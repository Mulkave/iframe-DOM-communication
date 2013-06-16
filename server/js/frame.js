// Generated by CoffeeScript 1.6.2
(function() {
  var Frame;

  Frame = (function() {
    function Frame() {
      console.debug('Intantiating Frame');
      window.addEventListener('message', $.proxy(this.handleClientMessages, this));
    }

    Frame.prototype.handleClientMessages = function(e) {
      var action, command, data, profile;

      command = e.data.split(/:(.*)/);
      action = command[0];
      data = JSON.parse(command[1]);
      console.log('Frame received message');
      console.debug('action:', action);
      console.debug('data:', data);
      switch (action) {
        case 'login':
          profile = {
            id: '59sdfgujkf8234',
            name: 'Mahatma Gandhi',
            email: 'fast@forever.net'
          };
          return this.tell(data, profile);
      }
    };

    Frame.prototype.tell = function(original_data, data) {
      var all;

      all = {
        original: original_data,
        result: data
      };
      return parent.postMessage("" + original_data._callback + ":" + (JSON.stringify(all)), document.referrer);
    };

    Frame.prototype.login = function(data) {
      return console.log('should perform logging in with data', data);
    };

    return Frame;

  })();

  window.Frame = new Frame;

}).call(this);
