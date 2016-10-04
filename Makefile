CACHE_DIR = ./downloaded-data

get_data:
	make get_disag_data
	make get_acct_summ_data
	make get_title_I_data

clean_data:
	make clean_title_I_data
	make clean_eddie_data
	make clean_acctsumm

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

COLS="school_year,lea_code,school_code,school_name,total_resident_children,number_low_income_students,percent_low_income_students,served_1st_year"
clean_title_I_data:
	mkdir -p ./cleaned/2015-16
	mkdir -p ./cleaned/2014-15
	mkdir -p ./cleaned/2013-14

	in2csv downloaded-data/ncdpi/titleI/2015-16.xls | python scripts/normalize-header.py > ./cleaned/2015-16/titleI.csv
	in2csv downloaded-data/ncdpi/titleI/2014-15.xlsx | python scripts/normalize-header.py > ./cleaned/2014-15/titleI.csv
	in2csv downloaded-data/ncdpi/titleI/2013-14.xls | python scripts/normalize-header.py > ./cleaned/2013-14/titleI.csv
	

	csvcut -c $(COLS) ./cleaned/2015-16/titleI.csv > ./cleaned/2015-16/titleI_ss.csv
	csvcut -c $(COLS) ./cleaned/2014-15/titleI.csv > ./cleaned/2014-15/titleI_ss.csv
	csvcut -c $(COLS) ./cleaned/2013-14/titleI.csv > ./cleaned/2013-14/titleI_ss.csv

	csvstack ./cleaned/2015-16/titleI_ss.csv ./cleaned/2014-15/titleI_ss.csv ./cleaned/2013-14/titleI_ss.csv \
		| python ./scripts/clean_titleI.py > ./cleaned/titleI.csv

COLS_2="school_year,lea_code,school_type,school_code,school_name,official_school_name,address_line1,address_line2,city,state,zip_code_5,opening_effective_date,grade_level_current,school_type_description,school_program_type_description,school_calendar_description"
clean_eddie_data:
	for year in 2015-16 2014-15 2013-14; do \
		mkdir -p ./cleaned/$$year; \
		csvcut -e latin1 downloaded-data/eddie/$$year/active_lea_school_district_schools_report.csv \
			| python scripts/clean_eddie.py $$year school_district \
			| csvcut -c $(COLS_2) > cleaned/$$year/eddie_school_district.csv; \
		csvcut -e latin1 downloaded-data/eddie/$$year/active_charter_schools_report.csv \
			| python scripts/clean_eddie.py $$year charter \
			| csvcut -c $(COLS_2) > cleaned/$$year/eddie_charter.csv; \
	done

	csvstack cleaned/*/eddie_*csv > cleaned/schools.csv

clean_acctsumm:
	python scripts/clean_acctsumm.py downloaded-data/ncdpi/acctsumm/acctsumm16.xlsx 6 \
		> cleaned/2015-16/acctsumm.csv
	python scripts/clean_acctsumm.py downloaded-data/ncdpi/acctsumm/acctsumm15.xlsx 6 \
		> cleaned/2014-15/acctsumm.csv
	python scripts/clean_acctsumm.py downloaded-data/ncdpi/acctsumm/acctsumm14.xlsx 4 \
		> cleaned/2013-14/acctsumm.csv

	python scripts/stack_acctsumm.py > cleaned/acctsumm.csv

clean_disag:
	mkdir -p ./cleaned/

	cd downloaded-data/ncdpi/disag/; \
	unzip -jo disag1516.zip; \
	unzip -jo disag1415.zip; \
	unzip -jo disag1314.zip; \

	python scripts/merge_disag.py downloaded-data/ncdpi/disag/ cleaned/disag.db

remove_disag_files:
	cd downloaded-data/ncdpi/disag/; \
	rm *.txt *.doc
