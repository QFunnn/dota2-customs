--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('common', exports); const require = GameUI.__require;

var libs = require('./libs.js');

function parseTokenCosts(rawCost) {
  if (!rawCost) {
    return [];
  }
  const costs = [];
  const costIndexes = {};
  for (const rawEntry of rawCost.split("|")) {
    const separatorIndex = rawEntry.indexOf(":");
    if (separatorIndex <= 0 || separatorIndex >= rawEntry.length - 1) {
      return [];
    }
    const rawName = rawEntry.slice(0, separatorIndex).trim();
    const rawValue = rawEntry.slice(separatorIndex + 1).trim();
    const tokenID = Number(rawName);
    const value = Number(rawValue);
    if (!Number.isFinite(tokenID) || tokenID <= 0 || !Number.isFinite(value) || value < 0) {
      return [];
    }
    const name = String(tokenID);
    const existingIndex = costIndexes[name];
    if (existingIndex == undefined) {
      costIndexes[name] = costs.length;
      costs.push({
        name,
        value
      });
    } else {
      costs[existingIndex].value += value;
    }
  }
  return costs;
}
function resolveServiceNetDataArgs(defaultPlayerID, args) {
  let defaultVar;
  let playerID = defaultPlayerID;
  if (args.length == 2) {
    [defaultVar, playerID] = args;
  } else if (args.length == 1) {
    let first = args[0];
    if (typeof first == "number") {
      playerID = first;
    } else {
      defaultVar = first;
    }
  }
  return {
    defaultVar,
    playerID
  };
}
function getServiceRegistry() {
  CustomUIConfig.__serviceNetDataRegistry ??= {};
  return CustomUIConfig.__serviceNetDataRegistry;
}
function getServiceRegistryKey(key, playerID) {
  return `service:${String(key)}:${playerID}`;
}
function acquireSharedServiceNetData(key, playerID) {
  const registry = getServiceRegistry();
  const registryKey = getServiceRegistryKey(key, playerID);
  let entry = registry[registryKey];
  if (entry == undefined) {
    const initialData = getServiceNetData(key, playerID);
    const [data, setData] = libs.createSignal(initialData);
    const listenerID = useServiceNetData(key, tData => {
      setData(() => tData);
    }, playerID);
    entry = {
      data,
      initialData,
      listenerID,
      refCount: 0
    };
    registry[registryKey] = entry;
  }
  entry.refCount++;
  const release = () => {
    const current = registry[registryKey];
    if (current == undefined) {
      return;
    }
    current.refCount--;
    if (current.refCount <= 0) {
      CustomNetTables.UnsubscribeNetTableListener(current.listenerID);
      delete registry[registryKey];
    }
  };
  if (libs.getOwner() != undefined) {
    libs.onCleanup(release);
  }
  return entry.data;
}
function createDefaultedServiceAccessor(sharedData, defaultVar) {
  return () => {
    const value = sharedData();
    return value == undefined ? defaultVar : value;
  };
}
function createToggleWindowSignal(windowName, state) {
  const [value, setter] = libs.createSignal(state ?? false);
  libs.onMount(() => {
    let id = useClientSideEvent("custom_ui_toggle_windows", eventData => {
      if (eventData.windowName == windowName) {
        if (eventData.state === undefined) {
          setter(value => !value);
        } else {
          setter(eventData.state == 1 || eventData.state === true);
        }
      } else {
        setter(false);
      }
    });
    libs.onCleanup(() => {
      GameEvents.Unsubscribe(id);
    });
  });
  return [value, setter];
}
function createNetDataSignal(tableName, tableKey, defaultVar) {
  const [v, setter] = libs.createSignal(getNetDataKey(tableName, tableKey) ?? defaultVar);
  libs.onMount(() => {
    let id = useNetDataKey(tableName, tableKey, value => {
      setter(value ?? defaultVar);
    });
    libs.onCleanup(() => {
      CustomNetTables.UnsubscribeNetTableListener(id);
    });
  });
  return v;
}
function createPlayerNetDataSignal(tableName, tableKey, defaultVar, playerID) {
  const actualPlayerID = playerID ?? Players.GetLocalPlayer();
  const [v, setter] = libs.createSignal(getNetDataKey(tableName, tableKey, actualPlayerID) ?? defaultVar);
  libs.onMount(() => {
    let id = useNetDataKey(tableName, tableKey, value => {
      setter(value ?? defaultVar);
    }, actualPlayerID);
    libs.onCleanup(() => {
      CustomNetTables.UnsubscribeNetTableListener(id);
    });
  });
  return v;
}
function createNetTableSignal(tableName, tableKey, defaultVar) {
  const [v, setter] = libs.createSignal(CustomNetTables.GetTableValue(tableName, tableKey) ?? defaultVar);
  libs.onMount(() => {
    let id = CustomNetTables.SubscribeNetTableListener(tableName, (_, key, value) => {
      if (key == tableKey && value != undefined) {
        setter(value);
      }
    });
    libs.onCleanup(() => {
      CustomNetTables.UnsubscribeNetTableListener(id);
    });
  });
  return v;
}
function createPlayerPropertyData(playerID) {
  const [data, setData] = libs.createSignal({});
  libs.createEffect(() => {
    const tableKey = `1_${playerID()}`;
    setData(CustomNetTables.GetTableValue("property_system", tableKey) ?? {});
    const listenerID = CustomNetTables.SubscribeNetTableListener("property_system", (_, key, value) => {
      if (key === tableKey) {
        setData(value ?? {});
      }
    });
    libs.onCleanup(() => {
      CustomNetTables.UnsubscribeNetTableListener(listenerID);
    });
  });
  return data;
}
function createServiceNetData(key, ...args) {
  const {
    defaultVar,
    playerID
  } = resolveServiceNetDataArgs(Players.GetLocalPlayer(), args);
  return createDefaultedServiceAccessor(acquireSharedServiceNetData(key, playerID), defaultVar);
}
function createPlayerUnreadIds(system) {
  const playerUnreadIds = createServiceNetData("player_unread_ids", {});
  CustomUIConfig.__playerUnreadReadCacheRegistry ??= {};
  let entry = CustomUIConfig.__playerUnreadReadCacheRegistry[system];
  if (entry == undefined) {
    const [readCache, setReadCache] = libs.createStore({});
    entry = {
      readCache,
      setReadCache
    };
    CustomUIConfig.__playerUnreadReadCacheRegistry[system] = entry;
  }
  const {
    readCache,
    setReadCache
  } = entry;
  const unreadIds = libs.createMemo(() => playerUnreadIds()[system] ?? {});
  const isUnread = id => {
    const key = String(id);
    return unreadIds()[key] === true && readCache[key] !== true;
  };
  const markRead = id => {
    const key = String(id);
    if (isUnread(key)) {
      setReadCache(key, true);
    }
  };
  const clearReadCache = ids => {
    setReadCache(libs.produce(cache => {
      if (ids != undefined) {
        for (const id of ids) {
          delete cache[String(id)];
        }
      } else {
        for (const key in cache) {
          delete cache[key];
        }
      }
    }));
  };
  libs.createEffect(() => {
    const unreads = unreadIds();
    setReadCache(libs.produce(cache => {
      for (const key in cache) {
        if (unreads[key] !== true) {
          delete cache[key];
        }
      }
    }));
  });
  let submitting = false;
  const submitReadCache = () => {
    const ids = Object.keys(readCache).map(Number).filter(id => isFinite(id));
    if (ids.length === 0 || submitting) return;
    submitting = true;
    ServerRequest("player_unread_read", {
      system,
      ids
    }, result => {
      submitting = false;
      if (result.code == 0 || result.code == 200) {
        clearReadCache(ids);
      }
    }, undefined, () => {
      submitting = false;
    });
  };
  return {
    unreadIds,
    readCache,
    isUnread,
    markRead,
    clearReadCache,
    submitReadCache
  };
}
function createGlobalServiceNetData(key, ...args) {
  const {
    defaultVar,
    playerID
  } = resolveServiceNetDataArgs(-1, args);
  return createDefaultedServiceAccessor(acquireSharedServiceNetData(key, playerID), defaultVar);
}
function createServiceNetTableDataStore(key, ...args) {
  const {
    defaultVar,
    playerID
  } = resolveServiceNetDataArgs(Players.GetLocalPlayer(), args);
  const sharedData = acquireSharedServiceNetData(key, playerID);
  const [data, setData] = libs.createStore(sharedData() ?? defaultVar ?? {});
  libs.createEffect(() => {
    setData(resetStore(sharedData() ?? defaultVar ?? {}));
  });
  return data;
}
function resetStore(data) {
  return libs.produce(prev => {
    for (let k in prev) {
      delete prev[k];
    }
    for (let [k, v] of Object.entries(data)) {
      prev[k] = v;
    }
  });
}
function DynamicKey(props) {
  return libs.createMemo(() => {
    const key = props.key();
    return libs.untrack(() => props.children(key));
  });
}

