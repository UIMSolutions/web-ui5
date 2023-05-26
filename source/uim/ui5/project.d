module web.ui5.project;

import web.ui5;

class DUI5Project  : DUI5AppObj {
	this() { super(); }
	this(DUI5App myApp) { super(myApp); }
	this(string someContent) { super(someContent); }
	this(DUI5App myApp, string someContent) { super(myApp, someContent); }

/*
	string opIndex(string name) {
		switch(name) {
			case "projectType": return `[
				"sap.watt.uitools.ide.fiori",
				"com.watt.common.builder.sapui5clientbuild"
		  	]`;
			case  "build": return `{
				"targetFolder": "dist",
				"sourceFolder": "webapp",
				"buildRequired": false,
				"lastBuildDateTime": "Mon, 27 Mar 2017 14:44:14 GMT"
			}`;
			case "generation": return `[
		    {
		      "templateId": "ui5template.basicSAPUI5ApplicationProject",
		      "templateVersion": "1.40.12",
		      "dateTimeStamp": "Mon, 27 Mar 2017 11:36:03 GMT"
		    },
		    {
		      "templateId": "servicecatalog.connectivityComponent",
		      "templateVersion": "0.0.0",
		      "dateTimeStamp": "Mon, 27 Mar 2017 13:48:20 GMT"
		    },
		    {
		      "templateId": "ui5template.basicSAPUI5ApplicationComponent",
		      "templateVersion": "1.4.0",
		      "dateTimeStamp": "Mon, 27 Mar 2017 13:54:03 GMT"
		    }
		  ]`;
		  case "codeCheckingTriggers": return `{
		    "notifyBeforePush": true,
		    "notifyBeforePushLevel": "Error",
		    "blockPush": false,
		    "blockPushLevel": "Error"
		  }`;
		  case "translation": `{
		    "translationDomain": "",
		    "supportedLanguages": "en,fr,de",
		    "defaultLanguage": "en",
		    "defaultI18NPropertyFile": "i18n.properties",
		    "resourceModelName": "i18n"
		  }`;
		  case "basevalidator": return `{
		    "services": {
		      "xml": "fioriXmlAnalysis",
		      "js": "fioriJsValidator"
		    }
		  }`;
		  case "mockpreview": return `{
		    "mockUri": "/sap/opu/odata/iwbep/GWSAMPLE_BASIC",
		    "metadataFilePath": "",
		    "loadJSONFiles": false,
		    "loadCustomRequests": false,
		    "mockRequestsFilePath": ""
		  }`;
		  case "hybrid": return `{
		    "backendDestination": "es4"
		  }`;
		  case "hcpdeploy": return `{
		    "account": "d055894trial",
		    "name": "businesspartner",
		    "lastVersionWeTriedToDeploy": "1.0.0"
		  }`;
		  default: return "";
		}
	}
	*/
}