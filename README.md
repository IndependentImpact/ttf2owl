# Token Taxonomy Framework (TTF) OWL Ontology

## Overview
This repository contains an OWL ontology representation of the InterWork Alliance Token Taxonomy Framework (TTF), expressed in Turtle (`ontology/ttf.ttl`). It also includes documentation for each implementation phase and a Dockerized Apache Jena Fuseki environment for querying the ontology.

## Repository Layout
- `ontology/ttf.ttl` — canonical ontology output in Turtle.
- `docs/` — phase summaries and source notes.
- `docker/` — Docker assets for running Apache Jena Fuseki.
- `shacl/` — mounted workspace for SHACL shapes.

## Running the Dockerized Query Environment

This repository includes a pre-configured Apache Jena Fuseki server (via Docker) for exploring and querying the TTF OWL ontology interactively.

### Prerequisites
- Docker Desktop (or Docker + Docker Compose)
- Docker Compose v2 plugin (included in recent Docker Desktop versions)

### One-time Preparation
1. Make the custom startup script executable (required on Unix-like systems, including macOS/Linux):

   ```bash
   chmod +x docker/fuseki/start-fuseki.sh
   ```

This ensures the script can be run inside the container. (You only need to do this once unless you modify the file.)

(Optional but recommended) Build the custom Fuseki image explicitly:

```bash
docker build -t ttf-fuseki -f docker/fuseki/Dockerfile .
```
This step is optional if you rely on docker compose up --build, but doing it separately helps catch errors early.

### Start Fuseki
From the root of the repository, run:

```bash
docker compose up --build
```
--build ensures the image is (re)built if the Dockerfile, startup script, config, or ontology files have changed.

The container will:
* Load the TTF ontology (ontology/ttf.ttl) into a persistent TDB2 dataset on the first run
* Start Fuseki with your custom configuration (ttf-config.ttl)
* Expose the Fuseki UI and SPARQL endpoint

The services will be available at:

*Fuseki Admin UI:* http://localhost:3030/
*SPARQL Query Endpoint:* http://localhost:3030/ttf/query
*SPARQL Update Endpoint:* http://localhost:3030/ttf/update (if enabled in config)

### Stopping the Server

To temporarily halt work but retain the state and data without a requiring full recreation (with docker compose start), use: 

```bash
docker compose stop
```
The dataset is stored in a Docker volume (`fuseki_data` or similar — check `docker compose.yml`). Data survives container restarts but is deleted with `docker compose down -v`. To remove volumes (reset dataset) when needed, use :docker compose down -v

### Example SPARQL Query (in Fuseki UI or via endpoint)

```sparql
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX ttf: <https://w3id.org/tta/owl#>   # adjust prefix to match your ontology

SELECT ?class ?label
WHERE {
  ?class rdf:type owl:Class .
  OPTIONAL { ?class rdfs:label ?label }
}
ORDER BY ?label
LIMIT 20
```

### SHACL Validation Workspace
Place any SHACL shape files (.ttl or .shacl) in the shacl/ directory on your host.
They are automatically mounted into the container at /opt/ttf/shacl.
You can later extend the startup script or use the Fuseki UI / command line to run SHACL validation against the TTF dataset.

### Troubleshooting Tips

**Permission denied on start-fuseki.sh** → Run `chmod +x docker/fuseki/start-fuseki.sh` again.

**Dataset not loading** → Check container logs (`docker compose logs`) for errors from tdbloader2.

**Port 3030 already in use** → Stop other services or change the port mapping in docker-compose.yml.

**403 Forbidden when creating datasets** → This occurs when admin authentication is not provided. When creating or managing datasets via the Fuseki web UI, you must authenticate with the admin credentials (see Admin Authentication section below). Your browser should automatically prompt for credentials when you attempt admin operations.

**Apple Silicon (M1/M2/M3) warning** → Normal — the base image is amd64; emulation works fine for this workload.

### Admin Authentication

Fuseki requires authentication for administrative operations (creating/deleting datasets, backups, etc.). The server is configured with the following default credentials:

**Username:** `admin`  
**Password:** `admin`

⚠️ **Security Note:** These default credentials are suitable for local development only. For production deployments, change the password in `docker/fuseki/shiro.ini` before building the image.

When accessing the Fuseki web UI at http://localhost:3030/, you'll need to provide these credentials for any admin operations like creating new datasets. Your browser will prompt for HTTP Basic Authentication when you attempt these operations.

### SHACL Workspace
Place SHACL shape files in `shacl/` on the host. They will be mounted into the container at `/opt/ttf/shacl` for future validation workflows.

You should now have a fully functional, persistent Fuseki instance with the Token Taxonomy Framework ontology loaded and ready to query.
