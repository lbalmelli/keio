package PetCaringSystem {
	
	// --- IMPORTS & BASIC DEFINITIONS ---
	import ScalarValues::*;
	
	// --- DOMAIN DEFINITIONS ---
	item def Food {
		// Represents pet food (type, portion, etc.)
		attribute foodType: String;
		attribute portionSize: Real; // in grams
	}

	item def Water {
		// Represents clean water input for the bowl
		attribute volume: Real; // in milliliters
	}

	item def Power {
		// Represents electricity to operate feeder
		attribute voltage: Real;
	}

	// --- ACTOR DEFINITIONS ---
	part def Owner {
		// Human actor using the system
		port command: out CommandPort;
		port notification: in StatusPort;
	}

	part def Pet {
		// The animal consuming food
		port consume: in FoodPort;
	}

	// --- SYSTEM CONTEXT ---
	part def FeedingSystem {
		// Core subsystem ensuring timely feeding
		port foodIn: in FoodPort;
		port powerIn: in PowerPort;
		port dispenseOut: out FoodPort;
		port statusOut: out StatusPort;
		port commandIn: in CommandPort;
	}

	// --- PORT DEFINITIONS ---
	port def FoodPort {
		// Interface for food flow
		flow food: Food;
	}

	port def PowerPort {
		// Interface for power supply
		flow energy: Power;
	}

	port def CommandPort {
		// Interface for commands from owner app
		in attribute feedNow: Boolean;
		in attribute scheduleTime: String;
	}

	port def StatusPort {
		// Interface for notifications back to owner
		out attribute feederStatus: String;
		out attribute remainingFood: Real;
	}

	// --- INTERNAL STRUCTURE ---
	part def SmartFeeder {
		part hopper {
			// Storage for pet food
			attribute capacity: Real;
			attribute currentLevel: Real;
		}
		
		part dispenser {
			// Mechanism to release food
			attribute portionSize: Real;
			attribute lastDispenseTime: String;
		}

		part controller {
			// Controls feeding logic & schedule
			attribute schedule: String;
			attribute manualOverride: Boolean;
		}

		port foodIn: in FoodPort;
		port dispenseOut: out FoodPort;
		port powerIn: in PowerPort;
		port commandIn: in CommandPort;
		port statusOut: out StatusPort;
	}

	// --- BEHAVIOR DEFINITION ---
	action def DispenseFood {
		input portion: Real;
		output delivered: Boolean;

		doc = "Checks schedule or manual command, dispenses specified food portion, updates status."
	}

	// --- CONTEXT DIAGRAM ---
	part context {
		part owner: Owner;
		part pet: Pet;
		part feeder: FeedingSystem;

		connect owner.command to feeder.commandIn;
		connect feeder.statusOut to owner.notification;
		connect feeder.dispenseOut to pet.consume;
	}

	// --- REQUIREMENTS ---
	requirement def ReliableFeeding {
		text = "The system shall dispense the correct portion of food at the scheduled time with ±5% accuracy."
	}

	requirement def RemoteControl {
		text = "The system shall allow the owner to remotely trigger feeding through a connected device."
	}

	requirement def PowerContinuity {
		text = "The system shall include a battery backup to continue operation during power outages."
	}
}
