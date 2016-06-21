shinyUI(fluidPage(
  
  titlePanel("Glasba in mediji skozi zgodovino"),
  
  tabsetPanel(
    
    
#####################################    
    tabPanel("Histogram medijev",  
      sliderInput(inputId="leto",
                  label="Izberi letnico",
                  value=1, min =1955, max=2016),
      
      plotOutput("hist")
    ),
########################################################
  tabPanel("Koliko tednov je pesem ostala na lestici",
           sliderInput(inputId="leto1", label= "Izberi si spodnjo letnico",
                       value=1, min=1955, max=2016),
           sliderInput(inputId="leto2",
                       label="Izberi si zgornjo letnico",
                       value=1, min =1955, max=2016),
           plotOutput("bla")
  )
########################################################
  )    
))



