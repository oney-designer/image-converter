#!/bin/bash

# --- Script de Instalação para o Conversor de Imagens (v1.0) ---

echo "Iniciando a instalação do Menu de Serviço 'Converter Imagem'..."
echo "------------------------------------------------------------------"

# Passo 1: Verificar dependência (ffmpeg)
if ! command -v ffmpeg &> /dev/null; then
    echo "ERRO: A dependência 'ffmpeg' não foi encontrada."
    echo "Por favor, instale o ffmpeg usando o gerenciador de pacotes da sua distribuição."
    echo "Exemplos:"
    echo "  - Debian/Ubuntu: sudo apt install ffmpeg"
    echo "  - Fedora/CentOS: sudo dnf install ffmpeg"
    echo "  - Arch Linux:    sudo pacman -S ffmpeg"
    exit 1
fi
echo "✓ Dependência 'ffmpeg' encontrada."

# Variáveis
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
SERVICE_MENU_FILE="image-converter.desktop"
CONVERTER_SCRIPT_FILE="image-converter.sh"

# Destinos
BIN_DEST_DIR="$HOME/.local/bin"
SERVICE_MENU_DEST_DIR="$HOME/.local/share/kio/servicemenus"

# Caminhos de origem e destino
SOURCE_SERVICE_MENU="$SCRIPT_DIR/$SERVICE_MENU_FILE"
SOURCE_CONVERTER_SCRIPT="$SCRIPT_DIR/$CONVERTER_SCRIPT_FILE"
DEST_CONVERTER_SCRIPT="$BIN_DEST_DIR/$CONVERTER_SCRIPT_FILE"

# Verificação de arquivos e criação de diretórios...
# (O restante do script segue a mesma lógica robusta do projeto anterior)
if [ ! -f "$SOURCE_SERVICE_MENU" ] || [ ! -f "$SOURCE_CONVERTER_SCRIPT" ]; then
    echo "ERRO: Arquivos de instalação não encontrados!"
    exit 1
fi
echo "✓ Arquivos de origem encontrados."
mkdir -p "$BIN_DEST_DIR"
mkdir -p "$SERVICE_MENU_DEST_DIR"
echo "✓ Diretórios de destino verificados/criados."

# Atualização do caminho do executável
sed -i "s|Exec=.*|Exec=$DEST_CONVERTER_SCRIPT %F|" "$SOURCE_SERVICE_MENU"
echo "✓ Arquivo de serviço atualizado."

# Mover arquivos
mv "$SOURCE_CONVERTER_SCRIPT" "$BIN_DEST_DIR/"
mv "$SOURCE_SERVICE_MENU" "$SERVICE_MENU_DEST_DIR/"
echo "✓ Arquivos movidos para os diretórios do sistema."

# Conceder permissões de execução
chmod +x "$DEST_CONVERTER_SCRIPT"
# Com base na nossa experiência anterior, vamos adicionar permissão ao .desktop por segurança.
chmod +x "$SERVICE_MENU_DEST_DIR/$SERVICE_MENU_FILE"
echo "✓ Permissões de execução concedidas (compatibilidade máxima)."

echo "------------------------------------------------------------------"
echo "🎉 Instalação concluída com sucesso!"
echo "Para aplicar as alterações, reinicie o Dolphin (dolphin -q && dolphin &)"
exit 0
