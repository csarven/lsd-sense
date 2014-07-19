#!/bin/bash
#Author: Sarven Capadisli <info@csarven.ca>
#Author URL: http://csarven.ca/#i

refPeriod="2010";
topic="4";
scIterations="--iters 2000";
scTopics="--topics 200";

sparqlEndpoint="http://worldbank.270a.info/sparql";

basePath="../";
metaPath="${basePath}""meta/";
observationPath="${basePath}""observations/";
summaryPath="${basePath}""summary/";
plotPath="${basePath}""plot/";

metaPathFile="${metaPath}""worldbank.metadata.""${topic}"".""${refPeriod}"".csv";

