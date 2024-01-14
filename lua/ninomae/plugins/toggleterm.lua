return {
    "akinsho/toggleterm.nvim",
    opts = {
        size = 20,
        shade_terminals = true,
        shading_factor = "20",
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        auto_scroll = true,
    },
    config=function ()
        local toogle_terminal = require("toggleterm.terminal")
        local lazygit = toogle_terminal.Terminal:new({
            cmd = "lazygit",
            hidden = true,
            direction = "float",
            float_opts = { border = "double" },
        })

        local keymap = vim.keymap

        keymap.set("n", "<leader>lg", function()
            lazygit:toggle()
        end, { noremap = true, silent = true, desc = "[L]azy[G]it" })

    end

}
