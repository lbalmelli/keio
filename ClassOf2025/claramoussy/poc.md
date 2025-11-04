# Proof of Concept (POC) — Folding Seat Metro System  

---

## Purpose of the Proof of Concept

The purpose of this Proof of Concept (POC) is to demonstrate how the **conceptual model** of the Folding Seat Metro System can be translated into a **functional and partially realizable design**.  
It validates the feasibility of the system’s key principles — namely, the interaction between **mechanical folding mechanisms**, **logical control**, and **sensor feedback** — within the operational constraints of a metro environment.  

The POC focuses on verifying:
- The **integration** between mechanical and logical parts (controller and sensors),  
- The **feasibility** of real-time seat deployment and folding under safe conditions,  
- The **traceability** from conceptual model elements to their implementation equivalents.  

This POC serves both as a validation of the model’s structure and as a foundation for a future prototype or testing platform.

---

## Component Selection Comparison Table

The following table summarizes the selection process for each major physical component of the folding seat.  
Three realistic options were compared based on market availability, reliability, cost, and suitability for metro integration.  
Each component’s **pros**, **cons**, and **final design choice** are justified to ensure a coherent mechanical assembly.

| **Component** | **Option 1** | **Option 2** | **Option 3** | **Pros & Cons Summary** | **Final Choice** |
|----------------|--------------|--------------|--------------|--------------------------|------------------|
| **Ceiling Mount** | Stainless steel bracket | Aluminum frame mount | Composite reinforced base | **Pros:** Excellent load resistance (steel); lightweight (aluminum). **Cons:** Steel is heavier; composite less rigid. | **Stainless steel bracket** — provides maximum strength and vibration stability. |
| **Telescopic Arm** | Pneumatic actuator | Gas spring arm | Motorized linear actuator | **Pros:** Gas spring offers silent motion; motorized version allows precision. **Cons:** Pneumatic requires maintenance; motorized increases weight and cost. | **Gas spring arm** — reliable, silent, no power dependency. |
| **Seat Unit** | Foldable ABS shell | Aluminum folding seat | Polycarbonate injection seat | **Pros:** ABS is durable and lightweight; aluminum is aesthetic but heavier. **Cons:** Polycarbonate less comfortable. | **Foldable ABS shell** — balanced solution with comfort and durability. |
| **Handle** | Integrated aluminum handle | Plastic ergonomic handle | Retractable stainless handle | **Pros:** Plastic ergonomic is light and easy to clean; aluminum more solid. **Cons:** Stainless too heavy. | **Plastic ergonomic handle** — best user comfort and maintainability. |
| **Seat Timer** | Optical infrared sensor | Ultrasonic presence sensor | Pressure seat sensor | **Pros:** Pressure sensor directly detects user presence; optical simple to integrate. **Cons:** Ultrasonic less stable in closed space. | **Pressure seat sensor** — robust, reliable, and inexpensive. |

---

## Conceptual-to-POC Traceability Table

This table ensures traceability between the conceptual system model and its proof-of-concept realization.  
It shows how each abstract SysML element was implemented or simulated in the POC.

| **Conceptual Model Element** | **POC Model Element** | **Transformation & Implementation Insight** |
|-------------------------------|------------------------|---------------------------------------------|
| **Seat (FoldingSeat)** | Folding seat prototype with gas-spring mechanism and ABS shell | The abstract seat concept was physically implemented using a gas spring and ABS seat surface. The folding motion was preserved with realistic angles and locking positions. |
| **CeilingMount** | Stainless-steel mounting bracket | Replaced the conceptual mount with a stainless bracket to ensure vibration resistance and long-term stability. Mounted directly to metro ceiling structure. |
| **TelescopicArm** | Gas-spring telescopic actuator | The conceptual arm was implemented as a mechanical gas spring for silent deployment and smooth movement without electrical control. |
| **SeatUnit (presence sensor + fold button)** | ABS seat shell with integrated pressure sensor and push button | The conceptual seat unit became a physical seat shell including a pressure sensor for presence detection and a folding button for manual override. |
| **Handle (deploy button)** | Plastic ergonomic handle with integrated button | The conceptual handle was realized as a molded ergonomic handle with a built-in low-resistance button. |
| **SeatTimer** | Embedded software timer (microcontroller-based) | The conceptual timer was implemented as a simple counter in the controller, tracking seat inactivity. |
| **CrowdSensor** | Infrared occupancy sensor module | The conceptual crowd sensor was modeled as an IR module providing binary outputs (`CROWDED` / `NOT_CROWDED`). |
| **Controller** | Arduino microcontroller running seat logic | Implemented control logic using software to process all sensor inputs and send deployment commands according to SysML transitions. |
| **User** | Simulated user input via button press | The “User” was represented physically by a button connected to the controller, simulating user requests. |
| **System Connections** | Electrical wiring and logical signal routing | Conceptual “connect” links were implemented as physical wiring and logical data routing between modules. |

---

## Summary of Implementation Insights

The POC implementation confirmed that all conceptual model elements could be **realistically represented** using accessible components and logical simulations.  
The seat’s mechanical system and electronic logic interacted successfully through well-defined SysML connections.  

Key results include:
- **Reliable folding/deployment** via gas-spring telescopic arm.  
- **Accurate crowd and presence detection** enabling conditional control.  
- **Logical controller coordination** that mirrors the conceptual SysML behavior.  
- **Modularity and scalability** allowing future upgrades or prototype extension.  

This POC demonstrates a complete and traceable realization of the Folding Seat Metro System, linking **conceptual design**, **mechanical engineering**, and **logical control** in a cohesive framework.

---

