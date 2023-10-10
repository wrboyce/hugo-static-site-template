help:
	@echo "Usage: make [command] …"
	@echo "Commands:"
	@echo "serve				  Run the development server"
	@echo "build				   Build the production site"
	@echo "clean		      Delete production build assets"
	@echo "deploy		    Deploy site to configured target"

serve:
	hugo server --environment=development \
		--logLevel=debug \
		--buildDrafts \
		--buildFuture

build:
	hugo --environment=production \
		--logLevel=debug \
		--enableGitInfo \
		--printI18nWarnings \
		--printMemoryUsage \
		--printUnusedTemplates \
		--templateMetrics \
		--templateMetricsHints

clean:
	rm -rf public/ resources/

deploy:
	hugo deploy --environment=production \
		--logLevel=debug

.PHONY: help serve build clean deploy
