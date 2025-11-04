# digital_twin_dashboard.py
# Lightweight digital twin dashboard prototype for ADAS Urban Parallel Parking PoC
# Run: python3 digital_twin_dashboard.py

import tkinter as tk
from tkinter import ttk
import time

# -----------------------
# Model / State Machine
# -----------------------
class ParkingStateMachine:
    # parkingStatus enumeration: idle, scanning, confirming, parking, paused, completed
    def __init__(self):
        self.parkingStatus = "idle"
        self.detectedSpaceWidth_m = 0.0      # Real [m]
        self.obstacleDistance_m = 10.0       # Real [m]
        self.vehicleSpeed_mps = 0.0          # Real [m/s]
        self.steeringAngle_deg = 0.0         # Real [deg]
        self.feedbackDisplay = "System Ready"
        self.startCommand = False            # Driver start command
        self.confirmationSignal = False      # Driver confirmation
        self.parking_progress = 0.0          # 0..100 percent for visualizing parking progress
        self.time_last = time.time()

    def reset(self):
        self.parkingStatus = "idle"
        self.detectedSpaceWidth_m = 0.0
        self.obstacleDistance_m = 10.0
        self.vehicleSpeed_mps = 0.0
        self.steeringAngle_deg = 0.0
        self.feedbackDisplay = "System Ready"
        self.startCommand = False
        self.confirmationSignal = False
        self.parking_progress = 0.0

    def step(self, dt):
        """Advance internal simulation by dt seconds and do state transitions."""
        # Basic rules from PoC:
        # idle -> scanning when startCommand True
        if self.parkingStatus == "idle":
            if self.startCommand:
                self.parkingStatus = "scanning"
                self.feedbackDisplay = "Scanning for spaces..."
                self.parking_progress = 0.0

        # scanning -> confirming when detectedSpaceWidth >= 5.0
        elif self.parkingStatus == "scanning":
            # pretend detection quality improves over time: increase detectedSpaceWidth if >0
            # but in GUI we set detectedSpaceWidth directly via slider; respect that.
            if self.detectedSpaceWidth_m >= 5.0:
                self.parkingStatus = "confirming"
                self.feedbackDisplay = "Spot found — please confirm to start"
            else:
                # remain scanning
                self.feedbackDisplay = "Scanning for spaces..."
        
        # confirming -> parking when confirmation signal True
        elif self.parkingStatus == "confirming":
            if self.confirmationSignal:
                self.parkingStatus = "parking"
                self.feedbackDisplay = "Parking engaged"
                self.parking_progress = 0.0
            else:
                # still asking for confirmation
                self.feedbackDisplay = "Awaiting driver confirmation"

        # parking -> paused if obstacleDistance < 0.5
        elif self.parkingStatus == "parking":
            # Simulate vehicle motion in parking: parking_progress increases, vehicleSpeed nonzero until finished
            if self.obstacleDistance_m < 0.5:
                self.parkingStatus = "paused"
                self.feedbackDisplay = "Paused — obstacle detected"
                self.vehicleSpeed_mps = 0.0
            else:
                # progress parking
                # simulate speed during parking (small)
                self.vehicleSpeed_mps = max(0.1, 0.5 * (1 - self.parking_progress / 100.0))
                self.parking_progress += 20.0 * dt  # progress rate: 20% per second (fast for demo)
                if self.parking_progress >= 100.0:
                    self.parking_progress = 100.0
                    self.vehicleSpeed_mps = 0.0
                    self.feedbackDisplay = "Parking Completed"
                    self.parkingStatus = "completed"
                else:
                    self.feedbackDisplay = f"Parking... {int(self.parking_progress)}%"

        # paused -> parking when obstacleDistance >= 0.5
        elif self.parkingStatus == "paused":
            if self.obstacleDistance_m >= 0.5:
                self.parkingStatus = "parking"
                self.feedbackDisplay = "Resuming parking"
            else:
                self.feedbackDisplay = "Paused — obstacle present"

        # completed -> idle when startCommand is false and driver acknowledged
        elif self.parkingStatus == "completed":
            # wait for driver to deactivate/startCommand == False to go back to idle
            if not self.startCommand:
                self.parkingStatus = "idle"
                self.feedbackDisplay = "System Ready"
                self.parking_progress = 0.0
                self.confirmationSignal = False

