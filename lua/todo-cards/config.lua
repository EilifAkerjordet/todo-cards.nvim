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
	set('topleft_border', '')
end

-- set("borderchars", { '?', '?', '?', '?', '?', '?', '?', '?'})

-- if ! exists('g:floatLf_topleft_border')
--     let g:floatLf_topleft_border = "?"
-- endif
--
-- if ! exists('g:floatLf_topright_border')
--     let g:floatLf_topright_border = "?"
-- endif
--
-- if ! exists('g:floatLf_botleft_border')
--     let g:floatLf_botleft_border = "?"
-- endif
--
-- if ! exists('g:floatLf_botright_border')
--     let g:floatLf_botright_border = "?"
-- endif
--
-- if ! exists('g:floatLf_vertical_border')
--     let g:floatLf_vertical_border = "?"
-- endif
--
-- if ! exists('g:floatLf_horizontal_border')
--     let g:floatLf_horizontal_border = "?"
-- endif

config.set_defaults()

return config
