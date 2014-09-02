$(function() {
  if($("body").hasClass("matches_show")) {
    // show appropriate nav bar triangle
    $(".triangles#matches").css("display", "initial")
    // set variables
    var userId = window.userId
    var matchId = window.matchId
    // add event listener for new favorite ajax request
    $(".match-controls").on("click",function(e) { 
      // favorites url delcaration
      var url = "/users/"+userId+"/favorites";
      // prevent default link behavior
      e.preventDefault();
      // delete favorite if it exists
      if($(".star-icon ").hasClass("favorite")) {
        var favoriteId = $(".star-icon").next().data().favoriteId
        $.ajax({
          url: url + "/" + favoriteId,
          type: 'DELETE'
          })
        .done(function(res) {
          // make the star gray
          $(".star-icon").removeClass("favorite");
        })
        // post to favorites if it isn't a favorite
      } else {
        $.post(url, {user_id: userId, match_id: matchId})
        .done(function(res) {
          // make favorite star gold and add favorite Id data attribute
          $(".star-icon").next().data({favoriteId: res.favorite_id});
          $(".star-icon").addClass("favorite");
        })
      }
    }) // end event listener 
  } // end main if statement
}) // end doc ready   


