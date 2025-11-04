package 'concept' {

   /* === ITEM DEFINITIONS === */
   item def SlideOperation {
      doc
      /*
       * Physical human interaction: sliding cushion panels and extending aluminium legs
       * to transform the backpack into a chair.
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

   // New: HumanInteraction Interface Definition
   port def HumanInteraction {
      in manipulatePanels; // Capabilities for sliding cushion panels
      in extendLegs;      // Capabilities for extending legs
      out exertionFeedback; // Feedback on physical effort
   }

   /* === PART DEFINITIONS === */
   part def Fabric { }
   
   part def Frame { }
   part def Hinge { }
   part def Cushion { }
   part def Leg {
      part structure : Frame;
      port frameInterface : FrameInterface;
   }

   // Updated: Human part definition with the new interface
   part def Human {
      attribute comfort : Scalar { units = 'comfort_scale'; }
      port interactionPort : HumanInteraction; // Human provides these interaction capabilities
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
      port frameInterface : ~FrameInterface;
      port hingeInterface : ~HingeInterface;
   }

   /* === ACTION DEFINITION === */
   // Updated: SlideAction now requires the HumanInteraction interface
   action def SlideAction {
      in fromBackpack : Backpack;
      out toChair : Chair;
      ref operation : SlideOperation;
      port requiredInteraction : ~HumanInteraction; // SlideAction requires interaction
      doc
      /*
       * Behavioral action representing the human performing the SlideOperation.
       * It takes the backpack configuration as input and results in a chair configuration.
       */
   }

   /* === SYSTEM CONFIGURATION CONTEXT === */
   part backpackChairContext {
      part backpack : Backpack;
      part chair : Chair;
      part user : Human; // Instance of Human

      interface frameConnection : FrameInterface connect
         backpack.frameInterface to chair.frameInterface;

      interface hingeConnection : HingeInterface connect
         backpack.hingeInterface to chair.hingeInterface;

      /* Item representing human physical operation */
      ref slideOperation : SlideOperation;


      action slideTransformation : SlideAction {
          fromBackpack = backpack;
          toChair = chair;
          operation = slideOperation;
          // The 'performer' input is now implicitly handled by the interface connection
      }

      /*user.comfort = 8;*/
   }
}