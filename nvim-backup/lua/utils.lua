-- This module defines common functions used across many files

local Utils = {}

function Utils.in_mathzone()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

function Utils.in_env(name)
    local is_inside = vim.fn['vimtex#env#is_inside'](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end

return Utils
