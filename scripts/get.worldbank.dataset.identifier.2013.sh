#!/bin/bash

curl -v -G http://worldbank.270a.info/sparql \
--data-urlencode "query@worldbank.dataset-identifiers.2013.q" \
--data "output=csv" \
-o ../data/worldbank.dataset-identifiers.2013.csv
