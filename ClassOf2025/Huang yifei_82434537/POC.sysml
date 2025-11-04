package TranslationGlassPoC {

	/* FLOW ITEMS */
	item def SpokenLanguage;
	item def TranslatedText;
	item def PowerSignal;
	item def UserInput;

	/* PORT DEFINITIONS */
	port def AudioInPort {
		in spoken: SpokenLanguage;
	}
	port def SubtitleDisplayPort {
		out subtitle: TranslatedText;
	}
	port def PowerPort {
		in signal: PowerSignal;
	}
	port def MenuInputPort {
		in command: UserInput;
	}

	/* ACTION DEFINITIONS */
	action def TranslateSpeech {
		in spoken: SpokenLanguage;
		out subtitle: TranslatedText;
	}
	
	action def ShowSubtitle {
		in subtitle: TranslatedText;
	}
	
	action def ReceiveUserMenuInput {
		in command: UserInput;
	}

	action def PowerToggle {
		in signal: PowerSignal;
	}

	/* PHYSICAL COMPONENT DEFINITIONS */
	part def TranslationGlass {
		doc /* A wearable AR device with transparent display for subtitle overlay and voice translation functionality. */

		port mic: AudioInPort;
		port display: SubtitleDisplayPort;
		port powerSwitch: PowerPort;
		port menuInput: MenuInputPort;

		perform TranslateSpeech {
			in spoken = mic.spoken;
			out subtitle;
		}

		perform ShowSubtitle {
			in subtitle = TranslateSpeech.subtitle;
			out subtitle = display.subtitle;
		}

		perform ReceiveUserMenuInput {
			in command = menuInput.command;
		}

		perform PowerToggle {
			in signal = powerSwitch.signal;
		}
	}

	/* CONTEXT CONFIGURATION */
	part TranslationGlassContext {
		part glass: TranslationGlass;

		/* External Interfaces */
		interface powerControl connect userSignal.signal to glass.powerSwitch.signal;
		interface speechFeed connect userVoice.spoken to glass.mic.spoken;
		interface menuControl connect userMenu.command to glass.menuInput.command;

		/* Simulated User Inputs */
		part userSignal {
			port signal: PowerPort;
		}
		part userVoice {
			port spoken: AudioInPort;
		}
		part userMenu {
			port command: MenuInputPort;
		}
	}
}
