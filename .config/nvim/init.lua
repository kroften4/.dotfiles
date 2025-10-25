-- TODO:
-- show lsp status on status bar
-- blink remove highlight after moved from snippet
-- ipynb support
-- what is https://github.com/nvim-treesitter/nvim-treesitter-textobjects
-- own lsp snippets (add header guards)
-- jump between header and source file
-- undo tree

-- OPTIONS --
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.cursorcolumn = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.inccommand = "split" -- preview substitutions
vim.opt.colorcolumn = "81"
vim.opt.textwidth = 80
vim.opt.linebreak = true
vim.opt.confirm = true
vim.opt.scrolloff = 10
vim.opt.timeout = false

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
vim.keymap.set("n", "<leader>u", "<cmd>update<CR> <cmd>source<CR>")
vim.keymap.set("n", "<leader>w", "<cmd>write<CR>")
vim.keymap.set("n", "<leader>a", "<cmd>wa<CR>")
vim.keymap.set("n", "<leader>q", "<cmd>quit<CR>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<C-q>", "<cmd>bdelete<CR>")
-- copy to system clipboard
vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v", "x" }, "<leader>Y", '"+y$') -- "+Y does not work
-- vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d')

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- PLUGINS --
vim.pack.add({
	-- themes
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/folke/tokyonight.nvim" },
	{ src = "https://github.com/rose-pine/neovim" },

	{ src = "https://github.com/stevearc/oil.nvim" }, -- edit files with neovim

	{ src = "https://github.com/nvim-lua/plenary.nvim" }, -- dependency
	{ src = "https://github.com/nvim-telescope/telescope.nvim" }, -- fuzzy find
	{ src = "https://github.com/aznhe21/actions-preview.nvim" }, -- preview code actions in telescope

	-- previews
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = "https://github.com/iamcco/markdown-preview.nvim" }, -- had to cd into plugin directory and run `npm install`

	{ src = "https://github.com/nvim-mini/mini.surround" },

	{ src = "https://github.com/folke/which-key.nvim" }, -- show pending keybinds

	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/mason-org/mason.nvim" }, -- auto install lsp
	{ src = "https://github.com/neovim/nvim-lspconfig" , version = vim.version.range("2.4.*") }, -- auto config lsp
	{ src = "https://github.com/j-hui/fidget.nvim" }, -- lsp status
	{ src = "https://github.com/stevearc/conform.nvim" }, -- format
	{ src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("1.*") }, -- autocompletion
})

require("mason").setup()
require("fidget").setup()
require("telescope").setup()
require("oil").setup({
	view_options = {
		show_hidden = true,
	},
})
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		typst = { "prettypst" },
	},
})
require("blink.cmp").setup({
	keymap = {
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "cancel", "fallback" },
		["<C-y>"] = { "select_and_accept", "fallback" },

		["<C-p>"] = { "select_prev", "fallback_to_mappings" },
		["<C-n>"] = { "select_next", "fallback_to_mappings" },

		["<C-u>"] = { "scroll_documentation_up", "fallback" },
		["<C-d>"] = { "scroll_documentation_down", "fallback" },

		["<C-j>"] = { "snippet_forward" },
		["<C-k>"] = { "snippet_backward" },
	},
	sources = { default = { "lsp", "path" } },
	completion = { menu = { max_height = 25 } },
})
---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
	auto_install = true,
	highlight = { enable = true },
})
require("mini.surround").setup({
	highlight_duration = 2000,
	mappings = {
		add = "<C-s>a", -- Add surrounding in Normal and Visual modes
		delete = "<C-s>d", -- Delete surrounding
		replace = "<C-s>r", -- Replace surrounding
		find = "",
		find_left = "",
		highlight = "",
		suffix_last = "",
		suffix_next = "",
	},
})
require("which-key").setup()

vim.lsp.enable({
	"lua_ls",
	"clangd",
	"pyright",
	"asm_lsp",
	"jdtls",
	"tinymist",
	"hyprls",
	"arduino_language_server",
	"ts_ls",
    "rust_analyzer",
    "docker_language_server"
})

-- Limit width of LSP hover float
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or "single"
	opts.max_width = opts.max_width or 100
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- PLUGIN KEYMAPS --
-- vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)
-- conform
vim.keymap.set({ "n", "v" }, "<leader>f", function()
	-- use configured formatter or fallback to lsp format
	require("conform").format({ async = true, lsp_format = "fallback" })
end)
-- oil
vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>")
vim.keymap.set("n", "<leader>E", ":Oil ")
-- lsp
local ts = require("telescope.builtin")
vim.keymap.set("n", "grn", vim.lsp.buf.rename, { desc = "Lsp [R]e[n]ame" })
-- vim.keymap.set("n", "gra", vim.lsp.buf.code_action, { desc = "Lsp go to code [a]ctions" })
vim.keymap.set("n", "gra", require("actions-preview").code_actions, { desc = "[G]oto code [A]ctions" })
vim.keymap.set("n", "grr", ts.lsp_references, { desc = "Lsp go to [r]eferences" })
vim.keymap.set("n", "gri", ts.lsp_implementations, { desc = "Lsp go to [i]mplementations" })
vim.keymap.set("n", "grd", ts.lsp_definitions, { desc = "Lsp go to [d]efinitions" })
vim.keymap.set("n", "grD", vim.lsp.buf.declaration, { desc = "Lsp go to [d]eclaration" })
vim.keymap.set("n", "gO", ts.lsp_document_symbols, { desc = "Lsp search document symbols" })
vim.keymap.set("n", "gW", ts.lsp_dynamic_workspace_symbols, { desc = "Lsp go to [w]orkspace symbols" })
vim.keymap.set("n", "grt", ts.lsp_type_definitions, { desc = "Lsp go to [t]ype definitions" })

vim.keymap.set("n", "<leader>r", ts.diagnostics, { desc = "[R]epair - Search Diagnostics" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open [D]iagnostic message float" })
-- fuzzy find
vim.keymap.set("n", "<leader>sh", ts.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", ts.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sf", ts.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sw", ts.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", ts.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sr", ts.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>s.", ts.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader><leader>", ts.buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>sn", function()
	ts.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })

vim.cmd.colorscheme("vague")
