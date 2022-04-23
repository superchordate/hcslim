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

