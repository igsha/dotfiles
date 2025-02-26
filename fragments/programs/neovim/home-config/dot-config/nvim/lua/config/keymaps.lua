local defopts = { noremap=true, silent=true }

vim.g.mapleader = "\\"

vim.keymap.set("n", "k", "<C-y>", defopts)
vim.keymap.set("n", "j", "<C-e>", defopts)
vim.keymap.set("n", "h", "zh", defopts)
vim.keymap.set("n", "l", "zl", defopts)
vim.keymap.set("n", "<Space>", ":noh<CR>", defopts)
