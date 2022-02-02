module source.uim.ui5.apps.i18n;

import uim.ui5;

class DUI5I18N  : DUI5AppObj {
	this() { super(); }
	this(DUI5App myApp) { super(myApp); }
	this(string someContent) { super(someContent); }
	this(DUI5App myApp, string someContent) { super(myApp, someContent); }

	/*
	O loadFrom(this O)(Database db, CachedResults.CachedRow row) {
		if (row) {
			return cast(O)this;
		}
		return null;
	}
	*/

	void request(HTTPServerRequest req, HTTPServerResponse res) {
		res.writeBody(toString, "text/plain");
	}
	override string toString() {
		return (_content) ? _content : "";
	}
}
auto UI5I18N() { return new DUI5I18N; }

unittest {
	auto i18n = UI5I18N;
}
