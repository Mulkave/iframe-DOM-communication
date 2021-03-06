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

		original = data?.original
		result   = data?.result

		@[action]?(result, original._subscribed_event)


	perform: (action, data)->
		console.log 'performing', action, 'with', data
		@when_window_loads => @iframe.contentWindow.postMessage "#{action}:#{JSON.stringify(data)}", 'http://localhost:5656/iframe.html'

	login: (data, callback)->

		subscription_event = 'login:complete'

		@subscribe_once subscription_event, callback
		$.extend data, {_callback: 'loginComplete', _subscribed_event: subscription_event}
		@perform 'login', data # .. deal with callback

	loginComplete: (data, event_to_publish)-> @publish event_to_publish, data if event_to_publish?

	when_window_loads: (callback)->
		if document.readyState isnt 'complete' then window.onload = callback else callback?()

	subscribe: (event, callback)->
		console.debug 'subscribing to', event
		$(@).on event, callback

	subscribe_once: (event, callback)->
		@subscribe event, (e, data)=>
			@unsubscribe event
			callback?(data)

	unsubscribe: (event, callback)->
		console.debug 'dropping subscription to', event
		console.log 'events before unsubscribing:', $._data @, 'events'
		$(@).off event, callback
		console.log 'events after unsubscribing:', $._data @, 'events'

	publish: (event, data...)->
		console.log 'publishing', event, 'with', data
		$(@).trigger event, data

window.App = App