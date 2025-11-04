# 🧩 PetCaringSystem Model Documentation

## 🧠 Overview

The **PetCaringSystem** model represents a **conceptual system architecture** for an automated pet feeding solution that ensures pets are properly cared for even when their owners are away for work or travel.  
It was created using **SysML v2** to formalize the system’s structure, behavior, and interaction between actors (Owner and Pet) and subsystems (FeedingSystem and SmartFeeder).  

This model captures both **physical components** (like the hopper, dispenser, and power source) and **logical behavior** (feeding control, scheduling, and status updates). It also defines key **requirements** ensuring reliability, remote accessibility, and power continuity.  

The system design aims to balance **user convenience**, **pet well-being**, and **technical feasibility**—serving as a foundation for downstream development of prototypes, simulations, and system validation activities.

---

## 🎯 Goal of the Model

The primary goal of this SysML model is to:
1. **Define a clear system boundary** between human, pet, and technology interactions.  
2. **Model the structural composition** of the automated feeder (SmartFeeder) to understand how hardware and control logic interact.  
3. **Specify functional behavior** (dispensing action) and the data flow between system parts (food, power, commands, and status).  
4. **Trace system requirements** to design elements, ensuring the system meets reliability, remote operation, and power resilience criteria.  
5. **Support system-level reasoning and validation**, providing a reference for simulation, proof-of-concept (PoC), or MVP design (e.g., FeedSmart prototype).

---

## ⚙️ Usage and Application

This SysML model is used for:

### 1. Conceptual System Design
Defines the architecture and boundaries of the **automated feeding system**, helping designers and engineers understand component responsibilities and interactions early in the lifecycle.

### 2. Requirements Traceability
Connects design elements (like SmartFeeder and FeedingSystem) to system-level requirements such as:
- *ReliableFeeding*: Timely and accurate dispensing  
- *RemoteControl*: Remote triggering via an app  
- *PowerContinuity*: Continued operation under power loss  

These traceability links ensure each requirement has a design representation.

### 3. System Validation & Communication
Acts as a **communication artifact** between UX designers, system engineers, and hardware developers—clarifying how physical components (hopper, dispenser, controller) interact with digital controls (commands, status updates).

### 4. Foundation for Proof-of-Concept (PoC)
Serves as the **conceptual foundation** for the **FeedSmart PoC system**, which expands on this model by integrating wireless connectivity, cloud synchronization, and a user-facing mobile app.

### 5. Simulation or System Behavior Testing
Through the defined `DispenseFood` action, system behavior (e.g., schedule validation, food release accuracy) can be simulated or tested against requirements.

---

## 🧩 Model Structure Summary

| **Category** | **Element** | **Purpose / Description** |
|---------------|--------------|-----------------------------|
| **Actors** | `Owner`, `Pet` | Represent external human and animal entities interacting with the system. |
| **Main System** | `FeedingSystem` | Core logical boundary of the pet feeding operation. |
| **Subsystem** | `SmartFeeder` | Physical implementation containing hopper, dispenser, controller, and power input. |
| **Behavior** | `DispenseFood` | Defines how food is dispensed when triggered manually or via schedule. |
| **Ports** | `FoodPort`, `PowerPort`, `CommandPort`, `StatusPort` | Define interfaces for data, control, and energy flow. |
| **Requirements** | `ReliableFeeding`, `RemoteControl`, `PowerContinuity` | Ensure operational reliability, remote functionality, and uninterrupted power. |
| **Context Diagram** | `context` | Shows interactions among `Owner`, `Pet`, and `FeedingSystem` through commands, status, and food flow. |

---

## 🧭 Design Insights

- The **SmartFeeder** part encapsulates mechanical and electronic subsystems, providing modularity for future upgrades (e.g., adding sensors, wireless modules).  
- **Ports** abstract data and energy exchanges, allowing for clear simulation and extension in later models.  
- The **DispenseFood** action formalizes the operational logic, connecting the control unit’s behavior with system-level requirements.  
- Requirements like *RemoteControl* foreshadow integration with mobile or IoT systems, aligning with later PoC implementations.  
- The **context connections** visually demonstrate the end-to-end interaction loop between the Owner (commands), Feeder (execution), and Pet (consumption).

---

## ✅ Summary

This SysML model of the **PetCaringSystem** establishes a structured and traceable foundation for automated pet feeding design.  
It bridges high-level conceptual understanding and detailed design elements, enabling teams to reason about functionality, ensure requirement satisfaction, and evolve toward real-world implementation (e.g., FeedSmart PoC).  

By maintaining this model as a living document, future iterations (e.g., smart sensors, mobile connectivity, or AI feeding optimization) can be seamlessly integrated into the system architecture while preserving design clarity.
