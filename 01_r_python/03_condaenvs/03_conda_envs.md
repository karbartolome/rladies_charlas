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
```

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
paste0('source ',
       gsub('C:','',reticulate::miniconda_path()),
       '/etc/profile.d/conda.sh')
```

-   Se activa el environment creado:

conda activate rladies-env

-   Se listan los environments, visualizando que está seleccionado el
    correcto:

conda env list

-   Se instalan 2 paquetes para probar que funciona correctamente

conda install -c conda-forge numpy

conda install -c conda-forge pandas

# 4. Uso del conda environment creado

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

# 5. Crear un .yml de los requerimientos del conda env

conda env export –name rladies-env \> rladies_requirements.yml

Guarda el .yml en el path de getwd()

``` r
getwd()
```

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

<div id="rfzdbpuvsy" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#rfzdbpuvsy .gt_table {
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

#rfzdbpuvsy .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#rfzdbpuvsy .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#rfzdbpuvsy .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#rfzdbpuvsy .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rfzdbpuvsy .gt_col_headings {
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

#rfzdbpuvsy .gt_col_heading {
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

#rfzdbpuvsy .gt_column_spanner_outer {
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

#rfzdbpuvsy .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#rfzdbpuvsy .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#rfzdbpuvsy .gt_column_spanner {
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

#rfzdbpuvsy .gt_group_heading {
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

#rfzdbpuvsy .gt_empty_group_heading {
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

#rfzdbpuvsy .gt_from_md > :first-child {
  margin-top: 0;
}

#rfzdbpuvsy .gt_from_md > :last-child {
  margin-bottom: 0;
}

#rfzdbpuvsy .gt_row {
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

#rfzdbpuvsy .gt_stub {
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

#rfzdbpuvsy .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#rfzdbpuvsy .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#rfzdbpuvsy .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#rfzdbpuvsy .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#rfzdbpuvsy .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#rfzdbpuvsy .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rfzdbpuvsy .gt_footnotes {
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

#rfzdbpuvsy .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#rfzdbpuvsy .gt_sourcenotes {
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

#rfzdbpuvsy .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#rfzdbpuvsy .gt_left {
  text-align: left;
}

#rfzdbpuvsy .gt_center {
  text-align: center;
}

#rfzdbpuvsy .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#rfzdbpuvsy .gt_font_normal {
  font-weight: normal;
}

#rfzdbpuvsy .gt_font_bold {
  font-weight: bold;
}

#rfzdbpuvsy .gt_font_italic {
  font-style: italic;
}

#rfzdbpuvsy .gt_super {
  font-size: 65%;
}

