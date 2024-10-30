-- This module defines snippets for commonly used Greek letters

-- Abbreviations used in the LuaSnip docs, to make LSP happy
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local isn = ls.indent_snippet_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local in_mathzone = require("utils").in_mathzone

return {

-- alpha
s(
    { trig=";a", snippetType="autosnippet" },
    t("\\alpha"),
    { condition = in_mathzone }
),

-- Delta
s(
    { trig=";D", snippetType="autosnippet" },
    t("\\Delta"),
    { condition = in_mathzone }
),

-- delta
s(
    { trig=";d", snippetType="autosnippet" },
    t("\\delta"),
    { condition = in_mathzone }
),

-- Theta
s(
    { trig=";T", snippetType="autosnippet" },
    t("\\Theta"),
    { condition = in_mathzone }
),

-- theta
s(
    { trig=";t", snippetType="autosnippet" },
    t("\\theta"),
    { condition = in_mathzone }
),

-- lambda
s(
    { trig=";l", snippetType="autosnippet" },
    t("\\lambda"),
    { condition = in_mathzone }
),

-- mu
s(
    { trig=";m", snippetType="autosnippet" },
    t("\\mu"),
    { condition = in_mathzone }
),

-- pi
s(
    { trig=";p", snippetType="autosnippet" },
    t("\\pi"),
    { condition = in_mathzone }
),

-- \varepsilon
s(
    { trig="kk"},
    t("\\varepsilon"),
    { condition = in_mathzone }
),

-- Omega
s(
    { trig=";O", snippetType="autosnippet" },
    t("\\Omega"),
    { condition = in_mathzone }
),

-- omega
s(
    { trig=";o", snippetType="autosnippet" },
    t("\\varepsilon"),
    { condition = in_mathzone }
),
}