const EOM_Icon = props => {
  const merged = libs.mergeProps({
    size: "32"
  }, props, {
    class: libs.classNames("EOM_Icon", {
      ["EOM_Icon" + props.type]: props.type != undefined
    }, props.extraType, "Size" + props.size, {
      EOM_IconSpin: props.spin,
      EOM_IconShadow: props.shadow
    })
  });
  const [local, others] = libs.splitProps(merged, ["children", "spin", "shadow", "size", "type", "extraType", "color"]);
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps$1(others, {
      get style() {
        return {
          "wash-color": local.color
        };
      }
    }), null);
    libs.spread(_el$, libs.mergeProps$1(others, {
      get style() {
        return {
          "wash-color": local.color
        };
      }
    }), true);
    libs.insert(_el$, () => local.children);
    return _el$;
  })();
};

const CommonItem = props => {
  const merged = libs.mergeProps(props, {
    class: libs.classNames("CommonItem", props.class, props.size ?? "small"),
    showRarity: true
  });
  const [local, others] = libs.splitProps(merged, ["itemName", "showRarity", "stackCount", "rarity", "showTips", "class"]);
  const itemData = libs.createMemo(() => {
    const kv = KeyValues.npc_items_custom[local.itemName];
    let itemType = "none";
    if (KeyValues.artifact[local.itemName]) {
      itemType = "artifact";
    } else if (KeyValues.bless[local.itemName]) {
      itemType = "bless";
    }
    return {
      kv,
      itemType
    };
  });
  const rarity = libs.createMemo(() => {
    if (local.rarity != undefined) return local.rarity;
    let kv = KeyValues.npc_items_custom[local.itemName];
    let rarity = toFiniteNumber(String(kv?.RarityRange).split("|")[0], 1);
    return rarity;
  });
  const tooltip = libs.createMemo(() => {
    const data = itemData();
    return local.showTips && data.itemType !== "none" ? {
      name: "artifact",
      itemName: local.itemName,
      rarity: rarity()
    } : undefined;
  });
  const src = libs.createMemo(() => {
    const abilityTextureName = itemData().kv?.AbilityTextureName;
    if (abilityTextureName == undefined || abilityTextureName == "") return undefined;
    if (abilityTextureName.startsWith("item_")) {
      return `file://{images}/items/${abilityTextureName.substring(5)}.png`;
    }
    return `file://{images}/spellicons/${abilityTextureName}.png`;
  });
  const defaultsrc = libs.createMemo(() => {
    const abilityTextureName = itemData().kv?.AbilityTextureName;
    if (abilityTextureName == undefined || abilityTextureName == "") return undefined;
    if (abilityTextureName.startsWith("item_")) {
      return `raw://resource/flash3/images/items/${abilityTextureName.substring(5)}.png`;
    }
    return `raw://resource/flash3/images/spellicons/${abilityTextureName}.png`;
  });
  const panelClass = libs.createMemo(() => libs.classNames(local.class, itemData().itemType));
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps$1(others, {
        get ["class"]() {
          return panelClass();
        }
      }), null),
      _el$2 = libs.createElement("Image", {
        "class": "ItemIcon",
        scaling: "stretch-to-fit-y-preserve-aspect",
        get src() {
          return src();
        }
      }, _el$),
      _el$3 = libs.createElement("Image", {
        width: "100%",
        height: "100%",
        scaling: "stretch-to-fit-y-preserve-aspect",
        get src() {
          return defaultsrc();
        }
      }, _el$2);
    libs.spread(_el$, libs.mergeProps$1(others, {
      get ["class"]() {
        return panelClass();
      },
      get customTooltip() {
        return tooltip();
      }
    }), true);
    libs.setProp(_el$3, "width", "100%");
    libs.setProp(_el$3, "height", "100%");
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return local.showRarity;
      },
      get children() {
        const _el$4 = libs.createElement("Panel", {
          get ["class"]() {
            return "Border Rarity" + rarity();
          }
        }, null);
        libs.effect(_$p => libs.setProp(_el$4, "class", "Border Rarity" + rarity(), _$p));
        return _el$4;
      }
    }), null);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return local.stackCount != undefined && local.stackCount > 0;
      },
      get children() {
        const _el$5 = libs.createElement("Label", {
          "class": "StackCount",
          get text() {
            return local.stackCount;
          }
        }, null);
        libs.effect(_$p => libs.setProp(_el$5, "text", local.stackCount, _$p));
        return _el$5;
      }
    }), null);
    libs.insert(_el$, () => props.children, null);
    libs.effect(_p$ => {
      const _v$ = src(),
        _v$2 = defaultsrc();
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$2, "src", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$3, "src", _v$2, _p$._v$2));
      return _p$;
    }, {
      _v$: undefined,
      _v$2: undefined
    });
    return _el$;
  })();
};

