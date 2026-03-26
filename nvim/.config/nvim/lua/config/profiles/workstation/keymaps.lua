return function()
  local map = LazyVim.safe_keymap_set
  local dropbar_api = require("dropbar.api")

  -- Dropbar
  map("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
  map("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
  map("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
end
