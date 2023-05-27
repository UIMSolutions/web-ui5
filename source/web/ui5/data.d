module web.ui5.data;

import web.ui5;

class DUI5Data : DUI5AppObj {
	this() { super(); }
	this(DUI5App myApp) { super(myApp); }
	this(string someContent) { super(someContent); }
	this(DUI5App myApp, string someContent) { super(myApp, someContent); }

	this(DUI5App myApp, string[string] newDependencies, string someContent) { this(myApp, someContent); _dependencies = newDependencies; }

	mixin(DataProperty!("STRING", "extend"));
	mixin(DataProperty!("STRING", "name"));
	mixin(OProperty!("string[string]", "dependencies"));

	string fullName() { return ((_app) ? _app.name~".controller."~name:name); }

	void request(HTTPServerRequest req, HTTPServerResponse res) {
		res.writeBody(toString, "text/json");
	}
	override string toString() {
		return (_content) ? _content : "";
	}
}
auto UI5Data() { return new DUI5Data; }

unittest {
}