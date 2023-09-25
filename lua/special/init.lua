
local special = {}

special.setup = function(opts)
  opts = special.opts_resolver(opts)
  require("telescope.themes").get_dropdown {}
  require('special.files').setup(opts.files)
end

-- Abstraction between input and usage
-- to allow for validation, transformation, backwards capatibility layer,
-- embellish config, add features that are not yet exposed.
--
-- Usage:
-- <code>
-- require('special').setup({
--   -- files = {
--   --   base_dir = vim.fn.stdpath("data") .. "/value"
--   -- }
-- })
-- </code>
special.opts_resolver = function(opts)
  return opts or {
    files = {
      base_dir = vim.fn.stdpath("data") .. "/special_files",
      prompt_title = "Special Files"
    },
    cwd_to_path = true,
    effect = function(path)
      vim.cmd("tabedit " .. path)
    end
  }
end

return special