const SectIcon = props => {
  const merged = libs.mergeProps({
    active: true,
    large: false
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "sectName", "active", "large", "class"]);
  const sectClass = libs.createMemo(() => libs.classNames("SectIcon", local.class, local.sectName, {
    Active: local.active ?? true,
    Large: local.large ?? false
  }));
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps$1(others, {
        get ["class"]() {
          return sectClass();
        }
      }), null);
      libs.createElement("Image", {
        "class": "SectImage"
      }, _el$);
    libs.spread(_el$, libs.mergeProps$1(others, {
      get ["class"]() {
        return sectClass();
      }
    }), true);
    return _el$;
  })();
};

const normalizeKeyName = keyName => keyName.trim().toLowerCase();
const isStickDirectionKey = keyName => /^(x_axis|y_axis|r_axis|u_axis)_(neg|pos)$/.test(keyName);
const textKeyLabelMap = {
  joy5: "LB",
  joy6: "RB",
  joy7: "SELECT",
  joy8: "MENU",
  z_axis_pos: "LT",
  v_axis_pos: "RT",
  lb: "LB",
  rb: "RB",
  select: "SELECT",
  menu: "MENU",
  lt: "LT",
  rt: "RT"
};
const isKnownGamePadKey = keyName => /^(joy[1-9]|joy10|z_axis_pos|v_axis_pos|pov_left|pov_right|pov_up|pov_down|x_axis_neg|x_axis_pos|y_axis_neg|y_axis_pos|r_axis_neg|r_axis_pos|u_axis_neg|u_axis_pos|start|view|home|menu|select)$/.test(keyName);
const getTextKeyLabel = keyName => textKeyLabelMap[keyName];
const EOM_GamePad = rawProps => {
  const props = libs.mergeProps({
    keyName: ""
  }, {
    class: "EOM_GamePad"
  }, rawProps);
  const [local, others] = libs.splitProps(props, ["keyName", "children"]);
  const currentKeyName = libs.createMemo(() => normalizeKeyName(local.keyName));
  const isKnownKey = libs.createMemo(() => isKnownGamePadKey(currentKeyName()));
  const isStickKey = libs.createMemo(() => isStickDirectionKey(currentKeyName()));
  const textKeyLabel = libs.createMemo(() => getTextKeyLabel(currentKeyName()));
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps$1(others, {
      get ["class"]() {
        return libs.classNames(props.class, {
          HasDirection: isStickKey(),
          IsTextKey: textKeyLabel() !== undefined
        }, isKnownKey() ? `Key-${currentKeyName()}` : undefined);
      }
    }), null);
    libs.spread(_el$, libs.mergeProps$1(others, {
      get ["class"]() {
        return libs.classNames(props.class, {
          HasDirection: isStickKey(),
          IsTextKey: textKeyLabel() !== undefined
        }, isKnownKey() ? `Key-${currentKeyName()}` : undefined);
      }
    }), true);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return isKnownKey();
      },
      get fallback() {
        return (() => {
          const _el$2 = libs.createElement("Label", {
            "class": "EOM_GamePadText",
            get text() {
              return local.keyName;
            }
          }, null);
          libs.effect(_$p => libs.setProp(_el$2, "text", local.keyName, _$p));
          return _el$2;
        })();
      },
      children: () => libs.createComponent(libs.Show, {
        get when() {
          return textKeyLabel() !== undefined;
        },
        get fallback() {
          return libs.createComponent(libs.Show, {
            get when() {
              return isStickKey();
            },
            get fallback() {
              return libs.createElement("Image", {
                "class": "EOM_GamePadIcon",
                scaling: "stretch-to-fit-preserve-aspect"
              }, null);
            },
            get children() {
              return [libs.createElement("Image", {
                "class": "EOM_GamePadStick",
                scaling: "stretch-to-fit-preserve-aspect"
              }, null), libs.createElement("Image", {
                "class": "EOM_GamePadDirection",
                scaling: "stretch-to-fit-preserve-aspect"
              }, null)];
            }
          });
        },
        get children() {
          return [libs.createElement("Image", {
            "class": "EOM_GamePadTextBorder"
          }, null), (() => {
            const _el$4 = libs.createElement("Label", {
              "class": "EOM_GamePadTextValue",
              get text() {
                return textKeyLabel();
              }
            }, null);
            libs.effect(_$p => libs.setProp(_el$4, "text", textKeyLabel(), _$p));
            return _el$4;
          })()];
        }
      })
    }), null);
    libs.insert(_el$, () => local.children, null);
    return _el$;
  })();
};

