local cmp = require('cmp')
local luasnip = require('luasnip')

local cmp_select = {behavior = cmp.SelectBehavior.Select}


local cmp_lang_maps = {
    ["QWERTY"] = cmp.mapping.preset.insert {
        ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-o>'] = cmp.mapping.confirm({ select = true }),
    },
    ["COLMAKDH"] = cmp.mapping.preset.insert {
        ['<C-e>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    },
}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  mapping = cmp_lang_maps[LANGMAP_SETTING],

  sources =  {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }

}
