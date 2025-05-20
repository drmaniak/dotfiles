-- Custom methods for LSP --
local on_attach = require("configs.mylspconfig").on_attach
local on_init = require("configs.mylspconfig").on_init
local capabilities = require("configs.mylspconfig").capabilities

-- Define servers --
local servers = {
  "lua_ls",
  "bashls",
  "pyright",
  "marksman",
  "html",
  "yamlls",
  "dockerls",
  "docker_compose_language_service",
  "taplo"
}

local tools = {
  "black",
  "debugpy",
  "flake8",
  "isort",
  "mypy",
  "pylint",
  "hadolint",
  "ruff",
  "pydocstyle",
  "htmlhint",
  "prettier",
  "stylua"
}

return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        PATH = "append",
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = servers, -- defined above
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = tools,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- Configure diagnostic display
      vim.diagnostic.config({
        severity_sort = true, -- Sort diagnostics in order of severity (Errors before warnings)
        float = {
          border = "rounded",
          severity_sort = true,
          source = true,
          header = "Diagnostics",
          prefix = "",
        },
      })

      -- Loop through all servers and set up
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({

          on_attach = on_attach,
          on_init = on_init,
          capabilities = capabilities,
        })
      end

      -- Setup lua_ls separately
      lspconfig["lua_ls"].setup({
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = {
                "vim",
                "require",
              },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })
    end,
  },
}
