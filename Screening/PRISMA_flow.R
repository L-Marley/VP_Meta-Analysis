library(metagear)
setwd("C:/Users/Liam Marley/OneDrive/University Work/MRes/Research Dissertation/Analysis Project/VP_Meta-Analysis/Screening")

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

PRISMA_plot <- plot_PRISMA(aPhaseVector = phases, design = "classic")
