return function()
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      if vim.bo[args.buf].filetype == "markdown" then
        vim.diagnostic.enable(false)
      end
    end,
  })
end
