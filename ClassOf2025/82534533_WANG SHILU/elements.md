# element_table.md

## EZkanji Chrome Extension Concept – Element Table

This document summarizes the major elements defined in the **conceptual model** and **proof-of-concept (PoC)** model of the EZkanji Chrome Extension system.  
The **Conceptual Layer** focuses on the logical and functional structure of the system, while the **PoC Layer** captures the practical implementation elements used for prototype validation.

---

## 1. Conceptual Layer Elements

| Element | Type | Description | Key Relationships |
|----------|------|--------------|--------------------|
| **ChromeExtensionConcept** | Concept Block | Represents the overall idea of an intelligent Japanese Kanji learning assistant implemented as a Chrome extension. | Composed of UI, LocalStorage, and SyncMechanism. |
| **User** | Actor | End user who interacts with the Chrome extension while browsing. | Initiates actions that trigger API requests and data synchronization. |
| **KanjiAPI** | External Block | External service providing Kanji information such as meanings, examples, and readings. | Connected to SyncMechanism via API_Handler. |
| **SyncMechanism** | Function | Defines the process of synchronizing user activity data between LocalStorage and the external API. | Bridges KanjiAPI and LocalStorage. |
| **LocalStorage** | Block | Handles local caching of user progress and Kanji data for offline availability. | Interacts with SyncMechanism and PoC StorageAdapter. |

### 💬 Explanation
The **Conceptual Layer** abstracts the key entities and their interactions in the EZkanji system.  
It does not depend on implementation technologies, focusing instead on **data flow, role definition, and service structure**.  
The relationships capture the logical dependencies among these parts — especially how the system maintains **continuity of learning data** across browsing sessions.

---

## 2. PoC Layer Elements

| Element | Type | Description | Key Relationships |
|----------|------|--------------|--------------------|
| **PoC_UI** | Component | A minimal user interface prototype that overlays Kanji hints and information on webpages. | Interfaces directly with User actions. |
| **API_Handler** | Script | JavaScript function managing API calls to fetch Kanji data. | Communicates with KanjiAPI and passes data to StorageAdapter. |
| **StorageAdapter** | Function | Prototype function handling data synchronization between the local cache and API results. | Operates under SyncMechanism in PoC implementation. |

### 💬 Explanation
The **PoC Layer** focuses on **technical feasibility** — verifying whether the conceptual interactions can be achieved with real browser APIs.  
These elements were implemented in a lightweight prototype to confirm the **data retrieval, storage, and synchronization logic**.  
They map directly to conceptual components (e.g., PoC_UI ↔ UI layer, StorageAdapter ↔ LocalStorage).

---

## 3. Notes

- **Conceptual Model**: defines “what the system is” (logical structure).  
- **PoC Model**: explores “how it can be realized” (technical prototype).  
- The table ensures traceability between both layers, supporting model evolution from idea → prototype → implementation.  

---