-- Keep the values around between reloads
_ConfigurationValues = _ConfigurationValues or {}

local function first_non_nil(...)
  local n = select('#', ...)
  for i = 1, n do
    local value = select(i, ...)

    if value ~= nil then
      return value
    end
  end
end

local config = {}
config.values = _ConfigurationValues

function config.set_defaults (defaults)
	defaults = defaults or {}

  local function get(name, default_val)
    return first_non_nil(defaults[name], config.values[name], default_val)
  end

  local function set(name, default_val)
    config.values[name] = get(name, default_val)
  end

	-- Default values
	set('autoclose', 0)
	set('border', 1)
	set('topleft_border', '╭')
	set('topright_border', '╮')
	set('botleft_border', '╰')
	set('botright_border', '╯')
	set('vertical_border', '│')
	set('horizontal_border', '─')

	set("mappings", {})
end

config.set_defaults()

return config
