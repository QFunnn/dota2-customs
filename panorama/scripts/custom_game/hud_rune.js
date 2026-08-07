--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var equipment_comp = require('./equipment_comp.js');
var EOM_MultiDropDown = require('./EOM_MultiDropDown.js');
var EOM_MenuLayout = require('./EOM_MenuLayout.js');
var Player = require('./Player.js');
var RecycleView = require('./RecycleView.js');
var equipment_utils = require('./equipment_utils.js');
var rune_data = require('./rune_data.js');
var solid_utils = require('./solid_utils.js');
var EOM_Button = require('./EOM_Button.js');
var EOM_DropDown = require('./EOM_DropDown.js');
var rune_components = require('./rune_components.js');
var hero_selection_bar = require('./hero_selection_bar.js');
var global_selection = require('./global_selection.js');
require('./service_netdata_helper.js');
require('./EOM_RedMark.js');
require('./EOM_TextEntry.js');
require('./attribute_formatter.js');
require('./EOM_HeroImage.js');

const EMPTY_SLOT_NUM = 5;
const BREAK_ATTR_LIST = Object.values(KeyValues.rune_break_level_exp).sort((a, b) => a.level - b.level);
const MAX_LEVEL = BREAK_ATTR_LIST[BREAK_ATTR_LIST.length - 1]?.level ?? 0;
const FIRST_LEVEL_EXP = KeyValues.rune_break_level_exp[1]?.exp ?? BREAK_ATTR_LIST[0]?.exp ?? 0;
const RUNE_RARITY_OPTIONS = Object.values(KeyValues.rune_rarity_setting).sort((a, b) => a.rarity - b.rarity);
const RUNE_BREAK_EXP_ITEM_ID = "200002";
const getRuneBreakEffects = effect => {
  if (effect == undefined) {
    return [];
  }
  return Object.entries(effect).map(([name, value]) => ({
    name,
    value: Number(value)
  }));
};
const getRuneBreakExp = rune => {
  if (rune == undefined) {
    return 0;
  }
  const bonus = KeyValues.rune_rarity_setting[rune.rarity]?.break_bonus;
  if (bonus == undefined) {
    return 0;
  }
  return toFiniteNumber(bonus[RUNE_BREAK_EXP_ITEM_ID]);
};
const getRuneBreakLevelExp = level => {
  const data = KeyValues.rune_break_level_exp[level] ?? BREAK_ATTR_LIST.find(item => item.level === level);
  if (data != undefined) {
    return data.exp;
  }
  return KeyValues.rune_break_level_exp[level + 1]?.exp ?? FIRST_LEVEL_EXP;
};
const RuneBreakAttributeInfo = props => {
  let lvInfoListHandle;
  let lvInfoScrollSchedule;
  const addedAttr = libs.createMemo(() => {
    const effectAttr = {};
    for (const data of BREAK_ATTR_LIST) {
      if (data.level > props.currentLevel()) {
        continue;
      }
      for (const attr of getRuneBreakEffects(data.effect)) {
        effectAttr[attr.name] = toFiniteNumber(effectAttr[attr.name]) + attr.value;
      }
    }
    return Object.entries(effectAttr).map(([name, value]) => ({
      name,
      value
    }));
  });
  function scrollToCurrentLv(bNoSmooth = false) {
    const index = BREAK_ATTR_LIST.findIndex(data => data.level == props.currentLevel());
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
  libs.createEffect(libs.on(props.currentLevel, () => {
    scheduleScrollToCurrentLv();
  }));
  libs.onCleanup(() => {
    if (lvInfoScrollSchedule != undefined) {
      try {
        $.CancelScheduled(lvInfoScrollSchedule);
      } catch (error) {}
    }
  });
  return (() => {
    const _el$ = libs.createElement("Panel", {
        id: "RuneBreakAttributeRoot"
      }, null),
      _el$2 = libs.createElement("Panel", {
        id: "AttributeLvInfo"
      }, _el$),
      _el$3 = libs.createElement("Panel", {
        id: "AddedAttrList",
        scroll: "y",
        "class": "VerticalScrollStyle"
      }, _el$2);
    libs.insert(_el$2, libs.createComponent(RecycleView.RecycleView, {
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
        const attrs = libs.createMemo(() => getRuneBreakEffects(dataAccessor().effect));
        return (() => {
          const _el$4 = libs.createElement("Panel", {
              get style() {
                return {
                  zIndex: MAX_LEVEL - dataAccessor().level
                };
              },
              get ["class"]() {
                return libs.classNames("LvInfoItemContainer", {
                  Unlock: props.currentLevel() >= dataAccessor().level,
                  Currentlv: props.currentLevel() == dataAccessor().level,
                  Last: dataAccessor().level == MAX_LEVEL
                });
              }
            }, null),
            _el$5 = libs.createElement("Panel", {
              id: "LvInfo"
            }, _el$4),
            _el$6 = libs.createElement("Label", {
              id: "Level",
              get text() {
                return dataAccessor().level;
              }
            }, _el$5),
            _el$7 = libs.createElement("Panel", {
              align: "center center",
              flowChildren: "down"
            }, _el$5);
            libs.createElement("Panel", {
              id: "Line"
            }, _el$4);
          libs.setProp(_el$7, "align", "center center");
          libs.setProp(_el$7, "flowChildren", "down");
          libs.insert(_el$7, libs.createComponent(libs.For, {
            get each() {
              return attrs();
            },
            children: attr => (() => {
              const _el$9 = libs.createElement("Label", {
                id: "Attr",
                get text() {
                  return GetPropertyLocalization(attr.name, attr.value);
                },
                html: true
              }, null);
              libs.effect(_$p => libs.setProp(_el$9, "text", GetPropertyLocalization(attr.name, attr.value), _$p));
              return _el$9;
            })()
          }));
          libs.effect(_p$ => {
            const _v$ = {
                zIndex: MAX_LEVEL - dataAccessor().level
              },
              _v$2 = libs.classNames("LvInfoItemContainer", {
                Unlock: props.currentLevel() >= dataAccessor().level,
                Currentlv: props.currentLevel() == dataAccessor().level,
                Last: dataAccessor().level == MAX_LEVEL
              }),
              _v$3 = dataAccessor().level;
            _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$4, "style", _v$, _p$._v$));
            _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$4, "class", _v$2, _p$._v$2));
            _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$6, "text", _v$3, _p$._v$3));
            return _p$;
          }, {
            _v$: undefined,
            _v$2: undefined,
            _v$3: undefined
          });
          return _el$4;
        })();
      }
    }), _el$3);
    libs.insert(_el$2, libs.createComponent(equipment_comp.EquipSeparator, {
      id: "LvInfoSeparator",
      text: "#RuneBreak_CurrentAttributes"
    }), _el$3);
    libs.setProp(_el$3, "scroll", "y");
    libs.insert(_el$3, libs.createComponent(libs.Show, {
      get when() {
        return addedAttr().length > 0;
      },
      get fallback() {
        return libs.createElement("Label", {
          "class": "AttrLabel",
          text: "#RuneBreak_CurrentAttributesEmpty"
        }, null);
      },
      get children() {
        return libs.createComponent(libs.For, {
          get each() {
            return addedAttr();
          },
          children: attr => (() => {
            const _el$1 = libs.createElement("Label", {
              "class": "AttrLabel",
              get text() {
                return GetPropertyLocalization(attr.name, attr.value);
              },
              html: true
            }, null);
            libs.effect(_$p => libs.setProp(_el$1, "text", GetPropertyLocalization(attr.name, attr.value), _$p));
            return _el$1;
          })()
        });
      }
    }));
    return _el$;
  })();
};
const RuneBreak = props => {
  const [fastAddRarity, setFastAddRarity] = libs.createSignal(0);
  const selectedRunes = libs.createMemo(() => props.breakRunes().filter(rune => rune != undefined));
  const addedExp = libs.createMemo(() => selectedRunes().reduce((result, rune) => result + getRuneBreakExp(rune), 0));
  const getBreakWindowClass = libs.createMemo(() => {
    const level = props.currentLevel();
    if (level < 10) {
      return "Level_1_9";
    }
    if (level < 20) {
      return "Level_10_19";
    }
    return "Level_20";
  });
  const target = libs.createMemo(() => {
    const currentLevel = Math.min(props.currentLevel(), MAX_LEVEL);
    if (currentLevel >= MAX_LEVEL) {
      return {
        addedLevel: 0,
        finalLevel: currentLevel,
        finalExp: props.currentExp(),
        finalProgress: 100,
        realProgress: 100
      };
    }
    let finalExp = props.currentExp() + addedExp();
    let finalLevel = currentLevel;
    let addedLevel = 0;
    while (finalLevel < MAX_LEVEL) {
      const levelExp = getRuneBreakLevelExp(finalLevel);
      if (levelExp <= 0 || finalExp < levelExp) {
        break;
      }
      finalExp -= levelExp;
      finalLevel++;
      addedLevel++;
    }
    const currentLevelExp = getRuneBreakLevelExp(currentLevel);
    const finalLevelExp = getRuneBreakLevelExp(finalLevel);
    const realProgress = currentLevelExp > 0 ? Math.min(100, props.currentExp() / currentLevelExp * 100) : 100;
    const finalProgress = finalLevel >= MAX_LEVEL ? 100 : finalLevelExp > 0 ? Math.min(100, finalExp / finalLevelExp * 100) : 100;
    return {
      addedLevel,
      finalLevel,
      finalExp,
      finalProgress: addedLevel > 0 ? 100 : finalProgress,
      realProgress
    };
  });
  const currentMaxExp = libs.createMemo(() => getRuneBreakLevelExp(Math.min(props.currentLevel(), MAX_LEVEL)));
  const hasSelectedRunes = libs.createMemo(() => selectedRunes().length > 0);
  let expBar;
  let expAnimBar;
  let expLabel;
  let breakParticle;
  let curStack = 0;
  let targetStack = 0;
  let barProgress = 0;
  let targetProgress = 0;
  let prevAddedExp = 0;
  let shouldStopAt100 = false;
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
  libs.createEffect(() => {
    const currentTarget = target();
    const added = addedExp();
    if (added > 0) {
      const currentLevel = Math.min(props.currentLevel(), MAX_LEVEL);
      const currentLevelExp = getRuneBreakLevelExp(currentLevel);
      const startProgress = currentLevelExp > 0 ? Math.min(100, props.currentExp() / currentLevelExp * 100) : 100;
      if (prevAddedExp === 0) {
        barProgress = startProgress;
        curStack = 0;
      }
    } else {
      barProgress = 0;
      curStack = 0;
      shouldStopAt100 = false;
    }
    prevAddedExp = added;
    targetStack = currentTarget.addedLevel > 0 ? 1 : 0;
    targetProgress = currentTarget.addedLevel > 0 ? 100 : currentTarget.finalProgress;
    shouldStopAt100 = currentTarget.addedLevel > 0;
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
      const realLv = Math.min(props.currentLevel(), MAX_LEVEL);
      const realLvExp = getRuneBreakLevelExp(realLv);
      const realProgress = realLv >= MAX_LEVEL ? 100 : realLvExp > 0 ? Math.min(100, props.currentExp() / realLvExp * 100) : 100;
      if (expBar != undefined) {
        expBar.style.clip = `rect( 0%, ${realProgress}%, 100%, 0% )`;
      }
      if (addedExp() > 0 && expAnimBar) {
        expAnimBar.style.clip = `rect( 0%, ${barProgress}%, 100%, 0% )`;
      } else if (expAnimBar) {
        expAnimBar.style.clip = `rect( 0%, 0%, 100%, 0% )`;
      }
      if (expLabel) {
        if (props.currentLevel() < MAX_LEVEL) {
          expLabel.text = `${props.currentExp()}/${realLvExp}`;
        } else {
          expLabel.text = `${props.currentExp()}`;
        }
      }
    }, 10);
    libs.onCleanup(() => {
      clearInterval(timer);
    });
  });
  libs.onCleanup(() => {
    if (breakParticleSchedule != undefined) {
      try {
        $.CancelScheduled(breakParticleSchedule);
      } catch (error) {}
    }
  });
  const handleSlotDragEnter = (panel, draggedPanel) => {
    const runeID = Number(LoadData(draggedPanel, "rune")) || 0;
    if (runeID <= 0 || props.requesting()) {
      return;
    }
    panel.AddClass("DropTarget");
  };
  const handleSlotDragLeave = panel => {
    panel.RemoveClass("DropTarget");
  };
  const handleSlotDragDrop = (slot, panel, draggedPanel) => {
    panel.RemoveClass("DropTarget");
    const runeID = Number(LoadData(draggedPanel, "rune")) || 0;
    if (runeID <= 0 || props.requesting()) {
      return;
    }
    props.onDropRune(slot, runeID);
  };
  return (() => {
    const _el$10 = libs.createElement("Panel", {
        id: "RuneBreakRoot",
        "class": "RuneContentSubRoot"
      }, null),
      _el$11 = libs.createElement("Panel", {
        id: "RuneBreakContent"
      }, _el$10),
      _el$12 = libs.createElement("Panel", {
        id: "ClickPanel",
        get onactivate() {
          return props.onShowBreakAttrs;
        }
      }, _el$11),
      _el$13 = libs.createElement("Panel", {
        id: "RuneBreakWindow",
        get ["class"]() {
          return libs.classNames(getBreakWindowClass());
        }
      }, _el$11),
      _el$14 = libs.createElement("Panel", {
        id: "BreakSlotsContainer"
      }, _el$13),
      _el$15 = libs.createElement("Panel", {
        id: "BreakSlots"
      }, _el$14);
      libs.createElement("Panel", {
        id: "CenterImage"
      }, _el$14);
      const _el$17 = libs.createElement("DOTAParticleScenePanel", {
        id: "BreakForgeParticle",
        particleName: "particles/ui/game/ui_game_equipment_interface_02_fx.vpcf",
        cameraOrigin: "0 0 250",
        fov: 90,
        lookAt: "0 0 0",
        hittest: false,
        squarePixels: true
      }, _el$14),
      _el$18 = libs.createElement("Panel", {
        id: "LevelInfo"
      }, _el$14),
      _el$19 = libs.createElement("Panel", {
        width: "100%",
        verticalAlign: "center",
        flowChildren: "down"
      }, _el$18),
      _el$20 = libs.createElement("Label", {
        verticalAlign: "center",
        text: "#RuneBreak_Level"
      }, _el$19),
      _el$21 = libs.createElement("Label", {
        get text() {
          return `Lv.${props.currentLevel()}${target().addedLevel > 0 ? ToColor(`+${target().addedLevel}`, "#53b646") : ""}`;
        },
        html: true
      }, _el$19),
      _el$22 = libs.createElement("Panel", {
        "class": "ToolTipInfo",
        get onactivate() {
          return props.onToggleBreakAttrs;
        }
      }, _el$18),
      _el$23 = libs.createElement("Panel", {
        id: "FastAdd"
      }, _el$13),
      _el$25 = libs.createElement("Panel", {
        id: "ExpBarContainer"
      }, _el$13),
      _el$26 = libs.createElement("Image", {
        id: "ExpAnimBar"
      }, _el$25),
      _el$27 = libs.createElement("Image", {
        id: "ExpBar"
      }, _el$25),
      _el$28 = libs.createElement("Label", {
        id: "CurExp",
        get text() {
          return libs.memo(() => props.currentLevel() < MAX_LEVEL)() ? `${props.currentExp()}/${currentMaxExp()}` : `${props.currentExp()}`;
        }
      }, _el$25),
      _el$29 = libs.createElement("Label", {
        id: "AddexExp",
        get text() {
          return `+${addedExp()}`;
        }
      }, _el$25),
      _el$31 = libs.createElement("Panel", {
        id: "BreakReward"
      }, _el$13);
      libs.createElement("Label", {
        id: "TipsText",
        text: "#RuneBreak_ItemReturn"
      }, _el$31);
      const _el$33 = libs.createElement("Panel", {
        id: "BreakRewardList",
        flowChildren: "right"
      }, _el$31);
    libs.insert(_el$15, libs.createComponent(libs.For, {
      get each() {
        return Array(EMPTY_SLOT_NUM);
      },
      children: (_, idx) => {
        const slotRune = () => props.breakRunes()[idx()];
        return (() => {
          const _el$34 = libs.createElement("Panel", {
              get id() {
                return "BreakSlot" + idx();
              },
              get ["class"]() {
                return libs.classNames("BreakSlot", {
                  Select: idx() == props.selectedBreakSlot()
                });
              }
            }, null);
            libs.createElement("Panel", {
              id: "Selected"
            }, _el$34);
          libs.setProp(_el$34, "onDragEnter", (panel, draggedPanel) => {
            handleSlotDragEnter(panel, draggedPanel);
          });
          libs.setProp(_el$34, "onDragLeave", panel => {
            handleSlotDragLeave(panel);
          });
          libs.setProp(_el$34, "onDragDrop", (panel, draggedPanel) => {
            handleSlotDragDrop(idx(), panel, draggedPanel);
          });
          libs.setProp(_el$34, "onactivate", () => {
            props.onSelectBreakSlot(idx());
          });
          libs.setProp(_el$34, "oncontextmenu", () => {
            props.onClearBreakSlot(idx());
          });
          libs.insert(_el$34, libs.createComponent(libs.Show, {
            get when() {
              return slotRune();
            },
            get fallback() {
              return libs.createElement("Panel", {
                id: "Empty"
              }, null);
            },
            get children() {
              const _el$36 = libs.createElement("Panel", {
                  get ["class"]() {
                    return `RuneBreakSlotIconRoot Rarity${slotRune().rarity}`;
                  }
                }, null),
                _el$37 = libs.createElement("Image", {
                  "class": "RuneBreakSlotIcon",
                  get src() {
                    return rune_data.getRuneIconPath(slotRune());
                  }
                }, _el$36);
              libs.effect(_p$ => {
                const _v$1 = `RuneBreakSlotIconRoot Rarity${slotRune().rarity}`,
                  _v$10 = rune_data.getRuneIconPath(slotRune());
                _v$1 !== _p$._v$1 && (_p$._v$1 = libs.setProp(_el$36, "class", _v$1, _p$._v$1));
                _v$10 !== _p$._v$10 && (_p$._v$10 = libs.setProp(_el$37, "src", _v$10, _p$._v$10));
                return _p$;
              }, {
                _v$1: undefined,
                _v$10: undefined
              });
              return _el$36;
            }
          }), null);
          libs.effect(_p$ => {
            const _v$11 = "BreakSlot" + idx(),
              _v$12 = libs.classNames("BreakSlot", {
                Select: idx() == props.selectedBreakSlot()
              });
            _v$11 !== _p$._v$11 && (_p$._v$11 = libs.setProp(_el$34, "id", _v$11, _p$._v$11));
            _v$12 !== _p$._v$12 && (_p$._v$12 = libs.setProp(_el$34, "class", _v$12, _p$._v$12));
            return _p$;
          }, {
            _v$11: undefined,
            _v$12: undefined
          });
          return _el$34;
        })();
      }
    }));
    const _ref$ = breakParticle;
    typeof _ref$ === "function" ? libs.use(_ref$, _el$17) : breakParticle = _el$17;
    libs.setProp(_el$19, "width", "100%");
    libs.setProp(_el$19, "verticalAlign", "center");
    libs.setProp(_el$19, "flowChildren", "down");
    libs.setProp(_el$20, "verticalAlign", "center");
    libs.setProp(_el$22, "tooltip_text", "#RuneBreak_LevelDescription");
    libs.insert(_el$23, libs.createComponent(EOM_DropDown.EOM_DropDown, {
      type: "EquipmentDropDown",
      get index() {
        return fastAddRarity();
      },
      menuPosition: "top",
      onChange: index => {
        setFastAddRarity(index);
      },
      get children() {
        return [libs.createElement("Label", {
          text: "#RuneBreak_FilterAll"
        }, null), libs.createComponent(libs.For, {
          each: RUNE_RARITY_OPTIONS,
          children: (rarity, idx) => (() => {
            const _el$39 = libs.createElement("Label", {
              get style() {
                return {
                  color: equipment_utils.EQUIP_RARITY_COLOR[idx()]
                };
              },
              get text() {
                return `#RuneBreak_RuneRarity${rarity.rarity}`;
              }
            }, null);
            libs.effect(_p$ => {
              const _v$13 = {
                  color: equipment_utils.EQUIP_RARITY_COLOR[idx()]
                },
                _v$14 = `#RuneBreak_RuneRarity${rarity.rarity}`;
              _v$13 !== _p$._v$13 && (_p$._v$13 = libs.setProp(_el$39, "style", _v$13, _p$._v$13));
              _v$14 !== _p$._v$14 && (_p$._v$14 = libs.setProp(_el$39, "text", _v$14, _p$._v$14));
              return _p$;
            }, {
              _v$13: undefined,
              _v$14: undefined
            });
            return _el$39;
          })()
        })];
      }
    }), null);
    libs.insert(_el$23, libs.createComponent(equipment_comp.EquipmentCommonBtn, {
      text: "#RuneBreak_FastAdd",
      get enabled() {
        return !props.requesting();
      },
      onactivate: () => {
        const rarity = fastAddRarity() == 0 ? 0 : RUNE_RARITY_OPTIONS[fastAddRarity() - 1]?.rarity ?? 0;
        props.onFastAdd(rarity);
      }
    }), null);
    const _ref$2 = expAnimBar;
    typeof _ref$2 === "function" ? libs.use(_ref$2, _el$26) : expAnimBar = _el$26;
    const _ref$3 = expBar;
    typeof _ref$3 === "function" ? libs.use(_ref$3, _el$27) : expBar = _el$27;
    const _ref$4 = expLabel;
    typeof _ref$4 === "function" ? libs.use(_ref$4, _el$28) : expLabel = _el$28;
    libs.insert(_el$25, libs.createComponent(libs.Show, {
      get when() {
        return target().addedLevel > 0;
      },
      get children() {
        return libs.createElement("Panel", {
          id: "UpgradeIcon"
        }, null);
      }
    }), null);
    libs.setProp(_el$33, "flowChildren", "right");
    libs.insert(_el$13, libs.createComponent(EOM_Button.EOM_Button, {
      id: "ConfirmBtn",
      get enabled() {
        return libs.memo(() => !!hasSelectedRunes())() && !props.requesting();
      },
      color: "Confirm",
      text: "#RuneBreak_Dismantle",
      onactivate: () => props.onConfirm(playBreakParticle)
    }), null);
    libs.effect(_p$ => {
      const _v$4 = props.onShowBreakAttrs,
        _v$5 = libs.classNames(getBreakWindowClass()),
        _v$6 = `Lv.${props.currentLevel()}${target().addedLevel > 0 ? ToColor(`+${target().addedLevel}`, "#53b646") : ""}`,
        _v$7 = props.onToggleBreakAttrs,
        _v$8 = libs.memo(() => props.currentLevel() < MAX_LEVEL)() ? `${props.currentExp()}/${currentMaxExp()}` : `${props.currentExp()}`,
        _v$9 = addedExp() > 0,
        _v$0 = `+${addedExp()}`;
      _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$12, "onactivate", _v$4, _p$._v$4));
      _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$13, "class", _v$5, _p$._v$5));
      _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$21, "text", _v$6, _p$._v$6));
      _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$22, "onactivate", _v$7, _p$._v$7));
      _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$28, "text", _v$8, _p$._v$8));
      _v$9 !== _p$._v$9 && (_p$._v$9 = libs.setProp(_el$29, "visible", _v$9, _p$._v$9));
      _v$0 !== _p$._v$0 && (_p$._v$0 = libs.setProp(_el$29, "text", _v$0, _p$._v$0));
      return _p$;
    }, {
      _v$4: undefined,
      _v$5: undefined,
      _v$6: undefined,
      _v$7: undefined,
      _v$8: undefined,
      _v$9: undefined,
      _v$0: undefined
    });
    return _el$10;
  })();
};

