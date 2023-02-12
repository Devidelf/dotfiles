local nvim_lsp = require('lspconfig') 
local treesitter = require('nvim-treesitter.configs')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local null_ls = require('null-ls')
local prettier = require('prettier')
local cmp = require('cmp')
local ls = require('luasnip')
local ll = require('lualine')
local telescope = require('telescope')
local indent = require('indent_blankline')
local focus = require('focus')
local color = require('nvim-highlight-colors');

cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({map_char = {tex = ''}}))


require('nvim-autopairs').setup({
  disable_filetype = { "html", "php" },
});

ll.setup({
  options = {
    theme = 'gruvbox-baby'
  },
  sections = {
    lualine_c = {'filename'}
  }
});

require('nightfox').setup();
vim.cmd("colorscheme nordfox")

indent.setup();
color.setup();
telescope.setup();

vim.diagnostic.config({
  virtual_text = false,
})

focus.setup({
  bufnew = false,
});

vim.api.nvim_set_keymap('n', '<leader>h', ':FocusSplitLeft<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>j', ':FocusSplitDown<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', ':FocusSplitUp<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>l', ':FocusSplitRight<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<c-l>', '<c-w>l', {silent = true})
vim.api.nvim_set_keymap('n', '<c-h>', '<c-w>h', {silent = true})

vim.api.nvim_set_keymap("n", "<leader>r", "<cmd>lua vim.lsp.buf.hover()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua vim.diagnostic.open_float()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<leader>gf", "<cmd>lua require('telescope.builtin').lsp_references()<CR>", {silent = true})

treesitter.setup {
  ensure_installed = { "css", "lua", "javascript", "php", "html", "typescript"},
  sync_install = false,
  auto_install = true,

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
      { name = 'csscp'},
    }, {
      { name = 'buffer' },
    })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local my_source = {
  null_ls.builtins.formatting.prettierd.with(
    {
      filetypes = {"html", "json", "css", "javascript", "typescript", "php"},
    }
  )
} 

null_ls.setup({
  sources = my_source,
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.cmd("nnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.format({async = true})<CR>")
      -- format on save
      vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.format({async = true})")
    end

    if client.server_capabilities.documentRangeFormattingProvider then
      vim.cmd("xnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.range_format({async = true})<CR>")
    end
  end,
})

prettier.setup({
  bin = 'prettierd', 
  filetypes = {
    'css',
    'html', 
    'javascript',
    'lua',
    'php',
  }
})

nvim_lsp.cssls.setup{
 cmd = { "vscode-css-language-server", "--stdio" };
 settings = { 
   css = { validate = false}
  };
  capabilities = capabilities
};

nvim_lsp.cssmodules_ls.setup{
  cmd = {"cssmodules-language-server"};
  filetypes = {"css"};
}

nvim_lsp.tsserver.setup{
 on_attach = function(client)
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
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
