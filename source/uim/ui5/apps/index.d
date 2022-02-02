module uim.ui5.apps.index;

import uim.ui5;

class DUI5Index : DUI5AppObj {
	this() { super(); }
	this(DUI5App myApp) { super(myApp); }
	this(string someContent) { super(someContent); }
	this(DUI5App myApp, string someContent) { super(myApp, someContent); }

	void request(HTTPServerRequest req, HTTPServerResponse res) {
		res.writeBody(toString, "text/html");
	}
	override string toString() {
		return (_content) ? _content : "";
	}
}
auto UI5Index() { return new DUI5Index; }

unittest {
	auto idx = UI5Index; 
}
