-- TODO: Create general preamble
--
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

local conditions = require("luasnip.extras.expand_conditions")

local in_env = require("utils").in_env

local function in_list()
    return in_env('itemize') or in_env('enumerate')
end

return {
---- Section headers
-- Mimic HTML
-- Section
s(
    { trig="h1", snippetType="autosnippet"},
    fmta([[\section{<>}
<>]], {i(1), i(0)}),
    { condition = conditions.line_begin }
),

-- Subsection
s(
    { trig="h2", snippetType="autosnippet"},
    fmta([[\subsection{<>}
<>]], {i(1), i(0)}),
    { condition = conditions.line_begin }
),

-- Subsubsection
s(
    { trig="h3", snippetType="autosnippet"},
    fmta([[\subsubsection{<>}
<>]], { i(1), i(0)} ),
    { condition = conditions.line_begin }
),

-- Item
-- "it" in Colemak for "ITem"
s(
    { trig="lf", snippetType="autosnippet" },
    t("\\item "),
    { condition = in_list }
),

-- Environments
-- "env" in Colemak for "ENVironment"
s(
    { trig="kjv", snippetType="autosnippet" },
    fmta([[
        \begin{<>}
            <>
        \end{<>}
    ]], { i(1), i(0), rep(1) })
),

-- Current Date
-- Format Example: Thursday, 20 October 22
s(
    "date",
    f(function() return os.date("%A, %d %b %y") end)
),

-- Italics
-- "tit" in Colemak for "TextIT"
s(
    { trig="flf", snippetType="autosnippet", wordTrig=false },
    fmta("\\textit{<>}", i(1))
),

-- Bold
-- "tbf" in Colemak for "TextBF"
s(
    { trig="fbe", snippetType="autosnippet", wordTrig=false },
    fmta("\\textbf{<>}", i(1))
),
}
