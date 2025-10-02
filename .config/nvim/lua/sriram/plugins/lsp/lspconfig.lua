return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_nvim_lsp.default_capabilities()
    local keymap = vim.keymap

    -- Diagnostics: modern sign config
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = "󰠠 ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
    })

    -- Keymaps on LSP attach
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        -- ── LSP nav actions (Telescope versions) ────────────────────────────────
        -- opts.desc = "Show LSP references"
        -- keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        -- opts.desc = "Show LSP definitions"
        -- keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        -- opts.desc = "Show LSP implementations"
        -- keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

        -- opts.desc = "Show LSP type definitions"
        -- keymap.set("n", "gt", "<cmd:Telescope lsp_type_definitions<CR>", opts)

        -- ── LSP nav actions (builtin replacements; future-proof for 0.12/0.13) ──
        opts.desc = "Go to definition"
        keymap.set("n", "gd", vim.lsp.buf.definition, opts)

        opts.desc = "Show LSP references"
        keymap.set("n", "gR", vim.lsp.buf.references, opts)

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)

        -- Other LSP actions (unchanged)
        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

        opts.desc = "Show documentation"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
      end,
    })

    -- Mason + mason-lspconfig
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "svelte", "graphql", "emmet_ls" },
      automatic_installation = false,
      -- v2 behavior: automatically calls vim.lsp.enable() for installed servers
      automatic_enable = true,
    })

    ---------------------------------------------------------------------------
    -- Server configs (Neovim 0.11+): vim.lsp.config('name', opts)
    ---------------------------------------------------------------------------

    -- Lua
    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          completion = { callSnippet = "Replace" },
          workspace = { checkThirdParty = false },
        },
      },
    })

    -- Svelte
    vim.lsp.config("svelte", {
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        -- Inform the server when TS/JS files change (Svelte's special hook)
        vim.api.nvim_create_autocmd("BufWritePost", {
          buffer = bufnr,
          pattern = { "*.js", "*.ts" },
          callback = function(ctx)
            local uri = vim.uri_from_fname(ctx.file)
            client.notify("$/onDidChangeTsOrJsFile", { uri = uri })
          end,
        })
      end,
    })

    -- GraphQL
    vim.lsp.config("graphql", {
      capabilities = capabilities,
      filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
    })

    -- Emmet
    vim.lsp.config("emmet_ls", {
      capabilities = capabilities,
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
    })

    -- NOTE:
    -- We do NOT call require('lspconfig').XYZ.setup() anymore.
    -- We also don't call vim.lsp.enable() manually here because
    -- mason-lspconfig v2 `automatic_enable = true` already enables installed servers.
  end,
}
