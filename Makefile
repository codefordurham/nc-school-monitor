CACHE_DIR = ./downloaded-data
#ROOT_DIR = 

get_disag_data:
	# NC DPI School Accountability disaggregated data
	mkdir -p $(CACHE_DIR)/ncdpi/disag; \
	cd $(CACHE_DIR)/ncdpi/disag; \
	wget -N http://www.ncpublicschools.org/docs/accountability/reporting/disag1516.zip; \
	wget -N http://www.ncpublicschools.org/docs/accountability/reporting/disag1415.zip; \
	wget -N http://www.ncpublicschools.org/docs/accountability/reporting/disag1314.zip; \
