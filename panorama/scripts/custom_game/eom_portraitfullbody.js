--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('EOM_PortraitFullBody', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');

const EOM_PortraitFullBody = props => {
  const merged = libs.mergeProps$1({
    allowrotation: true,
    yawmax: 40,
    yawmin: -160,
    particleonly: false,
    showPedestal: true
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "unitname", "allowrotation", "yawmax", "yawmin", "particleonly", "showPedestal"]);
  const resolved = libs.children(() => local.children);
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "EOM_PortraitFullBody"
    })), null);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "EOM_PortraitFullBody"
    })), true);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return local.unitname != undefined;
      },
      get children() {
        const _el$2 = libs.createElement("DOTAScenePanel", {
          get yawmax() {
            return local.yawmax;
          },
          get yawmin() {
            return local.yawmin;
          },
          get allowrotation() {
            return local.allowrotation;
          },
          get map() {
            return "full_body/" + local.unitname;
          },
          camera: "camera_1",
          light: "portrait_light",
          get particleonly() {
            return local.particleonly;
          },
          renderdeferred: true,
          deferredalpha: true,
          antialias: true
        }, null);
        libs.setProp(_el$2, "className", "CustomHeroPortraitHUD");
        libs.setProp(_el$2, "onload", self => {
          if (!local.showPedestal) {
            self.FireEntityInput('pedestal', 'TurnOff', '');
          }
        });
        libs.effect(_p$ => {
          const _v$ = local.yawmax,
            _v$2 = local.yawmin,
            _v$3 = local.allowrotation,
            _v$4 = "full_body/" + local.unitname,
            _v$5 = local.particleonly;
          _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$2, "yawmax", _v$, _p$._v$));
          _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$2, "yawmin", _v$2, _p$._v$2));
          _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$2, "allowrotation", _v$3, _p$._v$3));
          _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$2, "map", _v$4, _p$._v$4));
          _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$2, "particleonly", _v$5, _p$._v$5));
          return _p$;
        }, {
          _v$: undefined,
          _v$2: undefined,
          _v$3: undefined,
          _v$4: undefined,
          _v$5: undefined
        });
        return _el$2;
      }
    }), null);
    libs.insert(_el$, resolved, null);
    return _el$;
  })();
};

exports.EOM_PortraitFullBody = EOM_PortraitFullBody;