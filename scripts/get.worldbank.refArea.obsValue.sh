#!/bin/bash
data="../data/worldbank.dataset.identifier.2013.csv";
refPeriod="2013";

tail -n +2 "$data" | tr -d '\r' | while read dataSetCode ; do
echo "GET ${dataSetCode} ${refPeriod} observations";
#curl -L -H "Accept: application/sparql-results+xml" \
curl -s -L -H "Accept: text/csv" \
    -G http://worldbank.270a.info/sparql \
    --data-urlencode "query=SELECT ?refArea ?obsValue
WHERE
  { ?observation <http://purl.org/linked-data/cube#dataSet> <http://worldbank.270a.info/dataset/"${dataSetCode}"> .
    ?observation <http://purl.org/linked-data/sdmx/2009/dimension#refPeriod> <http://reference.data.gov.uk/id/year/${refPeriod}> .
    ?observation <http://purl.org/linked-data/sdmx/2009/dimension#refArea>/<http://www.w3.org/2004/02/skos/core#notation> ?refArea .
    ?observation <http://purl.org/linked-data/sdmx/2009/measure#obsValue> ?obsValue .
  }" \
    --data "output=csv" \
    -o ../data/observations/"${dataSetCode}"."${refPeriod}".csv;
done;

#real	2m18.357s
#user	0m4.614s
#sys	0m2.958s

