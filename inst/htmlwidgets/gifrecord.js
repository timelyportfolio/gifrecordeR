HTMLWidgets.widget({

  name: 'gifrecord',

  type: 'output',

  initialize: function(el, width, height) {

    return { };

  },

  renderValue: function(el, x, instance) {
    
    // remove position:relative if standalone which
    //   gives us an parentNode with id = "htmlwidget_container"
    if(el.parentNode.id === "htmlwidget_container"){
      var st = el.parentNode.style;
      st.position = "inherit";
      st.width = '260px';
      st.height = '2.5em';
    }
    

    anigif.initOnce();
    anigif.options.selector = "body";
    anigif.options.base_url = "./lib/gifw00t-0.0.1/"
    anigif.init();
    anigif_bar.install();

  },

  resize: function(el, width, height, instance) {

  }

});
