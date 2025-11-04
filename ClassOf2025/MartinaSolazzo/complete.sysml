package LandfillCompleteModel {

  /////////////////
  // STRUCTURAL MODEL
  /////////////////
  package StructuralModel {
    part def LandfillSite {
      part solarArray: SolarPVArray;
      part inverter: Inverter;
      part monitor: MonitoringSystem;
      part dashboard: Dashboard;

      connect solarArray.output -> inverter.input;
      connect inverter.data -> monitor.input;
      connect monitor.signal -> dashboard.display;
    }

    part def SolarPVArray {
      attribute power: ScalarValues::Real;
      attribute mountingType: String;
      port output;
    }

    part def Inverter {
      attribute type: String;
      port input;
      port data;
    }

    part def MonitoringSystem {
      attribute alertType: String;
      port input;
      port signal;
    }

    part def Dashboard {
      attribute displayType: String;
      port display;
    }
  }

  ///////////////////
  // STAKEHOLDERS //
  ///////////////////
  package Stakeholders {
    role def SiteManager;
    role def CommunityRep;
    role def SustainabilityAdvisor;
    role def Engineer;
    role def Regulator;

    individual item Alessandro :> SiteManager;
    individual item Chiara :> CommunityRep;
    individual item Fabio :> Engineer;
    individual item Laura :> SustainabilityAdvisor;
    individual item ARPA :> Regulator;
  }

  ///////////////////////////
  // CONFIGURATION OPTIONS //
  ///////////////////////////
  package ConfigurationOptions {
    part def LayoutOption {
      attribute estimatedCost: ScalarValues::Real;
      attribute estimatedROI: ScalarValues::Real;
      attribute power: ScalarValues::Real = 300.0;
      attribute mountingType: String;
      attribute publicAccess: Boolean;
    }

    part layoutA: LayoutOption {
      attribute estimatedCost = 472000.0;
      attribute estimatedROI = 11.0;
      attribute mountingType = "ballasted";
      attribute publicAccess = false;
    }

    part layoutB: LayoutOption {
      attribute estimatedCost = 498900.0;
      attribute estimatedROI = 8.2;
      attribute mountingType = "ballasted";
      attribute publicAccess = true;
    }

    part layoutC: LayoutOption {
      attribute estimatedCost = 499500.0;
      attribute estimatedROI = 7.5;
      attribute mountingType = "modular";
      attribute publicAccess = false;
    }

    part selectedLayout: LayoutOption = layoutB;
  }

  /////////////////////
  // BEHAVIORAL MODEL
  /////////////////////
  package BehavioralModel {
    import ConfigurationOptions::*;
    import Stakeholders::*;

    state def ProjectLifecycle {
      state evaluation;
      state design;
      state operational;

      transition 'starting-evaluation'
        first evaluation
        accept 'Start Planning'
        then design;

      transition 'deployment-complete'
        first design
        accept 'Install Confirmed'
        then operational;
    }

    action def RunSiteEvaluation {
      out layouts: LayoutOption[3];
      performedBy: Alessandro;
    }

    action def SelectConfiguration {
      in layouts: LayoutOption[3];
      out selected: LayoutOption = selectedLayout;
      performedBy: Alessandro;
    }

    action def InstallSystem {
      in layout: LayoutOption;
      performedBy: Fabio;
    }

    action def MonitorPerformance {
      in layout: LayoutOption;
      out yield: ScalarValues::Real;
      out alerts: String;
      performedBy: Alessandro;
    }

    part landfillController {
      perform RunSiteEvaluation;
      perform SelectConfiguration {
        in layouts = [layoutA, layoutB, layoutC];
      }
      perform InstallSystem {
        in layout = SelectConfiguration.selected;
      }
      perform MonitorPerformance {
        in layout = SelectConfiguration.selected;
      }
      exhibit lifecycle: ProjectLifecycle;

      connect RunSiteEvaluation.layouts -> SelectConfiguration.layouts;
      connect SelectConfiguration.selected -> InstallSystem.layout;
      connect SelectConfiguration.selected -> MonitorPerformance.layout;
    }
  }

  //////////////////////
  // REQUIREMENTS     //
  //////////////////////
  package Requirements {
    import ConfigurationOptions::*;
    import Stakeholders::*;

    requirement def BudgetConstraint {
      attribute maxCost: ScalarValues::Real = 500000.0;
      assertedBy: Laura;
      concernedStakeholder: Alessandro;
      assert constraint { selectedLayout.estimatedCost <= maxCost }
    }

    requirement def ROIRequirement {
      attribute maxYears: ScalarValues::Real = 10.0;
      assertedBy: Laura;
      concernedStakeholder: Alessandro;
      assert constraint { selectedLayout.estimatedROI <= maxYears }
    }

    requirement def NonInvasiveDesign {
      attribute groundPenetrationAllowed: Boolean = false;
      assertedBy: ARPA;
      assert constraint { selectedLayout.mountingType != "deep_anchored" }
    }

    requirement def CommunityAccess {
      attribute shouldAllowPublicAccess: Boolean = true;
      assertedBy: Chiara;
      assert constraint { selectedLayout.publicAccess == shouldAllowPublicAccess }
    }

    requirement def CapMaterialCompatibility {
      assertedBy: Fabio;
      assert constraint { selectedLayout.mountingType == "ballasted" }
    }

    requirement def IncentiveEligibility {
      assertedBy: Laura;
      concernedStakeholder: Alessandro;
      attribute minimumPower: ScalarValues::Real = 200.0;
      assert constraint {
        selectedLayout.estimatedCost <= BudgetConstraint.maxCost &
        selectedLayout.estimatedROI <= ROIRequirement.maxYears &
        selectedLayout.power >= minimumPower &
        selectedLayout.mountingType == "ballasted"
      }
    }

    connect selectedLayout -> BudgetConstraint;
    connect selectedLayout -> ROIRequirement;
    connect selectedLayout -> NonInvasiveDesign;
    connect selectedLayout -> CommunityAccess;
    connect selectedLayout -> CapMaterialCompatibility;
    connect selectedLayout -> IncentiveEligibility;
  }

  ///////////////////////////
  // VERIFICATION MODEL    //
  ///////////////////////////
  package VerificationModel {
    import ConfigurationOptions::*;
    import Requirements::*;

    verification def VerifyBudget {
      subject layout: LayoutOption;
      return verdict = (layout.estimatedCost <= BudgetConstraint.maxCost);
    }

    verification def VerifyROI {
      subject layout: LayoutOption;
      return verdict = (layout.estimatedROI <= ROIRequirement.maxYears);
    }

    verification def VerifyNonInvasiveDesign {
      subject layout: LayoutOption;
      return verdict = (layout.mountingType != "deep_anchored");
    }

    verification def VerifyCommunityAccess {
      subject layout: LayoutOption;
      return verdict = (layout.publicAccess == CommunityAccess.shouldAllowPublicAccess);
    }

    verification def VerifyCapMaterialCompatibility {
      subject layout: LayoutOption;
      return verdict = (layout.mountingType == "ballasted");
    }

    verification def VerifyIncentiveEligibility {
      subject layout: LayoutOption;
      return verdict = (
        layout.estimatedCost <= BudgetConstraint.maxCost &
        layout.estimatedROI <= ROIRequirement.maxYears &
        layout.power >= IncentiveEligibility.minimumPower &
        layout.mountingType == "ballasted"
      );
    }

    part verificationContext {
      verify VerifyBudget { layout = selectedLayout; }
      verify VerifyROI { layout = selectedLayout; }
      verify VerifyNonInvasiveDesign { layout = selectedLayout; }
      verify VerifyCommunityAccess { layout = selectedLayout; }
      verify VerifyCapMaterialCompatibility { layout = selectedLayout; }
      verify VerifyIncentiveEligibility { layout = selectedLayout; }

      connect selectedLayout -> VerifyBudget.layout;
      connect selectedLayout -> VerifyROI.layout;
      connect selectedLayout -> VerifyNonInvasiveDesign.layout;
      connect selectedLayout -> VerifyCommunityAccess.layout;
      connect selectedLayout -> VerifyCapMaterialCompatibility.layout;
      connect selectedLayout -> VerifyIncentiveEligibility.layout;
    }
  }

  /////////////////////////
  // PROOF OF CONCEPT   //
  /////////////////////////
  package ProofOfConcept {

    import ConfigurationOptions::*;
    import Stakeholders::*;
    import Requirements::*;
    import VerificationModel::*;
    import StructuralModel::*;

    action def ValidateProofOfConcept {
      in layout: LayoutOption;
      out validationPassed: Boolean;

      doc """
      Alessandro coordinates the Proof of Concept by verifying that the selected layout:
      - Complies with all regulatory and engineering constraints (non-invasive, structurally compatible)
      - Meets economic feasibility (budget and ROI)
      - Aligns with community expectations (public access)
      - Qualifies for national solar incentives for land reuse
      """;

      assert constraint {
        layout.estimatedCost <= BudgetConstraint.maxCost &
        layout.estimatedROI <= ROIRequirement.maxYears &
        layout.mountingType != "deep_anchored" &
        layout.publicAccess == CommunityAccess.shouldAllowPublicAccess
      }

      validationPassed = true;

      performedBy: Alessandro;
      reviewedBy: [Laura, Chiara, ARPA, Fabio];
    }

    part proofExecution {
      perform ValidateProofOfConcept {
        in layout = selectedLayout;
      }

      verify VerifyCapMaterialCompatibility { layout = selectedLayout; }
      verify VerifyIncentiveEligibility { layout = selectedLayout; }

      connect selectedLayout -> ValidateProofOfConcept.layout;
      connect selectedLayout -> VerifyCapMaterialCompatibility.layout;
      connect selectedLayout -> VerifyIncentiveEligibility.layout;

      connect Alessandro -> ValidateProofOfConcept.performedBy;
      connect Laura -> ValidateProofOfConcept.reviewedBy;
      connect Chiara -> ValidateProofOfConcept.reviewedBy;
      connect ARPA -> ValidateProofOfConcept.reviewedBy;
      connect Fabio -> ValidateProofOfConcept.reviewedBy;
    }

    verification def VerifyCapMaterialCompatibility {
      subject layout: LayoutOption;
      return verdict = (layout.mountingType == "ballasted");
    }

    verification def VerifyIncentiveEligibility {
      subject layout: LayoutOption;
      return verdict = (
        layout.estimatedCost <= BudgetConstraint.maxCost &
        layout.estimatedROI <= ROIRequirement.maxYears &
        layout.power >= IncentiveEligibility.minimumPower &
        layout.mountingType == "ballasted"
      );
    }

    requirement def IncentiveEligibility {
      doc "The layout must qualify for Italian incentives, meeting cost, ROI, mounting, and power requirements.";
      assertedBy: Laura;
      concernedStakeholder: Alessandro;
      attribute minimumPower: ScalarValues::Real = 200.0;
      assert constraint {
        selectedLayout.estimatedCost <= BudgetConstraint.maxCost &
        selectedLayout.estimatedROI <= ROIRequirement.maxYears &
        selectedLayout.power >= minimumPower &
        selectedLayout.mountingType == "ballasted"
      }
    }
  }

}
