#Author: Sarven Capadisli <info@csarven.ca>
#Author URL: http://csarven.ca/#i

PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX qb: <http://purl.org/linked-data/cube#>
PREFIX sdmx-dimension: <http://purl.org/linked-data/sdmx/2009/dimension#>
PREFIX year: <http://reference.data.gov.uk/id/year/>
PREFIX graph: <http://worldbank.270a.info/graph/>
PREFIX property: <http://worldbank.270a.info/property/>

SELECT ?topic ?topicPrefLabel (COUNT(DISTINCT ?identifier) AS ?count)
WHERE {
    GRAPH graph:world-development-indicators {
        ?observation sdmx-dimension:refPeriod year:2009 .
        ?observation qb:dataSet ?dataset .
        ?observation property:indicator ?indicator .
    }
    GRAPH graph:meta {
        ?dataset dcterms:identifier ?identifier .
        ?dataset dcterms:title ?title .
        ?indicator property:topic ?topic .
        ?topic skos:prefLabel ?topicPrefLabel .
    }
}
GROUP BY ?topic ?topicPrefLabel
ORDER BY ?count
