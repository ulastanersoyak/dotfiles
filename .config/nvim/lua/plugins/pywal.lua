return {
	"AlphaTechnolog/pywal.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		local ok, pywal = pcall(require, "pywal")
		if not ok then
			return
		end
		pywal.setup({ transparent = true })

		-- clear any leftover opaque backgrounds, and re-clear on palette reloads
		local function clear_bg()
			for _, g in ipairs({
				"Normal",
				"NormalNC",
				"NormalFloat",
				"SignColumn",
				"EndOfBuffer",
				"LineNr",
				"Folded",
				"StatusLine",
				"StatusLineNC",
			}) do
				vim.api.nvim_set_hl(0, g, { bg = "none" })
			end
		end
		clear_bg()
		vim.api.nvim_create_autocmd("ColorScheme", { callback = clear_bg })
	end,
}
