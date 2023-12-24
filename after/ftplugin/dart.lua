vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

require("flutter-tools").setup{}

vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
vim.keymap.set("n", "<leader>d", function() vim.diagnostic.open_float() end, opts)
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
