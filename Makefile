.DEFAULT_GOAL := help

# ==================================================================================== #
# VARIABLES
# ==================================================================================== #

PACKAGE_MANAGER := npm

# ==================================================================================== #
# DEVELOPMENT
# ==================================================================================== #

.PHONY: start
start: ## Start the Discord Tickets bot
	$(PACKAGE_MANAGER) start

.PHONY: studio
studio: ## Open Prisma Studio for database management
	$(PACKAGE_MANAGER) run studio

# ==================================================================================== #
# CODE QUALITY
# ==================================================================================== #

.PHONY: lint
lint: ## Run ESLint with auto-fix
	$(PACKAGE_MANAGER) run lint

.PHONY: test
test: ## Run i18n tests
	$(PACKAGE_MANAGER) test

# ==================================================================================== #
# UTILITIES
# ==================================================================================== #

.PHONY: keygen
keygen: ## Generate encryption key
	$(PACKAGE_MANAGER) run keygen

.PHONY: changelog
changelog: ## Generate changelog
	$(PACKAGE_MANAGER) run changelog

# ==================================================================================== #
# CONTRIBUTORS
# ==================================================================================== #

.PHONY: contributors-add
contributors-add: ## Add a contributor (requires name)
	$(PACKAGE_MANAGER) run contributors:add

.PHONY: contributors-gen
contributors-gen: ## Generate contributors list
	$(PACKAGE_MANAGER) run contributors:generate

# ==================================================================================== #
# SETUP & MAINTENANCE
# ==================================================================================== #

.PHONY: setup
setup: ## Install dependencies
	$(PACKAGE_MANAGER) install

.PHONY: clean
clean: ## Remove node_modules and build artifacts
	rm -rf node_modules
	rm -rf .turbo

# ==================================================================================== #
# HELPERS
# ==================================================================================== #

.PHONY: help
help: ## Show this help message
	@echo "Discord Tickets Bot"
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "Most popular open-source ticket management bot for Discord"
	@echo "Homepage: https://discordtickets.app"
