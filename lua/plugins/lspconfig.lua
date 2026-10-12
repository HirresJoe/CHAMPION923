return {
        {
                "neovim/nvim-lspconfig",
                opts = {
                        servers = {
                                pyright = {
                                        settings = {
                                                python = {
                                                        analysis = {
                                                                extraPaths = { "src" },
                                                                autoSearchPaths = true,
                                                                useLibraryCodeForTypes = true,
                                                                diagnosticMode = "workspace",
                                                        },
                                                },
                                        },
                                },

                                ts_ls = {},
                        },
                },
        },

        {
                "pmizio/typescript-tools.nvim",
                dependencies = {
                        "nvim-lua/plenary.nvim",
                        "neovim/nvim-lspconfig",
                },
                opts = {
                        on_attach = function(_, bufnr)
                                vim.keymap.set(
                                        "n",
                                        "<leader>co",
                                        "<cmd>TSToolsOrganizeImports<CR>",
                                        { buffer = bufnr, desc = "Organize Imports" }
                                )

                                vim.keymap.set(
                                        "n",
                                        "<leader>cR",
                                        "<cmd>TSToolsRenameFile<CR>",
                                        { buffer = bufnr, desc = "Rename File" }
                                )
                        end,
                },
        },
}
