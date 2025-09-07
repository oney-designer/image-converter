#!/bin/bash

# --- Script de Desinstalação para o Conversor de Imagens ---

echo "Iniciando a desinstalação do Menu de Serviço 'Converter Imagem'..."
echo "------------------------------------------------------------------"

# Define os caminhos dos arquivos que serão removidos
SCRIPT_FILE="$HOME/.local/bin/image-converter.sh"
SERVICE_MENU_FILE="$HOME/.local/share/kio/servicemenus/image-converter.desktop"

# Solicita confirmação do usuário
echo "Este script removerá os seguintes arquivos:"
echo "  - Script: $SCRIPT_FILE"
echo "  - Menu de Serviço: $SERVICE_MENU_FILE"
echo ""
read -p "Você tem certeza que deseja continuar? (s/N) " confirmacao
echo ""

if [[ ! "$confirmacao" =~ ^[sS]$ ]]; then
    echo "Desinstalação cancelada pelo usuário."
    exit 1
fi

# Remove os arquivos
if [ -f "$SCRIPT_FILE" ]; then
    rm "$SCRIPT_FILE"
    echo "✓ Arquivo de script removido."
else
    echo "i Arquivo de script não encontrado."
fi

if [ -f "$SERVICE_MENU_FILE" ]; then
    rm "$SERVICE_MENU_FILE"
    echo "✓ Arquivo do Menu de Serviço removido."
else
    echo "i Arquivo do Menu de Serviço não encontrado."
fi

echo "------------------------------------------------------------------"
echo "🎉 Desinstalação concluída!"
echo "Para que as alterações tenham efeito, reinicie o Dolphin."

exit 0
