#! /bin/bash

# These are some example commands that query Reactome's ContentService (https://reactome.org/ContentService/)
# You don't need to execute this whole script at once, feel free to copy/paste/modify whatever commands you want.
# Each command will output to a JSON or image file.
# Some commands demonstrate the usage of jq, so be sure to install jq (https://stedolan.github.io/jq/download/) before running those.

# Look up an entity
curl -X GET "https://reactome.org/ContentService/data/query/R-HSA-1640170" -H "accept: application/json" > R-HSA-1640170.json

# full-text search
curl -X GET "https://reactome.org/ContentService/search/query?query=APEX1&species=Homo%20sapiens&compartments=nucleoplasm&cluster=true" -H "accept: application/json" > APEX1.json
# ...without clustering
curl -X GET "https://reactome.org/ContentService/search/query?query=APEX1&species=Homo%20sapiens&compartments=nucleoplasm&cluster=false" -H "accept: application/json" > APEX1_no_cluster.json
# Search filtering for Pathways and Proteins
curl -X GET "https://reactome.org/ContentService/search/query?query=APEX1&species=Homo%20sapiens&compartments=nucleoplasm&cluster=true&types=Pathways,Proteins" -H "accept: application/json" APEX1_type_filtered.json
# Using jq to only show names and stable identifiers. Make sure jq is installed before running this command.
curl -X GET "https://reactome.org/ContentService/search/query?query=APEX1&species=Homo%20sapiens&compartments=nucleoplasm&cluster=true" -H "accept: application/json" | jq '.results[].entries[] | [.stId, .name]' > APEX1_names_stIds.json


# Get Interactors
# From MINT
curl -X GET "https://reactome.org/ContentService/interactors/psicquic/molecule/MINT/Q13501/details" -H "accept: application/json" > Q13501_interactors_MINT.json
# From UniProt
curl -X GET "https://reactome.org/ContentService/interactors/psicquic/molecule/UniProt/Q13501/details" -H "accept: application/json" > Q13501_interactors_UniProt.json

# Get Orthology
curl -X GET "https://reactome.org/ContentService/data/orthology/R-HSA-6799198/species/49633" -H "accept: application/json"  > R-HSA-6799198_SSC-orthologs.json

# You will need to install jq to run the next two commands. URL: https://stedolan.github.io/jq/ ; Command to install (deb/ubuntu): `sudo apt-get install jq`
# Use jq to filter an event and only keep the Inputs
curl -X GET -H "Accept: application/json" "https://reactome.org/ContentService/data/query/R-HSA-109624" | jq '.input' > R-HSA-109624_inputs.json
# Use jq to filter an event and only keep the Outputs
curl -X GET -H "Accept: application/json" "https://reactome.org/ContentService/data/query/R-HSA-109624" | jq '.output' > R-HSA-109624_output.json

# Export a reaction in a pathway to an image (SVG) and highlight "ATP"
curl -o R-HSA-109624.svg -X GET "https://reactome.org/ContentService/exporter/diagram/R-HSA-109624.svg?quality=10&flgInteractors=true&sel=R-HSA-109624&title=true&margin=15&ehld=true&diagramProfile=Modern&resource=TOTAL&analysisProfile=Standard&flg=ATP" -H "accept: image/png"
# Export to PNG (and no flag)
curl -o R-HSA-109624.png -X GET "https://reactome.org/ContentService/exporter/diagram/R-HSA-109624.png?quality=10&flgInteractors=true&sel=R-HSA-109624&title=true&margin=5&ehld=true&diagramProfile=Modern&resource=TOTAL&analysisProfile=Standard" -H "accept: image/png"

# Get events contained within a specific event
curl -X GET "https://reactome.org/ContentService/data/pathway/R-HSA-5673001/containedEvents" -H "accept: application/json" > R-HSA-5673001_containedEvents.json