#rfzdbpuvsy .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 65%;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">Paquete</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">Versión</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">Channel</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_left">brotli</td>
<td class="gt_row gt_left">1.0.9</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">brotli-bin</td>
<td class="gt_row gt_left">1.0.9</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">bzip2</td>
<td class="gt_row gt_left">1.0.8</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">ca-certificates</td>
<td class="gt_row gt_left">2021.10.8</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">certifi</td>
<td class="gt_row gt_left">2021.10.8</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">cycler</td>
<td class="gt_row gt_left">0.11.0</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">fonttools</td>
<td class="gt_row gt_left">4.32.0</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">freetype</td>
<td class="gt_row gt_left">2.10.4</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">intel-openmp</td>
<td class="gt_row gt_left">2022.0.0</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">jbig</td>
<td class="gt_row gt_left">2.1</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">jpeg</td>
<td class="gt_row gt_left">9e</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">kiwisolver</td>
<td class="gt_row gt_left">1.4.2</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">lcms2</td>
<td class="gt_row gt_left">2.12</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">lerc</td>
<td class="gt_row gt_left">3.0</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">libblas</td>
<td class="gt_row gt_left">3.9.0</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">libbrotlicommon</td>
<td class="gt_row gt_left">1.0.9</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">libbrotlidec</td>
<td class="gt_row gt_left">1.0.9</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">libbrotlienc</td>
<td class="gt_row gt_left">1.0.9</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">libcblas</td>
<td class="gt_row gt_left">3.9.0</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">libdeflate</td>
<td class="gt_row gt_left">1.10</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">libffi</td>
<td class="gt_row gt_left">3.4.2</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">liblapack</td>
<td class="gt_row gt_left">3.9.0</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">libpng</td>
<td class="gt_row gt_left">1.6.37</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">libtiff</td>
<td class="gt_row gt_left">4.3.0</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">libwebp</td>
<td class="gt_row gt_left">1.2.2</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">libwebp-base</td>
<td class="gt_row gt_left">1.2.2</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">libxcb</td>
<td class="gt_row gt_left">1.13</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">libzlib</td>
<td class="gt_row gt_left">1.2.11</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">lz4-c</td>
<td class="gt_row gt_left">1.9.3</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">m2w64-gcc-libgfortran</td>
<td class="gt_row gt_left">5.3.0</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">m2w64-gcc-libs</td>
<td class="gt_row gt_left">5.3.0</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">m2w64-gcc-libs-core</td>
<td class="gt_row gt_left">5.3.0</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">m2w64-gmp</td>
<td class="gt_row gt_left">6.1.0</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">m2w64-libwinpthread-git</td>
<td class="gt_row gt_left">5.0.0.4634.697f757</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">matplotlib-base</td>
<td class="gt_row gt_left">3.5.1</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">mkl</td>
<td class="gt_row gt_left">2022.0.0</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">msys2-conda-epoch</td>
<td class="gt_row gt_left">20160418</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">munkres</td>
<td class="gt_row gt_left">1.1.4</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">numpy</td>
<td class="gt_row gt_left">1.22.3</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">openjpeg</td>
<td class="gt_row gt_left">2.4.0</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">openssl</td>
<td class="gt_row gt_left">3.0.2</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">packaging</td>
<td class="gt_row gt_left">21.3</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">pandas</td>
<td class="gt_row gt_left">1.4.2</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">patsy</td>
<td class="gt_row gt_left">0.5.2</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">pillow</td>
<td class="gt_row gt_left">9.1.0</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">pip</td>
<td class="gt_row gt_left">22.0.4</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">pthread-stubs</td>
<td class="gt_row gt_left">0.4</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">pyparsing</td>
<td class="gt_row gt_left">3.0.8</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">python</td>
<td class="gt_row gt_left">3.8.13</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">python-dateutil</td>
<td class="gt_row gt_left">2.8.2</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">python_abi</td>
<td class="gt_row gt_left">3.8</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">pytz</td>
<td class="gt_row gt_left">2022.1</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">scipy</td>
<td class="gt_row gt_left">1.8.0</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">seaborn</td>
<td class="gt_row gt_left">0.11.2</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">seaborn-base</td>
<td class="gt_row gt_left">0.11.2</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">setuptools</td>
<td class="gt_row gt_left">62.0.0</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">six</td>
<td class="gt_row gt_left">1.16.0</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">sqlite</td>
<td class="gt_row gt_left">3.37.1</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">statsmodels</td>
<td class="gt_row gt_left">0.13.2</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">tbb</td>
<td class="gt_row gt_left">2021.5.0</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">tk</td>
<td class="gt_row gt_left">8.6.12</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">ucrt</td>
<td class="gt_row gt_left">10.0.20348.0</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">unicodedata2</td>
<td class="gt_row gt_left">14.0.0</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">vc</td>
<td class="gt_row gt_left">14.2</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">vs2015_runtime</td>
<td class="gt_row gt_left">14.29.30037</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">wheel</td>
<td class="gt_row gt_left">0.37.1</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">xorg-libxau</td>
<td class="gt_row gt_left">1.0.9</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">xorg-libxdmcp</td>
<td class="gt_row gt_left">1.1.3</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">xz</td>
<td class="gt_row gt_left">5.2.5</td>
<td class="gt_row gt_left">conda-forge</td></tr>
    <tr><td class="gt_row gt_left">zlib</td>
<td class="gt_row gt_left">1.2.11</td>
<td class="gt_row gt_left">conda-forge</td></tr>
  </tbody>
  
  
</table>
</div>

# 6. Eliminar el conda environment creado:

-   Se retorna al environment base

conda activate

-   Se elimina el environment creado

conda remove –name rladies-env –all

-   Se listan los environment disponibles

conda env list
