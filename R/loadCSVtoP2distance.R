#' Load a CSV file into a matrix object
#'
#' Reads a text file and converts it into the matrix object expected by
#' [p2distance()].
#'
#' The first column of the file is used to set the row names of the
#' resulting matrix (typically the name of each spatial entity), and is then
#' removed from the data itself. Internally this uses [utils::read.table()]
#' to read the file.
#'
#' @param path The path of the file from which the data are to be read. Each
#'   row of the table appears as one line of the file.
#' @param header A logical value indicating whether the file contains the
#'   names of the variables as its first line.
#' @param sep The field separator character.
#' @param dec The character used in the file for decimal points.
#' @param quote The set of quoting characters. To disable quoting
#'   altogether, use `quote = ""`.
#' @param na.strings A character vector of strings to be interpreted as `NA`
#'   values.
#' @param fileEncoding Character string: if non-empty, declares the encoding
#'   used in the file so the character data can be re-encoded. See the
#'   "Encoding" section of `?file`.
#' @param encoding Encoding to be assumed for input strings.
#'
#' @return A matrix containing the data from the CSV file, ready to be
#'   passed to [p2distance()].
#'
#' @seealso [p2distance()]
#'
#' @importFrom utils read.table
#' @export
loadCSVtoP2distance <- function (path, header=TRUE, 
                                 sep="\t", dec=".", 
                                 quote="\"", 
                                 na.strings="NA", 
                                 fileEncoding = "", 
                                 encoding = "unknown") {
  matriz <- read.table(path, header = header, sep = sep, dec = dec, quote = quote, na.strings = na.strings, fileEncoding = fileEncoding, encoding = encoding) 
  
  # Coger los nombres de los municipios 
  nombres <- matriz[,1]
  # Eliminar la columna de municipios y ponerlos como nombres de filas. 
  matriz.datos <- matriz[-1]
  row.names(matriz.datos) <- nombres
  
  return(as.matrix(matriz.datos))
}