# -----------------------
# GUI
# -----------------------
class DigitalTwinGUI:
    def __init__(self, root, model: ParkingStateMachine, tick_ms=200):
        self.root = root
        self.model = model
        self.tick_ms = tick_ms
        self.last_update = time.time()

        root.title("Digital Twin — ADAS Urban Parallel Parking PoC")

        # Frames
        controls_frame = ttk.LabelFrame(root, text="Driver Controls", padding=8)
        controls_frame.grid(row=0, column=0, padx=8, pady=8, sticky="nsew")

        sensors_frame = ttk.LabelFrame(root, text="Environment Sensors", padding=8)
        sensors_frame.grid(row=1, column=0, padx=8, pady=8, sticky="nsew")

        status_frame = ttk.LabelFrame(root, text="System Status", padding=8)
        status_frame.grid(row=0, column=1, rowspan=2, padx=8, pady=8, sticky="nsew")

        log_frame = ttk.LabelFrame(root, text="Event Log", padding=8)
        log_frame.grid(row=2, column=0, columnspan=2, padx=8, pady=8, sticky="nsew")

        # Driver Controls
        self.start_button = ttk.Button(controls_frame, text="Start Auto Park", command=self.toggle_start)
        self.start_button.grid(row=0, column=0, padx=4, pady=4, sticky="ew")

        self.confirm_button = ttk.Button(controls_frame, text="Confirm Parking", command=self.do_confirm)
        self.confirm_button.grid(row=0, column=1, padx=4, pady=4, sticky="ew")

        self.reset_button = ttk.Button(controls_frame, text="Reset System", command=self.do_reset)
        self.reset_button.grid(row=0, column=2, padx=4, pady=4, sticky="ew")

        # Sensors

        # detectedSpaceWidth slider
        ttk.Label(sensors_frame, text="Detected Space Width (m)").grid(row=0, column=0, sticky="w")
        self.space_slider = ttk.Scale(sensors_frame, from_=0.0, to=10.0, orient="horizontal",
                                      command=self.on_space_slider)
        self.space_slider.set(self.model.detectedSpaceWidth_m)
        self.space_slider.grid(row=1, column=0, sticky="ew", padx=4, pady=2)
        self.space_value_label = ttk.Label(sensors_frame, text=f"{self.model.detectedSpaceWidth_m:.2f} m")
        self.space_value_label.grid(row=1, column=1, sticky="w")

        # obstacleDistance slider
        ttk.Label(sensors_frame, text="Obstacle Distance (m)").grid(row=2, column=0, sticky="w")
        self.obs_slider = ttk.Scale(sensors_frame, from_=0.0, to=10.0, orient="horizontal",
                                      command=self.on_obs_slider)
        self.obs_slider.set(self.model.obstacleDistance_m)
        self.obs_slider.grid(row=3, column=0, sticky="ew", padx=4, pady=2)
        self.obs_value_label = ttk.Label(sensors_frame, text=f"{self.model.obstacleDistance_m:.2f} m")
        self.obs_value_label.grid(row=3, column=1, sticky="w")

        # vehicleSpeed slider (for testing completion condition)
        ttk.Label(sensors_frame, text="Vehicle Speed (m/s) [override]").grid(row=4, column=0, sticky="w")
        self.speed_slider = ttk.Scale(sensors_frame, from_=0.0, to=2.0, orient="horizontal",
                                      command=self.on_speed_slider)
        self.speed_slider.set(self.model.vehicleSpeed_mps)
        self.speed_slider.grid(row=5, column=0, sticky="ew", padx=4, pady=2)
        self.speed_value_label = ttk.Label(sensors_frame, text=f"{self.model.vehicleSpeed_mps:.2f} m/s")
        self.speed_value_label.grid(row=5, column=1, sticky="w")

        # System status labels
        ttk.Label(status_frame, text="Parking Status:").grid(row=0, column=0, sticky="w")
        self.status_label = ttk.Label(status_frame, text=self.model.parkingStatus, font=("Segoe UI", 12, "bold"))
        self.status_label.grid(row=0, column=1, sticky="w")

        ttk.Label(status_frame, text="Feedback:").grid(row=1, column=0, sticky="nw")
        self.feedback_label = ttk.Label(status_frame, text=self.model.feedbackDisplay, wraplength=260, justify="left")
        self.feedback_label.grid(row=1, column=1, sticky="w")

        ttk.Label(status_frame, text="Detected Space Width:").grid(row=2, column=0, sticky="w")
        self.detected_label = ttk.Label(status_frame, text=f"{self.model.detectedSpaceWidth_m:.2f} m")
        self.detected_label.grid(row=2, column=1, sticky="w")

        ttk.Label(status_frame, text="Obstacle Distance:").grid(row=3, column=0, sticky="w")
        self.obs_label = ttk.Label(status_frame, text=f"{self.model.obstacleDistance_m:.2f} m")
        self.obs_label.grid(row=3, column=1, sticky="w")

        ttk.Label(status_frame, text="Vehicle Speed:").grid(row=4, column=0, sticky="w")
        self.speed_label = ttk.Label(status_frame, text=f"{self.model.vehicleSpeed_mps:.2f} m/s")
        self.speed_label.grid(row=4, column=1, sticky="w")

        ttk.Label(status_frame, text="Parking Progress:").grid(row=5, column=0, sticky="w")
        self.progress_var = tk.DoubleVar(value=self.model.parking_progress)
        self.progress_bar = ttk.Progressbar(status_frame, variable=self.progress_var, maximum=100.0, length=200)
        self.progress_bar.grid(row=5, column=1, sticky="w")

        # Event log
        self.log_text = tk.Text(log_frame, height=8, width=80, state="disabled")
        self.log_text.grid(row=0, column=0, padx=4, pady=4)

        # Start periodic update
        self.root.after(self.tick_ms, self.update_loop)
        self.log_event("Digital twin started. System Ready.")

    # ------------
    # GUI callbacks
    # ------------
    def toggle_start(self):
        self.model.startCommand = not self.model.startCommand
        if self.model.startCommand:
            self.start_button.config(text="Stop Auto Park")
            self.log_event("Driver: Start Auto Park issued.")
        else:
            self.start_button.config(text="Start Auto Park")
            self.log_event("Driver: Start Auto Park canceled / deactivated.")

    def do_confirm(self):
        if self.model.parkingStatus == "confirming":
            self.model.confirmationSignal = True
            self.log_event("Driver: Confirmation signal given.")
        else:
            self.log_event("Driver: Confirmation pressed (ignored) — not in confirming state.")

    def do_reset(self):
        self.model.reset()
        self.space_slider.set(self.model.detectedSpaceWidth_m)
        self.obs_slider.set(self.model.obstacleDistance_m)
        self.speed_slider.set(self.model.vehicleSpeed_mps)
        self.start_button.config(text="Start Auto Park")
        self.log_event("System reset performed.")

    def on_space_slider(self, val):
        self.model.detectedSpaceWidth_m = float(val)
        self.space_value_label.config(text=f"{self.model.detectedSpaceWidth_m:.2f} m")

    def on_obs_slider(self, val):
        self.model.obstacleDistance_m = float(val)
        self.obs_value_label.config(text=f"{self.model.obstacleDistance_m:.2f} m")

    def on_speed_slider(self, val):
        # This slider overrides vehicle speed (useful for testing completion)
        self.model.vehicleSpeed_mps = float(val)
        self.speed_value_label.config(text=f"{self.model.vehicleSpeed_mps:.2f} m/s")

    # ------------
    # Update loop
    # ------------
    def update_loop(self):
        now = time.time()
        dt = now - self.last_update if hasattr(self, "last_update") else 0.0
        if dt <= 0:
            dt = self.tick_ms / 1000.0
        self.last_update = now

        # Let the model advance
        self.model.step(dt)

        # If as part of simulation we want vehicleSpeed to be influenced by parking progress,
        # only do that if speed slider wasn't used (i.e., keep slider-driven speed if user actively moves it).
        # For simplicity we allow the model to set speed during parking:
        if self.model.parkingStatus == "parking":
            # do not override if user manually set a non-zero speed via slider recently
            # We'll assume slider override if difference > small epsilon
            slider_speed = float(self.speed_slider.get())
            if abs(slider_speed - self.model.vehicleSpeed_mps) > 0.05:
                # update slider to reflect model speed (smooth)
                self.speed_slider.set(self.model.vehicleSpeed_mps)
            self.speed_value_label.config(text=f"{self.model.vehicleSpeed_mps:.2f} m/s")
        else:
            # reflect model speed to label/slider
            self.speed_slider.set(self.model.vehicleSpeed_mps)
            self.speed_value_label.config(text=f"{self.model.vehicleSpeed_mps:.2f} m/s")

        # Update UI elements
        self.status_label.config(text=self.model.parkingStatus)
        self.feedback_label.config(text=self.model.feedbackDisplay)
        self.detected_label.config(text=f"{self.model.detectedSpaceWidth_m:.2f} m")
        self.obs_label.config(text=f"{self.model.obstacleDistance_m:.2f} m")
        self.progress_var.set(self.model.parking_progress)

        # Log some notable state changes
        # (We will log transitions / important events)
        # Keep a simple last_state cache
        if not hasattr(self, "last_state_cache"):
            self.last_state_cache = self.model.parkingStatus
        if self.model.parkingStatus != self.last_state_cache:
            self.log_event(f"State change: {self.last_state_cache} -> {self.model.parkingStatus} -- {self.model.feedbackDisplay}")
            self.last_state_cache = self.model.parkingStatus

        # Continue timer
        self.root.after(self.tick_ms, self.update_loop)

    # ------------
    # Logging
    # ------------
    def log_event(self, text):
        t = time.strftime("%H:%M:%S")
        self.log_text.config(state="normal")
        self.log_text.insert("end", f"[{t}] {text}\n")
        self.log_text.see("end")
        self.log_text.config(state="disabled")

# -----------------------
# Run
# -----------------------
def main():
    root = tk.Tk()
    model = ParkingStateMachine()
    gui = DigitalTwinGUI(root, model)
    root.mainloop()

if __name__ == "__main__":
    main()
