module uim.ui5.view;

import uim.ui5;

class DUI5View : DUI5AppObj {
	this() { super(); }
	this(DUI5App myApp) { super(myApp); }
	this(string someContent) { super(someContent); }
	this(DUI5App myApp, string someContent) { super(myApp, someContent); }

	mixin(OProperty!("string", "name"));
	mixin(OProperty!("DUI5Controller", "controller"));
	mixin(OProperty!("string[string]", "nameSpaces"));

/*
	O loadFrom(this O)(Database db, UUID appid, string name) {
		foreach(row; db.execute("SELECT * FROM fragments WHERE (id = '%s') AND (name = '%s')".format(id, name)).cached) {
			return loadFrom(db, row);
		}
		return null;
	}
	O loadFrom(this O)(Database db, CachedResults.CachedRow row) {
		if (row) {
			name = row["name"].as!string;
			return cast(O)this;
		}
		return null;
	} */

	string xmlView() {
		string[] ns;
		foreach(k, v; nameSpaces) {
			if (v != "") ns ~= `xmlns:%s="%s"`.format(v, k);
			else ns ~= `xmlns="%s"`.format(k);
		}

		string c = (content) ? content.toString : ""; 
		return `<mvc:View controllerName="`~controller.fullName~`" `~ns.join(" ")~`>`
			~c~
`</mvc:View>`;
	}
	string jsonView() {
		return "";
	}
	string jsView() {
		return "";
	}
	string htmlView() {
		return "";
	}
	override string toString() {
		return super.toString;
	}
}
auto UI5View() { return new DUI5View; }

unittest {
	auto view = UI5View;
}
