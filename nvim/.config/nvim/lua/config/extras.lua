local function flatten(...)
  local merged = {}

  for i = 1, select("#", ...) do
    local group = select(i, ...)
    vim.list_extend(merged, group)
  end

  return merged
end

local base = {
  editing = {
    "lazyvim.plugins.extras.coding.mini-comment",
    "lazyvim.plugins.extras.coding.mini-surround",
    "lazyvim.plugins.extras.coding.yanky",
    "lazyvim.plugins.extras.editor.dial",
    "lazyvim.plugins.extras.editor.mini-files",
    "lazyvim.plugins.extras.editor.mini-move",
    "lazyvim.plugins.extras.formatting.prettier",
  },
  navigation = {
    "lazyvim.plugins.extras.editor.leap",
    "lazyvim.plugins.extras.editor.navic",
    "lazyvim.plugins.extras.editor.snacks_explorer",
  },
  ui = {
    "lazyvim.plugins.extras.ui.mini-animate",
    "lazyvim.plugins.extras.ui.smear-cursor",
  },
  utility = {
    "lazyvim.plugins.extras.util.dot",
    "lazyvim.plugins.extras.util.mini-hipatterns",
  },
}

local workstation = {
  ai = {
    "lazyvim.plugins.extras.ai.sidekick",
  },
  editing = {
    "lazyvim.plugins.extras.coding.luasnip",
    "lazyvim.plugins.extras.editor.illuminate",
    "lazyvim.plugins.extras.editor.mini-diff",
    "lazyvim.plugins.extras.editor.outline",
    "lazyvim.plugins.extras.editor.overseer",
    "lazyvim.plugins.extras.editor.refactoring",
  },
  debugging = {
    "lazyvim.plugins.extras.dap.core",
  },
  languages = {
    "lazyvim.plugins.extras.lang.docker",
    "lazyvim.plugins.extras.lang.git",
    "lazyvim.plugins.extras.lang.go",
    "lazyvim.plugins.extras.lang.json",
    "lazyvim.plugins.extras.lang.markdown",
    "lazyvim.plugins.extras.lang.nix",
    "lazyvim.plugins.extras.lang.python",
    "lazyvim.plugins.extras.lang.rust",
    "lazyvim.plugins.extras.lang.svelte",
    "lazyvim.plugins.extras.lang.tailwind",
    "lazyvim.plugins.extras.lang.toml",
    "lazyvim.plugins.extras.lang.typescript",
    "lazyvim.plugins.extras.lang.yaml",
  },
  linting = {
    "lazyvim.plugins.extras.linting.eslint",
    "lazyvim.plugins.extras.lsp.none-ls",
  },
  ui = {
    "lazyvim.plugins.extras.ui.treesitter-context",
  },
}

return {
  base = flatten(base.editing, base.navigation, base.ui, base.utility),
  profiles = {
    headless = {},
    workstation = flatten(
      workstation.ai,
      workstation.editing,
      workstation.debugging,
      workstation.languages,
      workstation.linting,
      workstation.ui
    ),
  },
}
