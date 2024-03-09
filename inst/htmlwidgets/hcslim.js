HTMLWidgets.widget({

  name: 'hcslim',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {

        // TODO: code to render the widget, e.g.
        const div = document.createElement('div')
        div.id = x.id 
        div.innerText = 'This text should be replaced by a Highchart. If you are seeing it, something probably went wrong in your options. Check the JS errors in the console.'

        const script = document.createElement('script')
        script.innerText = x.script

        el.appendChild(div)
        el.appendChild(script)

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});