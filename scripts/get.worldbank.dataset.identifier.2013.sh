#!/bin/bash

curl -v -G http://worldbank.270a.info/sparql \
--data-urlencode "query@worldbank.dataset.identifier.2013.q" \
--data "output=csv" \
-o ../data/worldbank.dataset.identifier.2013.csv
