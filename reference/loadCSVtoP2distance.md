# Load a CSV file into a matrix object

Reads a text file and converts it into the matrix object expected by
[`p2distance()`](https://ajpelu.github.io/p2distance/reference/p2distance.md).

## Usage

``` r
loadCSVtoP2distance(
  path,
  header = TRUE,
  sep = "\t",
  dec = ".",
  quote = "\"",
  na.strings = "NA",
  fileEncoding = "",
  encoding = "unknown"
)
```

## Arguments

- path:

  The path of the file from which the data are to be read. Each row of
  the table appears as one line of the file.

- header:

  A logical value indicating whether the file contains the names of the
  variables as its first line.

- sep:

  The field separator character.

- dec:

  The character used in the file for decimal points.

- quote:

  The set of quoting characters. To disable quoting altogether, use
  `quote = ""`.

- na.strings:

  A character vector of strings to be interpreted as `NA` values.

- fileEncoding:

  Character string: if non-empty, declares the encoding used in the file
  so the character data can be re-encoded. See the "Encoding" section of
  [`?file`](https://rdrr.io/r/base/connections.html).

- encoding:

  Encoding to be assumed for input strings.

## Value

A matrix containing the data from the CSV file, ready to be passed to
[`p2distance()`](https://ajpelu.github.io/p2distance/reference/p2distance.md).

## Details

The first column of the file is used to set the row names of the
resulting matrix (typically the name of each spatial entity), and is
then removed from the data itself. Internally this uses
[`utils::read.table()`](https://rdrr.io/r/utils/read.table.html) to read
the file.

## See also

[`p2distance()`](https://ajpelu.github.io/p2distance/reference/p2distance.md)
