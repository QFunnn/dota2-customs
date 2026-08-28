--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('EOM_DrawerLayout', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Button = require('./EOM_Button.js');

const EOM_DrawerLayout = props => {
  const merged = libs.mergeProps(props, {
    class: "EOM_DrawerLayout"
  });
  const [local, others] = libs.splitProps(merged, ["children", "show", "title", "onclose"]);
  const [show, setShow] = libs.createSignal(local.show);
  libs.createRenderEffect(() => {
    setShow(props.show);
  });
  return (() => {
    const _el$ = libs.createElement("Panel", others, null),
      _el$4 = libs.createElement("Panel", {
        id: "DrawerContents"
      }, _el$);
    libs.spread(_el$, libs.mergeProps$1(others, {
      get classList() {
        return {
          DrawerVisible: show()
        };
      }
    }), true);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return local.title;
      },
      get children() {
        const _el$2 = libs.createElement("Panel", {
            id: "TitleContainer",
            hittest: false
          }, null),
          _el$3 = libs.createElement("Label", {
            get text() {
              return local.title;
            }
          }, _el$2);
        libs.effect(_$p => libs.setProp(_el$3, "text", local.title, _$p));
        return _el$2;
      }
    }), _el$4);
    libs.setProp(_el$4, "onactivate", () => {});
    libs.insert(_el$4, () => libs.untrack(() => local.children));
    libs.insert(_el$, libs.createComponent(EOM_Button.EOM_BaseButton, {
      id: "EOM_DrawerLayoutClose",
      onactivate: () => {
        setShow(false);
        local.onclose?.();
      }
    }), null);
    return _el$;
  })();
};

exports.EOM_DrawerLayout = EOM_DrawerLayout;