# Makefile for Aurora Boreas

.PHONY: help build test lint clean install release-test release-dry-run dev-setup

# Variables
BINARY_NAME=aurora
VERSION=$(shell git describe --tags --abbrev=0 2>/dev/null || echo "v0.1.0")
COMMIT=$(shell git rev-parse --short HEAD 2>/dev/null || echo "unknown")
DATE=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
LDFLAGS=-s -w -X main.version=$(VERSION) -X main.commit=$(COMMIT) -X main.date=$(DATE)

# Colors for output
GREEN=\033[0;32m
YELLOW=\033[1;33m
BLUE=\033[0;34m
NC=\033[0m

help: ## Show this help message
	@echo "$(BLUE)Aurora Boreas - Makefile Commands$(NC)"
	@echo "=================================="
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "$(GREEN)%-20s$(NC) %s\n", $$1, $$2}'

dev-setup: ## Setup development environment
	@echo "$(YELLOW)Setting up development environment...$(NC)"
	go mod download
	go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
	go install github.com/goreleaser/goreleaser@latest
	pre-commit install
	@echo "$(GREEN)Development environment ready!$(NC)"

build: ## Build the binary
	@echo "$(YELLOW)Building Aurora Boreas...$(NC)"
	CGO_ENABLED=0 go build -ldflags="$(LDFLAGS)" -o bin/$(BINARY_NAME) ./cmd/main.go
	@echo "$(GREEN)Binary built: bin/$(BINARY_NAME)$(NC)"

build-all: ## Build for all platforms
	@echo "$(YELLOW)Building for all platforms...$(NC)"
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -ldflags="$(LDFLAGS)" -o bin/$(BINARY_NAME)-linux-amd64 ./cmd/main.go
	GOOS=darwin GOARCH=amd64 CGO_ENABLED=0 go build -ldflags="$(LDFLAGS)" -o bin/$(BINARY_NAME)-darwin-amd64 ./cmd/main.go
	GOOS=windows GOARCH=amd64 CGO_ENABLED=0 go build -ldflags="$(LDFLAGS)" -o bin/$(BINARY_NAME)-windows-amd64.exe ./cmd/main.go
	@echo "$(GREEN)All binaries built in bin/$(NC)"

test: ## Run tests
	@echo "$(YELLOW)Running tests...$(NC)"
	go test -v -race -coverprofile=coverage.out ./...
	@echo "$(GREEN)Tests completed!$(NC)"

test-coverage: test ## Run tests with coverage report
	@echo "$(YELLOW)Generating coverage report...$(NC)"
	go tool cover -html=coverage.out -o coverage.html
	@echo "$(GREEN)Coverage report generated: coverage.html$(NC)"

lint: ## Run linter
	@echo "$(YELLOW)Running linter...$(NC)"
	golangci-lint run
	@echo "$(GREEN)Linting completed!$(NC)"

lint-fix: ## Run linter with auto-fix
	@echo "$(YELLOW)Running linter with auto-fix...$(NC)"
	golangci-lint run --fix
	@echo "$(GREEN)Linting and fixes completed!$(NC)"

clean: ## Clean build artifacts
	@echo "$(YELLOW)Cleaning build artifacts...$(NC)"
	rm -rf bin/ dist/ coverage.out coverage.html
	@echo "$(GREEN)Cleaned!$(NC)"

install: build ## Install binary to system
	@echo "$(YELLOW)Installing Aurora Boreas...$(NC)"
	sudo cp bin/$(BINARY_NAME) /usr/local/bin/
	@echo "$(GREEN)Aurora Boreas installed to /usr/local/bin/$(BINARY_NAME)$(NC)"

run: build ## Build and run the application
	@echo "$(YELLOW)Running Aurora Boreas...$(NC)"
	./bin/$(BINARY_NAME)

docker-build: ## Build Docker image
	@echo "$(YELLOW)Building Docker image...$(NC)"
	docker build -t nataliagranato/auroraboreas:latest .
	@echo "$(GREEN)Docker image built!$(NC)"

docker-run: docker-build ## Build and run Docker container
	@echo "$(YELLOW)Running Docker container...$(NC)"
	docker run --rm nataliagranato/auroraboreas:latest

release-test: ## Test GoReleaser configuration
	@echo "$(YELLOW)Testing GoReleaser configuration...$(NC)"
	goreleaser check
	@echo "$(GREEN)GoReleaser configuration is valid!$(NC)"

release-dry-run: ## Dry run of release process
	@echo "$(YELLOW)Running GoReleaser dry run...$(NC)"
	goreleaser release --snapshot --clean
	@echo "$(GREEN)Dry run completed! Check dist/ directory$(NC)"

release-local: ## Create a local release
	@echo "$(YELLOW)Creating local release...$(NC)"
	goreleaser release --snapshot --clean --skip-publish
	@echo "$(GREEN)Local release created in dist/$(NC)"

tag: ## Create and push a new tag
	@read -p "Enter version (e.g., v1.0.0): " version; \
	git tag -a $$version -m "Release $$version"; \
	git push origin $$version; \
	echo "$(GREEN)Tag $$version created and pushed!$(NC)"

fmt: ## Format Go code
	@echo "$(YELLOW)Formatting code...$(NC)"
	go fmt ./...
	goimports -w .
	@echo "$(GREEN)Code formatted!$(NC)"

mod: ## Update Go modules
	@echo "$(YELLOW)Updating Go modules...$(NC)"
	go mod tidy
	go mod verify
	@echo "$(GREEN)Modules updated!$(NC)"

security: ## Run security checks
	@echo "$(YELLOW)Running security checks...$(NC)"
	gosec ./...
	@echo "$(GREEN)Security check completed!$(NC)"

bench: ## Run benchmarks
	@echo "$(YELLOW)Running benchmarks...$(NC)"
	go test -bench=. -benchmem ./...
	@echo "$(GREEN)Benchmarks completed!$(NC)"

generate: ## Generate code (mocks, etc.)
	@echo "$(YELLOW)Generating code...$(NC)"
	go generate ./...
	@echo "$(GREEN)Code generation completed!$(NC)"

# Development workflow
dev: lint test build run ## Complete development workflow: lint, test, build, and run

# CI workflow  
ci: lint test build ## CI workflow: lint, test, and build

# Pre-commit workflow
pre-commit: fmt lint test ## Pre-commit workflow: format, lint, and test

version: ## Show version information
	@echo "Aurora Boreas"
	@echo "Version: $(VERSION)"
	@echo "Commit:  $(COMMIT)"
	@echo "Date:    $(DATE)"

setup-homebrew: ## Setup Homebrew tap repository (deprecated - use update-homebrew)
	@echo "$(YELLOW)Setting up Homebrew tap...$(NC)"
	./scripts/setup-homebrew-tap.sh
	@echo "$(GREEN)Homebrew tap setup completed!$(NC)"

update-homebrew: ## Update Homebrew tap via GitHub Actions
	@echo "$(YELLOW)Updating Homebrew tap via GitHub Actions...$(NC)"
	./scripts/update-homebrew-tap.sh
	@echo "$(GREEN)Homebrew tap update initiated!$(NC)"

test-homebrew: ## Test Homebrew installation (requires tap to exist)
	@echo "$(YELLOW)Testing Homebrew installation...$(NC)"
	brew tap nataliagranato/tap || true
	brew install auroraboreas
	aurora --version
	@echo "$(GREEN)Homebrew test completed!$(NC)"

# Default target
.DEFAULT_GOAL := help
