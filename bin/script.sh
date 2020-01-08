#!/bin/bash

curl -o content.json "https://us-central1-psel-clt-ti-junho-2019.cloudfunctions.net/psel_2019_get"

# Seleciona apenas produtos em promocao
jq -r '.posts | map(select(.title | contains("promocao"))) | unique_by(.price, .product_id)' content.json > ex_a.json

# Seleciona apenas postagens com mais de 700 likes da midia instagram
jq -r '.posts | map(select(.media=="instagram_cpc" and .likes > 700 )) | group_by(.price, .post_id)' content.json > ex_b.json

# Seleciona apenas os posts de midias pagas no periodo do mes de maio
jq -r '.posts | map(select(.date | contains("/05/2019"))) | map(select(.media=="instagram_cpc" or .media=="facebook_cpc" or .media=="google_cpc"))' content.json > may.json

# Soma os likes do mes de maio e armazena o resultado em um json
jq -r '. | map(.likes) | add' may.json > ex_c.json
