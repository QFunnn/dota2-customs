--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('EOM_MenuLayout', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var GenericPanel = require('./GenericPanel.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Button = require('./EOM_Button.js');
var MenuMarkIcon = require('./MenuMarkIcon.js');
var red_point_utils = require('./red_point_utils.js');

const useEOM_MenuLayoutData = (show, setup) => {
  libs.createEffect(libs.on(show, visible => {
    if (!visible) return;
    const cleanup = setup();
    libs.onCleanup(cleanup);
  }));
};
const EOM_MenuLayout = props => {
  const merged = libs.mergeProps$1({
    type: EOM_Panel.ADDON_NAME,
    renderOnShow: false,
    renderSwtich: false
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "renderOnShow", "type", "name", "show", "close", "renderSwtich"]);
  const [renderChlidren, setRenderChildren] = libs.createSignal(!local.renderSwtich);
  const renderOnShow = () => {
    if (local.renderSwtich) {
      return !renderChlidren();
    }
    return local.renderOnShow;
  };
  libs.createEffect(libs.on(() => local.show, v => {
    if (!renderChlidren() && v) {
      setRenderChildren(true);
    }
  }));
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
        className: libs.classNames("EOM_MenuLayout", local.type, {
          Show: local.show
        })
      })), null);
      libs.createElement("Panel", {
        id: "EOM_MenuLayoutBG"
      }, _el$);
      libs.createElement("Image", {
        id: "TopBottomBG",
        hittest: false
      }, _el$);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("EOM_MenuLayout", local.type, {
        Show: local.show
      })
    }), {
      "onactivate": () => {}
    }), true);
    libs.insert(_el$, libs.createComponent(EOM_Button.EOM_CloseButton, {
      onactivate: self => {
        if (local.close != undefined) {
          local.close();
        } else {
          GameEvents.SendEventClientSide("custom_ui_toggle_windows", {
            window_name: local.name,
            state: 0
          });
        }
      }
    }), null);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return renderOnShow();
      },
      get fallback() {
        return libs.memo(() => local.children);
      },
      get children() {
        return libs.createComponent(libs.Show, {
          get when() {
            return props.show;
          },
          get children() {
            return local.children;
          }
        });
      }
    }), null);
    return _el$;
  })();
};
function getCombineMenuTag(menu, menu2) {
  return `${menu}&${menu2}`;
}
const EOM_MenuLayout_Menu = props => {
  const merged = libs.mergeProps$1({
    type: EOM_Panel.ADDON_NAME,
    menuList: []
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "type", "menuList", "onToggleMenu", "selectedMenu", "selectedMenu2", "menuName", "mark_icon", "show"]);
  const [menuSelected, setMenuSelected] = libs.createSignal(Object.keys(local.menuList)[0] ?? "");
  const [exclamationList, setExclamationList] = libs.createSignal([]);
  const [redPoints, setRedPoints] = libs.createSignal(getClientGlobalData("red_points") ?? []);
  const sLanguage = $.Language().toLowerCase();
  const getMenuSelected2 = () => {
    let result = {};
    if (local.menuList != undefined) {
      for (const key in local.menuList) {
        const element = local.menuList[key];
        result[key] = element[0];
      }
    }
    return result;
  };
  const [menuSelected2, setMenuSelected2] = libs.createStore(getMenuSelected2());
  libs.createEffect(libs.on(() => local.menuList, () => {
    setMenuSelected(Object.keys(local.menuList)[0] ?? "");
    setMenuSelected2(getMenuSelected2());
  }));
  libs.createEffect(libs.on(menuSelected, () => {
    if (local.onToggleMenu) {
      if (menuSelected() != "") {
        local.onToggleMenu(menuSelected(), menuSelected2[menuSelected()]);
      }
    }
  }));
  libs.createEffect(libs.on(() => local.selectedMenu, () => {
    if (local.selectedMenu != undefined) {
      setMenuSelected(local.selectedMenu);
    }
  }));
  libs.createEffect(libs.on(() => local.selectedMenu2, () => {
    if (local.selectedMenu2 != undefined) {
      let menu = Object.keys(local.menuList).find(v => local.menuList[v].includes(local.selectedMenu2));
      if (menu && menuSelected2[menu] != local.selectedMenu2) {
        setMenuSelected2(menu, local.selectedMenu2);
      }
    }
  }));
  libs.onMount(() => {
    let gameEventIDList = [];
    let netTableIDList = [];
    gameEventIDList.push(useClientGlobalData("red_points", setRedPoints));
    gameEventIDList.push(GameEvents.Subscribe("custom_ui_exclamation", event => {
      if (Object.keys(props.menuList).includes(event.name) || Object.values(props.menuList).some(v => v.includes(event.name))) {
        setExclamationList(exclamationList().concat([getCombineMenuTag(event.name)]));
      }
    }));
    libs.onCleanup(() => {
      gameEventIDList.forEach(id => GameEvents.Unsubscribe(id));
      netTableIDList.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    });
  });
  const hasMenuRedPoint = (menu, menu2) => {
    if (local.menuName == undefined) {
      return false;
    }
    if (menu2 != undefined) {
      return red_point_utils.hasRedPoint(redPoints(), local.menuName, menu, menu2);
    }
    if (menu.endsWith("_all")) {
      return red_point_utils.hasRedPoint(redPoints(), local.menuName);
    }
    return red_point_utils.hasRedPoint(redPoints(), local.menuName, menu);
  };
  return (() => {
    const _el$4 = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("EOM_MenuLayout_Menu", local.type)
    })), null);
    libs.spread(_el$4, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("EOM_MenuLayout_Menu", local.type)
    })), true);
    libs.insert(_el$4, libs.createComponent(libs.Index, {
      get each() {
        return Object.keys(local.menuList);
      },
      children: (menu, index) => {
        const menuIcon = () => {
          if (local.mark_icon) {
            return local.mark_icon(menu());
          }
        };
        return [(() => {
          const _el$5 = libs.createElement("Panel", {}, null),
            _el$6 = libs.createElement("Image", {}, _el$5);
          libs.setProp(_el$5, "onactivate", self => {
            setMenuSelected(menu());
          });
          libs.setProp(_el$6, "className", "TabBackgroundActive");
          libs.insert(_el$5, menuIcon, null);
          libs.insert(_el$5, libs.createComponent(libs.Show, {
            get when() {
              return hasMenuRedPoint(menu());
            },
            get children() {
              return libs.createComponent(MenuMarkIcon.MenuMarkIcon, {
                type: "default",
                hittest: false
              });
            }
          }), null);
          libs.insert(_el$5, libs.createComponent(GenericPanel.CLabel, {
            get className() {
              return libs.classNames(sLanguage);
            },
            get text() {
              return "#" + menu();
            },
            html: true
          }), null);
          libs.insert(_el$5, libs.createComponent(libs.Show, {
            get when() {
              return libs.memo(() => local.menuList[menu()] != undefined)() && local.menuList[menu()].length > 0;
            },
            get children() {
              const _el$7 = libs.createElement("Image", {}, null);
              libs.setProp(_el$7, "className", "TabBackgroundArrow");
              return _el$7;
            }
          }), null);
          libs.effect(_$p => libs.setProp(_el$5, "className", libs.classNames("TabButton", {
            Selected: menuSelected() == menu()
          }), _$p));
          return _el$5;
        })(), libs.createComponent(libs.Show, {
          get when() {
            return libs.memo(() => local.menuList[menu()] != undefined)() && local.menuList[menu()].length > 0;
          },
          get children() {
            const _el$8 = libs.createElement("Panel", {}, null);
            libs.insert(_el$8, libs.createComponent(libs.Index, {
              get each() {
                return local.menuList?.[menu()] ?? [];
              },
              children: (menu2, index2) => {
                const menu2Icon = () => {
                  if (local.mark_icon) {
                    return local.mark_icon(menu(), menu2());
                  }
                };
                return (() => {
                  const _el$9 = libs.createElement("Panel", {}, null),
                    _el$0 = libs.createElement("Image", {}, _el$9),
                    _el$1 = libs.createElement("Image", {}, _el$9);
                  libs.setProp(_el$9, "onactivate", self => {
                    setMenuSelected2({
                      [menu()]: menu2()
                    });
                    if (local.onToggleMenu) {
                      if (menuSelected() != "") {
                        local.onToggleMenu(menu(), menu2());
                      }
                    }
                  });
                  libs.setProp(_el$0, "className", "SecondaryBackgroundActive");
                  libs.setProp(_el$1, "className", "SecondaryCheckBox");
                  libs.insert(_el$9, libs.createComponent(GenericPanel.CLabel, {
                    get className() {
                      return libs.classNames(sLanguage);
                    },
                    get text() {
                      return "#" + menu2();
                    },
                    html: true
                  }), null);
                  libs.insert(_el$9, menu2Icon, null);
                  libs.insert(_el$9, libs.createComponent(libs.Show, {
                    get when() {
                      return hasMenuRedPoint(menu(), menu2());
                    },
                    get children() {
                      return libs.createComponent(MenuMarkIcon.MenuMarkIcon, {
                        type: "default",
                        hittest: false
                      });
                    }
                  }), null);
                  libs.effect(_$p => libs.setProp(_el$9, "className", libs.classNames("SecondaryMenuButton", {
                    Selected: menuSelected2[menu()] == menu2()
                  }), _$p));
                  return _el$9;
                })();
              }
            }));
            libs.effect(_$p => libs.setProp(_el$8, "className", libs.classNames("SecondaryContainer", {
              Selected: menuSelected() == menu()
            }), _$p));
            return _el$8;
          }
        })];
      }
    }));
    return _el$4;
  })();
};
const EOM_MenuLayout_Content = props => {
  const merged = libs.mergeProps$1({
    type: EOM_Panel.ADDON_NAME,
    show: true,
    renderOnShow: false
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "show", "type", "renderOnShow"]);
  return (() => {
    const _el$10 = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("EOM_MenuLayout_Content", local.type, {
        Show: local.show
      })
    }), {
      hittest: false
    }), null);
    libs.spread(_el$10, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("EOM_MenuLayout_Content", local.type, {
        Show: local.show
      })
    }), {
      "hittest": false
    }), true);
    libs.insert(_el$10, libs.createComponent(libs.Show, {
      get when() {
        return !local.renderOnShow || local.show;
      },
      get children() {
        return local.children;
      }
    }));
    return _el$10;
  })();
};

exports.EOM_MenuLayout = EOM_MenuLayout;
exports.EOM_MenuLayout_Content = EOM_MenuLayout_Content;
exports.EOM_MenuLayout_Menu = EOM_MenuLayout_Menu;
exports.useEOM_MenuLayoutData = useEOM_MenuLayoutData;