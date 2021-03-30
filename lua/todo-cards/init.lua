local actions = require('todo-cards.actions')
local mappings = require('todo-cards.mappings')
local todoCards = {}

function todoCards.setup(opts)
	opts = opts or {}
	require('todo-cards.config').set_defaults(opts.defaults)
end

todoCards.actions = actions
todoCards.mappings = mappings
return todoCards
