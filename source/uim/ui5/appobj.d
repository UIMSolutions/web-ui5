module uim.ui5.appobj;

import uim.ui5;

class DUI5AppObj {
	protected DData[string] properties;

	this() {}
	this(DUI5App myApp) { _app = myApp; }
	this(string someContent) { content = someContent; }
	this(DUI5App myApp, string someContent) { _app = myApp; content = someContent; }

	DUI5App _app;
	@property DUI5App app() { return _app; }
	@property void app(DUI5App newApp) { _app = newApp; if (_app) appid = _app.id; }

	mixin(DataProperty!("ID", "appid", true));
	mixin(DataProperty!("STRING", "content"));

	void opIndexAssign(T)(T newValue, string propName) {
		if (propName in properties) properties[propName].value = newValue; 
		properties[propName] = new DData("STRING", newValue); 
	}
	DData opIndex(string propName) {
		if (propName in properties) return properties[propName];
		return null;
	}
	O loadFrom(this O)(Database db, CachedResults.CachedRow row) {
		if (row) {
			appid = UUID(row["appid"].as!string);
			return cast(O)this;
		}
		return null;
	}

	override string toString() {
		return (content) ? content.toString : "";
	}
	string toJSON() {
		string[] values;
		foreach(k, v; properties) values ~= `"%s":%s`.format(k, v.toJSON);
		return "{ %s }".format(values.join(","));
	}
	string toSQLInsert(string table = "") {
		string[] values;
		string[] names;
		foreach(k, v; properties) {
			names ~= k;
			values ~= v.toSQL;
		}
		return "INSERT INTO %s (%s) VALUES(%s)".format(table, names.join(","), values.join(","));
	}
	string toSQLUpdate(string table = "") {
		string[] sets;
		string[] where;
		foreach(k, v; properties) {
			if (v.isKey) where ~= `(%s=%s)`.format(k, v.toSQL);
			else sets ~= `%s=%s`.format(k, v.toSQL);
		}
		return "UPDATE %s SET %s WHERE %s".format(table, sets.join(","), where.join(" AND "));
	}
}

unittest {

}
