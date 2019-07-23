module uim.ui5.manifest;

import uim.ui5;

class DUI5Manifest  : DUI5AppObj {
	this() { super(); }
	this(DUI5App myApp) { super(myApp); }
	this(string someContent) { super(someContent); }
	this(DUI5App myApp, string someContent) { super(myApp, someContent); }

	/* O loadFrom(this O)(Database db, CachedResults.CachedRow row) {
		if (row) {
			return cast(O)this;
		}
		return null;
	} */ 

	/*
	string opIndex(string name) {
		switch(name) {
			case "_version": return `"1.5.0"`;
			case "sap.app": return `{
				"id": "demo.rd.businesspartner",
				"type": "application",
				"i18n": "i18n/i18n.properties",
				"applicationVersion": {
					"version": "1.0.0"
				},
				"title": "{{appTitle}}",
				"description": "{{appDescription}}",
				"sourceTemplate": {
					"id": "servicecatalog.connectivityComponent",
					"version": "0.0.0"
				},
				"dataSources": {
					"GWSAMPLE_BASIC": {
						"uri": "/sap/opu/odata/iwbep/GWSAMPLE_BASIC/",
						"type": "OData",
						"settings": {
							"odataVersion": "2.0",
							"localUri": "localService/metadata.xml"
						}
					}
				}
			}`; break;
			case "sap.ui": return `{
				"technology": "UI5",
				"icons": {
					"icon": "",
					"favIcon": "",
					"phone": "",
					"phone@2": "",
					"tablet": "",
					"tablet@2": ""
				},
				"deviceTypes": {
					"desktop": true,
					"tablet": true,
					"phone": true
				},
				"supportedThemes": [
					"sap_hcb",
					"sap_belize"
				]
			}`; break;
			case "sap.ui5": return `{
				"_version": "1.1.0",
				"rootView": {
					"viewName": "demo.rd.businesspartner.view.App",
					"type": "XML"
				},
				"routing": {
					"config": {
						"routerClass": "sap.m.routing.Router",
						"controlId": "rootControl",
						"viewPath": "demo.rd.businesspartner.view",
						"viewType": "XML",
						"async": true,
						"bypassed": {
							"target": [
								"notFound",
								"master"
							]
						}
					},
					"routes": [
						{
							"pattern": "",
							"name": "main",
							"target": [
								"detail",
								"master"
							]
						},
						{
							"name": "detail",
							"pattern": "BusinessPartner/{BusinessPartnerID}",
							"greedy": false,
							"target": [
								"master",
								"detail"
							]
						}
					],
					"targets": {
						"master": {
							"viewName": "Master",
							"controlAggregation": "masterPages"
						},
						"detail": {
							"viewName": "Detail",
							"controlAggregation": "detailPages"
						},
						"notFound": {
							"transition": "flip",
							"viewName": "NotFound",
							"controlId": "rootControl",
							"controlAggregation": "detailPages"
						},
						"businessPartnerNotFound": {
							"viewName": "BusinessPartnerNotFound",
							"controlId": "rootControl",
							"controlAggregation": "detailPages"
						}
					}
				},
				"dependencies": {
					"minUI5Version": "1.40.0",
					"libs": {
						"sap.ui.core": {},
						"sap.m": {},
						"sap.ui.layout": {}
					}
				},
				"contentDensities": {
					"compact": true,
					"cozy": true
				},
				"models": {
					"i18n": {
						"type": "sap.ui.model.resource.ResourceModel",
						"settings": {
							"bundleName": "demo.rd.businesspartner.i18n.i18n"
						}
					},
					"": {
						"dataSource": "GWSAMPLE_BASIC",
						"settings": {
							"metadataUrlParams": {
								"sap-documentation": "heading, quickinfo"
							}
						}
					}
				},
				"resources": {
					"css": [
						{
							"uri": "css/style.css"
						}
					]
				}
			}`; break;
			case "sap.platform.hcp": `{
				"uri": "webapp",
				"_version": "1.1.0"				
			}`; break;
			default: return "";
		}
	} */
	override string toString() {
		string[] values;
		values ~= "_version: %s".format(this["_version"]);
		values ~= "sap.app: %s".format(this["sap.app"]);
		values ~= "sap.ui: %s".format(this["sap.ui"]);
		values ~= "sap.ui5: %s".format(this["sap.ui5"]);
		values ~= "sap.platform.hcp: %s".format(this["sap.platform.hcp"]);

		return "{ %s }".format(values.join(","));
	}
}
auto UI5Manifest() { return new DUI5Manifest(); }

unittest {
	auto manifest = UI5Manifest;
	writeln(manifest);
}

