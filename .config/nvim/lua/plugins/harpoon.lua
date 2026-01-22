return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()
      harpoon:extend(require("harpoon.extensions").builtins.highlight_current_file())
    end
  }
}