const PHASES = {
  Select: "Select",
  PeekDone: "PeekDone",
  Preview: "Preview"
};
const parseDevourCosts = () => {
  const rawValue = GameUI.CustomUIConfig().rune_setting?.rune_devour?.value ?? "";
  if (rawValue === "") {
    return [];
  }
  return rawValue.split("|").map(costText => {
    const [itemIDText, amountText] = costText.split(":");
    return {
      itemID: toFiniteNumber(itemIDText, 0),
      amount: toFiniteNumber(amountText, 0)
    };
  }).filter(cost => cost.itemID > 0 && cost.amount > 0);
};
const isEntryChanged = (before, after) => {
  return JSON.stringify(before) !== JSON.stringify(after);
};
const isPlayerRuneResultValue = value => {
  return value !== "nil";
};
const RuneDevour = props => {
  const playerPropertyData = solid_utils.createPlayerPropertyData(() => Players.GetLocalPlayer());
  const playerTokens = solid_utils.createServiceNetData("player_tokens", {});
  const playerRunes = solid_utils.createServiceNetData("player_runes", {});
  const playerRuneResults = solid_utils.createServiceNetData("player_devour_rune_results", {});
  const [selectedEntry, setSelectedEntry] = libs.createSignal();
  const [lockedAdverbEntryKeys, setLockedAdverbEntryKeys] = libs.createSignal(new Set());
  const getSelectionPhase = () => {
    return props.rightRune != undefined && selectedEntry() != undefined ? PHASES.PeekDone : PHASES.Select;
  };
  const runeMap = libs.createMemo(() => {
    return rune_data.buildRuneBagItems(playerRunes()).reduce((result, rune) => {
      result[rune.id] = rune;
      return result;
    }, {});
  });
  const previewResult = libs.createMemo(() => {
    const result = Object.values(playerRuneResults()).find(isPlayerRuneResultValue);
    return result;
  });
  const previewRuneID = libs.createMemo(() => previewResult()?.id);
  const oldRune = libs.createMemo(() => {
    const runeID = previewRuneID();
    if (runeID == undefined) {
      return undefined;
    }
    return runeMap()[runeID];
  });
  const isPreviewing = libs.createMemo(() => previewResult() != undefined);
  const phase = libs.createMemo(() => {
    if (isPreviewing()) {
      return PHASES.Preview;
    }
    return getSelectionPhase();
  });
  const devourCosts = libs.createMemo(() => {
    const tokenData = playerTokens();
    return parseDevourCosts().map(cost => ({
      ...cost,
      insufficient: (tokenData?.[cost.itemID]?.amounts ?? 0) < cost.amount
    }));
  });
  const insufficientCost = libs.createMemo(() => devourCosts().some(cost => cost.insufficient));
  const runeDevourLockLimit = libs.createMemo(() => {
    return toFiniteNumber(playerPropertyData().rune_devour_lock, 0);
  });
  const showAdverbEntryLockSelection = libs.createMemo(() => runeDevourLockLimit() > 0);
  const leftAdverbEntryCount = libs.createMemo(() => props.leftRune?.adverb_entry_data?.length ?? 0);
  const lockedTargetAdverbIndexes = libs.createMemo(() => {
    const maxIndex = leftAdverbEntryCount();
    return [...lockedAdverbEntryKeys()].map(entryKey => {
      const match = entryKey.match(/^adverb:(\d+)$/);
      return match == undefined ? undefined : toFiniteNumber(match[1], -1);
    }).filter(index => index != undefined && index >= 0 && index < maxIndex).sort((a, b) => a - b);
  });
  const selectedEntryKey = libs.createMemo(() => {
    if (isPreviewing()) {
      return undefined;
    }
    return selectedEntry()?.entryKey;
  });
  const rightDisplayRune = libs.createMemo(() => {
    if (isPreviewing()) {
      return oldRune();
    }
    return props.rightRune;
  });
  const allowEntrySelection = libs.createMemo(() => {
    return !isPreviewing() && !props.requesting();
  });
  const allowAdverbEntryLock = libs.createMemo(() => {
    return !isPreviewing() && !props.requesting();
  });
  const allowRuneRemove = libs.createMemo(() => {
    return !isPreviewing() && !props.requesting();
  });
  const resetRoundState = () => {
    setSelectedEntry(undefined);
    setLockedAdverbEntryKeys(new Set());
  };
  const leftDisplayRune = libs.createMemo(() => {
    const leftRune = isPreviewing() ? oldRune() : props.leftRune;
    const preview = previewResult();
    if (leftRune == undefined || preview == undefined || !isPreviewing()) {
      return leftRune;
    }
    return {
      ...leftRune,
      main_entry_data: preview.main_entry_data,
      adverb_entry_data: preview.adverb_entry_data,
      rune_suit_data: preview.rune_suit_data
    };
  });
  const changedEntryKeys = libs.createMemo(() => {
    const before = oldRune();
    const after = leftDisplayRune();
    const result = new Set();
    if (before == undefined || after == undefined || !isPreviewing()) {
      return result;
    }
    after.main_entry_data?.forEach((entry, index) => {
      if (isEntryChanged(before.main_entry_data?.[index], entry)) {
        result.add(`main:${index}`);
      }
    });
    after.adverb_entry_data?.forEach((entry, index) => {
      if (isEntryChanged(before.adverb_entry_data?.[index], entry)) {
        result.add(`adverb:${index}`);
      }
    });
    after.rune_suit_data?.forEach((entry, index) => {
      if (isEntryChanged(before.rune_suit_data?.[index], entry)) {
        result.add(`suit:${index}`);
      }
    });
    return result;
  });
  let lastRightRuneID = props.rightRune?.id;
  libs.createEffect(() => {
    const rightRuneID = props.rightRune?.id;
    if (isPreviewing() || props.requesting()) {
      lastRightRuneID = rightRuneID;
      return;
    }
    if (rightRuneID !== lastRightRuneID) {
      setSelectedEntry(undefined);
    }
    lastRightRuneID = rightRuneID;
  });
  let lastLeftRuneID = props.leftRune?.id;
  libs.createEffect(() => {
    const leftRuneID = props.leftRune?.id;
    if (isPreviewing() || props.requesting()) {
      lastLeftRuneID = leftRuneID;
      return;
    }
    if (leftRuneID === lastLeftRuneID) {
      return;
    }
    resetRoundState();
    lastLeftRuneID = leftRuneID;
  });
  libs.createEffect(() => {
    const canLock = showAdverbEntryLockSelection();
    const entryCount = leftAdverbEntryCount();
    setLockedAdverbEntryKeys(currentKeys => {
      if (!canLock || entryCount <= 0) {
        return currentKeys.size === 0 ? currentKeys : new Set();
      }
      const nextKeys = new Set();
      currentKeys.forEach(entryKey => {
        const match = entryKey.match(/^adverb:(\d+)$/);
        const index = match == undefined ? -1 : toFiniteNumber(match[1], -1);
        if (index >= 0 && index < entryCount) {
          nextKeys.add(entryKey);
        }
      });
      return nextKeys.size === currentKeys.size ? currentKeys : nextKeys;
    });
  });
  let lastPreviewRuneID = previewRuneID();
  libs.createEffect(() => {
    const currentPreviewRuneID = previewRuneID();
    props.onPreviewingChange(currentPreviewRuneID != undefined);
    if (lastPreviewRuneID != undefined && currentPreviewRuneID == undefined) {
      resetRoundState();
      props.onResetSelection();
    }
    lastPreviewRuneID = currentPreviewRuneID;
  });
  const handleDevour = () => {
    const leftRune = props.leftRune;
    const rightRune = props.rightRune;
    const entry = selectedEntry();
    if (props.requesting() || leftRune == undefined || rightRune == undefined || entry == undefined) {
      return;
    }
    if (insufficientCost()) {
      ErrorMessage("#error_token_no_enough");
      return;
    }
    props.setRequesting(true);
    CallActionRequest("/v1/rune/devour", {
      entry_type: entry.entryType,
      target_rune_id: leftRune.id,
      devoured_rune_id: rightRune.id,
      devoured_entry_index: entry.entryIndex,
      locked_target_adverb_indexes: lockedTargetAdverbIndexes()
    }, result => {
      props.setRequesting(false);
      if (result.code !== 0) {
        if (result.message != undefined) {
          ErrorMessage(result.message);
        }
        return;
      }
    }, () => {
      props.setRequesting(false);
    });
  };
  const handleConfirmPreview = confirm => {
    const runeID = previewRuneID();
    if (props.requesting() || runeID == undefined) {
      return;
    }
    props.setRequesting(true);
    CallActionRequest("/v1/rune/devour_confirm", {
      rune_id: runeID,
      confirm
    }, result => {
      props.setRequesting(false);
      if (result.code !== 0) {
        if (result.message != undefined) {
          ErrorMessage(result.message);
        }
      }
    }, () => {
      props.setRequesting(false);
    });
  };
  const handleAdverbEntryLockToggle = entry => {
    if (!allowAdverbEntryLock() || !showAdverbEntryLockSelection() || entry.entryType !== 2) {
      return;
    }
    setLockedAdverbEntryKeys(currentKeys => {
      const nextKeys = new Set(currentKeys);
      if (nextKeys.has(entry.entryKey)) {
        nextKeys.delete(entry.entryKey);
        return nextKeys;
      }
      if (runeDevourLockLimit() === 1) {
        return new Set([entry.entryKey]);
      }
      const nextLockedCount = nextKeys.size + 1;
      if (nextLockedCount >= leftAdverbEntryCount()) {
        ErrorMessage("#RuneDevour_DevourLockAllNotAllow");
        return currentKeys;
      }
      if (nextLockedCount > runeDevourLockLimit()) {
        ErrorMessage("#RuneDevour_RuneDevourLockNotAllow");
        return currentKeys;
      }
      nextKeys.add(entry.entryKey);
      return nextKeys;
    });
  };
  const handleDropRune = (slot, draggedPanel) => {
    if (props.requesting() || isPreviewing()) {
      return;
    }
    const runeID = Number(LoadData(draggedPanel, "rune")) || 0;
    if (runeID <= 0) {
      return;
    }
    props.onDropRune(slot, runeID);
  };
  return (() => {
    const _el$ = libs.createElement("Panel", {
        id: "RuneDevourRoot",
        "class": "RuneContentSubRoot"
      }, null),
      _el$2 = libs.createElement("Panel", {
        id: "RuneDevourMainContent",
        hittest: false
      }, _el$),
      _el$3 = libs.createElement("Image", {
        id: "RuneDevourArrow",
        hittest: false
      }, _el$2),
      _el$4 = libs.createElement("Panel", {
        id: "RuneDevourOperation",
        hittest: false
      }, _el$);
    libs.insert(_el$2, libs.createComponent(rune_components.RuneDetailCard, {
      id: "RuneDevourLeftCard",
      EmptyLabel: "#RuneDevour_LeftCardEmptyLabel",
      tooltipText: "#RuneDevour_LeftCardEmptyLabel_Tip",
      get rune() {
        return leftDisplayRune();
      },
      get highlightEntryKeys() {
        return libs.memo(() => !!isPreviewing())() ? changedEntryKeys() : undefined;
      },
      get lockedAdverbEntryKeys() {
        return lockedAdverbEntryKeys();
      },
      get onAdverbEntryLockToggle() {
        return showAdverbEntryLockSelection() ? handleAdverbEntryLockToggle : undefined;
      },
      get onRemoveRune() {
        return allowRuneRemove() ? () => {
          props.onRemoveRune("left");
        } : undefined;
      },
      onDragDrop: (_panel, draggedPanel) => {
        handleDropRune("left", draggedPanel);
      }
    }), _el$3);
    libs.insert(_el$2, libs.createComponent(rune_components.RuneDetailCard, {
      id: "RuneDevourRightCard",
      EmptyLabel: "#RuneDevour_RightCardEmptyLabel",
      tooltipText: "#RuneDevour_RightCardEmptyLabel_Tip",
      get rune() {
        return rightDisplayRune();
      },
      get highlightEntryKeys() {
        return libs.memo(() => !!isPreviewing())() ? changedEntryKeys() : undefined;
      },
      get selectable() {
        return allowEntrySelection();
      },
      get selectedEntryKey() {
        return selectedEntryKey();
      },
      onEntrySelect: entry => {
        if (allowEntrySelection()) {
          setSelectedEntry(entry);
        }
      },
      get onRemoveRune() {
        return allowRuneRemove() ? () => {
          props.onRemoveRune("right");
        } : undefined;
      },
      onDragDrop: (_panel, draggedPanel) => {
        handleDropRune("right", draggedPanel);
      }
    }), null);
    libs.insert(_el$4, libs.createComponent(libs.Show, {
      get when() {
        return phase() === PHASES.PeekDone;
      },
      get children() {
        const _el$5 = libs.createElement("Panel", {
            id: "RuneDevourStartButtons"
          }, null),
          _el$6 = libs.createElement("Panel", {
            id: "UpgradeCost",
            flowChildren: "right"
          }, _el$5),
          _el$7 = libs.createElement("Panel", {
            id: "UpgradeCostContent",
            flowChildren: "right"
          }, _el$6);
        libs.setProp(_el$6, "flowChildren", "right");
        libs.setProp(_el$7, "flowChildren", "right");
        libs.insert(_el$7, libs.createComponent(libs.For, {
          get each() {
            return devourCosts();
          },
          children: cost => (() => {
            const _el$1 = libs.createElement("Panel", {
                "class": "RuneDevourCostItem",
                flowChildren: "right"
              }, null),
              _el$10 = libs.createElement("Label", {
                id: "UpgradeCostLabel",
                get text() {
                  return `x${cost.amount}`;
                }
              }, _el$1);
            libs.setProp(_el$1, "flowChildren", "right");
            libs.insert(_el$1, libs.createComponent(Player.CurrencyIcon, {
              id: "UpgradeCostIcon",
              width: "28px",
              height: "28px",
              get tokenID() {
                return cost.itemID;
              }
            }), _el$10);
            libs.effect(_p$ => {
              const _v$ = {
                  Insufficient: cost.insufficient
                },
                _v$2 = `x${cost.amount}`;
              _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$10, "classList", _v$, _p$._v$));
              _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$10, "text", _v$2, _p$._v$2));
              return _p$;
            }, {
              _v$: undefined,
              _v$2: undefined
            });
            return _el$1;
          })()
        }));
        libs.insert(_el$5, libs.createComponent(EOM_Button.EOM_Button, {
          id: "RuneDevourStartConfirmButton",
          marginTop: "16px",
          color: "Confirm",
          size: "Normal",
          text: "#RuneDevour_OptCheck",
          get enabled() {
            return !props.requesting();
          },
          onactivate: handleDevour
        }), null);
        libs.effect(_$p => libs.setProp(_el$6, "visible", devourCosts().length > 0, _$p));
        return _el$5;
      }
    }), null);
    libs.insert(_el$4, libs.createComponent(libs.Show, {
      get when() {
        return phase() === PHASES.Preview;
      },
      get children() {
        const _el$8 = libs.createElement("Panel", {
            id: "RuneDevourCheckButtons"
          }, null),
          _el$9 = libs.createElement("Panel", {
            "class": "RuneDevourCheckButtonSlot"
          }, _el$8),
          _el$0 = libs.createElement("Panel", {
            "class": "RuneDevourCheckButtonSlot"
          }, _el$8);
        libs.insert(_el$9, libs.createComponent(EOM_Button.EOM_Button, {
          id: "RuneDevourCheckConfirmButton",
          color: "Confirm",
          size: "Normal",
          text: "#RuneDevour_OptCheckResult",
          get enabled() {
            return !props.requesting();
          },
          onactivate: () => {
            handleConfirmPreview(true);
          }
        }));
        libs.insert(_el$0, libs.createComponent(EOM_Button.EOM_Button, {
          id: "RuneDevourResetButton",
          color: "Cancel",
          size: "Normal",
          text: "#RuneDevour_OptReset",
          get enabled() {
            return !props.requesting();
          },
          onactivate: () => {
            handleConfirmPreview(false);
          }
        }));
        return _el$8;
      }
    }), null);
    return _el$;
  })();
};

