package 'Concept Model' {
	package IdeaWallModel {
		part def IdeaWall {
			ref part ideaCaptureModule : IdeaCaptureModule {
				doc /* The IdeaCaptureModule is a critical entry point for capturing creative inputs from users in real-time. It ensures that ideas are not only captured on-the-go but are also quickly synchronized with the collaborative boards, facilitating instant sharing and feedback. This helps create a dynamic, flexible, and accessible platform for team collaboration. */
			}
			ref part displayModule : DisplayModule;
			ref part connectivityModule : ConnectivityModule;
		}
		part def IdeaCaptureModule {
			attribute captureType : CaptureType;
			port ideaPort : IdeaPort;
			doc /* The IdeaCaptureModule is a critical entry point for capturing creative inputs from users in real-time. It ensures that ideas are not only captured on-the-go but are also quickly synchronized with the collaborative boards, facilitating instant sharing and feedback. This helps create a dynamic, flexible, and accessible platform for team collaboration. */
		}
		part def DisplayModule {
			attribute displayType;
			port displayPort : DisplayPort;
		}
		part def ConnectivityModule {
			attribute communicationProtocol;
			port connectionPort : ConnectionPort;
		}
		part def IdeaWallProduct {
			ref part voiceCapture : IdeaCaptureModule {
				port ideaPort : IdeaPort;
			}
			ref part deskDisplay : DisplayModule {
				port displayPort : DisplayPort;
			}
			ref part connectionModule : ConnectivityModule {
				port connectionPort : ConnectionPort;
			}
			interface connect;
			interface connect;
			part wallDisplay : DisplayModule {
				inout port port;
			}
			part textCapture : IdeaCaptureModule {
				inout port port;
			}
		}
		port def IdeaPort;
		port def DisplayPort;
		port def ConnectionPort;
		enum def CaptureType {
			Text;
		}
	}
}
package 'PoC1: Flip and OfficeLens' {
	package IdeaWallProofOfConcept {
		part def IdeaWallProduct {
			ref part ideaCaptureModule : MicrosoftOfficeLens {
				port capturePort : IdeaCapturePort;
			}
			ref part displayModule : SamsungFlip {
				port displayPort : SamsungDisplayPort;
			}
			ref part connectivityModule : ConnectivityModule {
				port connectionPort : ConnectionPort;
			}
		}
		part def MicrosoftOfficeLens {
			attribute captureType : CaptureType = ;
			port capturePort : IdeaCapturePort;
		}
		part def SamsungFlip {
			attribute displayType = ;
			port displayPort;
			perform action displayContent {
				doc /* Displays ideas and visual content on the screen. */
			}
			perform action annotateContent {
				doc /* Allows users to annotate or draw on displayed content using touch or a stylus. */
				annotation;
			}
			perform action shareScreen {
				doc /* Shares the current display with connected devices or remote displays. */
				sharedContent;
			}
			perform action saveSession {
				doc /* Saves the current screen or session to the cloud or internal memory. */
				sessionData;
			}
		}
		part def ConnectivityModule {
			attribute communicationProtocol;
			port connectionPort : ConnectionPort;
		}
		port def IdeaCapturePort;
		port def SamsungDisplayPort;
		port def ConnectionPort;
		enum def CaptureType {
			Text;
		}
	}
}
package 'Dependency Model';
package 'Requirement/Use Cases' {
	requirement def RequirementDefinition {
		doc /* The idea wall can capture ideas on-the-go, anywhere and automatically display them on a team (i.e. shared) collaborative boards that can be set-up in multiple locations. */
	}
}
package 'PoC2: Flip,  IdeaHub, Notion' {
	package 'IdeaWall System' {
		package PartDefinitions {
			part def Notion {
				doc /* * Notion is a digital platform used within the IdeaWall System to capture and organize ideas. 
				                 * It allows users to create and manage content in various formats such as text notes, databases, 
				                 * Kanban boards, and collaborative documents.
				                 *
				                 * Key features of Notion within the IdeaWall System:
				                 * - Supports flexible page layouts for capturing ideas in text, lists, and multimedia formats.
				                 * - Enables real-time collaboration with team members for brainstorming sessions.
				                 * - Provides tagging and filtering capabilities to organize and categorize ideas.
				                 * - Offers cross-device synchronization for capturing ideas on-the-go and during meetings. */
			}
			part def SamsungFlip {
				doc /* * The Samsung Flip is an interactive display within the IdeaWall System. 
				                 * It is responsible for visualizing and managing the ideas collected and synchronized 
				                 * from various IdeaCaptureDevices through the IdeaHub and InternetConnection.
				                 *
				                 * The Samsung Flip offers the following features:
				                 * - Receives synchronized ideas and displays them with interactive controls.
				                 * - Allows multiple participants to draw, write, and annotate using the InGlass? touch technology.
				                 * - Supports various connectivity options such as USB, HDMI, NFC, Wi-Fi, and Bluetooth for seamless integration.
				                 * - Operates on the Tizen OS, which provides an API for custom interactive applications.
				                 *
				                 * The Samsung Flip enhances collaboration by offering a large, interactive surface for idea visualization 
				                 * and flexible connectivity options for effective team engagement. */
				attribute modelNumber : ScalarValues::String;
				attribute screenSize : ScalarValues::String;
				attribute resolution : ScalarValues::String;
				attribute connectivityOptions : ScalarValues::String;
				ref part tizenOS : TizenOS;
			}
			part def TizenOS {
				doc /* * The Tizen OS is the operating system running on the Samsung Flip display. It provides the platform and APIs
				                 * for developing custom interactive applications, enabling integration with cloud services, multimedia processing, 
				                 * touch interactions, and network connectivity features. */
				port App {
					doc /* * Represents the application interface for deploying and running custom apps on the Tizen OS.
					                     * Allows the attachment of interactive applications to extend the capabilities of the Samsung Flip. */
				}
				ref part tizenFX {
					doc /* * TizenFX is the core API for developing Tizen applications using .NET. It provides access to system features 
					             * such as media, sensors, network connectivity, and application management. */
				}
				ref part nuiFramework {
					doc /* * The Natural User Interface (NUI) framework is used to create sophisticated and interactive 2D and 3D user 
					             * interfaces for applications. It is highly optimized for .NET applications running on Tizen. */
				}
				ref part tvUIControls {
					doc /* * A set of specialized UI controls for Tizen TV applications, which can be adapted for interactive experiences 
					             * on Samsung Flip displays. This includes channel buttons, volume controls, and other interactive elements. */
				}
			}
			part def InternetConnection {
				doc /* * The InternetConnection part in the IdeaWall System enables connectivity between idea capture tools, 
				                 * collaborative boards, and AI processing units. It supports synchronized communication and data flow 
				                 * across devices, allowing the real-time exchange of ideas and feedback metrics.
				                 *
				                 * The InternetConnection offers reliable and secure network communication, leveraging protocols 
				                 * such as Wi-Fi, Ethernet, and cellular connectivity to maintain seamless integration. */
			}
			part def IdeaHub {
				doc /* * The central management component coordinating idea flows and integrating the DistilBERT model and Idea definitions.
				                 *
				                 * The IdeaHub receives, routes, and synchronizes ideas collected from various capture devices, providing centralized 
				                 * management of AI-based analysis tasks using the Jetson Xavier NX. It includes capabilities for processing ideas 
				                 * using the DistilBERT model for semantic analysis and clustering. */
				ref part aiProcessor : NvidiaJetsonXavierNX;
				ref part distilBERTModel : DistilBERT;
				ref part ideaEntity : Idea;
				action routeIdeaFlow;
			}
			part def NvidiaJetsonXavierNX {
				doc /* * The NVIDIA Jetson Xavier NX is an AI processing unit used within the IdeaWall System. It provides edge computing 
				                 * capabilities for real-time idea analysis using pre-trained AI models. The Xavier NX offers 21 TOPS of AI performance,
				                 * making it suitable for executing machine learning tasks such as clustering, idea similarity detection, and generating 
				                 * feedback metrics.
				                 *
				                 * The NVIDIA Jetson Xavier NX runs on the JetPack SDK and supports frameworks like TensorFlow and PyTorch, enabling the 
				                 * deployment of AI models for collaborative analysis tasks within the IdeaWall System. */
				attribute processorType : ScalarValues::String;
				attribute performance : ScalarValues::Real;
				attribute supportedFrameworks : ScalarValues::String;
				port LLM {
					doc /* * Represents the interface for running a large language model (LLM) on the NVIDIA Jetson Xavier NX. This port
					                     * is used to handle LLM-based analysis tasks such as clustering, similarity detection, and feedback generation. */
				}
				action analyzeIdeas;
				action generateMetrics;
			}
			part def DistilBERT {
				doc /* * DistilBERT is a distilled version of BERT, designed to be smaller, faster, and lighter while retaining much of BERT?s 
				                 * original performance. DistilBERT is used to perform semantic analysis, clustering, and idea similarity detection 
				                 * within the IdeaHub. It processes ideas provided by participants and helps in generating feedback metrics.
				                 *
				                 * The model can be optimized for edge deployment on the NVIDIA Jetson Xavier NX using TensorRT or ONNX Runtime. */
			}
			part def Idea {
				doc /* * Represents an individual idea captured in the IdeaHub.
				                 * An idea can have a description, creator information, and tags to identify key themes or topics. */
				attribute description : ScalarValues::String;
				attribute creatorID : ScalarValues::String;
				attribute tags : ScalarValues::String;
			}
			part def IdeaWallProduct {
				doc /* * The main product definition for the IdeaWall System. It consists of instances of all key parts,
				                 * including Notion for idea capture, Samsung Flip, Internet Connection, and IdeaHub with integrated AI capabilities and Idea management. */
				ref part notionApp : Notion;
				ref part samsungFlip : SamsungFlip;
				ref part flipIdea : SamsungFlip;
				ref part internetConnection : InternetConnection;
				ref part hub : IdeaHub;
			}
		}
		doc /* * The IdeaWall System is a collaborative platform designed to capture ideas in real-time 
		         * from multiple devices or locations and display them seamlessly on shared boards across 
		         * a network. The system consists of various components to facilitate idea collection, 
		         * synchronization, AI-based analysis, and display in collaborative workspaces. This is achieved 
		         * through interconnected parts including mobile capture devices, centralized hubs, a communication 
		         * network, AI-based processing, and interactive displays such as the Samsung Flip.
		         *
		         * Key features of the IdeaWall System include:
		         * - Idea capture on-the-go using mobile devices.
		         * - Automatic synchronization of captured ideas through an Internet connection.
		         * - Continuous AI-based analysis to detect similar ideas and provide instant feedback using brainstorm metrics.
		         * - Display of synchronized ideas on shared Samsung Flip interactive displays across multiple locations.
		         * - Central management and routing of ideas through a hub component.
		         * 
		         * The following table summarizes the changes made in the proof of concept model, replacing generic elements with 
		         * specialized or more practical implementations:
		         *
		         * | **Element in Initial Concept**        | **Replaced or Modified Element in PoC Model**        | **Description of Change**                                                                                             |
		         * |---------------------------------------|-----------------------------------------------------|----------------------------------------------------------------------------------------------------------------------|
		         * | **CollaborativeBoard**                | **SamsungFlip**                                     | Replaced the generic *CollaborativeBoard* with the *SamsungFlip* display to reflect a real-world interactive board.   |
		         * | **CommunicationNetwork**              | **InternetConnection**                              | Replaced the *CommunicationNetwork* part with an *InternetConnection* part to reflect connectivity through internet-based protocols. |
		         * | **IdeaCaptureDevice**                 | **Notion**                                          | Replaced with *Notion*, a versatile digital platform for capturing and organizing ideas.                             |
		         * | **AIProcessor**                       | **NvidiaJetsonXavierNX** (inside `IdeaHub`)         | Moved AI processing to the *Nvidia Jetson Xavier NX*, integrated within the *IdeaHub*, to provide localized AI-based processing capabilities. |
		         * | **DistilBERT**                        | **Part of IdeaHub**                                 | Integrated *DistilBERT* within the *IdeaHub* for semantic analysis and clustering tasks.                             |
		         * | **Idea**                              | **Part of IdeaHub**                                 | Moved the *Idea* element into *IdeaHub* to centralize the management of idea definitions within the hub.             | */
	}
}