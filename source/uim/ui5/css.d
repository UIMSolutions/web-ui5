module web.ui5.css;

import web.ui5;

class DUI5Css : DUI5AppObj {
	this() { super(); }
	this(DUI5App myApp) { super(myApp); }
	this(string someContent) { super(someContent); }
	this(DUI5App myApp, string someContent) { super(myApp, someContent); }

	void request(HTTPServerRequest req, HTTPServerResponse res) {
		res.writeBody(toString, "text/css");
	}
	override string toString() {
		return (_content) ? _content : "";
	}
}
auto UI5Css() { return new DUI5Css; }

unittest {
	auto css = UI5Css;
}
