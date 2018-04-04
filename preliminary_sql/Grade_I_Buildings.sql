create view Grade_I_Buildings as
select row_number() over () as gid
	,mv.*
	-- name node id: 677f303d-09cc-11e7-9aa6-6c4008b05c4c
	,name_tile.tiledata->>'677f303d-09cc-11e7-9aa6-6c4008b05c4c'as name,
    'Grade I Listed Building' as Protection
from mv_geojson_geoms mv
left join tiles type_tile
	on mv.resourceinstanceid = type_tile.resourceinstanceid
left outer join tiles name_tile
	on mv.resourceinstanceid = name_tile.resourceinstanceid
	-- name type node id: 677f39a8-09cc-11e7-834a-6c4008b05c4c
	-- primary concept id: 866e8d3b-e00a-4559-bf23-dc1812c27e1f
	--and name_tile.tiledata->>'677f39a8-09cc-11e7-834a-6c4008b05c4c'
	--	= '866e8d3b-e00a-4559-bf23-dc1812c27e1f'
-- record type node id: 677f2c0f-09cc-11e7-b412-6c4008b05c4c
-- structure concept id: 3cf28c22-7271-4bd8-a7da-6e6c45ca4c13
where type_tile.tiledata->> '4ca32698-fa12-11e6-9e3e-026d961c88e6' = 'bc908dbc-45ff-426c-8713-f622907730ab'
and
name_tile.tiledata->>'677f303d-09cc-11e7-9aa6-6c4008b05c4c' is not null
;