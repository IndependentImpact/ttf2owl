# Phase 0 summary: source intake & scope confirmation

## Scoped checklist of required OWL elements and output constraints

### Required namespaces/output
- Output must be **Turtle (TTL) only**, with no explanatory text outside the TTL block.
- Start with `@prefix` declarations and end with the last triple.
- Required namespaces: `ttf: <http://interworkalliance.org/ttf#>`, plus `rdf:`, `rdfs:`, `owl:`.

### Required OWL classes
- Token
- BaseType
  - Fungible
  - NonFungible
  - UniqueFungible
  - UniqueNonFungible
- Behavior (with subclasses/individuals for core behaviors like Transferable, Divisible, Mintable, Burnable, Singleton, Delegable, Roles)
- PropertySet
- BehaviorGroup
- TokenTemplate
- TokenFormula
- TokenDefinition
- TokenClass
- TokenInstance
- Artifact

### Required object properties
- hasBaseType
- hasBehavior
- hasPropertySet
- hasGroup
- composes
- influences
- incompatibleWith
- parentOf
- childOf

### Required data properties
- symbol
- name
- description
- version

### Required individuals (minimum set)
- Base types: `ttf:Fungible`, `ttf:NonFungible` (and unique variants as specified).
- Behaviors: `ttf:Transferable`, `ttf:Divisible`, `ttf:Mintable`, `ttf:Burnable`, `ttf:Singleton`, `ttf:Delegable`, `ttf:Roles`.
- Behavior group: `ttf:SupplyControl` with `ttf:hasBehavior` links to `ttf:Mintable`, `ttf:Burnable`, `ttf:Roles`.

### Required axioms/relationships
- Use `owl:disjointWith` for incompatible behaviors (e.g., `Singleton` vs `Divisible`).
- Use `owl:someValuesFrom` where required components are needed.
- Use `owl:equivalentClass` where the modeling calls for equivalences.
- Use `rdfs:subClassOf` to encode Token Classification Hierarchy (TCH).

## Upstream reference pointers (authoritative TTF repo sections)

See `docs/ttf-source-notes.md` for the consolidated list of source sections and filenames:
- Taxonomy Overview (`token-taxonomy.md`)
- Taxonomy Model (`taxonomy-model.md`)
- Control Messages (`token-control-messages.md`)
- Taxonomy Artifact Format (`taxonomy-artifact-format.md`)
- Artifacts (`artifacts/`)

## Planned directory layout
- `ontology/ttf.ttl` (final Turtle ontology output)
- `docs/ImplementationPlan.md`

## Phase 0 completion criteria status

### Quality criteria checklist
- **All required ontology components are enumerated and traceable to the task requirements:** ✅ Met (see scoped checklist above).
- **Upstream reference sources and their roles are explicitly listed:** ✅ Met (see reference pointers and `docs/ttf-source-notes.md`).

### Traceability notes
- Scope requirements are captured in the checklist above to align the ontology build with the base-type, behavior, group, template, and artifact requirements.
- Upstream references are documented in `docs/ttf-source-notes.md` to anchor later phases to the authoritative TTF repo sections.
