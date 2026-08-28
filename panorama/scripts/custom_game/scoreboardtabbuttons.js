--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('ScoreBoardTabButtons', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Label = require('./EOM_Label.js');
var EOM_Panel = require('./EOM_Panel.js');

const ScoreBoardTabButtons = props => {
  const merged = libs.mergeProps$1({
    list: [],
    activateType: "onactivate",
    group: doUniqueString("EOM_Breadcrumb")
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "list", "selected", "group", "vipIndex"]);
  const [selectedIndex, setSelectedIndex] = libs.createSignal(local.selected != undefined ? Math.min(local.list.length - 1, Math.max(0, local.selected - 1)) : undefined);
  const onSelect = index => {
    setSelectedIndex(index);
    if (others.onChange) {
      others.onChange(index + 1, local.list[index]);
    }
  };
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "ScoreBoardTabButtons"
    })), null);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "ScoreBoardTabButtons"
    })), true);
    libs.insert(_el$, libs.createComponent(libs.Index, {
      get each() {
        return local.list;
      },
      children: (name, index) => {
        const isVipIndex = () => (local.vipIndex ?? []).length > 0 && local.vipIndex.includes(index);
        if (index > 0) {
          return (() => {
            const _el$2 = libs.createElement("Button", {}, null);
            libs.setProp(_el$2, "onactivate", () => onSelect(index));
            libs.insert(_el$2, libs.createComponent(EOM_Label.EOM_Label, {
              get text() {
                return name();
              }
            }), null);
            libs.insert(_el$2, libs.createComponent(libs.Show, {
              get when() {
                return isVipIndex();
              },
              get children() {
                const _el$3 = libs.createElement("Image", {}, null);
                libs.setProp(_el$3, "className", "VipIcon");
                return _el$3;
              }
            }), null);
            libs.effect(_$p => libs.setProp(_el$2, "className", libs.classNames("ScoreBoardTabButton", {
              Selected: selectedIndex() == index
            }), _$p));
            return _el$2;
          })();
        } else {
          return (() => {
            const _el$4 = libs.createElement("Button", {}, null);
            libs.setProp(_el$4, "onactivate", () => onSelect(index));
            libs.insert(_el$4, libs.createComponent(EOM_Label.EOM_Label, {
              get text() {
                return name();
              }
            }), null);
            libs.insert(_el$4, libs.createComponent(libs.Show, {
              get when() {
                return isVipIndex();
              },
              get children() {
                const _el$5 = libs.createElement("Image", {}, null);
                libs.setProp(_el$5, "className", "VipIcon");
                return _el$5;
              }
            }), null);
            libs.effect(_$p => libs.setProp(_el$4, "className", libs.classNames("ScoreBoardTabButton", {
              Selected: selectedIndex() == index
            }), _$p));
            return _el$4;
          })();
        }
      }
    }));
    return _el$;
  })();
};

exports.ScoreBoardTabButtons = ScoreBoardTabButtons;