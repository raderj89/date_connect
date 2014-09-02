// FlashMessage JavaScript object

FlashMessage = {}

// FlashMessage controller instantiated with HTML element

FlashMessage.Controller = function(opts) {
  this.observableSelector = opts.observableSelector;
}

// FlashMessage Controller function that calls desired events on objects
// In this case, I want flash messages to disappear when observableSelector is clicked

FlashMessage.Controller.prototype = {
  initEvents: function() {
  var controller = this;

  $(controller.observableSelector)
    .on('click', function(e) {

      e.preventDefault();
      var $that = $(this);
      controller.removeElement($that.parent());
    })
  },

  removeElement: function(parent) {
    parent.remove();
  }

}

// jQuery

$(function() {
  var flash = new FlashMessage.Controller({
    observableSelector: '.alert > .close'
  }).initEvents();

  var form_flash = new FlashMessage.Controller({
    observableSelector: '#error_explanation > .close'
  }).initEvents();
})