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

# 6. Eliminar el conda environment creado:

-   Se retorna al environment base

conda activate

-   Se elimina el environment creado

conda remove –name rladies-env –all

-   Se listan los environment disponibles

conda env list
