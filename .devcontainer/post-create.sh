#!/bin/bash
set -e

echo "🚀 Setting up Aurora Boreas development environment..."

# Update package lists
sudo apt-get update

# Install essential tools
sudo apt-get install -y \
    curl \
    wget \
    git \
    make \
    build-essential \
    ca-certificates \
    gnupg \
    lsb-release \
    jq \
    tree \
    htop \
    vim \
    unzip

# Install Go tools
echo "📦 Installing Go tools..."
go install -a github.com/golangci/golangci-lint/cmd/golangci-lint@v1.62.2
go install -a github.com/goreleaser/goreleaser@latest
go install -a gotest.tools/gotestsum@latest
go install -a github.com/vektra/mockery/v2@latest
go install -a github.com/swaggo/swag/cmd/swag@latest
go install -a golang.org/x/tools/cmd/goimports@latest
go install -a github.com/go-delve/delve/cmd/dlv@latest

# Verify Go tools installation
echo "🔍 Verifying Go tools installation..."
go version
golangci-lint version
goreleaser --version
gotestsum --version

# Install pre-commit
echo "📋 Installing pre-commit..."
pip3 install --user pre-commit

# Install mise tools based on mise.toml
echo "🛠️ Installing mise tools..."
mise install

# Set up git hooks
echo "🔗 Setting up git hooks..."
if [ -d ".git" ]; then
    pre-commit install --install-hooks
    pre-commit install --hook-type commit-msg
else
    echo "⚠️ Not a git repository, skipping git hooks setup"
fi

# Download Go dependencies
echo "📥 Downloading Go dependencies..."
go mod download
go mod tidy

# Create necessary directories
mkdir -p bin coverage logs

# Set up shell environment
echo "🐚 Setting up shell environment..."
echo 'export PATH="$PATH:$(go env GOPATH)/bin"' >> ~/.bashrc
echo 'export EDITOR=vim' >> ~/.bashrc
echo 'alias ll="ls -la"' >> ~/.bashrc
echo 'alias la="ls -A"' >> ~/.bashrc
echo 'alias l="ls -CF"' >> ~/.bashrc

# Create convenience scripts
echo "📝 Creating convenience scripts..."
cat > ~/dev-commands.sh << 'EOF'
#!/bin/bash
# Aurora Boreas Development Commands

# Run the application
run() {
    mise run run-api
}

# Run tests
test() {
    mise run test
}

# Run linting
lint() {
    mise run lint
}

# Build the application
build() {
    mise run build
}

# Format code
fmt() {
    mise run fmt
}

# Run generators
gen() {
    mise run generators
}

# Show available commands
commands() {
    echo "Available commands:"
    echo "  run     - Run the application"
    echo "  test    - Run tests"
    echo "  lint    - Run linting"
    echo "  build   - Build the application"
    echo "  fmt     - Format code"
    echo "  gen     - Run generators"
    echo "  setup   - Setup the project"
}

setup() {
    mise run setup
}
EOF

chmod +x ~/dev-commands.sh
echo 'source ~/dev-commands.sh' >> ~/.bashrc

# Create a welcome message
cat > ~/.motd << 'EOF'
╔════════════════════════════════════════════════════════════════════════════════╗
║                           🌌 Aurora Boreas 🌌                                  ║
║                     Development Environment Ready!                             ║
╠════════════════════════════════════════════════════════════════════════════════╣
║                                                                                ║
║  Quick Commands:                                                               ║
║    • run      - Start the Aurora Boreas application                           ║
║    • test     - Run all tests                                                 ║
║    • lint     - Run code linting                                              ║
║    • build    - Build the application                                         ║
║    • fmt      - Format code                                                   ║
║    • setup    - Setup/reinstall dependencies                                  ║
║    • commands - Show all available commands                                   ║
║                                                                                ║
║  Tools Available:                                                              ║
║    • Go 1.23+ with all dev tools                                              ║
║    • golangci-lint for code quality                                           ║
║    • pre-commit hooks                                                         ║
║    • Docker & Docker Compose                                                  ║
║    • mise for tool management                                                 ║
║    • GitHub CLI                                                               ║
║                                                                                ║
║  Observability Stack (labs/):                                                 ║
║    • Prometheus (localhost:9090)                                              ║
║    • Grafana (localhost:3000)                                                 ║
║    • Tempo (localhost:3001)                                                   ║
║    • Jaeger (localhost:16686)                                                 ║
║                                                                                ║
╚════════════════════════════════════════════════════════════════════════════════╝
EOF

echo "✅ Aurora Boreas development environment setup complete!"
echo "🎉 You can now start developing with 'run' or 'make dev-setup'"
echo ""
cat ~/.motd
