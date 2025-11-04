package MusicAnalysis_PoC_SystemModel_Req {

    doc
    /*
     * Proof-of-Concept System Model for "Latent Structure in Music Analysis" - Requirement
     * ---------------------------------------------------------------
     * Goal: prototype the extraction and visualization of latent musical structures
     * using currently available analytical and computational resources.
     */

    /* === Exchange Items (same PoC scope) === */
    package ExchangeItems {
        item def MusicalWork;
        item def FeatureSet;
        item def LatentStructurePrototype;
        item def Visualization;
        item def Insight;
    };

    /* === Ports === */
    package PortDefs {
        port def WorkInput        { in  ref work      : ExchangeItems::MusicalWork; };
        port def FeatureOut       { out ref features  : ExchangeItems::FeatureSet; };
        port def FeatureIn        { in  ref features  : ExchangeItems::FeatureSet; };
        port def StructureOut     { out ref structure : ExchangeItems::LatentStructurePrototype; };
        port def StructureIn      { in  ref structure : ExchangeItems::LatentStructurePrototype; };
        port def VisualizationOut { out ref view      : ExchangeItems::Visualization; };
        port def VisualizationIn  { in  ref view      : ExchangeItems::Visualization; };
        port def InsightOut       { out ref insight   : ExchangeItems::Insight; };
        port def InsightIn        { in  ref insight   : ExchangeItems::Insight; };
    };

    /* === PoC Functional Parts === */
    part def FeatureExtractor {
        doc /* Extract basic features (pitch/rhythm n-grams, interval/pulse stats). */;
        port workIn     : PortDefs::WorkInput;
        port featureOut : PortDefs::FeatureOut;

        // lightweight “evidence” that something was extracted
        assert constraint { featureOut.features != null };
    };

    part def LatentStructureEstimator {
        doc /* Build a small latent-structure prototype (e.g., motif graph/segments). */;
        port featureIn   : PortDefs::FeatureIn;
        port structureOut: PortDefs::StructureOut;

        // minimal correctness evidence: depends on features & produces structure
        assert constraint { featureIn.features != null & structureOut.structure != null };
    };

    part def Visualizer {
        doc /* Render structure (network/timeline overlay) for human inspection. */;
        port structureIn : PortDefs::StructureIn;
        port viewOut     : PortDefs::VisualizationOut;

        assert constraint { structureIn.structure != null & viewOut.view != null };
    };

    part def Interpreter {
        doc /* Read visualization and state the analytical insight in text. */;
        port viewIn    : PortDefs::VisualizationIn;
        port insightOut: PortDefs::InsightOut;

        assert constraint { viewIn.view != null & insightOut.insight != null };
    };

    /* === PoC System Configuration === */
    part systemContext {
        part featureExtractor : FeatureExtractor;
        part estimator        : LatentStructureEstimator;
        part visualizer       : Visualizer;
        part interpreter      : Interpreter;

        interface connect featureExtractor.featureOut.features to estimator.featureIn.features;
        interface connect estimator.structureOut.structure     to visualizer.structureIn.structure;
        interface connect visualizer.viewOut.view              to interpreter.viewIn.view;

        // PoC-level satisfaction of system goals
        part soi: PoCSystemProxy {
            satisfy Requirements::R1_PatternDetected;
            satisfy Requirements::R2_ViewGenerated;
            satisfy Requirements::R3_InsightRecorded;
            satisfy Requirements::R4_ReproducibleRun;
        };
    };

    /* === Requirements (usage) for PoC === */
    package Requirements {

        // definitions (templates)
        requirement def R1_PatternDetected_Def {
            text = "The PoC shall detect at least one non-trivial latent pattern (e.g., repeated n-gram or graph motif).";
            rationale = "Demonstrate feasibility of latent-structure extraction, even at small scale.";
        };
        requirement def R2_ViewGenerated_Def {
            text = "The PoC shall produce a human-inspectable visualization of the detected structure.";
            rationale = "Enable qualitative inspection to judge musical meaningfulness.";
        };
        requirement def R3_InsightRecorded_Def {
            text = "The PoC shall output a short textual insight derived from the visualization.";
            rationale = "Show that analysis can be communicated and archived.";
        };
        requirement def R4_ReproducibleRun_Def {
            text = "Running the PoC twice on the same input shall yield identical outputs (features/structure/view/insight).";
            rationale = "Ensure basic reproducibility for research credibility.";
        };

        // usages (instances) — satisfy must point to these
        requirement R1_PatternDetected  : R1_PatternDetected_Def;
        requirement R2_ViewGenerated    : R2_ViewGenerated_Def;
        requirement R3_InsightRecorded  : R3_InsightRecorded_Def;
        requirement R4_ReproducibleRun  : R4_ReproducibleRun_Def;
    };

    /* === Local proxy that the PoC ‘system’ can attach satisfy to === */
    part def PoCSystemProxy {
        // map module-level assertions to requirement intents (informal linkage notes)
        doc /* Acts as a trace anchor for PoC satisfaction links:
              - R1 via FeatureExtractor + LatentStructureEstimator assertions
              - R2 via Visualizer assertion
              - R3 via Interpreter assertion
              - R4 via scripted PoC run producing identical artifacts */
    };
}
