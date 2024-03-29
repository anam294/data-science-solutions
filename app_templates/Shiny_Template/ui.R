sidebar <- dashboardSidebar(
  width = 300,
  hr(),
  sidebarMenu(
    id="tabs",
    menuItem(
      "Exploratory", icon = icon("bullseye"), startExpanded = TRUE, 
      menuSubItem("Descriptive Statistics", tabName = "descriptive", icon=icon("check")),
      menuSubItem("Distribution", tabName = "distribution", icon=icon("check"))
    ),
    menuItem("About", tabName="about", icon=icon("question-circle"))
  ) 
)

body <- dashboardBody(
  tabItems(
    tabItem(
      tabName = 'descriptive',  
  		fluidRow(
  		  column(
  		    width=3,
  		    selectInput(
  		      inputId = "vars",
  		      label = "Variables", 
  		      choices = structure(as.character(variables$colname[-1]), names=as.character(variables$label[-1])),
  		      multiple = FALSE
  		    )
  		  )
      ),
  		fluidRow(
  			column(
  			  width=6,
  				box(width=NULL, collapsible=TRUE, tableOutput('descriptive_table'))
        ),
  			column(
  			  width=6,
  				box(width = NULL, plotOutput('descriptive_visual'))
        )
  		)
    ),
    
    tabItem(
      tabName = "distribution",
      fluidRow(    		
        column(
          3, 
          selectInput(
            inputId="groups", 
            label="Groups", 
            choices=structure(
              as.character(subset(variables, type == 'categorical')$colname), 
              names = as.character(subset(variables, type == 'categorical')$label)
            ), 
            multiple=FALSE, selectize=TRUE)
          ), 
      	column(6, uiOutput("select_group")),
      	column(
      	  3, 
      	  selectInput(
      	    inputId="target", 
      	    label="Variables", 
      	    choices=structure(
      	      as.character(subset(variables, type == 'numeric')$colname), 
      	      names = as.character(subset(variables, type == 'numeric')$label)
      	    ), 
      	    multiple=FALSE, selectize=TRUE))
  		), 
  		fluidRow(
  			column(
  			  width=6,
  				box(width=NULL, tableOutput('dist_summary'))
        ),
  			column(
  			  width=6,
  				box(width = NULL, plotOutput('dist_visual'))
        )
      )
    ),
    tabItem(tabName = "about", includeHTML("www/about.html")) 
  )
)

dbHeader = dashboardHeader(
  title = "Data Science Academy", titleWidth = 300, 
  tags$li(a(img(src = 'spg_logo.png', height = "30px"), style = "padding-top:10px; padding-bottom:10px;"), class = "dropdown")
)

dashboardPage(
  skin = "black", 
  dbHeader,
  sidebar,
  body
)


