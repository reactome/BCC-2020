#!/bin/bash
set -e

target_data_dir="$(pwd)/neo4j/data"
target_database_dir="$target_data_dir/databases"

wget https://reactome.org/download/current/reactome.graphdb.tgz

mkdir -p "$target_database_dir"

tar -zxvf reactome.graphdb.tgz

mv graph.db "$target_database_dir/graph.db"

docker run --name reactome_graph_db -p 7687:7687 -p 7474:7474 -e NEO4J_dbms_allow__upgrade=true -e NEO4J_AUTH=none -v "$target_data_dir:/data" neo4j:3.5.19
