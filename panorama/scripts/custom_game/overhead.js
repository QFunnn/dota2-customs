--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var CourierTitle = require('./CourierTitle.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Image = require('./EOM_Image.js');
var EOM_Button = require('./EOM_Button.js');
var GenericPanel = require('./GenericPanel.js');
var HeroProficiencyIcon = require('./HeroProficiencyIcon.js');
var ItemImage = require('./ItemImage.js');
var Player = require('./Player.js');
var SectAbility = require('./SectAbility.js');
var netdata_utils = require('./netdata_utils.js');
require('./EOM_Icon.js');
require('./EOM_Label.js');

$.GetContextPanel().AddClass("CosmeticPreviewLiveHidden");
function HasOverhead(iEntIndex) {
  return Entities.IsValidEntity(iEntIndex) && (Entities.IsAlive(iEntIndex) || Entities.HasBuff(iEntIndex, "modifier_hero"));
}
const CommonOverHeadFragments = ({
  iUnitEntIndex
}) => {
  return (() => {
    const _el$ = libs.createElement("Panel", {
        id: "Bar"
      }, null),
      _el$2 = libs.createElement("Panel", {
        id: "HealthProgress"
      }, _el$);
      libs.createElement("Panel", {
        id: "HealthProgress_Loss"
      }, _el$2);
      libs.createElement("Panel", {
        id: "HealthProgress_Left"
      }, _el$2);
    return _el$;
  })();
};
const GreevilOverHeadFragments = ({
  iUnitEntIndex
}) => {
  let ref;
  const PopupsByList = list => {
    if (ref?.IsValid()) {
      list.forEach((aid, i) => {
        const kv = KeyValues.AbilityUpgradesKv[aid];
        if (kv == undefined) {
          return;
        }
        $.Schedule(i * 0.15, () => {
          const panel = $.CreatePanel("Panel", ref, "");
          panel.AddClass("DiceAbilityContainer");
          panel.style.x = `${Round(Math.random() * 60) - 30}px`;
          panel.style.y = `${Round(Math.random() * 40) - 30}px`;
          panel.style.zIndex = ["n", "r", "sr"].indexOf(kv.rarity);
          let dispose = libs.render(() => (() => {
            const _el$5 = libs.createElement("Panel", {
              get ["class"]() {
                return libs.classNames("DiceAbility", kv.rarity);
              }
            }, null);
            libs.insert(_el$5, libs.createComponent(SectAbility.SectAbilityImage, {
              sectAbilityID: aid
            }));
            libs.effect(_$p => libs.setProp(_el$5, "class", libs.classNames("DiceAbility", kv.rarity), _$p));
            return _el$5;
          })(), panel);
          $.Schedule(1.2, () => {
            dispose();
            if (panel?.IsValid()) {
              panel.RemoveAndDeleteChildren();
            }
          });
        });
      });
    }
  };
  libs.onMount(() => {
    const event = GameEvents.Subscribe("dice_trigger_ability", eventData => {
      if (eventData.ent == iUnitEntIndex) {
        let list = JSON.parseSafe(eventData.ability_list);
        if (Array.isArray(list)) {
          PopupsByList(list);
        }
      }
    });
    libs.onCleanup(() => {
      GameEvents.Unsubscribe(event);
    });
  });
  return (() => {
    const _el$6 = libs.createElement("Panel", {
      id: "DiceAbilityList",
      hittest: false,
      hittestchildren: false
    }, null);
    const _ref$ = ref;
    typeof _ref$ === "function" ? libs.use(_ref$, _el$6) : ref = _el$6;
    return _el$6;
  })();
};
const WispOverHeadFragments = ({
  iUnitEntIndex
}) => {
  return (() => {
    const _el$7 = libs.createElement("Panel", {
        id: "Bar"
      }, null),
      _el$8 = libs.createElement("Panel", {
        id: "HealthProgress"
      }, _el$7);
      libs.createElement("Panel", {
        id: "HealthProgress_Loss"
      }, _el$8);
      libs.createElement("Panel", {
        id: "HealthProgress_Left"
      }, _el$8);
    libs.insert(_el$7, libs.createComponent(GenericPanel.CLabel, {
      id: "HealthProgress_Label"
    }), null);
    return _el$7;
  })();
};
const CourierHeadFragments = ({
  iUnitEntIndex
}) => {
  const playerID = Entities.GetPlayerOwnerID(iUnitEntIndex);
  const playerData = CustomNetTables.GetTableValue("player_data", String(playerID));
  const [buffCount, setBuffCount] = libs.createSignal(0);
  libs.onMount(() => {
    const timer = setInterval(() => {
      const buffIndex = Entities.FindBuffByName(iUnitEntIndex, "modifier_courier_title");
      if (buffIndex != -1) {
        setBuffCount(Buffs.GetStackCount(iUnitEntIndex, buffIndex));
      }
    }, 100);
    libs.onCleanup(() => {
      clearInterval(timer);
    });
  });
  return [libs.createElement("Panel", {
    id: "EmojiContainer",
    hittest: false,
    hittestchildren: false
  }, null), (() => {
    const _el$10 = libs.createElement("Panel", {
      id: "PlayerName",
      hittest: false
    }, null);
    libs.insert(_el$10, libs.createComponent(libs.Show, {
      get when() {
        return buffCount() > 0;
      },
      get children() {
        return libs.createComponent(CourierTitle.CourierTitle, {
          get oid() {
            return buffCount();
          }
        });
      }
    }), null);
    libs.insert(_el$10, libs.createComponent(Player.PlayerName, {
      playerID: playerID,
      get steamID() {
        return playerData?.steamID;
      },
      get ban() {
        return isNameBan(playerID);
      }
    }), null);
    return _el$10;
  })()];
};
const HeroBase = ({
  iUnitEntIndex
}) => {
  const [heroEmojiList, setHeroEmojiList] = libs.createSignal([]);
  const [battleWinList, setBattleWinList] = libs.createSignal(0);
  const [onRight, setOnRight] = libs.createSignal(true);
  const Update = () => {
    const currentList = heroEmojiList();
    if (currentList.length == 0) {
      return;
    }
    let newHeroEmoji = [];
    currentList.forEach((data, index) => {
      if (data.duration > 0) {
        data.duration -= Game.GetGameFrameTime();
        newHeroEmoji.push(data);
      }
    });
    if (heroEmojiList().length != 0 || newHeroEmoji.length != 0) {
      setHeroEmojiList(newHeroEmoji);
    }
    if (battleWinList() >= 0) {
      let newBattleWin = battleWinList() - Game.GetGameFrameTime();
      setBattleWinList(newBattleWin);
    }
  };
  const onHeroEmoji = event => {
    allClientSideEvent("hero_emoji_dialog", {
      index: event.emojiID ?? 5510000,
      playerID: Players.GetLocalPlayer(),
      entIndex: event.entIndex
    });
  };
  const getOnRight = () => {
    let cameraTurned = GameUI.GetCameraYaw() != 0;
    let lookPos = GameUI.GetCameraLookAtPosition();
    let pos = Entities.GetAbsOrigin(iUnitEntIndex);
    if (!cameraTurned) {
      if (pos == undefined) {
        return true;
      }
      if (pos[0] >= lookPos[0]) {
        return true;
      } else {
        return false;
      }
    } else {
      if (pos == undefined) {
        return false;
      }
      if (pos[0] >= lookPos[0]) {
        return false;
      } else {
        return true;
      }
    }
  };
  const onOverheadHeroEmoji = event => {
    if (event.entIndex == iUnitEntIndex) {
      const newData = {
        emojiID: event.index ?? -1,
        duration: 3
      };
      setHeroEmojiList([newData]);
      setOnRight(getOnRight());
    }
  };
  const onBattleWin = event => {
    if (event.entIndex == iUnitEntIndex) {
      setBattleWinList(1.5);
    }
  };
  const playerID = () => Entities.GetPlayerOwnerID(iUnitEntIndex);
  const kv = () => KeyValues.UnitsCommonKv[Entities.GetUnitName(iUnitEntIndex) ?? ""];
  const heroID = () => kv()?.Hid;
  const defaultKillOID = 5420000;
  const [battleKillOID, setBattleKillOID] = libs.createSignal(defaultKillOID);
  const ornamentDataEffect = data => {
    if (data && data[OrnamentType.KILL.toString()] != undefined) {
      setBattleKillOID(finiteNumber(Number(Object.keys(data[OrnamentType.KILL.toString()])[0]), defaultKillOID));
    }
  };
  libs.createEffect(libs.on(playerID, _playerID => {
    ornamentDataEffect(getServiceNetTable("player_equipped_ornament", _playerID));
  }));
  const [gameStateData, setGameStateData] = libs.createSignal({
    state: CustomNetTables.GetTableValue("common", "game_state")?.state ?? "GameState_None",
    time_end: CustomNetTables.GetTableValue("common", "game_state")?.time_end ?? 0
  });
  const [showProficiency, setShowProficiency] = libs.createSignal(false);
  let proficiencyShowTimer;
  libs.createEffect(libs.on(gameStateData, _gameStateData => {
    if (Entities.HasBuff(iUnitEntIndex, "modifier_neutral")) {
      setShowProficiency(false);
      return;
    }
    if (_gameStateData.state == "GameState_HeroShow" || _gameStateData.state == "GameState_HeroSelection") {
      if (proficiencyShowTimer != undefined) {
        clearInterval(proficiencyShowTimer);
      }
      proficiencyShowTimer = setInterval(() => {
        if (Entities.HasBuff(iUnitEntIndex, "modifier_hero_show_proficiency")) {
          setShowProficiency(true);
        } else {
          setShowProficiency(false);
        }
      }, 30);
    } else if (_gameStateData.state == "GameState_ConfirmBattle") {
      setShowProficiency(false);
      if (proficiencyShowTimer != undefined) {
        clearInterval(proficiencyShowTimer);
      }
      proficiencyShowTimer = setInterval(() => {
        let gameTime = Game.GetGameTime();
        if (gameTime >= _gameStateData.time_end) {
          setShowProficiency(false);
          clearInterval(proficiencyShowTimer);
          proficiencyShowTimer = undefined;
        } else {
          let dt = _gameStateData.time_end - gameTime;
          if (dt <= 2) {
            setShowProficiency(true);
          }
        }
      }, 30);
    } else {
      if (proficiencyShowTimer != undefined) {
        clearInterval(proficiencyShowTimer);
        proficiencyShowTimer = undefined;
      }
      setShowProficiency(false);
    }
  }));
  libs.onMount(() => {
    const timer = setInterval(Update, Game.GetGameFrameTime());
    const eventIDList = [];
    const netTableIDList = [];
    eventIDList.push(GameEvents.Subscribe("show_hero_emoji", onHeroEmoji));
    eventIDList.push(GameEvents.Subscribe("show_hero_win", onBattleWin));
    eventIDList.push(GameEvents.Subscribe("client_side_event", eventData => {
      if (eventData.event_name == "hero_emoji_dialog") {
        let data = JSON.parse(eventData.event_data);
        onOverheadHeroEmoji(data);
      }
    }));
    netTableIDList.push(useServiceNetTable("player_equipped_ornament", (data, _playerID) => {
      if (playerID() == _playerID) {
        ornamentDataEffect(data);
      }
    }, -1));
    netTableIDList.push(useNetTableKey("common", "game_state", data => {
      setGameStateData({
        state: data?.state ?? "GameState_None",
        time_end: data?.time_end ?? 0
      });
    }));
    libs.onCleanup(() => {
      eventIDList.forEach(id => {
        GameEvents.Unsubscribe(id);
      });
      netTableIDList.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
      clearInterval(timer);
      if (proficiencyShowTimer != undefined) {
        clearInterval(proficiencyShowTimer);
      }
    });
  });
  return [libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "HeroEmoji",
    get className() {
      return libs.classNames({
        right: onRight()
      });
    },
    hittest: false,
    get children() {
      return libs.createComponent(libs.For, {
        get each() {
          return heroEmojiList();
        },
        children: (data, index) => libs.createComponent(EOM_Panel.EOM_Panel, {
          className: "HeroEmojiRow",
          get children() {
            return libs.createComponent(EOM_Image.EOM_Image, {
              className: "HeroEmojiImage",
              get src() {
                return getCosmeticImagePath(data.emojiID.toString());
              }
            });
          }
        })
      });
    }
  }), libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "BattleWin",
    hittest: false,
    get children() {
      return libs.createComponent(libs.Show, {
        get when() {
          return battleWinList() > 0;
        },
        get children() {
          return libs.createComponent(CourierTitle.BattleWin, {
            get oid() {
              return battleKillOID();
            },
            type: "effect"
          });
        }
      });
    }
  }), libs.createComponent(EOM_Panel.EOM_Panel, {
    get className() {
      return libs.classNames("HeroProficiency", {
        ProficiencyShow: showProficiency()
      });
    },
    y: `${ -50}px`,
    hittest: false,
    hittestchildren: false,
    get children() {
      return libs.createComponent(HeroProficiencyIcon.HeroProficiencyIcon, {
        hittest: false,
        size: "small",
        get playerID() {
          return playerID();
        },
        get heroID() {
          return heroID();
        },
        get showParticle() {
          return showProficiency();
        }
      });
    }
  })];
};
const TeamPortalOverHeadFragments = ({
  iUnitEntIndex
}) => {
  let localPlayerID = Entities.GetPlayerOwnerID(iUnitEntIndex);
  const constantConfig = netdata_utils.createNetTable("common", "constant");
  const cdMax = () => constantConfig()?.TEAM_ABILITY_BLESS_CD_ROUNDS ?? 3;
  const [cdNow, setCdNow] = libs.createSignal(0);
  const [portalShow, setPortalShow] = libs.createSignal(false);
  const [teammatePlayerID, setTeammatePlayerID] = libs.createSignal();
  netdata_utils.createNetTableEffect("player_data", String(localPlayerID), data => {
    setTeammatePlayerID(Object.values(data?.teammates ?? {}).find(v => v != localPlayerID));
  });
  const [selfExchangingItem, setSelfExchangingItem] = libs.createSignal();
  const [selfItemSlot, setSelfItemSlot] = libs.createSignal(-1);
  const [teammateExchangingItem, setTeammateExchangingItem] = libs.createSignal();
  const [teammateSlot, setTeammateSlot] = libs.createSignal(-1);
  let teammateListeners = [];
  const getItemList = entIndex => {
    let items = [];
    if (entIndex == undefined || entIndex == -1) {
      return items;
    }
    for (let slot = 0; slot < 6; slot++) {
      const itemIndex = Entities.GetItemInSlot(entIndex, slot);
      if (itemIndex && itemIndex != -1) {
        items[slot] = Abilities.GetAbilityName(itemIndex);
      }
    }
    return items;
  };
  let updateEquipmentName = playerID => {
    if (playerID == localPlayerID) {
      if (selfItemSlot() == -1) {
        setSelfExchangingItem();
        return;
      }
      const itemList = getItemList(CustomNetTables.GetTableValue("player_data", playerID.toString())?.heroEntIndex);
      setSelfExchangingItem(itemList[selfItemSlot()] ?? undefined);
    } else {
      if (teammateSlot() == -1) {
        setTeammateExchangingItem();
        return;
      }
      const itemList = getItemList(CustomNetTables.GetTableValue("player_data", playerID.toString())?.heroEntIndex);
      setTeammateExchangingItem(itemList[teammateSlot()] ?? undefined);
    }
  };
  libs.createEffect(libs.on(teammatePlayerID, v => {
    teammateListeners.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    teammateListeners = [];
    setTeammateExchangingItem(undefined);
    if (v != undefined) {
      teammateListeners.push(useNetTableKeyHasDefaultValue("common", "team_portal_data_" + v.toString(), data => {
        setTeammateSlot(data?.blessEquipmentSlot ?? -1);
      }));
    }
  }));
  netdata_utils.createNetTableEffect("common", "team_portal_data_" + localPlayerID.toString(), data => {
    setCdNow(data?.blessCD ?? 0);
    setSelfItemSlot(data?.blessEquipmentSlot ?? -1);
  });
  const RemainingCD = () => Math.max(0, cdMax() - cdNow());
  libs.onMount(() => {
    let timer = setInterval(() => {
      let teammate = teammatePlayerID();
      if (teammate != undefined) {
        updateEquipmentName(teammate);
      }
      updateEquipmentName(localPlayerID);
    }, 100);
    libs.onCleanup(() => {
      clearInterval(timer);
      teammateListeners.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    });
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "PortalOverHead",
    hittest: false,
    onload: self => {
      self.AddClass("Show");
    },
    onmouseover: () => {
      setPortalShow(true);
    },
    onmouseout: () => setPortalShow(false),
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "PortalOverHeadTitleContainer",
        get hittest() {
          return portalShow();
        },
        get hittestchildren() {
          return portalShow();
        },
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "PortalOverHeadTitle",
            get classList() {
              return {
                PortalShow: portalShow()
              };
            },
            get children() {
              const _el$11 = libs.createElement("Label", {
                text: "#TeamBlessPortal"
              }, null);
              libs.setProp(_el$11, "tooltip_text", "#TeamBlessPortal_description");
              return _el$11;
            }
          });
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "PortalOverHeadMain",
        get children() {
          return [(() => {
            const _el$12 = libs.createElement("Panel", {
              id: "PortalAbilityBless"
            }, null);
            libs.insert(_el$12, libs.createComponent(EOM_Panel.EOM_Panel, {
              id: "PortalCooldownContainer",
              get tooltip_text() {
                return $.Localize("#error_cd") + ` (${RemainingCD()}/${cdMax()})`;
              },
              get children() {
                return libs.createComponent(libs.For, {
                  get each() {
                    return Array.from({
                      length: cdMax()
                    });
                  },
                  children: (_, index) => libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("PortalCooldownBlock", {
                        Active: index() < RemainingCD()
                      });
                    }
                  })
                });
              }
            }));
            return _el$12;
          })(), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "PortalEquipmentExchangeContainer",
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                align: "center center",
                padding: "2px 10px",
                flowChildren: "right",
                get children() {
                  return [libs.createComponent(EOM_Button.EOM_BaseButton, {
                    get className() {
                      return libs.classNames("PortalEquipmentBox", {
                        Active: selfExchangingItem() != undefined
                      });
                    },
                    get enabled() {
                      return selfExchangingItem() != undefined;
                    },
                    onactivate: () => {
                      GameEvents.SendCustomEventToServer("team_bless_action", {
                        type: "equipment",
                        value: "-1"
                      });
                    },
                    get children() {
                      return libs.createComponent(libs.Show, {
                        get when() {
                          return selfExchangingItem() != undefined;
                        },
                        get children() {
                          return libs.createComponent(ItemImage.ItemImage, {
                            className: "Equipment",
                            get itemName() {
                              return selfExchangingItem();
                            }
                          });
                        }
                      });
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "PortalEquipmentExchangeIcon",
                    tooltip_text: "#TeamBlessEquipment"
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("PortalEquipmentBox", {
                        Teammate: teammateExchangingItem() != undefined
                      });
                    },
                    get children() {
                      return libs.createComponent(libs.Show, {
                        get when() {
                          return teammateExchangingItem() != undefined;
                        },
                        get children() {
                          return libs.createComponent(ItemImage.ItemImage, {
                            className: "Equipment",
                            get itemName() {
                              return teammateExchangingItem();
                            }
                          });
                        }
                      });
                    }
                  }), libs.createComponent(libs.Show, {
                    get when() {
                      return teammateExchangingItem() != undefined;
                    },
                    get children() {
                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                        className: "PortalInfoIcon",
                        tooltip_text: "#TeamBlessEquipment_Teammate"
                      });
                    }
                  })];
                }
              });
            }
          })];
        }
      })];
    }
  });
};
const TeamPortalInteractiveFragments = ({
  iUnitEntIndex
}) => {
  const hitboxConfig = [{
    hitbox_mins: [-173.779, -170.392, -4.26001],
    hitbox_maxs: [162.729, 166.123, 29.5399]
  }, {
    hitbox_mins: [-155.379, -31.3591, -9.69534],
    hitbox_maxs: [159.687, 25.6018, 270.954]
  }];
  const calculateHitboxScreenBounds = () => {
    const origin = Entities.GetAbsOrigin(iUnitEntIndex);
    if (!origin) return null;
    let minScreenX = Infinity,
      minScreenY = Infinity;
    let maxScreenX = -Infinity,
      maxScreenY = -Infinity;
    hitboxConfig.forEach(box => {
      const mins = box.hitbox_mins;
      const maxs = box.hitbox_maxs;
      const vertices = [[mins[0], mins[1], mins[2]], [maxs[0], mins[1], mins[2]], [mins[0], maxs[1], mins[2]], [maxs[0], maxs[1], mins[2]], [mins[0], mins[1], maxs[2]], [maxs[0], mins[1], maxs[2]], [mins[0], maxs[1], maxs[2]], [maxs[0], maxs[1], maxs[2]]];
      vertices.forEach(vertex => {
        const worldX = origin[0] + vertex[0];
        const worldY = origin[1] + vertex[1];
        const worldZ = origin[2] + vertex[2];
        const screenX = Game.WorldToScreenX(worldX, worldY, worldZ);
        const screenY = Game.WorldToScreenY(worldX, worldY, worldZ);
        minScreenX = Math.min(minScreenX, screenX);
        minScreenY = Math.min(minScreenY, screenY);
        maxScreenX = Math.max(maxScreenX, screenX);
        maxScreenY = Math.max(maxScreenY, screenY);
      });
    });
    return {
      x: minScreenX,
      y: minScreenY,
      width: maxScreenX - minScreenX,
      height: maxScreenY - minScreenY
    };
  };
  const [hitboxBounds, setHitboxBounds] = libs.createSignal(null);
  libs.onMount(() => {
    const updateTimer = setInterval(() => {
      const bounds = calculateHitboxScreenBounds();
      if (bounds) {
        setHitboxBounds(bounds);
      }
    }, Game.GetGameFrameTime());
    libs.onCleanup(() => {
      clearInterval(updateTimer);
    });
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "PortalHittestBox",
    get style() {
      return {
        width: `${hitboxBounds()?.width ?? 0}px`,
        height: `${hitboxBounds()?.height ?? 0}px`
      };
    },
    get hittest() {
      return libs.memo(() => hitboxBounds()?.y != undefined)() && isFinite(hitboxBounds().y);
    },
    onactivate: self => {
      GameEvents.SendCustomEventToServer("team_portal_interactive", {
        player: Entities.GetPlayerOwnerID(iUnitEntIndex)
      });
    }
  });
};
function singleTeamPortalUpdate(fTime, portalIndex) {
  if (portalIndex == -1 || !Entities.IsValidEntity(portalIndex)) {
    return;
  }
  if (!isSpectator() && Entities.GetPlayerOwnerID(portalIndex) != Players.GetLocalPlayer()) {
    return;
  }
  let vOrigin = Entities.GetAbsOrigin(portalIndex);
  let fScreenX = Game.WorldToScreenX(vOrigin[0], vOrigin[1], vOrigin[2]);
  let fScreenY = Game.WorldToScreenY(vOrigin[0], vOrigin[1], vOrigin[2]);
  if (fScreenX < 0 || fScreenX > Game.GetScreenWidth() || fScreenY < 0 || fScreenY > Game.GetScreenHeight()) return;
  {
    let pPanel = pCommonOverheadContainer.FindChildTraverse(portalIndex.toString());
    if (pPanel == undefined || pPanel == null) {
      pPanel = $.CreatePanel("Panel", pCommonOverheadContainer, portalIndex.toString());
      pPanel.AddClass("TeamPortalBase");
      let dispose = libs.render(() => {
        const Comp = TeamPortalOverHeadFragments;
        return libs.createComponent(Comp, {
          iUnitEntIndex: portalIndex
        });
      }, pPanel);
      SaveData(pPanel, "_SOLIDJS_DISPOSE_", dispose);
    } else {
      pPanel.AddClass("Show");
    }
    let fOffset = 0;
    let center_X = Game.GetScreenWidth() / 2;
    Game.GetScreenHeight() / 2;
    fOffset = fOffset == -1 ? 100 : fOffset;
    let x1 = Game.WorldToScreenX(vOrigin[0], vOrigin[1], vOrigin[2] + fOffset) - pPanel.actuallayoutwidth / 2;
    let offset_X = RemapValClamped((x1 - center_X) * 0.25, -center_X, center_X, -80, 80);
    let fX = (x1 - offset_X) / pPanel.actualuiscale_x;
    let fY = (Game.WorldToScreenY(vOrigin[0], vOrigin[1], vOrigin[2] + fOffset) - pPanel.actuallayoutheight) / pPanel.actualuiscale_y;
    pPanel.SetPositionInPixels(fX, fY + pPanel.actuallayoutheight * 0.75, 0);
    SaveData(pPanel, "fTime", fTime);
  }
  if (!isSpectator()) {
    let pInteractivePanel = pInteractiveOverheadContainer.FindChildTraverse(portalIndex.toString());
    if (pInteractivePanel == undefined || pInteractivePanel == null) {
      pInteractivePanel = $.CreatePanel("Panel", pInteractiveOverheadContainer, portalIndex.toString());
      pInteractivePanel.AddClass("TeamPortalBase");
      let dispose = libs.render(() => {
        const Comp = TeamPortalInteractiveFragments;
        return libs.createComponent(Comp, {
          iUnitEntIndex: portalIndex
        });
      }, pInteractivePanel);
      SaveData(pInteractivePanel, "_SOLIDJS_DISPOSE_", dispose);
    }
    let center_X = Game.GetScreenWidth() / 2;
    let center_Y = Game.GetScreenHeight() / 2;
    let fOffset = 0;
    let x1 = Game.WorldToScreenX(vOrigin[0], vOrigin[1], vOrigin[2] + fOffset) - pInteractivePanel.actuallayoutwidth / 2;
    let offset_X = RemapValClamped(center_X - x1, -center_X, center_X, -80, 80);
    let y1 = Game.WorldToScreenY(vOrigin[0], vOrigin[1], vOrigin[2] + fOffset) - pInteractivePanel.actuallayoutheight / 2;
    let offset_Y = RemapValClamped(center_Y - y1, -center_Y, center_Y, -80, 80);
    let fX = (x1 - offset_X) / pInteractivePanel.actualuiscale_x;
    let fY = (y1 - offset_Y) / pInteractivePanel.actualuiscale_y;
    pInteractivePanel.SetPositionInPixels(fX, fY, 0);
    SaveData(pInteractivePanel, "fTime", fTime);
  }
}
function UpdateTeamPortal(fTime) {
  if (isGroupMode()) {
    const data = CustomNetTables.GetAllTableValues("player_data");
    data.forEach(v => {
      const playerID = Number(v.key);
      const data = CustomNetTables.GetTableValue("common", "team_portal_data_" + playerID);
      if (data?.visible == 1) {
        const ent = data?.portal ?? -1;
        singleTeamPortalUpdate(fTime, ent);
      }
    });
  }
  for (let i = 0; i < pInteractiveOverheadContainer.GetChildCount(); i++) {
    let pPanel = pInteractiveOverheadContainer.GetChild(i);
    if (pPanel != null && LoadData(pPanel, "fTime") != fTime) {
      pPanel.SetParent(pRecycleBin);
    }
  }
}
let pHeroOverHeadContainer = $("#HeroOverHeadContainer");
let pCommonOverheadContainer = $("#CommonOverheadContainer");
let pInteractiveOverheadContainer = $("#InteractiveOverheadContainer");
let pRecycleBin = $("#RecycleBin");
(() => {
  pHeroOverHeadContainer.RemoveAndDeleteChildren();
  pCommonOverheadContainer.RemoveAndDeleteChildren();
  pInteractiveOverheadContainer.RemoveAndDeleteChildren();
  pRecycleBin.RemoveAndDeleteChildren();
  let iLastEntIndex = -1;
  function Update() {
    $.Schedule(Game.GetGameFrameTime(), Update);
    let fTime = Game.Time();
    UpdateTeamPortal(fTime);
    let iCursorEntIndex = GameUI.CustomUIConfig().GetCursorEntity();
    let iLocalPortraitUnit = Players.GetLocalPlayerPortraitUnit();
    let iLocalPlayer = Players.GetLocalPlayer();
    let aSelectedEntities = Players.GetSelectedEntities(iLocalPlayer) ?? [];
    let isHeroShowStage = getGameState() == "GameState_HeroShow" || getGameState() == "GameState_HeroSelection";
    {
      let aHeros = Entities.GetAllHeroEntities();
      aHeros.forEach(iUnitEntIndex => {
        if (!HasOverhead(iUnitEntIndex)) return;
        if (Entities.HasBuff(iUnitEntIndex, "modifier_courier_hide_name")) return;
        let OverheadFragments = CourierHeadFragments;
        let OverheadType = "Hero";
        let vOrigin = Entities.GetAbsOrigin(iUnitEntIndex);
        let fScreenX = Game.WorldToScreenX(vOrigin[0], vOrigin[1], vOrigin[2]);
        let fScreenY = Game.WorldToScreenY(vOrigin[0], vOrigin[1], vOrigin[2]);
        if (fScreenX < 0 || fScreenX > Game.GetScreenWidth() || fScreenY < 0 || fScreenY > Game.GetScreenHeight()) return;
        let pPanel = pHeroOverHeadContainer.FindChildTraverse(iUnitEntIndex.toString());
        if (pPanel == undefined || pPanel == null) {
          pPanel = $.CreatePanel("Panel", pHeroOverHeadContainer, iUnitEntIndex.toString());
          pPanel.hittest = false;
          pPanel.AddClass("Overhead");
          pPanel.AddClass(OverheadType);
          pPanel.AddClass("New");
          let dispose = libs.render(() => {
            const Comp = OverheadFragments;
            return libs.createComponent(Comp, {
              iUnitEntIndex: iUnitEntIndex
            });
          }, pPanel);
          SaveData(pPanel, "_SOLIDJS_DISPOSE_", dispose);
        } else {
          pPanel.RemoveClass("New");
        }
        pPanel.SetHasClass("Simple", isHeroShowStage);
        let sUnitName = Entities.GetUnitName(iUnitEntIndex);
        let tKV = KeyValues.HeroesKv[sUnitName];
        tKV?.HealthBarWidth ?? 86;
        tKV?.HealthBarHeight ?? 12;
        let fOffset = tKV?.HealthBarOffset ?? 255;
        let center_X = Game.GetScreenWidth() / 2;
        Game.GetScreenHeight() / 2;
        fOffset = fOffset == -1 ? 100 : fOffset;
        if (isHeroShowStage) {
          fOffset = fOffset * 0.7;
        }
        let x1 = Game.WorldToScreenX(vOrigin[0], vOrigin[1], vOrigin[2] + fOffset) - pPanel.actuallayoutwidth / 2;
        let offset_X = isHeroShowStage ? 0 : RemapValClamped(x1 - center_X, -center_X, center_X, -80, 80);
        let fX = (x1 - offset_X) / pPanel.actualuiscale_x;
        let fY = (Game.WorldToScreenY(vOrigin[0], vOrigin[1], vOrigin[2] + fOffset) - pPanel.actuallayoutheight) / pPanel.actualuiscale_y;
        pPanel.SetPositionInPixels(fX, fY, 0);
        pPanel.SetHasClass("IsEnemy", Entities.IsEnemy(iUnitEntIndex));
        pPanel.SetHasClass("IsUpper", iUnitEntIndex == iLastEntIndex);
        pPanel.SetHasClass("IsCursor", iUnitEntIndex == iCursorEntIndex);
        pPanel.SetHasClass("IsSelected", aSelectedEntities.length == 1 && aSelectedEntities.indexOf(iUnitEntIndex) != -1 && Entities.IsControllableByPlayer(iUnitEntIndex, Players.GetLocalPlayer()));
        pPanel.SetHasClass("IsPortrait", iUnitEntIndex == iLocalPortraitUnit && Entities.IsControllableByPlayer(iUnitEntIndex, Players.GetLocalPlayer()));
        let pHealthProgress = pPanel.FindChildTraverse("HealthProgress");
        let fHealthPercent = Entities.GetHealth(iUnitEntIndex) / Entities.GetMaxHealth(iUnitEntIndex);
        if (pHealthProgress && Float(LoadData(pPanel, "fLastHealthPercent") ?? 0) != Float(fHealthPercent)) {
          SaveData(pPanel, "fLastHealthPercent", fHealthPercent);
          pHealthProgress.FindChildTraverse("HealthProgress_Left").style.width = finiteNumber(fHealthPercent * 100) + "%";
          pHealthProgress.FindChildTraverse("HealthProgress_Loss").style.width = finiteNumber(fHealthPercent * 100) + "%";
        }
        const pHealthLabel = pPanel.FindChildTraverse("HealthProgress_Label");
        if (pHealthLabel) {
          pHealthLabel.text = Entities.GetHealth(iUnitEntIndex) + " / " + Entities.GetMaxHealth(iUnitEntIndex);
        }
        let pManaProgress = pPanel.FindChildTraverse("ManaProgress");
        let fManaPercent = Entities.GetMana(iUnitEntIndex) / Entities.GetMaxMana(iUnitEntIndex);
        if (pManaProgress && Float(LoadData(pPanel, "fLastManaPercent") ?? 0) != Float(fManaPercent)) {
          SaveData(pPanel, "fLastManaPercent", fManaPercent);
          pManaProgress.FindChildTraverse("ManaProgress_Left").style.width = finiteNumber(fManaPercent * 100) + "%";
          const pManaLabel = pPanel.FindChildTraverse("ManaProgress_Label");
          if (pManaLabel) {
            pManaLabel.text = Entities.GetMana(iUnitEntIndex) + " / " + Entities.GetMaxMana(iUnitEntIndex);
          }
        }
        {
          let iLevel = Entities.GetLevel(iUnitEntIndex);
          pPanel.SetDialogVariableInt("level", iLevel);
        }
        SaveData(pPanel, "fTime", fTime);
      });
      for (let i = 0; i < pHeroOverHeadContainer.GetChildCount(); i++) {
        let pPanel = pHeroOverHeadContainer.GetChild(i);
        if (pPanel != null && LoadData(pPanel, "fTime") != fTime) {
          pPanel.SetParent(pRecycleBin);
        }
      }
    }
    {
      let aCreatures = Entities.GetAllEntitiesByName("npc_dota_creature");
      aCreatures.forEach(iUnitEntIndex => {
        if (!HasOverhead(iUnitEntIndex)) return;
        let OverheadFragments = CommonOverHeadFragments;
        let OverheadType = "Common";
        if (Entities.HasBuff(iUnitEntIndex, "modifier_sect_wisp_status")) {
          OverheadFragments = WispOverHeadFragments;
          OverheadType = "Wisp";
        }
        if (Entities.HasBuff(iUnitEntIndex, "modifier_greevil_1")) {
          OverheadFragments = GreevilOverHeadFragments;
          OverheadType = "Greevil";
        } else if (Entities.HasBuff(iUnitEntIndex, "modifier_hero")) {
          OverheadFragments = HeroBase;
          OverheadType = "HeroBase";
        }
        if (OverheadType == "Common") return;
        let vOrigin = Entities.GetAbsOrigin(iUnitEntIndex);
        let fScreenX = Game.WorldToScreenX(vOrigin[0], vOrigin[1], vOrigin[2]);
        let fScreenY = Game.WorldToScreenY(vOrigin[0], vOrigin[1], vOrigin[2]);
        if (fScreenX < 0 || fScreenX > Game.GetScreenWidth() || fScreenY < 0 || fScreenY > Game.GetScreenHeight()) return;
        let pPanel = pCommonOverheadContainer.FindChildTraverse(iUnitEntIndex.toString());
        if (pPanel == undefined || pPanel == null) {
          pPanel = $.CreatePanel("Panel", pCommonOverheadContainer, iUnitEntIndex.toString());
          pPanel.hittest = false;
          pPanel.AddClass("Overhead");
          pPanel.AddClass(OverheadType);
          pPanel.AddClass("New");
          let dispose = libs.render(() => {
            const Comp = OverheadFragments;
            return libs.createComponent(Comp, {
              iUnitEntIndex: iUnitEntIndex
            });
          }, pPanel);
          SaveData(pPanel, "_SOLIDJS_DISPOSE_", dispose);
        } else {
          pPanel.RemoveClass("New");
        }
        pPanel.SetHasClass("Simple", isHeroShowStage);
        let sUnitName = Entities.GetUnitName(iUnitEntIndex);
        let tKV = KeyValues.UnitsKv[sUnitName];
        let iWidth = tKV?.HealthBarWidth ?? 96;
        let iHeight = tKV?.HealthBarHeight ?? 16;
        let fOffset = tKV?.HealthBarOffset ?? 255;
        if (OverheadType == "HeroShow") ; else if (OverheadType == "Greevil") {
          fOffset = 50;
        }
        fOffset = fOffset == -1 ? 100 : fOffset;
        let fX = (Game.WorldToScreenX(vOrigin[0], vOrigin[1], vOrigin[2] + fOffset) - pPanel.actuallayoutwidth / 2) / pPanel.actualuiscale_x;
        let fY = (Game.WorldToScreenY(vOrigin[0], vOrigin[1], vOrigin[2] + fOffset) - pPanel.actuallayoutheight) / pPanel.actualuiscale_y;
        pPanel.SetPositionInPixels(fX, fY, 0);
        let pBar = pPanel.FindChildTraverse("Bar");
        if (pBar) {
          if (iWidth != -1) {
            pBar.style.width = Float(iWidth) + "px";
          } else {
            pBar.style.width = null;
          }
          if (iHeight != -1) {
            pBar.style.height = Float(iHeight) + "px";
          } else {
            pBar.style.height = null;
          }
        }
        pPanel.SetHasClass("IsEnemy", Entities.IsEnemy(iUnitEntIndex));
        pPanel.SetHasClass("IsUpper", iUnitEntIndex == iLastEntIndex);
        pPanel.SetHasClass("IsCursor", iUnitEntIndex == iCursorEntIndex);
        pPanel.SetHasClass("IsSelected", aSelectedEntities.length == 1 && aSelectedEntities.indexOf(iUnitEntIndex) != -1 && Entities.IsControllableByPlayer(iUnitEntIndex, Players.GetLocalPlayer()));
        pPanel.SetHasClass("IsPortrait", iUnitEntIndex == iLocalPortraitUnit && Entities.IsControllableByPlayer(iUnitEntIndex, Players.GetLocalPlayer()));
        let pHealthProgress = pPanel.FindChildTraverse("HealthProgress");
        let fHealthPercent = Entities.GetHealth(iUnitEntIndex) / Entities.GetMaxHealth(iUnitEntIndex);
        if (pHealthProgress && Float(LoadData(pPanel, "fLastHealthPercent") ?? 0) != Float(fHealthPercent)) {
          SaveData(pPanel, "fLastHealthPercent", fHealthPercent);
          pHealthProgress.FindChildTraverse("HealthProgress_Left").style.width = finiteNumber(fHealthPercent * 100) + "%";
          pHealthProgress.FindChildTraverse("HealthProgress_Loss").style.width = finiteNumber(fHealthPercent * 100) + "%";
        }
        const pHealthLabel = pPanel.FindChildTraverse("HealthProgress_Label");
        if (pHealthLabel) {
          pHealthLabel.text = Entities.GetHealth(iUnitEntIndex) + " / " + Entities.GetMaxHealth(iUnitEntIndex);
        }
        let pManaProgress = pPanel.FindChildTraverse("ManaProgress");
        let fManaPercent = Entities.GetMana(iUnitEntIndex) / Entities.GetMaxMana(iUnitEntIndex);
        if (pManaProgress && Float(LoadData(pPanel, "fLastManaPercent") ?? 0) != Float(fManaPercent)) {
          SaveData(pPanel, "fLastManaPercent", fManaPercent);
          pManaProgress.FindChildTraverse("ManaProgress_Left").style.width = finiteNumber(fManaPercent * 100) + "%";
          const pManaLabel = pPanel.FindChildTraverse("ManaProgress_Label");
          if (pManaLabel) {
            pManaLabel.text = Entities.GetMana(iUnitEntIndex) + " / " + Entities.GetMaxMana(iUnitEntIndex);
          }
        }
        let iBuffIndex = Entities.FindBuffByName(iUnitEntIndex, "modifier_summoned");
        if (iBuffIndex != -1) {
          let fPercent = Buffs.GetRemainingTime(iUnitEntIndex, iBuffIndex) / Buffs.GetDuration(iUnitEntIndex, iBuffIndex);
          let pLifeTime = pPanel.FindChildTraverse("LifeTime");
          if (pLifeTime) {
            let pLifeTime_FG = pPanel.FindChildTraverse("LifeTime_FG");
            if (pLifeTime_FG) {
              pLifeTime_FG.style.clip = `radial( 50.0% 50.0%, 0.0deg, ${fPercent * 360}deg)`;
            }
            if (iHeight != -1) {
              pLifeTime.style.height = Float(iHeight) + 6 + "px";
            } else {
              pLifeTime.style.height = null;
            }
          }
          if (iHeight != -1) {
            pPanel.style.marginLeft = -((Float(iHeight) + 8) / 2) + "px";
          } else {
            pPanel.style.marginLeft = "-8px";
          }
          if (pBar) {
            if (iHeight != -1) {
              pBar.style.marginLeft = Float(iHeight) + 8 + "px";
            } else {
              pBar.style.marginLeft = "16px";
            }
          }
        } else {
          pPanel.style.marginLeft = "0px";
          if (pBar) {
            pBar.style.marginLeft = "0px";
          }
        }
        pPanel.SetHasClass("IsSummoned", iBuffIndex != -1);
        SaveData(pPanel, "fTime", fTime);
      });
      for (let i = 0; i < pCommonOverheadContainer.GetChildCount(); i++) {
        let pPanel = pCommonOverheadContainer.GetChild(i);
        if (pPanel != null && LoadData(pPanel, "fTime") != fTime) {
          pPanel.SetParent(pRecycleBin);
        }
      }
    }
    if (pRecycleBin.GetChildCount() > 0) {
      for (let index = 0; index < pRecycleBin.GetChildCount(); index++) {
        const child = pRecycleBin.GetChild(index);
        if (child?.IsValid()) {
          let _dispose = LoadData(child, "_SOLIDJS_DISPOSE_");
          if (_dispose) {
            _dispose();
          }
        }
      }
      pRecycleBin.RemoveAndDeleteChildren();
    }
    if (iCursorEntIndex != -1) {
      iLastEntIndex = iCursorEntIndex;
    }
  }
  Update();
  GameEvents.Subscribe("client_side_event", eventData => {
    if (eventData.event_name == "emoji_dialog") {
      GameEvents.SendCustomEventToServer("emoji_record", {});
      let data = JSON.parse(eventData.event_data);
      let playerID = data.playerID;
      let heroIndex = Players.GetPlayerHeroEntityIndex(playerID);
      let pPanel = pHeroOverHeadContainer.FindChildTraverse(heroIndex.toString());
      let EmojiContainer = pPanel?.FindChildTraverse("EmojiContainer");
      if (EmojiContainer) {
        let children = EmojiContainer.Children();
        for (const child of children) {
          child.DeleteAsync(0);
        }
        if (data.index == 8 || data.index == 15 || data.index == 16) {
          let emoji = $.CreatePanel("MoviePanel", EmojiContainer, "", {
            class: "eomji_" + data.index,
            repeat: "true",
            autoplay: "onload",
            src: `file://{resources}/videos/${data.index}.webm`
          });
          $.Schedule(3, () => {
            if (emoji.IsValid()) {
              emoji.DeleteAsync(0);
            }
          });
        } else {
          let emoji = $.CreatePanel("Image", EmojiContainer, "", {
            class: "eomji_" + data.index,
            src: getCosmeticImagePath(String(data.index))
          });
          $.Schedule(3, () => {
            if (emoji.IsValid()) {
              emoji.DeleteAsync(0);
            }
          });
        }
      }
    }
  });
})();