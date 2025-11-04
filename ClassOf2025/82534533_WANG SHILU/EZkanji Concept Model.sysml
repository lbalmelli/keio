package EZkanjiConceptModel {

	package ConceptDefinitions {

// Conceptual layer EZkanjiExtensionConcept

		part def ChromeExtensionConcept {
			doc /* Conceptual model of the EZkanji browser extension.
			       It enhances webpages with Japanese Furigana annotations. 
				   用户输入通过 userInput 进入；输出通过 displayOutput 到前端显示。
				   这就是一个概念层的定义，没有指定 Chrome API、Manifest、JavaScript 文件等实现细节。*/

			port userInput : UserEventPort;
			port displayOutput : DisplayPort;

			part content : ContentScriptConcept;
			part background : BackgroundControllerConcept;
			part popup : PopupUIConcept;

			interface contentToBackground connect 
				content.contentChannel to background.contentLink;
/*这个交互通常是 Chrome 扩展结构中最典型的一个：
content script 在网页里执行；
background script 在扩展后台执行；
两者之间通过消息通道（chrome.runtime.sendMessage）通信。
✅ 表示 网页前端脚本 → 后台逻辑 的数据流。
*/
			interface popupToBackground connect 
				popup.popupChannel to background.popupLink;

/*通常用于：
用户在 popup 里执行某个动作；
由后台逻辑处理并返回数据。
✅ 表示 UI 弹窗 ↔ 后台逻辑 的交互。*/

			interface popupToDisplay connect 
				popup.popupChannel to displayOutput;
		}

		part def ContentScriptConcept {
			doc /* Embedded in webpages; analyzes Japanese text and provides annotated results. */

			port contentChannel : ContentPortConcept;
			action def analyzeText;
			action def addFurigana;
		}

		part def BackgroundControllerConcept {
			doc /* Coordinates content and popup communication; handles logic and permissions. */

			port contentLink : BackgroundPortConcept;
			port popupLink : BackgroundPortConcept;
			action def relayMessages;
			action def manageSettings;
		}

		part def PopupUIConcept {
			doc /* Popup interface for user control and system feedback. */

			port popupChannel : PopupPortConcept;
			action def showSettings;
			action def toggleExtension;
		}

/* -------------------------------------------------------------------
   Conceptual architecture overview:
   - BackgroundControllerConcept acts as the message hub (logic center).
   - PopupUIConcept serves as the user interaction entry point (UI layer).
   - ContentScriptConcept functions as the web content analyzer (execution layer).
   - DisplayPort represents the system output interface (result presentation).
   ------------------------------------------------------------------- */

/* Modeling rationale:
   - Multiple part defs represent distinct system roles and logical layers.
   - Multiple port defs represent different types of data flows (communication contracts).
   - Multiple action defs capture the internal responsibilities and behaviors of each module.
*/

		/* --- Abstract conceptual ports --- */
		port def ContentPortConcept {
			in textFromPage : String;
			out annotatedText : String;
		}

		port def BackgroundPortConcept {
			in messageIn : String;
			out messageOut : String;
		}

		port def PopupPortConcept {
			in userAction : String;
			out uiUpdate : String;
		}

		port def UserEventPort {
			in userEvent : String;
		}

		port def DisplayPort {
			out displayData : String;
		}
	}

	package ConceptUsage {
		import ConceptDefinitions::*;

		/* instantiate the concept without redefining internal structure */
		part EZkanjiExtensionConcept : ChromeExtensionConcept;
	}
}
