# Análisis de genes candidatos asociados a variables climáticas en *Quercus macdougallii*
## Introducción 
##### *Quercus macdougallii*, es un encino endémico de la Sierra norte, en el estado de Oaxaca. Este encino pertenece a la sección Quercus, también conocidos como encinos blancos, presenta una distribución restringida y debido a la pérdida y fragmentación de su hábitat se encuentra dentro de la categoría de amenazada (EN), en la Lista Roja de Especies Amenazadas de la Unión Internacional para la Conservación de la Naturaleza [UICN] (Carrero et al., 2020).
##### Por otra parte, un estudio de la distribución potencial actual y en escenarios de cambio climático (escenario de mitigación moderado RCP 4.5 y escenario de altas emisiones RCP 8.5), mostró que Q. macdougallii enfrenta una reducción significativa de su hábitat potencial debido al cambio climático (Alfonso-Corrado et. al., 2024). Para predecir qué respuesta puede tener una especie ante escenarios de cambio calimico es necesario conocer la variación genética presente asociada con variables ambientales (Sork et al., 2013). En este sentido el análisis de genes candidatos asociados a factores climáticos de Q. macdougallii, permitirá comprender la base genética de la adaptación climática, lo cual puede ayudar a predecir la vulnerabilidad de la especie a eventos asociados al cambio climático (Aitken et al., 2008).
## Objetivo
##### Identificar  genes candidatos asociados a variables climáticas en *Q. macdougallii*  y analizar la expresión de los genes candidatos asociados al clima de *Q. macdougallii*
## Análisis bioinformático 
### Datos de entrada
##### Se utilizaron secuencias genómicas obtenidas mediante secuenciación de genoma completo (Whole Genome Sequencing, WGS) de individuos de *Q. macdougallii* dentro de la distribución natural de la especie. Los datos consisten en lecturas crudas en formato FASTQ, obtenidas para cada individuo.

###  Control de calidad y filtrado de lecturas
#### Evaluación inicial de calidad
##### Las lecturas crudas fueron evaluadas para identificar posibles problemas asociados a calidad de bases, contenido de adaptadores, distribución de longitudes y sesgos de composición nucleotídica. La evaluación se realizo en el software Geneious 9.1.8
#### Filtrado y recorte de lecturas
##### Posteriormente, se realizó el filtrado de secuencias para eliminar adaptadores, recortar bases de baja calidad y descartar lecturas con un contenido elevado de errores. Este proceso se realizó en Geneious 9.1.8
### Preparación de secuencias de referencia (genes candidatos)
##### Se compiló un conjunto de 75 genes candidatos previamente reportados en Q. Lobata por mostrar asociación con variables climáticas (Gugger et al., 2021).
##### Las secuencias de estos genes fueron organizadas en un archivo de referencia en formato FASTA, el cual fue utilizado como base para el alineamiento dirigido. 
### Alineamiento dirigido a genes candidatos
##### Las lecturas filtradas de cada individuo fueron alineadas contra la referencia FASTA de genes candidatos. Este proceso se realizó en Geneious 9.1.8
### Análisis de Variantes (SNPs y Indels)
##### Calling de variantes: Se usara BCFtools sobre las lecturas alineadas (BAM files, resultado de Geneious) para llamar variantes específicamente en las regiones de sus genes candidatos.
##### Filtrado básico: Se Filtraran las variantes por calidad, profundidad de lectura (DP),  usando vcftools
#### Análisis poblacional básico: Con vcftools, se calculara:
##### Frecuencias alélicas por población. Se Compararan las frecuencias de los alelos en los individuos.
##### Estadísticos de diferenciación. se calculara el coeficiente Fst. Un Fst alto para un gen/variante sugiere diferenciación significativa entre individuos.
##### Estadísticos de diversidad nucleotídica. Se Comparara la diversidad genética (π) dentro de cada población para las regiones candidatas.

