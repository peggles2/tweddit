$(function() {
  
  $('[data-toggle="popover"]').popover()
  
  $('.delete_tweet').click(function (){
    id = $(this).parent().find('.tweet_id').val()
    url = "/tweet/" + id
    $.ajax({
           type: "POST",
           url: url,
           dataType: "json",
           data: {"_method":"delete"},
           complete: function(){
               location.reload("/");
           }
    });
  });
  $('.vote_up').click(function(e){
    e.preventDefault(); 
    id = $(this).closest('.tweet_container').find('.tweet_id').val()
    url = "/tweet/vote/up/" + id
    $.ajax({
           type: "POST",
           url: url,
           dataType: "json",
           data: {"_method":"post"},
           complete: function(){
               location.reload("/");
           }
    });
  });
  $('.vote_down').click(function(e){
    e.preventDefault();
    id = $(this).closest('.tweet_container').find('.tweet_id').val()
    url = "/tweet/vote/down/" + id
    $.ajax({
           type: "POST",
           url: url,
           dataType: "json",
           data: {"_method":"post"},
           complete: function(){
               location.reload("/");
           }
       });
  });
  
});