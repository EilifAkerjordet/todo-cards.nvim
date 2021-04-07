-- Keep the values around between reloads
local utils = require('todo-cards.utils')
local actions = require('todo-cards.actions')

_ConfigurationValues = _ConfigurationValues or {}

local config = {}
config.values = _ConfigurationValues

function config.set_defaults (get_options)
	local defaults = {}
	if get_options then defaults = get_options(actions).defaults end

  local function set_config_item(name, default_val)
    config.values[name] = utils.first_non_nil(defaults[name], config.values[name], default_val)
  end

	local function set_keymap(env, mode, mapping, default_val)
	  local default_keymap = utils.lookup(defaults, "mappings", env, mode, mapping)
		-- Create config.mappings sub fields if they don't exist
		if not config.values["mappings"] then config.values["mappings"] = {} end
		if not config.values["mappings"][env] then config.values["mappings"][env] = {} end
		if not config.values["mappings"][env][mode] then config.values["mappings"][env][mode] = {} end

		-- If there are two mappings of the same key, prefer the user setting
		config.values.mappings[env][mode][mapping] = utils.first_non_nil(
		  default_keymap,
			config.values.mappings[env][mode][mapping],
			default_val)
	end

	-- Default values
	set_config_item('border', 1)
	set_config_item('window_dimensions', { height = 0.89, width = 0.89 }) -- percentage
	set_config_item('view_split_ratio', 0.75) -- percentage
	set_config_item('borderchars', { '─', '│', '─', '│', '╭', '╮', '╯', '╰'})
	set_config_item('topleft_border', '╭')
	set_config_item('topright_border', '╮')
	set_config_item('botleft_border', '╰')
	set_config_item('botright_border', '╯')
	set_config_item('vertical_border', '│')
	set_config_item('horizontal_border', '─')
	-- Default keymap
	set_keymap('global', 'n', '<Localleader>w', actions.open_todo_window)
	set_keymap('buffer', 'n', 'q', actions.close_todo_window)

	-- Set the user defined keymaps that do not exist by default
	if utils.lookup(defaults, "mappings") then
		for env, _ in pairs(defaults.mappings) do
			for mode, _ in pairs(defaults.mappings[env]) do
				for binding, action in pairs(defaults.mappings[env][mode]) do
					if not utils.lookup(config.values.mappings, env) then config.values.mappings[env] = {} end
					if not utils.lookup(config.values.mappings, env, mode) then config.values.mappings[env][mode] = {} end
					if not utils.lookup(config.values.mappings, env, mode, binding) then
						config.values.mappings[env][mode][binding] = action
					end
				end
			end
		end
	end
end

return config
