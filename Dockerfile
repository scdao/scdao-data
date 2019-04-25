FROM rocker/tidyverse:3.5.1

WORKDIR /scdao-data

# Set up shiny
COPY dashboard/config/shiny-server.conf /etc/shiny-server/shiny-server.conf
RUN export ADD=shiny && bash /etc/cont-init.d/add
RUN ln -s /opt/shiny-server/samples/welcome.html /scdao-data/index.html
RUN ln -s /opt/shiny-server/samples/sample-apps /scdao-data/sample-apps

# Install R dependencies
RUN apt-get update && apt-get install -y libv8-dev libproj-dev
RUN R -e "install.packages('odbc', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('shinyWidgets', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('scales', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('DT', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('randomcoloR', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('measurements', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('proj4', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('ggalt', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('ggthemes', repos='http://cran.rstudio.com/')"

# TODO: install needed Oracle drivers if making a direct connection

COPY . /scdao-data
