package GRS{
	public import SI::*;
	public import ISQ::*;
	public import ScalarValues::*;
	
	/* -------------------------
	 * REQUIREMENT DEFINITIONS
	 * ------------------------- */
	package Requirements {
		
		requirement def <'1'> EnergyAutonomyRequirement {
			doc /* GRS shall achieve full energy autonomy under normal solar conditions. */
			
			attribute energyGenerated :> ISQ::energy;
			attribute energyConsumed :> ISQ::energy;
			
			require constraint { energyGenerated >= energyConsumed }
		}
		
		requirement def <'2'> EmergencyPowerAvailability {
			doc /* GRS shall provide at least 6 hours of emergency power after grid failure. */
			
			attribute backupDuration :> ISQ::time;
			require constraint { backupDuration >= 6 [SI::h] }
		}
		
		requirement def <'3'> CommunicationContinuity {
			doc /* GRS shall maintain Wi-Fi and alert broadcasting in disaster mode. */
			
			attribute commLink : Boolean;
			require constraint { commLink == true }
		}
	}
	
	/* -------------------------
	 * STRUCTURE DEFINITIONS
	 * ------------------------- */
	package Structure {
		
		part def SolarPanel {
			attribute outputPower :> ISQ::power;
		}
		
		part def Battery {
			attribute capacity :> ISQ::energy;
			attribute stateOfCharge : Real;
		}
		
		part def DisplayUnit {
			attribute powerDemand :> ISQ::power;
		}
		
		part def CommunicationModule {
			attribute commStatus : Boolean;
		}
		
		port def PowerPort {
			inout powerFlow :> ISQ::power;
		}
		
		part def PowerController {
			port solarIn: PowerPort;
			port batteryIO: PowerPort;
			port displayOut: PowerPort;
		}
		
		part def GreenResilienceStation {
			part solar: SolarPanel;
			part battery: Battery;
			part display: DisplayUnit;
			part comm: CommunicationModule;
			part controller: PowerController;
			
			interface solarConnection connect solar.outputPower to controller.solarIn.powerFlow;
			interface controllerToDisplay connect controller.displayOut.powerFlow to display.powerDemand;
			interface controllerToBattery connect controller.batteryIO.powerFlow to battery.capacity;
		}
	}
	
	/* -------------------------
	 * BEHAVIOR (STATE-BASED)
	 * ------------------------- */
	package Behavior {
		public import Structure::*;

		/* Event triggers */
        attribute def 'Grid Failure';
	    attribute def 'Grid Restored';

		/* Action definitions */
        action def provideBackupPower;
	    action def enableCommunication;
	    action def generateAndStorePower;
	    action def activateAdvertising;
		
		state def 'GRS Operational States' {
			
			state NormalOperation {
				action activateAdvert : activateAdvertising;
				action generateAndStore : generateAndStorePower;

				entry action activateAdvertising;
				do action generateAndStorePower;

				transition 'detectGridFailure'
					first NormalOperation
					accept 'Grid Failure'
					then EmergencyMode;
			}
			
			state EmergencyMode {
                action provideBackupPower : provideBackupPower;
			    action enableCommunication : enableCommunication;

				do action emergencyOperations {
		            perform provideBackupPower;
		            perform enableCommunication;
	            }

				transition 'gridRestored'
					first EmergencyMode
					accept 'Grid Restored'
					then NormalOperation;
			}
		}
	}
	
	/* -------------------------
	 * VERIFICATION CASES
	 * ------------------------- */
	package Verification {  
		public import Requirements::*;
		public import Structure::*;
		
		part testGRS : GreenResilienceStation;

        /* ---------- Energy Feasibility ---------- */
		verification def EnergyFeasibilityTest {
			doc /* Verify energy autonomy feasibility */

			action computeBalance {
				out feasible : Boolean;
				assert constraint {
				    (testGRS.solar.outputPower * 6 [SI::h]) >=
				    (testGRS.display.powerDemand * 6 [SI::h])
			    }
		    }
        }

        /* ---------- Backup Duration ---------- */
		verification def BackupDurationTest {
			doc /* Verify emergency battery duration feasibility */


			action checkBackup {
				out feasible : Boolean;
				assert constraint { 
			        (testGRS.battery.capacity / testGRS.display.powerDemand) >= 6 [SI::h] 
		        }
			}
		}
    }
}