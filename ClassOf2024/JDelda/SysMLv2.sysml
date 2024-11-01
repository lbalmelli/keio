package 'Package 1' {
	package 'Concept Model BlockProgrammingLearningTool' {
		package LearningToolComponents {
			part def UserInterface {
				doc /* Represents the main user interface for block-based programming, allowing students to navigate, 
				                    manipulate, and execute programming blocks in a user-friendly environment. */
				part fileMenu : FileMenu;
				part blockWorkspace : BlockWorkspace;
				part controlPanel : ControlPanel;
			}
			part def FileMenu {
				doc /* Provides options for essential file operations, enabling students to save and load their programming projects. */
				action saveFile : SaveFileAction;
				action loadFile : LoadFileAction;
			}
			part def BlockWorkspace {
				doc /* Represents the main area where students can drag and drop blocks to create programming logic visually. */
				action dragAndDropBlock : DragAndDropAction;
			}
			part def ControlPanel {
				doc /* Contains controls such as "Run" and "Stop" to execute or halt the students program in the workspace. */
				action runProgram : RunProgramAction;
				action stopProgram : StopProgramAction;
			}
			action def SaveFileAction {
				doc /* Defines the save operation, allowing students to store their current workspace configuration to a file. */
			}
			action def LoadFileAction {
				doc /* Defines the load operation, enabling retrieval of previously saved workspace configurations. */
			}
			action def DragAndDropAction {
				doc /* Supports drag-and-drop functionality, allowing blocks to be repositioned within the workspace to build logic. */
			}
			action def RunProgramAction {
				doc /* Initiates the execution of the program created in the block workspace. */
			}
			action def StopProgramAction {
				doc /* Halts the execution of the program, returning the workspace to a non-running state. */
			}
		}
		package ToolBehaviors {
			import LearningToolComponents::*;
		}
	}
	package 'Requirement/Use Case' {
		import 'Concept Model BlockProgrammingLearningTool'::LearningToolComponents::*;
		requirement def RequirementDefinition {
			part part : UserInterface {
				inout port port;
				inout port port;
				inout port port;
			}
			part part : FileMenu {
				inout port port;
				inout port port;
			}
			part part : BlockWorkspace {
				inout port port;
				inout port port;
				inout port port;
			}
			part part : ControlPanel {
				inout port port;
				inout port port;
			}
		}
	}
	package POC1 {
		package LearningToolComponents_PoC {
			part def UserInterface {
				doc /* Proof of Concept for the user interface of the Block-Based Programming Learning Tool, 
				                    covering file operations, workspace manipulation, program control, and feedback. */
				part fileMenu : FileMenu {
					doc /* Part of the UI for handling save and load actions. */
				}
				part blockWorkspace : BlockWorkspace {
					doc /* Part of the UI for the workspace where students arrange programming blocks. */
				}
				part controlPanel : ControlPanel {
					doc /* Part of the UI for running and stopping the program. */
				}
				part helpPanel : HelpPanel {
					doc /* Provides guidance, tutorials, or tooltips for using the tool effectively. */
				}
				part settingsPanel : SettingsPanel {
					doc /* Allows customization of tool settings and preferences. */
				}
				part feedbackPanel : FeedbackPanel {
					doc /* Displays program feedback and error messages for debugging. */
				}
				part toolbox : Toolbox {
					doc /* Contains programming blocks that students can drag into the workspace. */
				}
				part console : Console {
					doc /* Outputs program execution results and debug information. */
				}
			}
			part def ProcessingUnit {
				doc /* Central processing unit to handle logic and software execution for the tool. */
				part raspberryPi4 {
					doc /* Raspberry Pi 4 Model B, affordable and capable for educational coding applications. */
				}
				part intelNUC {
					doc /* Intel NUC for enhanced processing power, ideal for larger setups or more complex applications. */
				}
			}
			part def Display {
				doc /* Touchscreen display allowing user interaction with the block programming interface. */
				part waveshareTouchDisplay {
					doc /* Waveshare 7-inch capacitive touchscreen, suitable for individual or small-group coding exercises. */
				}
				part dellTouchMonitor {
					doc /* Dell 24" P2418HT touch monitor, providing a larger workspace for interactive learning. */
				}
			}
			part def SensorsAndInputs {
				doc /* Interactive input components that enhance engagement with the programming tool. */
				part circuitPlaygroundExpress {
					doc /* Adafruit Circuit Playground Express, with built-in sensors and inputs for interactive programming. */
				}
				part leapMotionController {
					doc /* Leap Motion Controller for gesture-based interaction, adding a hands-free input method. */
				}
			}
			part def Storage {
				doc /* Storage options for saving and loading programming projects. */
				part usbDrive {
					doc /* SanDisk Ultra Dual USB drive for cross-device compatibility and project portability. */
				}
				part externalSSD {
					doc /* WD My Passport SSD for fast storage access, especially for larger projects. */
				}
			}
			part def InterfaceDevices {
				doc /* Additional devices that allow for effective interaction and control within the tool. */
				part keyboardTouchpad {
					doc /* Logitech K600 TV Keyboard with integrated touchpad, suitable for navigating the interface. */
				}
				part streamDeck {
					doc /* Elgato Stream Deck with customizable buttons, providing quick access to common tool actions. */
				}
			}
			part def AudioVisualFeedback {
				doc /* Components providing visual and audio feedback, enhancing user interaction with the tool. */
				part speakers {
					doc /* Bose Companion 2 Series III speakers for clear audio feedback during programming sessions. */
				}
				part ledMatrix {
					doc /* Adafruit RGB LED Matrix for visual feedback on program status and execution output. */
				}
			}
			part def FileMenu {
				doc /* Enables file operations to save and load student projects, maintaining progress and reusability. */
				action saveFile : SaveFileAction;
				action loadFile : LoadFileAction;
			}
			part def BlockWorkspace {
				doc /* Visual workspace where blocks are organized to create programming logic. */
				action dragAndDropBlock : DragAndDropAction;
			}
			part def ControlPanel {
				doc /* Panel for controlling program execution with run and stop functionalities. */
				action runProgram : RunProgramAction;
				action stopProgram : StopProgramAction;
			}
			part def HelpPanel {
				doc /* Contains tutorials, tooltips, and instructional content to assist the user. */
				action displayHelp : DisplayHelpAction;
			}
			part def SettingsPanel {
				doc /* Allows users to modify interface settings, like theme and block size. */
				action adjustSettings : AdjustSettingsAction;
			}
			part def FeedbackPanel {
				doc /* Displays feedback, error messages, or other program information. */
				action showFeedback : ShowFeedbackAction;
			}
			part def Toolbox {
				doc /* Holds the various programming blocks that can be dragged into the workspace. */
				action selectBlock : SelectBlockAction;
			}
			part def Console {
				doc /* Displays program output, including debug and error messages. */
				action displayOutput : DisplayOutputAction;
			}
			action def SaveFileAction {
				doc /* Action to save the current state of the block workspace to a file, preserving student work. */
			}
			action def LoadFileAction {
				doc /* Action to load a saved configuration into the workspace, allowing students to resume their projects. */
			}
			action def DragAndDropAction {
				doc /* Action allowing blocks to be repositioned within the workspace, providing an interactive experience. */
			}
			action def RunProgramAction {
				doc /* Action to start executing the program designed in the block workspace, engaging the tools logic processing. */
			}
			action def StopProgramAction {
				doc /* Action to stop program execution, bringing the tool to an idle state. */
			}
			action def DisplayHelpAction {
				doc /* Action to show help content, providing tutorials or hints to assist the user. */
			}
			action def AdjustSettingsAction {
				doc /* Action to adjust tool settings, customizing the workspace environment to user preferences. */
			}
			action def ShowFeedbackAction {
				doc /* Action to display program feedback or error messages to guide debugging. */
			}
			action def SelectBlockAction {
				doc /* Action to select and drag a block from the toolbox into the workspace. */
			}
			action def DisplayOutputAction {
				doc /* Action to display the output of the program in the console for review. */
			}
		}
		package ToolBehaviors_PoC {
			import LearningToolComponents_PoC::*;
		}
	}
	package POC2 {
		package LearningToolComponents {
			part def UserInterface {
				doc /* Represents the main user interface for block-based programming, allowing students to navigate, 
				                    manipulate, and execute programming blocks in a user-friendly environment. */
				part fileMenu : FileMenu {
					part saveButton;
					part loadButton;
				}
				part blockWorkspace : BlockWorkspace {
					part toolbox;
					part editorArea;
				}
				part controlPanel : ControlPanel {
					part runButton;
					part stopButton;
				}
			}
			part def FileMenu {
				doc /* Provides options for essential file operations, enabling students to save and load their programming projects. */
				action saveFile : SaveFileAction;
				action loadFile : LoadFileAction;
				part saveButton {
					doc /* Save button using LGs button component for electronics projects. */
					attribute model = ;
					attribute buttonType = ;
				}
				part loadButton {
					doc /* Load button from LG, compatible with various educational toolkits. */
					attribute model = ;
					attribute buttonType = ;
				}
			}
			part def BlockWorkspace {
				doc /* Represents the main area where students can drag and drop blocks to create programming logic visually. */
				action dragAndDropBlock : DragAndDropAction;
				part toolbox {
					doc /* Toolbox using Blockly, a popular library for block-based programming. */
					attribute toolType = ;
					attribute version = ;
				}
				part editorArea {
					doc /* Code editor area using Monaco Editor, popular in IDEs and online code editors. */
					attribute editorType = ;
					attribute model = ;
				}
			}
			part def ControlPanel {
				doc /* Contains controls such as "Run" and "Stop" to execute or halt the students program in the workspace. */
				action runProgram : RunProgramAction;
				action stopProgram : StopProgramAction;
				part runButton {
					doc /* Run button from Adafruit, often used in maker projects. */
					attribute model = ;
					attribute buttonType = ;
				}
				part stopButton {
					doc /* Stop button, compatible with most educational hardware setups. */
					attribute model = ;
					attribute buttonType = ;
				}
			}
			action def SaveFileAction {
				doc /* Defines the save operation, allowing students to store their current workspace configuration to a file. */
			}
			action def LoadFileAction {
				doc /* Defines the load operation, enabling retrieval of previously saved workspace configurations. */
			}
			action def DragAndDropAction {
				doc /* Supports drag-and-drop functionality, allowing blocks to be repositioned within the workspace to build logic. */
			}
			action def RunProgramAction {
				doc /* Initiates the execution of the program created in the block workspace. */
			}
			action def StopProgramAction {
				doc /* Halts the execution of the program, returning the workspace to a non-running state. */
			}
		}
		package ToolBehaviors {
			import LearningToolComponents::*;
		}
	}
}