HTMLWidgets.widget({

  name: 'hcslim',

  type: 'output',

  factory: function(el, width, height) {

    return {

      renderValue: function(x) { 
 
        const div = document.createElement('div')
        div.id = x.id 
        div.classList.add('hcslim')
  
        // to help the plot look good, we'll expand to fill the parent and then center the chart vertically.
        div.style['height'] = '100%'
        div.style['display'] = 'flex'
        div.style['align-items'] = 'center'
  
        // add some helpful text for the user in case of an error. 
        div.innerText = 'This text should be replaced by a Highchart. If you are seeing it, something probably went wrong in your options. Check the JS errors in the console.'
  
        const script = document.createElement('script')
        script.innerText = x.script
  
        el.appendChild(div)
        el.appendChild(script)

      },

      resize: function(width, height) {

        // Highcharts will automatically handle resizing.

      }

    };
  }
});