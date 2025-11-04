# 🪑 MoveWell Smart Chair | SysML v2 Prompt Library
This document provides a complete set of prompts for creating and refining the **MoveWell Smart Chair** in SysML v2.

---

## 🧭 PART I — CONCEPT MODEL PROMPTS

### 1️⃣ System Concept Definition
> **Prompt:**  
> Describe the MoveWell Smart Chair as an intelligent ergonomic system that monitors posture, sitting time, and user presence.  
> Include:  
> - Physical components (sensors, actuators, controllers)  
> - Logical behaviors (state transitions)  
> - Ergonomic and design features  
> Create a SysML v2 `package 'MoveWellSmartChairModel'` that defines structure, attributes, and connections.

---

### 2️⃣ System Structure Modeling
> **Prompt:**  
> Define `part def SmartChair` with attributes for height, weight, material, powerSource, mode, and ports for data flow.  
> Add parts:
> - PressureSensor  
> - VibrationActuator  
> - LinearActuator  
> - ChairController  
> - PowerSupply  
> Instantiate a concrete configuration `MoveWellChair` assigning realistic values.

---

### 3️⃣ Component Definition Prompts
> **Prompt:**  
> Create detailed SysML v2 part definitions:  
> - `PressureSensor` with sensitivity and samplingRate  
> - `VibrationActuator` with voltage and vibrationLevel  
> - `LinearActuator` with stroke and force  
> - `ChairController` with processorSpeed and memory  
> - `PowerSupply` with voltage/current capacity  
> Add interface ports for data and power.

---

### 4️⃣ Ergonomic and Design Modeling
> **Prompt:**  
> Define `part def ChairDesign` with:  
> - hasLumbarSupport : Boolean  
> - hasFoamPadding : Boolean  
> - color : String  
> - adjustableBackAngle : Boolean  
> - usbPowered : Boolean  
> Instantiate it inside `MoveWellChair` to express color and ergonomic style.

---

### 5️⃣ Behavioral State Definition
> **Prompt:**  
> Add `state def 'Chair States'` with states `idle`, `sitting`, `alert`, `verticalLock`, `reset`.  
> Define transitions:
> - idle → sitting when userPresent  
> - sitting → alert after 60 min  
> - alert → verticalLock after 5 s  
> - verticalLock → reset after 5 min  
> - reset → idle when user returns  

---

### 6️⃣ Function Allocation
> **Prompt:**  
> Map logical behaviors to physical components using:
> ```
> allocation def 'FunctionRealization' {
>   allocate 'Monitor Sitting Time' to seatSensor;
>   allocate 'Alert User' to vibrationMotor;
>   allocate 'Enforce Standing Period' to seatMotor;
>   allocate 'Reset Chair State' to seatMotor;
>   allocate 'Process Timer' to controlUnit;
>   allocate 'Provide Power' to powerModule;
> }
> ```

---





### 🔚 Concept Model Goal
> Capture the conceptual structure, design, and behavior of the MoveWell Smart Chair, establishing a foundation for physical implementation.

---

## ⚙️ PART II — PROOF-OF-CONCEPT MODEL PROMPTS

### 1️⃣ Real-World Hardware Integration
> **Prompt:**  
> Extend the SysML v2 package `'MoveWellSmartChair_POC'` with real components:
> - Interlink FSR402 Pressure Sensor  
> - Precision Microdrives 307-100 Vibration Motor  
> - Firgelli FA-35-S-12-4 Linear Actuator  
> - Espressif ESP32 DevKit V1 Controller  
> - NVIDIA Jetson Xavier NX AI Module  
> - Anker PowerCore PD 26800 Power Bank  
> - Samsung Flip 2 Display  

---

### 2️⃣ Component Attribute Population
> **Prompt:**  
> Assign realistic values to each component:  
> - PressureSensor.sensitivity = 0.5 N  
> - VibrationActuator.voltage = 5 V, current = 150 mA  
> - LinearActuator.maxStroke = 40 mm  
> - ChairController.processorSpeed = 240 MHz  
> - PowerSupply.voltage = 5 V, current = 2 A  

---

### 3️⃣ Proof-of-Concept Structure
> **Prompt:**  
> Create:
> ```
> part MoveWellChair_POC : SmartChair {
>   part seatSensor : PressureSensor = InterlinkFSR402;
>   part vibrationMotor : VibrationActuator = Microdrives307_100;
>   part seatMotor : LinearActuator = FirgelliFA35S124;
>   part controlUnit : ChairController = ESP32_DevKitV1;
>   part aiProcessor : AI_Module = JetsonXavierNX;
>   part displayUnit : DisplayDevice = SamsungFlip2;
>   part powerModule : PowerSupply = AnkerPowerCorePD26800;
> }
> ```

---

### 4️⃣ Software / Hardware Linkage
> **Prompt:**  
> Define data ports:
> - Sensor → Controller (via I²C / ADC)  
> - Controller → Actuators (PWM outputs)  
> - Controller ↔ AI_Module (Wi-Fi / UART)  
> - AI_Module → Display (HDMI / wireless cast)  

---

### 5️⃣ Power and Connectivity Mapping
> **Prompt:**  
> Express power flow using `flow def PowerFlow` connecting PowerSupply → Controller → Actuators.  
> Include USB-C connector attributes and energy budget constraints.

---

### 6️⃣ Realistic Simulation and Test Plan
> **Prompt:**  
> Create parameter blocks for quick bench test:  
> - Duration threshold = 60 min  
> - Alert vibration intensity = 2 g  
> - Lock angle = 15 degrees  
> - Power budget ≤ 25 W  

---

### 7️⃣ Verification and Traceability
> **Prompt:**  
> Define requirement links:  
> - Req 001: Detect sitting > 60 min  
> - Req 002: Trigger vibration alert  
> - Req 003: Tilt seat after alert  
> - Req 004: Reset after user absence  


---

### 🔚 POC Model Goal
> Demonstrate technical feasibility of the MoveWell Smart Chair using commercially available components.  
> Provide traceability between conceptual model elements and real hardware implementation.

---

## ✅ Usage
Use **Part I** prompts to define the conceptual SysML v2 architecture.  
Use **Part II** prompts to develop and document the proof-of-concept model with real-world components.
