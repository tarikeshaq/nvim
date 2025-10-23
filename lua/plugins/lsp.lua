-- LSP and language-specific plugins
return {
    {
        'neovim/nvim-lspconfig',
        lazy = false,
        version = "*",
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^6',
        lazy = false,
    },
    {
        "scalameta/nvim-metals",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        ft = { "scala", "sbt", "java" },
        opts = function()
            local metals_config = require("metals").bare_config()
            metals_config.init_options.statusBarProvider = "off"
            metals_config.on_attach = function(client, bufnr)
                require("metals").setup_dap()
            end

            return metals_config
        end,
        config = function(self, metals_config)
            local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = self.ft,
                callback = function()
                    require("metals").initialize_or_attach(metals_config)
                end,
                group = nvim_metals_group,
            })
        end
    },
}
