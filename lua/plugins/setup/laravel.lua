return function()
	local laravel = require("laravel")

	laravel.setup({
		features = {
			pickers = {
				provider = "telescope",
			},
		},
	})

	vim.keymap.set("n", "<leader>ll", function()
		Laravel.pickers.laravel()
	end, { desc = "Laravel: Open Laravel Picker" })

	vim.keymap.set("n", "<leader>la", function()
		Laravel.pickers.artisan()
	end, { desc = "Laravel: Open Artisan Picker" })

	vim.keymap.set("n", "<leader>lr", function()
		Laravel.pickers.routes()
	end, { desc = "Laravel: Open Routes Picker" })

	vim.keymap.set("n", "<leader>lm", function()
		Laravel.pickers.make()
	end, { desc = "Laravel: Open Make Picker" })

	vim.keymap.set("n", "<leader>lc", function()
		Laravel.pickers.commands()
	end, { desc = "Laravel: Open Commands Picker" })

	vim.keymap.set("n", "<leader>lo", function()
		Laravel.pickers.resources()
	end, { desc = "Laravel: Open Resources Picker" })

	vim.keymap.set("n", "<leader>lt", function()
		Laravel.commands.run("actions")
	end, { desc = "Laravel: Open Actions Picker" })

	vim.keymap.set("n", "<leader>lu", function()
		Laravel.commands.run("hub")
	end, { desc = "Laravel Artisan Hub" })

	vim.keymap.set("n", "<leader>lh", function()
		Laravel.run("artisan docs")
	end, { desc = "Laravel: Open Documentation" })

	vim.api.nvim_create_autocmd("BufEnter", {
		pattern = "composer.json",
		once = true,
		callback = function()
			vim.cmd("runtime! plugin/laravel.lua")
		end,
	})

	vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
		pattern = { "php", "blade" },
		callback = function(args)
			vim.keymap.set("n", "gf", function()
				local ok, res = pcall(function()
					if Laravel.app("gf").cursorOnResource() then
						return "<cmd>lua Laravel.commands.run('gf')<cr>"
					end
				end)
				if not ok or not res then
					return "gf"
				end
				return res
			end, { expr = true, noremap = true, buffer = args.buf })
		end,
	})
end
