library(shiny)
suppressPackageStartupMessages(
  library(shinyjs)
)
#library(datasets)
library(sqldf)
library(ggplot2)
trim <- function (x) gsub("^\\s+|\\s+$", "", x)
tabla<<-1


shinyServer(function(input, output,session) {
  output$title <- renderText({
    "Correlation of violence versus poverty in El Salvador"     
  })
  output$caption <- renderText({
     opt<-input$depto
     la<-""
     if (opt=="(All)") {
       la<-paste(la,'All Country',sep="")
     }else{
       la<-paste(la,'Department Of ',opt,sep="")
     }
     la     
  })
  
  output$view <- renderTable({
    opt<-input$Type
    a<-"select * from Q"
    if (opt=="Data" )
       hide("mpgPlot")
    else
      show("mpgPlot")
    
    if ((opt=="Data") | (opt=="Both")){
      opt2<-input$depto
      if (opt2 != "(All)")
        a<-paste(a," where depto like '%", trim(opt2),"%'",sep="")  
      #print(a)
      Q<-read.csv(file = "datos.csv")
      F<-sqldf(a)    
      F
    }    
  })
  output$mpgPlot <- renderPlot({
    opt<-input$Type
    a<-"select * from Q"
    if ((opt=="Correlation") | (opt=="Both")){
      opt2<-input$depto
      if (opt2 != "(All)")
        a<-paste(a," where depto like '%", trim(opt2),"%'",sep="")  
      Q<-read.csv(file = "datos.csv")
      F<-sqldf(a)        
      MU<-input$tcolor
      if (MU)
        ggplot(F, aes(x=Violencia, y=Pobreza))+ geom_point(aes(colour=Municipio),size=3)+geom_smooth(method=lm)
      else
        ggplot(F, aes(x=Violencia, y=Pobreza))+ geom_point(shape=1)+geom_smooth(method=lm)
    }
  })
})
