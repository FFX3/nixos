local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

ls.add_snippets("lua", {
    ls.snippet("lf", {
        ls.text_node("local "),
        ls.insert_node(1),
        ls.text_node(" = function("),
        ls.insert_node(2),
        ls.text_node({ ")", "    " }),
        ls.insert_node(0),
        ls.text_node({ "", "end" }),
    }),

    ls.snippet("req",
        fmt("local {} = require('{}')", {
            f(function(args)
                print(vim.inspect(args))
                local parts = vim.split(args[1][1], ".", true)
                print(vim.inspect(parts))
                return parts[#parts] or ""
            end, { 1 }),
            i(1),
        })
    ),

    s('req_reload', fmt([[
            package.loaded['{}'] = nil
            require('{}')
        ]],
        { rep(1), i(1) }
    )),

    s('luasnip', fmt([[
        local ls = require("luasnip")
        local s = ls.snippet
        local sn = ls.snippet_node
        local isn = ls.indent_snippet_node
        local t = ls.text_node
        local i = ls.insert_node
        local f = ls.function_node
        local c = ls.choice_node
        local d = ls.dynamic_node
        local r = ls.restore_node
        local events = require("luasnip.util.events")
        local ai = require("luasnip.nodes.absolute_indexer")
        local extras = require("luasnip.extras")
        local l = extras.lambda
        local rep = extras.rep
        local p = extras.partial
        local m = extras.match
        local n = extras.nonempty
        local dl = extras.dynamic_lambda
        local fmt = require("luasnip.extras.fmt").fmt
        local fmta = require("luasnip.extras.fmt").fmta
        local conds = require("luasnip.extras.expand_conditions")
        local postfix = require("luasnip.extras.postfix").postfix
        local types = require("luasnip.util.types")
        local parse = require("luasnip.util.parser").parse_snippet
        local ms = ls.multi_snippet
        local k = require("luasnip.nodes.key_indexer").new_key


        ls.add_snippets('<>', {
            <>
        }, { key = '<>' }) 
    ]], {
        i(1),
        i(0),
        rep(1)
    } , {
        delimiters = "<>"
    })),

}, { key = 'lua' })
