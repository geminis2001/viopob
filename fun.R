leerdep <- function(){
  Q<-read.csv(file = "datos.csv",stringsAsFactors=FALSE)
  a<-"select distinct DEPTO from Q union all select '(All)' DEPTO order by 1"
  r<-sqldf(a)
  r
  
  
}