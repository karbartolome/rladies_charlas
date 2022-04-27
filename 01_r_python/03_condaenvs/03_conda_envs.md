R y python - Rladies
================
2022-04-09

# 1. Conda environments

[Documentación de
conda](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html)

# 2. Librerías

``` r
#install.packages('reticulate')
library(reticulate)
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

Se utiliza {reticulate} para instalar miniconda con:

``` r
reticulate::install_miniconda()
```

Se visualiza la configuración de python:

``` r
reticulate::py_config()
```

Se crea un nuevo conda environment, estableciendo la versión de python a
utilizar:

``` r
reticulate::conda_create('rladies-env', 
      # En este caso, versión de python que tenemos en RStudio cloud:
                         python_version = '3.8.13' 
                         )
```

# 3. Conda desde la terminal / instalación de paquetes

Para poder ejecutar comandos desde la terminal es necesario ejecutar lo
siguiente. Copiar el output del chunk siguiente y pegar en la terminal.

``` r
condash <- paste0(
  'source ',
   gsub('C:','',reticulate::miniconda_path()),
   '/etc/profile.d/conda.sh')

condash
```

    ## [1] "source /Users/karin/AppData/Local/r-miniconda/etc/profile.d/conda.sh"

-   Se activa el environment creado:

conda activate rladies-env

-   Se listan los environments, visualizando que está seleccionado el
    correcto:

conda env list

-   Se instalan paquetes para probar que funciona correctamente

conda install -c conda-forge numpy

conda install -c conda-forge pandas

conda install -c conda-forge scikit-learn

# 4. Configuración del environment en Rmarkdown

Es necesario realizar un restart y luego configurar el env a utilizar.
Esto es asì porque al ejecutar algunas cosas python antes quedó
configurada otra versión.

``` r
reticulate::use_condaenv(condaenv = 'rladies-env',  
                         required = TRUE)
```

Se importan las librerías python instaladas mediante conda en el
environment creado:

``` python
import re
import numpy as np
import pandas as pd
```

# 5. Crear un .yml de los requerimientos del conda env

conda env export –name rladies-env \> rladies_requirements.yml

Guarda el .yml en el path de getwd()

``` r
env_req <- base::system('conda list -n rladies-env', 
             intern =  TRUE)
```

``` python
data = r.env_req

def get_words(line): return re.findall("[^\s]+",line)
words = [get_words(x) for x in data[3:-1]]

requirements =  pd.DataFrame({
  'Paquete': [i[0] for i in words], 
  'Versión': [i[1] for i in words],
  'Channel': [i[3] if len(i)==4 else '' for i in words]})
```

    ##                    Paquete            Versión     Channel
    ## 1                   brotli              1.0.9 conda-forge
    ## 2               brotli-bin              1.0.9 conda-forge
    ## 3                    bzip2              1.0.8 conda-forge
    ## 4          ca-certificates          2021.10.8 conda-forge
    ## 5                  certifi          2021.10.8 conda-forge
    ## 6                   cycler             0.11.0 conda-forge
    ## 7                fonttools             4.32.0 conda-forge
    ## 8                 freetype             2.10.4 conda-forge
    ## 9             intel-openmp           2022.0.0 conda-forge
    ## 10                    jbig                2.1 conda-forge
    ## 11                    jpeg                 9e conda-forge
    ## 12              kiwisolver              1.4.2 conda-forge
    ## 13                   lcms2               2.12 conda-forge
    ## 14                    lerc                3.0 conda-forge
    ## 15                 libblas              3.9.0 conda-forge
    ## 16         libbrotlicommon              1.0.9 conda-forge
    ## 17            libbrotlidec              1.0.9 conda-forge
    ## 18            libbrotlienc              1.0.9 conda-forge
    ## 19                libcblas              3.9.0 conda-forge
    ## 20              libdeflate               1.10 conda-forge
    ## 21                  libffi              3.4.2 conda-forge
    ## 22               liblapack              3.9.0 conda-forge
    ## 23                  libpng             1.6.37 conda-forge
    ## 24                 libtiff              4.3.0 conda-forge
    ## 25                 libwebp              1.2.2 conda-forge
    ## 26            libwebp-base              1.2.2 conda-forge
    ## 27                  libxcb               1.13 conda-forge
    ## 28                 libzlib             1.2.11 conda-forge
    ## 29                   lz4-c              1.9.3 conda-forge
    ## 30   m2w64-gcc-libgfortran              5.3.0 conda-forge
    ## 31          m2w64-gcc-libs              5.3.0 conda-forge
    ## 32     m2w64-gcc-libs-core              5.3.0 conda-forge
    ## 33               m2w64-gmp              6.1.0 conda-forge
    ## 34 m2w64-libwinpthread-git 5.0.0.4634.697f757 conda-forge
    ## 35         matplotlib-base              3.5.1 conda-forge
    ## 36                     mkl           2022.0.0 conda-forge
    ## 37       msys2-conda-epoch           20160418 conda-forge
    ## 38                 munkres              1.1.4 conda-forge
    ## 39                   numpy             1.22.3 conda-forge
    ## 40                openjpeg              2.4.0 conda-forge
    ## 41                 openssl              3.0.2 conda-forge
    ## 42               packaging               21.3 conda-forge
    ## 43                  pandas              1.4.2 conda-forge
    ## 44                   patsy              0.5.2 conda-forge
    ## 45                  pillow              9.1.0 conda-forge
    ## 46                     pip             22.0.4 conda-forge
    ## 47           pthread-stubs                0.4 conda-forge
    ## 48               pyparsing              3.0.8 conda-forge
    ## 49                  python             3.8.13 conda-forge
    ## 50         python-dateutil              2.8.2 conda-forge
    ## 51              python_abi                3.8 conda-forge
    ## 52                    pytz             2022.1 conda-forge
    ## 53                   scipy              1.8.0 conda-forge
    ## 54                 seaborn             0.11.2 conda-forge
    ## 55            seaborn-base             0.11.2 conda-forge
    ## 56              setuptools             62.0.0 conda-forge
    ## 57                     six             1.16.0 conda-forge
    ## 58                  sqlite             3.37.1 conda-forge
    ## 59             statsmodels             0.13.2 conda-forge
    ## 60                     tbb           2021.5.0 conda-forge
    ## 61                      tk             8.6.12 conda-forge
    ## 62                    ucrt       10.0.20348.0 conda-forge
    ## 63            unicodedata2             14.0.0 conda-forge
    ## 64                      vc               14.2 conda-forge
    ## 65          vs2015_runtime        14.29.30037 conda-forge
    ## 66                   wheel             0.37.1 conda-forge
    ## 67             xorg-libxau              1.0.9 conda-forge
    ## 68           xorg-libxdmcp              1.1.3 conda-forge
    ## 69                      xz              5.2.5 conda-forge
    ## 70                    zlib             1.2.11 conda-forge

# 6. Uso del conda environment creado

Se crea un df en un chunk R:

``` r
df = iris
```

Se convierte a pandas df, visualizando el resúmen de las variables:

``` python
df_pandas = r.df

