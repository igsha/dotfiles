local autocmd = vim.api.nvim_create_autocmd
local mygroup = vim.api.nvim_create_augroup('user_cmds', { clear = true })

autocmd("FileType", {
    group = mygroup,
    pattern = { "asm" },
    command = "setlocal formatoptions+=rol"
})

autocmd({ 'BufRead', 'BufNewFile' }, {
    group = mygroup,
    pattern = { "inc" },
    command = "set filetype=asm"
})

vim.filetype.add({
  extension = {
    ets = 'typescript'
  }
})
