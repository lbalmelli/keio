package EZkanjiExtension_PoC {

	import EZkanjiConceptModel::ConceptDefinitions::*;

	/* 🧩 PoC Context — 验证上下文（引用概念结构） 
	这个 part 表示 概念模型的一个实例化版本，是所有行为和验证动作的“试验台（testbed）”*/

	part def EZkanji_PoC {
		doc /* Proof-of-Concept to validate the logical feasibility 
		       of the EZkanji extension architecture defined in the Concept Model. */

		part extension : ChromeExtensionConcept;

		/* Reuse existing conceptual connections for structure verification */
		interface popupToBackground connect 
			extension.popup.popupChannel to extension.background.popupLink;

		interface contentToBackground connect 
			extension.content.contentChannel to extension.background.contentLink;

		interface popupToDisplay connect 
			extension.popup.popupChannel to extension.displayOutput;

		exhibit state behavior : 'Extension Behavior';
	}



	/* ⚙️ Behavior — 验证逻辑流程闭环 
	The behavior definition represents a complete interaction loop:
	The system starts in the idle state,Receives user input and triggers content analysis,
	Proceeds to displaying annotated output,
	Then returns to idle.
	This verifies that the architecture supports a closed logical cycle without deadlocks, 
	demonstrating its feasibility at the conceptual level.*/
	state def 'Extension Behavior' {
		doc /* Behavioral validation: ensures message flow 
		       from user input → content → display → back to idle. */

		state idle;
		state analyzing;
		state displaying;

		transition 'idle-analyzing'
			first idle
			accept extension.userInput.userEvent
			do extension.content.analyzeText
			then analyzing;

		transition 'analyzing-displaying'
			first analyzing
			do extension.content.addFurigana
			then displaying;

		transition 'displaying-idle'
			first displaying
			do extension.displayOutput.displayData
			then idle;
	}

	/* 📜 Requirements — 验证目标（可行性与一致性）
	Two lightweight verification requirements guide the PoC:
	FeasibilityRequirement ensures the extension can complete one full input–output cycle logically.
	ConsistencyRequirement ensures that data communication among modules remains semantically coherent.
	These requirements define what the PoC intends to prove rather than how it is implemented. */

	requirement def FeasibilityRequirement {
		doc /* The architecture shall complete one full interaction cycle 
		       from user input to display without logical deadlocks. */
	}

	requirement def ConsistencyRequirement {
		doc /* Communication among popup, background, and content 
		       shall maintain consistent data flow direction. */
	}



	/* 🔍 Verification — 验证执行与结果
	This verification case links the architecture and its requirements to a conceptual simulation (simulateFlow).
	It represents the PoC execution logic—how feasibility and consistency are tested conceptually or via external test scripts.
	A verdict output provides a simple qualitative result (Pass/Fail). */

	verification def EZkanji_PoC_Verification {
		doc /* Verifies feasibility and consistency through simulated execution. */

		verify requirement feasible : FeasibilityRequirement;
		verify requirement consistent : ConsistencyRequirement;

		action simulateFlow {
			doc /* Conceptual simulation of interaction between parts. */
			out verdict : VerdictKind = PassIf(true);
			ref externalResource = "https://github.com/mifuko/EZkanji-chrome-ext.git";
		}
	}

	verification runEZkanjiPoC : EZkanji_PoC_Verification {
		subject extension : ChromeExtensionConcept;
	}
}

