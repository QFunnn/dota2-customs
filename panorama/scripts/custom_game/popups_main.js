--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Icon = require('./EOM_Icon.js');
var EOM_Image = require('./EOM_Image.js');
var EOM_Label = require('./EOM_Label.js');
var EOM_Button = require('./EOM_Button.js');
var RuneRewardCard = require('./RuneRewardCard.js');
var rookie_utils = require('./rookie_utils.js');
var AbilityDescription = require('./AbilityDescription.js');
var AbilityImage = require('./AbilityImage.js');
var GenericPanel = require('./GenericPanel.js');
var ShardAbility = require('./ShardAbility.js');
require('./Heroes.js');

const BasePopupMain = props => {
  const merged = libs.mergeProps$1({
    closeOnClickOuter: true,
    closeOnEsc: true,
    closeGroup: true
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "id", "closeOnClickOuter", "closeOnEsc", "closeGroup", "PopupID", "group"]);
  const onClickOuter = () => {
    if (local.closeOnClickOuter) {
      closePopupMain(local.PopupID);
    }
  };
  const onEsc = () => {
    if (local.closeOnEsc) {
      closePopupMain(local.PopupID);
    }
  };
  libs.onMount(() => {
    const id = GameEvents.Subscribe("client_side_event", eventData => {
      if ("close_popup_main_fadeout" == eventData.event_name) {
        let data = eventData.event_data;
        if (data.PopupID) {
          if (local.PopupID == data.PopupID) {
            libs.batch(() => {
              setPopupShow(false);
              setPopupClose(true);
            });
          }
        } else if (data.group) {
          if (local.group == data.group) {
            libs.batch(() => {
              setPopupShow(false);
              setPopupClose(true);
            });
          }
        }
      }
    });
    libs.onCleanup(() => {
      GameEvents.Unsubscribe(id);
    });
  });
  const [popupShow, setPopupShow] = libs.createSignal(false);
  const [popupClose, setPopupClose] = libs.createSignal(false);
  let buttonProps = {};
  if (local.closeOnClickOuter) {
    buttonProps.onactivate = onClickOuter;
  }
  return (() => {
    const _el$ = libs.createElement("Button", libs.mergeProps({
      get id() {
        return local.PopupID;
      }
    }, () => EOM_Panel.EOMProps(others, {
      className: libs.classNames("PopupContainer", "PopupType_PopOut", {
        EOM_PopupMainShow: popupShow(),
        EOM_PopupMainClose: popupClose()
      })
    }), {
      get hittest() {
        return local.closeOnClickOuter;
      }
    }, buttonProps), null);
    libs.spread(_el$, libs.mergeProps({
      get id() {
        return local.PopupID;
      }
    }, () => EOM_Panel.EOMProps(others, {
      className: libs.classNames("PopupContainer", "PopupType_PopOut", {
        EOM_PopupMainShow: popupShow(),
        EOM_PopupMainClose: popupClose()
      })
    }), {
      "onload": self => {
        setPopupShow(true);
        self.SetFocus();
      },
      "oncancel": self => onEsc(),
      get hittest() {
        return local.closeOnClickOuter;
      }
    }, buttonProps), true);
    libs.insert(_el$, () => local.children);
    return _el$;
  })();
};

