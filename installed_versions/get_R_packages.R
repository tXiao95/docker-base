library(data.table)
installed <- data.table(installed.packages())
installed <- installed[, .SD, .SDcols = c('Package', 'Version')]
readr::write_csv(installed, '/tmp/R_packages.csv')
