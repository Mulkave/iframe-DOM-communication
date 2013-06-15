$(document).ready ->
	app = new App $ '.that-iframe'
	app.login {username: 'some.user', password: 'some.pass'}, (profile)->

		console.log 'Got user profile', profile