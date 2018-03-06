.PHONY: run
run: ## run the app
	foreman start

.PHONY: install
install: ## install the dependencies
	sudo pip install -r requirements.txt

.PHONY: lint
lint: ## lint the code
	flake8 *py

.PHONY: clean
clean: ## remove .pyc files
	find . -name "*pyc" -delete

.PHONY: foreman
foreman: install ## install the startup scripts
	rm -fr /tmp/inky-rest
	mkdir /tmp/inky-rest
	foreman export -a inky-rest -u pi systemd /tmp/inky-rest
	sudo rsync -av /tmp/inky-rest/ /etc/systemd/system/
	sudo systemctl daemon-reload
	sudo systemctl restart inky-rest.target

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
