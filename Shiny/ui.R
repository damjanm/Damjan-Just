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
           #sliderInput(inputId="leto1", label= "Izberi si spodnjo letnico",
                       #value=1, min=1890, max=2016),
           #sliderInput(inputId="leto2",
                       #label="Izberi si zgornjo letnico",
                       #value=1, min =1890, max=2016),
           sliderInput(inputId="leto1", label= "Izberi si interval let",
                       value=c(1900, 2000), min=1890, max=2016),
           
           plotOutput("bla")
  ),
########################################################
  tabPanel("Popularne zvrsti skozi zgodovino",
             selectInput(inputId="zvrst", label="Zvrst", choices=c("","Rap","Rock","Country","Pop","R&B",
                                                                   "Latin","Reggae","Disco/Electro","Folk","Jazz","Blues") ),
             plotOutput("heh")),
##########################################################################################
  tabPanel("Koliko pesmi je na lestvici ostalo določeno obdobje",
           selectInput(inputId="stt", label="Izberi število tednov, ki te zanima", choices=c(1:50)),
           plotOutput("mah")),
##########################################################################################
  
tabPanel("Povprečna dolžina pesmi skozi čas",
         sliderInput(inputId = "povp_dolz",label="Izberi do katerega mesta na lestvici naj prikaze",value = 10, min = 1, max = 100),
         plotOutput("dolz"))
  )  



)    
)



