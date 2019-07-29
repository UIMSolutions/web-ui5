module uim.ui5.model;

import uim.ui5;

class DUI5Model : DUI5AppObj {
	this() { super(); }
	this(DUI5App myApp) { super(myApp); }
	this(string someContent) { super(someContent); }
	this(DUI5App myApp, string someContent) { super(myApp, someContent); }

	this(DUI5App myApp, string[string] newDependencies, string someContent) { this(myApp, someContent); _dependencies = newDependencies; }

	mixin(DataProperty!("STRING", "name"));
	mixin(DataProperty!("STRING", "extend"));
	mixin(OProperty!("string[string]", "dependencies"));

	string fullName() { return ((_app) ? _app.name~".controller."~name:name); }

	void request(HTTPServerRequest req, HTTPServerResponse res) {
		res.writeBody(toString, "text/javascript");
	}
	override string toString() {
		return (_content) ? _content : "";
	}
}
auto UI5Model() { return new DUI5Model; }
auto UI5Model(string someContent) { return new DUI5Model(someContent); }

unittest {
}