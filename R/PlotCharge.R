#' The charge-state of the precursor ion.
#'
#' @param MQCombined Object list containing all the files from the MaxQuant
#' output. It is the result from using \code{make_MQCombined}.
#' @param palette The palette from the Package RColorBrewer. By default is
#' 'Set2'.
#' @param plots_per_page Establish the maximum number of plots per page.
#' @param tabular_output If true a table with the information will be the
#' output.
#'
#'
#' @return Plots the charge-state of the precursor ion.
#' @export
#'
#' @examples
#' MQPathCombined <- system.file("extdata/combined/", package = "MQmetrics")
#' MQCombined <- make_MQCombined(MQPathCombined)
#' PlotCharge(MQCombined)
PlotCharge <- function(MQCombined,
                        palette = "Set2",
                        plots_per_page = 5,
                        tabular_output = FALSE) {

    evidence <- MQCombined$evidence.txt

    Experiment <- Charge <- value <- variable <- NULL

    ev <- evidence %>% select(c(Experiment, Charge))

    ev_agrup <- dcast(ev, Experiment ~ Charge, fill = 0)

    ev_agrup_m <- melt(ev_agrup, id.vars = "Experiment")


    if (tabular_output == TRUE) {
        charge_percentage <- ev_agrup[,-1]/rowSums(ev_agrup[,-1])*100

        charge_percentage <- cbind(
            ev_agrup$Experiment,
            format(round(charge_percentage,1),
                    nsmall =1))

        names(charge_percentage)[1] <- 'Experiment'

        return(charge_percentage)
    }

    n_pages_needed <- ceiling(
        length(unique(ev_agrup$Experiment)) / plots_per_page
    )

    colourCount <- length(unique(ev$Experiment))

    getPalette <- colorRampPalette(brewer.pal(8, palette))


    myplots = list()

    for (ii in seq_len(n_pages_needed)) {
        if (colourCount < plots_per_page) {
            nrow <- colourCount
        } else {
            nrow <- plots_per_page
        }

        p <- ggplot(ev_agrup_m, aes(
            x = variable,
            y = value,
            fill = Experiment
        )) +
            geom_bar(stat = "identity", color = "black") +
            scale_fill_manual(values = getPalette(colourCount)) +
            facet_wrap_paginate(. ~ Experiment,
                                ncol = 1,
                                nrow = nrow,
                                page = ii) +
            ggtitle(label = "The charge-state of the precursor ion.") +
            theme(legend.position = "none") +
            ylab("Ion Frequency") +
            xlab(label = "Charge") +
            theme_bw() +
            theme(legend.position = "none")

        myplots[[ii]] <- p
    }
    return(myplots)
}
