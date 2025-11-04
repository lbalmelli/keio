package 'ADAS Urban Parallel Parking Model' {

	// ===============================
	// 1. ACTORS
	// ===============================
	actor def Driver {
		doc /* The human operator who requests and supervises the automated parking. */
	}
	
	actor def Environment {
		doc /* Represents external elements: nearby vehicles, pedestrians, road edges, and weather conditions. */
	}

	// ===============================
	// 2. USE CASE
	// ===============================
	use case def 'Urban Parallel Parking' {
		doc
		/*
		 * The driver activates the automatic parking function in a dense urban street.
		 * The system scans for a suitable parking space, confirms driver approval,
		 * and autonomously performs the parking maneuver while ensuring safety.
		 */

		actor Driver;
		actor Environment;
		
		step 1: Driver activates 'Auto Park' mode;
		step 2: System scans for parking space;
		step 3: System identifies a candidate spot and requests confirmation;
		step 4: Driver approves parking;
		step 5: System performs steering, acceleration, and braking autonomously;
		step 6: System detects pedestrian and pauses until safe;
		step 7: System completes parking and confirms success to Driver;
	}

	// ===============================
	// 3. REQUIREMENTS
	// ===============================
	requirement def 'REQ-01 Detect Parking Space' {
		doc /* The system shall detect suitable parallel parking spaces using onboard sensors. */
	}

	requirement def 'REQ-02 Confirm Driver Approval' {
		doc /* The system shall request driver confirmation before initiating the automatic parking maneuver. */
	}

	requirement def 'REQ-03 Execute Parking Maneuver Safely' {
		doc /* The system shall autonomously perform steering, acceleration, and braking while avoiding collisions. */
	}

	requirement def 'REQ-04 Provide Feedback to Driver' {
		doc /* The system shall provide clear visual and auditory feedback during parking progress and completion. */
	}

	requirement def 'REQ-05 Manage Dynamic Obstacles' {
		doc /* The system shall pause and resume operation safely if dynamic obstacles (e.g., pedestrians) are detected. */
	}

	// ===============================
	// 4. TRACEABILITY RELATIONSHIPS
	// ===============================
	satisfy 'Urban Parallel Parking' -> 'REQ-01 Detect Parking Space';
	satisfy 'Urban Parallel Parking' -> 'REQ-02 Confirm Driver Approval';
	satisfy 'Urban Parallel Parking' -> 'REQ-03 Execute Parking Maneuver Safely';
	satisfy 'Urban Parallel Parking' -> 'REQ-04 Provide Feedback to Driver';
	satisfy 'Urban Parallel Parking' -> 'REQ-05 Manage Dynamic Obstacles';

	// ===============================
	// 5. SYSTEM CONTEXT
	// ===============================
	part def 'ADAS Parking System' {
		doc /* System boundary representing sensors, control logic, and actuator interfaces performing the automatic parking. */
		
		port driverInterface: Driver;
		port envSensors: Environment;

		exhibit use case 'Urban Parallel Parking';
	}
}

Please note that this model does not refer to company internal libraries or other models that you have defined in previous sessions. However, you might use Acronio-Technology to ensure model compositionality.

