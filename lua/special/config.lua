-- use global to keep the values around between reloads
_PersistedFiles = _PersistedFiles or {}

local config = {}
config.files = _PersistedFiles

local default_files = {
  src = vim.fn.stdpath("data") .. "/special_files",
  cwd_to_path = true,
  effect = function(path)
    vim.cmd("tabedit " .. path)
  end,
  prompt_title = "Special Files"
}

function config.set_files(files)
  files = vim.F.if_nil(files, {})
  config.files = vim.tbl_deep_extend("keep", files, default_files) --keep leftmost

  for k, v in pairs(files) do
    config.files[k] = v
  end

  return config
end

return config
