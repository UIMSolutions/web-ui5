module uim.ui5.css;

import uim.ui5;

class DUI5Css : DUI5AppObj {
	this() { super(); }
	this(DUI5App myApp) { super(myApp); }
	this(string someContent) { super(someContent); }
	this(DUI5App myApp, string someContent) { super(myApp, someContent); }

	O loadFrom(this O)(Database db, CachedResults.CachedRow row) {
		if (row) {
			return cast(O)this;
		}
		return null;
	}
}
auto UI5Css() { return new DUI5Css; }

unittest {
	auto css = UI5Css;
}
