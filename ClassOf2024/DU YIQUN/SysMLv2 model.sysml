package WheelchairWithBabySeatModel {

    import SI::kg;
    import SI::m;
    import SI::N;
    import VerificationLibrary::*;
    import SafetyLibrary::*;

    /* 1. Define Main Components */
    part def Wheelchair {
        attribute weight: kg;
        attribute maxLoad: kg;

        part frame: Frame;
        part wheels: Wheel[4];
        part seat: Seat;
        part brakes: BrakeSystem;
        port mobility: MobilityPort;
    }

    part def BabySeat {
        attribute maxWeight: kg;
        attribute material: String;
        
        part harness: SafetyHarness;
        part padding: Cushioning;
        port attachment: AttachmentPort;
    }

    part def SafetyHarness {
        attribute buckleStrength: N;
        attribute strapMaterial: String;
    }

    part def BrakeSystem {
        attribute brakeType: String;
        attribute brakeForce: N;
        port control: BrakeControlPort;
    }

    /* 2. Define Interfaces */
    port def MobilityPort {
        in pushForce: N;
        out movement: m/s;
    }
    
    port def AttachmentPort {
        in lockStatus: Boolean;
    }

    port def BrakeControlPort {
        in engageBrake: Boolean;
    }

    /* 3. Wheelchair with Baby Seat System */
    part WheelchairWithBabySeat {
        part wheelchair: Wheelchair {
            attribute redefines maxLoad = 120 [kg];
        }
        part babySeat: BabySeat {
            attribute redefines maxWeight = 20 [kg];
            attribute redefines material = "Reinforced Polymer";
        }
        
        interface seatAttachment connect wheelchair.frame to babySeat.attachment;
    }

    /* 4. Proof-of-Concept (PoC) Phases */
    package ProofOfConcept {
        part PoCPhase {
            action defineRequirements;
            action buildPrototype;
            action conductLoadTesting;
            action performUserTrials;
            action refineDesign;
            
            succession flow processFlow {
                defineRequirements -> buildPrototype -> conductLoadTesting -> performUserTrials -> refineDesign;
            }
        }
    }

    /* 5. Wheelchair State Machine (Behavior Model) */
    package BehaviorModels {
        state def WheelchairStates {
            state stationary;
            state moving;
            state braking;
            
            transition 'start-moving'
                first stationary
                accept pushForce > 5 [N]
                then moving;
            
            transition 'apply-brakes'
                first moving
                accept engageBrake = True
                do stopMovement()
                then braking;
            
            transition 'release-brakes'
                first braking
                accept engageBrake = False
                then stationary;
        }

        action def stopMovement {
            out movement = 0 [m/s];
        }
    }

    /* 6. Verification and Safety Requirements */
    package Verification {
        import ProofOfConcept::*;
        import BehaviorModels::*;

        verification def LoadTest {
            objective ensureLoadCapacity {
                verify requirement LoadRequirement;
            }
        }

        verification def SafetyTest {
            objective ensureSeatSafety {
                verify requirement SafetyRequirement;
            }
        }

        requirement def LoadRequirement {
            attribute maxWeight: kg;
            require constraint { maxWeight <= 120 [kg] }
        }

        requirement def SafetyRequirement {
            attribute lockStatus: Boolean;
            require constraint { lockStatus = True }
        }
    }

    /* 7. Simulation and Testing */
    package Simulation {
        part SimulationSetup {
            perform ProofOfConcept::PoCPhase;
            exhibit state WheelchairStates;
            
            scenario testLoadCapacity {
                assign WheelchairWithBabySeat.babySeat.maxWeight = 25 [kg];
                evaluate Verification::LoadTest;
            }
        }
    }
}

