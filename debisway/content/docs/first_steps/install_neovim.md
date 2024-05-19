---
title: Install neovim
description: Downloading and installing Neovim on your PC, excluding the configuration part, **which greatly enhances its usability**.
weight: 4
sidebar_position: 20
---

{{< card code=true header="Check the latest stable neovim release (optional)" lang="bash">}}
curl -sSL {{< param "debisway_scripts_url" >}}/get_latest_neovim_stable_version.sh | sh
{{< /card >}}
<details>
      <summary>Script source code</summary>
{{< readfile file="../../static/scripts/get_latest_neovim_stable_version.sh" code="true" lang="bash" >}}
</details>

---

<!-- TODO reuse documentation https://www.docsy.dev/docs/adding-content/shortcodes/#reuse-documentation -->
<!-- TODO make script to install/update? -->

1. Make a temporary directory. `mkdir temp && cd temp`
2. Download Neovim (replace v0.10.0 with the desired version): `curl -LO https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-linux64.tar.gz`
3. Unpack the archive and navigate to the extracted directory: 
```bash 
tar -xzf nvim-linux64.tar.gz
cd nvim-linux64
```
4. Move the extracted files to /usr/local: `sudo cp -r ./* /usr/local/`  
The `nvim` command must be available on this step. BTW command to exit neovim: `:q!` ;) 
5. Create a symbolic link to run Neovim using the command v: `sudo ln -s /usr/local/bin/nvim /usr/local/bin/v`
6. Remove temporaty dir `cd ../.. && rm -rf temp`

# Links 
- https://github.com/neovim/neovim
