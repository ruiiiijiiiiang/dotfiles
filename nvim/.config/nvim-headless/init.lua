local uv = vim.uv or vim.loop
local myvimrc = vim.env.MYVIMRC or vim.fs.joinpath(vim.fn.stdpath("config"), "init.lua")
local wrapper_init = uv.fs_realpath(myvimrc) or myvimrc
local wrapper_root = vim.fs.dirname(wrapper_init)
local base_root = vim.fs.joinpath(vim.fs.dirname(wrapper_root), "nvim")

vim.g.dotfiles_nvim_profile = "headless"
vim.g.dotfiles_nvim_base_root = uv.fs_realpath(base_root) or base_root

vim.opt.rtp:prepend(base_root)
dofile(vim.fs.joinpath(base_root, "init.lua"))
