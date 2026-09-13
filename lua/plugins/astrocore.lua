-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        Jenkinsfile = "groovy",
        hurl = "hurl",
        -- https://jsonlines.org/
        jsonl = "json",
        -- https://github.com/terraform-linters/tflint?tab=readme-ov-file#getting-started
        hcl = "terraform",
      },
      filename = {
        -- ["Foofile"] = "fooscript",
        ["uv.lock"] = "toml",
      },
      pattern = {
        -- Lua does not support regex
        --
        -- https://stackoverflow.com/a/2696469/6802186
        -- https://neovim.io/doc/user/luaref.html#luaref-patterns
        --
        -- '-' and '.' are "magic character" hence they have to be escaped
        [".+/dispatcher/src/.+%.any"] = "apache",
        [".+/dispatcher/src/.+%.conf"] = "apache",
        [".+/dispatcher/src/.+%.farm"] = "apache",
        [".+/dispatcher/src/.+%.rules"] = "apache",
        [".+/dispatcher/src/.+%.vars"] = "apache",
        [".+/dispatcher/src/.+%.vhost"] = "apache",
        [".+/dispatcher%-sdk%-.+/src/.+%.any"] = "apache",
        [".+/dispatcher%-sdk%-.+/src/.+%.conf"] = "apache",
        [".+/dispatcher%-sdk%-.+/src/.+%.farm"] = "apache",
        [".+/dispatcher%-sdk%-.+/src/.+%.rules"] = "apache",
        [".+/dispatcher%-sdk%-.+/src/.+%.vars"] = "apache",
        [".+/dispatcher%-sdk%-.+/src/.+%.vhost"] = "apache",
        -- Renderend k8s manifests should be treated as plain YAML files
        --
        -- To avoid clashes with Helm pack (see below) an explicit priority was defined.
        --
        -- Refs:
        -- - https://github.com/AstroNvim/astrocommunity/blob/main/lua/astrocommunity/pack/helm/init.lua
        -- - https://neovim.io/doc/user/lua.html#vim.filetype
        [".+/rendered%-manifests/.+/.+%.ya?ml"] = { "yaml", { priority = 10 } },
        -- YAML files with custom extension:
        -- - foo.yaml.ci.tpl
        -- - bar.yaml.ci.tpln
        [".+%.ya?ml%.ci%.tpln?"] = { "yaml" },
        -- Hugo templates
        --
        -- use 'helm' instead of 'gotmpl' to leverage better syntax highlighting
        [".+/layouts/partials/.+%.html"] = { "helm" },
      },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = false, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
      },
    },
    rooter = {
      -- prefer .git over LSP
      detector = {
        { ".git", "_darcs", ".hg", ".bzr", ".svn" },
        "lsp",
        { "lua", "MakeFile", "package.json" },
      },
      -- replaces https://github.com/ahmedkhalf/project.nvim
      autochdir = true,
    },
    autocmds = {
      -- Stop Supermaven for large buffers
      supermaven_large_buf = {
        {
          event = "User",
          pattern = "AstroLargeBuf",
          desc = "Stop Supermaven for large buffers",
          callback = function()
            local ok, api = pcall(require, "supermaven-nvim.api")
            if ok and api and api.stop then api.stop() end
          end,
        },
      },
      -- Detect large buffers from stdin (piped input)
      stdin_large_buf = {
        {
          event = "StdinReadPost",
          desc = "Detect large buffers from piped input",
          callback = function(args)
            if vim.b[args.buf].large_buf then return end

            local buffer = require "astrocore.buffer"
            if buffer.is_large(args.buf) then
              vim.b[args.buf].large_buf = true
              local buf_name = vim.api.nvim_buf_get_name(args.buf)
              if buf_name == "" then buf_name = "[stdin]" end
              vim.notify(
                ("Large file detected `%s`\nSome Neovim features may be **disabled**"):format(buf_name),
                vim.log.levels.INFO
              )
              require("astrocore").event("LargeBuf", true)
            end
          end,
        },
      },
    },
  },
}