const PopupMain_RuneReward = props => {
  const [local, others] = libs.splitProps(props, ["PopupID", "group"]);
  const {
    group,
    PopupID
  } = local;
  const [gameState, setGameState] = libs.createSignal("GameState_None");
  const [runeSelection, setRuneSelection] = libs.createSignal([]);
  const [runeRewardLoaded, setRuneRewardLoaded] = libs.createSignal(false);
  const [rewardSelection, setRewardSelection] = libs.createSignal();
  const showRuneRewardUI = () => runeSelection().length > 0;
  const canChooseRune = () => {
    return gameState() == "GameState_Prepare" || gameState() == "GameState_RuneTask" || gameState() == "GameState_SpecialSelection" || gameState() == "GameState_ArtifactSelection";
  };
  const [runeRewardRefreshCost, setRuneRewardRefreshCost] = libs.createSignal(-1);
  const rookieV2_trait = rookie_utils.useRookieV2Effect_Override({
    key: "trait_pick",
    params: {
      tooltip_position: "top"
    }
  }, 0.5);
  const rookieV2_trait_confirm = rookie_utils.useRookieV2Effect_Override({
    key: "trait_pick_confirm",
    params: {
      tooltip_position: "top"
    }
  }, 0.2);
  libs.onMount(() => {
    clientSideEvent("popup_main_rune_reward", {
      state: 1
    });
    const gameEventIDList = [];
    const netTableIDList = [];
    netTableIDList.push(useNetTableKeyHasDefaultValue("common", "constant", data => {
      updateRookieIndex();
    }));
    netTableIDList.push(useNetTableKeyHasDefaultValue("common", "game_state", data => {
      if (data.state == "GameState_None") {
        closePopupMain("RuneReward");
      }
      setGameState(data.state);
    }));
    netTableIDList.push(useNetTableKeyHasDefaultValue("common", "rune_reward_refresh_cost", data => {
      setRuneRewardRefreshCost(data?.cost ?? -1);
    }));
    netTableIDList.push(useNetTableKeyHasDefaultValue("common", "rune_reward_" + Players.GetLocalPlayer().toString(), data => {
      let entries = Object.entries(data);
      if (entries.length > 0) {
        let a = entries.sort((a, b) => Number(a[0]) - Number(b[0]))[0][1];
        setRuneSelection(Object.entries(a).sort((a, b) => Number(a[0]) - Number(b[0])).map(v => v[1]));
      } else {
        setRuneSelection([]);
      }
      setRuneRewardLoaded(true);
      setRewardSelection();
    }));
    netTableIDList.push(useNetTableKeyHasDefaultValue("player_data", Players.GetLocalPlayer().toString(), data => {
      if (data.health <= 0) {
        closePopupMain("RuneReward");
      }
      updateRookieIndex();
    }));
    libs.onCleanup(() => {
      clientSideEvent("popup_main_rune_reward", {
        state: 0
      });
      closeRookieV2Tip("trait_pick");
      closeRookieV2Tip("trait_pick_confirm");
      gameEventIDList.forEach(id => GameEvents.Unsubscribe(id));
      netTableIDList.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    });
  });
  let refreshCooldown = false;
  const [rookieRuneIndex, setRookieRuneIndex] = libs.createSignal(-1);
  const updateRookieIndex = () => {
    const heroName = CustomNetTables.GetTableValue("player_data", Players.GetLocalPlayer().toString())?.heroName;
    let index = -1;
    if (heroName) {
      const config = CustomNetTables.GetTableValue("common", "constant")?.ROOKIE_GUIDE_HERO_CONFIG;
      if (config) {
        if (config[heroName]) {
          index = runeSelection().indexOf(config[heroName].trait);
        }
      }
    }
    setRookieRuneIndex(index);
  };
  libs.createEffect(libs.on(runeSelection, () => {
    updateRookieIndex();
  }));
  libs.createEffect(libs.on(rewardSelection, v => {
    if (v) {
      rookieV2_trait_confirm.open();
    }
  }));
  libs.createEffect(libs.on(rookieRuneIndex, i => {
    if (i != -1) {
      rookieV2_trait.open();
    } else {
      rookieV2_trait.close();
    }
  }));
  closeRookieV2Tip("rune_task");
  closeRookieV2Tip("rune_task_confirm");
  return libs.createComponent(BasePopupMain, {
    className: "PopupMain_RuneTask",
    PopupID: PopupID,
    group: group,
    closeOnClickOuter: false,
    closeOnEsc: false,
    get children() {
      return libs.createComponent(EOM_Panel.EOM_Panel, {
        get className() {
          return libs.classNames("RuneTaskSelectionMain Reward", {
            Show: true
          });
        },
        onactivate: () => {},
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "RuneTaskTitle",
            get children() {
              return [libs.createComponent(EOM_Image.EOM_Image, {
                className: "RuneTaskTitleEdge Left"
              }), libs.createComponent(EOM_Image.EOM_Image, {
                className: "RuneTaskTitleEdge Right"
              }), libs.createComponent(EOM_Label.EOM_Label, {
                text: "#RuneReward"
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "RuneRewardSelectionList",
            get children() {
              return libs.createComponent(libs.Index, {
                get each() {
                  return runeSelection();
                },
                children: (abilityName, i) => {
                  if (abilityName() != "") {
                    let ref;
                    libs.createEffect(libs.on(rookieRuneIndex, _index => {
                      if (_index == i && ref?.IsValid()) {
                        rookieV2_trait.setRef(ref);
                        rookieV2_trait.open();
                      }
                    }));
                    return libs.createComponent(EOM_Panel.EOM_Panel, {
                      get className() {
                        return libs.classNames("RuneRewardButtonContainer", "Index", {
                          Show: showRuneRewardUI()
                        });
                      },
                      marginLeft: "52px",
                      x: `${i * (240 + 50) + 25 - 110}px`,
                      hittest: false,
                      get children() {
                        return [libs.createComponent(EOM_Panel.EOM_Panel, {
                          className: "RuneRewardButtons",
                          hittest: false,
                          get children() {
                            return [libs.createComponent(EOM_Button.EOM_BaseButton, {
                              ref(r$) {
                                const _ref$ = ref;
                                typeof _ref$ === "function" ? _ref$(r$) : ref = r$;
                              },
                              get className() {
                                return libs.classNames("RuneRewardButton", {
                                  Selected: rewardSelection() == abilityName()
                                });
                              },
                              onload: self => {
                                if (i == rookieRuneIndex()) {
                                  rookieV2_trait.setRef(self);
                                }
                              },
                              get enabled() {
                                return rewardSelection() != abilityName();
                              },
                              onactivate: () => {
                                setRewardSelection(abilityName());
                                if (i == rookieRuneIndex() && rookieV2_trait.state()) {
                                  rookieV2_trait.complete();
                                }
                              },
                              get children() {
                                return [libs.createComponent(EOM_Panel.EOM_Panel, {
                                  id: "RuneRewardCardBGPath",
                                  hittest: false
                                }), libs.createComponent(RuneRewardCard.RuneRewardCard, {
                                  get trait() {
                                    return abilityName();
                                  }
                                })];
                              }
                            }), libs.createComponent(libs.Show, {
                              get when() {
                                return runeRewardRefreshCost() > 0;
                              },
                              get children() {
                                return libs.createComponent(EOM_Button.EOM_BaseButton, {
                                  className: "RuneRewardCost",
                                  tooltip_text: "#Refresh",
                                  onactivate: () => {
                                    if (refreshCooldown) {
                                      return;
                                    }
                                    if (!abilityName()) {
                                      return;
                                    }
                                    refreshCooldown = true;
                                    $.Schedule(0.1, () => {
                                      refreshCooldown = false;
                                    });
                                    GameEvents.SendCustomEventToServer("refresh_rune_reward", {
                                      ability: abilityName()
                                    });
                                  },
                                  get children() {
                                    return [libs.createComponent(EOM_Icon.EOM_Icon, {
                                      className: "RuneRefreshIcon"
                                    }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                      id: "RefreshCost",
                                      get children() {
                                        return [libs.createComponent(EOM_Icon.EOM_Icon, {
                                          size: "24",
                                          get src() {
                                            return getSrcPath("icon/icon_gold_bevel_psd.png");
                                          }
                                        }), libs.createComponent(EOM_Label.EOM_Label, {
                                          get text() {
                                            return `${runeRewardRefreshCost()}`;
                                          }
                                        })];
                                      }
                                    })];
                                  }
                                });
                              }
                            })];
                          }
                        }), libs.createElement("DOTAParticleScenePanel", {
                          id: "RuneRewardCardAppearParticle",
                          particleName: "particles/eom/ui/ui_fx/ui_game_card_float_fx.vpcf",
                          lookAt: "10 0 0",
                          cameraOrigin: "10 0 250",
                          squarePixels: true,
                          fov: 45,
                          hittest: false
                        }, null)];
                      }
                    });
                  }
                }
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "RuneTaskSelections",
            get children() {
              return libs.createComponent(EOM_Button.EOM_Button, {
                color: "Blue",
                text: "#Popup_Button_Confirm",
                get enabled() {
                  return libs.memo(() => !!runeRewardLoaded())() && (runeSelection().length == 0 || rewardSelection() != undefined);
                },
                onactivate: () => {
                  if (!canChooseRune()) {
                    ErrorMessage("#battle_cannotchoose");
                  } else {
                    GameEvents.SendCustomEventToServer("select_rune_reward", {
                      ability: rewardSelection() ?? ""
                    });
                    closePopupMain("RuneReward");
                  }
                  if (rookieV2_trait_confirm.state()) {
                    rookieV2_trait_confirm.complete();
                  }
                },
                onload: self => {
                  rookieV2_trait_confirm.setRef(self);
                }
              });
            }
          }), libs.createComponent(EOM_Button.EOM_BaseButton, {
            id: "RuneRewardHideButton",
            onactivate: () => {
              closePopupMain("RuneReward");
            },
            tooltip_text: "#button_hide"
          })];
        }
      });
    }
  });
};

const PopupMain_ShardUnlock = props => {
  const [local, others] = libs.splitProps(props, ["PopupID", "group"]);
  const {
    group,
    PopupID
  } = local;
  const [heroName, setHeroName] = libs.createSignal();
  const [gold, setGold] = libs.createSignal(0);
  const shardAbility = libs.createMemo(() => {
    let name = `${heroName()}_shard`;
    if (!KeyValues.HeroShardKv[name]) {
      name = "shard_empty";
    }
    return name;
  });
  const [shardState, setShardState] = libs.createSignal(false);
  const [shardDiscount, setShardDiscount] = libs.createSignal(0);
  const [shardCostConfig, setShardCostConfig] = libs.createSignal({});
  const [shardPurchasable, setShardPurchasable] = libs.createSignal(false);
  const shardCost = libs.createMemo(() => {
    if (typeof KeyValues.HeroShardKv[shardAbility()]?.ShardLevel == "number") {
      const config = shardCostConfig()[KeyValues.HeroShardKv[shardAbility()].ShardLevel];
      return Math.max(config.min, config.origin - shardDiscount());
    }
    return -1;
  });
  const shardButtonText = () => {
    if (shardState()) {
      return "#HeroShard_Unlocked";
    }
    if (shardCost() > 0) {
      return `${shardCost()}`;
    }
    return "#UnlockHeroShard";
  };
  const relativeAbilities = libs.createMemo(() => {
    const kv = KeyValues.HeroShardKv[shardAbility()];
    return kv?.relative_ability == undefined ? [] : kv.relative_ability.split("|");
  });
  libs.onMount(() => {
    const NetTableIDList = [];
    NetTableIDList.push(useNetTableKeyHasDefaultValue("player_data", Players.GetLocalPlayer().toString(), data => {
      setHeroName(data?.heroName);
      setGold(data.gold);
      setShardState(data.shardState == 1);
      setShardDiscount(data.shardDiscount);
      setShardPurchasable(data.shardPurchasable == 1);
    }));
    NetTableIDList.push(useNetTableKeyHasDefaultValue("common", "constant", data => {
      setShardCostConfig(data.SHARD_LEVEL_COST);
    }));
    libs.onCleanup(() => {
      NetTableIDList.forEach(v => CustomNetTables.UnsubscribeNetTableListener(v));
    });
  });
  return libs.createComponent(BasePopupMain, {
    className: "PopupMain_ShardUnlock",
    PopupID: PopupID,
    group: group,
    closeOnClickOuter: false,
    closeOnEsc: false,
    get children() {
      return libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "ShardUnlockBG",
        onactivate: () => {},
        get children() {
          return [libs.createComponent(EOM_Button.EOM_BaseButton, {
            id: "ShardUnlockClose",
            onactivate: () => {
              closePopupMain(PopupID);
            },
            get children() {
              return libs.createComponent(EOM_Icon.EOM_Icon, {
                align: "center center",
                style: {
                  uiScale: "80%"
                },
                get src() {
                  return getSrcPath("eom_design/icon/C4/btn_store_close.png");
                }
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "ShardUnlockMain",
            hittest: false,
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "ShardTitle",
                hittest: false,
                hittestchildren: false,
                get children() {
                  return [libs.createElement("Label", {
                    text: "#HeroShard"
                  }, null), libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "ShardDivider"
                  })];
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "ShardDescription",
                hittest: false,
                get children() {
                  return [libs.createComponent(libs.Show, {
                    get when() {
                      return $.Localize("#DOTA_Tooltip_ability_" + shardAbility() + "_description") != "#DOTA_Tooltip_ability_" + shardAbility() + "_description";
                    },
                    get children() {
                      return libs.createComponent(AbilityDescription.AbilityDescription, {
                        className: "AbilityDescription",
                        get abilityName() {
                          return shardAbility();
                        },
                        get customTooltip() {
                          return libs.memo(() => !!hasKeyWord($.Localize("#DOTA_Tooltip_ability_" + shardAbility() + "_description")))() ? {
                            name: "keyword_list",
                            keyword_list: JSON.stringify(getKeyWordList($.Localize("#DOTA_Tooltip_ability_" + shardAbility() + "_description")))
                          } : undefined;
                        }
                      });
                    }
                  }), libs.createComponent(libs.Show, {
                    get when() {
                      return relativeAbilities().length > 0;
                    },
                    get children() {
                      return libs.createComponent(libs.Index, {
                        get each() {
                          return relativeAbilities();
                        },
                        children: (name, i) => libs.createComponent(EOM_Panel.EOM_Panel, {
                          className: "ShardRelativeContainer",
                          hittest: false,
                          get children() {
                            return [libs.createComponent(EOM_Panel.EOM_Panel, {
                              id: "ShardRelativeTitle",
                              hittest: false,
                              get children() {
                                return [libs.createComponent(AbilityImage.AbilityImage, {
                                  get abilityName() {
                                    return name();
                                  },
                                  get playerID() {
                                    return Players.GetLocalPlayer();
                                  }
                                }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                  flowChildren: "down",
                                  marginLeft: "8px",
                                  height: "100%",
                                  get children() {
                                    return [libs.createComponent(GenericPanel.CLabel, {
                                      id: "SectNameHeader",
                                      html: true,
                                      get text() {
                                        return "#DOTA_Tooltip_ability_" + name();
                                      }
                                    }), libs.createComponent(GenericPanel.CLabel, {
                                      className: "ShardRelativeType",
                                      text: "#ShardAbilityUpgrade"
                                    })];
                                  }
                                })];
                              }
                            }), libs.createComponent(ShardAbility.ShardRelativeDescription, {
                              get abilityName() {
                                return shardAbility();
                              },
                              get relativeAbilityName() {
                                return name();
                              }
                            })];
                          }
                        })
                      });
                    }
                  })];
                }
              }), libs.createComponent(EOM_Button.EOM_BaseButton, {
                id: "ShardUnlockButton",
                get classList() {
                  return {
                    Unlocked: shardState(),
                    GoldEnough: gold() >= shardCost()
                  };
                },
                get enabled() {
                  return libs.memo(() => !!(shardPurchasable() && !shardState() && shardCost() > 0))() && gold() >= shardCost();
                },
                onactivate: () => {
                  GameEvents.SendCustomEventToServer("buy_shard", {});
                  closePopupMain(PopupID);
                },
                onmouseover: self => {
                  if (shardCost() > 0) {
                    if (shardState()) {
                      $.DispatchEvent("DOTAShowTextTooltip", self, "#HeroShard_Unlocked");
                    } else {
                      let text = !getGameplayModuleState("rune_task") ? "#ShardCost_Description2" : "#ShardCost_Description";
                      $.DispatchEvent("DOTAShowTextTooltip", self, text);
                    }
                  }
                },
                onmouseout: self => $.DispatchEvent("DOTAHideTextTooltip", self),
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "ShardUnlockButtonBG"
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    align: "center center",
                    flowChildren: "right",
                    get children() {
                      return [libs.createComponent(libs.Show, {
                        get when() {
                          return libs.memo(() => !!!shardState())() && shardCost() > 0;
                        },
                        get children() {
                          return libs.createComponent(EOM_Icon.EOM_Icon, {
                            verticalAlign: "center",
                            width: "20px",
                            height: "20px",
                            get src() {
                              return getSrcPath("icon/icon_gold_bevel_psd.png");
                            }
                          });
                        }
                      }), libs.createComponent(EOM_Label.EOM_Label, {
                        get text() {
                          return shardButtonText();
                        }
                      })];
                    }
                  })];
                }
              })];
            }
          })];
        }
      });
    }
  });
};

