-- Configure Lazy --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Protected call to Lazy
local ok, lazy = pcall(require, "lazy")
if not ok then
  return
end

-- Lazy needs leader mapped --
require("helpers.keys").set_leader(" ")

-- Setup Lazy --
lazy.setup("plugins")


-- Set keymap for Lazy --
local map = require("helpers.keys").map

map("n", "<Leader>L", lazy.show, "Shows Lazy")


