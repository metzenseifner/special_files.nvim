-- use global to keep the values around between reloads
_SpecialConfigValues = _SpecialConfigValues or {}

local config = {}

config.values = _SpecialConfigValues

function config.set_files(files)
  files = vim.F.if_nil(files, {})

  for k,v in pairs(files) do
    config.files[k] = v
  end
end

return config
