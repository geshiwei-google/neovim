return {
  -- Google Internal Plugins (nvgoog)
  { url = "sso://user/fentanes/nvgoog" },
  { import = "nvgoog.google.lock-file" },
  { import = "nvgoog.google.citc" },
  { import = "nvgoog.google.telescope" },
  { import = "nvgoog.google.glugins" },
  { import = "nvgoog.google.lsp" },

  -- Disable Mason (Google uses internal binaries, not Mason)
  { "williamboman/mason.nvim", enabled = false },

  -- Disable Formatter (Google uses Cider/glaze/build_cleaner)
  { "stevearc/conform.nvim", enabled = false },

  -----------------------------------------------------------------------------
  -- TELESCOPE CONFIGURATION (Centered + Prompt on Top)
  -----------------------------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function(_, conf)
      conf = conf or {}
      conf.defaults = conf.defaults or {}
      
      -- 1. Center the window
      -- 2. Put prompt at the top ("ascending")
      -- 3. Use standard horizontal layout
      local nvchad_style = {
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        use_less = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      }

      -- Merge our centered style into defaults
      conf.defaults = vim.tbl_deep_extend("force", conf.defaults, nvchad_style)

      -- Remove the 'ivy' overrides so pickers use the default (centered) theme
      conf.pickers = vim.tbl_deep_extend("force", conf.pickers or {}, {
        lsp_references = { theme = nil }, -- Use default
        lsp_definitions = { theme = nil },
        lsp_implementations = { theme = nil },
        live_grep = { theme = nil },
        find_files = { theme = nil },
        buffers = { theme = nil },
      })

      -- Attempt to load Google extensions if available
      pcall(function() require("telescope").load_extension("codesearch") end)
      pcall(function() require("telescope").load_extension("citc") end)

      return conf
    end,
  },

  -----------------------------------------------------------------------------
  -- LSP CONFIGURATION (Override keymaps for Telescope)
  -----------------------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- Use an LspAttach autocmd to set keymaps only when an LSP client attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(ev)
          -- Helper to check if a client supports a method
          local client = vim.lsp.get_client_by_id(ev.data.client_id)

          -- Map 'gd' to Telescope LSP Definitions (uses default centered theme)
          vim.keymap.set("n", "gd", function()
            require("telescope.builtin").lsp_definitions()
          end, { desc = "LSP Definition (Telescope)", buffer = ev.buf })

          -- Map 'gr' to Telescope LSP References (uses default centered theme)
          vim.keymap.set("n", "gr", function()
            require("telescope.builtin").lsp_references()
          end, { desc = "LSP References (Telescope)", buffer = ev.buf })

          -- Optional: Map 'gi' to Implementation
          vim.keymap.set("n", "gi", function()
            require("telescope.builtin").lsp_implementations()
          end, { desc = "LSP Implementation (Telescope)", buffer = ev.buf })

          -- Google Code Search Mapping (e.g., <leader>fs or <leader>fc)
          vim.keymap.set("n", "<leader>fc", function()
             -- Try to use Google Code Search extension
             local ok, _ = pcall(require("telescope").extensions.codesearch.query)
             if ok then
               require("telescope").extensions.codesearch.query()
             else
               -- Fallback to standard live_grep if extension missing
               print("Code Search extension not found, using live_grep")
               require("telescope.builtin").live_grep()
             end
          end, { desc = "Google Code Search", buffer = ev.buf })
        end,
      })
    end,
  },

  -- Hop plugin
  {
    "hadronized/hop.nvim",
    keys = {
      { "s", "<cmd>HopWord<cr>", desc = "Hop to character" },
    },
    config = function()
      require("hop").setup()
    end,
  },
}
