// For more information see: http://emberjs.com/guides/routing/

App.Router.map(function() {
  this.route('login');
  this.route('logout');
  this.resource('registration', function() {
    this.route('new');
  })
});
