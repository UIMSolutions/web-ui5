module uim.ui5._index;

import uim.ui5;

class DUI5Index : DUI5AppObj {
	this() { super(); }
	this(DUI5App myApp) { super(myApp); }
	this(string someContent) { super(someContent); }
	this(DUI5App myApp, string someContent) { super(myApp, someContent); }
}
auto UI5Index() { return new DUI5Index; }

unittest {
	auto idx = UI5Index; 
}
