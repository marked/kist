  function reDate() {
    var dates = document.getElementsByClassName('hexDate');
    for (var i=0; i < dates.length; i++) {
      var hdnode =  dates[i];
      var hd = '0x' + hdnode.textContent;
      var d = new Date(hd*1000);
      hdnode.parentNode.innerHTML = hdnode.parentNode.innerHTML + formatDate(d);
    }
  }

  function formatDate(d) {
    var dow = [ 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][d.getDay()];
    var ds = [ pad(d.getMonth() + 1), pad(d.getDate()), d.getYear() + 1900 ].join('/');
    var ts = [ d.getHours(), d.getMinutes(), d.getSeconds() ].map(pad).join(':');

    return [ dow, ds, ts ].join('&nbsp;');
  }

  function pad(i) {
    return ("0" + i).slice(-2);
  }
