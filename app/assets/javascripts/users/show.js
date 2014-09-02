$(function() {
  if($("body").hasClass("users_show")) {
    // show appropriate nav bar triangle
    $(".triangles#matches").css("display", "initial");
    // check the status of the user's current job - render results on finish
    var matchesListContainer = $('.matches-list-container .match');
    var user_id = userId;

    // add match click event listener to launch facebook page

    $('.matches-list-container').on("click", '.match', function(e) {
      match = $(this);
      url = $(match).find(".name a");
      console.log([match, url])
      url[0].click();
    })

    // performs a get request to the 'users#render_matches' action
    // passing in user ID. If the response is 'still processing', it renders that on the page
    // otherwise, it renders the partial of the top matches returned from the controller

    var getMatches = function() {
      $.get('/render_matches', {id: user_id})
        .done(function(resp) {
          $('.matches-list-container').empty();
          if(resp.split(" ")[0] == 'Searched') {
            $('.matches-list-container').empty().append('<div class="load-status">' + resp + '</div>').fadeIn('slow');
          } else {
            $('.matches-list-container').empty().append(resp);
            clearInterval(render);
          }
        })
    }
    // calls the getMatches function every 3 seconds
    var render = window.setInterval(getMatches, 3000);    
  } // end main if statement

}) // end doc ready
