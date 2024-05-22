---
title: 2. Add user to sudoers
weight: 2
---

1. `su --login`
2. `apt install sudo`
3. `adduser <YOUR_USER_NAME> sudo`
4. **Do a full logout and login again**  
(Execute `exit` command twice. first - you exit from su, second you exit from your user)

### Selfcheck
Run `sudo apt update` 

# Links
- https://wiki.debian.org/sudo
