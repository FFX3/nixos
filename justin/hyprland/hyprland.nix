{ config, pkgs, inputs, ... }:
{
    programs.waybar.enable = true;
    programs.foot.enable = true;
    programs.wofi.enable = true;

    home = {
        packages = with pkgs; [
            dolphin
        ];
    };

    services.dunst.enable = true;

    wayland.windowManager.hyprland = {
        enable = true;

        package = pkgs.hyprland;

        xwayland.enable = true;

        #systemd.enable = true;

        settings = {
            "$mainMod" = "SUPER";

            "$terminal" = "kitty";
            "$fileManager" = "dolphin";
            "$menu" = "wofi";

            bind = [
                "$mainMod, T, exec, foot"
                "$mainMod, Q, killactive"
                "$mainMod, M, exit"
                "$mainMod, E, exec, dolphin"
            ];

            input = {
                kb_layout = "us";

                follow_mouse = "1";

                touchpad = {
                    natural_scroll = "false";
                };

                sensitivity = "0";
            };

            general = {
                gaps_in = "5";
                gaps_out = "20";
                border_size = "2";
                "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
                "col.inactive_border" = "rgba(595959aa)";

                layout = "dwindle";
            };

            decoration = {
                rounding = "10";

                blur = {
                    enabled = "true";
                    size = "3";
                    passes = "1";
                    vibrancy = "0.1696";
                };

                drop_shadow = "true";
                shadow_range = "4";
                shadow_render_power = "3";
                "col.shadow" = "rgba(1a1a1aee)";
            };

        };
    };
}
