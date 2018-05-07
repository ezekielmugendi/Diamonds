library(shiny)

library(ggplot2)

data <- as.data.frame(diamonds[,c(1:5,7)])
data$color <- as.factor(data$color)

ui <- fluidPage(
  
  titlePanel("Diamonds are Forever"),
  sidebarLayout(
    
    sidebarPanel(
      
      radioButtons("var", "Variable:",
                   list("carat"='a',
                        "cut"='b',
                        "color"='c', "clarity"='d', "depth"='e', "price"='f')),
      
      radioButtons("cut", "Quality cut bar_chart", "cut")
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      h3("Distribution analysis graph of the diamonds dataset"),
      plotOutput("distPlot"),
      h3("Bar_chart of Diamonds dataset grouped by cut"),
      plotOutput("cutplot")
      
    )
  )
)

server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    if(input$var=='a'){i<-1}
    if(input$var=='b'){i<-2}
    if(input$var=='c'){i<-3}
    if(input$var=='d'){i<-4}
    if(input$var=='e'){i<-5}
    if(input$var=='f'){i<-6}
    
    library(ggplot2)
    data <- as.data.frame(diamonds[,c(1:5,7)])
    data$color <- as.factor(data$color)
    x <- data[, i]
    plot(x)
  })
  output$cutplot <- renderPlot({
    library(ggplot2)
    data <- as.data.frame(diamonds[,c(1:5,7)])
    data$color <- as.factor(data$color) 
    ggplot(data) + 
      geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")
  })
  
}

shinyApp(ui=ui, server=server)