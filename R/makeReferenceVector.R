#' Make a reference vector
#'
#' A reference vector must be defined for each partial indicator so as to
#' compare different spatial entities. This vector is used by
#' [p2distance()] (as the base reference) to calculate the distance of each
#' spatial entity from this reference base. It is common to use the minimum
#' value as the base reference (see references).
#'
#' @param X A data frame or matrix with `n` rows (entities) and `m` columns
#'   (variables).
#' @param reference_vector_function Function used to build the reference
#'   vector. Common choices are `min`, `max`, `mean`, `median`, etc. See
#'   [apply()] for details. `min` is the default.
#'
#' @return A vector with the reference value (base reference) for each
#'   variable. Its length equals the number of variables.
#'
#' @references
#' Peña, J. B. (1977). *Problemas de la medición del bienestar y conceptos
#' afines (una aplicación al caso Español)*. Madrid: INE.
#'
#' Peña, J. B. (2009). La medición del bienestar social: una revisión
#' crítica. *Estudios de Economía Aplicada*, 27(2), 299-324.
#'
#' Somarriba, N. (2008). *Aproximación a la medición de la calidad de vida
#' en la Unión Europea*. Doctoral Thesis. University of Valladolid.
#'
#' Zarzosa, P. (1992). *Aproximación a la medición del bienestar social,
#' estudio de la idoneidad del indicador sintético Distancia P2*. Doctoral
#' Thesis. University of Valladolid.
#'
#' @seealso [p2distance()]
#'
#' @examples
#' ## Create a data frame of 3 variables (indicators) for 6 entities (rows)
#' dat <- data.frame(
#'   x1 = c(10, 12, 13, 14, 12, 11),
#'   x2 = c(40, 51, 61, 68, 34, 44),
#'   x3 = c(0.43, 0.41, 0.39, 0.55, 0.60, 0.38)
#' )
#'
#' ## Calculate the reference vector using the minimum value of each variable
#' makeReferenceVector(dat, reference_vector_function = min)
#'
#' @export
makeReferenceVector <-
  function (X, reference_vector_function = min){
    
    vRef <- as.matrix(apply(X, MARGIN=2, reference_vector_function))	# Calcula el minimo de cada variable contenida en la matrix X
    vRef <- t(vRef)	# Transpone lo anterior 		
    
    return(vRef)			
  }