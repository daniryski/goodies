## My Setup

* [Debian testing](https://www.debian.org/releases/testing/)
* [Xfce DE](https://www.xfce.org/)
* [i3-gaps-wm](https://github.com/Airblader/i3)
* [Kali Dark Theme](https://gitlab.com/kalilinux/packages/kali-themes)
* [feh](https://feh.finalrewind.org/)
* [lightdm-gtk-greeter](https://github.com/Xubuntu/lightdm-gtk-greeter)
* [zsh](https://www.zsh.org/)


### Setting up i3-gaps-wm

There isn't an official `i3-gaps-wm` package in Debian's repositories yet, but you can download the .deb package from [here](https://http.kali.org/kali/pool/main/i/i3-gaps/), and run `sudo apt install i3-gaps-wm*.deb` in the directory where it was downloaded.

Then, open Xfce's session configuration with `sudo vi /etc/xdg/xfce4/xfconf/xfce-perchannel-xml-xfce4-session.xml`.\
Replacing `<value type="string" value="xfwm4"/>` with `<value type="string" value="i3"/>` will setup *i3* as your window manager.\
Replacing `<value type="string" value="xfdesktop"/>` with `<value type="string" value="/home/$(whoami)/.fehbg"/>`, will set your background with *feh*, instead of starting *xfdesktop*.\
I kept *xfce4-panel*, since I prefer it to *i3bar*.

Run `i3-config-wizard`, to create an initial *.config/i3/config* file.\
Delete the *i3bar* section, remove the windows' borders and add some gaps (that's why we're using *i3-gaps-wm* anyway):

```sh
for_window [class=".*"] border pixel 0
gaps inner 20
```

***Note***: before doing the following steps, make sure that you've read at least the *Default keybindings* section of [i3 User's Guide](https://i3wm.org/docs/userguide.html)!\
Open **Menu->Settings->Session and Startup**, and add the command `/usr/bin/i3` in the **Application Autostart** tab.
In the **Current Session** tab change *xfwm4*'s, and *xfdesktop*'s *Restart Style* to *Never*.\
Quitting *xfwm4*, and *xfdesktop*, and restarting your session, will complete your initial *i3-gaps-wm* setup.
