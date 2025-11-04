package SportsCar_MaterialConcept {

  ////////////////////////////////////////////////////////
  // 1) Actors
  ////////////////////////////////////////////////////////
  part def Actor;

  part def MaterialsEngineer: Actor {
    port materialRole: Role_MaterialDesign;

    doc /* 
      The Materials Engineer is responsible for selecting and evaluating advanced materials 
      used in the vehicle, particularly the reinforcement material (e.g., carbon fiber). 
      They ensure that structural performance criteria such as strength, stiffness, and durability 
      are satisfied while optimizing weight and manufacturability.
    */
  }

  part def SustainabilityLead: Actor {
    port recycleRole: Role_RecyclabilityValidation;

    doc /*
      The Sustainability Lead ensures that material selections comply with environmental 
      regulations and corporate sustainability goals. This includes maximizing recyclable 
      content (e.g., using recycled PET) and minimizing environmental impact through material lifecycle assessments.
    */
  }

  part def VehicleArchitect: Actor {
    port vehicleIntegrationRole: Role_VehicleIntegration;

    doc /*
      The Vehicle Architect integrates subsystems and materials into the overall vehicle platform, 
      ensuring packaging, performance, and manufacturability constraints are met. 
      They align material properties with design requirements for weight, aerodynamics, and crashworthiness.
    */
  }

  ////////////////////////////////////////////////////////
  // 2) Roles (Interfaces)
  ////////////////////////////////////////////////////////
  interface def Role_MaterialDesign;
  interface def Role_RecyclabilityValidation;
  interface def Role_VehicleIntegration;

  ////////////////////////////////////////////////////////
  // 3) Requirements
  ////////////////////////////////////////////////////////
  requirement def RQ_WeightReduction;
  requirement def RQ_AeroFormability;
  requirement def RQ_Recyclability;

  ////////////////////////////////////////////////////////
  // 4) Composite Material System
  ////////////////////////////////////////////////////////
  part def CompositeMaterialSystem {

    part Matrix: PET_Recycled {
      attribute recycledContent_pct: Real;
      attribute density_gcm3: Real;

      doc /*
        PET_Recycled represents the polymer matrix made from post-consumer recycled PET 
        (polyethylene terephthalate), commonly sourced from recycled bottles. 
        It forms the base structure of the composite, embedding the fibers, 
        and contributes to both sustainability and density characteristics.
      */
    }

    part Reinforcement: CarbonFiberFabric {
      attribute weaveType: String;
      attribute tensileStrength_MPa: Real;

      doc /*
        CarbonFiberFabric is the reinforcement layer of the composite material. 
        It provides tensile strength and stiffness to the structure. The fabric is typically woven 
        in patterns like "twill" or "plain" to balance strength, flexibility, and aesthetic appeal. 
        Carbon fiber is known for its high strength-to-weight ratio and is widely used in motorsports and aerospace.
      */
    }

    attribute density_gcm3: Real;
    attribute tensileStrength_MPa: Real;
    attribute aerodynamicGrade: Boolean;

    interface Reinforces connect
      source: Reinforcement to target: Matrix;

    bind density_gcm3 to Matrix.density_gcm3;
    bind tensileStrength_MPa to Reinforcement.tensileStrength_MPa;
    bind aerodynamicGrade to aerodynamicGrade;

    // === Role Connections ===
    connect Reinforcement to Role_MaterialDesign;
    connect Matrix to Role_RecyclabilityValidation;
    connect CompositeMaterialSystem to Role_VehicleIntegration;

    // === Requirement Satisfaction ===
    connect satisfy CompositeMaterialSystem to RQ_WeightReduction;
    connect satisfy CompositeMaterialSystem to RQ_AeroFormability;
    connect satisfy Matrix.recycledContent_pct to RQ_Recyclability;
    connect satisfy Matrix.density_gcm3 to RQ_WeightReduction;
    connect satisfy Reinforcement.tensileStrength_MPa to RQ_WeightReduction;
    connect satisfy aerodynamicGrade to RQ_AeroFormability;
  }

  ////////////////////////////////////////////////////////
  // 5) Behaviors
  ////////////////////////////////////////////////////////
  action processCureComposite {
    in matrix: PET_Recycled;
    in reinforcement: CarbonFiberFabric;
    out curedComposite: CompositeMaterialSystem;

    doc /*
      Simulates the thermal curing process to bond matrix and reinforcement materials.
      Verifies that material attributes (density, strength) remain within target thresholds post-curing.
    */
  }

  action validateAeroFlow {
    in panel: CompositeMaterialSystem;
    out passed: Boolean;

    doc /*
      Evaluates aerodynamic performance of the body panel design.
      Checks if aerodynamicGrade is set to true based on simulation inputs.
    */
  }

  action assessRecyclability {
    in matrix: PET_Recycled;
    out valid: Boolean;

    doc /*
      Assesses the environmental compliance of the matrix based on recycled content percentage.
      Ensures that sustainability thresholds are met.
    */
  }

}
