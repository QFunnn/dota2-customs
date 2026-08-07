--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Button = require('./EOM_Button.js');
var equipment_comp = require('./equipment_comp.js');
var EOM_DropDown = require('./EOM_DropDown.js');
var EOM_MultiDropDown = require('./EOM_MultiDropDown.js');
var EOM_TextEntry = require('./EOM_TextEntry.js');
var EOM_MenuLayout = require('./EOM_MenuLayout.js');
var hero_level_main = require('./hero_level_main.js');
var hero_selection_bar = require('./hero_selection_bar.js');
var Player = require('./Player.js');
var portraitsFullBodyLoadout = require('./portraitsFullBodyLoadout.js');
var RecycleView = require('./RecycleView.js');
var equip_details = require('./equip_details.js');
var equipment_utils = require('./equipment_utils.js');
var server_equipment = require('./server_equipment.js');
var service_netdata_helper = require('./service_netdata_helper.js');
var global_selection = require('./global_selection.js');
var solid_utils = require('./solid_utils.js');
var StoreItem = require('./StoreItem.js');
var drawing_attr_row = require('./drawing_attr_row.js');
var server_equipment_drawing = require('./server_equipment_drawing.js');
var attribute_formatter = require('./attribute_formatter.js');
var server_dungeon_key = require('./server_dungeon_key.js');
var EOM_CostLabel = require('./EOM_CostLabel.js');
require('./EOM_RedMark.js');
require('./EOM_HeroImage.js');
require('./EOM_Loading.js');
require('./EOM_Countdown.js');

const EMPTY_SLOT_NUM = 5;
const RARITY_SETTING = KeyValues.equip_rarity_setting;
const BREAK_LEVEL_EXP = KeyValues.equip_break_level_exp;
const BREAK_ATTR_LIST = Object.values(BREAK_LEVEL_EXP);
const MAX_LEVEL = Object.keys(BREAK_LEVEL_EXP).length;
const EQUIPMENT_BREAK_KEY_TYPE = "equipment_break";
const EQUIPMENT_AUTO_BREAK_ENABLED_KEY = "equipment_auto_break_enabled";
const EQUIPMENT_AUTO_BREAK_CONFIG_KEY = "equipment_auto_break_config";
const NEEDLV_LIST$1 = Object.values(KeyValues.equip_class_setting).map(setting => setting.need_level);
const DEFAULT_AUTO_BREAK_CONFIG = {
  needLevels: [],
  rarities: [],
  classes: [],
  suits: []
};
const getEnabledFromText = value => value === "1";
const buildSelectedMap = values => {
  const map = {};
  for (const value of values ?? []) {
    map[String(value)] = true;
  }
  return map;
};
const getSelectedNumbers = map => Object.keys(map).filter(key => map[key]).map(Number).filter(value => isFinite(value));
const getSelectedStrings = map => Object.keys(map).filter(key => map[key]);
const getAutoBreakConfigFromText = value => {
  if (!value) return DEFAULT_AUTO_BREAK_CONFIG;
  const parsed = JSON.parseSafe(value);
  if (!parsed) return DEFAULT_AUTO_BREAK_CONFIG;
  return {
    needLevels: Array.isArray(parsed.needLevels) ? parsed.needLevels.map(Number).filter(value => isFinite(value)) : [],
    rarities: Array.isArray(parsed.rarities) ? parsed.rarities.map(Number).filter(value => isFinite(value)) : [],
    classes: Array.isArray(parsed.classes) ? parsed.classes.map(Number).filter(value => isFinite(value)) : [],
    suits: Array.isArray(parsed.suits) ? parsed.suits.map(String).filter(value => value != "") : []
  };
};
const EquipBreak = () => {
  const store = equipment_comp.useEquipmentStore();
  store.draggedSlot;
  const player_equipments = () => store.player_equipments();
  const player_gems = equipment_utils.GetSimplifyGems();
  const [selectedItemList, setSelectedItemList] = store.selectedItemList;
  const [selectSlot, setSelectSlot] = store.selectBreakSlot;
  const [hiddenItemList, setItemListIsHidden] = store.hiddenItemList;
  const [selectedItemTab] = store.selectedItemTab;
  const isGemMode = () => selectedItemTab() === "gem";
  const [fastAddRarity, setFastAddRarity] = libs.createSignal(0);
  const [rewardList, setRewardList] = libs.createSignal([]);
  const [addedExp, setAddedExp] = libs.createSignal(0);
  const [addedLv, setAddedLv] = libs.createSignal(0);
  const [showAutoBreakWindow, setShowAutoBreakWindow] = libs.createSignal(false);
  const [autoBreakEnabled, setAutoBreakEnabled] = libs.createSignal(false);
  const [autoBreakNeedLv, setAutoBreakNeedLv] = libs.createSignal({});
  const [autoBreakRarity, setAutoBreakRarity] = libs.createSignal({});
  const [autoBreakClass, setAutoBreakClass] = libs.createSignal({});
  const [autoBreakSuit, setAutoBreakSuit] = libs.createSignal({});
  let pendingAutoBreakEnabled;
  let autoBreakEnabledSaveRequestID = 0;
  let appliedAutoBreakConfigText;
  const player_account_levels = solid_utils.createServiceNetData("player_account_levels", {
    "equip_break_level": {
      level: 0,
      extra_exp: 0
    }
  });
  const player_key_values = solid_utils.createServiceNetData("player_key_values", {});
  const currentLv = libs.createMemo(() => {
    const lv = player_account_levels().equip_break_level.level;
    return lv;
  });
  const getBreakWindowClass = libs.createMemo(() => {
    const lv = currentLv();
    if (lv < 10) {
      return "Level_1_9";
    } else if (lv < 20) {
      return "Level_10_19";
    } else {
      return "Level_20";
    }
  });
  libs.createEffect(libs.on([selectSlot, showAutoBreakWindow], ([slot, showAutoBreakWindow]) => {
    setItemListIsHidden(showAutoBreakWindow || slot == -1);
  }));
  const getCurrentAutoBreakConfig = () => ({
    needLevels: getSelectedNumbers(autoBreakNeedLv()),
    rarities: getSelectedNumbers(autoBreakRarity()),
    classes: getSelectedNumbers(autoBreakClass()),
    suits: getSelectedStrings(autoBreakSuit())
  });
  const applyAutoBreakConfig = config => {
    setAutoBreakNeedLv(buildSelectedMap(config.needLevels));
    setAutoBreakRarity(buildSelectedMap(config.rarities));
    setAutoBreakClass(buildSelectedMap(config.classes));
    setAutoBreakSuit(buildSelectedMap(config.suits));
  };
  const isAutoBreakMatch = (equip, config) => {
    if (equipment_utils.EquipmentHasStates(equip)) return false;
    const needLevelMatch = config.needLevels.length == 0 || config.needLevels.includes(equip.need_level);
    const rarityMatch = config.rarities.length == 0 || config.rarities.includes(equip.rarity);
    const classMatch = config.classes.length == 0 || config.classes.includes(equip.class);
    const suitMatch = config.suits.length == 0 || equip.ability_entry_data?.[0]?.id != undefined && config.suits.includes(equip.ability_entry_data[0].id);
    return needLevelMatch && rarityMatch && classMatch && suitMatch;
  };
  const hasAutoBreakRule = config => {
    return config.needLevels.length > 0 || config.rarities.length > 0 || config.classes.length > 0 || config.suits.length > 0;
  };
  const autoBreakMatchedCount = libs.createMemo(() => {
    const config = getCurrentAutoBreakConfig();
    if (!hasAutoBreakRule(config)) return 0;
    return Object.values(player_equipments()).filter(equip => isAutoBreakMatch(equip, config)).length;
  });
  const saveAutoBreakEnabled = (checked, panel) => {
    const previousChecked = autoBreakEnabled();
    const requestID = autoBreakEnabledSaveRequestID + 1;
    autoBreakEnabledSaveRequestID = requestID;
    pendingAutoBreakEnabled = checked;
    setAutoBreakEnabled(checked);
    CallActionRequest("/v1/key/save", {
      type: EQUIPMENT_BREAK_KEY_TYPE,
      key: EQUIPMENT_AUTO_BREAK_ENABLED_KEY,
      value: checked ? "1" : "0"
    }, () => {}, () => {
      if (autoBreakEnabledSaveRequestID != requestID) return;
      pendingAutoBreakEnabled = undefined;
      setAutoBreakEnabled(previousChecked);
      if (panel?.IsValid()) {
        panel.checked = previousChecked;
      }
    }, false);
  };
  const submitAutoBreakConfig = (config, button) => {
    if (button?.IsValid()) {
      button.enabled = false;
    }
    CallActionRequest("/v1/key/save", {
      type: EQUIPMENT_BREAK_KEY_TYPE,
      key: EQUIPMENT_AUTO_BREAK_CONFIG_KEY,
      value: JSON.stringify(config)
    }, () => {
      if (button?.IsValid()) button.enabled = true;
    }, () => {
      if (button?.IsValid()) button.enabled = true;
    }, false);
  };
  const saveAutoBreakConfig = button => {
    const config = getCurrentAutoBreakConfig();
    if (config.rarities.includes(6) || config.rarities.includes(7)) {
      CustomUIConfig.showPopup("CommonConfirm", {
        text: "#Equipment_AutoBreakHighRarityConfirm",
        title: "#Equipment_AutoBreak",
        showCancel: true,
        onconfirm: () => submitAutoBreakConfig(config, button)
      });
      return;
    }
    submitAutoBreakConfig(config, button);
  };
  libs.createEffect(libs.on(player_key_values, data => {
    const nextEnabled = getEnabledFromText(data?.[EQUIPMENT_AUTO_BREAK_ENABLED_KEY]?.value);
    if (pendingAutoBreakEnabled == undefined || pendingAutoBreakEnabled == nextEnabled) {
      pendingAutoBreakEnabled = undefined;
      setAutoBreakEnabled(nextEnabled);
    }
    const nextConfigText = data?.[EQUIPMENT_AUTO_BREAK_CONFIG_KEY]?.value;
    if (appliedAutoBreakConfigText != nextConfigText) {
      appliedAutoBreakConfigText = nextConfigText;
      applyAutoBreakConfig(getAutoBreakConfigFromText(nextConfigText));
    }
  }));
  const resetAutoBreakStateFromSavedData = () => {
    const data = player_key_values();
    pendingAutoBreakEnabled = undefined;
    setAutoBreakEnabled(getEnabledFromText(data?.[EQUIPMENT_AUTO_BREAK_ENABLED_KEY]?.value));
    applyAutoBreakConfig(getAutoBreakConfigFromText(data?.[EQUIPMENT_AUTO_BREAK_CONFIG_KEY]?.value));
  };
  const toggleAutoBreakWindow = () => {
    const nextShow = !showAutoBreakWindow();
    if (nextShow) {
      resetAutoBreakStateFromSavedData();
    }
    setShowAutoBreakWindow(nextShow);
  };
  const AutoBreakWindow = () => {
    let needLvFilter;
    const needLvText = libs.createMemo(() => getSelectedStrings(autoBreakNeedLv()).toString());
    libs.onMount(() => {
      const scheduleID = $.Schedule(0.2, () => {
        needLvFilter?.setSelect(autoBreakNeedLv());
      });
      libs.onCleanup(() => $.CancelScheduled(scheduleID));
    });
    return (() => {
      const _el$ = libs.createElement("Panel", {
          id: "AutoBreakWindow"
        }, null);
        libs.createElement("Panel", {
          id: "AutoBreakHeader"
        }, _el$);
        const _el$3 = libs.createElement("Panel", {
          id: "AutoBreakOptions"
        }, _el$),
        _el$4 = libs.createElement("Panel", {
          id: "NeedLvFilter",
          "class": "Filter"
        }, _el$3);
        libs.createElement("Label", {
          id: "FilterType",
          text: "#NeedLvFilter"
        }, _el$4);
        libs.createElement("Label", {
          "class": "Subheading",
          text: "#Equipment_Rarity"
        }, _el$3);
        libs.createElement("Panel", {
          "class": "Separator FilterLine"
        }, _el$3);
        const _el$8 = libs.createElement("Panel", {
          id: "RarityFilterList",
          "class": "CheckBoxList"
        }, _el$3),
        _el$9 = libs.createElement("Label", {
          "class": "Subheading",
          text: "#Equipment_Class"
        }, _el$3);
        libs.createElement("Panel", {
          "class": "Separator FilterLine"
        }, _el$3);
        const _el$1 = libs.createElement("Panel", {
          id: "ClassFilterList",
          "class": "CheckBoxList"
        }, _el$3);
        libs.createElement("Label", {
          "class": "Subheading",
          text: "#Equipment_Suit"
        }, _el$3);
        libs.createElement("Panel", {
          "class": "Separator FilterLine"
        }, _el$3);
        const _el$12 = libs.createElement("Panel", {
          id: "SuitFilterList",
          "class": "CheckBoxList"
        }, _el$3),
        _el$13 = libs.createElement("Panel", {
          id: "AutoBreakFooter"
        }, _el$),
        _el$14 = libs.createElement("Label", {
          id: "AutoBreakMatchedCount",
          text: "#Equipment_AutoBreakMatchedCount",
          get vars() {
            return {
              value: autoBreakMatchedCount()
            };
          }
        }, _el$13);
      libs.insert(_el$4, libs.createComponent(EOM_MultiDropDown.EOM_MultiDropDown, {
        get placeholder() {
          return needLvText();
        },
        ref(r$) {
          const _ref$ = needLvFilter;
          typeof _ref$ === "function" ? _ref$(r$) : needLvFilter = r$;
        },
        options: NEEDLV_LIST$1,
        onChange: value => setAutoBreakNeedLv(value)
      }), null);
      libs.insert(_el$8, libs.createComponent(libs.For, {
        each: equipment_utils.EQUIP_RARITY_COLOR,
        children: (color, idx) => {
          const rarity = idx() + 1;
          return libs.createComponent(equipment_comp.EOM_CheckBox2, {
            "class": "Rarity" + rarity,
            get checked() {
              return autoBreakRarity()[rarity] ?? false;
            },
            get text() {
              return GetLocalization(`#Equipment_Rarity_${rarity}`);
            },
            onchecked: checked => {
              setAutoBreakRarity(prev => {
                const next = {
                  ...prev
                };
                if (checked) {
                  next[rarity] = true;
                } else {
                  delete next[rarity];
                }
                return next;
              });
            }
          });
        }
      }));
      libs.setProp(_el$9, "tooltip", "#Equipment_Class_Desc");
      libs.insert(_el$1, libs.createComponent(libs.For, {
        get each() {
          return Object.keys(GameUI.CustomUIConfig().equip_class_setting);
        },
        children: equipClass => {
          const classID = Number(equipClass);
          return libs.createComponent(equipment_comp.EOM_CheckBox2, {
            get checked() {
              return autoBreakClass()[classID] ?? false;
            },
            text: equipClass,
            onchecked: checked => {
              setAutoBreakClass(prev => {
                const next = {
                  ...prev
                };
                if (checked) {
                  next[classID] = true;
                } else {
                  delete next[classID];
                }
                return next;
              });
            }
          });
        }
      }));
      libs.insert(_el$12, libs.createComponent(libs.For, {
        get each() {
          return Object.keys(KeyValues.equipment_suit_effect);
        },
        children: suitID => libs.createComponent(equipment_comp.EOM_CheckBox2, {
          get checked() {
            return autoBreakSuit()[suitID] ?? false;
          },
          get text() {
            return GetLocalization("#" + suitID);
          },
          onchecked: checked => {
            setAutoBreakSuit(prev => {
              const next = {
                ...prev
              };
              if (checked) {
                next[suitID] = true;
              } else {
                delete next[suitID];
              }
              return next;
            });
          }
        })
      }));
      libs.insert(_el$13, libs.createComponent(EOM_Button.EOM_Button, {
        id: "AutoBreakSaveBtn",
        size: "Small",
        text: "#Equipment_AutoBreakSave",
        onactivate: self => saveAutoBreakConfig(self)
      }), null);
      libs.effect(_$p => libs.setProp(_el$14, "vars", {
        value: autoBreakMatchedCount()
      }, _$p));
      return _el$;
    })();
  };
  const addedAttr = libs.createMemo(() => {
    const lv = player_account_levels().equip_break_level.level;
    let effectAttr = {};
    for (let i = 1; i <= lv; i++) {
      const idx = i - 1;
      BREAK_ATTR_LIST[idx].effect.split("|").forEach(pair => {
        const [name, value] = pair.split(":");
        effectAttr[name] = toFiniteNumber(effectAttr[name]) + Number(value);
      });
    }
    return Object.entries(effectAttr).map(([k, v]) => {
      return {
        attrName: k,
        value: v
      };
    });
  });
  const calculateTarget = () => {
    const curExp = player_account_levels().equip_break_level.extra_exp;
    const curLv = currentLv();
    const added = addedExp();
    if (curLv >= MAX_LEVEL) {
      return {
        finalStack: 0,
        finalProgress: 0,
        finalExp: 0
      };
    }
    let finalExp = curExp + added;
    let targetLv = Math.min(MAX_LEVEL, addedLv() + curLv);
    let finalStack = addedLv();
    let tmp = curLv;
    while (tmp < targetLv) {
      finalExp = finalExp - BREAK_LEVEL_EXP[tmp].exp;
      tmp++;
    }
    const finalProgress = finalExp / BREAK_LEVEL_EXP[targetLv].exp * 100;
    return {
      finalStack,
      finalProgress,
      finalExp
    };
  };
  const calculateBreakReward = (equipID, record) => {
    let lv = player_equipments()[equipID].level - 1;
    while (lv >= 0) {
      KeyValues.equip_level_setting[lv].consume.split("|").forEach(item => {
        const [itemID, num] = item.split(":");
        const amount = toFiniteNumber(num);
        if (amount > 0) {
          record[itemID] = toFiniteNumber(record[itemID]) + toFiniteNumber(num);
        }
      });
      lv--;
    }
  };
  const calculateGemBreakReward = (gemID, record) => {
    const gem = player_gems()[gemID];
    if (!gem) return;
    const kv = Object.values(KeyValues.gem_level).find(row => row.rarity === gem.rarity && row.level === gem.level);
    if (!kv || !kv.decompose) return;
    kv.decompose.split("|").forEach(item => {
      const [itemID, num] = item.split(":");
      const amount = toFiniteNumber(num);
      if (amount > 0) {
        record[itemID] = toFiniteNumber(record[itemID]) + amount;
      }
    });
  };
  libs.createEffect(libs.on(selectedItemList, itemList => {
    let reward = {};
    if (isGemMode()) {
      for (let i = 0; i < itemList.length; i++) {
        let gemID = itemList[i];
        if (!gemID) continue;
        calculateGemBreakReward(gemID, reward);
      }
      setRewardList(Object.keys(reward).map(itemID => {
        return {
          itemID,
          amount: reward[itemID]
        };
      }));
      setAddedExp(0);
      setAddedLv(0);
      return;
    }
    const curExp = player_account_levels().equip_break_level.extra_exp;
    const curLv = player_account_levels().equip_break_level.level;
    let addedExp = 0;
    let addedLv = 0;
    for (let i = 0; i < itemList.length; i++) {
      let equipID = itemList[i];
      if (!equipID) {
        continue;
      }
      let rarity = player_equipments()[equipID].rarity;
      let [itemID, amount] = RARITY_SETTING[rarity].break_bonus.split(":");
      addedExp += Number(amount);
      calculateBreakReward(equipID, reward);
    }
    let currentLv = curLv;
    let totalExp = curExp + addedExp;
    while (currentLv < MAX_LEVEL) {
      const nextLvKv = BREAK_LEVEL_EXP[currentLv];
      if (!nextLvKv) break;
      const nextLvExp = nextLvKv.exp;
      if (totalExp >= nextLvExp) {
        totalExp -= nextLvExp;
        currentLv++;
        addedLv++;
      } else {
        break;
      }
    }
    libs.batch(() => {
      setRewardList(Object.keys(reward).map(itemID => {
        return {
          itemID,
          amount: reward[itemID]
        };
      }));
      setAddedExp(addedExp);
      setAddedLv(addedLv);
    });
    const {
      finalStack,
      finalProgress,
      finalExp
    } = calculateTarget();
    if (addedExp > 0) {
      const currentExp = player_account_levels().equip_break_level.extra_exp;
      const currentLv = player_account_levels().equip_break_level.level;
      const currentLvKv = BREAK_LEVEL_EXP[currentLv];
      animStartProgress = currentExp / currentLvKv.exp * 100;
      if (prevAddedExp === 0) {
        barProgress = animStartProgress;
      }
    } else {
      shouldStopAt100 = false;
    }
    prevAddedExp = addedExp;
    if (addedLv > 0) {
      targetStack = 1;
    } else {
      targetStack = 0;
    }
    if (addedLv > 0) {
      targetProgress = 100;
      shouldStopAt100 = true;
    } else {
      targetProgress = finalProgress;
      shouldStopAt100 = false;
    }
    targetExp = finalExp;
  }));
  let expBar;
  let expAnimBar;
  let expLabel;
  let breakParticle;
  let lvInfoListHandle;
  let curStack = 0;
  let targetStack = 0;
  let barProgress = 0;
  let targetProgress = 0;
  let targetExp = 0;
  let animStartProgress = 0;
  let prevAddedExp = 0;
  let shouldStopAt100 = false;
  let lvInfoScrollSchedule;
  let breakParticleSchedule;
  function playBreakParticle() {
    if (!breakParticle) {
      return;
    }
    if (breakParticleSchedule != undefined) {
      try {
        $.CancelScheduled(breakParticleSchedule);
      } catch (error) {}
    }
    breakParticle.AddClass("Show");
    breakParticle.ReloadScene();
    breakParticleSchedule = $.Schedule(1.2, () => {
      breakParticleSchedule = undefined;
      breakParticle?.RemoveClass("Show");
    });
    Game.EmitSound("ui.treasure_01");
  }
  function scrollToCurrentLv(bNoSmooth = false) {
    const index = BREAK_ATTR_LIST.findIndex(data => data.level == currentLv());
    if (index >= 0) {
      lvInfoListHandle?.scroll2Child(index, "center", bNoSmooth);
    }
  }
  function scheduleScrollToCurrentLv(bNoSmooth = false) {
    if (lvInfoScrollSchedule != undefined) {
      try {
        $.CancelScheduled(lvInfoScrollSchedule);
      } catch (error) {}
    }
    lvInfoScrollSchedule = $.Schedule(0.03, () => {
      lvInfoScrollSchedule = undefined;
      scrollToCurrentLv(bNoSmooth);
    });
  }
  libs.createEffect(libs.on(currentLv, () => {
    scheduleScrollToCurrentLv();
  }));
  libs.onCleanup(() => {
    if (lvInfoScrollSchedule != undefined) {
      try {
        $.CancelScheduled(lvInfoScrollSchedule);
      } catch (error) {}
    }
    if (breakParticleSchedule != undefined) {
      try {
        $.CancelScheduled(breakParticleSchedule);
      } catch (error) {}
    }
  });
  libs.onMount(() => {
    const SPEED_FACTOR = 0.35;
    const MIN_SPEED = 0.3;
    const timer = setInterval(() => {
      let currentTarget = targetProgress;
      if (curStack < targetStack) {
        currentTarget = 100;
      } else if (curStack > targetStack) {
        barProgress = currentTarget;
      }
      if (barProgress < currentTarget) {
        const distance = currentTarget - barProgress;
        const speed = Math.max(Math.sqrt(distance) * SPEED_FACTOR, MIN_SPEED);
        barProgress = Math.min(barProgress + speed, currentTarget);
      } else if (barProgress > currentTarget) {
        barProgress = currentTarget;
      }
      const displayLv = currentLv() + curStack;
      const displayLvKv = BREAK_LEVEL_EXP[displayLv];
      displayLvKv.exp;
      if (barProgress >= currentTarget) {
        if (curStack < targetStack) {
          if (shouldStopAt100) {
            curStack = targetStack;
          } else {
            barProgress = 0;
            curStack = targetStack;
          }
        } else if (curStack > targetStack) {
          barProgress = currentTarget;
          curStack = targetStack;
        }
      }
      const realExp = player_account_levels().equip_break_level.extra_exp;
      const realLv = currentLv();
      const realLvKv = BREAK_LEVEL_EXP[realLv];
      let realProgress = 100;
      if (realLvKv && realLvKv.exp != 0) {
        realProgress = realExp / realLvKv.exp * 100;
      }
      if (expBar != undefined) {
        expBar.style.clip = `rect( 0%, ${realProgress}%, 100%, 0% )`;
      }
      if (addedExp() > 0 && expAnimBar) {
        expAnimBar.style.clip = `rect( 0%, ${barProgress}%, 100%, 0% )`;
      } else if (expAnimBar) {
        expAnimBar.style.clip = `rect( 0%, 0%, 100%, 0% )`;
      }
      if (expLabel) {
        if (realLvKv) {
          if (currentLv() < MAX_LEVEL) {
            expLabel.text = `${realExp}/${realLvKv.exp}`;
          } else {
            expLabel.text = `${realExp}`;
          }
        }
      }
    }, 10);
    libs.onCleanup(() => {
      clearInterval(timer);
    });
  });
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
    id: "EquipBreakRoot",
    get children() {
      const _el$15 = libs.createElement("Panel", {
          id: "CenterBlock",
          hittest: false
        }, null),
        _el$16 = libs.createElement("Panel", {
          id: "ClickPanel"
        }, _el$15),
        _el$17 = libs.createElement("Panel", {
          id: "EquipBreakWindow",
          get ["class"]() {
            return libs.classNames(getBreakWindowClass());
          }
        }, _el$15),
        _el$18 = libs.createElement("Panel", {
          id: "BreakSlotsContainer"
        }, _el$17),
        _el$19 = libs.createElement("Panel", {
          id: "BreakSlots"
        }, _el$18);
        libs.createElement("Panel", {
          id: "CenterImage"
        }, _el$18);
        const _el$21 = libs.createElement("DOTAParticleScenePanel", {
          id: "BreakForgeParticle",
          particleName: "particles/ui/game/ui_game_equipment_interface_02_fx.vpcf",
          cameraOrigin: "0 0 250",
          fov: 90,
          lookAt: "0 0 0",
          hittest: false,
          squarePixels: true
        }, _el$18),
        _el$22 = libs.createElement("Panel", {
          id: "LevelInfo"
        }, _el$18),
        _el$23 = libs.createElement("Panel", {
          width: "100%",
          verticalAlign: "center",
          flowChildren: "down"
        }, _el$22),
        _el$24 = libs.createElement("Label", {
          verticalAlign: "center",
          text: "#Equipment_BreakLvTips"
        }, _el$23),
        _el$26 = libs.createElement("Panel", {
          "class": "ToolTipInfo"
        }, _el$22),
        _el$27 = libs.createElement("Panel", {
          id: "FastAdd"
        }, _el$17),
        _el$31 = libs.createElement("Panel", {
          id: "ExpBarContainer"
        }, _el$17),
        _el$32 = libs.createElement("Image", {
          id: "ExpAnimBar"
        }, _el$31),
        _el$33 = libs.createElement("Image", {
          id: "ExpBar"
        }, _el$31),
        _el$34 = libs.createElement("Label", {
          id: "CurExp"
        }, _el$31),
        _el$35 = libs.createElement("Label", {
          id: "AddexExp",
          get text() {
            return `+${addedExp()}`;
          }
        }, _el$31),
        _el$37 = libs.createElement("Panel", {
          id: "BreakReward",
          get ["class"]() {
            return libs.classNames({
              Show: rewardList().length > 0
            });
          }
        }, _el$17);
        libs.createElement("Label", {
          id: "TipsText",
          text: "#Equipment_Breakreward"
        }, _el$37);
        const _el$39 = libs.createElement("Panel", {
          id: "BreakRewardList",
          flowChildren: "right"
        }, _el$37),
        _el$40 = libs.createElement("Panel", {
          "class": "BtnList"
        }, _el$17),
        _el$41 = libs.createElement("Panel", {
          id: "AutoBreak",
          horizontalAlign: "center",
          flowChildren: "right"
        }, _el$17),
        _el$42 = libs.createElement("Panel", {
          id: "AttributeLvInfo"
        }, _el$15);
      libs.setProp(_el$16, "onactivate", () => {
        setShowAutoBreakWindow(false);
        setSelectSlot(-1);
      });
      libs.insert(_el$19, libs.createComponent(libs.For, {
        get each() {
          return Array(5);
        },
        children: (_, idx) => {
          const slotData = () => {
            const id = selectedItemList()[idx()];
            if (!id) return undefined;
            if (isGemMode()) {
              return player_gems()[id];
            }
            return player_equipments()[id];
          };
          return (() => {
            const _el$44 = libs.createElement("Panel", {
                get id() {
                  return "BreakSlot" + idx();
                },
                get ["class"]() {
                  return libs.classNames("BreakSlot", {
                    Select: idx() == selectSlot()
                  });
                }
              }, null);
              libs.createElement("Panel", {
                id: "Selected"
              }, _el$44);
            libs.setProp(_el$44, "onDragEnter", (pPanel, draggedPanel) => {
              const dragType = isGemMode() ? "gem" : "equip";
              if (LoadData(draggedPanel, dragType)) {
                draggedPanel.AddClass("draggedPanel_drop_enter");
              }
            });
            libs.setProp(_el$44, "onDragLeave", (pPanel, draggedPanel) => {
              draggedPanel.RemoveClass("draggedPanel_drop_enter");
            });
            libs.setProp(_el$44, "onDragDrop", (panel, draggedPanel) => {
              if (isGemMode()) {
                let gemId = LoadData(draggedPanel, "gem");
                if (!gemId) return;
                if (selectedItemList().includes(gemId)) {
                  setSelectedItemList(items => {
                    const newItems = [...items];
                    newItems[items.indexOf(gemId)] = undefined;
                    return newItems;
                  });
                  return;
                }
                setSelectedItemList(items => {
                  const slot = idx();
                  if (slot >= 0 && slot < 5) {
                    const newItems = [...items];
                    newItems[slot] = gemId;
                    return newItems;
                  }
                  if (items.includes(gemId)) {
                    return items.filter(i => i != gemId);
                  }
                  if (items.length < 5) {
                    return [...items, gemId];
                  }
                  return items;
                });
              } else {
                let equip = LoadData(draggedPanel, "equip");
                if (!equip) return;
                if (equipment_utils.EquipmentHasStates(player_equipments()[equip], true)) {
                  return;
                }
                if (selectedItemList().includes(equip)) {
                  setSelectedItemList(items => {
                    const newItems = [...items];
                    newItems[items.indexOf(equip)] = undefined;
                    return newItems;
                  });
                  return;
                }
                setSelectedItemList(items => {
                  const slot = idx();
                  if (slot >= 0 && slot < 5) {
                    const newItems = [...items];
                    newItems[slot] = equip;
                    return newItems;
                  }
                  if (items.includes(equip)) {
                    return items.filter(i => i != equip);
                  }
                  if (items.length < 5) {
                    return [...items, equip];
                  }
                  return items;
                });
              }
            });
            libs.setProp(_el$44, "onactivate", () => {
              setSelectSlot(idx());
            });
            libs.setProp(_el$44, "oncontextmenu", () => {
              const slotIndex = idx();
              const items = selectedItemList();
              if (items[slotIndex]) {
                setSelectedItemList(prev => {
                  const newItems = [...prev];
                  newItems[slotIndex] = undefined;
                  return newItems;
                });
              }
            });
            libs.insert(_el$44, libs.createComponent(libs.Show, {
              get when() {
                return slotData();
              },
              get fallback() {
                return libs.createElement("Panel", {
                  id: "Empty"
                }, null);
              },
              get children() {
                return libs.createComponent(libs.Show, {
                  get when() {
                    return isGemMode();
                  },
                  get fallback() {
                    return libs.createComponent(server_equipment.Equipment, libs.mergeProps$1(() => slotData()));
                  },
                  get children() {
                    return libs.createComponent(server_equipment.Gem, libs.mergeProps$1(() => slotData()));
                  }
                });
              }
            }), null);
            libs.effect(_p$ => {
              const _v$0 = "BreakSlot" + idx(),
                _v$1 = libs.classNames("BreakSlot", {
                  Select: idx() == selectSlot()
                });
              _v$0 !== _p$._v$0 && (_p$._v$0 = libs.setProp(_el$44, "id", _v$0, _p$._v$0));
              _v$1 !== _p$._v$1 && (_p$._v$1 = libs.setProp(_el$44, "class", _v$1, _p$._v$1));
              return _p$;
            }, {
              _v$0: undefined,
              _v$1: undefined
            });
            return _el$44;
          })();
        }
      }));
      const _ref$2 = breakParticle;
      typeof _ref$2 === "function" ? libs.use(_ref$2, _el$21) : breakParticle = _el$21;
      libs.setProp(_el$23, "width", "100%");
      libs.setProp(_el$23, "verticalAlign", "center");
      libs.setProp(_el$23, "flowChildren", "down");
      libs.setProp(_el$24, "verticalAlign", "center");
      libs.insert(_el$23, libs.createComponent(libs.Show, {
        get when() {
          return currentLv() == MAX_LEVEL;
        },
        get fallback() {
          return (() => {
            const _el$47 = libs.createElement("Label", {
              get text() {
                return `Lv.${currentLv()}${addedLv() > 0 ? ToColor(`+${addedLv()}`, '#53b646') : ''}`;
              },
              html: true
            }, null);
            libs.effect(_$p => libs.setProp(_el$47, "text", `Lv.${currentLv()}${addedLv() > 0 ? ToColor(`+${addedLv()}`, '#53b646') : ''}`, _$p));
            return _el$47;
          })();
        },
        get children() {
          const _el$25 = libs.createElement("Label", {
            get text() {
              return `Lv.${currentLv()}`;
            },
            html: true
          }, null);
          libs.effect(_$p => libs.setProp(_el$25, "text", `Lv.${currentLv()}`, _$p));
          return _el$25;
        }
      }), null);
      libs.setProp(_el$26, "tooltip_text", "#Equipment_BreakTips");
      libs.insert(_el$27, libs.createComponent(libs.Show, {
        get when() {
          return isGemMode();
        },
        get fallback() {
          return [libs.createComponent(EOM_DropDown.EOM_DropDown, {
            type: "EquipmentDropDown",
            get index() {
              return fastAddRarity();
            },
            menuPosition: "top",
            onChange: (index, item) => {
              setFastAddRarity(index);
            },
            get children() {
              return [libs.createElement("Label", {
                text: "#ALL"
              }, null), libs.createComponent(libs.For, {
                get each() {
                  return Array(equipment_utils.MAX_EQUIPMENT_RARITY);
                },
                children: (_, idx) => {
                  const rarity = idx() + 1;
                  return (() => {
                    const _el$49 = libs.createElement("Label", {
                      get style() {
                        return {
                          color: equipment_utils.EQUIP_RARITY_COLOR[idx()]
                        };
                      },
                      get text() {
                        return GetLocalization("#Equipment_Rarity_" + rarity);
                      }
                    }, null);
                    libs.effect(_p$ => {
                      const _v$10 = {
                          color: equipment_utils.EQUIP_RARITY_COLOR[idx()]
                        },
                        _v$11 = GetLocalization("#Equipment_Rarity_" + rarity);
                      _v$10 !== _p$._v$10 && (_p$._v$10 = libs.setProp(_el$49, "style", _v$10, _p$._v$10));
                      _v$11 !== _p$._v$11 && (_p$._v$11 = libs.setProp(_el$49, "text", _v$11, _p$._v$11));
                      return _p$;
                    }, {
                      _v$10: undefined,
                      _v$11: undefined
                    });
                    return _el$49;
                  })();
                }
              })];
            }
          }), libs.createComponent(equipment_comp.EquipmentCommonBtn, {
            text: "#Equipment_FastAdd",
            onactivate: () => {
              setSelectSlot(-1);
              setSelectedItemList(prev => {
                const addList = [];
                let equipments = Object.values(player_equipments());
                let list = equipments.map(equip => [equip.id, equip]);
                list.sort((a, b) => {
                  const kvA = KeyValues.info_item_equipment[a[1].equipment_item_id];
                  const kvB = KeyValues.info_item_equipment[b[1].equipment_item_id];
                  if (!kvA || !kvB) return 0;
                  return kvA.rarity - kvB.rarity;
                });
                for (const [uid, equip] of list) {
                  if (addList.length >= EMPTY_SLOT_NUM) break;
                  let id = toFiniteNumber(uid);
                  if (equipment_utils.EquipmentHasStates(equip)) continue;
                  const kv = KeyValues.info_item_equipment[equip.equipment_item_id];
                  if (!kv) continue;
                  const r = kv.rarity;
                  if (fastAddRarity() == 0 || r == fastAddRarity()) {
                    addList.push(id);
                  }
                }
                return addList.length > 0 ? addList : prev;
              });
            }
          })];
        },
        get children() {
          return [libs.createComponent(EOM_DropDown.EOM_DropDown, {
            type: "EquipmentDropDown",
            get index() {
              return fastAddRarity();
            },
            menuPosition: "top",
            onChange: (index, item) => {
              setFastAddRarity(index);
            },
            get children() {
              return [libs.createElement("Label", {
                text: "#ALL"
              }, null), (() => {
                const _el$29 = libs.createElement("Label", {
                  get style() {
                    return {
                      color: equipment_utils.EQUIP_RARITY_COLOR[4]
                    };
                  },
                  get text() {
                    return GetLocalization("#Equipment_Rarity_5");
                  }
                }, null);
                libs.effect(_p$ => {
                  const _v$ = {
                      color: equipment_utils.EQUIP_RARITY_COLOR[4]
                    },
                    _v$2 = GetLocalization("#Equipment_Rarity_5");
                  _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$29, "style", _v$, _p$._v$));
                  _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$29, "text", _v$2, _p$._v$2));
                  return _p$;
                }, {
                  _v$: undefined,
                  _v$2: undefined
                });
                return _el$29;
              })(), (() => {
                const _el$30 = libs.createElement("Label", {
                  get style() {
                    return {
                      color: equipment_utils.EQUIP_RARITY_COLOR[5]
                    };
                  },
                  get text() {
                    return GetLocalization("#Equipment_Rarity_6");
                  }
                }, null);
                libs.effect(_p$ => {
                  const _v$3 = {
                      color: equipment_utils.EQUIP_RARITY_COLOR[5]
                    },
                    _v$4 = GetLocalization("#Equipment_Rarity_6");
                  _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$30, "style", _v$3, _p$._v$3));
                  _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$30, "text", _v$4, _p$._v$4));
                  return _p$;
                }, {
                  _v$3: undefined,
                  _v$4: undefined
                });
                return _el$30;
              })()];
            }
          }), libs.createComponent(equipment_comp.EquipmentCommonBtn, {
            text: "#Equipment_FastAdd",
            onactivate: () => {
              setSelectSlot(-1);
              setSelectedItemList(prev => {
                const addList = [];
                let gems = Object.values(player_gems());
                gems.sort((a, b) => a.rarity - b.rarity);
                for (const gem of gems) {
                  if (addList.length >= EMPTY_SLOT_NUM) break;
                  if (prev.includes(gem.id)) continue;
                  if (fastAddRarity() == 0 || gem.rarity == fastAddRarity()) {
                    addList.push(gem.id);
                  }
                }
                return addList.length > 0 ? addList : prev;
              });
            }
          })];
        }
      }));
      const _ref$3 = expAnimBar;
      typeof _ref$3 === "function" ? libs.use(_ref$3, _el$32) : expAnimBar = _el$32;
      const _ref$4 = expBar;
      typeof _ref$4 === "function" ? libs.use(_ref$4, _el$33) : expBar = _el$33;
      const _ref$5 = expLabel;
      typeof _ref$5 === "function" ? libs.use(_ref$5, _el$34) : expLabel = _el$34;
      libs.insert(_el$31, libs.createComponent(libs.Show, {
        get when() {
          return addedLv() > 0;
        },
        get children() {
          return libs.createElement("Panel", {
            id: "UpgradeIcon"
          }, null);
        }
      }), null);
      libs.setProp(_el$39, "flowChildren", "right");
      libs.insert(_el$39, libs.createComponent(libs.For, {
        get each() {
          return rewardList();
        },
        children: reward => {
          return (() => {
            const _el$50 = libs.createElement("Panel", {
                "class": "RewardItem"
              }, null),
              _el$51 = libs.createElement("Label", {
                get text() {
                  return reward.amount;
                }
              }, _el$50);
            libs.insert(_el$50, libs.createComponent(StoreItem.StoreItemImage, {
              get itemid() {
                return reward.itemID;
              }
            }), _el$51);
            libs.effect(_$p => libs.setProp(_el$51, "text", reward.amount, _$p));
            return _el$50;
          })();
        }
      }));
      libs.insert(_el$40, libs.createComponent(EOM_Button.EOM_Button, {
        id: "ConfirmBtn",
        get enabled() {
          return selectedItemList().length > 0;
        },
        color: "Confirm",
        text: "#Equipment_Break",
        onactivate: () => {
          const list = selectedItemList().filter(d => d != null);
          if (list.length == 0) {
            return;
          }
          if (isGemMode()) {
            CallActionRequest("/v1/gem/break", {
              gem_ids: list
            }, () => {
              playBreakParticle();
              setSelectedItemList([]);
            });
          } else {
            CallActionRequest("/v1/equip/break", {
              ids: list
            }, () => {
              playBreakParticle();
              setSelectedItemList([]);
            });
          }
        }
      }));
      libs.setProp(_el$41, "horizontalAlign", "center");
      libs.setProp(_el$41, "flowChildren", "right");
      libs.insert(_el$41, libs.createComponent(equipment_comp.EOM_CheckBox2, {
        id: "AutoBreakSwitch",
        get checked() {
          return autoBreakEnabled();
        },
        text: "#Equipment_AutoBreak",
        onchecked: saveAutoBreakEnabled
      }), null);
      libs.insert(_el$41, libs.createComponent(EOM_Button.EOM_Button, {
        id: "AutoBreakBtn",
        size: "Small",
        get ["class"]() {
          return libs.classNames({
            Active: showAutoBreakWindow()
          });
        },
        onactivate: toggleAutoBreakWindow,
        text: "#Equipment_AutoBreak"
      }), null);
      libs.insert(_el$15, libs.createComponent(libs.Show, {
        get when() {
          return showAutoBreakWindow();
        },
        get children() {
          return libs.createComponent(AutoBreakWindow, {});
        }
      }), _el$42);
      libs.insert(_el$42, libs.createComponent(RecycleView.RecycleView, {
        id: "LvInfoList",
        direction: "Vertical",
        handle: h => lvInfoListHandle = h,
        input: () => BREAK_ATTR_LIST,
        childConfig: {
          width: 400,
          height: 109
        },
        paddingStart: 30,
        paddingEnd: 30,
        showBar: false,
        onload: () => {
          scheduleScrollToCurrentLv(true);
        },
        children: dataAccessor => {
          const attrs = libs.createMemo(() => {
            return dataAccessor().effect.split("|").map(pair => {
              const [name, value] = pair.split(":");
              return {
                name,
                value: Number(value)
              };
            });
          });
          return (() => {
            const _el$52 = libs.createElement("Panel", {
                get style() {
                  return {
                    zIndex: MAX_LEVEL - dataAccessor().level
                  };
                },
                get ["class"]() {
                  return libs.classNames("LvInfoItemContainer", {
                    Unlock: currentLv() >= dataAccessor().level,
                    Currentlv: currentLv() == dataAccessor().level,
                    Last: dataAccessor().level == MAX_LEVEL
                  });
                }
              }, null),
              _el$53 = libs.createElement("Panel", {
                id: "LvInfo"
              }, _el$52),
              _el$54 = libs.createElement("Label", {
                id: "Level",
                get text() {
                  return dataAccessor().level;
                }
              }, _el$53),
              _el$55 = libs.createElement("Panel", {
                align: "center center",
                flowChildren: "down"
              }, _el$53);
              libs.createElement("Panel", {
                id: "Line"
              }, _el$52);
            libs.setProp(_el$55, "align", "center center");
            libs.setProp(_el$55, "flowChildren", "down");
            libs.insert(_el$55, libs.createComponent(libs.For, {
              get each() {
                return attrs();
              },
              children: attr => (() => {
                const _el$57 = libs.createElement("Label", {
                  id: "Attr",
                  get text() {
                    return GetPropertyLocalization(attr.name, attr.value);
                  },
                  html: true
                }, null);
                libs.effect(_$p => libs.setProp(_el$57, "text", GetPropertyLocalization(attr.name, attr.value), _$p));
                return _el$57;
              })()
            }));
            libs.effect(_p$ => {
              const _v$12 = {
                  zIndex: MAX_LEVEL - dataAccessor().level
                },
                _v$13 = libs.classNames("LvInfoItemContainer", {
                  Unlock: currentLv() >= dataAccessor().level,
                  Currentlv: currentLv() == dataAccessor().level,
                  Last: dataAccessor().level == MAX_LEVEL
                }),
                _v$14 = dataAccessor().level;
              _v$12 !== _p$._v$12 && (_p$._v$12 = libs.setProp(_el$52, "style", _v$12, _p$._v$12));
              _v$13 !== _p$._v$13 && (_p$._v$13 = libs.setProp(_el$52, "class", _v$13, _p$._v$13));
              _v$14 !== _p$._v$14 && (_p$._v$14 = libs.setProp(_el$54, "text", _v$14, _p$._v$14));
              return _p$;
            }, {
              _v$12: undefined,
              _v$13: undefined,
              _v$14: undefined
            });
            return _el$52;
          })();
        }
      }), null);
      libs.insert(_el$42, libs.createComponent(libs.Show, {
        get when() {
          return addedAttr().length > 0;
        },
        get children() {
          return [libs.createComponent(equipment_comp.EquipSeparator, {
            id: "LvInfoSeparator",
            text: "#Equipment_AttributeLvInfo"
          }), (() => {
            const _el$43 = libs.createElement("Panel", {
              id: "AddedAttrList",
              scroll: "y",
              "class": "VerticalScrollStyle"
            }, null);
            libs.setProp(_el$43, "scroll", "y");
            libs.insert(_el$43, libs.createComponent(libs.Index, {
              get each() {
                return addedAttr();
              },
              children: data => {
                return (() => {
                  const _el$58 = libs.createElement("Label", {
                    "class": "AttrLabel",
                    get text() {
                      return GetPropertyLocalization(data().attrName, Number(data().value));
                    },
                    html: true
                  }, null);
                  libs.effect(_$p => libs.setProp(_el$58, "text", GetPropertyLocalization(data().attrName, Number(data().value)), _$p));
                  return _el$58;
                })();
              }
            }));
            return _el$43;
          })()];
        }
      }), null);
      libs.effect(_p$ => {
        const _v$5 = libs.classNames(getBreakWindowClass()),
          _v$6 = addedExp() > 0,
          _v$7 = `+${addedExp()}`,
          _v$8 = libs.classNames({
            Show: rewardList().length > 0
          }),
          _v$9 = hiddenItemList() && !showAutoBreakWindow();
        _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$17, "class", _v$5, _p$._v$5));
        _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$35, "visible", _v$6, _p$._v$6));
        _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$35, "text", _v$7, _p$._v$7));
        _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$37, "class", _v$8, _p$._v$8));
        _v$9 !== _p$._v$9 && (_p$._v$9 = libs.setProp(_el$42, "visible", _v$9, _p$._v$9));
        return _p$;
      }, {
        _v$5: undefined,
        _v$6: undefined,
        _v$7: undefined,
        _v$8: undefined,
        _v$9: undefined
      });
      return _el$15;
    }
  });
};

function calculateMainAttributeData(attrData, classFactor, lvUpFactor, rarity) {
  const baseValue = KeyValues.equip_entry[attrData.id].value_min;
  const rarityBonus = KeyValues.equip_rarity_setting[rarity]?.main_bonus ?? 0;
  let changeValue = baseValue * (1 + classFactor + rarityBonus) * (1 + lvUpFactor);
  return changeValue;
}
function calculateAdverbAttributeData(attrData, classFactor, lvUpFactor, currentClass) {
  const currentClassBonus = KeyValues.equip_class_setting[currentClass]?.adverb_bonus ?? 0;
  let changeValue = attrData.value * (1 + classFactor) / (1 + currentClassBonus);
  return changeValue;
}
const ClassUPWindow = props => {
  const MAX_CLASS = Object.keys(KeyValues.equip_class_setting).length;
  const store = equipment_comp.useEquipmentStore();
  const [selectedItemID] = store.selectedItemID;
  const [, setShowTokens] = store.showTokens;
  const itemData = () => props.itemData();
  const equipClass = () => itemData()?.class ?? 0;
  const bMax = () => equipClass() >= MAX_CLASS;
  const lv = () => itemData()?.level ?? 0;
  const rarity = () => itemData()?.rarity ?? 0;
  const curClassKv = () => {
    return KeyValues.equip_class_setting[equipClass()];
  };
  const nextClassKv = () => {
    if (bMax()) {
      return;
    }
    return KeyValues.equip_class_setting[equipClass() + 1];
  };
  const lvSettingKv = () => {
    if (bMax()) {
      return;
    }
    return KeyValues.equip_level_setting[lv()];
  };
  const consumeList = libs.createMemo(() => {
    const kv = curClassKv();
    store.player_tokens();
    if (!kv || kv.consume == undefined) {
      return [];
    }
    return kv.consume.split("|").map(item => {
      let [itemID, num] = item.split(":");
      return {
        itemID,
        needCount: Number(num),
        hasCount: GetServiceItemCount(itemID)
      };
    }).filter(d => d.needCount > 0);
  });
  libs.createEffect(() => {
    const tokens = consumeList().map(d => toFiniteNumber(d.itemID));
    setShowTokens(tokens);
  });
  const canStrengthen = libs.createMemo(() => consumeList().every(consume => consume.hasCount >= consume.needCount));
  libs.createEffect(() => {
    props.setLeftExtraContent?.((() => {
      const _el$ = libs.createElement("Panel", {
          id: "OperationBtns"
        }, null),
        _el$2 = libs.createElement("Panel", {
          id: "ConsumeBtn",
          flowChildren: "down"
        }, _el$),
        _el$3 = libs.createElement("Panel", {
          horizontalAlign: "center",
          flowChildren: "right"
        }, _el$2);
      libs.insert(_el$, libs.createComponent(EOM_Button.EOM_Button, {
        id: "ReturnBtn",
        text: "#MenuButton_Return",
        onactivate: () => props.onReturn?.()
      }), _el$2);
      libs.setProp(_el$2, "flowChildren", "down");
      libs.setProp(_el$3, "horizontalAlign", "center");
      libs.setProp(_el$3, "flowChildren", "right");
      libs.insert(_el$3, libs.createComponent(libs.For, {
        get each() {
          return consumeList();
        },
        children: consume => {
          return (() => {
            const _el$4 = libs.createElement("Panel", {
                get ["class"]() {
                  return libs.classNames("ComsumeItem", {
                    Enough: consume.hasCount >= consume.needCount
                  });
                }
              }, null),
              _el$5 = libs.createElement("Label", {
                get text() {
                  return "X" + consume.needCount;
                }
              }, _el$4);
            libs.insert(_el$4, libs.createComponent(StoreItem.StoreItemImage, {
              get itemid() {
                return consume.itemID;
              }
            }), _el$5);
            libs.effect(_p$ => {
              const _v$ = libs.classNames("ComsumeItem", {
                  Enough: consume.hasCount >= consume.needCount
                }),
                _v$2 = "X" + consume.needCount;
              _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$4, "class", _v$, _p$._v$));
              _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$5, "text", _v$2, _p$._v$2));
              return _p$;
            }, {
              _v$: undefined,
              _v$2: undefined
            });
            return _el$4;
          })();
        }
      }));
      libs.insert(_el$2, libs.createComponent(EOM_Button.EOM_Button, {
        get enabled() {
          return libs.memo(() => !!!bMax())() && canStrengthen();
        },
        color: "Confirm",
        get text() {
          return GetLocalization(bMax() ? "#Equipment_MaxLv" : "#Equipment_ClassUP");
        },
        onactivate: () => {
          props.startForgeAnimation?.(() => new Promise(resolve => {
            CallActionRequest("/v1/equip/classup", {
              id: selectedItemID()
            }, () => resolve(), () => resolve());
          }));
        }
      }), null);
      return _el$;
    })());
  });
  return (() => {
    const _el$6 = libs.createElement("Panel", {
        id: "ClassUPPanel",
        get ["class"]() {
          return libs.classNames({
            IsMax: bMax()
          }, "RarityColor" + rarity());
        }
      }, null);
      libs.createElement("Label", {
        "class": "WindowTitle",
        text: "#EquipmentTab_classup"
      }, _el$6);
      const _el$8 = libs.createElement("Label", {
        "class": "EquipName EquipRarityLabel",
        get text() {
          return "#" + itemData()?.equipment_item_id;
        }
      }, _el$6),
      _el$9 = libs.createElement("Panel", {
        "class": "ToolTipIcon"
      }, _el$6);
    libs.setProp(_el$9, "tooltip_text", "#EquipClassUpTips");
    libs.insert(_el$6, libs.createComponent(libs.Show, {
      get when() {
        return !bMax();
      },
      get children() {
        const _el$0 = libs.createElement("Panel", {
            id: "ShowClass"
          }, null),
          _el$1 = libs.createElement("Label", {
            id: "CurClass",
            get vars() {
              return {
                value: ToColor(String(equipClass()), "#EBD9B5")
              };
            },
            text: "#Equipment_ClassUPNum",
            html: true
          }, _el$0);
          libs.createElement("Image", {
            id: "Arrow"
          }, _el$0);
          const _el$11 = libs.createElement("Label", {
            id: "NextClass",
            get vars() {
              return {
                value: ToColor(String(equipClass() + 1), "#61C441")
              };
            },
            text: "#Equipment_ClassUPNum",
            html: true
          }, _el$0);
        libs.effect(_p$ => {
          const _v$3 = {
              value: ToColor(String(equipClass()), "#EBD9B5")
            },
            _v$4 = {
              value: ToColor(String(equipClass() + 1), "#61C441")
            };
          _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$1, "vars", _v$3, _p$._v$3));
          _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$11, "vars", _v$4, _p$._v$4));
          return _p$;
        }, {
          _v$3: undefined,
          _v$4: undefined
        });
        return _el$0;
      }
    }), null);
    libs.insert(_el$6, libs.createComponent(equipment_comp.EquipSeparator, {
      id: "ClassUPNextSeparator",
      text: "#Equipment_ClassUPNext"
    }), null);
    libs.insert(_el$6, libs.createComponent(equipment_comp.AttrContainer, {
      get children() {
        return [libs.createComponent(libs.For, {
          get each() {
            return itemData()?.main_entry_data ?? [];
          },
          children: (data, index) => {
            return libs.createComponent(equipment_comp.AttrItem, {
              get index() {
                return index();
              },
              attrData: data,
              get changeValue() {
                return libs.memo(() => !!bMax())() ? undefined : calculateMainAttributeData(data, nextClassKv()?.main_bonus ?? 0, lvSettingKv()?.main_bonus ?? 0, rarity());
              },
              type: "Main"
            });
          }
        }), libs.createComponent(libs.For, {
          get each() {
            return itemData()?.adverb_entry_data ?? [];
          },
          children: (data, index) => {
            return libs.createComponent(equipment_comp.AttrItem, {
              get index() {
                return index();
              },
              attrData: data,
              get changeValue() {
                return libs.memo(() => !!bMax())() ? undefined : calculateAdverbAttributeData(data, nextClassKv()?.adverb_bonus ?? 0, lvSettingKv()?.adverb_bonus ?? 0, equipClass());
              },
              type: "Adverb"
            });
          }
        })];
      }
    }), null);
    libs.effect(_p$ => {
      const _v$5 = libs.classNames({
          IsMax: bMax()
        }, "RarityColor" + rarity()),
        _v$6 = "#" + itemData()?.equipment_item_id;
      _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$6, "class", _v$5, _p$._v$5));
      _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$8, "text", _v$6, _p$._v$6));
      return _p$;
    }, {
      _v$5: undefined,
      _v$6: undefined
    });
    return _el$6;
  })();
};

const DRAWING_RARITY_COUNT = 7;
const DRAWING_BAG_MAX_CAPACITY = 400;
const EQUIP_PART_ICON$2 = {
  0: "icon_zb_01.png",
  1: "icon_zb_03.png",
  2: "icon_zb_08.png",
  3: "icon_zb_09.png",
  4: "icon_zb_07.png",
  5: "icon_zb_06.png",
  6: "icon_zb_05.png",
  7: "icon_zb_04.png",
  8: "icon_zb_02.png"
};
function compareDrawingIDs(a, b, allDrawings) {
  const drawingA = allDrawings[a];
  const drawingB = allDrawings[b];
  const rarityDiff = (drawingA?.rarity ?? 0) - (drawingB?.rarity ?? 0);
  if (rarityDiff != 0) {
    return rarityDiff;
  }
  const itemDiff = (drawingA?.drawing_item_id ?? 0) - (drawingB?.drawing_item_id ?? 0);
  if (itemDiff != 0) {
    return itemDiff;
  }
  return Number(a) - Number(b);
}
function getDrawingPart$1(data) {
  if (!data) {
    return 0;
  }
  const drawingKV = KeyValues.info_item_drawing[data.drawing_item_id];
  return toFiniteNumber(data.drawing_part ?? drawingKV?.drawing_part, 0);
}
function lockDrawing(id, lock) {
  CallAction("/v1/drawing/lock", {
    id: Number(id),
    lock
  });
}
function showDrawingContextMenu(panel, id, data) {
  const menus = {};
  if (data.locked) {
    menus["Hud_Equipment_Unlock"] = () => lockDrawing(id, false);
  } else {
    menus["Hud_Equipment_Lock"] = () => lockDrawing(id, true);
  }
  CustomUIConfig.showContextMenu(panel, menus);
}
const DrawingListPanel = props => {
  const drawingUnreadIds = solid_utils.createPlayerUnreadIds("drawing");
  const [showFilter, setShowFilter] = libs.createSignal(false);
  const [filterRarity, setFilterRarity] = libs.createSignal({});
  const [partFilter, setPartFilter] = libs.createSignal(0);
  const drawingBagCount = libs.createMemo(() => Object.keys(props.playerDrawings()).length);
  const isDrawingBagFull = libs.createMemo(() => drawingBagCount() >= DRAWING_BAG_MAX_CAPACITY);
  libs.onCleanup(() => drawingUnreadIds.submitReadCache());
  const activeRarityFilter = libs.createMemo(() => {
    const rarityFilter = filterRarity();
    return Object.keys(rarityFilter).reduce((result, rarity) => {
      if (rarityFilter[Number(rarity)]) {
        result[Number(rarity)] = true;
      }
      return result;
    }, {});
  });
  const drawingIDs = libs.createMemo(() => {
    const rarityFilter = activeRarityFilter();
    const hasRarityFilter = Object.keys(rarityFilter).length > 0;
    const selectedPart = partFilter();
    const allDrawings = props.playerDrawings();
    return Object.keys(allDrawings).filter(id => {
      const drawingData = allDrawings[id];
      if (selectedPart > 0 && getDrawingPart$1(drawingData) != selectedPart) {
        return false;
      }
      return !hasRarityFilter || rarityFilter[drawingData?.rarity] === true;
    }).sort((a, b) => compareDrawingIDs(a, b, allDrawings));
  });
  const highlightMap = libs.createMemo(() => {
    const result = {};
    const ids = props.highlightIDs?.() ?? [];
    for (let index = 0; index < ids.length; index++) {
      result[ids[index]] = true;
    }
    return result;
  });
  const selectedDrawingData = libs.createMemo(() => {
    const id = props.selectedID?.();
    return id != undefined ? props.playerDrawings()[id] : undefined;
  });
  const setRarityFilterEnabled = (rarity, enabled) => {
    setFilterRarity(prev => {
      const next = {
        ...prev
      };
      if (enabled) {
        next[rarity] = true;
      } else {
        delete next[rarity];
      }
      return next;
    });
  };
  return (() => {
    const _el$ = libs.createElement("Panel", {
        id: "DrawingListRoot"
      }, null),
      _el$2 = libs.createElement("Panel", {
        id: "DrawingListTop"
      }, _el$);
      libs.createElement("Image", {
        id: "DrawingListTopBG"
      }, _el$2);
      const _el$4 = libs.createElement("Label", {
        id: "DrawingListTopTitle",
        get ["class"]() {
          return libs.classNames({
            Full: isDrawingBagFull()
          });
        },
        get text() {
          return `${drawingBagCount()}/${DRAWING_BAG_MAX_CAPACITY}`;
        }
      }, _el$2),
      _el$5 = libs.createElement("Panel", {
        id: "DrawingListContent"
      }, _el$),
      _el$6 = libs.createElement("Panel", {
        id: "DrawingListBox"
      }, _el$5),
      _el$1 = libs.createElement("Panel", {
        id: "PartFilter"
      }, _el$5),
      _el$10 = libs.createElement("Panel", {
        id: "BtnsContainer"
      }, _el$),
      _el$11 = libs.createElement("Panel", {
        align: "center center",
        flowChildren: "right"
      }, _el$10),
      _el$12 = libs.createElement("Button", {
        id: "ResetBtn",
        "class": "SecondaryButtonStates"
      }, _el$11);
    libs.insert(_el$6, libs.createComponent(libs.Show, {
      get when() {
        return showFilter();
      },
      get fallback() {
        return libs.createComponent(RecycleView.RecycleView, {
          id: "DrawingsList",
          input: drawingIDs,
          direction: "VerticalGrid",
          wheelStep: 88,
          childConfig: {
            width: 88,
            height: 88,
            margin: 2
          },
          grid_children: () => libs.createElement("Panel", {
            "class": "EquipListGrid"
          }, null),
          children: id => {
            const drawingData = () => props.playerDrawings()[id()];
            const isNew = () => drawingUnreadIds.isUnread(id());
            return (() => {
              const _el$14 = libs.createElement("Panel", {
                  "class": "Item",
                  get onDragStart() {
                    return props.onDrawingDragStart(id);
                  },
                  get onDragEnd() {
                    return props.onDrawingDragEnd;
                  }
                }, null),
                _el$15 = libs.createElement("Panel", {
                  "class": "SelectedBorder",
                  hittest: false
                }, _el$14);
                libs.createElement("Panel", {
                  id: "NewTag",
                  hittest: false
                }, _el$14);
              libs.setProp(_el$14, "onmouseover", () => {
                if (isNew()) {
                  drawingUnreadIds.markRead(id());
                }
              });
              libs.insert(_el$14, libs.createComponent(server_equipment_drawing.EquipmentDrawingItem, libs.mergeProps$1(drawingData, {
                onactivate: () => props.onSelect?.(id()),
                oncontextmenu: panel => {
                  showDrawingContextMenu(panel, id(), drawingData());
                }
              })), _el$15);
              libs.effect(_p$ => {
                const _v$3 = {
                    Selected: props.selectedID?.() == id(),
                    InRecast: highlightMap()[id()] === true,
                    New: isNew()
                  },
                  _v$4 = props.onDrawingDragStart(id),
                  _v$5 = props.onDrawingDragEnd;
                _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$14, "classList", _v$3, _p$._v$3));
                _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$14, "onDragStart", _v$4, _p$._v$4));
                _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$14, "onDragEnd", _v$5, _p$._v$5));
                return _p$;
              }, {
                _v$3: undefined,
                _v$4: undefined,
                _v$5: undefined
              });
              return _el$14;
            })();
          }
        });
      },
      get children() {
        const _el$7 = libs.createElement("Panel", {
            id: "DrawingFilterWindow"
          }, null);
          libs.createElement("Label", {
            id: "RarityLabel",
            "class": "Subheading",
            text: "#Equipment_Rarity"
          }, _el$7);
          libs.createElement("Panel", {
            "class": "FilterLine"
          }, _el$7);
          const _el$0 = libs.createElement("Panel", {
            id: "RarityFilterList",
            "class": "CheckBoxList"
          }, _el$7);
        libs.insert(_el$0, libs.createComponent(libs.For, {
          get each() {
            return Array(DRAWING_RARITY_COUNT);
          },
          children: (_, idx) => {
            const rarity = idx() + 1;
            return libs.createComponent(equipment_comp.EOM_CheckBox2, {
              "class": "Rarity" + rarity,
              get checked() {
                return filterRarity()[rarity] ?? false;
              },
              get text() {
                return GetLocalization(`#Equipment_Rarity_${rarity}`);
              },
              onchecked: b => {
                setRarityFilterEnabled(rarity, b);
              }
            });
          }
        }));
        return _el$7;
      }
    }));
    libs.insert(_el$1, libs.createComponent(libs.For, {
      get each() {
        return [0, ...equipment_utils.EQUIP_PARTS];
      },
      children: part => (() => {
        const _el$17 = libs.createElement("Button", {
            get id() {
              return part.toString();
            },
            "class": "PartTab"
          }, null),
          _el$18 = libs.createElement("Image", {
            id: "PartIcon",
            get src() {
              return getSrcPath(`conv/icon/${EQUIP_PART_ICON$2[part]}`);
            }
          }, _el$17);
        libs.setProp(_el$17, "onactivate", () => setPartFilter(part));
        libs.effect(_p$ => {
          const _v$6 = part.toString(),
            _v$7 = {
              Selected: partFilter() == part
            },
            _v$8 = getSrcPath(`conv/icon/${EQUIP_PART_ICON$2[part]}`);
          _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$17, "id", _v$6, _p$._v$6));
          _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$17, "classList", _v$7, _p$._v$7));
          _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$18, "src", _v$8, _p$._v$8));
          return _p$;
        }, {
          _v$6: undefined,
          _v$7: undefined,
          _v$8: undefined
        });
        return _el$17;
      })()
    }));
    libs.setProp(_el$11, "align", "center center");
    libs.setProp(_el$11, "flowChildren", "right");
    libs.insert(_el$11, libs.createComponent(equipment_comp.EquipmentCommonBtn, {
      id: "FilterBtn",
      get classList() {
        return {
          ShowBtnBorder: showFilter()
        };
      },
      text: "#Hud_Equipment_Filter",
      onactivate: () => {
        setShowFilter(prev => !prev);
      }
    }), _el$12);
    libs.setProp(_el$12, "onactivate", () => {
      setFilterRarity({});
      setPartFilter(0);
    });
    libs.insert(_el$11, libs.createComponent(libs.Show, {
      get when() {
        return props.selectedID != undefined;
      },
      get fallback() {
        return libs.createComponent(equipment_comp.EquipmentCommonBtn, {
          opacity: "0"
        });
      },
      get children() {
        return libs.createComponent(equipment_comp.EquipmentCommonBtn, {
          get text() {
            return selectedDrawingData()?.locked ? "#Hud_Equipment_Unlock" : "#Hud_Equipment_Lock";
          },
          get enabled() {
            return selectedDrawingData() != undefined;
          },
          onactivate: () => {
            const id = props.selectedID?.();
            const data = selectedDrawingData();
            if (id != undefined && data != undefined) {
              lockDrawing(id, !data.locked);
            }
          }
        });
      }
    }), null);
    libs.effect(_p$ => {
      const _v$ = libs.classNames({
          Full: isDrawingBagFull()
        }),
        _v$2 = `${drawingBagCount()}/${DRAWING_BAG_MAX_CAPACITY}`;
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$4, "class", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$4, "text", _v$2, _p$._v$2));
      return _p$;
    }, {
      _v$: undefined,
      _v$2: undefined
    });
    return _el$;
  })();
};

function findEquipIDByDrawingKV(drawingKV) {
  for (const equipID in KeyValues.info_item_equipment) {
    const equipKV = KeyValues.info_item_equipment[equipID];
    if (equipKV.class === drawingKV.class && equipKV.equip_part === drawingKV.drawing_part && equipKV.rarity === drawingKV.rarity) {
      return equipKV.id;
    }
  }
}
function getDrawingSelectConfig(mainEntryType) {
  switch (mainEntryType) {
    case "drawing_3":
      return {
        payloadKey: "adverb_entry_ids"
      };
    case "drawing_4":
      return {
        payloadKey: "ability_entry_ids"
      };
    case "drawing_5":
      return {
        payloadKey: "myth_entry_ids"
      };
    case "drawing_6":
      return {
        payloadKey: "chaos_entry_ids"
      };
  }
}
function matchEquipEntryByMainEntryType(mainEntryType, entryType) {
  switch (mainEntryType) {
    case "drawing_3":
      return entryType === 2;
    case "drawing_4":
      return entryType === 3;
    case "drawing_5":
      return entryType === 4;
    case "drawing_6":
      return entryType === 5;
    default:
      return false;
  }
}
function getDrawingDropDownOptionLabel(entryID, entryKV) {
  switch (entryKV.entry_type) {
    case 2:
      {
        const labelInfo = attribute_formatter.formatAttributeNameHtml({
          id: entryID
        }, {
          config: {
            ratio: entryKV.ratio ?? CustomUIConfig.EntryRatio[entryID] ?? 1,
            value_min: entryKV.value_min,
            value_max: entryKV.value_max
          }
        });
        return {
          id: entryID,
          label: labelInfo.nameHtml,
          html: true
        };
      }
    case 3:
      return {
        id: entryID,
        label: GetLocalization(entryKV.entry_name),
        html: true
      };
    case 4:
      return {
        id: entryID,
        label: GetPrivilegeDesc(entryID, 1, {
          min: entryKV.value_min,
          max: entryKV.value_max
        }).replace(/%value%%?/g, ""),
        html: true
      };
    case 5:
      return {
        id: entryID,
        label: attribute_formatter.formatAttributeNameHtml({
          id: entryID
        }, {
          config: {
            ratio: entryKV.ratio ?? CustomUIConfig.EntryRatio[entryID] ?? 1,
            value_min: entryKV.value_min,
            value_max: entryKV.value_max
          }
        }).nameHtml,
        html: true
      };
  }
}
function buildDrawingDetailViewModel(id, drawingData, heroLevel) {
  if (!drawingData) {
    return;
  }
  const drawingItemID = drawingData.drawing_item_id;
  const drawingKV = KeyValues.info_item_drawing[drawingItemID];
  if (!drawingKV) {
    return;
  }
  const drawingClassSetting = KeyValues.drawing_class_setting[drawingKV.class];
  const equipID = findEquipIDByDrawingKV(drawingKV);
  if (!equipID) {
    return;
  }
  const equipKV = KeyValues.info_item_equipment[equipID];
  if (!equipKV) {
    return;
  }
  const equipClassSetting = KeyValues.equip_class_setting[equipKV.class];
  const equipRaritySetting = KeyValues.equip_rarity_setting[equipKV.rarity];
  const mainEntry = drawing_attr_row.getDrawingMainEntry(drawingData);
  const selectConfig = getDrawingSelectConfig(mainEntry?.entry_main_type);
  const equipEntries = drawing_attr_row.parseDrawingEntries(drawingData.drawing_entry_data);
  const potentialBonus = mainEntry?.entry_main_type === "drawing_2" ? mainEntry.value_1 ?? 0 : 0;
  const consumeList = [];
  const drawingCost = drawingClassSetting?.drawing_cost;
  if (drawingCost) {
    for (const itemID in drawingCost) {
      consumeList.push({
        itemID,
        needCount: drawingCost[itemID]
      });
    }
  }
  return {
    equipId: equipID.toString(),
    rarity: drawingData.rarity ?? 0,
    equipClass: equipKV.class,
    potentialMin: (equipRaritySetting?.potential_num_min ?? 0) + potentialBonus,
    potentialMax: (equipRaritySetting?.potential_num_max ?? 0) + potentialBonus,
    needLevel: equipClassSetting?.need_level ?? 1,
    canWear: heroLevel >= (equipClassSetting?.need_level ?? 1),
    mainEntry,
    equipEntries,
    selectPayloadKey: selectConfig?.payloadKey,
    selectCount: Math.max(1, mainEntry?.value_1 ?? 1),
    consumeList
  };
}
function DrawingMakeContent(props) {
  const [requesting, setRequesting] = libs.createSignal(false);
  const drawingCraftAccountID = libs.createMemo(() => Steam_64_3(Game.GetLocalPlayerInfo().player_steamid));
  const [selectedDropDownEntryID, setSelectedDropDownEntryID] = libs.createSignal();
  const [selectedDropDownEntryIDs, setSelectedDropDownEntryIDs] = libs.createSignal([]);
  let multiDropDownRef;
  const selectedItemData = libs.createMemo(() => {
    const id = props.selectedID();
    if (!id) {
      return;
    }
    return props.playerDrawings()[id];
  });
  const selectedDetailVM = libs.createMemo(() => {
    const id = props.selectedID();
    if (!id) {
      return;
    }
    const heroLevel = getServiceNetData("player_account_levels", Players.GetLocalPlayer())?.hero_level?.level ?? 1;
    return buildDrawingDetailViewModel(id, props.playerDrawings()[id], heroLevel);
  });
  const dropDownOptions = libs.createMemo(() => {
    const detailVM = selectedDetailVM();
    const mainEntryType = detailVM?.mainEntry?.entry_main_type;
    if (!mainEntryType || !detailVM?.selectPayloadKey) {
      return [];
    }
    const options = [];
    for (const entryID in KeyValues.equip_entry) {
      const entryKV = KeyValues.equip_entry[entryID];
      if (matchEquipEntryByMainEntryType(mainEntryType, entryKV.entry_type)) {
        const option = getDrawingDropDownOptionLabel(entryID, entryKV);
        if (!option) {
          continue;
        }
        options.push({
          sortID: entryKV.id,
          option
        });
      }
    }
    return options.sort((a, b) => a.sortID - b.sortID).map(item => item.option);
  });
  const selectedDropDownIndex = libs.createMemo(() => {
    const selectedEntryID = selectedDropDownEntryID();
    if (!selectedEntryID) {
      return -1;
    }
    return dropDownOptions().findIndex(option => option.id === selectedEntryID);
  });
  const isMultiSelect = libs.createMemo(() => {
    const detailVM = selectedDetailVM();
    return detailVM?.selectPayloadKey != undefined && detailVM.selectCount > 1;
  });
  const selectedDropDownEntryIDMap = libs.createMemo(() => {
    const result = {};
    const selectedIDs = selectedDropDownEntryIDs();
    for (let index = 0; index < selectedIDs.length; index++) {
      result[selectedIDs[index]] = true;
    }
    return result;
  });
  function resetSelectState() {
    setSelectedDropDownEntryID();
    setSelectedDropDownEntryIDs([]);
    multiDropDownRef?.reset();
  }
  const canCraft = libs.createMemo(() => {
    const detailVM = selectedDetailVM();
    const id = props.selectedID();
    if (!detailVM || !id || requesting()) {
      return false;
    }
    if (detailVM.selectPayloadKey) {
      if (detailVM.selectCount > 1) {
        return selectedDropDownEntryIDs().length === detailVM.selectCount;
      }
      return selectedDropDownIndex() >= 0;
    }
    return true;
  });
  libs.createEffect(() => {
    props.selectedID();
    resetSelectState();
  });
  function getMultiSelectPlaceholder() {
    const detailVM = selectedDetailVM();
    const selectedCount = Object.values(selectedDropDownEntryIDMap()).filter(Boolean).length;
    return `${drawing_attr_row.getDrawingMainEntryText(detailVM?.mainEntry)} (${selectedCount}/${detailVM?.selectCount ?? 0})`;
  }
  function handleMultiSelectChange(value) {
    const detailVM = selectedDetailVM();
    const maxSelectCount = detailVM?.selectCount ?? 1;
    const selectedIDs = [];
    const normalizedValue = {};
    const options = dropDownOptions();
    for (let index = 0; index < options.length; index++) {
      const optionID = options[index].id;
      if (value[optionID] === true && selectedIDs.length < maxSelectCount) {
        selectedIDs.push(optionID);
        normalizedValue[optionID] = true;
      } else {
        normalizedValue[optionID] = false;
      }
    }
    if (selectedIDs.length !== Object.values(value).filter(Boolean).length) {
      multiDropDownRef?.setSelect(normalizedValue);
    }
    setSelectedDropDownEntryID();
    setSelectedDropDownEntryIDs(selectedIDs);
  }
  function buildCraftPayload() {
    const detailVM = selectedDetailVM();
    const drawingID = props.selectedID();
    if (!detailVM || !drawingID) {
      return undefined;
    }
    const payload = {
      drawing_id: Number(drawingID)
    };
    if (detailVM.selectPayloadKey) {
      if (detailVM.selectCount > 1) {
        const selectedEntryIDs = selectedDropDownEntryIDs();
        if (selectedEntryIDs.length !== detailVM.selectCount) {
          return undefined;
        }
        payload[detailVM.selectPayloadKey] = selectedEntryIDs;
      } else {
        const selectedEntryID = selectedDropDownEntryID();
        if (!selectedEntryID || selectedDropDownIndex() < 0) {
          return undefined;
        }
        payload[detailVM.selectPayloadKey] = [selectedEntryID];
      }
    }
    return payload;
  }
  function handleCraft() {
    if (requesting()) {
      return;
    }
    const payload = buildCraftPayload();
    if (!payload) {
      return;
    }
    setRequesting(true);
    CallActionRequest("/v1/drawing/craft", payload, () => {
      setRequesting(false);
    }, () => {
      setRequesting(false);
    });
  }
  return (() => {
    const _el$ = libs.createElement("Panel", {
      id: "DrawingMakePanelRoot"
    }, null);
    libs.insert(_el$, libs.createComponent(EOM_Button.EOM_BaseButton, {
      id: "ActionSlot",
      get classList() {
        return {
          HasDrawing: selectedItemData() != undefined
        };
      },
      get onDragEnter() {
        return props.onActionSlotDragEnter;
      },
      get onDragLeave() {
        return props.onActionSlotDragLeave;
      },
      get onDragDrop() {
        return props.onActionSlotDrop;
      },
      get children() {
        return libs.createComponent(libs.Show, {
          get when() {
            return selectedItemData();
          },
          get children() {
            return libs.createComponent(server_equipment_drawing.EquipmentDrawingItem, libs.mergeProps$1(() => selectedItemData(), {
              oncontextmenu: () => props.setSelectedID(),
              get onDragStart() {
                return props.onDrawingDragStart;
              },
              get onDragEnd() {
                return props.onDrawingDragEnd;
              }
            }));
          }
        });
      }
    }), null);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return selectedItemData();
      },
      get fallback() {
        return [libs.createElement("Label", {
          id: "EmptyTitle",
          text: "#EquipmentDrawing_SelectDrawing"
        }, null), libs.createElement("Label", {
          id: "EmptyDesc",
          text: "#EquipmentDrawing_SelectDrawingDesc",
          html: true
        }, null)];
      },
      get children() {
        const _el$2 = libs.createElement("Panel", {
            id: "DrawingDetail"
          }, null),
          _el$3 = libs.createElement("Panel", {
            id: "DetailNameRow"
          }, _el$2);
          libs.createElement("Label", {
            id: "DetailName",
            text: "#Equipment_PutDrawing"
          }, _el$3);
          const _el$5 = libs.createElement("Panel", {
            id: "PreviewTitleRow"
          }, _el$2);
          libs.createElement("Panel", {
            id: "PreviewLineLeft"
          }, _el$5);
          libs.createElement("Label", {
            id: "PreviewTitle",
            text: "#Equipment_Preview"
          }, _el$5);
          libs.createElement("Panel", {
            id: "PreviewLineRight"
          }, _el$5);
          const _el$9 = libs.createElement("Panel", {
            id: "DetailInfo"
          }, _el$2),
          _el$0 = libs.createElement("Panel", {
            id: "DetailInfoLeft"
          }, _el$9),
          _el$1 = libs.createElement("Label", {
            id: "EquipPreviewName",
            get text() {
              return "#" + (selectedDetailVM()?.equipId ?? "");
            }
          }, _el$0),
          _el$10 = libs.createElement("Panel", {
            flowChildren: "right"
          }, _el$0),
          _el$11 = libs.createElement("Panel", {
            id: "EquipPreviewPotential"
          }, _el$10),
          _el$12 = libs.createElement("Label", {
            text: "#Equip_RemainingPotentialM",
            get vars() {
              return {
                min: selectedDetailVM()?.potentialMin ?? 0,
                max: selectedDetailVM()?.potentialMax ?? 0
              };
            }
          }, _el$11),
          _el$13 = libs.createElement("Panel", {
            id: "EquipPreviewCraftBy"
          }, _el$10);
          libs.createElement("Label", {
            text: "#Equipment_Maker"
          }, _el$13);
          const _el$15 = libs.createElement("Panel", {
            id: "EquipPreviewDiff"
          }, _el$0),
          _el$16 = libs.createElement("Label", {
            "class": "InfoLabel",
            get vars() {
              return {
                value: selectedDetailVM()?.equipClass ?? 0
              };
            },
            text: "#Equip_Class"
          }, _el$15),
          _el$17 = libs.createElement("Label", {
            "class": "InfoLabel",
            get vars() {
              return {
                value: selectedDetailVM()?.canWear ? selectedDetailVM()?.needLevel.toString() ?? "1" : ToColor(selectedDetailVM()?.needLevel.toString() ?? "1", "#E55043")
              };
            },
            text: "#Equip_NeedLevel",
            html: true
          }, _el$15),
          _el$18 = libs.createElement("Panel", {
            id: "DetailInfoRight"
          }, _el$9),
          _el$19 = libs.createElement("Panel", {
            id: "EquipPreviewIconWrap"
          }, _el$18),
          _el$21 = libs.createElement("Panel", {
            id: "MakeBtnArea"
          }, _el$2),
          _el$22 = libs.createElement("Panel", {
            id: "MakeConsumeRow"
          }, _el$21);
        libs.setProp(_el$10, "flowChildren", "right");
        libs.insert(_el$13, libs.createComponent(Player.PlayerName, {
          get accountid() {
            return drawingCraftAccountID();
          }
        }), null);
        libs.insert(_el$19, libs.createComponent(server_equipment.EquipmentIcon, {
          get equipment_item_id() {
            return Number(selectedDetailVM()?.equipId ?? 0);
          },
          get rarity() {
            return selectedDetailVM()?.rarity ?? 1;
          }
        }));
        libs.insert(_el$2, libs.createComponent(libs.Show, {
          get when() {
            return selectedDetailVM()?.selectPayloadKey != undefined;
          },
          get fallback() {
            return libs.createComponent(libs.Show, {
              get when() {
                return selectedDetailVM()?.mainEntry;
              },
              get children() {
                const _el$25 = libs.createElement("Label", {
                  "class": "DrawingMainEntry",
                  get text() {
                    return drawing_attr_row.getDrawingMainEntryText(selectedDetailVM()?.mainEntry);
                  }
                }, null);
                libs.effect(_$p => libs.setProp(_el$25, "text", drawing_attr_row.getDrawingMainEntryText(selectedDetailVM()?.mainEntry), _$p));
                return _el$25;
              }
            });
          },
          get children() {
            return libs.createComponent(libs.Show, {
              get when() {
                return isMultiSelect();
              },
              get fallback() {
                return libs.createComponent(EOM_DropDown.EOM_DropDown, {
                  id: "DrawingEntryDropDown",
                  type: "EquipmentDropDown",
                  get index() {
                    return selectedDropDownIndex();
                  },
                  get placeholder() {
                    return drawing_attr_row.getDrawingMainEntryText(selectedDetailVM()?.mainEntry);
                  },
                  onChange: index => {
                    const option = dropDownOptions()[index];
                    setSelectedDropDownEntryID(option?.id);
                  },
                  onClear: () => {
                    setSelectedDropDownEntryID();
                  },
                  get children() {
                    return libs.createComponent(libs.For, {
                      get each() {
                        return dropDownOptions();
                      },
                      children: option => (() => {
                        const _el$26 = libs.createElement("Label", {
                          get text() {
                            return option.label;
                          },
                          get html() {
                            return option.html;
                          }
                        }, null);
                        libs.effect(_p$ => {
                          const _v$5 = option.label,
                            _v$6 = option.html;
                          _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$26, "text", _v$5, _p$._v$5));
                          _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$26, "html", _v$6, _p$._v$6));
                          return _p$;
                        }, {
                          _v$5: undefined,
                          _v$6: undefined
                        });
                        return _el$26;
                      })()
                    });
                  }
                });
              },
              get children() {
                const _el$20 = libs.createElement("Panel", {
                  id: "DrawingEntryMultiDropDown"
                }, null);
                libs.insert(_el$20, libs.createComponent(EOM_MultiDropDown.EOM_MultiDropDown, {
                  ref: ref => {
                    multiDropDownRef = ref;
                  },
                  get options() {
                    return dropDownOptions().map(option => option.id);
                  },
                  get placeholder() {
                    return getMultiSelectPlaceholder();
                  },
                  localizeFunc: id => {
                    return dropDownOptions().find(option => option.id === id)?.label ?? id;
                  },
                  onChange: handleMultiSelectChange
                }));
                return _el$20;
              }
            });
          }
        }), _el$21);
        libs.insert(_el$2, libs.createComponent(libs.Show, {
          get when() {
            return (selectedDetailVM()?.equipEntries.length ?? 0) > 0;
          },
          get children() {
            return libs.createComponent(equipment_comp.AttrContainer, {
              get children() {
                return libs.createComponent(libs.Index, {
                  get each() {
                    return selectedDetailVM()?.equipEntries ?? [];
                  },
                  children: data => libs.createComponent(drawing_attr_row.DrawingAttrRow, {
                    get data() {
                      return data();
                    },
                    "class": "AttrItem Adverb",
                    valueId: "AttributeValue",
                    nameId: "AttributeName"
                  })
                });
              }
            });
          }
        }), _el$21);
        libs.insert(_el$22, libs.createComponent(libs.For, {
          get each() {
            return selectedDetailVM()?.consumeList ?? [];
          },
          children: consume => (() => {
            const _el$27 = libs.createElement("Panel", {
                "class": "MakeConsumeItem"
              }, null),
              _el$28 = libs.createElement("Label", {
                get text() {
                  return "X" + consume.needCount;
                }
              }, _el$27);
            libs.insert(_el$27, libs.createComponent(StoreItem.StoreItemImage, {
              get itemid() {
                return consume.itemID;
              }
            }), _el$28);
            libs.effect(_$p => libs.setProp(_el$28, "text", "X" + consume.needCount, _$p));
            return _el$27;
          })()
        }));
        libs.insert(_el$21, libs.createComponent(EOM_Button.EOM_Button, {
          color: "Confirm",
          text: "#EquipmentDrawing_Make",
          get enabled() {
            return canCraft();
          },
          get loading() {
            return requesting();
          },
          onactivate: handleCraft
        }), null);
        libs.effect(_p$ => {
          const _v$ = "#" + (selectedDetailVM()?.equipId ?? ""),
            _v$2 = {
              min: selectedDetailVM()?.potentialMin ?? 0,
              max: selectedDetailVM()?.potentialMax ?? 0
            },
            _v$3 = {
              value: selectedDetailVM()?.equipClass ?? 0
            },
            _v$4 = {
              value: selectedDetailVM()?.canWear ? selectedDetailVM()?.needLevel.toString() ?? "1" : ToColor(selectedDetailVM()?.needLevel.toString() ?? "1", "#E55043")
            };
          _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$1, "text", _v$, _p$._v$));
          _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$12, "vars", _v$2, _p$._v$2));
          _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$16, "vars", _v$3, _p$._v$3));
          _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$17, "vars", _v$4, _p$._v$4));
          return _p$;
        }, {
          _v$: undefined,
          _v$2: undefined,
          _v$3: undefined,
          _v$4: undefined
        });
        return _el$2;
      }
    }), null);
    return _el$;
  })();
}
const EquipmentDrawingMake = () => {
  const playerDrawings = solid_utils.createServiceNetData("player_drawings", {});
  const [selectedID, setSelectedID] = libs.createSignal();
  const createDrawingDragStart = getID => {
    return (panel, dragCallbacks) => {
      const id = getID();
      const data = id ? playerDrawings()[id] : undefined;
      if (!id || !data) {
        return;
      }
      const pDisplayPanel = $.CreatePanel("Panel", $.GetContextPanel(), "dragImage");
      const d = {
        ...data
      };
      libs.render(() => libs.createComponent(server_equipment_drawing.EquipmentDrawingItem, libs.mergeProps$1(d, {
        showTooltip: false
      })), pDisplayPanel);
      dragCallbacks.displayPanel = pDisplayPanel;
      const position = GameUI.GetCursorPosition();
      if (dragCallbacks.offsetX == undefined || dragCallbacks.offsetY == undefined) {
        dragCallbacks.offsetX = pDisplayPanel.GetPositionWithinWindow().x - position[0];
        dragCallbacks.offsetY = pDisplayPanel.GetPositionWithinWindow().y - position[1];
      }
      panel.AddClass("dragging_from");
      SaveData(pDisplayPanel, "drawing", id);
      return true;
    };
  };
  const handleDrawingDragEnd = (panel, draggedPanel) => {
    draggedPanel.DeleteAsync(-1);
    panel.RemoveClass("dragging_from");
  };
  const handleDropToActionSlot = (pPanel, draggedPanel) => {
    pPanel.RemoveClass("potential_drop_target");
    const drawingID = LoadData(draggedPanel, "drawing");
    if (drawingID == undefined) {
      return;
    }
    setSelectedID(drawingID);
  };
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
    id: "EquipmentDrawingRoot",
    get children() {
      return [libs.createElement("DOTAParticleScenePanel", {
        id: "BGLight",
        particleName: "particles/ui/game/ui_game_general_special_effects_04_fx.vpcf",
        cameraOrigin: "0 0 700",
        fov: 90,
        lookAt: "0 0 0",
        hittest: false,
        squarePixels: true
      }, null), (() => {
        const _el$30 = libs.createElement("Panel", {
            id: "CenterBlock",
            hittest: false
          }, null),
          _el$31 = libs.createElement("Panel", {
            id: "ActionPanelRoot"
          }, _el$30);
        libs.insert(_el$31, libs.createComponent(DrawingMakeContent, {
          selectedID: selectedID,
          setSelectedID: setSelectedID,
          playerDrawings: playerDrawings,
          onActionSlotDrop: handleDropToActionSlot,
          onActionSlotDragEnter: (pPanel, draggedPanel) => {
            if (LoadData(draggedPanel, "drawing")) {
              pPanel.AddClass("potential_drop_target");
            }
          },
          onActionSlotDragLeave: pPanel => {
            pPanel.RemoveClass("potential_drop_target");
          },
          get onDrawingDragStart() {
            return createDrawingDragStart(selectedID);
          },
          onDrawingDragEnd: handleDrawingDragEnd
        }));
        libs.insert(_el$30, libs.createComponent(DrawingListPanel, {
          playerDrawings: playerDrawings,
          selectedID: selectedID,
          onSelect: setSelectedID,
          onDrawingDragStart: createDrawingDragStart,
          onDrawingDragEnd: handleDrawingDragEnd
        }), null);
        return _el$30;
      })()];
    }
  });
};

const DRAWING_PART_COUNT = 8;
const RECAST_SLOT_COUNT = 24;
function getDrawingPart(data) {
  if (!data) {
    return 0;
  }
  const drawingKV = KeyValues.info_item_drawing[data.drawing_item_id];
  return toFiniteNumber(data.drawing_part ?? drawingKV?.drawing_part, 0);
}
function DrawingRecastContent(props) {
  const [requesting, setRequesting] = libs.createSignal(false);
  const [fastAddPart, setFastAddPart] = libs.createSignal(0);
  const handleFastAddRecastDrawings = () => {
    props.setRecastDrawingIDs(prev => {
      const allDrawings = props.playerDrawings();
      const selectedMap = prev.reduce((result, id) => {
        result[id] = true;
        return result;
      }, {});
      const addList = prev.filter(id => {
        const data = allDrawings[id];
        return data != undefined && data.locked !== true;
      });
      const candidates = Object.keys(allDrawings).sort((a, b) => compareDrawingIDs(a, b, allDrawings));
      for (const id of candidates) {
        if (addList.length >= RECAST_SLOT_COUNT) {
          break;
        }
        const data = allDrawings[id];
        if (!data || data.locked === true || selectedMap[id] === true) {
          continue;
        }
        if (fastAddPart() != 0 && getDrawingPart(data) != fastAddPart()) {
          continue;
        }
        addList.push(id);
        selectedMap[id] = true;
      }
      if (addList.length == prev.length) {
        return prev;
      }
      return addList;
    });
  };
  const handleRecast = () => {
    if (requesting()) {
      return;
    }
    const ids = props.recastDrawingIDs().map(id => Number(id)).filter(id => !Number.isNaN(id) && id > 0);
    if (ids.length <= 0) {
      return;
    }
    const payload = {
      ids
    };
    setRequesting(true);
    CallActionRequest("/v1/drawing/combine", payload, () => {
      setRequesting(false);
      props.setRecastDrawingIDs([]);
    }, () => {
      setRequesting(false);
    });
  };
  const expectedDrawingCount = () => Math.floor(props.recastDrawingIDs().length / 3);
  const completedRecastDrawingCount = () => expectedDrawingCount() * 3;
  return (() => {
    const _el$ = libs.createElement("Panel", {
        id: "DrawingRecastPanelRoot"
      }, null),
      _el$2 = libs.createElement("Panel", {
        "class": "RecastSectionRow RecastTitleRow"
      }, _el$);
      libs.createElement("Panel", {
        "class": "RecastSectionLine RecastSectionLineLeft"
      }, _el$2);
      libs.createElement("Label", {
        id: "RecastTitle",
        text: "#EquipmentTab_drawing_recast"
      }, _el$2);
      libs.createElement("Panel", {
        "class": "RecastSectionLine RecastSectionLineRight"
      }, _el$2);
      const _el$6 = libs.createElement("Panel", {
        id: "RecastSlotList",
        get onDragEnter() {
          return props.onDragEnter;
        },
        get onDragLeave() {
          return props.onDragLeave;
        },
        get onDragDrop() {
          return props.onDropToList;
        }
      }, _el$),
      _el$7 = libs.createElement("Panel", {
        id: "RecastFastAdd"
      }, _el$),
      _el$9 = libs.createElement("Panel", {
        "class": "RecastSectionRow RecastInfoRow"
      }, _el$);
      libs.createElement("Panel", {
        "class": "RecastSectionLine RecastSectionLineLeft"
      }, _el$9);
      libs.createElement("Label", {
        id: "RecastInfo",
        text: "#EquipmentTab_drawing_recast"
      }, _el$9);
      libs.createElement("Panel", {
        "class": "RecastSectionLine RecastSectionLineRight"
      }, _el$9);
      const _el$11 = libs.createElement("Label", {
        id: "RecastExpectedText",
        text: `#EquipmentDrawing_Resast_Out`,
        get vars() {
          return {
            value: expectedDrawingCount()
          };
        },
        html: true
      }, _el$),
      _el$12 = libs.createElement("Panel", {
        id: "RecastBtnArea"
      }, _el$);
    libs.insert(_el$6, libs.createComponent(libs.For, {
      get each() {
        return Array.from({
          length: RECAST_SLOT_COUNT
        });
      },
      children: (_, idx) => {
        const drawingID = () => props.recastDrawingIDs()[idx()];
        const drawingData = () => {
          const id = drawingID();
          if (!id) {
            return undefined;
          }
          const data = props.playerDrawings()[id];
          if (!data || data.drawing_item_id == undefined || KeyValues.info_item_drawing[data.drawing_item_id] == undefined) {
            return undefined;
          }
          return data;
        };
        return libs.createComponent(EOM_Button.EOM_BaseButton, {
          "class": "RecastSlot",
          get classList() {
            return {
              Incomplete: drawingID() != undefined && idx() >= completedRecastDrawingCount()
            };
          },
          get onDragEnter() {
            return props.onDragEnter;
          },
          get onDragLeave() {
            return props.onDragLeave;
          },
          onDragDrop: (pPanel, draggedPanel) => {
            props.onSlotDrop(pPanel, draggedPanel, idx());
          },
          get children() {
            return libs.createComponent(libs.Show, {
              get when() {
                return drawingData();
              },
              keyed: true,
              get fallback() {
                return libs.createElement("Panel", {
                  "class": "EquipListGrid"
                }, null);
              },
              children: data => libs.createComponent(server_equipment_drawing.EquipmentDrawingItem, libs.mergeProps$1(data, {
                oncontextmenu: () => {
                  const id = drawingID();
                  if (id) {
                    props.onRemoveRecastDrawing(id);
                  }
                },
                get onDragStart() {
                  return props.onCreateDrawingDragStart(drawingID, () => {
                    const id = drawingID();
                    return id ? {
                      id,
                      source: "recast",
                      index: idx()
                    } : undefined;
                  });
                },
                get onDragEnd() {
                  return props.onDrawingDragEnd;
                }
              }))
            });
          }
        });
      }
    }));
    libs.insert(_el$7, libs.createComponent(EOM_DropDown.EOM_DropDown, {
      type: "EquipmentDropDown",
      get index() {
        return fastAddPart();
      },
      menuPosition: "top",
      onChange: setFastAddPart,
      get children() {
        return [libs.createElement("Label", {
          text: "#ALL"
        }, null), libs.createComponent(libs.For, {
          get each() {
            return Array(DRAWING_PART_COUNT);
          },
          children: (_, idx) => {
            const part = idx() + 1;
            return (() => {
              const _el$14 = libs.createElement("Label", {
                text: "#Equipment_Part_" + part
              }, null);
              libs.setProp(_el$14, "text", "#Equipment_Part_" + part);
              return _el$14;
            })();
          }
        })];
      }
    }), null);
    libs.insert(_el$7, libs.createComponent(equipment_comp.EquipmentCommonBtn, {
      text: "#Equipment_FastAdd",
      onactivate: handleFastAddRecastDrawings
    }), null);
    libs.insert(_el$7, libs.createComponent(equipment_comp.EquipmentCommonBtn, {
      text: "#Equipment_ClearFastAdd",
      onactivate: () => {
        props.setRecastDrawingIDs([]);
      }
    }), null);
    libs.setProp(_el$11, "text", `#EquipmentDrawing_Resast_Out`);
    libs.insert(_el$12, libs.createComponent(EOM_Button.EOM_Button, {
      color: "Confirm",
      text: "#Equipment_Recast",
      get enabled() {
        return libs.memo(() => props.recastDrawingIDs().length >= 3)() && !requesting();
      },
      get loading() {
        return requesting();
      },
      onactivate: handleRecast
    }));
    libs.effect(_p$ => {
      const _v$ = props.onDragEnter,
        _v$2 = props.onDragLeave,
        _v$3 = props.onDropToList,
        _v$4 = {
          value: expectedDrawingCount()
        };
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$6, "onDragEnter", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$6, "onDragLeave", _v$2, _p$._v$2));
      _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$6, "onDragDrop", _v$3, _p$._v$3));
      _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$11, "vars", _v$4, _p$._v$4));
      return _p$;
    }, {
      _v$: undefined,
      _v$2: undefined,
      _v$3: undefined,
      _v$4: undefined
    });
    return _el$;
  })();
}
const EquipmentDrawingRecast = () => {
  const playerDrawings = solid_utils.createServiceNetData("player_drawings", {});
  const [recastDrawingIDs, setRecastDrawingIDs] = libs.createSignal([]);
  const removeRecastDrawing = id => {
    setRecastDrawingIDs(prev => prev.filter(itemID => itemID != id));
  };
  const addRecastDrawing = id => {
    const data = playerDrawings()[id];
    if (!data || data.locked === true) {
      return;
    }
    setRecastDrawingIDs(prev => {
      if (prev.includes(id) || prev.length >= RECAST_SLOT_COUNT) {
        return prev;
      }
      return [...prev, id];
    });
  };
  libs.createEffect(() => {
    const allDrawings = playerDrawings();
    const current = recastDrawingIDs();
    const valid = current.filter(id => {
      const data = allDrawings[id];
      return data != undefined && data.locked !== true;
    });
    if (valid.length != current.length) {
      setRecastDrawingIDs(valid);
    }
  });
  const getDraggedDrawingData = draggedPanel => {
    const dragData = LoadData(draggedPanel, "drawingDrag");
    if (dragData) {
      return dragData;
    }
    const drawingID = LoadData(draggedPanel, "drawing");
    if (drawingID == undefined) {
      return;
    }
    return {
      id: drawingID,
      source: "list"
    };
  };
  const createDrawingDragStart = (getID, getDragData) => {
    return (panel, dragCallbacks) => {
      const id = getID();
      const data = id ? playerDrawings()[id] : undefined;
      if (!id || !data) {
        return;
      }
      const dragData = getDragData?.() ?? {
        id,
        source: "list"
      };
      const pDisplayPanel = $.CreatePanel("Panel", $.GetContextPanel(), "dragImage");
      const d = {
        ...data
      };
      libs.render(() => libs.createComponent(server_equipment_drawing.EquipmentDrawingItem, libs.mergeProps$1(d, {
        showTooltip: false
      })), pDisplayPanel);
      dragCallbacks.displayPanel = pDisplayPanel;
      const position = GameUI.GetCursorPosition();
      if (dragCallbacks.offsetX == undefined || dragCallbacks.offsetY == undefined) {
        dragCallbacks.offsetX = pDisplayPanel.GetPositionWithinWindow().x - position[0];
        dragCallbacks.offsetY = pDisplayPanel.GetPositionWithinWindow().y - position[1];
      }
      panel.AddClass("dragging_from");
      SaveData(pDisplayPanel, "drawing", id);
      SaveData(pDisplayPanel, "drawingDrag", dragData);
      return true;
    };
  };
  const handleDrawingDragEnd = (panel, draggedPanel) => {
    const dragData = LoadData(draggedPanel, "drawingDrag");
    if (dragData && dragData.source == "recast") {
      const dropHandled = LoadData(draggedPanel, "drawingDropHandled");
      if (!dropHandled) {
        removeRecastDrawing(dragData.id);
      }
    }
    draggedPanel.DeleteAsync(-1);
    panel.RemoveClass("dragging_from");
  };
  const handleDropToRecastSlot = (pPanel, draggedPanel, targetIndex) => {
    pPanel.RemoveClass("potential_drop_target");
    const dragData = getDraggedDrawingData(draggedPanel);
    if (!dragData) {
      return;
    }
    const data = playerDrawings()[dragData.id];
    if (!data || data.locked === true) {
      return;
    }
    SaveData(draggedPanel, "drawingDropHandled", true);
    setRecastDrawingIDs(prev => {
      let next = [...prev];
      const sourceIndex = dragData.source == "recast" ? next.indexOf(dragData.id) : -1;
      if (sourceIndex >= 0) {
        next.splice(sourceIndex, 1);
      }
      const insertIndex = Math.min(targetIndex ?? next.length, next.length);
      next = [...next.slice(0, insertIndex), dragData.id, ...next.slice(insertIndex)];
      return next.filter((id, index, arr) => id != undefined && arr.indexOf(id) == index).slice(0, RECAST_SLOT_COUNT);
    });
  };
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
    id: "EquipmentDrawingRoot",
    get children() {
      return [libs.createElement("DOTAParticleScenePanel", {
        id: "BGLight",
        particleName: "particles/ui/game/ui_game_general_special_effects_04_fx.vpcf",
        cameraOrigin: "0 0 700",
        fov: 90,
        lookAt: "0 0 0",
        hittest: false,
        squarePixels: true
      }, null), (() => {
        const _el$16 = libs.createElement("Panel", {
            id: "CenterBlock",
            hittest: false
          }, null),
          _el$17 = libs.createElement("Panel", {
            id: "ActionPanelRoot"
          }, _el$16);
        libs.insert(_el$17, libs.createComponent(DrawingRecastContent, {
          recastDrawingIDs: recastDrawingIDs,
          setRecastDrawingIDs: setRecastDrawingIDs,
          playerDrawings: playerDrawings,
          onDropToList: handleDropToRecastSlot,
          onSlotDrop: handleDropToRecastSlot,
          onDragEnter: (pPanel, draggedPanel) => {
            if (LoadData(draggedPanel, "drawing")) {
              pPanel.AddClass("potential_drop_target");
            }
          },
          onDragLeave: pPanel => {
            pPanel.RemoveClass("potential_drop_target");
          },
          onCreateDrawingDragStart: createDrawingDragStart,
          onDrawingDragEnd: handleDrawingDragEnd,
          onRemoveRecastDrawing: removeRecastDrawing
        }));
        libs.insert(_el$16, libs.createComponent(DrawingListPanel, {
          playerDrawings: playerDrawings,
          highlightIDs: recastDrawingIDs,
          onSelect: addRecastDrawing,
          onDrawingDragStart: getID => createDrawingDragStart(getID),
          onDrawingDragEnd: handleDrawingDragEnd
        }), null);
        return _el$16;
      })()];
    }
  });
};

const InlayWindow = props => {
  const equipPunchMap = {};
  for (const row of Object.values(KeyValues.equip_punch)) {
    if (!equipPunchMap[row.class]) {
      equipPunchMap[row.class] = {};
    }
    equipPunchMap[row.class][row.rarity] = row;
  }
  function canEquipPunch(equipClass, rarity) {
    return getEquipPunchConfig(equipClass, rarity) != undefined;
  }
  function getEquipPunchConfig(equipClass, rarity) {
    return equipPunchMap[equipClass]?.[rarity];
  }
  Object.keys(KeyValues.equip_level_setting).length - 1;
  const store = equipment_comp.useEquipmentStore();
  const [, setItemListIsHidden] = store.hiddenItemList;
  const [selectedItemID] = store.selectedItemID;
  const [, setSelectedItemTab] = store.selectedItemTab;
  const [, setLockTab] = store.lockItemTab;
  const [, setShowTokens] = store.showTokens;
  const [, setSelectedGemList] = store.selectedGemList;
  const equipData = () => props.itemData();
  const gemData = libs.createMemo(() => {
    if (props.gemData && props.gemData() != "undefined") {
      return props.gemData();
    } else {
      return undefined;
    }
  });
  const rarity = () => equipData()?.rarity ?? 0;
  const inlayGemData = libs.createMemo(() => {
    const data = equipData();
    if (!data) {
      return [];
    }
    return JSON.parseSafe(data.inlay_gems_data);
  });
  const selectedInlayGem = libs.createMemo(() => {
    const embedded = inlayGemData()[props.selectGemSlot()];
    if (!embedded || !embedded.gem_item_id) return undefined;
    const parseEntries = v => {
      if (!v) return [];
      if (typeof v === "string") return JSON.parseSafe(v) ?? [];
      return v;
    };
    return {
      ...embedded,
      main_entry_data: parseEntries(embedded.main_entry_data),
      adverb_entry_data: parseEntries(embedded.adverb_entry_data),
      myth_entry_data: parseEntries(embedded.myth_entry_data),
      chaos_entry_data: parseEntries(embedded.chaos_entry_data),
      ability_entry_data: parseEntries(embedded.ability_entry_data)
    };
  });
  const InlayType = libs.createMemo(() => {
    const data = equipData();
    if (!data || !canEquipPunch(data.class, data.rarity)) {
      return "None";
    }
    return inlayGemData().length == 0 ? "Punch" : "Inlay";
  });
  const consumeList = libs.createMemo(() => {
    const data = equipData();
    if (!data) {
      return [];
    }
    const config = getEquipPunchConfig(data.class, data.rarity);
    if (!config) {
      return [];
    }
    if (InlayType() == "Punch") {
      return config.cost.split("|").map(item => {
        let [itemID, num] = item.split(":");
        let count = Number(num);
        let hasCount = () => GetServiceItemCount(itemID);
        return {
          itemID,
          needCount: count,
          hasCount: hasCount()
        };
      }).filter(d => d.needCount > 0);
    }
    return [];
  });
  const consumeEnough = libs.createMemo(() => consumeList().every(consume => consume.hasCount >= consume.needCount));
  const canInlay = libs.createMemo(() => {
    return InlayType() == "Inlay" && consumeEnough() && gemData() != undefined;
  });
  libs.createEffect(() => {
    const tokens = consumeList().map(d => toFiniteNumber(d.itemID));
    setShowTokens(tokens);
  });
  libs.createEffect(() => {
    libs.batch(() => {
      if (InlayType() == "Punch") {
        setItemListIsHidden(true);
      } else if (InlayType() == "Inlay") {
        if (!gemData()) {
          setItemListIsHidden(false);
          setSelectedItemTab("gem");
          setLockTab(true);
        } else {
          setItemListIsHidden(true);
        }
      }
      props.setLeftExtraContent?.([libs.createComponent(libs.Show, {
        get when() {
          return InlayType() == "Inlay";
        },
        get children() {
          const _el$ = libs.createElement("Panel", {
              id: "OperationBtns"
            }, null),
            _el$2 = libs.createElement("Panel", {
              id: "ConsumeBtn",
              flowChildren: "down"
            }, _el$),
            _el$3 = libs.createElement("Panel", {
              horizontalAlign: "center",
              flowChildren: "right"
            }, _el$2);
          libs.insert(_el$, libs.createComponent(EOM_Button.EOM_Button, {
            id: "ReturnBtn",
            text: "#MenuButton_Return",
            onactivate: () => {
              if (gemData()) {
                libs.batch(() => {
                  setSelectedGemList([]);
                  setItemListIsHidden(false);
                });
              } else {
                props.onReturn?.();
              }
            }
          }), _el$2);
          libs.setProp(_el$2, "flowChildren", "down");
          libs.setProp(_el$3, "horizontalAlign", "center");
          libs.setProp(_el$3, "flowChildren", "right");
          libs.insert(_el$3, libs.createComponent(libs.For, {
            get each() {
              return consumeList();
            },
            children: consume => {
              return (() => {
                const _el$9 = libs.createElement("Panel", {
                    get ["class"]() {
                      return libs.classNames("ComsumeItem", {
                        Enough: consume.hasCount >= consume.needCount
                      });
                    }
                  }, null),
                  _el$0 = libs.createElement("Label", {
                    get text() {
                      return "X" + consume.needCount;
                    }
                  }, _el$9);
                libs.insert(_el$9, libs.createComponent(StoreItem.StoreItemImage, {
                  get itemid() {
                    return consume.itemID;
                  }
                }), _el$0);
                libs.effect(_p$ => {
                  const _v$ = libs.classNames("ComsumeItem", {
                      Enough: consume.hasCount >= consume.needCount
                    }),
                    _v$2 = "X" + consume.needCount;
                  _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$9, "class", _v$, _p$._v$));
                  _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$0, "text", _v$2, _p$._v$2));
                  return _p$;
                }, {
                  _v$: undefined,
                  _v$2: undefined
                });
                return _el$9;
              })();
            }
          }));
          libs.insert(_el$2, libs.createComponent(EOM_Button.EOM_Button, {
            get enabled() {
              return canInlay();
            },
            onmouseover: p => {
              if (!canInlay()) {
                ShowCustomTooltip(p, "text", {
                  text: "#Equipment_Inlay_SelectGem"
                });
              }
            },
            onmouseout: p => {
              HideCustomTooltip(p, "text");
            },
            color: "Confirm",
            text: "#Equipment_InlayDo",
            onactivate: () => {
              props.startForgeAnimation?.(() => new Promise(resolve => {
                const gem_data = gemData();
                if (gem_data) {
                  CallActionRequest("/v1/gem/equipment_inlay_gem", {
                    equipment_id: selectedItemID(),
                    slot_index: props.selectGemSlot(),
                    gem_id: gem_data.id
                  }, () => resolve(), () => resolve());
                }
              }))?.then(() => {
                setSelectedGemList([]);
                setItemListIsHidden(false);
              });
            }
          }), null);
          return _el$;
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return InlayType() == "Punch";
        },
        get children() {
          const _el$4 = libs.createElement("Panel", {
              id: "OperationBtns"
            }, null),
            _el$5 = libs.createElement("Panel", {
              id: "ConsumeBtn",
              flowChildren: "down"
            }, _el$4),
            _el$6 = libs.createElement("Panel", {
              horizontalAlign: "center",
              flowChildren: "right"
            }, _el$5);
          libs.insert(_el$4, libs.createComponent(EOM_Button.EOM_Button, {
            id: "ReturnBtn",
            text: "#MenuButton_Return",
            onactivate: () => props.onReturn?.()
          }), _el$5);
          libs.setProp(_el$5, "flowChildren", "down");
          libs.setProp(_el$6, "horizontalAlign", "center");
          libs.setProp(_el$6, "flowChildren", "right");
          libs.insert(_el$6, libs.createComponent(libs.For, {
            get each() {
              return consumeList();
            },
            children: consume => {
              return (() => {
                const _el$1 = libs.createElement("Panel", {
                    get ["class"]() {
                      return libs.classNames("ComsumeItem", {
                        Enough: consume.hasCount >= consume.needCount
                      });
                    }
                  }, null),
                  _el$10 = libs.createElement("Label", {
                    get text() {
                      return "X" + consume.needCount;
                    }
                  }, _el$1);
                libs.insert(_el$1, libs.createComponent(StoreItem.StoreItemImage, {
                  get itemid() {
                    return consume.itemID;
                  }
                }), _el$10);
                libs.effect(_p$ => {
                  const _v$3 = libs.classNames("ComsumeItem", {
                      Enough: consume.hasCount >= consume.needCount
                    }),
                    _v$4 = "X" + consume.needCount;
                  _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$1, "class", _v$3, _p$._v$3));
                  _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$10, "text", _v$4, _p$._v$4));
                  return _p$;
                }, {
                  _v$3: undefined,
                  _v$4: undefined
                });
                return _el$1;
              })();
            }
          }));
          libs.insert(_el$5, libs.createComponent(EOM_Button.EOM_Button, {
            get enabled() {
              return consumeEnough();
            },
            color: "Confirm",
            text: "#Equipment_Punch",
            onactivate: () => {
              props.startForgeAnimation?.(() => new Promise(resolve => {
                CallActionRequest("/v1/gem/punch_equipment", {
                  equipment_id: selectedItemID(),
                  punch_num: getEquipPunchConfig(equipData().class, equipData().rarity).punch_num
                }, () => resolve(), () => resolve());
              }));
            }
          }), null);
          return _el$4;
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return InlayType() == "None";
        },
        get children() {
          const _el$7 = libs.createElement("Panel", {
              id: "OperationBtns"
            }, null),
            _el$8 = libs.createTextNode(`;`, _el$7);
          libs.insert(_el$7, libs.createComponent(EOM_Button.EOM_Button, {
            id: "ReturnBtn",
            text: "#MenuButton_Return",
            onactivate: () => props.onReturn?.()
          }), _el$8);
          return _el$7;
        }
      })]);
    });
  });
  return (() => {
    const _el$11 = libs.createElement("Panel", {
        id: "InlayPanel",
        get ["class"]() {
          return libs.classNames({
            IsMax: false
          }, "RarityColor" + rarity());
        }
      }, null),
      _el$12 = libs.createElement("Panel", {
        "class": "ToolTipIcon"
      }, _el$11);
    libs.setProp(_el$12, "tooltip_text", "#EquipInlayTips");
    libs.insert(_el$11, libs.createComponent(libs.Switch, {
      get children() {
        return [libs.createComponent(libs.Match, {
          get when() {
            return InlayType() == "Punch";
          },
          get children() {
            return [libs.createElement("Label", {
              "class": "WindowTitle",
              text: "#Equipment_EquipPunch"
            }, null), (() => {
              const _el$14 = libs.createElement("Label", {
                "class": "EquipName EquipRarityLabel",
                get text() {
                  return "#" + equipData()?.equipment_item_id;
                }
              }, null);
              libs.effect(_$p => libs.setProp(_el$14, "text", "#" + equipData()?.equipment_item_id, _$p));
              return _el$14;
            })(), libs.createComponent(equipment_comp.AttrContainer, {
              get children() {
                return [libs.createComponent(libs.For, {
                  get each() {
                    return equipData()?.main_entry_data ?? [];
                  },
                  children: (data, index) => {
                    return libs.createComponent(equipment_comp.AttrItem, {
                      get index() {
                        return index();
                      },
                      attrData: data,
                      type: "Main"
                    });
                  }
                }), libs.createComponent(libs.For, {
                  get each() {
                    return equipData()?.adverb_entry_data ?? [];
                  },
                  children: (data, index) => {
                    return libs.createComponent(equipment_comp.AttrItem, {
                      get index() {
                        return index();
                      },
                      attrData: data,
                      type: "Adverb"
                    });
                  }
                }), libs.createComponent(libs.Index, {
                  get each() {
                    return equipData()?.myth_entry_data ?? [];
                  },
                  children: data => {
                    const entryKv = KeyValues.equip_entry[data().id];
                    return (() => {
                      const _el$24 = libs.createElement("Panel", {
                          "class": "MythEntry"
                        }, null);
                        libs.createElement("Image", {}, _el$24);
                        const _el$26 = libs.createElement("Label", {
                          get text() {
                            return GetPrivilegeDesc(data().id, 1, {
                              value: data().value,
                              min: entryKv.value_min,
                              max: entryKv.value_max
                            });
                          },
                          html: true
                        }, _el$24);
                      libs.effect(_$p => libs.setProp(_el$26, "text", GetPrivilegeDesc(data().id, 1, {
                        value: data().value,
                        min: entryKv.value_min,
                        max: entryKv.value_max
                      }), _$p));
                      return _el$24;
                    })();
                  }
                }), libs.createComponent(libs.Index, {
                  get each() {
                    return equipData()?.chaos_entry_data ?? [];
                  },
                  children: data => (() => {
                    const _el$27 = libs.createElement("Panel", {
                        "class": `ChaosEntry`
                      }, null);
                      libs.createElement("Panel", {
                        id: "Point"
                      }, _el$27);
                      const _el$29 = libs.createElement("Label", {
                        id: "EntryText",
                        get text() {
                          return equipment_utils.GetChaosRowInfo(data());
                        },
                        html: true
                      }, _el$27);
                    libs.setProp(_el$27, "class", `ChaosEntry`);
                    libs.effect(_$p => libs.setProp(_el$29, "text", equipment_utils.GetChaosRowInfo(data()), _$p));
                    return _el$27;
                  })()
                })];
              }
            })];
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return InlayType() == "Inlay";
          },
          get children() {
            return [libs.createElement("Label", {
              "class": "WindowTitle",
              text: "#Equipment_GemInlay"
            }, null), (() => {
              const _el$16 = libs.createElement("Panel", {
                "class": "VerticalScrollStyle",
                width: "100%",
                flowChildren: "down",
                scroll: "y",
                paddingBottom: "10px"
              }, null);
              libs.setProp(_el$16, "width", "100%");
              libs.setProp(_el$16, "flowChildren", "down");
              libs.setProp(_el$16, "scroll", "y");
              libs.setProp(_el$16, "paddingBottom", "10px");
              libs.insert(_el$16, libs.createComponent(libs.Show, {
                get when() {
                  return gemData();
                },
                get children() {
                  return [libs.createComponent(libs.Show, {
                    get when() {
                      return selectedInlayGem();
                    },
                    get children() {
                      return [(() => {
                        const _el$17 = libs.createElement("Panel", {
                            "class": "GemContainer"
                          }, null),
                          _el$18 = libs.createElement("Label", {
                            "class": "EquipName EquipRarityLabel",
                            get text() {
                              return "#" + selectedInlayGem().gem_item_id;
                            }
                          }, _el$17);
                        libs.insert(_el$17, libs.createComponent(server_equipment.Gem, libs.mergeProps$1(selectedInlayGem)), _el$18);
                        libs.insert(_el$17, libs.createComponent(equipment_comp.AttrContainer, {
                          get children() {
                            return [libs.createComponent(libs.For, {
                              get each() {
                                return selectedInlayGem().main_entry_data ?? [];
                              },
                              children: (data, index) => {
                                return libs.createComponent(equipment_comp.AttrItem, {
                                  get index() {
                                    return index();
                                  },
                                  attrData: data,
                                  type: "Main"
                                });
                              }
                            }), libs.createComponent(libs.For, {
                              get each() {
                                return selectedInlayGem().adverb_entry_data ?? [];
                              },
                              children: (data, index) => {
                                return libs.createComponent(equipment_comp.AttrItem, {
                                  get index() {
                                    return index();
                                  },
                                  attrData: data,
                                  type: "Adverb"
                                });
                              }
                            })];
                          }
                        }), null);
                        libs.effect(_$p => libs.setProp(_el$18, "text", "#" + selectedInlayGem().gem_item_id, _$p));
                        return _el$17;
                      })(), (() => {
                        const _el$19 = libs.createElement("Panel", {
                            marginTop: "40px",
                            marginBottom: "40px",
                            horizontalAlign: "center",
                            flowChildren: "right"
                          }, null);
                          libs.createElement("Panel", {
                            "class": "EntryArrow"
                          }, _el$19);
                          libs.createElement("Panel", {
                            "class": "EntryArrow"
                          }, _el$19);
                        libs.setProp(_el$19, "marginTop", "40px");
                        libs.setProp(_el$19, "marginBottom", "40px");
                        libs.setProp(_el$19, "horizontalAlign", "center");
                        libs.setProp(_el$19, "flowChildren", "right");
                        return _el$19;
                      })()];
                    }
                  }), (() => {
                    const _el$22 = libs.createElement("Panel", {
                        "class": "GemContainer"
                      }, null),
                      _el$23 = libs.createElement("Label", {
                        "class": "EquipName EquipRarityLabel",
                        get text() {
                          return "#" + gemData().gem_item_id;
                        }
                      }, _el$22);
                    libs.insert(_el$22, libs.createComponent(server_equipment.Gem, libs.mergeProps$1(() => gemData())), _el$23);
                    libs.insert(_el$22, libs.createComponent(equipment_comp.AttrContainer, {
                      get children() {
                        return [libs.createComponent(libs.For, {
                          get each() {
                            return gemData().main_entry_data ?? [];
                          },
                          children: (data, index) => {
                            return libs.createComponent(equipment_comp.AttrItem, {
                              get index() {
                                return index();
                              },
                              attrData: data,
                              type: "Main"
                            });
                          }
                        }), libs.createComponent(libs.For, {
                          get each() {
                            return gemData().adverb_entry_data ?? [];
                          },
                          children: (data, index) => {
                            return libs.createComponent(equipment_comp.AttrItem, {
                              get index() {
                                return index();
                              },
                              attrData: data,
                              type: "Adverb"
                            });
                          }
                        }), libs.createComponent(libs.Index, {
                          get each() {
                            return gemData().myth_entry_data ?? [];
                          },
                          children: data => {
                            const entryKv = KeyValues.equip_entry[data().id];
                            return (() => {
                              const _el$30 = libs.createElement("Panel", {
                                  "class": "MythEntry"
                                }, null);
                                libs.createElement("Image", {}, _el$30);
                                const _el$32 = libs.createElement("Label", {
                                  get text() {
                                    return GetPrivilegeDesc(data().id, 1, {
                                      value: data().value,
                                      min: entryKv.value_min,
                                      max: entryKv.value_max
                                    });
                                  },
                                  html: true
                                }, _el$30);
                              libs.effect(_$p => libs.setProp(_el$32, "text", GetPrivilegeDesc(data().id, 1, {
                                value: data().value,
                                min: entryKv.value_min,
                                max: entryKv.value_max
                              }), _$p));
                              return _el$30;
                            })();
                          }
                        }), libs.createComponent(libs.Index, {
                          get each() {
                            return gemData()?.chaos_entry_data ?? [];
                          },
                          children: data => (() => {
                            const _el$33 = libs.createElement("Panel", {
                                "class": `ChaosEntry`
                              }, null);
                              libs.createElement("Panel", {
                                id: "Point"
                              }, _el$33);
                              const _el$35 = libs.createElement("Label", {
                                id: "EntryText",
                                get text() {
                                  return equipment_utils.GetChaosRowInfo(data());
                                },
                                html: true
                              }, _el$33);
                            libs.setProp(_el$33, "class", `ChaosEntry`);
                            libs.effect(_$p => libs.setProp(_el$35, "text", equipment_utils.GetChaosRowInfo(data()), _$p));
                            return _el$33;
                          })()
                        })];
                      }
                    }), null);
                    libs.effect(_$p => libs.setProp(_el$23, "text", "#" + gemData().gem_item_id, _$p));
                    return _el$22;
                  })()];
                }
              }));
              return _el$16;
            })()];
          }
        })];
      }
    }), null);
    libs.effect(_$p => libs.setProp(_el$11, "class", libs.classNames({
      IsMax: false
    }, "RarityColor" + rarity()), _$p));
    return _el$11;
  })();
};

const KEY_RARITY_COUNT = 7;
const KEY_BAG_MAX_CAPACITY = 400;
const DEVOUR_SLOT_COUNT = 12;
const DEVOUR_COLUMN_COUNT = 6;
const ATTRIBUTE_ROW_COUNT = 4;
const PREVIEW_GREEN = "#53b646";
function parseKeyMainEntries(value) {
  if (!value) {
    return [];
  }
  if (typeof value === "string") {
    return JSON.parseSafe(value) ?? [];
  }
  return Array.isArray(value) ? value : [];
}
function getKeyLevelSetting(level) {
  return KeyValues.key_level_setting[String(level)];
}
function getKeyRaritySetting(rarity) {
  if (rarity == undefined) {
    return undefined;
  }
  return KeyValues.key_rarity_setting[rarity] ?? KeyValues.key_rarity_setting[String(rarity)];
}
function getKeyLevelMainBonus(level) {
  return toFiniteNumber(getKeyLevelSetting(level)?.main_bonus, 0);
}
function getKeyLevelIntensityBonus(level) {
  return toFiniteNumber(getKeyLevelSetting(level)?.intensity_bonus, 0);
}
function getKeyLevelExp(setting, level) {
  return toFiniteNumber(setting?.level_exp?.[level], 0);
}
function getNextKeyLevelExp(setting, level) {
  const nextLevelExp = getKeyLevelExp(setting, level + 1);
  if (nextLevelExp > 0) {
    return nextLevelExp;
  }
  return getKeyLevelExp(setting, level);
}
function getKeyExpPreview(setting, level, currentExp, addedExp, levelMax) {
  let previewLevel = level;
  let previewExp = currentExp + addedExp;
  let nextLevelExp = getNextKeyLevelExp(setting, previewLevel);
  while (previewLevel < levelMax && nextLevelExp > 0 && previewExp >= nextLevelExp) {
    previewExp -= nextLevelExp;
    previewLevel += 1;
    nextLevelExp = getNextKeyLevelExp(setting, previewLevel);
  }
  return {
    previewLevel,
    previewExp,
    previewNextLevelExp: nextLevelExp
  };
}
function formatKeyPreviewNumber(value, ratio = 2, isPercent = false) {
  const rounded = Round(value, ratio);
  return `${rounded}${isPercent ? "%" : ""}`;
}
function getKeyAttributeDisplays(data, currentLevel, previewLevel) {
  if (!data) {
    return [];
  }
  const keyData = data;
  const currentMainBonus = getKeyLevelMainBonus(currentLevel);
  const previewMainBonus = getKeyLevelMainBonus(previewLevel);
  return parseKeyMainEntries(keyData.main_entry_data).filter(entry => entry.id != "" && entry.value != undefined).map(entry => {
    const entryConfig = KeyValues.key_entry[entry.id];
    const attributeName = entryConfig?.entry_name ?? entry.id;
    const baseValue = toFiniteNumber(entry.base_value ?? entry.value, 0);
    const value = baseValue * (1 + currentMainBonus);
    const previewValue = baseValue * (1 + previewMainBonus);
    const changeValue = previewValue - value;
    const propertyText = GetLocalization("#property_" + attributeName);
    const isPercent = propertyText.startsWith("%");
    const ratio = entryConfig?.ratio ?? 2;
    const display = attribute_formatter.formatAttributeDisplay({
      id: attributeName,
      value,
      base_value: value,
      percent: entry.percent != undefined ? toFiniteNumber(entry.percent, 0) : undefined,
      base_min: entry.base_min != undefined ? toFiniteNumber(entry.base_min, 0) : undefined,
      base_max: entry.base_max != undefined ? toFiniteNumber(entry.base_max, 0) : undefined
    }, {
      config: entryConfig
    });
    return {
      text: `${display.valueText} ${display.nameHtml}`,
      entryType: toFiniteNumber(entryConfig?.entry_type, 1),
      changeText: changeValue > 0 ? `+${formatKeyPreviewNumber(changeValue, ratio, isPercent)}` : undefined
    };
  }).filter(data => data.text != "");
}
function LockKey(id, lock) {
  CallAction("/v1/key/lock", {
    id: Number(id),
    lock: lock
  });
}
const EquipmentKey = () => {
  let actionPanelRoot;
  const player_keys = solid_utils.createServiceNetData("player_keys", {});
  const keyUnreadIds = solid_utils.createPlayerUnreadIds("key");
  const keyBagCount = libs.createMemo(() => Object.keys(player_keys()).length);
  const isKeyBagFull = libs.createMemo(() => keyBagCount() >= KEY_BAG_MAX_CAPACITY);
  const [actionKeyID, setActionKeyID] = libs.createSignal();
  const [devourKeyIDs, setDevourKeyIDs] = libs.createSignal([]);
  const [fastAddRarity, setFastAddRarity] = libs.createSignal(0);
  const [showFilter, setShowFilter] = libs.createSignal(false);
  const [filterRarity, setFilterRarity] = libs.createSignal({});
  libs.onCleanup(() => keyUnreadIds.submitReadCache());
  const [dragInsideActionPanelRoot, setDragInsideActionPanelRoot] = libs.createSignal(false);
  const activeRarityFilter = libs.createMemo(() => {
    const rarityFilter = filterRarity();
    return Object.keys(rarityFilter).reduce((result, rarity) => {
      if (rarityFilter[Number(rarity)]) {
        result[Number(rarity)] = true;
      }
      return result;
    }, {});
  });
  const keys = libs.createMemo(() => {
    const rarityFilter = activeRarityFilter();
    const hasRarityFilter = Object.keys(rarityFilter).length > 0;
    const allKeys = player_keys();
    return Object.keys(allKeys).filter(id => {
      return !hasRarityFilter || rarityFilter[allKeys[id]?.rarity] === true;
    }).sort((a, b) => {
      const rarityDiff = (allKeys[b]?.rarity ?? 0) - (allKeys[a]?.rarity ?? 0);
      if (rarityDiff != 0) {
        return rarityDiff;
      }
      return Number(a) - Number(b);
    });
  });
  const actionKeyData = libs.createMemo(() => {
    const id = actionKeyID();
    if (!id) {
      return;
    }
    return player_keys()[id];
  });
  const getKeyData = id => {
    if (!id) {
      return;
    }
    return player_keys()[id];
  };
  const setRarityFilterEnabled = (rarity, enabled) => {
    setFilterRarity(prev => {
      const next = {
        ...prev
      };
      if (enabled) {
        next[rarity] = true;
      } else {
        delete next[rarity];
      }
      return next;
    });
  };
  const unusedDevourKeyIDMap = libs.createMemo(() => {
    const data = actionKeyData();
    const setting = data ? getKeyRaritySetting(data.rarity) : undefined;
    let previewLevel = toFiniteNumber(data?.level, 0);
    let previewExp = toFiniteNumber(data?.extra_exp, 0);
    const levelMax = toFiniteNumber(setting?.level_max, 0);
    const unusedMap = {};
    if (!data || levelMax <= 0) {
      return unusedMap;
    }
    for (const id of devourKeyIDs()) {
      if (previewLevel >= levelMax) {
        unusedMap[id] = true;
        continue;
      }
      const key = getKeyData(id);
      previewExp += toFiniteNumber(getKeyRaritySetting(key?.rarity)?.devour_exp, 0);
      let nextLevelExp = getNextKeyLevelExp(setting, previewLevel);
      while (previewLevel < levelMax && nextLevelExp > 0 && previewExp >= nextLevelExp) {
        previewExp -= nextLevelExp;
        previewLevel += 1;
        nextLevelExp = getNextKeyLevelExp(setting, previewLevel);
      }
    }
    return unusedMap;
  });
  const devourExp = libs.createMemo(() => {
    const unusedMap = unusedDevourKeyIDMap();
    return devourKeyIDs().reduce((total, id) => {
      if (unusedMap[id]) {
        return total;
      }
      const data = getKeyData(id);
      return total + toFiniteNumber(getKeyRaritySetting(data?.rarity)?.devour_exp, 0);
    }, 0);
  });
  const actionKeyUpgradeInfo = libs.createMemo(() => {
    const data = actionKeyData();
    const setting = data ? getKeyRaritySetting(data.rarity) : undefined;
    const level = toFiniteNumber(data?.level, 0);
    const currentExp = toFiniteNumber(data?.extra_exp, 0);
    const levelMax = toFiniteNumber(setting?.level_max, 0);
    const nextLevelExp = getNextKeyLevelExp(setting, level);
    const addedExp = devourExp();
    const preview = getKeyExpPreview(setting, level, currentExp, addedExp, levelMax);
    const canUpgrade = preview.previewLevel > level;
    const displayExp = canUpgrade && nextLevelExp > 0 ? nextLevelExp : currentExp + addedExp;
    const currentPercent = nextLevelExp > 0 ? toFiniteNumber(Clamp(currentExp / nextLevelExp, 0, 1) * 100, 0) : 0;
    const previewPercent = nextLevelExp > 0 ? toFiniteNumber(Clamp(displayExp / nextLevelExp, 0, 1) * 100, 0) : 0;
    const currentIntensity = toFiniteNumber(data?.intensity, 0);
    const keyClass = data ? toFiniteNumber(KeyValues.info_item_key[String(data.key_item_id)]?.class, 1) : 1;
    const classSetting = KeyValues.key_class_setting[keyClass] ?? KeyValues.key_class_setting[String(keyClass)];
    const rarityIntensity = toFiniteNumber(setting?.intensity, 0);
    const classIntensityBonus = toFiniteNumber(classSetting?.intensity_bonus, 0);
    const initialIntensity = rarityIntensity * (1 + classIntensityBonus);
    const previewIntensityMultiplier = 1 + getKeyLevelIntensityBonus(preview.previewLevel);
    const previewIntensity = initialIntensity * previewIntensityMultiplier;
    const intensityChange = previewIntensity - currentIntensity;
    const durabilityData = data;
    const currentDurability = toFiniteNumber(durabilityData?.durability, toFiniteNumber(durabilityData?.origin_durability, 0));
    const durabilityChange = preview.previewLevel - level;
    let warning;
    if (data && levelMax <= 0) {
      warning = "#Equipment_Warning_1";
    } else if (data && level >= levelMax) {
      warning = "#Equipment_Warning_2";
    }
    return {
      data,
      setting,
      level,
      previewLevel: preview.previewLevel,
      currentExp,
      levelMax,
      nextLevelExp,
      previewNextLevelExp: preview.previewNextLevelExp,
      addedExp,
      previewExp: preview.previewExp,
      displayExp,
      currentPercent,
      previewPercent,
      currentIntensity,
      previewIntensity,
      intensityChange,
      currentDurability,
      durabilityChange,
      canUpgrade,
      expText: data && levelMax > 0 && level >= levelMax ? "Max" : data && nextLevelExp > 0 ? `${displayExp}/${nextLevelExp}` : `${displayExp}`,
      warning,
      canConfirm: data != undefined && levelMax > 0 && level < levelMax && nextLevelExp > 0
    };
  });
  const isActionKeyMaxLevel = libs.createMemo(() => {
    const info = actionKeyUpgradeInfo();
    return info.data != undefined && info.levelMax > 0 && info.level >= info.levelMax;
  });
  const actionKeyAttributeRows = libs.createMemo(() => {
    const upgradeInfo = actionKeyUpgradeInfo();
    const rows = getKeyAttributeDisplays(actionKeyData(), upgradeInfo.level, upgradeInfo.previewLevel);
    return Array.from({
      length: ATTRIBUTE_ROW_COUNT
    }, (_, index) => rows[index]);
  });
  const removeDevourKey = id => {
    setDevourKeyIDs(prev => prev.filter(itemID => itemID != id));
  };
  const getDraggedKeyData = draggedPanel => {
    const dragData = LoadData(draggedPanel, "keyDrag");
    if (dragData) {
      return dragData;
    }
    const keyID = LoadData(draggedPanel, "key");
    if (keyID == undefined) {
      return;
    }
    return {
      id: String(keyID),
      source: "list"
    };
  };
  const removeKeyFromSource = dragData => {
    if (dragData.source == "action") {
      setActionKeyID(prev => prev == dragData.id ? undefined : prev);
    } else if (dragData.source == "devour") {
      removeDevourKey(dragData.id);
    }
  };
  const isDevourCandidate = (id, key, selectedMap, actionID) => {
    return key != undefined && key.locked !== true && selectedMap[id] !== true && id != actionID;
  };
  const isCursorInsideActionPanelRoot = () => {
    if (!actionPanelRoot) {
      return dragInsideActionPanelRoot();
    }
    const cursor = GameUI.GetCursorPosition();
    const position = actionPanelRoot.GetPositionWithinWindow();
    return cursor[0] >= position.x && cursor[0] <= position.x + actionPanelRoot.actuallayoutwidth && cursor[1] >= position.y && cursor[1] <= position.y + actionPanelRoot.actuallayoutheight;
  };
  const markDropHandled = draggedPanel => {
    SaveData(draggedPanel, "keyDropHandled", true);
    setDragInsideActionPanelRoot(true);
  };
  const setActionKeyFromDrag = dragData => {
    if (!player_keys()[dragData.id]) {
      return;
    }
    const previousActionID = actionKeyID();
    libs.batch(() => {
      setActionKeyID(dragData.id);
      setDevourKeyIDs(prev => {
        let next = prev.filter(id => id != dragData.id);
        if (dragData.source == "devour" && previousActionID && previousActionID != dragData.id) {
          const targetIndex = Math.min(dragData.index ?? next.length, next.length);
          next = [...next.slice(0, targetIndex), previousActionID, ...next.slice(targetIndex)];
        }
        return next.slice(0, DEVOUR_SLOT_COUNT);
      });
    });
  };
  const setDevourSlotFromDrag = (targetIndex, dragData) => {
    if (isActionKeyMaxLevel()) {
      return;
    }
    const draggedKey = player_keys()[dragData.id];
    if (!draggedKey || draggedKey.locked === true) {
      return;
    }
    const previousActionID = actionKeyID();
    libs.batch(() => {
      setDevourKeyIDs(prev => {
        const targetID = prev[targetIndex];
        let next = [...prev];
        const sourceIndex = dragData.source == "devour" ? next.indexOf(dragData.id) : -1;
        if (dragData.source == "action") {
          next = next.filter(id => id != dragData.id);
          const insertIndex = Math.min(targetIndex, next.length);
          if (targetID && targetID != dragData.id) {
            next[insertIndex] = dragData.id;
          } else {
            next = [...next.slice(0, insertIndex), dragData.id, ...next.slice(insertIndex)];
          }
          setActionKeyID(targetID && targetID != dragData.id ? targetID : undefined);
        } else if (sourceIndex >= 0) {
          if (sourceIndex == targetIndex) {
            return prev;
          }
          if (targetID) {
            next[sourceIndex] = targetID;
            next[targetIndex] = dragData.id;
          } else {
            next.splice(sourceIndex, 1);
            next.splice(Math.min(targetIndex, next.length), 0, dragData.id);
          }
        } else {
          next = next.filter(id => id != dragData.id);
          const insertIndex = Math.min(targetIndex, next.length);
          if (targetID && targetID != dragData.id) {
            next[insertIndex] = dragData.id;
          } else {
            next = [...next.slice(0, insertIndex), dragData.id, ...next.slice(insertIndex)];
          }
          if (previousActionID == dragData.id) {
            setActionKeyID(targetID && targetID != dragData.id ? targetID : undefined);
          }
        }
        return next.filter((id, index, arr) => id != undefined && arr.indexOf(id) == index).slice(0, DEVOUR_SLOT_COUNT);
      });
    });
  };
  const createKeyDragStart = (getID, getDragData) => {
    return (panel, dragCallbacks) => {
      const id = getID();
      const data = getKeyData(id);
      if (!id || !data) {
        return;
      }
      const dragData = getDragData?.() ?? {
        id,
        source: "list"
      };
      const pDisplayPanel = $.CreatePanel("Panel", $.GetContextPanel(), "dragImage");
      const d = {
        ...data
      };
      libs.render(() => libs.createComponent(server_dungeon_key.DungeonKey, {
        data: d,
        keyID: id
      }), pDisplayPanel);
      dragCallbacks.displayPanel = pDisplayPanel;
      const position = GameUI.GetCursorPosition();
      if (dragCallbacks.offsetX == undefined || dragCallbacks.offsetY == undefined) {
        dragCallbacks.offsetX = pDisplayPanel.GetPositionWithinWindow().x - position[0];
        dragCallbacks.offsetY = pDisplayPanel.GetPositionWithinWindow().y - position[1];
      }
      panel.AddClass("dragging_from");
      SaveData(pDisplayPanel, "key", id);
      SaveData(pDisplayPanel, "keyDrag", dragData);
      SaveData(pDisplayPanel, "keyDropHandled", false);
      setDragInsideActionPanelRoot(dragData.source != "list");
      return true;
    };
  };
  const handleKeyDragEnd = (panel, draggedPanel) => {
    const dragData = LoadData(draggedPanel, "keyDrag");
    const dropHandled = LoadData(draggedPanel, "keyDropHandled");
    if (dragData && dragData.source != "list" && !dropHandled && !isCursorInsideActionPanelRoot()) {
      removeKeyFromSource(dragData);
    }
    draggedPanel.DeleteAsync(-1);
    panel.RemoveClass("dragging_from");
    setDragInsideActionPanelRoot(false);
  };
  const handleDropToActionSlot = (pPanel, draggedPanel) => {
    pPanel.RemoveClass("potential_drop_target");
    if (LoadData(draggedPanel, "keyDropHandled")) {
      return;
    }
    const dragData = getDraggedKeyData(draggedPanel);
    if (!dragData) {
      return;
    }
    markDropHandled(draggedPanel);
    setActionKeyFromDrag(dragData);
  };
  const handleDropToDevourSlot = (pPanel, draggedPanel, targetIndex) => {
    pPanel.RemoveClass("potential_drop_target");
    if (LoadData(draggedPanel, "keyDropHandled")) {
      return;
    }
    const dragData = getDraggedKeyData(draggedPanel);
    if (!dragData) {
      return;
    }
    markDropHandled(draggedPanel);
    setDevourSlotFromDrag(targetIndex ?? devourKeyIDs().length, dragData);
  };
  const compareKeyEntries = (a, b) => {
    const rarityDiff = a[1].rarity - b[1].rarity;
    if (rarityDiff != 0) {
      return rarityDiff;
    }
    const itemDiff = a[1].key_item_id - b[1].key_item_id;
    if (itemDiff != 0) {
      return itemDiff;
    }
    return Number(a[0]) - Number(b[0]);
  };
  const handleFastAddDevourKeys = () => {
    if (isActionKeyMaxLevel()) {
      return;
    }
    setDevourKeyIDs(prev => {
      const allKeys = player_keys();
      const actionID = actionKeyID();
      const selectedMap = prev.reduce((result, id) => {
        result[id] = true;
        return result;
      }, {});
      const addList = prev.filter(id => {
        const key = allKeys[id];
        return isDevourCandidate(id, key, {}, actionID);
      });
      const fastAddCandidates = Object.entries(allKeys).sort(compareKeyEntries);
      for (const [id, key] of fastAddCandidates) {
        if (addList.length >= DEVOUR_SLOT_COUNT) {
          break;
        }
        if (!isDevourCandidate(id, key, selectedMap, actionID)) {
          continue;
        }
        if (fastAddRarity() != 0 && key.rarity != fastAddRarity()) {
          continue;
        }
        addList.push(id);
        selectedMap[id] = true;
      }
      if (addList.length == prev.length) {
        return prev;
      }
      return addList;
    });
  };
  libs.createEffect(() => {
    const allKeys = player_keys();
    const currentActionKeyID = actionKeyID();
    if (currentActionKeyID && !allKeys[currentActionKeyID]) {
      setActionKeyID();
    }
    const currentDevourKeyIDs = devourKeyIDs();
    const validDevourKeyIDs = currentDevourKeyIDs.filter(id => {
      const key = allKeys[id];
      return key != undefined && key.locked !== true;
    });
    if (validDevourKeyIDs.length != currentDevourKeyIDs.length) {
      setDevourKeyIDs(validDevourKeyIDs);
    }
  });
  libs.createEffect(() => {
    if (isActionKeyMaxLevel() && devourKeyIDs().length > 0) {
      setDevourKeyIDs([]);
    }
  });
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
    id: "EquipmentKeyRoot",
    get children() {
      return [libs.createElement("DOTAParticleScenePanel", {
        id: "BGLight",
        particleName: "particles/ui/game/ui_game_general_special_effects_04_fx.vpcf",
        cameraOrigin: "0 0 700",
        fov: 90,
        lookAt: "0 0 0",
        hittest: false,
        squarePixels: true
      }, null), (() => {
        const _el$2 = libs.createElement("Panel", {
            id: "CenterBlock",
            hittest: false
          }, null),
          _el$3 = libs.createElement("Panel", {
            id: "ActionPanelRoot"
          }, _el$2),
          _el$4 = libs.createElement("Panel", {
            id: "ActionContent"
          }, _el$3),
          _el$5 = libs.createElement("Panel", {
            id: "ActionTip"
          }, _el$4);
          libs.createElement("Label", {
            text: "#Equipment_PutKey"
          }, _el$5);
          const _el$7 = libs.createElement("Panel", {
            "class": "ToolTipInfo"
          }, _el$5),
          _el$8 = libs.createElement("Panel", {
            id: "BarInfo"
          }, _el$4);
          libs.createElement("Label", {
            "class": "InfoKey",
            text: "#Equipment_KeyLevel"
          }, _el$8);
          const _el$0 = libs.createElement("Label", {
            "class": "InfoValue",
            html: true,
            get text() {
              return libs.memo(() => actionKeyUpgradeInfo().previewLevel != actionKeyUpgradeInfo().level)() ? `${ToColor(actionKeyUpgradeInfo().previewLevel.toString(), PREVIEW_GREEN)}/${actionKeyUpgradeInfo().levelMax}` : `${actionKeyUpgradeInfo().level}/${actionKeyUpgradeInfo().levelMax}`;
            }
          }, _el$8),
          _el$1 = libs.createElement("Label", {
            marginLeft: "64px",
            "class": "InfoKey",
            get text() {
              return GetLocalization("#Equipment_Intensity");
            },
            html: true
          }, _el$8),
          _el$10 = libs.createElement("Label", {
            "class": "InfoValue",
            get text() {
              return formatKeyPreviewNumber(actionKeyUpgradeInfo().currentIntensity);
            }
          }, _el$8),
          _el$12 = libs.createElement("Label", {
            marginLeft: "64px",
            "class": "InfoKey",
            get text() {
              return GetLocalization("#Equipment_Durability");
            },
            html: true
          }, _el$8),
          _el$13 = libs.createElement("Panel", {
            "class": "KeyDurabilityList"
          }, _el$8),
          _el$16 = libs.createElement("Panel", {
            id: "ExpBarContainer"
          }, _el$4),
          _el$17 = libs.createElement("Image", {
            id: "ExpAnimBar",
            get style() {
              return {
                clip: `rect( 0%, ${actionKeyUpgradeInfo().previewPercent}%, 100%, 0% )`
              };
            }
          }, _el$16),
          _el$18 = libs.createElement("Image", {
            id: "ExpBar",
            get style() {
              return {
                clip: `rect( 0%, ${actionKeyUpgradeInfo().currentPercent}%, 100%, 0% )`
              };
            }
          }, _el$16),
          _el$19 = libs.createElement("Label", {
            id: "CurExp",
            get text() {
              return actionKeyUpgradeInfo().expText;
            }
          }, _el$16),
          _el$22 = libs.createElement("Panel", {
            id: "TitleDivider"
          }, _el$4);
          libs.createElement("Image", {
            id: "LineLeft"
          }, _el$22);
          libs.createElement("Label", {
            id: "AccessTitle",
            text: "#Equipment_DevourKey"
          }, _el$22);
          libs.createElement("Image", {
            id: "LineRight"
          }, _el$22);
          const _el$26 = libs.createElement("Panel", {
            id: "DevourList"
          }, _el$4),
          _el$27 = libs.createElement("Panel", {
            id: "ActionFooter"
          }, _el$3),
          _el$28 = libs.createElement("Panel", {
            id: "FastAdd"
          }, _el$27),
          _el$30 = libs.createElement("Panel", {
            id: "KeyListRoot"
          }, _el$2),
          _el$31 = libs.createElement("Panel", {
            id: "KeyListTop"
          }, _el$30);
          libs.createElement("Image", {
            id: "KeyListTopBG"
          }, _el$31);
          const _el$33 = libs.createElement("Label", {
            id: "KeyListTopTitle",
            get ["class"]() {
              return libs.classNames({
                Full: isKeyBagFull()
              });
            },
            get text() {
              return `${keyBagCount()}/${KEY_BAG_MAX_CAPACITY}`;
            }
          }, _el$31),
          _el$34 = libs.createElement("Panel", {
            id: "KeyListBox"
          }, _el$30),
          _el$39 = libs.createElement("Panel", {
            id: "BtnsContainer"
          }, _el$30),
          _el$40 = libs.createElement("Panel", {
            align: "center center",
            flowChildren: "right"
          }, _el$39),
          _el$41 = libs.createElement("Button", {
            id: "ResetBtn",
            "class": "SecondaryButtonStates"
          }, _el$40);
        const _ref$ = actionPanelRoot;
        typeof _ref$ === "function" ? libs.use(_ref$, _el$3) : actionPanelRoot = _el$3;
        libs.setProp(_el$3, "onDragEnter", (pPanel, draggedPanel) => {
          if (LoadData(draggedPanel, "key")) {
            setDragInsideActionPanelRoot(true);
          }
        });
        libs.setProp(_el$3, "onDragLeave", (pPanel, draggedPanel) => {
          if (LoadData(draggedPanel, "key")) {
            setDragInsideActionPanelRoot(false);
          }
        });
        libs.insert(_el$4, libs.createComponent(EOM_Button.EOM_BaseButton, {
          id: "ActionSlot",
          get classList() {
            return {
              HasKey: actionKeyData() != undefined
            };
          },
          onDragEnter: (pPanel, draggedPanel) => {
            if (LoadData(draggedPanel, "key")) {
              pPanel.AddClass("potential_drop_target");
            }
          },
          onDragLeave: pPanel => {
            pPanel.RemoveClass("potential_drop_target");
          },
          onDragDrop: (pPanel, draggedPanel) => {
            handleDropToActionSlot(pPanel, draggedPanel);
          },
          get children() {
            return libs.createComponent(libs.Show, {
              get when() {
                return actionKeyData();
              },
              get children() {
                return libs.createComponent(server_dungeon_key.DungeonKey, {
                  get keyID() {
                    return actionKeyID();
                  },
                  oncontextmenu: () => {
                    setActionKeyID();
                  },
                  get onDragStart() {
                    return createKeyDragStart(actionKeyID, () => {
                      const id = actionKeyID();
                      return id ? {
                        id,
                        source: "action"
                      } : undefined;
                    });
                  },
                  onDragEnd: handleKeyDragEnd
                });
              }
            });
          }
        }), _el$5);
        libs.setProp(_el$7, "tooltip_text", "#Equipment_KeyTips");
        libs.setProp(_el$1, "marginLeft", "64px");
        libs.insert(_el$8, libs.createComponent(libs.Show, {
          get when() {
            return actionKeyUpgradeInfo().intensityChange > 0;
          },
          get children() {
            const _el$11 = libs.createElement("Label", {
              "class": "InfoValue PreviewValue PreviewChangeValue",
              get text() {
                return `+${formatKeyPreviewNumber(actionKeyUpgradeInfo().intensityChange)}`;
              }
            }, null);
            libs.effect(_$p => libs.setProp(_el$11, "text", `+${formatKeyPreviewNumber(actionKeyUpgradeInfo().intensityChange)}`, _$p));
            return _el$11;
          }
        }), _el$12);
        libs.setProp(_el$12, "marginLeft", "64px");
        libs.insert(_el$13, libs.createComponent(libs.For, {
          get each() {
            return Array.from({
              length: actionKeyUpgradeInfo().currentDurability
            });
          },
          children: () => libs.createElement("Panel", {
            "class": "KeyDurabilityStar"
          }, null)
        }));
        libs.insert(_el$8, libs.createComponent(libs.Show, {
          get when() {
            return actionKeyUpgradeInfo().durabilityChange > 0;
          },
          get children() {
            const _el$14 = libs.createElement("Label", {
              "class": "InfoValue PreviewValue PreviewChangeValue",
              get text() {
                return `+${actionKeyUpgradeInfo().durabilityChange}`;
              }
            }, null);
            libs.effect(_$p => libs.setProp(_el$14, "text", `+${actionKeyUpgradeInfo().durabilityChange}`, _$p));
            return _el$14;
          }
        }), null);
        libs.insert(_el$4, libs.createComponent(libs.Show, {
          get when() {
            return actionKeyUpgradeInfo().warning;
          },
          get children() {
            const _el$15 = libs.createElement("Label", {
              id: "DevourWarning",
              get text() {
                return actionKeyUpgradeInfo().warning;
              }
            }, null);
            libs.effect(_$p => libs.setProp(_el$15, "text", actionKeyUpgradeInfo().warning, _$p));
            return _el$15;
          }
        }), _el$16);
        libs.insert(_el$16, libs.createComponent(libs.Show, {
          get when() {
            return actionKeyUpgradeInfo().addedExp > 0;
          },
          get children() {
            const _el$20 = libs.createElement("Label", {
              id: "AddexExp",
              get text() {
                return `+${actionKeyUpgradeInfo().addedExp}`;
              }
            }, null);
            libs.effect(_$p => libs.setProp(_el$20, "text", `+${actionKeyUpgradeInfo().addedExp}`, _$p));
            return _el$20;
          }
        }), null);
        libs.insert(_el$16, libs.createComponent(libs.Show, {
          get when() {
            return actionKeyUpgradeInfo().canUpgrade;
          },
          get children() {
            return libs.createElement("Panel", {
              id: "UpgradeIcon"
            }, null);
          }
        }), null);
        libs.insert(_el$4, libs.createComponent(libs.For, {
          get each() {
            return actionKeyAttributeRows();
          },
          children: row => {
            return (() => {
              const _el$43 = libs.createElement("Panel", {
                "class": "AttributeRow"
              }, null);
              libs.insert(_el$43, libs.createComponent(libs.Show, {
                when: row,
                get children() {
                  return [libs.createElement("Panel", {
                    "class": "AttributePoint"
                  }, null), (() => {
                    const _el$45 = libs.createElement("Label", {
                      "class": "AttributeText",
                      html: true,
                      get text() {
                        return row.text;
                      }
                    }, null);
                    libs.effect(_$p => libs.setProp(_el$45, "text", row.text, _$p));
                    return _el$45;
                  })(), libs.createComponent(libs.Show, {
                    get when() {
                      return row.changeText;
                    },
                    get children() {
                      const _el$46 = libs.createElement("Label", {
                        "class": "AttributeChange",
                        get text() {
                          return row.changeText;
                        }
                      }, null);
                      libs.effect(_$p => libs.setProp(_el$46, "text", row.changeText, _$p));
                      return _el$46;
                    }
                  })];
                }
              }));
              libs.effect(_$p => libs.setProp(_el$43, "classList", {
                Empty: row == undefined,
                Main: row?.entryType == 1,
                Adverb: row?.entryType == 2
              }, _$p));
              return _el$43;
            })();
          }
        }), _el$22);
        libs.setProp(_el$26, "onDragEnter", (pPanel, draggedPanel) => {
          if (!isActionKeyMaxLevel() && LoadData(draggedPanel, "key")) {
            pPanel.AddClass("potential_drop_target");
          }
        });
        libs.setProp(_el$26, "onDragLeave", pPanel => {
          pPanel.RemoveClass("potential_drop_target");
        });
        libs.setProp(_el$26, "onDragDrop", (pPanel, draggedPanel) => {
          handleDropToDevourSlot(pPanel, draggedPanel);
        });
        libs.insert(_el$26, libs.createComponent(libs.For, {
          get each() {
            return Array.from({
              length: DEVOUR_SLOT_COUNT / DEVOUR_COLUMN_COUNT
            });
          },
          children: (_, rowIdx) => (() => {
            const _el$47 = libs.createElement("Panel", {
              "class": "DevourRow"
            }, null);
            libs.insert(_el$47, libs.createComponent(libs.For, {
              get each() {
                return Array.from({
                  length: DEVOUR_COLUMN_COUNT
                });
              },
              children: (_, columnIdx) => {
                const idx = () => rowIdx() * DEVOUR_COLUMN_COUNT + columnIdx();
                const keyID = () => devourKeyIDs()[idx()];
                const keyData = () => getKeyData(keyID());
                return libs.createComponent(EOM_Button.EOM_BaseButton, {
                  "class": "DevourSlot",
                  get classList() {
                    return {
                      Unused: unusedDevourKeyIDMap()[keyID()] === true
                    };
                  },
                  onDragEnter: (pPanel, draggedPanel) => {
                    if (!isActionKeyMaxLevel() && LoadData(draggedPanel, "key")) {
                      pPanel.AddClass("potential_drop_target");
                    }
                  },
                  onDragLeave: pPanel => {
                    pPanel.RemoveClass("potential_drop_target");
                  },
                  onDragDrop: (pPanel, draggedPanel) => {
                    handleDropToDevourSlot(pPanel, draggedPanel, idx());
                  },
                  get children() {
                    return libs.createComponent(libs.Show, {
                      get when() {
                        return keyData();
                      },
                      keyed: true,
                      get fallback() {
                        return libs.createElement("Panel", {
                          "class": "EquipListGrid"
                        }, null);
                      },
                      children: () => libs.createComponent(server_dungeon_key.DungeonKey, {
                        get keyID() {
                          return keyID();
                        },
                        oncontextmenu: () => {
                          const id = keyID();
                          if (id) {
                            removeDevourKey(id);
                          }
                        },
                        get onDragStart() {
                          return createKeyDragStart(keyID, () => {
                            const id = keyID();
                            return id ? {
                              id,
                              source: "devour",
                              index: idx()
                            } : undefined;
                          });
                        },
                        onDragEnd: handleKeyDragEnd
                      })
                    });
                  }
                });
              }
            }));
            return _el$47;
          })()
        }));
        libs.insert(_el$28, libs.createComponent(EOM_DropDown.EOM_DropDown, {
          type: "EquipmentDropDown",
          get index() {
            return fastAddRarity();
          },
          menuPosition: "top",
          onChange: (index, item) => {
            setFastAddRarity(index);
          },
          get children() {
            return [libs.createElement("Label", {
              text: "#ALL"
            }, null), libs.createComponent(libs.For, {
              get each() {
                return Array(KEY_RARITY_COUNT);
              },
              children: (_, idx) => {
                const rarity = idx() + 1;
                return (() => {
                  const _el$49 = libs.createElement("Label", {
                    get style() {
                      return {
                        color: equipment_utils.EQUIP_RARITY_COLOR[idx()]
                      };
                    },
                    get text() {
                      return GetLocalization("#Equipment_Rarity_" + rarity);
                    }
                  }, null);
                  libs.effect(_p$ => {
                    const _v$0 = {
                        color: equipment_utils.EQUIP_RARITY_COLOR[idx()]
                      },
                      _v$1 = GetLocalization("#Equipment_Rarity_" + rarity);
                    _v$0 !== _p$._v$0 && (_p$._v$0 = libs.setProp(_el$49, "style", _v$0, _p$._v$0));
                    _v$1 !== _p$._v$1 && (_p$._v$1 = libs.setProp(_el$49, "text", _v$1, _p$._v$1));
                    return _p$;
                  }, {
                    _v$0: undefined,
                    _v$1: undefined
                  });
                  return _el$49;
                })();
              }
            })];
          }
        }), null);
        libs.insert(_el$28, libs.createComponent(equipment_comp.EquipmentCommonBtn, {
          text: "#Equipment_FastAdd",
          get enabled() {
            return !isActionKeyMaxLevel();
          },
          onactivate: () => {
            handleFastAddDevourKeys();
          }
        }), null);
        libs.insert(_el$28, libs.createComponent(equipment_comp.EquipmentCommonBtn, {
          text: "#Equipment_ClearFastAdd",
          onactivate: () => {
            setDevourKeyIDs([]);
          }
        }), null);
        libs.insert(_el$27, libs.createComponent(EOM_Button.EOM_Button, {
          id: "ConfirmDevour",
          color: "Confirm",
          text: "#Equipment_ConfirmDevour",
          get enabled() {
            return actionKeyUpgradeInfo().canConfirm;
          },
          onactivate: () => {
            CallActionRequest("/v1/key/devour", {
              target_id: toFiniteNumber(actionKeyID()),
              devoured_ids: devourKeyIDs().map(id => toFiniteNumber(id))
            }, () => {
              setDevourKeyIDs([]);
            }, () => {});
          }
        }), null);
        libs.insert(_el$34, libs.createComponent(libs.Show, {
          get when() {
            return showFilter();
          },
          get fallback() {
            return libs.createComponent(RecycleView.RecycleView, {
              id: "KeysList",
              input: keys,
              direction: "VerticalGrid",
              wheelStep: 88,
              childConfig: {
                width: 88,
                height: 88,
                margin: 2
              },
              grid_children: () => libs.createElement("Panel", {
                "class": "EquipListGrid"
              }, null),
              children: id => {
                const keyData = () => player_keys()[id()];
                const isNew = () => keyUnreadIds.isUnread(id());
                return (() => {
                  const _el$51 = libs.createElement("Panel", {
                      "class": "Item",
                      get onDragStart() {
                        return createKeyDragStart(id);
                      }
                    }, null),
                    _el$52 = libs.createElement("Panel", {
                      "class": "SelectedBorder",
                      hittest: false
                    }, _el$51);
                    libs.createElement("Panel", {
                      id: "NewTag",
                      hittest: false
                    }, _el$51);
                  libs.setProp(_el$51, "onmouseover", () => {
                    if (isNew()) {
                      keyUnreadIds.markRead(id());
                    }
                  });
                  libs.setProp(_el$51, "onDragEnd", handleKeyDragEnd);
                  libs.insert(_el$51, libs.createComponent(server_dungeon_key.DungeonKey, {
                    get keyID() {
                      return id();
                    },
                    oncontextmenu: p => {
                      const menus = {};
                      if (keyData().locked) {
                        menus["Hud_Equipment_Unlock"] = () => {
                          LockKey(id(), false);
                        };
                      } else {
                        menus["Hud_Equipment_Lock"] = () => {
                          LockKey(id(), true);
                        };
                      }
                      CustomUIConfig.showContextMenu(p, menus);
                    }
                  }), _el$52);
                  libs.effect(_p$ => {
                    const _v$10 = {
                        Selected: actionKeyID() == id(),
                        InDevour: devourKeyIDs().includes(id()),
                        New: isNew()
                      },
                      _v$11 = createKeyDragStart(id);
                    _v$10 !== _p$._v$10 && (_p$._v$10 = libs.setProp(_el$51, "classList", _v$10, _p$._v$10));
                    _v$11 !== _p$._v$11 && (_p$._v$11 = libs.setProp(_el$51, "onDragStart", _v$11, _p$._v$11));
                    return _p$;
                  }, {
                    _v$10: undefined,
                    _v$11: undefined
                  });
                  return _el$51;
                })();
              }
            });
          },
          get children() {
            const _el$35 = libs.createElement("Panel", {
                id: "KeyFilterWindow"
              }, null);
              libs.createElement("Label", {
                id: "RarityLabel",
                "class": "Subheading",
                text: "#Equipment_Rarity"
              }, _el$35);
              libs.createElement("Panel", {
                "class": "FilterLine"
              }, _el$35);
              const _el$38 = libs.createElement("Panel", {
                id: "RarityFilterList",
                "class": "CheckBoxList"
              }, _el$35);
            libs.insert(_el$38, libs.createComponent(libs.For, {
              get each() {
                return Array(KEY_RARITY_COUNT);
              },
              children: (_, idx) => {
                const rarity = idx() + 1;
                return libs.createComponent(equipment_comp.EOM_CheckBox2, {
                  "class": "Rarity" + rarity,
                  get checked() {
                    return filterRarity()[rarity] ?? false;
                  },
                  get text() {
                    return GetLocalization(`#Equipment_Rarity_${rarity}`);
                  },
                  onchecked: b => {
                    setRarityFilterEnabled(rarity, b);
                  }
                });
              }
            }));
            return _el$35;
          }
        }));
        libs.setProp(_el$40, "align", "center center");
        libs.setProp(_el$40, "flowChildren", "right");
        libs.insert(_el$40, libs.createComponent(equipment_comp.EquipmentCommonBtn, {
          id: "FilterBtn",
          get classList() {
            return {
              ShowBtnBorder: showFilter()
            };
          },
          text: "#Hud_Equipment_Filter",
          onactivate: () => {
            setShowFilter(prev => {
              return !prev;
            });
          }
        }), _el$41);
        libs.setProp(_el$41, "onactivate", () => {
          setFilterRarity({});
        });
        libs.insert(_el$40, libs.createComponent(equipment_comp.EquipmentCommonBtn, {
          get text() {
            return actionKeyData()?.locked ? "#Hud_Equipment_Unlock" : "#Hud_Equipment_Lock";
          },
          get enabled() {
            return actionKeyID() != undefined;
          },
          onactivate: () => {
            const id = actionKeyID();
            if (id) {
              let lock = player_keys()[id].locked;
              LockKey(id, !lock);
            }
          }
        }), null);
        libs.effect(_p$ => {
          const _v$ = libs.memo(() => actionKeyUpgradeInfo().previewLevel != actionKeyUpgradeInfo().level)() ? `${ToColor(actionKeyUpgradeInfo().previewLevel.toString(), PREVIEW_GREEN)}/${actionKeyUpgradeInfo().levelMax}` : `${actionKeyUpgradeInfo().level}/${actionKeyUpgradeInfo().levelMax}`,
            _v$2 = GetLocalization("#Equipment_Intensity"),
            _v$3 = formatKeyPreviewNumber(actionKeyUpgradeInfo().currentIntensity),
            _v$4 = GetLocalization("#Equipment_Durability"),
            _v$5 = {
              clip: `rect( 0%, ${actionKeyUpgradeInfo().previewPercent}%, 100%, 0% )`
            },
            _v$6 = {
              clip: `rect( 0%, ${actionKeyUpgradeInfo().currentPercent}%, 100%, 0% )`
            },
            _v$7 = actionKeyUpgradeInfo().expText,
            _v$8 = libs.classNames({
              Full: isKeyBagFull()
            }),
            _v$9 = `${keyBagCount()}/${KEY_BAG_MAX_CAPACITY}`;
          _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$0, "text", _v$, _p$._v$));
          _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$1, "text", _v$2, _p$._v$2));
          _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$10, "text", _v$3, _p$._v$3));
          _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$12, "text", _v$4, _p$._v$4));
          _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$17, "style", _v$5, _p$._v$5));
          _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$18, "style", _v$6, _p$._v$6));
          _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$19, "text", _v$7, _p$._v$7));
          _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$33, "class", _v$8, _p$._v$8));
          _v$9 !== _p$._v$9 && (_p$._v$9 = libs.setProp(_el$33, "text", _v$9, _p$._v$9));
          return _p$;
        }, {
          _v$: undefined,
          _v$2: undefined,
          _v$3: undefined,
          _v$4: undefined,
          _v$5: undefined,
          _v$6: undefined,
          _v$7: undefined,
          _v$8: undefined,
          _v$9: undefined
        });
        return _el$2;
      })()];
    }
  });
};

const EQUIP_PART_LIST = [1, 2, 7, 8, 5, 6, 3, 4];
const EQUIP_PART_ICON$1 = {
  1: "icon_zb_03.png",
  2: "icon_zb_08.png",
  3: "icon_zb_09.png",
  4: "icon_zb_07.png",
  5: "icon_zb_06.png",
  6: "icon_zb_05.png",
  7: "icon_zb_04.png",
  8: "icon_zb_02.png"
};
function formatBonus(value) {
  return `${Math.round(value * 100)}%`;
}
function EquipmentPartLevelUp() {
  const store = equipment_comp.useEquipmentStore();
  const [, setShowTokens] = store.showTokens;
  const partDatas = solid_utils.createServiceNetData("player_equipment_part_datas", {});
  const [selectedPart, setSelectedPart] = libs.createSignal(1);
  const [requesting, setRequesting] = libs.createSignal(false);
  const [showBatchConsume, setShowBatchConsume] = libs.createSignal(false);
  const [slotScrollPercent, setSlotScrollPercent] = libs.createSignal(0);
  const maxLevel = Math.max(...Object.values(KeyValues.equip_level_setting).map(data => data.level));
  let partLevelUpParticle;
  let upgradeParticle;
  let upgradeParticle2;
  let particleSchedule;
  let partLevelSlotsHandle;
  const currentLevel = libs.createMemo(() => partDatas()[selectedPart()]?.level ?? 0);
  const currentSetting = libs.createMemo(() => KeyValues.equip_level_setting[currentLevel()]);
  const nextSetting = libs.createMemo(() => KeyValues.equip_level_setting[currentLevel() + 1]);
  const isMax = libs.createMemo(() => currentLevel() >= maxLevel || nextSetting() == undefined);
  const consumeList = libs.createMemo(() => {
    store.player_tokens();
    store.player_props();
    const consume = currentSetting()?.consume;
    if (!consume || isMax()) return [];
    return consume.split("|").map(item => {
      const [itemID, count] = item.split(":");
      return {
        itemID,
        needCount: Number(count),
        hasCount: GetServiceItemCount(itemID)
      };
    }).filter(item => item.needCount > 0);
  });
  const canLevelUp = libs.createMemo(() => !isMax() && consumeList().every(item => item.hasCount >= item.needCount));
  const maxReachableLevel = libs.createMemo(() => {
    store.player_tokens();
    store.player_props();
    const remaining = {};
    let level = currentLevel();
    while (level < maxLevel) {
      const consume = KeyValues.equip_level_setting[level]?.consume;
      if (!consume) break;
      const levelConsumes = consume.split("|").map(item => {
        const [itemID, count] = item.split(":");
        remaining[itemID] ??= GetServiceItemCount(itemID);
        return {
          itemID,
          needCount: Number(count)
        };
      }).filter(item => item.needCount > 0);
      if (!levelConsumes.every(item => remaining[item.itemID] >= item.needCount)) break;
      levelConsumes.forEach(item => remaining[item.itemID] -= item.needCount);
      level++;
    }
    return level;
  });
  const batchConsumeList = libs.createMemo(() => {
    const totals = {};
    for (let level = currentLevel(); level < maxReachableLevel(); level++) {
      const consume = KeyValues.equip_level_setting[level]?.consume;
      if (!consume) break;
      consume.split("|").forEach(item => {
        const [itemID, count] = item.split(":");
        const needCount = Number(count);
        if (needCount > 0) totals[itemID] = (totals[itemID] ?? 0) + needCount;
      });
    }
    return Object.entries(totals).map(([itemID, needCount]) => ({
      itemID,
      needCount,
      hasCount: GetServiceItemCount(itemID)
    }));
  });
  const canBatchLevelUp = libs.createMemo(() => maxReachableLevel() > currentLevel());
  const displayedConsumeList = libs.createMemo(() => showBatchConsume() && canBatchLevelUp() ? batchConsumeList() : consumeList());
  libs.createEffect(() => {
    const tokenIDs = [...consumeList(), ...batchConsumeList()].map(item => Number(item.itemID));
    setShowTokens(Array.from(new Set(tokenIDs)));
  });
  libs.onCleanup(() => {
    setShowTokens([]);
    if (particleSchedule != undefined) {
      $.CancelScheduled(particleSchedule);
    }
  });
  const playLevelUpParticle = () => {
    if (!partLevelUpParticle && !upgradeParticle && !upgradeParticle2) return;
    if (particleSchedule != undefined) {
      $.CancelScheduled(particleSchedule);
    }
    partLevelUpParticle?.AddClass("Show");
    partLevelUpParticle?.ReloadScene();
    upgradeParticle?.AddClass("Show");
    upgradeParticle?.ReloadScene();
    upgradeParticle2?.AddClass("Show");
    upgradeParticle2?.ReloadScene();
    particleSchedule = $.Schedule(1.2, () => {
      particleSchedule = undefined;
      partLevelUpParticle?.RemoveClass("Show");
      upgradeParticle?.RemoveClass("Show");
      upgradeParticle2?.RemoveClass("Show");
    });
  };
  const levelUp = (level, isBatch = false) => {
    if (level <= 0 || requesting()) return;
    if (isBatch ? !canBatchLevelUp() : !canLevelUp()) return;
    setRequesting(true);
    CallActionRequest("/v1/equip/levelup_part", {
      part: selectedPart(),
      level
    }, () => {
      playLevelUpParticle();
      setShowBatchConsume(false);
      setRequesting(false);
      Game.EmitSound("ui.treasure_01");
    }, () => {
      setRequesting(false);
    });
  };
  const PartSlot = props => {
    const level = () => partDatas()[props.part]?.level ?? 0;
    return libs.createComponent(EOM_Button.EOM_BaseButton, {
      get ["class"]() {
        return libs.classNames("PartLevelSlot", {
          Selected: selectedPart() == props.part
        });
      },
      onactivate: () => setSelectedPart(props.part),
      get children() {
        return [(() => {
          const _el$ = libs.createElement("Panel", {
              "class": "PartIconContainer"
            }, null),
            _el$2 = libs.createElement("Image", {
              "class": "PartIcon",
              get src() {
                return getSrcPath(`conv/icon/${EQUIP_PART_ICON$1[props.part]}`);
              }
            }, _el$);
          libs.effect(_$p => libs.setProp(_el$2, "src", getSrcPath(`conv/icon/${EQUIP_PART_ICON$1[props.part]}`), _$p));
          return _el$;
        })(), (() => {
          const _el$3 = libs.createElement("Panel", {
              "class": "PartTextContainer"
            }, null),
            _el$4 = libs.createElement("Label", {
              "class": "PartName",
              get text() {
                return GetLocalization(`#Equipment_Part_${props.part}`);
              }
            }, _el$3),
            _el$5 = libs.createElement("Label", {
              "class": "PartLevel",
              get text() {
                return LocalizeWithVars("#Equipment_PartLevel_ListLevel", {
                  level: level()
                });
              }
            }, _el$3);
          libs.effect(_p$ => {
            const _v$ = GetLocalization(`#Equipment_Part_${props.part}`),
              _v$2 = LocalizeWithVars("#Equipment_PartLevel_ListLevel", {
                level: level()
              });
            _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$4, "text", _v$, _p$._v$));
            _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$5, "text", _v$2, _p$._v$2));
            return _p$;
          }, {
            _v$: undefined,
            _v$2: undefined
          });
          return _el$3;
        })(), libs.createElement("Panel", {
          "class": "SelectedBorder"
        }, null)];
      }
    });
  };
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
    id: "EquipmentPartLevelUpRoot",
    get children() {
      const _el$7 = libs.createElement("Panel", {
          id: "PartLevelContent"
        }, null),
        _el$8 = libs.createElement("Panel", {
          id: "PartLevelLeft"
        }, _el$7),
        _el$9 = libs.createElement("Panel", {
          id: "PartSelected"
        }, _el$7),
        _el$0 = libs.createElement("Image", {
          id: "PartSelectedIcon",
          get src() {
            return getSrcPath(`conv/icon/${EQUIP_PART_ICON$1[selectedPart()]}`);
          }
        }, _el$9),
        _el$1 = libs.createElement("DOTAParticleScenePanel", {
          id: "PartLevelUpParticle",
          particleName: "particles/ui/game/ui_game_equipment_interface_02_fx.vpcf",
          cameraOrigin: "0 0 250",
          fov: 90,
          lookAt: "0 0 0",
          hittest: false,
          squarePixels: true
        }, _el$9),
        _el$10 = libs.createElement("Panel", {
          id: "PartLevelDetail"
        }, _el$7),
        _el$11 = libs.createElement("Panel", {
          "class": "ToolTipIcon"
        }, _el$10),
        _el$12 = libs.createElement("Panel", {
          id: "AccessDivider"
        }, _el$10);
        libs.createElement("Image", {
          id: "LineLeft"
        }, _el$12);
        const _el$14 = libs.createElement("Label", {
          id: "AccessTitle",
          get text() {
            return LocalizeWithVars("#Equipment_PartLevel_Title", {
              part: GetLocalization(`#Equipment_Part_${selectedPart()}`)
            });
          }
        }, _el$12);
        libs.createElement("Image", {
          id: "LineRight"
        }, _el$12);
        const _el$16 = libs.createElement("Panel", {
          id: "PartLevelCore"
        }, _el$10),
        _el$17 = libs.createElement("Panel", {
          id: "PartLevelCompare"
        }, _el$16),
        _el$18 = libs.createElement("Label", {
          "class": "CurrentLevel",
          get text() {
            return LocalizeWithVars("#Equipment_PartLevel_Level", {
              level: currentLevel()
            });
          }
        }, _el$17);
        libs.createElement("Panel", {
          "class": "LevelArrow"
        }, _el$17);
        const _el$20 = libs.createElement("Label", {
          "class": "NextLevel",
          get text() {
            return libs.memo(() => !!isMax())() ? GetLocalization("#Equipment_MaxLv") : LocalizeWithVars("#Equipment_PartLevel_Level", {
              level: currentLevel() + 1
            });
          }
        }, _el$17),
        _el$21 = libs.createElement("Panel", {
          id: "AccessDivider",
          "class": "BonusTitle"
        }, _el$10);
        libs.createElement("Image", {
          id: "LineLeft"
        }, _el$21);
        const _el$23 = libs.createElement("Label", {
          id: "AccessTitle",
          get text() {
            return GetLocalization("#Equipment_PartLevel_BonusTitle");
          }
        }, _el$21);
        libs.createElement("Image", {
          id: "LineRight"
        }, _el$21);
        const _el$25 = libs.createElement("Panel", {
          id: "PartBonusPanel"
        }, _el$10),
        _el$26 = libs.createElement("Panel", {
          "class": "PartBonusRow"
        }, _el$25),
        _el$27 = libs.createElement("Label", {
          "class": "BonusName",
          get text() {
            return GetLocalization("#Equipment_PartLevel_MainBonus");
          }
        }, _el$26),
        _el$28 = libs.createElement("Label", {
          "class": "BonusCurrent",
          get text() {
            return formatBonus(currentSetting()?.main_bonus ?? 0);
          }
        }, _el$26),
        _el$31 = libs.createElement("Panel", {
          "class": "PartBonusRow"
        }, _el$25),
        _el$32 = libs.createElement("Label", {
          "class": "BonusName",
          get text() {
            return GetLocalization("#Equipment_PartLevel_AdverbBonus");
          }
        }, _el$31),
        _el$33 = libs.createElement("Label", {
          "class": "BonusCurrent",
          get text() {
            return formatBonus(currentSetting()?.adverb_bonus ?? 0);
          }
        }, _el$31),
        _el$36 = libs.createElement("Panel", {
          id: "PartLevelOperation"
        }, _el$10),
        _el$37 = libs.createElement("Panel", {
          id: "ConsumeContainer"
        }, _el$36),
        _el$38 = libs.createElement("Panel", {
          id: "PartLevelConsumes",
          flowChildren: "right-wrap"
        }, _el$37),
        _el$39 = libs.createElement("Panel", {
          id: "PartLevelButtons"
        }, _el$37),
        _el$40 = libs.createElement("DOTAParticleScenePanel", {
          id: "UpgradeParticle1",
          "class": "UpgradeParticle",
          particleName: "particles/ui/game/ui_game_upgrade_fx.vpcf",
          cameraOrigin: "0 0 130",
          fov: 90,
          lookAt: "0 0 0",
          hittest: false,
          squarePixels: true
        }, _el$10),
        _el$41 = libs.createElement("DOTAParticleScenePanel", {
          id: "UpgradeParticle2",
          "class": "UpgradeParticle",
          particleName: "particles/ui/game/ui_game_upgrade_fx.vpcf",
          cameraOrigin: "0 0 130",
          fov: 90,
          lookAt: "0 0 0",
          hittest: false,
          squarePixels: true
        }, _el$10);
      libs.insert(_el$8, libs.createComponent(RecycleView.RecycleView, {
        id: "PartLevelSlots",
        input: () => EQUIP_PART_LIST,
        direction: "Vertical",
        childConfig: {
          width: 420,
          height: 122,
          margin_top: 8.5,
          margin_bottom: 8.5
        },
        wheelStep: 139,
        showBar: false,
        handle: handle => partLevelSlotsHandle = handle,
        onScrollPercent: percent => setSlotScrollPercent(percent),
        children: part => libs.createComponent(PartSlot, {
          get part() {
            return part();
          }
        })
      }), null);
      libs.insert(_el$8, libs.createComponent(EOM_Button.EOM_BaseButton, {
        "class": "DownArrow",
        get enabled() {
          return slotScrollPercent() < 1;
        },
        onactivate: () => partLevelSlotsHandle?.scroll(139)
      }), null);
      const _ref$ = partLevelUpParticle;
      typeof _ref$ === "function" ? libs.use(_ref$, _el$1) : partLevelUpParticle = _el$1;
      libs.setProp(_el$11, "tooltip_text", "#EquipPartLevelupUpTips");
      libs.insert(_el$26, libs.createComponent(libs.Show, {
        get when() {
          return !isMax();
        },
        get children() {
          return [libs.createElement("Panel", {
            "class": "SmallArrow"
          }, null), (() => {
            const _el$30 = libs.createElement("Label", {
              "class": "BonusNext",
              get text() {
                return formatBonus(nextSetting()?.main_bonus ?? 0);
              }
            }, null);
            libs.effect(_$p => libs.setProp(_el$30, "text", formatBonus(nextSetting()?.main_bonus ?? 0), _$p));
            return _el$30;
          })()];
        }
      }), null);
      libs.insert(_el$31, libs.createComponent(libs.Show, {
        get when() {
          return !isMax();
        },
        get children() {
          return [libs.createElement("Panel", {
            "class": "SmallArrow"
          }, null), (() => {
            const _el$35 = libs.createElement("Label", {
              "class": "BonusNext",
              get text() {
                return formatBonus(nextSetting()?.adverb_bonus ?? 0);
              }
            }, null);
            libs.effect(_$p => libs.setProp(_el$35, "text", formatBonus(nextSetting()?.adverb_bonus ?? 0), _$p));
            return _el$35;
          })()];
        }
      }), null);
      libs.setProp(_el$38, "flowChildren", "right-wrap");
      libs.insert(_el$38, libs.createComponent(libs.For, {
        get each() {
          return displayedConsumeList();
        },
        children: consume => (() => {
          const _el$42 = libs.createElement("Panel", {
            get ["class"]() {
              return libs.classNames("PartLevelConsume", {
                Enough: consume.hasCount >= consume.needCount
              });
            }
          }, null);
          libs.insert(_el$42, libs.createComponent(StoreItem.StoreItemBlock, {
            get item_id() {
              return consume.itemID;
            }
          }), null);
          libs.insert(_el$42, libs.createComponent(EOM_CostLabel.EOM_CostLabel, {
            get cost() {
              return consume.needCount;
            },
            get have() {
              return consume.hasCount;
            }
          }), null);
          libs.effect(_$p => libs.setProp(_el$42, "class", libs.classNames("PartLevelConsume", {
            Enough: consume.hasCount >= consume.needCount
          }), _$p));
          return _el$42;
        })()
      }));
      libs.insert(_el$39, libs.createComponent(EOM_Button.EOM_Button, {
        id: "PartLevelUpButton",
        color: "Confirm",
        get enabled() {
          return canLevelUp();
        },
        get loading() {
          return requesting();
        },
        get text() {
          return libs.memo(() => !!isMax())() ? GetLocalization("#Equipment_MaxLv") : GetLocalization("#Equipment_PartLevel_Action");
        },
        onmouseover: () => setShowBatchConsume(false),
        onactivate: () => levelUp(currentLevel() + 1)
      }), null);
      libs.insert(_el$39, libs.createComponent(EOM_Button.EOM_Button, {
        id: "AutoPartLevelUpButton",
        color: "Gold",
        get enabled() {
          return canBatchLevelUp();
        },
        get loading() {
          return requesting();
        },
        get text() {
          return LocalizeWithVars("#Equipment_PartLevel_AutoAction", {
            level: maxReachableLevel()
          });
        },
        onmouseover: () => setShowBatchConsume(true),
        onmouseout: () => setShowBatchConsume(false),
        onactivate: () => levelUp(maxReachableLevel(), true)
      }), null);
      const _ref$2 = upgradeParticle;
      typeof _ref$2 === "function" ? libs.use(_ref$2, _el$40) : upgradeParticle = _el$40;
      const _ref$3 = upgradeParticle2;
      typeof _ref$3 === "function" ? libs.use(_ref$3, _el$41) : upgradeParticle2 = _el$41;
      libs.effect(_p$ => {
        const _v$3 = getSrcPath(`conv/icon/${EQUIP_PART_ICON$1[selectedPart()]}`),
          _v$4 = LocalizeWithVars("#Equipment_PartLevel_Title", {
            part: GetLocalization(`#Equipment_Part_${selectedPart()}`)
          }),
          _v$5 = LocalizeWithVars("#Equipment_PartLevel_Level", {
            level: currentLevel()
          }),
          _v$6 = libs.memo(() => !!isMax())() ? GetLocalization("#Equipment_MaxLv") : LocalizeWithVars("#Equipment_PartLevel_Level", {
            level: currentLevel() + 1
          }),
          _v$7 = GetLocalization("#Equipment_PartLevel_BonusTitle"),
          _v$8 = GetLocalization("#Equipment_PartLevel_MainBonus"),
          _v$9 = formatBonus(currentSetting()?.main_bonus ?? 0),
          _v$0 = GetLocalization("#Equipment_PartLevel_AdverbBonus"),
          _v$1 = formatBonus(currentSetting()?.adverb_bonus ?? 0);
        _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$0, "src", _v$3, _p$._v$3));
        _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$14, "text", _v$4, _p$._v$4));
        _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$18, "text", _v$5, _p$._v$5));
        _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$20, "text", _v$6, _p$._v$6));
        _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$23, "text", _v$7, _p$._v$7));
        _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$27, "text", _v$8, _p$._v$8));
        _v$9 !== _p$._v$9 && (_p$._v$9 = libs.setProp(_el$28, "text", _v$9, _p$._v$9));
        _v$0 !== _p$._v$0 && (_p$._v$0 = libs.setProp(_el$32, "text", _v$0, _p$._v$0));
        _v$1 !== _p$._v$1 && (_p$._v$1 = libs.setProp(_el$33, "text", _v$1, _p$._v$1));
        return _p$;
      }, {
        _v$3: undefined,
        _v$4: undefined,
        _v$5: undefined,
        _v$6: undefined,
        _v$7: undefined,
        _v$8: undefined,
        _v$9: undefined,
        _v$0: undefined,
        _v$1: undefined
      });
      return _el$7;
    }
  });
}

const KV$2 = KeyValues.equip_common_setting["equip_rarity_upgrade_cost"];
const RarityUPWindow = props => {
  const MAX_RARITY = equipment_utils.MAX_EQUIPMENT_RARITY;
  const store = equipment_comp.useEquipmentStore();
  const [selectedItemID] = store.selectedItemID;
  const [, setShowTokens] = store.showTokens;
  const itemData = () => props.itemData();
  const [upgradeRecord, setUpgradeRecord] = libs.createStore({
    equipID: 0,
    mainNum: 0,
    adverbNum: 0
  });
  libs.createEffect(libs.on(itemData, () => {
    const item = itemData();
    if (item == undefined || item.id != upgradeRecord.equipID) {
      setUpgradeRecord(solid_utils.resetStore({
        equipID: 0,
        mainNum: 0,
        adverbNum: 0
      }));
    }
  }));
  const rarity = () => itemData()?.rarity ?? 0;
  const bMax = () => rarity() >= MAX_RARITY;
  const consumeList = libs.createMemo(() => {
    store.player_tokens();
    if (!KV$2 || KV$2.value == undefined) {
      return [];
    }
    let consume = String(KV$2.value);
    return consume.split("|").map(item => {
      let [itemID, num] = item.split(":");
      return {
        itemID,
        needCount: Number(num),
        hasCount: GetServiceItemCount(itemID)
      };
    }).filter(d => d.needCount > 0);
  });
  const canStrengthen = libs.createMemo(() => consumeList().every(consume => consume.hasCount >= consume.needCount) && (itemData()?.remaining_potential ?? 0) > 0);
  libs.createEffect(() => {
    const tokens = consumeList().map(d => toFiniteNumber(d.itemID));
    setShowTokens(tokens);
  });
  const suitEffectID = () => {
    const data = itemData();
    if (data == undefined) {
      return undefined;
    }
    if (data.ability_entry_data != undefined && data.ability_entry_data.length > 0) {
      return data.ability_entry_data[0].id;
    }
  };
  libs.createEffect(() => {
    props.setLeftExtraContent?.((() => {
      const _el$ = libs.createElement("Panel", {
          id: "OperationBtns"
        }, null),
        _el$2 = libs.createElement("Panel", {
          id: "ConsumeBtn",
          flowChildren: "down"
        }, _el$),
        _el$3 = libs.createElement("Panel", {
          horizontalAlign: "center",
          flowChildren: "right"
        }, _el$2);
      libs.insert(_el$, libs.createComponent(EOM_Button.EOM_Button, {
        id: "ReturnBtn",
        text: "#MenuButton_Return",
        onactivate: () => props.onReturn?.()
      }), _el$2);
      libs.setProp(_el$2, "flowChildren", "down");
      libs.setProp(_el$3, "horizontalAlign", "center");
      libs.setProp(_el$3, "flowChildren", "right");
      libs.insert(_el$3, libs.createComponent(libs.For, {
        get each() {
          return consumeList();
        },
        children: consume => {
          return (() => {
            const _el$4 = libs.createElement("Panel", {
                get ["class"]() {
                  return libs.classNames("ComsumeItem", {
                    Enough: consume.hasCount >= consume.needCount
                  });
                }
              }, null),
              _el$5 = libs.createElement("Label", {
                get text() {
                  return "X" + consume.needCount;
                }
              }, _el$4);
            libs.insert(_el$4, libs.createComponent(StoreItem.StoreItemImage, {
              get itemid() {
                return consume.itemID;
              }
            }), _el$5);
            libs.effect(_p$ => {
              const _v$ = libs.classNames("ComsumeItem", {
                  Enough: consume.hasCount >= consume.needCount
                }),
                _v$2 = "X" + consume.needCount;
              _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$4, "class", _v$, _p$._v$));
              _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$5, "text", _v$2, _p$._v$2));
              return _p$;
            }, {
              _v$: undefined,
              _v$2: undefined
            });
            return _el$4;
          })();
        }
      }));
      libs.insert(_el$2, libs.createComponent(EOM_Button.EOM_Button, {
        get enabled() {
          return libs.memo(() => !!!bMax())() && canStrengthen();
        },
        color: "Confirm",
        text: "#Equipment_RarityUP",
        onactivate: () => {
          const item = itemData();
          if (!item || !selectedItemID()) return;
          setUpgradeRecord({
            equipID: item.id,
            mainNum: item.main_entry_data.length,
            adverbNum: item.adverb_entry_data.length
          });
          props.startForgeAnimation?.(() => new Promise(resolve => {
            CallActionRequest("/v1/equip/rarity_upgrade", {
              id: selectedItemID()
            }, () => resolve(), () => resolve());
          }));
        }
      }), null);
      return _el$;
    })());
  });
  return (() => {
    const _el$6 = libs.createElement("Panel", {
        id: "RarityUPPanel",
        get ["class"]() {
          return libs.classNames({
            IsMax: bMax()
          }, "RarityColor" + rarity());
        }
      }, null);
      libs.createElement("Label", {
        "class": "WindowTitle",
        text: "#EquipmentTab_rarity_upgrade"
      }, _el$6);
      const _el$8 = libs.createElement("Label", {
        "class": "EquipName EquipRarityLabel",
        get text() {
          return "#" + itemData()?.equipment_item_id;
        }
      }, _el$6),
      _el$9 = libs.createElement("Panel", {
        "class": "ToolTipIcon"
      }, _el$6),
      _el$12 = libs.createElement("Label", {
        id: "RemainingPotential",
        get vars() {
          return {
            value: itemData()?.remaining_potential ?? 0
          };
        },
        text: "#Equip_RemainingPotential"
      }, _el$6);
    libs.setProp(_el$9, "tooltip_text", "#EquipRarityUpgradeTips");
    libs.insert(_el$6, libs.createComponent(libs.Show, {
      get when() {
        return !bMax();
      },
      get children() {
        const _el$0 = libs.createElement("Panel", {
            id: "ShowRarity"
          }, null),
          _el$1 = libs.createElement("Label", {
            id: "CurRarity",
            "class": "EquipRarityLabel",
            get text() {
              return `#Equipment_Rarity_${rarity()}`;
            },
            html: true
          }, _el$0);
          libs.createElement("Image", {
            id: "Arrow"
          }, _el$0);
          const _el$11 = libs.createElement("Label", {
            get ["class"]() {
              return "Rarity" + (rarity() + 1);
            },
            get text() {
              return `#Equipment_Rarity_${rarity() + 1}`;
            },
            html: true
          }, _el$0);
        libs.effect(_p$ => {
          const _v$3 = `#Equipment_Rarity_${rarity()}`,
            _v$4 = "Rarity" + (rarity() + 1),
            _v$5 = `#Equipment_Rarity_${rarity() + 1}`;
          _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$1, "text", _v$3, _p$._v$3));
          _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$11, "class", _v$4, _p$._v$4));
          _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$11, "text", _v$5, _p$._v$5));
          return _p$;
        }, {
          _v$3: undefined,
          _v$4: undefined,
          _v$5: undefined
        });
        return _el$0;
      }
    }), _el$12);
    libs.insert(_el$6, libs.createComponent(equipment_comp.EquipSeparator, {
      id: "CurAttrSeparator",
      text: "#Equipment_CurAttr"
    }), null);
    libs.insert(_el$6, libs.createComponent(equipment_comp.AttrContainer, {
      get children() {
        return [libs.createComponent(libs.For, {
          get each() {
            return itemData()?.main_entry_data ?? [];
          },
          children: (data, index) => {
            const isNewEntry = () => upgradeRecord.mainNum > 0 && index() >= upgradeRecord.mainNum;
            return libs.createComponent(equipment_comp.AttrItem, {
              get index() {
                return index();
              },
              attrData: data,
              type: "Main",
              get isNew() {
                return isNewEntry();
              }
            });
          }
        }), libs.createComponent(libs.For, {
          get each() {
            return itemData()?.adverb_entry_data ?? [];
          },
          children: (data, index) => {
            const isNewEntry = () => upgradeRecord.adverbNum > 0 && index() >= upgradeRecord.adverbNum;
            return libs.createComponent(equipment_comp.AttrItem, {
              get index() {
                return index();
              },
              attrData: data,
              type: "Adverb",
              get isNew() {
                return isNewEntry();
              }
            });
          }
        }), libs.createComponent(libs.Index, {
          get each() {
            return itemData().myth_entry_data;
          },
          children: data => {
            const entryKv = KeyValues.equip_entry[data().id];
            return (() => {
              const _el$13 = libs.createElement("Panel", {
                  "class": "MythEntry"
                }, null);
                libs.createElement("Image", {}, _el$13);
                const _el$15 = libs.createElement("Label", {
                  get text() {
                    return GetPrivilegeDesc(data().id, 1, {
                      value: data().value,
                      min: entryKv.value_min,
                      max: entryKv.value_max
                    });
                  },
                  html: true
                }, _el$13);
              libs.effect(_$p => libs.setProp(_el$15, "text", GetPrivilegeDesc(data().id, 1, {
                value: data().value,
                min: entryKv.value_min,
                max: entryKv.value_max
              }), _$p));
              return _el$13;
            })();
          }
        }), libs.createComponent(libs.Index, {
          get each() {
            return itemData().chaos_entry_data;
          },
          children: data => (() => {
            const _el$16 = libs.createElement("Panel", {
                "class": `ChaosEntry`
              }, null);
              libs.createElement("Panel", {
                id: "Point"
              }, _el$16);
              const _el$18 = libs.createElement("Label", {
                id: "EntryText",
                get text() {
                  return equipment_utils.GetChaosRowInfo(data());
                },
                html: true
              }, _el$16);
            libs.setProp(_el$16, "class", `ChaosEntry`);
            libs.effect(_$p => libs.setProp(_el$18, "text", equipment_utils.GetChaosRowInfo(data()), _$p));
            return _el$16;
          })()
        }), libs.createComponent(libs.Show, {
          get when() {
            return suitEffectID();
          },
          get children() {
            return libs.createComponent(equip_details.EquipSuitList, {
              get suitEffectID() {
                return suitEffectID();
              }
            });
          }
        })];
      }
    }), null);
    libs.effect(_p$ => {
      const _v$6 = libs.classNames({
          IsMax: bMax()
        }, "RarityColor" + rarity()),
        _v$7 = "#" + itemData()?.equipment_item_id,
        _v$8 = {
          value: itemData()?.remaining_potential ?? 0
        };
      _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$6, "class", _v$6, _p$._v$6));
      _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$8, "text", _v$7, _p$._v$7));
      _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$12, "vars", _v$8, _p$._v$8));
      return _p$;
    }, {
      _v$6: undefined,
      _v$7: undefined,
      _v$8: undefined
    });
    return _el$6;
  })();
};

const RARITY_COND$1 = 5;
const KV$1 = KeyValues.equip_forge_setting["entry_recast"];
function getEntryByType(data, entryType, entryIndex) {
  switch (entryType) {
    case 2:
      return data.adverb_entry_data?.[entryIndex];
    case 4:
      return data.myth_entry_data?.[entryIndex];
    case 5:
      return data.chaos_entry_data?.[entryIndex];
    default:
      return undefined;
  }
}
function parseNumber(value) {
  if (value == undefined || value === "") return undefined;
  const numberValue = Number(value);
  return Number.isFinite(numberValue) ? numberValue : undefined;
}
function normalizeRecastV2OptionEntry(raw) {
  if (!raw || typeof raw !== "object") return undefined;
  const data = raw;
  if (typeof data.id !== "string" || data.id === "") return undefined;
  return {
    id: data.id,
    value: parseNumber(data.value),
    base_value: parseNumber(data.base_value),
    extra_value: parseNumber(data.extra_value),
    percent: parseNumber(data.percent),
    base_min: parseNumber(data.base_min),
    base_max: parseNumber(data.base_max)
  };
}
function parseRecastV2OptionEntries(result) {
  const optionEntryData = result.option_entry_data;
  const rawEntries = typeof optionEntryData === "string" ? JSON.parseSafe(optionEntryData) : optionEntryData;
  if (Array.isArray(rawEntries)) {
    return rawEntries.map(normalizeRecastV2OptionEntry).filter(entry => entry != undefined);
  }
  return result.options?.split(",").filter(optionId => optionId !== "").map(id => ({
    id
  })) ?? [];
}
function getRecastV2OptionText(option) {
  if (option.id.startsWith("privilege_")) {
    const entryKv = KeyValues.equip_entry[option.id];
    return GetPrivilegeDesc(option.id, 1, {
      value: option.value ?? 0,
      min: option.base_min ?? entryKv?.value_min,
      max: option.base_max ?? entryKv?.value_max
    });
  }
  if (option.value != undefined) {
    return GetPropertyLocalization(option.id, equipment_utils.EquipAttributeRound(option.id, toFiniteNumber(option.value, 0)));
  }
  return GetLocalization("#property_" + option.id).replace("%", "");
}
const RecastWindow = props => {
  const store = equipment_comp.useEquipmentStore();
  const [selectedItemID] = store.selectedItemID;
  const [, setShowTokens] = store.showTokens;
  const itemData = () => props.itemData();
  const rarity = () => itemData()?.rarity ?? 0;
  const canStrengthen = () => rarity() >= RARITY_COND$1 && consumeList().every(consume => consume.hasCount >= consume.needCount) && (itemData()?.remaining_potential ?? 0) > 0;
  const [selectedEntry, setSelectedEntry] = libs.createSignal(null);
  const recastV2Results = solid_utils.createServiceNetData("player_recast_equipment_v2_results", {});
  const isRecastV2Confirm = () => itemData()?.in_check === "recast_v2";
  const currentRecastV2Result = libs.createMemo(() => {
    if (!isRecastV2Confirm()) return undefined;
    const results = recastV2Results();
    const id = String(selectedItemID());
    const result = results?.[id] ?? Object.values(results ?? {}).find(result => result !== "nil" && String(result.id) === id);
    if (result && result !== "nil") return result;
    return undefined;
  });
  const [cachedOldEntry, setCachedOldEntry] = libs.createSignal();
  const [cachedOptions, setCachedOptions] = libs.createSignal([]);
  libs.createEffect(() => {
    if (isRecastV2Confirm()) {
      const result = currentRecastV2Result();
      const data = itemData();
      if (result && data) {
        setCachedOldEntry(getEntryByType(data, result.entry_type, result.entry_index));
        setCachedOptions(parseRecastV2OptionEntries(result));
      }
    }
  });
  const recastV2OldEntry = () => cachedOldEntry();
  const recastV2Options = () => cachedOptions();
  const consumeList = libs.createMemo(() => {
    store.player_tokens();
    if (!KV$1 || KV$1.consume == undefined) {
      return [];
    }
    let consume = String(KV$1.consume);
    return consume.split("|").map(item => {
      let [itemID, num] = item.split(":");
      return {
        itemID,
        needCount: Number(num),
        hasCount: GetServiceItemCount(itemID)
      };
    }).filter(d => d.needCount > 0);
  });
  libs.createEffect(() => {
    libs.batch(() => {
      const tokens = consumeList().map(d => toFiniteNumber(d.itemID));
      setShowTokens(tokens);
    });
  });
  const suitEffectID = () => {
    const data = itemData();
    if (data == undefined) {
      return undefined;
    }
    if (data.ability_entry_data != undefined && data.ability_entry_data.length > 0) {
      return data.ability_entry_data[0].id;
    }
  };
  libs.createEffect(() => {
    if (isRecastV2Confirm()) {
      props.setLeftExtraContent?.((() => {
        const _el$ = libs.createElement("Panel", {
            id: "OperationBtns"
          }, null),
          _el$2 = libs.createElement("Label", {
            "class": "RecastV2HintText",
            text: "#Equipment_RecastV2_SelectOption"
          }, _el$);
        libs.insert(_el$, libs.createComponent(EOM_Button.EOM_Button, {
          id: "ReturnBtn",
          text: "#MenuButton_Return",
          onactivate: () => props.onReturn?.()
        }), _el$2);
        return _el$;
      })());
    } else {
      props.setLeftExtraContent?.((() => {
        const _el$3 = libs.createElement("Panel", {
            id: "OperationBtns"
          }, null),
          _el$4 = libs.createElement("Panel", {
            id: "ConsumeBtn",
            flowChildren: "down"
          }, _el$3),
          _el$5 = libs.createElement("Panel", {
            horizontalAlign: "center",
            flowChildren: "right"
          }, _el$4);
        libs.insert(_el$3, libs.createComponent(EOM_Button.EOM_Button, {
          id: "ReturnBtn",
          text: "#MenuButton_Return",
          onactivate: () => props.onReturn?.()
        }), _el$4);
        libs.setProp(_el$4, "flowChildren", "down");
        libs.setProp(_el$5, "horizontalAlign", "center");
        libs.setProp(_el$5, "flowChildren", "right");
        libs.insert(_el$5, libs.createComponent(libs.For, {
          get each() {
            return consumeList();
          },
          children: consume => {
            return (() => {
              const _el$6 = libs.createElement("Panel", {
                  get ["class"]() {
                    return libs.classNames("ComsumeItem", {
                      Enough: consume.hasCount >= consume.needCount
                    });
                  }
                }, null),
                _el$7 = libs.createElement("Label", {
                  get text() {
                    return "X" + consume.needCount;
                  }
                }, _el$6);
              libs.insert(_el$6, libs.createComponent(StoreItem.StoreItemImage, {
                get itemid() {
                  return consume.itemID;
                }
              }), _el$7);
              libs.effect(_p$ => {
                const _v$ = libs.classNames("ComsumeItem", {
                    Enough: consume.hasCount >= consume.needCount
                  }),
                  _v$2 = "X" + consume.needCount;
                _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$6, "class", _v$, _p$._v$));
                _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$7, "text", _v$2, _p$._v$2));
                return _p$;
              }, {
                _v$: undefined,
                _v$2: undefined
              });
              return _el$6;
            })();
          }
        }));
        libs.insert(_el$4, libs.createComponent(EOM_Button.EOM_Button, {
          get enabled() {
            return libs.memo(() => !!canStrengthen())() && selectedEntry() != null;
          },
          color: "Confirm",
          text: "#Equipment_Recast",
          onactivate: () => {
            const entry = selectedEntry();
            if (!selectedItemID() || !entry) return;
            props.startForgeAnimation?.(() => new Promise(resolve => {
              CallActionRequest("/v1/equip/recast", {
                id: selectedItemID(),
                entry_type: entry.type,
                entry_index: entry.index
              }, () => resolve(), () => resolve());
            }));
          }
        }), null);
        return _el$3;
      })());
    }
  });
  return (() => {
    const _el$8 = libs.createElement("Panel", {
        id: "RecastPanel",
        get ["class"]() {
          return libs.classNames("RarityColor" + rarity());
        }
      }, null);
      libs.createElement("Label", {
        "class": "WindowTitle",
        text: "#EquipmentTab_recast"
      }, _el$8);
      const _el$0 = libs.createElement("Label", {
        "class": "EquipName EquipRarityLabel",
        get text() {
          return "#" + itemData()?.equipment_item_id;
        }
      }, _el$8),
      _el$1 = libs.createElement("Panel", {
        "class": "ToolTipIcon"
      }, _el$8),
      _el$10 = libs.createElement("Label", {
        id: "RemainingPotential",
        get vars() {
          return {
            value: itemData()?.remaining_potential ?? 0
          };
        },
        text: "#Equip_RemainingPotential"
      }, _el$8);
    libs.setProp(_el$1, "tooltip_text", "#EquipRecastTips");
    libs.insert(_el$8, libs.createComponent(libs.Show, {
      get when() {
        return isRecastV2Confirm() || cachedOptions().length > 0;
      },
      get fallback() {
        return [libs.createComponent(equipment_comp.EquipSeparator, {
          id: "SelectSeparator",
          text: "#Equipment_SelectEntry"
        }), libs.createComponent(equipment_comp.AttrContainer, {
          get children() {
            return [libs.createComponent(libs.For, {
              get each() {
                return itemData()?.adverb_entry_data ?? [];
              },
              children: (data, index) => {
                const isSelected = () => selectedEntry()?.type === 2 && selectedEntry()?.index === index();
                return libs.createComponent(equipment_comp.AttrItem, {
                  attrData: data,
                  get selected() {
                    return isSelected();
                  },
                  type: "Adverb",
                  get index() {
                    return index();
                  },
                  onAttrbuteClick: (type, idx) => {
                    if (isSelected()) {
                      setSelectedEntry(null);
                    } else {
                      setSelectedEntry({
                        index: idx,
                        type: 2
                      });
                    }
                  },
                  get children() {
                    return libs.createComponent(libs.Show, {
                      get when() {
                        return isSelected();
                      },
                      get children() {
                        return [libs.createElement("Panel", {
                          id: "ShowArrow",
                          "class": "EquipArrow"
                        }, null), libs.createElement("Label", {
                          id: "UnknowText",
                          text: "???"
                        }, null)];
                      }
                    });
                  }
                });
              }
            }), libs.createComponent(libs.Index, {
              get each() {
                return itemData().myth_entry_data;
              },
              children: (data, mythIndex) => {
                const isSelected = () => selectedEntry()?.type === 4 && selectedEntry()?.index === mythIndex;
                const entryKv = () => KeyValues.equip_entry[data().id];
                return (() => {
                  const _el$19 = libs.createElement("Panel", {
                      "class": "EntryContainer"
                    }, null),
                    _el$20 = libs.createElement("Panel", {
                      "class": "MythEntry"
                    }, _el$19);
                    libs.createElement("Image", {}, _el$20);
                    const _el$22 = libs.createElement("Label", {
                      get text() {
                        return GetPrivilegeDesc(data().id, 1, {
                          value: data().value,
                          min: entryKv().value_min,
                          max: entryKv().value_max
                        });
                      },
                      html: true
                    }, _el$20);
                  libs.setProp(_el$19, "onactivate", () => {
                    if (isSelected()) {
                      setSelectedEntry(null);
                    } else {
                      setSelectedEntry({
                        index: mythIndex,
                        type: 4
                      });
                    }
                  });
                  libs.insert(_el$19, libs.createComponent(equipment_comp.AttributeSelectBtn, {
                    get selected() {
                      return isSelected();
                    }
                  }), _el$20);
                  libs.effect(_$p => libs.setProp(_el$22, "text", GetPrivilegeDesc(data().id, 1, {
                    value: data().value,
                    min: entryKv().value_min,
                    max: entryKv().value_max
                  }), _$p));
                  return _el$19;
                })();
              }
            }), libs.createComponent(libs.Index, {
              get each() {
                return itemData().chaos_entry_data;
              },
              children: (data, chaosIndex) => {
                const isSelected = () => selectedEntry()?.type === 5 && selectedEntry()?.index === chaosIndex;
                return (() => {
                  const _el$23 = libs.createElement("Panel", {
                      "class": "EntryContainer"
                    }, null),
                    _el$24 = libs.createElement("Panel", {
                      "class": `ChaosEntry`
                    }, _el$23);
                    libs.createElement("Panel", {
                      id: "Point"
                    }, _el$24);
                    const _el$26 = libs.createElement("Label", {
                      id: "EntryText",
                      get text() {
                        return equipment_utils.GetChaosRowInfo(data());
                      },
                      html: true
                    }, _el$24);
                  libs.setProp(_el$23, "onactivate", () => {
                    if (isSelected()) {
                      setSelectedEntry(null);
                    } else {
                      setSelectedEntry({
                        index: chaosIndex,
                        type: 5
                      });
                    }
                  });
                  libs.insert(_el$23, libs.createComponent(equipment_comp.AttributeSelectBtn, {
                    get selected() {
                      return isSelected();
                    }
                  }), _el$24);
                  libs.setProp(_el$24, "class", `ChaosEntry`);
                  libs.effect(_$p => libs.setProp(_el$26, "text", equipment_utils.GetChaosRowInfo(data()), _$p));
                  return _el$23;
                })();
              }
            }), libs.createComponent(libs.Show, {
              get when() {
                return suitEffectID();
              },
              get children() {
                const _el$16 = libs.createElement("Panel", {
                  "class": "EntryContainer"
                }, null);
                libs.setProp(_el$16, "onactivate", () => {
                  const isSelected = selectedEntry()?.type === 3 && selectedEntry()?.index === 0;
                  if (isSelected) {
                    setSelectedEntry(null);
                  } else {
                    setSelectedEntry({
                      index: 0,
                      type: 3
                    });
                  }
                });
                libs.insert(_el$16, libs.createComponent(equipment_comp.AttributeSelectBtn, {
                  get selected() {
                    return libs.memo(() => selectedEntry()?.type === 3)() && selectedEntry()?.index === 0;
                  }
                }), null);
                libs.insert(_el$16, libs.createComponent(equip_details.EquipSuitList, {
                  get suitEffectID() {
                    return suitEffectID();
                  }
                }), null);
                return _el$16;
              }
            })];
          }
        })];
      },
      get children() {
        const _el$11 = libs.createElement("Panel", {
            id: "RecastV2ConfirmPanel"
          }, null),
          _el$12 = libs.createElement("Panel", {
            "class": "RecastV2OldEntry"
          }, _el$11),
          _el$13 = libs.createElement("Panel", {
            "class": "RecastV2Arrow"
          }, _el$11);
          libs.createElement("Panel", {
            id: "ShowArrow",
            "class": "EquipArrow"
          }, _el$13);
          const _el$15 = libs.createElement("Panel", {
            "class": "RecastV2Options"
          }, _el$11);
        libs.insert(_el$11, libs.createComponent(equipment_comp.EquipSeparator, {
          id: "SelectSeparator",
          text: "#Equipment_RecastV2_Recasting"
        }), _el$12);
        libs.insert(_el$12, libs.createComponent(libs.Show, {
          get when() {
            return recastV2OldEntry();
          },
          get children() {
            return (() => {
              const entry = recastV2OldEntry();
              const isPrivilege = entry.id.startsWith("privilege_");
              const text = isPrivilege ? GetPrivilegeDesc(entry.id, 1, {
                value: entry.value,
                min: entry.min,
                max: entry.max
              }) : GetPropertyLocalization(entry.id, equipment_utils.EquipAttributeRound(entry.id, toFiniteNumber(entry.value, 0)));
              return (() => {
                const _el$27 = libs.createElement("Label", {
                  "class": "RecastV2OldEntryText",
                  text: text,
                  html: true
                }, null);
                libs.setProp(_el$27, "text", text);
                return _el$27;
              })();
            })();
          }
        }));
        libs.insert(_el$15, libs.createComponent(libs.For, {
          get each() {
            return recastV2Options();
          },
          children: (option, index) => {
            return (() => {
              const _el$28 = libs.createElement("Panel", {
                  "class": "RecastV2OptionBtn"
                }, null),
                _el$29 = libs.createElement("Label", {
                  "class": "RecastV2OptionText",
                  get text() {
                    return getRecastV2OptionText(option);
                  },
                  html: true
                }, _el$28);
              libs.setProp(_el$28, "onactivate", () => {
                if (!selectedItemID()) return;
                props.startForgeAnimation?.(() => new Promise(resolve => {
                  CallActionRequest("/v1/equip/recast_v2_confirm", {
                    id: selectedItemID(),
                    option: index()
                  }, () => resolve(), () => resolve());
                }))?.then(() => {
                  libs.batch(() => {
                    setCachedOldEntry();
                    setCachedOptions([]);
                  });
                });
              });
              libs.effect(_$p => libs.setProp(_el$29, "text", getRecastV2OptionText(option), _$p));
              return _el$28;
            })();
          }
        }));
        return _el$11;
      }
    }), null);
    libs.effect(_p$ => {
      const _v$3 = libs.classNames("RarityColor" + rarity()),
        _v$4 = "#" + itemData()?.equipment_item_id,
        _v$5 = {
          value: itemData()?.remaining_potential ?? 0
        };
      _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$8, "class", _v$3, _p$._v$3));
      _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$0, "text", _v$4, _p$._v$4));
      _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$10, "vars", _v$5, _p$._v$5));
      return _p$;
    }, {
      _v$3: undefined,
      _v$4: undefined,
      _v$5: undefined
    });
    return _el$8;
  })();
};

const RARITY_COND = 5;
const KV = KeyValues.equip_forge_setting["entry_refine"];
const RefineWindow = props => {
  const store = equipment_comp.useEquipmentStore();
  const [selectedItemID] = store.selectedItemID;
  const [, setShowTokens] = store.showTokens;
  const itemData = () => props.itemData();
  const rarity = () => itemData()?.rarity ?? 0;
  const getSelectedEntryPercent = () => {
    const entry = selectedEntry();
    if (!entry) return null;
    let data;
    if (entry.type === 2) {
      data = itemData()?.adverb_entry_data?.[entry.index];
    } else if (entry.type === 4) {
      data = itemData()?.myth_entry_data?.[entry.index];
    } else if (entry.type === 5) {
      data = itemData()?.chaos_entry_data?.[entry.index];
    }
    return data ? toFiniteNumber(data.percent, 0) : null;
  };
  const isEntryMaxValue = () => {
    const percent = getSelectedEntryPercent();
    return percent != null && percent >= 100;
  };
  const canStrengthen = () => rarity() >= RARITY_COND && consumeList().every(consume => consume.hasCount >= consume.needCount) && (itemData()?.remaining_potential ?? 0) > 0 && !isEntryMaxValue();
  const [selectedEntry, setSelectedEntry] = libs.createSignal(null);
  const consumeList = libs.createMemo(() => {
    store.player_tokens();
    if (!KV || KV.consume == undefined) {
      return [];
    }
    let consume = String(KV.consume);
    return consume.split("|").map(item => {
      let [itemID, num] = item.split(":");
      return {
        itemID,
        needCount: Number(num),
        hasCount: GetServiceItemCount(itemID)
      };
    }).filter(d => d.needCount > 0);
  });
  libs.createEffect(() => {
    const tokens = consumeList().map(d => toFiniteNumber(d.itemID));
    setShowTokens(tokens);
  });
  libs.createEffect(() => {
    props.setLeftExtraContent?.((() => {
      const _el$ = libs.createElement("Panel", {
          id: "OperationBtns"
        }, null),
        _el$2 = libs.createElement("Panel", {
          id: "ConsumeBtn",
          flowChildren: "down"
        }, _el$),
        _el$3 = libs.createElement("Panel", {
          horizontalAlign: "center",
          flowChildren: "right"
        }, _el$2);
      libs.insert(_el$, libs.createComponent(EOM_Button.EOM_Button, {
        id: "ReturnBtn",
        text: "#MenuButton_Return",
        onactivate: () => props.onReturn?.()
      }), _el$2);
      libs.setProp(_el$2, "flowChildren", "down");
      libs.setProp(_el$3, "horizontalAlign", "center");
      libs.setProp(_el$3, "flowChildren", "right");
      libs.insert(_el$3, libs.createComponent(libs.For, {
        get each() {
          return consumeList();
        },
        children: consume => {
          return (() => {
            const _el$4 = libs.createElement("Panel", {
                get ["class"]() {
                  return libs.classNames("ComsumeItem", {
                    Enough: consume.hasCount >= consume.needCount
                  });
                }
              }, null),
              _el$5 = libs.createElement("Label", {
                get text() {
                  return "X" + consume.needCount;
                }
              }, _el$4);
            libs.insert(_el$4, libs.createComponent(StoreItem.StoreItemImage, {
              get itemid() {
                return consume.itemID;
              }
            }), _el$5);
            libs.effect(_p$ => {
              const _v$ = libs.classNames("ComsumeItem", {
                  Enough: consume.hasCount >= consume.needCount
                }),
                _v$2 = "X" + consume.needCount;
              _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$4, "class", _v$, _p$._v$));
              _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$5, "text", _v$2, _p$._v$2));
              return _p$;
            }, {
              _v$: undefined,
              _v$2: undefined
            });
            return _el$4;
          })();
        }
      }));
      libs.insert(_el$2, libs.createComponent(EOM_Button.EOM_Button, {
        get enabled() {
          return libs.memo(() => !!canStrengthen())() && selectedEntry() != null;
        },
        color: "Confirm",
        text: "#Equipment_Refine",
        onactivate: () => {
          const entry = selectedEntry();
          if (!selectedItemID() || !entry) return;
          props.startForgeAnimation?.(() => new Promise(resolve => {
            CallActionRequest("/v1/equip/refine", {
              id: selectedItemID(),
              entry_type: entry.type,
              entry_index: entry.index
            }, () => resolve(), () => resolve());
          }));
        }
      }), null);
      return _el$;
    })());
  });
  return (() => {
    const _el$6 = libs.createElement("Panel", {
        id: "RefinePanel",
        get ["class"]() {
          return libs.classNames("RarityColor" + rarity());
        }
      }, null);
      libs.createElement("Label", {
        "class": "WindowTitle",
        text: "#EquipmentTab_refine"
      }, _el$6);
      const _el$8 = libs.createElement("Label", {
        "class": "EquipName EquipRarityLabel",
        get text() {
          return "#" + itemData()?.equipment_item_id;
        }
      }, _el$6),
      _el$9 = libs.createElement("Panel", {
        "class": "ToolTipIcon"
      }, _el$6),
      _el$0 = libs.createElement("Label", {
        id: "RemainingPotential",
        get vars() {
          return {
            value: itemData()?.remaining_potential ?? 0
          };
        },
        text: "#Equip_RemainingPotential"
      }, _el$6);
    libs.setProp(_el$9, "tooltip_text", "#EquipRefineTips");
    libs.insert(_el$6, libs.createComponent(equipment_comp.EquipSeparator, {
      id: "SelectSeparator",
      text: "#Equipment_SelectEntry"
    }), null);
    libs.insert(_el$6, libs.createComponent(equipment_comp.AttrContainer, {
      get children() {
        return [libs.createComponent(libs.For, {
          get each() {
            return itemData()?.main_entry_data ?? [];
          },
          children: (data, index) => {
            return libs.createComponent(equipment_comp.AttrItem, {
              attrData: data,
              type: "Main",
              get index() {
                return index();
              }
            });
          }
        }), libs.createComponent(libs.For, {
          get each() {
            return itemData()?.adverb_entry_data ?? [];
          },
          children: (data, index) => {
            const isSelected = () => selectedEntry()?.type === 2 && selectedEntry()?.index === index();
            return libs.createComponent(equipment_comp.AttrItem, {
              attrData: data,
              get selected() {
                return isSelected();
              },
              type: "Adverb",
              get index() {
                return index();
              },
              get changeValue() {
                return isSelected() ? "???" : undefined;
              },
              onAttrbuteClick: (type, idx) => {
                if (isSelected()) {
                  setSelectedEntry(null);
                } else {
                  setSelectedEntry({
                    index: idx,
                    type: 2
                  });
                }
              }
            });
          }
        }), libs.createComponent(libs.Index, {
          get each() {
            return itemData().myth_entry_data;
          },
          children: (data, mythIndex) => {
            const isSelected = () => selectedEntry()?.type === 4 && selectedEntry()?.index === mythIndex;
            const entryKv = KeyValues.equip_entry[data().id];
            return (() => {
              const _el$1 = libs.createElement("Panel", {
                  "class": "EntryContainer"
                }, null),
                _el$10 = libs.createElement("Panel", {
                  "class": "MythEntry"
                }, _el$1);
                libs.createElement("Image", {}, _el$10);
                const _el$12 = libs.createElement("Label", {
                  get text() {
                    return GetPrivilegeDesc(data().id, 1, {
                      value: data().value,
                      min: entryKv.value_min,
                      max: entryKv.value_max
                    });
                  },
                  html: true
                }, _el$10);
              libs.setProp(_el$1, "onactivate", () => {
                if (isSelected()) {
                  setSelectedEntry(null);
                } else {
                  setSelectedEntry({
                    index: mythIndex,
                    type: 4
                  });
                }
              });
              libs.insert(_el$1, libs.createComponent(equipment_comp.AttributeSelectBtn, {
                get selected() {
                  return isSelected();
                }
              }), _el$10);
              libs.effect(_$p => libs.setProp(_el$12, "text", GetPrivilegeDesc(data().id, 1, {
                value: data().value,
                min: entryKv.value_min,
                max: entryKv.value_max
              }), _$p));
              return _el$1;
            })();
          }
        }), libs.createComponent(libs.Index, {
          get each() {
            return itemData().chaos_entry_data;
          },
          children: (data, chaosIndex) => {
            const isSelected = () => selectedEntry()?.type === 5 && selectedEntry()?.index === chaosIndex;
            return (() => {
              const _el$13 = libs.createElement("Panel", {
                  "class": "EntryContainer"
                }, null),
                _el$14 = libs.createElement("Panel", {
                  "class": `ChaosEntry`
                }, _el$13);
                libs.createElement("Panel", {
                  id: "Point"
                }, _el$14);
                const _el$16 = libs.createElement("Label", {
                  id: "EntryText",
                  get text() {
                    return equipment_utils.GetChaosRowInfo(data());
                  },
                  html: true
                }, _el$14);
              libs.setProp(_el$13, "onactivate", () => {
                if (isSelected()) {
                  setSelectedEntry(null);
                } else {
                  setSelectedEntry({
                    index: chaosIndex,
                    type: 5
                  });
                }
              });
              libs.insert(_el$13, libs.createComponent(equipment_comp.AttributeSelectBtn, {
                get selected() {
                  return isSelected();
                }
              }), _el$14);
              libs.setProp(_el$14, "class", `ChaosEntry`);
              libs.effect(_$p => libs.setProp(_el$16, "text", equipment_utils.GetChaosRowInfo(data()), _$p));
              return _el$13;
            })();
          }
        })];
      }
    }), null);
    libs.effect(_p$ => {
      const _v$3 = libs.classNames("RarityColor" + rarity()),
        _v$4 = "#" + itemData()?.equipment_item_id,
        _v$5 = {
          value: itemData()?.remaining_potential ?? 0
        };
      _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$6, "class", _v$3, _p$._v$3));
      _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$8, "text", _v$4, _p$._v$4));
      _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$0, "vars", _v$5, _p$._v$5));
      return _p$;
    }, {
      _v$3: undefined,
      _v$4: undefined,
      _v$5: undefined
    });
    return _el$6;
  })();
};

function findGemLevelKv(rarity, level) {
  return Object.values(KeyValues.gem_level).find(row => row.rarity === rarity && row.level === level);
}
const GemLevelvpWindow = props => {
  const store = equipment_comp.useEquipmentStore();
  const [, setShowTokens] = store.showTokens;
  const gemData = libs.createMemo(() => {
    if (props.gemData && props.gemData() != "undefined") {
      return props.gemData();
    } else {
      return undefined;
    }
  });
  const rarity = () => gemData()?.rarity ?? 0;
  const lv = () => gemData()?.level ?? 0;
  const MAX_LV = libs.createMemo(() => {
    const r = rarity();
    const maxLv = Object.values(KeyValues.gem_level).filter(row => row.rarity === r).reduce((max, row) => Math.max(max, row.level), 0);
    return maxLv;
  });
  const bMax = () => lv() >= MAX_LV();
  const currentLvKv = () => findGemLevelKv(rarity(), lv());
  const nextLVKv = () => {
    if (bMax()) {
      return;
    }
    return findGemLevelKv(rarity(), lv() + 1);
  };
  const consumeList = libs.createMemo(() => {
    const kv = currentLvKv();
    if (!kv || kv.consume == undefined) {
      return [];
    }
    return kv.consume.split("|").map(item => {
      let [itemID, num] = item.split(":");
      return {
        itemID,
        needCount: Number(num),
        hasCount: GetServiceItemCount(itemID)
      };
    }).filter(d => d.needCount > 0);
  });
  libs.createEffect(() => {
    const tokens = consumeList().map(d => toFiniteNumber(d.itemID));
    setShowTokens(tokens);
  });
  const canStrengthen = libs.createMemo(() => consumeList().every(consume => consume.hasCount >= consume.needCount));
  libs.createEffect(() => {
    props.setLeftExtraContent?.((() => {
      const _el$ = libs.createElement("Panel", {
          id: "OperationBtns"
        }, null),
        _el$2 = libs.createElement("Panel", {
          id: "ConsumeBtn",
          flowChildren: "down"
        }, _el$),
        _el$3 = libs.createElement("Panel", {
          horizontalAlign: "center",
          flowChildren: "right"
        }, _el$2);
      libs.insert(_el$, libs.createComponent(EOM_Button.EOM_Button, {
        id: "ReturnBtn",
        text: "#MenuButton_Return",
        onactivate: () => props.onReturn?.()
      }), _el$2);
      libs.setProp(_el$2, "flowChildren", "down");
      libs.setProp(_el$3, "horizontalAlign", "center");
      libs.setProp(_el$3, "flowChildren", "right");
      libs.insert(_el$3, libs.createComponent(libs.For, {
        get each() {
          return consumeList();
        },
        children: consume => {
          return (() => {
            const _el$4 = libs.createElement("Panel", {
                get ["class"]() {
                  return libs.classNames("ComsumeItem", {
                    Enough: consume.hasCount >= consume.needCount
                  });
                }
              }, null),
              _el$5 = libs.createElement("Label", {
                get text() {
                  return "X" + consume.needCount;
                }
              }, _el$4);
            libs.insert(_el$4, libs.createComponent(StoreItem.StoreItemImage, {
              get itemid() {
                return consume.itemID;
              }
            }), _el$5);
            libs.effect(_p$ => {
              const _v$ = libs.classNames("ComsumeItem", {
                  Enough: consume.hasCount >= consume.needCount
                }),
                _v$2 = "X" + consume.needCount;
              _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$4, "class", _v$, _p$._v$));
              _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$5, "text", _v$2, _p$._v$2));
              return _p$;
            }, {
              _v$: undefined,
              _v$2: undefined
            });
            return _el$4;
          })();
        }
      }));
      libs.insert(_el$2, libs.createComponent(EOM_Button.EOM_Button, {
        get enabled() {
          return libs.memo(() => !!!bMax())() && canStrengthen();
        },
        color: "Confirm",
        get text() {
          return bMax() ? "#Equipment_MaxLv" : "#Equipment_LevelUP";
        },
        onactivate: () => {
          const gem = gemData();
          if (!gem) return;
          props.startForgeAnimation?.(() => new Promise(resolve => {
            CallActionRequest("/v1/gem/levelup", {
              gem_id: gem.id,
              level: 1
            }, () => resolve(), () => resolve());
          }));
        }
      }), null);
      libs.effect(_$p => libs.setProp(_el$3, "visible", !bMax(), _$p));
      return _el$;
    })());
  });
  return (() => {
    const _el$6 = libs.createElement("Panel", {
        id: "GemLevelupPanel",
        get ["class"]() {
          return libs.classNames({
            IsMax: bMax()
          }, "RarityColor" + rarity());
        }
      }, null);
      libs.createElement("Label", {
        "class": "WindowTitle",
        text: "#Equipment_GemLevelUP"
      }, _el$6);
      const _el$8 = libs.createElement("Label", {
        "class": "EquipName EquipRarityLabel",
        get text() {
          return "#" + gemData()?.gem_item_id;
        }
      }, _el$6),
      _el$9 = libs.createElement("Panel", {
        "class": "ToolTipIcon"
      }, _el$6);
      libs.createElement("Label", {
        "class": "MaxLvLabel",
        text: "#AlreadyMaxLv"
      }, _el$6);
    libs.setProp(_el$9, "tooltip_text", "#GemLevelUPTips");
    libs.insert(_el$6, libs.createComponent(libs.Show, {
      get when() {
        return !bMax();
      },
      get children() {
        const _el$1 = libs.createElement("Panel", {
            id: "ShowLv",
            hittest: false
          }, null),
          _el$10 = libs.createElement("Label", {
            id: "CurLv",
            get vars() {
              return {
                value: ToColor(String(lv()), "#EBD9B5")
              };
            },
            text: "#Equipment_LevelUPNum",
            html: true
          }, _el$1);
          libs.createElement("Image", {
            id: "Arrow"
          }, _el$1);
          const _el$12 = libs.createElement("Label", {
            id: "NextLv",
            get vars() {
              return {
                value: ToColor(String(lv() + 1), "#61C441")
              };
            },
            text: "#Equipment_LevelUPNum",
            html: true
          }, _el$1);
        libs.effect(_p$ => {
          const _v$3 = {
              value: ToColor(String(lv()), "#EBD9B5")
            },
            _v$4 = {
              value: ToColor(String(lv() + 1), "#61C441")
            };
          _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$10, "vars", _v$3, _p$._v$3));
          _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$12, "vars", _v$4, _p$._v$4));
          return _p$;
        }, {
          _v$3: undefined,
          _v$4: undefined
        });
        return _el$1;
      }
    }), null);
    libs.insert(_el$6, libs.createComponent(equipment_comp.EquipSeparator, {
      id: "LevelEffectSeparator",
      get text() {
        return bMax() ? "#CurrentLevelEffectPreview" : "#LevelEffectPreview";
      },
      hittest: false
    }), null);
    libs.insert(_el$6, libs.createComponent(equipment_comp.AttrContainer, {
      get children() {
        return [libs.createComponent(libs.For, {
          get each() {
            return gemData()?.main_entry_data ?? [];
          },
          children: (data, index) => {
            const {
              attrData,
              changeValue
            } = equipment_comp.calculateAttributeData(data, nextLVKv()?.main_mul ?? 0);
            return libs.createComponent(equipment_comp.AttrItem, {
              get index() {
                return index();
              },
              attrData: attrData,
              get changeValue() {
                return bMax() ? undefined : changeValue;
              },
              type: "Main"
            });
          }
        }), libs.createComponent(libs.For, {
          get each() {
            return gemData()?.adverb_entry_data ?? [];
          },
          children: (data, index) => libs.createComponent(equipment_comp.AttrItem, {
            get index() {
              return index();
            },
            attrData: data,
            type: "Adverb"
          })
        })];
      }
    }), null);
    libs.effect(_p$ => {
      const _v$5 = libs.classNames({
          IsMax: bMax()
        }, "RarityColor" + rarity()),
        _v$6 = "#" + gemData()?.gem_item_id;
      _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$6, "class", _v$5, _p$._v$5));
      _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$8, "text", _v$6, _p$._v$6));
      return _p$;
    }, {
      _v$5: undefined,
      _v$6: undefined
    });
    return _el$6;
  })();
};

const GemMakePreviewItem = props => (() => {
  const _el$ = libs.createElement("Panel", {
      get ["class"]() {
        return `AttrItem ${props.type}`;
      }
    }, null),
    _el$2 = libs.createElement("Panel", {
      verticalAlign: "center",
      flowChildren: "right"
    }, _el$);
    libs.createElement("Panel", {
      id: "Point"
    }, _el$2);
    const _el$4 = libs.createElement("Label", {
      id: "AttributeName",
      get text() {
        return props.name;
      },
      html: true
    }, _el$2),
    _el$5 = libs.createElement("Label", {
      id: "AttributeValue",
      get text() {
        return props.value;
      }
    }, _el$);
  libs.setProp(_el$2, "verticalAlign", "center");
  libs.setProp(_el$2, "style", {
    overflow: "noclip"
  });
  libs.setProp(_el$2, "flowChildren", "right");
  libs.effect(_p$ => {
    const _v$ = `AttrItem ${props.type}`,
      _v$2 = props.name,
      _v$3 = props.value;
    _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$, "class", _v$, _p$._v$));
    _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$4, "text", _v$2, _p$._v$2));
    _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$5, "text", _v$3, _p$._v$3));
    return _p$;
  }, {
    _v$: undefined,
    _v$2: undefined,
    _v$3: undefined
  });
  return _el$;
})();
const GemMakeWindow = props => {
  const store = equipment_comp.useEquipmentStore();
  const [, setShowTokens] = store.showTokens;
  const gemData = libs.createMemo(() => {
    if (props.gemData && props.gemData() != "undefined") {
      return props.gemData();
    } else {
      return undefined;
    }
  });
  const [selectedMainIndex, setSelectedMainIndex] = libs.createSignal(-1);
  const [selectedAdverbIndex, setSelectedAdverbIndex] = libs.createSignal(-1);
  const dropdownMainEntry = libs.createMemo(() => {
    const rarity = gemData()?.rarity;
    if (!rarity) return [];
    return Object.values(KeyValues.gem_entry_main).filter(entry => entry.rarity === rarity);
  });
  const dropdownAdverbEntry = libs.createMemo(() => {
    const rarity = gemData()?.rarity;
    if (!rarity) return [];
    return Object.values(KeyValues.gem_entry_sub).filter(entry => entry.rarity === rarity);
  });
  const selectedMainEntry = libs.createMemo(() => dropdownMainEntry()[selectedMainIndex()]);
  const selectedAdverbEntry = libs.createMemo(() => dropdownAdverbEntry()[selectedAdverbIndex()]);
  const getEntryName = (entry, placeholder) => {
    if (!entry) return GetLocalization(placeholder);
    return entry.entry_id.startsWith("privilege_") ? GetPrivilegeDesc(entry.entry_id, 1, {}).replace(/%value%%?/g, "") : GetLocalization("#property_" + entry.entry_id).replace("%", "");
  };
  const getEntryRange = entry => entry ? `${entry.min}~${entry.max}%` : "??%";
  const consumeList = libs.createMemo(() => {
    const rarity = gemData()?.rarity;
    if (!rarity) return [];
    const configKey = `gem_make_${rarity}`;
    const configValue = KeyValues.gem_setting?.[configKey]?.value;
    if (!configValue) return [];
    return configValue.split("|").map(item => {
      const [itemID, num] = item.split(":");
      return {
        itemID,
        needCount: Number(num),
        hasCount: GetServiceItemCount(itemID)
      };
    }).filter(d => d.needCount > 0);
  });
  libs.createEffect(() => {
    const tokens = consumeList().map(d => ({
      itemID: toFiniteNumber(d.itemID),
      value: d.hasCount
    }));
    setShowTokens(tokens);
  });
  const canMake = libs.createMemo(() => {
    const mainSelected = selectedMainIndex() >= 0;
    const adverbSelected = selectedAdverbIndex() >= 0;
    const hasMaterials = consumeList().every(c => c.hasCount >= c.needCount);
    return mainSelected && adverbSelected && hasMaterials;
  });
  libs.createEffect(() => {
    props.setLeftExtraContent?.((() => {
      const _el$6 = libs.createElement("Panel", {
          id: "OperationBtns"
        }, null),
        _el$7 = libs.createElement("Panel", {
          id: "ConsumeBtn",
          flowChildren: "down"
        }, _el$6),
        _el$8 = libs.createElement("Panel", {
          horizontalAlign: "center",
          flowChildren: "right"
        }, _el$7);
      libs.insert(_el$6, libs.createComponent(EOM_Button.EOM_Button, {
        id: "ReturnBtn",
        text: "#MenuButton_Return",
        onactivate: () => props.onReturn?.()
      }), _el$7);
      libs.setProp(_el$7, "flowChildren", "down");
      libs.setProp(_el$8, "horizontalAlign", "center");
      libs.setProp(_el$8, "flowChildren", "right");
      libs.insert(_el$8, libs.createComponent(libs.For, {
        get each() {
          return consumeList();
        },
        children: consume => {
          return (() => {
            const _el$9 = libs.createElement("Panel", {
                get ["class"]() {
                  return libs.classNames("ComsumeItem", {
                    Enough: consume.hasCount >= consume.needCount
                  });
                }
              }, null),
              _el$0 = libs.createElement("Label", {
                get text() {
                  return "X" + consume.needCount;
                }
              }, _el$9);
            libs.insert(_el$9, libs.createComponent(StoreItem.StoreItemImage, {
              get itemid() {
                return consume.itemID;
              }
            }), _el$0);
            libs.effect(_p$ => {
              const _v$4 = libs.classNames("ComsumeItem", {
                  Enough: consume.hasCount >= consume.needCount
                }),
                _v$5 = "X" + consume.needCount;
              _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$9, "class", _v$4, _p$._v$4));
              _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$0, "text", _v$5, _p$._v$5));
              return _p$;
            }, {
              _v$4: undefined,
              _v$5: undefined
            });
            return _el$9;
          })();
        }
      }));
      libs.insert(_el$7, libs.createComponent(EOM_Button.EOM_Button, {
        get enabled() {
          return canMake();
        },
        color: "Confirm",
        text: "#Equipment_GemMake",
        onactivate: () => {
          const gem = gemData();
          if (!gem) return;
          props.startForgeAnimation?.(() => new Promise(resolve => {
            CallActionRequest("/v1/gem/make", {
              gem_id: gem.id,
              target_gem_item_id: dropdownMainEntry()[selectedMainIndex()].id,
              adverb_entry_id: dropdownAdverbEntry()[selectedAdverbIndex()].entry_id
            }, () => resolve(), () => resolve());
          }));
        }
      }), null);
      return _el$6;
    })());
  });
  return (() => {
    const _el$1 = libs.createElement("Panel", {
        id: "GemMakePanel"
      }, null);
      libs.createElement("Label", {
        "class": "WindowTitle",
        text: "#Equipment_GemMake"
      }, _el$1);
      const _el$11 = libs.createElement("Label", {
        "class": "EquipName EquipRarityLabel",
        get text() {
          return "#" + gemData()?.gem_item_id;
        }
      }, _el$1),
      _el$12 = libs.createElement("Panel", {
        "class": "ToolTipIcon"
      }, _el$1);
    libs.setProp(_el$12, "tooltip_text", "#GemMakeTips");
    libs.insert(_el$1, libs.createComponent(equipment_comp.EquipSeparator, {
      id: "SelectEntry",
      text: "#Equipment_EntrySelection",
      hittest: false
    }), null);
    libs.insert(_el$1, libs.createComponent(EOM_DropDown.EOM_DropDown, {
      id: "MainEntrySelector",
      type: "EquipmentDropDown",
      index: -1,
      placeholder: "#Equipment_SelectMainEntry",
      onChange: index => setSelectedMainIndex(index),
      get children() {
        return libs.createComponent(libs.For, {
          get each() {
            return dropdownMainEntry();
          },
          children: entry => (() => {
            const _el$13 = libs.createElement("Label", {
              get text() {
                return libs.memo(() => !!entry.entry_id.startsWith("privilege_"))() ? GetPrivilegeDesc(entry.entry_id, 1, {}).replace(/%value%%?/g, "") : GetLocalization("#property_" + entry.entry_id).replace("%", "");
              },
              html: true
            }, null);
            libs.setProp(_el$13, "style", {
              marginLeft: "24px"
            });
            libs.effect(_$p => libs.setProp(_el$13, "text", libs.memo(() => !!entry.entry_id.startsWith("privilege_"))() ? GetPrivilegeDesc(entry.entry_id, 1, {}).replace(/%value%%?/g, "") : GetLocalization("#property_" + entry.entry_id).replace("%", ""), _$p));
            return _el$13;
          })()
        });
      }
    }), null);
    libs.insert(_el$1, libs.createComponent(EOM_DropDown.EOM_DropDown, {
      id: "AdverbEntrySelector",
      type: "EquipmentDropDown",
      placeholder: "#Equipment_SelectSubEntry",
      index: -1,
      onChange: index => setSelectedAdverbIndex(index),
      get children() {
        return libs.createComponent(libs.For, {
          get each() {
            return dropdownAdverbEntry();
          },
          children: entry => (() => {
            const _el$14 = libs.createElement("Label", {
              get text() {
                return libs.memo(() => !!entry.entry_id.startsWith("privilege_"))() ? GetPrivilegeDesc(entry.entry_id, 1, {}).replace(/%value%%?/g, "") : GetLocalization("#property_" + entry.entry_id).replace("%", "");
              },
              html: true
            }, null);
            libs.setProp(_el$14, "style", {
              marginLeft: "24px"
            });
            libs.effect(_$p => libs.setProp(_el$14, "text", libs.memo(() => !!entry.entry_id.startsWith("privilege_"))() ? GetPrivilegeDesc(entry.entry_id, 1, {}).replace(/%value%%?/g, "") : GetLocalization("#property_" + entry.entry_id).replace("%", ""), _$p));
            return _el$14;
          })()
        });
      }
    }), null);
    libs.insert(_el$1, libs.createComponent(equipment_comp.EquipSeparator, {
      id: "AttrPrev",
      text: "#Equipment_AttrPreview",
      hittest: false
    }), null);
    libs.insert(_el$1, libs.createComponent(equipment_comp.AttrContainer, {
      get children() {
        return [libs.createComponent(GemMakePreviewItem, {
          type: "Main",
          get name() {
            return getEntryName(selectedMainEntry(), "#Equipment_SelectMainEntry");
          },
          get value() {
            return getEntryRange(selectedMainEntry());
          }
        }), libs.createComponent(GemMakePreviewItem, {
          type: "Adverb",
          get name() {
            return getEntryName(selectedAdverbEntry(), "#Equipment_SelectSubEntry");
          },
          get value() {
            return getEntryRange(selectedAdverbEntry());
          }
        }), libs.createComponent(GemMakePreviewItem, {
          type: "Adverb",
          get name() {
            return GetLocalization("#Equipment_GemMake_RandomEntry");
          },
          value: "??%"
        }), libs.createComponent(GemMakePreviewItem, {
          type: "Adverb",
          get name() {
            return GetLocalization("#Equipment_GemMake_RandomEntry");
          },
          value: "??%"
        })];
      }
    }), null);
    libs.effect(_$p => libs.setProp(_el$11, "text", "#" + gemData()?.gem_item_id, _$p));
    return _el$1;
  })();
};

const MENU_LIST = {
  EquipmentTab_equip: [],
  EquipmentTab_part_levelup: [],
  EquipmentTab_forge2: [],
  EquipmentTab_break: [],
  EquipmentTab_key: [],
  EquipmentTab_drawing: ["EquipmentTab_drawing_make", "EquipmentTab_drawing_recast"]
};
const SHOW_ITEM_LIST_MENU = {
  "EquipmentTab_equip": true,
  "EquipmentTab_classup": true,
  "EquipmentTab_forge": true,
  "EquipmentTab_break": true,
  "EquipmentTab_forge2": true
};
const SHOW_EQUIPED_MENU = {
  "EquipmentTab_equip": true
};
function setDragPanelOffset(dragCallbacks, dragPanel) {
  const position = GameUI.GetCursorPosition();
  if (dragCallbacks.offsetX == undefined || dragCallbacks.offsetY == undefined) {
    dragCallbacks.offsetX = dragPanel.GetPositionWithinWindow().x - position[0];
    dragCallbacks.offsetY = dragPanel.GetPositionWithinWindow().y - position[1];
  }
}
const EQUIP_PART_ICON = {
  0: "icon_zb_01.png",
  1: "icon_zb_03.png",
  2: "icon_zb_08.png",
  3: "icon_zb_09.png",
  4: "icon_zb_07.png",
  5: "icon_zb_06.png",
  6: "icon_zb_05.png",
  7: "icon_zb_04.png",
  8: "icon_zb_02.png"
};
const GEM_RARITY_ICON = {
  5: "icon_zb_10.png",
  6: "icon_zb_11.png"
};
const GEM_MAIN_ENTRY_IDS = [...new Set(Object.values(KeyValues.gem_entry_main).map(entry => entry.entry_id))];
const GEM_SUB_ENTRY_IDS = [...new Set(Object.values(KeyValues.gem_entry_sub).map(entry => entry.entry_id))];
const GEM_SUB_ENTRY_FILTER_MODES = ["default", "include", "exclude"];
CustomUIConfig.EntryRatio ??= {};
for (let k in KeyValues.gem_entry_sub) {
  const id = KeyValues.gem_entry_sub[k].entry_id;
  CustomUIConfig.EntryRatio[id] = KeyValues.gem_entry_sub[k].ratio;
}
for (let k in KeyValues.gem_entry_main) {
  const id = KeyValues.gem_entry_main[k].entry_id;
  CustomUIConfig.EntryRatio[id] = KeyValues.gem_entry_main[k].ratio;
}
for (let id in KeyValues.equip_entry) {
  CustomUIConfig.EntryRatio[id] = KeyValues.equip_entry[id].ratio;
}
const classSetting = Object.values(KeyValues.equip_class_setting);
const NEEDLV_LIST = [];
const CLASS_LIST = [];
for (let i = 0; i < classSetting.length; i++) {
  let d = classSetting[i];
  NEEDLV_LIST.push(d.need_level);
  CLASS_LIST.push(d.equip_class);
}
const equipPunchMap = {};
for (const row of Object.values(KeyValues.equip_punch)) {
  if (!equipPunchMap[row.class]) {
    equipPunchMap[row.class] = {};
  }
  equipPunchMap[row.class][row.rarity] = row;
}
function canEquipPunch(equipClass, rarity) {
  return getEquipPunchConfig(equipClass, rarity) != undefined;
}
function getEquipPunchConfig(equipClass, rarity) {
  return equipPunchMap[equipClass]?.[rarity];
}
function getRarityUpgradeMax(equipClass) {
  return KeyValues.equip_class_setting[equipClass]?.rarity_upgrade_max;
}
function canEquipRarityUp(data) {
  const raritySetting = KeyValues.equip_rarity_setting[data.rarity];
  const maxRarity = getRarityUpgradeMax(data.class);
  return data.remaining_potential > 0 && raritySetting?.rarity_upgrade == 1 && maxRarity != undefined && data.rarity < maxRarity;
}
function getRarityUpgradeRange(equipClass) {
  const maxRarity = getRarityUpgradeMax(equipClass);
  const range = findRarityRangeByFlag("rarity_upgrade");
  if (!range || maxRarity == undefined) return range;
  const max = Math.min(range.max, maxRarity - 1);
  if (max < range.min) return undefined;
  return {
    min: range.min,
    max
  };
}
const isEquipMeetCondition = (data, tabName) => {
  if (data.in_check && data.in_check !== "") {
    return tabName === "Recast";
  }
  const equipClass = data.class;
  const equipRarity = data.rarity;
  if (tabName == "ClassUP") {
    const classSetting = KeyValues.equip_class_setting[equipClass];
    if (!classSetting) return false;
    return !(data.level < 50 && classSetting.ischange != 1);
  } else if (tabName == "RarityUP") {
    return canEquipRarityUp(data);
  } else if (tabName == "Recast") {
    const raritySetting = KeyValues.equip_rarity_setting[equipRarity];
    if (!raritySetting) return false;
    return data.remaining_potential > 0 && raritySetting.entry_recast == 1;
  } else if (tabName == "Refine") {
    const raritySetting = KeyValues.equip_rarity_setting[equipRarity];
    if (!raritySetting) return false;
    return data.remaining_potential > 0 && raritySetting.entry_refine == 1;
  } else if (tabName == "Inlay") {
    return canEquipPunch(data.class, data.rarity);
  }
  return true;
};
const isGemMeetCondition = (data, tabName) => {
  if (tabName == "GemLevelUP") {
    const rows = Object.values(KeyValues.gem_level).filter(row => row.rarity === data.rarity);
    if (rows.length === 0) return false;
    const maxLevel = rows.reduce((max, row) => Math.max(max, row.level), 0);
    return data.level < maxLevel;
  } else if (tabName == "GemMake") {
    return data.level === 0;
  }
  return true;
};
function findRarityRangeByFlag(flag) {
  const settings = KeyValues.equip_rarity_setting;
  if (!settings) return undefined;
  let min;
  let max;
  for (let r = 1; r <= 7; r++) {
    const row = settings[r];
    if (row && row[flag] == 1) {
      if (min == null) min = r;
      max = r;
    }
  }
  if (min == null || max == null) return undefined;
  return {
    min,
    max
  };
}
function getRarityRangeText(range) {
  if (!range) return undefined;
  const minName = GetLocalization("#Equipment_Rarity_" + range.min);
  const maxName = GetLocalization("#Equipment_Rarity_" + range.max);
  return range.min === range.max ? minName : `${minName}-${maxName}`;
}
const getEquipDisableReasons = (data, tabName) => {
  if (data.in_check && data.in_check !== "") {
    if (tabName !== "Recast") {
      return [{
        key: "#Equipment_TextTips_InCheck"
      }];
    }
  }
  if (tabName == "ClassUP") {
    const classSetting = KeyValues.equip_class_setting[data.class];
    if (!classSetting) return [{
      key: "#Equipment_TextTips_ClassUP_NotSupport"
    }];
    if (data.level < 50 && classSetting.ischange != 1) return [{
      key: "#Equipment_TextTips_ClassUP_LevelNotEnough",
      vars: {
        value: 50
      }
    }];
    return [];
  } else if (tabName == "RarityUP") {
    const reasons = [];
    if (!canEquipRarityUp(data) && data.remaining_potential > 0) {
      const rarityText = getRarityRangeText(getRarityUpgradeRange(data.class));
      reasons.push({
        key: "#Equipment_TextTips_RarityUP_RarityNotSupport",
        vars: rarityText ? {
          rarity: rarityText
        } : undefined
      });
    }
    if (data.remaining_potential <= 0) {
      reasons.push({
        key: "#Equipment_TextTips_NoPotential"
      });
    }
    return reasons;
  } else if (tabName == "Recast") {
    const reasons = [];
    const raritySetting = KeyValues.equip_rarity_setting[data.rarity];
    if (!raritySetting || raritySetting.entry_recast != 1) {
      const rarityText = getRarityRangeText(findRarityRangeByFlag("entry_recast"));
      reasons.push({
        key: "#Equipment_TextTips_Recast_RarityNotSupport",
        vars: rarityText ? {
          rarity: rarityText
        } : undefined
      });
    }
    if (data.remaining_potential <= 0) {
      reasons.push({
        key: "#Equipment_TextTips_NoPotential"
      });
    }
    return reasons;
  } else if (tabName == "Refine") {
    const reasons = [];
    const raritySetting = KeyValues.equip_rarity_setting[data.rarity];
    if (!raritySetting || raritySetting.entry_refine != 1) {
      const rarityText = getRarityRangeText(findRarityRangeByFlag("entry_refine"));
      reasons.push({
        key: "#Equipment_TextTips_Refine_RarityNotSupport",
        vars: rarityText ? {
          rarity: rarityText
        } : undefined
      });
    }
    if (data.remaining_potential <= 0) {
      reasons.push({
        key: "#Equipment_TextTips_NoPotential"
      });
    }
    return reasons;
  } else if (tabName == "Inlay") {
    if (!canEquipPunch(data.class, data.rarity)) {
      const reasons = [];
      const allClasses = Object.keys(equipPunchMap).map(Number);
      const allRarities = allClasses.flatMap(c => Object.keys(equipPunchMap[c]).map(Number));
      const minClass = allClasses.length > 0 ? Math.min(...allClasses) : undefined;
      const rarityRange = allRarities.length > 0 ? {
        min: Math.min(...allRarities),
        max: Math.max(...allRarities)
      } : undefined;
      if (minClass != null && data.class < minClass) {
        reasons.push({
          key: "#Equipment_TextTips_Inlay_ClassRequire",
          vars: {
            value: minClass
          }
        });
      }
      if (rarityRange && data.rarity < rarityRange.min) {
        const rarityText = getRarityRangeText(rarityRange);
        reasons.push({
          key: "#Equipment_TextTips_Inlay_RarityNotSupport",
          vars: rarityText ? {
            rarity: rarityText
          } : undefined
        });
      }
      if (reasons.length === 0) {
        reasons.push({
          key: "#Equipment_TextTips_Inlay_NotSupport"
        });
      }
      return reasons;
    }
    return [];
  }
  return [];
};
const getGemDisableReasons = (data, tabName) => {
  if (tabName == "GemLevelUP") {
    const rows = Object.values(KeyValues.gem_level).filter(row => row.rarity === data.rarity);
    if (rows.length === 0) return [{
      key: "#Equipment_TextTips_GemLevelUP_NoConfig"
    }];
    const maxLevel = rows.reduce((max, row) => Math.max(max, row.level), 0);
    if (data.level >= maxLevel) return [{
      key: "#Equipment_TextTips_GemLevelUP_MaxLevel"
    }];
    return [];
  } else if (tabName == "GemMake") {
    if (data.level !== 0) return [{
      key: "#Equipment_TextTips_GemMake_AlreadyEnhanced"
    }];
    return [];
  }
  return [];
};
const {
  LayoutMenu,
  show,
  secondTabName,
  menuName,
  jumpInfo
} = EOM_MenuLayout.createMenuLayout("equipment", () => MENU_LIST);
const [previewHeroName, setPreviewHeroName] = global_selection.createPreviewHeroNameSignal();
const selectHeroID = () => {
  const heroName = previewHeroName();
  return GetHeroIDByHeroName(heroName);
};
let selectEquipSuitID = () => 1;
let setSelectEquipSuitID = () => 1;
let selectedItemID = () => undefined;
let setSelectedItemID = () => undefined;
const selectedItemData = () => {
  const id = selectedItemID();
  if (!id) {
    return;
  }
  return player_equipments()[id];
};
let selectedSlot = () => undefined;
let setSelectedSlot = () => undefined;
let selectedItemTab = () => "equipment";
let setSelectedItemTab = () => "equipment";
let draggedSlot = () => undefined;
let setDraggedSlot = () => undefined;
let selectedItemList = () => [];
let setSelectedItemList = () => [];
let selectBreakSlot = () => -1;
let setSelectBreakSlot = () => -1;
let selectedGemList = () => [];
let setSelectedGemList = () => [];
let hiddenItemList = () => false;
let setItemListIsHidden = () => false;
let forgeChildTab = () => undefined;
let setForgeChildTab = () => undefined;
let lockItemTab = () => false;
let setLockItemTab = () => false;
let showFilter = () => false;
let setShowFilter = () => false;
let showTokens = () => [];
let setShowTokens = () => [];
let equipmentUnreadIds;
let gemUnreadIds;
let partFilter = () => 0;
let setPartFilter = () => 0;
let filterNeedLv = () => ({});
let setFilterNeedLv = () => ({});
let filterRarity = () => ({});
let setFilterRarity = () => ({});
let filterGemMainEntry = () => ({});
let setFilterGemMainEntry = () => ({});
let filterGemSubEntry = () => ({});
let setFilterGemSubEntry = () => ({});
let filteredGemIDs = () => undefined;
let setFilteredGemIDs = () => undefined;
let gemFilterRequesting = () => false;
let setGemFilterRequesting = () => false;
let filterClass = () => ({});
let setFilterClass = () => ({});
let filterSuit = () => ({});
let setFilterSuit = () => ({});
let filterMythText = () => "";
let setFilterMythText = () => "";
let resetFilter = () => 0;
let setResterFilter = () => 0;
const isItemTabLocked = tabName => false;
let player_heroes = () => ({});
let player_hero_equip_suit = () => ({});
let player_equipments = () => ({});
let player_gems = () => ({});
let equipmentCount = () => 0;
let gemCount = () => 0;
let player_props = () => ({});
let player_tokens = () => ({});
let equippedEquipment = () => undefined;
let playerAccountLevel = () => undefined;
function createEquipmentPageState() {
  [selectEquipSuitID, setSelectEquipSuitID] = libs.createSignal(1);
  [selectedItemID, setSelectedItemID] = libs.createSignal();
  [selectedSlot, setSelectedSlot] = libs.createSignal();
  [selectedItemTab, setSelectedItemTab] = libs.createSignal("equipment");
  [draggedSlot, setDraggedSlot] = libs.createSignal();
  [selectedItemList, setSelectedItemList] = libs.createSignal([]);
  [selectBreakSlot, setSelectBreakSlot] = libs.createSignal(-1);
  [selectedGemList, setSelectedGemList] = libs.createSignal([]);
  [hiddenItemList, setItemListIsHidden] = libs.createSignal(false);
  [forgeChildTab, setForgeChildTab] = libs.createSignal();
  [lockItemTab, setLockItemTab] = libs.createSignal(false);
  [showFilter, setShowFilter] = libs.createSignal(false);
  [showTokens, setShowTokens] = libs.createSignal([]);
  equipmentUnreadIds = solid_utils.createPlayerUnreadIds("equipment");
  gemUnreadIds = solid_utils.createPlayerUnreadIds("gem");
  [partFilter, setPartFilter] = libs.createSignal(0);
  [filterNeedLv, setFilterNeedLv] = libs.createSignal({});
  [filterRarity, setFilterRarity] = libs.createSignal({});
  [filterGemMainEntry, setFilterGemMainEntry] = libs.createSignal({});
  [filterGemSubEntry, setFilterGemSubEntry] = libs.createSignal({});
  [filteredGemIDs, setFilteredGemIDs] = libs.createSignal();
  [gemFilterRequesting, setGemFilterRequesting] = libs.createSignal(false);
  [filterClass, setFilterClass] = libs.createSignal({});
  [filterSuit, setFilterSuit] = libs.createSignal({});
  [filterMythText, setFilterMythText] = libs.createSignal("");
  [resetFilter, setResterFilter] = libs.createSignal(0);
  libs.createEffect(libs.on(menuName, () => {
    setSelectedItemList([]);
    setSelectedItemID();
    setSelectBreakSlot(-1);
    setSelectedGemList([]);
    setItemListIsHidden(false);
    setLockItemTab(false);
    setSelectedItemTab("equipment");
    setForgeChildTab();
    if (menuName() == "EquipmentTab_equip") {
      setShowTokens([]);
    }
  }));
  libs.createEffect(libs.on(jumpInfo, info => {
    const itemTab = info?.data?.itemTab;
    if (itemTab === "equipment" || itemTab === "gem") {
      setSelectedItemTab(itemTab);
    }
  }));
  libs.createEffect(libs.on(secondTabName, () => {
    setSelectedItemID();
  }));
  libs.createEffect(libs.on(selectedItemTab, () => {
    setPartFilter(0);
  }));
  player_heroes = solid_utils.createServiceNetData("player_heroes", {});
  player_hero_equip_suit = solid_utils.createServiceNetData("player_hero_equip_suits", {});
  player_equipments = equipment_utils.GetSimplifyEquipment();
  player_gems = equipment_utils.GetSimplifyGems();
  const playerCounters = solid_utils.createServiceNetData("player_counters", {});
  equipmentCount = libs.createMemo(() => playerCounters()?.equipment_count?.count ?? 0);
  gemCount = libs.createMemo(() => playerCounters()?.gem_count?.count ?? 0);
  solid_utils.createPlayerNetDataSignal("common", "hero_selection");
  player_props = solid_utils.createServiceNetData("player_props", {});
  player_tokens = solid_utils.createServiceNetData("player_tokens", {});
  equippedEquipment = libs.createMemo(() => player_hero_equip_suit()?.[selectHeroID()]?.[selectEquipSuitID()]);
  playerAccountLevel = service_netdata_helper.usePlayerAccountLevel("hero_level");
  libs.onCleanup(() => {
    equipmentUnreadIds.submitReadCache();
    gemUnreadIds.submitReadCache();
  });
}
function EquipmentProvider(props) {
  const store = {
    selectHeroID: selectHeroID,
    selectEquipSuitID: [selectEquipSuitID, setSelectEquipSuitID],
    selectedItemID: [selectedItemID, setSelectedItemID],
    selectedSlot: [selectedSlot, setSelectedSlot],
    selectedItemTab: [selectedItemTab, setSelectedItemTab],
    selectedItemList: [selectedItemList, setSelectedItemList],
    selectBreakSlot: [selectBreakSlot, setSelectBreakSlot],
    selectedGemList: [selectedGemList, setSelectedGemList],
    hiddenItemList: [hiddenItemList, setItemListIsHidden],
    lockItemTab: [lockItemTab, setLockItemTab],
    showTokens: [showTokens, setShowTokens],
    draggedSlot: [draggedSlot, setDraggedSlot],
    player_equipments,
    player_props,
    player_tokens
  };
  return libs.createComponent(equipment_comp.EquipmentContext.Provider, {
    value: store,
    get children() {
      return props.children;
    }
  });
}
function EquipmentContent() {
  libs.createEffect(() => {
    let heroId = selectHeroID();
    let heroData = player_heroes();
    libs.batch(() => {
      if (heroId) {
        setSelectEquipSuitID(heroData[heroId]?.equip_suit ?? 1);
      }
    });
  });
  let QueryEquipment = false;
  libs.createEffect(libs.on(show, show => {
    if (show) {
      if (QueryEquipment == false) {
        QueryEquipment = true;
        CallAction("/v1/equip/fetch_all", {
          only_equipped: false
        });
      }
    } else {
      equipmentUnreadIds.submitReadCache();
      gemUnreadIds.submitReadCache();
    }
  }));
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout, {
    id: "EquipmentRoot",
    name: "MenuButton_equipment",
    renderOnShow: true,
    get show() {
      return show();
    },
    get backgroundChildren() {
      return (() => {
        const _el$6 = libs.createElement("Panel", {
          id: "HudEquipBG",
          get ["class"]() {
            return menuName();
          }
        }, null);
        libs.setProp(_el$6, "onactivate", () => {
          if (menuName() == "EquipmentTab_equip") {
            libs.batch(() => {
              setSelectedSlot();
              setSelectedGemList([]);
              setSelectedItemID();
              setPartFilter(0);
              setForgeChildTab();
              setLockItemTab(false);
            });
          }
        });
        libs.effect(_$p => libs.setProp(_el$6, "class", menuName(), _$p));
        return _el$6;
      })();
    },
    get children() {
      return [libs.createComponent(LayoutMenu, {}), libs.createComponent(Player.CurrencyGroup, {
        currencyType: "top",
        get tokens() {
          return showTokens().map(token => typeof token === "number" ? token : token.itemID);
        },
        get values() {
          return showTokens().reduce((values, token) => {
            if (typeof token !== "number") values[token.itemID] = token.value;
            return values;
          }, {});
        }
      }), (() => {
        const _el$ = libs.createElement("Panel", {
            id: "ParticleRoot"
          }, null);
          libs.createElement("Image", {
            id: "SlotRootBG",
            hittest: false
          }, _el$);
          libs.createElement("DOTAParticleScenePanel", {
            id: "BGLight",
            particleName: "particles/ui/game/ui_game_general_special_effects_04_fx.vpcf",
            cameraOrigin: "0 0 700",
            fov: 90,
            lookAt: "0 0 0",
            hittest: false,
            squarePixels: true
          }, _el$);
        libs.effect(_$p => libs.setProp(_el$, "visible", menuName() == "EquipmentTab_equip", _$p));
        return _el$;
      })(), libs.createComponent(libs.Switch, {
        get children() {
          return [libs.createComponent(libs.Match, {
            get when() {
              return menuName() == "EquipmentTab_part_levelup";
            },
            get children() {
              return libs.createComponent(EquipmentPartLevelUp, {});
            }
          }), libs.createComponent(libs.Match, {
            get when() {
              return menuName() == "EquipmentTab_break";
            },
            get children() {
              return libs.createComponent(EquipBreak, {});
            }
          }), libs.createComponent(libs.Match, {
            get when() {
              return menuName() == "EquipmentTab_forge2";
            },
            get children() {
              return libs.createComponent(EquipForge, {});
            }
          }), libs.createComponent(libs.Match, {
            get when() {
              return menuName() == "EquipmentTab_key";
            },
            get children() {
              return libs.createComponent(EquipmentKey, {});
            }
          }), libs.createComponent(libs.Match, {
            get when() {
              return menuName() == "EquipmentTab_drawing";
            },
            get children() {
              return libs.createComponent(libs.Switch, {
                get children() {
                  return [libs.createComponent(libs.Match, {
                    get when() {
                      return secondTabName() == "EquipmentTab_drawing_recast";
                    },
                    get children() {
                      return libs.createComponent(EquipmentDrawingRecast, {});
                    }
                  }), libs.createComponent(libs.Match, {
                    get when() {
                      return secondTabName() == "EquipmentTab_drawing_make";
                    },
                    get children() {
                      return libs.createComponent(EquipmentDrawingMake, {});
                    }
                  })];
                }
              });
            }
          })];
        }
      }), (() => {
        const _el$4 = libs.createElement("Panel", {
            id: "MainBlockContainer",
            hittest: false
          }, null),
          _el$5 = libs.createElement("Panel", {
            id: "MainCenterBlock",
            hittest: false
          }, _el$4);
        libs.insert(_el$5, libs.createComponent(EquipSlot, {}), null);
        libs.insert(_el$5, libs.createComponent(ItemsRoot, {}), null);
        return _el$4;
      })()];
    }
  });
}
function HudEquipment() {
  return libs.createComponent(libs.Show, {
    get when() {
      return show();
    },
    get children() {
      return libs.createComponent(EquipmentPage, {});
    }
  });
}
function EquipmentPage() {
  createEquipmentPageState();
  return libs.createComponent(EquipmentProvider, {
    get children() {
      return libs.createComponent(EquipmentContent, {});
    }
  });
}
function EquipEquipment(equipID, heroID, suitID, part) {
  const equipData = player_equipments()[equipID];
  if (equipID != 0 && equipData == undefined) {
    return;
  }
  const heroLv = getServiceNetData("player_account_levels", Players.GetLocalPlayer())?.hero_level?.level ?? 1;
  if (equipData && equipData.need_level > heroLv) {
    ErrorMessage("#EquipEquipmentLvTips");
    return;
  }
  CallAction("/v1/hero/equip_equipment", {
    equipment_id: equipID,
    hero_id: heroID,
    suit_id: suitID,
    part: part
  });
}
const CURRENT_SUIT_OPTIONS = [{
  type: "current",
  suitID: 1
}, {
  type: "current",
  suitID: 2
}, {
  type: "current",
  suitID: 3
}];
function CopyHeroSuitEquipment(sourceHeroID, sourceSuitID, targetHeroID, targetSuitID) {
  const sourceSuit = player_hero_equip_suit()?.[sourceHeroID]?.[sourceSuitID];
  for (const part of equipment_utils.EQUIP_PARTS) {
    const equipID = sourceSuit?.[part] ?? 0;
    EquipEquipment(equipID, targetHeroID, targetSuitID, part);
  }
}
function LockEquipment(id, lock) {
  CallAction("/v1/equip/lock", {
    id: id,
    lock: lock
  });
}
function EquipSlot() {
  const showEquipSlot = () => {
    return SHOW_EQUIPED_MENU[menuName()];
  };
  const equipmentPartDatas = solid_utils.createServiceNetData("player_equipment_part_datas", {});
  const gameState = solid_utils.createNetDataSignal("common", "game_state", {
    state: "GameState_Prepare",
    start_time: -1,
    end_time: -1
  });
  const isBattleState = () => gameState().state === "GameState_Dungeon";
  const [suitDropDownData, setSuitDropDownData] = libs.createSignal({
    key: "",
    options: CURRENT_SUIT_OPTIONS
  });
  libs.createEffect(() => {
    const currentHeroID = selectHeroID();
    const heroes = player_heroes();
    const suitData = player_hero_equip_suit();
    const copyOptions = [];
    for (const [heroIDText, heroInfo] of Object.entries(heroes)) {
      const heroID = Number(heroIDText);
      if (!heroID || heroID === currentHeroID) {
        continue;
      }
      const suitList = suitData[heroID];
      if (!suitList) {
        continue;
      }
      const heroToken = GetHeroNameByHeroID(heroInfo?.hero_id ?? heroID);
      const heroName = heroToken ? GetLocalization("#" + heroToken) : String(heroID);
      for (const suitID of [1, 2, 3]) {
        const suit = suitList[suitID];
        if (!suit || !equipment_utils.EQUIP_PARTS.some(part => (suit[part] ?? 0) !== 0)) {
          continue;
        }
        copyOptions.push({
          type: "copy",
          heroID,
          suitID,
          label: `${heroName}|${GetLocalization("#EquipmentSuit")}${suitID}`
        });
      }
    }
    const key = `${currentHeroID}|${copyOptions.map(option => `${option.heroID}:${option.suitID}`).join(";")}`;
    if (key !== libs.untrack(() => suitDropDownData().key)) {
      setSuitDropDownData({
        key,
        options: [...CURRENT_SUIT_OPTIONS, ...copyOptions]
      });
    }
  });
  const [showOverviewAttr, setShowOverviewAttr] = libs.createSignal(false);
  const SlotItem = props => {
    const slotLevel = () => equipmentPartDatas()[props.part]?.level ?? 0;
    const equipID = () => {
      const heroID = selectHeroID();
      if (!heroID) return;
      const suit = player_hero_equip_suit()[heroID]?.[selectEquipSuitID()];
      if (!suit) return;
      const equipID = suit[props.part];
      if (equipID != 0) {
        return equipID;
      }
    };
    const equipData = () => {
      const id = equipID();
      if (!id) return;
      return player_equipments()[id];
    };
    return (() => {
      const _el$7 = libs.createElement("Panel", {
          get id() {
            return "EquipSlot_" + props.part;
          },
          get ["class"]() {
            return libs.classNames("EquipSlot", {
              "Selected": selectedSlot() == props.part,
              Shine: draggedSlot() == props.part
            });
          }
        }, null),
        _el$8 = libs.createElement("Panel", {
          "class": "SlotIcon"
        }, _el$7),
        _el$9 = libs.createElement("Panel", {
          "class": "SelectedBorder"
        }, _el$8),
        _el$0 = libs.createElement("Label", {
          "class": "SlotLevel",
          hittest: false,
          get text() {
            return LocalizeWithVars("#Equipment_PartLevel_SlotLevel", {
              level: slotLevel()
            });
          }
        }, _el$7);
      libs.setProp(_el$7, "onmouseover", p => {
        if (equipID()) {
          equipment_utils.ShowServerEquipTooltip(p, {
            id1: equipID(),
            hero_id: selectHeroID()
          });
        }
      });
      libs.setProp(_el$7, "onmouseout", p => HideCustomTooltip(p, "server_equip"));
      libs.setProp(_el$7, "oncontextmenu", () => {
        if (!equipData()) {
          return;
        }
        EquipEquipment(0, selectHeroID(), selectEquipSuitID(), props.part);
      });
      libs.setProp(_el$7, "onactivate", () => {
        setSelectedSlot(prev => prev === props.part ? undefined : props.part);
        setPartFilter(props.part);
      });
      libs.insert(_el$8, libs.createComponent(libs.Show, {
        get when() {
          return equipData();
        },
        get fallback() {
          return (() => {
            const _el$1 = libs.createElement("Image", {
              id: "EmptySlot",
              get src() {
                return getSrcPath(`conv/icon/${EQUIP_PART_ICON[props.part]}`);
              }
            }, null);
            libs.effect(_$p => libs.setProp(_el$1, "src", getSrcPath(`conv/icon/${EQUIP_PART_ICON[props.part]}`), _$p));
            return _el$1;
          })();
        },
        get children() {
          return libs.createComponent(server_equipment.Equipment, libs.mergeProps$1(() => equipData()));
        }
      }), _el$9);
      libs.effect(_p$ => {
        const _v$ = "EquipSlot_" + props.part,
          _v$2 = libs.classNames("EquipSlot", {
            "Selected": selectedSlot() == props.part,
            Shine: draggedSlot() == props.part
          }),
          _v$3 = LocalizeWithVars("#Equipment_PartLevel_SlotLevel", {
            level: slotLevel()
          });
        _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$7, "id", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$7, "class", _v$2, _p$._v$2));
        _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$0, "text", _v$3, _p$._v$3));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined,
        _v$3: undefined
      });
      return _el$7;
    })();
  };
  return (() => {
    const _el$10 = libs.createElement("Panel", {
        id: "EquipSlotRoot",
        get ["class"]() {
          return libs.classNames("RootWindow", {
            Hidden: !showEquipSlot()
          });
        },
        hittest: false
      }, null),
      _el$11 = libs.createElement("Panel", {
        id: "SlotContainer",
        hittest: false
      }, _el$10);
      libs.createElement("Image", {
        id: "SlotRootBG",
        hittest: false
      }, _el$11);
      const _el$13 = libs.createElement("Panel", {
        id: "Slots",
        get ["class"]() {
          return libs.classNames({
            Z: draggedSlot() != undefined
          });
        },
        get hittest() {
          return draggedSlot() == undefined;
        },
        get hittestchildren() {
          return draggedSlot() == undefined;
        }
      }, _el$11),
      _el$14 = libs.createElement("Panel", {
        flowChildren: "down"
      }, _el$13),
      _el$15 = libs.createElement("Panel", {
        horizontalAlign: "right",
        flowChildren: "down"
      }, _el$13),
      _el$18 = libs.createElement("Panel", {
        id: "BottomParticleRoot"
      }, _el$11);
      libs.createElement("DOTAParticleScenePanel", {
        id: "BottomParticle",
        particleName: "particles/ui/game/ui_game_general_special_effects_05_fx.vpcf",
        cameraOrigin: "0 0 800",
        fov: 90,
        lookAt: "0 0 0",
        hittest: false,
        squarePixels: true
      }, _el$18);
      const _el$20 = libs.createElement("Panel", {
        id: "EquipmentDropPanel"
      }, _el$11);
      libs.createElement("Label", {
        text: "#Hud_Equipment_Drag_Here"
      }, _el$20);
      const _el$22 = libs.createElement("Panel", {
        id: "AttributesSummaryContainer",
        get ["class"]() {
          return libs.classNames({
            Show: showOverviewAttr() && draggedSlot() == undefined
          });
        }
      }, _el$11);
    libs.insert(_el$10, libs.createComponent(solid_utils.DynamicKey, {
      key: () => suitDropDownData().key,
      children: () => libs.createComponent(EOM_DropDown.EOM_DropDown, {
        id: "SuitDropDown",
        type: "EquipmentDropDown",
        menuPosition: "bottom",
        get index() {
          return selectEquipSuitID() - 1;
        },
        onSelect: index => {
          const option = suitDropDownData().options[index];
          if (option?.type !== "copy") {
            return true;
          }
          const heroID = selectHeroID();
          if (!heroID) {
            return false;
          }
          CopyHeroSuitEquipment(option.heroID, option.suitID, heroID, selectEquipSuitID());
          return false;
        },
        onChange: (index, item) => {
          const option = suitDropDownData().options[index];
          if (option?.type !== "current") {
            return;
          }
          const suitID = option.suitID;
          const heroID = selectHeroID();
          setSelectEquipSuitID(suitID);
          if (heroID) {
            CallAction("/v1/hero/change_equip_suit", {
              hero_id: heroID,
              suit_id: suitID
            });
          }
        },
        get children() {
          return libs.createComponent(libs.For, {
            get each() {
              return suitDropDownData().options;
            },
            children: option => {
              if (option.type === "current") {
                return (() => {
                  const _el$23 = libs.createElement("Label", {
                    get vars() {
                      return {
                        value: option.suitID
                      };
                    },
                    text: "#EquipmentSuitType"
                  }, null);
                  libs.effect(_$p => libs.setProp(_el$23, "vars", {
                    value: option.suitID
                  }, _$p));
                  return _el$23;
                })();
              }
              return (() => {
                const _el$24 = libs.createElement("Label", {
                  get text() {
                    return option.label;
                  }
                }, null);
                libs.effect(_$p => libs.setProp(_el$24, "text", option.label, _$p));
                return _el$24;
              })();
            }
          });
        }
      })
    }), _el$11);
    libs.insert(_el$10, libs.createComponent(EOM_Button.EOM_BaseButton, {
      id: "OverviewAttributeBtn",
      get ["class"]() {
        return libs.classNames({
          ShowBtnBorder: showOverviewAttr()
        });
      },
      onactivate: () => {
        setShowOverviewAttr(prev => !prev);
      }
    }), _el$11);
    libs.setProp(_el$14, "flowChildren", "down");
    libs.insert(_el$14, libs.createComponent(libs.For, {
      each: [1, 7, 5, 3],
      children: part => {
        return libs.createComponent(SlotItem, {
          part: part
        });
      }
    }));
    libs.setProp(_el$15, "horizontalAlign", "right");
    libs.setProp(_el$15, "flowChildren", "down");
    libs.insert(_el$15, libs.createComponent(libs.For, {
      each: [2, 8, 6, 4],
      children: part => {
        return libs.createComponent(SlotItem, {
          part: part
        });
      }
    }));
    libs.insert(_el$11, libs.createComponent(libs.Show, {
      get when() {
        return isBattleState();
      },
      get children() {
        const _el$16 = libs.createElement("Panel", {
            id: "BattleTips"
          }, null);
          libs.createElement("Label", {
            text: "#Equipment_BattleTips"
          }, _el$16);
        return _el$16;
      }
    }), _el$18);
    libs.insert(_el$11, libs.createComponent(solid_utils.DynamicKey, {
      key: previewHeroName,
      children: hero => libs.createComponent(portraitsFullBodyLoadout.PortraitsFullBodyLoadout, {
        id: "FullBodyPreview",
        unit: hero,
        hittest: false,
        hittestchildren: false
      })
    }), _el$18);
    libs.insert(_el$11, libs.createComponent(hero_selection_bar.HeroSelectionBar, {
      get selecteHeroName() {
        return previewHeroName();
      },
      onchange: (heroName, heroID) => {
        setPreviewHeroName(heroName);
      }
    }), _el$20);
    libs.setProp(_el$20, "onDragEnter", (pPanel, draggedPanel) => {
      if (LoadData(draggedPanel, "equip")) {
        pPanel.AddClass("potential_drop_target");
      }
    });
    libs.setProp(_el$20, "onDragLeave", (pPanel, draggedPanel) => {
      pPanel.RemoveClass("potential_drop_target");
    });
    libs.setProp(_el$20, "onDragDrop", (panel, draggedPanel) => {
      if (!selectHeroID()) return;
      let equip = LoadData(draggedPanel, "equip");
      if (!equip || draggedSlot() == undefined) return;
      EquipEquipment(equip, selectHeroID(), selectEquipSuitID(), draggedSlot());
    });
    libs.insert(_el$11, libs.createComponent(hero_level_main.HeroLevelMain, {
      get level() {
        return playerAccountLevel().level;
      },
      get extraExp() {
        return playerAccountLevel().extra_exp;
      },
      get title() {
        return "#" + previewHeroName();
      },
      tooltip: "#Equipment_TextTips_HeroLv"
    }), _el$22);
    libs.insert(_el$22, libs.createComponent(AttributesSummary, {}));
    libs.effect(_p$ => {
      const _v$4 = libs.classNames("RootWindow", {
          Hidden: !showEquipSlot()
        }),
        _v$5 = libs.classNames({
          Z: draggedSlot() != undefined
        }),
        _v$6 = draggedSlot() == undefined,
        _v$7 = draggedSlot() == undefined,
        _v$8 = draggedSlot() != undefined,
        _v$9 = libs.classNames({
          Show: showOverviewAttr() && draggedSlot() == undefined
        });
      _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$10, "class", _v$4, _p$._v$4));
      _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$13, "class", _v$5, _p$._v$5));
      _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$13, "hittest", _v$6, _p$._v$6));
      _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$13, "hittestchildren", _v$7, _p$._v$7));
      _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$20, "visible", _v$8, _p$._v$8));
      _v$9 !== _p$._v$9 && (_p$._v$9 = libs.setProp(_el$22, "class", _v$9, _p$._v$9));
      return _p$;
    }, {
      _v$4: undefined,
      _v$5: undefined,
      _v$6: undefined,
      _v$7: undefined,
      _v$8: undefined,
      _v$9: undefined
    });
    return _el$10;
  })();
}
function AttributesSummary() {
  const parseEntries = value => {
    if (!value) return [];
    if (typeof value === "string") return JSON.parseSafe(value) ?? [];
    return value;
  };
  const [attrSum, setAttrSum] = libs.createSignal({});
  const [mythList, setMythList] = libs.createSignal([]);
  const [chaosAttr, setChaosAttr] = libs.createSignal({});
  const [suitList, setSuitList] = libs.createSignal([]);
  const equipmentPartDatas = solid_utils.createServiceNetData("player_equipment_part_datas", {});
  const equippedRevision = libs.createMemo(() => {
    const equipped = player_hero_equip_suit()[selectHeroID()]?.[selectEquipSuitID()];
    if (equipped == undefined) return "";
    const equipments = player_equipments();
    return equipment_utils.EQUIP_PARTS.map(part => {
      const id = equipped[part] ?? 0;
      return `${part}:${id}:${JSON.stringify(equipments[id] ?? null)}`;
    }).join("|");
  });
  const sumKeys = libs.createMemo(() => {
    return Object.keys(attrSum());
  });
  libs.createEffect(() => {
    equippedRevision();
    const hero = selectHeroID();
    const suit = selectEquipSuitID();
    const data = player_hero_equip_suit();
    let equipped = data[hero]?.[suit];
    let ids = equipped == undefined ? [] : Object.values(equipped).filter(id => Number(id) != 0);
    const partDatas = equipmentPartDatas();
    if (ids.length == 0) {
      libs.batch(() => {
        setAttrSum({});
        setChaosAttr({});
        setMythList([]);
        setSuitList([]);
      });
      return;
    }
    let request = equipment_utils.GetEquipmentDetail(ids, result => {
      let sum = {
        "main_entry_data": {},
        "adverb_entry_data": {}
      };
      let chaosAttr = {};
      let mythList = [];
      let suitList = [];
      let suitRecord = {};
      const addAttribute = (list, attr, bonus = 0) => {
        list[attr.id] ??= {
          base_value: 0,
          value: 0
        };
        list[attr.id].base_value += toFiniteNumber(attr.base_value, 0);
        const enhancedValue = equipment_utils.EquipAttributeRound(attr.id, toFiniteNumber(attr.value, 0) + toFiniteNumber(attr.base_value, 0) * bonus);
        list[attr.id].value += enhancedValue;
        const extraValue = toFiniteNumber(attr.extra_value, 0);
        if (extraValue != 0) {
          list[attr.id].extra_value = toFiniteNumber(list[attr.id].extra_value, 0) + extraValue;
        }
      };
      const addBonusAttribute = (list, attr) => {
        list[attr.id] ??= {
          base_value: 0,
          value: 0
        };
        list[attr.id].value += equipment_utils.EquipAttributeRound(attr.id, toFiniteNumber(attr.value, 0));
        const extraValue = toFiniteNumber(attr.extra_value, 0);
        if (extraValue != 0) {
          list[attr.id].extra_value = toFiniteNumber(list[attr.id].extra_value, 0) + extraValue;
        }
      };
      const addChaosAttribute = attr => {
        chaosAttr[attr.id] ??= {
          base_value: 0,
          value: 0
        };
        chaosAttr[attr.id].base_value = CalculatePropertyValue(attr.id, toFiniteNumber(chaosAttr[attr.id].base_value), attr.base_value);
        chaosAttr[attr.id].value = CalculatePropertyValue(attr.id, toFiniteNumber(chaosAttr[attr.id].value), attr.value);
      };
      for (const [id, data] of Object.entries(result)) {
        const partLevel = partDatas[data.equip_part]?.level ?? 0;
        const levelSetting = KeyValues.equip_level_setting[partLevel];
        for (const attr of data["main_entry_data"]) {
          addAttribute(sum["main_entry_data"], attr, levelSetting?.main_bonus ?? 0);
        }
        for (const attr of data["adverb_entry_data"]) {
          addAttribute(sum["adverb_entry_data"], attr, levelSetting?.adverb_bonus ?? 0);
        }
        for (const attr of data["chaos_entry_data"]) {
          addChaosAttribute(attr);
        }
        for (const attr of data["myth_entry_data"]) {
          mythList.push(attr);
        }
        const inlayGems = parseEntries(data.inlay_gems_data);
        for (const gem of inlayGems) {
          for (const attr of parseEntries(gem.main_entry_data)) {
            addBonusAttribute(sum["adverb_entry_data"], attr);
          }
          for (const attr of parseEntries(gem.adverb_entry_data)) {
            addAttribute(sum["adverb_entry_data"], attr);
          }
          for (const attr of parseEntries(gem.myth_entry_data)) {
            mythList.push(attr);
          }
          for (const attr of parseEntries(gem.chaos_entry_data)) {
            addChaosAttribute(attr);
          }
        }
        if (data.ability_entry_data.length > 0) {
          const suitID = data.ability_entry_data[0].id;
          suitRecord[suitID] = (suitRecord[suitID] ?? 0) + 1;
        }
      }
      for (const [suitID, count] of Object.entries(suitRecord)) {
        if (count >= 2) {
          suitList.push(suitID);
        }
      }
      for (let [attr_type, list] of Object.entries(sum)) {
        for (let [id, attr] of Object.entries(list)) {
          let kv = KeyValues.equip_entry[id] ?? CustomUIConfig.EntryRatio[id];
          if (kv != undefined) {
            let ratio = kv.ratio ?? CustomUIConfig.EntryRatio[id] ?? 1;
            list[id].base_value = Round(attr.base_value, ratio);
            list[id].value = Round(attr.value, ratio);
            if (attr.extra_value != undefined) {
              list[id].extra_value = Round(attr.extra_value, ratio);
            }
          }
        }
      }
      libs.batch(() => {
        setAttrSum(sum);
        setChaosAttr(chaosAttr);
        setMythList(mythList);
        setSuitList(suitList);
      });
    }, true);
    request && libs.onCleanup(() => CancelRequest(request));
  });
  return (() => {
    const _el$25 = libs.createElement("Panel", {
        id: "AttributesSummary"
      }, null);
      libs.createElement("Label", {
        id: "AttributesSummaryTitle",
        text: "#Equipment_AttributesSummary"
      }, _el$25);
      libs.createElement("Panel", {
        id: "TitleLine"
      }, _el$25);
      const _el$28 = libs.createElement("Panel", {
        id: "Attributes",
        "class": "VerticalScrollStyle",
        scroll: "y"
      }, _el$25),
      _el$29 = libs.createElement("Panel", {
        "class": "Separator"
      }, _el$28),
      _el$30 = libs.createElement("Panel", {
        "class": "Separator"
      }, _el$28),
      _el$31 = libs.createElement("Panel", {
        "class": "Separator"
      }, _el$28);
    libs.setProp(_el$28, "scroll", "y");
    libs.insert(_el$28, libs.createComponent(libs.For, {
      get each() {
        return sumKeys();
      },
      children: (attr_type, idx) => {
        return [libs.createComponent(libs.For, {
          get each() {
            return Object.keys(attrSum()[attr_type]);
          },
          children: id => {
            const AttrType = {
              "main_entry_data": "Main",
              "adverb_entry_data": "Adverb"
            };
            const memo = libs.createMemo(() => {
              let data = attrSum()[attr_type][id];
              return {
                ...data,
                id
              };
            });
            const color = AttrType[attr_type] == "Main" ? "#BFAA82" : "#958D83";
            return libs.createComponent(equip_details.EquipmentAttrRow, {
              get data() {
                return memo();
              },
              get type() {
                return AttrType[attr_type];
              },
              attributNameColor: color,
              showAttributeRange: false,
              hideZeroBaseValue: true
            });
          }
        }), (() => {
          const _el$32 = libs.createElement("Panel", {
            "class": "Separator"
          }, null);
          libs.effect(_$p => libs.setProp(_el$32, "visible", idx() < sumKeys().length - 1, _$p));
          return _el$32;
        })()];
      }
    }), _el$29);
    libs.insert(_el$28, libs.createComponent(libs.For, {
      get each() {
        return mythList();
      },
      children: (data, mythIndex) => {
        const entryKv = KeyValues.equip_entry[data.id];
        return (() => {
          const _el$33 = libs.createElement("Panel", {
              "class": "MythEntry"
            }, null);
            libs.createElement("Image", {}, _el$33);
            const _el$35 = libs.createElement("Label", {
              get text() {
                return GetPrivilegeDesc(data.id, 1, {
                  value: data.value,
                  min: entryKv.value_min,
                  max: entryKv.value_max
                });
              },
              html: true
            }, _el$33);
          libs.effect(_$p => libs.setProp(_el$35, "text", GetPrivilegeDesc(data.id, 1, {
            value: data.value,
            min: entryKv.value_min,
            max: entryKv.value_max
          }), _$p));
          return _el$33;
        })();
      }
    }), _el$30);
    libs.insert(_el$28, libs.createComponent(libs.For, {
      get each() {
        return Object.keys(chaosAttr());
      },
      children: (key, idx) => {
        const attrData = libs.createMemo(() => chaosAttr()[key]);
        return (() => {
          const _el$36 = libs.createElement("Panel", {
              "class": `ChaosEntry`
            }, null);
            libs.createElement("Panel", {
              id: "Point"
            }, _el$36);
            const _el$38 = libs.createElement("Label", {
              id: "EntryText",
              get text() {
                return equipment_utils.GetChaosRowInfo({
                  id: key,
                  base_value: attrData().base_value,
                  value: attrData().value
                });
              },
              html: true
            }, _el$36);
          libs.setProp(_el$36, "class", `ChaosEntry`);
          libs.effect(_$p => libs.setProp(_el$38, "text", equipment_utils.GetChaosRowInfo({
            id: key,
            base_value: attrData().base_value,
            value: attrData().value
          }), _$p));
          return _el$36;
        })();
      }
    }), _el$31);
    libs.insert(_el$28, libs.createComponent(libs.For, {
      get each() {
        return suitList();
      },
      children: (suit, idx) => {
        return libs.createComponent(solid_utils.DynamicKey, {
          key: () => `${suit}:${equippedRevision()}`,
          children: () => libs.createComponent(equip_details.EquipSuitList, {
            suitEffectID: suit,
            get hero_id() {
              return selectHeroID();
            }
          })
        });
      }
    }), null);
    libs.effect(_p$ => {
      const _v$0 = mythList().length > 0,
        _v$1 = Object.keys(chaosAttr()).length > 0,
        _v$10 = suitList().length > 0;
      _v$0 !== _p$._v$0 && (_p$._v$0 = libs.setProp(_el$29, "visible", _v$0, _p$._v$0));
      _v$1 !== _p$._v$1 && (_p$._v$1 = libs.setProp(_el$30, "visible", _v$1, _p$._v$1));
      _v$10 !== _p$._v$10 && (_p$._v$10 = libs.setProp(_el$31, "visible", _v$10, _p$._v$10));
      return _p$;
    }, {
      _v$0: undefined,
      _v$1: undefined,
      _v$10: undefined
    });
    return _el$25;
  })();
}
const ItemTabs = ["equipment", "gem"];
const ITEM_TABS_ICON = {
  "equipment": "icon_zhaungbei",
  "gem": "icon_baoshi"
};
function ItemsRoot() {
  const [mythDetailVersion, setMythDetailVersion] = libs.createSignal(0);
  let gemFilterRequestVersion = 0;
  libs.createEffect(() => {
    const keyword = filterMythText().trim();
    const ids = Object.keys(player_equipments());
    if (!keyword || ids.length === 0) {
      return;
    }
    equipment_utils.GetEquipmentDetail(ids, () => setMythDetailVersion(version => version + 1));
  });
  const showItemsRoot = () => {
    return SHOW_ITEM_LIST_MENU[menuName()];
  };
  const filteredEquips = libs.createMemo(() => {
    const part_filter = partFilter();
    const rarity_filter = filterRarity();
    const needlv_filter = filterNeedLv();
    const class_filter = filterClass();
    const suit_filter = filterSuit();
    const myth_text_filter = filterMythText().trim().toLowerCase();
    let res = Object.values(player_equipments());
    if (part_filter > 0) {
      res = res.filter(data => data.equip_part == part_filter);
    }
    const selectedRarity = Object.keys(rarity_filter).filter(k => rarity_filter[Number(k)]).map(Number);
    if (selectedRarity.length > 0) {
      res = res.filter(data => selectedRarity.includes(data.rarity));
    }
    const selectedNeedLv = Object.keys(needlv_filter).filter(k => {
      return needlv_filter[Number(k)];
    }).map(Number);
    if (selectedNeedLv.length > 0) {
      res = res.filter(data => selectedNeedLv.includes(data.need_level));
    }
    const selectedClass = Object.keys(class_filter).filter(k => class_filter[Number(k)]).map(Number);
    if (selectedClass.length > 0) {
      res = res.filter(data => {
        return selectedClass.includes(data.class);
      });
    }
    const selectedSuit = Object.keys(suit_filter).filter(k => suit_filter[k]);
    if (selectedSuit.length > 0) {
      res = res.filter(data => {
        const suitID = data.ability_entry_data?.[0]?.id;
        return suitID != undefined && selectedSuit.includes(suitID);
      });
    }
    if (myth_text_filter) {
      mythDetailVersion();
      res = res.filter(data => {
        const mythEntries = CustomUIConfig.EquipmentDetailCache[data.id]?.myth_entry_data ?? [];
        return mythEntries?.some(entry => {
          const entryKv = KeyValues.equip_entry[entry.id];
          const description = GetPrivilegeDesc(entry.id, 1, {
            value: entry.value,
            min: entryKv?.value_min,
            max: entryKv?.value_max
          });
          const searchableText = [entry.id, GetLocalization(`#DOTA_Tooltip_ability_${entry.id}`, ""), description].join(" ").replace(/<[^>]*>/g, "").toLowerCase();
          return searchableText.includes(myth_text_filter);
        });
      });
    }
    return res;
  });
  const sortedEquips = libs.createMemo(() => {
    const dataList = filteredEquips();
    const currentTab = forgeChildTab();
    const meetConditionList = [];
    const notMeetConditionList = [];
    for (const data of dataList) {
      if (!currentTab || isEquipMeetCondition(data, currentTab)) {
        meetConditionList.push(data);
      } else {
        notMeetConditionList.push(data);
      }
    }
    const sortFunc = (a, b) => {
      return multiCompare(b.rarity - a.rarity, b.class - a.class);
    };
    meetConditionList.sort(sortFunc);
    notMeetConditionList.sort(sortFunc);
    const ret = [...meetConditionList, ...notMeetConditionList];
    return ret;
  });
  const sortedGems = libs.createMemo(() => {
    const currentTab = forgeChildTab();
    const rarity = partFilter();
    const allowedGemIDs = filteredGemIDs();
    const selectedMainEntries = Object.keys(filterGemMainEntry()).filter(entryID => filterGemMainEntry()[entryID]);
    const gemList = Object.values(player_gems()).filter(gem => {
      if (rarity !== 0 && gem.rarity !== rarity) return false;
      if (allowedGemIDs != undefined && !allowedGemIDs.includes(gem.id)) return false;
      if (selectedMainEntries.length === 0) return true;
      const mainEntryID = KeyValues.gem_entry_main[gem.gem_item_id]?.entry_id;
      return mainEntryID != undefined && selectedMainEntries.includes(mainEntryID);
    });
    if (!currentTab || selectedItemTab() !== "gem") {
      return gemList.sort((a, b) => b.rarity - a.rarity);
    }
    const meetList = [];
    const notMeetList = [];
    for (const gem of gemList) {
      if (isGemMeetCondition(gem, currentTab)) {
        meetList.push(gem);
      } else {
        notMeetList.push(gem);
      }
    }
    meetList.sort((a, b) => b.rarity - a.rarity);
    notMeetList.sort((a, b) => b.rarity - a.rarity);
    return [...meetList, ...notMeetList];
  });
  const applyGemSubEntryFilter = () => {
    const include = [];
    const exclude = [];
    for (const [entryID, mode] of Object.entries(filterGemSubEntry())) {
      if (mode === "include") include.push(entryID);
      if (mode === "exclude") exclude.push(entryID);
    }
    const requestVersion = ++gemFilterRequestVersion;
    setGemFilterRequesting(true);
    setShowFilter(false);
    ServerRequest("filter_gems", {
      include,
      exclude
    }, result => {
      if (requestVersion !== gemFilterRequestVersion) return;
      libs.batch(() => {
        setFilteredGemIDs(result.ids ?? []);
        setGemFilterRequesting(false);
      });
    });
  };
  return (() => {
    const _el$39 = libs.createElement("Panel", {
        id: "ItemsRoot",
        get ["class"]() {
          return libs.classNames("RootWindow", {
            Hidden: !showItemsRoot() || hiddenItemList()
          });
        }
      }, null),
      _el$40 = libs.createElement("Panel", {
        id: "LeftArea"
      }, _el$39),
      _el$42 = libs.createElement("Panel", {
        id: "PartFilter",
        get ["class"]() {
          return libs.classNames({
            Gem: selectedItemTab() == "gem"
          });
        }
      }, _el$39),
      _el$43 = libs.createElement("Panel", {
        id: "BtnsContainer"
      }, _el$39),
      _el$44 = libs.createElement("Panel", {
        align: "center center",
        flowChildren: "right"
      }, _el$43),
      _el$45 = libs.createElement("Button", {
        id: "ResetBtn",
        "class": "SecondaryButtonStates"
      }, _el$44);
    libs.insert(_el$40, libs.createComponent(libs.Show, {
      get when() {
        return showFilter();
      },
      get children() {
        return libs.createComponent(FilterWindow, {});
      }
    }), null);
    libs.insert(_el$40, libs.createComponent(libs.Show, {
      get when() {
        return !showFilter();
      },
      get children() {
        return [(() => {
          const _el$41 = libs.createElement("Panel", {
            id: "Tabs",
            hittest: true
          }, null);
          libs.setProp(_el$41, "onactivate", () => {});
          libs.insert(_el$41, libs.createComponent(libs.For, {
            each: ItemTabs,
            children: name => {
              const locked = isItemTabLocked();
              return libs.createComponent(equipment_comp.MenuTabButton, {
                name: name,
                get icon() {
                  return ITEM_TABS_ICON[name];
                },
                get num() {
                  return name == "equipment" ? equipmentCount() : gemCount();
                },
                locked: locked,
                get selected() {
                  return selectedItemTab() == name;
                },
                clickCallback: () => {
                  setSelectedItemTab(name);
                }
              });
            }
          }));
          return _el$41;
        })(), libs.createComponent(libs.Show, {
          get when() {
            return selectedItemTab() == "equipment";
          },
          get children() {
            return libs.createComponent(RecycleView.RecycleView, {
              id: "ItemList",
              input: sortedEquips,
              direction: "VerticalGrid",
              wheelStep: 88,
              childConfig: {
                width: 88,
                height: 88,
                margin: 2
              },
              grid_children: () => libs.createElement("Panel", {
                "class": "EquipListGrid"
              }, null),
              children: data => {
                const id = () => data()?.id;
                const kv = () => {
                  if (!data()) return;
                  return KeyValues.info_item_equipment[data().equipment_item_id];
                };
                const select = () => {
                  return selectedItemID() == id() || selectedItemList().includes(id());
                };
                const gray = () => {
                  if (!data()) return;
                  const tab = forgeChildTab();
                  if (!tab) return false;
                  return !isEquipMeetCondition(data(), tab);
                };
                const isNew = () => {
                  return equipmentUnreadIds.isUnread(id());
                };
                const heroEquiped = () => {
                  const heroID = menuName() == "EquipmentTab_equip" ? selectHeroID() : undefined;
                  return equipment_utils.EquipmentIsEquiped(data(), heroID);
                };
                return (() => {
                  const _el$47 = libs.createElement("Panel", {
                      get ["class"]() {
                        return libs.classNames("Item", {
                          Selected: select(),
                          Gray: gray(),
                          New: isNew()
                        });
                      }
                    }, null),
                    _el$48 = libs.createElement("Panel", {
                      "class": "SelectedBorder"
                    }, _el$47);
                    libs.createElement("Panel", {
                      id: "NewTag"
                    }, _el$47);
                  libs.setProp(_el$47, "onmouseactivate", () => {
                    if (menuName() == "EquipmentTab_break") {
                      if (equipment_utils.EquipmentHasStates(data(), true)) {
                        return;
                      }
                      if (selectedItemList().includes(id())) {
                        setSelectedItemList(items => {
                          const newItems = [...items];
                          newItems[items.indexOf(id())] = undefined;
                          return newItems;
                        });
                        return;
                      }
                      setSelectedItemList(items => {
                        const slot = selectBreakSlot();
                        if (slot >= 0 && slot < 5) {
                          const newItems = [...items];
                          newItems[slot] = id();
                          return newItems;
                        }
                        if (items.includes(id())) {
                          return items.filter(i => i != id());
                        }
                        if (items.length < 5) {
                          return [...items, id()];
                        }
                        return items;
                      });
                    } else {
                      if (gray()) {
                        return;
                      }
                      setSelectedItemID(data().id);
                    }
                  });
                  libs.setProp(_el$47, "onmouseover", p => {
                    if (id()) {
                      let id2 = equippedEquipment()?.[data().equip_part];
                      if (id2 == id()) {
                        id2 = undefined;
                      }
                      equipment_utils.ShowServerEquipTooltip(p, {
                        id1: id(),
                        id2: id2
                      });
                      if (isNew()) {
                        equipmentUnreadIds.markRead(id());
                        CustomUIConfig.__equipmentRedPointState?.markEquipmentUnreadViewed([id()]);
                      }
                    }
                  });
                  libs.setProp(_el$47, "onmouseout", p => HideCustomTooltip(p, "server_equip"));
                  libs.setProp(_el$47, "onDragStart", (panel, dragCallbacks) => {
                    if (!data() || gray()) return;
                    HideCustomTooltip(panel, "server_equip");
                    let pDisplayPanel = $.CreatePanel("Panel", $.GetContextPanel(), "dragImage");
                    let d = {
                      ...data()
                    };
                    libs.render(() => libs.createComponent(server_equipment.Equipment, d), pDisplayPanel);
                    dragCallbacks.displayPanel = pDisplayPanel;
                    setDragPanelOffset(dragCallbacks, pDisplayPanel);
                    panel.AddClass("dragging_from");
                    SaveData(pDisplayPanel, "equip", id());
                    HideCustomTooltip(panel, "compare_server_equipment");
                    setDraggedSlot(kv().equip_part);
                    $.GetContextPanel().AddClass("Equipment_Dragging");
                    return true;
                  });
                  libs.setProp(_el$47, "onDragEnd", (panel, draggedPanel) => {
                    setDraggedSlot();
                    draggedPanel.DeleteAsync(-1);
                    panel.RemoveClass("dragging_from");
                    $.GetContextPanel().RemoveClass("Equipment_Dragging");
                  });
                  libs.setProp(_el$47, "oncontextmenu", p => {
                    const _kv = kv();
                    if (!_kv) return;
                    const menus = {};
                    const _part = _kv.equip_part;
                    const isEquip = equipment_utils.EquipmentIsEquiped(data(), selectHeroID());
                    if (data().locked) {
                      menus["Hud_Equipment_Unlock"] = () => {
                        LockEquipment(id(), false);
                      };
                    } else {
                      if (menuName() == "EquipmentTab_break" && selectedItemList().includes(id())) ; else {
                        menus["Hud_Equipment_Lock"] = () => {
                          LockEquipment(id(), true);
                        };
                      }
                    }
                    if (isEquip) {
                      menus["Hud_Equipment_UnEquip"] = () => {
                        EquipEquipment(0, selectHeroID(), selectEquipSuitID(), _part);
                      };
                    } else {
                      if (menuName() == "EquipmentTab_break" && selectedItemList().includes(id())) ; else {
                        menus["Hud_Equipment_Equip1"] = () => {
                          EquipEquipment(id(), selectHeroID(), selectEquipSuitID(), _part);
                        };
                      }
                    }
                    let equip_list = [];
                    const equipSuitData = player_hero_equip_suit();
                    for (let [hero_id, suit_list] of Object.entries(equipSuitData)) {
                      for (let [suit_id, part_list] of Object.entries(suit_list)) {
                        if (part_list[_part] == id()) {
                          equip_list.push({
                            hero_id: Number(hero_id),
                            suit_id: Number(suit_id)
                          });
                        }
                      }
                    }
                    if (equip_list.length) {
                      menus["Hud_Equipment_UnEquip_All"] = () => {
                        for (const element of equip_list) {
                          EquipEquipment(0, element.hero_id, element.suit_id, _part);
                        }
                      };
                    }
                    if (Object.keys(menus).length > 0) {
                      CustomUIConfig.showContextMenu(p, menus);
                    }
                  });
                  libs.insert(_el$47, libs.createComponent(server_equipment.Equipment, libs.mergeProps$1(data, {
                    get equipped() {
                      return heroEquiped();
                    }
                  })), _el$48);
                  libs.effect(_$p => libs.setProp(_el$47, "class", libs.classNames("Item", {
                    Selected: select(),
                    Gray: gray(),
                    New: isNew()
                  }), _$p));
                  return _el$47;
                })();
              }
            });
          }
        }), libs.createComponent(libs.Show, {
          get when() {
            return selectedItemTab() == "gem";
          },
          get children() {
            return libs.createComponent(RecycleView.RecycleView, {
              id: "ItemList",
              input: sortedGems,
              direction: "VerticalGrid",
              wheelStep: 88,
              childConfig: {
                width: 88,
                height: 88,
                margin: 2
              },
              grid_children: () => libs.createElement("Panel", {
                "class": "EquipListGrid"
              }, null),
              children: data => {
                const gemData = () => data();
                const gemId = () => gemData().id;
                const isSelected = () => {
                  if (menuName() == "EquipmentTab_break") {
                    return selectedItemList().includes(gemId());
                  }
                  return selectedGemList().includes(gemId());
                };
                const gray = () => {
                  if (!gemData()) return;
                  const tab = forgeChildTab();
                  if (!tab) return false;
                  return !isGemMeetCondition(gemData(), tab);
                };
                const isNew = () => gemUnreadIds.isUnread(gemId());
                return (() => {
                  const _el$51 = libs.createElement("Panel", {
                      get ["class"]() {
                        return libs.classNames("Item", {
                          Selected: isSelected(),
                          Gray: gray(),
                          New: isNew()
                        });
                      }
                    }, null),
                    _el$52 = libs.createElement("Panel", {
                      "class": "SelectedBorder"
                    }, _el$51);
                    libs.createElement("Panel", {
                      id: "NewTag"
                    }, _el$51);
                  libs.setProp(_el$51, "onmouseover", p => {
                    if (gemId()) {
                      const itemData = selectedItemData();
                      let embeddedGemData;
                      if (itemData) {
                        const gems = JSON.parseSafe(itemData.inlay_gems_data);
                        if (gems && gems[0] && gems[0].id != undefined) {
                          const gem = gems[0];
                          const parseEntries = v => {
                            if (!v) return [];
                            if (typeof v === "string") return JSON.parseSafe(v) ?? [];
                            return v;
                          };
                          embeddedGemData = JSON.stringify({
                            ...gem,
                            main_entry_data: parseEntries(gem.main_entry_data),
                            adverb_entry_data: parseEntries(gem.adverb_entry_data),
                            myth_entry_data: parseEntries(gem.myth_entry_data),
                            chaos_entry_data: parseEntries(gem.chaos_entry_data),
                            ability_entry_data: parseEntries(gem.ability_entry_data)
                          });
                        }
                      }
                      equipment_utils.ShowServerGemTooltip(p, {
                        id1: gemId(),
                        embeddedGemData
                      });
                      if (isNew()) {
                        gemUnreadIds.markRead(gemId());
                      }
                    }
                  });
                  libs.setProp(_el$51, "onmouseout", p => HideCustomTooltip(p, "server_gem"));
                  libs.setProp(_el$51, "onDragStart", (panel, dragCallbacks) => {
                    if (!gemData() || gray()) return;
                    HideCustomTooltip(panel, "server_gem");
                    let pDisplayPanel = $.CreatePanel("Panel", $.GetContextPanel(), "dragImage");
                    let d = {
                      ...gemData()
                    };
                    libs.render(() => libs.createComponent(server_equipment.Gem, d), pDisplayPanel);
                    dragCallbacks.displayPanel = pDisplayPanel;
                    setDragPanelOffset(dragCallbacks, pDisplayPanel);
                    panel.AddClass("dragging_from");
                    SaveData(pDisplayPanel, "gem", gemId());
                    return true;
                  });
                  libs.setProp(_el$51, "onDragEnd", (panel, draggedPanel) => {
                    draggedPanel.DeleteAsync(-1);
                    panel.RemoveClass("dragging_from");
                  });
                  libs.setProp(_el$51, "onmouseactivate", () => {
                    const id = gemId();
                    if (menuName() == "EquipmentTab_break") {
                      if (gray()) return;
                      if (selectedItemList().includes(id)) {
                        setSelectedItemList(items => {
                          const newItems = [...items];
                          newItems[items.indexOf(id)] = undefined;
                          return newItems;
                        });
                        return;
                      }
                      setSelectedItemList(items => {
                        const slot = selectBreakSlot();
                        if (slot >= 0 && slot < 5) {
                          const newItems = [...items];
                          newItems[slot] = id;
                          return newItems;
                        }
                        if (items.includes(id)) {
                          return items.filter(i => i != id);
                        }
                        if (items.length < 5) {
                          return [...items, id];
                        }
                        return items;
                      });
                    } else {
                      libs.batch(() => {
                        setSelectedGemList(prev => {
                          if (prev.includes(id)) {
                            return prev.filter(i => i !== id);
                          }
                          return [id];
                        });
                        if (forgeChildTab() == "Inlay") {
                          setSelectedItemTab("equipment");
                        }
                      });
                    }
                  });
                  libs.insert(_el$51, libs.createComponent(server_equipment.Gem, libs.mergeProps$1(gemData)), _el$52);
                  libs.effect(_$p => libs.setProp(_el$51, "class", libs.classNames("Item", {
                    Selected: isSelected(),
                    Gray: gray(),
                    New: isNew()
                  }), _$p));
                  return _el$51;
                })();
              }
            });
          }
        })];
      }
    }), null);
    libs.insert(_el$42, libs.createComponent(libs.For, {
      get each() {
        return selectedItemTab() == "equipment" ? [0, ...equipment_utils.EQUIP_PARTS] : [0, 5, 6];
      },
      children: part => {
        return (() => {
          const _el$54 = libs.createElement("Button", {
              get id() {
                return part.toString();
              },
              get ["class"]() {
                return libs.classNames("PartTab", {
                  Selected: partFilter() == part
                });
              }
            }, null),
            _el$55 = libs.createElement("Image", {
              id: "PartIcon",
              get src() {
                return getSrcPath(`conv/icon/${selectedItemTab() == "equipment" || part == 0 ? EQUIP_PART_ICON[part] : GEM_RARITY_ICON[part]}`);
              }
            }, _el$54);
          libs.setProp(_el$54, "onactivate", () => {
            if (selectedItemTab() == "equipment" && part == 0) {
              setSelectedSlot();
            }
            setPartFilter(part);
          });
          libs.effect(_p$ => {
            const _v$14 = part.toString(),
              _v$15 = libs.classNames("PartTab", {
                Selected: partFilter() == part
              }),
              _v$16 = getSrcPath(`conv/icon/${selectedItemTab() == "equipment" || part == 0 ? EQUIP_PART_ICON[part] : GEM_RARITY_ICON[part]}`);
            _v$14 !== _p$._v$14 && (_p$._v$14 = libs.setProp(_el$54, "id", _v$14, _p$._v$14));
            _v$15 !== _p$._v$15 && (_p$._v$15 = libs.setProp(_el$54, "class", _v$15, _p$._v$15));
            _v$16 !== _p$._v$16 && (_p$._v$16 = libs.setProp(_el$55, "src", _v$16, _p$._v$16));
            return _p$;
          }, {
            _v$14: undefined,
            _v$15: undefined,
            _v$16: undefined
          });
          return _el$54;
        })();
      }
    }));
    libs.setProp(_el$44, "align", "center center");
    libs.setProp(_el$44, "flowChildren", "right");
    libs.insert(_el$44, libs.createComponent(equipment_comp.EquipmentCommonBtn, {
      id: "FilterBtn",
      get ["class"]() {
        return libs.classNames({
          ShowBtnBorder: showFilter()
        });
      },
      text: "#Hud_Equipment_Filter",
      get enabled() {
        return !gemFilterRequesting();
      },
      onactivate: () => {
        if (showFilter() && selectedItemTab() == "gem") {
          applyGemSubEntryFilter();
          return;
        }
        setShowFilter(prev => {
          return !prev;
        });
      }
    }), _el$45);
    libs.setProp(_el$45, "onactivate", () => {
      libs.batch(() => {
        gemFilterRequestVersion += 1;
        setGemFilterRequesting(false);
        setFilterNeedLv({});
        setFilterRarity({});
        setFilterGemMainEntry({});
        setFilterGemSubEntry({});
        setFilteredGemIDs();
        setFilterClass({});
        setFilterSuit({});
        setFilterMythText("");
        setResterFilter(prev => {
          return prev += 1;
        });
      });
    });
    libs.insert(_el$44, libs.createComponent(equipment_comp.EquipmentCommonBtn, {
      get text() {
        return selectedItemData() && selectedItemData().locked ? "#Hud_Equipment_Unlock" : "#Hud_Equipment_Lock";
      },
      get enabled() {
        return selectedItemID() != undefined;
      },
      onactivate: () => {
        const id = selectedItemID();
        if (id) {
          let lock = player_equipments()[id].locked;
          LockEquipment(id, !lock);
        }
      }
    }), null);
    libs.effect(_p$ => {
      const _v$11 = libs.classNames("RootWindow", {
          Hidden: !showItemsRoot() || hiddenItemList()
        }),
        _v$12 = libs.classNames({
          Gem: selectedItemTab() == "gem"
        }),
        _v$13 = !gemFilterRequesting();
      _v$11 !== _p$._v$11 && (_p$._v$11 = libs.setProp(_el$39, "class", _v$11, _p$._v$11));
      _v$12 !== _p$._v$12 && (_p$._v$12 = libs.setProp(_el$42, "class", _v$12, _p$._v$12));
      _v$13 !== _p$._v$13 && (_p$._v$13 = libs.setProp(_el$45, "enabled", _v$13, _p$._v$13));
      return _p$;
    }, {
      _v$11: undefined,
      _v$12: undefined,
      _v$13: undefined
    });
    return _el$39;
  })();
}
function FilterWindow() {
  let needLvFilter;
  const needLvText = libs.createMemo(() => {
    let list = [];
    for (const [k, v] of Object.entries(filterNeedLv())) {
      if (v) {
        list.push(k);
      }
    }
    return list.toString();
  });
  libs.onMount(() => {
    const scheduleID = $.Schedule(0.2, () => {
      needLvFilter?.setSelect(filterNeedLv());
    });
    libs.onCleanup(() => {
      $.CancelScheduled(scheduleID);
    });
  });
  libs.createEffect(() => {
    resetFilter();
    needLvFilter?.reset();
  });
  const selectGemSubEntryFilter = (entryID, mode) => {
    setFilterGemSubEntry(prev => {
      const next = {
        ...prev
      };
      if (mode === "default") {
        delete next[entryID];
      } else {
        next[entryID] = mode;
      }
      return next;
    });
  };
  return (() => {
    const _el$56 = libs.createElement("Panel", {
      id: "FilterWindow"
    }, null);
    libs.insert(_el$56, libs.createComponent(libs.Show, {
      get when() {
        return selectedItemTab() == "equipment";
      },
      get fallback() {
        return (() => {
          const _el$71 = libs.createElement("Panel", {
              id: "GemFilterContent"
            }, null);
            libs.createElement("Label", {
              id: "GemMainEntryFilterLabel",
              "class": "Subheading",
              text: "#Equipment_SelectMainEntry"
            }, _el$71);
            libs.createElement("Panel", {
              "class": "Separator FilterLine"
            }, _el$71);
            const _el$74 = libs.createElement("Panel", {
              id: "GemMainEntryFilterList",
              "class": "CheckBoxList"
            }, _el$71),
            _el$75 = libs.createElement("Panel", {
              id: "GemSubEntryFilterTitle"
            }, _el$71);
            libs.createElement("Panel", {
              "class": "Separator"
            }, _el$75);
            libs.createElement("Label", {
              text: "#Equipment_GemSubFilter_Title"
            }, _el$75);
            libs.createElement("Panel", {
              "class": "Separator"
            }, _el$75);
            const _el$79 = libs.createElement("Panel", {
              id: "GemSubEntryFilterList",
              "class": "VerticalScrollStyle",
              scroll: "y"
            }, _el$71);
          libs.insert(_el$74, libs.createComponent(libs.For, {
            each: GEM_MAIN_ENTRY_IDS,
            children: entryID => libs.createComponent(equipment_comp.EOM_CheckBox2, {
              get checked() {
                return filterGemMainEntry()[entryID] ?? false;
              },
              get text() {
                return GetLocalization("#property_" + entryID).replace("%", "");
              },
              onchecked: checked => {
                if (checked) {
                  setFilterGemMainEntry(prev => ({
                    ...prev,
                    [entryID]: true
                  }));
                } else {
                  const next = {
                    ...filterGemMainEntry()
                  };
                  delete next[entryID];
                  setFilterGemMainEntry(next);
                }
              }
            })
          }));
          libs.setProp(_el$79, "scroll", "y");
          libs.insert(_el$79, libs.createComponent(libs.For, {
            each: GEM_SUB_ENTRY_IDS,
            children: entryID => {
              const mode = () => filterGemSubEntry()[entryID] ?? "default";
              return (() => {
                const _el$80 = libs.createElement("Panel", {
                    "class": "GemSubEntryFilterRow"
                  }, null),
                  _el$81 = libs.createElement("Label", {
                    "class": "GemSubEntryName",
                    get text() {
                      return GetLocalization("#property_" + entryID);
                    },
                    html: true
                  }, _el$80),
                  _el$82 = libs.createElement("Panel", {
                    "class": "GemSubEntryMode"
                  }, _el$80);
                libs.insert(_el$82, libs.createComponent(libs.For, {
                  each: GEM_SUB_ENTRY_FILTER_MODES,
                  children: (filterMode, index) => [(() => {
                    const _el$83 = libs.createElement("Button", {
                        get ["class"]() {
                          return libs.classNames("GemSubEntryModeButton", filterMode, {
                            Selected: mode() === filterMode
                          });
                        }
                      }, null),
                      _el$84 = libs.createElement("Label", {
                        text: `#Equipment_GemSubFilter_${filterMode}`
                      }, _el$83);
                    libs.setProp(_el$83, "onactivate", () => selectGemSubEntryFilter(entryID, filterMode));
                    libs.setProp(_el$84, "text", `#Equipment_GemSubFilter_${filterMode}`);
                    libs.effect(_$p => libs.setProp(_el$83, "class", libs.classNames("GemSubEntryModeButton", filterMode, {
                      Selected: mode() === filterMode
                    }), _$p));
                    return _el$83;
                  })(), libs.createComponent(libs.Show, {
                    get when() {
                      return index() < GEM_SUB_ENTRY_FILTER_MODES.length - 1;
                    },
                    get children() {
                      return libs.createElement("Label", {
                        "class": "GemSubEntryModeSeparator",
                        text: "/"
                      }, null);
                    }
                  })]
                }));
                libs.effect(_$p => libs.setProp(_el$81, "text", GetLocalization("#property_" + entryID), _$p));
                return _el$80;
              })();
            }
          }));
          return _el$71;
        })();
      },
      get children() {
        return [(() => {
          const _el$57 = libs.createElement("Panel", {
              id: "NeedLvFilter",
              "class": "Filter"
            }, null);
            libs.createElement("Label", {
              id: "FilterType",
              text: "#NeedLvFilter"
            }, _el$57);
          libs.insert(_el$57, libs.createComponent(EOM_MultiDropDown.EOM_MultiDropDown, {
            get placeholder() {
              return needLvText();
            },
            ref(r$) {
              const _ref$ = needLvFilter;
              typeof _ref$ === "function" ? _ref$(r$) : needLvFilter = r$;
            },
            options: NEEDLV_LIST,
            onChange: value => {
              setFilterNeedLv(value);
            }
          }), null);
          return _el$57;
        })(), libs.createElement("Label", {
          id: "RarityLabel",
          "class": "Subheading",
          text: "#Equipment_Rarity"
        }, null), libs.createElement("Panel", {
          "class": "Separator FilterLine"
        }, null), (() => {
          const _el$61 = libs.createElement("Panel", {
            id: "RarityFilterList",
            "class": "CheckBoxList"
          }, null);
          libs.insert(_el$61, libs.createComponent(libs.For, {
            each: equipment_utils.EQUIP_RARITY_COLOR,
            children: (color, idx) => {
              let rarity = idx() + 1;
              return libs.createComponent(equipment_comp.EOM_CheckBox2, {
                "class": "Rarity" + rarity,
                get checked() {
                  return filterRarity()[rarity] ?? false;
                },
                get text() {
                  return GetLocalization(`#Equipment_Rarity_${rarity}`);
                },
                onchecked: b => {
                  if (b) {
                    setFilterRarity(prev => ({
                      ...prev,
                      [rarity]: b
                    }));
                  } else {
                    const newRarity = {
                      ...filterRarity()
                    };
                    delete newRarity[rarity];
                    setFilterRarity(newRarity);
                  }
                }
              });
            }
          }));
          return _el$61;
        })(), (() => {
          const _el$62 = libs.createElement("Label", {
            id: "RarityLabel",
            "class": "Subheading",
            text: "#Equipment_Class"
          }, null);
          libs.setProp(_el$62, "tooltip", "#Equipment_Class_Desc");
          return _el$62;
        })(), libs.createElement("Panel", {
          "class": "Separator FilterLine"
        }, null), (() => {
          const _el$64 = libs.createElement("Panel", {
            id: "ClassFilterList",
            "class": "CheckBoxList"
          }, null);
          libs.insert(_el$64, libs.createComponent(libs.For, {
            get each() {
              return Object.keys(GameUI.CustomUIConfig().equip_class_setting);
            },
            children: (equipClass, idx) => {
              return libs.createComponent(equipment_comp.EOM_CheckBox2, {
                get checked() {
                  return filterClass()[Number(equipClass)] ?? false;
                },
                text: equipClass,
                onchecked: b => {
                  if (b) {
                    setFilterClass(prev => ({
                      ...prev,
                      [Number(equipClass)]: b
                    }));
                  } else {
                    const newClass = {
                      ...filterClass()
                    };
                    delete newClass[Number(equipClass)];
                    setFilterClass(newClass);
                  }
                }
              });
            }
          }));
          return _el$64;
        })(), libs.createElement("Label", {
          id: "RarityLabel",
          "class": "Subheading",
          text: "#Equipment_Suit"
        }, null), libs.createElement("Panel", {
          "class": "Separator FilterLine"
        }, null), (() => {
          const _el$67 = libs.createElement("Panel", {
            id: "SuitFilterList",
            "class": "CheckBoxList"
          }, null);
          libs.insert(_el$67, libs.createComponent(libs.For, {
            get each() {
              return Object.keys(KeyValues.equipment_suit_effect);
            },
            children: suitID => {
              return libs.createComponent(equipment_comp.EOM_CheckBox2, {
                get checked() {
                  return filterSuit()[suitID] ?? false;
                },
                get text() {
                  return GetLocalization("#" + suitID);
                },
                onchecked: b => {
                  if (b) {
                    setFilterSuit(prev => ({
                      ...prev,
                      [suitID]: b
                    }));
                  } else {
                    const newSuit = {
                      ...filterSuit()
                    };
                    delete newSuit[suitID];
                    setFilterSuit(newSuit);
                  }
                }
              });
            }
          }));
          return _el$67;
        })(), (() => {
          const _el$68 = libs.createElement("Label", {
            id: "MythFilterLabel",
            "class": "Subheading",
            get text() {
              return GetLocalization("#Equipment_MythFilter");
            }
          }, null);
          libs.effect(_$p => libs.setProp(_el$68, "text", GetLocalization("#Equipment_MythFilter"), _$p));
          return _el$68;
        })(), libs.createElement("Panel", {
          "class": "Separator FilterLine"
        }, null), (() => {
          const _el$70 = libs.createElement("Panel", {
            id: "MythTextFilter",
            "class": "ExchangeEntry"
          }, null);
          libs.insert(_el$70, libs.createComponent(EOM_TextEntry.EOM_TextEntry, {
            id: "ExchangeTextEntry",
            style: {
              border: "0px",
              backgroundColor: "none"
            },
            get className() {
              return Language();
            },
            placeholder: "#Equipment_MythFilter_Placeholder",
            onChange: (_, __, text) => setFilterMythText(text)
          }));
          return _el$70;
        })()];
      }
    }));
    return _el$56;
  })();
}
function EquipForge() {
  const equipTabs = ["ClassUP", "RarityUP", "Recast", "Refine", "Inlay"];
  const gemTabs = ["GemLevelUP", "GemMake"];
  const tabTipsMap = {
    "ClassUP": "#EquipClassUpTips",
    "RarityUP": "#EquipRarityUpgradeTips",
    "Recast": "#EquipRecastTips",
    "Refine": "#EquipRefineTips",
    "Inlay": "#EquipInlayTips",
    "GemLevelUP": "#GemLevelUPTips",
    "GemMake": "#GemMakeTips"
  };
  const {
    itemData,
    forceFresh
  } = equipment_comp.createEquipDetailSignal(selectedItemID);
  const {
    gemData,
    forceFresh: forceGemFresh
  } = equipment_comp.createGemDetailSignal(() => selectedGemList()[0]);
  const [showAnim, setShowAnim] = libs.createSignal(false);
  const [leftExtraContent, setLeftExtraContent] = libs.createSignal();
  const showGemDisplayData = libs.createMemo(() => {
    const childTab = forgeChildTab();
    return (childTab == undefined || gemTabs.includes(childTab)) && selectedItemTab() === "gem";
  });
  const newTabs = libs.createMemo(() => {
    return showGemDisplayData() ? gemTabs : equipTabs;
  });
  const displayData = libs.createMemo(() => {
    if (showAnim()) {
      return libs.untrack(() => itemData());
    }
    return itemData();
  });
  const displayGemData = libs.createMemo(() => {
    if (showAnim()) {
      return libs.untrack(() => gemData());
    }
    if (gemData() == undefined) {
      return "undefined";
    }
    return gemData();
  });
  const inlayGemData = libs.createMemo(() => {
    const data = displayData();
    if (!data) return [];
    return JSON.parseSafe(data.inlay_gems_data) ?? [];
  });
  const InlayType = libs.createMemo(() => {
    const data = displayData();
    if (!data || !canEquipPunch(data.class, data.rarity)) {
      return "None";
    }
    return inlayGemData().length == 0 ? "Punch" : "Inlay";
  });
  const [selectGemSlot, setSelectGemSlot] = libs.createSignal(0);
  libs.createEffect(libs.on([forgeChildTab], ([forgeChildTab]) => {
    if (forgeChildTab != "Inlay") {
      setItemListIsHidden(forgeChildTab != undefined);
    }
    setLeftExtraContent();
  }));
  libs.createEffect(libs.on([displayData], ([data]) => {
    if (data?.in_check && data.in_check !== "" && forgeChildTab() !== "Recast") {
      setForgeChildTab("Recast");
    }
  }));
  let chuiziParticle;
  let forgeParticle;
  let forgeAnimCancelled = false;
  const cancelForgeAnimation = () => {
    if (!showAnim()) return;
    forgeAnimCancelled = true;
    chuiziParticle?.StopParticlesImmediately(true);
    setShowAnim(false);
  };
  libs.createEffect(libs.on(show, isShow => {
    if (!isShow) cancelForgeAnimation();
  }));
  libs.onCleanup(cancelForgeAnimation);
  const startForgeAnimation = async requestFn => {
    forgeAnimCancelled = false;
    chuiziParticle?.StartParticles();
    setShowAnim(true);
    await Promise.all([requestFn(), new Promise(resolve => $.Schedule(1.8, resolve)), (async () => {
      for (let i = 0; i < 3; i++) {
        if (forgeAnimCancelled) return;
        Game.EmitSound("DOTA_Item.HavocHammer.Cast");
        await Timer.Wait(0.6);
      }
    })()]);
    if (forgeAnimCancelled) return;
    if (forgeParticle) {
      forgeParticle.AddClass("Show");
      forgeParticle.ReloadScene();
      Game.EmitSound("ui.treasure_01");
    }
    libs.batch(() => {
      forceFresh();
      forceGemFresh();
      setShowAnim(false);
      chuiziParticle?.StopParticlesImmediately(true);
    });
  };
  const onReturn = () => {
    libs.batch(() => {
      const forgeTab = forgeChildTab() ?? "";
      if (equipTabs.includes(forgeTab)) {
        setSelectedItemTab("equipment");
        setSelectedGemList([]);
      } else if (gemTabs.includes(forgeTab)) {
        setSelectedItemTab("gem");
      }
      setForgeChildTab();
      setLockItemTab(false);
      setItemListIsHidden(false);
      setShowTokens([]);
    });
  };
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
    id: "EquipForge",
    get ["class"]() {
      return libs.classNames({
        ShowAnim: showAnim()
      });
    },
    get children() {
      return [libs.createElement("DOTAParticleScenePanel", {
        id: "BGLight",
        particleName: "particles/ui/game/ui_game_equipment_interface_01_fx.vpcf",
        cameraOrigin: "0 0 700",
        fov: 90,
        lookAt: "0 0 0",
        hittest: false,
        squarePixels: true
      }, null), (() => {
        const _el$87 = libs.createElement("Panel", {
            id: "CenterBlock",
            hittest: false
          }, null);
          libs.createElement("Panel", {
            id: "ForgeImage"
          }, _el$87);
          const _el$89 = libs.createElement("Panel", {
            id: "LeftArea",
            get ["class"]() {
              return libs.classNames({
                ShowAnimState: showAnim()
              });
            }
          }, _el$87);
        libs.setProp(_el$87, "onDragEnter", (pPanel, draggedPanel) => {
          if (LoadData(draggedPanel, "equip")) {
            pPanel.AddClass("potential_drop_target");
          }
        });
        libs.setProp(_el$87, "onDragLeave", (pPanel, draggedPanel) => {
          pPanel.RemoveClass("potential_drop_target");
        });
        libs.setProp(_el$87, "onDragDrop", (panel, draggedPanel) => {
          let equip = LoadData(draggedPanel, "equip");
          if (!equip) return;
          setSelectedItemID(equip);
        });
        libs.insert(_el$89, libs.createComponent(libs.Show, {
          get when() {
            return libs.memo(() => !!showGemDisplayData())() ? displayGemData() : displayData();
          },
          get fallback() {
            return (() => {
              const _el$98 = libs.createElement("Panel", {
                  id: "EmptyState"
                }, null);
                libs.createElement("Panel", {
                  id: "EmptyIcon"
                }, _el$98);
                const _el$100 = libs.createElement("Label", {
                  get text() {
                    return showGemDisplayData() ? "#Gem_SelectEmpty" : "#Equipment_SelectEmpty";
                  }
                }, _el$98);
              libs.effect(_$p => libs.setProp(_el$100, "text", showGemDisplayData() ? "#Gem_SelectEmpty" : "#Equipment_SelectEmpty", _$p));
              return _el$98;
            })();
          },
          get children() {
            return [(() => {
              const _el$90 = libs.createElement("Panel", {
                  id: "SelectEquipContainer"
                }, null);
                libs.createElement("DOTAParticleScenePanel", {
                  id: "EquipItemParticle",
                  particleName: "particles/ui/game/ui_game_general_special_effects_02_fx.vpcf",
                  cameraOrigin: "0 0 60",
                  fov: 40,
                  lookAt: "0 0 0",
                  hittest: false,
                  squarePixels: true
                }, _el$90);
                const _el$93 = libs.createElement("DOTAParticleScenePanel", {
                  id: "ForgeParticle",
                  particleName: "particles/ui/game/ui_game_equipment_interface_02_fx.vpcf",
                  cameraOrigin: "0 0 350",
                  fov: 90,
                  lookAt: "0 0 0",
                  hittest: false,
                  squarePixels: true
                }, _el$90);
              libs.setProp(_el$90, "onload", () => Game.EmitSound("ui.blacksmith_background"));
              libs.insert(_el$90, libs.createComponent(libs.Show, {
                get when() {
                  return showGemDisplayData();
                },
                get fallback() {
                  return (() => {
                    const _el$101 = libs.createElement("Panel", {
                      horizontalAlign: "center",
                      flowChildren: "down"
                    }, null);
                    libs.setProp(_el$101, "horizontalAlign", "center");
                    libs.setProp(_el$101, "flowChildren", "down");
                    libs.insert(_el$101, libs.createComponent(server_equipment.Equipment, libs.mergeProps$1(() => displayData(), {
                      onmouseover: p => {
                        const data = displayData();
                        if (data) {
                          equipment_utils.ShowServerEquipTooltip(p, {
                            id1: data.id,
                            hero_id: selectHeroID()
                          });
                        }
                      },
                      onmouseout: p => HideCustomTooltip(p, "server_equip")
                    })), null);
                    libs.insert(_el$101, libs.createComponent(libs.Show, {
                      get when() {
                        return InlayType() == "Inlay";
                      },
                      get children() {
                        const _el$102 = libs.createElement("Panel", {
                          id: "ForgeGemSlotList"
                        }, null);
                        libs.insert(_el$102, libs.createComponent(libs.For, {
                          get each() {
                            return Array.from({
                              length: inlayGemData().length
                            });
                          },
                          children: (_, index) => {
                            const slotData = () => gemData() ?? inlayGemData()[index()];
                            const emptySlot = () => slotData()?.gem_item_id == undefined;
                            const slotGemId = () => slotData()?.id;
                            const buildEmbeddedGemData = () => {
                              const embedded = inlayGemData()[index()];
                              if (!embedded || !embedded.gem_item_id) return undefined;
                              const parseEntries = v => {
                                if (!v) return [];
                                if (typeof v === "string") return JSON.parseSafe(v) ?? [];
                                return v;
                              };
                              return JSON.stringify({
                                ...embedded,
                                main_entry_data: parseEntries(embedded.main_entry_data),
                                adverb_entry_data: parseEntries(embedded.adverb_entry_data),
                                myth_entry_data: parseEntries(embedded.myth_entry_data),
                                chaos_entry_data: parseEntries(embedded.chaos_entry_data),
                                ability_entry_data: parseEntries(embedded.ability_entry_data)
                              });
                            };
                            return (() => {
                              const _el$103 = libs.createElement("Panel", {
                                get ["class"]() {
                                  return libs.classNames("GemSlot", {
                                    EmptySlot: emptySlot()
                                  });
                                }
                              }, null);
                              libs.setProp(_el$103, "onmouseover", p => {
                                if (!slotGemId()) {
                                  if (buildEmbeddedGemData()) {
                                    ShowCustomTooltip(p, "server_gem", {
                                      id1: "",
                                      id2: "",
                                      embedded_gem_data: buildEmbeddedGemData()
                                    });
                                  }
                                } else {
                                  equipment_utils.ShowServerGemTooltip(p, {
                                    id1: slotGemId(),
                                    embeddedGemData: buildEmbeddedGemData()
                                  });
                                }
                              });
                              libs.setProp(_el$103, "onmouseout", p => HideCustomTooltip(p, "server_gem"));
                              libs.setProp(_el$103, "onactivate", () => {
                                setSelectGemSlot(index());
                                setSelectedGemList([]);
                              });
                              libs.insert(_el$103, libs.createComponent(libs.Show, {
                                get when() {
                                  return !emptySlot();
                                },
                                get children() {
                                  return libs.createComponent(server_equipment.Gem, libs.mergeProps$1(slotData));
                                }
                              }));
                              libs.effect(_$p => libs.setProp(_el$103, "class", libs.classNames("GemSlot", {
                                EmptySlot: emptySlot()
                              }), _$p));
                              return _el$103;
                            })();
                          }
                        }));
                        return _el$102;
                      }
                    }), null);
                    return _el$101;
                  })();
                },
                get children() {
                  const _el$92 = libs.createElement("Panel", {}, null);
                  libs.setProp(_el$92, "onmouseover", p => {
                    const gem = displayGemData();
                    if (gem && gem != "undefined") {
                      equipment_utils.ShowServerGemTooltip(p, {
                        id1: gem.id
                      });
                    }
                  });
                  libs.setProp(_el$92, "onmouseout", p => HideCustomTooltip(p, "server_gem"));
                  libs.insert(_el$92, libs.createComponent(server_equipment.Gem, libs.mergeProps$1(() => displayGemData())));
                  return _el$92;
                }
              }), _el$93);
              const _ref$2 = forgeParticle;
              typeof _ref$2 === "function" ? libs.use(_ref$2, _el$93) : forgeParticle = _el$93;
              return _el$90;
            })(), libs.createComponent(libs.Show, {
              get when() {
                return !forgeChildTab();
              },
              get fallback() {
                return leftExtraContent();
              },
              get children() {
                const _el$94 = libs.createElement("Panel", {
                  id: "NewBtnListContainer"
                }, null);
                libs.insert(_el$94, libs.createComponent(libs.For, {
                  get each() {
                    return newTabs();
                  },
                  children: (tab, index) => {
                    const disableReasons = libs.createMemo(() => {
                      if (showGemDisplayData()) {
                        const gem = displayGemData();
                        if (!gem || gem == "undefined") return [{
                          key: "#Equipment_TextTips_NoData"
                        }];
                        return getGemDisableReasons(gem, tab);
                      } else {
                        const equip = displayData();
                        if (!equip) return [{
                          key: "#Equipment_TextTips_NoData"
                        }];
                        return getEquipDisableReasons(equip, tab);
                      }
                    });
                    const isTabEnabled = () => disableReasons().length === 0;
                    return (() => {
                      const _el$104 = libs.createElement("Panel", {
                          get ["class"]() {
                            return libs.classNames("OperateBtn", tab);
                          },
                          get animationDelay() {
                            return "0s," + 0.03 * index() + "s";
                          },
                          get animationDuration() {
                            return 0.03 * index() + "s, 0.5s";
                          }
                        }, null),
                        _el$105 = libs.createElement("Panel", {
                          id: "BtnImg"
                        }, _el$104),
                        _el$106 = libs.createElement("Panel", {
                          id: "TabName"
                        }, _el$104),
                        _el$107 = libs.createElement("Label", {
                          text: "#Equipment_" + tab
                        }, _el$106);
                        libs.createElement("Panel", {
                          id: "Border",
                          hittest: false
                        }, _el$104);
                        libs.createElement("Panel", {
                          id: "LockIcon",
                          hittest: false
                        }, _el$104);
                      libs.setProp(_el$104, "onactivate", () => {
                        if (!isTabEnabled()) return;
                        setForgeChildTab(tab);
                      });
                      libs.setProp(_el$105, "onmouseover", p => {
                        const tipsKey = tabTipsMap[tab];
                        const parts = [];
                        if (tipsKey) parts.push(GetLocalization(tipsKey));
                        if (parts.length > 0) {
                          ShowCustomTooltip(p, "text", {
                            text: parts.join("<br>")
                          });
                        }
                      });
                      libs.setProp(_el$105, "onmouseout", p => {
                        HideCustomTooltip(p, "text");
                      });
                      libs.setProp(_el$107, "text", "#Equipment_" + tab);
                      libs.effect(_p$ => {
                        const _v$17 = libs.classNames("OperateBtn", tab),
                          _v$18 = "0s," + 0.03 * index() + "s",
                          _v$19 = 0.03 * index() + "s, 0.5s",
                          _v$20 = isTabEnabled();
                        _v$17 !== _p$._v$17 && (_p$._v$17 = libs.setProp(_el$104, "class", _v$17, _p$._v$17));
                        _v$18 !== _p$._v$18 && (_p$._v$18 = libs.setProp(_el$104, "animationDelay", _v$18, _p$._v$18));
                        _v$19 !== _p$._v$19 && (_p$._v$19 = libs.setProp(_el$104, "animationDuration", _v$19, _p$._v$19));
                        _v$20 !== _p$._v$20 && (_p$._v$20 = libs.setProp(_el$104, "enabled", _v$20, _p$._v$20));
                        return _p$;
                      }, {
                        _v$17: undefined,
                        _v$18: undefined,
                        _v$19: undefined,
                        _v$20: undefined
                      });
                      return _el$104;
                    })();
                  }
                }));
                return _el$94;
              }
            })];
          }
        }));
        libs.insert(_el$87, libs.createComponent(libs.Show, {
          get when() {
            return libs.memo(() => selectedItemTab() === "gem")() ? displayGemData() != undefined : displayData() != undefined;
          },
          get children() {
            const _el$95 = libs.createElement("Panel", {
              id: "EquipInfoContainer"
            }, null);
            libs.insert(_el$95, libs.createComponent(libs.Switch, {
              get children() {
                return [libs.createComponent(libs.Match, {
                  get when() {
                    return forgeChildTab() == "ClassUP";
                  },
                  get children() {
                    return libs.createComponent(ClassUPWindow, {
                      itemData: displayData,
                      setLeftExtraContent: setLeftExtraContent,
                      startForgeAnimation: startForgeAnimation,
                      onReturn: onReturn
                    });
                  }
                }), libs.createComponent(libs.Match, {
                  get when() {
                    return forgeChildTab() == "RarityUP";
                  },
                  get children() {
                    return libs.createComponent(RarityUPWindow, {
                      itemData: displayData,
                      setLeftExtraContent: setLeftExtraContent,
                      startForgeAnimation: startForgeAnimation,
                      onReturn: onReturn
                    });
                  }
                }), libs.createComponent(libs.Match, {
                  get when() {
                    return forgeChildTab() == "Recast";
                  },
                  get children() {
                    return libs.createComponent(RecastWindow, {
                      itemData: displayData,
                      setLeftExtraContent: setLeftExtraContent,
                      startForgeAnimation: startForgeAnimation,
                      onReturn: onReturn
                    });
                  }
                }), libs.createComponent(libs.Match, {
                  get when() {
                    return forgeChildTab() == "Refine";
                  },
                  get children() {
                    return libs.createComponent(RefineWindow, {
                      itemData: displayData,
                      setLeftExtraContent: setLeftExtraContent,
                      startForgeAnimation: startForgeAnimation,
                      onReturn: onReturn
                    });
                  }
                }), libs.createComponent(libs.Match, {
                  get when() {
                    return forgeChildTab() == "Inlay";
                  },
                  get children() {
                    return libs.createComponent(InlayWindow, {
                      itemData: displayData,
                      setLeftExtraContent: setLeftExtraContent,
                      startForgeAnimation: startForgeAnimation,
                      onReturn: onReturn,
                      gemData: displayGemData,
                      selectGemSlot: selectGemSlot,
                      setSelectGemSlot: setSelectGemSlot
                    });
                  }
                }), libs.createComponent(libs.Match, {
                  get when() {
                    return forgeChildTab() == "GemLevelUP";
                  },
                  get children() {
                    return libs.createComponent(GemLevelvpWindow, {
                      itemData: displayData,
                      gemData: displayGemData,
                      setLeftExtraContent: setLeftExtraContent,
                      startForgeAnimation: startForgeAnimation,
                      onReturn: onReturn
                    });
                  }
                }), libs.createComponent(libs.Match, {
                  get when() {
                    return forgeChildTab() == "GemMake";
                  },
                  get children() {
                    return libs.createComponent(GemMakeWindow, {
                      gemData: displayGemData,
                      setLeftExtraContent: setLeftExtraContent,
                      startForgeAnimation: startForgeAnimation,
                      onReturn: onReturn
                    });
                  }
                })];
              }
            }));
            libs.effect(_$p => libs.setProp(_el$95, "visible", hiddenItemList(), _$p));
            return _el$95;
          }
        }), null);
        libs.effect(_$p => libs.setProp(_el$89, "class", libs.classNames({
          ShowAnimState: showAnim()
        }), _$p));
        return _el$87;
      })(), (() => {
        const _el$96 = libs.createElement("DOTAParticleScenePanel", {
          id: "Chuizi",
          cameraOrigin: "0 0 750",
          fov: 120,
          lookAt: "0 0 0",
          hittest: false,
          particleName: "particles/ui/game/ui_game_equipment_interface_03_fx.vpcf",
          startActive: false,
          light: "light",
          camera: "camera_top",
          map: "scene/particle_scene",
          renderdeferred: false,
          deferredalpha: true,
          particleonly: false,
          squarePixels: true
        }, null);
        const _ref$3 = chuiziParticle;
        typeof _ref$3 === "function" ? libs.use(_ref$3, _el$96) : chuiziParticle = _el$96;
        return _el$96;
      })(), libs.createElement("DOTAParticleScenePanel", {
        id: "BottomParticle",
        particleName: "particles/ui/game/ui_game_equipment_interface_01_1_fx",
        cameraOrigin: "0 0 700",
        fov: 90,
        lookAt: "0 0 0",
        hittest: false,
        squarePixels: true
      }, null)];
    }
  });
}
libs.render(() => libs.createComponent(HudEquipment, {}), $.GetContextPanel());