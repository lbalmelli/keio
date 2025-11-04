# Music Analysis Integrated Model (SysML v2)

## Goal of the Concept
The overall goal is to formalize **music analysis as a system of interacting conceptual and computational processes** that reveal *latent musical structures*—patterns of **symmetry, directionality, organicity, and fractality** underlying melodic behavior.  
By articulating these structures and their relationships to perception and theory, the model seeks to:

- Bridge **musicology** and **cognitive music science** through shared representations.  
- Enable **performers, listeners, and researchers** to experience and interpret the same latent forms.  
- Demonstrate that music analysis can generate *living musical experiences* rather than static descriptions.

---

## Approach to the Concept Creation

### 1. Concept Model (Theoretical Layer)
- Defines key entities: `LatentStructure`, `MusicalWork`, `AnalyticalProcess`, `Representation`, `TheoreticalFramework`, `Perception`, and `Engagement`.  
- Captures semantic relationships such as *LatentStructure is revealed by AnalyticalProcess* and *enhances Engagement*.  
- Serves as the philosophical map connecting musical meaning to perceptual and analytical activity.  

### 2. Context Model (Social and Interaction Layer)
- Identifies stakeholders—`Composer`, `Performer`, `Listener`, `Musicologist`, `CognitiveMusicologist`—and the **System of Interest** `MusicAnalysis`.  
- Describes how information (works, insights, representations) flows among these roles.  

### 3. Behavior Model (Process Layer)
- Models the analytical workflow:  
  `Collect Data → Extract Features → Infer (N-gram, Graph, Bayesian) → Fuse Latent Structures → Visualize → Derive Insight`.  
- States lifecycle phases (`idle → ingesting → analyzing → synthesizing → publishing`) showing how the system evolves during analysis.  

### 4. Requirements Model (Goal Layer)
- Expresses verifiable objectives:  
  - **R1 LatentStructureExtracted** – the system can detect latent structure.  
  - **R2 RepresentationShareable** – results can be shared and understood across roles.  
  - **R3 BridgeDisciplines** – connects theoretical and perceptual domains.  
  - **R4 EnlivenExperience** – enhances engagement through analysis.  
  - **R5 MethodologicalCoverage** – integrates N-gram, graph, Bayesian approaches.  
  - **R6 TraceableInteractions** – maintains observable information flow among stakeholders.  

### 5. PoC System Model (Experimental Layer)
- Implements a small-scale, executable prototype to verify feasibility of the concept.  
- Focuses on melodic interval (pitch-difference) analysis to demonstrate latent-structure extraction and Tonnetz-like visualization.

---

## List of the Main Components

| Layer | Component | Function |
|-------|------------|-----------|
| **Concept** | `LatentStructure` | Central abstraction of hidden musical order. |
| | `AnalyticalProcess` | Actions that reveal latent structures from musical data. |
| | `Representation` | Formal or visual depiction of latent structures. |
| | `Perception` / `Engagement` | Human experience and response to structure. |
| **Context** | `Composer`, `Performer`, `Listener`, `Musicologist`, `CognitiveMusicologist` | External agents exchanging musical data and insights. |
| **Behavior** | `CollectData`, `ExtractFeatures`, `InferNgram`, `InferGraph`, `InferBayes`, `FuseLatentStructure`, `VisualizeStructure`, `DeriveInsight` | Sequential analytical actions forming the workflow. |
| **Structure (PoC)** | `FeatureExtractor` | Produces Δ-pitch N-grams from symbolic input. |
| | `GraphBuilder` | Builds interval-transition graph. |
| | `ProbabilisticModeler` | Integrates HMM and Bayesian models to estimate latent structures. |
| | `GeometricVisualizer` | Computes Tonnetz-like 2-D embedding (MDS/UMAP) and renders visualization. |
| **Requirements** | R1–R6 (Integrated) and R1–R4 (PoC) | Define success criteria and trace to modules/actions. |

---

## Draft Plan for Implementation

### 1. Prototype Data Pipeline
**Flow:** Feature Extraction → Graph Construction → Visualization

- Input: symbolic data (MIDI or MusicXML).  
- Generate Δ-pitch N-grams (`music21`, `miditoolkit`).  
- Construct directed weighted graph (`NetworkX`, `igraph`).  

### 2. Probabilistic Modeling
**Flow:** Graph → HMM/Bayesian Integration

- Train Hidden Markov Model to estimate transition probabilities (`pomegranate`, `hmmlearn`).  
- Build Bayesian Network capturing dependencies among intervals (`pgmpy`, `PyMC`).  
- Fuse both models via joint likelihood or shared state representation.  

### 3. Geometric Embedding and Visualization
**Flow:** Probabilistic Model → 2D Tonnetz-like Layout → Visualization

- Derive distance matrix from transition probabilities.  
- Apply **MDS**, **UMAP**, or **Spectral Embedding** to compute 2-D coordinates.  
- Align axes (x = perfect fifth, y = third) through Procrustes rotation.  
- Render interactive visualization (`plotly`, `matplotlib`).  

### 4. Verification and Traceability
- Map each PoC action to requirements R1–R4 (pattern detection, view generation, insight recording, reproducibility).  
- Log metrics: pattern count, embedding stress, reconstruction error, and run hash for reproducibility.  

### 5. Future Extensions
- Incorporate perceptual-evaluation module to link visualization with listener feedback.  
- Extend to harmonic and rhythmic latent structures.  
- Integrate directly with the Integrated Model for end-to-end requirement satisfaction tracing.

---

## Summary
The integrated SysML v2 model provides a **coherent conceptual-to-computational framework** for music analysis.  
The PoC demonstrates that **latent musical structures** can be extracted, modeled probabilistically, and visualized geometrically using existing computational tools.  
This establishes a foundation for a comprehensive system that connects **musical theory, perception, and technology**.

---
