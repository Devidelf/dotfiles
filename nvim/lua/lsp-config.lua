local nvim_lsp = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local null_ls = require('null-ls')
local prettier = require('prettier')
local cmp = require('cmp')

cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({map_char = {tex = ''}}))

require('nvim-autopairs').setup{};

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
null_ls.config({
  sources = {null_ls.builtins.formatting.prettier}
})
require('lspconfig')['null-ls'].setup({
  on_attach = function(client, bufnr)
    if client.resolved_capabilities.document_formatting then
      -- vim.cmd("nnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.formatting()<CR>")
      -- format on save
      vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()")
    end

    if client.resolved_capabilities.document_range_formatting then
      vim.cmd("xnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.range_formatting({})<CR>")
    end
  end,
})

prettier.setup({
  bin = 'prettier'; 
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
    "php",
  },

  -- prettier format options
  arrow_parens = "always",
  bracket_spacing = true,
  embedded_language_formatting = "auto",
  end_of_line = "lf",
  html_whitespace_sensitivity = "css",
  jsx_bracket_same_line = false,
  jsx_single_quote = true,
  print_width = 80,
  prose_wrap = "preserve",
  quote_props = "as-needed",
  semi = true,
  single_quote = true,
  tab_width = 2,
  trailing_comma = "es5",
  use_tabs = false,
  vue_indent_script_and_style = false,
})

nvim_lsp.cssls.setup{
 cmd = { "vscode-css-language-server", "--stdio" };
 settings = { 
   css = { validate = true}
  };
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
};

nvim_lsp.tsserver.setup{
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end,
  cmd = { "typescript-language-server", "--stdio" };
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" };
  init_options = {
    hostInfo = "neovim"
  };
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
};


nvim_lsp.html.setup{
  cmd = { "vscode-html-language-server", "--stdio" };
  filetypes = { "html" };
  init_options = {
    configurationSection = { "html", "css" , "javascript"},
    embeddedLanguages = {
    css = true,
    javascript = true
    }
  };
    settings = {}
};


