
library(rmarkdown)

informe <- "rladies_charlas/01_r_python/04_rmarkdown_param/04_r_python_parametrizado.Rmd"

render(
    informe,
    params = list(
        descripcion = 'Modelo considerando lunch, income y cawork',
        var1 = 'income',
        var2 = 'lunch',
        var3 = 'calworks'
    )
)
