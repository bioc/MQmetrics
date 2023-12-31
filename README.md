
# MQmetrics

<!-- badges: start -->
<!-- badges: end -->

MQmetrics serves as a tool to analyze the quality of the proteomics data
coming from the LC-MS/MS. As input, it takes the directory to the files
resulting from a MaxQuant analysis and returns a pdf with diverse
parameters.

## Installation

You can install the stable version of MQmetrics from Biocodunctor with:

``` r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")


BiocManager::install("MQmetrics")
```

I highly advice to install the development version from bioconductor
since it contains several updates (check the news).

``` r
BiocManager::install("MQmetrics",  version = 'devel')
```

You can also install the latest version from
[GitHub](https://github.com/svalvaro/) if you know what you are doing
with:

``` r
# install.packages("devtools")
devtools::install_github("svalvaro/MQmetrics")
```

## Example

MQmetrics it’s easy to use, and will provide you information about your
Proteomics MaxQuant analysis.

Start by loading the library. By default, the MaxQuant results will be
stored in a folder named *Combined*. The directory to that folder is all
you need to use MQmetrics.

``` r
library(MQmetrics)

MQPathCombined <- "D:/Documents/MaxQuant_results/example5/combined/"
# Use forward slashes in both windows/or linux.
MQPathCombined <- "/home/alvaro/Documents/MaxQuant/example5/combined/"
```

The main function of the package is `generateReport()`. It will generate
a PDF report containing several visualizations and tables from different
MaxQuant output tables. As input it is only necessary to provide the
Path to the *Combined* folder of MaxQuant output.

``` r
generateReport(MQPathCombined, long_names = TRUE, sep_names = '_')
```

Two useful parameters of every function including `generateReport()`
are: *long\_names* and *sep\_names*. They will allow a clear
visualization of those samples that have long names separated by a
character. In this example, the Experiment names are one full string
separated by underscores (\_):
*PLK010\_QC02\_210121\_HeLa\_125ng\_150meth*.

``` r
# make_MQCombined reads all the files needed from the MaxQuant output and
# remove Potential contaminants, reverse, and proteins identified by site only.

MQCombined <- make_MQCombined(MQPathCombined, remove_contaminants = TRUE) 

PlotIntensity(MQCombined, long_names = TRUE, sep_names = '_')
```

<img src="man/figures/README-example_long_names-1.png" width="100%" />

Check the
[vignettes](https://bioconductor.org/packages/devel/bioc/vignettes/MQmetrics/inst/doc/MQmetrics.html)
for more information.
