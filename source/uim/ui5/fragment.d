module uim.ui5.fragment;

import uim.ui5;

class DUI5Fragment : DUI5AppObj {
	this() { super(); }
	this(DUI5App myApp) { super(myApp); }
	this(string someContent) { super(someContent); }
	this(DUI5App myApp, string someContent) { super(myApp, someContent); }

	mixin(DataProperty!("string", "name", true));

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
	}
}
auto UI5Fragment() { return new DUI5Fragment; }

unittest {
	auto fragment = UI5Fragment;
}