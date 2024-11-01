# Proof of Concept Tables for Smart Health Bracelet

## Traceability Table
The following table outlines the traceability of SysML elements to real-world devices and their respective functionalities.

| **SysML Element**           | **Mapped Real-World Device**          | **Functionality**                              |
|-----------------------------|---------------------------------------|------------------------------------------------|
| SmartHealthBracelet         | System Concept                       | Health monitoring wearable                      |
| SensorModule                | Various Smart Sensors                | Health data collection                          |
| PowerSupply                 | Generic Battery Unit                 | Power monitoring                                |
| WearableStrap               | Generic Strap Material               | Wearable support                                |
| ProcessingUnit              | Guidance Processor                   | Data processing and user guidance               |
| MoreProHeartRate            | MorePro Fitness Tracker              | Heart rate monitoring                           |
| WithingsOxygenMonitor       | Withings ScanWatch                   | SpO2 monitoring                                 |
| SamsungPressureMonitor      | Samsung Galaxy Watch 5               | Blood pressure monitoring                       |
| MoreProTemperature          | MorePro Fitness Tracker              | Body temperature monitoring                     |
| GuidanceModule              | Processing Unit Analysis             | Health guidance and lifestyle recommendations    |

## Data Flow Definitions
This section describes how data flows between various components of the Smart Health Bracelet.

| **Health Metric**           | **States**                                | **Events**                       |
|-----------------------------|-------------------------------------------|----------------------------------|
| Heart Rate                  | Idle, Monitoring                          | HeartRateMonitor, HeartRateNormal |
| Oxygen Level                | Idle, Monitoring                          | OxygenMonitor, OxygenNormal      |
| Blood Pressure              | Idle, Monitoring                          | PressureMonitor, PressureNormal  |
| Body Temperature            | Idle, Monitoring                          | TempMonitor, TempNormal          |

## Conclusion
The tables above outline the essential components and data flows within the Smart Health Bracelet, serving as a reference for development and integration.
