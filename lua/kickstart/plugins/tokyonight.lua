return {
  {
    'benjaminjellis/rose-pine',
    name = 'rose-pine',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'rose-pine'

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,

    opts = {
      -- these options make the theme transparent
      -- disable_background = true,
      -- disable_float_background = true,
      -- highlight_groups = {
      --   Normal = { bg = "none" },
      -- },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
