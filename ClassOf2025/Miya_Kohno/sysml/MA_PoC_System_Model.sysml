package MusicAnalysis_PoC_SystemModel {

    import MusicAnalysis_PoC_SystemModel_Req public;

    // /* Exchange Items / Ports */
   
    package ExchangeItems {
        item def MidiData;
        item def PitchIntervalSeries;
        item def GraphData;
        item def ProbabilisticModel;
        item def LatentCoordinates;
        item def Visualization;
    };
    package Ports {
        port def MidiInput     { in  ref midi  : ExchangeItems::MidiData; };
        port def IntervalOut   { out ref intervals : ExchangeItems::PitchIntervalSeries; };
        port def GraphOut      { out ref graph : ExchangeItems::GraphData; };
        port def ModelOut      { out ref model : ExchangeItems::ProbabilisticModel; };
        port def LayoutOut     { out ref layout : ExchangeItems::LatentCoordinates; };
        port def ViewOut       { out ref view : ExchangeItems::Visualization; };
    };

        package Structure {
        part def FeatureExtractor {
            port midiIn : Ports::MidiInput;
            port intervalOut : Ports::IntervalOut;
            //  /* Δpitch N-grams (music21/miditoolkit). */;
        };
        part def GraphBuilder {
            port intervalIn : Ports::IntervalOut;
            port graphOut   : Ports::GraphOut;
            //  /* Directed weighted graph (NetworkX/igraph). */;
        };
        part def ProbabilisticModeler {
            port graphIn  : Ports::GraphOut;
            port modelOut : Ports::ModelOut;
            //  /* HMM + Bayesian integration (pomegranate/pgmpy/PyMC). */;
        };
        part def GeometricVisualizer {
            port modelIn   : Ports::ModelOut;
            port layoutOut : Ports::LayoutOut;
            port viewOut   : Ports::ViewOut;
            //  /* Tonnetz-like embedding (MDS/UMAP) + rendering. */;
        };

        part systemPoC {
            part featureExtractor : FeatureExtractor;
            part graphBuilder     : GraphBuilder;
            part probModeler      : ProbabilisticModeler;
            part geoVisualizer    : GeometricVisualizer;

            // only main connectino for simplicity
            interface connect featureExtractor.intervalOut.intervals to graphBuilder.intervalIn.intervals;
            interface connect probModeler.modelOut.model             to geoVisualizer.modelIn.model;
        };
    };

    package Behavior {

        //  /* Both control order (succession) and data flow (flow) are modeled. flow for drawing and succession for control sequence. 

        action ExtractIntervals {
            //  "Step 1 — Extract melodic intervals (Δpitch N-grams).";
            out intervals : ExchangeItems::PitchIntervalSeries;
        };
        action BuildGraph {
            //  "Step 2 — Construct interval-transition graph.";
            in  intervals : ExchangeItems::PitchIntervalSeries;
            out graph     : ExchangeItems::GraphData;
        };
        action TrainProbModel {
            // "Step 3 — Train HMM / Bayesian hybrid model.";
            in  graph : ExchangeItems::GraphData;
            out model : ExchangeItems::ProbabilisticModel;
        };
        action EmbedGeometry {
            // "Step 4 — Compute Tonnetz-like embedding (MDS / UMAP).";
            in  model  : ExchangeItems::ProbabilisticModel;
            out layout : ExchangeItems::LatentCoordinates;
        };
        action RenderVisualization {
            // "Step 5 — Render 2D visualization and output to viewer.";
            in  layout : ExchangeItems::LatentCoordinates;
            out view   : ExchangeItems::Visualization;
        };

        // /* --- Control Sequence (for concept retention) --- */;
        succession flow s1 from ExtractIntervals to BuildGraph;
        succession flow s2 from BuildGraph to TrainProbModel;
        succession flow s3 from TrainProbModel to EmbedGeometry;
        succession flow s4 from EmbedGeometry to RenderVisualization;

        // /* --- Dataflow (for drawing)  --- */;
        flow F1_Intervals
            from ExtractIntervals.intervals
            to   BuildGraph.intervals;
        flow F2_Graph
            from BuildGraph.graph
            to   TrainProbModel.graph;
        flow F3_Model
            from TrainProbModel.model
            to   EmbedGeometry.model;
        flow F4_Layout
            from EmbedGeometry.layout
            to   RenderVisualization.layout;

        // /* --- Execution Container --- */;
        part def PoC_Behavior {
            perform ExtractIntervals;
            perform BuildGraph;
            perform TrainProbModel;
            perform EmbedGeometry;
            perform RenderVisualization;
        };
    };
}