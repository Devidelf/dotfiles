local nvim_lsp = require('lspconfig') 
local treesitter = require('nvim-treesitter.configs')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local null_ls = require('null-ls')
local prettier = require('prettier')
local cmp = require('cmp')
local ls = require('luasnip')
local ll = require('lualine')

cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({map_char = {tex = ''}}))

require('nvim-autopairs').setup({
  disable_filetype = { "html", "php" },
});

ll.setup({
  options = {
    theme = 'gruvbox'
  },
  sections = {
    lualine_c = {'filename', 'buffers'}
  }
});

require('focus').setup({
  bufnew = true,
});
vim.api.nvim_set_keymap('n', '<leader>h', ':FocusSplitLeft<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>j', ':FocusSplitDown<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', ':FocusSplitUp<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>l', ':FocusSplitRight<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<c-l>', '<c-w>l', {silent = true})
vim.api.nvim_set_keymap('n', '<c-h>', '<c-w>h', {silent = true})

treesitter.setup {
  ensure_installed = { "css", "lua", "javascript", "php", "html", "typescript"},
  sync_install = false,
  auto_install = true,

  ignore_install = { "javascript" },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
} 

cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
      },
      ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif ls.expand_or_jumpable() then
        ls.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif ls.jumpable(-1) then
        ls.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip'},
    }, {
      { name = 'buffer' },
    })
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

null_ls.setup({
  sources = {null_ls.builtins.formatting.prettier},
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
   css = { validate = false}
  };
  capabilities = capabilities
};

require'lspconfig'.cssmodules_ls.setup{
  cmd = {"cssmodules-language-server"}
}

nvim_lsp.tsserver.setup{
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end,
  flags = lsp_flags,
  cmd = { "typescript-language-server", "--stdio" };
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" };
  init_options = {
    hostInfo = "neovim"
  };
  capabilities = capabilities;
};


nvim_lsp.html.setup{
  cmd = { "vscode-html-language-server", "--stdio" };
  filetypes = { "html" };
  init_options = {
    configurationSection = { "html", "css" , "javascript"},
    embeddedLanguages = {
    css = true,
    javascript = true
    },
    provideFormatter = true
  };
};

nvim_lsp.intelephense.setup({
  settings = {
    intelephense = {
      stubs = {
        "standard",
        "date",
        "Core",
        "wordpress",
        "woocommerce",
        "acf-pro",
        "wordpress-globals",
      },
      files = {
        maxSize = 5000000;
      };
    };
  },
  capabilities = capabilities,
  on_attach = on_attach
});

require("luasnip.loaders.from_vscode").lazy_load();
require("luasnip.loaders.from_vscode").lazy_load({paths = {"~/.config/nvim/my-snippets"}});
