vim.keymap.set('n', '<leader>p', "<cmd>TypstPreview<CR>", { buffer = true })
vim.keymap.set('n', '<leader>x', "<cmd>LspTinymistExportPdf<CR>", { buffer = true })

-- https://tesar.tech/blog/2025-11-29_neovim_for_writing_spellcheck
vim.opt_local.spell = true
vim.opt_local.spelllang = "en,ru"
vim.opt_local.formatoptions:append("t")
