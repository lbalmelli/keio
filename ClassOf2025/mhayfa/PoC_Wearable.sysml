package pocwearable {

  public import conceptmodel::*;

  doc /**
    Overlay package defining the internal structure of PoC_Wearable and how it connects to the base conceptmodel.
    Includes camera, audio, power, and enclosure modules with appropriate ports, attributes, actions, and full interconnections.
  **/

  // =============================================
  // PoC_Wearable (Refines conceptmodel::Wearable)
  // =============================================

  part def PoC_Wearable specializes conceptmodel::Wearable {
    doc /**
      Composite PoC wearable that refines Wearable from conceptmodel.
      Integrates ai, camera, audio, power, and enclosure modules.
      PoC Enclosure can be mounted on regular glass frames. 
    **/

    port userInterface: String;
    port bluetooth: String;
    port externalPower: String;  // External charger input

    part camera: CameraClip;
    part audio: AudioModule;
    part power: PowerModule;
    part enclosure: Enclosure;
    part ai: AIModule;

    connect power.powerOutput to camera.powerInput;
    connect power.powerOutput to enclosure.ledPower;
    connect power.powerMountM to enclosure.powerMountF;
    connect externalPower to power.chargingPort;

    connect camera.cameraMountM to enclosure.cameraMountF;
    connect audio.audioMountM to enclosure.audioMountF;
    connect enclosure.enclosureMount to userInterface;

    connect audio.audioBT to bluetooth;

    connect  power.powerOutput to ai.powerInput;
connect camera.mediaOut to ai.dataIn; // Assume camera shares image with AI
connect ai.dataBt to bluetooth;          
connect ai.mount to enclosure.aiMountF;       // New mount point on Enclosure
  }

  // =====================
  // Submodule Definitions
  // =====================

  part def CameraClip {
    doc /**
      Camera module for capturing still images and video.
      Includes BLE control, Wi-Fi transmission, power input, and mounting interface.
    **/

    port mediaOut: String;
    port powerInput: String;
    port cameraMountM: String;

    attribute resolution: ScalarValues::String;
    attribute supportsRTSP: ScalarValues::Boolean;
    attribute fps: ScalarValues::Real;
    attribute videoEncoding: ScalarValues::String;
    attribute manufacturer: ScalarValues::String = "Espressif";
    attribute model: ScalarValues::String = "ESP32-S3-EYE";

    action captureStill;
    action captureBurst;
    action sendThumbBLE;
    action uploadFullImage;
    action startVideoAssist;
    action stopVideoAssist;
    action streamVideo;
    action setPrivacyIndicators;
    action setVideoParams;
  }

  part def AudioModule {
    doc /**
      Bluetooth audio module for TTS playback and voice capture.
      Interfaces via Bluetooth and mounts to the enclosure.
    **/

    port audioBT: String;
    port audioMountM: String;

    attribute supportsA2DP: ScalarValues::Boolean;
    attribute supportsHFP: ScalarValues::Boolean;
    attribute micSensitivity: ScalarValues::Real;
    attribute brand: String = "JLab";
    attribute model: String = "JBuds Frames";
    attribute power: String = "Self-contained";

    action playPrompt;
    action startCallAssist;
    action endCallAssist;
    action adjustVolume;
    action acknowledgeTone;
  }

  part def PowerModule {
    doc /**
      Rechargeable power supply module for camera and LED indicator.
      Includes charging port, mount interface, and monitoring features.
    **/

    port powerOutput: String;
    port chargingPort: String;
    port powerMountM: String;

    attribute batteryCapacity: ScalarValues::Real = 500;
    attribute chargeStatus: ScalarValues::String = "Full";
    attribute powerOutputVoltage: ScalarValues::Real = 3.7;

    action charge;
    action reportBattery;
    action protect;
    action enablePower;
    action disablePower;
  }

  part def Enclosure {
    doc /**
      3D printed enclosure that houses camera, audio, and power modules.
      Provides mechanical mounts, user interface buttons, and LED indicators.
    **/

    port cameraMountF: String;
    port audioMountF: String;
    port powerMountF: String;
    port ledPower: String;
    port enclosureMount: String;
    port aiMountF: String;


    attribute mountType: ScalarValues::String;
    attribute hasPrivacyLED: ScalarValues::Boolean;

    action mountToFrames;
    action pressCaptureButton;
    action showLEDReady;
    action showLEDCapture;
    action detachSafely;
  }

  part def AIModule {
  doc /**
    On-device AI processing module for lightweight inference tasks such as OCR,
    gesture recognition, or contextual awareness. Processes data locally from the camera.
  **/

  port dataIn: String;         // From Camera (e.g., stills, thumbnails)
  port dataBt: String;      // Result back to App or display (optional)
  port powerInput: String;     // Powered by PowerModule
  port mount: String;          // Physical integration into Enclosure

  attribute processor: String = "Kendryte K210";
  attribute modelType: String = "CNN Lightweight";
  attribute memory: ScalarValues::Real = 8; // MB
  attribute aiCapabilities: String = "OCR, object detection";

  action analyzeImage;
  action detectText;
  action detectObject;
  action generateContext;
  action preprocessData;
}


  

  // =============================
  // Context Model Overlay (Refine)
  // =============================

  part def ContextModelOverlay specializes conceptmodel::ContextModel {
    part wearable_refines: PoC_Wearable;
    

    connect wearable_refines.camera.mediaOut to app.btLink;
    connect wearable_refines.audio.audioBT to app.btLink;
  }
} 