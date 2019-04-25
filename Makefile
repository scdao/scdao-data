.PHONY := run
run: build
	docker run 	--rm \
				--name scdao-data-container \
				-p 8787:8787 \
				-p 3838:3838 \
				-e PASSWORD=$(RSTUDIO_PASSWORD) \
				scdao/scdao-data

.PHONY := shiny-logs
shiny-logs:
	tail -f /var/log/shiny-server/dashboard-shiny-*.log

.PHONY := logs
logs:
	docker exec scdao-data-container make shiny-logs

.PHONY := debug
debug:
	docker exec -it scdao-data-container bash

.PHONY := build
build:
	docker build --tag scdao/scdao-data .