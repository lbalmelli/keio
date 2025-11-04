# 🪑 MoveWell Smart Chair | Proof-of-Concept (POC) Documentation

## Overview

The **MoveWell Smart Chair Proof-of-Concept (POC)** was developed to validate the technical feasibility of the conceptual **SmartChair** system model.  
This POC demonstrates the integration of sensing, actuation, and control within an ergonomic seating system designed to monitor sitting duration, alert users to stand, and adjust posture automatically.  
It bridges the conceptual SysML v2 model and real-world hardware implementation, using commercially available components and lightweight embedded control software.  
The goal is to assess ergonomics, hardware responsiveness, and data communication pathways before full-scale prototype production.

---

## Concept-to-POC Transformation Table

| **Conceptual Model Element** | **POC Model Element** | **Transformation & Implementation Insight** |
|------------------------------|-----------------------|---------------------------------------------|
| **SmartChair (System)** | MoveWell Smart Chair Prototype | Implemented as an assembled ergonomic office chair with integrated electronics; retains overall system architecture (sensor–controller–actuator–power hierarchy). |
| **PressureSensor** | Interlink FSR402 Force Sensor | The conceptual “PressureSensor” is realized using **Interlink FSR402** to detect seating pressure and presence; analog output connected to ESP32 ADC input. |
| **VibrationActuator** | Precision Microdrives 307-100 Vibration Motor | Used to generate tactile feedback for user alerts; driven by PWM signal from ESP32 via MOSFET circuit. Simplified control from continuous to pulse-based pattern. |
| **LinearActuator** | Firgelli FA-35-S-12-4 Mini Linear Actuator | Provides mechanical seat tilt for posture enforcement; integrated through relay driver module. Stroke length and force adjusted to suit ergonomic tilt angle. |
| **ChairController** | Espressif ESP32 DevKit V1 | Central microcontroller replacing conceptual control unit; handles sensor reading, timing, and Bluetooth communication; programmed via Arduino framework. |
| **AI_Module (Conceptual Extension)** | NVIDIA Jetson Xavier NX | Edge AI unit processes posture analytics and sends visualization data to connected display; communicates with ESP32 through serial-over-USB link. |
| **PowerSupply** | Anker PowerCore PD 26800 Power Bank | Provides mobile 5V/9V USB-C power delivery to the ESP32 and actuators; battery-based implementation replaces fixed wired source for portability. |
| **DisplayDevice** | Samsung Flip 2 Interactive Display | Acts as visualization interface for posture data and sitting duration analytics; receives input from Jetson NX dashboard via Wi-Fi streaming. |
| **ChairDesign (Ergonomics)** | Black & Silver Ergonomic Chair Frame | Physical chair with foam padding and aluminum frame, matching conceptual attributes (`color`, `hasFoamPadding`, `adjustableBackAngle`). |
| **Sensor–Controller Interface** | I²C / ADC Wiring Harness | Conceptual data port realized using direct analog inputs and I²C communication between sensors and ESP32. Compact wiring harness designed for modular testing. |
| **Controller–Actuator Interface** | PWM and Relay Control Lines | Logical control signals mapped to PWM (vibration) and relay-switched DC lines (linear actuator). Simplified from full digital bus for quick bench testing. |
| **Controller–Display Interface** | Wi-Fi (MQTT over TCP/IP) | Replaces conceptual appSyncPort with real wireless communication, enabling posture data upload to Jetson NX and visualization on Samsung Flip 2. |
| **Power Distribution Network** | USB-C Multi-Port Splitter | Consolidated all 5V power needs into one mobile battery output; reduced complexity and improved cable management for testing environment. |
| **System Integration** | Breadboard & 3D-Printed Mounting Panel | Conceptual integration realized as a compact electronics baseplate mounted under chair; allows rapid iteration and safety testing. |

---

## Implementation Summary

- **Hardware Integration:** Fully modular using off-the-shelf sensors, actuators, and controllers.  
- **Software Stack:** ESP32 (C++ firmware) for timing control; Jetson NX (Python-based) for AI inference and visualization.  
- **Power Management:** Battery-powered system enabling mobility and cable-free operation.  
- **Communication:** Wi-Fi and USB serial for data exchange between microcontroller and AI processor.  
- **Testing Goals:** Validate alert timing, actuation accuracy, and system responsiveness under varied user conditions.  

---

## Future Refinement

The next iteration will integrate:
- A unified PCB design to replace breadboard prototyping.  
- BLE-based mobile app connection.  
- Enhanced AI analytics for adaptive posture prediction.  
- Parametric optimization via SysML v2 constraint modeling.

---

> **Note:**  
> This POC implementation serves as a traceable bridge between the SysML v2 conceptual model and real-world hardware testing, following a model-based systems engineering (MBSE) workflow.


  
