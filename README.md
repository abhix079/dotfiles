# Dotfiles

Dotfiles contains all the configs related to arch i.e hyprland or i3. \
Before cloning these configs make sure that you are familiar or have basic knowledge of how things work to avoid unwanted issues. 

#### Hyprshot Configuration
You can add the various modes as keybindings in your Hyprland config like so:\
``` bash
# ~/.config/hypr/hyprland.conf
....
#Screenshot a Region
bind = $mainMod, PRINT,exex ,hyprshot -m region -o ~/Pictures/
#Screenshot a WINDOW
bind = ,PRINT,exec ,hyprshot -m output -o ~/Pictures/
```
Note: Make sure that you have installed the hyprshot before using this configuration
#### Install hyprshot
``` bash
yay -S hyprshot
```




