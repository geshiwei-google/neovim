return {
  "nvim-tree/nvim-tree.lua",
  opts = {
    git = {
      enable = true,
      timeout = 200, -- Kills the git process if it takes longer than 200ms
    },
    filesystem_watchers = {
      enable = false, -- Stops NvimTree from actively watching thousands of files
    },
    diagnostics = {
      enable = false,
    },
  },
}
