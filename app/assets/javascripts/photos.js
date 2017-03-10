$(document).ready(function(){
    if ($(".dropzone").length > 0) {
    // disable auto discover
    Dropzone.autoDiscover = false;
    var dropzone = new Dropzone (".dropzone", {
      maxFilesize: 256, // Set the maximum file size to 256 MB
      paramName: "photo[file]", // Rails expects the file upload to be something like model[field_name]
      addRemoveLinks: false // Don't show remove links on dropzone itself.
    });

    dropzone.on("success", function(file) {
      this.removeFile(file)
      $.getScript("/photos")
    })
  }

});