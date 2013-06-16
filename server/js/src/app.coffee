class App

	constructor: (frame_selector)->

		console.log 'instantiation App with frame', $(frame_selector)
		@iframe = $(frame_selector).get 0

		# Populate messages listener
		window.addEventListener 'message', $.proxy @handleFrameMessages, @

	handleFrameMessages: (e)->

		command = e.data.split(/:(.*)/)
		action  = command[0]
		data 	= command[1] || "{}"
		data    = JSON.parse data

		console.log 'App received message', action, data

		switch action
			when 'loginComplete' then @loginComplete data


	perform: (action, data)->
		console.log 'performing', action, 'with', data
		@when_window_loads => @iframe.contentWindow.postMessage "#{action}:#{JSON.stringify(data)}", 'http://localhost:5656/iframe.html'

	login: (data, callback)->
		@subscribe 'login:complete', (e, data)=>
			@unsubscribe 'login:complete', callback
			callback?(data)
		$.extend data, {original_callback: 'loginComplete'}
		@perform 'login', data # .. deal with callback

	loginComplete: (data)-> @publish 'login:complete', data

	when_window_loads: (callback)->
		if document.readyState isnt 'complete' then window.onload = callback else callback?()

	subscribe: (event, callback)->
		console.debug 'subscribing to', event
		$(@).on event, callback

	unsubscribe: (event, callback)->
		console.debug 'dropping subscription to', event
		$(@).off event, callback

	publish: (event, data...)->
		console.log 'publishing', event, 'with', data
		$(@).trigger event, data

window.App = App