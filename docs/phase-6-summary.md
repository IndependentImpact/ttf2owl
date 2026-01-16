# Phase 6 Summary — Dockerized Query Environment (Apache Jena)

## Outcomes
- Added a Dockerized Apache Jena Fuseki environment that loads `ontology/ttf.ttl` on startup.
- Included a Fuseki configuration and startup script to initialize the TDB2 dataset only when empty.
- Added a SHACL workspace directory that is mounted into the container for future constraint work.
- Documented how to run and query the container, including a sample SPARQL query.

## Key Files
- `docker/fuseki/Dockerfile`
- `docker/fuseki/start-fuseki.sh`
- `docker/fuseki/ttf-config.ttl`
- `docker-compose.yml`
- `shacl/README.md`

## Run Instructions
1. `docker compose up --build`
2. Open the Fuseki UI at `http://localhost:3030/`.
3. Query endpoint: `http://localhost:3030/ttf/query`.

## Sample SPARQL Query
```sparql
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>

SELECT ?class
WHERE {
  ?class rdf:type owl:Class .
}
LIMIT 20
```
