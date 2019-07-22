module source.uim.ui5.xmlobj;

import uim.ui5; 

class DUI5XmlObj : DUI5AppObj {
	this() { super(); }
	this(DUI5App myApp) { super(myApp); }
	this(string someContent) { super(someContent); }
	this(DUI5App myApp, string someContent) { super(myApp, someContent); }
}

