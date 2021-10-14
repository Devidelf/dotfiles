local nvim_lsp = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
local cmp = require'cmp'

cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip'},
      { name = 'buffer' },
    }
 })

require('nvim-autopairs').setup{};
require("nvim-autopairs.completion.cmp").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
  auto_select = true, -- automatically select the first item
  insert = false, -- use insert confirm behavior instead of replace
  map_char = { -- modifies the function or method delimiter by filetypes
    all = '(',
    tex = '{'
  }
})

nvim_lsp.cssls.setup{
 cmd = { "vscode-css-language-server", "--stdio" };
 settings = { 
   css = { validate = true}
  };
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

nvim_lsp.html.setup{
  cmd = { "vscode-html-language-server", "--stdio" };
  filetypes = { "html" };
  init_options = {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = {
    css = true,
    javascript = true
    }
  };
    root_dir = function(fname) return util.root_pattern('package.json', '.git')(fname) or util.path.dirname(fname)
        end,
    settings = {}
};

