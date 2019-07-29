module uim.ui5.control;

import uim.ui5;

class DUI5Control : DUI5AppObj {
	this() { super(); }
	this(DUI5App myApp) { super(myApp); }
	this(string someContent) { super(someContent); }
	this(DUI5App myApp, string someContent) { super(myApp, someContent); }

	mixin(DataProperty!("STRING", "name"));

	string fullName() { return ((_app) ? _app.name~".Control."~name:name); }

	void request(HTTPServerRequest req, HTTPServerResponse res) {
		res.writeBody(toString, "text/javascript");
	}
	override string toString() {
		return (_content) ? _content : "";
	}
}
auto UI5Control() { return new DUI5Control; }
auto UI5Control(string someContent) { return new DUI5Control(someContent); }

unittest {
}