# Phase 1 summary: ontology schema design (classes & properties)

## Phase 1 scope
- Define core OWL classes, object properties, and data properties required for the TTF ontology.
- Encode the Token Classification Hierarchy (TCH) using `rdfs:subClassOf` and OWL restrictions.

## Implemented ontology updates
- Added core classes for tokens, base types, behaviors, property sets, behavior groups, templates, formulas, definitions, classes, instances, and artifacts.
- Defined object properties for base types, behaviors, property sets, groups, template composition, influences, incompatibilities, and parent/child relations.
- Defined data properties for symbols, names, descriptions, versions, and formula expressions.
- Modeled the TCH for fungible and non-fungible tokens, including fractional fungible and singleton non-fungible restrictions.

## Phase 1 completion criteria status
- **All required classes and properties exist with consistent domain/range intent:** ✅ Met (see core classes and property declarations in `ontology/ttf.ttl`).
- **TCH branch structure is encoded as rdfs:subClassOf statements:** ✅ Met (fungible/non-fungible hierarchy with fractional and singleton restrictions).
