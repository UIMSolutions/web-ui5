module uim.ui5.app;

import uim.ui5;

class DUI5App {
	protected DData[string] properties;

	this() {}

	mixin(TProperty!("UUID", "id"));
	mixin(TProperty!("string", "name"));
	mixin(TProperty!("string", "versionName"));
	mixin(TProperty!("int", "versionNo"));
	mixin(TProperty!("string", "type"));
	mixin(TProperty!("string", "title"));
	mixin(TProperty!("string", "description"));
	mixin(TProperty!("string", "rootPath"));

	mixin(TProperty!("DUI5Index", "index"));
	O index(this O)(string newContent) { _index = UI5Index.content(newContent); return cast(O)this; }

	mixin(TProperty!("DUI5Component", "component"));
	O component(this O)(string newContent) { _component = UI5Component.content(newContent); return cast(O)this; }

	mixin(TProperty!("DUI5Manifest", "manifest"));
	O manifest(this O)(string newContent) { _manifest = UI5Manifest.content(newContent); return cast(O)this; }

	mixin(TProperty!("DUI5Test", "test"));

	mixin(TProperty!("DUI5Controller[string]", "controllers"));
	O controller(this O)(string name, string newContent) { _controllers[name] = UI5Controller.content(newContent); return cast(O)this; }

	mixin(TProperty!("DUI5Control[string]", "controls"));
	O control(this O)(string name, string newContent) { _controls[name] = UI5Control.content(newContent); return cast(O)this; }

	mixin(TProperty!("DUI5Css[string]", "csss"));
	O css(this O)(string name, string newContent) { _csss[name] = UI5Css.content(newContent); return cast(O)this; }

	mixin(TProperty!("DUI5Data[string]", "datas"));
	O data(this O)(string name, string newContent) { _datas[name] = UI5Data.content(newContent); return cast(O)this; }

	mixin(TProperty!("DUI5Fragment[string]", "fragments"));
	O fragment(this O)(string name, string newContent) { _fragments[name] = UI5Fragment.content(newContent); return cast(O)this; }

	mixin(TProperty!("DUI5I18N[string]", "i18ns"));
	O i18n(this O)(string name, string newContent) { _i18ns[name] = UI5I18N.content(newContent); return cast(O)this; }

	mixin(TProperty!("DUI5Model[string]", "models"));
	O model(this O)(string name, string newContent) { _models[name] = UI5Model.content(newContent); return cast(O)this; }
	
	mixin(TProperty!("DUI5View[string]", "views"));
	O view(this O)(string name, string newContent) { _views[name] = UI5View.content(newContent); return cast(O)this; }

	mixin(TProperty!("string[string]", "files"));
	O files(this O)(string name, string path) { _files[name] = path; return cast(O)this; }

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

			File(tp~"index.html", "w").write(index.toString);
			if (component) File(tp~"Component.js", "w").write(component.toString);
			File(tp~"manifest.json", "w").write(manifest.toString);
			File(tp~"test.html", "w").write(test.toString);
		}
		return this;
	}

	void request(HTTPServerRequest req, HTTPServerResponse res) {
		auto path = req.path.replace(_rootPath, "");
		auto pathItems = path.split("/");

		if (pathItems.length > 0) {
			switch(pathItems[0]) {				
				case "index":
				case "index.html": index.request(req, res); break;
				case "manifest":
				case "manifest.json": manifest.request(req, res); break;
				case "Component":
				case "Component.js": component.request(req, res); break;
				default: 
					if (pathItems.length > 1) {
						auto type = pathItems[0];
						auto name = pathItems[1..$].join("/");
						switch(type) {
							case "controller": if (name in _controllers) _controllers[name].request(req, res); break;
							case "control": if (name in _controls) _controls[name].request(req, res); break;
							case "css": if (name in _csss) _csss[name].request(req, res); break;
							case "fragment": if (name in _fragments) _fragments[name].request(req, res); break;
							case "i18n": if (name in _i18ns) _i18ns[name].request(req, res); break;
							case "model": 
								if (name in _models) _models[name].request(req, res); 
								if (name in _datas) _datas[name].request(req, res); break;
							case "view": if (name in _views) _views[name].request(req, res); break;
							default: break;
						}
					}
				break;
			}
		}
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
	app.index = new DUI5Index(app, `<!DOCTYPE html>
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