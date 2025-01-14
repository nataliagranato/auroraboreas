# Aurora Boreas

[![CodeQL Advanced](https://github.com/nataliagranato/aurora-boreas/actions/workflows/codeql.yml/badge.svg)](https://github.com/nataliagranato/aurora-boreas/actions/workflows/codeql.yml) [![Go](https://github.com/nataliagranato/aurora-boreas/actions/workflows/go.yml/badge.svg)](https://github.com/nataliagranato/aurora-boreas/actions/workflows/go.yml) 

Um projeto Go que combina poesia e visualização de um céu estrelado com telemetria usando OpenTelemetry. Dedicado a Tainara Almeida.

## Sobre o Projeto

Aurora Boreas é uma aplicação que imprime um poema para a amada Tainara Almeida e exibe um céu estrelado no terminal. A aplicação também coleta telemetria de execução de poemas usando OpenTelemetry.

### Funcionalidades
- Impressão de poema para Tainara Almeida
- Animação de céu estrelado no terminal
- Telemetria completa usando OpenTelemetry

## Estrutura do Projeto

```
aurora-boreas/
├── cmd/
│   └── main.go
├── internal/
│   ├── animation/
│   │   └── starry_sky.go
│   ├── instrumentation/
│   │   └── instrumentation.go
│   └── poem/
│       └── poem.go
├── go.mod
├── go.sum
└── LICENSE
└── CHANGELOG
└── README.md

```

## Pré-requisitos

- Go 1.19 ou superior
- Terminal com suporte a cores ANSI
- Coletor OpenTelemetry (opcional para telemetria)

## Instalação

```bash
git clone https://github.com/nataliagranato/aurora-boreas.git
cd aurora-boreas
go mod tidy
```

## Execução

```bash
go run ./cmd
```

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

## Licença

Este projeto está licenciado sob a MIT License.

