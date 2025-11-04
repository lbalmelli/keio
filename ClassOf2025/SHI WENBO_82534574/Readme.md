# **Green Resilience Station (GRS): Disaster-Resilient Solar Energy Billboard System**

---

## **Table of Contents**
1. [Problem Statement](#problem-statement)
2. [Usage / Service Scenarios](#usage--service-scenarios)
   - [Scenario 1 – Normal Operation: Smart Advertising and Energy Generation](#scenario-1--normal-operation-smart-advertising-and-energy-generation)
   - [Scenario 2 – Disaster Response Mode: Emergency Power and Communication Hub](#scenario-2--disaster-response-mode-emergency-power-and-communication-hub)
   - [Scenario 3 – Post-Disaster Recovery and Monitoring](#scenario-3--post-disaster-recovery-and-monitoring)
3. [Customer Struggles and Insights](#customer-struggles-and-insights)
4. [Appendix – SysML Model (MVM) Overview](#appendix--sysml-model-mvm-overview)

---

## **Problem Statement**

**Who (Customer/Actor):**  
Governments, advertising companies, disaster response agencies, and urban citizens.

**What (Problem/Struggle):**  
Current outdoor advertising systems lack resilience and multifunctionality. Traditional billboards cannot dynamically update content; electronic billboards consume large amounts of electricity and rely on fragile centralized power grids. During disasters, they fail to serve as emergency communication tools (e.g., broadcasting or public alerts) and cannot provide local power or communication support.

**Why (Need/Reason):**  
Urban environments face multiple challenges—energy instability, carbon reduction pressures, and frequent natural disasters. A distributed infrastructure capable of being self-sufficient in normal times and providing essential public services during emergencies is needed to enhance urban sustainability and resilience.

**Where/When (Context):**  
In high-density metropolitan areas—especially during earthquakes, typhoons, or power outages—outdoor advertising infrastructure must support both commercial communication and emergency public functions.

**Abstract Level:**  
At its core, the problem lies in the absence of a resilient urban-edge infrastructure system that integrates **energy autonomy, information dissemination, and disaster response**, rather than merely improving billboard design as a single-function product.

---

## **Usage / Service Scenarios**

### **Scenario 1 – Normal Operation: Smart Advertising and Energy Generation**

**Context:**  
In daily urban life, the Green Resilience Station (GRS) is installed along major roads or commercial districts.

**Steps:**
1. Advertising operators remotely update content through a cloud-based system.  
2. Solar panels generate electricity to power the display and lighting, with surplus energy stored in batteries.  
3. A real-time data interface displays carbon reduction metrics and local power generation status.

**Functional Dimension:**  
Enables energy self-sufficiency, intelligent advertising, and data visualization.  
**Emotional Dimension:**  
Advertisers gain a green brand image; citizens experience visible sustainable technology.  
**Social Dimension:**  
Reinforces the city’s “green identity” and supports carbon neutrality policies.

---

### **Scenario 2 – Disaster Response Mode: Emergency Power and Communication Hub**

**Context:**  
An earthquake or typhoon disrupts the city’s main power grid.

**Steps:**
1. The system automatically switches to emergency mode upon detecting a grid failure.  
2. Advertising functions are disabled, and the station provides free Wi-Fi, radio broadcasting, and emergency charging.  
3. Stored battery power supplies electricity to critical communication devices and local residents.

**Functional Dimension:**  
Ensures energy and communication continuity, serving as a micro energy node.  
**Emotional Dimension:**  
Residents feel safety and trust; the billboard becomes a “lifeline hub” in the community.  
**Social Dimension:**  
Strengthens community cohesion and public confidence, enhancing coordinated disaster response.

---

### **Scenario 3 – Post-Disaster Recovery and Monitoring**

**Context:**  
In the post-disaster recovery phase, as the main grid is being restored.

**Steps:**
1. The system returns to normal operation while uploading power and usage data to the city’s energy cloud.  
2. It analyzes energy flow and communication load during the disaster to inform future resilience planning.

**Functional Dimension:**  
Supports data-driven resilience analysis and infrastructure optimization.  
**Emotional Dimension:**  
Citizens and administrators perceive tangible value in sustainable innovation.  
**Social Dimension:**  
Transforms urban infrastructure from purely functional to service-oriented and regenerative.

---

## **Customer Struggles and Insights**

### **Customer Struggles (Current Challenges)**

* **Energy Fragility:** Existing billboards rely entirely on the main grid and fail during power outages.  
* **Lack of Emergency Functionality:** They cannot support public needs such as power and communication during disasters.  
* **Low Updating Efficiency:** Traditional advertisements are costly and time-consuming to replace.  
* **Limited Social Value:** Current systems serve commercial interests only, offering no public or sustainable contribution.

### **Unmet Needs / Innovation Signals**

* Cities require **renewable, autonomous, and intelligent** public infrastructure.  
* Citizens need **reliable micro energy and communication nodes** during disasters.  
* Governments and businesses seek **infrastructure models combining economic return and social value**.

### **Key Insight Statements**

1. **Resilience as Infrastructure Value:** The value of infrastructure must include continuity under extreme conditions.  
2. **Dual-Mode Utility:** Integrating commercial and public functions increases the social return of infrastructure investments.  
3. **Data-Driven Sustainability:** Real-time carbon and energy data enable citizen engagement in sustainability efforts.  
4. **Decentralized Preparedness:** Embedding disaster-response capabilities in distributed urban nodes reduces systemic citywide risk.

---

**Summary:**  
The *Green Resilience Station (GRS)* addresses the structural gap between **energy resilience, public safety, and carbon neutrality** in modern cities.  
By bridging **economic functionality in normal times** and **public service capability during crises**,  
GRS represents a model of **adaptive, sustainable, and resilient urban infrastructure co-evolution**.

---

## **Appendix – SysML Model (MVM) Overview**

### **1. Current Model Structure**

The **Green Resilience Station (GRS) – MVM (Model Verification Model)** is organized as follows:
```text
package 'Green Resilience Station (GRS) - MVM'
├── Requirements
│ ├── EnergyAutonomyRequirement
│ ├── EmergencyPowerAvailability
│ └── CommunicationContinuity
│
├── Structure
│ ├── SolarPanel, Battery, DisplayUnit, CommunicationModule
│ ├── PowerController
│ └── GreenResilienceStation (integrated system)
│
├── Behavior
│ └── GRS Operational States (NormalOperation / EmergencyMode)
│
└── Verification
├── EnergyFeasibilityTest
└── BackupDurationTest