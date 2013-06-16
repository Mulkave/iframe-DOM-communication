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

				@tell data, profile

	tell: (original_data, data)->
		all = original: original_data, result: data
		parent.postMessage "#{original_data._callback}:#{JSON.stringify(all)}", document.referrer
	login: (data)-> console.log 'should perform logging in with data', data

window.Frame = new Frame