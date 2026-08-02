--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('EOM_MenuLayout', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var GenericPanel = require('./GenericPanel.js');
var MenuMarkIcon = require('./MenuMarkIcon.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Button = require('./EOM_Button.js');

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
function splitCombineMenuTag(unique) {
  let [menu, menu2] = unique.split("&");
  return [menu, menu2];
}
function registerMenuMarkStore(menuName) {
  if (menuName) {
    const context = $.GetContextPanel();
    if (context?.IsValid()) {
      let storeGroup = LoadData(context, `menuMarkStore_${menuName}`);
      if (LoadData(context, `menuMarkStore_${menuName}`) == undefined) {
        storeGroup = libs.createStore({});
        SaveData(context, `menuMarkStore_${menuName}`, storeGroup);
      }
      return storeGroup;
    }
  }
  return [{}, () => {}];
}
const EOM_MenuLayout_Menu = props => {
  const merged = libs.mergeProps$1({
    type: EOM_Panel.ADDON_NAME,
    menuList: []
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "type", "menuList", "onToggleMenu", "selectedMenu", "selectedMenu2", "menuName", "mark_icon", "show"]);
  const [menuSelected, setMenuSelected] = libs.createSignal(Object.keys(local.menuList)[0] ?? "");
  let [markNewInfo, setMarkNewInfo] = registerMenuMarkStore(local.menuName);
  libs.createEffect(libs.on(() => local.menuName, v => {
    [markNewInfo, setMarkNewInfo] = registerMenuMarkStore(v);
  }));
  const [exclamationList, setExclamationList] = libs.createSignal([]);
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
  let opened = false;
  const hideAllMark = () => {
    if (markNewInfo) {
      if (local.menuName) {
        for (const combineTag in markNewInfo) {
          const [menu] = splitCombineMenuTag(combineTag);
          if (markNewInfo[combineTag]) {
            clickNewMark({
              menu: local.menuName,
              tag: menu
            });
          }
          setMarkNewInfo(combineTag, null);
        }
      }
    }
    setExclamationList([]);
  };
  libs.createEffect(libs.on(() => local.show, v => {
    if (!v && opened) {
      libs.batch(() => {
        hideAllMark();
      });
    } else if (v) {
      opened = true;
    }
  }));
  libs.createEffect(libs.on(menuSelected, menu_1 => {
    $.Schedule(0.1, () => {
      checkExclamation(menu_1);
    });
  }));
  libs.createEffect(libs.on(() => menuSelected2, _menuSelected2 => {
    let menu1 = menuSelected();
    let menu2 = _menuSelected2[menuSelected()];
    $.Schedule(0.1, () => {
      checkExclamation(menu1, menu2);
    });
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
  const updateNewMarkInfo = data => {
    if (data) {
      libs.batch(() => {
        for (const mid in data) {
          const state = data[mid];
          const kv = KeyValues.NewMarkInfoKv[mid];
          if (kv != undefined) {
            if (kv.menu_button != undefined && kv.menu_button == local.menuName && kv.tag_id != undefined && local.menuList[kv.tag_id] != undefined) {
              let menu2Tag;
              if (kv.benchmark != undefined && local.menuList[kv.tag_id].length > 0) {
                menu2Tag = local.menuList[kv.tag_id].find(v => v.includes(kv.benchmark));
              }
              let unique1 = getCombineMenuTag(kv.tag_id);
              let unique2 = getCombineMenuTag(kv.tag_id, menu2Tag);
              if (state) {
                if (markNewInfo[unique1] === undefined) {
                  setMarkNewInfo(unique1, kv.type);
                }
                if (menu2Tag && markNewInfo[unique2] === undefined) {
                  setMarkNewInfo(unique2, kv.type);
                }
              } else {
                if (markNewInfo[unique1]) {
                  setMarkNewInfo(unique1, null);
                }
                if (menu2Tag && markNewInfo[unique2]) {
                  setMarkNewInfo(unique2, null);
                }
              }
            }
          }
        }
      });
    }
  };
  libs.onMount(() => {
    let gameEventIDList = [];
    let netTableIDList = [];
    gameEventIDList.push(GameEvents.Subscribe("custom_ui_exclamation", event => {
      if (Object.keys(props.menuList).includes(event.name) || Object.values(props.menuList).some(v => v.includes(event.name))) {
        setExclamationList(exclamationList().concat([getCombineMenuTag(event.name)]));
      }
    }));
    if (local.menuName != undefined) {
      netTableIDList.push(useServiceNetTable("player_new_mark", data => {
        updateNewMarkInfo(data);
      }, Players.GetLocalPlayer()));
      gameEventIDList.push(useClientSideEvent("create_new_mark_info", data => {
        updateNewMarkInfo(data);
      }));
    }
    libs.onCleanup(() => {
      hideAllMark();
      gameEventIDList.forEach(id => GameEvents.Unsubscribe(id));
      netTableIDList.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    });
  });
  const checkExclamation = (_menu, _menu2) => {
    libs.batch(() => {
      let menu = getCombineMenuTag(_menu);
      let menu2 = getCombineMenuTag(_menu, _menu2);
      if (local.menuName != undefined) {
        if (menu2 && markNewInfo[menu2]) {
          if (markNewInfo[menu]) {
            setMarkNewInfo(menu, null);
          }
          setMarkNewInfo(menu2, null);
          clickNewMark({
            menu: local.menuName,
            tag: _menu,
            benchmark: _menu2
          });
        } else {
          if (markNewInfo[menu]) {
            setMarkNewInfo(menu, null);
            clickNewMark({
              menu: local.menuName,
              tag: _menu
            });
          }
        }
      }
      if (exclamationList().length > 0) {
        let list = [...exclamationList()];
        let index = list.indexOf(menu);
        let flag = false;
        if (index != -1) {
          list.splice(index, 1);
          flag = true;
        }
        if (menu2) {
          let index = list.indexOf(menu2);
          if (index != -1) {
            list.splice(index, 1);
            flag = true;
          }
        }
        if (flag) {
          setExclamationList(list);
        }
      }
    });
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
            checkExclamation(menuSelected());
            setMenuSelected(menu());
          });
          libs.setProp(_el$6, "className", "TabBackgroundActive");
          libs.insert(_el$5, menuIcon, null);
          libs.insert(_el$5, libs.createComponent(libs.Switch, {
            get children() {
              return [libs.createComponent(libs.Match, {
                get when() {
                  return markNewInfo[getCombineMenuTag(menu())];
                },
                get children() {
                  return libs.createComponent(MenuMarkIcon.MenuMarkIcon, {
                    get type() {
                      return libs.memo(() => markNewInfo[getCombineMenuTag(menu())] == "new")() ? "new_large" : markNewInfo[getCombineMenuTag(menu())];
                    }
                  });
                }
              }), libs.createComponent(libs.Match, {
                get when() {
                  return exclamationList().includes(getCombineMenuTag(menu()));
                },
                get children() {
                  return libs.createComponent(MenuMarkIcon.MenuMarkIcon, {
                    type: "default"
                  });
                }
              })];
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
                    checkExclamation(menuSelected(), menuSelected2[menuSelected()]);
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
                  libs.insert(_el$9, libs.createComponent(libs.Switch, {
                    get children() {
                      return [libs.createComponent(libs.Match, {
                        get when() {
                          return markNewInfo[getCombineMenuTag(menu(), menu2())];
                        },
                        get children() {
                          return libs.createComponent(MenuMarkIcon.MenuMarkIcon, {
                            get type() {
                              return markNewInfo[getCombineMenuTag(menu(), menu2())];
                            }
                          });
                        }
                      }), libs.createComponent(libs.Match, {
                        get when() {
                          return exclamationList().includes(getCombineMenuTag(menu(), menu2()));
                        },
                        get children() {
                          return libs.createComponent(MenuMarkIcon.MenuMarkIcon, {
                            type: "default"
                          });
                        }
                      })];
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
  const [rendered, setRendered] = libs.createSignal(!local.renderOnShow || local.show);
  libs.createEffect(libs.on(() => local.show, v => {
    if (local.renderOnShow && v && !rendered()) {
      setRendered(true);
    }
  }));
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
        return rendered();
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