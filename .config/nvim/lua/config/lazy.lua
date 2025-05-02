-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Set leader keys before loading lazy.nvim
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim with all plugins
require("lazy").setup({
  -- Filesystem Plugins
  {
    'vifm/vifm.vim',
    config = function()
      -- Enable embedding vifm in a terminal buffer
      vim.g.vifm_embed_term = 1
      vim.g.vifm_embed_split = 1
    end,
  },

  -- Autocomplete and code fix Plugins
  {
    'dense-analysis/ale',
    event = "VeryLazy", -- or more specific events like "BufReadPre"
    config = function()
      -- ALE configuration
			vim.g.ale_fixers = {
			  ['*'] = { 'remove_trailing_lines', 'trim_whitespace' },
			  javascript = { 'prettier', 'eslint' },
			  typescript = { 'prettier', 'eslint' },
			  javascriptreact = { 'prettier', 'eslint' },
			  typescriptreact = { 'prettier', 'eslint' },
			  css = { 'prettier' },
			  html = { 'prettier' },
			  json = { 'prettier' },
			  vue = { 'prettier' },
			  python = { 'yapf' },
			}

      vim.g.ale_linters = {
        vue = {'eslint', 'volar'},
        typescript = {'eslint', 'tsserver'}
      }

      -- Volar specific settings
      vim.g.ale_vue_volar_executable = 'vue-language-server'
      vim.g.ale_vue_volar_use_global = 1

      -- General settings
      vim.g.ale_use_global_executables = 0
      vim.g.ale_sign_error = '✘'
      vim.g.ale_sign_warning = '⚠'
      vim.g.ale_completion_enabled = 1
      vim.g.ale_lint_on_text_changed = 'never'
      vim.g.ale_lint_on_insert_leave = 0
      vim.g.ale_lint_on_save = 1
      vim.g.ale_fix_on_save = 1
      vim.g.ale_echo_msg_format = '[%linter%] %s [%severity%]'
    end,
  },

  -- Typescript Plugins
  {
    'leafgarland/typescript-vim',
    ft = { "typescript", "typescriptreact" },
  },

  -- Syntax Highlighting
  {
    'jparise/vim-graphql',
    ft = { "graphql" },
  },
  -- Colorscheme
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- Configure nightfox
      require('nightfox').setup({
        options = {
          styles = {
            comments = "italic",
            keywords = "bold",
            types = "italic,bold",
          },
        },
        groups = {
          terafox = {
            Normal = { bg = "#000000" }, -- Set pure black background
          },
        },
      })
      -- Set the colorscheme
      vim.cmd("colorscheme terafox")
    end,
  },
  {
    'posva/vim-vue',
    ft = { "vue" },
  },

  -- Avante: AI tools
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      provider = "gemini",
      memory_summary_provider = "gemini",
      debug = true,
      behaviour = {
        auto_suggestions = false,
        minimize_diff = false,
        disable_tools = true,
      },
      claude = {},
      gemini = {
        model = "gemini-2.5-pro-preview-03-25",
        max_tokens = 1000000,
        disable_tools = true,
      }
    },
    build = "make",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
        opts = {
          highlight = { enable = true },
          indent = { enable = true },
          ensure_installed = {
            "bash",
            "c",
            "diff",
            "html",
            "javascript",
            "jsdoc",
            "json",
            "jsonc",
            "lua",
            "luadoc",
            "luap",
            "markdown",
            "markdown_inline",
            "printf",
            "python",
            "query",
            "regex",
            "toml",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "vue",
            "xml",
            "yaml",
          },
        },
        ---@param opts TSConfig
        config = function(_, opts)
          require("nvim-treesitter.configs").setup(opts)
        end,
      },
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "ibhagwan/fzf-lua",
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true, -- required for Windows users
          },
        },
      },
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
          latex = { enabled = false }, -- Disable LaTeX support
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}, {
  checker = { enabled = false },
  change_detection = { enabled = false },
})

-- General Neovim Settings

-- Enable filetype detection, plugin, and indentation
vim.cmd('filetype plugin indent on')

