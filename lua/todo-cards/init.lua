local todoCards = {}
local config = require('todo-cards.config')
local actions = require('todo-cards.actions')
local api = vim.api

function todoCards.setup(get_options)
	config.set_defaults(get_options)
end

local function apply_keymap (env)
	env = 'global'
	for mode, _ in pairs(config.values.mappings[env]) do
		for mapping, action in pairs(config.values.mappings[env][mode]) do
			local callAction = string.format([[<cmd>lua %s()<cr>]], action)
			print(callAction)
			vim.api.nvim_set_keymap('n', mapping, callAction, {})
		end
	end
end

config.set_defaults()
apply_keymap()

return todoCards
