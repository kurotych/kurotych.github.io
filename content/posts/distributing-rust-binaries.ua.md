---
title: "Збірка та розгортання Rust бінарних файлів на різних дистрибутивах Linux"
date: 2024-02-11T13:09:33+02:00
tags: [rust, docker]
---

Екосистема Rust має численні платформи та велику документацію для підтримки функцій крос-компіляції.

Але чи працює це так, як очікується?

Що ж, якщо ваш бінарний файл має мало залежностей від спільних бібліотек,
то, швидше за все, так. Компіляція для `x86_64-unknown-linux-musl` значно збільшує ймовірність того, що ваш бінарний файл працюватиме на різних
дистрибутивах Linux.

**Однак** реальність у production може бути зовсім іншою.
Ми все ще стикаємося з dependency hell, і багато Rust крейтів залежать від спільних бібліотек, які можуть мати різні назви та шляхи.

Один з моїх проєктів має близько 120 залежностей від спільних бібліотек, і кодова база цього проєкту не велика (має близько 10k рядків з тестами).
(Незважаючи на мої зусилля мінімізувати кількість залежностей.)

Для перевірки залежностей я використовую утиліту Linux ldd:
```
ldd <path_to_binary>
	libssl.so.3 => /lib/x86_64-linux-gnu/libssl.so.3 (0x00007f912c971000)
	libcrypto.so.3 => /lib/x86_64-linux-gnu/libcrypto.so.3 (0x00007f9129800000)
    ...
	libkeyutils.so.1 => /lib/x86_64-linux-gnu/libkeyutils.so.1 (0x00007f9124096000)
	libresolv.so.2 => /lib/x86_64-linux-gnu/libresolv.so.2 (0x00007f91239f9000)
	libquadmath.so.0 => /lib/x86_64-linux-gnu/libquadmath.so.0 (0x00007f9121bb9000)
```

Отже, які шанси, що цей бінарний файл, зібраний на Debian 12, працюватиме, наприклад, з Ubuntu 22.04? (Це риторичне питання.)

### Проблема
Завдання полягає в тому, щоб зібрати бінарний файл, доставити його та запустити на Ubuntu 22.04 VPS (або будь-якому іншому дистрибутиві Linux на ваш вибір) лише з runtime залежностями.

### Рішення
[Зібрати бінарний файл у docker та експортувати його](https://docs.docker.com/build/guide/export/) на VPS.

Dockerfile, який збирає **hello_world** бінарний файл, може виглядати приблизно так:
```Dockerfile
FROM ubuntu:22.04 AS build-stage

ENV DEBIAN_FRONTEND=noninteractive

# Встановлення необхідних залежностей
RUN apt-get update && apt-get install -y --no-install-recommends \
    <package_name>... # Список залежностей для збірки бінарного файлу
    && rm -rf /var/lib/apt/lists/*

RUN curl https://sh.rustup.rs -sSf | bash -s -- -y

# Встановлення робочої директорії всередині контейнера
WORKDIR /usr/src/app/

COPY . .

RUN SQLX_OFFLINE=true ~/.cargo/bin/cargo build --release

FROM scratch AS export-stage
COPY --from=build-stage /usr/src/app/target/release/hello_world

CMD ["/bin/bash"]
```

Команда збірки `docker build -f <your_docker_file_name> --output=bin  .` доставить зібраний бінарний файл у директорію `bin`.

Потім ви можете використати утиліту `scp` для передачі цього бінарного файлу на ваш VPS.

Якщо бінарний файл потребує певних спільних бібліотек, вам потрібно буде встановити їх за допомогою вашого пакетного менеджера (у випадку ubuntu `apt` або `apt-get`)
