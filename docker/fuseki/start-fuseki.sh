#!/bin/sh
set -e

DATASET_DIR="${FUSEKI_BASE}/databases/ttf"
ONTOLOGY_SRC="/opt/ttf/ttf.ttl"

if [ ! -d "$DATASET_DIR" ] || [ -z "$(ls -A "$DATASET_DIR" 2>/dev/null)" ]; then
  mkdir -p "$DATASET_DIR"
  tdb2.tdbloader --loc "$DATASET_DIR" "$ONTOLOGY_SRC"
fi

exec fuseki-server --config=/opt/ttf/ttf-config.ttl
