local options = {
    backup = false, -- creates a backup file
    clipboard = "unnamedplus", -- allows neovim to access the system clipboard
    cmdheight = 2, -- more space in the neovim command line for displaying messages
    completeopt = { "menuone", "noselect" }, -- mostly just for cmp
    conceallevel = 0, -- so that `` is visible in markdown files
    fileencoding = "utf-8", -- the encoding written to a file
    hlsearch = false, -- highlight all matches on previous search pattern
    ignorecase = true, -- ignore case in search patterns
    mouse = "a", -- allow the mouse to be used in neovim
    pumheight = 10, -- pop up menu height
    showmode = true, -- we don't need to see things like -- INSERT -- anymore
    smartcase = true, -- smart case
    smartindent = true, -- make indenting smarter again
    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right of current window
    swapfile = false, -- creates a swapfile
    termguicolors = true, -- set term gui colors (most terminals support this)
    timeoutlen = 100, -- time to wait for a mapped sequence to complete (in milliseconds)
    undofile = true, -- enable persistent undo
    updatetime = 300, -- faster completion (4000ms default)
    writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    expandtab = true, -- convert tabs to spaces
    nu = true, -- set numbered lines
    relativenumber = true, -- set relative numbered lines

    -- Cursors
    cursorline = true, -- highlight the current line
    cursorcolumn = true,

    -- Tabs
    numberwidth = 4, -- set number column width to 2 {default 4}
    softtabstop = 4,
    showtabline = 4, -- always show tabs
    shiftwidth = 4, -- the number of spaces inserted for each indentation
    tabstop = 4, -- insert 2 spaces for a table

    signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
    wrap = false, -- display lines as one long line
    scrolloff = 8, -- Don't make the cursor reach the bottom edge
    sidescrolloff = 8, -- Don't make the cursor reach the side edge
    incsearch = true, -- Enables a better search, don't causing conflict if result doesn't exist
}

vim.opt.shortmess:append "c" -- Enables to use >> or << easier


for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.cmd[[highlight ColorColumn ctermbg=0 guibg=12]]
vim.cmd[[highlight ColorLine ctermbg=10 guibg=21]]

-- vim.o.list = true -- Set special formatting charactor to on.
-- vim.o.listchars = 'eol:↲'
