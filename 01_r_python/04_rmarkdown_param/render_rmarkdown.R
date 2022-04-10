
library(rmarkdown)



informe <- "rladies_charlas/01_r_python/03_markdown/r_python_parametrizado.Rmd"

render(
    informe,
    params = list(
        param1 = 'Este es un NUEVO parametro'
    )
)


scales::percent_format()

iris = iris


informe = ''

