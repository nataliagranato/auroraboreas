# Aurora Boreas

[![Release](https://img.shields.io/github/v/release/nataliagranato/auroraboreas)](https://github.com/nataliagranato/auroraboreas/releases)
[![Go Report Card](https://goreportcard.com/badge/github.com/nataliagranato/auroraboreas)](https://goreportcard.com/report/github.com/nataliagranato/auroraboreas)
[![CodeQL Advanced](https://github.com/nataliagranato/aurora-boreas/actions/workflows/codeql.yml/badge.svg)](https://github.com/nataliagranato/aurora-boreas/actions/workflows/codeql.yml)
[![Go](https://github.com/nataliagranato/aurora-boreas/actions/workflows/go.yml/badge.svg)](https://github.com/nataliagranato/aurora-boreas/actions/workflows/go.yml)
[![Release](https://github.com/nataliagranato/auroraboreas/actions/workflows/release.yml/badge.svg)](https://github.com/nataliagranato/auroraboreas/actions/workflows/release.yml)
[![Scorecard supply-chain security](https://github.com/nataliagranato/auroraboreas/actions/workflows/scorecard.yml/badge.svg)](https://github.com/nataliagranato/auroraboreas/actions/workflows/scorecard.yml)
[![OpenSSF Best Practices](https://www.bestpractices.dev/projects/9918/badge)](https://www.bestpractices.dev/projects/9918)
[![Docker Pulls](https://img.shields.io/docker/pulls/nataliagranato/auroraboreas)](https://hub.docker.com/r/nataliagranato/auroraboreas)


Um projeto Go que combina poesia e visualização de um céu estrelado com telemetria usando OpenTelemetry. Dedicado a Tainara Almeida.

## Sobre o Projeto

Aurora Boreas é uma aplicação que imprime um poema para a amada Tainara Almeida e exibe um céu estrelado no terminal. A aplicação também coleta telemetria de execução de poemas usando OpenTelemetry.

### Funcionalidades
- Impressão de poema para Tainara Almeida
- Animação de céu estrelado no terminal
- Telemetria completa usando OpenTelemetry

## 📦 Instalação

### Via Script de Instalação (Recomendado)
```bash
curl -sSL https://raw.githubusercontent.com/nataliagranato/auroraboreas/main/scripts/install.sh | bash
```

### Via Homebrew (macOS/Linux)
```bash
# Adicionar o tap
brew tap nataliagranato/tap

# Instalar Aurora Boreas
brew install auroraboreas
```

### Via Docker
```bash
# Executar diretamente
docker run --rm nataliagranato/auroraboreas:latest

# Ou baixar a imagem
docker pull nataliagranato/auroraboreas:latest
```

### Download Direto (GitHub Releases)
1. Vá para as [Releases](https://github.com/nataliagranato/auroraboreas/releases)
2. Baixe o arquivo para seu sistema operacional
3. Extraia e execute:

```bash
# Linux/macOS
tar -xzf auroraboreas-*.tar.gz
cd auroraboreas-*/
./aurora

# Windows
# Extraia o arquivo .zip e execute aurora.exe
```

### Via Go Install
```bash
go install github.com/nataliagranato/auroraboreas/cmd@latest
```

### Desenvolvimento (Código Fonte)
```bash
git clone https://github.com/nataliagranato/auroraboreas.git
cd auroraboreas
go mod tidy
make build    # ou: go build -o aurora ./cmd/main.go
```

## 🚀 Execução

Após a instalação, execute:
```bash
aurora
```

## 🎯 Pré-requisitos

- Terminal com suporte a cores ANSI
- Coletor OpenTelemetry (opcional para telemetria)

## Telemetria

A aplicação está instrumentada com OpenTelemetry e exporta:
- Métricas de execução
- Traces de geração de poemas
- Logs de eventos importantes

### Configuração da Telemetria

Configure as variáveis de ambiente:
```bash
export OTEL_EXPORTER_OTLP_ENDPOINT="seu-endpoint"
export OTEL_SERVICE_NAME="aurora-boreas"
```

## Contribuindo

Contribuições são bem-vindas! Por favor, sinta-se à vontade para enviar um Pull Request.

## 🍺 Homebrew Tap

Para criar e manter o repositório Homebrew:

```bash
# 1. Criar repositório homebrew-tap no GitHub
# 2. Clonar localmente
git clone https://github.com/nataliagranato/homebrew-tap.git

# 3. O GoReleaser automaticamente atualizará a fórmula a cada release
```

### Estrutura do Homebrew Tap
```
homebrew-tap/
├── Formula/
│   └── auroraboreas.rb    # Gerado automaticamente pelo GoReleaser
└── README.md
```

## 🔧 Comandos Úteis

```bash
# Verificar versão
aurora --version

# Ajuda
aurora --help

# Executar com telemetria personalizada
OTEL_EXPORTER_OTLP_ENDPOINT="http://localhost:4317" aurora
```

## 🐳 Docker

### Executar
```bash
docker run --rm nataliagranato/auroraboreas:latest
```

### Construir localmente
```bash
make docker-build
make docker-run
```

## 🛠️ Desenvolvimento

```bash
# Setup do ambiente
make dev-setup

# Compilar
make build

# Executar testes
make test

# Lint
make lint

# Executar
make run

# Release local (teste)
make release-dry-run
```

## 📋 Arquiteturas Suportadas

| OS | Arquitetura | Status |
|---|---|---|
| **Linux** | amd64, arm64, armv6, armv7 | ✅ |
| **macOS** | amd64, arm64 (M1/M2) | ✅ |
| **Windows** | amd64, arm64 | ✅ |
| **FreeBSD** | amd64, arm64 | ✅ |

## 🤝 Contribuindo

Contribuições são bem-vindas! Por favor:

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está licenciado sob a GPL-3.0 License - veja o arquivo [LICENSE](LICENSE) para detalhes.

