# 💜 Charlas RLadies 💜 

## **1. 01_r_python/** 👉 [El uso de R y python](https://karbartolome.github.io/rladies_charlas/01_r_python/02_slides/rladies_r_python.html)

Se presenta la configuración necesaria para utilizar python en Rstudio / Rmarkdown, combinando R y python en un único archivo. 

Incluye diferencias entre {tidyverse} y {pandas}, uso de {reticulate}, {rpy2}, modelos de regresión lineal en R y python. 

```mermaid
flowchart LR
    subgraph r[Estructura de la charla]
        direction LR
        data[fa:fa-database 01_data] -->|Ejemplos dplyr y pandas| slide(02_slides)
        slide -->|Slide 12| condaenv[03_condaenv]
        slide -->|Slide 44| rpy2[04_rpy2]
        slide -->|Slide 44| rmd[05_rmarkdown_param]
        data --> rpy2
        data --> rmd
        condaenv --> slide
        rpy2 --> slide
        rmd --> slide

        style slide fill:#652a75,stroke:#333,color: #ffffff, stroke-width:4px
        style data fill:#ffffff, stroke:#000000, stroke-width:2px,color:#000000,stroke-dasharray: 4
        style condaenv stroke:#e3b3ff
        style rpy2 stroke:#e3b3ff
        style rmd stroke:#e3b3ff
    style r fill: #0000, stroke: #333
    end

```