const defaultKeyImg = {
  "MOUSE0": "hud/h_key_mouse.png",
  "MOUSE1": "hud/h_key_mouse.png",
  "MOUSE2": "hud/h_key_mouse.png",
  "SPACE": "hud/h_key_space.png"
};
const EOM_HotKeyDisplay = rawProps => {
  const props = libs.mergeProps({
    hotkey: '',
    filp: false
  }, {
    class: "EOM_HotKeyDisplay"
  }, rawProps);
  const [local, others] = libs.splitProps(props, ['hotkey', 'filp']);
  const isImage = libs.createMemo(() => {
    if (defaultKeyImg[local.hotkey]) {
      return true;
    }
    const hotkey = local.hotkey || '';
    return /\.(jpg|jpeg|png|vtex)$/i.test(hotkey);
  });
  return (() => {
    const _el$ = libs.createElement("Panel", others, null);
    libs.spread(_el$, libs.mergeProps$1(others, {
      get classList() {
        return {
          IsImage: isImage(),
          Filp: local.hotkey == "MOUSE1" || local.filp
        };
      }
    }), true);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return isImage();
      },
      get fallback() {
        return [libs.createElement("Image", {
          "class": 'EOM_HotKeyDisplayBorder'
        }, null), (() => {
          const _el$4 = libs.createElement("Label", {
            "class": 'EOM_HotKeyDisplayText',
            get text() {
              return GetLocalization(local.hotkey);
            }
          }, null);
          libs.effect(_$p => libs.setProp(_el$4, "text", GetLocalization(local.hotkey), _$p));
          return _el$4;
        })()];
      },
      get children() {
        const _el$2 = libs.createElement("Image", {
          "class": 'EOM_HotKeyDisplayImage',
          get src() {
            return libs.memo(() => !!defaultKeyImg[local.hotkey])() ? getSrcPath(defaultKeyImg[local.hotkey]) : local.hotkey;
          },
          scaling: "stretch-to-cover-preserve-aspect"
        }, null);
        libs.effect(_$p => libs.setProp(_el$2, "src", libs.memo(() => !!defaultKeyImg[local.hotkey])() ? getSrcPath(defaultKeyImg[local.hotkey]) : local.hotkey, _$p));
        return _el$2;
      }
    }));
    return _el$;
  })();
};

const HOTKEY_REPLACERS = [["HotKeyAttack", KeyFunction.Attack], ["HotKeySkill", KeyFunction.Skill], ["HotKeyDodge", KeyFunction.Dodge], ["HotKeyDefense", KeyFunction.Defense], ["HotKeyUltimate", KeyFunction.Ultimate]];
const HotkeyLabel = props => {
  let ref;
  const inputMode = createPlayerNetDataSignal("common", "input_mode", {
    mode: "keyboard",
    isGamepad: 0
  });
  const playerKeyValues = createServiceNetData("player_key_values", {});
  const isGamepad = libs.createMemo(() => inputMode().isGamepad == 1);
  const getKeyboardHotkey = func => {
    const data = playerKeyValues();
    const mode = data?.["move_mode"]?.value ?? MOVE_MODE_KEYBOARD;
    const modePrefix = mode == MOVE_MODE_KEYBOARD ? "" : `_m${mode}`;
    const keybindData = data?.[`keybind_keyboard${modePrefix}_${func}`];
    if (keybindData !== undefined && keybindData.value !== undefined) {
      return keybindData.value;
    }
    const defaults = MOVE_MODE_DEFAULTS[mode] ?? DEFAULT_KEYBOARD_BINDINGS;
    return defaults[func] ?? "";
  };
  const getGamepadHotkey = func => {
    return playerKeyValues()[`keybind_gamepad_${func}`]?.value ?? DEFAULT_GAMEPAD_BINDINGS[func] ?? "";
  };
  const HotkeyIcon = iconProps => {
    const keyboardHotkey = libs.createMemo(() => getKeyboardHotkey(iconProps.func));
    const gamepadHotkey = libs.createMemo(() => getGamepadHotkey(iconProps.func));
    return libs.createComponent(libs.Show, {
      get when() {
        return isGamepad();
      },
      get fallback() {
        return libs.createComponent(EOM_HotKeyDisplay, {
          get hotkey() {
            return keyboardHotkey();
          }
        });
      },
      get children() {
        return libs.createComponent(EOM_GamePad, {
          get keyName() {
            return gamepadHotkey();
          },
          uiScale: "70%",
          marginTop: "-4px"
        });
      }
    });
  };
  libs.createEffect(libs.on(() => props.text, () => {
    if (ref && ref.IsValid()) {
      let replacers = ref.Children();
      if (replacers.length > 0) {
        replacers.forEach(replacer => {
          const hotkeyReplacer = HOTKEY_REPLACERS.find(([className]) => replacer.BHasClass(className));
          if (hotkeyReplacer !== undefined) {
            replacer.RemoveAndDeleteChildren();
            libs.insert(replacer, libs.createComponent(HotkeyIcon, {
              get func() {
                return hotkeyReplacer[1];
              }
            }));
          }
        });
      }
    }
  }));
  return (() => {
    const _el$ = libs.createElement("Label", props, null);
    const _ref$ = ref;
    typeof _ref$ === "function" ? libs.use(_ref$, _el$) : ref = _el$;
    libs.spread(_el$, props, false);
    return _el$;
  })();
};

