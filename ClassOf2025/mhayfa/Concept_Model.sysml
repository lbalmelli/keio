package 'conceptmodel' {

  public import ScalarValues::*;
  public import Base::*;

  // -------------------------
  // USERS
  // -------------------------
  part def Elderly {
    doc
    /*
      Older adult end-user. Primary interface is the Wearable module,
      but optionally uses the App or Website depending on tech-literacy.
    */
    port wearableConnection: String;
    port appConnection: String;
    port websiteConnection: String;
  }

  part def FamilyMember {
    doc
    /*
      Family member providing emotional/social connection and coordination.
      Uses App and Website with family-specific views.
    */
    port appConnection: String;
    port websiteConnection: String;
  }

  part def Volunteer {
    doc
    /*
      Community helper or volunteer who responds to service requests.
      Uses App and Website with volunteer-specific features.
    */
    port appConnection: String;
    port websiteConnection: String;
  }

  // -------------------------
  // DEVICES AND ROLES
  // -------------------------
  part def Wearable {
    doc
    /*
      Consumer smart glass module with real-time ai processor, camera and open-ear audio.
      Used by Elderly for capturing and receiving information.
      Hardware: Custom-built module to fit generic glasses
    */
    port userInterface: String;
    port bluetooth: String;

    action capturePhoto;
    action recordVoiceNote;
    action sendVoiceToApp;
    action receiveAudioPrompt;
    action notifyUser;
    action preprocessAI;

  }

  part def App {
    doc
    /*
      Unified application hosting both Family and Volunteer views.
      Software: Custom multi-role app, cross-platform.
    */
    port serverLink: String;
    port auth: String;
    port btLink: String;
    port uiContext: String;
    port aiQuery: String;
    port aiResult: String;

    action postprocessAi;
  }

  part def Website {
    doc
    /*
      Browser-accessible portal for Family and Volunteer features.
      Software: Responsive Web App
    */
    port serverLink: String;
    port auth: String;
    port uiContext: String;
  }

  part def Server {
    doc
    /*
      Cloud backend managing user accounts, media storage, volunteer matching, and sync.
      Service: AWS Cloud Storage + Custom Backend
    */
    port appAPI: String;
    port webAPI: String;
    port aiQuery: String;
    port aiResult: String;
  }

  part def AIService { 
    doc 
    /*
      AI Service for asynchronous processing.
      Used for asynchronous assistance, visual recognition, media queries.
    */
    port aiRequest: String;
    port aiResponse: String;

    action asynchronousAI;
  }

  part def AppFamily {
    doc
    /*
      Family member interface within the App.
      Allows media sharing, messaging, and visit scheduling.
    */
    port uiFamily: String;

    action uploadMedia;
    action sendMessage;
    action scheduleVisit;
    action browseVolunteers;
    action browseServices;
    action requestSupport;
    action viewCalendar;
    action manageProfile;
    action manageAccount;
    action managePayments;
    action queryAi;
  }

  part def AppVolunteer {
    doc
    /*
      Volunteer service interface within the App.
      Allows request viewing, visit coordination, and communication.
    */
    port uiVolunteer: String;

    action uploadMedia;
    action viewRequests;
    action acceptRequest; 
    action confirmAvailability;
    action chatWithFamily;
    action markVisitDone;
    action viewCalendar;
    action manageProfile;
    action manageAccount;
    action managePayouts;
  }

  part def WebsiteFamily {
    doc
    /*
      Web interface for family members.
      Mirrors AppFamily functionality.
    */
    port uiFamily: String;

    action uploadMedia;
    action requestSupport;
    action viewCalendar;
    action manageProfile;
    action manageAccount;
    action managePayments;
  }

  part def WebsiteVolunteer {
    doc
    /*
      Web interface for volunteers.
      Mirrors AppVolunteer functionality.
    */
    port uiVolunteer: String;

    action uploadMedia;
    action requestSupport;
    action viewCalendar;
    action manageProfile;
    action manageAccount;
    action managePayouts;
  }

  // -------------------------
  // CONTEXT SYSTEM
  // -------------------------
  part def ContextModel {
    part elderly           : Elderly;
    part family            : FamilyMember;
    part volunteer         : Volunteer;

    part wearable          : Wearable;
    part app               : App;
    part website           : Website;
    part server            : Server;
    part ai                : AIService;

    part appFamily         : AppFamily;
    part appVolunteer      : AppVolunteer;
    part websiteFamily     : WebsiteFamily;
    part websiteVolunteer  : WebsiteVolunteer;

    // USER CONNECTIONS VIA AUTHENTICATION
    connect elderly.appConnection to app.auth;
    connect elderly.websiteConnection to website.auth;

    connect family.appConnection to app.auth;
    connect family.websiteConnection to website.auth;

    connect volunteer.appConnection to app.auth;
    connect volunteer.websiteConnection to website.auth;

    // ELDERLY TO WEARABLE
    connect elderly.wearableConnection to wearable.userInterface;

    // BLUETOOTH COMMUNICATION
    connect wearable.bluetooth to app.btLink;
    connect app.btLink to wearable.bluetooth;

    // STRUCTURE CONTEXT VIA UI
    connect app.uiContext to appFamily.uiFamily;
    connect app.uiContext to appVolunteer.uiVolunteer;

    connect website.uiContext to websiteFamily.uiFamily;
    connect website.uiContext to websiteVolunteer.uiVolunteer;

    // SERVER CONNECTIONS
    connect app.serverLink to server.appAPI;
    connect server.appAPI to app.serverLink;
    connect website.serverLink to server.webAPI;
    connect  server.webAPI to website.serverLink;
    connect server.aiQuery to ai.aiRequest;
    connect ai.aiResponse to server.aiResult;
    connect app.aiQuery to ai.aiRequest;
    connect ai.aiResponse to app.aiResult;
  }

}