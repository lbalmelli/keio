package ADAS_UrbanParallelParking_PoC {

	import ScalarValues::*;
	import SI::*;
	import ISQ::*;

	// ===================================
	// 1. ACTORS
	// ===================================
	def actor Driver {
		attribute startCommand: Boolean;
		attribute confirmationSignal: Boolean;
		attribute feedbackDisplay: String;
		doc "Driver provides commands and receives system feedback."
	}

	def actor Environment {
		attribute obstacleDistance: Real [m];
		attribute lightLevel: Real;
		doc "Environment represents real-world conditions around the vehicle."
	}

	// ===================================
	// 2. SYSTEM DEFINITION
	// ===================================
	def part ADAS_ParkingSystem {
		doc "ADAS Parking System combining sensing, control, and actuation."

		attribute parkingStatus: Enumeration { idle, scanning, confirming, parking, paused, completed };
		attribute detectedSpaceWidth: Real [m];
		attribute vehicleSpeed: Real [m/s];
		attribute steeringAngle: Real [deg];

		port driverInterface: Driver;
		port envSensors: Environment;

		exhibit state 'Parking Behavior';
	}

	// ===================================
	// 3. STATE-BASED BEHAVIOR
	// ===================================
	def state 'Parking Behavior' {

		doc "Proof-of-concept behavior showing how the ADAS system progresses through parking phases."

		state idle;
		state scanning;
		state confirming;
		state parking;
		state paused;
		state completed;

		transition 'idle-scanning'
			first idle
			accept at driverInterface.startCommand
			then scanning;

		transition 'scanning-confirming'
			first scanning
			accept when detectedSpaceWidth >= 5.0
			do driverInterface.feedbackDisplay = "Spot Found – Confirm to Start"
			then confirming;

		transition 'confirming-parking'
			first confirming
			accept at driverInterface.confirmationSignal
			do driverInterface.feedbackDisplay = "Parking Engaged"
			then parking;

		transition 'parking-paused'
			first parking
			accept when envSensors.obstacleDistance < 0.5
			do driverInterface.feedbackDisplay = "Paused – Obstacle Detected"
			then paused;

		transition 'paused-parking'
			first paused
			accept when envSensors.obstacleDistance >= 0.5
			do driverInterface.feedbackDisplay = "Resuming Parking"
			then parking;

		transition 'parking-completed'
			first parking
			accept when detectedSpaceWidth > 0 & vehicleSpeed == 0
			do driverInterface.feedbackDisplay = "Parking Completed"
			then completed;

		transition 'completed-idle'
			first completed
			accept at driverInterface.startCommand == false
			do driverInterface.feedbackDisplay = "System Ready"
			then idle;
	}

	// ===================================
	// 4. REQUIREMENTS FOR TRACEABILITY
	// ===================================
	def requirement REQ_01_DetectSpace {
		doc "System shall detect a suitable parallel parking space before starting maneuver."
	}

	def requirement REQ_02_DriverApproval {
		doc "System shall request driver confirmation prior to automatic control."
	}

	def requirement REQ_03_SafeManeuver {
		doc "System shall maintain safe distance from obstacles during maneuver."
	}

	satisfy ADAS_ParkingSystem -> REQ_01_DetectSpace;
	satisfy ADAS_ParkingSystem -> REQ_02_DriverApproval;
	satisfy ADAS_ParkingSystem -> REQ_03_SafeManeuver;

	// ===================================
	// 5. SYSTEM CONTEXT (Simplified)
	// ===================================
	def part UrbanParkingContext {
		part driver: Driver;
		part environment: Environment;
		part system: ADAS_ParkingSystem;

		flow driverToSystem_Start
			from driver.startCommand
			to system.driverInterface.startCommand;

		flow driverToSystem_Confirm
			from driver.confirmationSignal
			to system.driverInterface.confirmationSignal;

		flow envToSystem_Obstacle
			from environment.obstacleDistance
			to system.envSensors.obstacleDistance;
	}
}
