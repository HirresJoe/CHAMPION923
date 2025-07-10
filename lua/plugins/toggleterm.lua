return {
	{
		"akinsho/toggleterm.nvim",
		-- Keys for the plugin
		keys = {
			-- First-level menu key for "RunCode"
			{
				"<leader>t",
				desc = "RunCode", -- Description for the keybinding
			},
			-- Keybinding to run code in a float terminal
			{
				"<leader>tr",
				function()
					-- Call the global function to run code
					_G.run_code()
				end,
				desc = "Run code in float terminal", -- Description for the keybinding
			},
		},
		-- Plugin configuration
		config = function()
			-- Setup toggleterm with desired options
			require("toggleterm").setup({
				direction = "float", -- Set terminal direction to float
				size = 20, -- Default size (though overridden by float_opts height)
				close_on_exit = false, -- Keep terminal open after command exits
				shell = vim.o.shell, -- Use the default shell

				-- Floating terminal specific options
				float_opts = {
					border = "rounded", -- Rounded border for the float window
					highlights = {
						background = "Normal", -- Background highlight group
						border = "Normal", -- Border highlight group
					},
					-- Dynamic width calculation
					width = function()
						return math.min(math.floor(vim.o.columns * 0.4), 80)
					end,
					-- Dynamic height calculation
					height = function()
						return math.floor(vim.o.lines * 0.3)
					end,
					-- Dynamic row position calculation
					row = function()
						local height = math.floor(vim.o.lines * 0.3)
						return vim.o.lines - height - 3
					end,
					-- Dynamic column position calculation
					col = function()
						local width = math.min(
							math.floor(vim.o.columns * 0.4),
							80
						)
						return vim.o.columns - width - 1
					end,
				},
			})

			-- Table defining run commands for different file types
			local run_command_table = {
				["cpp"] = "g++ %:t -o %:r && %:r && rm -f %:r",
				["cxx"] = "g++ %:t -o %:r && %:r && rm -f %:r",
				["c"] = "gcc %:t -o %:r && %:r && rm -f %:r",
				["python"] = "python %:t",
				["lua"] = "lua %:t",
				["java"] = "javac %:t && java -cp %:h %:r && rm -f %:r.class",
				["rust"] = "rustc %:t && %:r && rm -f %:r",
				["go"] = "go run %:t",
			}

			-- Global function to run code based on filetype
			function _G.run_code()
				local ft = vim.bo.filetype
				if not run_command_table[ft] then
					vim.notify(
						"No run command defined for filetype: " .. ft,
						vim.log.levels.WARN
					)
					return
				end

				local filename = vim.fn.expand("%:t")
				local file_base = vim.fn.expand("%:r")
				local file_dir = vim.fn.expand("%:p:h")
				local cmd = run_command_table[ft]

				-- 替换文件名
				cmd = cmd:gsub("%%:t", filename)

				-- 如果 file_base 已经是完整路径，则不添加 ./
				if string.sub(file_base, 1, 1) == "/" then
					cmd = cmd:gsub("%%:r", file_base)
				else
					cmd = cmd:gsub("%%:r", "./" .. file_base)
				end

				cmd = cmd:gsub("%%:h", file_dir)

				local Terminal = require("toggleterm.terminal").Terminal
				local terminal = Terminal:new({
					cmd = cmd,
					-- dir = file_dir,
					hidden = true,
					direction = "float",
				})

				terminal:toggle()
			end
		end,
	},
}
