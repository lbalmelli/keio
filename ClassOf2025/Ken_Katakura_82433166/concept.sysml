package 'FermentationMonitoringConcept' {

    package Concept {

        package Domain {
            import SI::*;
            item def Time;

            item def Temperature {
                attribute value: Real;
                attribute unit: SI::K;
                attribute timestamp: Time;
            }

            item def Acidity_pH {
                attribute value: Real;
                attribute timestamp: Time;
            }

            item def CO2Level {
                attribute value: Real;
                attribute unit: SI::ppm;
                attribute timestamp: Time;
            }

            item def AlertMessage {
                attribute message: String;
                attribute severity: String;
            }

            item def WiFiSignal {
                attribute ssid: String;
                attribute signalStrength: Real;
            }

            item def SlackMessage {
                attribute message: String;
                attribute severity: String;
            }

            item def SheetRecord {
                attribute temperature: Temperature;
                attribute pH: Acidity_pH;
                attribute co2: CO2Level;
            }
        }

        package Data {
            item def SensorSnapshot {
                attribute temperature: Domain::Temperature;
                attribute pH: Domain::Acidity_pH;
                attribute co2: Domain::CO2Level;
            }

            item def FermentationState {
                attribute progress: Real;
                attribute confidence: Real;
                attribute assessedAt: Domain::Time;
            }

            item def Alert {
                attribute alertMessage: Domain::AlertMessage;
                attribute issuedAt: Domain::Time;
            }
        }

        package Ports {
            port def MeasurementPort {
                out snapshot: Data::SensorSnapshot;
            }

            port def SnapshotIn {
                in snapshot: Data::SensorSnapshot;
            }

            port def StatePort {
                out state: Data::FermentationState;
            }

            port def AlertPort {
                out alert: Data::Alert;
            }

            port def DisplayPort {
                in snapshot: Data::SensorSnapshot;
                in state: Data::FermentationState;
                in alert: Data::Alert;
                in sheetRecord: Domain::SheetRecord;
                in slackMsg: Domain::SlackMessage;
            }

            port def BottleSensorLink;

            port def WiFiPort {
                flow comms: Domain::WiFiSignal;
            }

            port def SheetUploadPort {
                out sheetRecord: Domain::SheetRecord;
            }

            port def SlackOutPort {
                out slackMsg: Domain::SlackMessage;
            }
        }

        package Parts {
            part def Maker;
            part def Manager;

            part def FermentationBottle {
                port sensorPort: Ports::BottleSensorLink;
            }

            part def SensorUnit {
                port bottlePort: ~Ports::BottleSensorLink;
                port m: Ports::MeasurementPort;
                port wifi: Ports::WiFiPort;
            }

            part def AIRepository {
                port inSnap: Ports::SnapshotIn;
                port outState: Ports::StatePort;
                port outAlert: Ports::AlertPort;
                port wifi: ~Ports::WiFiPort;
            }

            part def DisplayInterface {
                port ui: Ports::DisplayPort;
            }

            part def RecordExportApp {
                port inData: Ports::StatePort;
                port sheetOut: Ports::SheetUploadPort;
                port wifi: ~Ports::WiFiPort;
            }

            part def SlackNotifierApp {
                port inAlert: Ports::AlertPort;
                port slackOut: Ports::SlackOutPort;
                port wifi: ~Ports::WiFiPort;
            }
        }

        package Behavior {
            action monitorFermentation {
                using Data::*;
                using Domain::*;

                action collectReadings { out snapshot: SensorSnapshot; }
                action inferState { in snapshot; out state: FermentationState; }
                action detectAbnormality { in snapshot; out alert: Alert; }
                action renderStatus {
                    in state;
                    in alert?;
                    actor viewer: Parts::Maker;
                }

                succession flow s1 from collectReadings.snapshot to inferState.snapshot;
                succession flow s2 from collectReadings.snapshot to detectAbnormality.snapshot;
                succession flow s3 from inferState.state to renderStatus.state;
                succession flow s4 from detectAbnormality.alert to renderStatus.alert;
            }
        }

        package Allocation {
            import Parts::*;
            import Behavior::*;

            perform monitorFermentation.collectReadings allocatedTo sensor: SensorUnit {
                out snapshot = sensor.m.snapshot;
            }

            perform monitorFermentation.inferState allocatedTo ai: AIRepository {
                in snapshot = sensor.m.snapshot;
                out state = ai.outState.state;
            }

            perform monitorFermentation.detectAbnormality allocatedTo ai: AIRepository {
                in snapshot = sensor.m.snapshot;
                out alert = ai.outAlert.alert;
            }

            perform monitorFermentation.renderStatus allocatedTo display: DisplayInterface {
                in state = display.ui.state;
                in alert = display.ui.alert;
                actor viewer = viewer;
            }
        }

        package Context {
            import Parts::*;

            part def FermentationMonitoringSystem {
                part maker: Maker;
                part manager: Manager;
                part bottle: FermentationBottle;
                part sensor: SensorUnit;
                part ai: AIRepository;
                part display: DisplayInterface;
                part exporter: RecordExportApp;
                part notifier: SlackNotifierApp;

                interface physicalMount connect sensor.bottlePort to bottle.sensorPort;
                interface wifiLink connect sensor.wifi to ai.wifi;
                interface measure connect sensor.m to ai.inSnap;
                interface stateToSheets connect ai.outState to exporter.inData;
                interface alertToNotifier connect ai.outAlert to notifier.inAlert;
                interface exportToDisplay connect exporter.sheetOut to display.ui;
                interface notifyToDisplay connect notifier.slackOut to display.ui;
                interface wifiToSheets connect ai.wifi to exporter.wifi;
                interface wifiToSlack connect ai.wifi to notifier.wifi;
                interface view connect maker to display;
                interface view2 connect manager to display;
            }
        }
    }
}