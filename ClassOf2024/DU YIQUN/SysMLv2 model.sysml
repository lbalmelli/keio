package WheelchairWithBabySeatModel {

    import SI::kg;
    import SI::m;
    
    /* DEFINITIONS */
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
        port control: BrakeControlPort;
    }

    /* INTERFACES */
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

    /* CONFIGURATION */
    part WheelchairWithBabySeat {
        part wheelchair: Wheelchair {
            attribute redefines maxLoad = 120 [kg];
        }
        part babySeat: BabySeat {
            attribute redefines maxWeight = 20 [kg];
        }
        
        interface seatAttachment connect wheelchair.frame to babySeat.attachment;
    }
}

