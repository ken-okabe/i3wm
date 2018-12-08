# i3wm

/etc/X11/xorg.conf.d/00-keyboard.conf


```
Section "InputClass"
    Identifier "system-keyboard"
    Option "XkbOptions" "caps:ctrl_modifier"
EndSection
```

┌[ken@ken-pc]
└> s su
[ken-pc blogger]# echo 2 > /sys/module/hid_apple/parameters/fnmode
[ken-pc blogger]# exit




