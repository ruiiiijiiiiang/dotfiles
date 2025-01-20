require("git"):setup()
require("starship"):setup()
require("full-border"):setup({
  type = ui.Border.ROUNDED,
})
require("yaziline"):setup({
  separator_open = "░▒▓",
  separator_close = "▓▒░",
  separator_open_thin = "",
  separator_close_thin = "",
  separator_head = "",
  separator_tail = "",
})
