#!/bin/bash

# Script para atualizar o Homebrew Tap via GitHub Actions
# Execute: ./update-homebrew-tap.sh

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🍺 Aurora Boreas Homebrew Tap Updater${NC}"
echo "========================================"

# Verificar se gh CLI está instalado
if ! command -v gh &> /dev/null; then
    echo -e "${RED}❌ GitHub CLI não está instalado${NC}"
    echo -e "${BLUE}💡 Instale com: brew install gh${NC}"
    exit 1
fi

# Verificar autenticação
if ! gh auth status &> /dev/null; then
    echo -e "${YELLOW}⚠️  Você não está autenticado no GitHub${NC}"
    echo -e "${BLUE}💡 Execute: gh auth login${NC}"
    exit 1
fi

# Verificar se estamos no repositório correto
if ! git remote get-url origin | grep -q "nataliagranato/auroraboreas"; then
    echo -e "${RED}❌ Execute este script no repositório auroraboreas${NC}"
    exit 1
fi

echo -e "${BLUE}🚀 Disparando GitHub Action para atualizar homebrew-tap...${NC}"

# Disparar a workflow
if gh workflow run update-homebrew-tap.yml; then
    echo -e "${GREEN}✅ GitHub Action iniciada com sucesso!${NC}"
    echo ""
    echo -e "${BLUE}📊 Acompanhe o progresso:${NC}"
    echo -e "${YELLOW}   gh run list --workflow=update-homebrew-tap.yml${NC}"
    echo ""
    echo -e "${BLUE}🔗 Ou acesse:${NC}"
    echo -e "${YELLOW}   https://github.com/nataliagranato/auroraboreas/actions${NC}"
    echo ""
    
    # Aguardar alguns segundos e mostrar o status
    echo -e "${BLUE}📋 Status da execução mais recente:${NC}"
    sleep 3
    gh run list --workflow=update-homebrew-tap.yml --limit=1
else
    echo -e "${RED}❌ Falha ao iniciar a GitHub Action${NC}"
    echo -e "${BLUE}💡 Verifique se:${NC}"
    echo "   1. O arquivo .github/workflows/update-homebrew-tap.yml existe"
    echo "   2. Você tem permissões no repositório"
    echo "   3. A secret USER_TOKEN está configurada"
    exit 1
fi

echo ""
echo -e "${GREEN}🎉 Processo iniciado!${NC}"
echo -e "${BLUE}📝 A GitHub Action irá:${NC}"
echo "   1. Clonar o repositório homebrew-tap"
echo "   2. Atualizar a fórmula auroraboreas.rb"
echo "   3. Atualizar o README.md"
echo "   4. Fazer commit e push das mudanças"
echo ""
echo -e "${BLUE}🍺 Após a conclusão, teste com:${NC}"
echo -e "${YELLOW}   brew tap nataliagranato/tap${NC}"
echo -e "${YELLOW}   brew install auroraboreas${NC}"
