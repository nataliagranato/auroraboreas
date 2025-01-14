## Executando Testes

### Comandos Básicos

```bash
# Executar todos os testes
go test -v ./...

# Executar testes de um pacote específico
go test -v ./internal/poem

# Executar um teste específico
go test -v -run TestForHer ./internal/poem
```

### Análise de Cobertura

```bash
# Gerar relatório de cobertura
go test -v -coverprofile=coverage.out ./...

# Visualizar relatório no navegador
go tool cover -html=coverage.out
```

### Estrutura de Testes

```
auroraboreas/
├── internal/
│   ├── animation/
│   │   └── animation_test.go
│   ├── instrumentation/
│   │   └── instrumentation_test.go
│   └── poem/
│       └── poem_test.go
└── main_test.go
```

Os testes são organizados em pacotes separados, com arquivos de teste nomeados com o sufixo `_test.go`. O arquivo `main_test.go` é utilizado para testes de integração.