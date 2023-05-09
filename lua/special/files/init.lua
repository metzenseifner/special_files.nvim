local vim = vim
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

M = {}

M.opts_resolver = function(opts)
  return opts or {
    require("telescope.themes").get_dropdown {},
    src = vim.fn.stdpath("data") .. "/jonathans_special_files",
    cwd_to_path = true,
    effect = function(path)
      vim.cmd("tabedit " .. path)
    end
  }
end

M.list_special_files = function(opts)
  opts = M.opts_resolver(opts)
  pickers.new(opts, {
    prompt_title = "Jonathan's Special Files",
    -- finder = finders.new_oneshot_job({ "find" }, opts ), -- async external process
    --  finder = finders.new_oneshot_job( vim.tbl_flatten({"find ", {vim.fn.stdpath("data")}}), opts),
    finder = require('telescope._extensions.file_browser.finders')
    .browse_files({
      cwd=opts.src,--vim.fn.stdpath"data" .. "/jonathans_special_files",
      depth=1,
      hidden=true,
      --respect_gitignore=false,
      entry_maker = function(entry)end,
    }),
    sorter = conf.file_sorter(opts), --conf.generic_sorter(opts),
    -- replace default action
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        -- close picker
        actions.close(prompt_bufnr)
        -- get selection from state
        local selection = action_state.get_selected_entry()
        -- Apply effect to selected element
        opts.effect(selection[1])
      end)
      return true
    end,
  }):find()
end

return M
