# Implementation Plan: Token Taxonomy Framework (TTF) OWL Ontology

## Phase 0 — Source intake & scope confirmation

**Objectives**
- Confirm required ontology output constraints (TTL-only, prefix requirements, mandatory classes/properties/individuals/axioms).
- Map the authoritative TTF repository sections that guide ontology scope.

**Key activities**
- Review local task requirements for ontology content, required namespaces, and output format.
- Capture the authoritative upstream sections from the InterWork Alliance Token Taxonomy Framework (TTF) repository.

**Deliverables**
- A scoped checklist of required OWL elements and output constraints.
- A pointer list of the upstream TTF repo sections (taxonomy overview, taxonomy model, control messages, artifact format, artifacts).
- Planned directory layout and file names:
  - `ontology/ttf.ttl` (final Turtle ontology output).
  - `docs/ImplementationPlan.md` (this plan, if documentation is stored under `docs/`).

**End-of-phase quality criteria**
- All required ontology components are enumerated and traceable to the task requirements.
- Upstream reference sources and their roles are explicitly listed.

---

## Phase 1 — Ontology schema design (classes & properties)

**Objectives**
- Define the OWL class hierarchy and object/data properties specified by the task requirements.
- Establish the Token Classification Hierarchy (TCH) in OWL using subclassing.

**Key activities**
- Create OWL classes: Token, BaseType (with Fungible, NonFungible, etc.), Behavior, PropertySet, BehaviorGroup, TokenTemplate, TokenFormula, TokenDefinition, TokenClass, TokenInstance, Artifact.
- Define object properties: hasBaseType, hasBehavior, hasPropertySet, hasGroup, composes, influences, incompatibleWith, parentOf, childOf.
- Define data properties: symbol, name, description, version.
- Model the TCH with subclasses for fungible vs non-fungible, divisibility/unit variants, and representation (unique/common).

**Deliverables**
- A complete OWL schema (classes + properties) consistent with the TTF vocabulary.
- TCH subtree definitions in OWL.
- Directory/file plan:
  - `ontology/schema.ttl` (schema-focused classes/properties, if separated).
  - `ontology/ttf.ttl` (merged final output).

**End-of-phase quality criteria**
- All required classes and properties exist with consistent domain/range intent.
- TCH branch structure is encoded as rdfs:subClassOf statements.

---

## Phase 2 — Behaviors, groups, and constraints

**Objectives**
- Represent behaviors, behavior groups, and their constraints/incompatibilities.

**Key activities**
- Create individuals for behaviors (e.g., Transferable, Divisible, Mintable, Burnable, Singleton, Delegable, Roles) with symbols.
- Define behavior groups (e.g., SupplyControl) and link them to behaviors.
- Encode incompatibilities (e.g., Singleton vs Divisible) using owl:disjointWith and/or incompatibleWith assertions.
- Add influences/dependencies where applicable (e.g., Delegable influences TransferFrom).

**Deliverables**
- Behavior and group individuals with correct properties.
- Incompatibility and influence axioms.
- Directory/file plan:
  - `ontology/behaviors.ttl` (behavior/group individuals, if separated).
  - `ontology/ttf.ttl` (merged final output).

**End-of-phase quality criteria**
- Behavior groups reference all required behaviors.
- Incompatibilities are represented in a way that supports OWL reasoning.

---

## Phase 3 — Template, formula, and definition modeling

**Objectives**
- Model token templates, formulas, and definitions, including hybrid composition.

**Key activities**
- Represent TokenTemplate as comprising TokenFormula + TokenDefinition.
- Encode artifact references (lightweight in formulas vs full in definitions) via properties or annotations.
- Model hybrid tokens using parent/child relationships and the composes property.
- Add example template expression elements (e.g., [τ {~d,SC} + φSKU]).

**Deliverables**
- Template/formula/definition classes with sample instances.
- Hybrid composition and parent/child relationships.
- Directory/file plan:
  - `ontology/templates.ttl` (template/formula/definition examples, if separated).
  - `ontology/ttf.ttl` (merged final output).

**End-of-phase quality criteria**
- Hybrid structures can be expressed with parent/child and composes relations.
- Template elements link base types, behaviors, groups, and property sets.

---

## Phase 4 — Artifact alignment & examples

**Objectives**
- Ensure ontology content aligns with TTF artifacts and examples.

**Key activities**
- Cross-check model elements against TTF taxonomy overview, model, control messages, artifact format, and sample artifacts.
- Add example instances for fungible, non-fungible, singleton, and hybrid tokens.
- Ensure examples use required symbols and align with TTF grammar expectations.

**Deliverables**
- Example individuals reflecting TTF examples and symbols.
- Coverage across base types, behaviors, groups, property sets, and templates.
- Directory/file plan:
  - `ontology/examples.ttl` (example instances, if separated).
  - `ontology/ttf.ttl` (merged final output).

**End-of-phase quality criteria**
- Example instances map to TTF examples.
- All required artifact types have at least one representative instance.

---

## Phase 5 — Validation & release readiness

**Objectives**
- Validate ontology coherence and output format compliance.

**Key activities**
- Run an OWL reasoner (if available) to confirm consistency and expected inferences.
- Verify TTL output constraints (prefixes first, TTL-only output, last line is a triple).

**Deliverables**
- A validated, coherent TTL ontology.
- Final TTL output formatted to specification.
- Directory/file plan:
  - `ontology/ttf.ttl` (single authoritative TTL output).

**End-of-phase quality criteria**
- Reasoner reports no inconsistencies.
- Output formatting meets TTL-only requirements exactly.

---

## Phase 6 — Dockerized query environment (Apache Jena)

**Objectives**
- Provide a Docker-based Apache Jena environment to host and query the ontology for testing and future development (e.g., SHACL constraints).

**Key activities**
- Create a Dockerfile (or docker-compose configuration) that spins up an Apache Jena Fuseki instance.
- Load the generated `ontology/ttf.ttl` into the dataset on container startup.
- Document local run and query instructions (including SPARQL endpoint URL and example query).
- Add SHACL-friendly wiring (e.g., volume mount or designated directory) to support future constraint files.

**Deliverables**
- Docker configuration for Apache Jena/Fuseki.
- Startup assets or scripts to preload the ontology dataset.
- Documentation updates for running and querying the container.

**End-of-phase quality criteria**
- Running the container exposes a queryable SPARQL endpoint backed by the ontology.
- A sample query returns expected classes/individuals from the ontology.
