-- ROS2 support: interface-file filetypes, XML-family robot formats, and
-- telescope pickers for the live ROS graph (topics/nodes/services/interfaces).
--
-- The heavy lifting for code intelligence happens elsewhere:
--   * C++ (incl. custom messages): clangd + colcon's compile_commands.json
--   * Python (incl. custom messages): basedpyright + PYTHONPATH extraPaths
-- See lsp.lua and the ROS2 section of the README for the workflow.

-- Filetype detection ---------------------------------------------------------
vim.filetype.add({
	extension = {
		-- ROS2 interface definitions (highlighted by nvim-ros2's grammar)
		msg = "ros",
		srv = "ros",
		action = "ros",
		-- Robot description / simulation formats are XML dialects;
		-- *.launch.xml already matches xml via its extension.
		urdf = "xml",
		xacro = "xml",
		sdf = "xml",
		world = "xml",
		-- vcstool workspace manifests (e.g. ros2.repos)
		repos = "yaml",
	},
})

-- ROS2 style: 2-space indent for interface files and package XML
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("my_ros", { clear = true }),
	pattern = { "ros", "xml", "yaml" },
	callback = function(args)
		local bo = vim.bo[args.buf]
		bo.expandtab = true
		bo.tabstop = 2
		bo.shiftwidth = 2
		if vim.bo[args.buf].filetype == "ros" then
			bo.commentstring = "# %s"
		end
	end,
})

-- Plugins --------------------------------------------------------------------
return {
	{
		-- Syntax highlighting for .msg/.srv/.action + telescope pickers:
		--   :Telescope ros2 topics | nodes | services | actions | interfaces
		-- Pickers shell out to the ros2 CLI, so launch nvim from a sourced shell.
		"ErickKramer/nvim-ros2",
		ft = { "ros", "python", "cpp", "xml", "yaml" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			autocmds = true,
			telescope = true,
			treesitter = true,
		},
		keys = {
			{ "<leader>rt", "<cmd>Telescope ros2 topics<CR>", desc = "ROS2 topics" },
			{ "<leader>rn", "<cmd>Telescope ros2 nodes<CR>", desc = "ROS2 nodes" },
			{ "<leader>rs", "<cmd>Telescope ros2 services<CR>", desc = "ROS2 services" },
			{ "<leader>ri", "<cmd>Telescope ros2 interfaces<CR>", desc = "ROS2 interfaces" },
			{ "<leader>ra", "<cmd>Telescope ros2 actions<CR>", desc = "ROS2 actions" },
		},
	},
}
