# Slim Highcharts for R and R Shiny

Highcharter and htmlWidgets add many failure points between processing in R and plotting with Highcharts. 

`hcslim` provides minimal HTML-based functions for creating plots in accordance with the Highcharts API. This allows easier use of Highcharts documentation and forums - and less time spent fighting Highcharter!

* [Highcharts](#highcharts)
* [Philosophy](#philosophy)
* [Installation](#installation)
* [Usage](#usage)
* [Converting Highcharter-based Apps](#converting-highcharter-based-apps)
* [Troubleshooting](#troubleshooting)
* [Contributions](#contributions)

## About Me

I'm an independent contractor helping companies build custom cloud apps and leverage data science, visual analytics, and AI. I offer low introductory rates, free consultation and estimates, and no minimums, so contact me today and let's chat about how I can help!

https://www.bryce-chamberlain.com/

## Highcharts

Highcharts may require a paid license. Special consideration is given for personal (non-commercial) use, schools, and non-profit organizations. Get more information at https://www.highcharts.com.

## Philosophy

hcslim takes a **web-first approach**: instead of pre-packaging all the HTML and JS in a widget, it provides tools for building out a website that can connect to these resources. This requires a bit of knowledge about web development in addition to R. But let's be real: R Shiny developers need to know how websites work. [w3schools](https://www.w3schools.com/) is a great resource if you would like to learn more.

This approach has benefits:

* Gives developers flexibility to optimize applications and choose specific highcharts versions and modules.
* Simplifies design by removing unnecessary R-based abstractions.
* Directly aligns with the highcharts documentation and forums. These are are fully mature, compared to Highcharter which has very little documentation or forum posts.

I presented on hcslim at Appsilon's conference where I go into this in depth. You can see that on [YouTube](https://www.youtube.com/watch?v=wDGEdiyDKac).

## Installation

I had this set up as a package, but realized it's better to just have R files that can be slotted into a project. This code is actually pretty simple so packaging it is overkill. I've also found that shinyapps.io does not like packages that aren't on CRAN, and I haven't found time to get this code CRAN-ready. Avoiding a package also makes it easier to customize.

This means a bit more setup, but I think it'll be worth it in the long run. 

To use the code, download the files from `main/` (and `supplemental/` if you need them) into your project and import them with `source(file, local = TRUE)`. See the `examples/` folder for more concrete examples. 

I also suggest putting `examples/www/highcharts-defaults.js` into your project and importing it with `<script src=...></script>` (see examples) since this is a much better way to get consistently good-looking charts with minimal effort.

## Usage

Highcharts examples can be found at https://www.highcharts.com/demo. If you click through you will find JS Fiddle examples that contain everything you need to build a chart, including JS libraries. Once you find one of these, it can be replicated easily with `hcslim`.

We'll look specifically at [this example](https://jsfiddle.net/gh/get/library/pure/highcharts/highcharts/tree/master/samples/highcharts/demo/line-labels/).

The HTML code for this chart looks like:

```html
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

<figure class="highcharts-figure">
    <div id="container"></div>
</figure>
```

And Javascript:

```js
Highcharts.chart('container', {
    chart: {
        type: 'line'
    },
    title: {
        text: 'Monthly Average Temperature'
    },
    subtitle: {
        text: 'Source: WorldClimate.com'
    },
    xAxis: {
        categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
    },
    yAxis: {
        title: {
            text: 'Temperature (°C)'
        }
    },
    plotOptions: {
        line: {
            dataLabels: {
                enabled: true
            },
            enableMouseTracking: false
        }
    },
    series: [{
        name: 'Tokyo',
        data: [7.0, 6.9, 9.5, 14.5, 18.4, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
    }, {
        name: 'London',
        data: [3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8]
    }]
});
```

To build this chart in a R Shiny app with hcslim, here is your `app.R`:

```R
require(shiny)
require(dplyr)
require(magrittr)

# read main files. 
for(file in list.files('main', full.names = TRUE)) source(file, local = TRUE)

shinyApp(
    
  ui = basicPage(
    hc_use(),    
    uiOutput('testchart')  
  ),

  server = function(input, output) {

    output$testchart = renderUI({ hc_html('testchart', list(
        chart = list(type = 'line'),
        title = list(text = 'Monthly Average Temperature'),
        subtitle = list(text = 'Source = WorldClimate.com'),
        xAxis = list(
            categories = c('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')
        ),
        yAxis = list(
            title = list(
                text = 'Temperature (°C)'
            )
        ),
        plotOptions = list(
            line = list(dataLabels = list(enabled = TRUE), enableMouseTracking = FALSE)
        ),
        series = list(
          list(
            name = 'Tokyo',
            data = c(7.0, 6.9, 9.5, 14.5, 18.4, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6)
          ),
          list(
            name = 'London',
            data = c(3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8)
          )
        )
      ))
      
    })

})
```

This is a very simple example. See `examples/app.R` for more complicated/realistic examples.

See `examples/RStudio.R` for an example using hcslim outside of an R Shiny app, for example in R Studio or Quarto. *hc_view will import the Highcharts JS files every time it is used, so you may want to customize it if you plan to use it a lot.*

**hc_markjs**

When converting your options to JSON, hcslim needs to know what parts are Javascript, otherwise it'll surround your javascript with quotes and it won't run as code. 

This is where the hc_markjs function comes in. 

Here is an example using https://jsfiddle.net/gh/get/library/pure/highcharts/highcharts/tree/master/samples/highcharts/xaxis/labels-formatter-extended/:

*When using hc_markjs, open/close your characters with " instead of '. If you have " inside a markjs argment you might get the Javascript error `invalid escape sequence`.*

Note the JS used for the xAxis `formatter`.

```html
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>

<div id="container"></div>
```

```js
Highcharts.chart('container', {

    title: {
        text: 'Demo of reusing but modifying default X axis label formatter'
    },

    subtitle: {
        text: 'X axis labels should have thousands separators'
    },

    xAxis: {
        labels: {
            formatter: function () {
                var label = this.axis.defaultLabelFormatter.call(this);

                // Use thousands separator for four-digit numbers too
                if (/^[0-9]{4}$/.test(label)) {
                    return Highcharts.numberFormat(this.value, 0);
                }
                return label;
            }
        }
    },

    series: [{
        data: [29.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4],
        pointStart: 9000,
        type: 'column'
    }]

});
```

In hcslim:

```R
require(shiny)
require(hcslim)
shinyApp(
    
  ui = basicPage(
        #jquery is already loaded by Shiny.
        hc_use(),    
        uiOutput('testchart')
  ),

  server = function(input, output) {

    output$testchart = renderUI({ hc_html( 'testchart', list(
        title = list(text = 'Demo of reusing but modifying default X axis label formatter'),
        subtitle = list(text = 'X axis labels should have thousands separators'),
        xAxis = list(
            labels = list(formatter = hc_markjs(" 
                function () {
                    var label = this.axis.defaultLabelFormatter.call(this);

                    // Use thousands separator for four-digit numbers too
                    if (/^[0-9]{4}$/.test(label)) {
                        return Highcharts.numberFormat(this.value, 0);
                    }
                    return label;
                }
            "))
        ),
        series = list(
          list(
            data = [29.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4],
            pointStart = 9000,
            type = 'column'
          )
        )
      ))
      
    })

})
```


## Troubleshooting

If there are no R errors and the charts aren't showing, use the browser JavaScript console to check for JavaScript errors. Sometimes there will be Highcharts errors that will give you a hint as to what is wrong.

If there are no Highcharts JS errors, but you do see other JS errors, it might be a JavaScript syntax issue in the code output by hcslim. Use the `printjson = TRUE` argument for `hc_html` to print the output JSON to the R console. Review it to see if anything looks off. If you are familiar with JavaScript , you can probably find the issue by visually scanning the output.

You can also paste this JSON into a JS Fiddle example for the chart type you are working with For example, if it's a treemap then I google `highcharts jsfiddle treemap`, access the fiddle, and replace the options object `{type: "treemap", ...}` with the console output. Then tweak the options to find out what fixes the chart.

Common errors:

* Not marking JavaScript code like `hc_markjs("some js")`.
* Invalid escape sequence: when using markjs, open/close your characters with " instead of '. If you have " inside a markjs argment you might get the `invalid escape sequence` Javascript error.
* Not having the JS files you need. Pay attention to JSFiddle examples to see what JS files they import and either include these in your project or add them with `hc_use()`, in the correct order. Order is really important with Highcharts code modules.
* If you are using direct .js files instead of `hc_use()`, which I do recommend for complex apps, your files need to be in a folder structure that matches JSFiddles. For example, if the JS fiddle reference is https://code.highcharts.com/modules/exporting.js then you need to save this file into the modules/ folder relative to the location of highcharts.js.

## Converting Highcharter-based Apps

While it is smart to start new apps using the format above, it may be very difficult to convert existing apps. For this reason, functions have been included to make switching from Highcharter easier. To use these, read in the `supplemental/hc_highcharter.R` file and remove Highcharter. Most functions have been replaced such that they will directly work, **except for renderHighchart()**. Where as before you would have used:

```R
renderHighchart({
    # code to build chart here (including series data).
})
```

You now need to give the chart id followed by a function that builds the options list, similar to:

```R
renderHighchart('mychart', function(){
    # code to build options here (including series data).
})
```

## Contributions

Please consider making a Pull Request if you end up improving or expanding this code!

