# 🧩 FeedSmart Proof-of-Concept (PoC) Model Documentation

## 🎯 Purpose of the Proof-of-Concept

The **FeedSmart Proof-of-Concept (PoC)** was developed as a tangible prototype to validate the functional, technical, and user-interaction feasibility of the automated feeding system derived from the conceptual **Pet Caring System** model.  
This PoC demonstrates how a real-world implementation can embody the conceptual system’s design intent, verifying the integration between hardware components, embedded control logic, and remote communication.  

Specifically, it shows how an **ESP32-based SmartFeeder** communicates with a **MobileApp** via **Wi-Fi or Bluetooth**, logs feeding data through a **DataTrackingModule**, and synchronizes information to a **CloudDatabase**.  
This allows pet owners to monitor and control feeding remotely while ensuring local reliability and scalability for future MVP versions.

---

## 🔗 Conceptual Model to PoC Implementation Mapping

| **Conceptual Model Element** | **POC Model Element** | **Transformation & Implementation Insight** |
|------------------------------|-----------------------|---------------------------------------------|
| **FoodHopper** | 3D-printed or acrylic container | Simplified from the conceptual hopper into a compact, low-capacity food container with a gravity feed outlet. Designed for easy refilling and visual level inspection. |
| **DispenserMechanism** | Servo-driven mechanism (SG90 servo) | Implemented using a single micro servo motor controlled by ESP32 GPIOs to release food portions on schedule or manual trigger. Simplified actuation logic for PoC reliability. |
| **FeedingBowl** | Stainless-steel detachable bowl | Designed as a washable and removable component to validate hygiene and usability. Positioned directly under dispenser outlet for accurate food delivery. |
| **ControlUnit** | ESP32 firmware controller | Embedded software executing manual and scheduled commands, processing sensor input, and coordinating motor actuation. Replaces abstract control logic from the conceptual model. |
| **MotorUnit** | SG90 servo assembly | Realized as a single servo motor powered via 5V rail. Simplified from multiple motion elements to reduce cost and test control precision. |
| **SensorModule** | IR sensor module | Basic infrared proximity sensor detects food presence and bowl fill level. Future versions may include weight sensors for accuracy improvement. |
| **PowerUnit** | 5V USB DC adapter | Supplies power to ESP32, motor, and sensors. No power monitoring in PoC; included for completeness in energy flow validation. |
| **CommunicationModule** | ESP32 built-in Wi-Fi/Bluetooth radio | Provides wireless connection between feeder, app, and cloud. Operates in AP (local control) or STA (cloud sync) mode. Defines explicit WirelessPort for network data exchange. |
| **DataTrackingModule** | SPIFFS-based local log & Cloud sync | Stores timestamps and feeding data locally. Syncs with Firebase/Supabase test instance for remote access. Demonstrates data persistence and telemetry proof. |
| **CloudDatabase** | Firebase / Supabase | Manages feeding history and schedules via REST or MQTT protocol. Enables multi-device access and data redundancy for long-term monitoring. |
| **MobileApp** | Local Web UI / Cloud-linked mobile interface | Connects to SmartFeeder via Wi-Fi or Bluetooth. Displays feeder status, feeding logs, and allows remote control. Serves as both UX prototype and functional control surface. |
| **Wireless Connectivity** | WirelessPort (Wi-Fi/Bluetooth interface) | Newly added in PoC model to explicitly represent wireless link between feeder and app. Models both local (AP) and cloud-connected (STA) modes for flexible communication. |
| **Owner (Actor)** | End-user mobile device interface | Represents the human actor using the mobile app to send feed commands, schedule feedings, and review logs. Used to validate interaction experience. |
| **Pet (Actor)** | Test object / Real pet | Represents the physical consumer of food output, validating the timing, portioning, and responsiveness of the system. |

---

## 🧠 Implementation Insights

- The PoC model validates **end-to-end connectivity** between SmartFeeder, MobileApp, and CloudDatabase through Wi-Fi and optional Bluetooth channels.  
- The system demonstrates **data traceability** and **command-feedback loops** using explicit port connections (`commandOut`, `statusIn`, `dataIn`).  
- The **ESP32 microcontroller** serves as a combined ControlUnit and CommunicationModule, showcasing hardware simplification and integration efficiency.  
- The **WirelessPort** was explicitly added in the SysML PoC model to show how the feeder communicates bidirectionally with the MobileApp.  
- Power and food flow were modeled to maintain **physical system completeness** and confirm all resource dependencies.  
- The design ensures **scalability for MVP**, where sensors, data logging, and analytics can be expanded without altering the system’s foundational architecture.

---

## ✅ Summary

This FeedSmart PoC bridges the conceptual and physical domains by implementing a minimal yet complete system that verifies real-world feasibility.  
It proves that a single embedded controller can manage feeding automation, sensor feedback, and wireless communication while maintaining clean architectural traceability from concept to prototype.
