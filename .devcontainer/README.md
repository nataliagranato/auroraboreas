# Aurora Boreas Development Container

Este devcontainer foi configurado especificamente para o projeto Aurora Boreas, incluindo todas as ferramentas e dependências necessárias para desenvolvimento.

## 🚀 Ferramentas Incluídas

### Linguagens e Runtime
- **Go 1.23+** - Linguagem principal do projeto
- **Node.js LTS** - Para ferramentas de desenvolvimento frontend
- **Python 3** - Para pre-commit e scripts

### Ferramentas de Desenvolvimento Go
- **golangci-lint** - Linter de código Go
- **goreleaser** - Ferramenta de release
- **gotestsum** - Executor de testes com formatação melhorada
- **mockery** - Gerador de mocks
- **swag** - Gerador de documentação Swagger
- **goimports** - Formatador de imports
- **dlv (Delve)** - Debugger para Go

### Ferramentas de Qualidade de Código
- **pre-commit** - Hooks de pre-commit
- **gitleaks** - Detecção de vazamentos de credenciais
- **conventional-commits** - Padrão de commits

### Ferramentas de Container e Orquestração
- **Docker** - Container runtime
- **Docker Compose** - Orquestração de containers

### Ferramentas de Desenvolvimento
- **mise** - Gerenciador de ferramentas e versões
- **GitHub CLI** - Interface de linha de comando do GitHub
- **Git** - Controle de versão
- **Make** - Build system

## 🛠️ Comandos Rápidos

Após o container ser iniciado, você terá acesso aos seguintes comandos:

```bash
# Executar a aplicação
run

# Executar testes
test

# Executar linting
lint

# Construir a aplicação
build

# Formatar código
fmt

# Executar geradores
gen

# Configurar projeto
setup

# Mostrar todos os comandos disponíveis
commands
```

## 📁 Estrutura de Portas

O devcontainer está configurado para encaminhar as seguintes portas:

- **8080** - Aurora Boreas API
- **3000** - Grafana
- **9090** - Prometheus  
- **3001** - Tempo
- **16686** - Jaeger

## 🔧 Configuração do Ambiente

### Variáveis de Ambiente
As variáveis de ambiente estão configuradas automaticamente:
- Configurações do Go (GOPROXY, GOSUMDB, etc.)
- Configurações da aplicação (EASYZAP_LOG_TYPE, etc.)
- Configurações de observabilidade (OTEL_*)

### Extensões do VS Code
O devcontainer inclui extensões essenciais:
- Go extension pack
- Docker support
- YAML/JSON/TOML support
- Git integration
- Testing tools
- Code quality tools

## 🚦 Stack de Observabilidade

O projeto inclui uma stack completa de observabilidade no diretório `labs/`:

```bash
cd labs
docker-compose up -d
```

Isso iniciará:
- **Prometheus** - Métricas
- **Grafana** - Dashboards
- **Tempo** - Traces distribuídos
- **Jaeger** - Interface de traces
- **OTEL Collector** - Coleta de telemetria

## 🔄 Comandos Make

Você também pode usar os comandos Make tradicionais:

```bash
make help          # Mostrar ajuda
make dev-setup      # Configurar ambiente de desenvolvimento
make build          # Construir a aplicação
make test           # Executar testes
make lint           # Executar linting
make clean          # Limpar artefatos
```

## 🐛 Debugging

O devcontainer está configurado para debugging:
- Delve está instalado para debugging Go
- Configurações de launch.json podem ser adicionadas ao VS Code
- Suporte a debugging remoto

## 🔍 Troubleshooting

### Problema com golangci-lint
Se você encontrar o erro "go: no such tool golangci-lint":

```bash
go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.62.2
```

### Reinstalar dependências
```bash
setup  # ou mise run setup
```

### Verificar instalação das ferramentas
```bash
go version
golangci-lint version
pre-commit --version
mise --version
```

## 📝 Contribuindo

1. Use `pre-commit` para garantir qualidade do código
2. Execute testes antes de fazer commit: `test`
3. Use conventional commits para mensagens de commit
4. Execute linting: `lint`
5. Formate o código: `fmt`

## 🎯 Performance

O devcontainer está otimizado para:
- Cache de dependências Go
- Bind mounts para .git (performance)
- Variáveis de ambiente otimizadas
- Tools pré-instaladas para evitar downloads

Agora você tem um ambiente de desenvolvimento completo e otimizado para o Aurora Boreas! 🌌