const PLAYER_INFO_CACHE_INTERVAL = 180;
const EQUIPMENT_SIMPLIFY_KEYS = ["id", "equipment_item_id", "level", "remaining_potential", "total_potential", "locked", "in_equip_suit", "ability_entry_data", "inlay_gems_data", "in_check"];
function parseJSONSafe(jsonString, defaultValue) {
  if (!jsonString || jsonString === "null" || jsonString === "undefined") {
    return defaultValue;
  }
  try {
    const parsed = JSON.parse(jsonString);
    return parsed || defaultValue;
  } catch (e) {
    print(`[parseJSONSafe] Failed to parse JSON: ${e}`);
    return defaultValue;
  }
}
function getShopItemBaseCost(itemName, rarity, fallbackCost = 0) {
  let cost;
  const itemKV = KeyValues.npc_items_custom[itemName];
  if (itemKV != undefined && itemKV.GoldCost != undefined && String(itemKV.GoldCost) != "") {
    const costList = String(itemKV.GoldCost).split(" ").map(c => parseInt(c));
    cost = costList[Math.min(costList.length - 1, rarity - 1)];
  }
  return cost ?? SHOP_RARITY_COST[rarity] ?? fallbackCost;
}
function getShopDiscountPercent(heroIndex) {
  return Entities.IsValidEntity(heroIndex) ? Entities.GetPropertyValue(heroIndex, "shop_discount") : 0;
}
function getDiscountedShopItemCost(heroIndex, itemName, rarity, fallbackCost = 0) {
  const cost = getShopItemBaseCost(itemName, rarity, fallbackCost);
  if (cost <= 0) {
    return 0;
  }
  const discountPercent = getShopDiscountPercent(heroIndex);
  return Math.max(0, Math.ceil(cost * (1 - discountPercent * 0.01)));
}
function getShopItemUpgradeInfo(heroIndex, itemName) {
  const itemKV = KeyValues.npc_items_custom[itemName];
  const targetGroup = String(itemKV?.UpgradeGroup ?? "");
  const targetRank = Number(itemKV?.UpgradeRank ?? 0);
  if (targetGroup == "" || targetRank <= 0) {
    return undefined;
  }
  const unitData = getNetDataKey("unit", String(heroIndex)) ?? {
    items: []
  };
  let owned;
  for (const item of unitData.items ?? []) {
    const ownedKV = KeyValues.npc_items_custom[item.itemName];
    if (String(ownedKV?.UpgradeGroup ?? "") != targetGroup) {
      continue;
    }
    const rank = Number(ownedKV?.UpgradeRank ?? 0);
    if (owned == undefined || rank > owned.rank) {
      owned = {
        itemName: item.itemName,
        level: item.level,
        rank
      };
    }
  }
  if (owned == undefined) {
    return undefined;
  }
  return {
    owned,
    targetRank,
    isUpgrade: owned.rank < targetRank
  };
}
function getShopItemDisplayCost(heroIndex, itemName, rarity, fallbackCost = 0) {
  const upgradeInfo = getShopItemUpgradeInfo(heroIndex, itemName);
  if (upgradeInfo != undefined) {
    if (!upgradeInfo.isUpgrade) {
      return 0;
    }
    return Math.max(0, getDiscountedShopItemCost(heroIndex, itemName, rarity, fallbackCost) - getDiscountedShopItemCost(heroIndex, upgradeInfo.owned.itemName, upgradeInfo.owned.level, fallbackCost));
  }
  return getDiscountedShopItemCost(heroIndex, itemName, rarity, fallbackCost);
}
function getTalentLevel(talentId, talentLevels) {
  return talentLevels[talentId] ?? 0;
}
function useTalentLevels(playerID = Game.GetLocalPlayerID()) {
  function Parse(data) {
    const talentsStr = data?.talents;
    return parseJSONSafe(talentsStr, {});
  }
  const playerTalent = createServiceNetData("player_talent", playerID);
  return libs.createMemo(() => Parse(playerTalent()));
}
function usePlayerAccountLevel(levelType = "hero_level", playerID = Game.GetLocalPlayerID()) {
  function Parse(data) {
    return data?.[levelType] ?? {
      level: 1,
      extra_exp: 0
    };
  }
  const playerAccountLevels = createServiceNetData("player_account_levels", playerID);
  return libs.createMemo(() => Parse(playerAccountLevels()));
}
function usePlayerMaxDiff(playerID = Game.GetLocalPlayerID()) {
  function Parse(data) {
    return toFiniteNumber(data?.max_diff, 0);
  }
  const playerCommonMatchData = createServiceNetData("player_common_match_data", playerID);
  return libs.createMemo(() => Parse(playerCommonMatchData()));
}
function usePlayerMaxAbyssalDiff(playerID = Game.GetLocalPlayerID()) {
  function Parse(data) {
    let maxDiff = 0;
    for (const [diffText, info] of Object.entries(data ?? {})) {
      if ((info?.star ?? 0) <= 0) {
        continue;
      }
      const diff = toFiniteNumber(diffText, 0);
      if (diff > maxDiff) {
        maxDiff = diff;
      }
    }
    return maxDiff;
  }
  const playerAbyssalFirstPasses = createServiceNetData("player_abyssal_first_passes", playerID);
  return libs.createMemo(() => Parse(playerAbyssalFirstPasses()));
}
function usePlayerCouriers(playerID = Game.GetLocalPlayerID()) {
  function Parse(data) {
    return data ?? {};
  }
  const playerCouriers = createServiceNetData("player_couriers", playerID);
  return libs.createMemo(() => Parse(playerCouriers()));
}
function getCourierCategories() {
  const categories = [0];
  for (const id of Object.keys(KeyValues.service_courier || {})) {
    const category = KeyValues.service_courier[id]?.category;
    if (category !== undefined && category !== null && !categories.includes(category)) {
      categories.push(category);
    }
  }
  return categories.sort((a, b) => a - b);
}
function getSortedCourierIDs(playerCouriers, categoryID = 0) {
  const courierIDList = Object.keys(KeyValues.courier);
  return courierIDList.filter(id => {
    if (categoryID === 0) return true;
    return KeyValues.service_courier[id]?.category === categoryID;
  }).map(id => ({
    id,
    data: playerCouriers[id] ?? {
      courier_id: id,
      star: 0,
      exp: 0,
      extra_star_exp: 0,
      equipped: 0,
      assist_slot: 0
    }
  })).sort((a, b) => {
    const aEquipped = Boolean(a.data.equipped);
    const bEquipped = Boolean(b.data.equipped);
    if (aEquipped !== bEquipped) {
      return bEquipped ? 1 : -1;
    }
    const starDiff = b.data.star - a.data.star;
    if (starDiff !== 0) {
      return starDiff;
    }
    const aQuality = KeyValues.service_courier[a.id]?.quality ?? 0;
    const bQuality = KeyValues.service_courier[b.id]?.quality ?? 0;
    return bQuality - aQuality;
  }).map(item => toFiniteString(item.data.courier_id));
}
function usePlayerAchievements(playerID = Game.GetLocalPlayerID()) {
  function Parse(data) {
    return data ?? {};
  }
  const playerAchievements = createServiceNetData("player_achievements", playerID);
  return libs.createMemo(() => Parse(playerAchievements()));
}
function resolveMaybeAccessor(value) {
  if (typeof value === "function") {
    return value();
  }
  return value;
}
function normalizeSteamID(raw) {
  if (raw == undefined) return undefined;
  const text = String(raw);
  if (!/^\d+$/.test(text)) return undefined;
  const value = Number(text);
  return value > 0 ? value : undefined;
}
function normalizeSteam64ID(raw) {
  if (raw == undefined) return undefined;
  return normalizeSteamID(Steam_64_3(String(raw)));
}
function getPlayerSteamID(props) {
  const directSteamID = normalizeSteamID(resolveMaybeAccessor(props.steamID));
  if (directSteamID != undefined) return directSteamID;
  const steam64ID = normalizeSteam64ID(resolveMaybeAccessor(props.steam64ID));
  if (steam64ID != undefined) return steam64ID;
  const playerID = resolveMaybeAccessor(props.playerID);
  if (playerID == undefined) return undefined;
  const playerSteam64ID = Game.GetPlayerInfo(playerID)?.player_steamid;
  return normalizeSteam64ID(playerSteam64ID);
}
function reconstructByKey(data, key) {
  const result = {};
  if (data == undefined) return result;
  for (const value of Object.values(data)) {
    if (value == undefined || typeof value !== "object") continue;
    const id = value[key];
    if (id == undefined) continue;
    result[String(id)] = value;
  }
  return result;
}
function reconstructByCombineKey(data, keys) {
  const result = {};
  if (data == undefined) return result;
  for (const value of Object.values(data)) {
    if (value == undefined || typeof value !== "object") continue;
    const id = keys.map(key => value[key]).join("-");
    if (id == "") continue;
    result[id] = value;
  }
  return result;
}
function normalizeShowRoomData(data) {
  const result = {};
  if (data == undefined) return result;
  for (const value of Object.values(data)) {
    if (value == undefined || typeof value !== "object") continue;
    const showType = value.show_type;
    const slot = value.slot;
    if (showType == undefined || slot == undefined) continue;
    const key = `${showType}-${slot}`;
    if (value.id === 0) {
      result[key] = "nil";
      continue;
    }
    let parsed = {};
    if (typeof value.details === "string") {
      const decoded = JSON.parseSafe(value.details);
      parsed = Array.isArray(decoded) ? decoded[0] ?? {} : decoded ?? {};
    } else if (value[showType] != undefined) {
      parsed = value[showType];
    }
    result[key] = {
      show_type: showType,
      slot,
      id: value.id,
      [showType]: parsed
    };
  }
  return result;
}
function extractShowRoomData(data) {
  if (data?.player_show_rooms != undefined) return data.player_show_rooms;
  if (data?.show_room != undefined) return data.show_room;
  if (data?.show_rooms != undefined) return data.show_rooms;
  if (data == undefined || typeof data !== "object") return undefined;
  const rows = Object.values(data).filter(value => {
    return value != undefined && typeof value === "object" && value.show_type != undefined && value.slot != undefined;
  });
  return rows.length > 0 ? rows : undefined;
}
function normalizeEquipments(data) {
  const result = {};
  if (data == undefined) return result;
  for (const value of Object.values(data)) {
    if (value == undefined) continue;
    if (value == "nil") continue;
    if (Array.isArray(value)) {
      const id = value[0];
      if (id != undefined) {
        result[String(id)] = value;
      }
      continue;
    }
    if (typeof value !== "object") continue;
    const id = value.id;
    if (id == undefined) continue;
    result[String(id)] = EQUIPMENT_SIMPLIFY_KEYS.map(key => value[key]);
  }
  return result;
}
function normalizePlayerInfoData(rawData, steamID) {
  const data = rawData ?? {};
  const showRoomData = extractShowRoomData(data);
  return {
    ...data,
    steamID,
    player_account_levels: data.player_account_levels != undefined ? reconstructByKey(data.player_account_levels, "account_type") : data.player_account_levels,
    player_heroes: data.player_heroes != undefined ? reconstructByKey(data.player_heroes, "hero_id") : data.player_heroes,
    player_achievements: data.player_achievements != undefined ? reconstructByKey(data.player_achievements, "task_id") : data.player_achievements,
    player_cosmetic_equips: data.player_cosmetic_equips != undefined ? reconstructByCombineKey(data.player_cosmetic_equips, ["hero_id", "slot_id"]) : data.player_cosmetic_equips,
    player_idle_game_fishes: data.player_idle_game_fishes != undefined ? reconstructByKey(data.player_idle_game_fishes, "id") : data.player_idle_game_fishes,
    player_weapons: data.player_weapons != undefined ? reconstructByKey(data.player_weapons, "weapon_id") : data.player_weapons,
    player_couriers: data.player_couriers != undefined ? reconstructByKey(data.player_couriers, "courier_id") : data.player_couriers,
    player_equipments: data.player_equipments != undefined ? normalizeEquipments(data.player_equipments) : data.player_equipments,
    player_counters: data.player_counters != undefined ? reconstructByKey(data.player_counters, "counter_type") : data.player_counters,
    player_show_rooms: normalizeShowRoomData(showRoomData ?? {})
  };
}
function notifyPlayerInfoCache(entry) {
  for (const listener of entry.listeners) {
    listener();
  }
}
function requestPlayerInfo(steamID, force = false) {
  CustomUIConfig.PlayerInfoCache ??= {};
  const now = Game.Time();
  const entry = CustomUIConfig.PlayerInfoCache[steamID] ??= {
    lastFetchTime: -PLAYER_INFO_CACHE_INTERVAL,
    requesting: false,
    listeners: []
  };
  if (!force && entry.data != undefined && entry.lastFetchTime + PLAYER_INFO_CACHE_INTERVAL > now) {
    notifyPlayerInfoCache(entry);
    return;
  }
  if (entry.requesting) {
    notifyPlayerInfoCache(entry);
    return;
  }
  entry.requesting = true;
  notifyPlayerInfoCache(entry);
  ServerRequest("get_player_info", {
    steamID
  }, result => {
    entry.requesting = false;
    if ((result.code == 0 || result.code == 200) && result.data != undefined) {
      const resultSteamID = normalizeSteamID(result.steamID) ?? steamID;
      const resultEntry = CustomUIConfig.PlayerInfoCache[resultSteamID] ??= entry;
      resultEntry.data = normalizePlayerInfoData(result.data, resultSteamID);
      resultEntry.lastFetchTime = Game.Time();
      resultEntry.requesting = false;
      notifyPlayerInfoCache(resultEntry);
      if (resultSteamID !== steamID) {
        notifyPlayerInfoCache(entry);
      }
      return;
    }
    notifyPlayerInfoCache(entry);
  }, undefined, () => {
    entry.requesting = false;
    notifyPlayerInfoCache(entry);
  });
}
function GetPlayerInfo(props) {
  CustomUIConfig.PlayerInfoCache ??= {};
  const [steamID, setSteamID] = libs.createSignal();
  const [data, setData] = libs.createSignal();
  const [loading, setLoading] = libs.createSignal(false);
  const applyEntry = targetSteamID => {
    const entry = targetSteamID != undefined ? CustomUIConfig.PlayerInfoCache[targetSteamID] : undefined;
    setData(entry?.data);
    setLoading(targetSteamID != undefined && entry?.data == undefined && entry?.requesting == true);
  };
  libs.createEffect(() => {
    const targetSteamID = getPlayerSteamID(props);
    setSteamID(targetSteamID);
    if (targetSteamID == undefined) {
      setData(undefined);
      setLoading(false);
      return;
    }
    const entry = CustomUIConfig.PlayerInfoCache[targetSteamID] ??= {
      lastFetchTime: -PLAYER_INFO_CACHE_INTERVAL,
      requesting: false,
      listeners: []
    };
    const listener = () => {
      if (steamID() === targetSteamID) {
        applyEntry(targetSteamID);
      }
    };
    entry.listeners.push(listener);
    libs.onCleanup(() => {
      const index = entry.listeners.indexOf(listener);
      if (index >= 0) {
        entry.listeners.splice(index, 1);
      }
    });
    applyEntry(targetSteamID);
    requestPlayerInfo(targetSteamID);
  });
  return {
    data,
    loading,
    steamID,
    refresh: () => {
      const targetSteamID = steamID();
      if (targetSteamID != undefined) {
        requestPlayerInfo(targetSteamID, true);
      }
    }
  };
}

