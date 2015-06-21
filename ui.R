library(shiny)
suppressPackageStartupMessages(
  library(shinyjs)
)
library(sqldf)
source("./fun.R")

# Define UI for dataset viewer application
shinyUI(fluidPage(
  useShinyjs(),
  # Application title
  titlePanel("Violence/poverty"),
  
  # Sidebar with controls to provide a caption, select a dataset,
  # and specify the number of observations to view. Note that
  # changes made to the caption in the textInput control are
  # updated in the output area immediately as you type
  sidebarLayout(
    sidebarPanel(
      selectInput("depto", "Choose a Department:", 
                  choices = c(leerdep())),
      #selectInput("Munic", "Choose a municipality:", 
      #            choices = c("Quezaltepeque", "Nejapa")),
      
      selectInput("Type", "Choose a Type:",choices = c("Correlation","Data","Both")),
      checkboxInput("tcolor","Include Municipalities in graph",FALSE)
      
            
    ),
    
    
    # Show the caption, a summary of the dataset and an HTML 
	 # table with the requested number of observations
    mainPanel(
      #h3(textOutput("caption", container = span)),
      #verbatimTextOutput("summary"), 
      
      #
      h4(textOutput("title",container = span),align="center"),
      h4(textOutput("caption",container = span),align="center"),    
      plotOutput("mpgPlot"),
      tableOutput("view")
    )
  )
))
