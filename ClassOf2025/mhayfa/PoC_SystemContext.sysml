package pocsystem {

  public import pocwearable::*;
  public import conceptmodel::*;

  doc /*
    System-level PoC integration package.
    Includes PoC_Wearable, App, Server, Website, and AIService for data flow modeling and AI-assisted features.
  */

  part def PoCSystem {
    part wearable: PoC_Wearable {
    port btLink: String;
    }
    part app: App {
      port btLink: String;
      port serverAPI: String;
      port aiQuery: String;
      port aiResult: String;
    }
    part server: Server {
      port apiEndpoint: String;
      port aiQuery: String;
      port aiResult: String;
    }
    part website: Website {
      port apiEndpoint: String;
    }
    part ai: AIService {
       doc /*
      Logical AI/LLM processing unit used by App and Server.
      Provides OCR post-processing and assistive prompt generation for non-realtime taks. 
      Realtime services are handled by wearable device AI Module.
    */
      port aiRequest: String;
      port aiResponse: String;
    }

    connect app.serverAPI to server.apiEndpoint;
    connect server.apiEndpoint to app.serverAPI;

    connect website.apiEndpoint to server.apiEndpoint;
    connect server.apiEndpoint to website.apiEndpoint;

    connect app.aiQuery to ai.aiRequest;
    connect ai.aiResponse to app.aiResult;

    connect server.aiQuery to ai.aiRequest;
    connect ai.aiResponse to server.aiResult;

    connect wearable.btLink to app.btLink;
    connect app.btLink to wearable.btLink;

  }
}