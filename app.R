library(shiny)
library(tidyverse)
library(palmerpenguins)

### Create a user interface
ui<- fluidPage(
  titlePanel('I am adding a title'),
  sidebarLayout(
    sidebarPanel('Put my widgets here',
                 radioButtons(inputId = 'penguin_species',
                              label = 'Choose penguin species',
                              choices = c('Adelie', 'Gentoo', 'Chinstrap')),
                 'choose a color',
                 selectInput(inputId = 'pt_color',
                             label = 'choose your favorite color',
                             choices = c('awesome red' = 'red',
                                         'pretty purple' = 'purple',
                                         'ooorange' = 'orange'))
                 ), ### end sidebarPanel
    mainPanel('Put my graph here',
              plotOutput(outputId = 'penguin_plot'),
              tableOutput(outputId = 'penguin_table')
              ) ### end main panel
  ) ### end sidebarLayout
) ### end fluidPage



### Create the server function
server <- function(input, output) {
  penguin_select <- reactive({
    penguins %>%
      filter(species == input$penguin_species)
  })

  penguin_table <- reactive({
    penguins %>%
      filter(species == input$penguin_species) %>%
      group_by(sex) %>%
      summarize(mean_flip = mean(flipper_length_mm),
                mean_mass = mean(body_mass_g))
  }) ### end penguin_table

  output$penguin_plot <- renderPlot({
    ggplot(data = penguin_select(),
           aes(x = flipper_length_mm, y = body_mass_g)) +
      geom_point(color = input$pt_color)
  })

  output$penguin_table <- renderTable({
    penguin_table()
  })

}

### combine these into an app
shinyApp(ui = ui, server = server)
