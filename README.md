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
Replacing `<value type="string" value="xfdesktop"/>` with `<value type="string" value="/home/$(whoami)/.fehbg"/>`, will set your background with *feh*, instead of starting *xfdesktop* (*replace `/home/$(whoami)` with the actual directory!*).\
See the [section about setting up feh](#setting-up-feh) below for more information.\
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


### Setting up Kali Dark Theme

Download the Kali themes with `git clone https://gitlab.com/kalilinux/packages/kali-themes`.

***Note***: keeping the repository will make it easier to manage the themes.

Next, make the themes, icons, and *xfce4-terminal*'s colorschemes accessible by Xfce, by adding symbolic links to them.

```
sudo ln -s kali-themes/share/themes/Kali-Dark /usr/share/themes/
sudo ln -s kali-themes/share/icons/Flat-Remix-Blue-Dark /usr/share/icons/
sudo ln -s kali-themes/share/xfce4/terminal/colorschemes/Kali.theme /usr/share/xfce4/terminal/colorschemes/
```

Install the fonts *Fira Code*, and *Cantarell* with `sudo apt install fonts-firacode fonts-cantarell`.

Open **Menu->Settings->Appearance**.\
In the **Style** tab select *Kali-Dark*, in the icons tab select *Flat-Remix-Blue-Dark*, and in the **Fonts** tab set the *Default Font* to *Cantarell Regular 11*, and the *Default Monospace Font* to *Fira Code Medium 10*.

Open **Xfce Terminal->Edit->Preferences**.\
In the **Appearance** tab set the *Font* to *Fira Code Regular 10*, and in the *Colors* tab select *Kali* from *Load Presets...*.

*Bonus*: enable *Firefox*'s dark theme from **Settings Menu->Preferences**, **Extensions & Themes** tab.


### Setting up feh

Install feh with `sudo apt install feh`.\
Running `feh --bg-scale wallpaper.png` will set your background to *wallpaper.png*, and will save the command to `~/.fehbg`


### Setting up lightdm-gtk-greeter

*lightdm-gtk-greeter* is already installed, and used as your default login screen.\
You can either customise it manually by editing `/etc/lightdm/lightdm-gtk-greeter.conf`,
or run `sudo apt install lightdm-gtk-greeter-settings`, and then `lightdm-gtk-greeter-settings`.

Set *Kali-Dark* as its theme, *Flat-Remix-Blue-Dark* as its icon theme, and *Cantarell 10* as its font, and you're good to go.


### Setting up a random background for the login screen, display, and terminal

Create a *display-setup-script.sh* in `/usr/local/bin`, `sudo vi /etc/lightdm/lightdm.conf`, and under the `[Seat:*]` section uncomment, and edit `display-setup-script` to `display-setup-script=dislpay-setup-script.sh`.\
To randomise the background selection, you can use my [cp-random-background](scripts/cp-random-background) script/tool, after placing it in `/usr/local/bin`.\
You can see [an example display-setup-script.sh](scripts/display-setup-script.sh), similar to the one I'm using.\
***Note***: be careful, when modifying those scripts, because they will be ran as root!

Edit `/etc/lightdm/lightdm-gtk-greeter.conf`, and `~/.fehbg` to set the random background from `display-setup-script.sh` for the login screen, and display.\
You can set your *Xfce Terminal*'s *Background* from the **Appearance** tab in **Edit->Preferences**.
