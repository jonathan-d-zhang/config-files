-- Loads boilerplate code from files in the boilerplate directory
-- Only works on *nix because it uses /bin/ls lol
-- Loads files in the boilerplate directory

-- Abbreviations used in the LuaSnip docs, to make LSP happy
--[[
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

local conditions = require("luasnip.extras.expand_conditions")

local function readFile(path)
    io.input(path)
    return io.read("a")
end

local function name(path)
    local start = 1
    local r
    while true do
        r = string.find(path, "/", start)
        if r == nil then
            return string.sub(path, start)
        end

        start = r
    end
end

local function dfs()
    local stack = io.popen("ls /home/jz9/.config/nvim/LuaSnip/boilerplate"):lines()
    local snippets = {}

    while #stack > 0 do
        local file = table.remove(stack)

        if extension(file) == nil then
            for p in io.popen("ls " .. string.format("/%s", file)) do
                stack[#stack+1] = file .. string.format("%s", p)
            end
        else
            local content = readFile(file)
            local snippet = s(name(file) .. "boil", fmta(content, i(0)), { condition = conditions.line_begin })
            snippets[#snippets+1] = snippet
        end
    end

    return snippets
end

return dfs()

local files = io.popen("ls /home/jz9/.config/nvim/LuaSnip/boilerplate"):lines()
local snippets = {}
for path in files do
    local filename = name(path)
    local content = readFile(path)
    snippets[#snippets+1] = s(filename .. "boil", { t(content) }, { condition = conditions.line_begin })
end

return snippets
--]]
