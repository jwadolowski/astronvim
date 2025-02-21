-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
vim.filetype.add {
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
}
