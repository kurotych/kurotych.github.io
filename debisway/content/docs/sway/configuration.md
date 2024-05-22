---
title: Configuration
weight: 2
---

## Running sway after "login screen"

Add to `~/.bashrc`
```bash
if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
	  exec sway
fi
```
