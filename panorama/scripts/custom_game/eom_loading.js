--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('EOM_Loading', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');

const EOM_Loading = props => {
  const merged = libs.mergeProps$1({
    color: "#fff"
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "type", "color"]);
  const {
    type,
    color
  } = local;
  if (type == "Wave") {
    return (() => {
      const _el$ = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
          className: libs.classNames("EOM_Loading", type)
        })), null),
        _el$2 = libs.createElement("Image", {}, _el$),
        _el$3 = libs.createElement("Image", {}, _el$),
        _el$4 = libs.createElement("Image", {}, _el$),
        _el$5 = libs.createElement("Image", {}, _el$),
        _el$6 = libs.createElement("Image", {}, _el$),
        _el$7 = libs.createElement("Image", {}, _el$),
        _el$8 = libs.createElement("Image", {}, _el$),
        _el$9 = libs.createElement("Image", {}, _el$);
      libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
        className: libs.classNames("EOM_Loading", type)
      })), true);
      libs.setProp(_el$2, "className", "WaveCol1");
      libs.setProp(_el$2, "style", {
        backgroundColor: color
      });
      libs.setProp(_el$3, "className", "WaveCol2");
      libs.setProp(_el$3, "style", {
        backgroundColor: color
      });
      libs.setProp(_el$4, "className", "WaveCol3");
      libs.setProp(_el$4, "style", {
        backgroundColor: color
      });
      libs.setProp(_el$5, "className", "WaveCol4");
      libs.setProp(_el$5, "style", {
        backgroundColor: color
      });
      libs.setProp(_el$6, "className", "WaveCol5");
      libs.setProp(_el$6, "style", {
        backgroundColor: color
      });
      libs.setProp(_el$7, "className", "WaveCol6");
      libs.setProp(_el$7, "style", {
        backgroundColor: color
      });
      libs.setProp(_el$8, "className", "WaveCol7");
      libs.setProp(_el$8, "style", {
        backgroundColor: color
      });
      libs.setProp(_el$9, "className", "WaveCol8");
      libs.setProp(_el$9, "style", {
        backgroundColor: color
      });
      return _el$;
    })();
  } else if (type == "Matrix") {
    return (() => {
      const _el$0 = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
        className: libs.classNames("EOM_Loading", type)
      })), null);
      libs.spread(_el$0, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
        className: libs.classNames("EOM_Loading", type)
      })), true);
      libs.insert(_el$0, libs.createComponent(EOM_Panel.EOM_Panel, {
        width: "100%",
        height: "100%",
        flowChildren: "down",
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            width: "100%",
            height: "25%",
            className: "Row1",
            flowChildren: "right",
            get children() {
              return [(() => {
                const _el$1 = libs.createElement("Image", {}, null);
                libs.setProp(_el$1, "style", {
                  backgroundColor: color
                });
                return _el$1;
              })(), (() => {
                const _el$10 = libs.createElement("Image", {}, null);
                libs.setProp(_el$10, "style", {
                  backgroundColor: color
                });
                return _el$10;
              })(), (() => {
                const _el$11 = libs.createElement("Image", {}, null);
                libs.setProp(_el$11, "style", {
                  backgroundColor: color
                });
                return _el$11;
              })(), (() => {
                const _el$12 = libs.createElement("Image", {}, null);
                libs.setProp(_el$12, "style", {
                  backgroundColor: color
                });
                return _el$12;
              })()];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            width: "100%",
            height: "25%",
            className: "Row2",
            flowChildren: "right",
            get children() {
              return [(() => {
                const _el$13 = libs.createElement("Image", {}, null);
                libs.setProp(_el$13, "style", {
                  backgroundColor: color
                });
                return _el$13;
              })(), (() => {
                const _el$14 = libs.createElement("Image", {}, null);
                libs.setProp(_el$14, "style", {
                  backgroundColor: color
                });
                return _el$14;
              })(), (() => {
                const _el$15 = libs.createElement("Image", {}, null);
                libs.setProp(_el$15, "style", {
                  backgroundColor: color
                });
                return _el$15;
              })(), (() => {
                const _el$16 = libs.createElement("Image", {}, null);
                libs.setProp(_el$16, "style", {
                  backgroundColor: color
                });
                return _el$16;
              })()];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            width: "100%",
            height: "25%",
            className: "Row3",
            flowChildren: "right",
            get children() {
              return [(() => {
                const _el$17 = libs.createElement("Image", {}, null);
                libs.setProp(_el$17, "style", {
                  backgroundColor: color
                });
                return _el$17;
              })(), (() => {
                const _el$18 = libs.createElement("Image", {}, null);
                libs.setProp(_el$18, "style", {
                  backgroundColor: color
                });
                return _el$18;
              })(), (() => {
                const _el$19 = libs.createElement("Image", {}, null);
                libs.setProp(_el$19, "style", {
                  backgroundColor: color
                });
                return _el$19;
              })(), (() => {
                const _el$20 = libs.createElement("Image", {}, null);
                libs.setProp(_el$20, "style", {
                  backgroundColor: color
                });
                return _el$20;
              })()];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            width: "100%",
            height: "25%",
            className: "Row4",
            flowChildren: "right",
            get children() {
              return [(() => {
                const _el$21 = libs.createElement("Image", {}, null);
                libs.setProp(_el$21, "style", {
                  backgroundColor: color
                });
                return _el$21;
              })(), (() => {
                const _el$22 = libs.createElement("Image", {}, null);
                libs.setProp(_el$22, "style", {
                  backgroundColor: color
                });
                return _el$22;
              })(), (() => {
                const _el$23 = libs.createElement("Image", {}, null);
                libs.setProp(_el$23, "style", {
                  backgroundColor: color
                });
                return _el$23;
              })(), (() => {
                const _el$24 = libs.createElement("Image", {}, null);
                libs.setProp(_el$24, "style", {
                  backgroundColor: color
                });
                return _el$24;
              })()];
            }
          })];
        }
      }));
      return _el$0;
    })();
  } else if (type == "PointSpin") {
    return (() => {
      const _el$25 = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
          className: libs.classNames("EOM_Loading", type)
        })), null),
        _el$26 = libs.createElement("Image", {}, _el$25),
        _el$27 = libs.createElement("Image", {}, _el$25),
        _el$28 = libs.createElement("Image", {}, _el$25),
        _el$29 = libs.createElement("Image", {}, _el$25);
      libs.spread(_el$25, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
        className: libs.classNames("EOM_Loading", type)
      })), true);
      libs.setProp(_el$26, "className", "Point1");
      libs.setProp(_el$26, "style", {
        backgroundColor: color
      });
      libs.setProp(_el$27, "className", "Point2");
      libs.setProp(_el$27, "style", {
        backgroundColor: color
      });
      libs.setProp(_el$28, "className", "Point3");
      libs.setProp(_el$28, "style", {
        backgroundColor: color
      });
      libs.setProp(_el$29, "className", "Point4");
      libs.setProp(_el$29, "style", {
        backgroundColor: color
      });
      return _el$25;
    })();
  }
};

exports.EOM_Loading = EOM_Loading;