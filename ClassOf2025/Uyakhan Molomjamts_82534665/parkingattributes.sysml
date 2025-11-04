package ADAS_UrbanParallelParkingModel {

	import ScalarValues::*;
	import SI::*;
	import ISQ::*;

	// ===============================
	// 1. ACTORS
	// ===============================
	def actor Driver {
		attribute confirmationSignal: Boolean;
		doc "The human operator who requests and supervises the automated parking."
	}

	def actor Environment {
		attribute obstacleDistance: Real;
		attribute lightLevel: Real;
		doc "Represents external elements such as vehicles, pedestrians, or lighting."
	}

	// ===============================
	// 2. SYSTEM DEFINITION
	// ===============================
	def part ADAS_ParkingSystem {
		doc "Automated parking system including sensors, controller, and actuators."

		attribute parkingStatus: Enumeration { idle, scanning, confirming, parking, paused, completed }
		attribute detectedSpaceWidth: Real [m]
		attribute vehicleSpeed: Real [m/s]
		attribute steeringAngle: Real [deg]

		port driverInterface: Driver
		port envSensors: Environment
	}

	// ===============================
	// 3. USE CASE
	// ===============================
	def usecase UrbanParallelParking {
		doc "Driver activates auto park; system detects, confirms, and executes maneuver safely."

		actor Driver
		actor Environment

		step 1: "Driver activates system."
		step 2: "System scans and measures detectedSpaceWidth."
		step 3: "System requests confirmation via driverInterface.confirmationSignal."
		step 4: "Driver confirms; system adjusts steeringAngle and vehicleSpeed."
		step 5: "If Environment.obstacleDistance < safeThreshold, system pauses."
		step 6: "When clear, resumes until parkingStatus == completed."
	}

	// ===============================
	// 4. REQUIREMENTS
	// ===============================
	def requirement REQ_01_DetectParkingSpace {
		attribute minDetectionRange: Real [m]
		require constraint { minDetectionRange >= 1.5 }
		doc "The system shall detect suitable parallel parking spaces within a minimum range of 1.5 m."
	}

	def requirement REQ_02_ExecuteSafeParking {
		attribute maxSteeringAngle: Real [deg]
		require constraint { maxSteeringAngle <= 35 }
		doc "The system shall not exceed a steering angle of 35° during automatic parking."
	}

	def requirement REQ_03_ManageDynamicObstacles {
		attribute safeThreshold: Real [m]
		require constraint { safeThreshold >= 0.5 }
		doc "The system shall maintain at least 0.5 m clearance from dynamic obstacles."
	}

	satisfy UrbanParallelParking -> REQ_01_DetectParkingSpace
	satisfy UrbanParallelParking -> REQ_02_ExecuteSafeParking
	satisfy UrbanParallelParking -> REQ_03_ManageDynamicObstacles
}
