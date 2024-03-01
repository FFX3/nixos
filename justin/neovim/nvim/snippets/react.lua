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


ls.add_snippets('typescriptreact', {
    s(
        'state',
        fmt([[
            const [{}, set{}] = useState{}({})
            {}
        ]], {
            i(1),
            d(4, function (args)
                args[1][1] = args[1][1]:gsub("^%l", string.upper)
                return sn(nil, {
                    --i(1, args[1])
                    t(args[1])
                })
            end, 1),
            sn(3, {
                n(1, "<", ""),
                i(1),
                n(1, ">", ""),
            }),
            i(2),
            i(0),
        })
    ),

    s(
        'context',
        fmt([[
            import React, {{ useState, createContext, useContext }} from "react"

            type {state_type} = {{
                {state_type_props}
            }}

            const {context_name}Context = createContext(null)

            export function use{context_name_repeat_capitalized}(){{
                return useContext({context_name_repeat}Context)
            }}

            export function {context_name_repeat_capitalized}ContextProvider({{ children }}){{
                const [{context_name_repeat}, set{context_name_repeat_capitalized}] = useState<{state_type_repeat}>()

                {final}

                return <{context_name_repeat}Context.Provider value={{{{
                    {context_name_repeat},
                    set{context_name_repeat_capitalized},
                }}}}>
                    {{ children }}
                </{context_name_repeat}Context.Provider>
            }}
        ]],
        {
            context_name = i(1),
            context_name_repeat = rep(1),
            context_name_repeat_capitalized = d(4, function (args)
                args[1][1] = args[1][1]:gsub("^%l", string.upper)
                return sn(nil, {
                    t(args[1])
                })
            end, 1),
            state_type = d(2, function (args)
                args[1][1] = args[1][1]:gsub("^%l", string.upper)
                return sn(nil, {
                    i(1, args[1])
                })
            end, 1),
            state_type_repeat = rep(2),
            state_type_props = i(3),
            final = i(0),
        },
        { repeat_duplicates = true }
        )
    ),
}, { key = 'typescriptreact' })
