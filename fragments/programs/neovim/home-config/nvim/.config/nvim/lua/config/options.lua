vim.opt.encoding = 'utf-8'
vim.opt.number = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.cindent = true
vim.opt.smarttab = true
vim.opt.ruler = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.modeline = true
vim.opt.foldenable = false
vim.opt.list = true
vim.opt.listchars = { tab = '»»', trail = '·', nbsp = 'º' }
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrapscan = false
vim.opt.mouse = 'a'
vim.opt.hidden = true
vim.opt.autochdir = true
vim.opt.textwidth = 200
vim.opt.wildmode = { "longest", "list", "full" }
vim.opt.wildmenu = true
vim.opt.fileencodings = { "utf8", "cp1251", "koi8-r", "cp866" }
vim.opt.fileformats:append("dos")
vim.opt.spelllang = { "ru_yo", "en" }
vim.opt.directory = vim.fn.stdpath("run")
vim.opt.backupdir = vim.fn.stdpath("run")

vim.cmd.syntax('on')

local function escape(str)
  local escape_chars = [[;,."|\]]
  return vim.fn.escape(str, escape_chars)
end

local EN = escape([[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]])
local RU = escape([[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]])
local en = escape([[`qwertyuiop[]asdfghjkl;'zxcvbnm]])
local ru = escape([[ёйцукенгшщзхъфывапролджэячсмить]])

vim.opt.langmap = vim.fn.join({ RU .. ';' .. EN, ru .. ';' .. en }, ',')
