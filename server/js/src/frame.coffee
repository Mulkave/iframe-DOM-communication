class Frame

	constructor: ->
		console.debug 'Intantiating Frame'

		# window.addEventListener 'message', @handleClientMessages

	@handleClientMessages: (e)->

		command = e.data.split(/:(.*)/)
		action = command[0]
		data   = JSON.parse command[1]

		console.log 'Frame received message', action, data
		switch action
			when 'login' then @login data

	@login: (data)->
		console.log 'should perform logging in with data', data

window.Frame = Frame