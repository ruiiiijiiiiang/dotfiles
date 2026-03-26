local M = {}

M.name = vim.g.dotfiles_nvim_profile or "base"
M.base_root = vim.g.dotfiles_nvim_base_root or vim.fn.stdpath("config")
M.config_root = vim.fn.stdpath("config")

function M.is(name)
  return M.name == name
end

return M
