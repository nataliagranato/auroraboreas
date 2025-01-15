# Pipeline de Release - Aurora Boreas

## Estrutura da Pipeline

A pipeline de release do Aurora Boreas é configurada para:
- Compilar binários para múltiplas plataformas
- Criar releases automáticas no GitHub
- Gerenciar tags e versionamento

## Componentes Principais

### Triggers
- Push de tags (formato: `v*.*.*`)
- Criação manual de release

### Jobs
1. `create-release`: Cria a release no GitHub
2. `releases-matrix`: Compila binários para diferentes sistemas

### Matriz de Compilação
- Sistemas: Linux, Windows, MacOS
- Arquiteturas: x86, amd64, arm64

## Como Criar uma Release

1. **Criar Tag Local**
```bash
git tag v0.1.0
```

2. **Enviar Tag para GitHub**
```bash
git push origin v0.1.0
```

3. **Verificar Pipeline**
- Acesse GitHub Actions
- Monitore job "Compiling the starry sky"

## Artifacts Gerados

- `aurora-v*.*.*-linux-amd64.tar.gz`
- `aurora-v*.*.*-windows-amd64.zip`
- `aurora-v*.*.*-darwin-amd64.tar.gz`

## Troubleshooting

### Erro 404 na Release
1. Verifique se a tag existe:
```bash
git tag -l
```

2. Confira permissões do token:
```bash
gh auth status
```

### Logs do Build
```bash
gh run list --workflow=release.yml
gh run view <run-id>
```
