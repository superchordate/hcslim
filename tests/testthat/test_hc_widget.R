test_that("simple call", {

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

    expect_equal(class(hc_widget(options)), c('hcslim', 'htmlwidget'))

})

