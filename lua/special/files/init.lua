local vim = vim
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local config = require("special.config").files

M = {}

M.list_special_files = function()
  pickers.new(config, {
    prompt_title = config.prompt_title,
    -- finder = finders.new_oneshot_job({ "find" }, config ), -- async external process
    --  finder = finders.new_oneshot_job( vim.tbl_flatten({"find ", {vim.fn.stdpath("data")}}), config),
    finder = require('telescope._extensions.file_browser.finders')
        .browse_files({
          path = config.base_dir, --vim.fn.stdpath"data" .. "/jonathans_special_files",
          depth = 1,
          hidden = true,
          entry_maker = function(entry) end,
        }),
    sorter = conf.file_sorter(config), --conf.generic_sorter(config),
    -- replace default action
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        -- close picker
        actions.close(prompt_bufnr)
        -- get selection from state
        local selection = action_state.get_selected_entry()
        -- Apply effect to selected element
        config.effect(selection[1])
      end)
      return true
    end,
  }):find()
end

return M
