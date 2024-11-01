package 'Package 1' {
	package 'Sea\t-Shell Model' {
		import 'Component Definitions'::Chair::*;
		import 'Component Definitions'::*;
		import *;
		package 'Component Definitions' {
			part def Motors {
				action activateMotor {
					doc /* Activates the motor to adjust chair position based on stabilization signals. */
				}
				action deactivateMotor {
					doc /* Deactivates the motor to conserve power or when stabilization is not needed. */
				}
				doc /* /* 		* **Motors**: DC Servo Motors provide precise and responsive adjustments to the chair's position. They receive real-time commands from  		*             the control unit to counteract detected wave-induced motions, allowing the system to stabilize the chair with minimal delay. 		*             The motors are critical to achieving continuous stabilization. 		*/ */
			}
			part def Cables {
				action attachToCeiling {
					doc /* Attaches the cable to the ceiling support. */
				}
				action detachFromCeiling {
					doc /* Detaches the cable from the ceiling support for maintenance or replacement. */
				}
				doc /* /* 		* **Cables**: The suspension system (replacing traditional cables) provides structural support and shock absorption, suspending the chair securely  		*             from above. It allows limited movement in response to forces exerted by the motors, giving the chair the flexibility to maintain  		*             stability while remaining securely attached. 		*/ */
			}
			part def GyroscopeMicrocontroller {
				action initializeGyroscope {
					doc /* Initializes the gyroscope to start detecting movement. */
				}
				action sendStabilizationSignal {
					doc /* Sends stabilization signals to the motors based on detected motion. */
				}
				doc /* /* 		* **GyroscopeMicrocontroller**: This microcontroller processes data from sensors such as the gyroscope and IMU, detecting chair movements in  		*                               real-time. It calculates stabilization commands and sends them to the motors, ensuring adjustments happen promptly 		*                               to counteract wave-induced motion. 		*/ */
			}
			part def Chair {
				part armrests {
					action supportArm {
						doc /* Provides support to the user?s arm. */
					}
					action adjustArmPosition {
						doc /* Adjusts the armrest position for user comfort. */
					}
					doc /* /* 		* **Armrest**: Provides ergonomic support for the user's arms and connects structurally to the seat base. The armrest moves with the chair,  		*              ensuring user comfort and stability by offering reliable support during motion adjustments. 		*/ */
				}
				part backrest {
					action supportBack {
						doc /* Provides support to the user?s back for stability and comfort. */
					}
					action reclineBack {
						doc /* Adjusts the backrest angle for reclining. */
					}
					doc /* /* 		* **Backrest**: Supports the user???s back, helping to maintain correct posture. The backrest is connected to the seat base, ensuring a secure and  		*               stable seating structure that adjusts seamlessly with the chair's movements to keep the user balanced. 		*/ */
				}
				part seatBase {
					action provideSeating {
						doc /* Provides the primary seating surface for the user. */
					}
					action adjustSeatHeight {
						doc /* Adjusts the height of the seat for user comfort. */
					}
					doc /* /* 		* **SeatBase**: The foundational seating surface for the user, integrating with the armrests and backrest to form a stable seating area.  		*               The seat base directly receives adjustments from the motors, ensuring that the user???s primary seating position remains balanced  		*               despite external movements. 		*/ */
				}
				motors : Motors;
				suspension : Cables;
				gyroscopeMicrocontroller : GyroscopeMicrocontroller;
				action stabilize {
					doc /* Coordinates stabilization by controlling the motors based on gyroscope input. */
				}
				part ceilingSupport {
					doc /* Ceiling support structure to which the suspension cables are attached. */
				}
				action stabilizeInstance : stabilize;
				doc /* /* 		* **Chair**: The main structure of the Sea't-Shell, designed to support and position the user comfortably. The chair integrates components like  		*            the armrest, backrest, and seat base, each contributing to user stability and comfort. It is connected to the suspension system and  		*            relies on motorized adjustments to counteract wave motions. 		*/ */
			}
			part def User {
				action 'Sit on the chair';
				doc /* /* 		* **User**: Represents the individual using the Sea't-Shell chair. The system is designed to detect and respond to the user???s position and  		*            movements, ensuring optimal stability and comfort throughout their experience in the chair, regardless of sea conditions. 		*/ */
			}
			part Sensors {
				doc /* /*
						* **Sensors**: This component includes essential sensing devices such as the MEMS Gyroscope and Inertial Measurement Unit (IMU), 
						*              which are responsible for continuously monitoring the chair???s orientation and movement. The sensors detect roll, 
						*              pitch, and yaw induced by waves, allowing the system to gather real-time data on the chair???s position and motion.
						*              This information is then processed by the microcontroller, which calculates the necessary counter-adjustments 
						*              to maintain stability. The sensors are crucial to enabling the Sea't-Shell's responsive and adaptive stabilization 
						*              capabilities, ensuring user comfort and minimizing the effects of sea-induced motion.
						*/ */
			}
		}
		package Requirements {
			requirement def assumption1 {
				doc /* Assumption 1: The Seat-Shell prevents sea sickness for any user, 
							       regardless of body size, sea sickness tolerance. */
			}
			requirement def assumption2 {
				doc /* Assumption 2: The Seat-Shell maintains stabilization using its gyroscopic mechanism, 
							       even under varying power levels, ensuring user comfort at all times. */
			}
			requirement def assumption3 {
				doc /* Assumption 3: The Seat-Shell prevents sea sickness for any user, 
							       regardless of sea conditions. */
			}
		}
		part def InterconnectionSystem {
			part motor : Motors {
				inout port port;
			}
			part cable : Cables {
				inout port port;
			}
			part gyroscopeMicrocontroller : GyroscopeMicrocontroller {
				inout port port;
				inout port port;
			}
			part 'Seat Base' : seatBase {
				part armrests : 'Component Definitions'::Chair::armrests {
					port armConnect : ConnectionPort;
				}
				part backrest : 'Component Definitions'::Chair::backrest {
					port backConnect : ConnectionPort;
				}
				part seatBase : seatBase {
					port baseConnect : ConnectionPort;
				}
				inout port port;
				inout port port;
				inout port port;
			}
			port def StabilizationOutput {
				signal;
			}
			port def StabilizationInput {
				signal;
			}
			port def AttachmentPort;
			port def ConnectionPort;
			part Arnaud : User {
				inout port port;
				inout port port;
			}
			interface connect;
			interface connect;
			part Sensors : 'Component Definitions'::Sensors {
				inout port port;
				inout port port;
			}
			part 'ceiling support' : ceilingSupport {
				inout port port;
				inout port port;
			}
			part armrests : 'Component Definitions'::Chair::armrests {
				inout port port;
				inout port port;
			}
			part backrest : 'Component Definitions'::Chair::backrest {
				inout port port;
				inout port port;
			}
			interface connect;
			interface connect;
			interface connect;
			interface connect;
			interface connect;
			action flow;
			action flow;
			action flow;
			action flow;
			interface connect;
			interface connect;
		}
		package POC {
			part def DCServoMotor {
				doc /* * DC Servo Motor: Provides precise control of chair adjustments.
							* Receives stabilization signals to adjust position in response to wave movements.
							* High responsiveness and torque enable counteraction of sea-induced motions. */
			}
			part def STM32Microcontroller {
				doc /* * STM32 Microcontroller: Processes input from sensors like IMUs and MEMS Gyroscopes.
							* Acts as the central processing unit, handling real-time adjustments and motor control.
							* Integrates PID algorithms for responsive stabilization. */
			}
			part def MEMSGyroscope {
				doc /* * MEMS Gyroscope: Detects roll and pitch motions caused by waves.
							* Measures wave intensity and direction to calculate necessary counter-torque.
							* Outputs stabilization signals to the STM32 microcontroller. */
			}
			part def IMU {
				doc /* * Inertial Measurement Unit (IMU): Provides orientation data such as pitch, roll, and yaw.
							* Assists in precise stabilization by providing comprehensive motion data.
							* Outputs data to the STM32 microcontroller for real-time adjustment calculations. */
			}
			part def SuspensionSystem {
				doc /* * Suspension System: Physically supports and stabilizes the chair within a marine environment.
							* Replaces traditional cables, providing enhanced shock absorption and stability.
							* Allows controlled motion for the motorized chair. */
			}
			part def Chair {
				part armrests {
					doc /* /* Armrests: Provide structural and ergonomic support to the user's arms. 				* Connects to the seat base to maintain stability and comfort. 				*/ */
				}
				part backrest {
					doc /* * Backrest: Supports the users back, enhancing comfort and posture.
									* Connects to the seat base to form a stable seating structure. */
				}
				part seatBase {
					doc /* * Seat Base: Main seating area of the chair.
									* Serves as the foundational part to which other components connect. */
				}
			}
			part def StabilizationModule {
				part gyroscope : MEMSGyroscope;
				part motor : DCServoMotor;
				doc /* * Stabilization Module: Integrates MEMS Gyroscope and DC Servo Motor.
							* Gyroscope detects wave-induced movements and sends data to the motor.
							* The motor adjusts chair positioning to counteract these movements. */
			}
			part def ControlModule {
				part controlUnit : STM32Microcontroller;
				part imu : IMU;
				doc /* * Control Module: Integrates STM32 Microcontroller and IMU.
							* Receives input from sensors to process and output control signals.
							* Coordinates real-time adjustments for stabilization. */
			}
			part def InterconnectionSystem {
				part stabilizationModule : StabilizationModule;
				part controlModule : ControlModule;
				part suspension : SuspensionSystem;
				part chair : Chair;
			}
			doc 'compaison des parts POC' /* /* Comparison Table: Original Parts vs. POC Alternatives 		* 		* | Original Part (Component Definitions) | POC Alternative        | Description of Change                                                                                           | 		* |---------------------------------------|-------------------------|------------------------------------------------------------------------------------------------------------------| 		* | Motor                                 | DCServoMotor            | Replaced generic motor with a DC servo motor for precise, responsive control needed for stabilization.          | 		* | GyroscopeMicrocontroller              | STM32Microcontroller    | Substituted with STM32 microcontroller to handle complex processing tasks and support real-time control algorithms. | 		* | MEMSGyroscope                         | MEMSGyroscope           | Retained as is, since the MEMS gyroscope is already a suitable off-the-shelf component for detecting motion.      | 		* | IMU                                   | IMU                     | Kept as is, as the IMU provides essential orientation data directly applicable to the stabilization model.       | 		* | Cable                                 | SuspensionSystem        | Replaced cable with a full suspension system, providing enhanced support, shock absorption, and motion control.   | 		* | Chair                                 | Chair                   | Maintained as is but with added decomposition of Chair parts like Armrest, Backrest, and SeatBase for consistency. | 		* 		* Summary of Key Changes: 		* 1. Increased Specificity: Components like Motor and GyroscopeMicrocontroller were replaced with application-specific  		*    alternatives (DCServoMotor and STM32Microcontroller) that better meet the motorized chair???s stabilization needs. 		* 2. Suspension System Upgrade: The simple Cable was upgraded to a full SuspensionSystem, capable of providing the necessary 		*    structural support and shock absorption for a marine environment. 		* 3. Structural Consistency: Both Chair parts retain decomposition of sub-parts (Armrest, Backrest, and SeatBase) to maintain  		*    structural consistency and detailed support features. 		*/ */
			doc 'liste des prompts' /* /* 	* List of Prompts for Proof-of-Concept Development: 	* 	* 1. "Can you propose a series existing off-the-shelf products that i could use to implement the motorized chair?" 	* 2. "Can you create a proof of concept model based on the previous model, in a package call 'POC' that now replace motors by the DC Servo Motors  	*      you presented me, and the gyroscope microcontroller by STM32 Microcontrollers, and create a new part for the following sensors MEMS Gyroscopes  	*      and Inertial Measurement Units (IMUs), and finally replace the cables by the suspension system. Can you write commentary that will explain the role of each part." 	* 3. "Keep the same parts and the same organization, just improve the code to match the following demand: can you create a part that will gather  	*      MEMSGyroscope and DCServoMotor." 	* 4. "Can you do the same thing for STM32Microcontroller and IMU." 	* 5. "Can you remove the ports and attributes." 	* 6. "Can you create a table that will compare for each part I have in 'component definition' the alternative in the POC. Can you also write the description change." 	* 7. "Can you create a version of the table as a comment to be added on the package containing the entire POC Model." 	* 8. "Can you output just the code for the table." 	* 9. "Can you remove the 'doc'." 	* 	* This list documents the sequence of prompts that guided the development of the proof-of-concept model. 	*/ */
		}
		doc 'overview of the Sea\'t shell system' /* /* 	* Overview of the Sea't-Shell System 	* 	* The Sea't-Shell is a motorized stabilization chair designed for marine environments, aimed at providing a comfortable, sea-sickness-reducing experience for users. 	* This chair system is engineered to counteract the rolling and pitching motions caused by waves, using advanced sensors and motorized adjustments to keep the  	* chair balanced and stable. 	* 	* Key Components: 	* 	* 1. **DC Servo Motors**: Highly responsive motors that provide precise control over chair adjustments. They receive real-time stabilization commands to counteract wave movements, ensuring the chair remains steady. 	* 	* 2. **MEMS Gyroscope**: This sensor detects the roll and pitch of the chair as it responds to waves. The data it gathers is critical for calculating the  	*    necessary adjustments, which the system then applies through the servo motors. 	* 	* 3. **STM32 Microcontroller**: The processing core of the Sea't-Shell system. This microcontroller receives inputs from the gyroscope and IMU sensors,  	*    processes them, and sends commands to the motors to adjust the chair???s position. It employs real-time control algorithms to manage the chair???s movements  	*    based on incoming sensor data. 	* 	* 4. **IMU (Inertial Measurement Unit)**: Provides comprehensive motion data, including pitch, roll, and yaw, which enhances the precision of stabilization.  	*    The IMU works in conjunction with the gyroscope, feeding detailed orientation data to the microcontroller. 	* 	* 5. **Suspension System**: A robust system that physically supports and stabilizes the chair. It replaces traditional cables, providing enhanced support and  	*    shock absorption, ensuring that the chair can handle various load conditions and stabilize even during intense sea movements. 	* 	* Operation Summary: 	* The Sea't-Shell operates by continuously monitoring the chair???s orientation through the MEMS gyroscope and IMU. The STM32 microcontroller processes  	* this data, calculating the necessary adjustments to counteract the detected motion. It then signals the DC servo motors to apply the needed force to keep  	* the chair stable. The suspension system provides additional stability, ensuring the chair remains balanced and secure in dynamic marine environments. 	* 	* The Sea't-Shell system is optimized to provide a stable, comfortable seating experience for any user, regardless of sea conditions or user characteristics. 	*/ */
	}
}