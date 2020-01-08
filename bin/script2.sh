#!/bin/bash

curl -o content_error.json "https://us-central1-psel-clt-ti-junho-2019.cloudfunctions.net/psel_2019_get_error"

# Conta o numero de ocorrencias dos posts com um respectivo preco 
jq -r '.posts | group_by(.price) | map(.[]+{"count":length}) | unique_by(.price)' content_error.json > count_incons.json

# Retorna em um arquivo json o id dos produtos com valores inconsistentes e o numero de ocorrencia deles
jq -r '. | map(select(.count > 5 or .count <5)) | group_by(.product_id)' count_incons.json > incons_by_id.json
