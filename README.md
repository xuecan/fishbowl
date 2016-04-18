# Fishbowl

Fish shell 配置。


## 安装

首先，备份当前 `~/.config/fish` 目录中的 `config.fish` 文件和 `functions`
目录（如果存在的话）。随后，将这个目录中的 `fishbowl`、`functions` 目录以及
`config.fish`、`profile.fish` 文件在 `~/.config/fish` 中建立符号链接：

```
ln -s /path/to/this/folder/functions ~/.config/fish
ln -s /path/to/this/folder/fishbowl ~/.config/fish
ln -s /path/to/this/folder/profile.fish ~/.config/fish
ln -s /path/to/this/folder/config.fish ~/.config/fish
```

执行 `source ~/.config/fish/config.fish`，可以开始使用 fishbowl。
