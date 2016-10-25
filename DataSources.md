---
title: Data Sources
---

# School performance

## NC DPI Accountability and Testing Summary Results

These are the school "grades". Description is here: http://www.ncpublicschools.org/docs/accountability/reporting/spgbckgrndpack15.pdf. 

Data may be found here: http://www.ncpublicschools.org/accountability/reporting/

2015-2016 results are here: http://www.dpi.state.nc.us/docs/accountability/reporting/acctsumm16.xlsx

## NC DPI School Accountability disaggregated data

Main site for the data is here: http://www.ncpublicschools.org/accountability/reporting/leaperformancearchive/

Data for the last three years is stored as zipped data. The 2015-2016 school year, for example, may be found here: http://www.ncpublicschools.org/docs/accountability/reporting/disag1516.zip

Data sets for 2012-2013 and prior may be found here: http://accrpt.ncpublicschools.org/docs/disag_datasets/.

It'd be real cool if there were a codebook or something to help me understand what this data is.

## NC Report Cards

http://www.ncreportcards.org/src/

Must pull data manually, one school, one year at a time. The data is pretty awful in terms of content and presentation.

## NC SAT performance

http://www.ncpublicschools.org/accountability/reporting/sat/

Data is stored in Excel. 

2016 data is found here: http://www.ncpublicschools.org/docs/accountability/reporting/sat/2016/satprfrm1516.xlsx

2015 data is found here: http://www.ncpublicschools.org/docs/accountability/reporting/sat/2015/satresults15.xls

Should be possible to script fetching the URLs. Structure of the file is pretty awful, but I've seen worse. Data goes as far back as 1995.

## AP reports

Again, Excel. The URLs don't use a common naming scheme, but there are only three years. Looks to be a manual munge.

http://www.ncpublicschools.org/docs/accountability/reporting/apresults15.xlsx
http://www.ncpublicschools.org/docs/accountability/reporting/aptestresults14.xlsx
http://www.ncpublicschools.org/docs/accountability/reporting/apresults1113.xls

Data may be found here: http://www.dpi.state.nc.us/docs/program-monitoring/titleIA/2015-16.xls

## Cohort graduation rates

http://www.ncpublicschools.org/accountability/reporting/cohortgradrate

# Ancillary data

## School disciplinary action

http://www.ncpublicschools.org/research/discipline/reports/#consolidated

## NC DPI Title I schools

http://www.dpi.state.nc.us/program-monitoring/titleIA/

## National Center for Education Statistics

This will give a list of all public schools for specific academic years. Construction of the data is manual.

http://nces.ed.gov/ccd/elsi/

## American Community Survey

The data may be manually gathered from the Census website: https://www.census.gov/programs-surveys/acs/

Much easier to fetch the data using the R package `acs`.

# 

## NC Wise

Jeebus, what the @#$# is this? http://www.ncwise.org/
http://www.ncwise.org/documents/contact_us/NCWISE_Schools.pdf

# Wish list

* School funding
    * By source
    * Federal
    * State
    * Local
    * Bond issues?
* School spending
    * Instructional services
    * system-wide support services
    * Ancillary services
    * non-programmed charges (includes charter)
    * Capital outlay