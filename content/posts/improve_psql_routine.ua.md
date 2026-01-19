---
title: "Покращення рутини розробки програмного забезпечення. Локальне налаштування бази даних."
date: 2023-11-17T11:11:08+03:00
tags: [psql, sqlant, adminer, plantuml, mermaid]
---

Майже всі розробники програмного забезпечення використовують бази даних у своїй повсякденній роботі.

Незручності можуть виникати, коли потрібно працювати з різними типами баз даних
або різними версіями. На щастя, існує загальний спосіб роботи з усіма популярними базами даних.

**Передумови**: Linux, Docker.

### 1. Запуск сервера бази даних та інструменту управління БД
За допомогою docker ви можете запустити будь-яку базу даних без проблем з установкою.

Візьмемо для прикладу базу даних *PostgreSQL*.
#### Запуск
```bash
✦❯ docker run --name some-postgres -e POSTGRES_PASSWORD=pswd -e POSTGRES_USER=user -e POSTGRES_DB=pdb -d --network=host postgres:15.3
70c2e363683fe9de108642e5f7140cd03d2ab0b117c8a3520c7a8ce6e7c10cca
```

Після цієї команди у вас має бути запущений сервер БД на вашому localhost
зі створеним користувачем: `user` та базою даних: `pdb` на порту `5432`.
Для перевірки можете використати `telnet`:

```bash
✦❯ telnet localhost 5432
Trying ::1...
Connected to localhost.
Escape character is '^]'.
```

### 2. Запуск інструменту управління БД (Frontend)
Тепер у нас є запущений *PostgreSQL* сервер і настав час використати frontend. Вам потрібно просто запустити ще один `docker` контейнер з [adminer](https://www.adminer.org/).
#### Запуск
```bash
✦❯ docker run -d --network=host adminer
c30e0215855e3926162749bde3a606a0ce20c4374abc688a665e604c78a64e66
```
Adminer успішно запущено. Перейдіть на [http://localhost:8080/](http://localhost:8080/)

![img](/images/adminer_login.png)

### 3. Аналіз та обмін структурою БД
Для легкого аналізу та обміну структурою вашої БД з колегами ви можете використовувати [sqlant](https://github.com/kurotych/sqlant)

![img](/images/sqlant.png)
