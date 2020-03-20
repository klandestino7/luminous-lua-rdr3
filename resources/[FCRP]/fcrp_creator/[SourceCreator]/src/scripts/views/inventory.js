import Vue from 'vue/dist/vue.common';

class Inventory {
  constructor() { 
    if (window.location.href.indexOf('inventory') > -1) {
      this.initScript();
    }
  }

  initScript() {
    window.vm = new Vue({
      el: "#sinventory",
      data: {
        hoveringDivinity: [],
        hoveringNormal: [],
        showInventory: true,
        items: [ 
        ],
        tiltOptions: {
          reverse:            true  ,  // reverse the tilt direction
          max:                15,     // max tilt rotation (degrees)
          startX:                 0,      // the starting tilt on the X axis, in degrees.
          startY:                 0,      // the starting tilt on the Y axis, in degrees.
          transition:         true,   // Set a transition on enter/exit.
          axis:               "x",   // What axis should be disabled. Can be X or Y.
        },
      },
      methods: {    
        emitItens: function (listitens) {
          this.items = null;
          this.items = listitens;
          this.showInventory = true;
        },
        closeInventory: function () {
          this.showInventory = false;
          $.post("http://fcrp_inventory/NUIFocusOff", JSON.stringify({}));
        }        
      },
      mounted() {
      },
      created() { 
      }
    });
  }
}
window.addEventListener('message', function (event) {
  switch (event.data.action) {
    case "clearPrimary":
      if (event.data.primaryItems) {
        console.log(event.data.primaryItems)
        window.vm.emitItens(event.data.primaryItems);
      } else {
        window.vm.emitItens([]);
      }
      break;
  }
}); 

$(document).ready(function() {
  $(document).keydown(function(event) {
      if (event.which == 27) { // ES     s
          window.vm.closeInventory();      }
  });
});


export default Inventory;