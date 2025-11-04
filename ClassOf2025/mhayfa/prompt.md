# Prompt Log for Conceptual and PoC Modeling

This file records the key prompts used during the development of both the conceptual system model and the proof-of-concept (PoC) model. These entries provide traceability of the modeling decisions and serve as documentation of the rationale behind the architecture.

## Conceptual Model Prompts

### Goal Definition

* "Create a system that connects elderly users to family members and volunteers using a wearable device and a cross-platform application."

### User Roles and Devices

* "Define roles for Elderly, FamilyMember, and Volunteer and connect them via App and Website."
* "Include a server and AI service to support backend operations and asynchronous AI assistance."

### Context and Interactions

* "Connect the wearable to the app via Bluetooth."
* "Structure user access via authentication and UI context routing."

## PoC Model Prompts

### Wearable System Definition

* "Create a PoC_Wearable that refines the conceptual Wearable. Include modules for camera, audio, power, and enclosure."
* "Define part definitions for each submodule, with ports and key actions."
* "Use attributes to represent brand, model, and specifications."

### AI Integration

* "Add an on-device AI module to the wearable to handle real-time image processing."
* "Connect the camera's media output to the AI's data input. Connect the AI's output to Bluetooth."

### Interconnections and Mounts

* "Map internal connections such as camera power, mounts between modules, and Bluetooth/data links to the app."
* "Clarify that the Enclosure mounts onto generic glasses frames without defining them explicitly."

### System Integration

* "Create a PoCSystem package with parts for App, Server, Website, and AIService."
* "Model bi-directional communication paths between all system-level parts."

## Modeling Rationale

* Emphasized traceability from conceptual abstractions to implementation details.
* Used modular part definitions to simulate real-world device composition.
* Refined interface and power models to reflect realistic data and energy flow.
* Added user context and AI integration based on evolving assistive feature requirements.

---

This file documents the iterative nature of the system design and supports future auditing, evolution, or re-use of the PoC and conceptual models.
