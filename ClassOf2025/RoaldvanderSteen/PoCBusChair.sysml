package 'AdaptiveBusChair_PoC' {

	public import ScalarValues::*;
	public import ISQ::*;
	public import SI::*;

	doc /* 
	Vehicle-ready proof-of-concept for the Adaptive Bus Chair design.
	This model refactors Implementation into VendorParts and PoCImplementation
	to separate reusable supplier components from prototype assembly definitions.
	*/

	// ==============================================================
	// Abstract Definitions
	// ==============================================================
	package Definitions {

		part def BusChair {
			attribute adjustableGeometry : ScalarValues::Boolean;
			attribute seatPitch : ScalarValues::Real;     
			attribute comfortRating : ScalarValues::Real;

			part seatBase;
			part backSupport;
			part frameAttachment;
			part lockingMechanism;
			part rotationMechanism;
		}

		part def Passenger {
			attribute height : ScalarValues::Real;        
			attribute comfortLevel : ScalarValues::Real;
		}
	}

	// ==============================================================
	// Implementation
	// ==============================================================
	package Implementation {

		// ----------------------------------------------------------
		// VendorParts – Market components used in the PoC
		// ----------------------------------------------------------
		package VendorParts {

			part def KIPP_K0367_PullPin {
				doc /* KIPP K0367-610 Adjustable Indexing Plunger.
					Spring-loaded steel pin for angular locking.
					https://www.kippusa.com/us/en/Products/Indexing-plungers/Indexing-plungers-locking-type-with-extended-spindle.html
				*/
				attribute strokeLength : ScalarValues::Real = 10.0 [SI::mm];
				attribute springForce  : ScalarValues::Real = 20.0 [SI::N];
				attribute engaged      : ScalarValues::Boolean = true;

				// Supplier metadata
				attribute supplier     : ScalarValues::String = "KIPP USA";
				attribute productName  : ScalarValues::String = "K0367 Adjustable Indexing Plunger";
				attribute partNumber   : ScalarValues::String = "K0367.610";
				attribute cost         : ScalarValues::Real = 18.0;
				attribute material     : ScalarValues::String = "AISI 303 Stainless Steel";
				attribute weight       : ScalarValues::Real = 0.095 [SI::kg];
				attribute datasheetURI : ScalarValues::String = "https://www.kippusa.com/us/en/Products/Indexing-plungers/Indexing-plungers-locking-type-with-extended-spindle.html";
			}

			part def Scopema_TurntableBase {
				doc /* Scopema / RIB vehicle seat swivel base.
					ECE R14/R17 compliant low-profile steel assembly.
					Used for seat rotation in buses, vans, and RVs.
				*/
				attribute installedHeight : ScalarValues::Real = 30.0 [SI::mm];
				attribute mass            : ScalarValues::Real = 9.5  [SI::kg];
				attribute maxPayload      : ScalarValues::Real = 1500.0 [SI::N];
				attribute hasDetents      : ScalarValues::Boolean = true;
				attribute detentAngles    : ScalarValues::String = "0, 90, 180";
				attribute rotationRange   : ScalarValues::String = "0..180 deg";
				part upperPlate;
				part lowerPlate;
				part lockLever;
				attribute supplier     : ScalarValues::String = "Scopema / RIB";
				attribute productName  : ScalarValues::String = "Turntable Base ECE R14/R17";
				attribute partNumber   : ScalarValues::String = "RIB-SCOPEMA-R14";
				attribute datasheetURI : ScalarValues::String = "https://scopema.com";
				attribute finish       : ScalarValues::String = "Powder-coated steel";
				attribute compliance   : ScalarValues::String = "ECE R14/R17, TÜV";
			}

			part def Unwin_SlideTrackAnchorage {
				doc /* Unwin ATF1200 Aluminium Slide Track Anchorage.
					Used for securing seat frames to vehicle floor.
					https://unwin-safety.com
				*/
				attribute length       : ScalarValues::Real = 1200.0 [SI::mm];
				attribute width        : ScalarValues::Real = 45.0 [SI::mm];
				attribute height       : ScalarValues::Real = 20.0 [SI::mm];
				attribute mass         : ScalarValues::Real = 1.8 [SI::kg];
				attribute loadCapacity : ScalarValues::Real = 3000.0 [SI::N];
				part anchorSlots;
				part mountingHoles;
				attribute supplier     : ScalarValues::String = "Unwin Safety Systems";
				attribute productName  : ScalarValues::String = "ATF1200 Slide Track Anchorage";
				attribute partNumber   : ScalarValues::String = "ATF1200-AL";
				attribute material     : ScalarValues::String = "Aluminium 6061-T6";
				attribute finish       : ScalarValues::String = "Anodized silver";
				attribute datasheetURI : ScalarValues::String = "https://unwin-safety.com";
			}
		}

		// ----------------------------------------------------------
		// PoCImplementation – Assembled prototype definitions
		// ----------------------------------------------------------
		package PoCImplementation {

			public import VendorParts::*;

			part def BusChair_PoC {
				doc /* Prototype BusChair with Scopema base, KIPP pin lock, and Unwin anchorage. */
				attribute adjustableGeometry : ScalarValues::Boolean = true;
				attribute seatPitch : ScalarValues::Real = 0.75 [SI::m];
				attribute comfortRating : ScalarValues::Real = 0.9;

				part seatBase;
				part backSupport;

				part frameAttachment {
					part anchorage : Unwin_SlideTrackAnchorage;
				}

				part rotationMechanism {
					part base : Scopema_TurntableBase;
				}

				part lockingMechanism {
					part pullPin : KIPP_K0367_PullPin;
				}
			}

			interface def ComfortFeedback {
				end passengerEnd : Definitions::Passenger;
				end chairEnd : BusChair_PoC;
				attribute pressureFeedback : ScalarValues::Real = 0.5;
				attribute comfortScore : ScalarValues::Real = 0.8;
			}
		}
	}

	// ==============================================================
	// Configuration – system context
	// ==============================================================
	package Configuration {

		public import Definitions::*;
		public import Implementation::PoCImplementation::*;

		part proofOfConceptContext {
			part chair : BusChair_PoC;
			part passenger : Passenger {
				attribute height = 1.78 [SI::m];
				attribute comfortLevel = 0.0;
			}

			// Mechanical & comfort connections
			connection seatToSwivel connect chair.frameAttachment.anchorage to chair.rotationMechanism.base.lowerPlate;
			connection seatFrameMount connect chair.rotationMechanism.base.upperPlate to chair.seatBase;
			connection kippToBase connect chair.lockingMechanism.pullPin to chair.rotationMechanism.base;

			interface comfortEval : ComfortFeedback connect passenger to chair;
		}
	}

	// ==============================================================
	// Verification
	// ==============================================================
	package Verification {
		requirement def 'Prototype Verification Requirement' {
			doc /* Verify Scopema + KIPP + Unwin system holds under vehicle vibration and complies with ECE R14/R17. */
		}
		requirement def 'Comfort Validation Requirement' {
			doc /* Validate comfortScore ≥ 0.8 for average passenger in all seat positions. */
		}
	}
}
