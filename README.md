# Token Taxonomy Framework (TTF) OWL Ontology

## Overview
This repository contains an OWL ontology representation of the InterWork Alliance Token Taxonomy Framework (TTF), expressed in Turtle (`ontology/ttf.ttl`). It also includes documentation for each implementation phase and a Dockerized Apache Jena Fuseki environment for querying the ontology.

## Repository Layout
- `ontology/ttf.ttl` — canonical ontology output in Turtle.
- `docs/` — phase summaries and source notes.
- `docker/` — Docker assets for running Apache Jena Fuseki.
- `shacl/` — mounted workspace for SHACL shapes.

## Running the Dockerized Query Environment
### Prerequisites
- Docker and Docker Compose (v2 plugin).

### Start Fuseki
```bash
docker compose up --build
```

The Fuseki UI will be available at:
- `http://localhost:3030/`

The SPARQL query endpoint is:
- `http://localhost:3030/ttf/query`

### Example Query
```sparql
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>

SELECT ?class
WHERE {
  ?class rdf:type owl:Class .
}
LIMIT 20
```

### SHACL Workspace
Place SHACL shape files in `shacl/` on the host. They will be mounted into the container at `/opt/ttf/shacl` for future validation workflows.
