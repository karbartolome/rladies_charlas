
# Renderizar un Rmarkdown parametrizado, dejando un registro de los parametros utilizados

# Se define el path del informe a renderizar
informe <- "rladies_charlas/01_r_python/05_rmarkdown_param/05_r_python_parametrizado.Rmd"
informe <- "05_rmarkdown_param/05_r_python_parametrizado.Rmd"


# Se utiliza la función render 
rmarkdown::render(
    informe,
    params = list(
        descripcion = 'Modelo considerando lunch, income y cawork',
        var1 = 'income',
        var2 = 'lunch',
        var3 = 'calworks'
    )
)
