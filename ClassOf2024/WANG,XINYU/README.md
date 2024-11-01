# Traffic Flow Prediction System Model

This repository contains a **Traffic Flow Prediction System** developed in SysML v2. The model leverages a hybrid neural network to analyze and predict traffic flow, considering various inputs such as traffic density, road capacity, and environmental conditions. Both the full model and a simplified Proof-of-Concept (PoC) version are provided to demonstrate different levels of system detail and functionality.

## Model Overview

### Full Model
The full **Traffic Flow Prediction System** model provides a comprehensive structure that includes several layers and components of a neural network along with detailed data sources, condition analyzers, and prediction actions. This model is suitable for in-depth system analysis, including the interactions between different layers of the neural network and data processing components.

### PoC Model
The **PoC Model** is a simplified version of the Traffic Flow Prediction System. It includes the essential components and connections needed to validate the system's capability for traffic flow prediction, focusing on core functionality without all the layers and complexity of the full model. This version is ideal for initial testing and conceptual validation.

## Model Structure

The structure for each model is as follows:

### Full Model Components

| Component               | Type          | Description                                                              |
|-------------------------|---------------|--------------------------------------------------------------------------|
| `NeuralNetwork`         | part          | Comprehensive neural network with multiple layers for traffic prediction |
| `RecurrentLayer`        | part          | Captures sequential traffic patterns over time                           |
| `ConvolutionLayer`      | part          | Identifies spatial patterns within traffic data                          |
| `FullyConnectedLayer`   | part          | Consolidates features from previous layers for final predictions         |
| `TrafficDataSource`     | part          | Provides traffic data inputs, such as density and speed                  |
| `WeatherConditions`     | part          | Supplies environmental data, including temperature and visibility        |
| `TrafficConditionAnalyzer` | part       | Processes and normalizes traffic data for neural network input           |
| `PredictionSystem`      | part          | Integrates all components to perform traffic flow predictions            |
| `dataToAnalyzer`        | interface     | Connection linking data source to analyzer for data processing           |
| `analyzerToNN`          | interface     | Connection linking analyzer to neural network for further processing     |
| `PredictFlow`           | action        | Core action to produce traffic flow predictions                          |
| `ProvideData`           | action        | Supplies traffic density and other relevant data                         |
| `AnalyzeTraffic`        | action        | Processes traffic data for use in neural network                         |
| `GeneratePrediction`    | action        | Action that produces the final traffic prediction output                 |

### PoC Model Components

| Component               | Type          | Description                                                              |
|-------------------------|---------------|--------------------------------------------------------------------------|
| `NeuralNetwork_PoC`     | part          | Core neural network component for traffic prediction                     |
| `TrafficDataSource_PoC` | part          | Simplified data source for traffic density                               |
| `TrafficConditionAnalyzer_PoC` | part   | Basic analyzer for processing traffic data                               |
| `PredictionSystem_PoC`  | part          | Main PoC system integrating essential components                         |
| `dataToAnalyzer`        | interface     | Connection from traffic data source to analyzer                          |
| `analyzerToNN`          | interface     | Connection from analyzer to neural network                               |
| `PredictFlow_PoC`       | action        | Action for predicting traffic flow in PoC model                          |
| `ProvideData_PoC`       | action        | Supplies traffic data in the PoC model                                   |
| `AnalyzeTraffic_PoC`    | action        | Processes data for neural network in PoC                                 |
| `GeneratePrediction`    | action        | Final action to generate traffic predictions in PoC model                |

## Getting Started

### Prerequisites
- **SysML v2 Modeling Tool**: Both models use SysML v2 syntax. Make sure your modeling tool is compatible with SysML v2.

### Usage
1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/TrafficFlowPredictionSystem.git
