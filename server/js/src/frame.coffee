class Frame

	constructor: ->
		console.debug 'Intantiating Frame'

		window.addEventListener 'message', $.proxy @handleClientMessages, @

	handleClientMessages: (e)->

		command = e.data.split(/:(.*)/)
		action = command[0]
		data   = JSON.parse command[1]

		console.log 'Frame received message'
		console.debug 'action:', action
		console.debug 'data:', data

		switch action
			when 'login'

				profile = {
					id: '59sdfgujkf8234'
					name: 'Mahatma Gandhi'
					email: 'fast@forever.net'
				}

				@tell data.original_callback, profile

	tell: (message, data)-> parent.postMessage "#{message}:#{JSON.stringify(data)}", document.referrer
	login: (data)-> console.log 'should perform logging in with data', data

window.Frame = new Frame