CACHE_DIR = ./downloaded-data
#ROOT_DIR = 

get_disag_data:
	# NC DPI School Accountability disaggregated data
	mkdir -p $(CACHE_DIR)/ncdpi/disag
	cd $(CACHE_DIR)/ncdpi/disag; \
	wget -N http://www.ncpublicschools.org/docs/accountability/reporting/disag1516.zip; \
	wget -N http://www.ncpublicschools.org/docs/accountability/reporting/disag1415.zip; \
	wget -N http://www.ncpublicschools.org/docs/accountability/reporting/disag1314.zip; \

get_acct_summ_data:
	# NC DPI Accountability and Testing Summary Results
	# i.e. the school "grades"
	mkdir -p $(CACHE_DIR)/ncdpi/acctsumm
	cd $(CACHE_DIR)/ncdpi/acctsumm; \
	wget -N http://www.dpi.state.nc.us/docs/accountability/reporting/acctsumm16.xlsx; \
	wget -N http://www.dpi.state.nc.us/docs/accountability/reporting/acctsumm15.xlsx; \
	wget -N http://www.dpi.state.nc.us/docs/accountability/reporting/acctsumm14.xlsx; \

get_title_I_data:
	# NC DPI Title I schools
	mkdir -p $(CACHE_DIR)/ncdpi/titleI
	cd $(CACHE_DIR)/ncdpi/titleI; \
	wget -N http://www.dpi.state.nc.us/docs/program-monitoring/titleIA/2015-16.xls; \
	wget -N http://www.dpi.state.nc.us/docs/program-monitoring/titleIA/2014-15.xlsx; \
	wget -N http://www.dpi.state.nc.us/docs/program-monitoring/titleIA/2013-14.xls; \


