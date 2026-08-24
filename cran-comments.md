## Resubmission

This package was archived on CRAN on 2022-05-09 because email to the
maintainer was undeliverable. I am one of the original package authors
(Antonio J. Pérez-Luque) and am resubmitting as the new maintainer with
a working email address.

This resubmission also fixes the NOTEs reported by the win-builder
pre-test on the previous attempt:

* Modernized `inst/CITATION` to use `bibentry()` and `c()` on person
  objects instead of the deprecated `citEntry()`/`personList()`.
* Removed three dead/unreliable URLs (eumed.net, eurofound.europa.eu,
  travis-ci.org) from the documentation and README.
* Changed a DOI reference in `p2distance.Rd` to use `\doi{}` instead of
  a raw URL.
* Added `cran-comments.md` to `.Rbuildignore` so it is no longer flagged
  as a non-standard top-level file.

Documentation has also been rewritten with roxygen2 for maintainability.

## R CMD check results

0 errors | 0 warnings | 0 notes