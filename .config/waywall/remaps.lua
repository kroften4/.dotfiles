return {
    remapped_kb = {
        ["F1"] = "F11",
        ["F11"] = "F1",

        -- f3+a
        ["A"] = "O",
        ["O"] = "A",

        -- switch to pickaxe at 2nd slot without messing with piechart
        ["2"] = "6",
        ["6"] = "2",

        -- tab as a hotbar slot
        ["TAB"] = "V",
        ["V"] = "TAB",

        -- pie without shifting
        ["CAPSLOCK"] = "RIGHTSHIFT",
        ["RIGHTSHIFT"] = "CAPSLOCK", -- this one does not work
    },

    normal_kb = {
        -- Add any remaps you want to keep when disabling normal remaps (not necessary)
    },

}
