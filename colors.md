# Change Colors

The default colors in centos darkblue on black hard to read sometimes.


## Bash

```
cp /etc/DIR_COLORS  ~/.dircolor
vi ~/.dircolors
```

change DIR 01;34 to DIR 01;35

Now directoris are magenta instead of dark blue.

## vim

```
cp /etc/.vimrc ~/.vimrc
vi ~/.vimrc
```

add line
```
colorscheme desert
```
