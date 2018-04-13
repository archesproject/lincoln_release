SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
BEGIN;
INSERT INTO map_layers(maplayerid, name, layerdefinitions, isoverlay, icon, activated, addtomap)
   VALUES (public.uuid_generate_v1mc(), 'Search Results Heat Map', '[
        {
           "id": "search-results-heat",
           "maxzoom": 17,
           "minzoom": 9,
           "type": "heatmap",
           "source": "search-results-hashes",
           "paint": {
               "heatmap-weight": [
                   "interpolate", [
                       "linear"
                   ],
                   [
                       "get",
                       "doc_count"
                   ],
                   0,
                   0,
                   6,
                   1
               ],
               "heatmap-intensity": [
                   "interpolate", [
                       "linear"
                   ],
                   [
                       "zoom"
                   ],
                   0,
                   1,
                   25,
                   10
               ],
               "heatmap-color": [
                   "interpolate", [
                       "linear"
                   ],
                   [
                       "heatmap-density"
                   ],
                   0,
                   "rgba(33,102,172,0)",
                   0.2,
                   "rgb(103,169,207)",
                   0.4,
                   "rgb(209,229,240)",
                   0.6,
                   "rgb(253,219,199)",
                   0.8,
                   "rgb(239,138,98)",
                   1,
                   "rgb(178,24,43)"
               ],
               "heatmap-radius": [
                   "interpolate", [
                       "linear"
                   ],
                   [
                       "zoom"
                   ],
                   0,
                   2,
                   25,
                   75
               ],
               "heatmap-opacity": 0.6
           }
       }
   ]', TRUE, 'ion-search', TRUE, FALSE);



INSERT INTO map_layers(maplayerid, name, layerdefinitions, isoverlay, icon, activated, addtomap)
   VALUES (public.uuid_generate_v1mc(), 'Map Markers', '[
       {
        "layout": {
          "icon-image": "marker-15",
          "icon-allow-overlap": true,
          "icon-offset": [
            0,
            -6
          ],
          "icon-size": 1
        },
        "source": "search-results-points",
        "filter": [
          "all",
          [
            "==",
            "$type",
            "Point"
          ],
          [
            "!=",
            "highlight",
            true
          ]
        ],
        "paint": {},
        "type": "symbol",
        "id": "search-results-points-markers"
      },
      {
        "layout": {
          "icon-image": "marker-15",
          "icon-allow-overlap": true,
          "icon-offset": [
            0,
            -6
          ],
          "icon-size": 1.3
        },
        "source": "search-results-points",
        "filter": [
          "all",
          [
            "==",
            "$type",
            "Point"
          ],
          [
            "==",
            "highlight",
            true
          ]
        ],
        "paint": {},
        "type": "symbol",
        "id": "search-results-points-markers-highlighted"
      },
      {
        "layout": {
          "visibility": "visible"
        },
        "source": "search-results-points",
        "filter": [
          "all",
          [
            "==",
            "$type",
            "Point"
          ],
          [
            "==",
            "highlight",
            true
          ]
        ],
        "paint": {
          "circle-translate": [
            0,
            -25
          ],
          "circle-color": "rgba(0,0,0,0)",
          "circle-radius": 16
        },
        "type": "circle",
        "id": "search-results-points-markers-point-highlighted"
      },
      {
        "layout": {
          "visibility": "visible"
        },
        "source": "search-results-points",
        "filter": [
          "all",
          [
            "==",
            "$type",
            "Point"
          ]
        ],
        "paint": {
          "circle-translate": [
            0,
            -16
          ],
          "circle-color": "rgba(0,0,0,0)",
          "circle-radius": 11
        },
        "type": "circle",
        "id": "search-results-points-markers-point"
      }
   ]', TRUE, 'ion-location', TRUE, TRUE);



INSERT INTO map_layers(maplayerid, name, layerdefinitions, isoverlay, icon, activated, addtomap)
   VALUES (public.uuid_generate_v1mc(), 'Hex', '[
      {
        "layout": {},
        "source": "search-results-hex",
        "filter": [
          "==",
          "id",
          ""
        ],
        "paint": {
          "fill-extrusion-color": "#54278f",
          "fill-extrusion-height": {
            "property": "doc_count",
            "type": "exponential",
            "stops": [
              [
                0,
                0
              ],
              [
                500,
                5000
              ]
            ]
          },
          "fill-extrusion-opacity": 0.85
        },
        "type": "fill-extrusion",
        "id": "search-results-hex-outline-highlighted"
      },
      {
        "layout": {},
        "source": "search-results-hex",
        "filter": [
          "all",
          [
            ">",
            "doc_count",
            0
          ]
        ],
        "paint": {
          "fill-extrusion-color": {
            "property": "doc_count",
            "stops": [
              [
                1,
                "#f2f0f7"
              ],
              [
                5,
                "#cbc9e2"
              ],
              [
                10,
                "#9e9ac8"
              ],
              [
                20,
                "#756bb1"
              ],
              [
                50,
                "#54278f"
              ]
            ]
          },
          "fill-extrusion-height": {
            "property": "doc_count",
            "type": "exponential",
            "stops": [
              [
                0,
                0
              ],
              [
                500,
                5000
              ]
            ]
          },
          "fill-extrusion-opacity": 0.5
        },
        "type": "fill-extrusion",
        "id": "search-results-hex"
      }

   ]', TRUE, 'ion-funnel', TRUE, FALSE);
