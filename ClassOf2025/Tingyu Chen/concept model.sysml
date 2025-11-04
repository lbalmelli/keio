package 'MoveWellSmartChairModel' {

    // ============================================================
    // 1️⃣ SYSTEM STRUCTURE — main hardware components
    // ============================================================
    part def SmartChair {
        attribute height : Real;
        attribute weight : Real;
        attribute material : String;
        attribute powerSource : String;
        attribute sittingDuration : Real;
        attribute userPresent : Boolean;
        attribute mode : String;   // "Idle", "Sitting", "Alert", etc.

        port sensorPort;
        port actuatorPort;
        port controllerPort;
        port vibrationPort;
        port appSyncPort;

        part seatSensor : PressureSensor;
        part vibrationMotor : VibrationActuator;
        part seatMotor : LinearActuator;
        part controlUnit : ChairController;
        part powerModule : PowerSupply;
    }

    part def PressureSensor {
        attribute sensitivity : Real;
        attribute samplingRate : Real;
        perform action 'detect pressure';
    }

    part def VibrationActuator {
        attribute vibrationLevel : Real;
        perform action 'generate vibration';
    }

    part def LinearActuator {
        attribute maxStroke : Real;
        perform action 'tilt seat';
    }

    part def ChairController {
        attribute processorSpeed : Real;
        attribute memory : Real;
        perform action 'process timer';
        perform action 'send commands';
    }

    part def PowerSupply {
        attribute voltage : Real;
        attribute current : Real;
        perform action 'provide power';
    }

    // ============================================================
    // 2️⃣ FUNCTIONAL DEFINITION — logical behaviors
    // ============================================================
    action def 'Monitor Sitting Time' {
        in userDetected : Boolean;
        out duration : Real;
    }

    action def 'Alert User' {
        in duration : Real;
        perform 'generate vibration';
    }

    action def 'Enforce Standing Period' {
        in overDuration : Boolean;
        perform 'tilt seat';
        out lockActive : Boolean;
    }

    action def 'Reset Chair State' {
        in lockActive : Boolean;
        perform 'return seat';
    }

    // ============================================================
    // 3️⃣ FUNCTIONAL REALIZATION — logical to physical mapping
    // ============================================================
    allocation def 'FunctionRealization' {
        allocate 'Monitor Sitting Time' to seatSensor;
        allocate 'Alert User' to vibrationMotor;
        allocate 'Enforce Standing Period' to seatMotor;
        allocate 'Reset Chair State' to seatMotor;
        allocate 'process timer' to controlUnit;
        allocate 'provide power' to powerModule;
    }

    // ============================================================
    // 4️⃣ BEHAVIORAL STATE MACHINE — system modes
    // ============================================================
    state def 'Chair States' {
        state idle;
        state sitting;
        state alert;
        state verticalLock;
        state reset;

        transition 'idle-sitting'
            first idle
            accept when self.userPresent
            do perform 'Monitor Sitting Time'
            then sitting;

        transition 'sitting-alert'
            first sitting
            accept when self.sittingDuration >= 60[min]
            do perform 'Alert User'
            then alert;

        transition 'alert-verticalLock'
            first alert
            accept after 5[s]
            do perform 'Enforce Standing Period'
            then verticalLock;

        transition 'verticalLock-reset'
            first verticalLock
            accept after 5[min]
            do perform 'Reset Chair State'
            then reset;

        transition 'reset-idle'
            first reset
            accept when not self.userPresent
            then idle;
    }

    // ============================================================
    // 5️⃣ CHAIR DESIGN — aesthetic and ergonomic properties
    // ============================================================
    part def ChairDesign {
        attribute hasLumbarSupport : Boolean;
        attribute hasFoamPadding : Boolean;
        attribute color : String;
        attribute adjustableBackAngle : Boolean;
        attribute usbPowered : Boolean;
    }
    }
}
