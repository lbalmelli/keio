package 'Package 1' {
	import CardGameModel::*;
	package CardGameModel {
		doc /* Models a simulated card game involving various professional roles, each with specific skills. 
		          This model also defines scenarios to illustrate game mechanics such as miscommunication and negotiation. */
		part def Engineer {
			doc /* Represents an engineer role, focusing on project and negotiation skills. */
			attribute negotiationSkill : ScalarValues::Real;
			attribute projectSkill : ScalarValues::Real;
		}
		part def Architect {
			doc /* Represents an architect role, emphasizing vision and negotiation skills. */
			attribute negotiationSkill : ScalarValues::Real;
			attribute visionSkill : ScalarValues::Real;
		}
		part def ProjectManager {
			doc /* Represents a project manager role, equipped with skills for communication, negotiation, and time management. */
			attribute communicationSkill : ScalarValues::Real;
			attribute negotiationSkill : ScalarValues::Real;
			attribute timeManagementSkill : ScalarValues::Real;
		}
		part def CostConsultant {
			doc /* Represents a cost consultant role, focusing on negotiation and cost control skills. */
			attribute negotiationSkill : ScalarValues::Real;
			attribute costControlSkill : ScalarValues::Real;
		}
		part def Miscommunication {
			doc /* Models a scenario where information is transferred with potential for misinterpretation. 
			               The miscommunication rate quantifies the likelihood of information distortion. */
			fromRole : ProjectManager;
			toRole : Engineer;
			msgContent;
			misinterpretationRate : ScalarValues::Real;
		}
		part def ProjectManagement {
			doc /* Models the project management process, tracking tasks from assignment to completion under the project managers lead. */
			leader : ProjectManager;
			projectTasks : ScalarValues::Natural;
			completedTasks : ScalarValues::Natural;
			projectProgress : ScalarValues::Real;
		}
		part def Negotiation {
			doc /* Models negotiation dynamics between two roles, specifically Engineer and Architect. 
			               The outcome is represented by an agreement level based on negotiation points. */
			roleA : Engineer;
			roleB : Architect;
			negotiationPoints : ScalarValues::Natural;
			agreementLevel : ScalarValues::Real;
		}
		part def ConflictingValues {
			doc /* Models a conflict scenario where differing values between Project Manager and Cost Consultant 
			               lead to an intensity level quantifying the disagreement. */
			role1 : ProjectManager;
			role2 : CostConsultant;
			conflictIntensity : ScalarValues::Real;
		}
		part def GameSession {
			doc /* Defines a game session structure encompassing various scenarios, including miscommunication, 
			               project management, negotiation, and conflict. This can be instantiated in specific contexts. */
			part miscommunicationScenario : Miscommunication;
			part projectManagementScenario : ProjectManagement;
			part negotiationScenario : Negotiation;
			part conflictScenario : ConflictingValues;
		}
	}
	requirement def RequirementDefinition {
		part 'Player 1' : Engineer {
			inout port port;
			inout port port;
			inout port port;
			doc /* Engineer role, interacting with other roles through an interaction port. */
		}
		part 'Player 2' : Architect {
			inout port port;
			inout port port;
			inout port port;
			doc /* Architect role, interacts with others for negotiation and collaboration */
		}
		part 'Player 3' : ProjectManager {
			inout port port;
			inout port port;
			inout port port;
			doc /* Project manager role, handles project tasks and negotiates with other roles. */
		}
		part 'Player 4' : CostConsultant {
			inout port port;
			inout port port;
			inout port port;
			doc /* Cost consultant role, focused on cost control and negotiation. */
		}
	}
	package PoC {
		package ToyHouseBuildingModel {
			import ::*;
			part def Wood;
			: Material {
				attribute type = ;
				attribute cost = 5;
			}
			part def Plastic;
			: Material {
				attribute type = ;
				attribute cost = 3;
			}
			part def Glass;
			: Material {
				attribute type = ;
				attribute cost = 8;
			}
			part def AssemblyTool {
				doc /* Represents a tool used for joining materials in the toy house construction. */
				attribute type;
				attribute cost : ScalarValues::Real;
			}
			part def Pin;
			: AssemblyTool {
				attribute type = ;
				attribute cost = 1;
			}
			part def Glue;
			: AssemblyTool {
				attribute type = ;
				attribute cost = 2;
			}
			part def Rope;
			: AssemblyTool {
				attribute type = ;
				attribute cost = 0.0;
			}
			part toyHouseConstruction {
				doc /* Scenario where Engineer, Architect, Project Manager, and Cost Consultant collaborate 
				               to build a toy house with chosen materials and assembly tools. */
				part engineer {
					attribute negotiationSkill = 0.0;
					attribute projectSkill = 0.0;
				}
				part architect {
					attribute negotiationSkill = 0.0;
					attribute visionSkill = 0.0;
				}
				part projectManager {
					doc /* Oversees the project timeline and ensures adherence to goals. */
					attribute communicationSkill = 0.0;
					attribute timeManagementSkill = 0.0;
				}
				part costConsultant {
					doc /* Evaluates cost constraints and ensures the project stays within budget. */
					attribute negotiationSkill = 0.0;
					attribute costControlSkill = 0.0;
				}
				part buildingProcess : BuildingProcess;
				part wood : Wood;
				part glue : Glue;
			}
			doc /* add doc here */
		}
	}
	package PoC2 {
		package ToyHouseBuildingModelConcept {
			part def Engineer {
				doc /* * Represents an engineer with skills in negotiation and project planning. */
				attribute negotiationSkill : ScalarValues::Real;
				attribute projectSkill : ScalarValues::Real;
				port interactionPort : InteractionPort;
			}
			part def Architect {
				doc /* * Represents an architect with skills in vision planning and negotiation. */
				attribute negotiationSkill : ScalarValues::Real;
				attribute visionSkill : ScalarValues::Real;
				port interactionPort : InteractionPort;
			}
			part def ProjectManager {
				doc /* * Oversees project timeline, managing communication and time. */
				attribute communicationSkill : ScalarValues::Real;
				attribute timeManagementSkill : ScalarValues::Real;
				port interactionPort : InteractionPort;
			}
			part def CostConsultant {
				doc /* * Ensures the project stays within budget through cost control skills. */
				attribute negotiationSkill : ScalarValues::Real;
				attribute costControlSkill : ScalarValues::Real;
				port interactionPort : InteractionPort;
			}
			part def Material {
				doc /* * Represents a building material. */
				attribute type;
				attribute cost : ScalarValues::Real;
			}
			part def Wood;
			: Material {
				attribute type = ;
				attribute cost = 5;
			}
			part def Plastic;
			: Material {
				attribute type = ;
				attribute cost = 3;
			}
			part def Glass;
			: Material {
				attribute type = ;
				attribute cost = 8;
			}
			part def AssemblyTool {
				doc /* * Represents a tool used in assembly of the toy house. */
				attribute type;
				attribute cost : ScalarValues::Real;
			}
			part def Pin;
			: AssemblyTool {
				attribute type = ;
				attribute cost = 1;
			}
			part def Glue;
			: AssemblyTool {
				attribute type = ;
				attribute cost = 2;
			}
			part def Rope;
			: AssemblyTool {
				attribute type = ;
				attribute cost = 0.0;
			}
			part def BuildingProcess {
				doc /* * Process for building the toy house with chosen materials and assembly tools. */
				primaryMaterial : Material;
				secondaryMaterial : AssemblyTool;
				completedToyHouse;
				totalCost : ScalarValues::Real;
				behavior;
				buildToyHouse {
					doc /* * Builds the toy house with selected materials and calculates total cost. */
					perform  {
						matType = .;
						toolType = .;
						matCost = .;
						toolCost = .;
						completedToyHouse = ;
						totalCost = ;
					}
				}
			}
			port def InteractionPort {
				doc /* * Port enabling bidirectional communication for negotiation and decision-making. */
				action;
				negotiationData : ScalarValues::Real;
			}
		}
		doc /* add doc here */
	}
	part def BuildingProcess {
		doc /* Models the building process of a toy house using selected materials and assembly tools. */
		primaryMaterial : Material;
		secondaryMaterial : PoC::ToyHouseBuildingModel::AssemblyTool;
		completedToyHouse;
		totalCost : ScalarValues::Real;
		behavior;
		buildToyHouse {
			doc /* Combines materials and tools to create a toy house with cost calculation. */
			perform  {
				doc /* Constructs the toy house using specified materials and tools, calculating total cost. */
				matType = .;
				toolType = .;
				matCost = .;
				toolCost = .;
				completedToyHouse = ;
				totalCost = ;
			}
		}
	}
	part def Material {
		doc /* Represents a building material used in constructing the toy house. */
		attribute type;
		attribute cost : ScalarValues::Real;
	}
}