bufferline = require("load").req("bufferline")

bufferline.setup {
    options = {
        numbers = function(opts)
            return string.format('%s', opts.lower(opts.ordinal))
        end,
        close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
        right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
        left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
        middle_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
        -- NOTE: this plugin is designed with this icon in mind,
        -- and so changing this is NOT recommended, this is intended
        -- buffer_close_icon = '',
        indicator = {
            icon = "▎",
        },
        buffer_close_icon = "",
        modified_icon = "●",
        close_icon = "",
        -- close_icon = '',
        left_trunc_marker = "",
        right_trunc_marker = "",
        --- name_formatter can be used to change the buffer's label in the bufferline.
        --- Please note some names can/will break the
        --- bufferline so use this at your discretion knowing that it has
        --- some limitations that will *NOT* be fixed.
        -- name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
        --   -- remove extension from markdown files for example
        --   if buf.name:match('%.md') then
        --     return vim.fn.fnamemodify(buf.name, ':t:r')
        --   end
        -- end,
        max_name_length = 30,
        max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
        tab_size = 15,
        diagnostics = false, -- | "nvim_lsp" | "coc",
        diagnostics_update_in_insert = false,
        -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
        --   return "("..count..")"
        -- end,
        -- NOTE: this will be called a lot so don't do any heavy processing here
        -- custom_filter = function(buf_number)
        --   -- filter out filetypes you don't want to see
        --   if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
        --     return true
        --   end
        --   -- filter out by buffer name
        --   if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
        --     return true
        --   end
        --   -- filter out based on arbitrary rules
        --   -- e.g. filter out vim wiki buffer from tabline in your work repo
        --   if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
        --     return true
        --   end
        -- end,
        offsets = {
            {
                filetype = "NvimTree",
                text = "Explorer",
                highlight = "Directory",
                text_align = "center",
                separator = true -- use a "true" to enable the default, or set your own character
            },
        },
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        -- can also be a table containing 2 custom separators
        -- [focused and unfocused]. eg: { '|', '|' }
        separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
        enforce_regular_tabs = true,
        always_show_bufferline = false,
        -- sort_by = 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
        --   -- add custom logic
        --   return buffer_a.modified > buffer_b.modified
        -- end
        --[[ sort_by = function(buffer_a, buffer_b) ]]
        --[[     print(vim.inspect(buffer_a)) ]]
        --[[     -- add custom logic ]]
        --[[     return buffer_a.modified > buffer_b.modified ]]
        --[[ end ]]
    },
    highlights = {
        fill = {
            fg = { attribute = "fg", highlight = "#ff0000" },
            bg = { attribute = "bg", highlight = "Normal" },
            italic = true,
        },
        background = {
            fg = { attribute = "fg", highlight = "TabLine" },
            bg = { attribute = "bg", highlight = "Normal" },
            italic = true,
        },

         buffer_selected = {
           fg = {attribute='fg',highlight='#ff0000'},
           bg = {attribute='bg',highlight='#0000ff'},
            italic = true,
           },
        
        buffer_visible = {
            fg = { attribute = "fg", highlight = "TabLine" },
            bg = { attribute = "bg", highlight = "Normal" },
            italic = true,
        },

        close_button = {
            fg = { attribute = "fg", highlight = "TabLine" },
            bg = { attribute = "bg", highlight = "Normal" },
        },
        close_button_visible = {
            fg = { attribute = "fg", highlight = "TabLine" },
            bg = { attribute = "bg", highlight = "Normal" },
        },
        -- close_button_selected = {
        --   fg = {attribute='fg',highlight='TabLineSel'},
        --   bg ={attribute='bg',highlight='TabLineSel'}
        --   },

        tab_selected = {
            fg = { attribute = "fg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "Normal" },
            italic = true,
        },
        tab = {
            fg = { attribute = "fg", highlight = "TabLine" },
            bg = { attribute = "bg", highlight = "Normal" },
            italic = true,
        },
        tab_close = {
            -- fg = {attribute='fg',highlight='LspDiagnosticsDefaultError'},
            fg = { attribute = "fg", highlight = "TabLineSel" },
            bg = { attribute = "bg", highlight = "Normal" },
            italic = true,
        },

        duplicate_selected = {
            fg = { attribute = "fg", highlight = "TabLineSel" },
            bg = { attribute = "bg", highlight = "Normal" },
            italic = true,
        },
        duplicate_visible = {
            fg = { attribute = "fg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "Normal" },
            italic = true,
        },
        duplicate = {
            fg = { attribute = "fg", highlight = "TabLine" },
            bg = { attribute = "bg", highlight = "Normal" },
            italic = true,
        },

        modified = {
            fg = { attribute = "fg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "Normal" },
            italic = true,
        },
        modified_selected = {
            fg = { attribute = "fg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "Normal" },
            italic = true,
        },
        modified_visible = {
            fg = { attribute = "fg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "Normal" },
            italic = true,
        },

        separator = {
            fg = { attribute = "bg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "Normal" },
            italic = true,
        },
        separator_selected = {
            fg = { attribute = "bg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "Normal" },
            italic = true,
        },
        -- separator_visible = {
        --   fg = {attribute='bg',highlight='TabLine'},
        --   bg = {attribute='bg',highlight='TabLine'}
        --   },
        indicator_selected = {
            fg = { attribute = "fg", highlight = "LspDiagnosticsDefaultHint" },
            bg = { attribute = "bg", highlight = "Normal" },
            italic = true,
        },
    },
}
