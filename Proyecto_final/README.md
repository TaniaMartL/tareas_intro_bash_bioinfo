##  Construcción automatizada de pseudo-referencias de genes de Quercus lobata para análisis comparativo de secuencias en *Quercus* *macdougallii* 
### 2. Introducción
#### Este proyecto forma parte de la pipe line Los scripts incluidos en este proyecto forman parte de la pipiline 
#### *Quercus* *macdougallii*, es un encino endémico de la Sierra norte, en el estado de Oaxaca. Pertenece a la sección Quercus, también conocidos como encinos blancos, presenta una distribución restringida y debido a la pérdida y fragmentación de su hábitat se encuentra dentro de la categoría de amenazada (EN), en la Lista Roja de Especies Amenazadas de la Unión Internacional para la Conservación de la Naturaleza [UICN] (Carrero et al., 2020).
#### Ademas de acuerdo a un estudio de la distribución potencial actual y en escenarios de cambio climático (escenario de mitigación moderado RCP 4.5 y escenario de altas emisiones RCP 8.5),  Q. macdougallii enfrenta una reducción significativa de su hábitat potencial debido al cambio climático (Alfonso-Corrado et. al., 2024). Para predecir qué respuesta puede tener una especie ante escenarios de cambio climático es necesario conocer la variación genética presente asociada con variables ambientales (Sork et al., 2013). En este sentido el análisis de genes candidatos asociados a factores climáticos de Q. macdougallii, permitirá comprender la base genética de la adaptación climática, lo cual puede ayudar a predecir la vulnerabilidad de la especie a eventos asociados al cambio climático (Aitken et al., 2008).
#### El análisis de genes candidatos asociados a variables climáticas se iniciará con el alineamiento de las secuencias de Q. macdougalli con  74 genes identificados en *Q.* *lobata*  por mostrar asociación con variables climáticas (Gugger et al., 2021)
### 3. Objetivo
#### El objetivo de este proyecto bioinformatico es realizar una parte de la pipeline del  proyecto de Tesis: Análisis de genes candidatos asociados a variables climáticas en Quercus macdougallii.

#### Los procesos realizados por los scripts son:
#### Realizar la descarga de secuencias de mRNA de *Q.* *lobata* que presenta asociación a varables climáticas del database del NCBI
#### Hacer la validación de las secuencias descargadas 
#### Concatenar las secuencias a manera de crear un pseudo cromosoma de referencia para realizar el alineamiento con secuencias de Q. macdougalli
#### Indexar el pseudo cromosoma de referencia 
### 4. Descripción general del flujo de trabajo
#### Realizar la descarga de secuencias de mRNA de Q. lobata que presenta asociación a varables climáticas del database del NCBI
#### Hacer la validación de las secuencias descargadas 
#### Concatenar las secuencias a manera de crear un pseudo cromosoma de referencia para realizar el alineamiento con secuencias de *Q.* *macdougalli*
#### Indexar el pseudo cromosoma de referencia 

### 5. Estructura del repositorio
#### Explicación breve de las carpetas y archivos principales.
### 6. Requisitos de software
#### Bash 5.1
#### EDirect
#### BWA 0.7.17-r1188
#### awk
#### grep
#### curl 
### 7. Reproducibilidad
#### Dar permisos de ejecución y lectura a los scripts 
#### Instalación de EDirect y BAW 0.7.17-r1188 (proceso de instalación incluido en los scripts)
### 8. Instrucciones de uso
#### Descargar el repositorio 
#### git clone https://github.com/usuario/proyecto_final.git
#### cd proyecto_final
####Ejecutar el script para descargar secuencias de mNRA de *Q.* *lobata* del NCBI 
#### bash scripts/descargar_genes.sh metadatos/genes_id.txt
####Ejecutar el script para validar las secuencias descargadas del NCBI 
#### bash scripts/validacion_gb.sh
####Ejecutar el script para concatenar las secuencias 
#### bash scripts/pseudo_referencia.sh datos Quercus_ref
####Ejecutar el script para indexar las secuencias concatenadas en formato .fasta
#### bash scripts/indexar_Quercus_bwa.sh
### 9. Entradas y salidas
#### Entrada 
#### En carpeta metadatos la lista en formato.txt de los ID de las secuencias de mRNA, 
#### Salidas 
#### Secuencias de mRNA de Q. lobata descargadas de NCBI  en formato.gb
#### secuencias concatenadas en formato fasta 
#### 

### 10. Información del sistema
#### Marca y modelo: Lenovo IdeaPad 3 15ALC6
#### Tipo: laptop 
####  Sistema operativo: Ubuntu 20.04.4 LTS
#### CPU: AMD Ryzen 7 5700U with Radeon Graphics          (1.80 GHz)
#### Núcleos / hilos:  8 nucleos/ 16 hilos 
#### RAM instalada (GB): 16 GB
#### Almacenamiento: SSD  512 GB
#### Tiempo aproximado de ejecución:  minutos
### 11. Autoría
#### Tania Martínez León 

