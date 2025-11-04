package GRS_POC {

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

	public import SI::*;
	public import ISQ::*;
    public import ScalarValues::*;

	port def PowerPort {
		public in attribute powerIn :> ISQ::power;
		public out attribute powerOut :> ISQ::power;
	}

	port def DataPort {
		in attribute dataIn : Boolean;
		out attribute dataOut : Boolean;
	}


	part def SolarPanel {
		doc /* LVYUAN 410W Solar Panel (2-pack) */
		attribute outputPower :> ISQ::power;
		port powerPort : PowerPort;
	}

	part def Battery {
		doc /* Anker Solix C1000 Portable Power Station */
		attribute capacity :> ISQ::energy;
		attribute stateOfCharge : Real;
		port chargePort : ~PowerPort;      
		port dischargePort : PowerPort;    
	}

	part def DisplayUnit {
		doc /* Samsung QMC Series 4K UHD Display */
		attribute powerDemand :> ISQ::power;
		port powerPort : PowerPort;        
		port dataPort : DataPort;
	}

	part def CommunicationModule {
		doc /* ESP32-C3 WiFi + Bluetooth Module */
		attribute commStatus : Boolean;
		port dataPort : ~DataPort;
	}

	
	part def GreenResilienceStation {
		doc /* System-level context: integrates solar, storage, display, and comm subsystems. */


		part solar : SolarPanel;
		part battery : Battery;
		part display : DisplayUnit;
		part comm : CommunicationModule;


		flow SolarToBattery
			from solar.powerPort.powerOut
			to battery.chargePort.powerOut;

		flow BatteryToDisplay
			from battery.dischargePort.powerOut
			to display.powerPort.powerIn;

		flow CommToDisplay
			from comm.dataPort.dataIn
			to display.dataPort.dataIn;

		flow DisplayToComm
			from display.dataPort.dataOut
			to comm.dataPort.dataOut;
    	}
    }


	/* -------------------------
	 * BEHAVIOR (STATE-BASED)
	 * ------------------------- */
	package Behavior {
		public import Structure::*;

		attribute def 'Grid Failure';
		attribute def 'Grid Restored';

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


