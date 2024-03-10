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

trivia = [[
{
  "id": <>,
  "question": "<>",
  "answer": "<>"
},
]]

return {
s(
    { trig="qu" },
    fmta(trivia, {i(1), i(2), i(3)}),
    {}
)
}
