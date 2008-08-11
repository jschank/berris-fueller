CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "vehicles" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255) DEFAULT NULL NULL, "make" varchar(255) DEFAULT NULL NULL, "model" varchar(255) DEFAULT NULL NULL, "year" integer DEFAULT NULL NULL, "miles" integer DEFAULT NULL NULL, "created_at" datetime DEFAULT NULL NULL, "updated_at" datetime DEFAULT NULL NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20080811051638');