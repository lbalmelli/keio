# System_Model_for_Music_Analysis
Artifacts from SysML v2 class by @lbalmelli

## Music Analysis Integrated Model (SysML v2)

This repository contains a **conceptual and computational model** of *Music Analysis* developed in **SysML v2**.  
It integrates theoretical, behavioral, and proof-of-concept (PoC) models to reveal **latent musical structures**  
(fractality, symmetry, organicity, and formative impulse) and to bridge **musicology** and **cognitive musicology**.

---

### Repository Contents

| File | Description |
|------|--------------|
| [MusicAnalysis_Integrated_v2.sysml](sysml/MusicAnalysis_Integrated_v2.sysml) | Main SysML v2 model integrating Context, Concept, Behavior, and Requirements layers. |
| [MusicAnalysis_PoC_SystemModel.sysml](sysml/MA_PoC_System_Model.sysml) | Proof-of-Concept structural and behavioral model demonstrating practical analysis pipeline. |
| [MusicAnalysis_PoC_SystemModel_Req.sysml](sysml/MA_PoC_Req.sysml) | PoC requirements verifying feasibility (pattern detection, visualization, reproducibility). |
| [model.md](doc/model.md) | High-level documentation explaining the goal, approach, main components, and implementation plan. |
| [prompt.md](doc/prompt.md) | Chronological record of prompts and design reasoning tracing model evolution using ChatGPT SysML v2 Model Creator. |
| [poc.md](doc/poc.md) | Demonstration of how selected conceptual structures are being realized computationally using off-the-shelf tools. |
| [element_mapping_table.md](doc/element_mapping_table.md) | Mapping table showing how conceptual elements correspond to SysML model components and PoC implementations. |
| [diagram.pdf](doc/MK_System_Model_Music_Analysis.pdf) | Diagram for presentation |
| `README.md` | (this file) Overview and guidance for using the repository. |

---

### Overview

The model formalizes **music analysis** as an interacting system of human and computational components.  
It connects five stakeholder roles (Composer, Performer, Listener, Musicologist, Cognitive Musicologist)  
with a central *MusicAnalysis* process that extracts and shares latent structures.

---

### Quick Start

1. Install [SysIDE modeler](https://docs.sensmetry.com/latest/modeler/install.html#modeler-install) as a plugin for editors (VScode, Cursor, VSCodium).  
2. Explore the main packages:
   - `ContextModel` – stakeholders and information exchanges  
   - `ConceptModel` – semantic structure centered on `LatentStructure`  
   - `BehaviorModel` – analytical workflow actions  
   - `RequirementsModel` – verifiable system objectives  
3. Inspect the **PoC System Model** to view a running analytical pipeline  
   (`FeatureExtractor → GraphBuilder → ProbabilisticModeler → GeometricVisualizer`).

---

### Implementation Notes

- The PoC can be prototyped in Python using:
  - `music21`, `miditoolkit` for symbolic feature extraction  
  - `NetworkX`, `igraph`,`cytoscape`  for graph analysis  
  - `pomegranate`, `pgmpy`, `PyMC` for HMM/Bayesian modeling  
  - `scikit-learn`, `UMAP`, `matplotlib`, `plotly` for geometric embedding and visualization  
- See **model.md** for the conceptual goal and plan, and **prompt.md** for the development rationale.

---
