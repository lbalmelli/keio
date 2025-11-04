# 🎼 Element Mapping Table for *MusicAnalysis_PoC_SystemModel*

This table documents the correspondence between **conceptual elements**, **SysML v2 model components**,  
and their **behavioral actions and computational implementations** within the Proof-of-Concept (PoC) system.  
It provides traceability across the conceptual, structural, and practical layers of the model—  
showing how theoretical constructs such as *LatentStructure* and *Representation* are realized through  
specific PoC modules, analytical actions, and software tools.

| Concept Model Element | Structure Model Part / Port | Behavior (Action / Flow) | Implementation / Tools | Purpose / Note |
|------------------------|-----------------------------|---------------------------|-------------------------|----------------|
| **MusicalWork** | `Ports::MidiInput`<br>`FeatureExtractor.midiIn` | `ExtractIntervals` | `music21`, `miditoolkit` | Input source (MIDI, symbolic score). |
| **AnalyticalProcess** | `FeatureExtractor`, `GraphBuilder` | `ExtractIntervals → BuildGraph` | `music21`, `NetworkX`, `nltk` | Generate N-gram intervals and construct directed graph. |
| **LatentStructure** | `ProbabilisticModeler` | `TrainProbModel` | `pomegranate`, `pgmpy`, `PyMC` | Build HMM / Bayesian model to represent latent musical order. |
| **Representation** | `GeometricVisualizer` | `EmbedGeometry`, `RenderVisualization` | `scikit-learn` (MDS, UMAP), `plotly`, `matplotlib` | Compute Tonnetz-like 2D layout and visualize latent structure. |
| **Perception** | *(Not modeled internally)* — to be linked with evaluation module later | — | `plotly` (interactive visualization) | Perceptual interpretation of generated structure. |
| **Engagement** | *(External effect)* | — | — | Represents how visualization enhances user understanding. |
| **AnalysisMethod** | `Ports::MethodInput` *(optional future extension)* | — | `"N-gram"`, `"Graph"`, `"HMM"`, `"Bayesian"` | Parameter specifying analysis type. |
| **Requirements::R1_PatternDetected** | `ProbabilisticModeler.assert constraint` | `TrainProbModel` | Validation script (Python) | Detect non-trivial latent pattern. |
| **Requirements::R2_ViewGenerated** | `GeometricVisualizer` | `RenderVisualization` | `Plotly`, `MATLAB` | Generate inspectable 2D representation. |
| **Requirements::R3_InsightRecorded** | *(Future)* `Interpreter` module | — | Jupyter notebook summary | Record textual analytical insight. |
| **Requirements::R4_ReproducibleRun** | `systemPoC` *(entire workflow)* | All `flow` actions | Pipeline orchestration (Jupyter / CLI) | Verify reproducible analysis results. |
