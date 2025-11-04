package FeedSmart {

	import ScalarValues::*;

	// === DOMAIN ITEMS ===
	item def Food {
		attribute foodType: String;
		attribute portionSize: Real; // grams
		doc /* Represents the type and quantity of pet food handled by the system. */
	}

	item def Power {
		attribute voltage: Real;
		attribute current: Real;
		doc /* Electrical power supply for all components. */
	}

	item def ConsumptionData {
		attribute dailyIntake: Real;
		attribute timestamp: String;
		doc /* Logs each feeding event with timestamp and portion size. */
	}

	// === ACTORS ===
	part def Owner {
		port command: out CommandPort;
		port notification: in StatusPort;
		port dataView: in DataPort;
		doc /* Pet owner controlling the system and receiving status/data updates. */
	}

	part def Pet {
		port consume: in FoodPort;
		doc /* The pet consuming dispensed food. */
	}

	// === PORT DEFINITIONS ===
	port def FoodPort {
		flow food: Food;
		doc /* Transfers food portions between components. */
	}

	port def PowerPort {
		flow energy: Power;
		doc /* Transmits power supply to subsystems. */
	}

	port def CommandPort {
		in attribute feedNow: Boolean;
		in attribute scheduleTime: String;
		doc /* Command interface for triggering or scheduling feed events. */
	}

	port def StatusPort {
		out attribute feederStatus: String;
		out attribute remainingFood: Real;
		doc /* Reports feeder status and remaining food data. */
	}

	port def DataPort {
		out attribute dailyIntake: Real;
		doc /* Sends feeding history or analytics data. */
	}

	port def WirelessPort {
		attribute connectionType: String; // "WiFi" or "Bluetooth"
		attribute protocol: String; // "HTTP", "MQTT", or "BLE"
		attribute signalStrength: Real;
		doc /* Represents the wireless channel (Wi-Fi or Bluetooth)
		used for communication between feeder, cloud, and mobile app. */
	}

	// === MAIN SYSTEM ===
	part def ProofOfConceptSystem {

		port foodIn: in FoodPort;
		port powerIn: in PowerPort;
		port dispenseOut: out FoodPort;
		port statusOut: out StatusPort;
		port commandIn: in CommandPort;
		port dataOut: out DataPort;

		part feeder: SmartFeeder;
		part app: MobileApp;
		part cloud: CloudDatabase;

		// --- Core Wireless and Data Connections ---
		connect app.wirelessIn to feeder.comms.wirelessOut;
		connect app.commandOut to feeder.comms.commandIn;
		connect feeder.controller.statusOut to app.statusIn;
		connect feeder.dataTracker.dataOut to app.dataIn;

		// --- Cloud Synchronization Paths ---
		connect feeder.dataTracker.dataOut to cloud.dataIn;
		connect cloud.dataOut to app.dataIn;
		connect cloud.dataOut to feeder.comms.dataOut;

		// --- Resource Flow (optional for completeness) ---
		connect powerIn to feeder.power.powerIn;
		connect foodIn to feeder.hopper.output;
		connect feeder.dispenseOut to dispenseOut;

		doc /* Fully connected FeedSmart Proof-of-Concept configuration.
		Includes wireless link (Wi-Fi/Bluetooth), data feedback, command flow,
		and cloud synchronization between the feeder, app, and cloud database. */
	}

	// === SMART FEEDER STRUCTURE ===
	part def SmartFeeder {
		part hopper: FoodHopper;
		part dispenser: DispenserMechanism;
		part bowl: FeedingBowl;
		part controller: ControlUnit;
		part motor: MotorUnit;
		part sensors: SensorModule;
		part power: PowerUnit;
		part comms: CommunicationModule;
		part dataTracker: DataTrackingModule;

		port foodIn: in FoodPort;
		port dispenseOut: out FoodPort;
		port powerIn: in PowerPort;
		port commandIn: in CommandPort;
		port statusOut: out StatusPort;
		port dataOut: out DataPort;

		doc /* Physical feeder hardware integrating control logic, sensors, 
		and wireless connectivity for automated feeding. */
	}

	// === SUBPART DEFINITIONS ===
	part def FoodHopper {
		attribute capacity: Real;
		attribute currentLevel: Real;
		port output: out FoodPort;
		doc /* Stores dry food and feeds the dispenser by gravity. */
	}

	part def DispenserMechanism {
		attribute portionSize: Real;
		attribute lastDispenseTime: String;
		port input: in FoodPort;
		port output: out FoodPort;
		port motorSignal: in Boolean;
		doc /* Servo-controlled gate releasing measured food portions into bowl. */
	}

	part def FeedingBowl {
		attribute currentAmount: Real;
		attribute lastFedTime: String;
		port input: in FoodPort;
		port petConsume: out FoodPort;
		doc /* Detachable, washable bowl where food is dispensed for pet use. */
	}

	part def ControlUnit {
		attribute schedule: String;
		attribute manualOverride: Boolean;
		port commandIn: in CommandPort;
		port motorOut: out Boolean;
		port statusOut: out StatusPort;
		port sensorIn: in Boolean;
		port dataOut: out DataPort;
		doc /* ESP32 firmware handling commands, motor control, and feedback reporting. */
	}

	part def MotorUnit {
		attribute powerUsage: Real;
		port controlSignal: in Boolean;
		port powerIn: in PowerPort;
		doc /* Servo motor responsible for dispenser motion. */
	}

	part def SensorModule {
		attribute foodLevelDetected: Boolean;
		attribute bowlFoodAmount: Real;
		port output: out Boolean;
		port dataOut: out DataPort;
		doc /* IR sensor detecting food presence and bowl fill level. */
	}

	part def PowerUnit {
		attribute supplyVoltage: Real;
		attribute currentLoad: Real;
		port powerIn: in PowerPort;
		port supply: out PowerPort;
		doc /* 5V DC power input via USB; powers ESP32 and servo. */
	}

	part def CommunicationModule {
		attribute wifiConnected: Boolean;
		port wirelessOut: out WirelessPort;
		port statusOut: out StatusPort;
		port commandIn: in CommandPort;
		port dataOut: out DataPort;
		doc /* ESP32 Wi-Fi/Bluetooth interface for wireless data exchange.
		Supports local AP mode or STA mode for cloud access. */
	}

	part def DataTrackingModule {
		attribute totalDailyIntake: Real;
		port dataOut: out DataPort;
		doc /* Logs each feed event locally and pushes data to the cloud. */
	}

	part def CloudDatabase {
		port dataIn: in DataPort;
		port dataOut: out DataPort;
		doc /* Cloud service (e.g., Firebase or Supabase) storing feeding logs,
		schedules, and feeder status for remote access. */
	}

	part def MobileApp {
		attribute appName: String;
		port wirelessIn: in WirelessPort;
		port commandOut: out CommandPort;
		port statusIn: in StatusPort;
		port dataIn: in DataPort;
		doc /* User interface connecting via Wi-Fi/Bluetooth to send commands,
		receive feeder status, and synchronize data with the cloud. */
	}

	// === CONTEXT ===
	part context {
		part owner: Owner;
		part pet: Pet;
		part system: ProofOfConceptSystem;

		// User interactions
		connect owner.command to system.commandIn;
		connect system.statusOut to owner.notification;
		connect system.dataOut to owner.dataView;

		// Feeding process
		connect system.dispenseOut to pet.consume;

		doc /* Complete system-level context linking owner, pet, and FeedSmart PoC.
		User interacts via app; data flows through wireless and cloud connections. */
	}
}
