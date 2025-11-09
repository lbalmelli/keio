package PoCofSolEnergyPlant {

    package SystemStructure {

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

        part def SolarPanelSubsystem {
            doc /* Selected Product: Renogy Flexible Solar Panel 100W 12V Black. Lightweight, high-efficiency monocrystalline panel. Size approx. 1075 x 510 x 2 mm, weight about 1.62 kg.*/
            attribute mass;
            attribute power;
            attribute generationCapacity;
            attribute angle;

            port electricityOut: ElectricityFlowInterface;
            port panelPositionOut: PanelPositionInterface;
            port panelControlSignalIn: ~PanelControlSignalInterface;
        }

        part def BatteryStorageSubsystem {
            doc /*Selected Product: Anker Solix BP1000. Lithium iron phosphate battery with high safety and long cycle life. Capacity ~1056 Wh.*/
            attribute mass;
            attribute soc;
            attribute temperature;

            port electricityIn: ~ElectricityFlowInterface;
            port electricityOut: ElectricityFlowInterface;
        }

        part def PowerConverterSubsystem {
            doc /* Included in Anker Solix BP1000. Converts DC to AC and provides multiple output formats.*/
            attribute mass;
            attribute temperature;
            attribute outletMode;

            port electricityIn: ~ElectricityFlowInterface;
            port electricityOut: ElectricityFlowInterface;
            port modeSignalIn: ~ModeControlSignalInterface;
        }

        part def ControlUnitSubsystem {
            doc /* Selected Platform: Anker Solix BP1000 embedded controller. Manages battery and power system behaviors.*/
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
            doc /* Selected Interface: Mobile App with Bluetooth or Wi-Fi connection (e.g., Anker App). Allows monitoring and control.*/
            attribute monitorStatus;
            attribute temperature;

            port uiSignalOut: UIControlSignalInterface;
            port statusSignalIn: ~SystemConditionInterface;
        }

        part def ElectricitySupplyInterfaceSubsystem {
            doc /* Provided by: Anker Solix BP1000. Supports AC outlets, USB ports, and DC outputs.*/
            port electricityOut: ~ElectricityFlowInterface;
        }
    }
}