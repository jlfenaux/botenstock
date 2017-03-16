# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready =>
  $('#bots-category,#bots-platform,#bots-status,#bots-keywords').on 'change', =>
    search = "?category=#{$('#bots-category').val()}&platform=#{$('#bots-platform').val()}&status=#{$('#bots-status').val()}&keywords=#{$('#bots-keywords').val()}"
    window.location.search = search
