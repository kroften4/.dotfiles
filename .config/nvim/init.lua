-- TODO:
-- lsp snippets
-- autocompletions
-- better formatters?

-- OPTIONS --
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.cursorcolumn = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.inccommand = 'split' -- preview substitutions
vim.opt.colorcolumn = '80'
vim.opt.linebreak = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.signcolumn = "yes"
vim.g.mapleader = " "
vim.opt.winborder = "rounded"
vim.opt.termguicolors = true

-- KEYMAPS --
vim.keymap.set('n', '<leader>u', '<cmd>update<CR> <cmd>source<CR>')
vim.keymap.set('n', '<leader>w', '<cmd>write<CR>')
vim.keymap.set('n', '<leader>a', '<cmd>wa<CR>')
vim.keymap.set('n', '<leader>q', '<cmd>quit<CR>')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- copy to system clipboard
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d')

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- PLUGINS --
vim.pack.add({
    -- themes
    { src = "https://github.com/vague2k/vague.nvim" },
    { src = "https://github.com/folke/tokyonight.nvim" },

    { src = "https://github.com/stevearc/oil.nvim" },          -- edit files with neovim

    { src = "https://github.com/nvim-lua/plenary.nvim" },      -- dependency
    { src = "https://github.com/nvim-telescope/telescope.nvim" }, -- fuzzy find

    -- previews
    { src = "https://github.com/chomosuke/typst-preview.nvim" },
    { src = "https://github.com/iamcco/markdown-preview.nvim" }, -- had to cd into plugin directory and run `npm install`

    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/mason-org/mason.nvim" }, -- auto install lsp
    { src = "https://github.com/neovim/nvim-lspconfig" }, -- auto config lsp
    { src = "https://github.com/j-hui/fidget.nvim" },  -- lsp status
})

require "mason".setup()
require "fidget".setup {}
require "telescope".setup()
require "oil".setup()

-- i don't really know what i need this for
---@diagnostic disable-next-line: missing-fields
require "nvim-treesitter.configs".setup({
    auto_install = true,
    highlight = { enable = true }
})

vim.lsp.enable({ "lua_ls", "clangd", "pyright", "asm_lsp", "jdtls", "tinymist", "hyprls", })
-- get support for `vim` object
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            }
        }
    }
})

-- Limit width of LSP hover float
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or 'single'
    opts.max_width = opts.max_width or 100
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- PLUGIN KEYMAPS --
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)
-- oil
vim.keymap.set('n', '<leader>e', "<cmd>Oil<CR>")
-- lsp
local telescope_builtin = require "telescope.builtin"
vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { desc = 'Lsp [R]e[n]ame' })
vim.keymap.set('n', 'gra', vim.lsp.buf.code_action, { desc = 'Lsp go to code [a]ctions' })
vim.keymap.set('n', 'grr', telescope_builtin.lsp_references, { desc = 'Lsp go to [r]eferences' })
vim.keymap.set('n', 'gri', telescope_builtin.lsp_implementations, { desc = 'Lsp go to [i]mplementations' })
vim.keymap.set('n', 'grd', telescope_builtin.lsp_definitions, { desc = 'Lsp go to [d]efinitions' })
vim.keymap.set('n', 'grD', vim.lsp.buf.declaration, { desc = 'Lsp go to [d]eclaration' })
vim.keymap.set('n', 'gO', telescope_builtin.lsp_document_symbols, { desc = 'Lsp search document symbols' })
vim.keymap.set('n', 'gW', telescope_builtin.lsp_dynamic_workspace_symbols, { desc = 'Lsp go to [w]orkspace symbols' })
vim.keymap.set('n', 'grt', telescope_builtin.lsp_type_definitions, { desc = 'Lsp go to [t]ype definitions' })
-- fuzzy find
vim.keymap.set('n', '<leader>sh', telescope_builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', telescope_builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', telescope_builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sw', telescope_builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', telescope_builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', telescope_builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', telescope_builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', telescope_builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader><leader>', telescope_builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>sn', function()
    telescope_builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })

vim.cmd.colorscheme "vague"