df_pandas.describe().transpose()
```

    ##               count      mean       std  min  25%   50%  75%  max
    ## Sepal.Length  150.0  5.843333  0.828066  4.3  5.1  5.80  6.4  7.9
    ## Sepal.Width   150.0  3.057333  0.435866  2.0  2.8  3.00  3.3  4.4
    ## Petal.Length  150.0  3.758000  1.765298  1.0  1.6  4.35  5.1  6.9
    ## Petal.Width   150.0  1.199333  0.762238  0.1  0.3  1.30  1.8  2.5

# 6. Eliminar el conda environment creado:

Post restart tal vez es necesario volver a ejecutar esto en la terminal
en RStudio Cloud:

``` r
condash
```

    ## [1] "source /Users/karin/AppData/Local/r-miniconda/etc/profile.d/conda.sh"

-   Se retorna al environment base

conda activate

-   Se elimina el environment creado

conda remove –name rladies-env –all

-   Se listan los environment disponibles

conda env list

``` r
sessioninfo::package_info() %>% 
  dplyr::filter(attached==TRUE) %>% 
  dplyr::select(package, loadedversion, date, source) %>% 
  gt::gt() %>% 
  gt::tab_header(title='Paquetes utilizados',
             subtitle='Versiones') %>% 
  gt::opt_align_table_header('left')
```

<div id="qzgrikegjw" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#qzgrikegjw .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#qzgrikegjw .gt_heading {
  background-color: #FFFFFF;
  text-align: left;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#qzgrikegjw .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#qzgrikegjw .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#qzgrikegjw .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qzgrikegjw .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#qzgrikegjw .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#qzgrikegjw .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#qzgrikegjw .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#qzgrikegjw .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#qzgrikegjw .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#qzgrikegjw .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#qzgrikegjw .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#qzgrikegjw .gt_from_md > :first-child {
  margin-top: 0;
}

#qzgrikegjw .gt_from_md > :last-child {
  margin-bottom: 0;
}

#qzgrikegjw .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#qzgrikegjw .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#qzgrikegjw .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#qzgrikegjw .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#qzgrikegjw .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#qzgrikegjw .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#qzgrikegjw .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#qzgrikegjw .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qzgrikegjw .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#qzgrikegjw .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#qzgrikegjw .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#qzgrikegjw .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#qzgrikegjw .gt_left {
  text-align: left;
}

#qzgrikegjw .gt_center {
  text-align: center;
}

#qzgrikegjw .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#qzgrikegjw .gt_font_normal {
  font-weight: normal;
}

#qzgrikegjw .gt_font_bold {
  font-weight: bold;
}

#qzgrikegjw .gt_font_italic {
  font-style: italic;
}

#qzgrikegjw .gt_super {
  font-size: 65%;
}

#qzgrikegjw .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 65%;
}
</style>
<table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="4" class="gt_heading gt_title gt_font_normal" style>Paquetes utilizados</th>
    </tr>
    <tr>
      <th colspan="4" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style>Versiones</th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">package</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">loadedversion</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">date</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">source</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_left">dplyr</td>
<td class="gt_row gt_left">1.0.7</td>
<td class="gt_row gt_left">2021-06-18</td>
<td class="gt_row gt_left">CRAN (R 4.1.0)</td></tr>
    <tr><td class="gt_row gt_left">reticulate</td>
<td class="gt_row gt_left">1.20</td>
<td class="gt_row gt_left">2021-05-03</td>
<td class="gt_row gt_left">CRAN (R 4.1.0)</td></tr>
  </tbody>
  
  
</table>
</div>
