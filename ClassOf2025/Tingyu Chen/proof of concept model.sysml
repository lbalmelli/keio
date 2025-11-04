package 'MoveWellSmartChair_POC_RealComponents' {

    // ============================================================
    // 1️⃣ SYSTEM STRUCTURE — hardware-based proof-of-concept
    // ============================================================
    part def SmartChair {
        attribute height : Real;
        attribute weight : Real;
        attribute material : String;
        attribute powerSource : String;

        port sensorPort;
        port actuatorPort;
        port controllerPort;
        port aiPort;
        port displayPort;
        port powerPort;

        part seatSensor : PressureSensor;
        part imuSensor : MotionSensor;
        part vibrationMotor : VibrationActuator;
        part seatMotor : LinearActuator;
        part controlUnit : ChairController;
        part aiProcessor : AI_Module;
        part displayUnit : DisplayDevice;
        part powerModule : PowerSupply;
    }

    // ============================================================
    // 2️⃣ COMPONENT DEFINITIONS WITH REAL PRODUCTS
    // ============================================================

    // Seat pressure detection
    part def PressureSensor {
        attribute model : String;
        attribute brand : String;
        attribute interface : String;
        attribute sensitivity : Real;
        attribute samplingRate : Real;
        attribute priceUSD : Real;
    }

    // Posture tilt/movement sensing
    part def MotionSensor {
        attribute model : String;
        attribute brand : String;
        attribute interface : String;
        attribute range : Real;
        attribute samplingRate : Real;
        attribute priceUSD : Real;
    }

    // Vibration feedback actuator
    part def VibrationActuator {
        attribute model : String;
        attribute brand : String;
        attribute voltage : Real;
        attribute current : Real;
        attribute vibrationLevel : Real;
        attribute priceUSD : Real;
    }

    // Linear actuator for tilt / lift
    part def LinearActuator {
        attribute model : String;
        attribute brand : String;
        attribute voltage : Real;
        attribute force : Real;
        attribute stroke : Real;
        attribute speed : Real;
        attribute priceUSD : Real;
    }

    // Embedded microcontroller for logic
    part def ChairController {
        attribute model : String;
        attribute brand : String;
        attribute processor : String;
        attribute frequency : Real;
        attribute memory : Real;
        attribute wireless : String;
        attribute priceUSD : Real;
    }

    // AI inference unit
    part def AI_Module {
        attribute model : String;
        attribute brand : String;
        attribute gpuCores : Integer;
        attribute memory : Real;
        attribute powerUsage : Real;
        attribute priceUSD : Real;
    }

    // Power supply
    part def PowerSupply {
        attribute model : String;
        attribute brand : String;
        attribute type : String;
        attribute voltage : Real;
        attribute current : Real;
        attribute capacity : Real;
        attribute priceUSD : Real;
    }

    // Display system
    part def DisplayDevice {
        attribute model : String;
        attribute brand : String;
        attribute type : String;
        attribute size : Real;
        attribute resolution : String;
        attribute connectivity : String;
        attribute priceUSD : Real;
    }

    // Ergonomic design metadata
    part def ChairDesign {
        attribute hasLumbarSupport : Boolean;
        attribute hasFoamPadding : Boolean;
        attribute color : String;
        attribute adjustableBackAngle : Boolean;
        attribute usbPowered : Boolean;
    }

    // ============================================================
    // 3️⃣ MOVEWELL CHAIR POC IMPLEMENTATION — with real components
    // ============================================================
    part MoveWellChair_POC : SmartChair {

        // ---- Structural information ----
        attribute :>> height = 1.1;
        attribute :>> weight = 16.5;
        attribute :>> material = "Aluminum alloy frame + breathable mesh";
        attribute :>> powerSource = "USB-C Power Bank";

        // ---- Sensor subsystem ----
        part seatSensor {
            attribute :>> model = "FSR402 Pressure Sensor";
            attribute :>> brand = "Interlink Electronics";
            attribute :>> interface = "Analog";
            attribute :>> sensitivity = 0.95;
            attribute :>> samplingRate = 25.0;
            attribute :>> priceUSD = 8.0;
        }

        part imuSensor {
            attribute :>> model = "MPU-6050 6-DOF IMU Module";
            attribute :>> brand = "InvenSense";
            attribute :>> interface = "I2C";
            attribute :>> range = 2.0; // ±2g acceleration range
            attribute :>> samplingRate = 100.0;
            attribute :>> priceUSD = 5.5;
        }

        // ---- Vibration subsystem ----
        part vibrationMotor {
            attribute :>> model = "307-100 Coin Vibration Motor";
            attribute :>> brand = "Precision Microdrives";
            attribute :>> voltage = 3.0;
            attribute :>> current = 0.06;
            attribute :>> vibrationLevel = 0.8;
            attribute :>> priceUSD = 9.0;
        }

        // ---- Linear actuator subsystem ----
        part seatMotor {
            attribute :>> model = "FA-35-S-12-4 Linear Actuator";
            attribute :>> brand = "Firgelli Automations";
            attribute :>> voltage = 12.0;
            attribute :>> force = 150.0; // Newtons
            attribute :>> stroke = 0.1;  // meters
            attribute :>> speed = 10.0;  // mm/s
            attribute :>> priceUSD = 75.0;
        }

        // ---- Control subsystem ----
        part controlUnit {
            attribute :>> model = "ESP32 DevKit V1";
            attribute :>> brand = "Espressif Systems";
            attribute :>> processor = "Tensilica Xtensa LX6";
            attribute :>> frequency = 240.0; // MHz
            attribute :>> memory = 520.0;    // KB SRAM
            attribute :>> wireless = "Wi-Fi + Bluetooth BLE";
            attribute :>> priceUSD = 12.0;
        }

        // ---- AI processing subsystem ----
        part aiProcessor {
            attribute :>> model = "Jetson Xavier NX Developer Kit";
            attribute :>> brand = "NVIDIA";
            attribute :>> gpuCores = 384;
            attribute :>> memory = 8.0; // GB
            attribute :>> powerUsage = 15.0; // W
            attribute :>> priceUSD = 399.0;
        }

        // ---- Display subsystem ----
        part displayUnit {
            attribute :>> model = "Samsung Flip 2 55-inch";
            attribute :>> brand = "Samsung";
            attribute :>> type = "Interactive Display";
            attribute :>> size = 55.0;
            attribute :>> resolution = "3840x2160 (4K UHD)";
            attribute :>> connectivity = "HDMI / Wireless Mirroring";
            attribute :>> priceUSD = 1399.0;
        }

        // ---- Power subsystem ----
        part powerModule {
            attribute :>> model = "Anker PowerCore PD 26800";
            attribute :>> brand = "Anker";
            attribute :>> type = "USB-C Power Bank";
            attribute :>> voltage = 5.0;
            attribute :>> current = 3.0;
            attribute :>> capacity = 26800.0; // mAh
            attribute :>> priceUSD = 129.0;
        }

        // ---- Ergonomic & design subsystem ----
        part design : ChairDesign {
            attribute :>> hasLumbarSupport = true;
            attribute :>> hasFoamPadding = true;
            attribute :>> color = "Black and Silver";
            attribute :>> adjustableBackAngle = true;
            attribute :>> usbPowered = true;
        }
    }
}
