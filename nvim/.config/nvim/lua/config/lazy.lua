local profile = require("config.profile")
local extras = require("config.extras")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local spec = {
  -- add LazyVim and import its plugins
  { "LazyVim/LazyVim", import = "lazyvim.plugins" },
}

local rtp_paths = {}
if profile.base_root ~= profile.config_root then
  rtp_paths[#rtp_paths + 1] = profile.base_root
end

for _, extra in ipairs(extras.base) do
  spec[#spec + 1] = { import = extra }
end

for _, extra in ipairs(extras.profiles[profile.name] or {}) do
  spec[#spec + 1] = { import = extra }
end

spec[#spec + 1] = { import = "plugins.base" }

if profile.name ~= "base" then
  spec[#spec + 1] = { import = "plugins.profile." .. profile.name }
end

require("lazy").setup({
  spec = spec,
  lockfile = vim.fs.joinpath(profile.base_root, "lazy-lock.json"),
  defaults = {
    lazy = false,
    version = false,
  },
  install = {},
  checker = {
    enabled = true,
    notify = true,
  },
  performance = {
    rtp = {
      paths = rtp_paths,
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
