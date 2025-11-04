package 'FermentationMonitoringPoC' {

    package PoC {

        // --- 必要なPort定義（簡略版） ---
        port def BottleSensorLink;

        port def WiFiPort {
            flow comms: WiFiSignal;
        }

        port def MeasurementPort {
            out snapshot: SensorSnapshot;
        }

        port def SnapshotIn {
            in snapshot: SensorSnapshot;
        }

        port def StatePort {
            out state: FermentationState;
        }

        port def AlertPort {
            out alert: Alert;
        }

        port def SheetUploadPort {
            out sheetRecord: SheetRecord;
        }

        port def SlackOutPort {
            out slackMsg: SlackMessage;
        }

        port def DisplayPort {
            in snapshot: SensorSnapshot;
            in state: FermentationState;
            in alert: Alert;
            in sheetRecord: SheetRecord;
            in slackMsg: SlackMessage;
        }

        // --- 簡易データ定義 ---
        item def WiFiSignal {
            attribute ssid: String;
            attribute signalStrength: Real;
        }

        item def SensorSnapshot;
        item def FermentationState;
        item def Alert;
        item def SheetRecord;
        item def SlackMessage;

        // --- 必要なPart定義 ---
        part def FermentationBottle {
            port sensorPort: BottleSensorLink;
        }

        part def SensorUnit {
            port bottlePort: ~BottleSensorLink;
            port m: MeasurementPort;
            port wifi: WiFiPort;
        }

        part def AIRepository {
            port inSnap: SnapshotIn;
            port outState: StatePort;
            port outAlert: AlertPort;
            port wifi: ~WiFiPort;
        }

        part def DisplayInterface {
            port ui: DisplayPort;
        }

        part def RecordExportApp {
            port inData: StatePort;
            port sheetOut: SheetUploadPort;
            port wifi: ~WiFiPort;
        }

        part def SlackNotifierApp {
            port inAlert: AlertPort;
            port slackOut: SlackOutPort;
            port wifi: ~WiFiPort;
        }

        part def Maker;
        part def Manager;

        // --- OTS定義とPoC構成 ---
        part def FermentationBottle_OTS :> FermentationBottle {
            attribute productName: String = "HARIO FKT-1000 Stainless Steel Bottle";
            attribute description: String = "Stores fermenting food contents.";
        }

        part def SensorUnit_OTS :> SensorUnit {
            attribute productName: String = "Atlas Scientific EZO™ pH, DS18B20, SCD41 CO₂ Sensor";
            attribute description: String = "Measures pH, temperature, and CO₂ levels.";
        }

        part def AIRepository_OTS_Pi :> AIRepository {
            attribute productName: String = "Raspberry Pi 5 (8GB)";
            attribute description: String = "Processes sensor data and estimates fermentation state.";
        }

        part def DisplayDevice_OTS :> DisplayInterface {
            attribute productName: String = "Samsung Galaxy Tab Active 4 Pro";
            attribute description: String = "Displays fermentation status and alerts.";
        }

        part def RecordExportApp_OTS :> RecordExportApp {
            attribute productName: String = "Google Sheets API Connector";
            attribute description: String = "Exports fermentation data to cloud storage.";
        }

        part def SlackNotifierApp_OTS :> SlackNotifierApp {
            attribute productName: String = "Slack Webhook Notification Service";
            attribute description: String = "Sends alert messages to Slack in real time.";
        }

        part def Maker_Operator :> Maker;
        part def Manager_Operator :> Manager;

        part def PoC_Box_A {
            part bottle: FermentationBottle_OTS;
            part sensor: SensorUnit_OTS;
            part repo: AIRepository_OTS_Pi;
            part display: DisplayDevice_OTS;
            part maker: Maker_Operator;
            part manager: Manager_Operator;
            part exporter: RecordExportApp_OTS;
            part notifier: SlackNotifierApp_OTS;

            interface physicalMount connect sensor.bottlePort to bottle.sensorPort;
            interface wifiLink connect sensor.wifi to repo.wifi;
            interface measure connect sensor.m to repo.inSnap;
            interface view connect maker to display;
            interface view2 connect manager to display;
            interface stateToSheets connect repo.outState to exporter.inData;
            interface alertToNotifier connect repo.outAlert to notifier.inAlert;
            interface exportToDisplay connect exporter.sheetOut to display.ui;
            interface notifyToDisplay connect notifier.slackOut to display.ui;
            interface wifiToSheets connect repo.wifi to exporter.wifi;
            interface wifiToSlack connect repo.wifi to notifier.wifi;
        }
    }
}