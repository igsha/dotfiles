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
local actions_layout = require("telescope.actions.layout")
local actions_state = require("telescope.actions.state")
local fb_utils = require("telescope.utils")
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
                ["<M-p>"] = actions_layout.toggle_preview
            },
            i = {
                ["<M-p>"] = actions_layout.toggle_preview
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
        },
        find_files = {
            mappings = {
                i = {
                    ["<C-up>"] = function(prompt_bufnr)
                        local current_picker = actions_state.get_current_picker(prompt_bufnr)
                        -- cwd is only set if passed as telescope option
                        local cwd = current_picker.cwd and tostring(current_picker.cwd) or vim.loop.cwd()
                        local parent_dir = vim.fs.dirname(cwd)
                        current_picker.finder.path = parent_dir

                        actions.close(prompt_bufnr)
                        require("telescope.builtin").find_files {
                            prompt_title = vim.fs.basename(parent_dir),
                            cwd = parent_dir,
                        }
                        --[[
                        fb_utils.redraw_border_title(current_picker)
                        current_picker:refresh(
                            finder,
                            {
                                new_prefix = fb_utils.relative_path_prefix(finder),
                                reset_prompt = true,
                                multi = current_picker._multi
                            }
                        )
                        ]]
                    end,
                },
            }
        }
    }
})

require('nvim-treesitter.config').setup {
    sync_install = false,
    auto_install = false,
    playground = { enable = true },
    highlight = {
        enable = true,
        disable = {"c", "lua", "query", "vim", "vimdoc"},
        additional_vim_regex_highlighting = false,
    },
}
