# Machine-Actionable DMP

Template based on the [RDA DMP Common Standard (DCS)](https://github.com/RDA-DMP-Common/RDA-DMP-Common-Standard) for machine-actionable Data Management Plans and the provided [JSON schema](https://github.com/RDA-DMP-Common/RDA-DMP-Common-Standard/tree/master/examples/JSON/JSON-schema) for machine-actionable DMPs. It also uses the [DCS Ontology](https://github.com/RDA-DMP-Common/RDA-DMP-Common-Standard/tree/master/ontologies) to allow export in RDF.


## Usage

This template is available through [DSW Registry](https://registry.ds-wizard.org/templates).


## Issues and Contributing

This document template for DSW is available as open-source via GitHub Repository [ds-wizard/madmp-template](https://github.com/ds-wizard/madmp-template), you can [report issues](https://github.com/ds-wizard/madmp-template/issues) there and fork it for customisations or contributions.


### Contributors

* **Marek Suchánek** <[marek.suchanek@ds-wizard.org](mailto:marek.suchanek@ds-wizard.org)>
  * ORCID: [0000-0001-7525-9218](https://orcid.org/0000-0001-7525-9218)
  * GitHub: [@MarekSuchanek](https://github.com/MarekSuchanek)
* **Kryštof Komanec** <[krystof.komanec@ds-wizard.org](mailto:krystof.komanec@ds-wizard.org)>
  * ORCID: [0000-0003-3856-1682](https://orcid.org/0000-0003-3856-1682)
  * GitHub: [@krystofkomanec](https://github.com/krystofkomanec)
* **Jana Martínková** <[jana.martinkova@ds-wizard.org]>(mailto:jana.martinkova@ds-wizard.org)>
  * ORCID: [0000-0001-8575-6533](https://orcid.org/0000-0001-8575-6533/)
  * GitHub: [@jmartinkova](https://github.com/jmartinkova)


## Changelog

### 1.17.0

- Add costs in project

### 1.16.0

- Adjusted to template metamodel version 13 (released in DSW 4.3.0)

### 1.15.0

- Adjusted to template metamodel version 12 (released in DSW 4.1.0)

### 1.14.0

- Adjusted to template metamodel version 11 (released in DSW 3.20.0)

### 1.13.1

- Fix defaults to prevent failure "Object of type Undefined is not JSON serializable"

### 1.12.0

- Adjusted to template metamodel version 9 (released in DSW 3.10.0)

### 1.11.0

- Compatible with `dsw:root:2.4.0`

### 1.10.0

- Adjusted to template metamodel version 8 (released in DSW 3.8.0)

### 1.9.0

- Adjusted to template metamodel version 7 (released in DSW 3.7.0)

### 1.8.0

- Adjusted to template metamodel version 6 (released in DSW 3.6.0)

### 1.7.0

- Adjusted to template metamodel version 5 (released in DSW 3.5.0)

### 1.6.0

- Added support for Turtle export without Blank nodes

### 1.5.0

- Adjusted to template metamodel version 4 (released in DSW 3.2.0)

### 1.4.0

- Adjusted to template metamodel version 3 (released in DSW 2.12.0)
- Fix licenses in RDF formats

### 1.3.1

- Fix problem with failing on missing Grant ID

### 1.3.0

- Fix ethical issues with non-reference datasets
- Compatible with `dsw:root:2.3.0`
- Added *data steward* contributor role

### 1.2.0

- Updated according to [RDA DMP Common Standard v1.1](https://github.com/RDA-DMP-Common/RDA-DMP-Common-Standard/releases/tag/v1.1)

### 1.1.0

- Adjusted to template metamodel version 2
- Allow `dsw:lifesciences:2.2.0` and higher

### 1.0.0

- Initial version based on results of [RDA hackathon on maDMPs 2020](https://rda-dmp-common.github.io/hackathon-2020/)
- Compatible with *DCS JSON Schema 1.0* and *DCSO 3.0.2*
