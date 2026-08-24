# Welfare's Synthetic Indicator function

This function calculates the \\P\_{2}\\ distance synthetic indicator for
a set of variables.

## Usage

``` r
p2distance(matriz, reference_vector = NULL, reference_vector_function = min, 
    iterations = 20, umbral = 1e-04)
```

## Arguments

- matriz:

  An object of matrix type with spatial entities in rows and variables
  in columns

- reference_vector:

  Optionally. A reference vector defined for each partial indicator so
  as to compare different spatial entities

- reference_vector_function:

  Optionally. Function to make the reference vector. Minimum es the
  default. Others common functions used: min, max, mean, median, etc.
  See
  [`makeReferenceVector`](https://ajpelu.github.io/p2distance/reference/makeReferenceVector.md)
  for further details

- iterations:

  Numbers of maximum iterations for the computational process until
  reach the convergence

- umbral:

  The algorithm stop when the difference between iterations is lower
  than this umbral

## Details

This is the main function on package. It calculates the Pena distance
indicator, also called DP2, which is used to measure welfare in
quality-of-life applications, to create Environmental Quality Indexes,
etc. (see references). It is a multidimensional indicator capable to
aggregate various partial indicators (variables) in a unique measure to
compare the state of different spatial entities. The P2 Distance from a
spatial entity *r* is definied as \$\$
DP\_{2}=\sum^{n}\_{i=1}\left\lbrace\left(\frac{d\_{i}}{\sigma\_{i}}\right)\left(1-R^{2}\_{i,i-1,i-2,\ldots,1}\right)\right\rbrace\$\$
with \\R^{2}\_{1}=0\\; where \\d\_{i}=\|x\_{ri}-x\_{\*i}\|\\ with the
reference base
\\X\_{\*}=\left(x\_{\*1},x\_{\*2},\ldots,x\_{\*n}\right)\\ where:

- *n* is the number of variables

- \\x\_{ri}\\, is the value of the variable *i* in the spatial entity
  *r*

- \\\sigma\_{i}\\ is the standard deviation of variable *i*

- \\R^{2}\_{i,i-1,\ldots,1}\\ is the coefficient of determination in the
  regression of \\X\_{i}\\ over \\X\_{i-1}, X\_{i-2}, \ldots,X\_{1}\\
  already included.

The numerical value of the DP2 index has no real meaning, but its is
useful for comparing the state of different spatial entities in terms of
welfare, environmental conditions, etc.

## Value

- discrimination.coefficient:

  Vector of discrimination coefficients (DC) for each variable. The
  value of DC, defined by Ivanovic (1974) is
  \$\$DC\_{i}=\frac{2}{m(m-1)}\sum\_{j,l\>j}^{k\_{i}}m\_{ji}m\_{li}\left\|\frac{x\_{ji}-x\_{li}}{\overline{X}\_{i}}\right\|\$\$
  where *m* is the number of spatial entities and \\m\_{ji}\\ is the
  absolute frequency of \\x\_{ji}\\. This measure ranges between 0 an 2.
  If a variable takes the same values for all spatial entities, DC
  equals zero, indicating zero discriminant power. By contrast, if a
  variable only has a value other than zero for one spatial entity and
  in the remainder \\m-1\\, is equal to zero, DC reaches its maximun
  value (2) and the variable has full discriminant power (see Zarzosa,
  1996; Zarzosa and Somarriba, 2012). There is an alternative way of
  calculating the coefficient, by using the Gini
  index,\$\$DC\_{i}=2\frac{m}{m-1}G\$\$ where *m* is the number of
  spatial entities and *G* the Gini index

- p2distance:

  Vector with the last \\P\_{2}\\ distance value for each spatial entity

- p2distances:

  Array with vectors of \\P\_{2}\\ distances values resulting for each
  iteration

- diff_p2distances:

  Array with differeces between two contiguous \\P\_{2}\\ distances

- iteration:

  Number of calculated iterations

- umbral:

  Threshold in difference for two contiguous \\P\_{2}\\ distances

- variables_sort:

  Vector with the variable names by entrance order determined by last
  iteration

- correction_factors:

  Correction Factors for each variable

- cor.coeff:

  Correlation coefficient for each variable with the synthetic indicator
  (\\P\_{2}\\ distance) calculated

- partial.Indicators:

  For each spatial entity the difference between the reference vector
  and the value of each variable divided by the standard deviation. For
  a spatial entity, the sum of all partial indicators is the Frechet
  Distance (DF), which is the maximun value that \\P\_{2}\\ distance can
  reach.

## References

Ivanovic, B. (1974) Comment ètablir une liste des indicateurs de
developpment. *Revue de Statistique Apliquée*, **XXII(2)**, 37–50

Montero, J. M., Chasco, C. and Larraz, B. (2010). Building an
environmental quality index for a big city: a spatial interpolation
approach combined with a distance indicator. *Journal of Geographical
Systems*, **12**, 435–459.

Pena, J. B. (1977). *Problemas de la medición del bienestar y conceptos
afines (una aplicación al caso Español)*. Madrid: INE.

Pena, J. B. (2009). La medición del bienestar social: una revisión
crítica. *Estudios de Economía Aplicada*, **27(2)**, 299–324.

Zarzosa, P. (1996). *Aproximación a la medición del Bienestar social*.
Valladolid: University of Valladolid. 248 pp.

Zarzosa, P. and Somarriba, N. (2012). An assessment of social welfare in
Spain: Territorial analysis using a synthetic welfare indicator. *Social
Indicators Research*, doi: <http://dx.doi.org/10.1007/s11205-012-0005-0>

## Author

A.J. Perez-Luque; R. Moreno; R. Perez-Perez and F.J. Bonet

## Examples

``` r
## Calculate a welfare indicator for 27 countries of Europe 
data(welfare) 

## Convert welfare dataframe to matrix object 
welfare <- as.matrix(welfare)

## Calculate P2 Distance 
ind <- p2distance(matriz=welfare, reference_vector_function = min, 
        iterations = 20)
#> [1] "Iteration 1"
#> [1] "Iteration 2"
#> [1] "Iteration 3"
#> [1] "Iteration 4"

## Examine the results
# P2 distance
ind$p2distance
#>               p2distance.4
#> Austria          14.243429
#> Belgium          14.205152
#> Bulgaria          3.300577
#> Cyprus           14.196170
#> CzechRepublic    10.595075
#> Germany          12.882661
#> Denmark          17.932001
#> Estonia          10.014157
#> Greece            9.467627
#> Spain            12.653989
#> Finland          16.014650
#> France           14.106968
#> Hungary           6.157913
#> Ireland          13.186726
#> Italy            10.822846
#> Lithuania         6.728374
#> Luxembourg       15.608905
#> Latvia            5.881641
#> Malta            14.124929
#> Netherlands      15.096630
#> Poland            9.072606
#> Portugal          9.927800
#> Romania           7.855658
#> Sweden           16.225990
#> Slovenia         12.005987
#> Slovakia          9.584544
#> UnitedKingdom    13.817885

# Iterations to achieve convergence
ind$iteration 
#> [1] 4

# Order of entry of variables resulting the last iteration
ind$variables_sort
#>  [1] "standard"    "social"      "life.satis"  "home"        "happiness"  
#>  [6] "family"      "night"       "area"        "life.0"      "life.65"    
#> [11] "job"         "judicial"    "education"   "employement" "people"     
#> [16] "health"      "inequality"  "stress"      "hobbies"     "dist.school"

# Correction factors of each variable
ind$correction_factors
#>    standard      social  life.satis        home   happiness      family 
#>  1.00000000  0.26994486  0.15647574  0.19019368  0.11374336  0.16464658 
#>       night        area      life.0     life.65         job    judicial 
#>  0.22771776  0.26803770  0.23019934  0.05377976  0.39866003  0.35480094 
#>   education employement      people      health  inequality      stress 
#>  0.25202059  0.28405573  0.19859718  0.42516392  0.08949479  0.18883919 
#>     hobbies dist.school 
#>  0.07721116  0.15296173 

# Correlations between P2 distance indicator and variables
ind$cor.coeff
#>             p2distance.4
#> happiness      0.8923932
#> life.satis     0.9032185
#> judicial       0.7240456
#> night          0.8259018
#> social         0.9193612
#> people         0.5994948
#> family         0.8366196
#> health         0.5648329
#> life.65        0.7758931
#> life.0         0.8013540
#> inequality    -0.4733350
#> hobbies       -0.3985391
#> education      0.6609428
#> standard       0.9572833
#> dist.school    0.3876915
#> area           0.8066489
#> home           0.8945082
#> stress        -0.4232577
#> employement    0.6416367
#> job            0.7744487

# Discrimination coefficient of each variable
ind$discrimination.coefficient
#>   happiness  life.satis    judicial       night      social      people 
#>  0.08033682  0.22114042  0.37154869  0.21365413  0.19085162  0.21602518 
#>      family      health     life.65      life.0  inequality     hobbies 
#>  0.07274169  0.56579365  0.09533417  0.04596938  0.29771635  0.16633727 
#>   education    standard dist.school        area        home      stress 
#>  0.09708026  0.14761252  0.06577282  0.07862064  0.12099290  0.31190294 
#> employement         job 
#>  0.10930471  0.13470473 

## Plot of P2 Distance Indicator for European countries
barplot(ind$p2distance, beside=TRUE, col="white", space=.3, ylab="P2 distance", 
      ylim=c(0,20), names.arg=rownames(ind$p2distance), las=3, cex.names=0.8)
```
