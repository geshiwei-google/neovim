require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Terminal mode: jk to exit to normal mode
map("t", "jk", "<C-\\><C-n>", { desc = "Terminal exit to normal mode" })


-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Neoscopes
map("n", "<leader>ns", function() require("telescope").extensions.neoscopes.neoscopes() end, { desc = "Select Neoscopes" })

-- Search within the nearest package (defined by METADATA file)
local function search_nearest_package()
  local current_file = vim.api.nvim_buf_get_name(0)
  -- Find the nearest METADATA file upwards
  local metadata_files = vim.fs.find({ "BUILD" }, {
    path = vim.fs.dirname(current_file),
    upward = true,
    stop = vim.env.HOME, -- Stop at home directory to avoid scanning too far
  })

  local relative_path = ""
  if #metadata_files > 0 then
    local package_root = vim.fs.dirname(metadata_files[1])
    -- Extract path relative to google3 if possible, otherwise use full path
    -- Assuming google3 structure: .../google3/path/to/package
    -- We can try to find "google3/" in the path.
    local g3_pattern = "google3/"
    local start_idx, end_idx = package_root:find(g3_pattern)
    if end_idx then
      relative_path = package_root:sub(end_idx + 1)
    else
      -- Fallback: if not in google3 explicitly, use the package root name
      relative_path = vim.fn.fnamemodify(package_root, ":.")
    end
  else
    -- Fallback to current directory relative to google3 if METADATA not found
    local g3_pattern = "google3/"
    local start_idx, end_idx = current_file:find(g3_pattern)
    if end_idx then
       relative_path = vim.fs.dirname(current_file):sub(end_idx + 1)
    else
       relative_path = vim.fn.fnamemodify(vim.fs.dirname(current_file), ":.")
    end
  end

  require("telescope").extensions.codesearch.find_query({ default_text = "f:" .. relative_path })
end

map("n", "<leader>sz", search_nearest_package, { desc = "Search in nearest package (METADATA)" })

-- Diagnostics (Telescope instead of loclist)
map("n", "<leader>dc", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Telescope diagnostics (current buffer)" })
map("n", "<leader>dw", "<cmd>Telescope diagnostics<CR>", { desc = "Telescope diagnostics (workspace)" })

-- Document Symbols
map("n", "<leader>ds", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "LSP Document Symbols" })



