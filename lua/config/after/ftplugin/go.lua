-- Go-specific configuration
local bufnr = vim.api.nvim_get_current_buf()

-- Use tabs instead of spaces for Go (gofmt standard)
vim.opt_local.expandtab = false
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})

-- Organize imports on save
vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    callback = function()
        local params = vim.lsp.util.make_range_params()
        params.context = {only = {"source.organizeImports"}}
        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
        for _, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
                if r.edit then
                    vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
                end
            end
        end
    end,
})

-- Go-specific keybindings
vim.keymap.set("n", "<leader>gt", "<cmd>!go test ./...<CR>", { silent = true, buffer = bufnr, desc = "Run go test" })
vim.keymap.set("n", "<leader>gr", "<cmd>!go run %<CR>", { silent = true, buffer = bufnr, desc = "Run current go file" })
vim.keymap.set("n", "<leader>gb", "<cmd>!go build<CR>", { silent = true, buffer = bufnr, desc = "Build go project" })
