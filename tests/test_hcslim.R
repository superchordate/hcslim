#TODO update these tests so they are not in package format. 

# test that code runs and outputs the expected class.
expect_equal(
    class(hchtml( 'testchart', list(
        chart = list(type = 'line'),
        title = list(text = 'Random Numbers'),
        xAxis = list(
            categories = c('Jan', 'Feb', 'Mar')
        ),
        yAxis = list(
            title= list(
                text = 'Temperature (°C)'
            )
        ),
        plotOptions = list(
            line = list(dataLabels = list(enabled = TRUE), enableMouseTracking = FALSE)
        ),
        series = list(
            list(
            name = 'Tokyo',
            data = c(1, 2, 3)
            ),
            list(
            name = 'London',
            data = c(1, 2, 3)
            )
        )
    ))),
    c('html', 'character')
)

# test that expect_equal runs.
expect_equal(
    class(usecode('highcharts')[[1]]),
    c('html', 'character')
)

# single-valued vectors for data and categories.

    options = list(
        chart = list(type = 'line'),
        title = list(text = 'Some Numbers'),
        yAxis = list(title = list(text = '123456')),
        xAxis = list(
            type = 'categorical',
            categories = c(1)
        ),
        series = list(
            list(name = '123', data = c(1)),
            list(name = '456', data = c(1))
        )
    )
    expect_equal(
        as.character(hchtml('testchart', options, pretty = FALSE)),
        "<script>Highcharts.chart('testchart', {\"chart\":{\"type\":\"line\"},\"title\":{\"text\":\"Some Numbers\"},\"yAxis\":{\"title\":{\"text\":\"123456\"}},\"xAxis\":{\"type\":\"categorical\",\"categories\": [1]},\"series\":[{\"name\":\"123\",\"data\": [1]},{\"name\":\"456\",\"data\": [1]}]});</script>"
    )

    options$xAxis$categories = 'hello'
    expect_equal(
        as.character(hchtml('testchart', options, pretty = FALSE)),
        "<script>Highcharts.chart('testchart', {\"chart\":{\"type\":\"line\"},\"title\":{\"text\":\"Some Numbers\"},\"yAxis\":{\"title\":{\"text\":\"123456\"}},\"xAxis\":{\"type\":\"categorical\",\"categories\": [\"hello\"]},\"series\":[{\"name\":\"123\",\"data\": [1]},{\"name\":\"456\",\"data\": [1]}]});</script>"
    )
    
    options$xAxis$categories = c('hello1', 'hello2')
    expect_equal(
        as.character(hchtml('testchart', options, pretty = FALSE)),
        "<script>Highcharts.chart('testchart', {\"chart\":{\"type\":\"line\"},\"title\":{\"text\":\"Some Numbers\"},\"yAxis\":{\"title\":{\"text\":\"123456\"}},\"xAxis\":{\"type\":\"categorical\",\"categories\":[\"hello1\",\"hello2\"]},\"series\":[{\"name\":\"123\",\"data\": [1]},{\"name\":\"456\",\"data\": [1]}]});</script>"
    )
    
    options$series[[1]]$data = 1:2
    expect_equal(
      as.character(hchtml('testchart', options, pretty = FALSE)),
      "<script>Highcharts.chart('testchart', {\"chart\":{\"type\":\"line\"},\"title\":{\"text\":\"Some Numbers\"},\"yAxis\":{\"title\":{\"text\":\"123456\"}},\"xAxis\":{\"type\":\"categorical\",\"categories\":[\"hello1\",\"hello2\"]},\"series\":[{\"name\":\"123\",\"data\":[1,2]},{\"name\":\"456\",\"data\": [1]}]});</script>"
    )
    
    options$series[[2]]$data = 1:2
    expect_equal(
      as.character(hchtml('testchart', options, pretty = FALSE)),
      "<script>Highcharts.chart('testchart', {\"chart\":{\"type\":\"line\"},\"title\":{\"text\":\"Some Numbers\"},\"yAxis\":{\"title\":{\"text\":\"123456\"}},\"xAxis\":{\"type\":\"categorical\",\"categories\":[\"hello1\",\"hello2\"]},\"series\":[{\"name\":\"123\",\"data\":[1,2]},{\"name\":\"456\",\"data\":[1,2]}]});</script>"
    )

    options = list(
        chart = list(type = 'column'),
        title = list(
            text = "iris"
        ),
        xAxis = list(
            categories = c("setosa", "versicolor", "virginica"),
            title = list(text = "Species")
        ),
        yAxis = list(
            title = list(text = "Sepal.Length")
        ),
        series = list(list(
            name = "Mean Sepal.Length",
            data =  c(5.006, 5.936, 6.588)
        ))
    )
    expect_equal(
      as.character(hchtml('testchart', options, pretty = TRUE)),
      "<script>Highcharts.chart('testchart', {\n  \"chart\": {\n    \"type\": \"column\"\n  },\n  \"title\": {\n    \"text\": \"iris\"\n  },\n  \"xAxis\": {\n    \"categories\": [\"setosa\", \"versicolor\", \"virginica\"],\n    \"title\": {\n      \"text\": \"Species\"\n    }\n  },\n  \"yAxis\": {\n    \"title\": {\n      \"text\": \"Sepal.Length\"\n    }\n  },\n  \"series\": [\n    {\n      \"name\": \"Mean Sepal.Length\",\n      \"data\": [5.006, 5.936, 6.588]\n    }\n  ]\n});</script>"
    )
