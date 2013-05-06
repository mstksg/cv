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
  setTimeout(check_change,3000);
}

check_change();
