# Folding Seat Metro System — Concept Model

![Folding Seat Concept](./FoldingSeat_POC.png)

## Goal of the Concept

The goal of the Folding Seat Metro System is to design an intelligent and space-efficient folding seat for metro wagons.  
The system must automatically fold or deploy the seat based on metro occupancy, user interaction, and seat activity, improving both passenger comfort and space management during peak hours.  

This model focuses on integrating logical control, mechanical actions, and sensing capabilities to enable autonomous seat management.

---

## Approach to the Concept Creation

The model was built using SysML v2, following a hierarchical system decomposition.  
The top-level system (`FoldingSeatMetroSystem`) contains all the main interacting parts:  
- the **User**, who requests seat deployment,  
- the **Controller**, which makes logical decisions based on input data,  
- the **CrowdSensor**, which monitors metro occupancy,  
- and the **Seat**, which executes the mechanical actions of folding and deployment.  

Information flows are modeled through ports and connections.  
The control logic within the `Controller` decides the seat’s behavior according to three conditions:
1. **Crowd level** — if the metro is crowded, the seat stays folded.
2. **User request** — a deploy button allows manual seat activation.
3. **Idle timeout** — the seat folds automatically if unused for more than 30 seconds.

This approach ensures both ergonomic use and automatic adaptability.

---

## Main Components

| Component | Description | Function |
|------------|--------------|-----------|
| **User** | Represents the passenger inside the metro. | Sends the deploy request via button. |
| **Controller** | Logical core of the system. | Receives all input data and decides whether the seat should fold or deploy. |
| **CrowdSensor** | Detects occupancy level in the metro. | Sends crowd status (`CROWDED` / `NOT_CROWDED`) to the controller. |
| **Seat** | Mechanical assembly composed of sub-parts. | Physically performs the folding and deployment actions. |
| **CeilingMount** | Fixed structure attached to the metro ceiling. | Supports the telescopic arm and entire seat mechanism. |
| **TelescopicArm** | Extensible mechanical element. | Deploys or retracts the seat unit. |
| **SeatUnit** | Contains the presence sensor and fold button. | Detects user presence and enables manual folding. |
| **Handle** | Holds the deploy button. | Allows manual deployment command. |
| **SeatTimer** | Tracks seat inactivity time. | Sends elapsed time information to the controller. |

---

## Draft Plan for Implementation

1. **Mechanical Design**  
   - Develop a compact folding mechanism with a telescopic arm attached to a reinforced ceiling mount.  
   - Include hinges and rotation axes for smooth folding.  

2. **Sensing and Control**  
   - Integrate the crowd sensor for occupancy detection.  
   - Implement a presence sensor on the seat and a timer for idle monitoring.  
   - Program the controller logic following the SysML model (`allowDeployment`, `crowdOverride`, `idleTimeout`).

3. **Behavioral Logic**  
   - Implement the state machine:
     - FOLDED → DEPLOYED when `allowDeployment == true`
     - DEPLOYED → FOLDED when `allowDeployment == false`  
   - Trigger actions `deploySeat` and `foldSeat` to simulate physical motion.

4. **Testing and Validation**  
   - Validate logic integration between sensors and mechanical parts.  
   - Simulate user interactions and crowd variations in a virtual environment.  
   - Verify automatic retraction after 30 seconds of inactivity.

---

## Summary

This concept model provides a modular and realistic foundation for an intelligent folding seat integrated into a metro system.  
It ensures safety, efficiency, and comfort while demonstrating the synergy between mechanical components and logical control modeled in SysML v2.

---

