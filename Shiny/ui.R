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
                       value=1, min=1890, max=2016),
           sliderInput(inputId="leto2",
                       label="Izberi si zgornjo letnico",
                       value=1, min =1890, max=2016),
           plotOutput("bla")
  ),
########################################################
  tabPanel("Popularne zvrsti skozi zgodovino",
             selectInput(inputId="zvrst", label="zvrst", choices=c("","Rap","Rock","Country","Newage","Pop", "R&B","Alternative",
                                                                   "Club","Latin","Reggae","Electronica","Techno","World",
                                                                   "Vocal","Gospel","Folk","Jazz","Comedy","Dance","Easy",
                                                                   "Benefit","Singer-Songwriter","Blues","Ensemble",
                                                                   "Adult Contemporary", "Soundtrack","Disco","New-Wave",
                                                                   "Christmas","Techno-Rock","Big Band", "Celtic","Child",
                                                                   "Children's", "Bluegrass","Easy Listening","Cajun","Spoken") ),
             plotOutput("heh")),
##########################################################################################
  tabPanel("Koliko pesmi je na lestvici ostalo določeno obdobje",
           selectInput(inputId="stt", label="Izberi število tednov, ki te zanima", choices=c(1:50)),
           plotOutput("mah"))
           )

            



)    
)



