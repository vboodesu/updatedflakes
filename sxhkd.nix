
let
  # user scripts
  s = "/bin";
in
{
  services.sxhkd = {
    enable = true;
    keybindings = {
      # general
    # start terminal
    "super + Return" = "alacritty";
    # rofi
    "super + p" = "rofi -modi drun,run -show drun";
    # launch librewolf
      "super + shift + b" = "librewolf";
        # reload sxhkd
      "super + Escape" = "pkill -USR1 -x sxhkd"; 
      # quit bspwm normally
      "super + alt + Escape" = "bspc quit";
       # kill program
      "super + {_,shift + }q" = "bspc node -{c,k}";
      # reload bspwm 
      "super + shift +r" = "bash ~/.config/bspwm/bspwmrc";
      # play/pause
      "{Pause,XF86AudioPlay}" = "playerctl play-pause";
      # next/prev song
      "super + shift + {Right,Left}" = "playerctl {next,previous}";
      # toggle repeat/shuffle
      "super + alt + {r,z}" = "playerctl {loop,shuffle}";
        # set the window state
      "super + {t,shift + t,s,f}" = "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";
         # focus the node in the given direction
      "super + {_,shift + }{h,j,k,l}" = "bspc node -{f,s} {west,south,north,east}"; 
    # increase/decrease borders
      "super + {_,ctrl + } {equal,minus}" = "${s}/dynamic_bspwm {b,g} {+,-}";  
   # focus or send to the given desktop
      "super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'"; 
    
  };
};
}