$.GetContextPanel().AddClass("CosmeticPreviewLiveHidden");
GameUI.CustomUIConfig()._PopupMainPropsList = {};
const PopupComponents = {
  RuneReward: PopupMain_RuneReward,
  ShardUnlock: PopupMain_ShardUnlock
};
const Popups = () => {
  const [popupData, setPopupData] = libs.createStore({});
  libs.onMount(() => {
    const id = GameEvents.Subscribe("client_side_event", eventData => {
      if ("show_popup_main" == eventData.event_name) {
        let PopupID = eventData.PopupID;
        let popupName = eventData.popupName;
        let data = Object.assign({
          PopupID,
          popupName
        }, GameUI.CustomUIConfig()._PopupMainPropsList[PopupID] ?? {});
        if (data.popupName && PopupComponents[data.popupName]) {
          setPopupData(data.PopupID, data);
        } else {
          console.error("invalid popupMainName: " + data.popupName);
        }
      } else if ("close_popup_main" == eventData.event_name) {
        let data = eventData.event_data;
        if (data.PopupID) {
          setPopupData(data.PopupID, undefined);
          delete GameUI.CustomUIConfig()._PopupMainPropsList[data.PopupID];
        }
        if (data.group) {
          Object.entries(popupData).forEach(([id, v], i) => {
            if (v?.group == data.group) {
              setPopupData(id, undefined);
              delete GameUI.CustomUIConfig()._PopupMainPropsList[id];
            }
          });
        }
      } else if ("switch_popup_main" == eventData.event_name) {
        if (eventData.PopupID) {
          if (popupData[eventData.PopupID]) {
            closePopupMain(eventData.PopupID);
          } else {
            if (eventData.popupName && PopupComponents[eventData.popupName]) {
              setPopupData(eventData.PopupID, Object.assign({
                PopupID: eventData.PopupID,
                popupName: eventData.popupName
              }, GameUI.CustomUIConfig()._PopupMainPropsList[eventData.PopupID] ?? {}));
            } else {
              console.error("invalid popupMainName: " + eventData.popupName);
            }
          }
        }
      }
    });
    libs.onCleanup(() => {
      GameEvents.Unsubscribe(id);
    });
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "PopupsMain",
    hittest: false,
    get className() {
      return libs.classNames({
        ShowPopup: Object.keys(popupData).length > 0
      });
    },
    get children() {
      return libs.createComponent(libs.For, {
        get each() {
          return Object.keys(popupData);
        },
        children: (PopupID, index) => {
          return libs.createComponent(libs.Show, {
            get when() {
              return popupData[PopupID].popupName;
            },
            get children() {
              return PopupComponents[popupData[PopupID].popupName](popupData[PopupID]);
            }
          });
        }
      });
    }
  });
};
libs.render(() => Popups(), $.GetContextPanel());