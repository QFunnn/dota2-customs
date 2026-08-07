--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('equipment_comp', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Button = require('./EOM_Button.js');
var equipment_utils = require('./equipment_utils.js');

function EOM_CheckBox2(props) {
  const [local, others] = libs.splitProps(props, ["text", "onchecked", "class"]);
  return (() => {
    const _el$3 = libs.createElement("Panel", libs.mergeProps$1(others, {
        get ["class"]() {
          return libs.classNames("EOM_CheckBox2", local.class);
        }
      }), null),
      _el$4 = libs.createElement("Panel", {
        id: "CheckBox"
      }, _el$3);
      libs.createElement("Panel", {
        id: "CheckBoxTick"
      }, _el$4);
      const _el$6 = libs.createElement("Label", {
        "class": "CheckLabel",
        get text() {
          return local.text;
        },
        html: true
      }, _el$3);
    libs.spread(_el$3, libs.mergeProps$1(others, {
      get ["class"]() {
        return libs.classNames("EOM_CheckBox2", local.class);
      },
      "onactivate": p => {
        p.checked = !p.checked;
        local.onchecked?.(p.checked, p);
      }
    }), true);
    libs.effect(_$p => libs.setProp(_el$6, "text", local.text, _$p));
    return _el$3;
  })();
}

const MenuTabButton = props => {
  const merged = libs.mergeProps(props, {
    class: "MenuTabButton"
  });
  const [local, others] = libs.splitProps(merged, ['name', 'selected', 'locked', 'clickCallback', "icon", "num"]);
  return libs.createComponent(EOM_Button.EOM_BaseButton, libs.mergeProps$1({
    get id() {
      return local.name;
    },
    get classList() {
      return {
        Selected: local.selected
      };
    },
    get onactivate() {
      return local.clickCallback;
    }
  }, others, {
    get children() {
      const _el$ = libs.createElement("Panel", {
          align: "center center",
          flowChildren: "right",
          "class": "MenuTabButtonContent"
        }, null),
        _el$3 = libs.createElement("Label", {
          id: "MenuTabButtonLabel",
          get text() {
            return "#MenuTabButton_" + local.name;
          }
        }, _el$);
      libs.setProp(_el$, "align", "center center");
      libs.setProp(_el$, "flowChildren", "right");
      libs.insert(_el$, libs.createComponent(libs.Show, {
        get when() {
          return local.icon;
        },
        get children() {
          const _el$2 = libs.createElement("Image", {
            get src() {
              return getSrcPath("conv/icon/" + local.icon + ".png");
            }
          }, null);
          libs.effect(_$p => libs.setProp(_el$2, "src", getSrcPath("conv/icon/" + local.icon + ".png"), _$p));
          return _el$2;
        }
      }), _el$3);
      libs.insert(_el$, libs.createComponent(libs.Show, {
        get when() {
          return (local.num ?? 0) > 0;
        },
        get children() {
          const _el$4 = libs.createElement("Label", {
            "class": "MenuTabButtonNum",
            get text() {
              return `${String(local.num)}/${EQUIP_MAX_COUNT}`;
            }
          }, null);
          libs.effect(_$p => libs.setProp(_el$4, "text", `${String(local.num)}/${EQUIP_MAX_COUNT}`, _$p));
          return _el$4;
        }
      }), null);
      libs.insert(_el$, libs.createComponent(libs.Show, {
        get when() {
          return local.locked;
        },
        get children() {
          return libs.createElement("Image", {
            "class": "MenuLockIcon"
          }, null);
        }
      }), null);
      libs.effect(_$p => libs.setProp(_el$3, "text", "#MenuTabButton_" + local.name, _$p));
      return _el$;
    }
  }));
};
const EquipmentCommonBtn = props => {
  const [local, others] = libs.splitProps(props, ["children", "class"]);
  return (() => {
    const _el$6 = libs.createElement("TextButton", libs.mergeProps$1(others, {
      get ["class"]() {
        return libs.classNames("EquipmentCommonBtn SecondaryButtonStates", local.class);
      }
    }), null);
    libs.spread(_el$6, libs.mergeProps$1(others, {
      get ["class"]() {
        return libs.classNames("EquipmentCommonBtn SecondaryButtonStates", local.class);
      }
    }), true);
    libs.insert(_el$6, () => local.children);
    return _el$6;
  })();
};
const EquipSeparator = props => {
  const [local, other] = libs.splitProps(props, ["text", "class"]);
  return (() => {
    const _el$7 = libs.createElement("Panel", libs.mergeProps$1(other, {
        get ["class"]() {
          return libs.classNames("EquipSeparator", local.class);
        }
      }), null);
      libs.createElement("Panel", {
        id: "Line1",
        "class": "Line"
      }, _el$7);
      const _el$9 = libs.createElement("Label", {
        get text() {
          return props.text;
        }
      }, _el$7);
      libs.createElement("Panel", {
        id: "Line2",
        "class": "Line"
      }, _el$7);
    libs.spread(_el$7, libs.mergeProps$1(other, {
      get ["class"]() {
        return libs.classNames("EquipSeparator", local.class);
      }
    }), true);
    libs.effect(_$p => libs.setProp(_el$9, "text", props.text, _$p));
    return _el$7;
  })();
};
const AttrContainer = props => {
  return (() => {
    const _el$15 = libs.createElement("Panel", {
        "class": "AttrBox VerticalScrollStyle"
      }, null),
      _el$16 = libs.createElement("Panel", {
        "class": "AttrContainer",
        hittest: false
      }, _el$15);
    libs.insert(_el$16, () => libs.untrack(() => props.children));
    return _el$15;
  })();
};
function AttrItem(props) {
  const [local, other] = libs.splitProps(props, ["attrData", "changeValue", "type", "index", "children", "onAttrbuteClick", "selected", "isNew", "attributeNameText"]);
  const attribute = () => GetLocalization("#property_" + local.attrData.id);
  const isPrivilege = () => local.attrData.id.startsWith("privilege_");
  const isPercent = () => attribute().startsWith("%");
  const color = () => props.attrData.percent != undefined ? equipment_utils.GetEntryHtmlColorByPercent(props.attrData.percent) : "#958D83";
  const name = () => ToColor(attribute().replace("%", ""), color());
  const displayName = () => local.attributeNameText ?? (isPrivilege() ? GetPrivilegeDesc(local.attrData.id, 1, {
    value: local.attrData.value
  }) : name());
  const valueISChange = () => local.changeValue != undefined && local.changeValue != local.attrData.value || typeof local.changeValue == "string";
  const ShowNext = () => {
    return typeof local.changeValue == "string" ? local.changeValue : `${equipment_utils.EquipAttributeRound(local.attrData.id, local.changeValue)}${isPercent() ? "%" : ""}`;
  };
  return (() => {
    const _el$17 = libs.createElement("Panel", {
        get ["class"]() {
          return libs.classNames({
            ValueIsChange: valueISChange(),
            New: local.isNew
          }, "AttrItem " + local.type);
        }
      }, null);
      libs.createElement("Panel", {
        "class": "NewBorder"
      }, _el$17);
      const _el$19 = libs.createElement("Panel", {
        verticalAlign: "center",
        flowChildren: "right"
      }, _el$17),
      _el$20 = libs.createElement("Panel", {
        id: "Point"
      }, _el$19),
      _el$21 = libs.createElement("Label", {
        id: "AttributeName",
        get text() {
          return displayName();
        },
        html: true
      }, _el$19);
      libs.createElement("Panel", {
        "class": "NewTag"
      }, _el$19);
    libs.setProp(_el$17, "onactivate", () => {
      local?.onAttrbuteClick?.(local.type, local.index);
    });
    libs.setProp(_el$19, "verticalAlign", "center");
    libs.setProp(_el$19, "style", {
      overflow: "noclip"
    });
    libs.setProp(_el$19, "flowChildren", "right");
    libs.insert(_el$19, libs.createComponent(libs.Show, {
      get when() {
        return local.onAttrbuteClick;
      },
      get children() {
        return libs.createComponent(AttributeSelectBtn, {
          get selected() {
            return local.selected;
          }
        });
      }
    }), _el$20);
    libs.insert(_el$19, () => libs.untrack(() => local.children), null);
    libs.insert(_el$17, libs.createComponent(libs.Show, {
      get when() {
        return !isPrivilege();
      },
      get children() {
        const _el$23 = libs.createElement("Label", {
          id: "AttributeValue",
          get text() {
            return equipment_utils.EquipAttributeRound(local.attrData.id, local.attrData.value) + (isPercent() ? "%" : "");
          }
        }, null);
        libs.effect(_$p => libs.setProp(_el$23, "text", equipment_utils.EquipAttributeRound(local.attrData.id, local.attrData.value) + (isPercent() ? "%" : ""), _$p));
        return _el$23;
      }
    }), null);
    libs.insert(_el$17, libs.createComponent(libs.Show, {
      get when() {
        return valueISChange();
      },
      get children() {
        return [libs.createElement("Panel", {
          id: "ValueChangeArrow",
          "class": "EquipArrow"
        }, null), (() => {
          const _el$25 = libs.createElement("Label", {
            id: "Next",
            "class": "Green",
            get text() {
              return ShowNext();
            }
          }, null);
          libs.effect(_$p => libs.setProp(_el$25, "text", ShowNext(), _$p));
          return _el$25;
        })()];
      }
    }), null);
    libs.effect(_p$ => {
      const _v$3 = libs.classNames({
          ValueIsChange: valueISChange(),
          New: local.isNew
        }, "AttrItem " + local.type),
        _v$4 = displayName();
      _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$17, "class", _v$3, _p$._v$3));
      _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$21, "text", _v$4, _p$._v$4));
      return _p$;
    }, {
      _v$3: undefined,
      _v$4: undefined
    });
    return _el$17;
  })();
}
const AttributeSelectBtn = props => {
  const merged = libs.mergeProps({
    selected: false
  }, props);
  const [local, others] = libs.splitProps(merged, ["selected", "class"]);
  return (() => {
    const _el$26 = libs.createElement("Panel", others, null);
      libs.createElement("Panel", {
        id: "mid"
      }, _el$26);
    libs.spread(_el$26, libs.mergeProps$1(others, {
      get className() {
        return libs.classNames("AttributeSelectBtn", {
          Selected: local.selected
        }, local.class);
      }
    }), true);
    return _el$26;
  })();
};
function createEquipDetailSignal(id_signal) {
  const [itemData, setItemData] = libs.createSignal();
  const [force, _forceFresh] = libs.createSignal(false);
  libs.createEffect(() => {
    force();
    let id = String(id_signal());
    if (id) {
      let request = equipment_utils.GetEquipmentDetail([id], data => {
        setItemData(data[id]);
      }, true);
      request && libs.onCleanup(() => CancelRequest(request));
    } else {
      setItemData();
    }
  });
  return {
    itemData,
    forceFresh: () => {
      _forceFresh(b => !b);
    }
  };
}
function createGemDetailSignal(id_signal) {
  const [gemData, setGemData] = libs.createSignal();
  const [force, _forceFresh] = libs.createSignal(false);
  libs.createEffect(() => {
    force();
    let id = String(id_signal());
    if (id) {
      let request = equipment_utils.GetGemDetail([id], data => {
        setGemData(data[id]);
      }, true);
      request && libs.onCleanup(() => CancelRequest(request));
    } else {
      setGemData();
    }
  });
  return {
    gemData,
    forceFresh: () => {
      _forceFresh(b => !b);
    }
  };
}
const EquipmentContext = libs.createContext();
function useEquipmentStore() {
  const context = libs.useContext(EquipmentContext);
  if (!context) {
    throw new Error("useEquipmentStore must be used within EquipmentProvider");
  }
  return context;
}
function calculateAttributeData(attrData, bonus) {
  const addValue = attrData.base_value * bonus;
  const changeValue = equipment_utils.EquipAttributeRound(attrData.id, attrData.base_value + addValue);
  return {
    attrData,
    changeValue
  };
}

exports.AttrContainer = AttrContainer;
exports.AttrItem = AttrItem;
exports.AttributeSelectBtn = AttributeSelectBtn;
exports.EOM_CheckBox2 = EOM_CheckBox2;
exports.EquipSeparator = EquipSeparator;
exports.EquipmentCommonBtn = EquipmentCommonBtn;
exports.EquipmentContext = EquipmentContext;
exports.MenuTabButton = MenuTabButton;
exports.calculateAttributeData = calculateAttributeData;
exports.createEquipDetailSignal = createEquipDetailSignal;
exports.createGemDetailSignal = createGemDetailSignal;
exports.useEquipmentStore = useEquipmentStore;