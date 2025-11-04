# 🚀 Proof-of-Concept (POC) Documentation

The purpose of this Proof-of-Concept (PoC) is to validate the interoperability and feasibility of integrating the main IT tools defined in the conceptual SysML v2 model — namely, the **CAD**, **PLM**, and **ERP** systems.  
This PoC demonstrates how conceptual architectural elements (abstract system parts and data flows) can be realized using **commercial off-the-shelf (COTS) software solutions** or lightweight open-source tools.  
It was created to compare different levels of technological maturity, flexibility, and cost efficiency, and to provide traceability between the conceptual model and its practical implementations.  

---

## 🧩 Conceptual–Implementation Traceability Table

| **Conceptual Model Element** | **POC Model Element** | **Transformation & Implementation Insight** |
|-------------------------------|------------------------|---------------------------------------------|
| **CAD_Creo** (Conceptual CAD system producing 3D models) | **PTC Creo** *(Option A)*<br>**CATIA V6** *(Option B)*<br>**FreeCAD 0.22** *(Option C)* | Each CAD element from the conceptual model was mapped to an actual design tool. Creo and CATIA maintain industrial-grade integration with PLM systems; FreeCAD was chosen as a lightweight open-source equivalent for quick testing. Minor simplifications were made to focus on model export and version tracking only. |
| **PLM_Windchill** (Product Lifecycle Management system) | **PTC Windchill 13** *(Option A)*<br>**Siemens Teamcenter X** *(Option B)*<br>**Aras Innovator 30R2** *(Option C)* | The conceptual PLM was instantiated using different market tools to explore integration strategies. Windchill was directly aligned with Creo (native connector), Teamcenter was interfaced with CATIA using STEP/JT formats, and Aras Innovator was used to test open API-based workflows. Lifecycle attributes were retained but simplified for PoC validation. |
| **ERP_SAP** (Enterprise Resource Planning system) | **SAP S/4HANA 2023** *(Option A)*<br>**Oracle NetSuite Cloud ERP 2025** *(Option B)*<br>**Microsoft Dynamics 365 Business Central 2025** *(Option C)* | The conceptual ERP system was represented by leading ERP platforms with varying complexity. Data exchanges (mainly BOM and production rate) were implemented through standardized interfaces: certified PLM→ERP connectors for Option A, middleware REST/XML for Option B, and lightweight REST mapping for Option C. |
| **Information Flows** (`Model_3D`, `ProductBOM`) | **Data exchanges between CAD↔PLM↔ERP** | Conceptual information flows were operationalized as file transfers, API calls, or data model synchronization. For Option A, the integration relied on vendor connectors; Option B used standardized data exchange formats; Option C applied simplified REST endpoints and Python scripts for quick prototyping. |
| **LifecycleState** (data maturity enumeration) | **Simplified status tracking inside PLM tools** | The detailed SysML v2 lifecycle states (Conception, Review, Validated, Obsolete, Cancelled) were retained conceptually but mapped to available workflow states in each PLM solution. In the PoC, only *Draft → Released → Obsolete* were implemented to reduce configuration overhead. |

---

## 🧠 Summary

This PoC establishes a clear **traceability link** between the conceptual SysML v2 architecture and its real-world instantiations.  
It demonstrates that the defined information flows and system roles (CAD, PLM, ERP) can be effectively realized through multiple technology stacks — from industrial to open-source.  
The documentation ensures **design rationale and implementation transparency**, supporting future evaluation, integration testing, and prototype scaling.

---

## Comparative table

Below is a visual comparative table.


![Comparative Table of solutions](./comparative_table.png)
