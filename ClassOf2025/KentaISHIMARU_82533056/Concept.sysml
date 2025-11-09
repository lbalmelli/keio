package SolPlantEnergySystemConceptModel {

    package Structure {

        port def ElectricityFlowInterface {
            out electricity;
        }

        port def ModeControlSignalInterface {
            out modeSignal;
        }

        port def UIControlSignalInterface {
            out uiSignal;
        }

        port def SystemConditionInterface {
            out statusSignal;
        }

        port def PanelPositionInterface {
            out positionInfo;
        }

        port def PanelControlSignalInterface {
            out controlSignal;
        }

        port def LightInputInterface {
            in light;
        }

        port def UserControlInterface {
            in controlSignal;
        }

        port def StatusOutputInterface {
            out status;
        }

        port def ExternalElectricityInterface {
            out electricity;
        }

        part def SolPlantEnergySystem {
            doc /* Top-level system-of-systems for indoor solar-based electric power generation. */

            attribute batterySOC;
            attribute generationStatus;
            attribute panelOptimizationStatus;
            attribute chargingStatus;
            attribute outletMode;
            attribute totalMass;

            part solarPanelSubsystem: SolarPanelSubsystem;
            part batteryStorageSubsystem: BatteryStorageSubsystem;
            part powerConverterSubsystem: PowerConverterSubsystem;
            part controlUnitSubsystem: ControlUnitSubsystem;
            part userInterfaceSubsystem: UserInterfaceSubsystem;
            part electricitySupplyInterfaceSubsystem: ElectricitySupplyInterfaceSubsystem;

            // Interfaces and connections
            interface solarToControl: ElectricityFlowInterface
                connect solarPanelSubsystem.electricityOut to controlUnitSubsystem.electricityFromSolar;

            interface controlToBattery: ElectricityFlowInterface
                connect controlUnitSubsystem.electricityToBattery to batteryStorageSubsystem.electricityIn;

            interface batteryToControl: ElectricityFlowInterface
                connect batteryStorageSubsystem.electricityOut to controlUnitSubsystem.electricityFromBattery;

            interface controlToConverter: ElectricityFlowInterface
                connect controlUnitSubsystem.electricityToConverter to powerConverterSubsystem.electricityIn;

            interface converterToSupply: ElectricityFlowInterface
                connect powerConverterSubsystem.electricityOut to electricitySupplyInterfaceSubsystem.electricityOut;

            interface controlToConverterSignal: ModeControlSignalInterface
                connect controlUnitSubsystem.modeSignalOut to powerConverterSubsystem.modeSignalIn;

            interface uiToControl: UIControlSignalInterface
                connect userInterfaceSubsystem.uiSignalOut to controlUnitSubsystem.uiSignalIn;

            interface controlToUI: SystemConditionInterface
                connect controlUnitSubsystem.statusSignalOut to userInterfaceSubsystem.statusSignalIn;

            interface solarToControlPosition: PanelPositionInterface
                connect solarPanelSubsystem.panelPositionOut to controlUnitSubsystem.panelPositionIn;

            interface controlToSolarPosition: PanelControlSignalInterface
                connect controlUnitSubsystem.panelControlSignalOut to solarPanelSubsystem.panelControlSignalIn;

            port light: ~LightInputInterface;
            port controlSignal: ~UserControlInterface;
            port status: StatusOutputInterface;
            port electricity: ExternalElectricityInterface;
        }

        part def SolarPanelSubsystem {
            doc /* Subsystem responsible for converting indoor light into electrical energy. */
            attribute mass;
            attribute power;
            attribute generationCapacity;
            attribute angle;

            port electricityOut: ElectricityFlowInterface;
            port panelPositionOut: PanelPositionInterface;
            port panelControlSignalIn: ~PanelControlSignalInterface;
        }

        part def BatteryStorageSubsystem {
            doc /* Subsystem that stores generated electrical energy. */
            attribute mass;
            attribute soc;
            attribute temperature;

            port electricityIn: ~ElectricityFlowInterface;
            port electricityOut: ElectricityFlowInterface;
        }

        part def PowerConverterSubsystem {
            doc /* Subsystem that converts DC energy to a usable output format. */
            attribute mass;
            attribute temperature;
            attribute outletMode;

            port electricityIn: ~ElectricityFlowInterface;
            port electricityOut: ElectricityFlowInterface;
            port modeSignalIn: ~ModeControlSignalInterface;
        }

        part def ControlUnitSubsystem {
            doc /* Subsystem responsible for monitoring and controlling internal system behavior. */
            attribute mass;
            attribute temperature;
            attribute systemAvailability;
            attribute batterySOC;
            attribute generationStatus;
            attribute panelOptimizationStatus;
            attribute chargingStatus;
            attribute outletMode;

            port electricityFromSolar: ~ElectricityFlowInterface;
            port electricityFromBattery: ~ElectricityFlowInterface;
            port electricityToBattery: ElectricityFlowInterface;
            port electricityToConverter: ElectricityFlowInterface;
            port modeSignalOut: ModeControlSignalInterface;
            port uiSignalIn: ~UIControlSignalInterface;
            port statusSignalOut: SystemConditionInterface;
            port panelPositionIn: ~PanelPositionInterface;
            port panelControlSignalOut: PanelControlSignalInterface;
        }

        part def UserInterfaceSubsystem {
            doc /* Subsystem that allows user interaction with the system for control and monitoring. */
            attribute monitorStatus;
            attribute temperature;

            port uiSignalOut: UIControlSignalInterface;
            port statusSignalIn: ~SystemConditionInterface;
        }

        part def ElectricitySupplyInterfaceSubsystem {
            doc /* Subsystem responsible for delivering electrical power to external devices or systems. */
            port electricityOut: ~ElectricityFlowInterface;
        }
    }

    package ExternalSystemDefinitions {

        port def LightInputInterface {
            out light;
        }

        port def UserControlInterface {
            out controlSignal;
        }

        port def StatusOutputInterface {
            out status;
        }

        part def LightingSystem {
            attribute lightAmount;
            port lightOut: LightInputInterface;
        }

        part def User {
            port controlOut: UserControlInterface;
            port statusIn: ~StatusOutputInterface;
        }

        port def ExternalElectricityInterface {
            out electricity;
        }

        part def ElectricDevices {
            attribute chargingStatus;
            port electricityIn: ~ExternalElectricityInterface;
        }
    }

    package LifeCycleStages {

        state def SolPlantSystemLifeCycleStages;

        state SolPlantSystemLifeCycleStages parallel {

            state ConceptDesign {
                doc /* Making Concept of the system */
            }

            state Development {
                doc /* Developing the system and preparing production, delivery and support of the product. */
            }

            state Production {
                doc /* Producing the system. */
            }

            state Delivery {
                doc /* Delivering the product in knockdown style. */
            }

            state AssembleInUser {
                doc /* Assembling parts of the product at user site. */
            }

            state Use {
                doc /* Use of the product by user. */
            }

            state Support parallel {
                doc /* Support for the user in parallel with Use stage. */
            }

            state Disposal {
                doc /* Disposal stage of the product. */
            }
        }
    }

    package UseStage {

        part DiagramUseStage {
            part solSystem: Structure::SolPlantEnergySystem;
            part lighting: ExternalSystemDefinitions::LightingSystem;
            part user: ExternalSystemDefinitions::User;
            part devices: ExternalSystemDefinitions::ElectricDevices;

            connect lighting.lightOut to solSystem.light;
            connect user.controlOut to solSystem.controlSignal;
            connect solSystem.status to user.statusIn;
            connect solSystem.electricity to devices.electricityIn;
        }
    }

}
