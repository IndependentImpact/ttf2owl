#!/bin/sh
set -e

DATASET_DIR="${FUSEKI_BASE}/databases/ttf"
ONTOLOGY_SRC="/opt/ttf/ttf.ttl"

if [ ! -d "$DATASET_DIR" ] || [ -z "$(ls -A "$DATASET_DIR" 2>/dev/null)" ]; then
  echo "Initializing TDB dataset at $DATASET_DIR"
  mkdir -p "$DATASET_DIR"
  # Use the image's own tdbloader2 wrapper (already +x and in PATH? No → full path)
  /jena-fuseki/tdbloader2 --loc "$DATASET_DIR" "$ONTOLOGY_SRC"
  echo "Dataset loaded."
else 
  echo "Dataset at $DATASET_DIR already exist -- skipping load."
fi

exec /jena-fuseki/fuseki-server --config=/opt/ttf/ttf-config.ttl
