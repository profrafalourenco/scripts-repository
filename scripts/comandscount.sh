#!/bin/bash
# =========================================================
# Script de instalação: Contador de comandos no Bash
# Autor: Prof Rafael Lourenço
# Descrição: Insere automaticamente no ~/.bashrc um código
# que conta quantos comandos foram digitados e mostra isso
# em uma variável chamada $contatos.
# =========================================================

# Caminho do arquivo bashrc do usuário
BASHRC="$HOME/.bashrc"

# Código a ser inserido (usando EOF para preservar formatação)
CODIGO=$(cat <<'EOF'

# === CONFIGURAÇÃO DO CONTADOR DE COMANDOS ===
MEU_NOME="${MEU_NOME:-$(whoami)}"
CONTADOR_FILE="$HOME/.contatos_state"

if [ -f "$CONTADOR_FILE" ]; then
    contador=$(cat "$CONTADOR_FILE")
else
    contador=0
fi

atualiza_contador() {
    contador=$((contador + 1))
    echo "$contador" > "$CONTADOR_FILE"
    contatos="$MEU_NOME digitou na data $(date) $contador comandos $(cat ~/.bashrc)"
    export contatos
}

PROMPT_COMMAND=atualiza_contador
# === FIM DO BLOCO AUTOMÁTICO ===

EOF
)

# Verifica se o código já existe no .bashrc
if grep -q "CONFIGURAÇÃO DO CONTADOR DE COMANDOS" "$BASHRC"; then
    echo "⚠️  O contador já está configurado no seu ~/.bashrc."
else
    echo "$CODIGO" >> "$BASHRC"
    echo "✅ Código de contador adicionado ao ~/.bashrc com sucesso!"
    echo "💡 Execute: source ~/.bashrc  para ativar agora."
fi
