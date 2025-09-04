return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    vim.opt.termguicolors = true

    require("bufferline").setup({
      options = {
        mode = "tabs",
        separator_style = "slant",
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "center",
            separator = true,
          },
        },
      },
    })

    -- set keymaps
    local keymap = vim.keymap -- for consciseness

    keymap.set("n", "<leader>bl", "<cmd>BufferLinePick<CR>", { desc = "Change a buffer using BufferLine Picker" }) -- switch between buffers using BufferLinePicker
  end,
}
