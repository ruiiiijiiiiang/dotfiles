local profile = require("config.profile")

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("no_auto_comment", {}),
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

if profile.is("workstation") then
  require("config.profiles.workstation.autocmds")()
end
