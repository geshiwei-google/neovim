-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "catppuccin-macchiato",

	hl_override = {
		Comment = { italic = true },
		["@comment"] = { italic = true },
		Visual = { bg = "#88A8B5", fg = "#ffffff" },
		StatusLine = { bg = "#24273a" },
		StatusLineNC = { bg = "#24273a" },
		St_EmptySpace = { bg = "#24273a" },
	},
}

M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
-- }

return M
