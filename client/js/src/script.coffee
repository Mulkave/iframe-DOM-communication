$(document).ready ->
	app = new App $ '.that-iframe'
	app.login {username: 'some.user', password: 'some.pass'}