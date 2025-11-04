package IT_Tools_Interconnection_POC {

    import IT_Tools_Interconnection_4::*;

    doc 
    /*
     * Proof-of-Concept comparison model containing three alternative triptychs.
     * Each package directly defines a possible configuration for CAD–PLM–ERP integration,
     * with qualitative characteristics for decision support.
     */

    // ============================================================
    // OPTION A — INDUSTRIAL PREMIUM
    // ============================================================
    package POC_OptionA_Premium {
        doc 
        /*
         * 🏭 Industrial Premium Architecture
         * -----------------------------------
         * Composition:
         *   CAD: PTC Creo
         *   PLM: PTC Windchill
         *   ERP: SAP S/4HANA
         *
         * Characteristics:
         *   • Cost: High (≈ 100k–250k €/year)
         *   • Target enterprise: Large industrial (automotive, aerospace, defense)
         *   • Robustness: Excellent – enterprise-grade with full data integrity
         *   • Flexibility: Moderate – closed ecosystem, strong vendor lock-in
         *   • Cloud availability: Hybrid (on-prem or PTC Cloud + SAP Cloud)
         *   • Integration:
         *        - CAD→PLM: Native (Creo↔Windchill)
         *        - PLM→ERP: Certified connector (Windchill↔SAP)
         *   • Complexity: High – dedicated infrastructure required
         *   • Ideal for: Realistic industrial PoC with high governance
         */

        part CREO: CAD_Creo {
            attribute Vendor = "PTC";
            attribute Version = "Creo Parametric 10";
        }

        part PLM: PLM_Windchill {
            attribute Vendor = "PTC";
            attribute Version = "Windchill 13";
        }

        part SAP: ERP_SAP {
            attribute Vendor = "SAP";
            attribute Version = "S/4HANA 2023";
        }

        interface CreoToPlm connect CREO.CREO_Port to PLM.PLM_Port {
            flow CREO.CREO_Port.Model_3D_out to PLM.PLM_Port.Model_3D_in;
            flow CREO.CREO_Port.Product_BOM_out to PLM.PLM_Port.Product_BOM_in;
        }

        interface PlmToSap connect PLM.PLM_Port to SAP.SAP_Port {
            flow PLM.PLM_Port.Product_BOM_out to SAP.SAP_Port.Product_BOM_in;
        }
    }

    // ============================================================
    // OPTION B — FLEXIBLE / BALANCED
    // ============================================================
    package POC_OptionB_Flexible {
        doc 
        /*
         * ☁️ Balanced Cloud / Hybrid Architecture
         * ----------------------------------------
         * Composition:
         *   CAD: Dassault CATIA
         *   PLM: Siemens Teamcenter
         *   ERP: Oracle NetSuite
         *
         * Characteristics:
         *   • Cost: Medium (≈ 50k–120k €/year)
         *   • Target enterprise: Mid-size to large engineering firms
         *   • Robustness: High – used in complex industrial environments
         *   • Flexibility: Good – hybrid cloud, configurable integrations
         *   • Cloud availability: Yes (Teamcenter X + NetSuite Cloud)
         *   • Integration:
         *        - CAD→PLM: Supported (CATIA↔Teamcenter via JT/STEP)
         *        - PLM→ERP: Middleware required (REST/XML)
         *   • Complexity: Medium – modular deployment
         *   • Ideal for: Collaborative engineering with multi-vendor setup
         */

        part CATIA: CAD_Creo {
            attribute Vendor = "Dassault Systèmes";
            attribute Version = "CATIA V6 2024";
        }

        part TEAMCENTER: PLM_Windchill {
            attribute Vendor = "Siemens";
            attribute Version = "Teamcenter X 2025";
        }

        part NETSUITE: ERP_SAP {
            attribute Vendor = "Oracle";
            attribute Version = "NetSuite Cloud ERP 2025";
        }

        interface CatiaToTeamcenter connect CATIA.CREO_Port to TEAMCENTER.PLM_Port {
            flow CATIA.CREO_Port.Model_3D_out to TEAMCENTER.PLM_Port.Model_3D_in;
            flow CATIA.CREO_Port.Product_BOM_out to TEAMCENTER.PLM_Port.Product_BOM_in;
        }

        interface TeamcenterToNetsuite connect TEAMCENTER.PLM_Port to NETSUITE.SAP_Port {
            flow TEAMCENTER.PLM_Port.Product_BOM_out to NETSUITE.SAP_Port.Product_BOM_in;
        }
    }

    // ============================================================
    // OPTION C — LIGHTWEIGHT / PROTOTYPE
    // ============================================================
    package POC_OptionC_Lightweight {
        doc 
        /*
         * 🧠 Lightweight Open & Agile Architecture
         * ----------------------------------------
         * Composition:
         *   CAD: FreeCAD (open source)
         *   PLM: Aras Innovator
         *   ERP: Microsoft Dynamics 365 Business Central
         *
         * Characteristics:
         *   • Cost: Low (≈ 0–15k €/year)
         *   • Target enterprise: SMEs, startups, academic or R&D PoC
         *   • Robustness: Moderate – stable for demonstrations
         *   • Flexibility: Excellent – open APIs, extensible
         *   • Cloud availability: Yes (Aras Cloud + Dynamics 365)
         *   • Integration:
         *        - CAD→PLM: STEP/XML or Python scripts
         *        - PLM→ERP: REST API connectors
         *   • Complexity: Low – quick setup
         *   • Ideal for: Fast prototyping & integration testing
         */

        part FREECAD: CAD_Creo {
            attribute Vendor = "FreeCAD Community";
            attribute Version = "FreeCAD 0.22";
        }

        part ARAS: PLM_Windchill {
            attribute Vendor = "Aras Corporation";
            attribute Version = "Aras Innovator 30R2";
        }

        part DYNAMICS: ERP_SAP {
            attribute Vendor = "Microsoft";
            attribute Version = "Dynamics 365 Business Central 2025";
        }

        interface FreecadToAras connect FREECAD.CREO_Port to ARAS.PLM_Port {
            flow FREECAD.CREO_Port.Model_3D_out to ARAS.PLM_Port.Model_3D_in;
            flow FREECAD.CREO_Port.Product_BOM_out to ARAS.PLM_Port.Product_BOM_in;
        }

        interface ArasToDynamics connect ARAS.PLM_Port to DYNAMICS.SAP_Port {
            flow ARAS.PLM_Port.Product_BOM_out to DYNAMICS.SAP_Port.Product_BOM_in;
        }
    }
}

