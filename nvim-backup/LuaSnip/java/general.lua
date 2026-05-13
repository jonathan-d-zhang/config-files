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

return {
s(
    "Sop",
    t("System.out.println"),
    { condition = conditions.line_begin }
),
}
