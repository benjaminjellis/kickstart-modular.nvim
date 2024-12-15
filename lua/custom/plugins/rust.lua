return {
  -- Extend auto completion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      {
        'Saecki/crates.nvim',
        event = { 'BufRead Cargo.toml' },
        opts = {
          completion = {
            cmp = { enabled = true },
          },
        },
      },
    },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, { name = 'crates' })
    end,
  },
  -- Add Rust & related to treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'rust',
        'ron',
      })
    end,
  },
  -- Ensure Rust debugger is installed
  {
    'williamboman/mason.nvim',
    optional = true,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, { 'codelldb' })
    end,
  },
  {
    'mrcjkb/rustaceanvim',
    version = vim.fn.has 'nvim-0.10.0' == 0 and '^4' or false,
    ft = { 'rust' },
    opts = {
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set('n', '<leader>cR', function()
            vim.cmd.RustLsp 'codeAction'
          end, { desc = 'Code Action', buffer = bufnr })
          vim.keymap.set('n', '<leader>ce', function()
            vim.cmd.RustLsp 'expandMacro'
          end, { desc = 'Expand Macro', buffer = bufnr })
          vim.keymap.set('n', '<C-k>', function()
            vim.cmd.RustLsp { 'hover', 'actions' }
          end, { desc = 'Hover Action', buffer = bufnr })
          vim.keymap.set('n', '<leader>dr', function()
            vim.cmd.RustLsp 'debuggables'
          end, { desc = 'Rust Debuggables', buffer = bufnr })
        end,
        default_settings = {
          -- rust-analyzer language server configuration
          ['rust-analyzer'] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
            },
            -- Add clippy lints for Rust.
            checkOnSave = true,
            rustfmt = {
              extraArgs = { '--config', 'imports_granularity=crate' },
            },
            procMacro = {
              enable = true,
              ignored = {
                -- ["async-trait"] = { "async_trait" },
                ['napi-derive'] = { 'napi' },
                ['async-recursion'] = { 'async_recursion' },
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend('keep', vim.g.rustaceanvim or {}, opts or {})
      -- if vim.fn.executable 'rust-analyzer' == 0 then
      --   LazyVim.error('**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/', { title = 'rustaceanvim' })
      -- end
    end,
  },
  { 'Saecki/crates.nvim', enabled = false },
  { 'tamasfe/taplo', enabled = false },

  -- Correctly setup lspconfig for Rust 🚀
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {},
    },
  },
  {
    'nvim-neotest/neotest',
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      vim.list_extend(opts.adapters, {
        require 'rustaceanvim.neotest',
      })
    end,
  },
}
