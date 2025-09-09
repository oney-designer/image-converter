#!/bin/bash

# ============================================================================
# Universal Image Converter for Dolphin
#
# Autor:        Ney Designer (com assistência de IA)
# Versão:       3.0 (Edição de Máxima Confiabilidade: remove a barra de progresso
#               para contornar bugs do kdialog em alguns sistemas)
# Dependência:  ffmpeg, kdialog
# Descrição:    Converte um ou mais arquivos de imagem para um formato
#               selecionado pelo usuário.
# ============================================================================

# Verifica se pelo menos um arquivo foi passado como argumento
if [ "$#" -eq 0 ]; then
    kdialog --error "Nenhum arquivo de imagem selecionado."
    exit 1
fi

# Lista de formatos de saída populares.
formats=("png" "jpg" "webp" "avif" "jxl" "gif" "bmp" "tiff")

# Pede ao usuário para escolher o formato de saída.
output_format=$(kdialog --combobox "Converter para o formato:" "${formats[@]}" --title "Escolha o Formato de Saída")

# Sai se o usuário cancelar a seleção
if [ -z "$output_format" ]; then
    exit 1
fi

# Loop principal de conversão (sem barra de progresso)
for file in "$@"; do
    output_filename="${file%.*}.$output_format"
    # O comando ffmpeg agora é a única coisa no loop
    ffmpeg -hide_banner -loglevel error -i "$file" -y "$output_filename" < /dev/null
done

# Notifica o usuário sobre a conclusão APÓS todos os arquivos serem processados
kdialog --msgbox "Conversão concluída com sucesso para $# arquivo(s)!" --title "Processo Finalizado"

exit 0
