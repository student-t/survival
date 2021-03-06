options(na.action=na.exclude) # preserve missings
options(contrasts=c('contr.treatment', 'contr.poly')) #ensure constrast type
library(survival)

mdy.Date <- function(m, d, y) {
    y <- ifelse(y<100, y+1900, y)
    as.Date(paste(m,d,y, sep='/'), "%m/%d/%Y")
    }
#
# A test of the match.ratetable function, specifically the
#  change to allow partial matching of strings 
#  Note that 10,000 days old is 27.4 years
#
aeq <- function(x,y, ...) all.equal(as.vector(x), as.vector(y), ...)

temp1 <- data.frame(year=mdy.Date(2,2,1960:1964),
                    age =   10000 + 1:5,
                    sex = c('M', 'fema', 'f', 'ma', 'F'))

temp2 <- ratetable(year=temp1$year, age=temp1$age, sex=temp1$sex)
temp3 <- match.ratetable(temp2, survexp.us)
aeq(temp3$R[,2], c(1,2,2,1,2))
