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
  setTimeout(check_change,1000);
}

check_change();

// startw = function() {
//   ws            = new WebSocket('ws://' + window.location.host + '/sockets/watch');
//   ws.onopen     = function() { check_changes(); };
//   ws.onmessage  = function(m) { document.location.reload(); };
//   ws.onclose    = function() { setTimeout(startw,1000) };
//   ws.onerror    = function() { setTimeout(startw,1000) };
// }

// check_changes = function() {
//   ws.send('1');
//   setTimeout(check_changes,1000);
// }

// startw();

// $('#cv-body').responsiveMeasure({
//   idealLineLength: 66,
//   ratio: 4/3,
//   minimumFontSize: 12,
//   maximumFontSize: 300,
//   sampleText: "n"
// });

