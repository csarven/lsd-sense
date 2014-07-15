#!/bin/bash
#Author: Sarven Capadisli <info@csarven.ca>
#Author URL: http://csarven.ca/#i

curl -v -G http://worldbank.270a.info/sparql \
--data-urlencode "query@query.worldbank.metadata.2013.q" \
--data "output=csv" \
-o ../../data/worldbank/meta/worldbank.metadata.2013.csv
