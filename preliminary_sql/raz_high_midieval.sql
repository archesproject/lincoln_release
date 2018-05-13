CREATE OR REPLACE VIEW raz_high_midieval AS
  SELECT row_number() OVER () AS gid,
    mv.tileid,
    mv.resourceinstanceid,
    mv.nodeid,
    mv.geom,
    (name_tile.tiledata ->> '1c86845e-2c5a-11e8-89e4-0242ac120005'::text) AS name
   FROM ((mv_geojson_geoms mv
     LEFT JOIN tiles type_tile ON ((mv.resourceinstanceid = type_tile.resourceinstanceid)))
     LEFT JOIN tiles name_tile ON ((mv.resourceinstanceid = name_tile.resourceinstanceid)))
  WHERE (((type_tile.tiledata ->> 'd306e130-31ad-11e8-911f-0242ac120005'::text) = '40ec2887-8299-40a9-a38b-8cbb9a59e408'::text) AND ((name_tile.tiledata ->> '1c86845e-2c5a-11e8-89e4-0242ac120005'::text) IS NOT NULL))