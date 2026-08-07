--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('EOM_Segmented', exports); const require = GameUI.__require;

var libs = require('./libs.js');

function EOM_Segmented(props) {
  const merged = libs.mergeProps({
    list: [],
    defaultSelected: 0,
    itemWidth: 80
  }, props);
  const [local, others] = libs.splitProps(merged, ["class", "list", "selected", "defaultSelected", "itemWidth", "onChange"]);
  const [innerIndex, setInnerIndex] = libs.createSignal(local.defaultSelected);
  const selectedIndex = () => local.selected ?? innerIndex();
  const containerWidth = libs.createMemo(() => local.list.length * local.itemWidth + 8);
  const spacerWidth = libs.createMemo(() => selectedIndex() * local.itemWidth);
  const onSelect = index => {
    if (local.selected === undefined) {
      setInnerIndex(index);
    }
    local.onChange?.(index, local.list[index]);
  };
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps$1(others, {
        get ["class"]() {
          return libs.classNames("EOM_Segmented", local.class);
        },
        get style() {
          return {
            width: `${containerWidth()}px`
          };
        }
      }), null),
      _el$2 = libs.createElement("Panel", {
        "class": "EOM_Segmented_IndicatorRow"
      }, _el$),
      _el$3 = libs.createElement("Panel", {
        "class": "EOM_Segmented_Spacer",
        get style() {
          return {
            width: `${spacerWidth()}px`
          };
        }
      }, _el$2),
      _el$4 = libs.createElement("Panel", {
        "class": "EOM_Segmented_Indicator",
        get style() {
          return {
            width: `${local.itemWidth}px`
          };
        }
      }, _el$2),
      _el$5 = libs.createElement("Panel", {
        "class": "EOM_Segmented_Items"
      }, _el$);
    libs.spread(_el$, libs.mergeProps$1(others, {
      get ["class"]() {
        return libs.classNames("EOM_Segmented", local.class);
      },
      get style() {
        return {
          width: `${containerWidth()}px`
        };
      }
    }), true);
    libs.insert(_el$5, libs.createComponent(libs.For, {
      get each() {
        return local.list;
      },
      children: (text, index) => (() => {
        const _el$6 = libs.createElement("Panel", {
            get ["class"]() {
              return libs.classNames("EOM_Segmented_Item", selectedIndex() === index() && "is-selected");
            },
            get style() {
              return {
                width: `${local.itemWidth}px`
              };
            }
          }, null),
          _el$7 = libs.createElement("Label", {
            "class": "EOM_Segmented_Label",
            text: text
          }, _el$6);
        libs.setProp(_el$6, "onactivate", () => onSelect(index()));
        libs.setProp(_el$7, "text", text);
        libs.effect(_p$ => {
          const _v$3 = libs.classNames("EOM_Segmented_Item", selectedIndex() === index() && "is-selected"),
            _v$4 = {
              width: `${local.itemWidth}px`
            };
          _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$6, "class", _v$3, _p$._v$3));
          _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$6, "style", _v$4, _p$._v$4));
          return _p$;
        }, {
          _v$3: undefined,
          _v$4: undefined
        });
        return _el$6;
      })()
    }));
    libs.effect(_p$ => {
      const _v$ = {
          width: `${spacerWidth()}px`
        },
        _v$2 = {
          width: `${local.itemWidth}px`
        };
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$3, "style", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$4, "style", _v$2, _p$._v$2));
      return _p$;
    }, {
      _v$: undefined,
      _v$2: undefined
    });
    return _el$;
  })();
}

exports.EOM_Segmented = EOM_Segmented;