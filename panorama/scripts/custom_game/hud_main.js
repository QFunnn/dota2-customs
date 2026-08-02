--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Label = require('./EOM_Label.js');
var EOM_Button = require('./EOM_Button.js');
var GenericPanel = require('./GenericPanel.js');
var profile_info = require('./profile_info.js');
var WinStreak = require('./WinStreak.js');
var HeroPortrait = require('./HeroPortrait.js');
var netdata_utils = require('./netdata_utils.js');
var AbilityImage = require('./AbilityImage.js');
var EOM_Icon = require('./EOM_Icon.js');
var EOM_Image = require('./EOM_Image.js');
var EOM_QRCode = require('./EOM_QRCode.js');
var EOM_XP = require('./EOM_XP.js');
var greevil_icon = require('./greevil_icon.js');
var ShopEffectCard = require('./ShopEffectCard.js');
var InteractiveAbility = require('./InteractiveAbility.js');
var ItemImage = require('./ItemImage.js');
var Player = require('./Player.js');
var SectAbility = require('./SectAbility.js');
var SectIcon = require('./SectIcon.js');
var ShardAbility = require('./ShardAbility.js');
var ShopSpecialCard = require('./ShopSpecialCard.js');
var TalentTree = require('./TalentTree.js');
var TeamSuggestionIcon = require('./TeamSuggestionIcon.js');
var game_utils = require('./game_utils.js');
var rookie_utils = require('./rookie_utils.js');
var EOM_PortraitFullBody = require('./EOM_PortraitFullBody.js');
var CityDescription = require('./CityDescription.js');
var CityImage = require('./CityImage.js');
var CosmeticCard = require('./CosmeticCard.js');
var EOM_Loading = require('./EOM_Loading.js');
var NewRegressionIcon = require('./NewRegressionIcon.js');
var RankTierIcon = require('./RankTierIcon.js');
var RuneRewardCard = require('./RuneRewardCard.js');
require('./Heroes.js');
require('./HeroCard.js');
require('./EOM_Portrait.js');
require('./EOM_Countdown.js');

const ActiveStar = () => {
  const playerActiveBox = netdata_utils.createPlayerNetData("player_active_box", Players.GetLocalPlayer(), {
    active_score: 0,
    box1_count: 1,
    box2_count: 1,
    box3_count: 1,
    update_time: -1,
    settlement_gain_count: 0
  });
  return (() => {
    const _el$ = libs.createElement("Panel", {
      id: "ActiveStar"
    }, null);
    libs.setProp(_el$, "onactivate", () => {});
    libs.setProp(_el$, "tooltip_text", "#ActiveStar_desc");
    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
      paddingBottom: "2px",
      width: "100%",
      get children() {
        return [(() => {
          const _el$2 = libs.createElement("Image", {
            id: "Star1",
            get ["class"]() {
              return libs.classNames({
                Active: playerActiveBox().active_score >= 1
              }, "StarImage");
            }
          }, null);
          libs.effect(_$p => libs.setProp(_el$2, "class", libs.classNames({
            Active: playerActiveBox().active_score >= 1
          }, "StarImage"), _$p));
          return _el$2;
        })(), (() => {
          const _el$3 = libs.createElement("Image", {
            id: "Star2",
            get ["class"]() {
              return libs.classNames({
                Active: playerActiveBox().active_score >= 3
              }, "StarImage");
            }
          }, null);
          libs.effect(_$p => libs.setProp(_el$3, "class", libs.classNames({
            Active: playerActiveBox().active_score >= 3
          }, "StarImage"), _$p));
          return _el$3;
        })(), (() => {
          const _el$4 = libs.createElement("Image", {
            id: "Star3",
            get ["class"]() {
              return libs.classNames({
                Active: playerActiveBox().active_score >= 5
              }, "StarImage");
            }
          }, null);
          libs.effect(_$p => libs.setProp(_el$4, "class", libs.classNames({
            Active: playerActiveBox().active_score >= 5
          }, "StarImage"), _$p));
          return _el$4;
        })(), (() => {
          const _el$5 = libs.createElement("Image", {
            id: "Star4",
            get ["class"]() {
              return libs.classNames({
                Active: playerActiveBox().active_score >= 7
              }, "RefreshIconImage");
            }
          }, null);
          libs.effect(_$p => libs.setProp(_el$5, "class", libs.classNames({
            Active: playerActiveBox().active_score >= 7
          }, "RefreshIconImage"), _$p));
          return _el$5;
        })(), (() => {
          const _el$6 = libs.createElement("Label", {
            id: "StarLabel1",
            "class": "StarLabel",
            get text() {
              return "x" + (playerActiveBox().active_score >= 1 ? 0 : playerActiveBox().box1_count);
            }
          }, null);
          libs.effect(_$p => libs.setProp(_el$6, "text", "x" + (playerActiveBox().active_score >= 1 ? 0 : playerActiveBox().box1_count), _$p));
          return _el$6;
        })(), (() => {
          const _el$7 = libs.createElement("Label", {
            id: "StarLabel2",
            "class": "StarLabel",
            get text() {
              return "x" + (playerActiveBox().active_score >= 3 ? 0 : playerActiveBox().box2_count);
            }
          }, null);
          libs.effect(_$p => libs.setProp(_el$7, "text", "x" + (playerActiveBox().active_score >= 3 ? 0 : playerActiveBox().box2_count), _$p));
          return _el$7;
        })(), (() => {
          const _el$8 = libs.createElement("Label", {
            id: "StarLabel3",
            "class": "StarLabel",
            get text() {
              return "x" + (playerActiveBox().active_score >= 5 ? 0 : playerActiveBox().box3_count);
            }
          }, null);
          libs.effect(_$p => libs.setProp(_el$8, "text", "x" + (playerActiveBox().active_score >= 5 ? 0 : playerActiveBox().box3_count), _$p));
          return _el$8;
        })(), (() => {
          const _el$9 = libs.createElement("Label", {
            id: "StarLabel4",
            "class": "StarLabel",
            get text() {
              return "x" + (playerActiveBox().active_score >= 7 ? 0 : 10);
            }
          }, null);
          libs.effect(_$p => libs.setProp(_el$9, "text", "x" + (playerActiveBox().active_score >= 7 ? 0 : 10), _$p));
          return _el$9;
        })()];
      }
    }), null);
    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
      id: "Progress",
      flowChildren: "right",
      get children() {
        return [(() => {
          const _el$0 = libs.createElement("Image", {
            get ["class"]() {
              return libs.classNames({
                Show: playerActiveBox().active_score >= 1
              }, "Block Start");
            }
          }, null);
          libs.effect(_$p => libs.setProp(_el$0, "class", libs.classNames({
            Show: playerActiveBox().active_score >= 1
          }, "Block Start"), _$p));
          return _el$0;
        })(), (() => {
          const _el$1 = libs.createElement("Image", {
            get ["class"]() {
              return libs.classNames({
                Show: playerActiveBox().active_score >= 2
              }, "Block");
            }
          }, null);
          libs.effect(_$p => libs.setProp(_el$1, "class", libs.classNames({
            Show: playerActiveBox().active_score >= 2
          }, "Block"), _$p));
          return _el$1;
        })(), (() => {
          const _el$10 = libs.createElement("Image", {
            get ["class"]() {
              return libs.classNames({
                Show: playerActiveBox().active_score >= 3
              }, "Block");
            }
          }, null);
          libs.effect(_$p => libs.setProp(_el$10, "class", libs.classNames({
            Show: playerActiveBox().active_score >= 3
          }, "Block"), _$p));
          return _el$10;
        })(), (() => {
          const _el$11 = libs.createElement("Image", {
            get ["class"]() {
              return libs.classNames({
                Show: playerActiveBox().active_score >= 4
              }, "Block");
            }
          }, null);
          libs.effect(_$p => libs.setProp(_el$11, "class", libs.classNames({
            Show: playerActiveBox().active_score >= 4
          }, "Block"), _$p));
          return _el$11;
        })(), (() => {
          const _el$12 = libs.createElement("Image", {
            get ["class"]() {
              return libs.classNames({
                Show: playerActiveBox().active_score >= 5
              }, "Block");
            }
          }, null);
          libs.effect(_$p => libs.setProp(_el$12, "class", libs.classNames({
            Show: playerActiveBox().active_score >= 5
          }, "Block"), _$p));
          return _el$12;
        })(), (() => {
          const _el$13 = libs.createElement("Image", {
            get ["class"]() {
              return libs.classNames({
                Show: playerActiveBox().active_score >= 6
              }, "Block");
            }
          }, null);
          libs.effect(_$p => libs.setProp(_el$13, "class", libs.classNames({
            Show: playerActiveBox().active_score >= 6
          }, "Block"), _$p));
          return _el$13;
        })(), (() => {
          const _el$14 = libs.createElement("Image", {
            get ["class"]() {
              return libs.classNames({
                Show: playerActiveBox().active_score >= 7
              }, "Block End");
            }
          }, null);
          libs.effect(_$p => libs.setProp(_el$14, "class", libs.classNames({
            Show: playerActiveBox().active_score >= 7
          }, "Block End"), _$p));
          return _el$14;
        })()];
      }
    }), null);
    return _el$;
  })();
};

const AbilityUpgradeMechincsCard = props => {
  const [local, others] = libs.splitProps(props, ["name", "onClick", "children", "hideDescription"]);
  const resolved = libs.children(() => local.children);
  const mechincsKV = () => KeyValues.AbilityUpgradesMechenicsKv[local.name];
  const src = () => {
    if (mechincsKV() && mechincsKV()?.textrue) {
      if ($.BImageFileExists(`file://{images}/spellicons/${mechincsKV()?.textrue}.png`)) {
        return `file://{images}/spellicons/${mechincsKV()?.textrue}.png`;
      }
      return `raw://resource/flash3/images/spellicons/${mechincsKV()?.textrue}.png`;
    }
    return `file://{images}/spellicons/empty.png`;
  };
  const title = libs.createMemo(() => {
    if (mechincsKV() && mechincsKV()?.title) {
      return mechincsKV()?.title;
    }
    return "";
  });
  const description = libs.createMemo(() => {
    if (mechincsKV()?.description) {
      return $.Localize("#" + mechincsKV()?.description);
    }
    return "";
  });
  return libs.createComponent(EOM_Button.EOM_BaseButton, libs.mergeProps(() => EOM_Panel.EOMProps(others), {
    get className() {
      return libs.classNames("AbilityUpgradeMechincsCard");
    },
    get customTooltip() {
      return libs.memo(() => !!(!local.hideDescription && hasKeyWord(description())))() ? {
        name: "keyword_list",
        keyword_list: JSON.stringify(getKeyWordList(description()))
      } : undefined;
    },
    onactivate: self => {
      if (local.onClick) {
        local.onClick(self);
      }
    },
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "AbilityUpgradeMechincsCardBG_Light"
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "AbilityUpgradeMechincsCardImage",
        get children() {
          return libs.createComponent(GenericPanel.CImage, {
            id: "AbilityUpgradeMechincsCardImage_Image",
            scaling: "stretch",
            get src() {
              return src();
            }
          });
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return mechincsKV();
        },
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "AbilityUpgradeMechincsCard_Title",
            get children() {
              return libs.createComponent(EOM_Label.EOM_Label, {
                html: true,
                id: "AbilityUpgradeMechincsCard_TitleLabel",
                get text() {
                  return `#${title()}`;
                }
              });
            }
          }), libs.createComponent(libs.Show, {
            get when() {
              return !local.hideDescription;
            },
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "AbilityUpgradeMechincsCard_Description",
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    html: true,
                    id: "ItemDescription",
                    get text() {
                      return getAbilityUpgradeMechanicsDescriptionByID(local.name);
                    }
                  });
                }
              });
            }
          })];
        }
      }), libs.memo(() => resolved())];
    }
  }));
};

const EOM_RadioButton = props => {
  const [local, other] = libs.splitProps(props, ["text"]);
  return (() => {
    const _el$ = libs.createElement("RadioButton", libs.mergeProps(() => EOM_Panel.EOMProps(other, {
      className: "EOM_RadioButton"
    })), null);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(other, {
      className: "EOM_RadioButton"
    })), true);
    libs.insert(_el$, libs.createComponent(GenericPanel.CLabel, {
      get text() {
        return local.text;
      }
    }));
    return _el$;
  })();
};

const InteractiveItemButton = props => {
  let cooldown = undefined;
  const abilityName = libs.createMemo(() => Abilities.GetAbilityName(props.abilityIndex));
  return libs.createComponent(EOM_Button.EOM_BaseButton, {
    get className() {
      return libs.classNames("InteractiveItemButton");
    },
    get enabled() {
      return props.charge > 0;
    },
    onactivate: () => {
      Abilities.ExecuteAbility(props.abilityIndex, Abilities.GetCaster(props.abilityIndex), false);
    },
    get children() {
      return [(() => {
        const _el$ = libs.createElement("Panel", {
            hittest: false
          }, null);
          libs.createElement("Panel", {
            id: "CooldownMaskBG",
            hittest: false
          }, _el$);
        const _ref$ = cooldown;
        typeof _ref$ === "function" ? libs.use(_ref$, _el$) : cooldown = _el$;
        libs.setProp(_el$, "className", "CooldownMask");
        libs.insert(_el$, libs.createComponent(GenericPanel.CLabel, {
          id: "CooldownCountDown",
          hittest: false
        }), null);
        return _el$;
      })(), (() => {
        const _el$3 = libs.createElement("DOTAAbilityImage", {
          get abilityname() {
            return abilityName();
          },
          scaling: "stretch-to-fit-preserve-aspect"
        }, null);
        libs.effect(_$p => libs.setProp(_el$3, "abilityname", abilityName(), _$p));
        return _el$3;
      })(), libs.createComponent(GenericPanel.CLabel, {
        className: "InteractiveItemCount",
        get text() {
          return props.charge;
        },
        hittest: false
      }), libs.createComponent(GenericPanel.CLabel, {
        className: "KeyBindName",
        get text() {
          return Abilities.GetKeybind(props.abilityIndex);
        },
        hittest: false
      })];
    }
  });
};

const [_INTERACT_ABILITY_COOLDOWN, setInteractAbilityCooldown] = libs.createSignal(false);
const [gameStateName, setGameStateName] = libs.createSignal(getGameState());
const [showStore, setShowStore] = libs.createSignal(true);
const [round$1, setRound$1] = libs.createSignal(CustomNetTables.GetTableValue("common", "round_data")?.round_number ?? 1);
const [localPlayerData, setLocalPlayerData] = libs.createSignal(CustomNetTables.GetTableValue("player_data", Players.GetLocalPlayer().toString()));
const [specialSelectionData, setSpecialSelectionData] = libs.createSignal();
const [playerGold, setPlayerGold] = libs.createSignal(getPlayerData(Players.GetLocalPlayer(), "gold") ?? 0);
const [playerHealth, setPlayerHealth] = libs.createSignal(getPlayerData(Players.GetLocalPlayer(), "health") ?? 0);
const [playerGreevilEnergy, setPlayerGreevilEnergy] = libs.createSignal(getPlayerData(Players.GetLocalPlayer(), "greevilEnergy") ?? 0);
const [talentPoint, setTalentPoint] = libs.createSignal(getPlayerData(Players.GetLocalPlayer(), "talentPoint") ?? 0);
const [bPrepareReady, setPrepareReady] = libs.createSignal(getPlayerData(Players.GetLocalPlayer(), "prepareReady"));
const [rookieRecommend, setRookieRecommend] = libs.createSignal();
const [selectionMode, setSelectionMode] = libs.createSignal();
libs.createEffect(libs.on(talentPoint, v => {
  if (v == 0 && selectionMode() == 'talent') {
    setSelectionMode(undefined);
  }
}));
const [talentSelectionNet, setTalentSelection] = libs.createSignal(getPlayerData(Players.GetLocalPlayer(), "talentSelection") ?? {});
const [rarityChance, setRarityChance] = libs.createSignal({
  n: "100",
  r: "0",
  sr: "0"
});
const [roshanReward, setRoshanReward] = libs.createSignal();
const [roshanSelectionInfo, setRoshanSelectionInfo] = libs.createSignal();
const [roshanPlayerOrder, setRoshanPlayerOrder] = libs.createSignal();
const [cardEffect, setCardEffect] = libs.createSignal("");
const [runeRefreshCount, setRuneRefreshCount] = libs.createSignal(0);
const [runeBought, setRuneBought] = libs.createSignal(true);
const [teamCardCanRefresh, SetTeamCardCanRefresh] = libs.createSignal(true);
const [roundRuneList, setRoundRuneList] = libs.createSignal({});
let [openTipShop, setOpenTipShop] = libs.createSignal(false);
let [tipPrepareFinish, setTipPrepareFinish] = libs.createSignal(false);
let [tipPrepareRecord, setTipPrepareRecord] = libs.createSignal(0);
let [tipShopFinish, setTipShopFinish] = libs.createSignal(false);
let hotKeyCacheList = [];
const isHotKeyValid = key => {
  if (hotKeyCacheList.includes(key)) return false;
  hotKeyCacheList.push(key);
  $.Schedule(0.03, () => {
    let index = hotKeyCacheList.indexOf(key);
    if (index != -1) {
      hotKeyCacheList.splice(index, 1);
    }
  });
  return true;
};
const teamPortalData = netdata_utils.createNetTable("common", "team_portal_data_" + Players.GetLocalPlayer());
const blessOn = () => shop_player_id() == Players.GetLocalPlayer() && teamPortalData()?.interactState == 1;
const blessEnable = () => teamPortalData()?.blessCD == 0;
const teamPortalVisible = () => teamPortalData()?.visible == 1;
const [shop_player_id, setShopPlayerID] = libs.createSignal(Players.GetLocalPlayer());
const [ability_upgrade, setAbilityUpgrade] = libs.createSignal(CustomNetTables.GetTableValue("sect_data", "ability_upgrade_" + Players.GetLocalPlayer()) ?? {});
if (!isSpectator() && isGroupMode()) {
  const [allyPlayerIDs, setAllyPlayerIDs] = libs.createSignal([]);
  const [viewingID, setViewingID] = libs.createSignal(Players.GetLocalPlayer());
  netdata_utils.createNetTableEffect("player_data", Players.GetLocalPlayer().toString(), data => {
    setAllyPlayerIDs(Object.values(data.teammates ?? {}));
    setViewingID(data.viewPlayerInfo.player_id);
  });
  libs.createEffect(() => {
    setShopPlayerID(allyPlayerIDs().includes(viewingID()) ? viewingID() : Players.GetLocalPlayer());
  });
} else if (isSpectator()) {
  libs.createEffect(() => {
    setShopPlayerID(GameUI.GetSpectatorViewingInfo().player_id);
  });
}
let shop_listeners = [];
const showTeamSuggestion = () => !isSpectator() && shop_player_id() != Players.GetLocalPlayer();
libs.createEffect(libs.on(shop_player_id, v => {
  libs.batch(() => {
    if (shop_listeners.length > 0) {
      shop_listeners.forEach(v => CustomNetTables.UnsubscribeNetTableListener(v));
      shop_listeners = [];
    }
    shop_listeners.push(useNetTableKeyHasDefaultValue("sect_data", "ability_upgrade_" + v, setAbilityUpgrade));
    setShowStore(true);
    setSpecialSelectionData();
    shop_listeners.push(useNetTableKeyHasDefaultValue("selection", v, data => {
      if (data?.unique_key != undefined) {
        setSpecialSelectionData(data);
        let parentP = $("#SpecialSelectionList");
        if (parentP?.IsValid()) {
          for (let index = 0; index < Object.values(data.list).length; index++) {
            let cardPanel = parentP.FindChildTraverse("Card" + index);
            if (cardPanel?.IsValid()) {
              if (cardPanel.BHasClass("ShopSpecialCard")) {
                cardPanel.TriggerClass("ShopSpecialCard");
              }
              if (cardPanel.BHasClass("AbilityUpgradeMechincsCard")) {
                cardPanel.TriggerClass("AbilityUpgradeMechincsCard");
              }
              if (cardPanel.BHasClass("ShopCard")) {
                cardPanel.TriggerClass("ShopCard");
              }
            }
          }
        }
      } else {
        setShowStore(true);
        setSpecialSelectionData();
      }
    }));
    setCardEffect("");
    setRuneRefreshCount(0);
    setRuneBought(false);
    SetTeamCardCanRefresh(true);
    setRoundRuneList({});
    shop_listeners.push(useNetTableKeyHasDefaultValue("common", "card_effect_" + v, data => {
      if (data.card_effect && data.card_effect != "") {
        setCardEffect(data.card_effect);
      } else {
        setCardEffect("");
      }
      setRuneBought(data.buy_record == 1);
      SetTeamCardCanRefresh(data.no_refresh == 0);
      setRuneRefreshCount(data.refresh_record ?? 0);
      setRoundRuneList(data.round_record);
    }));
  });
}));
libs.onCleanup(() => {
  if (shop_listeners.length > 0) {
    shop_listeners.forEach(v => CustomNetTables.UnsubscribeNetTableListener(v));
    shop_listeners = [];
  }
});
libs.onMount(() => {
  const GameEventListenerIDList = [];
  GameEventListenerIDList.push(useClientSideEvent("openTipShop", data => {
    setOpenTipShop(true);
  }));
  GameEventListenerIDList.push(useNetData("rookie_recommend", data => {
    setRookieRecommend(data);
  }, Players.GetLocalPlayer()));
  const listenerIDList = [];
  if (isSpectator()) {
    listenerIDList.push(CustomNetTables.SubscribeNetTableListener("ability_shop", (_, k, v) => {
      if (k == "player_rarity_chance_" + GameUI.GetSpectatorViewingInfo().player_id) {
        let data = v;
        setRarityChance({
          n: Round(data.n, 2).toString(),
          r: Round(data.r, 2).toString(),
          sr: Round(data.sr, 2).toString()
        });
      }
    }));
  } else {
    GameEventListenerIDList.push(useClientSideEvent("listener_Hotkey", data => {
      if (!playerGameOver()) {
        if (data && typeof data.event == "string") {
          if (data.event == "toggle_talent") {
            if (talentPoint() > 0) {
              setSelectionMode(selectionMode() == 'talent' ? undefined : 'talent');
            }
          } else if (data.event == "team_portal") {
            if (shop_player_id() == Players.GetLocalPlayer() && teamPortalVisible()) {
              GameEvents.SendCustomEventToServer("team_portal_interactive", {
                player: Players.GetLocalPlayer()
              });
            }
          }
        }
      }
    }));
    listenerIDList.push(useNetTableKeyHasDefaultValue("ability_shop", "player_rarity_chance_" + Players.GetLocalPlayer().toString(), data => {
      setRarityChance({
        n: Round(data.n, 2).toString(),
        r: Round(data.r, 2).toString(),
        sr: Round(data.sr, 2).toString()
      });
    }));
  }
  libs.onCleanup(() => {
    listenerIDList.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    GameEventListenerIDList.forEach(id => GameEvents.Unsubscribe(id));
  });
});
const talentSelection = libs.createMemo(() => {
  const result = [];
  const talentData = talentSelectionNet()?.["1"];
  if (!talentData) return result;
  let leftTalent;
  let rightTalent;
  const unsortedTalents = [];
  const _TalentIndexMap = new Map(Object.keys(KeyValues.HeroTalentKv).map((key, index) => [key, index]));
  const getIndex = talentName => {
    return _TalentIndexMap.get(talentName) ?? 0;
  };
  Object.values(talentData).forEach(talentName => {
    const kv = KeyValues.HeroTalentKv[talentName];
    if (kv) {
      switch (kv.UIDirection) {
        case "left":
          leftTalent ||= talentName;
          break;
        case "right":
          rightTalent ||= talentName;
          break;
        default:
          unsortedTalents.push(talentName);
      }
    }
  });
  unsortedTalents.sort((a, b) => getIndex(a) - getIndex(b));
  if (leftTalent) {
    result.push(leftTalent);
  } else if (unsortedTalents.length) {
    result.push(unsortedTalents.shift());
  }
  if (rightTalent) {
    result.push(rightTalent);
  }
  result.push(...unsortedTalents);
  return result;
});
const [playerGameOver, setPlayerGameOver] = libs.createSignal((() => {
  const data = CustomNetTables.GetTableValue("player_data", Players.GetLocalPlayer().toString());
  if (data != undefined && data.rank != undefined) {
    return true;
  }
  return false;
})());
const [showRuneReward, setShowRuneReward] = libs.createSignal(false);
let greevilHatchPopup = false;
const BottomBar = () => {
  libs.createEffect(() => {
    if (isSpectator()) {
      const spectatorInfo = GameUI.GetSpectatorViewingInfo();
      let shopRarityData = CustomNetTables.GetTableValue("ability_shop", "player_rarity_chance_" + spectatorInfo.player_id);
      const playerData = CustomNetTables.GetTableValue("player_data", String(spectatorInfo.player_id));
      libs.batch(() => {
        setLocalPlayerData(playerData);
        if (shopRarityData) {
          setRarityChance({
            n: Round(shopRarityData.n, 2).toString(),
            r: Round(shopRarityData.r, 2).toString(),
            sr: Round(shopRarityData.sr, 2).toString()
          });
        }
      });
    }
  });
  const [showGreevilShop, setShowGreevilShop] = libs.createSignal(false);
  const [traitRound, setTraitRound] = libs.createSignal(-1);
  const [runeRewardPopupState, setRuneRewardPopupState] = libs.createSignal(false);
  libs.createEffect(libs.on(showRuneReward, v => {
    if (v) {
      showPopupMain("RuneReward", {
        PopupID: "RuneReward"
      });
    }
  }));
  const [triggerRecord, setTriggerRecord] = libs.createSignal("");
  const aiHost = () => {
    return localPlayerData()?.ai_host == 1;
  };
  const [hostPrivilege, setHostPrivilege] = libs.createSignal(false);
  const [showHostPrivilegeDetails, setHostPrivilegeDetails] = libs.createSignal(false);
  const [hostPrivilegeState, setHostPrivilegeState] = libs.createSignal(false);
  const [hostPrivilegeOption, setHostPrivilegeOption] = libs.createSignal(0);
  const [hostPrivilegeSectList, setHostPrivilegeSectList] = libs.createSignal([]);
  const onClickHostPrivilegeButton = self => {
    if (isSpectator()) return;
    setHostPrivilegeDetails(!showHostPrivilegeDetails());
  };
  libs.createEffect(libs.on(showHostPrivilegeDetails, v => {
    let active = !v && hostPrivilegeSectList().length > 0;
    GameEvents.SendCustomEventToServer("on_host_privilege", {
      active,
      option: hostPrivilegeOption(),
      sect_list: hostPrivilegeSectList()
    });
  }));
  let recordButton;
  libs.createEffect(libs.on(localPlayerData, data => {
    setPlayerGold(data?.gold ?? 0);
    setPlayerHealth(data?.health ?? 0);
    setTalentPoint(data?.talentPoint ?? 0);
    setTalentSelection(data?.talentSelection ?? {});
    setPrepareReady(data?.prepareReady ?? 0);
    setPlayerGameOver(data?.rank != undefined);
    setHostPrivilegeState(data?.hostPrivilegeState == 1);
    setPlayerGreevilEnergy(data?.greevilEnergy ?? 0);
  }));
  const [banListNet, _setBanListNet] = libs.createSignal(CustomNetTables.GetTableValue("common", "ban_list"));
  const banList = () => Object.values(banListNet() ?? {});
  const pickList = libs.createMemo(() => {
    return Object.keys(KeyValues.SectAbilitiesKv).filter(v => {
      return !banList().includes(v);
    });
  });
  const [greevilData, setGreevilData] = libs.createSignal();
  const showGreevilShopButton = () => greevilData()?.shop_enabled == true;
  libs.onMount(() => {
    const listenerIDList = [];
    listenerIDList.push(useSyncDataKey("common", "greevil_data", data => {
      if (data?.shop_enabled && !greevilData()?.shop_enabled) {
        setShowStore(false);
      }
      setGreevilData(data);
    }, Players.GetLocalPlayer()));
    listenerIDList.push(useNetTableKeyHasDefaultValue("common", "player_privilege", data => {
      setHostPrivilege((data?.[Players.GetLocalPlayer()]?.host_privilege ?? 0) > 0);
    }));
    listenerIDList.push(useSyncDataKey("common", "greevil_data", data => {
      if (!greevilHatchPopup) {
        if (data?.stage == GreevilStage.EGG && data.shop_enabled) {
          greevilHatchPopup = true;
          setSelectionMode('greevil_skill');
        }
      }
      if (data?.stage == GreevilStage.GREEVIL) {
        greevilHatchPopup = false;
      }
    }, Players.GetLocalPlayer()));
    listenerIDList.push(useNetTableKeyHasDefaultValue("common", "roshan_reward_selection", data => {
      setRoshanSelectionInfo(data);
    }));
    listenerIDList.push(useNetTableKeyHasDefaultValue("common", "roshan_player_order", data => {
      setRoshanPlayerOrder(data);
    }));
    listenerIDList.push(useNetTableKeyHasDefaultValue("common", "roshan_reward_list", data => {
      if (Object.keys(data).length > 0) {
        setRoshanReward(data);
      } else {
        setRoshanReward();
      }
    }));
    listenerIDList.push(useNetTableKeyHasDefaultValue("common", "game_state", gameState => {
      if (gameState.state) {
        setGameStateName(gameState.state);
        if (gameState.state == "GameState_GreevilEgg") {
          greevilHatchPopup = false;
        }
      }
    }));
    listenerIDList.push(useNetTableKeyHasDefaultValue("common", "merge_ability_round", data => {
      setTraitRound(data?.round ?? -1);
    }));
    listenerIDList.push(useNetTableKey("common", "round_data", data => {
      setRound$1(data.round_number);
    }));
    if (isSpectator()) {
      listenerIDList.push(CustomNetTables.SubscribeNetTableListener("player_data", (_, k, v) => {
        const playerID = Number(k);
        if (GameUI.GetSpectatorViewingInfo().player_id == playerID) {
          if (playerGold() != v.gold) {
            setPlayerGold(v.gold ?? 0);
          }
          if (playerHealth() != v.health) {
            setPlayerHealth(v.health ?? 0);
          }
          if (talentPoint() != v.talentPoint) {
            setTalentPoint(v.talentPoint ?? 0);
          }
          if (bPrepareReady() != v.prepareReady) {
            setPrepareReady(v.prepareReady);
          }
        }
      }));
    } else {
      listenerIDList.push(useNetTableKeyHasDefaultValue("selection", Players.GetLocalPlayer().toString(), data => {
        if (data?.unique_key != undefined) {
          setSpecialSelectionData(data);
          let parentP = $("#SpecialSelectionList");
          if (parentP?.IsValid()) {
            for (let index = 0; index < Object.values(data.list).length; index++) {
              let cardPanel = parentP.FindChildTraverse("Card" + index);
              if (cardPanel?.IsValid()) {
                if (cardPanel.BHasClass("ShopSpecialCard")) {
                  cardPanel.TriggerClass("ShopSpecialCard");
                }
                if (cardPanel.BHasClass("AbilityUpgradeMechincsCard")) {
                  cardPanel.TriggerClass("AbilityUpgradeMechincsCard");
                }
                if (cardPanel.BHasClass("ShopCard")) {
                  cardPanel.TriggerClass("ShopCard");
                }
              }
            }
          }
        } else {
          setShowStore(true);
          setSpecialSelectionData();
        }
      }));
      listenerIDList.push(useNetTableKey("player_data", Players.GetLocalPlayer().toString(), data => {
        setLocalPlayerData(data);
      }));
      listenerIDList.push(useNetTableKeyHasDefaultValue("common", "rune_reward_" + Players.GetLocalPlayer().toString(), data => {
        setShowRuneReward(Object.keys(data).length > 0);
      }));
    }
    const GameEventListenerIDList = [];
    GameEventListenerIDList.push(useClientSideEvent("toggle_shop", () => {
      setShowStore(v => !v);
      if (showStore()) {
        setShowGreevilShop(false);
      }
    }));
    GameEventListenerIDList.push(useClientSideEvent("toggle_greevil_shop", () => {
      setShowGreevilShop(v => !v);
      setShowStore(false);
    }));
    GameEventListenerIDList.push(useClientSideEvent("popup_main_rune_reward", data => {
      setRuneRewardPopupState(data?.state == 1);
    }));
    GameEventListenerIDList.push(GameEvents.Subscribe("custom_ability_trigger_count", data => {
      if (recordButton?.IsValid()) {
        recordButton?.TriggerClass("Trigger");
      }
      if (data.count != undefined && data?.count > 0) {
        setTriggerRecord(String(data.count));
      } else {
        setTriggerRecord("");
      }
    }));
    libs.onCleanup(() => {
      listenerIDList.forEach(id => {
        CustomNetTables.UnsubscribeNetTableListener(id);
      });
      GameEventListenerIDList.forEach(id => GameEvents.Unsubscribe(id));
    });
  });
  libs.createEffect(libs.on(gameStateName, gameState => {
    if (gameState == "GameState_ConfirmBattle" || gameState == "GameState_ConfirmNeutral") {
      setShowStore(false);
    } else if (gameState == "GameState_Prepare") {
      setShowStore(true);
    } else if (gameState == "GameState_Trait") {
      if (!playerGameOver()) {
        setShowStore(false);
        setSelectionMode('custom_ability');
      }
    } else if (gameState == "GameState_None") {
      setSelectionMode(undefined);
      setOpenTipShop(false);
      setTipShopFinish(false);
      setShowGreevilShop(false);
    }
  }));
  const rookieV2_equipment = rookie_utils.useRookieV2Effect_Override({
    key: "equipment_pick",
    params: {
      tooltip_position: "top"
    }
  }, 0.2);
  const rookieV2_artifact = rookie_utils.useRookieV2Effect_Override({
    key: "artifact_pick",
    params: {
      tooltip_position: "top"
    }
  }, 0.2);
  const rookieV2_talent_button = rookie_utils.useRookieV2Effect_Override({
    key: "talent_pick_button",
    params: {
      tooltip_position: "top"
    }
  }, 0.2);
  const rookieV2_talent = rookie_utils.useRookieV2Effect_Override({
    key: "talent_pick",
    params: {
      tooltip_position: "top"
    }
  }, 0.2);
  const rookieV2_trait_button = rookie_utils.useRookieV2Effect_Override({
    key: "trait_pick_button",
    params: {
      tooltip_position: "top"
    }
  }, 0.2);
  const rookieV2_card_effect_buy = rookie_utils.useRookieV2Effect_Override({
    key: "card_effect_buy",
    params: {
      tooltip_position: "top"
    }
  }, 0.3);
  libs.createEffect(libs.on([showRuneReward, runeRewardPopupState, gameStateName], () => {
    if (showRuneReward() && !runeRewardPopupState() && isCeasefireState(gameStateName())) {
      rookieV2_trait_button.open();
    } else {
      rookieV2_trait_button.close();
    }
  }));
  libs.createEffect(libs.on([talentPoint, gameStateName], () => {
    let gameState = gameStateName();
    if (gameState == "GameState_RuneTask") {
      return;
    }
    if (talentPoint() > 0 && selectionMode() != 'talent') {
      rookieV2_talent_button.open();
    }
  }));
  libs.createEffect(libs.on(selectionMode, v => {
    if (v == 'talent') {
      rookieV2_talent.open();
    } else {
      rookieV2_talent.close();
    }
  }));
  libs.createEffect(() => {
    const id = CustomNetTables.SubscribeNetTableListener("common", function (_, k, v) {
      if (k === "ban_list") {
        _setBanListNet(v);
      }
    });
    libs.onCleanup(() => {
      CustomNetTables.UnsubscribeNetTableListener(id);
    });
  });
  return [libs.createComponent(libs.Show, {
    get when() {
      return roshanReward() != undefined;
    },
    get children() {
      return libs.createComponent(RoshanReward, {});
    }
  }), (() => {
    const _el$ = libs.createElement("Panel", {
      id: "BottomBar",
      hittest: false
    }, null);
    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
      zIndex: -99,
      align: "center bottom",
      flowChildren: "right",
      width: "100%",
      get children() {
        return [libs.createElement("Image", {
          id: "DecorationLeft"
        }, null), libs.createElement("Image", {
          id: "DecorationRight"
        }, null)];
      }
    }), null);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return roshanReward() == undefined;
      },
      get fallback() {
        return [libs.createComponent(EOM_Button.EOM_IconButton, {
          id: "MoneyButton",
          get icon() {
            return libs.createComponent(EOM_Image.EOM_Image, {
              className: "MoneyButtonIcon"
            });
          },
          onactivate: () => {
            clientSideEvent("toggle_shop", {});
            clearRookieTip("shop");
          }
        }), libs.createComponent(EOM_Panel.EOM_Panel, {
          get className() {
            return libs.classNames("AbilityShopChance");
          },
          hittest: false,
          get tooltip() {
            return replaceEnum($.Localize("#AbilityShopChance_Description"));
          },
          get children() {
            return [libs.createComponent(EOM_Panel.EOM_Panel, {
              id: "ChanceLeftBlock"
            }), libs.createComponent(EOM_Panel.EOM_Panel, {
              id: "ChanceCenterBlock",
              get children() {
                return [libs.createComponent(GenericPanel.CLabel, {
                  id: "N",
                  get text() {
                    return `<font color='#ffffff'>N:${rarityChance().n}%</font>`;
                  },
                  html: true
                }), libs.createComponent(GenericPanel.CLabel, {
                  id: "R",
                  get text() {
                    return `<font color='#a67aff'>R:${rarityChance().r}%</font>`;
                  },
                  html: true
                }), libs.createComponent(GenericPanel.CLabel, {
                  id: "SR",
                  get text() {
                    return `<font color='#ffe564'>SR:${rarityChance().sr}%</font>`;
                  },
                  html: true
                })];
              }
            }), libs.createComponent(EOM_Panel.EOM_Panel, {
              id: "ChanceRightBlock"
            })];
          }
        }), libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "GoldLabel",
          get customTooltip() {
            return {
              name: "gold_info",
              playerID: isSpectator() ? GameUI.GetSpectatorViewingInfo().player_id : Players.GetLocalPlayer()
            };
          },
          get children() {
            return [libs.createElement("Image", {
              id: "GoldLabelBG"
            }, null), libs.createComponent(EOM_Panel.EOM_Panel, {
              flowChildren: "right",
              align: "center center",
              get children() {
                return [libs.createElement("Image", {
                  id: "GoldIcon"
                }, null), libs.createComponent(GenericPanel.CLabel, {
                  get text() {
                    return playerGold();
                  }
                })];
              }
            })];
          }
        }), libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "GreevilEnergyLabel",
          get ["class"]() {
            return libs.classNames({
              Closed: !showGreevilShopButton()
            });
          },
          onmouseover: self => {
            if (showGreevilShopButton()) {
              $.DispatchEvent("DOTAShowTextTooltip", self, "#GreevilShopTips");
            }
          },
          onmouseout: self => {
            $.DispatchEvent("DOTAHideTextTooltip", self);
          },
          get children() {
            return [libs.createElement("Image", {
              id: "GreevilEnergyLabelBG"
            }, null), libs.createComponent(EOM_Panel.EOM_Panel, {
              flowChildren: "right",
              align: "center center",
              get children() {
                return [libs.createElement("Image", {
                  id: "GreevilEnergyIcon"
                }, null), libs.createComponent(GenericPanel.CLabel, {
                  get text() {
                    return playerGreevilEnergy();
                  }
                })];
              }
            })];
          }
        })];
      },
      get children() {
        return [libs.createComponent(libs.Show, {
          get when() {
            return !aiHost();
          },
          get children() {
            return libs.memo(() => !!isSpectator())() ? libs.createComponent(Shop, {}) : libs.createComponent(libs.Switch, {
              fallback: () => [libs.createComponent(Shop, {
                rookieV2_card_effect_buy: rookieV2_card_effect_buy,
                get forceHidden() {
                  return showGreevilShop();
                }
              }), libs.createComponent(GreevilShop, {
                get show() {
                  return libs.memo(() => !!showGreevilShopButton())() && showGreevilShop();
                },
                setShow: setShowGreevilShop,
                get hatchReward() {
                  return greevilData()?.hatch_reward == true;
                }
              })],
              get children() {
                return [libs.createComponent(libs.Match, {
                  get when() {
                    return selectionMode() == 'talent';
                  },
                  get children() {
                    return libs.createComponent(TalentSelection, {
                      rookieV2_talent: rookieV2_talent
                    });
                  }
                }), libs.createComponent(libs.Match, {
                  get when() {
                    return libs.memo(() => specialSelectionData() != undefined)() && !playerGameOver();
                  },
                  get children() {
                    return libs.createComponent(SpecialSelection, {
                      rookieV2_equipment: rookieV2_equipment,
                      rookieV2_artifact: rookieV2_artifact
                    });
                  }
                }), libs.createComponent(libs.Match, {
                  get when() {
                    return selectionMode() == 'custom_ability';
                  },
                  get children() {
                    return libs.createComponent(CustomAbilitySelect, {});
                  }
                }), libs.createComponent(libs.Match, {
                  get when() {
                    return selectionMode() == 'greevil_skill';
                  },
                  get children() {
                    return libs.createComponent(GreevilSkillSelectPanel, {
                      onClose: () => setSelectionMode(undefined)
                    });
                  }
                })];
              }
            });
          }
        }), libs.createComponent(libs.Show, {
          get when() {
            return isSpectator() || !playerGameOver() && !aiHost();
          },
          get fallback() {
            return libs.createComponent(EliminatorBottom, {});
          },
          get children() {
            return [libs.createComponent(EOM_Button.EOM_IconButton, {
              id: "MoneyButton",
              get icon() {
                return libs.createComponent(EOM_Image.EOM_Image, {
                  className: "MoneyButtonIcon"
                });
              },
              onactivate: () => {
                clientSideEvent("toggle_shop", {});
                clearRookieTip("shop");
              }
            }), libs.memo(() => (() => {
              const rookieV2_shopChance = rookie_utils.useRookieV2Effect({
                key: "shop_chance",
                params: {
                  click_close: true,
                  tooltip_position: "top"
                }
              });
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("AbilityShopChance");
                },
                hittest: false,
                get tooltip() {
                  return replaceEnum($.Localize("#AbilityShopChance_Description"));
                },
                onload: p => {
                  rookieV2_shopChance.setRef(p);
                },
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "ChanceLeftBlock"
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "ChanceCenterBlock",
                    get children() {
                      return [libs.createComponent(GenericPanel.CLabel, {
                        id: "N",
                        get text() {
                          return `<font color='#ffffff'>N:${rarityChance().n}%</font>`;
                        },
                        html: true
                      }), libs.createComponent(GenericPanel.CLabel, {
                        id: "R",
                        get text() {
                          return `<font color='#a67aff'>R:${rarityChance().r}%</font>`;
                        },
                        html: true
                      }), libs.createComponent(GenericPanel.CLabel, {
                        id: "SR",
                        get text() {
                          return `<font color='#ffe564'>SR:${rarityChance().sr}%</font>`;
                        },
                        html: true
                      })];
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "ChanceRightBlock"
                  })];
                }
              });
            })()), libs.createComponent(libs.Show, {
              get when() {
                return hostPrivilege();
              },
              get children() {
                return libs.createComponent(EOM_Button.EOM_BaseButton, {
                  get className() {
                    return libs.classNames("HostPrivilege", {
                      Active: hostPrivilegeState()
                    });
                  },
                  onactivate: self => onClickHostPrivilegeButton(),
                  tooltip: "#host_privilege_desc"
                });
              }
            }), libs.memo(() => (() => {
              const rookieV2_interest = rookie_utils.useRookieV2Effect({
                key: "gold_interest",
                params: {
                  click_close: true,
                  tooltip_position: "top"
                }
              });
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "GoldLabel",
                get customTooltip() {
                  return {
                    name: "gold_info",
                    playerID: isSpectator() ? GameUI.GetSpectatorViewingInfo().player_id : Players.GetLocalPlayer()
                  };
                },
                onload: p => {
                  rookieV2_interest.setRef(p);
                },
                get children() {
                  return [libs.createElement("Image", {
                    id: "GoldLabelBG"
                  }, null), libs.createComponent(EOM_Panel.EOM_Panel, {
                    flowChildren: "right",
                    align: "center center",
                    get children() {
                      return [libs.createElement("Image", {
                        id: "GoldIcon"
                      }, null), libs.createComponent(GenericPanel.CLabel, {
                        get text() {
                          return playerGold();
                        }
                      })];
                    }
                  })];
                }
              });
            })()), libs.createComponent(EOM_Button.EOM_BaseButton, {
              id: "GreevilEnergyLabel",
              get ["class"]() {
                return libs.classNames({
                  Closed: !showGreevilShopButton()
                });
              },
              onactivate: () => {
                if (!showGreevilShopButton()) return;
                clientSideEvent("toggle_greevil_shop", {});
              },
              onmouseover: self => {
                if (!showGreevilShopButton()) {
                  $.DispatchEvent("DOTAShowTextTooltip", self, "#GreevilShopTips");
                }
              },
              onmouseout: self => {
                $.DispatchEvent("DOTAHideTextTooltip", self);
              },
              get children() {
                return [(() => {
                  const _el$4 = libs.createElement("Image", {
                    id: "GreevilEnergyLabelBG"
                  }, null);
                  libs.effect(_$p => libs.setProp(_el$4, "classList", {
                    enable: showGreevilShop()
                  }, _$p));
                  return _el$4;
                })(), libs.createComponent(EOM_Panel.EOM_Panel, {
                  flowChildren: "right",
                  align: "center center",
                  get children() {
                    return [libs.createElement("Image", {
                      id: "GreevilEnergyIcon"
                    }, null), libs.createComponent(GenericPanel.CLabel, {
                      get text() {
                        return playerGreevilEnergy();
                      }
                    })];
                  }
                })];
              }
            }), libs.createComponent(EOM_Button.EOM_BaseButton, {
              id: "TalentActive",
              get className() {
                return libs.classNames({
                  Show: talentPoint() > 0
                });
              },
              onactivate: () => {
                setSelectionMode(selectionMode() == 'talent' ? undefined : 'talent');
                clearRookieTip("talent");
                clearRookieTip("shop");
                if (rookieV2_talent_button.state()) {
                  rookieV2_talent_button.close();
                }
              },
              onload: self => {
                rookieV2_talent_button.setRef(self);
              },
              get children() {
                return libs.createComponent(GenericPanel.CLabel, {
                  text: "#RecordTab_Talent"
                });
              }
            }), libs.createComponent(EOM_Button.EOM_BaseButton, {
              ref(r$) {
                const _ref$ = recordButton;
                typeof _ref$ === "function" ? _ref$(r$) : recordButton = r$;
              },
              id: "CustomAbility",
              get className() {
                return libs.classNames({
                  Show: traitRound() != -1 && round$1() >= traitRound()
                });
              },
              onactivate: () => setSelectionMode(selectionMode() == 'custom_ability' ? undefined : 'custom_ability'),
              get children() {
                return [libs.createComponent(GenericPanel.CLabel, {
                  id: "Desc",
                  text: "#RecordTab_Trait"
                }), libs.createComponent(GenericPanel.CLabel, {
                  id: "Record",
                  get text() {
                    return triggerRecord();
                  }
                })];
              }
            }), libs.createComponent(EOM_Panel.EOM_Panel, {
              id: "TianYunDanButtonContainer",
              get className() {
                return libs.classNames({
                  Show: showRuneReward()
                });
              },
              get children() {
                return libs.createComponent(EOM_Button.EOM_BaseButton, {
                  id: "TianYunDanButton",
                  onactivate: () => {
                    if (runeRewardPopupState()) {
                      closePopupMain("RuneReward");
                    } else {
                      switchPopupMain("RuneReward", {
                        PopupID: "RuneReward"
                      });
                      if (rookieV2_trait_button.state()) {
                        rookieV2_trait_button.close();
                      }
                    }
                  },
                  tooltip_text: "#RuneReward",
                  onload: self => {
                    rookieV2_trait_button.setRef(self);
                  }
                });
              }
            })];
          }
        })];
      }
    }), null);
    libs.insert(_el$, libs.createComponent(PlayerBanner, {
      direction: "Left"
    }), null);
    libs.insert(_el$, libs.createComponent(PlayerBanner, {
      direction: "Right"
    }), null);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return !aiHost();
      },
      get children() {
        return libs.createComponent(InteractiveItems$1, {});
      }
    }), null);
    libs.effect(_$p => libs.setProp(_el$, "classList", {
      HideBottomInfo: gameStateName() == "GameState_GreevilEgg"
    }, _$p));
    return _el$;
  })(), libs.createComponent(libs.Show, {
    get when() {
      return showHostPrivilegeDetails();
    },
    get children() {
      return libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "HostPrivilegeDetails",
        hittest: true,
        onactivate: () => {},
        get children() {
          return [libs.createComponent(EOM_Button.EOM_BaseButton, {
            id: "closeBtn",
            onactivate: () => {
              setHostPrivilegeDetails(false);
            }
          }), (() => {
            const _el$6 = libs.createElement("Panel", {
              id: "HostPrivilegeDetailsSectListTitle"
            }, null);
            libs.insert(_el$6, libs.createComponent(GenericPanel.CLabel, {
              text: "#HostPrivilegeDetailsSectListTxt"
            }));
            return _el$6;
          })(), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "HostPrivilegeDetailsSectList",
            get children() {
              return [libs.createComponent(libs.Index, {
                get each() {
                  return pickList();
                },
                children: (sect_name, idx) => {
                  const trigger = () => {
                    return hostPrivilegeSectList().includes(sect_name());
                  };
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "HostPrivilegeDetailsSect",
                    hittest: false,
                    get children() {
                      const _el$13 = libs.createElement("ToggleButton", {
                        id: "DetailsToggle",
                        get selected() {
                          return trigger();
                        },
                        get text() {
                          return "#DOTA_Tooltip_ability_" + sect_name();
                        }
                      }, null);
                      libs.setProp(_el$13, "onactivate", () => {
                        const c_sect_list = hostPrivilegeSectList();
                        if (hostPrivilegeSectList().includes(sect_name())) {
                          setHostPrivilegeSectList(c_sect_list.filter((tp, _) => tp !== sect_name()));
                        } else {
                          c_sect_list.push(sect_name());
                          setHostPrivilegeSectList(c_sect_list);
                        }
                      });
                      libs.effect(_p$ => {
                        const _v$ = trigger(),
                          _v$2 = "#DOTA_Tooltip_ability_" + sect_name();
                        _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$13, "selected", _v$, _p$._v$));
                        _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$13, "text", _v$2, _p$._v$2));
                        return _p$;
                      }, {
                        _v$: undefined,
                        _v$2: undefined
                      });
                      return _el$13;
                    }
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "HostPrivilegeDetailsSect",
                hittest: true,
                get children() {
                  const _el$7 = libs.createElement("ToggleButton", {
                    id: "DetailsToggle",
                    get selected() {
                      return hostPrivilegeSectList().includes("SR");
                    },
                    text: "#HostPrivilegeDetailsSR"
                  }, null);
                  libs.setProp(_el$7, "onactivate", () => {
                    const c_sect_list = hostPrivilegeSectList();
                    if (hostPrivilegeSectList().includes("SR")) {
                      setHostPrivilegeSectList(c_sect_list.filter((tp, _) => tp !== "SR"));
                    } else {
                      c_sect_list.push("SR");
                      setHostPrivilegeSectList(c_sect_list);
                    }
                  });
                  libs.effect(_$p => libs.setProp(_el$7, "selected", hostPrivilegeSectList().includes("SR"), _$p));
                  return _el$7;
                }
              })];
            }
          }), (() => {
            const _el$8 = libs.createElement("Panel", {
              id: "HostPrivilegeDetailsOptionListTitle"
            }, null);
            libs.insert(_el$8, libs.createComponent(GenericPanel.CLabel, {
              text: "#HostPrivilegeDetailsOptionTxt"
            }));
            return _el$8;
          })(), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "HostPrivilegeDetailsOptionList",
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "HostPrivilegeDetailsOption",
                get children() {
                  return libs.createComponent(EOM_RadioButton, {
                    id: "DetailsRadio",
                    group: "DetailsRadioOption",
                    text: "#HostPrivilegeDetailsOptionNone",
                    get selected() {
                      return hostPrivilegeOption() == 0;
                    },
                    onselect: () => {
                      setHostPrivilegeOption(0);
                    },
                    ondeselect: () => {}
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "HostPrivilegeDetailsOption",
                get children() {
                  return libs.createComponent(EOM_RadioButton, {
                    id: "DetailsRadio",
                    group: "DetailsRadioOption",
                    text: "#HostPrivilegeDetailsOptionRefresh",
                    get selected() {
                      return hostPrivilegeOption() == 1;
                    },
                    onselect: () => {
                      setHostPrivilegeOption(1);
                    },
                    ondeselect: () => {}
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "HostPrivilegeDetailsOption",
                get children() {
                  return libs.createComponent(EOM_RadioButton, {
                    id: "DetailsRadio",
                    group: "DetailsRadioOption",
                    text: "#HostPrivilegeDetailsOptionRandom",
                    get selected() {
                      return hostPrivilegeOption() == 2;
                    },
                    onselect: () => {
                      setHostPrivilegeOption(2);
                    },
                    ondeselect: () => {}
                  });
                }
              })];
            }
          })];
        }
      });
    }
  })];
};
const SpecialSelection = props => {
  const specialSelectionSuggesting = game_utils.CreateTeammateSuggestActionSignal(TeamSuggestAction.SpecialSelection, 5);
  const specialSelect = (type, name) => {
    if (showTeamSuggestion()) {
      if (type == "equipment" || type == "artifact") {
        SendTeammateSuggestAction(TeamSuggestAction.SpecialSelection, name);
      }
      return;
    }
    if (isSpectator()) return;
    if (name == undefined) {
      return;
    }
    const data = specialSelectionData();
    if (!data) {
      return;
    }
    if (!Object.values(data.list).includes(name)) {
      return;
    }
    GameEvents.SendCustomEventToServer("selection_confirm", {
      result: name,
      unique_key: data.unique_key
    });
    if (type == "equipment") {
      if (rookieRecommend() != undefined) {
        clearRookieTip("equipment");
      }
      if (props.rookieV2_equipment.state()) {
        props.rookieV2_equipment.close();
      }
    } else if (type == "artifact") {
      if (rookieRecommend() != undefined) {
        clearRookieTip("artifact");
      }
      if (props.rookieV2_artifact.state()) {
        props.rookieV2_artifact.close();
      }
    }
  };
  const selectionList = libs.createMemo(() => Object.values(specialSelectionData().list));
  const type = () => specialSelectionData().type;
  const refreshCount = () => specialSelectionData().refresh_count ?? 0;
  const refreshMaxCount = () => specialSelectionData().refresh_count_max ?? 0;
  const hideDescription = () => Boolean(specialSelectionData().hide_description);
  const refreshTooltip = () => {
    return $.Localize("#FreeRefreshCount") + refreshCount();
  };
  const refreshButtonText = () => {
    return refreshCount() + " / " + refreshMaxCount();
  };
  const [rookieIndex, setRookieIndex] = libs.createSignal();
  let rookieRefRefresh = false;
  libs.createEffect(libs.on(selectionList, v => {
    if (rookieRecommend() == undefined) {
      return;
    }
    if (v.length <= 1) return;
    const numberList = v.map(name => Number(name.split("_")[2]));
    if (type() == "equipment") {
      if (rookieRecommend()?.equipments == undefined) return;
      const orderList = numberList.map(name => rookieRecommend()?.equipments.indexOf(name) ?? 0);
      const maxIndex = orderList.indexOf(Math.min(...orderList));
      rookieTip("equipment", "#RookieTip6", {
        index: maxIndex
      });
      setRookieIndex(maxIndex);
      if ((Object.values(CustomNetTables.GetTableValue("common", "constant")?.NEUTRAL_ROUND ?? {})[0] ?? 0) == round$1() - 1) {
        props.rookieV2_equipment.open();
      }
    }
    if (type() == "artifact") {
      if (rookieRecommend()?.artifacts == undefined) return;
      const orderList = numberList.map(name => rookieRecommend().artifacts.indexOf(name) ?? 0);
      const maxIndex = orderList.indexOf(Math.min(...orderList));
      rookieTip("artifact", "#RookieTip7", {
        index: maxIndex
      });
      setRookieIndex(maxIndex);
      if ((Object.values(CustomNetTables.GetTableValue("common", "constant")?.ARTIFACT_ROUND ?? {})[0] ?? 0) == round$1()) {
        props.rookieV2_artifact.open();
      }
    }
  }));
  libs.onMount(() => {
    const GameEventListenerIDList = [];
    const listenerIDList = [];
    GameEventListenerIDList.push(useClientSideEvent("listener_Hotkey", data => {
      if (!playerGameOver()) {
        if (data && typeof data.event == "string") {
          if (!isHotKeyValid(data.event)) return;
          switch (data.event) {
            case "slot_1":
              specialSelect(type(), selectionList()[0]);
              break;
            case "slot_2":
              specialSelect(type(), selectionList()[1]);
              break;
            case "slot_3":
              specialSelect(type(), selectionList()[2]);
              break;
            case "slot_4":
              specialSelect(type(), selectionList()[3]);
              break;
          }
        }
      }
    }));
    libs.onCleanup(() => {
      GameEventListenerIDList.forEach(id => GameEvents.Unsubscribe(id));
      listenerIDList.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    });
  });
  return (() => {
    const _el$14 = libs.createElement("Panel", {
      id: "SpecialSelectionList"
    }, null);
    libs.insert(_el$14, libs.createComponent(libs.Index, {
      get each() {
        return selectionList();
      },
      children: (selectionName, index) => {
        let cardRef;
        let rookie = () => rookieIndex() == index;
        const willShow = () => {
          let name = selectionName();
          let _type = type();
          if (_type == "hero") {
            return KeyValues.UnitsCommonKv[name] != undefined;
          } else if (_type == "ability_card") {
            return KeyValues.AbilityUpgradesKv[name] != undefined;
          } else if (_type == "ability_upgrades_mechenics") {
            return KeyValues.AbilityUpgradesMechenicsKv[name] != undefined;
          }
          return KeyValues.ItemsKv[name] != undefined;
        };
        libs.createEffect(libs.on([selectionList, rookie], () => {
          if (rookieRefRefresh && rookie() && cardRef?.IsValid()) {
            props.rookieV2_equipment.setRef(cardRef);
            props.rookieV2_artifact.setRef(cardRef);
          }
        }));
        return libs.createComponent(libs.Show, {
          get when() {
            return willShow();
          },
          get children() {
            return libs.createComponent(libs.Switch, {
              get fallback() {
                return libs.createComponent(ShopSpecialCard.ShopSpecialCard, {
                  ref(r$) {
                    const _ref$4 = cardRef;
                    typeof _ref$4 === "function" ? _ref$4(r$) : cardRef = r$;
                  },
                  id: `Card${index}`,
                  get type() {
                    return type();
                  },
                  get name() {
                    return selectionName();
                  },
                  callback: specialSelect,
                  get rookie() {
                    return rookie();
                  },
                  onload: self => {
                    if (showTeamSuggestion()) {
                      return;
                    }
                    if (!rookieRefRefresh && rookie()) {
                      props.rookieV2_equipment.setRef(self);
                      props.rookieV2_artifact.setRef(self);
                      rookieRefRefresh = true;
                    }
                  },
                  get children() {
                    return libs.createComponent(TeamSuggestionIcon.TeamSuggestionIcon, {
                      get show() {
                        return specialSelectionSuggesting() == selectionName();
                      }
                    });
                  }
                });
              },
              get children() {
                return [libs.createComponent(libs.Match, {
                  get when() {
                    return type() == "ability_card";
                  },
                  get children() {
                    return libs.createComponent(ShopSpecialCard.ShopAbilityCard, {
                      ref(r$) {
                        const _ref$2 = cardRef;
                        typeof _ref$2 === "function" ? _ref$2(r$) : cardRef = r$;
                      },
                      id: `Card${index}`,
                      get playerGold() {
                        return playerGold();
                      },
                      get name() {
                        return selectionName();
                      },
                      cost: -1,
                      get level() {
                        return ability_upgrade()[selectionName()]?.level ?? 0;
                      },
                      soldOut: false,
                      isLock: false,
                      onClick: self => {
                        specialSelect(type(), selectionName());
                      }
                    });
                  }
                }), libs.createComponent(libs.Match, {
                  get when() {
                    return type() == "ability_upgrades_mechenics";
                  },
                  get children() {
                    return libs.createComponent(AbilityUpgradeMechincsCard, {
                      ref(r$) {
                        const _ref$3 = cardRef;
                        typeof _ref$3 === "function" ? _ref$3(r$) : cardRef = r$;
                      },
                      id: `Card${index}`,
                      get name() {
                        return selectionName();
                      },
                      get hideDescription() {
                        return hideDescription();
                      },
                      onClick: () => {
                        specialSelect(type(), selectionName());
                      }
                    });
                  }
                })];
              }
            });
          }
        });
      }
    }), null);
    libs.insert(_el$14, libs.createComponent(EOM_Button.EOM_BaseButton, {
      get enabled() {
        return refreshCount() > 0;
      },
      className: "ShopAction",
      get opacity() {
        return !showTeamSuggestion() && refreshMaxCount() > 0 ? "1" : "0";
      },
      onactivate: self => {
        if (isSpectator()) return;
        if (showTeamSuggestion()) return;
        rookieRefRefresh = true;
        props.rookieV2_artifact.close();
        props.rookieV2_artifact.setRef();
        props.rookieV2_equipment.close();
        props.rookieV2_equipment.setRef();
        if (specialSelectionData()?.unique_key) {
          GameEvents.SendCustomEventToServer("selection_confirm", {
            result: "refresh",
            unique_key: specialSelectionData().unique_key
          });
        }
      },
      get tooltip() {
        return refreshTooltip();
      },
      get children() {
        return [libs.createElement("Image", {
          id: "RefreshIcon",
          "class": "ActionImage"
        }, null), (() => {
          const _el$16 = libs.createElement("Panel", {
            id: "CostContainer"
          }, null);
          libs.insert(_el$16, libs.createComponent(GenericPanel.CLabel, {
            get text() {
              return refreshButtonText();
            }
          }));
          libs.effect(_$p => libs.setProp(_el$16, "className", libs.classNames({
            Warning: refreshCount() <= 0
          }), _$p));
          return _el$16;
        })()];
      }
    }), null);
    libs.effect(_$p => libs.setProp(_el$14, "className", libs.classNames({
      SelectCount2: selectionList().length == 2
    }), _$p));
    return _el$14;
  })();
};
const GREEVIL_SKILLS = ["greevil_1", "greevil_2", "greevil_3", "greevil_4"];
const GreevilSkillSelectPanel = props => {
  const [selectEnable, setSelectEnable] = libs.createSignal(false);
  let id = $.Schedule(0.5, () => {
    setSelectEnable(true);
    id = undefined;
  });
  const skillOptions = libs.createMemo(() => {
    return GREEVIL_SKILLS.map(name => {
      const values = KeyValues.AbilitiesKv[name]?.AbilityValues ?? {};
      let description = $.Localize(`#DOTA_Tooltip_ability_${name}_description`);
      const keywords = getKeyWordList(description);
      description = replaceInfo(description);
      description = replaceKeyword(description);
      description = replaceAbility(description);
      description = replaceBuffEnum(description);
      description = getKeyValueDescription(values, description, {
        onlyShowNowLevel: false
      });
      description = NormalizeTabText(description);
      return {
        name,
        description,
        keywords
      };
    });
  });
  const onConfirm = skillName => {
    if (!selectEnable()) return;
    GameEvents.SendCustomEventToServer("select_greevil", {
      name: skillName
    });
    props.onClose();
  };
  libs.onCleanup(() => {
    if (id != undefined) {
      $.CancelScheduled(id);
    }
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    className: "GreevilSkillSelect",
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        width: "143px"
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "GreevilSkillSelectList",
        hittest: false,
        get children() {
          return libs.createComponent(libs.For, {
            get each() {
              return skillOptions();
            },
            children: (option, index) => libs.createComponent(EOM_Button.EOM_BaseButton, {
              get className() {
                return libs.classNames("GreevilSkillCard", "Card" + index());
              },
              get enabled() {
                return selectEnable();
              },
              onactivate: () => onConfirm(option.name),
              get children() {
                return [libs.createComponent(EOM_Panel.EOM_Panel, {
                  className: "Greevil3D",
                  hittest: false,
                  get children() {
                    const _el$18 = libs.createElement("DOTAScenePanel", {
                      get map() {
                        return "full_body/" + option.name;
                      },
                      camera: "camera_1",
                      light: "portrait_light",
                      allowrotation: true,
                      renderwaterreflections: true,
                      deferredalpha: true,
                      rendershadows: true,
                      allowsuspendrepaint: true,
                      antialias: true,
                      particleonly: false,
                      hittest: false
                    }, null);
                    libs.effect(_$p => libs.setProp(_el$18, "map", "full_body/" + option.name, _$p));
                    return _el$18;
                  }
                }), libs.createElement("DOTAParticleScenePanel", {
                  id: "GreevilBorderParticle1",
                  particleName: "particles/ui/greevil_bubble.vpcf",
                  lookAt: "0 0 0",
                  cameraOrigin: "0 0 250",
                  fov: 45,
                  squarePixels: true,
                  hittest: false,
                  particleonly: true
                }, null), (() => {
                  const _el$20 = libs.createElement("Panel", {
                      hittest: false
                    }, null),
                    _el$21 = libs.createElement("Panel", {}, _el$20);
                  libs.setProp(_el$20, "className", "GreevilSkillCardMain");
                  libs.setProp(_el$21, "className", "GreevilSkillCardBG");
                  libs.insert(_el$20, libs.createComponent(EOM_Panel.EOM_Panel, {
                    className: "SkillTitle",
                    hittest: false,
                    get children() {
                      return libs.createComponent(EOM_Label.EOM_Label, {
                        html: true,
                        get text() {
                          return "#DOTA_Tooltip_ability_" + option.name;
                        }
                      });
                    }
                  }), null);
                  libs.insert(_el$20, libs.createComponent(EOM_Panel.EOM_Panel, {
                    className: "SkillDescription",
                    get customTooltip() {
                      return libs.memo(() => option.keywords.length > 0)() ? {
                        name: "keyword_list",
                        keyword_list: JSON.stringify(option.keywords)
                      } : undefined;
                    },
                    get children() {
                      return libs.createComponent(EOM_Label.EOM_Label, {
                        html: true,
                        get text() {
                          return option.description;
                        }
                      });
                    }
                  }), null);
                  return _el$20;
                })(), libs.createElement("DOTAParticleScenePanel", {
                  id: "GreevilBorderParticle2",
                  particleName: "particles/ui/greevil_bubble_bg.vpcf",
                  lookAt: "0 0 0",
                  cameraOrigin: "0 0 250",
                  fov: 45,
                  squarePixels: true,
                  hittest: false,
                  particleonly: true
                }, null)];
              }
            })
          });
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "GreevilSkillSelectActions",
        hittest: false,
        get children() {
          return libs.createComponent(EOM_Button.EOM_BaseButton, {
            className: "ShopAction",
            marginTop: "175px",
            onactivate: self => {
              setSelectionMode(undefined);
              props.onClose();
            },
            get children() {
              return [libs.createElement("Image", {
                id: "CollapseIcon",
                "class": "ActionImage"
              }, null), libs.createComponent(GenericPanel.CLabel, {
                className: "CostLabel",
                text: "#CollapseSelection"
              })];
            }
          });
        }
      })];
    }
  });
};
const TalentSelection = props => {
  const selectTalent = index => {
    if (isSpectator()) return;
    if (talentSelection()[index]) {
      GameEvents.SendCustomEventToServer("learn_talent", {
        sTalentName: talentSelection()[index]
      });
      setSelectionMode(undefined);
    }
  };
  const [rookieV2Config, setRookieV2Config] = libs.createSignal();
  const [rookieRecommendIndex, setRookieRecommendIndex] = libs.createSignal(-1);
  libs.createEffect(() => {
    if (isSpectator()) return;
    const config = rookieV2Config();
    if (!config) return;
    const heroName = localPlayerData()?.heroName;
    if (!heroName || !config[heroName]) return;
    const talentList = talentSelection();
    if (!talentList) return;
    let talentLv = 5;
    for (let i = 0; i < talentList.length; i++) {
      const talentName = talentList[i];
      const kv = KeyValues.HeroTalentKv[talentName];
      if (kv && kv.RequiredLevel) {
        talentLv = kv.RequiredLevel;
        break;
      }
    }
    if (config[heroName].talent_tree) {
      let index = Round(talentLv / 5) - 1;
      let _list = Object.values(config[heroName].talent_tree);
      if (index >= 0 && _list[index]) {
        setRookieRecommendIndex(_list[index] - 1);
      }
    }
  });
  libs.onMount(() => {
    const GameEventListenerIDList = [];
    const listenerIDList = [];
    GameEventListenerIDList.push(useClientSideEvent("listener_Hotkey", data => {
      if (!playerGameOver()) {
        if (data && typeof data.event == "string") {
          if (!isHotKeyValid(data.event)) return;
          switch (data.event) {
            case "slot_1":
              selectTalent(0);
              break;
            case "slot_2":
              selectTalent(1);
              break;
            case "slot_3":
              selectTalent(2);
              break;
          }
        }
      }
    }));
    listenerIDList.push(useNetTableKeyHasDefaultValue("common", "constant", data => {
      if (data.ROOKIE_GUIDE_HERO_CONFIG) {
        setRookieV2Config(data.ROOKIE_GUIDE_HERO_CONFIG);
      }
    }));
    libs.onCleanup(() => {
      GameEventListenerIDList.forEach(id => GameEvents.Unsubscribe(id));
    });
  });
  return (() => {
    const _el$23 = libs.createElement("Panel", {
      id: "TalentSelectionList"
    }, null);
    libs.insert(_el$23, libs.createComponent(EOM_Panel.EOM_Panel, {
      width: "148px"
    }), null);
    libs.insert(_el$23, libs.createComponent(libs.Index, {
      get each() {
        return talentSelection();
      },
      children: (talentName, index) => {
        let talentRef;
        const rookie = () => {
          if (rookieRecommendIndex() != -1) {
            return rookieRecommendIndex() == index;
          }
          return (rookieRecommend()?.talents ?? []).indexOf(Number(talentName().split("_")[2])) != -1;
        };
        libs.createEffect(libs.on([talentSelection, rookie], () => {
          if (rookie()) {
            props.rookieV2_talent.setRef(talentRef);
          }
        }));
        return libs.createComponent(TalentCard, {
          ref(r$) {
            const _ref$5 = talentRef;
            typeof _ref$5 === "function" ? _ref$5(r$) : talentRef = r$;
          },
          index: index,
          get name() {
            return talentName();
          },
          get rookie() {
            return rookie();
          },
          onClick: name => {
            if (isSpectator()) return;
            GameEvents.SendCustomEventToServer("learn_talent", {
              sTalentName: name
            });
            setSelectionMode(undefined);
            clearRookieTip("talent");
          }
        });
      }
    }), null);
    libs.insert(_el$23, libs.createComponent(EOM_Button.EOM_BaseButton, {
      className: "ShopAction",
      marginTop: "175px",
      onactivate: self => {
        setSelectionMode(undefined);
        clearRookieTip("talent");
      },
      get children() {
        return [libs.createElement("Image", {
          id: "CollapseIcon",
          "class": "ActionImage"
        }, null), libs.createComponent(GenericPanel.CLabel, {
          className: "CostLabel",
          text: "#CollapseSelection"
        })];
      }
    }), null);
    libs.effect(_$p => libs.setProp(_el$23, "className", libs.classNames({
      SelectCount2: talentSelection().length == 2
    }), _$p));
    return _el$23;
  })();
};
const TalentCard = props => {
  const [local, others] = libs.splitProps(props, ["index", "name", "rookie", "onClick"]);
  const rookie = () => props.rookie ?? false;
  return libs.createComponent(EOM_Button.EOM_BaseButton, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
    className: libs.classNames("ShopCard", "talent", "Card" + props.index)
  }), {
    onload: self => {
      if (rookie()) {
        rookieTip("talent", "#RookieTip5", {
          index: props.index
        });
      }
    },
    onactivate: self => {
      props.onClick(props.name);
    },
    get customTooltip() {
      return libs.memo(() => !!hasKeyWord($.Localize("#DOTA_Tooltip_ability_" + props.name + "_description")))() ? {
        name: "keyword_list",
        keyword_list: JSON.stringify(getKeyWordList($.Localize("#DOTA_Tooltip_ability_" + props.name + "_description")))
      } : undefined;
    },
    get children() {
      return [libs.createComponent(EOM_Image.EOM_Image, {
        id: "ShopCardBG"
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "SpecialDescriptionContainer",
        get children() {
          return libs.createComponent(EOM_Label.EOM_Label, {
            html: true,
            id: "SpecialDescription",
            get text() {
              return getAbilityDescription(props.name, 1, undefined, true);
            }
          });
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return rookie();
        },
        get children() {
          return libs.createComponent(EOM_Image.EOM_Image, {
            id: "Rookie"
          });
        }
      })];
    }
  }));
};
const useShopButtonStore = () => {
  Players.GetLocalPlayer().toString();
  const [gameState, _setGameState] = libs.createSignal(CustomNetTables.GetTableValue("common", "game_state"));
  let playerData = () => localPlayerData();
  const [roundRuneNeedCount, setRoundRuneNeedCount] = libs.createSignal({});
  const roundNeedCount = libs.createMemo(() => {
    let count = 3;
    for (const _round in roundRuneNeedCount()) {
      if (Number(_round) <= round$1()) {
        count = roundRuneNeedCount()[_round];
      }
    }
    return count;
  });
  const runeNeedCount = () => Math.max(roundNeedCount() - runeRefreshCount(), 1);
  const runeRefreshDisable = libs.createMemo(() => roundRuneList()[round$1()] != undefined);
  const refresh = () => {
    if (isSpectator()) return;
    GameEvents.SendCustomEventToServer("ability_shop", {
      refresh: 1
    });
  };
  const random = () => {
    if (isSpectator()) return;
    GameEvents.SendCustomEventToServer("ability_shop", {
      random: 1
    });
  };
  const lock = () => {
    if (isSpectator()) return;
    GameEvents.SendCustomEventToServer("PlayerLockShop", {
      lock: isLocked() ? 0 : 1
    });
  };
  const refreshEnable = () => {
    return (playerData()?.gold ?? 0) >= refreshGoldCost() || hasFreeRefresh();
  };
  const hasFreeRefresh = () => {
    return getFreeRefreshCount() > 0;
  };
  const getFreeRefreshCount = () => {
    return playerData()?.freeRefresh ?? 0;
  };
  const randomEnable = () => {
    return (playerData()?.gold ?? 0) >= (playerData()?.randomGoldCost ?? 0);
  };
  const prepareEnable = () => {
    return gameState()?.state == "GameState_Prepare";
  };
  const prepareReady = self => {
    if (isSpectator()) return;
    if (prepareEnable()) {
      GameEvents.SendCustomEventToServer("prepare_ready", {});
    }
  };
  libs.createEffect(libs.on(cardEffect, v => {
    if (getGameplayModuleState("card_effect")) {
      let count = $("#ShopCardList")?.GetChildCount() ?? 0;
      if (count > 0) {
        for (let i = 0; i < count; i++) {
          const element = $("#ShopCardList").GetChild(i);
          if (element?.IsValid() && element.BHasClass("ShopEffectCard")) {
            element.TriggerClass("ShopEffectCard");
          }
        }
      }
    }
  }));
  const refreshGoldCost = () => playerData()?.refreshGoldCost ?? 0;
  const randomGoldCost = () => playerData()?.randomGoldCost ?? 0;
  const [time, setTime] = libs.createSignal(0);
  libs.onMount(() => {
    const netTableListenIDs = [];
    const timer = setInterval(() => {
      const game_state = gameState();
      if (game_state && game_state.time_end && game_state.time_start && game_state.is_pause == 0) {
        let remaining_time = Math.floor((game_state.time_end ?? 0) - Game.GetGameTime());
        setTime(Math.max(remaining_time, 0));
      }
    }, 1000);
    if (isSpectator()) {
      libs.createEffect(() => {
        const spectatorID = GameUI.GetSpectatorViewingInfo().player_id;
        const abilityShopData = CustomNetTables.GetTableValue("common", "ability_shop_func_" + spectatorID);
        if (abilityShopData) {
          setRandomable(abilityShopData.random == 1);
          setRefreshable(abilityShopData.refresh == 1);
          setLockable(abilityShopData.lock == 1);
        }
      });
      netTableListenIDs.push(CustomNetTables.SubscribeNetTableListener("common", (_, k, v) => {
        const spectatorID = GameUI.GetSpectatorViewingInfo().player_id;
        if (k == "ability_shop_func_" + spectatorID) {
          let data = v;
          setRandomable(data.random == 1);
          setRefreshable(data.refresh == 1);
          setLockable(data.lock == 1);
        }
      }));
    } else {
      netTableListenIDs.push(useNetTableKey("common", "ability_shop_func_" + Players.GetLocalPlayer().toString(), data => {
        setRandomable(data.random == 1);
        setRefreshable(data.refresh == 1);
        setLockable(data.lock == 1);
      }));
    }
    netTableListenIDs.push(useNetTableKeyHasDefaultValue("common", "constant", data => {
      if (data.CARD_EFFECT_REFRESH_COUNT) {
        setRoundRuneNeedCount(data.CARD_EFFECT_REFRESH_COUNT);
      }
    }));
    libs.onCleanup(() => {
      clearInterval(timer);
      netTableListenIDs.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    });
  });
  const [randomable, setRandomable] = libs.createSignal(true);
  const [refreshable, setRefreshable] = libs.createSignal(true);
  const [lockable, setLockable] = libs.createSignal(true);
  const isLocked = () => {
    return (playerData()?.lockAbilityShop ?? 0) == 1;
  };
  libs.createEffect(() => {
    const id = CustomNetTables.SubscribeNetTableListener("common", function (_, k, v) {
      if (k === "game_state") {
        _setGameState(v);
      }
    });
    libs.onCleanup(() => {
      CustomNetTables.UnsubscribeNetTableListener(id);
    });
  });
  return {
    refresh,
    random,
    lock,
    refreshEnable,
    randomEnable,
    prepareEnable,
    hasFreeRefresh,
    getFreeRefreshCount,
    time,
    refreshGoldCost,
    randomGoldCost,
    isLocked,
    prepareReady,
    randomable,
    refreshable,
    lockable,
    runeNeedCount,
    roundNeedCount,
    runeRefreshDisable
  };
};
const useShopDataStore = () => {
  const [cardStoreList, setCardStoreList] = libs.createSignal([]);
  const setCardStore = (index, data, willRefresh) => {
    const store = cardStoreList()[index];
    if (data.name != "") {
      if (!store) {
        const levelNetData = ability_upgrade();
        setCardStoreList(v => {
          const cardStore = libs.createStore(Object.assign({
            cardlevel: levelNetData?.[data.name]?.level ?? 0
          }, data));
          v[index] = cardStore;
          return v.concat([]);
        });
      } else {
        store[1]("gold", data.gold);
        store[1]("health", data.health);
        store[1]("soldOut", data.soldOut);
        store[1]("type", data.type);
        store[1]("name", data.name);
        store[1]("fu", data.fu == true);
        if (willRefresh) {
          const levelNetData = ability_upgrade();
          store[1]("cardlevel", levelNetData?.[data.name]?.level ?? 0);
        }
      }
    } else {
      if (store) {
        setCardStoreList(v => {
          v[index] = null;
          return v.concat([]);
        });
      }
    }
  };
  const [cardNum, setCardNum] = libs.createSignal(0);
  const [shopRefresh, setShopRefresh] = libs.createSignal(false);
  libs.createEffect(libs.on(shopRefresh, refresh => {
    if (!showStore()) {
      setShowStore(true);
    }
    for (let index = 0; index < cardNum(); index++) {
      let containerPanel = $("#ShopCardList")?.FindChild("ShopLayoutCardContainer" + index);
      if (containerPanel?.IsValid()) {
        let cardPanel = containerPanel?.FindChild("Card" + index);
        if (cardPanel?.IsValid()) {
          if (cardPanel.BHasClass("ShopCard")) {
            cardPanel.TriggerClass("ShopCard");
          }
        }
      }
    }
  }));
  const [freeState, setFreeState] = libs.createSignal(false);
  const parseShopCardList = netData => {
    const currentRefreshState = netData.refresh == 1;
    const willRefresh = currentRefreshState != shopRefresh();
    const data = netData.ability_list;
    const keys = Object.keys(data);
    let currentCardNum = keys.length;
    let initedIndexList = [];
    keys.sort((a, b) => data[a].index - data[b].index).forEach((sectName, i) => {
      let cardIndex = data[sectName].index;
      initedIndexList.push(cardIndex);
      setCardStore(cardIndex, {
        name: sectName,
        soldOut: data[sectName].soldOut == 1,
        type: data[sectName].type,
        gold: typeof data[sectName].gold == "number" ? data[sectName].gold : undefined,
        health: typeof data[sectName].health == "number" ? data[sectName].health : undefined,
        fu: data[sectName].fu == 1
      }, willRefresh);
    });
    if (willRefresh || currentCardNum != cardNum()) {
      cardStoreList().forEach((_, index) => {
        if (!initedIndexList.includes(Number(index))) {
          setCardStore(Number(index), {
            name: "",
            type: "shop",
            soldOut: false
          }, false);
        }
      });
    }
    setFreeState(netData.free == 1);
    if (getGameplayModuleState("card_effect")) {
      currentCardNum++;
    }
    setCardNum(currentCardNum);
    setShopRefresh(currentRefreshState);
  };
  let shopListener;
  libs.onMount(() => {
    libs.createEffect(libs.on(shop_player_id, v => {
      if (shopListener != undefined) {
        CustomNetTables.UnsubscribeNetTableListener(shopListener);
        shopListener = undefined;
      }
      shopListener = useNetTableKeyHasDefaultValue("ability_shop", "ability_shop_" + v, data => {
        libs.batch(() => {
          parseShopCardList(data);
        });
      });
    }));
    libs.onCleanup(() => {
      if (shopListener != undefined) {
        CustomNetTables.UnsubscribeNetTableListener(shopListener);
      }
    });
  });
  return {
    cardStoreList,
    shopRefresh,
    cardNum,
    freeState,
    ability_upgrade
  };
};
const Shop = props => {
  const {
    refresh,
    random,
    lock,
    prepareReady,
    refreshEnable,
    randomEnable,
    prepareEnable,
    hasFreeRefresh,
    getFreeRefreshCount,
    refreshGoldCost,
    randomGoldCost,
    isLocked,
    randomable,
    lockable,
    runeNeedCount,
    roundNeedCount} = useShopButtonStore();
  const {
    cardStoreList,
    shopRefresh,
    cardNum,
    freeState
  } = useShopDataStore();
  const shopCardSuggesting = game_utils.CreateTeammateSuggestActionSignal(TeamSuggestAction.ShopCard, 5);
  const cardEffectSuggesting = game_utils.CreateTeammateSuggestActionSignal(TeamSuggestAction.CardEffect, 5);
  const isRookie = abilityName => {
    const sect1 = rookieRecommend()?.sects?.[0];
    const sect2 = rookieRecommend()?.sects?.[1];
    const kv = KeyValues.AbilityUpgradesKv[abilityName];
    if (kv && sect1 != undefined && sect2 != undefined) {
      return kv.sect.indexOf(sect1) != -1 || kv.sect.indexOf(sect2) != -1;
    }
    return false;
  };
  const prepareRookieTimer = panel => {
    if (panel.IsValid() && !tipPrepareFinish()) {
      $.Schedule(1, () => {
        prepareRookieTimer(panel);
        if (round$1() >= 2 && gameStateName() == "GameState_Prepare" && selectionMode() != 'talent') {
          setTipPrepareRecord(tipPrepareRecord() + 1);
          if (tipPrepareRecord() >= 1) {
            rookieTip("prepare", "#RookieTip12", {
              layout4: cardStoreList()?.[4] != undefined ? "Layout4" : ""
            });
            setTipPrepareFinish(true);
          }
        }
      });
    }
  };
  libs.createEffect(libs.on([shopRefresh, openTipShop], v => {
    if (!tipShopFinish() && openTipShop()) {
      const sect1 = rookieRecommend()?.sects[0];
      const sect2 = rookieRecommend()?.sects[1];
      if (sect1 != undefined && sect2 != undefined) {
        const shopCardNameList = Object.values(cardStoreList()).filter(v => (v?.[0].name ?? "") != "").map(v => v[0].name);
        let cardList = shopCardNameList.filter(v => v && (KeyValues.AbilityUpgradesKv[v].sect.indexOf(sect1) != -1 || KeyValues.AbilityUpgradesKv[v].sect.indexOf(sect2) != -1));
        if (cardList.length > 0) {
          const randomCard = cardList[Math.floor(Math.random() * cardList.length)];
          rookieTip("shop", "#RookieTip8", {
            index: shopCardNameList.indexOf(randomCard),
            length: shopCardNameList.length
          });
          setTipShopFinish(true);
        }
      }
    } else {
      clearRookieTip("shop");
    }
  }));
  const [hasRuneTask, setHasRuneTask] = libs.createSignal(false);
  const OnClickShopCard = (abilityName, isCardEffect) => {
    if (showTeamSuggestion()) {
      if (abilityName != "") {
        if (isCardEffect) {
          SendTeammateSuggestAction(TeamSuggestAction.CardEffect, cardEffect());
        } else {
          SendTeammateSuggestAction(TeamSuggestAction.ShopCard, abilityName);
        }
      }
      return false;
    } else {
      if (shop_player_id() != Players.GetLocalPlayer()) return;
    }
    if (abilityName == "") {
      return false;
    }
    if (!isCardEffect && isGroupMode() && blessOn()) {
      if (blessEnable()) {
        GameEvents.SendCustomEventToServer("team_bless_action", {
          type: "ability",
          value: abilityName
        });
      } else {
        ErrorMessage("TeamBlessAbilityDisable");
      }
    } else {
      if (abilityName != "") {
        if (isCardEffect) {
          GameEvents.SendCustomEventToServer("buy_card_effect", {
            cardName: cardEffect()
          });
        } else {
          GameEvents.SendCustomEventToServer("ability_shop", {
            abilityName: abilityName
          });
        }
      }
    }
    return true;
  };
  libs.onMount(() => {
    const GameEventListenerIDs = [];
    const netTableIDList = [];
    if (!isSpectator()) {
      netTableIDList.push(useNetTableKeyHasDefaultValue("common", "rune_task_selection", data => {
        let v = Object.values(data[Players.GetLocalPlayer().toString()] ?? {});
        if (v.length > 0) {
          setHasRuneTask(true);
        } else {
          setHasRuneTask(false);
        }
      }));
    }
    GameEventListenerIDs.push(useClientSideEvent("listener_Hotkey", data => {
      if (showTeamSuggestion()) return;
      if (isSpectator()) return;
      if (showStore() && !playerGameOver()) {
        if (data && typeof data.event == "string") {
          if (!isHotKeyValid(data.event)) return;
          switch (data.event) {
            case "refresh_ability_shop":
              refresh();
              break;
            case "random_ability_shop":
              random();
              break;
            case "lock_ability_shop":
              lock();
              break;
            case "prepare_ready":
              prepareReady();
              break;
            case "slot_1":
              OnClickShopCard(cardStoreList()?.[1]?.[0].name ?? "");
              break;
            case "slot_2":
              OnClickShopCard(cardStoreList()?.[2]?.[0].name ?? "");
              break;
            case "slot_3":
              OnClickShopCard(cardStoreList()?.[3]?.[0].name ?? "");
              break;
            case "slot_4":
              if (getGameplayModuleState("card_effect") && cardStoreList()?.[4]?.[0].name == undefined) {
                if (cardEffect() != "") {
                  OnClickShopCard(cardEffect(), true);
                }
              } else {
                OnClickShopCard(cardStoreList()?.[4]?.[0].name ?? "");
              }
              break;
          }
        }
      }
    }));
    libs.onCleanup(() => {
      for (const id of GameEventListenerIDs) {
        GameEvents.Unsubscribe(id);
      }
      netTableIDList.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    });
  });
  const shopShow = () => !props.forceHidden && gameStateName() != "GameState_GreevilEgg" && !hasRuneTask() && showStore() && (!playerGameOver() || isSpectator());
  const rookieV2_stage6 = rookie_utils.useRookieV2Effect({
    key: "ability_card_buy",
    params: {
      tooltip_position: "top"
    }
  }, 0.3);
  const rookieV2_sect = rookie_utils.useRookieV2Effect({
    key: "ability_card_sect",
    params: {
      click_close: true
    }
  });
  const rookieV2_rarity = rookie_utils.useRookieV2Effect({
    key: "ability_card_rarity",
    params: {
      click_close: true
    }
  });
  const rookieV2_effect = rookie_utils.useRookieV2Effect({
    key: "ability_card_effect",
    params: {
      click_close: true
    }
  });
  const rookieV2_cost = rookie_utils.useRookieV2Effect({
    key: "ability_card_cost",
    params: {
      click_close: true
    }
  });
  const rookieV2_card_effect_1 = rookie_utils.useRookieV2Effect({
    key: "card_effect_1",
    params: {
      tooltip_position: "top",
      click_close: true
    }
  }, 0.3);
  libs.createEffect(libs.on(cardEffect, v => {
    if (props.rookieV2_card_effect_buy) {
      if (v == "") {
        props.rookieV2_card_effect_buy.close();
      } else {
        props.rookieV2_card_effect_buy.open();
      }
    }
  }));
  let rookiev2AbilityIndex = -1;
  libs.createMemo(libs.on(cardStoreList, v => {
    if (v && v.length > 0) {
      if (rookieV2_stage6.state() && !v.some((store, index) => store && store[0] && store[0].type == "rookie")) {
        closeRookieV2Tip("ability_card_buy");
      }
      if (rookiev2AbilityIndex == -1) {
        rookiev2AbilityIndex = v.findIndex((store, index) => store && store[0] && store[0].type == "rookie");
      }
    } else {
      if (rookieV2_stage6.state()) {
        closeRookieV2Tip("ability_card_buy");
      }
    }
    if (rookieV2_sect.state()) {
      closeRookieV2Tip("ability_card_sect");
    }
    if (rookieV2_rarity.state()) {
      closeRookieV2Tip("ability_card_rarity");
    }
    if (rookieV2_effect.state()) {
      closeRookieV2Tip("ability_card_effect");
    }
    if (rookieV2_cost.state()) {
      closeRookieV2Tip("ability_card_cost");
    }
  }));
  const rookieV2_refresh = rookie_utils.useRookieV2Effect({
    key: "shop_refresh",
    params: {
      tooltip_position: "top"
    }
  }, 0.5, true);
  const rookieV2_random = rookie_utils.useRookieV2Effect({
    key: "shop_random",
    params: {
      tooltip_position: "top"
    }
  }, 0.3, true);
  const rookieV2_lock = rookie_utils.useRookieV2Effect({
    key: "shop_lock",
    params: {
      tooltip_position: "top",
      click_close: true
    }
  }, 0.3, true);
  const rookieV2_ready = rookie_utils.useRookieV2Effect({
    key: "shop_ready",
    params: {
      tooltip_position: "top"
    }
  }, 0.3, true);
  libs.createEffect(libs.on([shopShow, showRuneReward], () => {
    if (!(shopShow() || showRuneReward())) {
      rookieV2_stage6.hideTips();
      rookieV2_sect.hideTips();
      rookieV2_rarity.hideTips();
      rookieV2_effect.hideTips();
      rookieV2_cost.hideTips();
      rookieV2_refresh.hideTips();
      rookieV2_random.hideTips();
      rookieV2_lock.hideTips();
      rookieV2_ready.hideTips();
      rookieV2_card_effect_1.hideTips();
      props.rookieV2_card_effect_buy?.close();
    } else {
      rookieV2_refresh.resumeTips(0.3);
      rookieV2_random.resumeTips(0.3);
      rookieV2_lock.resumeTips(0.3);
      rookieV2_ready.resumeTips(0.3);
      rookieV2_card_effect_1.resumeTips(0.3);
      if (props.rookieV2_card_effect_buy && cardEffect() != "") {
        props.rookieV2_card_effect_buy.open();
      }
    }
  }));
  libs.createEffect(libs.on(round$1, v => {
    if (v == 2) {
      rookieV2_refresh.customToggleOn(true);
      rookieV2_random.customToggleOn(true);
      rookieV2_lock.customToggleOn(true);
      rookieV2_ready.customToggleOn(true);
      closeRookieV2Tip("ability_card_cost");
      closeRookieV2Tip("card_effect_1");
    } else if (v == 3) {
      closeRookieV2Tip("shop_refresh");
      closeRookieV2Tip("shop_random");
      closeRookieV2Tip("shop_lock");
      closeRookieV2Tip("shop_ready");
      closeRookieV2Tip("gold_interest");
      closeRookieV2Tip("shop_chance");
    }
  }));
  return (() => {
    const _el$25 = libs.createElement("Panel", {
        id: "AbilityShopList"
      }, null);
      libs.createElement("Panel", {
        id: "AbilityShopBlank"
      }, _el$25);
    libs.insert(_el$25, libs.createComponent(EOM_Panel.EOM_Panel, {
      id: "ShopCardList",
      flowChildren: "right",
      get className() {
        return "CardLength" + cardNum();
      },
      get children() {
        return [libs.createComponent(libs.Index, {
          get each() {
            return cardStoreList().filter(v => v != undefined);
          },
          children: (cardStore, i) => {
            const cardGetter = () => cardStore()?.[0];
            let ref;
            let ref_sect;
            let ref_effect;
            let ref_cost;
            const checkRookieV2Card = data => {
              if (shopShow()) {
                if (data && data?.type == "rookie") {
                  rookieV2_stage6.setRef(ref);
                  rookieV2_stage6.resumeTips(0.3);
                }
                if (rookiev2AbilityIndex == i) {
                  rookieV2_rarity.setRef(ref);
                  rookieV2_sect.setRef(ref_sect);
                  rookieV2_effect.setRef(ref_effect);
                  rookieV2_cost.setRef(ref_cost);
                  rookieV2_rarity.resumeTips(0.3);
                  rookieV2_sect.resumeTips(0.3);
                  rookieV2_effect.resumeTips(0.3);
                  rookieV2_cost.resumeTips(0.3);
                }
              }
            };
            libs.createEffect(libs.on([cardGetter, shopShow], () => {
              checkRookieV2Card(cardGetter());
            }));
            const costHealth = () => cardGetter()?.health != undefined;
            const CardCost = libs.createMemo(() => {
              if (freeState()) {
                return 0;
              }
              if (costHealth()) {
                return cardGetter().health;
              }
              return cardGetter().gold;
            });
            const playerValues = () => {
              if (costHealth()) {
                return playerHealth();
              }
              return playerGold();
            };
            return libs.createComponent(EOM_Panel.EOM_Panel, {
              id: `ShopLayoutCardContainer${i}`,
              get children() {
                return [libs.createComponent(ShopSpecialCard.ShopAbilityCard, {
                  className: "ShopLayoutCard",
                  ref(r$) {
                    const _ref$6 = ref;
                    typeof _ref$6 === "function" ? _ref$6(r$) : ref = r$;
                  },
                  id: `Card${i}`,
                  sect_rookie: self => {
                    ref_sect = self;
                    if (shopShow() && rookiev2AbilityIndex == i) {
                      rookieV2_sect.setRef(ref_sect);
                    }
                  },
                  effect_rookie: self => {
                    ref_effect = self;
                    if (shopShow() && rookiev2AbilityIndex == i) {
                      rookieV2_effect.setRef(ref_effect);
                    }
                  },
                  get team_bless() {
                    return blessOn();
                  },
                  get bless_enable() {
                    return blessEnable();
                  },
                  cost_rookie: self => {
                    ref_cost = self;
                    if (shopShow() && rookiev2AbilityIndex == i) {
                      rookieV2_cost.setRef(ref_cost);
                    }
                  },
                  get fu() {
                    return cardGetter().fu;
                  },
                  get playerGold() {
                    return playerValues();
                  },
                  get name() {
                    return cardGetter().name;
                  },
                  get costHealth() {
                    return costHealth();
                  },
                  get cost() {
                    return CardCost() ?? 0;
                  },
                  get level() {
                    return cardGetter().cardlevel;
                  },
                  get soldOut() {
                    return cardGetter().soldOut;
                  },
                  get isLock() {
                    return isLocked();
                  },
                  get rookie() {
                    return isRookie(cardGetter().name);
                  },
                  onClick: self => {
                    if (isSpectator()) return;
                    OnClickShopCard(cardGetter().name);
                    setTipPrepareRecord(0);
                    if (shopShow() && cardGetter() && cardGetter().type == "rookie" && rookieV2_stage6.state()) {
                      closeRookieV2Tip("ability_card_buy");
                    }
                  },
                  onload: self => {
                    if (showTeamSuggestion()) {
                      return;
                    }
                    if (shopShow() && cardGetter() && cardGetter().type == "rookie") {
                      rookieV2_stage6.setRef(self);
                    }
                    if (shopShow() && rookiev2AbilityIndex == i) {
                      rookieV2_rarity.setRef(self);
                    }
                  }
                }), libs.createComponent(TeamSuggestionIcon.TeamSuggestionIcon, {
                  tooltipPosition: "top",
                  get show() {
                    return libs.memo(() => !!shopShow())() && shopCardSuggesting() == cardGetter().name;
                  }
                })];
              }
            });
          }
        }), libs.createComponent(libs.Show, {
          get when() {
            return getGameplayModuleState("card_effect");
          },
          get children() {
            return libs.createComponent(EOM_Panel.EOM_Panel, {
              get id() {
                return `ShopLayoutCardContainer${cardStoreList().length + 1}`;
              },
              get children() {
                return [libs.createComponent(ShopEffectCard.ShopEffectCard, {
                  className: "ShopLayoutCard",
                  get id() {
                    return `Card${cardStoreList().length + 1}`;
                  },
                  get team_card() {
                    return isGroupMode();
                  },
                  get playerGold() {
                    return playerGold();
                  },
                  get soldOut() {
                    return runeBought();
                  },
                  get isLock() {
                    return isLocked();
                  },
                  get name() {
                    return cardEffect();
                  },
                  callback: () => {
                    if (isSpectator()) return;
                    OnClickShopCard(cardEffect(), true);
                    if (shopShow() && rookieV2_card_effect_1.state()) {
                      closeRookieV2Tip("card_effect_1");
                    }
                    if (props.rookieV2_card_effect_buy && props.rookieV2_card_effect_buy.state()) {
                      props.rookieV2_card_effect_buy.complete();
                    }
                  },
                  onload: self => {
                    rookieV2_card_effect_1.setRef(self);
                    if (props.rookieV2_card_effect_buy) {
                      props.rookieV2_card_effect_buy.setRef(self);
                    }
                  }
                }), libs.createComponent(TeamSuggestionIcon.TeamSuggestionIcon, {
                  tooltipPosition: "top",
                  get show() {
                    return libs.memo(() => !!shopShow())() && cardEffectSuggesting() == cardEffect();
                  }
                })];
              }
            });
          }
        })];
      }
    }), null);
    libs.insert(_el$25, libs.createComponent(EOM_Panel.EOM_Panel, {
      id: "ShopActionList",
      get children() {
        return (() => {
          const showActionButton = () => shop_player_id() == Players.GetLocalPlayer() || isSpectator();
          return [libs.createComponent(libs.Show, {
            get when() {
              return getGameplayModuleState("card_effect");
            },
            get fallback() {
              return libs.createComponent(EOM_Button.EOM_BaseButton, {
                id: "ActionRefreshNoCardEffect",
                get enabled() {
                  return randomable();
                },
                className: "ShopAction",
                get opacity() {
                  return showActionButton() ? "1" : "0";
                },
                onactivate: self => {
                  if (refreshEnable()) {
                    self.FindChildTraverse("RefreshIcon")?.TriggerClass("SpinnerRotate");
                    refresh();
                  }
                  if (rookieV2_refresh.state()) {
                    closeRookieV2Tip("shop_refresh");
                  }
                },
                get tooltip() {
                  return libs.memo(() => !!hasFreeRefresh())() ? $.Localize("#FreeRefreshCount") + getFreeRefreshCount() : "#Refresh";
                },
                onload: p => {
                  rookieV2_refresh.setRef(p);
                },
                get children() {
                  return [libs.createElement("Image", {
                    id: "RefreshIcon",
                    "class": "ActionImage"
                  }, null), (() => {
                    const _el$36 = libs.createElement("Panel", {
                        id: "CostContainer"
                      }, null);
                      libs.createElement("Image", {
                        id: "GoldIcon"
                      }, _el$36);
                    libs.insert(_el$36, libs.createComponent(GenericPanel.CLabel, {
                      get text() {
                        return libs.memo(() => !!hasFreeRefresh())() ? "#Free" : refreshGoldCost();
                      }
                    }), null);
                    libs.effect(_$p => libs.setProp(_el$36, "className", libs.classNames({
                      Warning: !refreshEnable() || playerGold() < refreshGoldCost() && !hasFreeRefresh()
                    }), _$p));
                    return _el$36;
                  })()];
                }
              });
            },
            get children() {
              return libs.createComponent(EOM_Button.EOM_BaseButton, {
                id: "ActionRefresh",
                get enabled() {
                  return randomable();
                },
                className: "ShopAction",
                get opacity() {
                  return showActionButton() ? "1" : "0";
                },
                onactivate: self => {
                  if (refreshEnable()) {
                    self.FindChildTraverse("RefreshIcon")?.TriggerClass("SpinnerRotate");
                    refresh();
                  }
                  if (rookieV2_refresh.state()) {
                    closeRookieV2Tip("shop_refresh");
                  }
                },
                onload: p => {
                  rookieV2_refresh.setRef(p);
                },
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "ActionRefreshButtonBG",
                    hittest: false
                  }), libs.createElement("Image", {
                    id: "RefreshIcon",
                    "class": "ActionImage",
                    hittest: false
                  }, null), (() => {
                    const _el$28 = libs.createElement("Panel", {
                        id: "CostContainer",
                        hittest: false
                      }, null);
                      libs.createElement("Image", {
                        id: "GoldIcon"
                      }, _el$28);
                    libs.insert(_el$28, libs.createComponent(GenericPanel.CLabel, {
                      get text() {
                        return libs.memo(() => !!hasFreeRefresh())() ? "#Free" : refreshGoldCost();
                      }
                    }), null);
                    libs.effect(_$p => libs.setProp(_el$28, "className", libs.classNames({
                      Warning: !refreshEnable() || playerGold() < refreshGoldCost() && !hasFreeRefresh()
                    }), _$p));
                    return _el$28;
                  })(), libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "RefreshTooltipBlock",
                    get tooltip() {
                      return libs.memo(() => !!hasFreeRefresh())() ? $.Localize("#FreeRefreshCount") + getFreeRefreshCount() : "#Refresh";
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("CardEffectRefreshBlock", {
                        runeBought: !teamCardCanRefresh()
                      });
                    },
                    get tooltip() {
                      return libs.memo(() => !!teamCardCanRefresh())() ? (isGroupMode() ? $.Localize("#TeamCardRefreshCount") : $.Localize("#RuneRefreshCount")) + runeNeedCount() : isGroupMode() ? "#TeamCardBought" : "#RuneBought";
                    },
                    get children() {
                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "CardEffectRefreshBlockIn",
                        get children() {
                          return [libs.createComponent(EOM_Image.EOM_Image, {
                            id: "CardEffectRefreshIcon"
                          }), libs.createComponent(EOM_Label.EOM_Label, {
                            id: "CardEffectRefreshLabel",
                            html: true,
                            get text() {
                              return `${runeNeedCount()}<font color='#b1bdc3'>/</font><font color='#f7ea88'>${roundNeedCount()}</font>`;
                            }
                          })];
                        }
                      });
                    }
                  })];
                }
              });
            }
          }), libs.createComponent(EOM_Button.EOM_BaseButton, {
            id: "ActionRandom",
            get enabled() {
              return randomable();
            },
            className: "ShopAction",
            get opacity() {
              return showActionButton() ? "1" : "0";
            },
            onactivate: self => {
              if (randomEnable()) {
                self.FindChildTraverse("RandomIcon")?.TriggerClass("SpinnerRotate");
                random();
              }
              if (rookieV2_random.state()) {
                closeRookieV2Tip("shop_random");
              }
            },
            tooltip: "#Tooltip_AbilityShop_Random",
            onload: p => {
              rookieV2_random.setRef(p);
            },
            get children() {
              return [libs.createElement("Image", {
                id: "RandomIcon",
                "class": "ActionImage"
              }, null), (() => {
                const _el$31 = libs.createElement("Panel", {
                    id: "CostContainer"
                  }, null);
                  libs.createElement("Image", {
                    id: "GoldIcon"
                  }, _el$31);
                libs.insert(_el$31, libs.createComponent(GenericPanel.CLabel, {
                  get text() {
                    return randomGoldCost();
                  }
                }), null);
                libs.effect(_$p => libs.setProp(_el$31, "className", libs.classNames({
                  Warning: !randomEnable() || playerGold() < refreshGoldCost()
                }), _$p));
                return _el$31;
              })()];
            }
          }), libs.createComponent(EOM_Button.EOM_BaseButton, {
            id: "ActionLock",
            get enabled() {
              return lockable();
            },
            get className() {
              return libs.classNames("ShopAction LockAction", {
                Lock: isLocked()
              });
            },
            tooltip: "#LockTooltip",
            get opacity() {
              return showActionButton() ? "1" : "0";
            },
            onactivate: self => {
              lock();
              if (rookieV2_lock.state()) {
                closeRookieV2Tip("shop_lock");
              }
            },
            onload: p => {
              rookieV2_lock.setRef(p);
            },
            get children() {
              return [libs.createComponent(EOM_Image.EOM_Image, {
                id: "LockIcon",
                get ["class"]() {
                  return libs.classNames("ActionImage", {
                    Lock: isLocked()
                  });
                }
              }), libs.createComponent(GenericPanel.CLabel, {
                className: "CostLabel",
                get text() {
                  return isLocked() ? "#UnlockShop" : "#LockShop";
                }
              }), libs.createElement("DOTAParticleScenePanel", {
                id: "LockParticle",
                particleName: "particles/ui/button_lock.vpcf",
                cameraOrigin: "235 0 0",
                lookAt: "0 0 0",
                fov: "50"
              }, null)];
            }
          }), libs.createComponent(EOM_Button.EOM_BaseButton, {
            id: "ActionPrepare",
            get opacity() {
              return showActionButton() ? "1" : "0";
            },
            onload: self => {
              prepareRookieTimer(self);
            },
            get className() {
              return libs.classNames("ShopAction", {
                "EnglishReady": $.Language().toLowerCase() != "schinese"
              });
            },
            tooltip: "#prepare_ready_tooltip",
            get enabled() {
              return libs.memo(() => !!prepareEnable())() && !bPrepareReady();
            },
            onactivate: self => {
              prepareReady(self);
              clearRookieTip("shop");
              if (rookieV2_ready.state()) {
                closeRookieV2Tip("shop_ready");
              }
            },
            onload: p => {
              rookieV2_ready.setRef(p);
            },
            get children() {
              return [libs.createElement("Image", {
                id: "PrepareIcon",
                "class": "ActionImage"
              }, null), libs.createComponent(GenericPanel.CLabel, {
                className: "CostLabel",
                text: "#Prepare"
              })];
            }
          })];
        })();
      }
    }), null);
    libs.effect(_$p => libs.setProp(_el$25, "className", libs.classNames({
      Show: shopShow()
    }), _$p));
    return _el$25;
  })();
};
const getBattleInfoData = ({
  data1,
  data2,
  type1,
  type2,
  direction
}) => {
  const localPlayerID = Players.GetLocalPlayer();
  let isAlly = id => {
    return localPlayerID == id;
  };
  if (isGroupMode()) {
    let gourpIndex = getPlayerData(localPlayerID, "groupIndex");
    const groupInfo = CustomNetTables.GetTableValue("common", "group_team_" + gourpIndex);
    if (groupInfo?.players) {
      isAlly = id => {
        return Object.values(groupInfo.players).includes(id);
      };
    }
  }
  let resultData = data1;
  let resultType = "P";
  if (data1.type == "custom") {
    if (isAlly(data1.id) && type1 == "P") {
      if (direction == "Right") {
        resultData = data1;
        resultType = type1;
      } else {
        resultData = data2;
        resultType = type2;
      }
    } else {
      if (direction == "Right") {
        resultData = data2;
        resultType = type2;
      } else {
        resultData = data1;
        resultType = type1;
      }
    }
  } else {
    if (isAlly(data2.id) && type2 == "P") {
      if (direction == "Right") {
        resultData = data2;
        resultType = type2;
      } else {
        resultData = data1;
        resultType = type1;
      }
    } else {
      if (direction == "Right") {
        resultData = data1;
        resultType = type1;
      } else {
        resultData = data2;
        resultType = type2;
      }
    }
  }
  return {
    data: resultData,
    type: resultType
  };
};
const getItemList = entIndex => {
  let items = ["", "", ""];
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
const isCeasefireState = game_state => {
  if (game_state == "GameState_ExtraBattlePrepare" || game_state == "GameState_ConfirmBattle" || game_state == "GameState_Battle" || game_state == "GameState_ConfirmNeutral" || game_state == "GameState_Neutral" || game_state == "GameState_BattleEnd") {
    return false;
  }
  return true;
};
const usePlayerBanner = direction => {
  const localPlayerID = Players.GetLocalPlayer();
  const [show, setShow] = libs.createSignal(direction == "Right" ? true : isBattleState(CustomNetTables.GetTableValue("common", "game_state") ?? undefined));
  const [game_state, setGameState] = libs.createSignal(getGameState());
  libs.createEffect(libs.on(game_state, gameState => {
    if (direction == "Left") {
      setShow(gameState == "GameState_Battle" || gameState == "GameState_ConfirmBattle" || gameState == "GameState_Neutral" || gameState == "GameState_ConfirmNeutral");
    }
  }));
  let defaultInfo = {
    player_id: getPlayerData(localPlayerID, "viewPlayerInfo")?.player_id ?? localPlayerID,
    is_illusion: getPlayerData(localPlayerID, "viewPlayerInfo")?.is_illusion ?? 0
  };
  if (isSpectator()) {
    defaultInfo = {
      player_id: GameUI.GetSpectatorViewingInfo().player_id,
      is_illusion: GameUI.GetSpectatorViewingInfo().illusion ? 1 : 0
    };
    libs.createEffect(() => {
      const spectatorInfo = GameUI.GetSpectatorViewingInfo();
      setWatchingPlayerInfo("player_id", spectatorInfo.player_id);
      setWatchingPlayerInfo("is_illusion", GameUI.GetSpectatorViewingInfo().illusion ? 1 : 0);
    });
  }
  const [watchingPlayerInfo, setWatchingPlayerInfo] = libs.createStore(defaultInfo);
  const [newBattleInfo, setNewBattleInfo] = libs.createSignal(CustomNetTables.GetTableValue("common", "new_battle_info"));
  const [entIndex, setEntIndex] = libs.createSignal(-1);
  const [playerID, setPlayerID] = libs.createSignal(-1);
  const [isViewingPlayer, setIsViewingPlayer] = libs.createSignal(true);
  const [steamID, setSteamID] = libs.createSignal("");
  const [level, setLevel] = libs.createSignal(1);
  const [heroName, setHeroName] = libs.createSignal("");
  let heroNameRefreshTimer;
  libs.createEffect(libs.on(entIndex, v => {
    if (heroNameRefreshTimer) {
      $.CancelScheduled(heroNameRefreshTimer);
      heroNameRefreshTimer = undefined;
    }
    let name = Entities.GetUnitName(v);
    if (name == "" || name == undefined) {
      heroNameRefreshTimer = $.Schedule(0.03, () => {
        heroNameRefreshTimer = undefined;
        setHeroName(Entities.GetUnitName(v) ?? "");
      });
    } else {
      setHeroName(name);
    }
  }));
  const [itemList, setItemList] = libs.createSignal([]);
  const [sectList, setSectList] = libs.createSignal([]);
  libs.createEffect(libs.on(heroName, v => {
    const _sectList = KeyValues.UnitsKv[v]?.Sect?.split("|") ?? [];
    setSectList(_sectList);
  }));
  const [shardUnlocked, setShardUnlocked] = libs.createSignal(false);
  const [shardPurchasable, setShardPurchasable] = libs.createSignal(false);
  const [shardCostConfig, setShardCostConfig] = libs.createSignal({});
  const shardDiscount = () => localPlayerData()?.shardDiscount ?? 0;
  const shardCost = libs.createMemo(() => {
    const kv = KeyValues.HeroShardKv[heroName() + "_shard"];
    if (typeof kv?.ShardLevel == "number") {
      const config = shardCostConfig()[kv?.ShardLevel];
      return Math.max(config.min, config.origin - shardDiscount());
    }
    return -1;
  });
  const [attribute, setAttribute] = libs.createSignal({
    Attack: 0,
    Attackspeed: 0,
    Critical: 0,
    CriticalDamage: 150,
    Evasion: 0
  });
  const getTraitLv = data => {
    if (data == undefined) {
      return (getPlayerData(playerID(), "trait") ? 1 : 0) + (getPlayerData(playerID(), "trait2") ? 1 : 0);
    }
    return (data.trait ? 1 : 0) + (data.trait2 ? 1 : 0);
  };
  const [trait_lv, setTraitLv] = libs.createSignal(getTraitLv());
  const skinID = libs.createMemo(() => {
    const netTableData = getServiceNetTable("player_equipped_ornament", playerID())?.[OrnamentType.HERO_SKIN];
    let _skinID;
    if (netTableData) {
      for (const oid in netTableData) {
        const kv = KeyValues.CosmeticsKv[oid];
        if (kv && kv.hero && GetHeroNameByGoodID(finiteNumber(Number(kv.hero))) == heroName()) {
          _skinID = oid;
        }
      }
    }
    return _skinID;
  });
  const model = libs.createMemo(() => KeyValues.UnitsKv[heroName()]?.Model ?? "");
  const [itemCharges, setItemCharges] = libs.createSignal({});
  let itemChargerListener = -1;
  libs.createEffect(libs.on(playerID, _playerID => {
    if (itemChargerListener != -1) {
      CustomNetTables.UnsubscribeNetTableListener(itemChargerListener);
      itemChargerListener = -1;
    }
    if (_playerID != -1) {
      itemChargerListener = useNetTableKey("common", "hero_item_charges_" + _playerID, _itemCharges => {
        setItemCharges(_itemCharges);
      });
    }
  }));
  libs.createEffect(libs.on(playerID, _playerID => {
    setLevel(getPlayerData(playerID(), "heroLevel") ?? 1);
    setSteamID(getPlayerData(playerID(), "steamID") ?? "");
    setTraitLv(getTraitLv());
    setShardUnlocked(getPlayerData(playerID(), "shardState") == 1);
    setShardPurchasable(getPlayerData(playerID(), "shardPurchasable") == 1);
  }));
  libs.createEffect(() => {
    setShow(entIndex() != -1);
  });
  libs.createEffect(() => {
    const viewingPlayerID = watchingPlayerInfo.player_id;
    const viewingIllusion = watchingPlayerInfo.is_illusion == 1;
    const current_newBattleInfo = newBattleInfo();
    if (isCeasefireState(game_state())) {
      if (direction == "Right") {
        setPlayerID(viewingPlayerID);
        setEntIndex(getPlayerData(viewingPlayerID, "heroEntIndex") ?? -1);
        setIsViewingPlayer(true);
      } else {
        setPlayerID(-1);
        setIsViewingPlayer(false);
      }
    } else {
      const viewingKey = (viewingIllusion ? "I" : "P") + "_" + viewingPlayerID.toString();
      let enemyKey = "";
      let entIndex = -1;
      let playerID = -1;
      let _isViewingPlayer = false;
      let success = false;
      if (current_newBattleInfo) {
        const viewInfo = current_newBattleInfo[viewingKey];
        if (viewInfo) {
          enemyKey = viewInfo.enemy_key;
        }
        const enemyInfo = enemyKey == "" ? undefined : current_newBattleInfo[enemyKey];
        if (enemyInfo) {
          let {
            data,
            type
          } = getBattleInfoData({
            data1: viewInfo,
            type1: viewingKey.slice(0, 1),
            data2: enemyInfo,
            type2: enemyKey.slice(0, 1),
            direction: direction
          });
          _isViewingPlayer = type == "P";
          entIndex = data?.index;
          playerID = data?.id;
          success = true;
        }
      }
      if (!success) {
        if (direction == "Right") {
          if (isSpectator()) {
            playerID = viewingPlayerID;
          } else {
            if (!viewingIllusion && viewingKey.slice(0, 1) == "P") {
              playerID = viewingPlayerID;
            } else {
              playerID = localPlayerID;
            }
          }
          entIndex = getPlayerData(playerID, "heroEntIndex");
          _isViewingPlayer = true;
        }
      }
      libs.batch(() => {
        setIsViewingPlayer(_isViewingPlayer);
        setPlayerID(playerID);
        setEntIndex(entIndex);
      });
    }
  });
  const UpdateEntIndex = () => {
    if (show()) {
      const _itemList = getItemList(entIndex());
      libs.batch(() => {
        setItemList(_itemList);
      });
    }
  };
  const UpdateAttribute = () => {
    if (show()) {
      const _attribute = {
        Attack: Round(Entities.GetAttackDamage(entIndex()) ?? 0),
        Attackspeed: Round(Entities.GetAttacksPerSecond(entIndex()) ?? 0, 2),
        Critical: Round(Entities.GetPhysicalCriticalChance(entIndex()) ?? 0),
        CriticalDamage: Round(Entities.GetUnitData(entIndex(), "GetPhysicalCriticalDamage") ?? 0),
        Evasion: Round(Entities.GetEvasion(entIndex()) ?? 0)
      };
      setAttribute(_attribute);
    }
  };
  libs.onMount(() => {
    const entIndexTimer = setInterval(UpdateEntIndex, 200);
    const attributeTimer = setInterval(UpdateAttribute, 100);
    const listenerIDList = [];
    listenerIDList.push(useNetTableKey("common", "game_state", data => {
      setGameState(data?.state ?? "GameState_None");
    }));
    listenerIDList.push(useNetTableKey("common", "new_battle_info", data => {
      setNewBattleInfo(data);
    }));
    listenerIDList.push(CustomNetTables.SubscribeNetTableListener("player_data", (tableName, key, playerData) => {
      if (!isSpectator()) {
        libs.batch(() => {
          if (key == String(localPlayerID)) {
            if (playerData.viewPlayerInfo) {
              setWatchingPlayerInfo("player_id", playerData.viewPlayerInfo.player_id);
              setWatchingPlayerInfo("is_illusion", playerData.viewPlayerInfo.is_illusion);
            }
          }
          if (isCeasefireState(game_state())) {
            if (key == String(playerID())) {
              if (playerData.heroEntIndex && entIndex() != playerData.heroEntIndex) {
                setEntIndex(playerData.heroEntIndex ?? -1);
              }
              if (playerData.heroLevel) {
                setLevel(playerData.heroLevel);
              }
              if (playerData.steamID) {
                setSteamID(playerData.steamID);
              }
              setShardUnlocked(playerData.shardState == 1);
              setShardPurchasable(playerData.shardPurchasable == 1);
              setTraitLv(getTraitLv(playerData));
            }
          }
        });
      } else {
        if (isCeasefireState(game_state()) && direction == "Right") {
          if (key == watchingPlayerInfo.player_id) {
            if (playerData.heroEntIndex && entIndex() != playerData.heroEntIndex) {
              setEntIndex(playerData.heroEntIndex ?? -1);
            }
          }
        }
      }
    }));
    listenerIDList.push(useNetTableKeyHasDefaultValue("common", "constant", data => {
      setShardCostConfig(data.SHARD_LEVEL_COST);
    }));
    libs.onCleanup(() => {
      listenerIDList.forEach(id => {
        CustomNetTables.UnsubscribeNetTableListener(id);
      });
      if (itemChargerListener != -1) {
        CustomNetTables.UnsubscribeNetTableListener(itemChargerListener);
        itemChargerListener = -1;
      }
      clearInterval(entIndexTimer);
      clearInterval(attributeTimer);
      if (heroNameRefreshTimer) {
        $.CancelScheduled(heroNameRefreshTimer);
        heroNameRefreshTimer = undefined;
      }
    });
  });
  return {
    show,
    playerID,
    heroName,
    steamID,
    level,
    itemList,
    model,
    skinID,
    itemCharges,
    entIndex,
    sectList,
    attribute,
    trait_lv,
    isViewingPlayer,
    shardUnlocked,
    shardCost,
    shardPurchasable,
    game_state
  };
};
const PlayerBanner = props => {
  const {
    show,
    playerID,
    heroName,
    steamID,
    level,
    itemList,
    model,
    skinID,
    itemCharges,
    entIndex,
    sectList,
    attribute,
    trait_lv,
    isViewingPlayer,
    shardUnlocked,
    shardCost,
    shardPurchasable,
    game_state
  } = usePlayerBanner(props.direction);
  let sHotkey = Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL);
  const isNeutral = () => {
    if (heroName() == "neu_roshan") {
      return true;
    }
    const reg = /^neu_\d+$/;
    const result = reg.test(heroName());
    return result;
  };
  const _level = () => {
    if (isNeutral()) {
      return 1;
    } else {
      return level();
    }
  };
  const rookieV2_attribute1 = rookie_utils.useRookieV2Effect({
    key: "hero_attribute",
    params: {
      tooltip_position: "left"
    }
  }, undefined, true);
  const rookieV2_attribute2 = rookie_utils.useRookieV2Effect({
    key: "hero_attribute_enemy",
    params: {
      tooltip_position: "right"
    }
  }, undefined, true);
  libs.createEffect(libs.on(game_state, v => {
    rookieV2_attribute1.customToggleOn(v == "GameState_Battle");
    rookieV2_attribute2.customToggleOn(v == "GameState_Battle");
  }));
  libs.createEffect(libs.on(round$1, v => {
    if (v == 2) {
      if (rookieV2_attribute1.state()) {
        closeRookieV2Tip("hero_attribute");
      }
      if (rookieV2_attribute2.state()) {
        closeRookieV2Tip("hero_attribute_enemy");
      }
    }
  }));
  const [talentAbility, setTalentAbility] = libs.createSignal("");
  const [ultiAbility, setUltiAbility] = libs.createSignal("");
  const [talentAbilityIndex, setTalentAbilityIndex] = libs.createSignal(-1);
  const [ultiAbilityIndex, setUltiAbilityIndex] = libs.createSignal(-1);
  libs.onMount(() => {
    const id = setInterval(() => {
      libs.batch(() => {
        if (entIndex() != -1 && KeyValues.HeroAbilityDisplayList[heroName()]) {
          KeyValues.HeroAbilityDisplayList[heroName()].forEach(ability => {
            let abilityIndex = Entities.GetAbilityByName(entIndex(), ability);
            if (abilityIndex && !Abilities.IsHidden(abilityIndex)) {
              if (Abilities.IsPassive(abilityIndex)) {
                setTalentAbility(ability);
                setTalentAbilityIndex(Entities.GetAbilityByName(entIndex(), ability));
              } else {
                setUltiAbility(ability);
                setUltiAbilityIndex(Entities.GetAbilityByName(entIndex(), ability));
              }
            }
          });
        } else if (KeyValues.UnitsKv[heroName()]) {
          let talent = KeyValues.UnitsKv[heroName()]?.DefaultAbility1;
          let ulti = KeyValues.UnitsKv[heroName()]?.DefaultAbility2;
          setTalentAbility(talent);
          setUltiAbility(ulti);
          setTalentAbilityIndex(Entities.GetAbilityByName(entIndex(), talent));
          setUltiAbilityIndex(Entities.GetAbilityByName(entIndex(), ulti));
        }
      });
    }, 100);
    libs.onCleanup(() => {
      clearInterval(id);
    });
  });
  let IsLocalPlayer = () => isViewingPlayer() && playerID() == Players.GetLocalPlayer();
  if (isSpectator()) {
    IsLocalPlayer = () => !GameUI.GetSpectatorViewingInfo().illusion && isViewingPlayer() && playerID() == GameUI.GetSpectatorViewingInfo().player_id;
  }
  const InteractiveAbilityEnable = () => {
    if (props.direction == "Left") {
      return false;
    }
    if (isSpectator()) {
      return false;
    }
    let selfEnt = localPlayerData()?.heroEntIndex ?? -1;
    return selfEnt != -1 && selfEnt == entIndex();
  };
  return (() => {
    const _el$38 = libs.createElement("Panel", {
        hittest: false
      }, null),
      _el$42 = libs.createElement("Image", {
        hittest: false
      }, _el$38),
      _el$46 = libs.createElement("Image", {
        id: "PortraitBorder",
        hittest: false
      }, _el$38),
      _el$55 = libs.createElement("Panel", {
        id: "AbilityList"
      }, _el$38);
    libs.insert(_el$38, libs.createComponent(libs.Show, {
      get when() {
        return libs.memo(() => !!!isNeutral())() && show();
      },
      get children() {
        return [libs.createComponent(libs.Switch, {
          get fallback() {
            return (() => {
              const _el$56 = libs.createElement("Panel", {
                id: "ShardContainer"
              }, null);
              libs.insert(_el$56, libs.createComponent(EOM_Button.EOM_BaseButton, {
                id: "ShardUnlockButton",
                get classList() {
                  return {
                    ShowCost: shardCost() > 0 && IsLocalPlayer() && !shardUnlocked(),
                    GoldEnough: playerGold() >= shardCost(),
                    ShardPurchasable: shardPurchasable() && playerGold() >= shardCost()
                  };
                },
                get enabled() {
                  return libs.memo(() => !!(!shardUnlocked() && IsLocalPlayer()))() && shardCost() > 0;
                },
                onactivate: () => {
                  switchPopupMain("ShardUnlock", {
                    PopupID: "ShardUnlock"
                  });
                },
                get children() {
                  return [libs.createComponent(ShardAbility.ShardAbility, {
                    get heroName() {
                      return heroName();
                    },
                    get entIndex() {
                      return entIndex();
                    },
                    get playerID() {
                      return playerID();
                    },
                    showTooltip: true
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "ShardUnlockCost",
                    get tooltip_text() {
                      return getGameplayModuleState("card_effect") ? "#ShardCost_Description2" : "#ShardCost_Description";
                    },
                    get children() {
                      return [libs.createComponent(EOM_Icon.EOM_Icon, {
                        get src() {
                          return getSrcPath("icon/icon_gold_bevel_psd.png");
                        }
                      }), libs.createComponent(EOM_Label.EOM_Label, {
                        get text() {
                          return shardCost();
                        }
                      })];
                    }
                  })];
                }
              }));
              return _el$56;
            })();
          },
          get children() {
            return libs.createComponent(libs.Match, {
              get when() {
                return getGameplayModuleState("rune_task");
              },
              get children() {
                return libs.createComponent(EOM_Panel.EOM_Panel, {
                  id: "TraitAndShard",
                  get children() {
                    return [libs.createComponent(EOM_Panel.EOM_Panel, {
                      id: "TraitAndShardBG"
                    }), (() => {
                      const _el$39 = libs.createElement("Panel", {
                        id: "MixedTraitContainer"
                      }, null);
                      libs.insert(_el$39, libs.createComponent(EOM_Image.EOM_Image, {
                        get ["class"]() {
                          return libs.classNames("RuneRewardIcon", "LV" + trait_lv());
                        },
                        get customTooltip() {
                          return {
                            name: "rune_reward",
                            player_id: playerID()
                          };
                        }
                      }));
                      return _el$39;
                    })(), (() => {
                      const _el$40 = libs.createElement("Panel", {
                        id: "MixedShardContainer"
                      }, null);
                      libs.insert(_el$40, libs.createComponent(EOM_Button.EOM_BaseButton, {
                        id: "ShardUnlockButton",
                        get classList() {
                          return {
                            ShowCost: shardCost() > 0 && IsLocalPlayer() && !shardUnlocked(),
                            GoldEnough: playerGold() >= shardCost(),
                            ShardPurchasable: shardPurchasable() && playerGold() >= shardCost()
                          };
                        },
                        get enabled() {
                          return libs.memo(() => !!(!shardUnlocked() && IsLocalPlayer()))() && shardCost() > 0;
                        },
                        onactivate: () => {
                          switchPopupMain("ShardUnlock", {
                            PopupID: "ShardUnlock"
                          });
                        },
                        get children() {
                          return [libs.createComponent(ShardAbility.ShardAbility, {
                            get heroName() {
                              return heroName();
                            },
                            get entIndex() {
                              return entIndex();
                            },
                            get playerID() {
                              return playerID();
                            },
                            showTooltip: true
                          }), libs.createComponent(EOM_Panel.EOM_Panel, {
                            id: "ShardUnlockCost",
                            get tooltip_text() {
                              return !getGameplayModuleState("rune_task") ? "#ShardCost_Description2" : "#ShardCost_Description";
                            },
                            get children() {
                              return [libs.createComponent(EOM_Icon.EOM_Icon, {
                                get src() {
                                  return getSrcPath("icon/icon_gold_bevel_psd.png");
                                }
                              }), libs.createComponent(EOM_Label.EOM_Label, {
                                get text() {
                                  return shardCost();
                                }
                              })];
                            }
                          })];
                        }
                      }));
                      return _el$40;
                    })()];
                  }
                });
              }
            });
          }
        }), libs.createComponent(libs.Show, {
          get when() {
            return getGameplayModuleState("card_effect");
          },
          get children() {
            return libs.createComponent(EOM_Panel.EOM_Panel, {
              id: "CardEffectContainer",
              get customTooltip() {
                return {
                  name: "card_effect",
                  playerID: playerID(),
                  team_mode: Number(isGroupMode())
                };
              },
              get children() {
                return [libs.createComponent(EOM_Image.EOM_Image, {
                  id: "CardBG"
                }), libs.createComponent(EOM_Image.EOM_Image, {
                  id: "CardImage"
                })];
              }
            });
          }
        }), libs.createComponent(EOM_Panel.EOM_Panel, {
          get className() {
            return libs.classNames("InteractiveAbilityButtonContainer", {
              Show: hasInteractiveAbility(heroName())
            });
          },
          hittest: false,
          get children() {
            return [libs.createComponent(EOM_Button.EOM_BaseButton, {
              get className() {
                return libs.classNames("InteractiveAbilityButton", {
                  Show: true
                });
              },
              get enabled() {
                return libs.memo(() => !!InteractiveAbilityEnable())() && !_INTERACT_ABILITY_COOLDOWN();
              },
              onactivate: () => {
                if (_INTERACT_ABILITY_COOLDOWN()) {
                  return;
                }
                setInteractAbilityCooldown(true);
                let cd = 1;
                $.Schedule(cd, () => {
                  setInteractAbilityCooldown(false);
                });
                GameEvents.SendCustomEventToServer("active_interact_ability", {});
              },
              get children() {
                return libs.createComponent(InteractiveAbility.InteractiveAbility, {
                  get heroName() {
                    return heroName();
                  },
                  get playerID() {
                    return playerID();
                  },
                  isHUD: true
                });
              }
            }), libs.createComponent(libs.Show, {
              get when() {
                return InteractiveAbilityEnable();
              },
              get children() {
                return [libs.createComponent(EOM_Label.EOM_Label, {
                  id: "InteractiveAbilityLabel",
                  text: "#HeroInteractiveAbility",
                  hittest: false
                }), libs.createElement("DOTAParticleScenePanel", {
                  particleName: "particles/ui/background/ui_10th_anniversary_logo_fx.vpcf",
                  cameraOrigin: "300 0 0",
                  lookAt: "0 0 0",
                  fov: 30,
                  hittest: false
                }, null)];
              }
            })];
          }
        })];
      }
    }), _el$42);
    libs.setProp(_el$42, "className", "PlayerInfoBG");
    libs.insert(_el$38, libs.createComponent(EOM_XP.EOM_XP, {
      get level() {
        return _level();
      },
      maxLevel: 100,
      type: "C4",
      get dialogVariables() {
        return {
          value: _level()
        };
      },
      onmouseover: self => {
        $.DispatchEvent("DOTAShowTitleTextTooltip", self, $.Localize("#PlayerInfo_Level", self), $.Localize("#PlayerInfo_Level_description", self));
      },
      onmouseout: self => {
        $.DispatchEvent("DOTAHideTitleTextTooltip", self);
      }
    }), _el$46);
    libs.insert(_el$38, libs.createComponent(libs.Show, {
      get when() {
        return isNeutral();
      },
      fallback: () => libs.createComponent(Player.PlayerName, {
        get steamID() {
          return steamID();
        },
        get playerID() {
          return playerID();
        },
        get ban() {
          return isNameBan(playerID());
        }
      }),
      get children() {
        const _el$43 = libs.createElement("Panel", {}, null);
        libs.setProp(_el$43, "className", "PlayerName");
        libs.insert(_el$43, libs.createComponent(GenericPanel.CLabel, {
          get text() {
            return `#${heroName()}`;
          }
        }));
        return _el$43;
      }
    }), _el$46);
    libs.insert(_el$38, libs.createComponent(EOM_Panel.EOM_Panel, {
      className: "PlayerBannerPortraitContainer",
      get children() {
        return [libs.createComponent(HeroPortrait.HeroPortrait, {
          get unitname() {
            return skinID() ?? heroName();
          },
          get model() {
            return model();
          },
          get neutral() {
            return isNeutral();
          },
          get player_id() {
            return playerID();
          }
        }), (() => {
          const _el$44 = libs.createElement("Panel", {
            id: "TagList",
            dialogVariables: {
              sect_name: ""
            }
          }, null);
          libs.setProp(_el$44, "onmouseover", self => {
            let sects = sectList();
            if (sects.length > 0) {
              let tooltip = "";
              sects.forEach(sectName => {
                if (tooltip != "") {
                  tooltip += "<br>";
                }
                tooltip += $.Localize("#DOTA_Tooltip_ability_" + sectName);
              });
              if (tooltip != "") {
                let title = $.Localize("#RecommendSect", self);
                $.DispatchEvent("DOTAShowTitleTextTooltip", self, title, tooltip);
              }
            }
          });
          libs.setProp(_el$44, "onmouseout", self => {
            $.DispatchEvent("DOTAHideTitleTextTooltip", self);
          });
          libs.setProp(_el$44, "dialogVariables", {
            sect_name: ""
          });
          libs.insert(_el$44, libs.createComponent(libs.For, {
            get each() {
              return sectList();
            },
            children: (sectName, index) => {
              return (() => {
                const _el$57 = libs.createElement("Panel", {}, null),
                  _el$58 = libs.createElement("Image", {}, _el$57);
                libs.insert(_el$57, libs.createComponent(SectIcon.SectIcon, {
                  width: "42px",
                  height: "42px",
                  marginBottom: "-5px",
                  sectName: sectName
                }), _el$58);
                libs.setProp(_el$58, "className", "Suggest");
                return _el$57;
              })();
            }
          }));
          return _el$44;
        })(), libs.createComponent(libs.Show, {
          get when() {
            return itemList().length > 0;
          },
          get children() {
            return libs.createElement("Image", {
              id: "ItemMask",
              hittest: false
            }, null);
          }
        }), libs.createComponent(EOM_Panel.EOM_Panel, {
          get className() {
            return libs.classNames("ItemList", "Slot" + (itemList().length > 3 ? 4 : itemList().length));
          },
          get children() {
            return libs.createComponent(libs.Index, {
              get each() {
                return itemList();
              },
              children: (abilityName, i) => {
                return libs.createComponent(EOM_Button.EOM_BaseButton, {
                  className: "PlayerItemImageButton",
                  get enabled() {
                    return blessOn();
                  },
                  onactivate: self => {
                    GameEvents.SendCustomEventToServer("team_bless_action", {
                      type: "equipment",
                      value: i.toString()
                    });
                  },
                  get children() {
                    return [libs.createComponent(EOM_Panel.EOM_Panel, {
                      marginTop: "6px",
                      get children() {
                        return libs.createComponent(ItemImage.ItemImage, {
                          get className() {
                            return libs.classNames("Equipment", {
                              NoItem: abilityName() == ""
                            });
                          },
                          get itemName() {
                            return abilityName();
                          },
                          get itemCharge() {
                            return itemCharges()[abilityName()];
                          }
                        });
                      }
                    }), libs.createComponent(libs.Show, {
                      get when() {
                        return libs.memo(() => !!blessOn())() && abilityName() != "";
                      },
                      get children() {
                        return libs.createComponent(EOM_Panel.EOM_Panel, {
                          className: "TeamBlessIcon",
                          get children() {
                            return libs.createComponent(EOM_Icon.EOM_Icon, {});
                          }
                        });
                      }
                    })];
                  }
                });
              }
            });
          }
        }), libs.createComponent(libs.Show, {
          get when() {
            return heroName().indexOf("neu") == -1;
          },
          get children() {
            return libs.createComponent(TalentTree.TalentTree, {
              get playerID() {
                return playerID();
              },
              get heroName() {
                return heroName();
              },
              showTooltip: true
            });
          }
        })];
      }
    }), _el$46);
    libs.insert(_el$38, (() => {
      const _c$ = libs.memo(() => !!!isSpectator());
      return () => _c$() && libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "ActionList",
        get children() {
          return [libs.createComponent(EOM_Button.EOM_IconButton, {
            id: "EmojiAction",
            className: "PlayerAction",
            get icon() {
              return libs.createComponent(EOM_Image.EOM_Image, {
                id: "Emoji"
              });
            },
            customTooltip: {
              name: "hotkey_tip",
              hotkey: sHotkey
            },
            onactivate: () => clientSideEvent("emoji_action", {})
          }), libs.createComponent(EOM_Button.EOM_IconButton, {
            id: "ConsumableAction",
            className: "PlayerAction",
            get icon() {
              return libs.createComponent(EOM_Image.EOM_Image, {
                id: "Consumable"
              });
            },
            onactivate: () => setShowInteractiveAbilities(v => !v)
          })];
        }
      });
    })(), _el$55);
    libs.insert(_el$38, libs.createComponent(EOM_Panel.EOM_Panel, {
      id: "AttributeList",
      get customTooltip() {
        return {
          name: "attribute_detail",
          entIndex: entIndex()
        };
      },
      onload: self => {
        if (props.direction == "Right") {
          rookieV2_attribute1.setRef(self);
        } else {
          rookieV2_attribute2.setRef(self);
        }
      },
      onactivate: () => {
        if (props.direction == "Right") {
          if (rookieV2_attribute1.state()) {
            closeRookieV2Tip("hero_attribute");
          }
        } else {
          if (rookieV2_attribute2.state()) {
            closeRookieV2Tip("hero_attribute_enemy");
          }
        }
      },
      get children() {
        return [(() => {
          const _el$47 = libs.createElement("Panel", {}, null),
            _el$48 = libs.createElement("Image", {}, _el$47);
          libs.setProp(_el$47, "className", "AttributeRow");
          libs.setProp(_el$48, "className", "AttributeIcon Attack");
          libs.insert(_el$47, libs.createComponent(GenericPanel.CLabel, {
            className: "AttributeValue",
            get text() {
              return attribute().Attack;
            }
          }), null);
          return _el$47;
        })(), (() => {
          const _el$49 = libs.createElement("Panel", {}, null),
            _el$50 = libs.createElement("Image", {}, _el$49);
          libs.setProp(_el$49, "className", "AttributeRow");
          libs.setProp(_el$50, "className", "AttributeIcon AttackSpeed");
          libs.insert(_el$49, libs.createComponent(GenericPanel.CLabel, {
            className: "AttributeValue",
            get text() {
              return attribute().Attackspeed;
            }
          }), null);
          return _el$49;
        })(), (() => {
          const _el$51 = libs.createElement("Panel", {}, null),
            _el$52 = libs.createElement("Image", {}, _el$51);
          libs.setProp(_el$51, "className", "AttributeRow");
          libs.setProp(_el$52, "className", "AttributeIcon Crit");
          libs.insert(_el$51, libs.createComponent(GenericPanel.CLabel, {
            className: "AttributeValue",
            get text() {
              return attribute().Critical;
            }
          }), null);
          return _el$51;
        })(), (() => {
          const _el$53 = libs.createElement("Panel", {}, null),
            _el$54 = libs.createElement("Image", {}, _el$53);
          libs.setProp(_el$53, "className", "AttributeRow");
          libs.setProp(_el$54, "className", "AttributeIcon Evade");
          libs.insert(_el$53, libs.createComponent(GenericPanel.CLabel, {
            className: "AttributeValue",
            get text() {
              return attribute().Evasion;
            }
          }), null);
          return _el$53;
        })()];
      }
    }), _el$55);
    libs.insert(_el$55, libs.createComponent(AbilityImage.AbilityImage, {
      get abilityName() {
        return ultiAbility();
      },
      get entIndex() {
        return entIndex();
      },
      get playerID() {
        return playerID();
      },
      get abilityIndex() {
        return ultiAbilityIndex();
      }
    }), null);
    libs.insert(_el$55, libs.createComponent(AbilityImage.AbilityImage, {
      get abilityName() {
        return talentAbility();
      },
      get entIndex() {
        return entIndex();
      },
      get playerID() {
        return playerID();
      },
      get abilityIndex() {
        return talentAbilityIndex();
      }
    }), null);
    libs.insert(_el$38, libs.createComponent(libs.Show, {
      get when() {
        return libs.memo(() => !!getGameplayModuleState("greevil"))() && !isNeutral();
      },
      get children() {
        return libs.createComponent(greevil_icon.GreevilIcon, {
          get playerID() {
            return playerID();
          },
          get reverse() {
            return props.direction == "Left";
          },
          onHatchClick: canHatch => {
            if (props.direction == "Right" && !isSpectator() && playerID() == Players.GetLocalPlayer()) {
              if (canHatch) {
                setSelectionMode('greevil_skill');
              } else {
                ErrorMessage("#Greevil_Skill_Selection_Locked");
              }
            }
          }
        });
      }
    }), null);
    libs.effect(_$p => libs.setProp(_el$38, "className", libs.classNames("PlayerInfo", props.direction, {
      Show: show() && gameStateName() != "GameState_GreevilEgg"
    }), _$p));
    return _el$38;
  })();
};
const [show_interactive_abilities, setShowInteractiveAbilities] = libs.createSignal(false);
const InteractiveItems$1 = () => {
  const [abilityList, setAbilityList] = libs.createSignal([]);
  libs.onMount(() => {
    let id = setInterval(() => {
      const list = [];
      const heroIndex = Players.GetPlayerHeroEntityIndex(Players.GetLocalPlayer());
      if (Entities.IsValidEntity(heroIndex)) {
        for (let index = 0; index < 6; index++) {
          const ability = Entities.GetAbility(heroIndex, index);
          if (Entities.IsValidEntity(ability) && !Abilities.IsHidden(ability) && !Abilities.IsPassive(ability)) {
            if (Abilities.GetAbilityName(ability).startsWith("consumables_")) {
              list.push({
                abilityIndex: ability,
                charge: Abilities.GetCurrentAbilityCharges(ability)
              });
            }
          }
        }
      }
      setAbilityList(list);
    }, 30);
    libs.onCleanup(() => {
      clearInterval(id);
    });
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    get className() {
      return libs.classNames("InteractiveItems", {
        Show: show_interactive_abilities()
      });
    },
    get children() {
      return libs.createComponent(libs.Index, {
        get each() {
          return abilityList();
        },
        children: abilityData => {
          return libs.createComponent(InteractiveItemButton, {
            get abilityIndex() {
              return abilityData().abilityIndex;
            },
            get charge() {
              return abilityData().charge;
            }
          });
        }
      });
    }
  });
};
const GREEVIL_SHOP_SLOT_COUNT = 4;
const GreevilShop = props => {
  props.setShow(false);
  const [slots, setSlots] = libs.createSignal([]);
  const [playerGreevilLv, setPlayerGreevilLv] = libs.createSignal(0);
  const rarityRuleTips = () => {
    let text = "";
    let lv = playerGreevilLv();
    if (lv == 3) {
      text += $.Localize("#GreevilShopRefreshRule3");
    } else if (lv == 2) {
      text += $.Localize("#GreevilShopRefreshRule2");
    } else {
      text += $.Localize("#GreevilShopRefreshRule1");
    }
    text += "<br><br>" + $.Localize("#GreevilShopRefreshRule");
    return text;
  };
  libs.onMount(() => {
    const listenerList = [];
    listenerList.push(useSyncDataKey("common", "greevil_data", data => {
      setPlayerGreevilLv(data?.level ?? 0);
    }, Players.GetLocalPlayer()));
    libs.onCleanup(() => {
      listenerList.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    });
  });
  const listenerId = useNetTableKeyHasDefaultValue("greevil_shop", "greevil_shop_" + Players.GetLocalPlayer(), data => {
    const list = data?.list;
    if (!list) return;
    setSlots(prev => {
      const arr = [];
      for (let i = 0; i < GREEVIL_SHOP_SLOT_COUNT; i++) {
        const newSlot = list[String(i)];
        if (!newSlot) continue;
        const oldSlot = prev[i];
        if (oldSlot && oldSlot.id === newSlot.id && oldSlot.type === newSlot.type && oldSlot.value === newSlot.value && oldSlot.rarity === newSlot.rarity && oldSlot.special === newSlot.special && oldSlot.cost === newSlot.cost) {
          arr.push(oldSlot);
        } else {
          arr.push(newSlot);
        }
      }
      return arr;
    });
  });
  libs.onCleanup(() => {
    CustomNetTables.UnsubscribeNetTableListener(listenerId);
    props.setShow(false);
  });
  const onBuy = index => {
    if (props.hatchReward) {
      GameEvents.SendCustomGameEventToServer("select_hatch_reward", {
        slot_index: index
      });
    } else {
      GameEvents.SendCustomGameEventToServer("buy_greevil_shop_item", {
        slot_index: index
      });
    }
  };
  const REFRESH_COST = 2;
  const canRefresh = () => playerGreevilEnergy() >= REFRESH_COST;
  const onRefresh = () => {
    GameEvents.SendCustomGameEventToServer("refresh_greevil_shop", {});
  };
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "GreevilShop",
    get className() {
      return libs.classNames({
        GreevilShopShow: props.show
      });
    },
    hittest: false,
    get children() {
      return [libs.createElement("DOTAScenePanel", {
        hittest: false,
        id: "GreevilShopBG",
        particleonly: false,
        allowrotation: false,
        light: "preview_light",
        camera: "preview_camera",
        map: "scene/greevil_shop_ui"
      }, null), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "ShopBG",
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            width: "90px"
          }), libs.createComponent(libs.Show, {
            get when() {
              return props.show;
            },
            get children() {
              return libs.createComponent(libs.For, {
                get each() {
                  return slots();
                },
                children: (slot, i) => libs.createComponent(ShopEffectCard.GreevilShopCard, {
                  get Id() {
                    return Number(slot.id);
                  },
                  get type() {
                    return slot.type;
                  },
                  get rarity() {
                    return slot.rarity;
                  },
                  get value() {
                    return slot.value;
                  },
                  get special() {
                    return slot.special;
                  },
                  get cost() {
                    return slot.cost;
                  },
                  get playerGreevilEnergy() {
                    return playerGreevilEnergy();
                  },
                  onactivate: () => {
                    onBuy(i());
                  }
                })
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "GreevilShopBottomBlock",
            get children() {
              return libs.createComponent(libs.Show, {
                get when() {
                  return !props.hatchReward;
                },
                get fallback() {
                  return libs.createComponent(GenericPanel.CLabel, {
                    id: "GreevilShopHatchRewardText",
                    text: "#GreevilHatchRewardTip"
                  });
                },
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    width: "16px",
                    height: "16px"
                  }), libs.createComponent(EOM_Button.EOM_BaseButton, {
                    id: "GreevilShopRefreshBtn",
                    get enabled() {
                      return canRefresh();
                    },
                    onactivate: onRefresh,
                    get children() {
                      const _el$60 = libs.createElement("Panel", {
                        id: "GreevilShopRefreshBtnWrap"
                      }, null);
                      libs.insert(_el$60, libs.createComponent(GenericPanel.CLabel, {
                        id: "GreevilShopRefreshText",
                        text: "#Refresh"
                      }), null);
                      libs.insert(_el$60, libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "GreevilShopRefreshCost",
                        get children() {
                          return [libs.createElement("Image", {
                            id: "GreevilShopRefreshEnergyIcon"
                          }, null), libs.createComponent(GenericPanel.CLabel, {
                            id: "GreevilShopRefreshCostText",
                            text: REFRESH_COST
                          })];
                        }
                      }), null);
                      return _el$60;
                    }
                  }), libs.createComponent(EOM_Icon.EOM_Icon, {
                    id: "GreevilShopRefreshRuleInfo",
                    verticalAlign: "center",
                    size: "16",
                    get src() {
                      return getSrcPath("eom_design/icon/C4/info.png");
                    },
                    get tooltip() {
                      return rarityRuleTips();
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
const CustomAbilitySelect = () => {
  const [banListNet, _setBanListNet2] = libs.createSignal(CustomNetTables.GetTableValue("common", "ban_list"));
  const banList = () => Object.values(banListNet() ?? {});
  const pickList = () => Object.keys(GameUI.CustomUIConfig().SectAbilitiesKv).filter(sectName => !banList().includes(sectName));
  const onDragStart = (source, dragCallbacks) => {
    const displayPanel = $.CreatePanel("Image", source, "DragPanel", {
      src: "panel://" + source.id
    });
    dragCallbacks.displayPanel = displayPanel;
    return true;
  };
  const onDragEnter = (source, draggedPanel) => {
    return false;
  };
  const onDragLeave = (source, draggedPanel) => {
    return false;
  };
  const onDragDrop = (source, draggedPanel) => {
    return true;
  };
  const onDragEnd = (source, draggedPanel) => {
    draggedPanel.DeleteAsync(-1);
  };
  const [sectMergeData, setsectMergeData] = libs.createSignal(CustomNetTables.GetTableValue("sect_data", "sect_merge_" + Players.GetLocalPlayer()) ?? {
    trigger: "",
    effect: ""
  });
  const onClickSect = sectName => {
    if (isSpectator()) return;
    if (sectMergeData()?.trigger == "" || sectMergeData()?.trigger == undefined) {
      GameEvents.SendCustomEventToServer("select_merge_ability", {
        type: "trigger",
        sectName: sectName
      });
    } else {
      GameEvents.SendCustomEventToServer("select_merge_ability", {
        type: "effect",
        sectName: sectName
      });
    }
  };
  const triggerDesc = () => getCustomAbilityDescription(sectMergeData()?.trigger + "_trigger", 1, undefined, true);
  const effectDesc = () => getCustomAbilityDescription(sectMergeData()?.effect + "_effect", 1, undefined, true);
  libs.onMount(() => {
    const listenerIDList = [];
    listenerIDList.push(useNetTableKey("sect_data", "sect_merge_" + Players.GetLocalPlayer(), data => {
      setsectMergeData(data);
    }));
    libs.onCleanup(() => {
      listenerIDList.forEach(id => {
        CustomNetTables.UnsubscribeNetTableListener(id);
      });
    });
  });
  let resultCard;
  libs.createEffect(() => {
    if (sectMergeData()?.trigger != "" && sectMergeData()?.trigger != undefined && sectMergeData()?.effect != "" && sectMergeData()?.effect != undefined) {
      resultCard?.TriggerClass("Show");
    }
  });
  libs.createEffect(() => {
    const id = CustomNetTables.SubscribeNetTableListener("common", function (_, k, v) {
      if (k === "ban_list") {
        _setBanListNet2(v);
      }
    });
    libs.onCleanup(() => {
      CustomNetTables.UnsubscribeNetTableListener(id);
    });
  });
  return (() => {
    const _el$62 = libs.createElement("Panel", {
        id: "CustomAbilitySelect",
        hittest: false
      }, null),
      _el$63 = libs.createElement("Panel", {
        id: "SectList",
        hittest: false
      }, _el$62);
    libs.insert(_el$63, libs.createComponent(EOM_Panel.EOM_Panel, {
      flowChildren: "right",
      align: "center center",
      hittest: false,
      get children() {
        return libs.createComponent(libs.Index, {
          get each() {
            return pickList();
          },
          children: (sectName, index) => {
            return libs.createComponent(EOM_Button.EOM_BaseButton, {
              onDragStart: onDragStart,
              onDragLeave: onDragLeave,
              onDragEnter: onDragEnter,
              onDragDrop: onDragDrop,
              onDragEnd: onDragEnd,
              get id() {
                return sectName();
              },
              get customTooltip() {
                return {
                  name: "player_sect_list",
                  sectName: sectName(),
                  concise: 1
                };
              },
              tooltipPosition: "top",
              onactivate: () => {
                onClickSect(sectName());
              },
              get enabled() {
                return !(sectMergeData().effect == sectName() || sectMergeData().trigger == sectName());
              },
              get children() {
                return libs.createComponent(SectIcon.SectIcon, {
                  large: true,
                  active: true,
                  get sectName() {
                    return sectName();
                  },
                  width: "56px",
                  height: "56px"
                });
              }
            });
          }
        });
      }
    }));
    libs.insert(_el$62, libs.createComponent(EOM_Panel.EOM_Panel, {
      flowChildren: "right",
      horizontalAlign: "center",
      hittest: false,
      get children() {
        return [libs.createComponent(EOM_Panel.EOM_Panel, {
          width: "148px"
        }), libs.createComponent(EOM_Button.EOM_BaseButton, {
          "class": "TraitCard",
          onactivate: () => {
            if (isSpectator()) return;
            GameEvents.SendCustomEventToServer("select_merge_ability", {
              type: "trigger",
              sectName: ""
            });
          },
          get children() {
            return [(() => {
              const _el$64 = libs.createElement("Panel", {
                  "class": "Slot"
                }, null);
                libs.createElement("Image", {
                  "class": "Add"
                }, _el$64);
              libs.insert(_el$64, libs.createComponent(libs.Show, {
                get when() {
                  return sectMergeData()?.trigger != undefined;
                },
                get children() {
                  return libs.createComponent(SectIcon.SectIcon, {
                    large: true,
                    active: true,
                    get sectName() {
                      return sectMergeData()?.trigger ?? "";
                    },
                    width: "100px",
                    height: "100px"
                  });
                }
              }), null);
              return _el$64;
            })(), libs.createComponent(libs.Show, {
              get when() {
                return libs.memo(() => sectMergeData()?.trigger != undefined)() && sectMergeData()?.trigger != "";
              },
              get children() {
                const _el$66 = libs.createElement("Label", {
                  "class": "Name",
                  get text() {
                    return "#DOTA_Tooltip_ability_" + sectMergeData()?.trigger;
                  }
                }, null);
                libs.effect(_$p => libs.setProp(_el$66, "text", "#DOTA_Tooltip_ability_" + sectMergeData()?.trigger, _$p));
                return _el$66;
              }
            }), (() => {
              const _el$67 = libs.createElement("Label", {
                html: true,
                "class": "Desc",
                get text() {
                  return libs.memo(() => !!(sectMergeData()?.trigger == undefined || sectMergeData()?.trigger == ""))() ? "#WaitTrait" : triggerDesc();
                }
              }, null);
              libs.effect(_$p => libs.setProp(_el$67, "text", libs.memo(() => !!(sectMergeData()?.trigger == undefined || sectMergeData()?.trigger == ""))() ? "#WaitTrait" : triggerDesc(), _$p));
              return _el$67;
            })()];
          }
        }), libs.createElement("Image", {
          "class": "AddIcon",
          hittest: false
        }, null), libs.createComponent(EOM_Button.EOM_BaseButton, {
          "class": "TraitCard",
          onactivate: () => {
            if (isSpectator()) return;
            GameEvents.SendCustomEventToServer("select_merge_ability", {
              type: "effect",
              sectName: ""
            });
          },
          get children() {
            return [(() => {
              const _el$69 = libs.createElement("Panel", {
                  "class": "Slot"
                }, null);
                libs.createElement("Image", {
                  "class": "Add"
                }, _el$69);
              libs.insert(_el$69, libs.createComponent(libs.Show, {
                get when() {
                  return sectMergeData()?.effect != undefined;
                },
                get children() {
                  return libs.createComponent(SectIcon.SectIcon, {
                    large: true,
                    active: true,
                    get sectName() {
                      return sectMergeData()?.effect ?? "";
                    },
                    width: "100px",
                    height: "100px"
                  });
                }
              }), null);
              return _el$69;
            })(), libs.createComponent(libs.Show, {
              get when() {
                return libs.memo(() => sectMergeData()?.effect != undefined)() && sectMergeData()?.effect != "";
              },
              get children() {
                const _el$71 = libs.createElement("Label", {
                  "class": "Name",
                  get text() {
                    return "#DOTA_Tooltip_ability_" + sectMergeData()?.effect;
                  }
                }, null);
                libs.effect(_$p => libs.setProp(_el$71, "text", "#DOTA_Tooltip_ability_" + sectMergeData()?.effect, _$p));
                return _el$71;
              }
            }), (() => {
              const _el$72 = libs.createElement("Label", {
                html: true,
                "class": "Desc",
                get text() {
                  return libs.memo(() => !!(sectMergeData()?.effect == undefined || sectMergeData()?.effect == ""))() ? "#WaitTrait" : effectDesc();
                }
              }, null);
              libs.effect(_$p => libs.setProp(_el$72, "text", libs.memo(() => !!(sectMergeData()?.effect == undefined || sectMergeData()?.effect == ""))() ? "#WaitTrait" : effectDesc(), _$p));
              return _el$72;
            })()];
          }
        }), libs.createElement("Image", {
          "class": "EqualIcon",
          hittest: false
        }, null), libs.createComponent(EOM_Button.EOM_BaseButton, {
          "class": "TraitCard",
          ref(r$) {
            const _ref$7 = resultCard;
            typeof _ref$7 === "function" ? _ref$7(r$) : resultCard = r$;
          },
          onactivate: () => setSelectionMode(undefined),
          get children() {
            return [(() => {
              const _el$74 = libs.createElement("Panel", {
                  "class": "ResultSlot"
                }, null);
                libs.createElement("Image", {
                  "class": "Wait"
                }, _el$74);
                const _el$76 = libs.createElement("Image", {
                  get src() {
                    return `file://{images}/spellicons/${KeyValues.CustomAbilitiesKv[sectMergeData()?.effect + "_effect"]?.AbilityTextureName}.png`;
                  }
                }, _el$74);
              libs.setProp(_el$76, "className", "DOTAAbilityImage");
              libs.effect(_$p => libs.setProp(_el$76, "src", `file://{images}/spellicons/${KeyValues.CustomAbilitiesKv[sectMergeData()?.effect + "_effect"]?.AbilityTextureName}.png`, _$p));
              return _el$74;
            })(), libs.createComponent(libs.Show, {
              get when() {
                return libs.memo(() => !!(sectMergeData()?.effect != undefined && sectMergeData()?.effect != "" && sectMergeData()?.trigger != undefined))() && sectMergeData()?.trigger != "";
              },
              get children() {
                const _el$77 = libs.createElement("Label", {
                  "class": "Name ResultName",
                  get text() {
                    return `#DOTA_Tooltip_ability_${sectMergeData()?.effect}_result`;
                  }
                }, null);
                libs.effect(_$p => libs.setProp(_el$77, "text", `#DOTA_Tooltip_ability_${sectMergeData()?.effect}_result`, _$p));
                return _el$77;
              }
            }), (() => {
              const _el$78 = libs.createElement("Label", {
                "class": "Desc",
                html: true,
                get text() {
                  return libs.memo(() => !!(sectMergeData()?.effect == undefined || sectMergeData()?.effect == "" || sectMergeData()?.trigger == undefined || sectMergeData()?.trigger == ""))() ? "#WaitTrait" : triggerDesc() + ", " + effectDesc();
                }
              }, null);
              libs.effect(_$p => libs.setProp(_el$78, "text", libs.memo(() => !!(sectMergeData()?.effect == undefined || sectMergeData()?.effect == "" || sectMergeData()?.trigger == undefined || sectMergeData()?.trigger == ""))() ? "#WaitTrait" : triggerDesc() + ", " + effectDesc(), _$p));
              return _el$78;
            })()];
          }
        }), libs.createComponent(EOM_Button.EOM_BaseButton, {
          className: "ShopAction",
          marginTop: "175px",
          onactivate: self => {
            setSelectionMode(undefined);
          },
          get children() {
            return [libs.createElement("Image", {
              id: "CollapseIcon",
              "class": "ActionImage"
            }, null), libs.createComponent(GenericPanel.CLabel, {
              className: "CostLabel",
              text: "#CollapseSelection"
            })];
          }
        })];
      }
    }), null);
    return _el$62;
  })();
};
const RoshanReward = () => {
  const [rewardList1, setRewardList1] = libs.createSignal([]);
  const [rewardList2, setRewardList2] = libs.createSignal([]);
  libs.createEffect(libs.on(roshanReward, data => {
    if (data != undefined) {
      let arr = Object.keys(data).sort((a, b) => finiteNumber(Number(a.replace("roshan_", "")), 999) - finiteNumber(Number(b.replace("roshan_", "")), 999));
      let list1 = [];
      let list2 = [];
      for (let i = 0; i < arr.length; i++) {
        if (i >= arr.length / 2) {
          list2.push(arr[i]);
        } else {
          list1.push(arr[i]);
        }
      }
      libs.batch(() => {
        setRewardList1(list1);
        setRewardList2(list2);
      });
    }
  }));
  let cooldown = false;
  const LocalPlayerID = Players.GetLocalPlayer();
  const canPick = () => {
    if (isSpectator()) {
      return false;
    } else {
      if (roshanSelectionInfo()?.player_selection[LocalPlayerID] == undefined) {
        let selecting = roshanSelectionInfo()?.selecting ?? -1;
        if (selecting != -1 && roshanPlayerOrder()) {
          let selectingIndex = Object.values(roshanPlayerOrder()).indexOf(selecting);
          let localIndex = Object.values(roshanPlayerOrder()).indexOf(LocalPlayerID);
          if (localIndex != -1 && selectingIndex >= localIndex) {
            return true;
          }
        }
      }
      return false;
    }
  };
  const [sectData, setSectData] = libs.createSignal();
  libs.onMount(() => {
    if (!isSpectator()) {
      const id = useNetTableKeyHasDefaultValue("sect_data", "ability_upgrade_" + Players.GetLocalPlayer().toString(), data => {
        setSectData(data);
      });
      libs.onCleanup(() => {
        CustomNetTables.UnsubscribeNetTableListener(id);
      });
    }
  });
  return [(() => {
    const _el$80 = libs.createElement("DOTAParticleScenePanel", {
      hittest: false,
      id: "RoshanSelectingParticle",
      particleName: "particles/gameplay/ui_roshan_selecting.vpcf",
      cameraOrigin: "0 0 300",
      lookAt: "0 0 0",
      fov: 15
    }, null);
    libs.effect(_$p => libs.setProp(_el$80, "classList", {
      Show: canPick()
    }, _$p));
    return _el$80;
  })(), libs.createComponent(EOM_Panel.EOM_Panel, {
    get className() {
      return libs.classNames("RoshanRewardMain", {
        canPick: canPick()
      });
    },
    hittest: false,
    get children() {
      return libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "RoshanRewardBottom",
        hittest: false,
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "RoshanRewardTitle",
            tooltip: "#RoshanRewardDescription",
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "RoshanRewardTitleBg Left"
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                verticalAlign: "center",
                flowChildren: "right",
                get children() {
                  return [libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#RoshanChallenge"
                  }), libs.createComponent(EOM_Icon.EOM_Icon, {
                    size: "24",
                    get src() {
                      return getSrcPath("icon/c_info.png");
                    }
                  })];
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "RoshanRewardTitleBg Right"
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "RoshanRewardList",
            get children() {
              return [libs.createComponent(RoshanRewardListRow, {
                get sectData() {
                  return sectData();
                },
                get list() {
                  return rewardList1();
                },
                get canPick() {
                  return canPick();
                },
                onSelect: key => {
                  if (isSpectator()) {
                    return;
                  }
                  if (cooldown) {
                    return;
                  }
                  cooldown = true;
                  $.Schedule(0.1, () => {
                    cooldown = false;
                  });
                  GameEvents.SendCustomEventToServer("select_roshan_reward", {
                    reward_index: key
                  });
                }
              }), libs.createComponent(RoshanRewardListRow, {
                get sectData() {
                  return sectData();
                },
                get list() {
                  return rewardList2();
                },
                get canPick() {
                  return canPick();
                },
                onSelect: key => {
                  if (isSpectator()) {
                    return;
                  }
                  if (cooldown) {
                    return;
                  }
                  cooldown = true;
                  $.Schedule(0.1, () => {
                    cooldown = false;
                  });
                  GameEvents.SendCustomEventToServer("select_roshan_reward", {
                    reward_index: key
                  });
                }
              })];
            }
          })];
        }
      });
    }
  })];
};
const RoshanRewardListRow = props => {
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    className: "RoshanRewardListRow",
    get children() {
      return libs.createComponent(libs.Index, {
        get each() {
          return props.list;
        },
        children: (key, i) => {
          const rewardData = libs.createMemo(() => {
            return roshanReward()[key()];
          });
          const rarity = libs.createMemo(() => {
            if (rewardData().ability != undefined) {
              return Object.values(rewardData().ability).reduce((prev, cur) => {
                let curRarity = KeyValues.AbilityUpgradesKv[cur].rarity ?? "n";
                if (prev == "n") {
                  return curRarity;
                }
                if (prev == "r" && curRarity != "n") {
                  return curRarity;
                }
                return prev;
              }, "n");
            }
            return "n";
          });
          const selectedPlayerID = libs.createMemo(() => {
            if (roshanSelectionInfo() != undefined && roshanSelectionInfo()?.player_selection) {
              let selectedID = -1;
              const data = roshanSelectionInfo()?.player_selection;
              for (const k in data) {
                const v = data[k];
                if (v == key()) {
                  selectedID = Number(k);
                  break;
                }
              }
              if (selectedID != -1) {
                return selectedID;
              }
            }
          });
          const abilityList = libs.createMemo(() => {
            let abilities = rewardData().ability;
            if (abilities != undefined) {
              return Object.values(rewardData().ability);
            }
          });
          const isMaxList = libs.createMemo(() => {
            const sect_data = props.sectData;
            let list = [];
            if (sect_data && abilityList()) {
              let cached = {};
              abilityList()?.forEach((aid, index) => {
                let maxLv = KeyValues.AbilityUpgradesKv[aid]?.MaxLevel ?? 0;
                let lv = cached[aid];
                if (cached[aid] == undefined) {
                  lv = sect_data[aid]?.level ?? 0;
                }
                if (lv >= maxLv) {
                  list.push(index);
                } else {
                  lv++;
                }
                cached[aid] = lv;
              });
            }
            return list;
          });
          return libs.createComponent(EOM_Button.EOM_BaseButton, {
            get className() {
              return libs.classNames("RoshanRewardButton", "Rarity_" + rarity(), {
                GoldReward: rewardData().gold != undefined,
                Selected: selectedPlayerID() != undefined
              });
            },
            get enabled() {
              return libs.memo(() => !!props.canPick)() && selectedPlayerID() == undefined;
            },
            onactivate: () => {
              props.onSelect(key());
            },
            get children() {
              return [libs.createComponent(libs.Show, {
                get when() {
                  return selectedPlayerID() != undefined;
                },
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "RoshanPlayerInfo",
                    get children() {
                      return libs.createComponent(Player.PlayerAvatar, {
                        get steamID() {
                          return getPlayerData(selectedPlayerID(), "steamID");
                        },
                        get playerID() {
                          return selectedPlayerID();
                        }
                      });
                    }
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "RoshanRewardButtonMain",
                get children() {
                  return libs.createComponent(libs.Switch, {
                    get children() {
                      return [libs.createComponent(libs.Match, {
                        get when() {
                          return rewardData().gold != undefined;
                        },
                        get children() {
                          return libs.createComponent(EOM_Panel.EOM_Panel, {
                            id: "RewardGold",
                            get children() {
                              return [libs.createComponent(EOM_Icon.EOM_Icon, {
                                size: "24",
                                get src() {
                                  return getSrcPath("icon/icon_gold_bevel_psd.png");
                                }
                              }), libs.createComponent(EOM_Label.EOM_Label, {
                                get text() {
                                  return `${rewardData().gold}${$.Localize("#1100001")}`;
                                }
                              })];
                            }
                          });
                        }
                      }), libs.createComponent(libs.Match, {
                        get when() {
                          return abilityList() != undefined;
                        },
                        get children() {
                          return libs.createComponent(EOM_Panel.EOM_Panel, {
                            id: "RewardAbilityList",
                            get customTooltip() {
                              return libs.memo(() => !!isSpectator())() ? undefined : {
                                name: "roshan_reward",
                                ability_list: JSON.stringify(abilityList()),
                                playerID: Players.GetLocalPlayer()
                              };
                            },
                            get children() {
                              return libs.createComponent(libs.Index, {
                                get each() {
                                  return abilityList();
                                },
                                children: (abilityID, index) => {
                                  const sects = () => {
                                    if (KeyValues.AbilityUpgradesKv[abilityID()] && KeyValues.AbilityUpgradesKv[abilityID()].sect) {
                                      return KeyValues.AbilityUpgradesKv[abilityID()].sect.split("|");
                                    }
                                    return [];
                                  };
                                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                                    get className() {
                                      return libs.classNames("RewardAbility", "" + KeyValues.AbilityUpgradesKv[abilityID()]?.rarity, {
                                        isMaxLv: isMaxList().includes(index)
                                      });
                                    },
                                    get customTooltip() {
                                      return libs.memo(() => !!!isSpectator())() ? undefined : {
                                        name: "sect_ability",
                                        abilityUpgradeID: abilityID()
                                      };
                                    },
                                    get children() {
                                      return [libs.createComponent(SectAbility.SectAbilityImage, {
                                        get sectAbilityID() {
                                          return abilityID();
                                        }
                                      }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                        id: "SectContainer",
                                        get children() {
                                          return libs.createComponent(libs.Index, {
                                            get each() {
                                              return sects();
                                            },
                                            children: (sectName, i) => {
                                              return libs.createComponent(SectIcon.SectIcon, {
                                                get sectName() {
                                                  return sectName();
                                                }
                                              });
                                            }
                                          });
                                        }
                                      }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                        id: "RewardAbilityMax"
                                      })];
                                    }
                                  });
                                }
                              });
                            }
                          });
                        }
                      })];
                    }
                  });
                }
              }), libs.createComponent(EOM_Icon.EOM_Icon, {
                hittest: false,
                get visible() {
                  return selectedPlayerID() != undefined;
                },
                align: "center bottom",
                get src() {
                  return getSrcPath("icon/selected.png");
                },
                width: "50px",
                height: "46px"
              })];
            }
          });
        }
      });
    }
  });
};
const EliminatorBottom = () => {
  const [showInfo, setShowInfo] = libs.createSignal("");
  const getRegameAmounts = () => {
    let c = 0;
    const data = CustomNetTables.GetAllTableValues("player_data");
    if (data) {
      Object.values(data).forEach(v => {
        if (v.value.regame_state == 1) {
          c++;
        }
      });
    }
    return c;
  };
  const [regameAmounts, setRegameAmounts] = libs.createSignal(getRegameAmounts());
  const [matchPlayerAmounts, setMatchPlayerAmounts] = libs.createSignal(8);
  const restartGameText = () => {
    return $.Localize("#EndScreen_RestartGame") + `(<font color='#6cd4b1'>${regameAmounts()}</font>/${Math.max(1, Math.floor(matchPlayerAmounts() / 2))})`;
  };
  libs.onMount(() => {
    const GameEventListenerIDs = [];
    const NetTableListenerIDs = [];
    NetTableListenerIDs.push(CustomNetTables.SubscribeNetTableListener("player_data", (_, playerID, data) => {
      setRegameAmounts(getRegameAmounts());
    }));
    NetTableListenerIDs.push(useNetTableKeyHasDefaultValue("common", "match_player_amounts", data => {
      setMatchPlayerAmounts(data?.count ?? 8);
    }));
    libs.onCleanup(() => {
      GameEventListenerIDs.forEach(id => GameEvents.Unsubscribe(id));
      NetTableListenerIDs.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    });
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "ContactInformation",
    get children() {
      return [libs.createComponent(libs.Show, {
        get when() {
          return $.Language().toLowerCase() == "schinese";
        },
        fallback: () => libs.createComponent(EOM_Panel.EOM_Panel, {
          className: "ContactInformationButton",
          hittest: false,
          get children() {
            return [libs.createComponent(EOM_Button.EOM_BaseButton, {
              id: "ContactButton",
              onactivate: () => setShowInfo(v => v == "discord" ? "" : "discord"),
              get children() {
                return libs.createComponent(EOM_Panel.EOM_Panel, {
                  get className() {
                    return libs.classNames("ContactUSIcon", "discord");
                  }
                });
              }
            }), libs.createComponent(EOM_Panel.EOM_Panel, {
              get className() {
                return libs.classNames("ContactUSInfo", {
                  Show: showInfo() == "discord"
                });
              },
              get children() {
                return (() => {
                  let url = $.Localize("#ContactUSDiscord");
                  if (url != "#ContactUSDiscord") {
                    return libs.createComponent(EOM_Button.EOM_BaseButton, {
                      horizontalAlign: "center",
                      flowChildren: "down",
                      onactivate: () => $.DispatchEvent("ExternalBrowserGoToURL", url),
                      get children() {
                        return [libs.createComponent(EOM_QRCode.EOM_QRCode, {
                          align: "center center",
                          value: url,
                          qrcodesize: 200
                        }), libs.createComponent(EOM_Label.EOM_Label, {
                          horizontalAlign: "center",
                          marginTop: "15px",
                          fontSize: "18px",
                          color: "#fff",
                          textDecoration: "underline",
                          text: "#EndScreen_DiscordContact"
                        })];
                      }
                    });
                  }
                })();
              }
            })];
          }
        }),
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "ContactInformationButton",
            hittest: false,
            get children() {
              return [libs.createComponent(EOM_Button.EOM_BaseButton, {
                id: "ContactButton",
                onactivate: () => setShowInfo(v => v == "wx" ? "" : "wx"),
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("ContactUSIcon", "wx");
                    }
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("ContactUSInfo", {
                    Show: showInfo() == "wx"
                  });
                },
                get children() {
                  return [libs.createComponent(EOM_Label.EOM_Label, {
                    align: "center center",
                    marginBottom: "20px",
                    horizontalAlign: "center",
                    color: "#ffffff",
                    text: "#EndScreen_WeChatContact"
                  }), libs.createComponent(EOM_Image.EOM_Image, {
                    width: "200px",
                    height: "200px",
                    get backgroundImage() {
                      return getImagePath("hud/wechat_official.png");
                    }
                  })];
                }
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "ContactInformationButton",
            hittest: false,
            get children() {
              return [libs.createComponent(EOM_Button.EOM_BaseButton, {
                id: "ContactButton",
                onactivate: () => setShowInfo(v => v == "qq" ? "" : "qq"),
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("ContactUSIcon", "qq");
                    }
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("ContactUSInfo", {
                    Show: showInfo() == "qq"
                  });
                },
                get children() {
                  return [libs.createComponent(EOM_Label.EOM_Label, {
                    horizontalAlign: "center",
                    marginBottom: "10px",
                    color: "#ffffff",
                    text: "#EndScreen_QqContact"
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    marginTop: "20px",
                    flowChildren: "right",
                    get children() {
                      return [...Array(2)].map((_, index) => {
                        let i = index + 1;
                        return libs.createComponent(EOM_Button.EOM_BaseButton, {
                          margin: "0px 10px",
                          flowChildren: "down",
                          horizontalAlign: "center",
                          onactivate: () => {
                            const text = $.Localize("#ContactUSInfoQQ" + i + "_address");
                            if (text != "#ContactUSInfoQQ" + i + "_address") {
                              $.DispatchEvent("ExternalBrowserGoToURL", text);
                            }
                          },
                          get children() {
                            return [libs.createComponent(EOM_Image.EOM_Image, {
                              width: "200px",
                              height: "200px",
                              get backgroundImage() {
                                return getImagePath("hud/qq_qrcode_" + i + ".png");
                              }
                            }), libs.createComponent(EOM_Label.EOM_Label, {
                              horizontalAlign: "center",
                              marginTop: "5px",
                              fontSize: "18px",
                              color: "#fff",
                              textDecoration: "underline",
                              text: "#ContactUSInfoQQ" + i
                            })];
                          }
                        });
                      });
                    }
                  })];
                }
              })];
            }
          })];
        }
      }), libs.createComponent(EOM_Button.EOM_BaseButton, {
        verticalAlign: "bottom",
        onload: self => {},
        onactivate: self => {
          showPopup("Feedback", {});
        },
        get children() {
          return [libs.createElement("Image", {
            id: "ContactButtonBG"
          }, null), libs.createElement("Image", {
            id: "FeedbackIcon",
            "class": "ActionImage"
          }, null), libs.createComponent(GenericPanel.CLabel, {
            id: "FeedbackLabel",
            text: "#Feedback_Title"
          })];
        }
      }), libs.createComponent(EOM_Button.EOM_BaseButton, {
        verticalAlign: "bottom",
        onload: self => {},
        onactivate: self => {
          if (localPlayerData()?.regame_state != 1) {
            GameEvents.SendCustomEventToServer("regame_request", {});
          }
        },
        get children() {
          return [libs.createElement("Image", {
            id: "ContactButtonBG"
          }, null), libs.createElement("Image", {
            id: "RegameCheckIcon",
            "class": "ActionImage"
          }, null), libs.createComponent(GenericPanel.CLabel, {
            id: "RegameCheckLabel",
            get text() {
              return restartGameText();
            },
            html: true
          })];
        }
      })];
    }
  });
};

const dataSum = damageList => {
  let total = 0;
  for (const damageType in damageList) {
    if (damageType != "count") {
      total += damageList[damageType];
    }
  }
  return total;
};
const useDamageRankNew = () => {
  const localPlayerID = Players.GetLocalPlayer();
  let defaultwatchInfo = {
    player_id: getPlayerData(localPlayerID, "viewPlayerInfo")?.player_id ?? localPlayerID,
    is_illusion: getPlayerData(localPlayerID, "viewPlayerInfo")?.is_illusion ?? 0
  };
  if (isSpectator()) {
    defaultwatchInfo = {
      player_id: GameUI.GetSpectatorViewingInfo().player_id,
      is_illusion: GameUI.GetSpectatorViewingInfo().illusion ? 1 : 0
    };
    libs.createEffect(() => {
      setWatchingPlayerInfo({
        player_id: GameUI.GetSpectatorViewingInfo().player_id,
        is_illusion: GameUI.GetSpectatorViewingInfo().illusion ? 1 : 0
      });
    });
  }
  const [watchingPlayerInfo, setWatchingPlayerInfo] = libs.createStore(defaultwatchInfo);
  const [tabIndex, setTabIndex] = libs.createSignal(0);
  const [newBattleInfo, setNewBattleInfo] = libs.createSignal(CustomNetTables.GetTableValue("common", "new_battle_info"));
  const battleInfo = libs.createMemo(() => {
    let selfEnt = -1;
    let enemyEnt = -1;
    const current_newBattleInfo = newBattleInfo();
    const viewingPlayerID = watchingPlayerInfo.player_id;
    const viewingIllusion = watchingPlayerInfo.is_illusion == 1;
    const viewingKey = (viewingIllusion ? "I" : "P") + "_" + viewingPlayerID.toString();
    let enemyKey = "";
    if (current_newBattleInfo) {
      const viewInfo = current_newBattleInfo[viewingKey];
      if (viewInfo) {
        selfEnt = viewInfo.index;
        enemyKey = viewInfo.enemy_key;
      }
      const enemyInfo = enemyKey == "" ? undefined : current_newBattleInfo[enemyKey];
      if (enemyInfo) {
        enemyEnt = enemyInfo.index;
      }
    }
    return {
      selfEnt,
      enemyEnt
    };
  });
  libs.onMount(() => {
    const listenerIDList = [];
    listenerIDList.push(useNetTableKey("common", "new_battle_info", data => {
      setNewBattleInfo(data);
    }));
    if (!isSpectator()) {
      listenerIDList.push(CustomNetTables.SubscribeNetTableListener("player_data", (tableName, key, playerData) => {
        if (key == String(localPlayerID)) {
          if (playerData.viewPlayerInfo) {
            libs.batch(() => {
              setWatchingPlayerInfo("player_id", playerData.viewPlayerInfo.player_id);
              setWatchingPlayerInfo("is_illusion", playerData.viewPlayerInfo.is_illusion);
            });
          }
        }
      }));
    }
    libs.onCleanup(() => {
      listenerIDList.forEach(id => {
        CustomNetTables.UnsubscribeNetTableListener(id);
      });
    });
  });
  return {
    tabIndex,
    setTabIndex,
    battleInfo
  };
};
const DamageRank = props => {
  const {
    battleInfo,
    tabIndex,
    setTabIndex
  } = useDamageRankNew();
  const title_list = ["#DamageRank_Tab_applydamage", "#DamageRank_Tab_takedamage", "#DamageRank_Tab_selfheal", "#DamageRank_Tab_enemyheal"];
  const DamageTitle = () => title_list[Clamp(tabIndex(), 0, title_list.length)];
  return (() => {
    const _el$ = libs.createElement("Panel", {
      id: "DamageRank",
      hittest: false
    }, null);
    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
      id: "DamageRankTitle",
      get children() {
        return libs.createComponent(EOM_Label.EOM_Label, {
          get text() {
            return DamageTitle();
          }
        });
      }
    }), null);
    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
      id: "BattleStatsButtons",
      hittest: false,
      get children() {
        return [libs.createComponent(EOM_Button.EOM_BaseButton, {
          get className() {
            return libs.classNames("BattleStatsButton", "Damage", "Self");
          },
          get enabled() {
            return tabIndex() != 0;
          },
          onactivate: () => {
            setTabIndex(0);
          },
          get children() {
            return libs.createComponent(EOM_Icon.EOM_Icon, {});
          }
        }), libs.createComponent(EOM_Button.EOM_BaseButton, {
          get className() {
            return libs.classNames("BattleStatsButton", "Damage", "Enemy");
          },
          get enabled() {
            return tabIndex() != 1;
          },
          onactivate: () => {
            setTabIndex(1);
          },
          get children() {
            return libs.createComponent(EOM_Icon.EOM_Icon, {});
          }
        }), libs.createComponent(EOM_Button.EOM_BaseButton, {
          get className() {
            return libs.classNames("BattleStatsButton", "Heal", "Self");
          },
          get enabled() {
            return tabIndex() != 2;
          },
          onactivate: () => {
            setTabIndex(2);
          },
          get children() {
            return libs.createComponent(EOM_Icon.EOM_Icon, {});
          }
        }), libs.createComponent(EOM_Button.EOM_BaseButton, {
          get className() {
            return libs.classNames("BattleStatsButton", "Heal", "Enemy");
          },
          get enabled() {
            return tabIndex() != 3;
          },
          onactivate: () => {
            setTabIndex(3);
          },
          get children() {
            return libs.createComponent(EOM_Icon.EOM_Icon, {});
          }
        })];
      }
    }), null);
    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
      id: "DataListContainer",
      get children() {
        return [libs.createComponent(DataList, {
          get entIndex() {
            return battleInfo().selfEnt;
          },
          get show() {
            return tabIndex() == 0;
          },
          type: "damage"
        }), libs.createComponent(DataList, {
          get entIndex() {
            return battleInfo().enemyEnt;
          },
          get show() {
            return tabIndex() == 1;
          },
          type: "damage"
        }), libs.createComponent(DataList, {
          get entIndex() {
            return battleInfo().selfEnt;
          },
          get show() {
            return tabIndex() == 2;
          },
          type: "regen"
        }), libs.createComponent(DataList, {
          get entIndex() {
            return battleInfo().enemyEnt;
          },
          get show() {
            return tabIndex() == 3;
          },
          type: "regen"
        })];
      }
    }), null);
    libs.effect(_$p => libs.setProp(_el$, "classList", {
      HideList: props.game_state == "GameState_GreevilEgg"
    }, _$p));
    return _el$;
  })();
};
const DataList = props => {
  const [local, others] = libs.splitProps(props, ["entIndex", "show", "type"]);
  const [battleData, setBattleData] = libs.createSignal({});
  const abilityNameList = () => {
    if (!battleData()) {
      return [];
    } else {
      let list = Object.keys(battleData());
      list.sort((a, b) => {
        return dataSum(battleData()[b]) - dataSum(battleData()[a]);
      });
      return list;
    }
  };
  const [maxData, setMaxData] = libs.createSignal(0);
  const [allData, setAllData] = libs.createSignal(0);
  libs.onMount(() => {
    const timer = setInterval(() => {
      const battleData = CustomNetTables.GetTableValue("battle_record", String(local.entIndex));
      if (battleData) {
        let maxData = 0;
        let allData = 0;
        for (const abilityName in battleData[props.type]) {
          maxData = Math.max(Round(dataSum(battleData[props.type][abilityName])), maxData);
          allData += Round(dataSum(battleData[props.type][abilityName]));
        }
        libs.batch(() => {
          setBattleData(battleData[props.type]);
          setMaxData(maxData);
          setAllData(allData);
        });
      }
    }, 50);
    libs.onCleanup(() => {
      clearInterval(timer);
    });
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    get className() {
      return libs.classNames("DetailData", {
        Show: local.show
      });
    },
    flowChildren: "down",
    scroll: "y",
    get children() {
      return libs.createComponent(libs.Show, {
        get when() {
          return local.show;
        },
        get children() {
          return libs.createComponent(libs.Index, {
            get each() {
              return abilityNameList();
            },
            children: (abilityName, index) => {
              return libs.createComponent(DataRow, {
                get abilityName() {
                  return abilityName();
                },
                get damage() {
                  return battleData()[abilityName()];
                },
                get maxDamage() {
                  return maxData();
                },
                get allDamage() {
                  return allData();
                },
                get type() {
                  return props.type;
                }
              });
            }
          });
        }
      });
    }
  });
};
const DataRow = props => {
  const getAbilityInfo = () => {
    let name = props.abilityName;
    const splits = name.split("@");
    name = splits?.[1] ?? "";
    const color = splits?.[2] == "true" ? "#ff0000" : "#ffffff";
    return {
      name,
      color
    };
  };
  let abilityInfo = libs.createMemo(() => getAbilityInfo());
  const abilityUpgradeInfo = libs.createMemo(() => GameUI.CustomUIConfig().AbilityUpgradesKv[abilityInfo().name]);
  const abilityKV = libs.createMemo(() => GameUI.CustomUIConfig().AbilitiesKv[abilityInfo().name]);
  const isAttack = libs.createMemo(() => props.abilityName.indexOf("Attack@") != -1);
  const isAbility = libs.createMemo(() => props.abilityName.indexOf("Ability@") != -1);
  const isSect = libs.createMemo(() => props.abilityName.indexOf("Sect@") != -1);
  const isAbilityUpgrade = libs.createMemo(() => props.abilityName.indexOf("AbilityUpgrade@") != -1);
  const isTalent = libs.createMemo(() => (abilityKV()?.CustomAbilityType ?? "") == "ABILITY_TYPE_TALENT");
  const getImageType = () => {
    if (isTalent()) {
      return "Talent";
    } else if (isAttack()) {
      return "Attack";
    } else if (isAbility()) {
      return "Ability";
    } else if (isSect()) {
      return "Sect";
    } else if (isAbilityUpgrade()) {
      return "AbilityUpgrade";
    }
    return "Ability";
  };
  let imageType = libs.createMemo(() => getImageType());
  let tooltip = libs.createMemo(() => {
    if (isTalent()) {
      if ($.Localize("#DOTA_Tooltip_ability_" + abilityInfo().name) == "#DOTA_Tooltip_ability_" + abilityInfo().name) {
        const kv = KeyValues.HeroTalentKv[abilityInfo().name];
        let requireLevel = finiteNumber(Number(kv?.RequiredLevel), -1);
        if (requireLevel > 0) {
          return $.Localize("#CombatLog_TalentLabel").replace("${level}", requireLevel.toString());
        }
      } else {
        return "#DOTA_Tooltip_ability_" + abilityInfo().name;
      }
    } else if (isAbilityUpgrade()) {
      return "#DOTA_Tooltip_ability_mechanics_" + abilityInfo().name;
    }
    return "#DOTA_Tooltip_ability_" + abilityInfo().name;
  });
  const damage = libs.createMemo(() => Round(dataSum(props.damage)));
  const damageList = () => Object.keys(props.damage);
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    className: "DataRow",
    width: "100%",
    marginRight: "10px",
    get tooltip() {
      return tooltip();
    },
    marginBottom: "2px",
    get children() {
      return [libs.createComponent(libs.Dynamic, {
        get component() {
          return {
            Attack: () => (() => {
              const _el$2 = libs.createElement("Image", {
                src: `file://{images}/spellicons/attr_damage.png`
              }, null);
              libs.setProp(_el$2, "className", "RecordImage");
              libs.setProp(_el$2, "src", `file://{images}/spellicons/attr_damage.png`);
              return _el$2;
            })(),
            Ability: () => (() => {
              const _el$3 = libs.createElement("DOTAAbilityImage", {
                get abilityname() {
                  return abilityInfo().name;
                }
              }, null);
              libs.setProp(_el$3, "className", "RecordImage");
              libs.effect(_$p => libs.setProp(_el$3, "abilityname", abilityInfo().name, _$p));
              return _el$3;
            })(),
            Talent: () => (() => {
              const _el$4 = libs.createElement("DOTAAbilityImage", {
                abilityname: "attribute_bonus"
              }, null);
              libs.setProp(_el$4, "className", "RecordImage");
              return _el$4;
            })(),
            Sect: () => (() => {
              const _el$5 = libs.createElement("DOTAAbilityImage", {
                get abilityname() {
                  return abilityInfo().name;
                }
              }, null);
              libs.setProp(_el$5, "className", "RecordImage");
              libs.effect(_$p => libs.setProp(_el$5, "abilityname", abilityInfo().name, _$p));
              return _el$5;
            })(),
            AbilityUpgrade: () => libs.createComponent(GenericPanel.CImage, {
              className: "RecordImage",
              get src() {
                return `file://{images}/spellicons/${abilityUpgradeInfo().Texture}.png`;
              }
            })
          }[imageType()];
        }
      }), libs.createComponent(GenericPanel.CLabel, {
        className: "RecordName",
        html: true,
        get text() {
          return `<font color='${abilityInfo().color}'>${$.Localize(tooltip())}</font> × ${props.damage.count}`;
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        className: "ProgressContainer",
        get children() {
          return libs.createComponent(libs.For, {
            get each() {
              return damageList();
            },
            children: (damageType, index) => {
              if (damageType != "count") {
                const damageWithType = () => props.damage[damageType];
                if (props.type == "regen") {
                  return libs.createComponent(EOM_Icon.EOM_Icon, {
                    get className() {
                      return libs.classNames("RecordProgress", "regen", {
                        Start: index() == 0,
                        End: index() == damageList().length - 2
                      });
                    },
                    get width() {
                      return damageWithType() / Math.max(props.maxDamage, 1) * 100 + "%";
                    }
                  });
                } else {
                  return libs.createComponent(EOM_Icon.EOM_Icon, {
                    get className() {
                      return libs.classNames("RecordProgress", "damageType" + damageType, {
                        Start: index() == 0,
                        End: index() == damageList().length - 2
                      });
                    },
                    get width() {
                      return damageWithType() / Math.max(props.maxDamage, 1) * 100 + "%";
                    }
                  });
                }
              }
            }
          });
        }
      }), libs.createComponent(GenericPanel.CLabel, {
        className: "RecordDamagevalue",
        get text() {
          return damage() + " (" + Round(damage() / Math.max(props.allDamage, 1) * 100) + "%)";
        }
      })];
    }
  });
};

const FinalVS = () => {
  const groupInfo = (() => {
    let data = [];
    for (let i = 0; i < 4; i++) {
      const groupData = CustomNetTables.GetTableValue("common", "group_team_" + i);
      if (groupData?.rank == -1) {
        data.push({
          players: Object.values(groupData.players),
          group_index: i,
          health: groupData.health
        });
      }
    }
    data.sort((a, b) => b.health - a.health);
    return data;
  })();
  const playerList = (() => {
    let list = [];
    if (groupInfo) {
      groupInfo.forEach(v => {
        list = list.concat(v.players);
      });
    }
    return list;
  })();
  return (() => {
    const _el$ = libs.createElement("Panel", {
        id: "FinalVS"
      }, null);
      libs.createElement("Panel", {
        id: "FinalVSBG"
      }, _el$);
      const _el$3 = libs.createElement("Panel", {
        id: "FinalVSTitle"
      }, _el$);
      libs.createElement("Label", {
        text: "#GameState_FinalVS"
      }, _el$3);
      libs.createElement("Panel", {
        id: "FinalVSGraphicLeft"
      }, _el$);
      libs.createElement("Panel", {
        id: "FinalVSGraphicMid"
      }, _el$);
      libs.createElement("Panel", {
        id: "FinalVSGraphicRight"
      }, _el$);
      libs.createElement("Panel", {
        id: "FinalVSLogo"
      }, _el$);
      libs.createElement("Panel", {
        id: "FinalGlassLeft"
      }, _el$);
      libs.createElement("Panel", {
        id: "FinalGlassRight"
      }, _el$);
      const _el$1 = libs.createElement("Panel", {
        id: "FinalVSHeros",
        hittest: false
      }, _el$);
    libs.insert(_el$1, () => playerList.map((playerID, index) => {
      const portraitUnit = () => {
        let unit = "";
        const heroName = getPlayerData(playerID, "heroName");
        const cosmetic_data = getServiceNetTable("player_equipped_ornament", playerID)?.[OrnamentType.HERO_SKIN];
        if (cosmetic_data) {
          let hid;
          for (const oid in cosmetic_data) {
            hid = KeyValues.CosmeticsKv[oid]?.hero;
            if (typeof hid == "number" && GetHeroNameByGoodID(hid) == heroName) {
              unit = oid.toString();
              break;
            }
          }
        }
        if (unit == "") {
          unit = heroName;
        }
        return unit;
      };
      if (index >= 2) {
        index = Math.floor(index / 2) + (2 - index % 2);
      }
      return (() => {
        const _el$10 = libs.createElement("Panel", {}, null),
          _el$11 = libs.createElement("Panel", {
            id: "FinalVSPlayerName"
          }, _el$10);
        libs.insert(_el$10, libs.createComponent(EOM_PortraitFullBody.EOM_PortraitFullBody, {
          id: "FinalVSHeroPortrait",
          showPedestal: false,
          allowrotation: false,
          get unitname() {
            return portraitUnit();
          }
        }), _el$11);
        libs.insert(_el$11, libs.createComponent(Player.PlayerName, {
          playerID: playerID,
          get steamID() {
            return getPlayerData(playerID, "steamID");
          },
          get ban() {
            return isNameBan(playerID);
          }
        }));
        libs.effect(_$p => libs.setProp(_el$10, "className", libs.classNames("FinalVSHeroInfo", `Index_${index}`), _$p));
        return _el$10;
      })();
    }));
    return _el$;
  })();
};

const GreevilEggSelect = props => {
  const [showSelect, setShowSelect] = libs.createSignal(false);
  const [taskConfig, setTaskConfig] = libs.createSignal({});
  libs.onMount(() => {
    const netTableIDList = [];
    netTableIDList.push(useSyncDataKey("common", "greevil_selection", data => {
      let list = data?.list ?? [];
      setShowSelect(list.includes(Players.GetLocalPlayer()));
    }));
    netTableIDList.push(useNetTableKeyHasDefaultValue("common", "greevil_setting", data => {
      setTaskConfig(data?.GREEVIL_EGG_TASK_CONFIG ?? {});
    }));
  });
  const eggOptions = libs.createMemo(() => {
    const eggKV = KeyValues.GreevilEggKV ?? {};
    const config = taskConfig();
    const names = Object.keys(eggKV).sort();
    return names.map(name => {
      const values = eggKV[name]?.AbilityValues ?? {};
      let str = $.Localize('#DOTA_Tooltip_ability_' + name + '_description');
      str = replaceInfo(str);
      str = replaceKeyword(str);
      str = replaceAbility(str);
      str = replaceBuffEnum(str);
      str = replaceAbilityValues(str);
      str = getKeyValueDescription(values, str, {
        onlyShowNowLevel: true
      });
      const task = config[name];
      let taskText = '';
      if (task) {
        const tokenKey = `#Greevil_Egg_Task_${task.type}`;
        const raw = $.Localize(tokenKey);
        taskText = raw.replace('%d', String(task.target));
      }
      return {
        name,
        UISKin: eggKV[name]?.UISkin ?? 0,
        titleToken: `#DOTA_Tooltip_ability_${name}`,
        descToken: str,
        taskText
      };
    }).filter(v => v != undefined);
  });
  const pickEggType = name => {
    GameEvents.SendCustomEventToServer("select_greevil_egg_type", {
      name: name
    });
  };
  libs.createEffect(libs.on(showSelect, v => {
    if (v) {
      $.Schedule(0.8, () => {
      });
    }
  }));
  return libs.createComponent(libs.Show, {
    get when() {
      return showSelect();
    },
    get children() {
      const _el$ = libs.createElement("Panel", {
          "class": "GreevilEggSelect",
          hittest: false
        }, null),
        _el$2 = libs.createElement("Panel", {
          id: "GreevilTypeMain",
          hittest: false
        }, _el$);
      libs.insert(_el$2, libs.createComponent(libs.For, {
        get each() {
          return eggOptions();
        },
        children: option => {
          return libs.createComponent(EOM_Button.EOM_BaseButton, {
            get className() {
              return libs.classNames("GreevilOption");
            },
            onactivate: () => pickEggType(option.name),
            get children() {
              return [(() => {
                const _el$3 = libs.createElement("DOTAParticleScenePanel", {
                  id: "GreevilEggBG",
                  particleName: "particles/eom/ui/ui_fx/greed_demon/ui_game_greed_demon_mouse_model.vpcf",
                  lookAt: "0 0 0",
                  cameraOrigin: "250 0 0",
                  fov: 20,
                  squarePixels: true,
                  particleonly: true,
                  hittest: false
                }, null);
                libs.setProp(_el$3, "onload", self => {
                  self.SetControlPoint(10, option.UISKin, 0, 0);
                });
                return _el$3;
              })(), (() => {
                const _el$4 = libs.createElement("DOTAParticleScenePanel", {
                  id: "GreevilEggAmbient",
                  particleName: "particles/eom/ui/ui_fx/greed_demon/ui_game_greed_demon_mouse.vpcf",
                  lookAt: "0 0 0",
                  cameraOrigin: "250 0 0",
                  fov: 20,
                  squarePixels: true,
                  hittest: false
                }, null);
                libs.setProp(_el$4, "onload", self => {
                  self.SetControlPoint(10, option.UISKin, 0, 0);
                });
                return _el$4;
              })(), (() => {
                const _el$5 = libs.createElement("Panel", {
                  id: "GreevilOptionMain"
                }, null);
                libs.insert(_el$5, libs.createComponent(EOM_Label.EOM_Label, {
                  className: "OptionDesc",
                  get text() {
                    return option.descToken;
                  },
                  html: true
                }), null);
                libs.insert(_el$5, libs.createComponent(libs.Show, {
                  get when() {
                    return option.taskText !== '';
                  },
                  get children() {
                    return libs.createComponent(EOM_Label.EOM_Label, {
                      className: "OptionTaskText",
                      get text() {
                        return option.taskText;
                      },
                      html: true
                    });
                  }
                }), null);
                return _el$5;
              })(), libs.createElement("DOTAParticleScenePanel", {
                id: "GreevilEggFlash",
                hittest: false,
                particleName: "particles/eom/ui/ui_fx/greed_demon/ui_game_greed_demon_gray_mouse_open_fx.vpcf",
                lookAt: "0 0 0",
                cameraOrigin: "250 0 0",
                fov: 20,
                squarePixels: true
              }, null)];
            }
          });
        }
      }));
      return _el$;
    }
  });
};

const useHeathBarContainerNew = () => {
  const localPlayerID = Players.GetLocalPlayer();
  const [game_state, setGameState] = libs.createSignal(getGameState());
  let defaultWatchingInfo = {
    player_id: getPlayerData(localPlayerID, "viewPlayerInfo")?.player_id ?? localPlayerID,
    is_illusion: getPlayerData(localPlayerID, "viewPlayerInfo")?.is_illusion ?? 0
  };
  if (isSpectator()) {
    defaultWatchingInfo = {
      player_id: GameUI.GetSpectatorViewingInfo().player_id,
      is_illusion: GameUI.GetSpectatorViewingInfo().illusion ? 1 : 0
    };
  }
  const [allyPlayers, setAllyPlayers] = libs.createSignal([Players.GetLocalPlayer()]);
  if (isGroupMode()) {
    netdata_utils.createNetTableEffect("player_data", String(Players.GetLocalPlayer()), data => {
      setAllyPlayers(Object.values(data.teammates ?? {}));
    });
  }
  const [watchingPlayerInfo, setWatchingPlayerInfo] = libs.createStore(defaultWatchingInfo);
  const [newBattleInfo, setNewBattleInfo] = libs.createSignal(CustomNetTables.GetTableValue("common", "new_battle_info"));
  const battleFieldInfo = libs.createMemo(() => {
    let mainEnt = -1;
    let mainID = -1;
    let customEnt = -1;
    let customID = -1;
    let isReverse = false;
    const current_newBattleInfo = newBattleInfo();
    const viewingPlayerID = watchingPlayerInfo.player_id;
    const viewingIllusion = watchingPlayerInfo.is_illusion == 1;
    const viewingKey = (viewingIllusion ? "I" : "P") + "_" + viewingPlayerID.toString();
    let enemyKey = "";
    if (current_newBattleInfo) {
      const viewInfo = current_newBattleInfo[viewingKey];
      if (viewInfo) {
        if (viewInfo.type == "main") {
          mainEnt = viewInfo.index;
          mainID = viewInfo.id;
        } else {
          customEnt = viewInfo.index;
          customID = viewInfo.id;
        }
        enemyKey = viewInfo.enemy_key;
      }
      const enemyInfo = enemyKey == "" ? undefined : current_newBattleInfo[enemyKey];
      if (enemyInfo) {
        if (enemyInfo.type == "main") {
          mainEnt = enemyInfo.index;
          mainID = enemyInfo.id;
        } else {
          customEnt = enemyInfo.index;
          customID = enemyInfo.id;
        }
      }
    }
    if (allyPlayers().includes(customID) && !(enemyKey.includes("I_") || viewingKey.includes("I_")) && !enemyKey.includes("N_")) {
      isReverse = true;
    }
    return {
      customEnt,
      customID,
      mainEnt,
      mainID,
      isReverse
    };
  });
  if (isSpectator()) {
    libs.createEffect(() => {
      let info = GameUI.GetSpectatorViewingInfo();
      if (info) {
        libs.batch(() => {
          setWatchingPlayerInfo("player_id", info.player_id);
          setWatchingPlayerInfo("is_illusion", info.illusion ? 1 : 0);
        });
      }
    });
  }
  libs.onMount(() => {
    const listenerIDList = [];
    listenerIDList.push(useNetTableKey("common", "game_state", data => {
      setGameState(data?.state ?? "GameState_None");
    }));
    listenerIDList.push(useNetTableKey("common", "new_battle_info", data => {
      setNewBattleInfo(data);
    }));
    if (!isSpectator()) {
      listenerIDList.push(CustomNetTables.SubscribeNetTableListener("player_data", (tableName, key, playerData) => {
        if (key == String(localPlayerID)) {
          if (playerData.viewPlayerInfo) {
            libs.batch(() => {
              setWatchingPlayerInfo("player_id", playerData.viewPlayerInfo.player_id);
              setWatchingPlayerInfo("is_illusion", playerData.viewPlayerInfo.is_illusion);
            });
          }
        }
      }));
    }
    libs.onCleanup(() => {
      listenerIDList.forEach(id => {
        CustomNetTables.UnsubscribeNetTableListener(id);
      });
    });
  });
  return {
    game_state,
    battleFieldInfo,
    allyPlayers
  };
};
const HealthBarContainer = () => {
  const {
    game_state,
    battleFieldInfo,
    allyPlayers
  } = useHeathBarContainerNew();
  const show = () => game_state() == "GameState_Battle" || game_state() == "GameState_BattleEnd" || game_state() == "GameState_Neutral";
  const leftEntindex = () => {
    return battleFieldInfo().isReverse ? battleFieldInfo().mainEnt : battleFieldInfo().customEnt;
  };
  const rightEntindex = () => {
    return battleFieldInfo().isReverse ? battleFieldInfo().customEnt : battleFieldInfo().mainEnt;
  };
  const leftPlayerID = () => {
    return battleFieldInfo().isReverse ? battleFieldInfo().mainID : battleFieldInfo().customID;
  };
  const rightPlayerID = () => {
    return battleFieldInfo().isReverse ? battleFieldInfo().customID : battleFieldInfo().mainID;
  };
  const [cameraState, setCameraState] = libs.createSignal(1);
  libs.onMount(() => {
    const NetTableListenerIDs = [];
    NetTableListenerIDs.push(useNetTableKeyHasDefaultValue("common", "camera_state_" + Players.GetLocalPlayer(), data => {
      setCameraState(data?.type ?? 1);
    }));
    libs.onCleanup(() => {
      NetTableListenerIDs.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    });
  });
  return (() => {
    const _el$ = libs.createElement("Panel", {
        id: "HeroHealthContainer"
      }, null),
      _el$2 = libs.createElement("Panel", {}, _el$);
    libs.insert(_el$, libs.createComponent(HealthBar, {
      get allyPlayers() {
        return allyPlayers();
      },
      direction: "Left",
      get self() {
        return leftEntindex();
      },
      get enemy() {
        return rightEntindex();
      },
      get playerID() {
        return leftPlayerID();
      }
    }), _el$2);
    libs.setProp(_el$2, "className", "Placeholder");
    libs.insert(_el$, libs.createComponent(HealthBar, {
      get allyPlayers() {
        return allyPlayers();
      },
      direction: "Right",
      get self() {
        return rightEntindex();
      },
      get enemy() {
        return leftEntindex();
      },
      get playerID() {
        return rightPlayerID();
      }
    }), null);
    libs.effect(_$p => libs.setProp(_el$, "className", libs.classNames("AlignCenter", "State_" + cameraState(), {
      Show: show()
    }), _$p));
    return _el$;
  })();
};
const useHealthBar = props => {
  props.direction;
  const [local, others] = libs.splitProps(props, ["self", "enemy", "playerID"]);
  const entIndex = () => local.self;
  const enemyEntIndex = () => local.enemy;
  const playerID = () => local.playerID;
  const [state, setState] = libs.createStore({
    health: 0,
    maxHealth: 0,
    mana: 0,
    maxMana: 0,
    hpPct: 100,
    mpPct: 0,
    shield: 0,
    fury: 0,
    ice: 0,
    injury: 0,
    poison: 0,
    chaos: 0,
    customMana: false,
    stunned: false,
    silenced: false,
    disarmed: false,
    buffList2: (() => {
      let list = [];
      return list;
    })()
  });
  const customManaType = libs.createMemo(() => {
    let ent = entIndex();
    if (ent != -1) {
      let unitName = Entities.GetUnitName(ent);
      if (unitName && KeyValues.UnitsCommonKv[unitName]) {
        return KeyValues.UnitsCommonKv[unitName].CustomManaType;
      }
    }
  });
  const Update = () => {
    setState({
      health: Entities.GetHealth(entIndex()),
      maxHealth: Entities.GetMaxHealth(entIndex()),
      mana: Entities.GetMana(entIndex()),
      maxMana: Entities.GetMaxMana(entIndex()),
      customMana: Entities.HasBuff(entIndex(), "modifier_custom_mana"),
      hpPct: Entities.GetHealth(entIndex()) / Entities.GetMaxHealth(entIndex()) * 100,
      mpPct: Entities.GetMana(entIndex()) / Entities.GetMaxMana(entIndex()) * 100,
      shield: Buffs.GetStackCount(entIndex(), Entities.FindBuffByName(entIndex(), "modifier_shield_custom")) + Buffs.GetStackCount(entIndex(), Entities.FindBuffByName(entIndex(), "modifier_shield_permanent")),
      fury: Buffs.GetStackCount(entIndex(), Entities.FindBuffByName(entIndex(), "modifier_fury_custom")) + Buffs.GetStackCount(entIndex(), Entities.FindBuffByName(entIndex(), "modifier_fury_permanent")),
      ice: Buffs.GetStackCount(entIndex(), Entities.FindBuffByName(entIndex(), "modifier_ice_custom")) + Buffs.GetStackCount(entIndex(), Entities.FindBuffByName(entIndex(), "modifier_ice_permanent")),
      injury: Buffs.GetStackCount(entIndex(), Entities.FindBuffByName(entIndex(), "modifier_injury_custom")) + Buffs.GetStackCount(entIndex(), Entities.FindBuffByName(entIndex(), "modifier_injury_permanent")),
      poison: Buffs.GetStackCount(entIndex(), Entities.FindBuffByName(entIndex(), "modifier_poison_custom")) + Buffs.GetStackCount(entIndex(), Entities.FindBuffByName(entIndex(), "modifier_poison_permanent")),
      chaos: Buffs.GetStackCount(entIndex(), Entities.FindBuffByName(entIndex(), "modifier_chaos_custom")) + Buffs.GetStackCount(entIndex(), Entities.FindBuffByName(entIndex(), "modifier_chaos_permanent")),
      stunned: Entities.IsStunned(entIndex()),
      silenced: Entities.IsSilenced(entIndex()),
      disarmed: Entities.IsDisarmed(entIndex()),
      buffList2: GetBuffList2(entIndex())
    });
  };
  const GetBuffList2 = entity => {
    let result = [];
    const buffCount = Entities.GetNumBuffs(entity);
    for (let i = 0; i < buffCount; i++) {
      const buffID = Entities.GetBuff(entity, i);
      const count = Buffs.GetStackCount(entity, buffID);
      if (!Buffs.IsHidden(entity, buffID) && count > 0) {
        result.push({
          buff_id: buffID,
          count
        });
      }
    }
    return result;
  };
  libs.onMount(() => {
    const listenerIDList = [];
    const timer = setInterval(Update, 100);
    libs.onCleanup(() => {
      listenerIDList.forEach(id => {
        CustomNetTables.UnsubscribeNetTableListener(id);
      });
      clearInterval(timer);
    });
  });
  return {
    playerID,
    entIndex,
    enemyEntIndex,
    customManaType,
    state
  };
};
const HealthBar = props => {
  const {
    playerID,
    entIndex,
    enemyEntIndex,
    customManaType,
    state
  } = useHealthBar(props);
  const GetManaType = () => {
    if (state.customMana) {
      return "1";
    }
    return customManaType();
  };
  let isEnemy = () => {
    return props.direction == "Left" ? true : playerID() != Players.GetLocalPlayer();
  };
  if (isSpectator()) {
    isEnemy = () => {
      return props.direction == "Left";
    };
  } else if (isGroupMode()) {
    isEnemy = () => {
      return props.direction == "Left" ? true : !props.allyPlayers.includes(playerID());
    };
  }
  return (() => {
    const _el$3 = libs.createElement("Panel", {
        get id() {
          return props.direction == "Left" ? "HeroHealthLeft" : "HeroHealthRight";
        }
      }, null),
      _el$4 = libs.createElement("Panel", {}, _el$3),
      _el$5 = libs.createElement("Panel", {}, _el$3),
      _el$6 = libs.createElement("Panel", {}, _el$3);
    libs.setProp(_el$4, "className", "HealthBarContainer");
    libs.insert(_el$4, libs.createComponent(GenericPanel.CImage, {
      className: "HeroHealthBG"
    }), null);
    libs.insert(_el$4, libs.createComponent(GenericPanel.CImage, {
      className: "HealthBarLoss",
      get style() {
        return {
          clip: `rect( 0%, ${state.hpPct}%, 100%, 0% )`
        };
      }
    }), null);
    libs.insert(_el$4, libs.createComponent(GenericPanel.CImage, {
      className: "HealthBar",
      get style() {
        return {
          clip: `rect( 0%, ${state.hpPct}%, 100%, 0% )`
        };
      }
    }), null);
    libs.insert(_el$4, libs.createComponent(EOM_Panel.EOM_Panel, {
      get className() {
        return libs.classNames("ManaBarContainer", "ManaType_" + GetManaType());
      },
      get children() {
        return libs.createComponent(GenericPanel.CImage, {
          className: "ManaBar",
          get style() {
            return {
              clip: `rect( 0%, ${state.mpPct}%, 100%, 0% )`
            };
          }
        });
      }
    }), null);
    libs.insert(_el$4, libs.createComponent(GenericPanel.CLabel, {
      className: "HealthText",
      get text() {
        return `${state.health}/${state.maxHealth}`;
      }
    }), null);
    libs.insert(_el$4, libs.createComponent(GenericPanel.CLabel, {
      className: "ManaText",
      get text() {
        return `${state.mana}/${state.maxMana}`;
      }
    }), null);
    libs.setProp(_el$5, "className", "BuffList2");
    libs.insert(_el$5, libs.createComponent(libs.Index, {
      get each() {
        return state.buffList2;
      },
      children: (data, index) => {
        const BuffID = () => data().buff_id;
        const buffName = () => Buffs.GetName(entIndex(), BuffID());
        const isDebuff = () => Buffs.IsDebuff(entIndex(), BuffID());
        const textureName = () => Buffs.GetTexture(entIndex(), BuffID());
        const count = () => data().count;
        return libs.createComponent(BuffIcon, {
          get buffName() {
            return buffName();
          },
          get count() {
            return count();
          },
          get textureName() {
            return textureName();
          },
          get isDebuff() {
            return isDebuff();
          }
        });
      }
    }));
    libs.setProp(_el$6, "className", "BuffList");
    libs.insert(_el$6, libs.createComponent(EOM_Panel.EOM_Panel, {
      get className() {
        return libs.classNames("BuffContainer Show", {
          NoBuff: state.shield <= 0
        });
      },
      get customTooltip() {
        return {
          name: "buff_detail",
          sectName: "sect_shield",
          entIndex: entIndex()
        };
      },
      get children() {
        return [libs.createComponent(SectIcon.SectIcon, {
          sectName: "sect_shield",
          width: "40px",
          height: "40px"
        }), libs.createComponent(GenericPanel.CLabel, {
          id: "ShieldValue",
          className: "BuffValue",
          get text() {
            return state.shield;
          }
        })];
      }
    }), null);
    libs.insert(_el$6, libs.createComponent(EOM_Panel.EOM_Panel, {
      get className() {
        return libs.classNames("BuffContainer Show", {
          NoBuff: state.fury <= 0
        });
      },
      get customTooltip() {
        return {
          name: "buff_detail",
          sectName: "sect_fury",
          entIndex: entIndex()
        };
      },
      get children() {
        return [libs.createComponent(SectIcon.SectIcon, {
          sectName: "sect_fury",
          width: "40px",
          height: "40px"
        }), libs.createComponent(GenericPanel.CLabel, {
          id: "FuryValue",
          className: "BuffValue",
          get text() {
            return state.fury;
          }
        })];
      }
    }), null);
    libs.insert(_el$6, libs.createComponent(EOM_Panel.EOM_Panel, {
      get className() {
        return libs.classNames("BuffContainer Show", {
          NoBuff: state.chaos <= 0
        });
      },
      get customTooltip() {
        return {
          name: "buff_detail",
          sectName: "sect_chaos",
          entIndex: entIndex()
        };
      },
      get children() {
        return [libs.createComponent(SectIcon.SectIcon, {
          sectName: "sect_chaos",
          width: "40px",
          height: "40px"
        }), libs.createComponent(GenericPanel.CLabel, {
          id: "ChaosValue",
          className: "BuffValue",
          get text() {
            return state.chaos;
          }
        })];
      }
    }), null);
    libs.insert(_el$6, libs.createComponent(EOM_Panel.EOM_Panel, {
      get className() {
        return libs.classNames("BuffContainer Debuff Show", {
          NoBuff: state.ice <= 0
        });
      },
      get customTooltip() {
        return {
          name: "buff_detail",
          sectName: "sect_ice",
          entIndex: enemyEntIndex()
        };
      },
      get children() {
        return [libs.createComponent(SectIcon.SectIcon, {
          sectName: "sect_ice",
          width: "40px",
          height: "40px"
        }), libs.createComponent(GenericPanel.CLabel, {
          id: "IceValue",
          className: "BuffValue",
          get text() {
            return state.ice;
          }
        })];
      }
    }), null);
    libs.insert(_el$6, libs.createComponent(EOM_Panel.EOM_Panel, {
      get className() {
        return libs.classNames("BuffContainer Debuff Show", {
          NoBuff: state.injury <= 0
        });
      },
      get customTooltip() {
        return {
          name: "buff_detail",
          sectName: "sect_injury",
          entIndex: enemyEntIndex()
        };
      },
      get children() {
        return [libs.createComponent(SectIcon.SectIcon, {
          sectName: "sect_injury",
          width: "40px",
          height: "40px"
        }), libs.createComponent(GenericPanel.CLabel, {
          id: "InjuryValue",
          className: "BuffValue",
          get text() {
            return state.injury;
          }
        })];
      }
    }), null);
    libs.insert(_el$6, libs.createComponent(EOM_Panel.EOM_Panel, {
      get className() {
        return libs.classNames("BuffContainer Debuff Show", {
          NoBuff: state.poison <= 0
        });
      },
      get customTooltip() {
        return {
          name: "buff_detail",
          sectName: "sect_poison",
          entIndex: enemyEntIndex()
        };
      },
      get children() {
        return [libs.createComponent(SectIcon.SectIcon, {
          sectName: "sect_poison",
          width: "40px",
          height: "40px"
        }), libs.createComponent(GenericPanel.CLabel, {
          id: "PoisonValue",
          className: "BuffValue",
          get text() {
            return state.poison;
          }
        })];
      }
    }), null);
    libs.insert(_el$6, libs.createComponent(libs.Show, {
      get when() {
        return state.silenced;
      },
      get children() {
        return libs.createComponent(EOM_Image.EOM_Image, {
          className: "StatusImage",
          get backgroundImage() {
            return getImagePath("buffstatus/silenced_png.png");
          }
        });
      }
    }), null);
    libs.insert(_el$6, libs.createComponent(libs.Show, {
      get when() {
        return state.stunned;
      },
      get children() {
        return libs.createComponent(EOM_Image.EOM_Image, {
          className: "StatusImage",
          get backgroundImage() {
            return getImagePath("buffstatus/stunned_png.png");
          }
        });
      }
    }), null);
    libs.insert(_el$6, libs.createComponent(libs.Show, {
      get when() {
        return state.disarmed;
      },
      get children() {
        return libs.createComponent(EOM_Image.EOM_Image, {
          className: "StatusImage",
          get backgroundImage() {
            return getImagePath("buffstatus/disarmed_png.png");
          }
        });
      }
    }), null);
    libs.effect(_p$ => {
      const _v$ = props.direction == "Left" ? "HeroHealthLeft" : "HeroHealthRight",
        _v$2 = libs.classNames("HeroHealth", {
          Enemy: isEnemy()
        });
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$3, "id", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$3, "className", _v$2, _p$._v$2));
      return _p$;
    }, {
      _v$: undefined,
      _v$2: undefined
    });
    return _el$3;
  })();
};
const BuffIcon = props => {
  const buffSrc = () => {
    const path = `file://{images}/custom_game/buffstatus/${props.textureName}.png`;
    if ($.BImageFileExists(path)) {
      return path;
    }
    return `file://{images}/spellicons/${props.textureName}.png`;
  };
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    get className() {
      return libs.classNames("BuffContainer", {
        Show: props.count > 0,
        Debuff: props.isDebuff
      });
    },
    get customTooltip() {
      return {
        name: "keyword_list",
        keyword_list: JSON.stringify([{
          type: "Info",
          value: props.buffName
        }].concat(getKeyWordList($.Localize("#" + props.buffName + "_description")))),
        type: "info"
      };
    },
    get children() {
      return [libs.createComponent(EOM_Image.EOM_Image, {
        get className() {
          return libs.classNames("StatusImage StatusMask", props.buffName);
        },
        get src() {
          return buffSrc();
        }
      }), libs.createComponent(EOM_Label.EOM_Label, {
        get className() {
          return libs.classNames("BuffValue", props.buffName);
        },
        get text() {
          return props.count;
        }
      })];
    }
  });
};

const setPlayerCamera = (distance, yaw, pitch, heightOffset) => {
  if (distance != undefined) {
    GameUI.CustomUIConfig().SetCameraDistance_C4(distance);
  }
  if (yaw != undefined) {
    GameUI.CustomUIConfig().SetCameraYaw_C4(yaw);
  }
  if (pitch != undefined) {
    GameUI.CustomUIConfig().SetCameraPitch_C4(pitch);
  }
  if (heightOffset != undefined) {
    GameUI.CustomUIConfig().SetCameraLookAtPositionHeightOffset_C4(heightOffset);
  }
};
const HeroShow = () => {
  const HERO_SHOW_CONFIG = CustomNetTables.GetTableValue("common", "constant")?.HERO_SHOW_CONFIG;
  const [game_state, setGameState] = libs.createSignal(getGameState());
  const [isReturnPlayer, setIsReturnPlayer] = libs.createSignal(false);
  const [activityList, setActivityList] = libs.createSignal([]);
  const rookieV2_sectflow = rookie_utils.useRookieV2Effect({
    key: "sect_flow",
    params: {}
  }, 0, true);
  libs.createEffect(libs.on(rookieV2_sectflow.state, v => {
    if (v) {
      clientSideEvent("rookie_sect_flow", {
        state: true
      });
    }
  }));
  libs.onMount(() => {
    setPlayerCamera(HERO_SHOW_CONFIG?.CAMERA_DISTANCE, HERO_SHOW_CONFIG?.CAMERA_YAW, HERO_SHOW_CONFIG?.CAMERA_PITCH, HERO_SHOW_CONFIG?.CAMERA_HEIGHT);
    const gameEventIDList = [];
    let customNetTableListeners = [];
    customNetTableListeners.push(useNetTableKeyHasDefaultValue("player_data", Players.GetLocalPlayer().toString(), data => {
      if (data.heroName) {
        rookieV2_sectflow.customToggleOn(true);
      }
    }));
    customNetTableListeners.push(useNetTableKey("common", "game_state", data => {
      setGameState(data?.state ?? "GameState_None");
    }));
    gameEventIDList.push(useNetData("player_regression_data", data => {
      setIsReturnPlayer(data?.is_regression_player == true);
    }, Players.GetLocalPlayer()));
    gameEventIDList.push(useNetData("info_activity_data", data => {
      let now = Math.floor(Date.now() / 1000);
      let filterList = [];
      for (const activityInfo of data) {
        if (now < activityInfo.start_time) {
          continue;
        }
        if (activityInfo.end_time > now || activityInfo.end_time == 0) {
          filterList.push(activityInfo.activity_id);
        }
      }
      setActivityList(filterList);
    }));
    libs.onCleanup(() => {
      setPlayerCamera(undefined, undefined, undefined, 0);
      customNetTableListeners.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
      gameEventIDList.forEach(id => GameEvents.Unsubscribe(id));
      clientSideEvent("rookie_sect_flow", {
        state: false
      });
    });
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "HeroShow",
    hittest: false,
    get children() {
      return [libs.createComponent(TeamSuggestionIcon.TopBar, {}), libs.createComponent(libs.Switch, {
        get children() {
          return [libs.createComponent(libs.Match, {
            get when() {
              return isReturnPlayer();
            },
            get children() {
              return libs.createComponent(EOM_Button.EOM_BaseButton, {
                className: "ReturnHUDButton",
                onactivate: () => {
                  ToggleWindows("MenuButton_activity", true);
                  clientSideEvent("switchActivityTag", {
                    id: "Activity_Regression"
                  });
                },
                get children() {
                  return [libs.createComponent(EOM_Label.EOM_Label, {
                    id: "ReturnHUDButtonTitle",
                    text: "#Activity_Regression"
                  }), libs.createComponent(EOM_Label.EOM_Label, {
                    id: "ReturnHUDButtonLabel",
                    text: "#Hud_ReturnTips",
                    html: true
                  })];
                }
              });
            }
          }), libs.createComponent(libs.Match, {
            get when() {
              return libs.memo(() => !!!isCompetitionMode())() && activityList().includes(12001);
            },
            get children() {
              return libs.createComponent(EOM_Button.EOM_BaseButton, {
                className: "AdvertisementButton",
                id: "IkunWinterButton",
                onactivate: () => {
                  ToggleWindows("MenuButton_activity", true);
                  clientSideEvent("switchActivityTag", {
                    id: "Activity_IkunWinter"
                  });
                },
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#Activity_IkunWinter",
                    html: true
                  });
                }
              });
            }
          })];
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return game_state() == "GameState_CitySelection";
        },
        get children() {
          return libs.createComponent(CitySelection, {});
        }
      }), libs.memo(() => libs.memo(() => !!!isSpectator())() && [libs.createComponent(CosmeticBottomLayout, {}), libs.createComponent(EOM_Button.EOM_IconButton, {
        id: "EmojiButton",
        get icon() {
          return libs.createComponent(EOM_Image.EOM_Image, {
            id: "Emoji"
          });
        },
        get customTooltip() {
          return {
            name: "hotkey_tip",
            hotkey: Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL)
          };
        },
        onactivate: () => clientSideEvent("emoji_action", {}),
        get children() {
          return libs.createComponent(GenericPanel.CLabel, {
            get text() {
              return `${Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL)}`;
            }
          });
        }
      }), libs.createComponent(InteractiveItems, {})])];
    }
  });
};
const CosmeticBottomLayout = () => {
  const [heroName, setHeroName] = libs.createSignal(getPlayerData(Players.GetLocalPlayer(), "heroName"));
  const [playerOrnament, setPlayerOrnament] = libs.createSignal({});
  const [experienceCosmeticData, setExperienceCosmeticData] = libs.createSignal();
  const updateExperienceCosmeticData = () => {
    const info_prop = getNetDataCache("info_prop");
    const player_props = getNetDataCache("player_props", Players.GetLocalPlayer());
    if (info_prop == undefined || player_props == undefined) {
      return;
    }
    let data = {};
    Object.values(player_props).forEach(v => {
      if (v.amounts > 0) {
        let propInfo = info_prop[v.prop_id];
        if (propInfo && propInfo.type == 5) {
          let params = JSON.parseSafe(propInfo.param);
          if (params.type && params.type != "any") {
            data[params.type] = {
              prop_id: v.prop_id,
              id: v.id
            };
          }
        }
      }
    });
    setExperienceCosmeticData(data);
  };
  const cosmeticExperienceData = oid => {
    if (oid == undefined) {
      return;
    }
    return experienceCosmeticData()?.[oid.toString()];
  };
  const playerOrnamentExpireData = libs.createMemo(() => {
    let data = {};
    Object.values(playerOrnament()).forEach(v => {
      data[v.oid] = v.permanent == 1 ? 0 : v.expire ?? -1;
    });
    return data;
  });
  const getCosmeticExpire = oid => {
    if (oid != undefined) {
      return playerOrnamentExpireData()[oid.toString()] ?? -1;
    }
    return -1;
  };
  const defaultFilter = [OrnamentType.COURIER_SKIN, OrnamentType.HERO_SKIN];
  const filter = () => {
    if (heroName() == undefined) {
      return defaultFilter.filter(v => v != OrnamentType.HERO_SKIN);
    }
    return defaultFilter;
  };
  const [cosmeticShow, setCosmeticShow] = libs.createSignal(false);
  const [cosmeticTag, setCosmeticTag] = libs.createSignal(OrnamentType.COURIER_SKIN);
  const [cosmeticList, setCosmeticList] = libs.createSignal((() => {
    const data = {};
    defaultFilter.forEach(type => data[type] = []);
    return data;
  })());
  libs.createEffect(() => {
    const allCosmetic = getAllCosmetics();
    const current_heroName = heroName();
    let hid;
    let _filer = defaultFilter;
    if (!current_heroName) {
      _filer = _filer.filter(v => v != OrnamentType.HERO_SKIN);
    } else {
      hid = GetGoodIDByHeroName(current_heroName);
    }
    let list = {};
    allCosmetic.forEach(cosmeticInfo => {
      if (KeyValues.CosmeticsKv[cosmeticInfo.oid].tool == 1) return;
      if (_filer.indexOf(cosmeticInfo.slot) != -1) {
        if (list[cosmeticInfo.slot] == undefined) {
          list[cosmeticInfo.slot] = [];
          if (cosmeticInfo.slot == OrnamentType.HERO_SKIN) {
            list[cosmeticInfo.slot].push({
              oid: 5100000,
              slot: 10,
              rarity: 0,
              default: true,
              orderby: 0,
              mark: 0
            });
          }
        }
        if (cosmeticInfo.slot != OrnamentType.HERO_SKIN || hid && KeyValues.CosmeticsKv[cosmeticInfo.oid]?.hero == hid) {
          list[cosmeticInfo.slot].push(cosmeticInfo);
        }
      }
    });
    let sortPlayerOrnament = Object.keys(playerOrnament()).length > 0;
    let isOwn = oid => {
      if (sortPlayerOrnament) {
        return playerOrnament()[oid] != undefined || oid.endsWith("0000");
      }
      return oid.endsWith("0000");
    };
    let getRarity = oid => {
      return KeyValues.CosmeticsKv[oid]?.rarity ?? 0;
    };
    let sortExperience = experienceCosmeticData() != undefined;
    _filer.forEach(type => {
      if (list[type]) {
        list[type] = list[type].sort((a, b) => {
          if (sortExperience) {
            return multiCompare((isOwn(b.oid.toString()) ? 1 : 0) - (isOwn(a.oid.toString()) ? 1 : 0), getRarity(b.oid.toString()) - getRarity(a.oid.toString()), (cosmeticExperienceData(b.oid) == undefined ? 0 : 1) - (cosmeticExperienceData(a.oid) == undefined ? 0 : 1), Number(b.oid.toString()) % 100 - Number(a.oid.toString()) % 100);
          } else {
            return multiCompare((isOwn(b.oid.toString()) ? 1 : 0) - (isOwn(a.oid.toString()) ? 1 : 0), getRarity(b.oid.toString()) - getRarity(a.oid.toString()), Number(b.oid.toString()) % 100 - Number(a.oid.toString()) % 100);
          }
        });
      }
    });
    setCosmeticList(list);
  });
  let timer;
  let end = false;
  libs.createEffect(libs.on(cosmeticTag, _cosmeticTag => {
    tiggerShining(true);
  }));
  libs.createEffect(libs.on(cosmeticShow, v => {
    if (v) {
      tiggerShining(true);
    }
  }));
  const tiggerShining = (force = false) => {
    if (end) return;
    if (!cosmeticShow()) return;
    if (!force && timer) {
      return;
    }
    let pHeroShow = $("#HeroShow");
    if (pHeroShow?.IsValid()) {
      pHeroShow.TriggerClass("CosmeticCardStrumming");
    }
    if (timer) {
      $.CancelScheduled(timer);
    }
    timer = $.Schedule(5, () => {
      if (timer) {
        timer = undefined;
      }
      tiggerShining();
    });
  };
  libs.onMount(() => {
    const gameEventIDList = [];
    let customNetTableListeners = [];
    gameEventIDList.push(useNetData('player_ornament', data => {
      setPlayerOrnament(data);
    }, Players.GetLocalPlayer()));
    gameEventIDList.push(useNetData("player_props", data => {
      updateExperienceCosmeticData();
    }, Players.GetLocalPlayer()));
    gameEventIDList.push(useNetData("info_prop", data => {
      updateExperienceCosmeticData();
    }));
    customNetTableListeners.push(useNetTableKey("player_data", Players.GetLocalPlayer().toString(), data => {
      setHeroName(data.heroName);
    }));
    tiggerShining();
    libs.onCleanup(() => {
      end = true;
      customNetTableListeners.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
      gameEventIDList.forEach(id => GameEvents.Unsubscribe(id));
      clearInterval(timer);
    });
  });
  const isEquip = cosmeticID => {
    if (cosmeticID == "5100000") {
      const hid = GetGoodIDByHeroName(heroName() ?? "");
      if (hid) {
        for (const oid in playerOrnament()) {
          const cosmeticData = playerOrnament()[oid];
          if (cosmeticData.hid == hid && cosmeticData.equip == 1) {
            return false;
          }
        }
      }
      return true;
    }
    if (cosmeticID.slice(-4) == "0000") {
      for (const oid in playerOrnament()) {
        const cosmeticData = playerOrnament()[oid];
        if (cosmeticData.pool.toString() == cosmeticID.slice(1, 3) && cosmeticData.equip == 1) {
          return false;
        }
      }
      return true;
    }
    return (playerOrnament()[cosmeticID]?.equip ?? 0) == 1;
  };
  const cosmeticSelectedList = () => cosmeticList()[cosmeticTag()] ?? [];
  const [selectedOid, setSelectedOid] = libs.createStore((() => {
    const oids = {};
    defaultFilter.forEach(type => oids[type] = finiteNumber(Number(`5${type}0000`), -1));
    return oids;
  })());
  let selectedOidInited = false;
  libs.createEffect(libs.on(playerOrnament, _playerOrnament => {
    if (_playerOrnament != undefined && !selectedOidInited) {
      selectedOidInited = true;
      let tempList = {};
      for (const oid in _playerOrnament) {
        const cosmeticData = playerOrnament()[oid];
        if (cosmeticData.equip == 1) {
          tempList[cosmeticData.pool] = Number(oid);
        }
      }
      defaultFilter.forEach(type => {
        if (tempList[type]) {
          setSelectedOid(type, tempList[type]);
        }
      });
    }
  }));
  const hasColoring = cosmeticID => {
    return KeyValues.CosmeticsKv[cosmeticID.toString()] && KeyValues.CosmeticsKv[cosmeticID.toString()].coloring != undefined;
  };
  const getAccessWay = (access, store_id, color_id) => {
    let [storeId, itemId] = store_id?.toString()?.split(",") ?? [];
    if (access == "draw" || access == "drawExchange") {
      if (storeId != undefined && storeId != "") {
        clientSideEvent("switchDrawPool", {
          pid: storeId
        });
        if (access == "drawExchange") {
          clientSideEvent("openDrawExchange", {
            state: true,
            itemId: itemId
          });
        }
      }
      ToggleWindows('MenuButton_draw', true);
    } else if (access == "store" && storeId != undefined && storeId != "") {
      clientSideEvent('directly_purchase', {
        itemid: storeId
      });
    } else if (access == "coloring") {
      showPopup("ColoringUnlock", {
        cosmeticId: color_id,
        group: "ColoringUnlock"
      });
    } else if (access == "activity") {
      ToggleWindows('MenuButton_activity', true);
      if (storeId != undefined && storeId != "") {
        clientSideEvent("switchActivityTag", {
          id: storeId
        });
      }
    } else {
      if (access == "battlepass") {
        ToggleWindows('MenuButton_store', true);
      } else {
        ToggleWindows('MenuButton_' + access, true);
      }
    }
  };
  const isLock = oid => {
    return playerOrnament()[oid.toString()] == undefined && KeyValues.CosmeticsKv[oid].access != "default";
  };
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "CosmeticBottomLayout",
    hittest: false,
    get children() {
      return [libs.createComponent(EOM_Button.EOM_BaseButton, {
        id: "CosmeticButton",
        classList: {
          CosmeticButtonAnim: true
        },
        onactivate: () => setCosmeticShow(v => !v),
        get children() {
          return [(() => {
            const _el$ = libs.createElement("Image", {}, null);
            libs.setProp(_el$, "className", "ShopAction");
            return _el$;
          })(), libs.createComponent(EOM_Image.EOM_Image, {
            get className() {
              return cosmeticShow() ? "BackIcon" : "SkinIcon";
            }
          }), libs.createComponent(GenericPanel.CLabel, {
            id: "CostLabel",
            get text() {
              return cosmeticShow() ? "#CollapseSelection" : "#MenuButton_cosmetics";
            }
          })];
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "CosmeticDetails",
        get classList() {
          return {
            Show: cosmeticShow()
          };
        },
        hittest: false,
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "CosmeticMainButtons",
            hittest: false,
            get children() {
              return libs.createComponent(libs.For, {
                get each() {
                  return filter();
                },
                children: (type, i) => {
                  return libs.createComponent(EOM_Button.EOM_BaseButton, {
                    get className() {
                      return libs.classNames("CosmeticMainButton", {
                        Selected: cosmeticTag() == type
                      });
                    },
                    onactivate: () => setCosmeticTag(type),
                    get children() {
                      return libs.createComponent(GenericPanel.CLabel, {
                        text: "#" + "CosmeticSlot_" + type
                      });
                    }
                  });
                }
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "CosmeticMain",
            hittest: false,
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "CosmeticList",
                scroll: "x",
                get children() {
                  return libs.createComponent(libs.Index, {
                    get each() {
                      return cosmeticSelectedList();
                    },
                    children: (cosmetic, i) => {
                      const oid = () => cosmetic().oid;
                      const hid = () => KeyValues.CosmeticsKv[oid()]?.hero ?? GetGoodIDByHeroName(heroName() ?? "") ?? -1;
                      const kvAccess = () => KeyValues.CosmeticsKv[oid()].access;
                      const kvStoreID = () => KeyValues.CosmeticsKv[oid()].StoreID;
                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                        get className() {
                          return libs.classNames("HeroShowCosmetic", {});
                        },
                        hittest: false,
                        get children() {
                          return [libs.createComponent(EOM_Panel.EOM_Panel, {
                            hittest: false,
                            get children() {
                              return [libs.createComponent(libs.Show, {
                                get when() {
                                  return cosmeticTag() == OrnamentType.HERO_SKIN;
                                },
                                fallback: () => libs.createComponent(CosmeticCard.CosmeticCard, {
                                  get itemid() {
                                    return oid().toString();
                                  },
                                  get lock() {
                                    return isLock(oid());
                                  },
                                  get equip() {
                                    return isEquip(oid().toString());
                                  },
                                  get preview() {
                                    return selectedOid[cosmeticTag()] == oid();
                                  },
                                  get rarity() {
                                    return cosmetic().rarity;
                                  },
                                  get mark() {
                                    return cosmetic().mark;
                                  },
                                  get hasColoring() {
                                    return hasColoring(oid());
                                  },
                                  onactivate: () => {
                                    setSelectedOid(cosmeticTag(), oid());
                                    if (!isLock(oid()) && cosmetic().slot != 31) {
                                      callAction('ornament_equip', {
                                        oid: oid(),
                                        pool: cosmetic().slot
                                      });
                                    }
                                  },
                                  get children() {
                                    return [libs.createComponent(libs.Show, {
                                      get when() {
                                        return getCosmeticExpire(oid()) > 0;
                                      },
                                      get children() {
                                        const _el$4 = libs.createElement("Panel", {
                                            id: "Trial"
                                          }, null),
                                          _el$5 = libs.createElement("Panel", {
                                            id: "TrialTime"
                                          }, _el$4);
                                        libs.insert(_el$4, libs.createComponent(GenericPanel.CImage, {
                                          id: "TrialMark",
                                          get ["class"]() {
                                            return $.Language().toLocaleLowerCase();
                                          }
                                        }), _el$5);
                                        libs.insert(_el$5, libs.createComponent(CosmeticCard.EOM_CountdownWithIcon, {
                                          id: "HeroRoleCountdown",
                                          get endTime() {
                                            return Number(getCosmeticExpire(oid()));
                                          }
                                        }));
                                        return _el$4;
                                      }
                                    }), libs.createComponent(libs.Show, {
                                      get when() {
                                        return libs.memo(() => !!isLock(oid()))() && cosmeticExperienceData(oid()) != undefined;
                                      },
                                      get children() {
                                        return libs.createComponent(EOM_Panel.EOM_Panel, {
                                          className: "Experience",
                                          get children() {
                                            return libs.createComponent(EOM_Label.EOM_Label, {
                                              color: 'white',
                                              get text() {
                                                return $.Localize("#can_experience");
                                              }
                                            });
                                          }
                                        });
                                      }
                                    })];
                                  }
                                }),
                                get children() {
                                  return libs.createComponent(CosmeticCard.HeroCosmeticCard, {
                                    get itemid() {
                                      return oid().toString();
                                    },
                                    get hid() {
                                      return hid();
                                    },
                                    get lock() {
                                      return isLock(oid());
                                    },
                                    get equip() {
                                      return isEquip(oid().toString());
                                    },
                                    get preview() {
                                      return selectedOid[cosmeticTag()] == oid();
                                    },
                                    get rarity() {
                                      return cosmetic().rarity;
                                    },
                                    get mark() {
                                      return cosmetic().mark;
                                    },
                                    get hasColoring() {
                                      return hasColoring(oid());
                                    },
                                    onactivate: () => {
                                      setSelectedOid(cosmeticTag(), oid());
                                      if (hid() != -1) {
                                        callAction('ornament_equip', {
                                          hid: hid(),
                                          oid: oid(),
                                          pool: cosmetic().slot
                                        });
                                      }
                                    },
                                    get children() {
                                      return [libs.createComponent(libs.Show, {
                                        get when() {
                                          return getCosmeticExpire(oid()) > 0;
                                        },
                                        get children() {
                                          const _el$2 = libs.createElement("Panel", {
                                              id: "Trial"
                                            }, null),
                                            _el$3 = libs.createElement("Panel", {
                                              id: "TrialTime"
                                            }, _el$2);
                                          libs.insert(_el$2, libs.createComponent(GenericPanel.CImage, {
                                            id: "TrialMark",
                                            get ["class"]() {
                                              return $.Language().toLocaleLowerCase();
                                            }
                                          }), _el$3);
                                          libs.insert(_el$3, libs.createComponent(CosmeticCard.EOM_CountdownWithIcon, {
                                            id: "HeroRoleCountdown",
                                            get endTime() {
                                              return Number(getCosmeticExpire(oid()));
                                            }
                                          }));
                                          return _el$2;
                                        }
                                      }), libs.createComponent(libs.Show, {
                                        get when() {
                                          return libs.memo(() => !!isLock(oid()))() && cosmeticExperienceData(oid()) != undefined;
                                        },
                                        get children() {
                                          return libs.createComponent(EOM_Panel.EOM_Panel, {
                                            className: "Experience",
                                            get children() {
                                              return libs.createComponent(EOM_Label.EOM_Label, {
                                                color: 'white',
                                                get text() {
                                                  return $.Localize("#can_experience");
                                                }
                                              });
                                            }
                                          });
                                        }
                                      })];
                                    }
                                  });
                                }
                              }), libs.createComponent(libs.Show, {
                                get when() {
                                  return !isLock(oid());
                                },
                                get children() {
                                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                                    width: "100%",
                                    height: "100%",
                                    margin: "8px 6px",
                                    hittest: false,
                                    get children() {
                                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                                        id: "CosmeticCardMask",
                                        hittest: false
                                      });
                                    }
                                  });
                                }
                              })];
                            }
                          }), libs.createComponent(EOM_Panel.EOM_Panel, {
                            id: "HeroShowCosmeticButton",
                            get children() {
                              return libs.createComponent(libs.Show, {
                                get when() {
                                  return isLock(oid());
                                },
                                get children() {
                                  return libs.createComponent(libs.Show, {
                                    get when() {
                                      return cosmeticExperienceData(oid()) != undefined;
                                    },
                                    fallback: () => libs.createComponent(EOM_Button.EOM_Button, {
                                      type: "C4glass",
                                      color: "Blue",
                                      text: "#CosmeticGet",
                                      get enabled() {
                                        return libs.memo(() => kvAccess() != undefined)() && kvAccess() != "none";
                                      },
                                      onactivate: () => {
                                        let coloring = KeyValues.CosmeticsKv[oid()]?.coloring;
                                        if (coloring && isLock(coloring)) {
                                          showPopup("ErrorMessage", {
                                            msg: "#cosmetic_origin_skin_locked"
                                          });
                                        } else {
                                          getAccessWay(kvAccess(), kvStoreID(), oid());
                                        }
                                      }
                                    }),
                                    get children() {
                                      return libs.createComponent(EOM_Button.EOM_Button, {
                                        type: "C4glass",
                                        color: 'Gold',
                                        text: '#UseExperienceCard',
                                        onactivate: () => {
                                          const propData = cosmeticExperienceData(oid());
                                          callAction("use_prop", {
                                            id: propData?.id ?? 0,
                                            prop_id: propData?.prop_id ?? 0,
                                            amounts: 1,
                                            params: [(oid() ?? 0).toString()]
                                          });
                                        }
                                      });
                                    }
                                  });
                                }
                              });
                            }
                          })];
                        }
                      });
                    }
                  });
                }
              });
            }
          })];
        }
      })];
    }
  });
};
const InteractiveItems = () => {
  const [abilityList, setAbilityList] = libs.createSignal([]);
  libs.onMount(() => {
    let id = setInterval(() => {
      const list = [];
      const heroIndex = Players.GetPlayerHeroEntityIndex(Players.GetLocalPlayer());
      if (Entities.IsValidEntity(heroIndex)) {
        for (let index = 0; index < 6; index++) {
          const ability = Entities.GetAbility(heroIndex, index);
          if (Entities.IsValidEntity(ability) && !Abilities.IsHidden(ability) && !Abilities.IsPassive(ability)) {
            list.push({
              abilityIndex: ability,
              charge: Abilities.GetCurrentAbilityCharges(ability)
            });
          }
        }
      }
      setAbilityList(list);
    }, 30);
    libs.onCleanup(() => {
      clearInterval(id);
    });
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    get className() {
      return libs.classNames("HeroShowInteractiveItems");
    },
    get children() {
      return libs.createComponent(libs.Index, {
        get each() {
          return abilityList();
        },
        children: abilityData => {
          return libs.createComponent(InteractiveItemButton, {
            get abilityIndex() {
              return abilityData().abilityIndex;
            },
            get charge() {
              return abilityData().charge;
            }
          });
        }
      });
    }
  });
};
const CitySelection = () => {
  const [selectionList, setSelectionList] = libs.createSignal([]);
  const [selfSelection, setSelfSelection] = libs.createSignal();
  const [cityResult, setCityResult] = libs.createSignal();
  const [cityResultPlayerID, setCityResultPlayerID] = libs.createSignal(-1);
  const resultAccountID = libs.createMemo(() => {
    if (cityResultPlayerID() != -1) {
      return getPlayerData(cityResultPlayerID(), "steamID");
    }
    return "-1";
  });
  const [showCityResult, setShowCityResult] = libs.createSignal(false);
  libs.onMount(() => {
    const gameEventIDList = [];
    let customNetTableListeners = [];
    customNetTableListeners.push(useNetTableKeyHasDefaultValue("common", "city_selection", data => {
      setSelectionList(Object.values(data));
    }));
    customNetTableListeners.push(useNetTableKeyHasDefaultValue("common", "player_city_selection", data => {
      setSelfSelection(data?.[Players.GetLocalPlayer()]);
    }));
    customNetTableListeners.push(useNetTableKeyHasDefaultValue("common", "city_effect", data => {
      setCityResult(data?.name);
    }));
    gameEventIDList.push(GameEvents.Subscribe("city_selection_result", data => {
      setCityResultPlayerID(data.result_player);
      setShowCityResult(true);
    }));
    libs.onCleanup(() => {
      customNetTableListeners.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
      gameEventIDList.forEach(id => GameEvents.Unsubscribe(id));
    });
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "CitySelection",
    hittest: false,
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "CitySelectionList",
        hittest: false,
        get children() {
          return libs.createComponent(libs.Index, {
            get each() {
              return selectionList();
            },
            children: (cityName, index) => {
              return libs.createComponent(EOM_Button.EOM_BaseButton, {
                get className() {
                  return libs.classNames("CitySelectionButton", {
                    Selected: selfSelection() == cityName()
                  });
                },
                onactivate: () => {
                  if (!isSpectator()) {
                    GameEvents.SendCustomEventToServer("select_city_effect", {
                      name: cityName()
                    });
                  }
                },
                get customTooltip() {
                  return {
                    name: "city_effect",
                    abilityName: cityName()
                  };
                },
                onload: self => {},
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "CityIconContainer",
                    get children() {
                      return [libs.createComponent(CityImage.CityImage, {
                        get city_name() {
                          return cityName();
                        }
                      }), libs.createComponent(EOM_Image.EOM_Image, {
                        id: "SelectedIcon",
                        get src() {
                          return getSrcPath("icon/selected.png");
                        }
                      })];
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "CitySelectionLabels",
                    get children() {
                      return [libs.createComponent(CityDescription.CityDescription, {
                        className: "CityDescription",
                        get abilityName() {
                          return cityName();
                        }
                      }), libs.createComponent(EOM_Label.EOM_Label, {
                        id: "CityName",
                        get text() {
                          return `#DOTA_Tooltip_ability_${cityName()}`;
                        }
                      })];
                    }
                  })];
                }
              });
            }
          });
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        get className() {
          return libs.classNames("CityResultContainer", {
            Show: showCityResult()
          });
        },
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "CityResultBG",
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "CityResultDescription",
                get children() {
                  return libs.createComponent(CityDescription.CityDescription, {
                    className: "CityDescription",
                    get abilityName() {
                      return cityResult() ?? "";
                    }
                  });
                }
              }), libs.createComponent(EOM_Label.EOM_Label, {
                id: "CityResultLabel",
                get text() {
                  return `#DOTA_Tooltip_ability_${cityResult()}`;
                }
              })];
            }
          }), libs.createComponent(libs.Show, {
            get when() {
              return cityResultPlayerID() != -1;
            },
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "CityResultPlayer",
                flowChildren: "right",
                get children() {
                  return [libs.createComponent(Player.PlayerAvatar, {
                    get steamID() {
                      return resultAccountID();
                    },
                    get playerID() {
                      return cityResultPlayerID();
                    }
                  }), libs.createComponent(Player.PlayerName, {
                    get steamID() {
                      return resultAccountID();
                    },
                    get playerID() {
                      return cityResultPlayerID();
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

var PLAYER_LIST_UI_STATES = function (PLAYER_LIST_UI_STATES) {
  PLAYER_LIST_UI_STATES[PLAYER_LIST_UI_STATES["normal"] = 1] = "normal";
  PLAYER_LIST_UI_STATES[PLAYER_LIST_UI_STATES["battle"] = 2] = "battle";
  PLAYER_LIST_UI_STATES[PLAYER_LIST_UI_STATES["neutral"] = 3] = "neutral";
  PLAYER_LIST_UI_STATES[PLAYER_LIST_UI_STATES["roshan"] = 4] = "roshan";
  return PLAYER_LIST_UI_STATES;
}(PLAYER_LIST_UI_STATES || {});
const localPlayerID = Players.GetLocalPlayer();
const [game_state, setGameState] = libs.createSignal(getGameState());
const [finalBo3Fighting, setFinalBo3Fighting] = libs.createSignal(false);
netdata_utils.createNetTableEffect("common", "game_state", data => {
  setGameState(data.state);
  setFinalBo3Fighting(data.team_bo3_fighting == 1);
});
const [selectAbility$1, setSelectAbility$1] = libs.createSignal("");
const [selectAbilityImgIndex, setSelectAbilityImgIndex] = libs.createSignal(0);
const abilityIsTrait$1 = () => {
  if (selectAbility$1() == "") {
    return false;
  }
  const strArr = selectAbility$1().split("_");
  if (strArr[0] == "trait") {
    return true;
  }
  return false;
};
function CanMoveCamera() {
  if (isSpectator()) {
    return true;
  }
  let cameraType = getPlayerData(localPlayerID, "cameraType");
  if (cameraType == undefined) {
    return true;
  }
  return cameraType == 0;
}
const [battle_data, setBattleData] = libs.createSignal();
const [neutral_data, setNeutralData] = libs.createSignal();
const [roshan_order, setRoshanOrder] = libs.createSignal();
const [uiState, setUIState] = libs.createSignal(PLAYER_LIST_UI_STATES.normal);
libs.createEffect(() => {
  if (roshan_order()) {
    setUIState(PLAYER_LIST_UI_STATES.roshan);
  } else if (neutral_data()) {
    setUIState(PLAYER_LIST_UI_STATES.neutral);
  } else if (battle_data()) {
    setUIState(PLAYER_LIST_UI_STATES.battle);
  } else {
    setUIState(PLAYER_LIST_UI_STATES.normal);
  }
});
const [cameraEntList, setCameraEntList] = libs.createSignal();
const [roshan_reward_selection, setRoshanRewardSelection] = libs.createSignal();
let roshanSelectTimer;
const [roshanCountDown, setRoshanCountDown] = libs.createSignal(0);
const [newOrRgressionPlayers, setNewOrRgressionPlayers] = libs.createSignal({});
const IsNewOrRegressionPlayer = uid => {
  if (!uid) return false;
  return newOrRgressionPlayers()?.[uid] == 1;
};
libs.createEffect(libs.on(roshan_reward_selection, v => {
  let cleartimer = true;
  if (v && v.end_time != -1) {
    cleartimer = false;
    if (roshanSelectTimer == undefined) {
      roshanSelectTimer = setInterval(() => {
        if (roshan_reward_selection() != undefined && roshan_reward_selection().end_time != undefined) {
          setRoshanCountDown(roshan_reward_selection().end_time - Game.GetGameTime());
        }
      }, 10);
    }
  }
  if (cleartimer && roshanSelectTimer) {
    clearInterval(roshanSelectTimer);
    roshanSelectTimer = undefined;
    setRoshanCountDown(0);
  }
}));
const [all_player_data, setAllPlayerData] = libs.createStore((() => {
  const all_data = {};
  const net_table_data = CustomNetTables.GetAllTableValues("player_data");
  if (net_table_data) {
    Object.values(net_table_data).forEach(v => {
      all_data[Number(v.key)] = v.value;
    });
  }
  return all_data;
})());
const selectingPlayerInfo = libs.createMemo(() => {
  let player_id = localPlayerID;
  let illusion = false;
  if (isSpectator()) {
    let info = GameUI.GetSpectatorViewingInfo();
    player_id = info.player_id;
    illusion = info.illusion;
  } else {
    if (all_player_data?.[localPlayerID]?.viewPlayerInfo != undefined) {
      player_id = all_player_data[localPlayerID].viewPlayerInfo.player_id;
      illusion = all_player_data[localPlayerID].viewPlayerInfo.is_illusion == 1;
    }
  }
  return {
    player_id,
    illusion
  };
});
const [enemyProphecy, setEnemyProphecy] = libs.createSignal([]);
const rivalData = libs.createMemo(() => {
  let id;
  let isIllusion = false;
  if (battle_data() != null) {
    Object.values(battle_data()).forEach(data => {
      if (id != undefined) return;
      if (data) {
        if (data.customerPlayer.PlayerID == localPlayerID) {
          id = data.mainPlayer.PlayerID;
          isIllusion = data.mainPlayer.illusion == 1;
        } else if (data.mainPlayer.PlayerID == localPlayerID) {
          id = data.customerPlayer.PlayerID;
          isIllusion = data.customerPlayer.illusion == 1;
        }
      }
    });
  }
  return {
    playerID: id,
    illusion: isIllusion
  };
});
const [avatarMedalList, setAvatarMedalList] = libs.createStore({});
const [playerSelectionData, setPlayerSelectionData] = libs.createSignal();
if (isSpectator()) {
  let state = false;
  libs.createEffect(libs.on(battle_data, v => {
    if (v != undefined) {
      if (!state) {
        state = true;
        $.Schedule(3, () => {
          const spectatorInfo = GameUI.GetSpectatorViewingInfo();
          let battleIndex = 1;
          for (const i in v) {
            let index = Number(i);
            if (v[i].mainPlayer.illusion == 0 && v[i].mainPlayer.PlayerID == spectatorInfo.player_id || v[i].customerPlayer.illusion == 0 && v[i].customerPlayer.PlayerID == spectatorInfo.player_id) {
              battleIndex = index;
            }
          }
          GameEvents.SendCustomEventToServer("teleport_player_area", {
            targetPlayerID: spectatorInfo.player_id,
            isIllusion: false,
            battleDataIndex: battleIndex.toString()
          });
          GameUI.SetSpectatorViewingInfo({
            player_id: spectatorInfo.player_id,
            illusion: false
          });
        });
      }
    } else {
      if (state) {
        state = false;
        const spectatorInfo = GameUI.GetSpectatorViewingInfo();
        GameEvents.SendCustomEventToServer("teleport_player_area", {
          targetPlayerID: spectatorInfo.player_id
        });
        if (spectatorInfo.illusion) {
          GameUI.SetSpectatorViewingInfo({
            player_id: spectatorInfo.player_id,
            illusion: false
          });
        }
      }
    }
  }));
}
const CardEffectNotifyDuration = 6;
const cardEffectClassTrigger = {};
const setCardEffectClassTrigger = (id, state) => {
  if (state) {
    cardEffectClassTrigger[id] = state;
  } else {
    delete cardEffectClassTrigger[id];
  }
};
const [notifyCardEffectStore, setNotifyCardEffectStore] = libs.createStore({});
let cardEffectScheduleIDList = {};
let playerInfoTooltipTimer;
const [takeDamages, setTakeDamages] = libs.createStore((() => {
  let damages = {};
  Object.keys(all_player_data).forEach(v => {
    damages[Number(v)] = 0;
  });
  return damages;
})());
libs.createEffect(() => {
  let _all_player_data = all_player_data;
  let _battle_data = battle_data();
  libs.batch(() => {
    if (_battle_data) {
      for (const data of Object.values(_battle_data)) {
        setTakeDamages(data.mainPlayer.PlayerID, _all_player_data[data.customerPlayer.PlayerID].damage ?? 0);
        if (data.customerPlayer.illusion != 1) {
          setTakeDamages(data.customerPlayer.PlayerID, _all_player_data[data.mainPlayer.PlayerID].damage ?? 0);
        }
      }
    }
  });
});
function PlayerList() {
  libs.onMount(() => {
    let GameEventsIDList = [];
    let NetTableListenerIDs = [];
    GameEventsIDList.push(useNetData("match_new_regression_players", data => {
      let players = {};
      if (data?.new_players) {
        data.new_players.split(",").forEach(elm => {
          players[elm] = 1;
        });
      }
      if (data?.regression_players) {
        data.regression_players.split(",").forEach(elm => {
          players[elm] = 1;
        });
      }
      setNewOrRgressionPlayers(players);
    }));
    GameEventsIDList.push(GameEvents.Subscribe("player_card_effect", events => {
      if (cardEffectScheduleIDList[events.player_id] != undefined) {
        $.CancelScheduled(cardEffectScheduleIDList[events.player_id]);
        delete cardEffectScheduleIDList[events.player_id];
      }
      cardEffectScheduleIDList[events.player_id] = $.Schedule(CardEffectNotifyDuration, () => {
        delete cardEffectScheduleIDList[events.player_id];
        libs.batch(() => {
          if (cardEffectClassTrigger[events.player_id] != undefined) {
            setCardEffectClassTrigger(events.player_id, undefined);
          }
          if (notifyCardEffectStore[events.player_id]) {
            setNotifyCardEffectStore(events.player_id, undefined);
          }
        });
      });
      libs.batch(() => {
        setCardEffectClassTrigger(events.player_id, true);
        setNotifyCardEffectStore(events.player_id, events.card_name);
      });
    }));
    NetTableListenerIDs.push(CustomNetTables.SubscribeNetTableListener("player_data", (_, k, v) => {
      let _playerID = Number(k) ?? -1;
      if (Players.IsValidPlayerID(_playerID)) {
        setAllPlayerData(_playerID, v);
      }
    }));
    NetTableListenerIDs.push(useNetTableKeyHasDefaultValue("common", "camera_ent_list", data => {
      setCameraEntList(data);
    }));
    NetTableListenerIDs.push(useNetTableKeyHasDefaultValue("common", "enemy_prophecy", data => {
      if (data.data?.[localPlayerID] != undefined) {
        setEnemyProphecy([data.data?.[localPlayerID]]);
      } else {
        setEnemyProphecy([]);
      }
    }));
    NetTableListenerIDs.push(useNetTableKeyHasDefaultValue("common", "battle_data", data => {
      if (Object.keys(data ?? {}).length > 0) {
        setBattleData(data);
      } else {
        setBattleData(null);
      }
    }));
    NetTableListenerIDs.push(useNetTableKeyHasDefaultValue("common", "neutral_data", data => {
      if (Object.keys(data ?? {}).length > 0) {
        setNeutralData(data);
      } else {
        setNeutralData(null);
      }
    }));
    NetTableListenerIDs.push(useNetTableKeyHasDefaultValue("common", "roshan_player_order", data => {
      let order = Object.values(data ?? {});
      if (order.length > 0) {
        setRoshanOrder(order);
      } else {
        setRoshanOrder();
      }
    }));
    NetTableListenerIDs.push(useNetTableKeyHasDefaultValue("common", "roshan_reward_selection", data => {
      setRoshanRewardSelection(data);
    }));
    if (!isSpectator()) {
      NetTableListenerIDs.push(useNetTableKeyHasDefaultValue("common", "player_selection_" + Players.GetLocalPlayer(), data => {
        let arr = Object.values(data?.players ?? []);
        if (arr.length > 0) {
          setPlayerSelectionData(arr);
          setSelectAbility$1(data.ability_name ?? "");
        } else {
          setPlayerSelectionData();
        }
      }));
    }
    NetTableListenerIDs.push(useServiceNetTable("player_equipped_ornament", (data, id) => {
      if (data && data?.[OrnamentType.MEDAL]) {
        let medalID = "";
        for (const id in data[OrnamentType.MEDAL]) {
          medalID = id;
          break;
        }
        if (medalID != "") {
          setAvatarMedalList(id, medalID);
        }
      }
    }, -1));
    libs.onCleanup(() => {
      NetTableListenerIDs.forEach(id => {
        CustomNetTables.UnsubscribeNetTableListener(id);
      });
      GameEventsIDList.forEach(id => GameEvents.Unsubscribe(id));
      Object.values(cardEffectScheduleIDList).forEach(id => {
        $.CancelScheduled(id);
      });
      cardEffectScheduleIDList = {};
    });
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "PlayerList",
    get classList() {
      return {
        HideList: game_state() == "GameState_GreevilEgg"
      };
    },
    marginTop: "60px",
    hittest: false,
    get children() {
      const _el$ = libs.createElement("Panel", {
        id: "PlayerRowList",
        hittest: false
      }, null);
      libs.insert(_el$, libs.createComponent(libs.Show, {
        get when() {
          return uiState() == PLAYER_LIST_UI_STATES.roshan || !isGroupMode();
        },
        get fallback() {
          return libs.createComponent(GroupPlayerList, {});
        },
        get children() {
          return libs.createComponent(SinglePlayerList, {});
        }
      }));
      return _el$;
    }
  });
}
const SinglePlayerList = () => {
  const [illusionIndexList, setIllusionIndexList] = libs.createSignal([]);
  const [statesList, setStatesList] = libs.createSignal(Array(8).fill("none"));
  const updatePlayerInfo = () => {
    let illuList = [];
    let list = [];
    let states = [];
    let _neutral_data = neutral_data();
    let _battle_data = battle_data();
    switch (uiState()) {
      case PLAYER_LIST_UI_STATES.battle:
        if (_battle_data) {
          Object.values(_battle_data).forEach((data, index) => {
            let winnderID = data.winnerID ?? -1;
            list.push(data.mainPlayer.PlayerID);
            if (data.mainPlayer.illusion == 1) {
              illuList.push(index * 2);
            }
            list.push(data.customerPlayer.PlayerID);
            if (data.customerPlayer.illusion == 1) {
              illuList.push(index * 2 + 1);
            }
            if (winnderID == data.mainPlayer.PlayerID) {
              states.push("win");
              states.push("loss");
            } else if (winnderID == data.customerPlayer.PlayerID) {
              states.push("loss");
              states.push("win");
            } else {
              states.push("fighting");
              states.push("fighting");
            }
          });
        }
        break;
      case PLAYER_LIST_UI_STATES.neutral:
        list = Object.keys(all_player_data).map(v => Number(v)).sort((a, b) => (all_player_data[b].health ?? 0) - (all_player_data[a].health ?? 0));
        if (_neutral_data) {
          list.forEach((pid, index) => {
            if (_neutral_data) if (_neutral_data[pid.toString()]?.result != undefined) {
              states.push(_neutral_data[pid.toString()].result == 1 ? "win" : "loss");
            } else {
              states.push("fighting");
            }
          });
        }
        break;
      case PLAYER_LIST_UI_STATES.roshan:
        const roshanOrder = roshan_order();
        if (roshanOrder) {
          list = roshanOrder;
        }
        break;
      default:
        list = Object.keys(all_player_data).map(Number).sort((a, b) => multiCompare((all_player_data[a].rank ?? 0) - (all_player_data[b].rank ?? 0), (all_player_data[b].health ?? 0) - (all_player_data[a].health ?? 0)));
        list.forEach(pid => {
          let state = "loading";
          if (all_player_data[pid]?.prepareReady == 1) {
            state = "checked";
          }
          states.push(state);
        });
    }
    setIllusionIndexList(illuList);
    if (game_state() == "GameState_ConfirmNeutral" || game_state() == "GameState_ConfirmRoshan" || game_state() == "GameState_End" || states.length == 0) {
      states = Array(8).fill("none");
    }
    setStatesList(states);
    if (list.length > 0) {
      return list;
    }
    return Object.keys(all_player_data).map(Number).sort((a, b) => (all_player_data[b].health ?? 0) - (all_player_data[a].health ?? 0));
  };
  const [playerIDList, setPlayerIDList] = libs.createSignal(updatePlayerInfo());
  libs.createEffect(() => {
    let new_list = updatePlayerInfo();
    if (JSON.stringify(new_list) != JSON.stringify(playerIDList())) {
      setPlayerIDList(new_list);
    }
  });
  return libs.createComponent(libs.Index, {
    get each() {
      return playerIDList();
    },
    children: (playerID, index) => {
      const isIllusion = () => illusionIndexList().includes(index);
      const player_state = () => all_player_data[playerID()].health == 0 && (all_player_data[playerID()].rank ?? 0) > 0 ? "dead" : statesList()[index];
      const color = libs.createMemo(() => {
        if (localPlayerID == playerID() && !isIllusion()) {
          return "blue";
        }
        if (rivalData().playerID == playerID() && rivalData().illusion == isIllusion()) {
          return "red";
        }
        return "none";
      });
      const healthDeg = () => {
        const playerInfo = all_player_data[playerID()];
        if (playerInfo != undefined) {
          return 360 * playerInfo.health / playerInfo.maxHealth;
        }
        return 180;
      };
      return libs.createComponent(NewPlayerRow, {
        index: index,
        game_mode: "single",
        get health_deg() {
          return healthDeg();
        },
        get take_damage() {
          return takeDamages[playerID()] ?? 0;
        },
        get player_id() {
          return playerID();
        },
        get health() {
          return all_player_data[playerID()].health;
        },
        get player_state() {
          return player_state();
        },
        get rank() {
          return all_player_data[playerID()]?.rank;
        },
        get background_color() {
          return color();
        },
        get roshan_treasure() {
          return uiState() == PLAYER_LIST_UI_STATES.roshan;
        },
        get selected() {
          return libs.memo(() => selectingPlayerInfo().player_id == playerID())() && selectingPlayerInfo().illusion == isIllusion();
        },
        get illusion() {
          return isIllusion();
        },
        onSelect: () => {
          if (!isSpectator() && uiState() == PLAYER_LIST_UI_STATES.roshan) {
            return;
          }
          if (player_state() == "dead") {
            return;
          }
          if (!CanMoveCamera()) {
            return;
          }
          let cameraList = cameraEntList();
          if (cameraList != undefined) {
            let applyYaw = false;
            const gameState = getGameState();
            let targetPlayerID = -1;
            if (gameState == "GameState_ConfirmBattle" || gameState == "GameState_Battle" || gameState == "GameState_BattleEnd" || gameState == "GameState_ExtraBattlePrepare") {
              if (battle_data() != undefined) {
                let battleInfoIndex = Math.floor(index / 2);
                let battleInfo = Object.values(battle_data())[battleInfoIndex];
                if (battleInfo != undefined) {
                  if (battleInfo.customerPlayer.illusion != 1 && battleInfo.customerPlayer.PlayerID == Players.GetLocalPlayer()) {
                    applyYaw = true;
                  }
                  targetPlayerID = battleInfo.mainPlayer.PlayerID;
                  GameEvents.SendCustomEventToServer("teleport_player_area", {
                    targetPlayerID: playerID(),
                    isIllusion: isIllusion(),
                    battleDataIndex: (battleInfoIndex + 1).toString()
                  });
                }
              }
            } else {
              targetPlayerID = playerID();
              GameEvents.SendCustomEventToServer("teleport_player_area", {
                targetPlayerID
              });
            }
            if (targetPlayerID != -1) {
              let index = all_player_data[targetPlayerID]?.index;
              if (index != undefined && cameraList.player_home?.[index] != undefined) {
                let targetEnt = cameraList.player_home?.[index];
                GameUI.CustomUIConfig().CameraLockTargetWithAnimation(targetEnt);
                if (!isSpectator() && applyYaw) {
                  GameUI.CustomUIConfig().SetCameraYaw_C4(180);
                } else {
                  GameUI.CustomUIConfig().SetCameraYaw_C4(0);
                }
              }
            }
          }
          if (isSpectator()) {
            GameUI.SetSpectatorViewingInfo({
              player_id: playerID(),
              illusion: isIllusion()
            });
          }
        }
      });
    }
  });
};
const GroupPlayerList = () => {
  let groupIndexList = [0, 1, 2, 3];
  const [allGroupInfo, setAllGroupInfo] = libs.createStore((() => {
    let groupInfo = {};
    groupIndexList.forEach(index => {
      let data = CustomNetTables.GetTableValue("common", "group_team_" + index);
      if (data != undefined) {
        groupInfo[index] = data;
      }
    });
    return groupInfo;
  })());
  const allyPlayers = libs.createMemo(() => {
    let list = [];
    Object.values(allGroupInfo).forEach(group => {
      let pids = Object.values(group.players);
      if (pids.includes(localPlayerID)) {
        list = pids;
      }
    });
    return list;
  });
  libs.onMount(() => {
    let tableListeners = [];
    groupIndexList.forEach(index => {
      tableListeners.push(useNetTableKeyHasDefaultValue("common", "group_team_" + index, data => {
        setAllGroupInfo(index, Object.assign({}, data));
      }));
    });
    libs.onCleanup(() => {
      tableListeners.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    });
  });
  const [groupSort, setGroupSort] = libs.createSignal(groupIndexList);
  libs.createEffect(() => {
    setGroupSort(Object.keys(allGroupInfo).map(Number).sort((a, b) => multiCompare(allGroupInfo[a].rank - allGroupInfo[b].rank, allGroupInfo[b].health - allGroupInfo[a].health, allGroupInfo[a].undead - allGroupInfo[b].undead)));
  });
  let viewingIDs = libs.createMemo(() => {
    let viewingPlayerID = all_player_data[localPlayerID]?.viewPlayerInfo?.player_id ?? -1;
    if (isSpectator()) {
      viewingPlayerID = GameUI.GetSpectatorViewingInfo().player_id;
    }
    let list = [viewingPlayerID];
    let _battle_data = battle_data();
    if (_battle_data) {
      for (const data of Object.values(_battle_data)) {
        if (data.mainPlayer.PlayerID == viewingPlayerID) {
          list.push(data.customerPlayer.PlayerID);
          break;
        } else if (data.customerPlayer.PlayerID == viewingPlayerID) {
          list.push(data.mainPlayer.PlayerID);
          break;
        }
      }
    }
    return list;
  });
  return libs.createComponent(libs.Index, {
    get each() {
      return groupSort();
    },
    children: (group, i) => {
      const groupInfo = () => allGroupInfo[group()];
      const healthPct = () => Clamp(allGroupInfo[group()].health / allGroupInfo[group()].max_health * 100, 8, 100);
      const groupPlayerList = libs.createMemo(() => Object.values(groupInfo().players));
      const undead = () => allGroupInfo[group()].undead == 1;
      const rank = () => allGroupInfo[group()].rank;
      return libs.createComponent(EOM_Panel.EOM_Panel, {
        get ["class"]() {
          return libs.classNames("GroupTeamRow", "Index" + i);
        },
        hittest: false,
        get children() {
          return [libs.createComponent(libs.Index, {
            get each() {
              return groupPlayerList();
            },
            children: (playerID, i) => {
              const isIllusion = () => false;
              const [player_state, setPlayerState] = libs.createSignal("none");
              const [battle_index, setBattleIndex] = libs.createSignal(-1);
              const healthDeg = () => {
                const groupInfo = allGroupInfo[group()];
                if (groupInfo != undefined) {
                  return 360 * groupInfo.health / groupInfo.max_health;
                }
                return 180;
              };
              libs.createEffect(() => {
                let state = "none";
                let gameState = game_state();
                if (all_player_data[playerID()]?.health == 0 && (all_player_data[playerID()]?.rank ?? 0) > 0) {
                  state = "dead";
                }
                let battleIndex = -1;
                let _neutral_data = neutral_data();
                let _battle_data = battle_data();
                if (gameState != "GameState_End" && state != "dead") {
                  switch (uiState()) {
                    case PLAYER_LIST_UI_STATES.battle:
                      if (_battle_data) {
                        for (const [key, data] of Object.entries(_battle_data)) {
                          if (data.mainPlayer.PlayerID == playerID() || data.customerPlayer.PlayerID == playerID()) {
                            battleIndex = Number(key);
                            let winnerID = data.winnerID ?? -1;
                            if (winnerID == -1) {
                              state = "fighting";
                              break;
                            }
                            state = winnerID == playerID() ? "win" : "loss";
                            break;
                          }
                        }
                      }
                      break;
                    case PLAYER_LIST_UI_STATES.neutral:
                      if (_neutral_data) {
                        if (_neutral_data[playerID().toString()]?.result != undefined) {
                          state = _neutral_data[playerID().toString()].result == 1 ? "win" : "loss";
                        } else {
                          state = "fighting";
                        }
                      }
                      break;
                    default:
                      if (all_player_data[playerID()]?.prepareReady == 1) {
                        state = "checked";
                      } else {
                        state = "loading";
                      }
                  }
                }
                setBattleIndex(battleIndex);
                setPlayerState(state);
              });
              const color = libs.createMemo(() => {
                if (localPlayerID == playerID() && true) {
                  return "blue";
                }
                if (rivalData().playerID == playerID() && rivalData().illusion == isIllusion()) {
                  return "red";
                }
                return "none";
              });
              return libs.createComponent(NewPlayerRow, {
                index: i,
                get health() {
                  return allGroupInfo[group()].health;
                },
                get health_deg() {
                  return healthDeg();
                },
                get take_damage() {
                  return takeDamages[playerID()] ?? 0;
                },
                game_mode: "group",
                get player_id() {
                  return playerID();
                },
                get player_state() {
                  return player_state();
                },
                get rank() {
                  return all_player_data[playerID()]?.rank;
                },
                get background_color() {
                  return color();
                },
                get roshan_treasure() {
                  return uiState() == PLAYER_LIST_UI_STATES.roshan;
                },
                get selected() {
                  return libs.memo(() => selectingPlayerInfo().player_id == playerID())() && selectingPlayerInfo().illusion == isIllusion();
                },
                get group_selecting() {
                  return libs.memo(() => game_state() == "GameState_ExtraBattlePrepare")() ? player_state() == "win" : viewingIDs().includes(playerID());
                },
                get illusion() {
                  return isIllusion();
                },
                onSelect: () => {
                  if (!isSpectator() && uiState() == PLAYER_LIST_UI_STATES.roshan) {
                    return;
                  }
                  if (player_state() == "dead") {
                    return;
                  }
                  if (!CanMoveCamera()) {
                    return;
                  }
                  let cameraList = cameraEntList();
                  if (cameraList != undefined) {
                    let applyYaw = false;
                    const gameState = game_state();
                    let targetPlayerID = -1;
                    if (gameState == "GameState_ConfirmBattle" || gameState == "GameState_Battle" || gameState == "GameState_BattleEnd") {
                      if (battle_data() != undefined) {
                        let battleInfoIndex = battle_index();
                        let battleInfo = battle_data()[battle_index()];
                        if (battleInfo != undefined) {
                          if (battleInfo.customerPlayer.illusion != 1 && allyPlayers().includes(battleInfo.customerPlayer.PlayerID)) {
                            applyYaw = true;
                          }
                          targetPlayerID = battleInfo?.battlefieldID ?? battleInfo.mainPlayer.PlayerID;
                          GameEvents.SendCustomEventToServer("teleport_player_area", {
                            targetPlayerID: playerID(),
                            isIllusion: isIllusion(),
                            battleDataIndex: battleInfoIndex.toString()
                          });
                        }
                      }
                    } else {
                      targetPlayerID = playerID();
                      GameEvents.SendCustomEventToServer("teleport_player_area", {
                        targetPlayerID
                      });
                    }
                    if (targetPlayerID != -1) {
                      let index = all_player_data[targetPlayerID]?.index;
                      if (index != undefined && cameraList.player_home?.[index] != undefined) {
                        let targetEnt = cameraList.player_home?.[index];
                        GameUI.CustomUIConfig().CameraLockTargetWithAnimation(targetEnt);
                        if (!isSpectator() && applyYaw) {
                          GameUI.CustomUIConfig().SetCameraYaw_C4(180);
                        } else {
                          GameUI.CustomUIConfig().SetCameraYaw_C4(0);
                        }
                      }
                    }
                  }
                  if (isSpectator()) {
                    GameUI.SetSpectatorViewingInfo({
                      player_id: playerID(),
                      illusion: isIllusion()
                    });
                  }
                }
              });
            }
          }), libs.createComponent(libs.Show, {
            get when() {
              return rank() > 0;
            },
            get fallback() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "TeamHealth",
                get classList() {
                  return {
                    undead: undead()
                  };
                },
                hittest: false,
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("TeamHealthBar", "Team" + group());
                    },
                    get children() {
                      return libs.createComponent(EOM_Image.EOM_Image, {
                        id: "HealthBar",
                        get style() {
                          return {
                            clip: `rect( ${100 - healthPct()}% ,100%, 100%, 0%)`
                          };
                        }
                      });
                    }
                  }), libs.createComponent(GenericPanel.CLabel, {
                    get text() {
                      return allGroupInfo[group()].health;
                    }
                  })];
                }
              });
            },
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "TeamRankContainer",
                hittest: true,
                hittestchildren: false,
                get children() {
                  return [libs.createComponent(GenericPanel.CImage, {
                    get className() {
                      return libs.classNames("TeamRankBG", "Rank" + rank());
                    }
                  }), libs.createComponent(EOM_Label.EOM_Label, {
                    className: "TeamRank",
                    get text() {
                      return libs.memo(() => rank() > 3)() ? rank() : "";
                    }
                  })];
                }
              });
            }
          })];
        }
      });
    }
  });
};
const NewPlayerRow = props => {
  const health = () => {
    return props.health;
  };
  const healthDeg = () => {
    return props.health_deg;
  };
  const isDisconnect = () => {
    if (isCompetitionMode()) {
      return (all_player_data[props.player_id]?.online ?? 0) == 0;
    }
    return false;
  };
  const avatarMedal = () => {
    const ornamentData = getServiceNetTable("player_equipped_ornament", props.player_id);
    if (ornamentData && ornamentData[OrnamentType.MEDAL]) {
      return Object.keys(ornamentData[OrnamentType.MEDAL])[0];
    }
  };
  let cardContainerRef;
  const selfCardEffect = () => {
    if (props.player_id == undefined) return;
    if (!props.illusion) {
      return notifyCardEffectStore[props.player_id];
    }
  };
  const selfTriggerState = () => {
    if (props.player_id == undefined) return false;
    if (!props.illusion) {
      return cardEffectClassTrigger[props.player_id] ?? false;
    }
    return false;
  };
  const lastNotifyState = {
    id: -1,
    card: ""
  };
  const OnNotifyTigger = playerID => {
    if (cardEffectClassTrigger[playerID]) {
      setCardEffectClassTrigger(playerID, undefined);
      return true;
    }
    return false;
  };
  const TriggerCardEffectNotify = self => {
    if (self?.IsValid() && props.player_id != undefined) {
      if (selfCardEffect()) {
        self.SetHasClass("Show", true);
        self.RemoveClass("HidePopupIn");
        if (selfTriggerState()) {
          OnNotifyTigger(props.player_id);
          self.TriggerClass("ShowPopupOut");
        }
        lastNotifyState.id = props.player_id;
        lastNotifyState.card = selfCardEffect();
      } else {
        if (lastNotifyState.id == props.player_id && lastNotifyState.card != "") {
          self.TriggerClass("HidePopupIn");
        }
        self.SetHasClass("Show", false);
        self.RemoveClass("ShowPopupOut");
        lastNotifyState.id = -1;
        lastNotifyState.card = "";
      }
    }
  };
  libs.createEffect(() => {
    TriggerCardEffectNotify(cardContainerRef);
  });
  const showPlayerSelectButton = () => {
    let list = playerSelectionData();
    if (!list || props.player_id == undefined || props.player_state == "dead" || props.illusion) return false;
    if (props.index == 0 && props.player_id == localPlayerID) {
      setSelectAbilityImgIndex(1);
    } else if (props.index == 0 && props.player_id != localPlayerID) {
      setSelectAbilityImgIndex(0);
    }
    return list.includes(props.player_id);
  };
  return (() => {
    const _el$2 = libs.createElement("Panel", {
        hittest: false
      }, null),
      _el$4 = libs.createElement("Panel", {
        id: "PlayerBattleContainer",
        hittest: false
      }, _el$2),
      _el$5 = libs.createElement("Panel", {
        id: "RegameStateContainer"
      }, _el$2),
      _el$6 = libs.createElement("Panel", {
        id: "EomjiContainer",
        hittest: false
      }, _el$2),
      _el$9 = libs.createElement("Panel", {
        id: "SelectButtonContainer",
        hittest: false
      }, _el$2),
      _el$1 = libs.createElement("Panel", {
        id: "CardContainer",
        hittest: false
      }, _el$2);
    libs.insert(_el$2, libs.createComponent(EOM_Panel.EOM_Panel, {
      id: "RankContainer",
      get children() {
        return libs.createComponent(RankTierIcon.RankTierIcon, {
          size: "64",
          get player_id() {
            return props.player_id;
          },
          showtooltip: true
        });
      }
    }), _el$4);
    libs.insert(_el$2, libs.createComponent(EOM_Panel.EOM_Panel, {
      className: "PlayerRowMain",
      hittest: false,
      get children() {
        return [libs.createComponent(Player.PlayerRowBGOrnament, {
          get team_mode() {
            return isGroupMode();
          },
          get playerID() {
            return props.player_id;
          },
          hittest: false,
          get children() {
            return libs.createComponent(libs.Show, {
              get when() {
                return !isGroupMode();
              },
              get children() {
                return libs.createComponent(libs.Show, {
                  get when() {
                    return props.player_state == "dead" || props.rank == 1;
                  },
                  fallback: () => libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "HealthCircle",
                    hittest: false,
                    hittestchildren: false,
                    get children() {
                      return [libs.createComponent(EOM_Image.EOM_Image, {
                        className: "Circle",
                        get style() {
                          return {
                            clip: `radial( 50.0% 50.0%, 0deg, ${healthDeg()}deg)`
                          };
                        }
                      }), libs.createComponent(GenericPanel.CLabel, {
                        get text() {
                          return health();
                        }
                      })];
                    }
                  }),
                  get children() {
                    return libs.createComponent(EOM_Panel.EOM_Panel, {
                      id: "PlayerRankContainer",
                      hittest: false,
                      hittestchildren: false,
                      get children() {
                        return [libs.createComponent(GenericPanel.CImage, {
                          get className() {
                            return libs.classNames("PlayerRankBG", "Rank" + props.rank);
                          }
                        }), libs.createComponent(EOM_Label.EOM_Label, {
                          className: "PlayerRank",
                          get text() {
                            return props.rank > 3 ? props.rank : "";
                          }
                        })];
                      }
                    });
                  }
                });
              }
            });
          }
        }), libs.createComponent(EOM_Button.EOM_BaseButton, {
          id: "PlayerRowMainContainer",
          onactivate: self => {
            props.onSelect();
          },
          get children() {
            return [libs.createComponent(Player.PlayerAvatar, {
              get steamID() {
                return all_player_data[props.player_id].steamID;
              },
              get playerID() {
                return props.player_id;
              },
              get disconnect() {
                return isDisconnect();
              },
              get ban() {
                return isNameBan(props.player_id);
              },
              get ai_host() {
                return all_player_data[props.player_id].ai_host == 1;
              },
              get customTooltip() {
                return {
                  name: "player_profile",
                  playerID: props.player_id
                };
              },
              onactivate: () => {
                GameUI.SetProfilePlayerId(props.player_id ?? localPlayerID);
                ToggleWindows('MenuButton_profile', true);
              }
            }), libs.createComponent(EOM_Panel.EOM_Panel, {
              className: "InfoContainer",
              get customTooltip() {
                return {
                  name: "player_info",
                  playerID: String(props.player_id)
                };
              },
              onmouseover: p => {
                if (playerInfoTooltipTimer) {
                  $.CancelScheduled(playerInfoTooltipTimer);
                }
                playerInfoTooltipTimer = $.Schedule(0.06, () => {
                  playerInfoTooltipTimer = undefined;
                  ShowCustomTooltip(p, "player_info", {
                    playerID: String(props.player_id)
                  });
                });
              },
              onmouseout: p => {
                if (playerInfoTooltipTimer) {
                  $.CancelScheduled(playerInfoTooltipTimer);
                  playerInfoTooltipTimer = undefined;
                }
                HideCustomTooltip(p, "player_info");
              },
              get children() {
                return libs.createComponent(EOM_Panel.EOM_Panel, {
                  marginLeft: "10px",
                  width: "100%",
                  height: "100%",
                  get children() {
                    return [libs.createComponent(Player.PlayerName, {
                      get classList() {
                        return {
                          Short: IsNewOrRegressionPlayer(all_player_data[props.player_id].steamID)
                        };
                      },
                      get steamID() {
                        return all_player_data[props.player_id].steamID;
                      },
                      get playerID() {
                        return props.player_id;
                      },
                      get ban() {
                        return isNameBan(props.player_id);
                      }
                    }), libs.createComponent(libs.Show, {
                      get when() {
                        return IsNewOrRegressionPlayer(all_player_data[props.player_id].steamID);
                      },
                      get children() {
                        return libs.createComponent(NewRegressionIcon.NewRegressionIcon, {
                          show_tooltip: true
                        });
                      }
                    }), libs.createComponent(EOM_Panel.EOM_Panel, {
                      flowChildren: "right",
                      verticalAlign: "bottom",
                      marginBottom: "4px",
                      get children() {
                        return [libs.createComponent(GenericPanel.CImage, {
                          id: "GoldIcon"
                        }), libs.createComponent(GenericPanel.CLabel, {
                          id: "LevelLabel",
                          get text() {
                            return all_player_data[props.player_id].gold;
                          }
                        }), libs.createComponent(GenericPanel.CImage, {
                          id: "DamageIcon"
                        }), libs.createComponent(GenericPanel.CLabel, {
                          id: "DamageLabel",
                          get classList() {
                            return {
                              FinalBo3Fighting: finalBo3Fighting() && (props.player_state == "fighting" || props.player_state == "win" || props.player_state == "loss")
                            };
                          },
                          get text() {
                            return all_player_data[props.player_id].damage;
                          }
                        })];
                      }
                    })];
                  }
                });
              }
            }), libs.createElement("Panel", {
              id: "SelectedIcon",
              hittest: false
            }, null)];
          }
        })];
      }
    }), _el$4);
    libs.insert(_el$4, libs.createComponent(libs.Show, {
      get when() {
        return uiState() == PLAYER_LIST_UI_STATES.battle && props.game_mode == "single" && props.player_state == "fighting" && props.index % 2 == 0;
      },
      get children() {
        return [libs.createComponent(GenericPanel.CImage, {
          id: "BattlingBG"
        }), libs.createComponent(EOM_Panel.EOM_Panel, {
          className: "InCombatIcon",
          get children() {
            return [libs.createComponent(GenericPanel.CImage, {
              id: "Sword1"
            }), libs.createComponent(GenericPanel.CImage, {
              id: "Sword2"
            })];
          }
        })];
      }
    }));
    libs.insert(_el$2, libs.createComponent(libs.Show, {
      get when() {
        return libs.memo(() => !!props.roshan_treasure)() && roshan_reward_selection() != undefined;
      },
      get children() {
        return libs.createComponent(libs.Switch, {
          get children() {
            return [libs.createComponent(libs.Match, {
              get when() {
                return Object.keys(roshan_reward_selection().player_selection).map(Number).includes(props.player_id);
              },
              get children() {
                return libs.createComponent(EOM_Image.EOM_Image, {
                  id: "RoshanRewardSelected",
                  get backgroundImage() {
                    return getImagePath("icon/selected.png");
                  }
                });
              }
            }), libs.createComponent(libs.Match, {
              get when() {
                return roshan_reward_selection().selecting == props.player_id;
              },
              get children() {
                return libs.createComponent(EOM_Panel.EOM_Panel, {
                  className: "RoshanCountDownBar",
                  get children() {
                    return libs.createComponent(EOM_Panel.EOM_Panel, {
                      id: "RoshanCountDownBarIn",
                      get width() {
                        return `${Math.min(100, Math.max(roshanCountDown(), 0) / 10 * 100)}%`;
                      }
                    });
                  }
                });
              }
            })];
          }
        });
      }
    }), _el$5);
    libs.insert(_el$2, libs.createComponent(EOM_Panel.EOM_Panel, {
      id: "CommonInfoContainer",
      hittest: false,
      get children() {
        return libs.createComponent(EOM_Panel.EOM_Panel, {
          align: "center center",
          overflow: "noclip",
          style: {
            minWidth: "35px"
          },
          get children() {
            return libs.createComponent(libs.Show, {
              get when() {
                return uiState() != PLAYER_LIST_UI_STATES.roshan;
              },
              get children() {
                return [libs.createComponent(libs.Switch, {
                  get children() {
                    return [libs.createComponent(libs.Match, {
                      get when() {
                        return libs.memo(() => props.player_state == "win")() && game_state() == "GameState_ExtraBattlePrepare" || props.player_state == "fighting" && finalBo3Fighting();
                      },
                      get children() {
                        return libs.createComponent(EOM_Image.EOM_Image, {
                          id: "PlayerVersusIcon",
                          verticalAlign: "center",
                          get backgroundImage() {
                            return getImagePath("hud/s11_vs.png");
                          },
                          width: "38px",
                          height: "50px",
                          tooltip_text: "#TeamFinalBo3Damage",
                          tooltipPosition: "right"
                        });
                      }
                    }), libs.createComponent(libs.Match, {
                      get when() {
                        return props.player_state == "checked" || props.player_state == "win";
                      },
                      get children() {
                        return libs.createComponent(EOM_Image.EOM_Image, {
                          id: "PlayerCheckedIcon",
                          verticalAlign: "center",
                          get backgroundImage() {
                            return getImagePath("icon/icon_party_ready_psd.png");
                          },
                          width: "35px",
                          height: "34px"
                        });
                      }
                    }), libs.createComponent(libs.Match, {
                      get when() {
                        return libs.memo(() => props.player_state == "loss")() && game_state() != "GameState_ExtraBattlePrepare";
                      },
                      get children() {
                        return libs.createComponent(libs.Show, {
                          get when() {
                            return libs.memo(() => !!!props.illusion)() && uiState() == PLAYER_LIST_UI_STATES.battle;
                          },
                          get fallback() {
                            return (libs.createComponent(EOM_Image.EOM_Image, {
                                verticalAlign: "center",
                                get backgroundImage() {
                                  return getImagePath("icon/icon_party_reject_psd.png");
                                },
                                width: "35px",
                                height: "34px"
                              })
                            );
                          },
                          get children() {
                            return libs.createComponent(EOM_Panel.EOM_Panel, {
                              flowChildren: "right",
                              verticalAlign: "center",
                              get children() {
                                return [libs.createComponent(EOM_Label.EOM_Label, {
                                  id: "TakeDamage",
                                  get text() {
                                    return "-" + props.take_damage;
                                  }
                                }), libs.createComponent(GenericPanel.CImage, {
                                  id: "TakeDamageIcon"
                                })];
                              }
                            });
                          }
                        });
                      }
                    }), libs.createComponent(libs.Match, {
                      get when() {
                        return props.player_state == "loading";
                      },
                      get children() {
                        return libs.createComponent(EOM_Loading.EOM_Loading, {
                          verticalAlign: "center",
                          type: "Wave"
                        });
                      }
                    }), libs.createComponent(libs.Match, {
                      get when() {
                        return (uiState() == PLAYER_LIST_UI_STATES.neutral || props.game_mode == "group") && props.player_state == "fighting";
                      },
                      get children() {
                        return libs.createComponent(EOM_Panel.EOM_Panel, {
                          className: "InCombatIcon",
                          get children() {
                            return [libs.createComponent(GenericPanel.CImage, {
                              id: "Sword1"
                            }), libs.createComponent(GenericPanel.CImage, {
                              id: "Sword2"
                            })];
                          }
                        });
                      }
                    })];
                  }
                }), libs.createComponent(libs.Switch, {
                  get children() {
                    return [libs.createComponent(libs.Match, {
                      get when() {
                        return libs.memo(() => avatarMedal() != undefined)() && avatarMedal() != "5750000";
                      },
                      get children() {
                        return libs.createComponent(WinStreak.PlayerAvatarMedal, {
                          get oid() {
                            return avatarMedal();
                          }
                        });
                      }
                    }), libs.createComponent(libs.Match, {
                      get when() {
                        return isBlackList(all_player_data[props.player_id].steamID ?? "0");
                      },
                      get children() {
                        return libs.createComponent(GenericPanel.CImage, {
                          id: "Douyu"
                        });
                      }
                    }), libs.createComponent(libs.Match, {
                      get when() {
                        return isGMList(all_player_data[props.player_id].steamID ?? "0");
                      },
                      get children() {
                        return libs.createComponent(GenericPanel.CImage, {
                          id: "GMIcon"
                        });
                      }
                    }), libs.createComponent(libs.Match, {
                      get when() {
                        return isTranslatorList(all_player_data[props.player_id].steamID ?? "0");
                      },
                      get children() {
                        return libs.createComponent(GenericPanel.CImage, {
                          id: "TranslatorIcon",
                          get ["class"]() {
                            return $.Language().toLowerCase();
                          }
                        });
                      }
                    })];
                  }
                })];
              }
            });
          }
        });
      }
    }), _el$5);
    libs.insert(_el$5, libs.createComponent(libs.Show, {
      get when() {
        return (props.player_state == "dead" || all_player_data[props.player_id].rank == 1) && all_player_data[props.player_id].regame_state == 1;
      },
      get children() {
        return libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "Regame",
          get children() {
            return [libs.createComponent(EOM_Panel.EOM_Panel, {
              id: "RegameIcon"
            }), libs.createComponent(EOM_Label.EOM_Label, {
              text: "#EndScreen_RestartGame"
            })];
          }
        });
      }
    }));
    libs.insert(_el$6, libs.createComponent(libs.Show, {
      get when() {
        return playerEmoji[props.player_id]?.emoji_index != undefined;
      },
      get children() {
        const _el$7 = libs.createElement("Panel", {
            id: "EmojiBG"
          }, null),
          _el$8 = libs.createElement("Image", {
            get ["class"]() {
              return "eomji_" + playerEmoji[props.player_id]?.emoji_index;
            },
            get src() {
              return getCosmeticImagePath(playerEmoji[props.player_id]?.emoji_index ?? "");
            }
          }, _el$7);
        libs.effect(_p$ => {
          const _v$ = "eomji_" + playerEmoji[props.player_id]?.emoji_index,
            _v$2 = getCosmeticImagePath(playerEmoji[props.player_id]?.emoji_index ?? "");
          _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$8, "class", _v$, _p$._v$));
          _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$8, "src", _v$2, _p$._v$2));
          return _p$;
        }, {
          _v$: undefined,
          _v$2: undefined
        });
        return _el$7;
      }
    }));
    libs.insert(_el$9, libs.createComponent(libs.Show, {
      get when() {
        return showPlayerSelectButton();
      },
      get children() {
        return libs.createComponent(EOM_Button.EOM_Button, {
          className: "PlayerSelectionButton",
          type: "P2",
          text: "#ButtonConfirm",
          onactivate: () => {
            GameEvents.SendCustomEventToServer("select_player", {
              player_id: props.player_id
            });
          }
        });
      }
    }));
    libs.insert(_el$2, libs.createComponent(libs.Show, {
      get when() {
        return libs.memo(() => !!(showPlayerSelectButton() && selectAbility$1() != ""))() && props.index == selectAbilityImgIndex();
      },
      get children() {
        return [libs.createComponent(libs.Show, {
          get when() {
            return abilityIsTrait$1();
          },
          get children() {
            return libs.createComponent(EOM_Image.EOM_Image, {
              id: "ButtonLeftImg",
              get backgroundImage() {
                return getImagePath("rune/rune_reward_icon.png");
              },
              onmouseover: self => {
                $.DispatchEvent("DOTAShowTitleTextTooltip", self, "#DOTA_Tooltip_ability_" + selectAbility$1(), getAbilityDescription(selectAbility$1(), 1, undefined));
              },
              onmouseout: self => {
                $.DispatchEvent("DOTAHideTitleTextTooltip", self);
              }
            });
          }
        }), libs.createComponent(libs.Show, {
          get when() {
            return !abilityIsTrait$1();
          },
          get children() {
            const _el$0 = libs.createElement("DOTAAbilityImage", {
              id: "ButtonLeftImg",
              get abilityname() {
                return selectAbility$1();
              },
              showtooltip: true
            }, null);
            libs.effect(_$p => libs.setProp(_el$0, "abilityname", selectAbility$1(), _$p));
            return _el$0;
          }
        })];
      }
    }), _el$1);
    libs.insert(_el$1, libs.createComponent(EOM_Panel.EOM_Panel, {
      ref(r$) {
        const _ref$ = cardContainerRef;
        typeof _ref$ === "function" ? _ref$(r$) : cardContainerRef = r$;
      },
      className: "CardEffectNotification",
      onload: self => {
        TriggerCardEffectNotify(self);
      },
      hittest: false,
      get children() {
        return [libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "CardEffectNotificationBG",
          get customTooltip() {
            return {
              name: "card_effect",
              playerID: props.player_id,
              concise: 1,
              team_mode: Number(isGroupMode())
            };
          },
          get children() {
            return libs.createComponent(EOM_Panel.EOM_Panel, {
              id: "FlowShineBorder",
              hittest: false
            });
          }
        }), libs.createComponent(EOM_Image.EOM_Image, {
          id: "CardEffectImage",
          hittest: false
        })];
      }
    }));
    libs.effect(_$p => libs.setProp(_el$2, "className", libs.classNames("PlayerRow", "No_" + props.index, "BackgroundColor_" + props.background_color, {
      IsSelf: props.player_id == localPlayerID && !props.illusion,
      HealthMid: isTurboMode() ? health() <= 8 : health() <= 20,
      HealthLow: isTurboMode() ? health() <= 4 : health() <= 10,
      IsSelected: props.selected,
      IsVictory: props.game_mode == "single" && props.player_state == "win",
      IsLoss: props.game_mode == "single" && props.player_state == "loss",
      IsDead: props.player_state == "dead",
      isRankMode: isRankMode() || isKingsRankMode(),
      IsBattle: props.game_mode == "single" && uiState() == PLAYER_LIST_UI_STATES.battle,
      IsClone: props.illusion,
      IsDisconnected: isDisconnect(),
      RoshanSelection: props.roshan_treasure,
      GroupSelecting: props.group_selecting,
      ShowPeakScore: isCompetitionMode()
    }), _$p));
    return _el$2;
  })();
};
const [playerEmoji, setPlayerEmoji] = libs.createStore({
  [0]: {
    emoji_index: undefined,
    timer: undefined
  },
  [1]: {
    emoji_index: undefined,
    timer: undefined
  },
  [2]: {
    emoji_index: undefined,
    timer: undefined
  },
  [3]: {
    emoji_index: undefined,
    timer: undefined
  },
  [4]: {
    emoji_index: undefined,
    timer: undefined
  },
  [5]: {
    emoji_index: undefined,
    timer: undefined
  },
  [6]: {
    emoji_index: undefined,
    timer: undefined
  },
  [7]: {
    emoji_index: undefined,
    timer: undefined
  }
});
const [playerCard, setPlayerCard] = libs.createStore({
  [0]: false,
  [1]: false,
  [2]: false,
  [3]: false,
  [4]: false,
  [5]: false,
  [6]: false,
  [7]: false
});
const [round, setRound] = libs.createSignal(CustomNetTables.GetTableValue("common", "round_data")?.round_number ?? 1);
(() => {
  GameEvents.Subscribe("client_side_event", eventData => {
    if (eventData.event_name == "emoji_dialog" || eventData.event_name == "hero_emoji_dialog") {
      let data = JSON.parse(eventData.event_data);
      let playerID = data.playerID;
      const emojiData = playerEmoji?.[playerID];
      if (emojiData != undefined) {
        if (emojiData.timer != undefined) {
          $.CancelScheduled(emojiData.timer);
        }
        let timer = undefined;
        if (data.index == 16) {
          timer = $.Schedule(6, () => {
            let timer = playerEmoji?.[playerID].timer;
            if (timer != undefined) {
              setPlayerEmoji(playerID, pre => {
                return {
                  emoji_index: undefined,
                  timer: undefined
                };
              });
            }
          });
        } else {
          timer = $.Schedule(3, () => {
            let timer = playerEmoji?.[playerID].timer;
            if (timer != undefined) {
              setPlayerEmoji(playerID, pre => {
                return {
                  emoji_index: undefined,
                  timer: undefined
                };
              });
            }
          });
        }
        setPlayerEmoji(playerID, pre => {
          return {
            emoji_index: data.index.toString(),
            timer: timer
          };
        });
      }
    }
  });
  CustomNetTables.SubscribeNetTableListener("common", (tableName, key, value) => {
    if (key.indexOf("card_effect_list_") != -1) {
      let playerID = finiteNumber(Number(key.slice(-1)), -1);
      if (playerID != -1) {
        let list = Object.values(value);
        list.forEach(v => {
          if (v.round == round()) {
            setPlayerCard(playerID, true);
          }
        });
      }
    } else if (key == "round_data") {
      setRound(value.round_number);
      setPlayerCard(0, false);
      setPlayerCard(1, false);
      setPlayerCard(2, false);
      setPlayerCard(3, false);
      setPlayerCard(4, false);
      setPlayerCard(5, false);
      setPlayerCard(6, false);
      setPlayerCard(7, false);
    }
  });
})();

const [sectSelection, setSectSelection] = libs.createSignal();
libs.createSignal(true);
const [selectAbility, setSelectAbility] = libs.createSignal("");
const abilityIsTrait = () => {
  if (selectAbility() == "") {
    return false;
  }
  const strArr = selectAbility().split("_");
  if (strArr[0] == "trait") {
    return true;
  }
  return false;
};
let tip4 = true;
function SectList() {
  const localPlayerID = Players.GetLocalPlayer().toString();
  const [level, setLevel] = libs.createSignal(1);
  const [banListNet, _setBanListNet] = libs.createSignal(CustomNetTables.GetTableValue("common", "ban_list"));
  const [round, SetRound] = libs.createSignal(CustomNetTables.GetTableValue("common", "round_data")?.round_number ?? 0);
  const [rookieRecommend, setRookieRecommend] = libs.createSignal();
  const [gameState, setGameState] = libs.createSignal(CustomNetTables.GetTableValue("common", "game_state")?.state ?? "GameState_None");
  const banList = () => Object.values(banListNet() ?? {});
  const pickList = libs.createMemo(() => {
    return Object.keys(KeyValues.SectAbilitiesKv).filter(v => {
      return !banList().includes(v);
    });
  });
  const [cityEffect, setCityEffect] = libs.createSignal();
  let sectDataKey = () => "sect_data_" + localPlayerID;
  let sectModifiersKey = () => "sect_modifiers_" + localPlayerID;
  let showID = () => Players.GetLocalPlayer();
  if (isSpectator()) {
    showID = () => GameUI.GetSpectatorViewingInfo()?.player_id ?? Players.GetLocalPlayer();
    sectDataKey = libs.createMemo(() => {
      return "sect_data_" + (GameUI.GetSpectatorViewingInfo()?.player_id ?? localPlayerID);
    });
    sectModifiersKey = libs.createMemo(() => {
      return "sect_modifiers_" + (GameUI.GetSpectatorViewingInfo()?.player_id ?? localPlayerID);
    });
    libs.createEffect(() => {
      const spectatorid = GameUI.GetSpectatorViewingInfo().player_id;
      setLevel(getPlayerData(spectatorid, "heroLevel") ?? 1);
    });
    libs.onMount(() => {
      let id = CustomNetTables.SubscribeNetTableListener("player_data", (_, k, v) => {
        const playerID = Number(k);
        const spectatorid = GameUI.GetSpectatorViewingInfo().player_id;
        if (spectatorid == playerID) {
          setLevel(v.heroLevel);
        }
      });
      libs.onCleanup(() => {
        CustomNetTables.UnsubscribeNetTableListener(id);
      });
    });
  } else if (isGroupMode()) {
    const [allyPlayers, setAllyPlayers] = libs.createSignal([]);
    const [viewID, setViewID] = libs.createSignal(Players.GetLocalPlayer());
    showID = libs.createMemo(() => {
      if (allyPlayers().includes(viewID())) {
        return viewID();
      }
      return Players.GetLocalPlayer();
    });
    sectDataKey = libs.createMemo(() => {
      return "sect_data_" + showID();
    });
    sectModifiersKey = libs.createMemo(() => {
      return "sect_modifiers_" + showID();
    });
    netdata_utils.createNetTableEffect("player_data", String(Players.GetLocalPlayer()), data => {
      setAllyPlayers(Object.values(data.teammates ?? {}));
      setViewID(data.viewPlayerInfo.player_id);
    });
    libs.createEffect(() => {
      setLevel(getPlayerData(showID(), "heroLevel") ?? 1);
    });
    libs.onMount(() => {
      let id = CustomNetTables.SubscribeNetTableListener("player_data", (_, k, v) => {
        const playerID = Number(k);
        if (showID() == playerID) {
          setLevel(v.heroLevel);
        }
      });
      libs.onCleanup(() => {
        CustomNetTables.UnsubscribeNetTableListener(id);
      });
    });
  }
  const [bannedSect, setBannedSect] = libs.createSignal();
  const [sectData, setSectData] = libs.createSignal(CustomNetTables.GetTableValue("sect_data", sectDataKey()) ?? {});
  const [sectModifiers, setSectModifiers] = libs.createSignal(CustomNetTables.GetTableValue("sect_data", sectModifiersKey()) ?? {});
  libs.createEffect(() => {
    setSectData(CustomNetTables.GetTableValue("sect_data", sectDataKey()) ?? {});
    setSectModifiers(CustomNetTables.GetTableValue("sect_data", sectModifiersKey()) ?? {});
  });
  libs.onMount(() => {
    const eventList = [];
    let netTableIDs = [];
    netTableIDs.push(useNetTableKey("common", "game_state", data => {
      if (data.state == "GameState_Prepare" && rookieRecommend() != undefined) {
        if (round() == 1) {
          const sect = rookieRecommend()?.sects;
          if (sect) {
            rookieTip("sect", "#RookieTip2", {
              sect1: sect[0] ?? "",
              sect2: sect[1] ?? ""
            });
          }
        }
        if (round() == 2) {
          rookieTip("gold", "#RookieTip3");
        }
      }
      setGameState(data.state);
    }));
    netTableIDs.push(useNetTableKey("common", "round_data", data => {
      SetRound(data.round_number);
    }));
    netTableIDs.push(CustomNetTables.SubscribeNetTableListener("sect_data", (_, key, value) => {
      if (key == sectDataKey()) {
        setSectData(value);
      } else if (key == sectModifiersKey()) {
        setSectModifiers(value);
      }
    }));
    if (!isSpectator() && !isGroupMode()) {
      netTableIDs.push(useNetTableKeyHasDefaultValue("player_data", localPlayerID, data => {
        setLevel(data.heroLevel);
        setBannedSect(data?.bannedSect);
      }));
    }
    netTableIDs.push(useNetTableKeyHasDefaultValue("common", "city_effect", data => {
      setCityEffect(data.name);
    }));
    netTableIDs.push(useNetTableKeyHasDefaultValue("common", "sect_selection_" + Players.GetLocalPlayer(), data => {
      let arr = Object.values(data?.sects ?? []);
      if (arr.length > 0) {
        setSelectAbility(data?.ability_name ?? "");
        setSectSelection(arr);
      } else {
        setSectSelection();
      }
    }));
    eventList.push(useNetData("rookie_recommend", data => {
      setRookieRecommend(data);
    }, Players.GetLocalPlayer()));
    libs.onCleanup(() => {
      netTableIDs.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
      eventList.forEach(id => GameEvents.Unsubscribe(id));
    });
  });
  libs.createEffect(libs.on(level, v => {
    if (gameState() == "GameState_Prepare" && v == 2 && rookieRecommend() != undefined && tip4) {
      let sectName;
      let data = sectData();
      if (data) {
        for (const _sectName in data) {
          if (data[_sectName].level > 0) {
            sectName = _sectName;
          }
        }
      }
      if (sectName) {
        tip4 = false;
        rookieTip("level", "#RookieTip4", {
          sect: sectName
        });
      }
    }
  }));
  const sectListSorted = () => {
    return pickList().sort((a, b) => multiCompare((sectData()?.[b]?.exp ?? 0) - (sectData()?.[a]?.exp ?? 0), (sectData()?.[b]?.level ?? 0) - (sectData()?.[a]?.level ?? 0)));
  };
  libs.createEffect(() => {
    const id = CustomNetTables.SubscribeNetTableListener("common", function (_, k, v) {
      if (k === "ban_list") {
        _setBanListNet(v);
      }
    });
    libs.onCleanup(() => {
      CustomNetTables.UnsubscribeNetTableListener(id);
    });
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "SectContainer",
    hittest: false,
    get children() {
      return libs.createComponent(EOM_Panel.EOM_Panel, {
        flowChildren: "down",
        hittest: false,
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "BanList",
            get children() {
              return banList().map(sectName => {
                return libs.createComponent(EOM_Panel.EOM_Panel, {
                  verticalAlign: "center",
                  width: "56px",
                  height: "56px",
                  customTooltip: {
                    name: "player_sect_list",
                    sectName: sectName,
                    concise: 1
                  },
                  tooltipPosition: "bottom",
                  get children() {
                    return [libs.createComponent(SectIcon.SectIcon, {
                      className: "BanSect",
                      width: "56px",
                      height: "56px",
                      sectName: sectName
                    }), libs.createComponent(EOM_Image.EOM_Image, {
                      width: "36px",
                      height: "36px",
                      align: "center center",
                      get backgroundImage() {
                        return getImagePath("icon/s_ban.png");
                      }
                    })];
                  }
                });
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            horizontalAlign: "right",
            get children() {
              return [libs.createComponent(libs.Show, {
                get when() {
                  return libs.memo(() => !!getGameplayModuleState("city_effect"))() && cityEffect() != undefined;
                },
                get children() {
                  return libs.createComponent(CityImage.CityImage, {
                    get city_name() {
                      return cityEffect();
                    },
                    get customTooltip() {
                      return {
                        name: "city_effect",
                        abilityName: cityEffect()
                      };
                    }
                  });
                }
              }), libs.createComponent(GenericPanel.CImage, {
                id: "Rainbow",
                hittest: false
              }), libs.createComponent(GenericPanel.CLabel, {
                id: "Lv",
                text: "LV."
              }), libs.createComponent(EOM_XP.EOM_XP, {
                get level() {
                  return level();
                },
                maxLevel: 100,
                get dialogVariables() {
                  return {
                    value: level()
                  };
                },
                onmouseover: self => {
                  $.DispatchEvent("DOTAShowTitleTextTooltip", self, $.Localize("#PlayerInfo_Level", self), $.Localize("#PlayerInfo_Level_description", self));
                },
                onmouseout: self => {
                  $.DispatchEvent("DOTAHideTitleTextTooltip", self);
                }
              })];
            }
          }), libs.createComponent(libs.Index, {
            get each() {
              return sectListSorted();
            },
            children: (sectName, i) => {
              const sectInfo = libs.createMemo(() => sectData()?.[sectName()] ?? {
                level: 0,
                bonusLevel: 0,
                exp: 0,
                maxExp: 8
              });
              const counts = libs.createMemo(() => {
                const sectModifier = sectModifiers()?.[sectName()] ?? {};
                const _counts = {};
                for (let k in sectModifier) {
                  if (!_counts[sectModifier[k]]) {
                    _counts[sectModifier[k]] = 1;
                  } else _counts[sectModifier[k]]++;
                }
                return _counts;
              });
              return libs.createComponent(SectRow, {
                get player_id() {
                  return showID();
                },
                get banned() {
                  return bannedSect() == sectName();
                },
                get sectName() {
                  return sectName();
                },
                get exp() {
                  return sectInfo().exp;
                },
                get maxExp() {
                  return sectInfo().maxExp;
                },
                get level() {
                  return sectInfo().level;
                },
                get maxLevel() {
                  return 4 + sectInfo().bonusLevel;
                },
                sect_index: i,
                get showConfirm() {
                  return sectSelection()?.includes(sectName());
                },
                get artifactList() {
                  return counts();
                },
                get rookie() {
                  return (rookieRecommend()?.sects?.indexOf(sectName()) ?? 100000) <= 1;
                }
              });
            }
          })];
        }
      });
    }
  });
}
const SectRow = props => {
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    get className() {
      return libs.classNames("SectRow", {
        Level0: props.level == 0,
        banned: props.banned
      });
    },
    get customTooltip() {
      return {
        name: "player_sect_list",
        sr_reveal: 1,
        sectName: props.sectName,
        player_id: props.player_id
      };
    },
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        flowChildren: "right",
        marginRight: "180px",
        verticalAlign: "center",
        get children() {
          return [libs.memo(() => Object.keys(props.artifactList).map((key, index) => {
            return libs.createComponent(EOM_Panel.EOM_Panel, {
              className: "ModifierItem",
              verticalAlign: "center",
              get children() {
                return [(() => {
                  const _el$6 = libs.createElement("DOTAItemImage", {
                    itemname: key,
                    scaling: "stretch-to-cover-preserve-aspect"
                  }, null);
                  libs.setProp(_el$6, "itemname", key);
                  libs.setProp(_el$6, "className", "ModifierItemImage");
                  return _el$6;
                })(), libs.createComponent(GenericPanel.CLabel, {
                  className: "ModifierItemLabel",
                  get text() {
                    return props.artifactList[key];
                  },
                  get visible() {
                    return props.artifactList[key] > 1;
                  }
                })];
              }
            });
          })), libs.createComponent(libs.Show, {
            get when() {
              return props.showConfirm;
            },
            get children() {
              return libs.createComponent(EOM_Button.EOM_Button, {
                className: "SectSelectionButton",
                type: "P2",
                text: "#ButtonConfirm",
                onactivate: () => {
                  GameEvents.SendCustomEventToServer("select_sect", {
                    sect: props.sectName
                  });
                }
              });
            }
          })];
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return props.showConfirm && selectAbility() != "" && props.sect_index == 0;
        },
        get children() {
          return [libs.createComponent(libs.Show, {
            get when() {
              return abilityIsTrait();
            },
            get children() {
              return libs.createComponent(EOM_Image.EOM_Image, {
                id: "ButtonLeftImg",
                get backgroundImage() {
                  return getImagePath("rune/rune_reward_icon.png");
                },
                onmouseover: self => {
                  $.DispatchEvent("DOTAShowTitleTextTooltip", self, "#DOTA_Tooltip_ability_" + selectAbility(), getAbilityDescription(selectAbility(), 1, undefined));
                },
                onmouseout: self => {
                  $.DispatchEvent("DOTAHideTitleTextTooltip", self);
                }
              });
            }
          }), libs.createComponent(libs.Show, {
            get when() {
              return !abilityIsTrait();
            },
            get children() {
              const _el$ = libs.createElement("DOTAAbilityImage", {
                id: "ButtonLeftImg",
                get abilityname() {
                  return selectAbility();
                },
                showtooltip: true
              }, null);
              libs.effect(_$p => libs.setProp(_el$, "abilityname", selectAbility(), _$p));
              return _el$;
            }
          })];
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return props.exp > 0;
        },
        get children() {
          const _el$2 = libs.createElement("Panel", {}, null),
            _el$3 = libs.createElement("Panel", {}, _el$2),
            _el$4 = libs.createElement("Image", {}, _el$2);
          libs.setProp(_el$2, "className", "ExpPanel");
          libs.setProp(_el$3, "className", "ExpProgressBG");
          libs.insert(_el$2, libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "ExpProgress",
            get width() {
              return props.level / props.maxLevel * 59 + "px";
            }
          }), _el$4);
          libs.setProp(_el$4, "className", "ExpShield");
          libs.insert(_el$2, libs.createComponent(GenericPanel.CLabel, {
            className: "ExpLabel",
            get text() {
              return props.exp;
            }
          }), null);
          libs.insert(_el$2, libs.createComponent(GenericPanel.CLabel, {
            className: "ExpMaxLabel",
            get text() {
              return "/" + props.maxExp;
            }
          }), null);
          return _el$2;
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return props.rookie;
        },
        get children() {
          return libs.createElement("Image", {
            id: "SmallRookie"
          }, null);
        }
      }), libs.createComponent(SectIcon.SectIcon, {
        get sectName() {
          return props.sectName;
        },
        get active() {
          return props.exp > 0;
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "SectBannedIcon",
        hittest: false
      })];
    }
  });
};

const RightTopArea = props => {
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "RightTopArea",
    get classList() {
      return {
        HideList: props.game_state == "GameState_GreevilEgg"
      };
    },
    hittest: false,
    get children() {
      return [libs.createComponent(SectList, {}), libs.createComponent(ArtifactList, {})];
    }
  });
};
const DOTA_ITEM_INVENTORY_MIN = 0;
const DOTA_ITEM_INVENTORY_MAX = 2;
const getArtifactList = (playerID = Players.GetLocalPlayer()) => {
  let items = [];
  const heroIndex = Players.GetPlayerHeroEntityIndex(playerID);
  for (let slot = DOTA_ITEM_INVENTORY_MIN; slot <= DOTA_ITEM_INVENTORY_MAX; ++slot) {
    if (Entities.GetItemInSlot(heroIndex, slot) != -1) {
      items.push(Entities.GetItemInSlot(heroIndex, slot));
    }
  }
  return items;
};
const ArtifactList = () => {
  const [show, setShow] = libs.createSignal(true);
  const [artifactList, setArtifactList] = libs.createSignal(getArtifactList(GameUI.GetSpectatorViewingInfo().player_id));
  libs.onMount(() => {
    let id = setInterval(() => {
      if (isSpectator()) {
        setArtifactList(getArtifactList(GameUI.GetSpectatorViewingInfo().player_id));
      } else {
        setArtifactList(getArtifactList(Players.GetLocalPlayer()));
      }
    }, 1000);
    libs.onCleanup(() => {
      clearInterval(id);
    });
  });
  const artifactCount = libs.createMemo(() => {
    let count = 0;
    artifactList().forEach(itemIndex => {
      count += 1;
    });
    return count;
  });
  return (() => {
    const _el$ = libs.createElement("Panel", {}, null),
      _el$2 = libs.createElement("Button", {
        id: "ExpandButton"
      }, _el$);
    libs.setProp(_el$2, "onactivate", () => setShow(b => !b));
    libs.insert(_el$2, libs.createComponent(EOM_Panel.EOM_Panel, {
      id: "ButtonArrow"
    }), null);
    libs.insert(_el$2, libs.createComponent(EOM_Panel.EOM_Panel, {
      id: "ArtifactIcons",
      get children() {
        return [libs.createComponent(EOM_Image.EOM_Image, {
          id: "ArtifactIcon"
        }), libs.createComponent(EOM_Label.EOM_Label, {
          id: "ArtifactCount",
          get text() {
            return artifactCount();
          }
        })];
      }
    }), null);
    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
      id: "ArtifactItems",
      get children() {
        return libs.createComponent(libs.Index, {
          get each() {
            return artifactList();
          },
          children: (itemEntityIndex, index) => {
            const [itemCount, setItemCount] = libs.createSignal(Items.GetCurrentCharges(itemEntityIndex()));
            libs.onMount(() => {
              let id = setInterval(() => {
                setItemCount(Items.GetCurrentCharges(itemEntityIndex()));
              }, 30);
              libs.onCleanup(() => {
                clearInterval(id);
              });
            });
            const customTooltipProps = () => {
              if (isSpectator()) {
                return {
                  name: "equipment",
                  itemname: Abilities.GetAbilityName(itemEntityIndex()),
                  entindex: itemEntityIndex(),
                  player_id: GameUI.GetSpectatorViewingInfo().player_id
                };
              }
              return {
                name: "equipment",
                itemname: Abilities.GetAbilityName(itemEntityIndex()),
                entindex: itemEntityIndex()
              };
            };
            return libs.createComponent(EOM_Panel.EOM_Panel, {
              get className() {
                return libs.classNames("ArtifactItem", {
                  NotIsPassive: !Abilities.IsPassive(itemEntityIndex()),
                  Enable: itemCount() > 0
                });
              },
              hittest: false,
              get customTooltip() {
                return customTooltipProps();
              },
              get children() {
                return [(() => {
                  const _el$3 = libs.createElement("DOTAItemImage", {
                    id: "ArtifactImage",
                    get itemname() {
                      return Abilities.GetAbilityName(itemEntityIndex());
                    },
                    get contextEntityIndex() {
                      return itemEntityIndex();
                    },
                    showtooltip: false
                  }, null);
                  libs.setProp(_el$3, "onactivate", () => {
                    if (Players.GetLocalPlayer() != GameUI.GetSpectatorViewingInfo().player_id) {
                      return;
                    }
                    Abilities.ExecuteAbility(itemEntityIndex(), Abilities.GetCaster(itemEntityIndex()), false);
                  });
                  libs.effect(_p$ => {
                    const _v$3 = Abilities.GetAbilityName(itemEntityIndex()),
                      _v$4 = itemEntityIndex();
                    _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$3, "itemname", _v$3, _p$._v$3));
                    _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$3, "contextEntityIndex", _v$4, _p$._v$4));
                    return _p$;
                  }, {
                    _v$3: undefined,
                    _v$4: undefined
                  });
                  return _el$3;
                })(), libs.createComponent(libs.Show, {
                  get when() {
                    return itemCount() > 0;
                  },
                  get children() {
                    return libs.createComponent(GenericPanel.CLabel, {
                      className: "ItemCharges",
                      get text() {
                        return itemCount();
                      },
                      hittest: false
                    });
                  }
                })];
              }
            });
          }
        });
      }
    }), null);
    libs.effect(_p$ => {
      const _v$ = libs.classNames("ArtifactList", {
          Show: show()
        }, "Width" + artifactList().length),
        _v$2 = artifactCount() > 0;
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$, "className", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$2, "enabled", _v$2, _p$._v$2));
      return _p$;
    }, {
      _v$: undefined,
      _v$2: undefined
    });
    return _el$;
  })();
};

const RuneTask = () => {
  const [runeTaskData, setRuneTaskData] = libs.createSignal();
  const runeTaskList = libs.createMemo(() => {
    let list = [];
    const data = runeTaskData();
    if (data) {
      for (const key in data) {
        const v = data[key];
        if (v.hide != 1) {
          list.push({
            id: v.id,
            progress: v.progress,
            finish: v.finish == 1,
            trait: v.trait
          });
        }
      }
    }
    return list;
  });
  libs.onMount(() => {
    const gameEventIDList = [];
    const netTableIDList = [];
    if (isSpectator()) {
      libs.createEffect(libs.on(GameUI.GetSpectatorViewingInfo, data => {
        let v = CustomNetTables.GetTableValue("common", "rune_task_" + data.player_id);
        setRuneTaskData(v == null ? undefined : v);
      }));
      netTableIDList.push(CustomNetTables.SubscribeNetTableListener("common", (_, key, value) => {
        if (key == "rune_task_" + GameUI.GetSpectatorViewingInfo().player_id) {
          setRuneTaskData(value);
        }
      }));
    } else {
      netTableIDList.push(useNetTableKeyHasDefaultValue("common", "rune_task_" + Players.GetLocalPlayer(), data => {
        setRuneTaskData(data);
      }));
    }
    libs.onCleanup(() => {
      gameEventIDList.forEach(id => GameEvents.Unsubscribe(id));
      netTableIDList.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    });
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "RuneTask",
    get visible() {
      return runeTaskList().length > 0;
    },
    get children() {
      return libs.createComponent(libs.Index, {
        get each() {
          return runeTaskList();
        },
        children: (data, i) => {
          const taskType = () => {
            return KeyValues.RuneTaskKV[data().id]?.type ?? "none";
          };
          const target = () => {
            return KeyValues.RuneTaskKV[data().id]?.target ?? -1;
          };
          return (() => {
            const _el$ = libs.createElement("Panel", {
              id: "RuneTaskInfoContainer"
            }, null);
            libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
              get className() {
                return libs.classNames("RuneTaskInfo", {
                  finish: data().finish
                });
              },
              get children() {
                return libs.createComponent(EOM_Panel.EOM_Panel, {
                  id: "RuneTaskDesc",
                  get children() {
                    return [libs.createComponent(EOM_Label.EOM_Label, {
                      id: "RuneTaskProgress",
                      get text() {
                        return `(${data().progress}/${target()})`;
                      }
                    }), libs.createComponent(EOM_Label.EOM_Label, {
                      id: "RuneTaskDescription",
                      get text() {
                        return "#RuneTask_" + taskType() + "_description";
                      },
                      get dialogVariables() {
                        return {
                          target: target()
                        };
                      },
                      html: true
                    })];
                  }
                });
              }
            }), null);
            libs.insert(_el$, libs.createComponent(libs.Show, {
              get when() {
                return data().finish;
              },
              get children() {
                return libs.createComponent(EOM_Icon.EOM_Icon, {
                  id: "finishIcon",
                  size: "32",
                  get src() {
                    return getSrcPath("icon/selected.png");
                  }
                });
              }
            }), null);
            libs.insert(_el$, libs.createComponent(libs.Show, {
              get when() {
                return data().trait != undefined;
              },
              get children() {
                return libs.createComponent(EOM_Image.EOM_Image, {
                  get ["class"]() {
                    return libs.classNames("RuneRewardIcon", "LV" + ((KeyValues.TraitKv[data().trait]?.Round ?? 0) > 1 ? "2" : "1"));
                  },
                  onmouseover: self => {
                    $.DispatchEvent("DOTAShowTitleTextTooltip", self, "#DOTA_Tooltip_ability_" + data().trait, getAbilityDescription(data().trait, 1, undefined));
                  },
                  onmouseout: self => {
                    $.DispatchEvent("DOTAHideTitleTextTooltip", self);
                  }
                });
              }
            }), null);
            return _el$;
          })();
        }
      });
    }
  });
};
const RuneTaskSelection = props => {
  const [taskSelectionList, setTaskSelectionList] = libs.createSignal([]);
  const [taskSelectionIndex, setTaskSelectionIndex] = libs.createSignal(-1);
  const showTaskSelection = () => props.TaskSelectingState && taskSelectionList().length > 0;
  const [rookieV2Recommend, setRookieV2Recommend] = libs.createSignal();
  libs.createEffect(libs.on(taskSelectionIndex, v => {
    if (v != -1) {
      GameEvents.SendCustomEventToServer("select_rune_task", {
        index: v,
        operate: "preselect",
        preorder: true
      });
    }
  }));
  libs.onMount(() => {
    const gameEventIDList = [];
    const netTableIDList = [];
    netTableIDList.push(useNetTableKeyHasDefaultValue("common", "rune_task_selection", data => {
      let v = Object.values(data[Players.GetLocalPlayer().toString()] ?? {});
      if (JSON.stringify(v) != JSON.stringify(taskSelectionList())) {
        if (taskSelectionList().length == 0) {
          setTaskSelectionIndex(-1);
        }
        setTaskSelectionList(v);
      }
    }));
    netTableIDList.push(useNetTableKeyHasDefaultValue("common", "constant", data => {
      setRookieV2Recommend(data?.ROOKIE_GUIDE_RUNE_TASK);
    }));
    libs.onCleanup(() => {
      gameEventIDList.forEach(id => GameEvents.Unsubscribe(id));
      netTableIDList.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    });
  });
  const taskBindTrait = libs.createMemo(() => {
    return taskSelectionList().some(v => v.trait_id != undefined && v.trait_id != "");
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "RuneTaskSelection",
    get visible() {
      return showTaskSelection();
    },
    hittest: false,
    get children() {
      return libs.createComponent(libs.Show, {
        get when() {
          return showTaskSelection();
        },
        get children() {
          return (() => {
            const stage4 = rookie_utils.useRookieV2Effect({
              key: "rune_task",
              params: {
                tooltip_position: "top"
              }
            }, 1.2);
            const stage5 = rookie_utils.useRookieV2Effect({
              key: "rune_task_confirm",
              params: {}
            });
            return libs.createComponent(EOM_Panel.EOM_Panel, {
              get className() {
                return libs.classNames("RuneTaskSelectionMain", "Show", {
                  BindTrait: taskBindTrait()
                });
              },
              onload: self => {
                $.Schedule(.6, () => {
                  if (self?.IsValid()) {
                    self.RemoveClass("Show");
                  }
                });
              },
              hittest: false,
              get children() {
                return [(() => {
                  const _el$2 = libs.createElement("Panel", {
                    id: "RuneTaskSelectionHitBox"
                  }, null);
                  libs.setProp(_el$2, "onactivate", () => {});
                  return _el$2;
                })(), libs.createComponent(EOM_Panel.EOM_Panel, {
                  id: "RuneTaskTitle",
                  get children() {
                    return [libs.createComponent(EOM_Image.EOM_Image, {
                      className: "RuneTaskTitleEdge Left"
                    }), libs.createComponent(EOM_Image.EOM_Image, {
                      className: "RuneTaskTitleEdge Right"
                    }), libs.createComponent(EOM_Label.EOM_Label, {
                      text: "#GameState_RuneTask"
                    })];
                  }
                }), libs.createComponent(EOM_Panel.EOM_Panel, {
                  id: "RuneTaskSelectionList",
                  get children() {
                    return libs.createComponent(libs.Index, {
                      get each() {
                        return taskSelectionList();
                      },
                      children: (task_data, i) => {
                        const taskForTarit = () => {
                          return task_data().trait_id != undefined && task_data().trait_id != "";
                        };
                        const taskType = () => {
                          return KeyValues.RuneTaskKV[task_data().task_id]?.type ?? "none";
                        };
                        const target = () => {
                          return KeyValues.RuneTaskKV[task_data().task_id]?.target ?? -1;
                        };
                        return libs.createComponent(libs.Show, {
                          get when() {
                            return libs.memo(() => !!taskForTarit())() && taskBindTrait();
                          },
                          get fallback() {
                            return libs.createComponent(EOM_Button.EOM_BaseButton, {
                              get className() {
                                return libs.classNames("RuneTaskSelectionButton", {
                                  Selected: taskSelectionIndex() == i,
                                  RookieTip: rookieV2Recommend() == task_data().task_id && stage4.state()
                                });
                              },
                              get enabled() {
                                return taskSelectionIndex() != i;
                              },
                              onactivate: () => {
                                setTaskSelectionIndex(i);
                                if (stage4.state() && rookieV2Recommend() == task_data().task_id) {
                                  closeRookieV2Tip("rune_task");
                                }
                              },
                              get children() {
                                return [libs.createComponent(EOM_Panel.EOM_Panel, {
                                  id: "RuneTaskSelectionButtonMainPath",
                                  hittest: false
                                }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                  id: "RuneTaskSelectionButtonMain",
                                  onload: self => {
                                    if (rookieV2Recommend() == task_data().task_id) {
                                      stage4.setRef(self);
                                    }
                                  },
                                  get children() {
                                    return [libs.createComponent(EOM_Label.EOM_Label, {
                                      id: "RuneTaskSelectionTitle",
                                      get text() {
                                        return "#RuneTask_" + taskType();
                                      }
                                    }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                      id: "RuneTaskUnderline"
                                    }), libs.createComponent(EOM_Label.EOM_Label, {
                                      id: "RuneTaskDescription",
                                      get text() {
                                        return "#RuneTask_" + taskType() + "_description";
                                      },
                                      get dialogVariables() {
                                        return {
                                          target: target()
                                        };
                                      }
                                    })];
                                  }
                                })];
                              }
                            });
                          },
                          get children() {
                            const _el$3 = libs.createElement("Panel", {
                              id: "RuneRewardAndTask"
                            }, null);
                            libs.insert(_el$3, libs.createComponent(EOM_Button.EOM_BaseButton, {
                              get className() {
                                return libs.classNames("RuneTaskSelectionButton", {
                                  Selected: taskSelectionIndex() == i,
                                  RookieTip: rookieV2Recommend() == task_data().task_id && stage4.state(),
                                  BindTrait: true
                                });
                              },
                              onactivate: () => {
                                setTaskSelectionIndex(i);
                              },
                              get children() {
                                return [libs.createComponent(EOM_Panel.EOM_Panel, {
                                  id: "RuneRewardCardBGPath",
                                  hittest: false
                                }), libs.createComponent(RuneRewardCard.RuneRewardCard, {
                                  id: "RuneRewardCard",
                                  get trait() {
                                    return task_data().trait_id;
                                  },
                                  get children() {
                                    return libs.createComponent(libs.Show, {
                                      get when() {
                                        return (task_data().trait_refresh_count ?? 0) > 0;
                                      },
                                      get children() {
                                        return libs.createComponent(EOM_Button.EOM_BaseButton, {
                                          hittest: true,
                                          className: "RefreshIconButton",
                                          id: "TaritRefreshButton",
                                          get tooltip_text() {
                                            return `${$.Localize("#Refresh")} (${task_data().trait_refresh_count})`;
                                          },
                                          onactivate: () => {
                                            GameEvents.SendCustomEventToServer("refresh_rune_task", {
                                              index: i,
                                              trait: true
                                            });
                                          }
                                        });
                                      }
                                    });
                                  }
                                }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                  id: "TaskTitleContainer",
                                  get children() {
                                    return libs.createComponent(EOM_Label.EOM_Label, {
                                      id: "TaskTitle",
                                      get text() {
                                        return "#RuneTask_" + taskType() + "_description";
                                      },
                                      get dialogVariables() {
                                        return {
                                          target: target()
                                        };
                                      }
                                    });
                                  }
                                })];
                              }
                            }), null);
                            libs.insert(_el$3, libs.createComponent(libs.Show, {
                              get when() {
                                return task_data().refresh_count > 0;
                              },
                              get children() {
                                return libs.createComponent(EOM_Button.EOM_BaseButton, {
                                  className: "RefreshIconButton",
                                  id: "RefreshButton",
                                  get tooltip_text() {
                                    return `${$.Localize("#Refresh")} (${task_data().refresh_count})`;
                                  },
                                  onactivate: () => {
                                    GameEvents.SendCustomEventToServer("refresh_rune_task", {
                                      index: i
                                    });
                                  }
                                });
                              }
                            }), null);
                            return _el$3;
                          }
                        });
                      }
                    });
                  }
                }), libs.createComponent(EOM_Panel.EOM_Panel, {
                  id: "RuneTaskExtraInfo",
                  get classList() {
                    return {
                      city_37: taskSelectionList()[0].trait_id != undefined && taskSelectionList()[0].trait_id != ""
                    };
                  },
                  get children() {
                    return [libs.createComponent(EOM_Label.EOM_Label, {
                      get text() {
                        return replaceBuffEnum($.Localize("#RuneTaskInfo"));
                      },
                      html: true
                    }), libs.createComponent(EOM_Icon.EOM_Icon, {
                      tooltip_text: "#RuneTaskDamageReduce"
                    })];
                  }
                }), libs.createComponent(EOM_Panel.EOM_Panel, {
                  id: "RuneTaskSelections",
                  get children() {
                    return libs.createComponent(EOM_Button.EOM_Button, {
                      color: "Blue",
                      text: "#Popup_Button_Confirm",
                      get enabled() {
                        return taskSelectionIndex() != -1;
                      },
                      onactivate: () => {
                        if (taskSelectionIndex() != -1) {
                          GameEvents.SendCustomEventToServer("select_rune_task", {
                            index: taskSelectionIndex(),
                            operate: "select"
                          });
                        }
                        if (stage5.state()) {
                          closeRookieV2Tip("rune_task_confirm");
                        }
                      },
                      onload: self => {
                        stage5.setRef(self);
                      }
                    });
                  }
                })];
              }
            });
          })();
        }
      });
    }
  });
};

$.GetContextPanel().AddClass("CosmeticPreviewLiveHidden");
const [skin, setSkin] = libs.createSignal("Skin" + (getEquipCosmetic(OrnamentType.HUD_SKIN) ?? 5740000));
{
  const sCommand = String(Math.floor(Date.now() / 1000));
  GameEvents.SendEventClientSide("date_now", {
    date: sCommand
  });
  HeroPortrait.createLocalConsoleMessage("player_region", data => {
    GameUI.CustomUIConfig()._Player_Region = data.region;
    GameEvents.SendCustomGameEventToServer("ping_test", {
      location: data.region,
      time: Game.GetGameTime()
    });
  });
}
libs.onMount(() => {
  GameEvents.SendCustomEventToServer("ui_setting", {
    language: $.Language().toLowerCase()
  });
  const id = useNetData("player_ornament", data => {
    const equipSkin = getEquipCosmetic(OrnamentType.HUD_SKIN);
    if ("Skin" + equipSkin != skin()) {
      if (equipSkin == undefined) {
        setSkin("Skin5740000");
      } else {
        setSkin("Skin" + equipSkin);
      }
    }
  }, Players.GetLocalPlayer());
  GameEvents.SendCustomGameEventToServer("save_lang", {
    lang: $.Language().toLowerCase()
  });
  clientSideEvent("web_request", {
    url: "http://metric.eomgames.net/project",
    type: "POST",
    data: JSON.stringify({
      project: "c4",
      uid: steam_64_3(Game.GetPlayerInfo(Players.GetLocalPlayer()).player_steamid) == "NaN" ? "0" : steam_64_3(Game.GetPlayerInfo(Players.GetLocalPlayer()).player_steamid)
    })
  });
  [GameUI.ProfilePlayerId, GameUI.SetProfilePlayerId] = libs.createSignal(Players.GetLocalPlayer());
  libs.onCleanup(() => {
    GameEvents.Unsubscribe(id);
  });
});
const useMainStore = () => {
  const [gameState, setGameState] = libs.createSignal();
  const game_state = () => gameState()?.state ?? 'GameState_None';
  let camera_state = 1;
  let gameStateTimer;
  let animTimer1;
  let animTimer2;
  let animTimer3;
  let nextReturn;
  const [cameraState, setCameraState] = libs.createSignal(camera_state);
  const [cameraType, setCameraType] = libs.createSignal("1");
  const HeroShowStateList = ["GameState_HeroShow", "GameState_HeroSelection", "GameState_HeroBan", "GameState_CitySelection", "GameState_CityEnd"];
  const [showHeroShow, setShowHeroShow] = libs.createSignal(HeroShowStateList.includes(game_state()));
  libs.createEffect(() => {
    setShowHeroShow(HeroShowStateList.includes(game_state()));
  });
  const cameraEnable = () => cameraType() == "2";
  libs.createEffect(() => {
    const isHeroShow = showHeroShow();
    const _cameraType = cameraType();
    if (!isHeroShow) {
      const CAMERA_CONFIG = CustomNetTables.GetTableValue("common", "constant")?.CAMERA_CONFIG;
      if (CAMERA_CONFIG == undefined) {
        GameUI.CustomUIConfig().SetCameraDistance_C4(1590);
        GameUI.CustomUIConfig().SetCameraPitch_C4(60);
        GameUI.CustomUIConfig().SetCameraLookAtPositionHeightOffset_C4(-340);
        return;
      }
      let type;
      if (_cameraType == "0" || _cameraType == "2") {
        type = "default";
      } else if (_cameraType == "1") {
        type = "close";
      }
      if (type != undefined) {
        const config = CAMERA_CONFIG[type];
        if (config) {
          GameUI.CustomUIConfig().SetCameraDistance_C4(config.distance);
          GameUI.CustomUIConfig().SetCameraPitch_C4(config.pitch);
          GameUI.CustomUIConfig().SetCameraLookAtPositionHeightOffset_C4(config.yOffset);
        }
      }
    }
  });
  const settingChangeCamera = _cameraType => {
    const CAMERA_CONFIG = CustomNetTables.GetTableValue("common", "constant")?.CAMERA_CONFIG;
    if (!showHeroShow() && CAMERA_CONFIG != undefined) {
      let type;
      if (_cameraType == "0" || _cameraType == "2") {
        type = "default";
      } else if (_cameraType == "1") {
        type = "close";
      }
      if (type != undefined) {
        const config = CAMERA_CONFIG[type];
        if (config) {
          GameUI.CustomUIConfig().SetCameraDistance_C4(config.distance);
          GameUI.CustomUIConfig().SetCameraPitch_C4(config.pitch);
          GameUI.CustomUIConfig().SetCameraLookAtPositionHeightOffset_C4(config.yOffset);
        }
      }
    }
  };
  libs.createEffect(libs.on(game_state, state => {
    if (state != "GameState_None" && GameUI.CustomUIConfig()._Camera_Lock_Target_Ent == -1) {
      if (GameUI.CustomUIConfig()._Camera_Lock_Target_Ent == -1) {
        let playerData = CustomNetTables.GetTableValue("player_data", Players.GetLocalPlayer().toString());
        if (isSpectator()) {
          const data = CustomNetTables.GetAllTableValues("player_data");
          if (data) {
            playerData = Object.values(data)[0].value;
          }
        }
        if (playerData) {
          const cameraList = CustomNetTables.GetTableValue("common", "camera_ent_list");
          if (cameraList) {
            if (playerData.cameraType == PlayerCameraType.PUBLIC) {
              if (cameraList.public != undefined) {
                GameUI.CustomUIConfig().CameraLockTargetWithAnimation(cameraList.public);
              }
            } else {
              if (cameraList.player_home[playerData.index] != undefined) {
                GameUI.CustomUIConfig().CameraLockTargetWithAnimation(cameraList.player_home[playerData.index]);
              }
            }
          }
        }
        if (!isSpectator()) {
          if (playerData?.service_config?.["camera_move"] != undefined) {
            setCameraType(playerData.service_config["camera_move"]);
          }
        }
      }
    }
  }));
  libs.onMount(() => {
    const NetTableListenerIDs = [];
    const GameEventListenerIDs = [];
    GameEventListenerIDs.push(useClientSideEvent("camera_move", data => {
      if (data.type) {
        settingChangeCamera(data.type);
      }
    }));
    NetTableListenerIDs.push(useNetTableKeyHasDefaultValue("common", "camera_state_" + Players.GetLocalPlayer(), data => {
      setCameraState(data?.type ?? 1);
    }));
    NetTableListenerIDs.push(useNetTableKeyHasDefaultValue("player_data", Players.GetLocalPlayer().toString(), data => {
      if (data?.service_config?.["camera_move"] != undefined) {
        setCameraType(data.service_config["camera_move"]);
      }
    }));
    NetTableListenerIDs.push(useNetTableKeyHasDefaultValue("common", "game_state", data => {
      setGameState(data);
    }));
    libs.onCleanup(() => {
      NetTableListenerIDs.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
      GameEventListenerIDs.forEach(id => GameEvents.Unsubscribe(id));
    });
  });
  libs.createEffect(libs.on(gameState, _gameState => {
    let state = _gameState?.state ?? 'GameState_None';
    let endTime = _gameState?.time_end ?? 0;
    const paused = (_gameState?.is_pause ?? 0) == 1;
    if (!paused) {
      if (state == "GameState_HeroSelection") {
        cameraAnim2();
      } else if (state == "GameState_Prepare") {
        nextReturn = undefined;
        if (gameStateTimer != undefined) {
          clearInterval(gameStateTimer);
        }
        gameStateTimer = setInterval(() => {
          let timeNow = Game.GetGameTime();
          if (Math.abs(timeNow - endTime) < 5) {
            cameraAnim1();
          }
        }, 250);
      } else if (state == "GameState_BattleEnd") {
        if (nextReturn == undefined) nextReturn = true;
      } else {
        if (gameStateTimer != undefined) {
          clearInterval(gameStateTimer);
        }
        if (nextReturn) {
          nextReturn = false;
          cameraAnim2();
        }
      }
    } else {
      if (gameStateTimer != undefined) {
        clearInterval(gameStateTimer);
      }
      gameStateTimer = undefined;
    }
  }));
  libs.createEffect(libs.on(cameraState, _cameraState => {
    if (_cameraState == 1) {
      cameraAnim2();
    } else {
      cameraAnim1();
    }
  }));
  const cameraAnim1 = () => {
    if (!cameraEnable()) return;
    const config = CustomNetTables.GetTableValue("common", "constant")?.CAMERA_CONFIG;
    if (camera_state == 1) {
      camera_state = 2;
      if (animTimer1 != undefined) {
        clearInterval(animTimer1);
        animTimer1 = undefined;
      }
      if (animTimer2 != undefined) {
        clearInterval(animTimer2);
        animTimer2 = undefined;
      }
      if (animTimer3 != undefined) {
        clearInterval(animTimer3);
        animTimer3 = undefined;
      }
      if (animTimer1 == undefined) {
        let pitch1 = 52;
        let pitch2 = 60;
        if (config?.["close"]) {
          pitch1 = config?.["close"].pitch;
        }
        if (config?.["default"]) {
          pitch2 = config?.["default"].pitch;
        }
        animTimer1 = easeOutAnim(pitch2, pitch1, 2, cur => {
          GameUI.CustomUIConfig().SetCameraPitch_C4(cur);
        });
      }
      if (animTimer2 == undefined) {
        let distance1 = 1270;
        let distance2 = 1590;
        if (config?.["close"]) {
          distance1 = config?.["close"].distance;
        }
        if (config?.["default"]) {
          distance2 = config?.["default"].distance;
        }
        animTimer2 = easeOutAnim(distance2, distance1, 2, cur => {
          GameUI.CustomUIConfig().SetCameraDistance_C4(cur);
        });
      }
      if (animTimer3 == undefined) {
        let yOffset1 = -200;
        let yOffset2 = -340;
        if (config?.["close"]) {
          yOffset1 = config?.["close"].yOffset;
        }
        if (config?.["default"]) {
          yOffset2 = config?.["default"].yOffset;
        }
        animTimer3 = easeOutAnim(yOffset2, yOffset1, 2, cur => {
          GameUI.CustomUIConfig().SetCameraLookAtPositionHeightOffset_C4(cur);
        });
      }
    }
  };
  const cameraAnim2 = () => {
    if (!cameraEnable()) return;
    const config = CustomNetTables.GetTableValue("common", "constant")?.CAMERA_CONFIG;
    if (camera_state == 2) {
      camera_state = 1;
      if (animTimer1 != undefined) {
        clearInterval(animTimer1);
        animTimer1 = undefined;
      }
      if (animTimer2 != undefined) {
        clearInterval(animTimer2);
        animTimer2 = undefined;
      }
      if (animTimer3 != undefined) {
        clearInterval(animTimer3);
        animTimer3 = undefined;
      }
      if (animTimer1 == undefined) {
        let pitch1 = 52;
        let pitch2 = 60;
        if (config?.["close"]) {
          pitch1 = config?.["close"].pitch;
        }
        if (config?.["default"]) {
          pitch2 = config?.["default"].pitch;
        }
        animTimer1 = easeOutAnim(pitch1, pitch2, 2.5, cur => {
          GameUI.CustomUIConfig().SetCameraPitch_C4(cur);
        });
      }
      if (animTimer2 == undefined) {
        let distance1 = 1270;
        let distance2 = 1590;
        if (config?.["close"]) {
          distance1 = config?.["close"].distance;
        }
        if (config?.["default"]) {
          distance2 = config?.["default"].distance;
        }
        animTimer2 = easeOutAnim(distance1, distance2, 2.5, cur => {
          GameUI.CustomUIConfig().SetCameraDistance_C4(cur);
        });
      }
      if (animTimer3 == undefined) {
        let yOffset1 = -200;
        let yOffset2 = -340;
        if (config?.["close"]) {
          yOffset1 = config?.["close"].yOffset;
        }
        if (config?.["default"]) {
          yOffset2 = config?.["default"].yOffset;
        }
        animTimer3 = easeOutAnim(yOffset1, yOffset2, 2.5, cur => {
          GameUI.CustomUIConfig().SetCameraLookAtPositionHeightOffset_C4(cur);
        });
      }
    }
  };
  const easeOutAnim = (start, end, duration, callback) => {
    let time = 0;
    let tick = 10;
    let delta = end - start;
    let timer = setInterval(() => {
      time += tick * 0.001;
      if (time > duration) {
        clearInterval(timer);
        callback(end);
      } else {
        let percent = time / duration;
        let current_value = start + delta * (1 - Math.pow(1 - percent, 2));
        callback(current_value);
      }
    }, tick);
    return timer;
  };
  return {
    showHeroShow,
    game_state
  };
};
const Main = () => {
  const {
    showHeroShow,
    game_state
  } = useMainStore();
  const [isReturnPlayer, setIsReturnPlayer] = libs.createSignal(false);
  libs.onMount(() => {
    const gameEventIDList = [];
    gameEventIDList.push(useNetData("player_regression_data", data => {
      setIsReturnPlayer(data?.is_regression_player == true);
    }, Players.GetLocalPlayer()));
    libs.onCleanup(() => {
      gameEventIDList.forEach(id => GameEvents.Unsubscribe(id));
    });
  });
  return (() => {
    const _el$ = libs.createElement("Panel", {
      id: "HudMain",
      get ["class"]() {
        return skin();
      },
      hittest: false
    }, null);
    libs.insert(_el$, libs.createComponent(libs.Switch, {
      get fallback() {
        return [libs.createElement("Panel", {
          id: "WorldVignetteLeft",
          hittest: false
        }, null), libs.createElement("Panel", {
          id: "WorldVignetteRight",
          hittest: false
        }, null), libs.createComponent(HealthBarContainer, {}), libs.createComponent(RightTopArea, {
          get game_state() {
            return game_state();
          }
        }), libs.createComponent(PlayerList, {}), libs.createComponent(TeamSuggestionIcon.TopBar, {}), libs.createComponent(DamageRank, {
          get game_state() {
            return game_state();
          }
        }), libs.createComponent(BattleMessage, {}), libs.createComponent(BottomBar, {}), libs.createComponent(RuneTask, {}), libs.createComponent(libs.Show, {
          get when() {
            return !isReturnPlayer();
          },
          get fallback() {
            return libs.createComponent(EOM_Button.EOM_BaseButton, {
              className: "ReturnHUDButton small",
              onactivate: () => {
                ToggleWindows("MenuButton_activity", true);
                clientSideEvent("switchActivityTag", {
                  id: "Activity_Regression"
                });
              },
              get children() {
                return libs.createComponent(EOM_Label.EOM_Label, {
                  id: "ReturnHUDButtonTitle",
                  text: "#Activity_Regression"
                });
              }
            });
          },
          get children() {
            return libs.createComponent(GenericPanel.CImage, {
              id: "Logo",
              get className() {
                return $.Language();
              }
            });
          }
        }), libs.createComponent(GenericPanel.CImage, {
          id: "MenuMask",
          hittest: false
        }), libs.memo((() => {
          const _c$ = libs.memo(() => !!!isSpectator());
          return () => _c$() && libs.createComponent(ActiveStar, {});
        })()), libs.createComponent(libs.Show, {
          get when() {
            return !isSpectator();
          },
          get children() {
            return libs.createComponent(RuneTaskSelection, {
              get TaskSelectingState() {
                return game_state() == "GameState_RuneTask";
              },
              get gameState() {
                return game_state();
              }
            });
          }
        }), libs.createComponent(libs.Show, {
          get when() {
            return !isSpectator();
          },
          get children() {
            return libs.createComponent(GreevilEggSelect, {
              get game_state() {
                return game_state();
              }
            });
          }
        })];
      },
      get children() {
        return [libs.createComponent(libs.Match, {
          get when() {
            return game_state() == "GameState_FinalVS";
          },
          get children() {
            return libs.createComponent(FinalVS, {});
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return showHeroShow();
          },
          get children() {
            return libs.createComponent(HeroShow, {});
          }
        })];
      }
    }));
    libs.effect(_$p => libs.setProp(_el$, "class", skin(), _$p));
    return _el$;
  })();
};
const getPlayerSkinIDByHeroID = (playerID, hid) => {
  if (hid == undefined || playerID == undefined) return;
  const ornament_data = getServiceNetTable("player_equipped_ornament", playerID);
  if (ornament_data == undefined || ornament_data[OrnamentType.HERO_SKIN] == undefined) return;
  let result = Object.keys(ornament_data[OrnamentType.HERO_SKIN]).find(oid => KeyValues.CosmeticsKv?.[oid]?.hero == hid);
  if (result != undefined) {
    return Number(result);
  }
};
const BattleMessage = () => {
  let winSteakTimer;
  const [winStreakData_new, setWinStreakData_new] = libs.createSignal();
  let battleConfirmTimer;
  const [battleConfirmData_new, setBattleConfirmData_new] = libs.createSignal();
  const [selfHeroName, setSelfHeroName] = libs.createSignal();
  const selfHeroID = () => GetGoodIDByHeroName(selfHeroName() ?? "");
  const defaultWinStreakOID = 5440000;
  const getWinStreakOid = playerID => {
    if (playerID != undefined) {
      const data = getServiceNetTable("player_equipped_ornament", playerID);
      if (data && data[OrnamentType.BROADCAST.toString()] != undefined) {
        return finiteNumber(Number(Object.keys(data[OrnamentType.BROADCAST.toString()])[0]), defaultWinStreakOID);
      }
    }
    return defaultWinStreakOID;
  };
  const onWinStreak = data => {
    const newData = {
      enemyPlayerID: data.enemyPlayerID ?? -1,
      enemyHeroName: data.enemyHeroName ?? "",
      enemySkinID: getPlayerSkinIDByHeroID(data.enemyPlayerID, GetGoodIDByHeroName(data.enemyHeroName ?? "")),
      localHeroName: data.localHeroName ?? "",
      losePlayerID: data.losePlayerID ?? -1,
      winStreak: data.winStreak ?? 0,
      duration: 3,
      oid: getWinStreakOid(data.losePlayerID == Players.GetLocalPlayer() ? data.enemyPlayerID : Players.GetLocalPlayer())
    };
    if (newData.enemyPlayerID != -1 && newData.losePlayerID != -1 && newData.winStreak > 1) {
      setWinStreakData_new(newData);
      if (winSteakTimer != undefined) {
        $.CancelScheduled(winSteakTimer);
      }
      winSteakTimer = $.Schedule(4, () => {
        setWinStreakData_new(undefined);
      });
    }
  };
  const onBattleConfirm = event => {
    const newData = {
      enemyID: event.enemyID ?? -1,
      duration: 3
    };
    setBattleConfirmData_new(newData);
    if (battleConfirmTimer != undefined) {
      $.CancelScheduled(battleConfirmTimer);
    }
    battleConfirmTimer = $.Schedule(4, () => {
      battleConfirmTimer = undefined;
      setBattleConfirmData_new(undefined);
    });
  };
  const [selfSkinID, setSelfSkinID] = libs.createSignal();
  libs.createEffect(libs.on(selfHeroID, _selfHeroID => {
    setSelfSkinID(getPlayerSkinIDByHeroID(Players.GetLocalPlayer(), _selfHeroID));
  }));
  libs.onMount(() => {
    const eventIDList = [];
    const netTableIDList = [];
    eventIDList.push(GameEvents.Subscribe("win_streak_data", onWinStreak));
    eventIDList.push(GameEvents.Subscribe("battle_confirm_data", onBattleConfirm));
    netTableIDList.push(useServiceNetTable("player_equipped_ornament", data => {
      getPlayerSkinIDByHeroID(Players.GetLocalPlayer(), selfHeroID());
    }, Players.GetLocalPlayer()));
    netTableIDList.push(useNetTableKey("player_data", Players.GetLocalPlayer().toString(), data => {
      setSelfHeroName(data.heroName);
    }));
    libs.onCleanup(() => {
      eventIDList.forEach(id => {
        GameEvents.Unsubscribe(id);
      });
      netTableIDList.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    });
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    width: '100%',
    height: '100%',
    hittest: false,
    get children() {
      return [(() => {
        const _el$4 = libs.createElement("Panel", {
          id: "WinStreak",
          hittest: false
        }, null);
        libs.insert(_el$4, libs.createComponent(libs.Show, {
          get when() {
            return winStreakData_new() != undefined;
          },
          get children() {
            return libs.createComponent(WinStreak.WinStreak, {
              type: "effect",
              get winStreak() {
                return winStreakData_new().winStreak;
              },
              get oid() {
                return winStreakData_new().oid;
              },
              get leftHeroName() {
                return winStreakData_new().enemyHeroName;
              },
              get leftSkinID() {
                return winStreakData_new().enemySkinID;
              },
              get rightHeroName() {
                return winStreakData_new().localHeroName;
              },
              get rightSkinID() {
                return selfSkinID();
              },
              get winnerPosition() {
                return winStreakData_new().enemyPlayerID == winStreakData_new().losePlayerID ? "right" : "left";
              }
            });
          }
        }));
        return _el$4;
      })(), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "BattleConfirm",
        hittest: false,
        get children() {
          return libs.createComponent(libs.Show, {
            get when() {
              return battleConfirmData_new() != undefined;
            },
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "BattleConfirmRow",
                get children() {
                  return [libs.createElement("Panel", {
                    id: "Middle"
                  }, null), libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("Profile", "left");
                    },
                    get children() {
                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "ProfileWrapper",
                        get children() {
                          return libs.createComponent(profile_info.ProfileInfo, {
                            get player_id() {
                              return battleConfirmData_new().enemyID;
                            },
                            battle_position: "left"
                          });
                        }
                      });
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("Profile", "right");
                    },
                    get children() {
                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "ProfileWrapper",
                        get children() {
                          return libs.createComponent(profile_info.ProfileInfo, {
                            get player_id() {
                              return Players.GetLocalPlayer();
                            },
                            battle_position: "right"
                          });
                        }
                      });
                    }
                  })];
                }
              });
            }
          });
        }
      })];
    }
  });
};
libs.render(() => libs.createComponent(Main, {}), $.GetContextPanel());