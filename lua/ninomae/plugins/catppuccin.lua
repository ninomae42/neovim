return {
    'catppuccin/nvim',
    lazy = false,
    name = 'catppuccin',
    priority = 1000,
    config = function()
        require('catppuccin').setup({
            transparent_background=false,
            term_colors=true,
            color_overrides = {
                mocha={
                    base = "#000000",
                    mantle = "#000000",
                    crust = "#000000",
                },
            },
        })
        vim.cmd([[colorscheme catppuccin]])
    end,
}
