class App

	constructor: (frame_selector)->

		console.log 'instantiation App with frame', $(frame_selector)
		@iframe = $(frame_selector).get 0

		# Populate messages listener
		window.addEventListener 'message', @handleFrameMessages, false

	handleFrameMessages: (e)->

		command = e.data.split(/:(.*)/)
		action  = command[0]
		data    = JSON.parse command[1]

		console.log 'App received message', action, data

		switch action
			when 'loginComlete' then @loginComplete data


	perform: (action, data)->
		console.log 'performing', action, 'with', data
		@when_window_loads => @iframe.contentWindow.postMessage "#{action}:#{JSON.stringify(data)}", 'http://localhost:5656/iframe.html'

	login: (data, callback)-> @perform 'login', data # .. deal with callback
	loginComplete: (data)-> console.log 'login complete...'

	when_window_loads: (callback)->
		if document.readyState isnt 'complete' then window.onload = callback else callback?()


window.App = App