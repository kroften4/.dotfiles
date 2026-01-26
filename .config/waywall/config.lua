-- ==== WAYWALL GENERIC CONFIG ====
return {
    -- ==== LOOKS ====
    bg_col = "#000000",
    toggle_bg_picture = true,
    text_col = "#FFFFFF",
    pie_chart_1 = "#EC6E4E",
    pie_chart_2 = "#46CE66",
    pie_chart_3 = "#E446C4",

    ninbot_anchor = "topright", -- topleft, top, topright, left, right, bottomleft, bottomright
    ninbot_opacity = 0.9,         -- 0 to 1


    -- ==== MIRRORS ====
    e_count = { enabled = true, x = 1340, y = 300, size = 5, colorkey = true },
    thin_pie = { enabled = true, x = 1200, y = 400, size = 4, colorkey = true }, -- Turning off colorkeying also maintains the original pie chart's dimensions and shows the percentages
    thin_percent = { enabled = true, x = 1300, y = 850, size = 6 },
    tall_pie = { enabled = true, x = 1200, y = 400, size = 4, colorkey = true }, -- Leave same as thin for seamlessness
    tall_percent = { enabled = true, x = 1300, y = 850, size = 6 },              -- Leave same as thin for seamlessness

    eye_measure = { enabled = true, x = 30, y = 10, size = 10 },                 -- w = 700, h = 400 },

    stretched_measure = false,


    -- ==== KEYBINDS ====
    -- resolution change actions
    thin = { key = "*-F2", f3_safe = false },
    wide = { key = "*-X", f3_safe = false },
    tall = { key = "*-Alt_L", f3_safe = false },

    -- startup actions
    -- toggle_fullscreen_key = "Shift-O",
    -- launch_paceman_key = "Shift-P",

    -- during game actions
    toggle_ninbot_key = "KP_Home",
    toggle_remaps_key = "KP_Insert",



    -- ==== MISC ====
    remaps_config = { layout_name = "mc", enabled = false }, -- ~/.config/xkb/symbols/mc
    remaps_text_config = { text = "remaps off", x = 100, y = 100, size = 2, color = "#000000" },

    res_1440 = false,
    sens_change = { enabled = true, normal = 8.722842008245408, tall = 0.3 }, -- raw input off, dpi 700
    enable_resize_animations = false,
}
