// For more information see: http://emberjs.com/guides/routing/

App.Router.map(function() {
  this.route('login');
  this.resource('registration', function() {
    this.route('new');
  })
});
