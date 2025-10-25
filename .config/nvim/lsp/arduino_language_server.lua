---@type vim.lsp.Config
-- return {
--   cmd = {
--     "arduino-language-server",
--     '-cli-config',
--     vim.fn.expand('~/.arduino15/arduino-cli.yaml'),
--     "-cli",
--     "/usr/bin/arduino-cli",
--     "-clangd",
--     "/home/krft/.local/share/nvim/mason/bin/clangd",
--   },
-- }
return {
	capabilities = {
		textDocument = {
			semanticTokens = vim.NIL,
		},
		workspace = {
			semanticTokens = vim.NIL,
		},
	},

	cmd = {
		"arduino-language-server",
		"-cli-config",
		vim.fn.expand("~/.arduino15/arduino-cli.yaml"),
		"-cli",
		"arduino-cli",
		"-clangd",
		"clangd",
	},

	filetypes = { "arduino" },

	root_dir = function(bufnr, on_dir)
		on_dir(vim.fn.expand("%:p:h"))
	end,
}
