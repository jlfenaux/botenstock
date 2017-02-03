# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready =>
  $('#bots-category,#bots-platform,#bots-keywords').on 'change', =>
    console.log $('#bots-category').val()
    search = "?category=#{$('#bots-category').val()}&platform=#{$('#bots-platform').val()}&keywords=#{$('#bots-keywords').val()}"
    window.location.search = search
