# README.md

## EZkanji Chrome Extension — SysML v2 Modeling Project

This repository contains the complete set of documentation, models, and media files for the **EZkanji Chrome Extension** project.  
It demonstrates conceptual and proof-of-concept (PoC) modeling using **SysML v2**, supported by design reasoning and prototype validation materials.

---

## 📁 File Overview

### 🧩 Model Files

#### `EZkanji Concept Model.sysml`
- The **conceptual-level SysML model** describing the logical structure of the EZkanji system.  
- Defines main elements such as `ChromeExtensionConcept`, `User`, `KanjiAPI`, `LocalStorage`, and `SyncMechanism`.  
- Focus: *What the system is* and *how its components conceptually interact.*

#### `EZkanji Proof-of-Concept System.sysml`
- The **PoC-level SysML model** focusing on implementation validation.  
- Includes components such as `PoC_UI`, `API_Handler`, and `StorageAdapter`.  
- Focus: *How the conceptual logic can be realized technically.*

---

### 📝 Documentation Files

#### `model.md`
- Main document explaining the conceptual design.
- **Structure:**
  - Goal of the Concept  
  - Approach to Concept Creation  
  - List of Main Components  
  - Draft Plan for Implementation  
- Includes a Markdown image command linking to `model.png`.

#### `elements.md`
- Structural summary table for both **Conceptual** and **PoC** layers.
- Lists each element, its type, description, and key relationships.
- Provides a concise cross-reference between SysML elements and documentation.

#### `prompt.md`
- Design and reasoning log.
- Chronicles the **modeling process**, including idea drafts, reasoning, AI-assisted iterations, and design revisions.
- Reflects the evolution from conceptual modeling to PoC verification.

#### `poc.md`
- Supplementary description for the **Proof-of-Concept** phase.
- Focuses on technical feasibility, prototype outcomes, and alignment with conceptual definitions.
- References the PoC system diagram `poc.png`.

---

### 🖼️ Visuals

#### `model.png`
- Diagram visualizing the **conceptual model structure** and main relationships between system elements.

#### `poc.png`
- Diagram visualizing the **PoC model structure** and technical workflow used for prototype testing.

---

### 🎥 Prototype Media

#### `prototype.mp4`
- Short video demonstration of the working prototype.
- Shows real browser interactions and how the EZkanji extension integrates the designed components.

---

## 🔗 Relationships Between Files

```text
EZkanji Concept Model.sysml  → Conceptual structure (model basis)
EZkanji Proof-of-Concept System.sysml → Prototype-level system

model.md     → Concept explanation
elements.md  → Model structure summary
prompt.md    → Design reasoning log
poc.md       → Proof-of-concept documentation
model.png    → Concept model diagram
poc.png      → PoC system diagram
prototype.mp4 → Visual demonstration
