#' Welfare's synthetic indicator (P2 distance)
#'
#' Calculates the \eqn{P_2} distance synthetic indicator for a set of
#' variables. This is the main function of the package.
#'
#' The \eqn{P_2} distance, also called DP2, is used to measure welfare in
#' quality-of-life applications, to build environmental quality indexes, and
#' more generally to aggregate multiple partial indicators (variables) into
#' a single measure that allows spatial entities to be compared. For a
#' spatial entity *r*, the \eqn{P_2} distance is defined as:
#' \deqn{DP_{2}=\sum^{n}_{i=1}\left\lbrace\left(\frac{d_{i}}{\sigma_{i}}\right)\left(1-R^{2}_{i,i-1,i-2,\ldots,1}\right)\right\rbrace}
#' with \eqn{R^{2}_{1}=0}, where \eqn{d_{i}=|x_{ri}-x_{*i}|}, with the
#' reference base \eqn{X_{*}=(x_{*1},x_{*2},\ldots,x_{*n})}, and:
#' - *n* is the number of variables
#' - \eqn{x_{ri}} is the value of variable *i* for spatial entity *r*
#' - \eqn{\sigma_{i}} is the standard deviation of variable *i*
#' - \eqn{R^{2}_{i,i-1,\ldots,1}} is the coefficient of determination of the
#'   regression of \eqn{X_i} on \eqn{X_{i-1}, X_{i-2}, \ldots, X_1} already
#'   included
#'
#' The numerical value of the DP2 index has no meaning by itself, but it is
#' useful for comparing the state of different spatial entities in terms of
#' welfare, environmental conditions, etc.
#'
#' @param matriz A matrix with spatial entities in rows and variables in
#'   columns.
#' @param reference_vector Optional. A reference vector defined for each
#'   partial indicator, used to compare different spatial entities.
#' @param reference_vector_function Optional. Function used to build the
#'   reference vector when `reference_vector` is not supplied. `min` is the
#'   default; other common choices are `max`, `mean`, `median`, etc. See
#'   [makeReferenceVector()] for details.
#' @param iterations Maximum number of iterations for the computational
#'   process until convergence is reached.
#' @param umbral The algorithm stops when the difference between two
#'   consecutive iterations is lower than this threshold.
#'
#' @return A list with the following elements:
#' - `discrimination.coefficient`: Vector of discrimination coefficients
#'   (DC) for each variable (Ivanovic, 1974). DC ranges between 0 and 2: a
#'   variable with the same value for every spatial entity has DC = 0 (no
#'   discriminant power), while a variable with a single non-zero value has
#'   DC = 2 (full discriminant power). See Zarzosa (1996) and Zarzosa &
#'   Somarriba (2012).
#' - `p2distance`: Vector with the final \eqn{P_2} distance value for each
#'   spatial entity.
#' - `p2distances`: Matrix with the \eqn{P_2} distance values resulting from
#'   each iteration.
#' - `diff_p2distances`: Matrix with the differences between two consecutive
#'   \eqn{P_2} distances.
#' - `iteration`: Number of iterations performed.
#' - `umbral`: Threshold used to stop the iterations.
#' - `variables_sort`: Variable names ordered by entrance order in the last
#'   iteration.
#' - `correction_factors`: Correction factor for each variable.
#' - `cor.coeff`: Correlation coefficient of each variable with the
#'   calculated \eqn{P_2} distance.
#' - `partial.Indicators`: For each spatial entity, the difference between
#'   the reference vector and the value of each variable, divided by the
#'   standard deviation. The sum of all partial indicators for a spatial
#'   entity is the Frechet Distance (DF), the maximum value the \eqn{P_2}
#'   distance can reach.
#'
#' @references
#' Ivanovic, B. (1974). Comment établir une liste des indicateurs de
#' developpment. *Revue de Statistique Appliquée*, 22(2), 37-50.
#'
#' Montero, J. M., Chasco, C., & Larraz, B. (2010). Building an
#' environmental quality index for a big city: a spatial interpolation
#' approach combined with a distance indicator. *Journal of Geographical
#' Systems*, 12, 435-459.
#'
#' Peña, J. B. (1977). *Problemas de la medición del bienestar y conceptos
#' afines (una aplicación al caso Español)*. Madrid: INE.
#'
#' Peña, J. B. (2009). La medición del bienestar social: una revisión
#' crítica. *Estudios de Economía Aplicada*, 27(2), 299-324.
#'
#' Zarzosa, P. (1996). *Aproximación a la medición del Bienestar social*.
#' Valladolid: Universidad de Valladolid.
#'
#' Zarzosa, P., & Somarriba, N. (2012). An assessment of social welfare in
#' Spain: Territorial analysis using a synthetic welfare indicator. *Social
#' Indicators Research*. \doi{10.1007/s11205-012-0005-0}
#'
#' @seealso [makeReferenceVector()], [loadCSVtoP2distance()]
#'
#' @examples
#' ## Calculate a welfare indicator for 27 European countries
#' data(welfare)
#' welfare <- as.matrix(welfare)
#'
#' ind <- p2distance(welfare, reference_vector_function = min, iterations = 20)
#'
#' ## Examine the results
#' ind$p2distance
#' ind$iteration
#' ind$variables_sort
#' ind$correction_factors
#' ind$cor.coeff
#' ind$discrimination.coefficient
#'
#' ## Plot of the P2 distance indicator for European countries
#' barplot(ind$p2distance, beside = TRUE, col = "white", space = .3,
#'   ylab = "P2 distance", ylim = c(0, 20),
#'   names.arg = rownames(ind$p2distance), las = 3, cex.names = 0.8)
#'
#' @importFrom stats cor lm sd
#' @export
p2distance <-
  function (matriz, reference_vector = NULL, reference_vector_function = min, iterations = 20, umbral = 0.0001){
    
    ## chequear que la matriz sea de tipo matriz
    ## 
    if (!is.matrix(matriz)){
      warning("the argument 'matriz' would be a matrix object")
      matriz <- as.matrix(matriz)
    }		
    
    discrimination.coefficient <- function (X){
      n <- length(X) # Longitud vector
      X.ord <- sort(X) # Obtener el vector X ordenado 
      vec1 <- rep(1, length(X)) # Creamos un vector de 1 con la misma longitud que X 
      indice <- cumsum(vec1) # Obtenemos un vector con la posición 
      gini.coeff <- ((2*sum(indice*X.ord))/(n*sum(X)))-((n+1)/n) # coeficiente GINI 
      discrimination.coeff <- 2*gini.coeff*(n/(n-1))
      return(discrimination.coeff)
    } 
    
    
    ################### funciones auxliares	
    # función que pre-calcula la distancia con el vector de referencia
    calcularDistancia = function (X, vector_referencia = NULL, funcion_v_referencia = min) {	
      if (is.null(vector_referencia)){
        vRef <- makeReferenceVector(X, reference_vector_function = funcion_v_referencia)
      }else{
        vRef <- reference_vector	
      }		
      m <- dim(X)[1] # Calcula el número de filas (m) de la matrix X
      n <- dim(X)[2] # Calcula el número de columnas (n) de la matrix X 
      matRef <- matrix(t(vRef), nrow=m, ncol=n, byrow=TRUE) # Crea una matrix con los valores de referencia para cada variable con el numero de filas igual a la matrix X
      mDif <- X - matRef ### Calcula la matriz de diferencias 
      mDif.abs <- abs(mDif) # matriz de valores absolutos de las diferencias. 
      desT <- as.matrix(apply(X, MARGIN=2, sd)) # Calcula le desviación tipica para cada variable (columna) de la matrix X
      desT <- desT*(sqrt((m-1)/m))
      desT.inversa <- 1/t(desT) # Calcula la inversa de las desviaciones típica
      mdesT <- matrix(t(desT.inversa), nrow=m, ncol=n, byrow=TRUE) #  Crea una matrix con las desviaciones tipicas para cada variable con el numero de filas igual a la matrix X	
      partial.Indicators <- mDif.abs * mdesT ### Crea la matrix Tipificada 
      mI <- as.matrix(partial.Indicators)
      return(partial.Indicators)
    } 
    
    # Devuelve el índice de Frechet de la matriz pasada como referencia
    indiceFrechet = function (matriz){
      iF <- matrix(rowSums(matriz), ncol=1) ### Calcula el Indice Freshet: Suma las filas (municipios) de la matrix Tipificada
      colnames(iF) <- "Frechet.Index" # Dar nombre a la variable Indice de Freshet: IF
      return(iF)
    }
    
    # Ordena las variables de matriz teniendo en cuenta el vector de referencia
    # Devuelve el orden de las variables
    ordenarVariables = function (matriz, referencia){
      colnames(referencia) <- "Reference"
      mVTF <- cbind (matriz, referencia) # Une las dos matrices y obtiene una matriz de m filas y n+1 columnas
      mCor <- cor(mVTF) # Crea la correlación entre cada variable tipificada y el IF o el DP
      vCor <- mCor[colnames(referencia),] # Creo un vector que contenga solamente la correlacion del IF (o DP) con el resto de variables
      vCorAbs <- abs(vCor) # Valores absolutos de la correlación 
      vCorSort <- sort(vCorAbs, decreasing=TRUE) # Ordeno los valores de la correlacion decrecientemente
      vCorSort <- vCorSort[!names(vCorSort) == "Reference"] # Elimino el primer valor que es la correlacion de IF (DP) con IF (DP)
      
      nombres.Ord <- names(vCorSort) # Obtengo los nombres de las variables ordenados segun la correlacion 
      return(nombres.Ord)
    }
    
    # Función que calcula la matriz con los factores de ponderacion
    calculoFactoresPonderacion = function (matriz){
      m <- dim(matriz)[1] # Calcula el número de filas de la matrix X
      n <- dim(matriz)[2] # Calcula el número de columnas de la matrix X 
      vec.results <- numeric() # Creo un  objeto vacío
      for (i in 1:(n-1)) {vec.results[i] <- summary(lm(matriz[,i+1] ~ matriz[,1:i]))$r.squared}
      vect1 <- matrix(1,m,1) # Creo una matriz de 1 columna con el valor 1 y con m filas. 
      coefs <- matrix(vec.results, m, n-1, byrow=TRUE) # Obtengo una matrix con los coeficientes y con m filas
      mR.restado <- 1 - coefs # Calculo 1 - el coeficiente Rsquared
      mFacPond <- cbind(vect1, mR.restado) # Matriz con los factores de ponderacion 
      return(mFacPond)
    }
    
    calculoDP2 = function (matriz, matrizFactores, iteracion = 1){
      mDP <- matriz * matrizFactores 
      DP2 <- t(t(apply(mDP, MARGIN=1, sum)))
      colnames(DP2) <- paste("p2distance",iteracion, sep=".") 
      return(DP2)
    }
    
    #################################
    #################################	
    #################################
    
    #construimos la lista de resultados
    resultados <- list()
    diff_dps <- numeric()
    
    # calculamos la matriz con las distancias, el vector de refencia el predeterminado (min)
    mDif <- calcularDistancia(matriz, vector_referencia = reference_vector, funcion_v_referencia = reference_vector_function)
    
    #devolvemos también ese valor
    resultados$partial.Indicators = mDif
    
    # calculamos el indice de frechet
    dp2_aux <- indiceFrechet(mDif)	
    dps <- dp2_aux
    
    iteracion <- 1 #indice de las iteraciones	
    repeat{
      
      print(paste("Iteration", iteracion))
      
      #Ordenamos las variables según la importancia con respecto al vector
      nombres.Ord <- ordenarVariables(mDif, dp2_aux)
      
      #ordenamos la matriz
      mOrdTip <- mDif[,nombres.Ord] ### Reordeno la matriz tipificada segun la correlacion 
      
      #factores de ponderacion
      mFacPond <- calculoFactoresPonderacion(mOrdTip)
      
      dp2_aux <- calculoDP2(mOrdTip, mFacPond, iteracion = iteracion)
      
      #añadimos al vector común
      dps <- cbind(dps, dp2_aux)		
      diff_dps <- cbind(diff_dps, abs(dp2_aux - dps[,iteracion])) # calculamos las diferencias
      umbral_aux <- mean(diff_dps[,iteracion]) # calculamos el umbral alcanzado
      
      #Paramos si se da la condicion de parada del método
      if((iteracion >= iterations) || (umbral >= umbral_aux)) {break}
      
      #si hemos llegado aquí, incrementamos el contador
      iteracion <- iteracion + 1
      
    }
    
    resultados$discrimination.coefficient <- apply(abs(matriz), 2, discrimination.coefficient)
    resultados$p2distance <- dp2_aux
    resultados$diff_p2distances <- diff_dps
    resultados$p2distances <- dps
    resultados$iteration <- iteracion
    resultados$umbral <- umbral_aux	
    resultados$variables_sort <- nombres.Ord
    resultados$correction_factors <- mFacPond
    colnames(resultados$correction_factors) <- nombres.Ord
    resultados$correction_factors <- resultados$correction_factors[1,]
    resultados$cor.coeff <- cor(matriz, dp2_aux)
    
    # devolver los resultados
    return(resultados)
  }