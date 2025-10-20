return {
    { "folke/todo-comments.nvim", opts = {} },
    {
        "nvim-tree/nvim-web-devicons", opts = {}
    },
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        -- or if using mini.icons/mini.nvim
        -- dependencies = { "echasnovski/mini.icons" },
        opts = {}
    },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup {}
        end,
    },
    {
        'smoka7/hop.nvim',
        version = "*",
        opts = {
            keys = 'etovxqpdygfblzhckisuran'
        }
    },
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        branch = 'master',
        build = ':TSUpdate'
    },
    {
        'neovim/nvim-lspconfig',
        lazy = false,
        version = "*",
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^6', -- Recommended
        lazy = false,   -- This plugin is already lazy
    }, {
    'hrsh7th/cmp-nvim-lsp',
    lazy = false,
}, {
    'hrsh7th/nvim-cmp',
    lazy = false,
},
    { "catppuccin/nvim",          name = "catppuccin", priority = 1000 },
    {
        'm4xshen/autoclose.nvim',
        config = function()
            require('autoclose').setup {}
        end,
    },
    {
        'mfussenegger/nvim-dap',
        lazy = "false",
        version = "*"
    },
    {
        "nvim-lua/plenary.nvim",
        lazy = "false",
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
    {
        'lewis6991/gitsigns.nvim',
        lazy = false,
        opts = {}
    }
}
