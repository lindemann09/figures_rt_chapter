render:
	docker run -it -v  $(shell pwd):/files ghcr.io/racklet/render-drawio-action:v1 --formats png
	Rscript Posner.R
