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

local in_mathzone = require("utils").in_mathzone

-- We want to be able to turn some math snippets off while writing text
-- in a math environment.
local function in_text_env()
    local text_cmds = { "textit", "textrm", "textbf" }

    for idx = 1,#text_cmds do
        local current_command = vim.fn['vimtex#cmd#get_current']()

        if current_command and current_command.name then
            -- The full name is returned, e.g. \textit,
            -- so slice off the "\" so it looks nicer
            local in_text = string.sub(current_command.name, 2,-1) == text_cmds[idx]
            if in_text then
                return true
            end
        end
    end

    return false
end

local function in_math_and_not_text()
    return in_mathzone() and not in_text_env()
end

return {
-- Comparisons
-- \leq
s(
    { trig="<=", snippetType="autosnippet" },
    t("\\leq"),
    { condition = in_mathzone }
),
-- \geq
s(
    { trig=">=", snippetType="autosnippet" },
    t("\\geq"),
    { condition = in_mathzone }
),
-- \neq
s(
    { trig="!=", snippetType="autosnippet" },
    t("\\neq"),
    { condition = in_mathzone }
),

-- Sum
-- "dim" in Colemak for "SUM"
s(
    { trig="dim", snippetType="autosnippet" },
    fmta("\\sum_{<>}^{<>}", { i(1), i(2) }),
    { condition = in_math_and_not_text }
),

-- Limit
s(
    { trig="lim", snippetType="autosnippet" },
    fmta("\\lim_{<>}", i(1)),
    { condition = in_math_and_not_text }
),

-- Floor
-- "flr" in Colemak for "FLooR"
s(
    { trig="eus" },
    fmta("\\left\\lfloor<>\\right\\rfloor", i(1)),
    { condition = in_math_and_not_text }
),

-- Ceil
-- "cel" in Colemak for "CEiL"
s(
    { trig="cku" },
    fmta("\\left\\lceil<>\\right\\rceil", i(1)),
    { condition = in_math_and_not_text }
),

-- Derivatives
-- "DerivatiVe"
s(
    { trig="dv", snippetType="autosnippet" },
    fmta("\\dv{<>}{<>}", { i(1), i(2) }),
    { condition = in_math_and_not_text }
),

-- Partial Derivative
-- "Partial DerivatiVe"
s(
    { trig="pdv", snippetType="autosnippet" },
    fmta("\\pdv{<>}{<>}", { i(1), i(2) }),
    { condition = in_math_and_not_text }
),

-- Integrals
-- "dint" in Colemak for "Definite INTegral"
s(
    { trig="gljf", snippetType="autosnippet", priority = 1000 },
    fmta("\\int_{<>}^{<>}", { i(1), i(2) }),
    { condition = in_math_and_not_text }
),

-- "int" in Colemak for "INTegral"
s(
    { trig = "ljf", snippetType="autosnippet", priority = 900 },
    t("\\int "),
    { condition = in_math_and_not_text }
),

-- Differential
-- "DiFferential
s(
    { trig = "df", snippetType="autosnippet" },
    t("\\diff "),
    { condition = in_math_and_not_text }
),

-- Infty
-- "inf" in Colemak for "INFinity"
s(
    { trig="lje", snippetType="autosnippet", wordTrig = false },
    t("\\infty"),
    { condition = in_math_and_not_text }
),

-- Fractions
-- "fraction" and "fd" both begin with "f"
s(
    { trig="fd", snippetType="autosnippet", wordTrig=false },
    fmta("\\frac{<>}{<>}", {i(1), i(2)}),
    { condition = in_math_and_not_text }
),

-- Superscript
s(
    { trig="^", snippetType="autosnippet", wordTrig=false },
    fmta("^{<>}", i(1)),
    { condition = in_math_and_not_text }
),
-- Subscript
s(
    { trig="_", snippetType="autosnippet", wordTrig=false },
    fmta("_{<>}", i(1)),
    { condition = in_math_and_not_text }
),

-- Vec
-- "vkc" in Colemak for "VEC"
s(
    { trig="vkc", snippetType="autosnippet", wordTrig=false },
    fmta("\\vec{<>}", i(1)),
    { condition = in_math_and_not_text }
),

-- Textrm
-- "trm" in Colemak for "TextRM"
s(
    { trig="fsm", snippetType="autosnippet", wordTrig=false },
    fmta("\\textrm{<>}", i(1)),
    { condition = in_math_and_not_text }
),

-- Matrixes
-- "na" in Colemak, which is like "ma", for "MAtrix"
-- supply matrix dimensions with #rowj#col
-- TODO: Fix indentation
s(
    { trig="ja(%d)j(%d)", regTrig=true, wordTrig=false },
    fmta([[
        \begin{<>matrix}
            <>
        \end{<>matrix}
        ]],
        {
            i(1),
            d(2,
                function(_, snip)
                    local R = tonumber(snip.captures[1])
                    local C = tonumber(snip.captures[2])

                    local nodes = {}
                    local format_string = {}

                    for y = 0,R-1 do
                        local strings = {}
                        for x = 0,C-1 do
                            strings[x + 1] = "<>"
                            nodes[y * C + x + 1] = i(y * C + x + 1, "0")
                        end
                        format_string[y + 1] = table.concat(strings, " & ")
                    end

                    return sn(nil, fmta(table.concat(format_string, " \\\\\n"), nodes), "    ")
                end
            ),
            rep(1)
        }),
    { condition = in_math_and_not_text }
),
}
