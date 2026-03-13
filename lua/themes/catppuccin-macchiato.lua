local M = {}

M.base_30 = {
  white = "#cad3f5",
  darker_black = "#1e2030",
  black = "#24273a",
  black2 = "#24273a",
  one_bg = "#363a4f",
  one_bg2 = "#494d64",
  one_bg3 = "#5b6078",
  grey = "#6e738d",
  grey_fg = "#8087a2",
  grey_fg2 = "#939ab7",
  light_grey = "#a5adcb",
  red = "#ed8796",
  baby_pink = "#f0c6c6",
  pink = "#f5bde6",
  line = "#363a4f",
  green = "#a6da95",
  vibrant_green = "#a6da95",
  nord_blue = "#8aadf4",
  blue = "#8aadf4",
  yellow = "#eed49f",
  sun = "#f4dbd6",
  purple = "#c6a0f6",
  dark_purple = "#c6a0f6",
  teal = "#8bd5ca",
  orange = "#f5a97f",
  cyan = "#91d7e3",
  statusline_bg = "#24273a",
  lightbg = "#24273a",
  pmenu_bg = "#a6da95",
  folder_bg = "#8aadf4",
  lavender = "#b7bdf8",
}

M.base_16 = {
  base00 = "#24273a",
  base01 = "#1e2030",
  base02 = "#363a4f",
  base03 = "#494d64",
  base04 = "#5b6078",
  base05 = "#cad3f5",
  base06 = "#b8c0e0",
  base07 = "#a5adcb",
  base08 = "#ed8796",
  base09 = "#f5a97f",
  base0A = "#eed49f",
  base0B = "#a6da95",
  base0C = "#8bd5ca",
  base0D = "#8aadf4",
  base0E = "#c6a0f6",
  base0F = "#ee99a0",
}

M.polish_hl = {
  treesitter = {
    ["@variable"] = { fg = M.base_30.lavender },
    ["@property"] = { fg = M.base_30.teal },
    ["@variable.builtin"] = { fg = M.base_30.red },
  },
}

M.type = "dark"

M = require("base46").override_theme(M, "catppuccin-macchiato")

return M