const defaultAbilityID = 1;
const runeUnlockConfigKeyBySlotID = {
  2: "rune_unlock_1",
  3: "rune_unlock_2"
};
const isPlayerRuneValue = value => {
  return value !== "nil";
};
const getRuneIconPath = rune => {
  if (rune == undefined) {
    return undefined;
  }
  const staticData = KeyValues.info_item_rune[rune.rune_item_id];
  if (staticData == undefined) {
    return undefined;
  }
  return `file://{images}/custom_game/store_items/${staticData.icon}.png`;
};
const buildDragHoverSlotKey = (skillID, slotID) => `${skillID}:${slotID}`;
const normalizeAttributeNumber = (value, fallback = 0) => {
  return toFiniteNumber(value, fallback);
};
const normalizeOptionalAttributeNumber = value => {
  if (value == undefined) {
    return undefined;
  }
  return normalizeAttributeNumber(value);
};
const normalizeAttributeEntry = entry => {
  const normalizedValue = normalizeAttributeNumber(entry.value);
  return {
    ...entry,
    value: normalizedValue,
    base_value: normalizeAttributeNumber(entry.base_value, normalizedValue),
    base_min: normalizeOptionalAttributeNumber(entry.base_min),
    base_max: normalizeOptionalAttributeNumber(entry.base_max)
  };
};
const mergeAttributeValue = (currentValue, nextValue) => {
  if (nextValue == undefined) {
    return currentValue;
  }
  return normalizeAttributeNumber(currentValue) + normalizeAttributeNumber(nextValue);
};
const appendAggregatedAttributes = (attributeMap, entries) => {
  if (entries == undefined) {
    return;
  }
  for (const entry of entries) {
    const normalizedEntry = normalizeAttributeEntry(entry);
    const currentEntry = attributeMap[entry.id];
    if (currentEntry == undefined) {
      attributeMap[entry.id] = normalizedEntry;
      continue;
    }
    currentEntry.value = normalizeAttributeNumber(currentEntry.value) + normalizedEntry.value;
    currentEntry.base_value = normalizeAttributeNumber(currentEntry.base_value, currentEntry.value) + normalizedEntry.base_value;
    currentEntry.base_min = mergeAttributeValue(currentEntry.base_min, normalizedEntry.base_min);
    currentEntry.base_max = mergeAttributeValue(currentEntry.base_max, normalizedEntry.base_max);
    if (currentEntry.percent == undefined && normalizedEntry.percent !== undefined) {
      currentEntry.percent = normalizedEntry.percent;
    }
  }
};
const buildPlanAttributeSummary = (currentPlan, abilityID, runes) => {
  const mainAttributeMap = {};
  const subAttributeMap = {};
  const suitPointMap = {};
  const skillSlots = currentPlan[abilityID];
  for (const runeID of Object.values(skillSlots ?? {})) {
    if (runeID === "nil") {
      continue;
    }
    const runeData = runes[Number(runeID)];
    if (runeData == undefined) {
      continue;
    }
    appendAggregatedAttributes(mainAttributeMap, runeData.main_entry_data);
    appendAggregatedAttributes(subAttributeMap, runeData.adverb_entry_data);
    for (const suitPoint of runeData.rune_suit_data ?? []) {
      const currentSuitPoint = suitPointMap[suitPoint.id];
      if (currentSuitPoint == undefined) {
        suitPointMap[suitPoint.id] = {
          ...suitPoint
        };
        continue;
      }
      currentSuitPoint.value += suitPoint.value;
    }
  }
  return {
    main_attributes: Object.values(mainAttributeMap),
    sub_attributes: Object.values(subAttributeMap),
    suit_attributes: Object.values(suitPointMap).filter(suitPoint => suitPoint.value > 0)
  };
};
const AttributeSummaryPanel = props => {
  const [local, other] = libs.splitProps(props, ["class", "main_attributes", "sub_attributes", "suit_attributes"]);
  const mainEntries = libs.createMemo(() => rune_data.buildRuneAttributeDisplays(local.main_attributes, 1, {
    showAttributeRange: false,
    usePercentColor: false
  }));
  const adverbEntries = libs.createMemo(() => rune_data.buildRuneAttributeDisplays(local.sub_attributes, 2, {
    showAttributeRange: false,
    usePercentColor: false
  }));
  const suitEntries = libs.createMemo(() => rune_data.buildRuneSuitDisplays(local.suit_attributes));
  return (() => {
    const _el$ = libs.createElement("Panel", {
        id: "AttributeSummaryPanel",
        hittest: false
      }, null);
      libs.createElement("Label", {
        id: "AttributesSummaryTitle",
        text: "#Equipment_AttributesSummary"
      }, _el$);
      libs.createElement("Panel", {
        id: "TitleLine"
      }, _el$);
      const _el$4 = libs.createElement("Panel", {
        id: "AttributesSummary",
        "class": "VerticalScrollStyle",
        scroll: "y"
      }, _el$),
      _el$5 = libs.createElement("Panel", {
        "class": "RuneSummaryMainAttr",
        hittest: false
      }, _el$4),
      _el$6 = libs.createElement("Panel", {
        "class": "RuneSummaryAdverbAttr",
        hittest: false
      }, _el$4);
      libs.createElement("Image", {
        "class": "RuneSummaryAttributeSeparator"
      }, _el$6);
      const _el$8 = libs.createElement("Panel", {
        "class": "RuneSummarySuitPoint",
        hittest: false
      }, _el$4);
      libs.createElement("Image", {
        "class": "RuneSummaryAttributeSeparator"
      }, _el$8);
    libs.setProp(_el$4, "scroll", "y");
    libs.insert(_el$5, libs.createComponent(libs.For, {
      get each() {
        return mainEntries();
      },
      children: entry => libs.createComponent(rune_components.RuneAttributeRow, {
        get attr_name_html() {
          return entry.nameHtml;
        },
        get attr_value_html() {
          return entry.valueText;
        },
        entry_type: "Main"
      })
    }));
    libs.insert(_el$6, libs.createComponent(libs.For, {
      get each() {
        return adverbEntries();
      },
      children: entry => libs.createComponent(rune_components.RuneAttributeRow, {
        get attr_name_html() {
          return entry.nameHtml;
        },
        get attr_value_html() {
          return entry.valueText;
        },
        entry_type: "Adverb"
      })
    }), null);
    libs.insert(_el$8, libs.createComponent(libs.For, {
      get each() {
        return suitEntries();
      },
      children: entry => libs.createComponent(rune_components.RuneBondItem, {
        get suitKey() {
          return entry.suitKey;
        },
        get currentPoint() {
          return entry.currentPoint;
        },
        get suitPoint() {
          return entry.currentPoint;
        },
        useSuitStyle: true,
        showTooltip: true
      })
    }), null);
    libs.effect(_p$ => {
      const _v$ = adverbEntries().length > 0,
        _v$2 = suitEntries().length > 0;
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$6, "visible", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$8, "visible", _v$2, _p$._v$2));
      return _p$;
    }, {
      _v$: undefined,
      _v$2: undefined
    });
    return _el$;
  })();
};
const RuneEmbed = props => {
  const [selectPlanID, setSelectPlanID] = libs.createSignal(1);
  const [previewHeroName, setPreviewHeroName] = global_selection.createPreviewHeroNameSignal();
  const previewHeroKV = libs.createMemo(() => KeyValues.heroes[previewHeroName()]);
  const previewAbilityList = libs.createMemo(() => {
    const heroKV = previewHeroKV();
    return props.abilityDisplayMappings.map(ability => ({
      serviceSkillID: ability.serviceSkillID,
      id: ability.id,
      abilityName: heroKV?.["Ability" + (ability.heroAbilityIndex + 1)]
    }));
  });
  const [selectAbilityID, setSelectAbilityID] = libs.createSignal(defaultAbilityID);
  const selectHeroID = () => {
    const heroName = previewHeroName();
    return GetHeroIDByHeroName(heroName);
  };
  const [showOverviewAttr, setShowOverviewAttr] = libs.createSignal(false);
  const plan_suit = solid_utils.createServiceNetData("player_hero_rune_equip_suits", {});
  const playerHeroes = solid_utils.createServiceNetData("player_heroes", {});
  const playerRunes = solid_utils.createServiceNetData("player_runes", {});
  const playerRuneUnlockData = solid_utils.createServiceNetData("player_rune_unlock_data", {});
  const playerTokens = solid_utils.createServiceNetData("player_tokens", {});
  const defaultUnlockedSlotCount = libs.createMemo(() => {
    const rawValue = GameUI.CustomUIConfig().rune_setting?.rune_default?.value;
    return Math.max(1, toFiniteNumber(rawValue, 1));
  });
  const runeMap = libs.createMemo(() => {
    const runeData = playerRunes();
    const result = {};
    for (const [runeID, rune] of Object.entries(runeData)) {
      if (!isPlayerRuneValue(rune)) {
        continue;
      }
      result[Number(runeID)] = rune;
    }
    return result;
  });
  const currentPlanSuit = libs.createMemo(() => {
    const heroID = selectHeroID();
    return plan_suit()?.[heroID]?.[selectPlanID()] ?? {};
  });
  const currentPlanPeekedRuneIDs = libs.createMemo(() => {
    const currentPlan = currentPlanSuit();
    const peekedRuneIDMap = {};
    const result = [];
    for (let abilityIndex = 0; abilityIndex < props.abilityDisplayMappings.length; abilityIndex++) {
      const serviceSkillID = props.abilityDisplayMappings[abilityIndex].serviceSkillID;
      const skillSlots = currentPlan[serviceSkillID] ?? {};
      for (let slotID = 1; slotID <= 3; slotID++) {
        const runeID = skillSlots[slotID];
        if (runeID == undefined || runeID === "nil") {
          continue;
        }
        const normalizedRuneID = Number(runeID);
        if (normalizedRuneID <= 0 || peekedRuneIDMap[normalizedRuneID] === true) {
          continue;
        }
        peekedRuneIDMap[normalizedRuneID] = true;
        result.push(normalizedRuneID);
      }
    }
    return result;
  });
  const planAttributeSummary = libs.createMemo(() => buildPlanAttributeSummary(currentPlanSuit(), selectAbilityID(), runeMap()));
  const getUnlockedSlotCount = skillID => {
    const defaultCount = defaultUnlockedSlotCount();
    const rawCount = playerRuneUnlockData()?.[skillID];
    return Math.max(defaultCount, toFiniteNumber(rawCount, defaultCount));
  };
  const parseUnlockCosts = slotID => {
    const configKey = runeUnlockConfigKeyBySlotID[slotID];
    if (configKey == undefined) {
      return [];
    }
    const rawValue = GameUI.CustomUIConfig().rune_setting?.[configKey]?.value ?? "";
    if (rawValue === "") {
      return [];
    }
    return rawValue.split("|").map(costText => {
      const [itemIDText, amountText] = costText.split(":");
      return {
        itemID: toFiniteNumber(itemIDText, 0),
        amount: toFiniteNumber(amountText, 0)
      };
    }).filter(cost => cost.itemID > 0 && cost.amount > 0);
  };
  const buildSlotUnlockCosts = slotID => {
    const tokenData = playerTokens();
    return parseUnlockCosts(slotID).map(cost => {
      const ownedAmount = tokenData?.[cost.itemID]?.amounts ?? 0;
      return {
        itemID: cost.itemID,
        amount: cost.amount,
        valueText: `x${cost.amount}`,
        insufficient: ownedAmount < cost.amount
      };
    });
  };
  const runRequest = request => {
    if (props.requesting()) {
      return false;
    }
    props.setRequesting(true);
    request();
    return true;
  };
  const handleUnlockSlotRequest = (serviceSkillID, slotID) => {
    return runRequest(() => {
      CallActionRequest("/v1/rune/unlock_slot", {
        skill_id: serviceSkillID,
        slot_id: slotID
      }, () => {
        props.setRequesting(false);
      }, () => {
        props.setRequesting(false);
      });
    });
  };
  const canWearRune = runeID => {
    if (runeID === 0) {
      return true;
    }
    const rune = runeMap()[runeID];
    if (rune == undefined) {
      return false;
    }
    const needLevel = KeyValues.rune_rarity_setting[rune.rarity]?.need_level ?? 1;
    const heroLv = getServiceNetData("player_account_levels", Players.GetLocalPlayer())?.hero_level?.level ?? 1;
    if (needLevel > heroLv) {
      ErrorMessage("#RuneEmbed_HeroLevelNotAllow");
      return false;
    }
    return true;
  };
  const handleEquipRuneRequest = (slotID, runeID) => {
    const heroID = selectHeroID();
    if (heroID == undefined || heroID <= 0) {
      return;
    }
    const unlockedSlotCount = getUnlockedSlotCount(selectAbilityID());
    if (slotID > unlockedSlotCount) {
      return;
    }
    if (!canWearRune(runeID)) {
      return;
    }
    runRequest(() => {
      CallActionRequest("/v1/hero/equip_rune", {
        hero_id: heroID,
        suit_id: selectPlanID(),
        skill_id: selectAbilityID(),
        slot_id: slotID,
        rune_id: runeID
      }, () => {
        props.setRequesting(false);
      }, () => {
        props.setRequesting(false);
      });
    });
  };
  const handleUnequipRuneRequest = slotData => {
    if (props.requesting()) {
      return;
    }
    if (slotData.locked === true || slotData.isEmpty === true) {
      return;
    }
    handleEquipRuneRequest(slotData.slotID, 0);
  };
  const handleLockedSlotActivate = slotData => {
    if (props.requesting()) {
      return;
    }
    if (slotData.locked !== true) {
      return;
    }
    if (slotData.insufficientCost) {
      ErrorMessage("#RuneDevour_ActivateCostNotAllow");
      return;
    }
    handleUnlockSlotRequest(selectAbilityID(), slotData.slotID);
  };
  const suit_points = libs.createMemo(() => rune_data.buildRuneSuitDisplays(planAttributeSummary().suit_attributes));
  const selectedSkillSlots = libs.createMemo(() => {
    const skillSlots = currentPlanSuit()?.[selectAbilityID()] ?? {};
    const unlockedSlotCount = getUnlockedSlotCount(selectAbilityID());
    return [1, 2, 3].map(slotID => {
      if (slotID > unlockedSlotCount) {
        const costs = buildSlotUnlockCosts(slotID);
        return {
          slotID,
          isEmpty: true,
          locked: true,
          costs,
          insufficientCost: costs.some(cost => cost.insufficient)
        };
      }
      const runeID = skillSlots[slotID];
      if (runeID == undefined || runeID === "nil") {
        return {
          slotID,
          isEmpty: true,
          locked: false,
          costs: [],
          insufficientCost: false
        };
      }
      const runeData = runeMap()[Number(runeID)];
      return {
        slotID,
        runeID: Number(runeID),
        icon: getRuneIconPath(runeData),
        isEmpty: false,
        locked: false,
        costs: [],
        insufficientCost: false
      };
    });
  });
  const abilityDotState = libs.createMemo(() => {
    const currentPlan = currentPlanSuit();
    return props.abilityDisplayMappings.reduce((result, ability) => {
      const skillID = ability.serviceSkillID;
      const skillSlots = currentPlan?.[skillID] ?? {};
      const unlockedSlotCount = getUnlockedSlotCount(skillID);
      result[skillID] = [1, 2, 3].slice(0, unlockedSlotCount).map(slotID => {
        const runeID = skillSlots[slotID];
        return runeID !== undefined && runeID !== "nil";
      });
      return result;
    }, {});
  });
  let syncedHeroID;
  let syncedPlanID;
  libs.createEffect(() => {
    const heroID = selectHeroID();
    const planID = Math.max(1, toFiniteNumber(playerHeroes()[heroID]?.rune_equip_suit, 1));
    if (syncedHeroID === heroID && syncedPlanID === planID) {
      return;
    }
    syncedHeroID = heroID;
    syncedPlanID = planID;
    setSelectPlanID(planID);
    setSelectAbilityID(defaultAbilityID);
    props.clearDragState();
  });
  libs.createEffect(() => {
    props.setPeekedRuneIDs(currentPlanPeekedRuneIDs());
  });
  libs.createEffect(() => {
    const heroID = selectHeroID();
    const planID = selectPlanID();
    const skillID = selectAbilityID();
    const slots = selectedSkillSlots().map(slot => ({
      slotID: slot.slotID,
      runeID: slot.runeID,
      isEmpty: slot.isEmpty,
      locked: slot.locked
    }));
    props.onContextChange?.({
      heroID,
      planID,
      skillID,
      slots,
      equipRune: handleEquipRuneRequest
    });
  });
  libs.onCleanup(() => {
    props.onContextChange?.(undefined);
  });
  const PlanDropDownOnSelect = index => {
    const planID = index + 1;
    const heroID = selectHeroID();
    if (!heroID || planID === selectPlanID() || props.requesting()) {
      return false;
    }
    props.clearDragState();
    setSelectPlanID(planID);
    CallAction("/v1/hero/change_rune_equip_suit", {
      hero_id: heroID,
      suit_id: planID
    });
    return false;
  };
  const canAcceptDraggedRune = slotData => {
    return props.requesting() !== true && slotData.locked !== true;
  };
  const handleSlotDragEnter = (slotData, draggedPanel) => {
    const runeID = LoadData(draggedPanel, "rune");
    if (!runeID || !canAcceptDraggedRune(slotData)) {
      props.setDragHoverSlotKey(undefined);
      return;
    }
    props.setDragHoverSlotKey(buildDragHoverSlotKey(selectAbilityID(), slotData.slotID));
  };
  const handleSlotDragLeave = slotData => {
    const dragHoverKey = buildDragHoverSlotKey(selectAbilityID(), slotData.slotID);
    if (props.dragHoverSlotKey() === dragHoverKey) {
      props.setDragHoverSlotKey(undefined);
    }
  };
  const handleSlotDragDrop = (slotData, draggedPanel) => {
    const runeID = Number(LoadData(draggedPanel, "rune")) || 0;
    props.setDragHoverSlotKey(undefined);
    if (runeID <= 0 || !canAcceptDraggedRune(slotData)) {
      return;
    }
    handleEquipRuneRequest(slotData.slotID, runeID);
  };
  return (() => {
    const _el$0 = libs.createElement("Panel", {
        id: "RuneEmbedRoot",
        "class": "RuneContentSubRoot"
      }, null),
      _el$1 = libs.createElement("Panel", {
        id: "RuneEmbedMainContent",
        hittest: false
      }, _el$0);
      libs.createElement("Panel", {
        id: "RuneEmbedBG",
        hittest: false
      }, _el$1);
      const _el$11 = libs.createElement("Panel", {
        id: "RuneEmbedBlock",
        hittest: false
      }, _el$1),
      _el$12 = libs.createElement("Panel", {
        id: "PlanSelectBlock"
      }, _el$11),
      _el$13 = libs.createElement("Panel", {
        id: "SplitTitleBlock",
        "class": "EOM_SectionDivider"
      }, _el$11);
      libs.createElement("Image", {
        "class": "LineLeft"
      }, _el$13);
      const _el$15 = libs.createElement("Panel", {
        id: "SplitTitleContainer"
      }, _el$13),
      _el$16 = libs.createElement("Panel", {
        id: "SplitTitleLocater"
      }, _el$15);
      libs.createElement("Label", {
        "class": "TitleToolTipInfo",
        text: "#RuneEmbed_SuitAttribute"
      }, _el$16);
      const _el$18 = libs.createElement("Panel", {
        "class": "ToolTipInfo"
      }, _el$16);
      libs.createElement("Image", {
        "class": "LineRight"
      }, _el$13);
      const _el$20 = libs.createElement("Panel", {
        id: "SuitPreviewBlock"
      }, _el$11),
      _el$21 = libs.createElement("Panel", {
        id: "SuitPreviewContent",
        hittest: false
      }, _el$20),
      _el$22 = libs.createElement("Panel", {
        id: "SlotEquipBlock"
      }, _el$11),
      _el$23 = libs.createElement("Panel", {
        id: "RuneAbilityPreview",
        hittest: false
      }, _el$1),
      _el$24 = libs.createElement("Panel", {
        id: "RuneEmbedHeroBar"
      }, _el$0);
    libs.insert(_el$12, libs.createComponent(EOM_Button.EOM_BaseButton, {
      id: "OverviewAttributeBtn",
      get ["class"]() {
        return libs.classNames({
          ShowBtnBorder: showOverviewAttr()
        });
      },
      onactivate: () => {
        setShowOverviewAttr(prev => !prev);
      }
    }), null);
    libs.insert(_el$12, libs.createComponent(EOM_DropDown.EOM_DropDown, {
      id: "SuitDropDown",
      type: "EquipmentDropDown",
      menuPosition: "top",
      get index() {
        return selectPlanID() - 1;
      },
      onSelect: PlanDropDownOnSelect,
      get children() {
        return libs.createComponent(libs.For, {
          each: [1, 2, 3],
          children: type => {
            return (() => {
              const _el$25 = libs.createElement("Label", {
                vars: {
                  value: type
                },
                text: "#EquipmentSuitType"
              }, null);
              libs.setProp(_el$25, "vars", {
                value: type
              });
              return _el$25;
            })();
          }
        });
      }
    }), null);
    libs.setProp(_el$18, "tooltip_text", "#RuneEmbed_TitleDescription");
    libs.insert(_el$21, libs.createComponent(libs.For, {
      get each() {
        return suit_points();
      },
      children: (suitPoint, Index) => libs.createComponent(rune_components.RuneBondItem, {
        get suitKey() {
          return suitPoint.suitKey;
        },
        get currentPoint() {
          return suitPoint.currentPoint;
        },
        get suitPoint() {
          return suitPoint.currentPoint;
        },
        useSuitStyle: true,
        showTooltip: true
      })
    }));
    libs.insert(_el$22, libs.createComponent(libs.For, {
      get each() {
        return selectedSkillSlots();
      },
      children: slotData => libs.createComponent(rune_components.RuneSlotItem, {
        get ["class"]() {
          return libs.classNames({
            DropTarget: props.dragHoverSlotKey() === buildDragHoverSlotKey(selectAbilityID(), slotData.slotID),
            DropBlocked: props.dragHoverSlotKey() === undefined && props.requesting() === false && slotData.locked === true,
            Requesting: props.requesting()
          });
        },
        get runeID() {
          return slotData.runeID;
        },
        get icon() {
          return slotData.icon;
        },
        get isEmpty() {
          return slotData.isEmpty;
        },
        get locked() {
          return slotData.locked;
        },
        get costs() {
          return slotData.costs;
        },
        onDragEnter: (_panel, draggedPanel) => {
          handleSlotDragEnter(slotData, draggedPanel);
        },
        onDragLeave: () => {
          handleSlotDragLeave(slotData);
        },
        onDragDrop: (_panel, draggedPanel) => {
          handleSlotDragDrop(slotData, draggedPanel);
        },
        oncontextmenu: () => {
          handleUnequipRuneRequest(slotData);
        },
        onmouseactivate: () => {
          handleLockedSlotActivate(slotData);
        }
      })
    }));
    libs.insert(_el$23, libs.createComponent(libs.For, {
      get each() {
        return previewAbilityList();
      },
      children: ability => libs.createComponent(rune_components.RuneAbilityItem, {
        get id() {
          return ability.id;
        },
        get abilityName() {
          return ability.abilityName;
        },
        get ["class"]() {
          return libs.classNames({
            Selected: selectAbilityID() === ability.serviceSkillID
          });
        },
        get activeDots() {
          return abilityDotState()[ability.serviceSkillID] ?? [];
        },
        onmouseactivate: () => {
          setSelectAbilityID(ability.serviceSkillID);
        }
      })
    }));
    libs.insert(_el$24, libs.createComponent(hero_selection_bar.HeroSelectionBar, {
      get selecteHeroName() {
        return previewHeroName();
      },
      onchange: (heroName, _heroID) => {
        setPreviewHeroName(heroName);
      }
    }));
    libs.insert(_el$0, libs.createComponent(libs.Show, {
      get when() {
        return showOverviewAttr();
      },
      get children() {
        return libs.createComponent(AttributeSummaryPanel, {
          get main_attributes() {
            return planAttributeSummary().main_attributes;
          },
          get sub_attributes() {
            return planAttributeSummary().sub_attributes;
          },
          get suit_attributes() {
            return planAttributeSummary().suit_attributes;
          }
        });
      }
    }), null);
    return _el$0;
  })();
};

