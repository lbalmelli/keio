ADAS Urban Parallel Parking System — Conceptual Model Overview
Goal of the Concept

The goal of the ADAS Urban Parallel Parking System is to enable a vehicle to autonomously perform safe, efficient parallel parking maneuvers in dense urban environments.

The system aims to:

Reduce driver workload and parking-related stress.

Detect suitable parking spaces using onboard environment sensors.

Request and receive driver approval before initiating control.

Safely execute steering, acceleration, and braking during the maneuver.

Adapt dynamically to environmental factors such as obstacles, lighting, and road markings.

Ultimately, the concept demonstrates how Model-Based Systems Engineering (MBSE) using SysML v2 can integrate sensing, control logic, and driver interaction into a coherent and verifiable system.

Approach to the Concept Creation

This concept was created using a SysML v2 model-driven approach to formally capture both the structural and behavioral architecture of the automated parking feature.

Key Steps in the Approach:

Define Actors:
Identify the external entities interacting with the system — Driver and Environment.

Define System Part:
Model the ADAS_ParkingSystem as a cohesive subsystem responsible for perception, decision, and actuation during parking.

Define Interaction Flows:
Establish clear data and control flows between actors and system ports (e.g., start commands, obstacle distance, feedback display).

Define Requirements and Traceability:
Link formal requirements (REQ_01–REQ_03) to system parts for traceable verification against detection, confirmation, and safety objectives.

Contextual Integration:
Create an UrbanParkingContext showing the complete interaction between driver, environment, and system, enabling simulation and digital twin execution.

This model-driven methodology ensures logical consistency, traceability, and simulation readiness — essential for early-stage validation and future system integration.

List of the Main Components
Component	Description
Driver (Actor)	Represents the human operator who activates and supervises the automated parking process. Interacts with the system through commands (startCommand, confirmationSignal) and receives feedback (feedbackDisplay).
Environment (Actor)	Represents external conditions and influences such as nearby vehicles, pedestrians, road visibility, and lighting. Provides dynamic inputs like obstacleDistance, lightLevel, and roadMarkingVisibility.
ADAS_ParkingSystem (System Part)	The automated subsystem integrating sensors, perception algorithms, and control logic. Manages detection of parking spaces, driver communication, and maneuver execution.
UrbanParkingContext (Context Part)	The top-level system context that defines the interaction and information flow between the driver, environment, and the parking system. Serves as the integration and simulation boundary for the concept.
Requirements (REQ_01–REQ_03)	Define measurable objectives: space detection, driver approval, and safe maneuver execution. Ensure design traceability and support safety certification readiness.
Draft Plan for Implementation
Phase	Description	Deliverable
1. Model Refinement	Enhance SysML v2 model by adding detailed state machine behavior (idle → scanning → confirming → parking → completed).	Updated SysML v2 package (ADAS_UrbanParallelParking_PoC.sysml)
2. Simulation Integration	Connect model attributes and flows to a digital twin prototype (e.g., Python Tkinter or Modelica simulation).	digital_twin_dashboard.py prototype
3. Virtual Testing	Run simulation scenarios (normal operation, obstacle detection, low light, failed confirmation) to validate requirements.	Test logs and behavior reports
4. Verification & Traceability	Establish requirement satisfaction links for REQ_01–REQ_03 within the SysML toolchain.	Traceability matrix
5. Stakeholder Demonstration	Visualize the system using simulation dashboard and report findings in an engineering review.	Presentation-ready demonstration and PoC summary

This plan ensures a structured progression from concept definition to simulation-based validation and stakeholder evaluation.

Visual Representation

A visual context diagram can help stakeholders quickly understand the relationships between the Driver, Environment, and ADAS Parking System.

![alt text](image.png)

