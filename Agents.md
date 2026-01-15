You are an expert in Semantic Web technologies and ontology engineering. Your task is to create a comprehensive OWL ontology that represents the official Token Taxonomy Framework (TTF) from the InterWork Alliance. The ontology must be output in Turtle (TTL) format for readability. Do not include any explanatory text outside the TTL code block; start directly with the @prefix declarations and end with the ontology definitions.

Base the ontology on the following structured summary of the TTF:

### Introduction to TTF
The Token Taxonomy Framework (TTF) provides a common language for modeling tokens across blockchain platforms. It defines tokens as digital representations of value, with accounts/wallets as repositories. Key goals include education, shared concepts, implementation-neutral definitions, a Token Classification Hierarchy (TCH), tooling, neutral terminology, collaborative workshops, standard artifacts, interoperability, regulatory sandbox, and organic growth.

### Key Concepts
- **Tokens**: Digital value representations, classified by type (fungible/non-fungible), unit (fractional/whole/singleton), value type, representation (common/unique), supply, and template type. Tokens can be templates, classes, or instances.
- **Base Types**: Rooted in a single base token with properties like name, symbol, quantity, owner.
  - Fungible (τ): Interchangeable.
  - Non-Fungible (τ**): Unique.
  - Unique variants: τ' (unique fungible), τ**' (unique non-fungible).
- **Properties**: Data attributes.
  - Behavioral: Tied to behaviors (e.g., balance via transfer).
  - Non-Behavioral (Property Sets): Independently settable, e.g., φ[Name] for properties like SKU, with φ[Name]' for unique. Can be nested or repeated.
- **Behaviors**: Capabilities/restrictions with logic and properties, e.g., transferable (t), divisible (d), mintable (m), burnable (b), singleton (s), delegable (g), roles (r). Behaviors can be internal/external, delegable, role-based, and have incompatibilities (e.g., s conflicts with d).
- **Groups**: Bundles of behaviors, e.g., Supply Control (SC) = {m, b, r}.

### Composition Framework
- **Token Template**: Comprises a formula (reusable components: base type, behaviors, property sets, groups) and a definition (specific values/settings).
- **Token Class**: Deployed template.
- **Token Instance**: Individual token.
- **Artifact References**: Lightweight in formulas, full in definitions for versioning.
- **Grammar**: Syntax for formulas, e.g., tF for fungible base, {t} for behaviors, +φSKU for properties, SC{m,b,r} for groups. Hybrids like [tN](tF) for parent-child.
- **Validation**: Check incompatibilities, dependencies, influences.

### Artifact Formats
- **Types**: Base types, behaviors, groups, property sets, templates (formulas, definitions, specifications).
- **Format**: JSON-serializable Taxonomy Object Model (TOM). Stored hierarchically with versions.
- **Structure**: Symbols/IDs, control messages (e.g., TransferRequest), documentation, diagrams.
- **Taxonomy Model**: Hierarchical with nested collections.

### Examples
- Fungible: τ {t,d}
- Non-Fungible: τ**
- Hybrid: τ** (τ*)
- Singleton: τ** {s}
- Template: [τ {~d,SC} + φSKU]

### Hierarchies and Relationships
- **TCH**: Tree from base token (τ), branching by type (fungible/non-fungible), unit (d/~d/s), representation (').
- **Template Hierarchy**: Formulas as branches, definitions as leaves. Hybrids nest parents/children.
- **Relationships**: Parent-child in hybrids, influences (e.g., delegable enables TransferFrom), incompatibilities, reusability of artifacts.

Map this to OWL as follows:
- Define namespaces: Use @prefix ttf: <http://interworkalliance.org/ttf#> . Include rdf, rdfs, owl.
- OWL Classes: Token, BaseType (with subclasses Fungible, NonFungible, etc.), Behavior (subclasses like Transferable, Divisible), PropertySet, BehaviorGroup, TokenTemplate, TokenFormula, TokenDefinition, TokenClass, TokenInstance, Artifact.
- Object Properties: hasBaseType, hasBehavior, hasPropertySet, hasGroup, composes (for hybrids), influences, incompatibleWith, parentOf, childOf.
- Data Properties: symbol, name, description, version.
- Individuals: Create instances for base types (e.g., ttf:Fungible rdf:type ttf:BaseType), behaviors (e.g., ttf:Transferable rdf:type ttf:Behavior ; ttf:symbol "t"), groups (e.g., ttf:SupplyControl rdf:type ttf:BehaviorGroup ; ttf:hasBehavior ttf:Mintable, ttf:Burnable, ttf:Roles).
- Axioms: Use owl:disjointWith for incompatibilities, owl:someValuesFrom for required components, owl:equivalentClass where appropriate.
- Hierarchy: Use rdfs:subClassOf for TCH (e.g., ttf:FractionalNonFungible rdfs:subClassOf ttf:NonFungible ; ttf:hasBehavior ttf:Divisible).
- Ensure the ontology is coherent, supports reasoning (e.g., infer incompatibilities), and covers composition rules.

Output only the TTL code, starting with prefixes and ending with the last triple.
