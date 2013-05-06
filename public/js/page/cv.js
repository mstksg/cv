var CHECKRATE = 1000;

var ws;
var dirhash = "";

check_change = function() {
  $.post( '/a/dirhash',
      {},
      process_change,
      'json');
}

process_change = function(d) {
  // console.log(d.dirhash);
  if (dirhash != "" && d.dirhash != dirhash) {
    document.location.reload();
  }
  dirhash = d.dirhash;
  setTimeout(check_change,CHECKRATE);
}

$.ajaxSetup({
  error: function() { setTimeout(check_change,CHECKRATE); }
});


$(document).ready(function() {
  // $('h1').fitText();
  if (window.data.watch) {
    check_change();
  }
  // $('#cv-body').responsiveMeasure();
});
