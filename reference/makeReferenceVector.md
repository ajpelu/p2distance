# Make a reference vector

Make a reference vector.

## Usage

``` r
makeReferenceVector(X, reference_vector_function = min)
```

## Arguments

- X:

  Array with *n* rows (entities) and *m* columns (values of variables)

- reference_vector_function:

  Function to make the reference vector. Common functions used are: min,
  max, mean, median, etc. See `apply` for further details. Minimum es
  the default function

## Details

A reference vector must be defined for each partial indicator so as to
compare different spatial entities. This vector is used by
[`p2distance`](https://ajpelu.github.io/p2distance/reference/p2distance.md)
function (as base reference) to calculate distances of each spatial
entities with this reference base. It is quite commom to consider the
minimum value as the base reference (see references).

## Value

Vector with the reference value (base reference) of each variable. The
vector length equals to number of variables

## References

Pena, J. B. (1977). *Problemas de la medición del bienestar y conceptos
afines (una aplicación al caso Español)*. Madrid: INE.

Pena, J. B. (2009). La medición del bienestar social: una revisión
crítica. *Estudios de Economía Aplicada*, **27(2)**, 299–324.

Somarriba, N. (2008). *Aproximación a la medición de la calidad de vida
en la Unión Europea*. Doctoral Thesis. University of Valladolid.
<http://www.eumed.net/tesis/2010/mnsa/index.htm>

Zarzosa, P. (1992). *Aproximación a la medición del bienestar social,
estudio de la idoneidad del indicador sintético Distancia P2*. Doctoral
Thesis. University of Valladolid.

## Author

A.J. Perez-Luque; R. Moreno; R. Perez-Perez and F.J. Bonet

## Examples

``` r
## Create a data frame of 3 variables (indicators) for 6 entities (rows)
dat <- data.frame( 
      x1=c(10,12,13,14,12,11),
      x2=c(40,51,61,68,34,44),
      x3=c(0.43, 0.41, 0.39, 0.55, 0.60, 0.38))

## Calculate the reference vector (base reference) using minimun value of each variable
makeReferenceVector(dat, reference_vector_function=min)  
#>      x1 x2   x3
#> [1,] 10 34 0.38
```
