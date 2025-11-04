package IT_Tools_Interconnection_4 {

    package Definitions {

        // Lifecycle enumeration for data maturity
        enum def LifecycleState {
            enum CONCEPTION;     // En cours de création
            enum REVIEW;         // En validation
            enum VALIDATED;      // Approuvé et publié
            enum OBSOLETE;       // Plus utilisé
            enum CANCELLED;      // Annulé
        }

        // Data items exchanged between systems
        item def Model_3D {
            doc 
            /* Represents the 3D design model created and managed in CREO, 
             * transferred to PLM for validation and lifecycle management. 
             * Contains metadata for authorship, versioning, and traceability.
             */

            attribute Lifecycle : LifecycleState = LifecycleState::CONCEPTION;
            attribute Author : String;
            attribute Version : String;
            attribute Date_Creation : Date;
            attribute Last_Modified : Date;
        }

        item def ProductBOM {
            doc
            /* Represents the Product Stucture generated from PLM,
             * later transferred to SAP for manufacturing and production planning. 
             * Tracks product structure, version, and production-related metadata.
             */

            attribute Lifecycle : LifecycleState = LifecycleState::CONCEPTION;
            attribute Product_ID : String;
            attribute Version : String;
            attribute Date_Creation : Date;
            attribute Last_Modified : Date;
            attribute Production_Rate : Natural;
        }


        // Port definition for exchanging these items
        port def InfoPort {
            out Model_3D_out: Model_3D;
            out Product_BOM_out: ProductBOM;
            
            in Model_3D_in: Model_3D;
            in Product_BOM_in: ProductBOM;
        }

        // System part definitions exposing InfoPorts
        part def PLM_Windchill {
            doc 
            /* Represents the Product Lifecycle Management (PLM) system Windchill. 
             * It acts as a central repository for design data, ensuring version 
             * control, validation, and product configuration management.
             */

            port PLM_Port: InfoPort;
        }

        part def ERP_SAP {
            doc 
            /* Represents the Enterprise Resource Planning (ERP) system SAP. 
             * It consumes Product BOM information from PLM for manufacturing 
             * resource planning, scheduling, and production rate tracking.
             */

            port SAP_Port: InfoPort;
        }

        part def CAD_Creo {
            doc
            /* Represents the CAD software CREO. 
             * It produces the 3D model design data and initial Product BOM 
             * information before transferring them to the PLM system.
             */
            port CREO_Port: InfoPort;
        }
    }

    package Configuration {
        public import Definitions::*;

        // Actual way my software environment work
        part IT_Landscape_Context {
            part PLM: PLM_Windchill;
            part SAP: ERP_SAP;
            part CREO: CAD_Creo;

            // CREO → PLM: transfer of Model 3D and Product BOM
            interface creoToPlm connect CREO.CREO_Port to PLM.PLM_Port {
                flow CREO.CREO_Port.Model_3D_out to PLM.PLM_Port.Model_3D_in;
                flow CREO.CREO_Port.Product_BOM_out to PLM.PLM_Port.Product_BOM_in;
            }

            // PLM → SAP: transfer of Product BOM and Production Rate
            interface plmToSap connect PLM.PLM_Port to SAP.SAP_Port {
                flow PLM.PLM_Port.Product_BOM_out to SAP.SAP_Port.Product_BOM_in;
            }
        }
    }
}
