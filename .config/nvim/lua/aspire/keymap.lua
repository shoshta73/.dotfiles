local harpoon = require("harpoon")

vim.keymap.set("n", "<leader>e", function()
  require("oil").toggle_float()
end, { desc = "Open explorer" })

vim.keymap.set("n", "<leader>ha", function()
  harpoon:list():add()
end, { desc = "Harpoon add" })

vim.keymap.set("n", "<leader>hm", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon menu" })

vim.keymap.set("n", "<leader>hn", function()
  -- TODO: Implement wrapping
  harpoon:list():next()
end, { desc = "Harpoon next" })

vim.keymap.set("n", "<leader>hp", function()
  -- TODO: Implement wrapping
  harpoon:list():prev()
end, { desc = "Harpoon previous" })

vim.keymap.set("i", "jj", "<esc>", { desc = "Exit insert mode (jj)" })
vim.keymap.set("i", "JJ", "<esc>", { desc = "Exit insert mode (JJ)" })
