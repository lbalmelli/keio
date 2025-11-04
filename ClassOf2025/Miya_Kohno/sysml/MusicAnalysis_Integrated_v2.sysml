package MusicAnalysis_Integrated_v2 {

    doc
    /*
     * [Problem Statement]
     * ---------------------------------------------------
     * Through musical analysis, I wish to reveal the latent structure present within music
     * "Latent structure" refers to naturally occurring principles such as fractal properties, 
     * symmetry, the intentionality seen in Goethe's “Forming”, and organicity (a state of 
     * cohesion as a system). 
     *
     * By enabling performers and listeners to share this latent structure, I aim to realise 
     * a more vivid musical experience.
     *
     * Furthermore, conventional music analysis has primarily focused on visualising manifest 
     * structures, which is thought to constitute a gap between musicology and cognitive musicology. 
     * By visualising latent structures, we wish to contribute towards bridging this gap between 
     * musicology and cognitive musicology.
     * 
     * [Integrated System Model for "Music Analysis" (rev2)]
     * ---------------------------------------------------
     * This model integrates Context, Concept, Behavior, and Requirements Models.
     * PoC System Model (MusicAnalysis_PoC_SystemModel) can be imported separately.
     */

    import ScalarValues::* public;

    package ContextModel {
        doc "Context Model: stakeholders, exchanges, and the system boundary.";

        package ExchangeItems {
            item def MusicalWork;
            item def AnalyticalInsight;
            item def LatentStructureRepresentation;
            item def PerceptualResponse;
            item def TheoreticalFramework;
            item def AnalysisMethod;
        };

        package PortDefs {
            import ExchangeItems::* public;

            port def MusicInput { in ref work: MusicalWork; };
            port def InsightOutput { out ref insight: AnalyticalInsight; };
            port def StructureOutput { out ref structure: LatentStructureRepresentation; };
            port def PerceptionInput { in ref response: PerceptualResponse; };
            port def TheoryInput { in ref theory: TheoreticalFramework; };
            port def MethodInput { in ref method: AnalysisMethod; };
        };

        package RoleDefs {
            import PortDefs::* public;

            part def Composer {
                port provideWork: MusicInput;
                port receiveInsight: InsightOutput;
            };
            part def Performer {
                port performWork: MusicInput;
                port receiveInsight: InsightOutput;
            };
            part def Listener {
                port perceiveStructure: StructureOutput;
                port providePerception: PerceptionInput;
            };
            part def Musicologist {
                port provideTheory: TheoryInput;
                port receiveInsight: InsightOutput;
            };
            part def CognitiveMusicologist {
                port providePerceptualModel: TheoryInput;
                port receiveInsight: InsightOutput;
            };

            part def MusicAnalysis {
                port workIn: MusicInput;
                port methodIn: MethodInput;
                port theoryIn: TheoryInput;
                port perceptionIn: PerceptionInput;
                port insightOut: InsightOutput;
                port structureOut: StructureOutput;
            };
        };

        package Context {
            import RoleDefs::* public;

            part systemContext {
                part composer: Composer;
                part performer: Performer;
                part listener: Listener;
                part musicologist: Musicologist;
                part cogSci: CognitiveMusicologist;
                part soi: MusicAnalysis;

                interface composerToSOI connect composer.provideWork to soi.workIn;
                interface performerToSOI connect performer.performWork to soi.workIn;
                interface musicologistToSOI connect musicologist.provideTheory to soi.theoryIn;
                interface cogSciToSOI connect cogSci.providePerceptualModel to soi.theoryIn;
                interface listenerToSOI connect listener.providePerception to soi.perceptionIn;

                interface insights connect soi.insightOut to composer.receiveInsight;
                interface insightsToPerformer connect soi.insightOut to performer.receiveInsight;
                interface insightsToMusicologist connect soi.insightOut to musicologist.receiveInsight;
                interface insightsToCogSci connect soi.insightOut to cogSci.receiveInsight;
                interface structures connect soi.structureOut to listener.perceiveStructure;
            };
        };
    };

    package ConceptModel {
        doc "Concept Model: semantic relationships centered on LatentStructure.";

        item def MusicalWork {
            attribute title : String;
            attribute composer : String;
        };

        item def AnalyticalProcess {
            attribute methodUsed : String;
            ref analyzes : MusicalWork;
        };

        item def Representation {
            attribute medium : String;
        };

        item def TheoreticalFramework {
            attribute paradigm : String;
        };

        item def Perception {
            attribute coherence : ScalarValues::Real;
            attribute surprise  : ScalarValues::Real;
            attribute valence   : ScalarValues::Real;
            attribute arousal   : ScalarValues::Real;
            attribute relaxation : ScalarValues::Real;
            attribute tension     : ScalarValues::Real;
            attribute joyfulness  : ScalarValues::Real;
            attribute sadness     : ScalarValues::Real;
        };

        item def Engagement {
            attribute intensity : ScalarValues::Real;
            attribute description : String;
        };

        item def LatentStructure {
            attribute fractality : ScalarValues::Real;
            attribute symmetry   : ScalarValues::Real;
            attribute organicity : ScalarValues::Real;
            attribute teleology  : String;
            attribute description : String;

            ref originatesFrom : MusicalWork;
            ref revealedBy     : AnalyticalProcess;
            ref representedBy  : Representation;
            ref interpretedBy  : TheoreticalFramework;
            ref perceivedAs    : Perception;
            ref enhances       : Engagement;
        };
    };

    package BehaviorModel {
        doc "Behavior Model: analytical process pipeline for latent structure analysis.";

        import ContextModel::ExchangeItems::*;
        import ContextModel::PortDefs::*;

        package Actions {
            action CollectData {
                out work: MusicalWork;
                out method: AnalysisMethod;
                out theory: TheoreticalFramework;
                out perception: PerceptualResponse;
            };

            action ExtractFeatures {
                in  work: MusicalWork;
                out features: FeatureSet;
            };

            action InferNgram { in features: FeatureSet; out latentN: LatentStructure; };
            action InferGraph { in features: FeatureSet; out latentG: LatentStructure; };
            action InferBayes { in features: FeatureSet; out latentB: LatentStructure; };

            action FuseLatentStructure {
                in  latentN: LatentStructure;
                in  latentG: LatentStructure;
                in  latentB: LatentStructure;
                out latent:  LatentStructure;
            };

            action VisualizeStructure {
                in  latent: LatentStructure;
                out view:  LatentStructureRepresentation;
            };

            action DeriveInsight {
                in  view: LatentStructureRepresentation;
                out insight: AnalyticalInsight;
            };

            succession flow f1 from CollectData.work to ExtractFeatures.work;
            succession flow f2 from ExtractFeatures.features to InferNgram.features;
            succession flow f3 from ExtractFeatures.features to InferGraph.features;
            succession flow f4 from ExtractFeatures.features to InferBayes.features;
            succession flow f5 from InferNgram.latentN to FuseLatentStructure.latentN;
            succession flow f6 from InferGraph.latentG to FuseLatentStructure.latentG;
            succession flow f7 from InferBayes.latentB to FuseLatentStructure.latentB;
            succession flow f8 from FuseLatentStructure.latent to VisualizeStructure.latent;
            succession flow f9 from VisualizeStructure.view to DeriveInsight.view;
        };

        package RoleDefs {
            part def MusicAnalysis {
                port workIn: MusicInput;
                port methodIn: MethodInput;
                port theoryIn: TheoryInput;
                port perceptionIn: PerceptionInput;
                port structureOut: StructureOutput;
                port insightOut: InsightOutput;

                perform Actions::CollectData;
                perform Actions::ExtractFeatures;
                perform Actions::InferNgram;
                perform Actions::InferGraph;
                perform Actions::InferBayes;
                perform Actions::FuseLatentStructure;
                perform Actions::VisualizeStructure;
                perform Actions::DeriveInsight;

                state 'analysis-lifecycle' {
                    state idle;
                    state ingesting;
                    state analyzing;
                    state synthesizing;
                    state publishing;

                    transition 'start-ingest'
                        first idle
                        accept 'Work Received'
                        then ingesting;

                    transition 'start-analysis'
                        first ingesting
                        accept 'Features Ready'
                        then analyzing;

                    transition 'start-synthesis'
                        first analyzing
                        accept 'Latent Hypotheses Ready'
                        then synthesizing;

                    transition 'start-publish'
                        first synthesizing
                        accept 'Representation Ready'
                        then publishing;
                };
            };
        };
    };

    package RequirementsModel {
        doc "Requirement definitions and satisfaction traces.";

        package Requirements {
            requirement def R1_LatentStructureExtracted_Def {
                text = "音楽に内在する潜在構造を抽出できること";
                rationale = "顕在構造の可視化に偏らず、自然的秩序を扱うため";
            };
            requirement def R2_RepresentationShareable_Def {
                text = "抽出した潜在構造を共有可能な表現として提示できること";
            };
            requirement def R3_BridgeDisciplines_Def {
                text = "潜在構造の可視化が音楽学と認知音楽学の橋渡しを行うこと";
            };
            requirement def R4_EnlivenExperience_Def {
                text = "潜在構造の共有を通じて音楽体験の活性化に寄与すること";
            };
            requirement def R5_MethodologicalCoverage_Def {
                text = "N-gram・グラフ理論・ベイズ等、複数の方法を統合できること";
            };
            requirement def R6_TraceableInteractions_Def {
                text = "ステークホルダー間の情報フローを追跡可能にすること";
            };

            requirement R1_LatentStructureExtracted : R1_LatentStructureExtracted_Def;
            requirement R2_RepresentationShareable : R2_RepresentationShareable_Def;
            requirement R3_BridgeDisciplines : R3_BridgeDisciplines_Def;
            requirement R4_EnlivenExperience : R4_EnlivenExperience_Def;
            requirement R5_MethodologicalCoverage : R5_MethodologicalCoverage_Def;
            requirement R6_TraceableInteractions : R6_TraceableInteractions_Def;
        };

        package Trace {
            satisfy from ContextModel::Context::systemContext::soi
                    to Requirements::R1_LatentStructureExtracted;
            satisfy from ContextModel::Context::systemContext::soi
                    to Requirements::R2_RepresentationShareable;
            satisfy from ContextModel::Context::systemContext::soi
                    to Requirements::R3_BridgeDisciplines;
            satisfy from ContextModel::Context::systemContext::soi
                    to Requirements::R4_EnlivenExperience;
            satisfy from ContextModel::Context::systemContext::soi
                    to Requirements::R5_MethodologicalCoverage;
            satisfy from ContextModel::Context::systemContext::soi
                    to Requirements::R6_TraceableInteractions;
        };
    };

    import MusicAnalysis_PoC_SystemModel public;   // optional external prototype

};