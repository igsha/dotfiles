local defopts = { noremap=true, silent=true }

vim.keymap.set("n", "<Leader>q", ":cclose<CR>", defopts)
vim.keymap.set("n", "<Leader>n", ":cnext<CR>", defopts)
vim.keymap.set("n", "<Leader>p", ":cprev<CR>", defopts)
vim.keymap.set("n", "<Leader>o", ":copen<CR>", defopts)

vim.keymap.set("n", "<Leader>t", ":TagbarToggle<CR>", defopts)
vim.g.tagbar_left = false
vim.g.tagbar_autoclose = true

vim.g.airline_section_z = [[%3p%% (0x%2B) %#__accent_bold#%4l%#__restore__#:%3c]]

vim.g.hybrid_reduced_contrast = true;

vim.g.jellybeans_overrides = {
    background = {
        ['ctermbg'] = 'none',
        ['256ctermbg'] = 'none',
        ['guibg'] = 'none'
    }
}
vim.cmd.colorscheme('jellybeans')

vim.keymap.set("n", "<Leader>b", ":Telescope buffers<CR>", defopts)
vim.keymap.set("n", "<Leader>g", ":Telescope live_grep<CR>", defopts)
vim.keymap.set("n", "<Leader>f", ":Telescope find_files<CR>", defopts)
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
require('telescope').setup({
    defaults = {
        path_display = {
            "truncate"
        },
        mappings = {
            i = {
                ["<esc>"] = actions.close
            },
            n = {
                ["<M-p>"] = action_layout.toggle_preview
            },
            i = {
                ["<M-p>"] = action_layout.toggle_preview
            },
        },
    },
    pickers = {
        buffers = {
            mappings = {
                i = {
                    ["<c-d>"] = actions.delete_buffer + actions.move_to_top
                }
            },
            preview = {
                hide_on_startup = true
            }
        }
    }
})

require('nvim-treesitter.configs').setup {
    sync_install = false,
    auto_install = false,
    playground = { enable = true },
    highlight = {
        enable = true,
        disable = {"c", "lua", "query", "vim", "vimdoc"},
        additional_vim_regex_highlighting = false,
    },
}
