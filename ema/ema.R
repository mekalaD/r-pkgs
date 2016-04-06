# TODO: Add comment
# 
# Author: mekala
###############################################################################

library("doParallel")
registerDoParallel(cores=2)
process<-function(df,columns,method,windowLength) {

	startTime=Sys.time();
	foreach(x=1:ncol(df)) %dopar% {
		ema(df[x],windowLength)
	}
	print(Sys.time() - startTime)
}

ema<-function(df1,n) {

	count<-nrow(df1)
	## Checks if the first element is NA if yes then replace with 0
	if(is.na(df1[1,])=="TRUE")
	{df1[1,]<-0}
	## For loop starts
	for (i in 2:n)
	{ ### if the values are less than n
		if(is.na(df1[i,])=="TRUE")
		{df1[i,]<-mean(df1[1:(i-1),])}
	}
	### if the values are greater than n
	for (i in n+1:(count-(n)))
	{
		if(is.na(df1[i,])=="TRUE")
		{df1[i,]<-mean(df1[(i-n):(i-1),])}
	} 
	return (df1);
}

process1<-function(df,columns,method,windowLength) {
	
	startTime=Sys.time();
	for ( x in 1:ncol(df)){
		ema(df[x],windowLength)
	}
	print(Sys.time() - startTime)
}

process(df_txn_KPI[1:100000,2:3],colnames(df_txn_KPI[1:100000,2:3]),"test",3)

process1(df_txn_KPI[1:100000,2:3],colnames(df_txn_KPI[1:100000,2:3]),"test",3)

