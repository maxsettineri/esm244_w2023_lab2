library(shiny)
library(tidyverse)
library(palmerpenguins)

### Create a user interface
ui<- fluidPage(
  titlePanel('I am ading a title'),
  sidebarLayout(
    sidebarPanel('Put my widgets here',
                 radioButtons(inputId = 'penguin_species',
                              label = 'Choose penguin species',
                              choices = c('Adelie', 'Gentoo', 'Chinstrap'))
                 ), ### end sidebarPanel
    mainPanel('Put my graph here')
  ) ### end sidebarLayout
) ### end fluidPage



### Create the server function
server <- function(input, output) {}

### combine these into an app
shinyApp(ui = ui, server = server)
