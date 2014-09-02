function open(elem) {
  if (document.createEvent) {
      var e = document.createEvent("MouseEvents");
      e.initMouseEvent("mousedown", true, true, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
      elem[0].dispatchEvent(e);
  } else if (element.fireEvent) {
      elem[0].fireEvent("onmousedown");
  }
}

// User preferences select actions

$(function() {
  if($("body").hasClass("users_edit")) {
    $('.select-arrow').on('click', function(e) {
      e.preventDefault();
      open($(this).next().find('.match-select'));  
    })
  }
})


