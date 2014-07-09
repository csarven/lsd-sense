#!/bin/bash
data="../data/worldbank.dataset.identifier.2013.csv";

tail -n +2 "$data" | tr -d '\r' | while read dataSetCode ; do
curl -v -L -H "Accept: application/sparql-results+xml" \
    -G http://worldbank.270a.info/sparql \
    --data-urlencode "query=SELECT ?refArea ?obsValue
WHERE
  { ?observation <http://purl.org/linked-data/cube#dataSet> <http://worldbank.270a.info/dataset/"${dataSetCode}"> .
    ?observation <http://purl.org/linked-data/sdmx/2009/dimension#refPeriod> <http://reference.data.gov.uk/id/year/2013> .
    ?observation <http://purl.org/linked-data/sdmx/2009/dimension#refArea> ?refArea .
    ?observation <http://purl.org/linked-data/sdmx/2009/measure#obsValue> ?obsValue .
  }" \

#Outputting this for now to test. In actual tests, this need not be stored since ATS will cache everything for the analysis
    -o ../data/observations/"${dataSetCode}".2013.xml;
done;

#real	3m6.052s
#user	0m4.585s
#sys	0m3.366s

