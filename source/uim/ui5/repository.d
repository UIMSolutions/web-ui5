module uim.ui5.repository;

import std.uuid;
import uim.ui5;

class DUI5Repository {
	this() {}

	/* DUI5App loadAppFromDB(Database db, string name) {
		if (auto count = db.execute("SELECT count(*) FROM apps WHERE (name = '%s')".format(name)).oneValue!long) {
			// one or more apps with the same name -> different versions 
			auto maxVersion = db.execute("SELECT max(versionno) FROM apps WHERE (name = '%s')".format(name)).oneValue!long; 
			DUI5App app;
			foreach(row; db.execute("SELECT * FROM apps WHERE (name = '%s') AND (versionno = %s)".format(name, maxVersion)).cached) {
				app = UI5App.loadFrom(db, UUID(row[0].as!string));
			}		
			return app;
		}
		return null;
	}

	DUI5App loadAppFromDB(Database db, string name, string aVersion) {
		DUI5App app;
		foreach(row; db.execute("SELECT id FROM apps WHERE (name = '%s') AND (version = '%s')".format(name, aVersion)).cached) {
			return UI5App.loadFrom(db, UUID(row[0].as!string));
		}
		return null;
	}

	DUI5App loadAppFromDB(Database db, UUID id) {
		if (auto count = db.execute("SELECT count(*) FROM apps WHERE (id = '%s')".format(id)).oneValue!long) {
			DUI5App app;
			foreach(row; db.execute("SELECT * FROM apps WHERE (id = '%s')".format(id)).cached) {
				return UI5App.loadFrom(db, UUID(row[0].as!string));
			}		
		}
		return null;
	} */
}
auto UI5Repository() { return new DUI5Repository; }

unittest {
/*	UI5Repository.loadAppFromDB(Database("ui5.db"), "uim.app.test");
	UI5Repository.loadAppFromDB(Database("ui5.db"), "uim.app.test", "0.0.1");
	auto app = UI5Repository.loadAppFromDB(Database("ui5.db"), UUID("433748c8-4590-4d1f-9af5-780be03eab14"));
*/
//		writeln(app);
}
