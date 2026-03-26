local harpoon = require("harpoon")
local telescope_builtin = require('telescope.builtin')

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

vim.keymap.set('n', 'rn', vim.lsp.buf.rename, {desc = 'LSP: Rename'})
vim.keymap.set('n', 'ca', vim.lsp.buf.code_action, { desc = 'LSP: Goto Code Action'})
vim.keymap.set('x', 'ca', vim.lsp.buf.code_action, { desc = 'LSP: Goto Code Action'})
vim.keymap.set('n', 'gr', telescope_builtin.lsp_references, { desc = 'LSP: Goto Reference'})
vim.keymap.set('n', 'gi', telescope_builtin.lsp_implementations, { desc = 'LSP: Goto Implementation'})
vim.keymap.set('n', 'gd', telescope_builtin.lsp_definitions, { desc = 'LSP: Goto Definition'})
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'LSP: Goto Declaration'})
vim.keymap.set('n', 'gO', telescope_builtin.lsp_document_symbols, { desc = 'LSP: Open Document Symbols'})
vim.keymap.set('n', 'gW', telescope_builtin.lsp_dynamic_workspace_symbols, { desc = 'LSP: Open Workspace Symbols'})
vim.keymap.set('n', 'gt', telescope_builtin.lsp_type_definitions, { desc = 'LSP: Goto Type Definition'})
