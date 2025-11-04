package 'AdaptiveBusChairProblem' {

	public import ScalarValues::*;
	public import ISQ::*;
	public import SI::*;

	//–––––––––––––––––––––––––––––––––––––––––––––––––––
	package Requirements {

		package Comfort {
			requirement def 'Comfort Requirement' {
				doc /* The chair shall provide ergonomic comfort and physical support 
					for both tall and regular passengers during normal bus operation. */
			}
			requirement def 'Ergonomic Fit Requirement' {
				doc /* The seat height and width shall match the user's body size 
					to ensure posture comfort and support. 
					Refines: Comfort Requirement */
			}
		}

		package Safety {
			requirement def 'Safety Requirement' {
				doc /* The chair shall maintain structural integrity and ensure passenger 
					safety during acceleration, braking, and collision events. */
			}
			requirement def 'Load Capacity Requirement' {
				doc /* The chair shall support passengers weighing up to 150 kg 
					without structural deformation or failure. (Fusion 360)
					Refines: Safety Requirement */
			}
			requirement def 'Attachment Strength Requirement' {
				doc /* The chair shall remain securely fixed to the vehicle frame 
					under vibration and emergency braking loads.
					Refines: Safety Requirement */
			}
		}

		package Adaptability {
			requirement def 'Adaptability Requirement' {
				doc /* The chair shall adjust or reconfigure its geometry to accommodate 
					passengers between 1.50 m and 2.00 m tall, without tools or manual effort. */
			}
		}

		package Space {
			requirement def 'Space Efficiency Requirement' {
				doc /* The chair layout shall optimize space utilization and maintain
					the current passenger capacity per bus. */
			}
		}

		package Manufacturing {
			requirement def 'Manufacturing and Cost Requirement' {
				doc /* The chair shall be economical to manufacture, lightweight, 
					and built using approved materials. */
			}
			requirement def 'Chair Weight Requirement' {
				doc /* The total mass of the chair shall be less than 10 kg. (Fusion 360)
					Refines: Manufacturing and Cost Requirement */
			}
			requirement def 'Chair Cost Requirement' {
				doc /* The manufacturing cost shall not exceed 10 000 yen per unit. (Fusion 360)
					Refines: Manufacturing and Cost Requirement */
			}
			requirement def 'Material Specification Requirement' {
				doc /* Only designated or approved materials shall be used 
					for chair manufacturing. (Fusion 360)
					Refines: Manufacturing and Cost Requirement */
			}
		}

		package DesignFreedom {
			requirement def 'Design Freedom Requirement' {
				doc /* The overall chair shape and form are not constrained 
					by external geometry standards — free design is permitted. (Fusion 360) */
			}
		}
	}

	//–––––––––––––––––––––––––––––––––––––––––––––––––––
	package Definitions {

		part def Passenger {
			attribute height : ISQ::LengthValue;
			attribute comfortLevel : ScalarValues::Real;

			part def TallPassenger :> Passenger {
				doc /* Represents passengers above 1.85 m needing extra legroom. */
			}
			part def RegularPassenger :> Passenger {
				doc /* Represents typical commuters prioritizing compact seating. */
			}
		}

		part def BusChair {

			doc /* Composite seat assembly providing comfort, safety,
				and space efficiency in a public transport environment. */

			attribute adjustableGeometry : ScalarValues::Boolean;
			attribute seatPitch : ISQ::LengthValue;
			attribute comfortRating : ScalarValues::Real;

			part seatBase {
				doc /* Primary seating surface supporting passenger weight. */
				part armSupport {
					doc /* Lateral rest integrated into seatBase to enhance posture comfort
						and stability during motion. */
				}
			}

			part backSupport {
				doc /* Provides upper-body and lumbar support. */
			}

			part adjustMechanism {
				doc /* Enables recline or pitch adjustment for posture comfort. */
			}

			part frameAttachment {
				doc /* Connects the chair assembly to the vehicle frame for stability. */
			}

			part rotationMechanism {
				doc /* Allows manual seat rotation between predefined angles.
					Consists of a pivot joint and bearing system mounted to the frameAttachment. */
				attribute rotationAngle : ScalarValues::Real;
				attribute maxRotationAngle : ScalarValues::Real = 45.0;
				ref connectedFrame : frameAttachment;
			}

			part lockingMechanism {
				doc /* Spring-loaded pull-pin system that locks the rotationMechanism
					in discrete angular positions. When the user pulls the pin,
					the seat can rotate; releasing the pin re-engages the spring 
					to lock the chair automatically. */
				part pullPin {
					doc /* Cylindrical steel pin that engages holes in the rotation plate. */
					attribute engaged : ScalarValues::Boolean;
				}
				part springRetainer {
					doc /* Coil spring providing axial force to keep the pullPin engaged 
						when released by the user. */
					attribute springForce : ISQ::ForceValue;
					ref maintainedPin : pullPin;
				}
				ref controlledRotation : rotationMechanism;
			}

			//–––––––––––––––––––––––––––––––––––––––––––––––––––
			// Internal physical connections between chair parts
			connection seatToBack connect seatBase to backSupport;
			connection seatToAdjust connect backSupport to adjustMechanism;
			connection adjustToFrame connect adjustMechanism to frameAttachment;
			connection frameToRotation connect frameAttachment to rotationMechanism;
			connection rotationToLock connect rotationMechanism to lockingMechanism;
		}

		//–––––––––––––––––––––––––––––––––––––––––––––––––––
		// Comfort interface definition (Passenger ↔ BusChair)
		interface def ComfortInterface {

			doc /* Defines measurable comfort interaction parameters 
				between a Passenger and a BusChair instance.
				Used for exchanging comfort and posture data. */

			end passengerEnd : Passenger;
			end chairEnd : BusChair;

			attribute pressureFeedback : ScalarValues::Real;
			attribute comfortScore : ScalarValues::Real;
		}
	}

	//–––––––––––––––––––––––––––––––––––––––––––––––––––
	package Configuration {

		public import Definitions::*;

		part systemContext {
			part busSeat : BusChair;
			part seatedPassenger : Passenger;

			// Mechanical connections
			interface frameJoint connect 
				busSeat.rotationMechanism.connectedFrame to busSeat.frameAttachment;

			interface rotationLock connect 
				busSeat.lockingMechanism.controlledRotation to busSeat.rotationMechanism;

			interface springToPin connect 
				busSeat.lockingMechanism.springRetainer.maintainedPin to busSeat.lockingMechanism.pullPin;

			// Comfort interaction between Passenger and BusChair
			interface comfortLink : ComfortInterface connect 
				seatedPassenger to busSeat;
		}
	}

	//–––––––––––––––––––––––––––––––––––––––––––––––––––
	package RequirementUsages {

		public import Requirements::*;
		public import Definitions::*;
		public import SI::*;

		requirement 'Seat Comfort Requirement' {
			subject seat : Definitions::BusChair::seatBase;
			doc /* seatBase shall provide uniform support and maintain comfort 
				across passenger body sizes. */
		}

		requirement 'Arm Support Comfort' {
			subject arm : Definitions::BusChair::seatBase::armSupport;
			doc /* armSupport shall improve posture comfort and provide stability 
				during bus motion. */
		}

		requirement 'Back Support Ergonomics' {
			subject back : Definitions::BusChair::backSupport;
			doc /* backSupport shall align with spinal curvature and reduce fatigue. */
		}

		requirement 'Adjustability Mechanism Compliance' {
			subject mechanism : Definitions::BusChair::adjustMechanism;
			doc /* adjustMechanism shall allow simple geometry adjustment for tall passengers. */
		}

		requirement 'Frame Attachment Safety' {
			subject attach : Definitions::BusChair::frameAttachment;
			doc /* frameAttachment shall resist detachment and deformation under dynamic load. */
		}

		requirement 'Adaptive Seat Constraints' {
			subject chair : Definitions::BusChair;
			require constraint {
				chair.adjustableGeometry == true &
				chair.seatPitch <= 0.80 [SI::m]
			}
			doc /* Ensures the chair adapts within space limits while retaining comfort. */
		}
	}
}
