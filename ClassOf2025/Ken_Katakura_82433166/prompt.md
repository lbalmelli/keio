# 🧠 prompt.md — Fermentation Monitoring System
_Last updated: 2025-11-04 (JST)_  
_Ken Katakura_  
_82433166_

## Record of the Model Development Process

This document records the process of developing the **Sansho-zuke Fermentation Monitoring System** using **SysML v2**.  
As both the artisan and the founder of the project, I advanced the modeling work through three major stages:  
**Step 1: Problem Structuring → Step 2: Concept Modeling → Step 3: Proof-of-Concept (PoC) Implementation.**  
The following sections summarize the key prompts I used and the reasoning behind each design decision.

---

## 🩵 Step 1: Problem Structuring
### 🎯 Goal  
To organize the real challenges that occur on the fermentation site and define the system’s purpose and requirements to be represented in SysML v2.

---

### 1-1. Extraction of On-Site Issues  
#### Goal: Clarify the practical problems based on firsthand craftsmanship experience and establish the modeling starting point.

**Key Prompts Used**
1. “Please design a way to manage the Sansho-zuke fermentation process with data rather than relying on intuition.”  
2. “Please consider a mechanism to quantitatively capture invisible fermentation states such as pH, temperature, and CO₂.”  
3. “Please organize a system concept that can reduce quality variation and improve reproducibility.”

---

### 1-2. Structuring the Requirement Hierarchy  
#### Goal: Organize requirements hierarchically according to ISO/IEC/IEEE 15288 as BMA → StRS → SyRS.

**Explanation based on ISO 15288**
- **Business or Mission Analysis (BMA):**  
  Defined business and operational problems such as variation in fermentation quality and lack of reproducibility.  
  → Clarified the goal of scientifically visualizing the process to stabilize Sansho-zuke production.  

- **Stakeholder Needs & Requirements (StRS):**  
  Organized the expectations and constraints of stakeholders—craftsmen, managers, executives, and customers.  
  → For example: “Monitor internal bottle conditions in real time,” “Keep implementation costs low.”  

- **System Requirements (SyRS):**  
  Defined specific functional, performance, interface, and quality requirements.  
  → For example: “Automatic sensing of temperature, pH, and CO₂,” “Slack notifications,” “Dashboard visualization.”  

**Key Prompts Used**
1. “Based on ISO 15288 BMA, please clarify the business problem of fermentation quality and define the purpose of systemization.”  
2. “Based on ISO 15288 StRS, please organize the expectations and constraints of artisans, managers, executives, and customers.”  
3. “Based on ISO 15288 SyRS, please summarize the system’s functional requirements for measurement, recording, visualization, and notification.”

---

### 1-3. Translating Problems into System Requirements  
#### Goal: Transform real-world challenges into system-level requirements usable in design.

**Key Prompts Used**
1. “Please identify the measurable factors in the fermentation process—pH, temperature, CO₂, and time.”  
2. “Please organize the system’s data structures, such as FermentationState and Alert.”  
3. “Please define evaluation indicators (KPIs) to assess reproducibility and quality stability.”

---

## 🩵 Step 2: Concept Modeling
### 🎯 Goal  
To design the overall architecture of the Fermentation Monitoring System in SysML v2 and represent the structure that reproduces artisans’ sensory judgments.

---

### 2-1. Defining the Model Framework  
#### Goal: Organize the system using six packages — Domain, Data, Ports, Parts, Behavior, and Context.

**Key Prompts Used**
1. “Please create a package called FermentationMonitoringConcept in SysML v2.”  
2. “Please structure it into six packages — Domain, Data, Ports, Parts, Behavior, and Context — and define the role of each.”  
3. “Please add comments so that the entire model can be easily understood and read consistently.”

---

### 2-2. Defining Domain Elements and Data Structures  
#### Goal: Formalize fermentation phenomena into measurable data elements.

**Key Prompts Used**
1. “Please define Temperature, Acidity_pH, CO₂Level, and Time as item defs within the Domain package.”  
2. “Please add SensorSnapshot, FermentationState, and Alert to the Data package.”  
3. “Please assign value, unit, and timestamp attributes to each element to complete the data structure.”

---

### 2-3. Defining Behavior and Allocation  
#### Goal: Represent the fermentation monitoring workflow as actions and allocate them to each part.

**Key Prompts Used**
1. “Please define the monitorFermentation action within the Behavior package.”  
2. “Please set four actions: collectReadings, inferState, detectAbnormality, and renderStatus.”  
3. “Please allocate these actions respectively to SensorUnit, AIRepository, and DisplayInterface.”

---

## 🩵 Step 3: Proof-of-Concept (PoC) Modeling
### 🎯 Goal  
To implement the conceptual model using real devices and verify its practical feasibility on-site.

---

### 3-1. Creating the PoC Package  
#### Goal: Extend the conceptual model by adding real product attributes.

**Key Prompts Used**
1. “Please create a PoC package based on the conceptual model.”  
2. “Please inherit each element using :> syntax and define FermentationBottle_OTS, SensorUnit_OTS, AIRepository_OTS, etc.”  
3. “Please specify actual product names such as HARIO, Raspberry Pi, and Slack API as productName attributes.”

---

### 3-2. Defining the PoC Configuration (PoCBox)  
#### Goal: Combine all elements into one integrated system configuration.

**Key Prompts Used**
1. “Please include the bottle, sensors, AI, apps, display, and users in the PoCBox structure.”  
2. “Please connect each part using interface connect to reproduce the data flow.”  
3. “Please integrate Slack and Sheets outputs into display.ui so that artisans can monitor fermentation status.”

---

### 3-3. Verifying Data Flow and Consistency  
#### Goal: Confirm that the PoC configuration behaves as intended in the conceptual model.

**Key Prompts Used**
1. “Please verify that the data flow follows Sensor → AI → Slack/Sheets → Display.”  
2. “Please ensure that Maker and Manager can view the system state through the DisplayInterface.”  
3. “Please align the PoC structure with the conceptual model for consistency.”

---

## 🧭 Summary

This document traces the process of developing the **Sansho-zuke Fermentation Monitoring System**,  
starting from real on-site challenges and applying **ISO/IEC/IEEE 15288 requirement-definition processes** through **SysML v2 modeling**.

Through the workflow  
**Step 1: Problem Structuring → Step 2: Concept Modeling → Step 3: Proof-of-Concept Implementation**,  
the natural fermentation process was transformed into a **Cyber-Physical System (CPS)**  
capable of **measurement, analysis, visualization, and decision-support.**

As a result, this work redefines the traditional Japanese natural fermentation of Sansho-zuke  
as a modern, data-driven fermentation management system with scientific reproducibility.
