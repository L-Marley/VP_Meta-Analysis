# metagear v. 0.1 and 0.2 version of 'plot_PRISMA()'
# author: Marc J. Lajeunesse, University of South Florida, lajeunesse@usf.edu
# website: http://lajeunesse.myweb.usf.edu
# updated: 11/13/2015

library(grid)
source("plot_PRISMA_utils.R")
source("plot_PRISMA.R")

phases <- c("START_PHASE: # of studies identified through database searching",
            "START_PHASE: # of additional studies identified through other sources",
            "# of studies after duplicates removed",
            "# of studies with title and abstract screened",
            "EXCLUDE_PHASE: # of studies excluded",
            "# of full-text articles assessed for eligibility",
            "EXCLUDE_PHASE: # of full-text articles excluded, not fitting eligibility criteria",
            "# of studies included in qualitative synthesis",
            "EXCLUDE_PHASE: # studies excluded, incomplete data reported",
            "final # of studies included in quantitative synthesis (meta-analysis)")

plot_PRISMA(phases)

