# Scripts do Aurora Boreas

Esta pasta contém os scripts de automação e configuração do projeto Aurora Boreas.

## 📜 Scripts Disponíveis

### 🚀 `install.sh`
Script de instalação automática do Aurora Boreas.

**Uso:**
```bash
# Instalação remota
curl -sSL https://raw.githubusercontent.com/nataliagranato/auroraboreas/main/scripts/install.sh | bash

# Instalação local
./scripts/install.sh
```

**Funcionalidades:**
- Detecta automaticamente o sistema operacional e arquitetura
- Download da versão mais recente do GitHub Releases
- Instalação no diretório apropriado (`/usr/local/bin` ou `~/.local/bin`)
- Verificação de checksums para segurança
- Suporte a múltiplas plataformas (Linux, macOS, Windows via WSL)

### 🍺 `setup-homebrew-tap.sh`
Script para configuração inicial do repositório Homebrew tap.

**Uso:**
```bash
./scripts/setup-homebrew-tap.sh
```

**Funcionalidades:**
- Clona o repositório homebrew-tap
- Cria/atualiza a estrutura de arquivos necessária
- Configura a fórmula inicial do Homebrew
- Faz commit e push das mudanças

**Nota:** Este script requer a variável `USER_TOKEN` configurada ou é preferível usar a GitHub Action.

### 🔄 `update-homebrew-tap.sh`
Script que dispara a GitHub Action para atualizar o Homebrew tap.

**Uso:**
```bash
./scripts/update-homebrew-tap.sh
```

**Funcionalidades:**
- Executa via GitHub CLI (gh)
- Dispara a workflow `update-homebrew-tap.yml`
- Mostra o status da execução
- Mais seguro que o script manual (usa GitHub secrets)

### 📜 `setup-homebrew-tap-old.sh`
Versão anterior do script de setup do Homebrew tap (backup).

## 🔧 Como Usar

### Via Makefile
```bash
# Atualizar Homebrew tap (recomendado)
make update-homebrew

# Setup inicial (deprecado)
make setup-homebrew

# Testar instalação via Homebrew
make test-homebrew
```

### Diretamente
```bash
# Tornar executável (se necessário)
chmod +x scripts/*.sh

# Executar script específico
./scripts/update-homebrew-tap.sh
```

## 📋 Pré-requisitos

### Para `install.sh`:
- `curl` ou `wget`
- `tar` ou `unzip`
- Acesso à internet

### Para scripts do Homebrew:
- Git configurado
- GitHub CLI (`gh`) instalado e autenticado
- Token do GitHub com permissões adequadas (para setup manual)

### Para `update-homebrew-tap.sh`:
- GitHub CLI (`gh`) instalado
- Autenticação no GitHub
- Permissões no repositório

## 🔐 Configuração de Secrets

Para usar os scripts que requerem autenticação, configure a secret `USER_TOKEN` no GitHub:

1. Gere um token em: https://github.com/settings/tokens
2. Permissões necessárias: `repo` (Full control)
3. Configure em: https://github.com/nataliagranato/auroraboreas/settings/secrets/actions
4. Nome da secret: `USER_TOKEN`

## 🤝 Contribuindo

Ao modificar scripts:

1. Mantenha compatibilidade com sistemas Unix-like
2. Use `set -e` para falhar rapidamente em erros
3. Adicione cores e mensagens informativas
4. Teste em múltiplas plataformas quando possível
5. Documente mudanças neste README

## 📖 Documentação Relacionada

- [Makefile](../Makefile) - Comandos de automação
- [GoReleaser](../.goreleaser.yml) - Configuração de releases
- [GitHub Actions](../.github/workflows/) - Automação CI/CD
- [README Principal](../README.md) - Documentação do projeto
