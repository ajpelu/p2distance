# p2distance 1.0.2

* New maintainer: Antonio J. Pérez-Luque (ajpelu@gmail.com). The package
  was archived on CRAN on 2022-05-09 because email to the previous
  maintainer was undeliverable.
* Fixed R CMD check NOTE about undefined global functions/variables by
  adding proper `importFrom()` declarations in NAMESPACE for `cor`, `lm`,
  `sd` (stats) and `read.table` (utils).

# p2distance 1.0.1

* Added a `NEWS.md` file to track changes to the package.
