--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('greevil_icon', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');

const GreevilIcon = props => {
  const isRecordOnly = props.mode == "shop_record";
  const isIconOnly = props.mode == "icon_only";
  const isBattleRecord = props.battle_record_data !== undefined;
  const shopInfoShow = () => true;
  const [levelUpFlash, setLevelUpFlash] = libs.createSignal(false);
  let levelUpFlashTimer;
  let _shopInfoShowLast = shopInfoShow();
  let ref;
  libs.createEffect(() => {
    const state = shopInfoShow();
    if (state != _shopInfoShowLast && state == false) {
      ref?.TriggerClass("ShopInfoHide");
    }
    _shopInfoShowLast = state;
  });
  const _DEFAULT_GREEVIL_SHOP_RECORD = {
    trait: false,
    card_effect: false,
    greevil_effect: false,
    attribute: false
  };
  const _DEFAULT_GREEVIL_DATA = {
    egg_type: "",
    greevil_name: "",
    stage: GreevilStage.EGG,
    exp: 0,
    level: 0,
    total_exp: 0,
    next_level_exp: 1,
    shop_enabled: false
  };
  const [greevilData, setGreevilData] = libs.createSignal(_DEFAULT_GREEVIL_DATA);
  const [greevilShopRecord, setGreevilShopRecord] = libs.createSignal(_DEFAULT_GREEVIL_SHOP_RECORD);
  const GreevilRecordTypes = isBattleRecord ? ["greevil_effect", "card_effect"] : ["greevil_effect", "card_effect", "attribute"];
  const battleRecordShopRecord = () => {
    const data = props.battle_record_data;
    if (!data) return _DEFAULT_GREEVIL_SHOP_RECORD;
    const effects = Object.values(JSON.parseSafe(data.greevil_effects ?? "") ?? []);
    const traits = Object.values(JSON.parseSafe(data.nemestice_embers ?? "") ?? []);
    const runes = Object.values(JSON.parseSafe(data.runes ?? "") ?? []);
    return {
      trait: traits.length > 0,
      card_effect: runes.length > 0,
      greevil_effect: effects.length > 0 || traits.length > 0,
      attribute: false
    };
  };
  const currentShopRecord = () => isBattleRecord ? battleRecordShopRecord() : greevilShopRecord();
  const effectiveGreevilData = () => {
    const brd = props.battle_record_data;
    if (!brd) return greevilData();
    const hasGreevil = (brd.greevil_type ?? "") !== "";
    return {
      ..._DEFAULT_GREEVIL_DATA,
      egg_type: brd.greevil_egg ?? "",
      greevil_name: brd.greevil_type ?? "",
      stage: hasGreevil ? GreevilStage.GREEVIL : GreevilStage.EGG
    };
  };
  libs.createEffect(libs.on(() => props.playerID, () => {
    if (isBattleRecord) return;
    UpdateGreevilData();
    UpdateGreevilShopRecord();
  }));
  const UpdateGreevilData = (data = getSyncDataKey("common", "greevil_data", props.playerID)) => {
    if (props.playerID != -1 && data) {
      setGreevilData(data);
    } else {
      setGreevilData(_DEFAULT_GREEVIL_DATA);
    }
  };
  const UpdateGreevilShopRecord = (data = getSyncDataKey("common", "greevil_shop_record", props.playerID)) => {
    if (props.playerID != -1 && data) {
      setGreevilShopRecord({
        trait: (data.trait ?? []).length > 0,
        card_effect: (data.card_effect ?? []).length > 0,
        greevil_effect: (data.greevil_effect ?? []).length > 0,
        attribute: Object.keys(data.attribute ?? {}).length > 0
      });
    } else {
      setGreevilShopRecord(_DEFAULT_GREEVIL_SHOP_RECORD);
    }
  };
  const GREEVIL_SETTINGS = CustomNetTables.GetTableValue("common", "greevil_setting");
  const computeLevelFromExp = totalExp => {
    let lv = 0;
    for (let i = 0; i < 99; i++) {
      const threshold = GREEVIL_SETTINGS?.GREEVIL_LEVEL_EXP?.[i];
      if (threshold == undefined) break;
      if (totalExp >= threshold) lv = i + 1;else break;
    }
    return lv;
  };
  const effectiveLevel = () => isBattleRecord ? computeLevelFromExp(props.battle_record_data.greevil_exp ?? 0) : greevilData().level ?? 0;
  const greevilLevelProgress = () => {
    if (isBattleRecord) {
      const totalExp = props.battle_record_data.greevil_exp ?? 0;
      const lv = computeLevelFromExp(totalExp);
      const low = lv > 0 ? GREEVIL_SETTINGS?.GREEVIL_LEVEL_EXP?.[lv - 1] ?? 0 : 0;
      const up = GREEVIL_SETTINGS?.GREEVIL_LEVEL_EXP?.[lv] ?? 0;
      if (up == 0) {
        return 100;
      }
      return Clamp((totalExp - low) / (up - low) * 100, 0, 100);
    }
    if (greevilData().stage == GreevilStage.EGG) {
      const task = greevilData().egg_task;
      if (!task) {
        return 0;
      }
      if (task.finish) {
        return 100;
      }
      return Clamp(task.progress / task.target * 100, 0, 100);
    }
    const lv0Exp = 0;
    let lv = greevilData().level ?? 0;
    let low_lv = lv - 1;
    let low = low_lv >= 1 ? (GREEVIL_SETTINGS?.GREEVIL_LEVEL_EXP[low_lv] ?? 0) - lv0Exp : 0;
    let up = (GREEVIL_SETTINGS?.GREEVIL_LEVEL_EXP[lv] ?? 0) - lv0Exp;
    if (up <= 0) {
      return 100;
    }
    let exp = greevilData().exp;
    return Clamp((exp - low) / (up - low) * 100, 0, 100);
  };
  const canHatch = () => props.playerID == Players.GetLocalPlayer() && greevilData().stage == GreevilStage.EGG && !!greevilData().egg_task?.finish;
  const greevilExpTooltip = () => {
    let tooltip = "";
    if (isBattleRecord) {
      const totalExp = props.battle_record_data.greevil_exp ?? 0;
      const lv = computeLevelFromExp(totalExp);
      tooltip += `${$.Localize("#Greevil_Level")}：${lv}<br>`;
      tooltip += `${$.Localize("#Greevil_Exp")}：${totalExp}`;
    } else if (greevilData().stage == GreevilStage.EGG) {
      const task = greevilData().egg_task;
      if (task) {
        tooltip += `${$.Localize("#Greevil_Hatch_Progress")}：${task.progress} / ${task.target}`;
        tooltip += `<br><br>${$.Localize("#Greevil_Egg_Task_" + task.type).replace("%d", String(task.target))}`;
      }
    } else {
      tooltip += `${$.Localize("#Greevil_Level")}：${greevilData().level}<br>`;
      if (greevilData().next_level_exp == 0) {
        tooltip += `${$.Localize("#Greevil_Exp")}： ${greevilData().exp}/Max`;
      } else {
        tooltip += `${$.Localize("#Greevil_Exp")}：${greevilData().exp}/${greevilData().next_level_exp}`;
      }
      tooltip += `<br><br>${$.Localize("#Greevil_Exp_Description")}`;
    }
    return tooltip;
  };
  libs.createEffect(libs.on(() => greevilData().level, (newLevel, oldLevel) => {
    if (oldLevel == undefined || props.playerID == -1 || newLevel <= oldLevel) {
      return;
    }
    setLevelUpFlash(true);
    if (levelUpFlashTimer != undefined) {
      $.CancelScheduled(levelUpFlashTimer);
    }
    levelUpFlashTimer = $.Schedule(0.45, () => {
      setLevelUpFlash(false);
      levelUpFlashTimer = undefined;
    });
  }));
  libs.onCleanup(() => {
    if (levelUpFlashTimer != undefined) {
      $.CancelScheduled(levelUpFlashTimer);
    }
  });
  libs.onMount(() => {
    if (isBattleRecord) return;
    const nettableListenerIDs = [];
    nettableListenerIDs.push(useSyncDataKey("common", "greevil_data", (data, id) => {
      if (id == props.playerID) {
        UpdateGreevilData(data);
      }
    }, -1));
    nettableListenerIDs.push(useSyncDataKey("common", "greevil_shop_record", (data, id) => {
      if (id == props.playerID) {
        UpdateGreevilShopRecord(data);
      }
    }, -1));
    libs.onCleanup(() => {
      nettableListenerIDs.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    });
  });
  const infoShow = () => isRecordOnly || shopInfoShow();
  return (() => {
    const _el$ = libs.createElement("Panel", {
        get ["class"]() {
          return libs.classNames("GreevilIcon", {
            Reverse: props.reverse,
            RecordOnly: isRecordOnly,
            IconOnly: isIconOnly
          });
        },
        hittest: false
      }, null),
      _el$2 = libs.createElement("Panel", {
        get ["class"]() {
          return libs.classNames("GreevilShopInfoBlock", {
            Show: infoShow()
          });
        }
      }, _el$);
    const _ref$ = ref;
    typeof _ref$ === "function" ? libs.use(_ref$, _el$2) : ref = _el$2;
    libs.insert(_el$2, libs.createComponent(libs.For, {
      each: GreevilRecordTypes,
      children: (recordType, index) => {
        const state = () => {
          const shopRecord = currentShopRecord();
          if (recordType == "greevil_effect") {
            return shopRecord["greevil_effect"] || shopRecord["trait"];
          }
          return shopRecord[recordType];
        };
        return (() => {
          const _el$10 = libs.createElement("Panel", {
            get ["class"]() {
              return libs.classNames("GreevilShopCategoryAnimation", "Anim_Pos" + index());
            },
            hittest: false
          }, null);
          libs.insert(_el$10, libs.createComponent(EOM_Panel.EOM_Panel, {
            get className() {
              return libs.classNames("GreevilShopCategory", "Pos" + index(), {
                Empty: !state()
              });
            },
            get customTooltip() {
              return isBattleRecord ? {
                name: "greevil_record",
                record_type: recordType,
                greevil_effects_json: props.battle_record_data.greevil_effects ?? "",
                trait_json: props.battle_record_data.nemestice_embers ?? "",
                card_effect_json: props.battle_record_data.runes ?? ""
              } : {
                name: "greevil_record",
                record_type: recordType,
                player_id: props.playerID
              };
            },
            get children() {
              const _el$11 = libs.createElement("Panel", {}, null);
                libs.createElement("Image", {}, _el$11);
              libs.effect(_$p => libs.setProp(_el$11, "className", libs.classNames("GreevilShopCategoryIcon", recordType), _$p));
              return _el$11;
            }
          }));
          libs.effect(_$p => libs.setProp(_el$10, "class", libs.classNames("GreevilShopCategoryAnimation", "Anim_Pos" + index()), _$p));
          return _el$10;
        })();
      }
    }));
    libs.insert(_el$, libs.createComponent(libs.Show, {
      when: !isRecordOnly,
      get children() {
        return [(() => {
          const _el$3 = libs.createElement("Panel", {}, null),
            _el$4 = libs.createElement("Panel", {
              "class": "GreevilPregress"
            }, _el$3),
            _el$5 = libs.createElement("Panel", {
              "class": "GreevilPregress_Full",
              get style() {
                return {
                  clip: `radial( 50% 50%, 225deg, ${greevilLevelProgress() * 2.7}deg )`
                };
              }
            }, _el$4),
            _el$6 = libs.createElement("Panel", {
              "class": "GreevilAbilityIconBox"
            }, _el$3),
            _el$9 = libs.createElement("Panel", {
              "class": "GreevilAbilityMask",
              hittest: false
            }, _el$6);
          libs.setProp(_el$3, "onactivate", () => {
            props.onHatchClick?.(canHatch());
          });
          libs.setProp(_el$4, "onmouseover", self => {
            $.DispatchEvent("DOTAShowTextTooltip", self, greevilExpTooltip());
          });
          libs.setProp(_el$4, "onmouseout", self => {
            $.DispatchEvent("DOTAHideTextTooltip", self);
          });
          libs.insert(_el$6, libs.createComponent(libs.Switch, {
            get children() {
              return [libs.createComponent(libs.Match, {
                get when() {
                  return libs.memo(() => effectiveGreevilData().stage == GreevilStage.EGG)() && effectiveGreevilData().egg_type != "";
                },
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    "class": "GreevilAbility",
                    get customTooltip() {
                      return isBattleRecord ? {
                        name: "greevil_ability",
                        egg_type: props.battle_record_data.greevil_egg ?? "",
                        greevil_name: props.battle_record_data.greevil_type ?? "",
                        level_override: String(computeLevelFromExp(props.battle_record_data.greevil_exp ?? 0))
                      } : {
                        name: "greevil_ability",
                        player_id: props.playerID
                      };
                    },
                    get children() {
                      const _el$7 = libs.createElement("DOTAAbilityImage", {
                        get abilityname() {
                          return effectiveGreevilData().egg_type;
                        }
                      }, null);
                      libs.effect(_$p => libs.setProp(_el$7, "abilityname", effectiveGreevilData().egg_type, _$p));
                      return _el$7;
                    }
                  });
                }
              }), libs.createComponent(libs.Match, {
                get when() {
                  return libs.memo(() => effectiveGreevilData().stage == GreevilStage.GREEVIL)() && effectiveGreevilData().greevil_name != "";
                },
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    "class": "GreevilAbility",
                    get customTooltip() {
                      return isBattleRecord ? {
                        name: "greevil_ability",
                        egg_type: props.battle_record_data.greevil_egg ?? "",
                        greevil_name: props.battle_record_data.greevil_type ?? "",
                        level_override: String(computeLevelFromExp(props.battle_record_data.greevil_exp ?? 0))
                      } : {
                        name: "greevil_ability",
                        player_id: props.playerID
                      };
                    },
                    get children() {
                      const _el$8 = libs.createElement("DOTAAbilityImage", {
                        get abilityname() {
                          return effectiveGreevilData().greevil_name;
                        }
                      }, null);
                      libs.effect(_$p => libs.setProp(_el$8, "abilityname", effectiveGreevilData().greevil_name, _$p));
                      return _el$8;
                    }
                  });
                }
              })];
            }
          }), _el$9);
          libs.effect(_p$ => {
            const _v$ = libs.classNames("GreevilAbilityIcon", {
                CanHatch: canHatch(),
                EggStage: greevilData().stage == GreevilStage.EGG,
                LevelUpFlash: levelUpFlash()
              }),
              _v$2 = {
                clip: `radial( 50% 50%, 225deg, ${greevilLevelProgress() * 2.7}deg )`
              };
            _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$3, "className", _v$, _p$._v$));
            _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$5, "style", _v$2, _p$._v$2));
            return _p$;
          }, {
            _v$: undefined,
            _v$2: undefined
          });
          return _el$3;
        })(), (() => {
          const _el$0 = libs.createElement("Panel", {}, null),
            _el$1 = libs.createElement("Label", {
              get text() {
                return String(effectiveLevel());
              }
            }, _el$0);
          libs.setProp(_el$0, "onmouseover", self => {
            $.DispatchEvent("DOTAShowTextTooltip", self, greevilExpTooltip());
          });
          libs.setProp(_el$0, "onmouseout", self => {
            $.DispatchEvent("DOTAHideTextTooltip", self);
          });
          libs.effect(_p$ => {
            const _v$3 = libs.classNames("GreevilLevelBadge", {
                CanHatch: canHatch(),
                LevelUpFlash: levelUpFlash()
              }),
              _v$4 = String(effectiveLevel());
            _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$0, "className", _v$3, _p$._v$3));
            _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$1, "text", _v$4, _p$._v$4));
            return _p$;
          }, {
            _v$3: undefined,
            _v$4: undefined
          });
          return _el$0;
        })()];
      }
    }), null);
    libs.effect(_p$ => {
      const _v$5 = libs.classNames("GreevilIcon", {
          Reverse: props.reverse,
          RecordOnly: isRecordOnly,
          IconOnly: isIconOnly
        }),
        _v$6 = libs.classNames("GreevilShopInfoBlock", {
          Show: infoShow()
        });
      _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$, "class", _v$5, _p$._v$5));
      _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$2, "class", _v$6, _p$._v$6));
      return _p$;
    }, {
      _v$5: undefined,
      _v$6: undefined
    });
    return _el$;
  })();
};

exports.GreevilIcon = GreevilIcon;