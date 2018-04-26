CREATE OR REPLACE VIEW monument_listed_building AS
  SELECT row_number() OVER () AS gid,
    mv.tileid,
    mv.resourceinstanceid,
    mv.nodeid,
    mv.geom,
    (name_tile.tiledata ->> 'e4b37f8a-343a-11e8-ab89-dca90488358a'::text) AS name,
	(type_tile.tiledata ->> 'e4b4cd17-343a-11e8-84b5-dca90488358a') AS protection
   FROM ((mv_geojson_geoms mv
     LEFT JOIN tiles type_tile ON ((mv.resourceinstanceid = type_tile.resourceinstanceid)))
	 LEFT JOIN tiles name_tile ON ((mv.resourceinstanceid = name_tile.resourceinstanceid)))
  WHERE (((type_tile.tiledata ->> 'e4b4cd17-343a-11e8-84b5-dca90488358a'::text) = '["fd19a2aa-7de0-4237-a7d0-99200590e3da"]'::text) AND ((name_tile.tiledata ->> 'e4b37f8a-343a-11e8-ab89-dca90488358a'::text) IS NOT NULL));