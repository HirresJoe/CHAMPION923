return {
	{
		"stevearc/conform.nvim",
		opts = function()
			local opts = {
				default_format_opts = {
					lsp_fallback = true, -- not recommended to change
					lsp_format = "fallback",
					undojoin = true,
				},
				formatters_by_ft = {
					lua = { "stylua" },
					fish = { "fish_indent" },
					sh = { "shfmt" },
					cpp = { "clang-format" },
					c = { "clang-format" },
					cs = { "editorconfig" },
				},
				formatters = {
					injected = { options = { ignore_errors = true } },
					shfmt = {
						prepend_args = { "-i", "2", "-ci" },
					},
				},
			}
			return opts
		end,
	},
}
