local profile = require("config.profile")

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("no_auto_comment", {}),
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "snacks_picker_input", "snacks_input", "TelescopePrompt", "fzf" },
  callback = function(args)
    local bufnr = args.buf
    pcall(vim.cmd, "ReactiveStop")

    vim.api.nvim_create_autocmd({ "BufLeave", "BufDelete" }, {
      buffer = bufnr,
      once = true,
      callback = function()
        pcall(vim.cmd, "ReactiveStart")
      end,
    })
  end,
})

if profile.is("workstation") then
  require("config.profiles.workstation.autocmds")()
end
