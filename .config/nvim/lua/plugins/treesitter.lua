return {
	{
		"nvim-treesitter/nvim-treesitter",
    branch = "main",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		event = { "BufEnter" },
    opts = {
      ensure_installed = {
        "lua",
        "vim",
        "bash",
        "c",
        "cpp"
      },
      sync_install = false,
      highlight = {
        enable = true,
      },
    },
  },
  {
		"nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
  {
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      enable = true,
    }
	},
}
