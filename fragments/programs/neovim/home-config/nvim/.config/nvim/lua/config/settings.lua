local defopts = { noremap=true, silent=true }

vim.keymap.set("n", "<Leader>q", ":cclose<CR>", defopts)
vim.keymap.set("n", "<Leader>n", ":cnext<CR>", defopts)
vim.keymap.set("n", "<Leader>p", ":cprev<CR>", defopts)
vim.keymap.set("n", "<Leader>o", ":copen<CR>", defopts)
vim.keymap.set("n", "<Leader>g", ":Ack<CR>", defopts)
vim.api.nvim_create_user_command("AckWord", ":Ack <cword> <args>", { nargs = '*' })

vim.keymap.set("n", "<Leader>t", ":TagbarToggle<CR>", defopts)
vim.g.tagbar_left = false
vim.g.tagbar_autoclose = true

vim.g.airline_section_z = [[%3p%% (0x%2B) %#__accent_bold#%4l%#__restore__#:%3c]]

vim.g.hybrid_reduced_contrast = true;

vim.keymap.set("n", "<Leader>b", ":BuffergatorToggle<CR>", defopts)
vim.g.buffergator_suppress_keymaps = true
vim.g.buffergator_viewport_split_policy = 'T'

vim.cmd.colorscheme('jellybeans')
vim.g.jellybeans_overrides = {
    background = {
        ['ctermbg'] = 'none',
        ['256ctermbg'] = 'none',
        ['guibg'] = 'none'
    }
}
vim.o.background = "dark"
