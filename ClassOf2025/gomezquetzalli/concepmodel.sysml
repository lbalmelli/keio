package Material_SportsCarConcept {

  ////////////////////////////////////////////////////////
  // 1) Actors (Stakeholders)
  ////////////////////////////////////////////////////////
  part def Actor;

  part def MaterialsEngineer: Actor;
  part def SustainabilityLead: Actor;
  part def VehicleArchitect: Actor;

  ////////////////////////////////////////////////////////
  // 2) Requirements
  ////////////////////////////////////////////////////////
  requirement def RQ_WeightReduction {
    id = "MAT-REQ-01";
    text = "The material shall reduce part weight by at least 30% compared to traditional aluminum components.";
  }

  requirement def RQ_AeroFormability {
    id = "MAT-REQ-02";
    text = "The material shall allow forming of curved aerodynamic surfaces without delamination or wrinkling.";
  }

  requirement def RQ_Recyclability {
    id = "MAT-REQ-03";
    text = "The material shall contain at least 60% recycled PET and be processable in existing recycling streams.";
  }

  ////////////////////////////////////////////////////////
  // 3) Material System and Subcomponents
  ////////////////////////////////////////////////////////
  part def CompositeMaterialSystem {

    part Matrix: PET_Recycled;
    part Reinforcement: CarbonFiberFabric;

    attribute density_gcm3: Real;
    attribute tensileStrength_MPa: Real;
    attribute aerodynamicGrade: Boolean;
  }

  part def PET_Recycled;
  part def CarbonFiberFabric;

  ////////////////////////////////////////////////////////
  // 4) Concept Context
  ////////////////////////////////////////////////////////
  package Concept_Context {

    part mat: CompositeMaterialSystem {
      density_gcm3 = 1.2;
      tensileStrength_MPa = 600.0;
      aerodynamicGrade = true;

      part Matrix {
        recycledContent_pct = 65.0;
      }

      part Reinforcement {
        weaveType = "twill";
      }
    }

    part eng: MaterialsEngineer;
    part sus: SustainabilityLead;
    part arch: VehicleArchitect;

    requirement rq1: RQ_WeightReduction;
    requirement rq2: RQ_AeroFormability;
    requirement rq3: RQ_Recyclability;
  }
}



