-- Treesitter for syntax highlighting
return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        branch = 'master',
        build = ':TSUpdate'
    },
}
