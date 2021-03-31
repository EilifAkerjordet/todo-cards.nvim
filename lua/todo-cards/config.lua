-- Keep the values around between reloads
local utils = require('todo-cards.utils')
local actions = require('todo-cards.actions')

_ConfigurationValues = _ConfigurationValues or {}

local config = {}
config.values = _ConfigurationValues

function config.set_defaults (defaults)
	defaults = defaults or {}

  local function set_config_item(name, default_val)
    config.values[name] = utils.first_non_nil(defaults[name], config.values[name], default_val)
  end

	local function set_keymap(env, mode, mapping, default_val)
	  local default_keymap = utils.lookup(defaults, "mappings", env, mode, mapping)
		-- Create config.mappings sub fields of they don't exist
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
	set_config_item('autoclose', 0)
	set_config_item('border', 1)
	set_config_item('topleft_border', '╭')
	set_config_item('topright_border', '╮')
	set_config_item('botleft_border', '╰')
	set_config_item('botright_border', '╯')
	set_config_item('vertical_border', '│')
	set_config_item('horizontal_border', '─')
	-- Default keymap
	set_keymap('global', 'n', '<Localleader>w', 'openwindow')
	set_keymap('buffer', 'n', 'q', actions.closeTodoWindow)

	-- Apply the user defined keymaps that do not exist by default
	-- @TODO
	-- - Check if there are mappings at all in the user object
	-- - If there is, loop over items in buffer and global
	-- - For each found item (mapping), check if that mapping already exists
	-- - If it does, ignore it. If it dosen't, add it.
end

config.set_defaults()

return config
