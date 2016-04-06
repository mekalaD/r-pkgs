# TODO: Add comment
# 
# Author: mekala
###############################################################################




		library(RMySQL)
		library(RODBC)
		library(timeSeries)
		library(forecast)
		library(timeDate)
		library(dplyr)
		library(zoo)
		library(lubridate)
		library(ggplot2)
		library(Amelia)
		library(mice)

	data<-function() {
		con <- dbConnect(dbDriver("MySQL"),
		user="root", password="",
		dbname="AppsOneDemo", host="10.1.1.152", port = 3333)
		on.exit(dbDisconnect(con))

		df_txn <- as.data.frame(dbReadTable(con,"TEST",row.names=NULL))
		df_KPI_APACHE <- as.data.frame(dbReadTable(con,"APACHE_FCCAPP",row.names=NULL))
		df_txn_id_name_map <- as.data.frame(dbReadTable(con,"TESTMAP",row.names=NULL))
#df_KPI_DB_NET <- as.data.frame(dbReadTable(con,"DB_NET",row.names=NULL))
		
# Get transaction and KPI for single time in same row
		df_txn_KPI <- merge(df_txn, df_KPI_APACHE, by = "Time") # 2 rows
		return(df_txn_KPI)
		
		#df_txn_KPI[["Time"]]  <- strptime(x = as.character(df_txn_KPI[["Time"]] ),
		#format = "%Y-%m-%d %H:%M:%S")
		
		#df_txn_KPI[is.na(df_txn_KPI)] <- 0
		
	}

