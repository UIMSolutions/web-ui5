module uim.ui5.app;

import std.uuid;
import uim.ui5;

class DUI5App {
	protected DData[string] properties;

	this() {}

	mixin(DataProperty!("UUID", "id"));
	mixin(DataProperty!("string", "name"));
	mixin(DataProperty!("string", "versionName"));
	mixin(DataProperty!("int", "versionNo"));
	mixin(DataProperty!("string", "type"));
	mixin(DataProperty!("string", "title"));
	mixin(DataProperty!("string", "description"));

	mixin(OProperty!("DUI5Index", "idx"));
	mixin(OProperty!("DUI5Component", "component"));
	mixin(OProperty!("DUI5Manifest", "manifest"));
	mixin(OProperty!("DUI5Test", "test"));

	mixin(OProperty!("DUI5Controller[string]", "controllers"));
	mixin(OProperty!("DUI5Fragment[string]", "fragments"));
	mixin(OProperty!("DUI5View[string]", "views"));

	void opIndexAssign(T)(T newValue, string propName) {
		if (propName in properties) properties[propName].value = newValue; 
		properties[propName] = new DData("STRING", newValue); 
	}
	DData opIndexAssign(string propName) {
		if (propName in properties) return properties[propName];
		return null;
	}

	/* auto loadFrom(Database db, UUID anId) {
		foreach(row; db.execute("SELECT * FROM apps WHERE (id = '%s')".format(anId)).cached) {
			loadFrom(db, row);
		}
		return this;
	}
	auto loadFrom(Database db, CachedResults.CachedRow row) {
		if (row) {
			id = row["id"].as!string;
			name = row["name"].as!string;
			versionName = row["version"].as!string;
			versionNo = row["versionno"].as!int;
			type = row["type"].as!string;
			title = row["title"].as!string;
			description = row["description"].as!string;

			foreach(cRow; db.execute("SELECT * FROM controllers WHERE (id = '%s')".format(id)).cached) {
				if (auto controller = UI5Controller.loadFrom(db, cRow)) controllers[controller.name] = controller;
			}
			foreach(vRow; db.execute("SELECT * FROM views WHERE (id = '%s')".format(id)).cached) {
				if (auto view = UI5View.loadFrom(db, vRow)) views[view.name] = view;
			}
			foreach(fRow; db.execute("SELECT * FROM fragments WHERE (id = '%s')".format(id)).cached) {
				if (auto fragment = UI5Fragment.loadFrom(db, fRow)) fragments[fragment.name] = fragment;
			}
			return this;
		}
		return null;
	} */

	auto exportToPath(string targetPath) {
		if (targetPath) {
			string tp = (std.string.endsWith(targetPath, "/")) ? targetPath : targetPath~"/";
			if (!exists(tp)) mkdirRecurse(tp);

			mkdir(tp~"controller");
			foreach(c; controllers) { File(tp~"controller/"~c.name~".controller.js", "w").write(c.toString); }
			mkdir(tp~"i18n");
			//foreach(i; i18ns) { File(tp~"i18n/i18n_"~i.language~".js", "w").write(i.toString); }
			mkdir(tp~"fragment");
			// foreach(f; fragments) { File(tp~"fragment/"~f.name~".fragment.js", "w").write(f.toString); }
			mkdir(tp~"localService");
			mkdir(tp~"model");
			mkdir(tp~"test");
			mkdir(tp~"util");
			mkdir(tp~"view");
			foreach(v; views) { File(tp~"view/"~v.name~".view.js", "w").write(v.toString); }
			mkdir(tp~"css");
			// foreach(c; css) { File(tp~"css/"~c.name~".css", "w").write(c.toString); }

			File(tp~"index.html", "w").write(idx.toString);
			if (component) File(tp~"Component.js", "w").write(component.toString);
			File(tp~"manifest.json", "w").write(manifest.toString);
			File(tp~"test.html", "w").write(test.toString);
		}
		return this;
	}

	override string toString() {
		return `id = %s
name = %s
versionName = %s
versionNo = %s`.format(id, name, versionName, versionNo);
	}
}
auto UI5App() { return new DUI5App; }

unittest {
	auto app = UI5App;
	app.idx = new DUI5Index(app, `<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta charset="utf-8">
		<title>SAPUI5 Walkthrough</title>
		<script
			id="sap-ui-bootstrap"
			src="https://sapui5.hana.ondemand.com/resources/sap-ui-core.js"
			data-sap-ui-theme="sap_belize"
			data-sap-ui-modules="sap.m.library"
			data-sap-ui-compatVersion="edge"
			data-sap-ui-preload="async" >
		</script>
		<script>
			sap.ui.getCore().attachInit(function () {
				new sap.m.Text({
					text : "SAPUI5 is loaded successfully!"
				}).placeAt("content");
			});
		</script>
	</head>
	<body class="sapUiBody" id="content">
	</body>
</html>`);

	app.component = new DUI5Component(app, `sap.ui.define(['jquery.sap.global', 'sap/ui/core/UIComponent'],
	function(jQuery, UIComponent) {
	"use strict";

	var Component = UIComponent.extend("samples.components.sample.Component", {
		metadata : {
			manifest : "json"
		}
	});
	return Component;
});`);

	app.manifest = new DUI5Manifest(app, `<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta charset="utf-8">
		<title>SAPUI5 Walkthrough</title>
		<script
			id="sap-ui-bootstrap"
			src="https://sapui5.hana.ondemand.com/resources/sap-ui-core.js"
			data-sap-ui-theme="sap_belize"
			data-sap-ui-modules="sap.m.library"
			data-sap-ui-compatVersion="edge"
			data-sap-ui-preload="async" >
		</script>
		<script>
			sap.ui.getCore().attachInit(function () {
				new sap.m.Text({
					text : "SAPUI5 is loaded successfully!"
				}).placeAt("content");
			});
		</script>
	</head>
	<body class="sapUiBody" id="content">
	</body>
</html>`);

	app.test = new DUI5Test(app, `<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta charset="utf-8">
		<title>SAPUI5 Walkthrough</title>
		<script
			id="sap-ui-bootstrap"
			src="https://sapui5.hana.ondemand.com/resources/sap-ui-core.js"
			data-sap-ui-theme="sap_belize"
			data-sap-ui-modules="sap.m.library"
			data-sap-ui-compatVersion="edge"
			data-sap-ui-preload="async" >
		</script>
		<script>
			sap.ui.getCore().attachInit(function () {
				new sap.m.Text({
					text : "SAPUI5 is loaded successfully!"
				}).placeAt("content");
			});
		</script>
	</head>
	<body class="sapUiBody" id="content">
	</body>
</html>`);

	app.exportToPath("/home/ozan/ui5/test1");
	app.exportToPath("/home/ozan/ui5/test2/");

}