HTMLWidgets.widget({

  name: 'gifrecord',

  type: 'output',

  initialize: function(el, width, height) {

    return {
      // TODO: add instance fields as required
    }

  },

  renderValue: function(el, x, instance) {

    anigif.initOnce();
    anigif.options.selector = "body";
    anigif.options.base_url = "./lib/gifw00t-0.0.1/"
    anigif.init();
    anigif_bar.install();

  },

  resize: function(el, width, height, instance) {

  }

});
