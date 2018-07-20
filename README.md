# Fishbowl


```
~                                            _J""-._,                 .
~              _.-""L_                     /o )_  \' ,';              .
~           ;`,\/   ( o\                   \ ,'=`   ;  /              .
~           \  ;  /=`, /                     "-.__.'"\_;              .
~           ;_/"`.__.-"                                               .
```

自用的一套 [Fish](https://fishshell.com/) shell 配置。


## 安装 fish

在 macOS 中，使用 [Homebrew](https://brew.sh/) 安装 fish：

```bash
brew install fish
```

随后，将 `/usr/local/bin/fish` 添加到 `/etc/shells` 文件中。

执行 `chsh -s /usr/local/bin/fish` 设置默认的 shell 为 fish。


## 安装和使用 fishbowl

建议在 github 上 fork 这个仓库。

首先，备份当前 `~/.config/fish` 目录中的 `config.fish` 文件。随后，将这个目录中的
`fishbowl`  目录以及 `config.fish`、`profile.fish` 文件在
`~/.config/fish` 中建立符号链接：

```bash
ln -s /path/to/this/folder/fishbowl ~/.config/fish
ln -s /path/to/this/folder/profile.fish ~/.config/fish
ln -s /path/to/this/folder/config.fish ~/.config/fish
```

根据实际需要修改 `~/.config/fish/profile.fish`。

执行 `source ~/.config/fish/config.fish`，可以开始使用 fishbowl。