const CommonBox = props => {
  const merged = libs.mergeProps({
    showCost: false,
    showTips: true,
    entIndex: -1,
    showAutoAttribute: false
  }, props, {
    class: libs.classNames("CommonBox", props.class)
  });
  const [local, others] = libs.splitProps(merged, ["itemName", "showCost", "cost", "entIndex", "rarity", "upgradeLevel"]);
  const kv = libs.createMemo(() => KeyValues.npc_items_custom[local.itemName] ?? {});
  const rarity = libs.createMemo(() => {
    if (local.rarity != undefined) return local.rarity;
    let kv = KeyValues.npc_items_custom[local.itemName];
    let rarity = toFiniteNumber(String(kv?.RarityRange).split("|")[0], 1);
    return rarity;
  });
  const upgradedRarity = libs.createMemo(() => {
    if (local.upgradeLevel != undefined && local.upgradeLevel > 0) return rarity() + local.upgradeLevel;
    return undefined;
  });
  const goldCost = libs.createMemo(() => {
    let cost = local.cost;
    if (cost != undefined) {
      return Math.max(0, cost);
    }
    return getShopItemDisplayCost(local.entIndex, local.itemName, rarity());
  });
  const abilityDetailValues = libs.createMemo(() => {
    const values = kv()?.AbilityValues || {};
    return Object.entries(values).map(([key, value]) => {
      let label = GetLocalization(`DOTA_Tooltip_ability_${local.itemName}_${key}`, "");
      const hasPct = label.startsWith('%');
      if (hasPct) {
        label = label.slice(1);
      }
      const currentValue = GetAbilityValue(value, {
        hasPct,
        level: rarity(),
        onlyShowNowLevel: true
      });
      let upgradeValue;
      if (upgradedRarity() != undefined) {
        upgradeValue = GetAbilityValue(value, {
          hasPct,
          level: upgradedRarity(),
          onlyShowNowLevel: true
        });
      }
      return {
        key,
        label: label.startsWith('DOTA_Tooltip') ? key : label,
        value: currentValue,
        upgradeValue
      };
    }).filter(item => item.label !== "");
  });
  const commonDescription = libs.createMemo(() => {
    let description = getKeyValueDescription(GetLocalization(`#DOTA_Tooltip_ability_${local.itemName}_description`, ""), kv()?.AbilityValues ?? {}, {
      level: rarity(),
      onlyShowNowLevel: true
    });
    if (kv().Access != "Bless") {
      description += getItemArrtibute(local.itemName, rarity());
    }
    return description;
  });
  const suitList = libs.createMemo(() => (kv().Suit ?? "").split("|").filter(Boolean));
  const extraTags = libs.createMemo(() => {
    const tags = [];
    if (toFiniteNumber(kv().Quantitylimit, 0) == 1) {
      tags.push(GetLocalization("#ArtifactQuantitylimit"));
    }
    if (String(kv().UpgradeGroup ?? "") != "") {
      tags.push(GetLocalization("#ArtifactGrouplimit"));
    }
    return tags;
  });
  const enoughGold = libs.createMemo(() => {
    const playerID = Players.GetLocalPlayer();
    const playerData = getNetDataKey("player_data", "resource", playerID);
    if (!playerData) return true;
    return (playerData.gold ?? 0) >= goldCost();
  });
  return (() => {
    const _el$ = libs.createElement("Panel", others, null),
      _el$2 = libs.createElement("Panel", {
        "class": "CommonInfo"
      }, _el$),
      _el$3 = libs.createElement("Panel", {
        "class": "CommonNameRow"
      }, _el$2),
      _el$4 = libs.createElement("Label", {
        "class": "CommonName",
        html: true,
        get text() {
          return GetLocalization(`#DOTA_Tooltip_ability_${local.itemName}`, "");
        }
      }, _el$3),
      _el$6 = libs.createElement("Panel", {
        "class": "SectList"
      }, _el$),
      _el$7 = libs.createElement("Label", {
        "class": "HeroAbility__PropertyValue AbilityCooldown",
        get text() {
          return kv()?.AbilityCooldown ?? "";
        }
      }, _el$),
      _el$8 = libs.createElement("Label", {
        "class": "HeroAbility__PropertyValue GoldCost",
        get text() {
          return goldCost();
        }
      }, _el$);
    libs.spread(_el$, others, true);
    libs.insert(_el$, libs.createComponent(CommonItem, {
      "class": "AbilityImage",
      get itemName() {
        return local.itemName;
      },
      get rarity() {
        return rarity();
      },
      size: "large"
    }), _el$2);
    libs.insert(_el$3, libs.createComponent(libs.For, {
      get each() {
        return extraTags();
      },
      children: tag => (() => {
        const _el$9 = libs.createElement("Label", {
          html: true,
          get ["class"]() {
            return libs.classNames("CommonExtraTag");
          },
          text: tag
        }, null);
        libs.setProp(_el$9, "text", tag);
        libs.effect(_$p => libs.setProp(_el$9, "class", libs.classNames("CommonExtraTag"), _$p));
        return _el$9;
      })()
    }), null);
    libs.insert(_el$2, libs.createComponent(HotkeyLabel, {
      "class": "CommonDescription",
      html: true,
      get text() {
        return commonDescription();
      }
    }), null);
    libs.insert(_el$2, libs.createComponent(libs.Show, {
      get when() {
        return abilityDetailValues().length > 0;
      },
      get children() {
        const _el$5 = libs.createElement("Panel", {
          "class": "HeroAbility__Details"
        }, null);
        libs.insert(_el$5, libs.createComponent(libs.For, {
          get each() {
            return abilityDetailValues();
          },
          children: detail => (() => {
            const _el$0 = libs.createElement("Panel", {
                "class": "HeroAbility__Detail"
              }, null),
              _el$1 = libs.createElement("Label", {
                html: true,
                "class": "HeroAbility__DetailLabel",
                get text() {
                  return detail.label;
                }
              }, _el$0),
              _el$10 = libs.createElement("Label", {
                html: true,
                "class": "HeroAbility__DetailValue",
                get text() {
                  return detail.value;
                }
              }, _el$0);
            libs.insert(_el$0, libs.createComponent(libs.Show, {
              get when() {
                return detail.upgradeValue != undefined;
              },
              get children() {
                return [libs.createComponent(EOM_Icon, {
                  marginLeft: "4px",
                  type: "DoubleArrowRight",
                  size: "16",
                  align: "center center",
                  color: "#70EA72"
                }), (() => {
                  const _el$11 = libs.createElement("Label", {
                    html: true,
                    marginLeft: "4px",
                    "class": "HeroAbility__DetailValue HeroAbility__UpgradeValue",
                    get text() {
                      return `<font color='#70EA72'>${detail.upgradeValue}</font>`;
                    }
                  }, null);
                  libs.setProp(_el$11, "marginLeft", "4px");
                  libs.effect(_$p => libs.setProp(_el$11, "text", `<font color='#70EA72'>${detail.upgradeValue}</font>`, _$p));
                  return _el$11;
                })()];
              }
            }), null);
            libs.effect(_p$ => {
              const _v$8 = detail.label,
                _v$9 = detail.value;
              _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$1, "text", _v$8, _p$._v$8));
              _v$9 !== _p$._v$9 && (_p$._v$9 = libs.setProp(_el$10, "text", _v$9, _p$._v$9));
              return _p$;
            }, {
              _v$8: undefined,
              _v$9: undefined
            });
            return _el$0;
          })()
        }));
        return _el$5;
      }
    }), null);
    libs.insert(_el$6, libs.createComponent(libs.For, {
      get each() {
        return suitList();
      },
      children: sectName => libs.createComponent(SectIcon, {
        sectName: sectName,
        large: true
      })
    }));
    libs.effect(_p$ => {
      const _v$ = {
          ["Rarity" + rarity()]: true
        },
        _v$2 = GetLocalization(`#DOTA_Tooltip_ability_${local.itemName}`, ""),
        _v$3 = kv()?.AbilityCooldown != undefined,
        _v$4 = kv()?.AbilityCooldown ?? "",
        _v$5 = local.showCost && goldCost() > 0,
        _v$6 = {
          NoEnoughGold: !enoughGold()
        },
        _v$7 = goldCost();
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$4, "classList", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$4, "text", _v$2, _p$._v$2));
      _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$7, "visible", _v$3, _p$._v$3));
      _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$7, "text", _v$4, _p$._v$4));
      _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$8, "visible", _v$5, _p$._v$5));
      _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$8, "classList", _v$6, _p$._v$6));
      _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$8, "text", _v$7, _p$._v$7));
      return _p$;
    }, {
      _v$: undefined,
      _v$2: undefined,
      _v$3: undefined,
      _v$4: undefined,
      _v$5: undefined,
      _v$6: undefined,
      _v$7: undefined
    });
    return _el$;
  })();
};