const MENU_LIST = {
  RuneEmbed_Menu: [],
  RuneBreak_Menu: [],
  RuneDevour_Menu: []
};
const {
  LayoutMenu,
  show,
  menuName
} = EOM_MenuLayout.createMenuLayout("rune", () => MENU_LIST);
let player_runes = () => ({});
let runeUnreadIds;
const isRuneNew = id => runeUnreadIds?.isUnread(id) ?? false;
const markRuneRead = id => runeUnreadIds?.markRead(id);
const abilityDisplayMappings = [{
  serviceSkillID: 1,
  heroAbilityIndex: 3,
  id: "AbilityAttack"
}, {
  serviceSkillID: 2,
  heroAbilityIndex: 0,
  id: "Ability1"
}, {
  serviceSkillID: 3,
  heroAbilityIndex: 1,
  id: "Ability2"
}, {
  serviceSkillID: 4,
  heroAbilityIndex: 2,
  id: "Ability3"
}, {
  serviceSkillID: 5,
  heroAbilityIndex: 5,
  id: "Ability4"
}];
const RUNE_NEEDLV_LIST = Array.from(new Set(Object.values(KeyValues.rune_rarity_setting).map(setting => setting.need_level))).sort((a, b) => a - b);
const RUNE_RARITY_LIST = Object.values(KeyValues.rune_rarity_setting).map(setting => setting.rarity).sort((a, b) => a - b);
const RUNE_BREAK_SLOT_NUM = 5;
const RUNE_BAG_MAX_CAPACITY = 400;
const DEVOUR_LEFT_RUNE_MIN_RARITY = 7;
const LOCKED_RUNE_BREAK_MESSAGE = "#RuneBreak_LockedErrorMessage";
const EQUIPPED_RUNE_BREAK_MESSAGE = "#RuneBreak_EquippedTips";
const EQUIPPED_RUNE_DEVOUR_MESSAGE = "#RuneDevour_EquippedRuneNotAllow";
const createEmptyBreakSlots = () => Array.from({
  length: RUNE_BREAK_SLOT_NUM
}, () => undefined);
let showFilter = () => false;
let setShowFilter = () => false;
let filterNeedLv = () => ({});
let setFilterNeedLv = () => ({});
let filterRarity = () => ({});
let setFilterRarity = () => ({});
let filterSuit = () => ({});
let setFilterSuit = () => ({});
let resetFilter = () => 0;
let setResetFilter = () => 0;
function createRunePageState() {
  player_runes = solid_utils.createServiceNetData("player_runes", {});
  runeUnreadIds = solid_utils.createPlayerUnreadIds("rune");
  [showFilter, setShowFilter] = libs.createSignal(false);
  [filterNeedLv, setFilterNeedLv] = libs.createSignal({});
  [filterRarity, setFilterRarity] = libs.createSignal({});
  [filterSuit, setFilterSuit] = libs.createSignal({});
  [resetFilter, setResetFilter] = libs.createSignal(0);
  libs.onCleanup(() => {
    runeUnreadIds?.submitReadCache();
  });
}
const getRuneNeedLevel = rune => {
  return KeyValues.rune_rarity_setting[rune.rarity]?.need_level;
};
const isRuneEquipped = rune => {
  return rune?.in_rune_equip_suit != undefined && rune.in_rune_equip_suit !== "";
};
const handleRuneLock = (id, lock) => {
  CallAction("/v1/rune/lock", {
    id: id,
    lock: lock
  });
};
const RuneBagRoot = props => {
  const filterTabs = libs.createMemo(() => {
    const suitIDs = Object.values(KeyValues.rune_suit_effect).map(suit => suit.id);
    return ["all", ...suitIDs];
  });
  const filteredRunes = libs.createMemo(() => {
    const filter = props.suitFilter();
    const rarityFilter = filterRarity();
    const needLvFilter = filterNeedLv();
    const suitFilter = filterSuit();
    let result = props.runeList();
    if (filter !== "all") {
      result = result.filter(rune => rune.suitIDs.includes(filter));
    }
    const selectedRarity = Object.keys(rarityFilter).filter(k => rarityFilter[Number(k)]).map(Number);
    if (selectedRarity.length > 0) {
      result = result.filter(rune => selectedRarity.includes(rune.rarity));
    }
    const selectedNeedLv = Object.keys(needLvFilter).filter(k => needLvFilter[Number(k)]).map(Number);
    if (selectedNeedLv.length > 0) {
      result = result.filter(rune => {
        const needLevel = getRuneNeedLevel(rune);
        return needLevel != undefined && selectedNeedLv.includes(needLevel);
      });
    }
    const selectedSuit = Object.keys(suitFilter).filter(k => suitFilter[k]);
    if (selectedSuit.length > 0) {
      result = result.filter(rune => {
        return rune.suitIDs.some(suitID => selectedSuit.includes(suitID));
      });
    }
    return result;
  });
  const peekedRuneIDMap = libs.createMemo(() => {
    return props.peekedRuneIDs().reduce((result, runeID) => {
      result[runeID] = true;
      return result;
    }, {});
  });
  const selectedRuneIDMap = libs.createMemo(() => {
    if (props.selectedRuneIDs != undefined) {
      return props.selectedRuneIDs().reduce((result, runeID) => {
        result[runeID] = true;
        return result;
      }, {});
    }
    const selectedRuneID = props.selectedRuneID();
    return selectedRuneID == undefined ? {} : {
      [selectedRuneID]: true
    };
  });
  const filterIcon = filter => {
    if (filter === "all") {
      return getSrcPath("conv/icon/icon_zb_01.png");
    }
    return rune_data.getRuneSuitIconPath(filter) ?? getSrcPath("conv/icon/icon_zb_01.png");
  };
  const selectedRune = libs.createMemo(() => {
    return props.runeList().find(v => v.id == props.selectedRuneID());
  });
  const selectedRuneLocked = libs.createMemo(() => {
    return selectedRune()?.locked === true;
  });
  return (() => {
    const _el$ = libs.createElement("Panel", {
        id: "RuneBagRoot",
        "class": "RuneRightBag"
      }, null),
      _el$2 = libs.createElement("Panel", {
        id: "RuneBagLeftArea"
      }, _el$),
      _el$3 = libs.createElement("Panel", {
        id: "RuneBagFilter"
      }, _el$),
      _el$4 = libs.createElement("Panel", {
        id: "RuneBottomContainer"
      }, _el$),
      _el$5 = libs.createElement("Button", {
        id: "ResetBtn",
        "class": "SecondaryButtonStates"
      }, _el$4);
    libs.insert(_el$2, libs.createComponent(libs.Show, {
      get when() {
        return showFilter();
      },
      get fallback() {
        return libs.createComponent(RecycleView.RecycleView, {
          id: "RuneBagItemList",
          input: filteredRunes,
          direction: "VerticalGrid",
          wheelStep: 88,
          childConfig: {
            width: 88,
            height: 88,
            margin: 2
          },
          grid_children: () => libs.createElement("Panel", {
            "class": "RuneBagListGrid"
          }, null),
          children: data => {
            const rune = data;
            const isDragging = () => props.draggingRuneID() === rune().id;
            const isPeeked = () => peekedRuneIDMap()[rune().id] === true;
            const isSelectionBlocked = () => props.selectionBlocked?.() === true;
            const showSelectionBlockedMessage = () => {
              ErrorMessage("#RuneDevour_PreviewBlockSelect");
            };
            const isLocked = () => rune().locked === true;
            return (() => {
              const _el$7 = libs.createElement("Panel", {
                  get ["class"]() {
                    return libs.classNames("RuneBagItem", {
                      Selected: selectedRuneIDMap()[rune().id] === true,
                      Peeked: isPeeked(),
                      RedPoint: props.isRuneNew(rune().id),
                      Locked: isLocked()
                    });
                  }
                }, null),
                _el$8 = libs.createElement("Panel", {
                  get ["class"]() {
                    return libs.classNames(`RuneBagItemIconRoot Rarity${rune().rarity}`, {
                      Dragging: isDragging(),
                      Requesting: props.requesting()
                    });
                  }
                }, _el$7),
                _el$9 = libs.createElement("Image", {
                  "class": "RuneBagItemIcon",
                  get src() {
                    return rune_data.getRuneIconPath(rune());
                  }
                }, _el$8);
                libs.createElement("Image", {
                  "class": "RunePeekIcon"
                }, _el$7);
                libs.createElement("Panel", {
                  "class": "SelectedBorder"
                }, _el$7);
                libs.createElement("Panel", {
                  "class": "RuneNewRedPoint"
                }, _el$7);
                libs.createElement("Panel", {
                  "class": "RuenLocked"
                }, _el$7);
              libs.setProp(_el$7, "onmouseover", panel => {
                props.markRuneRead(rune().id);
                equipment_utils.ShowServerRuneTooltip(panel, {
                  id1: rune().id
                });
              });
              libs.setProp(_el$7, "onmouseout", panel => HideCustomTooltip(panel, "server_rune"));
              libs.setProp(_el$7, "onmouseactivate", () => {
                if (props.disableClickActivate === true) {
                  return;
                }
                if (isSelectionBlocked()) {
                  showSelectionBlockedMessage();
                  return;
                }
                props.onRuneActivate(rune().id);
              });
              libs.setProp(_el$7, "onDragStart", (panel, dragCallbacks) => {
                if (props.requesting()) {
                  return false;
                }
                if (isSelectionBlocked()) {
                  showSelectionBlockedMessage();
                  return false;
                }
                props.setDraggingRuneID(rune().id);
                const dragPanel = $.CreatePanel("Panel", $.GetContextPanel(), "runeDragImage");
                libs.render(() => (() => {
                  const _el$12 = libs.createElement("Panel", {
                      "class": "RuneDragPreview"
                    }, null),
                    _el$13 = libs.createElement("Panel", {
                      get ["class"]() {
                        return `RuneBagItemIconRoot Rarity${rune().rarity}`;
                      }
                    }, _el$12),
                    _el$14 = libs.createElement("Image", {
                      "class": "RuneBagItemIcon",
                      get src() {
                        return rune_data.getRuneIconPath(rune());
                      }
                    }, _el$13);
                  libs.effect(_p$ => {
                    const _v$4 = `RuneBagItemIconRoot Rarity${rune().rarity}`,
                      _v$5 = rune_data.getRuneIconPath(rune());
                    _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$13, "class", _v$4, _p$._v$4));
                    _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$14, "src", _v$5, _p$._v$5));
                    return _p$;
                  }, {
                    _v$4: undefined,
                    _v$5: undefined
                  });
                  return _el$12;
                })(), dragPanel);
                dragCallbacks.displayPanel = dragPanel;
                const position = GameUI.GetCursorPosition();
                if (dragCallbacks.offsetX == undefined || dragCallbacks.offsetY == undefined) {
                  dragCallbacks.offsetX = dragPanel.GetPositionWithinWindow().x - position[0];
                  dragCallbacks.offsetY = dragPanel.GetPositionWithinWindow().y - position[1];
                }
                panel.AddClass("dragging_from");
                SaveData(dragPanel, "rune", rune().id);
                $.GetContextPanel().AddClass("Rune_Dragging");
                return true;
              });
              libs.setProp(_el$7, "onDragEnd", (panel, draggedPanel) => {
                if (draggedPanel !== undefined && draggedPanel.IsValid()) {
                  draggedPanel.DeleteAsync(-1);
                }
                panel.RemoveClass("dragging_from");
                $.GetContextPanel().RemoveClass("Rune_Dragging");
                props.clearDragState();
              });
              libs.setProp(_el$7, "oncontextmenu", panel => {
                props.onRuneContextMenu?.(panel, rune().id);
              });
              libs.effect(_p$ => {
                const _v$ = libs.classNames("RuneBagItem", {
                    Selected: selectedRuneIDMap()[rune().id] === true,
                    Peeked: isPeeked(),
                    RedPoint: props.isRuneNew(rune().id),
                    Locked: isLocked()
                  }),
                  _v$2 = libs.classNames(`RuneBagItemIconRoot Rarity${rune().rarity}`, {
                    Dragging: isDragging(),
                    Requesting: props.requesting()
                  }),
                  _v$3 = rune_data.getRuneIconPath(rune());
                _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$7, "class", _v$, _p$._v$));
                _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$8, "class", _v$2, _p$._v$2));
                _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$9, "src", _v$3, _p$._v$3));
                return _p$;
              }, {
                _v$: undefined,
                _v$2: undefined,
                _v$3: undefined
              });
              return _el$7;
            })();
          }
        });
      },
      get children() {
        return libs.createComponent(RuneFilterWindow, {});
      }
    }));
    libs.insert(_el$3, libs.createComponent(libs.For, {
      get each() {
        return filterTabs();
      },
      children: filter => {
        return (() => {
          const _el$15 = libs.createElement("Button", {
              get ["class"]() {
                return libs.classNames("RuneBagFilterTab", {
                  Selected: props.suitFilter() === filter
                });
              }
            }, null),
            _el$16 = libs.createElement("Image", {
              "class": "RuneBagFilterIcon",
              get src() {
                return filterIcon(filter);
              }
            }, _el$15);
          libs.setProp(_el$15, "onactivate", () => {
            props.setSuitFilter(filter);
          });
          libs.effect(_p$ => {
            const _v$6 = libs.classNames("RuneBagFilterTab", {
                Selected: props.suitFilter() === filter
              }),
              _v$7 = filterIcon(filter);
            _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$15, "class", _v$6, _p$._v$6));
            _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$16, "src", _v$7, _p$._v$7));
            return _p$;
          }, {
            _v$6: undefined,
            _v$7: undefined
          });
          return _el$15;
        })();
      }
    }));
    libs.insert(_el$4, libs.createComponent(equipment_comp.EquipmentCommonBtn, {
      id: "FilterBtn",
      get ["class"]() {
        return libs.classNames({
          ShowBtnBorder: showFilter()
        });
      },
      text: "#Hud_Equipment_Filter",
      onactivate: () => {
        setShowFilter(prev => !prev);
      }
    }), _el$5);
    libs.setProp(_el$5, "onactivate", () => {
      libs.batch(() => {
        setFilterNeedLv({});
        setFilterRarity({});
        setFilterSuit({});
        setResetFilter(prev => prev + 1);
      });
    });
    libs.insert(_el$4, libs.createComponent(equipment_comp.EquipmentCommonBtn, {
      id: "RuneLockBtn",
      get text() {
        return selectedRuneLocked() ? "#RuneItem_OptUnlock" : "#RuneItem_OptLock";
      },
      get enabled() {
        return selectedRune() !== undefined;
      },
      onactivate: () => handleRuneLock(selectedRune()?.id, !selectedRuneLocked())
    }), null);
    return _el$;
  })();
};
function RuneFilterWindow() {
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
  return (() => {
    const _el$17 = libs.createElement("Panel", {
        id: "RuneFilterWindow"
      }, null),
      _el$18 = libs.createElement("Panel", {
        id: "NeedLvFilter",
        "class": "Filter"
      }, _el$17);
      libs.createElement("Label", {
        id: "FilterType",
        text: "#NeedLvFilter"
      }, _el$18);
      libs.createElement("Label", {
        id: "RarityLabel",
        "class": "Subheading",
        text: "#Equipment_Rarity"
      }, _el$17);
      libs.createElement("Panel", {
        "class": "FilterLine"
      }, _el$17);
      const _el$22 = libs.createElement("Panel", {
        id: "RarityFilterList",
        "class": "CheckBoxList"
      }, _el$17);
      libs.createElement("Label", {
        id: "SuitLabel",
        "class": "Subheading",
        text: "#Equipment_Suit"
      }, _el$17);
      libs.createElement("Panel", {
        "class": "FilterLine"
      }, _el$17);
      const _el$25 = libs.createElement("Panel", {
        id: "SuitFilterList",
        "class": "CheckBoxList"
      }, _el$17);
    libs.insert(_el$18, libs.createComponent(EOM_MultiDropDown.EOM_MultiDropDown, {
      get placeholder() {
        return needLvText();
      },
      ref(r$) {
        const _ref$ = needLvFilter;
        typeof _ref$ === "function" ? _ref$(r$) : needLvFilter = r$;
      },
      options: RUNE_NEEDLV_LIST,
      onChange: value => {
        setFilterNeedLv(value);
      }
    }), null);
    libs.insert(_el$22, libs.createComponent(libs.For, {
      each: RUNE_RARITY_LIST,
      children: rarity => {
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
    libs.insert(_el$25, libs.createComponent(libs.For, {
      get each() {
        return Object.keys(KeyValues.rune_suit_effect);
      },
      children: suitID => {
        return libs.createComponent(equipment_comp.EOM_CheckBox2, {
          get checked() {
            return filterSuit()[suitID] ?? false;
          },
          get text() {
            return GetLocalization(`#RuneSuit_${suitID}`);
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
    return _el$17;
  })();
}
function RunePage() {
  createRunePageState();
  const [suitFilter, setSuitFilter] = libs.createSignal("all");
  const player_hero_rune_equip_suits = solid_utils.createServiceNetData("player_hero_rune_equip_suits", {});
  const player_account_levels = solid_utils.createServiceNetData("player_account_levels", {
    rune_break_level: {
      level: 0,
      extra_exp: 0
    }
  });
  const runeList = libs.createMemo(() => rune_data.buildRuneBagItems(player_runes()));
  const runeBagCount = libs.createMemo(() => runeList().length);
  const isRuneBagFull = libs.createMemo(() => runeBagCount() >= RUNE_BAG_MAX_CAPACITY);
  const runeMap = libs.createMemo(() => {
    return runeList().reduce((result, rune) => {
      result[rune.id] = rune;
      return result;
    }, {});
  });
  const [requesting, setRequesting] = libs.createSignal(false);
  const [selectedRuneID, setSelectedRuneID] = libs.createSignal();
  const [peekedRuneIDs, setPeekedRuneIDs] = libs.createSignal([]);
  const [draggingRuneID, setDraggingRuneID] = libs.createSignal();
  const [dragHoverSlotKey, setDragHoverSlotKey] = libs.createSignal();
  const [devourLeftRuneID, setDevourLeftRuneID] = libs.createSignal();
  const [devourRightRuneID, setDevourRightRuneID] = libs.createSignal();
  const [devourPreviewing, setDevourPreviewing] = libs.createSignal(false);
  const [selectedBreakSlot, setSelectedBreakSlot] = libs.createSignal(-1);
  const [showBreakAttrInfo, setShowBreakAttrInfo] = libs.createSignal(false);
  const [breakRuneIDs, setBreakRuneIDs] = libs.createSignal(createEmptyBreakSlots());
  const [runeEmbedContext, setRuneEmbedContext] = libs.createSignal();
  const devourLeftRune = libs.createMemo(() => runeMap()[devourLeftRuneID() ?? 0]);
  const devourRightRune = libs.createMemo(() => runeMap()[devourRightRuneID() ?? 0]);
  const breakRunes = libs.createMemo(() => {
    return breakRuneIDs().map(runeID => runeID == undefined ? undefined : runeMap()[runeID]);
  });
  const breakSelectedRuneIDs = libs.createMemo(() => {
    return breakRuneIDs().filter(runeID => runeID != undefined);
  });
  const equippedRuneIDs = libs.createMemo(() => {
    const result = {};
    for (const planList of Object.values(player_hero_rune_equip_suits())) {
      for (const skillList of Object.values(planList)) {
        for (const slotList of Object.values(skillList)) {
          for (const equippedRuneID of Object.values(slotList)) {
            const runeID = Number(equippedRuneID);
            if (runeID > 0) {
              result[runeID] = true;
            }
          }
        }
      }
    }
    return Object.keys(result).map(Number);
  });
  const bagPeekedRuneIDs = libs.createMemo(() => {
    if (menuName() === "RuneEmbed_Menu") {
      return peekedRuneIDs();
    }
    if (menuName() === "RuneBreak_Menu") {
      return equippedRuneIDs();
    }
    if (menuName() === "RuneDevour_Menu") {
      return equippedRuneIDs();
    }
    return [];
  });
  const runeBreakLevel = libs.createMemo(() => player_account_levels().rune_break_level ?? {
    level: 0,
    extra_exp: 0
  });
  const rightShowAttrInfo = libs.createMemo(() => menuName() === "RuneBreak_Menu" && showBreakAttrInfo());
  libs.createEffect(() => {
    const rune = devourRightRune();
    if (rune?.locked === true || isRuneEquipped(rune)) {
      setDevourRightRuneID(undefined);
    }
  });
  libs.createEffect(() => {
    setBreakRuneIDs(prev => {
      const next = prev.map(runeID => {
        if (runeID == undefined) {
          return undefined;
        }
        const rune = runeMap()[runeID];
        return rune != undefined && rune.locked !== true && !isRuneEquipped(rune) ? runeID : undefined;
      });
      return next.some((runeID, index) => runeID !== prev[index]) ? next : prev;
    });
  });
  const clearDragState = () => {
    setDraggingRuneID(undefined);
    setDragHoverSlotKey(undefined);
  };
  libs.createEffect(libs.on(show, isShow => {
    if (isShow) return;
    runeUnreadIds?.submitReadCache();
  }));
  const canBreakRune = rune => {
    if (rune == undefined) {
      return false;
    }
    if (rune.locked === true) {
      ErrorMessage(LOCKED_RUNE_BREAK_MESSAGE);
      return false;
    }
    if (isRuneEquipped(rune)) {
      ErrorMessage(EQUIPPED_RUNE_BREAK_MESSAGE);
      return false;
    }
    return true;
  };
  const addRuneToBreakSlot = (runeID, slot) => {
    if (!canBreakRune(runeMap()[runeID])) {
      return false;
    }
    setBreakRuneIDs(prev => {
      const next = [...prev];
      const oldSlot = next.indexOf(runeID);
      if (oldSlot >= 0) {
        next[oldSlot] = undefined;
      }
      const targetSlot = slot != undefined ? slot : selectedBreakSlot() >= 0 ? selectedBreakSlot() : next.findIndex(id => id == undefined);
      if (targetSlot < 0 || targetSlot >= RUNE_BREAK_SLOT_NUM) {
        return prev;
      }
      next[targetSlot] = runeID;
      return next;
    });
    return true;
  };
  const removeRuneFromBreakSlots = runeID => {
    setBreakRuneIDs(prev => {
      const next = prev.map(id => id === runeID ? undefined : id);
      return next.some((id, index) => id !== prev[index]) ? next : prev;
    });
  };
  const handleFastAddBreakRunes = rarity => {
    setSelectedBreakSlot(-1);
    setShowBreakAttrInfo(false);
    setShowFilter(false);
    setBreakRuneIDs(prev => {
      const selectedIDs = prev.filter(id => {
        const rune = id == undefined ? undefined : runeMap()[id];
        return rune != undefined && rune.locked !== true && !isRuneEquipped(rune);
      });
      const selectedIDMap = selectedIDs.reduce((result, id) => {
        result[id] = true;
        return result;
      }, {});
      const addList = [...selectedIDs];
      const fastAddCandidates = [...runeList()].sort((a, b) => {
        return a.rarity - b.rarity || a.rune_item_id - b.rune_item_id || a.id - b.id;
      });
      for (const rune of fastAddCandidates) {
        if (addList.length >= RUNE_BREAK_SLOT_NUM) {
          break;
        }
        if (rune.locked === true || isRuneEquipped(rune) || selectedIDMap[rune.id] === true) {
          continue;
        }
        if (rarity != 0 && rune.rarity != rarity) {
          continue;
        }
        addList.push(rune.id);
        selectedIDMap[rune.id] = true;
      }
      if (addList.length == 0) {
        return prev;
      }
      return Array.from({
        length: RUNE_BREAK_SLOT_NUM
      }, (_, index) => addList[index]);
    });
  };
  const handleConfirmBreakRunes = playSuccessEffect => {
    if (requesting()) {
      return;
    }
    const ids = breakRunes().filter(rune => rune != undefined && rune.locked !== true && !isRuneEquipped(rune)).map(rune => rune.id);
    if (ids.length == 0) {
      return;
    }
    setRequesting(true);
    CallActionRequest("/v1/rune/break", {
      ids
    }, result => {
      setRequesting(false);
      if (result.code !== 0) {
        if (result.message != undefined) {
          if (result.message === "rune in check") {
            ErrorMessage("#RuneBreak_InCheckRuneNotAllow");
          } else {
            ErrorMessage(result.message);
          }
        }
        return;
      }
      playSuccessEffect();
      setBreakRuneIDs(createEmptyBreakSlots());
    }, () => {
      setRequesting(false);
    });
  };
  const handleSelectBreakSlot = slot => {
    libs.batch(() => {
      setSelectedBreakSlot(slot);
      setShowBreakAttrInfo(false);
      setShowFilter(false);
    });
  };
  const handleShowBreakAttrs = () => {
    libs.batch(() => {
      setSelectedBreakSlot(-1);
      setShowBreakAttrInfo(true);
    });
  };
  const handleToggleBreakAttrs = () => {
    const nextVisible = !showBreakAttrInfo();
    libs.batch(() => {
      setShowBreakAttrInfo(nextVisible);
      if (nextVisible) {
        setSelectedBreakSlot(-1);
      }
    });
  };
  const handleClearBreakSlot = slot => {
    setBreakRuneIDs(prev => {
      const next = [...prev];
      next[slot] = undefined;
      return next;
    });
  };
  const handleDropBreakRune = (slot, runeID) => {
    if (requesting() || runeID <= 0) {
      return;
    }
    setSelectedRuneID(runeID);
    addRuneToBreakSlot(runeID, slot);
  };
  const setDevourRuneSlot = (slot, runeID) => {
    if (runeID == undefined) {
      if (slot === "left") {
        setDevourLeftRuneID(undefined);
      } else {
        setDevourRightRuneID(undefined);
      }
      return;
    }
    const rune = runeMap()[runeID];
    if (slot === "left" && (rune == undefined || rune.rarity < DEVOUR_LEFT_RUNE_MIN_RARITY)) {
      ErrorMessage("#RuneDevour_LeftCardRarityNotAllow");
      return;
    }
    if (slot === "right" && rune?.locked === true) {
      ErrorMessage("#RuneDevour_LockedRuneNotAllow");
      return;
    }
    if (slot === "right" && isRuneEquipped(rune)) {
      ErrorMessage(EQUIPPED_RUNE_DEVOUR_MESSAGE);
      return;
    }
    setSelectedRuneID(runeID);
    if (slot === "left") {
      setDevourLeftRuneID(runeID);
      if (devourRightRuneID() === runeID) {
        setDevourRightRuneID(undefined);
      }
      return;
    }
    setDevourRightRuneID(runeID);
    if (devourLeftRuneID() === runeID) {
      setDevourLeftRuneID(undefined);
    }
  };
  const handleDevourRuneActivate = runeID => {
    if (requesting() || devourPreviewing()) {
      ErrorMessage("#RuneDevour_PreviewBlockSelect");
      return;
    }
    const rune = runeMap()[runeID];
    if (rune == undefined) {
      return;
    }
    if (rune.rarity < DEVOUR_LEFT_RUNE_MIN_RARITY) {
      setDevourRuneSlot("right", runeID);
      return;
    }
    if (devourLeftRuneID() === runeID) {
      return;
    }
    setDevourRuneSlot(devourLeftRuneID() == undefined ? "left" : "right", runeID);
  };
  const handleRuneActivate = runeID => {
    if (menuName() === "RuneDevour_Menu") {
      handleDevourRuneActivate(runeID);
      return;
    }
    setSelectedRuneID(runeID);
    if (menuName() === "RuneBreak_Menu") {
      addRuneToBreakSlot(runeID);
      return;
    }
  };
  const handleDevourDrop = (slot, runeID) => {
    if (requesting() || devourPreviewing() || runeID <= 0) {
      return;
    }
    setDevourRuneSlot(slot, runeID);
  };
  const handleDevourRemove = slot => {
    if (requesting() || devourPreviewing()) {
      return;
    }
    setDevourRuneSlot(slot, undefined);
  };
  const callEquipRune = (position, runeID) => {
    CallAction("/v1/hero/equip_rune", {
      hero_id: position.heroID,
      suit_id: position.planID,
      skill_id: position.skillID,
      slot_id: position.slotID,
      rune_id: runeID
    });
  };
  const findRuneEquipPositions = (runeID, heroID, planID) => {
    const result = [];
    for (const [rawHeroID, planList] of Object.entries(player_hero_rune_equip_suits())) {
      const normalizedHeroID = Number(rawHeroID);
      if (heroID != undefined && normalizedHeroID !== heroID) {
        continue;
      }
      for (const [rawPlanID, skillList] of Object.entries(planList)) {
        const normalizedPlanID = Number(rawPlanID);
        if (planID != undefined && normalizedPlanID !== planID) {
          continue;
        }
        for (const [rawSkillID, slotList] of Object.entries(skillList)) {
          for (const [rawSlotID, equippedRuneID] of Object.entries(slotList)) {
            if (Number(equippedRuneID) !== runeID) {
              continue;
            }
            result.push({
              heroID: normalizedHeroID,
              planID: normalizedPlanID,
              skillID: Number(rawSkillID),
              slotID: Number(rawSlotID)
            });
          }
        }
      }
    }
    return result;
  };
  const buildEmbedContextMenus = runeID => {
    const menus = {};
    const context = runeEmbedContext();
    if (!context || requesting()) {
      return menus;
    }
    const currentPositions = findRuneEquipPositions(runeID, context.heroID, context.planID);
    const emptySlot = context.slots.find(slot => slot.locked !== true && slot.isEmpty === true);
    if (emptySlot && currentPositions.length === 0) {
      menus["RuneItem_OptEquip"] = () => {
        context.equipRune(emptySlot.slotID, runeID);
      };
    }
    if (currentPositions.length > 0) {
      menus["RuneItem_OptUnequip"] = () => {
        callEquipRune(currentPositions[0], 0);
      };
    }
    const allPositions = findRuneEquipPositions(runeID);
    if (allPositions.length > 0) {
      menus["RuneItem_OptUnequipAll"] = () => {
        for (const position of allPositions) {
          callEquipRune(position, 0);
        }
      };
    }
    return menus;
  };
  const buildDevourContextMenus = runeID => {
    const menus = {};
    if (requesting() || devourPreviewing()) {
      return menus;
    }
    if (devourLeftRuneID() === runeID) {
      menus["RuneItem_OptTakeLeft"] = () => {
        setDevourRuneSlot("left", undefined);
      };
    } else {
      menus["RuneItem_OptPutLeft"] = () => {
        setDevourRuneSlot("left", runeID);
      };
    }
    if (devourRightRuneID() === runeID) {
      menus["RuneItem_OptTakeRight"] = () => {
        setDevourRuneSlot("right", undefined);
      };
    } else if (!isRuneEquipped(runeMap()[runeID])) {
      menus["RuneItem_OptPutRight"] = () => {
        setDevourRuneSlot("right", runeID);
      };
    }
    return menus;
  };
  const buildBreakContextMenus = runeID => {
    const menus = {};
    if (requesting()) {
      return menus;
    }
    if (breakRuneIDs().includes(runeID)) {
      menus["RuneItem_OptTakeOut"] = () => {
        removeRuneFromBreakSlots(runeID);
      };
    } else {
      menus["RuneItem_OptPutIn"] = () => {
        setSelectedRuneID(runeID);
        addRuneToBreakSlot(runeID);
      };
    }
    return menus;
  };
  const buildRuneContextMenus = runeID => {
    const rune = runeMap()[runeID];
    if (!rune) {
      return {};
    }
    const menus = {};
    menus[rune.locked === true ? "RuneItem_OptUnlock" : "RuneItem_OptLock"] = () => {
      handleRuneLock(runeID, rune.locked !== true);
    };
    Object.assign(menus, (() => {
      if (menuName() === "RuneEmbed_Menu") {
        return buildEmbedContextMenus(runeID);
      }
      if (menuName() === "RuneDevour_Menu") {
        return buildDevourContextMenus(runeID);
      }
      if (menuName() === "RuneBreak_Menu") {
        return buildBreakContextMenus(runeID);
      }
      return {};
    })());
    return menus;
  };
  const handleRuneContextMenu = (panel, runeID) => {
    const menus = buildRuneContextMenus(runeID);
    if (Object.keys(menus).length > 0) {
      CustomUIConfig.showContextMenu(panel, menus);
    }
  };
  const resetDevourSelection = () => {
    setDevourRightRuneID(undefined);
    setSelectedRuneID(undefined);
    setDevourPreviewing(false);
    clearDragState();
  };
  libs.createEffect(libs.on(menuName, name => {
    libs.batch(() => {
      setSelectedBreakSlot(-1);
      setBreakRuneIDs(createEmptyBreakSlots());
      setShowBreakAttrInfo(name === "RuneBreak_Menu");
      if (name !== "RuneEmbed_Menu") {
        setRuneEmbedContext(undefined);
      }
    });
  }));
  let queryEquipment = false;
  libs.createEffect(() => {
    if (show() && !queryEquipment) {
      queryEquipment = true;
      CallAction("/v1/equip/fetch_all", {
        only_equipped: false
      });
    }
  });
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout, {
    id: "RuneRoot",
    name: "MenuButton_rune",
    renderOnShow: true,
    get show() {
      return show();
    },
    get children() {
      return [libs.createComponent(Player.CurrencyGroup, {
        currencyType: "top",
        tokens: [120015]
      }), libs.createComponent(LayoutMenu, {}), libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
        id: "RuneContent",
        get topbarChildren() {
          return (() => {
            const _el$33 = libs.createElement("Panel", {
                id: "BGRoot",
                get ["class"]() {
                  return menuName() == "RuneDevour_Menu" ? "DevourPage" : "EmbedPage";
                },
                hittest: false
              }, null);
              libs.createElement("Panel", {
                id: "CustomTopBottomBG",
                hittest: false
              }, _el$33);
            libs.effect(_$p => libs.setProp(_el$33, "class", menuName() == "RuneDevour_Menu" ? "DevourPage" : "EmbedPage", _$p));
            return _el$33;
          })();
        },
        get children() {
          const _el$26 = libs.createElement("Panel", {
              id: "RuneContentMain"
            }, null),
            _el$27 = libs.createElement("Panel", {
              id: "RuneContentLeft"
            }, _el$26),
            _el$28 = libs.createElement("Panel", {
              id: "RuneContentRight"
            }, _el$26);
          libs.insert(_el$27, libs.createComponent(libs.Switch, {
            get children() {
              return [libs.createComponent(libs.Match, {
                get when() {
                  return menuName() == "RuneEmbed_Menu";
                },
                get children() {
                  return libs.createComponent(RuneEmbed, {
                    abilityDisplayMappings: abilityDisplayMappings,
                    requesting: requesting,
                    setRequesting: setRequesting,
                    setPeekedRuneIDs: setPeekedRuneIDs,
                    dragHoverSlotKey: dragHoverSlotKey,
                    setDragHoverSlotKey: setDragHoverSlotKey,
                    clearDragState: clearDragState,
                    onContextChange: setRuneEmbedContext
                  });
                }
              }), libs.createComponent(libs.Match, {
                get when() {
                  return menuName() == "RuneDevour_Menu";
                },
                get children() {
                  return libs.createComponent(RuneDevour, {
                    get leftRune() {
                      return devourLeftRune();
                    },
                    get rightRune() {
                      return devourRightRune();
                    },
                    requesting: requesting,
                    setRequesting: setRequesting,
                    onDropRune: handleDevourDrop,
                    onRemoveRune: handleDevourRemove,
                    onPreviewingChange: setDevourPreviewing,
                    onResetSelection: resetDevourSelection
                  });
                }
              }), libs.createComponent(libs.Match, {
                get when() {
                  return menuName() == "RuneBreak_Menu";
                },
                get children() {
                  return libs.createComponent(RuneBreak, {
                    selectedBreakSlot: selectedBreakSlot,
                    breakRunes: breakRunes,
                    currentLevel: () => runeBreakLevel().level,
                    currentExp: () => runeBreakLevel().extra_exp,
                    requesting: requesting,
                    onSelectBreakSlot: handleSelectBreakSlot,
                    onClearBreakSlot: handleClearBreakSlot,
                    onDropRune: handleDropBreakRune,
                    onShowBreakAttrs: handleShowBreakAttrs,
                    onToggleBreakAttrs: handleToggleBreakAttrs,
                    onFastAdd: handleFastAddBreakRunes,
                    onConfirm: handleConfirmBreakRunes
                  });
                }
              })];
            }
          }));
          libs.insert(_el$28, libs.createComponent(libs.Show, {
            get when() {
              return rightShowAttrInfo();
            },
            get children() {
              return libs.createComponent(RuneBreakAttributeInfo, {
                currentLevel: () => runeBreakLevel().level
              });
            }
          }), null);
          libs.insert(_el$28, libs.createComponent(libs.Show, {
            get when() {
              return !rightShowAttrInfo();
            },
            get children() {
              const _el$29 = libs.createElement("Panel", {
                  id: "RuneBagContainer"
                }, null),
                _el$30 = libs.createElement("Panel", {
                  id: "RuneBagContainerTop"
                }, _el$29);
                libs.createElement("Image", {
                  id: "RuneContentRightTopBG"
                }, _el$30);
                const _el$32 = libs.createElement("Label", {
                  id: "RuneContentRightTopTitle",
                  get ["class"]() {
                    return libs.classNames({
                      Full: isRuneBagFull()
                    });
                  },
                  get text() {
                    return `${runeBagCount()}/${RUNE_BAG_MAX_CAPACITY}`;
                  }
                }, _el$30);
              libs.insert(_el$29, libs.createComponent(RuneBagRoot, {
                suitFilter: suitFilter,
                setSuitFilter: setSuitFilter,
                runeList: runeList,
                peekedRuneIDs: bagPeekedRuneIDs,
                requesting: requesting,
                selectedRuneID: selectedRuneID,
                get selectedRuneIDs() {
                  return menuName() === "RuneBreak_Menu" ? breakSelectedRuneIDs : undefined;
                },
                onRuneActivate: handleRuneActivate,
                onRuneContextMenu: handleRuneContextMenu,
                selectionBlocked: () => menuName() === "RuneDevour_Menu" && (requesting() || devourPreviewing()),
                draggingRuneID: draggingRuneID,
                setDraggingRuneID: setDraggingRuneID,
                clearDragState: clearDragState,
                isRuneNew: isRuneNew,
                markRuneRead: markRuneRead
              }), null);
              libs.effect(_p$ => {
                const _v$8 = libs.classNames({
                    Full: isRuneBagFull()
                  }),
                  _v$9 = `${runeBagCount()}/${RUNE_BAG_MAX_CAPACITY}`;
                _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$32, "class", _v$8, _p$._v$8));
                _v$9 !== _p$._v$9 && (_p$._v$9 = libs.setProp(_el$32, "text", _v$9, _p$._v$9));
                return _p$;
              }, {
                _v$8: undefined,
                _v$9: undefined
              });
              return _el$29;
            }
          }), null);
          return _el$26;
        }
      })];
    }
  });
}
function HudRune() {
  return libs.createComponent(libs.Show, {
    get when() {
      return show();
    },
    get children() {
      return libs.createComponent(RunePage, {});
    }
  });
}
libs.render(() => libs.createComponent(HudRune, {}), $.GetContextPanel());