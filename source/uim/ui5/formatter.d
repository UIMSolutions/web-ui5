module web.ui5.formatter;

import web.ui5;

class DUI5Formatter : DUI5AppObj {
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
auto UI5Formatter() { return new DUI5Formatter; }

unittest {
	auto formatter = UI5Formatter; 
}