exports.CommonBox = CommonBox;
exports.CommonItem = CommonItem;
exports.DynamicKey = DynamicKey;
exports.EOM_GamePad = EOM_GamePad;
exports.EOM_HotKeyDisplay = EOM_HotKeyDisplay;
exports.EOM_Icon = EOM_Icon;
exports.GetPlayerInfo = GetPlayerInfo;
exports.HotkeyLabel = HotkeyLabel;
exports.SectIcon = SectIcon;
exports.createGlobalServiceNetData = createGlobalServiceNetData;
exports.createNetDataSignal = createNetDataSignal;
exports.createNetTableSignal = createNetTableSignal;
exports.createPlayerNetDataSignal = createPlayerNetDataSignal;
exports.createPlayerPropertyData = createPlayerPropertyData;
exports.createPlayerUnreadIds = createPlayerUnreadIds;
exports.createServiceNetData = createServiceNetData;
exports.createServiceNetTableDataStore = createServiceNetTableDataStore;
exports.createToggleWindowSignal = createToggleWindowSignal;
exports.getCourierCategories = getCourierCategories;
exports.getPlayerSteamID = getPlayerSteamID;
exports.getShopItemDisplayCost = getShopItemDisplayCost;
exports.getShopItemUpgradeInfo = getShopItemUpgradeInfo;
exports.getSortedCourierIDs = getSortedCourierIDs;
exports.getTalentLevel = getTalentLevel;
exports.parseTokenCosts = parseTokenCosts;
exports.resetStore = resetStore;
exports.usePlayerAccountLevel = usePlayerAccountLevel;
exports.usePlayerAchievements = usePlayerAchievements;
exports.usePlayerCouriers = usePlayerCouriers;
exports.usePlayerMaxAbyssalDiff = usePlayerMaxAbyssalDiff;
exports.usePlayerMaxDiff = usePlayerMaxDiff;
exports.useTalentLevels = useTalentLevels;