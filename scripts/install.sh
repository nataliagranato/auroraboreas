#!/bin/bash

# Aurora Boreas Installation Script
# This script installs the latest version of Aurora Boreas

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REPO="nataliagranato/auroraboreas"
BINARY_NAME="aurora"
INSTALL_DIR="${INSTALL_DIR:-/usr/local/bin}"

# Functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Detect OS and architecture
detect_platform() {
    OS=$(uname -s | tr '[:upper:]' '[:lower:]')
    ARCH=$(uname -m)

    case "$OS" in
        linux*)
            OS="linux"
            ;;
        darwin*)
            OS="darwin"
            ;;
        mingw*|msys*|cygwin*)
            OS="windows"
            ;;
        *)
            log_error "Unsupported operating system: $OS"
            exit 1
            ;;
    esac

    case "$ARCH" in
        x86_64|amd64)
            ARCH="amd64"
            ;;
        arm64|aarch64)
            ARCH="arm64"
            ;;
        armv7l)
            ARCH="armv7"
            ;;
        *)
            log_error "Unsupported architecture: $ARCH"
            exit 1
            ;;
    esac

    log_info "Detected platform: $OS/$ARCH"
}

# Get latest release version
get_latest_version() {
    log_info "Fetching latest release information..."
    
    if command -v curl >/dev/null 2>&1; then
        VERSION=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
    elif command -v wget >/dev/null 2>&1; then
        VERSION=$(wget -qO- "https://api.github.com/repos/$REPO/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
    else
        log_error "Neither curl nor wget is available. Please install one of them."
        exit 1
    fi

    if [ -z "$VERSION" ]; then
        log_error "Failed to get latest version"
        exit 1
    fi

    log_info "Latest version: $VERSION"
}

# Download and install
install_aurora() {
    # Construct download URL
    if [ "$OS" = "windows" ]; then
        ARCHIVE_EXT="zip"
    else
        ARCHIVE_EXT="tar.gz"
    fi
    
    ARCHIVE_NAME="auroraboreas-${VERSION}-${OS}-${ARCH}.${ARCHIVE_EXT}"
    DOWNLOAD_URL="https://github.com/$REPO/releases/download/$VERSION/$ARCHIVE_NAME"
    
    log_info "Downloading from: $DOWNLOAD_URL"
    
    # Create temporary directory
    TMP_DIR=$(mktemp -d)
    cd "$TMP_DIR"
    
    # Download
    if command -v curl >/dev/null 2>&1; then
        curl -LO "$DOWNLOAD_URL"
    else
        wget "$DOWNLOAD_URL"
    fi
    
    # Extract
    log_info "Extracting archive..."
    if [ "$ARCHIVE_EXT" = "zip" ]; then
        unzip -q "$ARCHIVE_NAME"
    else
        tar -xzf "$ARCHIVE_NAME"
    fi
    
    # Find binary
    EXTRACTED_DIR=$(find . -type d -name "auroraboreas-*" | head -1)
    if [ -z "$EXTRACTED_DIR" ]; then
        log_error "Failed to find extracted directory"
        exit 1
    fi
    
    # Check if install directory is writable
    if [ ! -w "$INSTALL_DIR" ] && [ "$INSTALL_DIR" = "/usr/local/bin" ]; then
        log_warning "Need sudo permissions to install to $INSTALL_DIR"
        sudo cp "$EXTRACTED_DIR/$BINARY_NAME" "$INSTALL_DIR/"
        sudo chmod +x "$INSTALL_DIR/$BINARY_NAME"
    else
        cp "$EXTRACTED_DIR/$BINARY_NAME" "$INSTALL_DIR/"
        chmod +x "$INSTALL_DIR/$BINARY_NAME"
    fi
    
    # Cleanup
    cd - > /dev/null
    rm -rf "$TMP_DIR"
    
    log_success "Aurora Boreas installed successfully to $INSTALL_DIR/$BINARY_NAME"
}

# Verify installation
verify_installation() {
    if command -v "$BINARY_NAME" >/dev/null 2>&1; then
        VERSION_OUTPUT=$("$BINARY_NAME" --version 2>&1 || echo "Aurora Boreas $VERSION")
        log_success "Installation verified: $VERSION_OUTPUT"
        
        echo
        echo -e "${BLUE}🌟 Aurora Boreas is ready!${NC}"
        echo
        echo "Usage:"
        echo "  $BINARY_NAME          # Run the poetry and starry sky animation"
        echo "  $BINARY_NAME --help   # Show help information"
        echo
        echo "Enjoy your poetic starry sky! ✨"
    else
        log_warning "Binary installed but not found in PATH. You may need to:"
        echo "  - Add $INSTALL_DIR to your PATH"
        echo "  - Restart your terminal"
        echo "  - Run: export PATH=\$PATH:$INSTALL_DIR"
    fi
}

# Main execution
main() {
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════╗"
    echo "║        Aurora Boreas Installer       ║"
    echo "║     Poesia e céu estrelado ✨        ║"
    echo "╚══════════════════════════════════════╝"
    echo -e "${NC}"
    
    # Check if already installed
    if command -v "$BINARY_NAME" >/dev/null 2>&1; then
        CURRENT_VERSION=$("$BINARY_NAME" --version 2>&1 | grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' || echo "unknown")
        log_info "Aurora Boreas is already installed: $CURRENT_VERSION"
        
        read -p "Do you want to update to the latest version? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log_info "Installation cancelled by user"
            exit 0
        fi
    fi
    
    detect_platform
    get_latest_version
    install_aurora
    verify_installation
}

# Check dependencies
if ! command -v tar >/dev/null 2>&1 && ! command -v unzip >/dev/null 2>&1; then
    log_error "Either tar or unzip is required but not installed"
    exit 1
fi

# Run main function
main "$@"
