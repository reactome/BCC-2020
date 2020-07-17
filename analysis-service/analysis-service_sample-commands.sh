#! /bin/bash

## These are sample curl GET and POST requests used during the Reactome BCC 2020 presentation on the Analysis Service (https://reactome.org/AnalysisService/).
## Each command will output the returned results to a json file. 

# GET request for running Analyis Service (AS) on single 'TP53' identifier. Results stored to TP53-analysis-results.json.
curl -X GET "https://reactome.org/AnalysisService/identifier/TP53" -H "accept: application/json" > TP53-analysis-results.json

# POST request for running AS on multiple identifiers (TP53, PTEN). Results stored to TP53-PTEN-analysis-results.json.
curl -X POST "https://reactome.org/AnalysisService/identifiers/" -H "accept: application/json" -H "content-type: text/plain" -d "TP53 PTEN" > TP53-PTEN-analysis-results.json

# POST request for running AS on an online dataset (https://www.ebi.ac.uk/pride/ws/archive/protein/list/assay/27929.acc).
# Results stored to url-analysis-results.json.
curl -X POST "https://reactome.org/AnalysisService/identifiers/url" -H "accept: application/json" -H "content-type: text/plain" -d "https://www.ebi.ac.uk/pride/ws/archive/protein/list/assay/27929.acc" > url-analysis-results.json

# POST request for running AS on a local data file (TwelveTumorsNaturePaper127genes.txt). 
# This particular example is using a file called 'TwelveTumorsNaturePaper127genes.txt' that can be downloaded from https://github.com/reactome/BCC-2020/edit/master/analysis-service/TwelveTumorsNaturePaper127genes.txt.
# Results stored to analysis-TumoursNaturePaper127genes.json.
curl -X POST "https://reactome.org/AnalysisService/identifiers/form/projection/?" -H  "accept: application/json" -H "content-type: multipart/form-data" -F file=@TwelveTumorsNaturePaper127genes.txt > analysis-TumoursNaturePaper127genes.json

# Same as above command, except that it sets the pValue threshold to 1. Any Pathway over-representation Pathway analyses that have a pValue statistic over 1 will be excluded from results.
# Results stored to analysis-TumoursNaturePaper127genes.json.
curl -X POST "https://reactome.org/AnalysisService/identifiers/form/?pValue=1" -H  "accept: application/json" -H "content-type: multipart/form-data" -F file=@TwelveTumorsNaturePaper127genes.txt > analysis-TumoursNaturePaper127genes.json

# POST request for running AS on a local data file (TwelveTumorsNaturePaper127genes.txt).
# This is the final example used in the Reactome AS tutorial during BCC 2020. This replicates the default Pathway Browser analysis settings.
# Results stored to analysis-TumoursNaturePaper127genes.json.
curl -X POST "https://reactome.org/AnalysisService/identifiers/form/projection?pValue=1&sortBy=ENTITIES_PVALUE&order=ASC" -H  "accept: application/json" -H "content-type: multipart/form-data" -F file=@TwelveTumorsNaturePaper127genes.txt > analysis-TumoursNaturePaper127genes.json
