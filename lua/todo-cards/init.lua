local todoCards = {}

function todoCards.setup(callback)
	require('todo-cards.config').set_defaults(callback)
end

return todoCards
