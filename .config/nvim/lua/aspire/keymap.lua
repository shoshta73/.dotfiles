local map = vim.keymap.set

local harpoon = require("harpoon")

map("n", "<leader>e", function()
  require("oil").toggle_float()
end, { desc = "Open explorer" })

map("n", "<leader>ha", function()
  harpoon:list():add()
end, { desc = "Harpoon add" })

map("n", "<leader>hm", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon menu" })

map("n", "<leader>hn", function()
  -- TODO: Implement wrapping
  harpoon:list():next()
end, { desc = "Harpoon next" })

map("n", "<leader>hp", function()
  -- TODO: Implement wrapping
  harpoon:list():prev()
end, { desc = "Harpoon previous" })
