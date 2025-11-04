package 'poc' {

   /* === ITEM DEFINITIONS === */
   item def SlideOperation {
      doc
      /*
       * Human-driven reconfiguration: sliding panels, rotating hinges,
       * and extending aluminum legs — converting a backpack into a chair.
       */
   }

   /* === PORT DEFINITIONS === */
   port def FrameInterface {
      in loadTransfer;
      out supportFeedback;
   }

   port def HingeInterface {
      in rotationCmd;
      out hingeLockStatus;
   }

   port def HumanInteraction {
      in manipulatePanels;
      in extendLegs;
      out exertionFeedback;
   }

   // Added for clarity — soft and load interfaces
   port def FabricAttachmentInterface {
      in attachSurface;
      out tensionFeedback;
   }

   port def LoadSupportInterface {
      in weight;
      out structuralFeedback;
   }

   port def LegJointInterface {
      in jointTorque;
      out jointStability;
   }

   /* === PART DEFINITIONS === */
   part def Fabric {
      attribute material : String = "Cordura 500D";
      port fabricAttachment : FabricAttachmentInterface;
   }

   part def Frame {
      attribute material : String = "6061-T6 Aluminum";
      port frameLoad : FrameInterface;
   }

   part def Hinge {
      attribute vendor : String = "Southco Adjustable Pivot Hinge";
      port hingeConnection : HingeInterface;
   }

   part def Cushion {
      attribute model : String = "Therm-a-Rest Z Seat";
      port cushionSupport : LoadSupportInterface;
      port fabricAttachment : ~FabricAttachmentInterface;
   }

   part def Leg {
      attribute model : String = "Helinox DAC Foldable Leg";
      port legJoint : LegJointInterface;
      port frameInterface : FrameInterface;
   }

   part def Human {
      attribute comfort : Scalar { units = 'comfort_scale'; } = 8;
      port interactionPort : HumanInteraction;
   }

   /* === BACKPACK STRUCTURE === */
   part def Backpack {

      part storageSection {
         part outerFabric : Fabric;
         part innerPocket : Fabric;
      }

      part supportSystem {
         part metalFrame : Frame;
         part foldHinges : Hinge;
         part cushionBack : Cushion;
         part cushionBottom : Cushion;
         part aluminiumLegs[2] : Leg;
      }

      port frameInterface : FrameInterface;
      port hingeInterface : HingeInterface;

      /* === Internal Assembly Connections === */

      // Fabric-to-cushion and frame integration
      interface outerFabricToCushionBack : FabricAttachmentInterface connect
         storageSection.outerFabric.fabricAttachment to supportSystem.cushionBack.fabricAttachment;

      interface innerPocketToOuterFabric : FabricAttachmentInterface connect
         storageSection.innerPocket.fabricAttachment to storageSection.outerFabric.fabricAttachment;

      // Cushions supported by metal frame
      interface cushionBackToFrame : LoadSupportInterface connect
         supportSystem.cushionBack.cushionSupport to supportSystem.metalFrame.frameLoad;

      interface cushionBottomToFrame : LoadSupportInterface connect
         supportSystem.cushionBottom.cushionSupport to supportSystem.metalFrame.frameLoad;

      // Legs connected to frame via joint interfaces
      interface leg1Joint : LegJointInterface connect
         supportSystem.aluminiumLegs#(1).legJoint to supportSystem.metalFrame.frameLoad;

      interface leg2Joint : LegJointInterface connect
         supportSystem.aluminiumLegs#(2).legJoint to supportSystem.metalFrame.frameLoad;

      // Hinges connect to frame
      interface hingeToFrame : HingeInterface connect
         supportSystem.foldHinges.hingeConnection to supportSystem.metalFrame.frameLoad;

      // Backpack system-level ports connected to frame/hinge
      interface frameBinding : FrameInterface connect
         supportSystem.metalFrame.frameLoad to frameInterface;

      interface hingeBinding : HingeInterface connect
         supportSystem.foldHinges.hingeConnection to hingeInterface;
   }

   /* === CHAIR STRUCTURE === */
   part def Chair {

      part seatAssembly {
         part cushionPad : Cushion;
         part supportFrame : Frame;
      }

      part backSupport {
         part backFabric : Fabric;
         part lockHinge : Hinge;
      }

      part frontLegs[2] : Leg;
      part backLegs[2] : Leg;

      port frameInterface : ~FrameInterface;
      port hingeInterface : ~HingeInterface;

      /* === Internal Assembly Connections === */

      // Cushion supported by seat frame
      interface cushionToSeatFrame : LoadSupportInterface connect
         seatAssembly.cushionPad.cushionSupport to seatAssembly.supportFrame.frameLoad;

      // Back fabric attached to hinge and frame
      interface backFabricToHinge : FabricAttachmentInterface connect
         backSupport.backFabric.fabricAttachment to backSupport.lockHinge.hingeConnection;

      interface backFabricToFrame : FabricAttachmentInterface connect
         backSupport.backFabric.fabricAttachment to seatAssembly.supportFrame.frameLoad;

      // Hinge joins seat frame and back support
      interface frameToBackHinge : HingeInterface connect
         seatAssembly.supportFrame.frameLoad to backSupport.lockHinge.hingeConnection;

      // Legs connect to seat frame
      interface frontLegsAttach : LegJointInterface connect
         frontLegs#(1).legJoint to seatAssembly.supportFrame.frameLoad;

      interface backLegsAttach : LegJointInterface connect
         backLegs#(1).legJoint to seatAssembly.supportFrame.frameLoad;

      // Frame connection to system-level interface
      interface chairFrameBinding : FrameInterface connect
         seatAssembly.supportFrame.frameLoad to frameInterface;

      interface chairHingeBinding : HingeInterface connect
         backSupport.lockHinge.hingeConnection to hingeInterface;
   }

   /* === ACTION DEFINITION === */
   action def SlideAction {
      in fromBackpack : Backpack;
      out toChair : Chair;
      ref operation : SlideOperation;
      port requiredInteraction : ~HumanInteraction;

      doc
      /*
       * Behavioral action performed by the human.
       * Executes SlideOperation: detach fabrics, rotate hinge, extend legs,
       * and reconfigure structure from backpack mode to chair mode.
       */
   }

   /* === SYSTEM CONFIGURATION CONTEXT (Assembly) === */
   part backpackChairContext {

      part backpack : Backpack;
      part chair : Chair;
      part user : Human;

      /* Connect system-level structural paths */
      interface frameConnection : FrameInterface connect
         backpack.frameInterface to chair.frameInterface;

      interface hingeConnection : HingeInterface connect
         backpack.hingeInterface to chair.hingeInterface;

      /* Define the operational reference */
      ref slideOperation : SlideOperation;

      /* Human action triggers transformation */
      interface humanActionConnection : HumanInteraction connect
         user.interactionPort to slideTransformation.requiredInteraction;

      /* Define transformation action */
      action slideTransformation : SlideAction {
         fromBackpack = backpack;
         toChair = chair;
         operation = slideOperation;
      }

      user.comfort : Integer;
   }

   /* === VISUALIZATION HINT === */
   view asAssemblyDiagram {
      expose backpackChairContext;
      doc
      /*
       * Visualize as a multi-level assembly:
       * - Internal structure of Backpack (fabric, cushions, frame, hinges, legs)
       * - Internal structure of Chair (frame, hinge, fabric, legs)
       * - External connections and human-triggered transformation
       */
   }

   Please note that this model does not refer to company internal libraries or other models that you have defined in previous sessions.
   However, you might use Acronio-Technology to ensure model compositionality.
}