-- Line numbering
vim.opt.nu = true

-- Set default encoding to UTF-8
vim.opt.encoding = 'utf-8'

-- Make backspaces more powerful
vim.opt.backspace = 'indent,eol,start'

-- Disable regex optimization (assuming 're' stands for 'redrawtime')
vim.opt.redrawtime = 0 -- Adjust if 're' refers to something else

-- Maximum number of tab pages
vim.opt.tabpagemax = 30

-- Set clipboard to use the system clipboard
vim.opt.clipboard:append('unnamedplus')

-- Set mouse support
if vim.fn.has('mouse') == 1 then
  vim.opt.mouse = 'a'
end

-- Set color column at 80 characters
vim.opt.colorcolumn = '80'

-- Enable line numbers
vim.opt.number = true

-- Autocomplete Brackets and Quotes in Insert Mode
local opts = { noremap = true, silent = true }

vim.keymap.set('i', '(', '()<Esc>i', opts)
vim.keymap.set('i', '{', '{}<Esc>i', opts)
vim.keymap.set('i', '[', '[]<Esc>i', opts)
vim.keymap.set('i', '"', '""<Esc>i', opts)
vim.keymap.set('i', "'", "''<Esc>i", opts)
vim.keymap.set('i', '<', '<><Esc>i', opts)

-- Mapping <C-e> in Insert Mode to Jump to the Matching Closing Bracket or Quote
vim.keymap.set('i', '<C-e>', [[<Esc>/[)}"'\]>]<CR>:nohl<CR>a]], opts)

-- Vifm Keybinding: Open vifm in a vertical split with Ctrl + n
vim.keymap.set('n', '<C-n>', ':vert TabVifm<CR>', opts)

-- Remap Navigation in the Jumplist with Ctrl + m and Ctrl + i
vim.keymap.set('n', '<C-m>', '<C-O>', opts)

-- ALE Jump Commands
vim.keymap.set('n', 'agt', ':ALEGoToDefinition<CR>', opts)
vim.keymap.set('n', 'afr', ':ALEFindReferences<CR>', opts)
vim.keymap.set('n', 'ah', ':ALEHover<CR>', opts)
vim.keymap.set('n', 'as', ':ALESymbolSearch<CR>', opts)
vim.keymap.set('n', 'an', '<cmd>ALENext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'ad', ':ALEDetail<CR>', opts)

-- Autocommands

-- Create an augroup to avoid duplication
vim.api.nvim_create_augroup('MyConfig', { clear = true })

-- Autocommands for setting tab-related options and file formats
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = 'MyConfig',
  pattern = '*',
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
    vim.opt_local.softtabstop = 2
  end,
})

-- Autocommand for setting file format to UNIX on new files
vim.api.nvim_create_autocmd('BufNewFile', {
  group = 'MyConfig',
  pattern = '*',
  callback = function()
    vim.opt_local.fileformat = 'unix'
  end,
})

-- ALE Configuration

-- Set UNIX line endings for all new files
vim.opt.fileformat = 'unix'


-- To get icons to work, do the following:
-- mkdir -p ~/.local/share/fonts
-- wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
-- fc-cache -fv
--
-- and then set the term font to use JetBrainsMono

vim.opt.laststatus = 3
vim.opt.syntax = "on"
vim.g.markdown_fenced_languages = {'python', 'javascript', 'html', 'bash', 'sh'}


-- Set up tab complete mapping for avante suggestions instead of alt-l
function _G.handle_tab()
  local ok, avante = pcall(require, "avante.api")
  if not ok then
    return "\t" -- Fall back to Tab
  end

  if not avante.get_suggestion then
    return "\t"
  end

  local suggestion = avante.get_suggestion()
  if suggestion and suggestion:is_visible() then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<M-l>", true, false, true), "i", true)
    return ""
  end

  -- Default to Tab if no valid suggestion
  return "\t"
end

vim.api.nvim_set_keymap(
  "i", -- Insert mode
  "<Tab>",
  "v:lua.handle_tab()",
  { expr = true, noremap = true, silent = true }
)
