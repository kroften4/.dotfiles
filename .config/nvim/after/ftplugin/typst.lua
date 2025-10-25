vim.keymap.set('n', '<leader>p', "<cmd>TypstPreview<CR>", { buffer = true })
vim.keymap.set('n', '<leader>x', "<cmd>LspTinymistExportPdf<CR>", { buffer = true })

vim.opt_local.spell = true -- TODO: doesn't work for russian
vim.opt_local.formatoptions:append("t")
