#!/bin/bash
#Author: Sarven Capadisli <info@csarven.ca>
#Author URL: http://csarven.ca/#i

. ./config.sh

curl -v -s -L -H "Accept: text/csv" \
    -G "${sparqlEndpoint}" \
    --data-urlencode "query=PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX qb: <http://purl.org/linked-data/cube#>
PREFIX sdmx-dimension: <http://purl.org/linked-data/sdmx/2009/dimension#>
PREFIX year: <http://reference.data.gov.uk/id/year/>
PREFIX graph: <http://worldbank.270a.info/graph/>
PREFIX property: <http://worldbank.270a.info/property/>

SELECT DISTINCT ?identifier ?title
WHERE {
    GRAPH graph:world-development-indicators {
        ?observation sdmx-dimension:refPeriod year:"${refPeriod}" .
        ?observation qb:dataSet ?dataset .
    }
    GRAPH graph:meta {
        ?dataset dcterms:identifier ?identifier .
        ?dataset dcterms:title ?title .
    }
}
ORDER BY LCASE(?identifier)" \
--data "output=csv" \
-o "${metaPathFile}"

