# 🧪 poc.md —  Proof of Concept (PoC) Model — Sansho-zuke Fermentation Monitoring System
_Last updated: 2025-11-04 (JST)_  
_Ken Katakura_  
_82433166_

## 🎯 Purpose of the PoC

This Proof of Concept (PoC) was built to reproduce and verify the conceptual model of the **Fermentation Monitoring System**—originally designed in SysML v2—within an actual production environment.  
The objective is to confirm that **a complete data cycle—where natural fermentation is measured by sensors, analyzed by AI for progress and anomalies, and interpreted by humans in real time—can function in practice.**

This PoC was created to demonstrate the following:
- That the “Physical → Data → Judgment → Action” feedback loop defined in the conceptual model can be realized in a real hardware and software configuration.  
- That real-time AI processing on a local Raspberry Pi can operate independently from the cloud.  
- That consistent traceability can be maintained across sensors, AI, notification applications, and visualization interfaces.  

---

## ⚙️ Traceability Between Conceptual Model and PoC Implementation

| Conceptual Model Element | POC Model Element | Transformation & Implementation Insight |
|---------------------------|-------------------|------------------------------------------|
| **FermentationBottle** | **HARIO FKT-1000 Stainless Steel Bottle** | The conceptual fermentation vessel was realized using a HARIO stainless bottle. A sensor port was drilled while maintaining hygiene and airtightness. The off-the-shelf bottle was modified to serve as the physical foundation for data acquisition. |
| **SensorUnit** | **Atlas Scientific EZO™ pH + DS18B20 + SCD41 CO₂ Sensors** | The conceptual sensor cluster was implemented using commercial modules. pH, temperature, and CO₂ are measured and transmitted to the Raspberry Pi via I²C communication. Calibration was simplified, and measurement intervals were set to one minute. |
| **AIRepository** | **Raspberry Pi 5 (8GB)** | The conceptual AI node was implemented as a physical device. Python scripts handle data collection, preprocessing, and inference of fermentation progress and anomalies. Lightweight AI models (scikit-learn / TensorFlow Lite) enable fully local inference. |
| **RecordExportApp** | **Google Sheets API Connector** | The conceptual data recording module was implemented via the Google Sheets API. Data is automatically uploaded from the Raspberry Pi to the cloud, enabling visualization of fermentation history. The main purpose was to verify API integration. |
| **SlackNotifierApp** | **Slack Incoming Webhook Service** | The anomaly notification module was implemented using the Slack API. When AIRepository detects an anomaly, a notification is sent via Webhook. Users receive instant alerts on mobile or desktop. |
| **DisplayInterface** | **Samsung Galaxy Tab Active4 Pro** | The conceptual display interface was realized using a tablet device. It integrates Slack and Sheets outputs to show fermentation status, alerts, and history on one screen, validating human-centered usability. |
| **Maker / Manager** | **Craftsman (myself) and Production Manager** | The human element was represented by myself (artisan) and a production manager. We operated the PoC, evaluating consistency between AI estimations and human judgments, as well as response time and interaction quality. |

---

## 🧠 Implementation Highlights and Insights

- Focused on **traceability from the conceptual SysML model to the physical implementation**, ensuring a one-to-one correspondence between PoC elements and Parts definitions.  
- Converted the previously abstract data flow (Sensor → AI → Slack/Sheets → Display) into **actual inter-device communication.**  
- Avoided complex cloud architecture, completing the PoC with a **lightweight, locally processed system centered on the Raspberry Pi.**  

---

## 🧩 Summary

This PoC demonstrates that the concept defined in the SysML v2 model—  
**“Enhancing craftsmanship through data”**—can be validated in a real-world production setting.  
The inference capability of the AIRepository and the immediacy of Slack notifications establish a new operational model that allows the fermentation state to be monitored both scientifically and humanistically.  

