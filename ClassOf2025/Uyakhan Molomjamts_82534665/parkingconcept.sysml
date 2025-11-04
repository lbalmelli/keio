package ADAS_UrbanParallelParkingFlows {

	import ScalarValues::*;
	import SI::*;
	import ISQ::*;

	// ===============================
	// 1. ACTORS
	// ===============================
	def actor Driver {
		doc "The human operator who requests and supervises the automated parking."

		// Information exchanged between Driver and system
		attribute startCommand: Boolean;
		attribute confirmationSignal: Boolean;
		attribute feedbackDisplay: String;
	}

	def actor Environment {
		doc "Represents the surroundings (vehicles, pedestrians, lighting, and obstacles)."

		// Information the environment provides or changes dynamically
		attribute obstacleDistance: Real [m];
		attribute lightLevel: Real;
		attribute roadMarkingVisibility: Real;
	}

	// ===============================
	// 2. SYSTEM DEFINITION
	// ===============================
	def part ADAS_ParkingSystem {
		doc "Automated parking system including sensors, perception, and control logic."

		// Key system properties
		attribute detectedSpaceWidth: Real [m];
		attribute vehicleSpeed: Real [m/s];
		attribute steeringAngle: Real [deg];
		attribute parkingStatus: Enumeration { idle, scanning, confirming, parking, paused, completed };

		// Interaction ports
		port driverInterface: Driver;
		port envSensors: Environment;
	}

	// ===============================
	// 3. FLOW CONNECTIONS (SYSTEM CONTEXT)
	// ===============================
	def part UrbanParkingContext {
		doc "System context showing interactions between driver, system, and environment."

		// Instantiate actors and system
		part driver: Driver;
		part environment: Environment;
		part parkingSystem: ADAS_ParkingSystem;

		// Define the information flows
		flow driverToSystem_Start
			from driver.startCommand
			to parkingSystem.driverInterface.startCommand;

		flow driverToSystem_Confirm
			from driver.confirmationSignal
			to parkingSystem.driverInterface.confirmationSignal;

		flow systemToDriver_Feedback
			from parkingSystem.driverInterface.feedbackDisplay
			to driver.feedbackDisplay;

		flow environmentToSystem_Obstacle
			from environment.obstacleDistance
			to parkingSystem.envSensors.obstacleDistance;

		flow environmentToSystem_Lighting
			from environment.lightLevel
			to parkingSystem.envSensors.lightLevel;

		flow environmentToSystem_RoadMarking
			from environment.roadMarkingVisibility
			to parkingSystem.envSensors.roadMarkingVisibility;
	}

	// ===============================
	// 4. REQUIREMENTS (For Traceability)
	// ===============================
	def requirement REQ_01_DetectParkingSpace {
		doc "The system shall detect available parallel parking spaces using environment sensors."
	}

	def requirement REQ_02_ConfirmDriverApproval {
		doc "The system shall receive explicit driver approval before starting automatic parking."
	}

	def requirement REQ_03_ExecuteSafeManeuver {
		doc "The system shall control steering, acceleration, and braking safely."
	}

	satisfy ADAS_ParkingSystem -> REQ_01_DetectParkingSpace;
	satisfy ADAS_ParkingSystem -> REQ_02_ConfirmDriverApproval;
	satisfy ADAS_ParkingSystem -> REQ_03_ExecuteSafeManeuver;
}
