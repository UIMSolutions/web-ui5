module uim.ui5.controller;

import uim.ui5;

class DUI5Controller : DUI5AppObj {
	this() { super(); }
	this(DUI5App myApp) { super(myApp); }
	this(string someContent) { super(someContent); }
	this(DUI5App myApp, string someContent) { super(myApp, someContent); }

	this(DUI5App myApp, string[string] newDependencies, string someContent) { this(myApp, someContent); _dependencies = newDependencies; }

	mixin(DataProperty!("STRING", "name"));
	mixin(DataProperty!("STRING", "extend"));
	mixin(OProperty!("string[string]", "dependencies"));

	string fullName() { return ((_app) ? _app.name~".controller."~name:name); }

	/* 
	O loadFrom(this O)(Database db, CachedResults.CachedRow row) {
		if (row) {
			return cast(O)this;
		}
		return null;
	}
	*/

	/* override string toString() {
		string[] names;
		string[] modules;
		foreach(name; dependencies.keys.sort.array) {
			names ~= "%s".format(name);
			modules ~= "'%s'".format(dependencies[name]);
		}

		string c = (_content) ? _content : ""; 
		return jsFCall("sap.ui.define", [
			jsArray(modules), 
			jsFunc(names, `"use strict";return `~extend~jsOCall("extend", [fullName, jsBlock(c)])~`;`)
			]~";");
	} */

	void request(HTTPServerRequest req, HTTPServerResponse res) {
		res.writeBody(toString, "text/javascript");
	}
	override string toString() {
		return (_content) ? _content : "";
	}
}
auto UI5Controller() { return new DUI5Controller; }
auto UI5Controller(string someContent) { return new DUI5Controller(someContent); }

unittest {
	writeln("\n Start testing uim.ui5.controller");
	auto controller = UI5Controller;
	writeln("End testing uim.ui5.controller\n");
}