local todoCards = {}
local config = require('todo-cards.config')
local mappings = require('todo-cards.mappings')

function todoCards.setup(get_options)
	config.set_defaults(get_options)
end

-- Set default config
config.set_defaults()
-- Apply global keymap
mappings.apply_keymap('global', config.values.mappings.global)

return todoCards
