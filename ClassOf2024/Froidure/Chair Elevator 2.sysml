package 'ChairLiftSystem' {
    doc /* 
        This chair's aim is to help users daily and allow them to stay in the same house 
        even if they cannot climb the stairs.
    */
    
    package 'ChairComponents' {
        // Definition of the main parts of the chair lift
        part def Chair {
            attribute materialType;  // Comfortable material attribute
            doc /* The material of the chair should be soft for the user comfort*/
            attribute isFoldable: ScalarValues::Boolean = true;
            part armrest: Armrest;
            part footrest: Footrest;
            part controlPanel: ControlPanel;
            part chairBase: ChairBase;
            part motor: Motor;
            part energysource: EnergySource;
            part rail: Rail ;
            part sensors: Sensor;
            part controllor: Controllor;

        }
        part def ChairBase {
            doc /*This chair base should be able to help the user to get up by following and helping their mouvment*/
        }
        part def Armrest {
            doc /* Provides support to help the user sit and stand up. */
            part controlPanel: ControlPanel;
        }

        part def Footrest {
            doc /* Increases user comfort during usage. */
        }

        part def ControlPanel {
            doc /* Panel to control chair functions located on the armrest. */
            port controlCommands: ControlCommandsPort;
        }

        // Motor and energy source definitions
        part def Motor {
            doc /* Provides the mechanical force needed to move the chair along the rail. */
            port inputPower: PowerPort;
            port movementControl: MovementControlPort;
        }

        part def EnergySource {
            doc /* Provides energy to the motor. */
            attribute powerCapacity: ScalarValues::Real = 500.0; // example capacity in watts
            port outputPower: PowerPort;
        }

        // Rail system definition
        part def Rail {
            doc /* Guides the chair lift along the stairs. */
            part mountingElement: MountingElement;
        }

        part def MountingElement {
            doc /* Fixes the chair lift system to the wall, providing guidance. */
        }

        part def Sensor {
            doc /* Detect the position of the chair and obstacles on the way*/
        }

        part def Controllor {
            doc /* Use sensors to stop the chair in case of emergencies*/
            port safetyInput: SafetyPort;
            port safetyOutput: SafetyPort;
        }

        // Ports definitions
        port def ControlCommandsPort {
            out moveCommand: MoveCommand;
        }

        port def PowerPort {
            out powerSupply: ScalarValues::Real; // Watts
        }

        port def MovementControlPort {
            in command: MoveCommand;
        }

        port def SafetyPort {
            in isEmergency: ScalarValues::Boolean ; // Input signal indicating an emergency stop
            out stopSignal: ScalarValues::Boolean; // Output signal to stop the motor 
        }

        // Definition of move commands
        item def MoveCommand {
            doc /* Command to initiate the chair's movement */
            attribute direction; // "up" or "down"
        }
    }

    package 'ChairSystemConfiguration' {
        import 'ChairComponents'::*;
        
        part chairLiftSystem {
            part chair: Chair;
            part rail: Rail;
            part motor: Motor;
            part energySource: EnergySource;

            // Energy flow from source to motor
            flow PowerSupplyFlow
                from energySource.outputPower.powerSupply
                to motor.inputPower.powerSupply;

            // Control flow for movement from control panel to motor
            flow MovementControlFlow
                from chair.armrest.controlPanel.controlCommands.moveCommand
                to motor.movementControl.command;
            
            // Connection for chair to the rail system
            interface chairToRail connect chair to rail.mountingElement {
                doc /* Chair is permanently attached to the rail for movement guidance. */
            }
        }
        part def ChairProduct {
            doc /* This is an example of components which could be use*/
            // Definition of the Stannah Control Panel
            part ControlPanelStannah {
                doc /* Stannah control panel with commands to lift up, lower down, and stop the chair */
                port controlSignalOutput ;
                }
            
    
            port def ControlSignalPort {
                attribute controlSignal; // Command signal sent by the control panel
            }

            // Definition of the Linak LA31 Motor
            part MotorLinakLA31 {
                doc /* Linak LA31 motor used for lifting the chair */
                port controlInput: ~ControlSignalPort; // Control port to receive signals from the control panel
                port powerInput: PowerPort; // Power input port to receive energy

            }
    
            port def PowerPort {
                attribute powerCapacity: ScalarValues::Real; // Power capacity in watts
            }

            // Definition of the Mean Well HLG-150H-24A Power Supply
            part PowerSupplyMeanWellHLG150 {
                doc /* Mean Well HLG-150H-24A power supply providing power to the motor */
                port powerOutput: ~PowerPort;

                attribute outputVoltage: ScalarValues::Real = 24.0; // Output voltage in volts
                attribute outputPower: ScalarValues::Real = 150.0; // Maximum power output in watts
            }
            
            //Definition of sensors: Banner Engineering QS18 Series
            part BannerEnginneringQS18Series {
                doc /* Banner Engineering QS18 Series allow a good detection of the position of the chair
                    and also avoid problems in case of emergencies 
                    */
                attribute inputvoltage: ScalarValues::Real = 24;
            }

            //Definition of controllor: Siemens SIRIUS Safety Relays
            part SiemensSIRIUSSafetyRelays {
                doc /* Siemens SIRIUS Safety Relays for emergency stop and safety monitoring */
                port safetyInput: SafetyPort;
                port safetyOutput: SafetyPort;
            }
            port def SafetyPort {
                in isEmergency: ScalarValues::Boolean ; // Input signal indicating an emergency stop
                out stopSignal: ScalarValues::Boolean; // Output signal to stop the motor

            
            }
        }
    }
}