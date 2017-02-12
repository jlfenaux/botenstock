$(document).ready =>
  document.addEventListener "turbolinks:load", =>
    $('#post_body').bind 'input propertychange', =>
      $.post "/posts/preview",
        preview_text: $("#post_body").val(),
        (response) ->
          $('#post_preview').html(response)