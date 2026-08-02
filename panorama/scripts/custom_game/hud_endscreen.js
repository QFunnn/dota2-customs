--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var solid_utils = require('./solid_utils.js');
var common_item = require('./common_item.js');
var upgrade_icon = require('./upgrade_icon.js');
var StoreItem = require('./StoreItem.js');
var EOM_Button = require('./EOM_Button.js');
var Player = require('./Player.js');
var portraitsFullBodyLoadout = require('./portraitsFullBodyLoadout.js');
var equipment_utils = require('./equipment_utils.js');
require('./EOM_Countdown.js');
require('./EOM_TextEntry.js');

const localizeAbilityName = name => {
  if (name === undefined || name === "") {
    return GetLocalization("#EndScreen_Unknown");
  }
  const token = `#DOTA_Tooltip_ability_${name}`;
  const localized = GetLocalization(token);
  if (localized !== token) {
    return localized;
  }
  return name.replace(/^item_artifact_/, "").replace(/^item_/, "").replace(/^ability_/, "").replace(/^privilege_/, "").replace(/_/g, " ");
};
const getDamageSourceItemRarity = (abilityName, blessings, artifacts) => {
  for (let i = 0; i < blessings.length; i++) {
    if (blessings[i].name === abilityName) {
      return blessings[i].rarity;
    }
  }
  for (let i = 0; i < artifacts.length; i++) {
    if (artifacts[i].item_name === abilityName) {
      return artifacts[i].level;
    }
  }
  const rarityRange = KeyValues.npc_items_custom[abilityName]?.RarityRange;
  return toFiniteNumber(String(rarityRange).split("|")[0], 1);
};
const getHeroAbilityEntityIndex = (heroIndex, abilityName) => {
  if (heroIndex === undefined || !Entities.IsValidEntity(heroIndex)) {
    return undefined;
  }
  for (let slot = 0; slot < 32; slot++) {
    const abilityIndex = Entities.GetAbility(heroIndex, slot);
    if (abilityIndex && Entities.IsValidEntity(abilityIndex) && Abilities.GetAbilityName(abilityIndex) === abilityName) {
      return abilityIndex;
    }
  }
  return undefined;
};
const getDamageSourceKind = abilityName => {
  if (KeyValues.artifact[abilityName] !== undefined || KeyValues.bless[abilityName] !== undefined) {
    return "item";
  }
  if (KeyValues.hero_abilities[abilityName] !== undefined) {
    return "hero_ability";
  }
  return "unknown";
};
const getDamageSourceTooltip = item => {
  if (item.sourceKind === "item") {
    return {
      name: "artifact",
      itemName: item.abilityName,
      rarity: item.rarity ?? 1
    };
  }
  if (item.sourceKind === "hero_ability") {
    return {
      name: "hero_ability",
      abilityName: item.abilityName,
      entIndex: item.entIndex ?? -1
    };
  }
  return {
    name: "text",
    text: item.name
  };
};
const DamageSourceIcon = props => {
  if (props.item.sourceKind === "item") {
    return libs.createComponent(common_item.CommonItem, {
      "class": "DamageAbilityIcon",
      get itemName() {
        return props.item.abilityName;
      },
      get rarity() {
        return props.item.rarity ?? 1;
      },
      showTips: true
    });
  }
  return (() => {
    const _el$ = libs.createElement("DOTAAbilityImage", {
      "class": "DamageAbilityIcon",
      get abilityname() {
        return props.item.abilityName;
      },
      showtooltip: false
    }, null);
    libs.effect(_p$ => {
      const _v$ = props.item.abilityName,
        _v$2 = getDamageSourceTooltip(props.item);
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$, "abilityname", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$, "customTooltip", _v$2, _p$._v$2));
      return _p$;
    }, {
      _v$: undefined,
      _v$2: undefined
    });
    return _el$;
  })();
};
const formatDuration = totalSeconds => {
  const safeSeconds = Math.max(0, Math.floor(totalSeconds));
  const hours = Math.floor(safeSeconds / 3600);
  const minutes = Math.floor(safeSeconds % 3600 / 60);
  const seconds = safeSeconds % 60;
  if (hours > 0) {
    return `${hours}:${minutes.toString().padStart(2, "0")}:${seconds.toString().padStart(2, "0")}`;
  }
  return `${minutes.toString().padStart(2, "0")}:${seconds.toString().padStart(2, "0")}`;
};
const buildDamageSourceItems = (sources, blessings, artifacts, heroIndex) => {
  return sources.map(ability => {
    const sourceKind = getDamageSourceKind(ability.ability_name);
    return {
      abilityName: ability.ability_name,
      name: localizeAbilityName(ability.ability_name),
      value: ability.total_damage,
      ratio: ability.ratio,
      sourceKind,
      rarity: sourceKind === "item" ? getDamageSourceItemRarity(ability.ability_name, blessings, artifacts) : undefined,
      entIndex: sourceKind === "hero_ability" ? getHeroAbilityEntityIndex(heroIndex, ability.ability_name) : undefined
    };
  });
};

const DEFAULT_HERO_NAME = "npc_dota_hero_vexis";
const ABYSSAL_REWARD_COST_TOKEN_ID = 110011;
const ABYSSAL_REWARD_COST_COUNT = 1;
const ABYSSAL_DAILY_FREE_REWARD_LIMIT = 3;
const ABYSSAL_BOX_Open_FLASH_PARTICLE = "particles/ui/game/ui_game_box_open_fx.vpcf";
const ABYSSAL_BOX_NORMAL_PARTICLE = "particles/ui/game/ui_game_box_select_fx.vpcf";
const ABYSSAL_REWARD_PREVIEW_REVEAL_INTERVAL = 0.1;
const ABYSSAL_REWARD_CARD_FLASH_PARTICLE = "particles/ui/game/ui_game_fx_chouka_shanguang_01l.vpcf";
const ABYSSAL_REWARD_CARD_PARTICLES = {
  3: "particles/ui/game/ui_game_fx_chouka_pinzhi_lanse_zong.vpcf",
  4: "particles/ui/game/ui_game_fx_chouka_pinzhi_zise_zong.vpcf",
  5: "particles/ui/game/ui_game_fx_chouka_pinzhi_jinse_zong.vpcf",
  6: "particles/ui/game/ui_game_fx_chouka_pinzhi_jinse_zong.vpcf",
  7: "particles/ui/game/ui_game_fx_chouka_pinzhi_jinse_zong.vpcf"
};
const getRewardRuneIconPath = runeItemID => {
  const icon = KeyValues.info_item_rune[runeItemID]?.icon;
  if (icon == undefined) {
    return undefined;
  }
  return `file://{images}/custom_game/store_items/${icon}.png`;
};
const SummaryRewardItem = props => {
  return (() => {
    const _el$ = libs.createElement("Panel", {
        get ["class"]() {
          return libs.classNames("AbyssalSummaryRewardItem", `Rarity${props.reward.rarity}`);
        },
        get transitionDelay() {
          return props.transitionDelay;
        }
      }, null);
      libs.createElement("Image", {
        "class": "SummaryRewardBG"
      }, _el$);
      const _el$3 = libs.createElement("Image", {
        "class": "RewardRuneIcon",
        get src() {
          return getRewardRuneIconPath(props.reward.rune_item_id);
        }
      }, _el$);
    libs.setProp(_el$, "onmouseover", panel => equipment_utils.ShowServerRuneTooltip(panel, {
      id1: props.reward.id
    }));
    libs.setProp(_el$, "onmouseout", panel => HideCustomTooltip(panel, "server_rune"));
    libs.effect(_p$ => {
      const _v$ = libs.classNames("AbyssalSummaryRewardItem", `Rarity${props.reward.rarity}`),
        _v$2 = props.classList,
        _v$3 = props.transitionDelay,
        _v$4 = getRewardRuneIconPath(props.reward.rune_item_id);
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$, "class", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$, "classList", _v$2, _p$._v$2));
      _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$, "transitionDelay", _v$3, _p$._v$3));
      _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$3, "src", _v$4, _p$._v$4));
      return _p$;
    }, {
      _v$: undefined,
      _v$2: undefined,
      _v$3: undefined,
      _v$4: undefined
    });
    return _el$;
  })();
};
const RewardItemCard = props => {
  const rewardRarity = () => {
    return props.reward.rarity ?? 0;
  };
  const cardFxName = () => ABYSSAL_REWARD_CARD_PARTICLES[rewardRarity()];
  const revealDelay = () => props.index * ABYSSAL_REWARD_PREVIEW_REVEAL_INTERVAL;
  return (() => {
    const _el$4 = libs.createElement("Panel", {
        get ["class"]() {
          return libs.classNames("AbyssalRewardItemCard", `Rarity${props.reward.rarity}`);
        },
        get style() {
          return {
            animationDelay: revealDelay() + "s"
          };
        }
      }, null),
      _el$6 = libs.createElement("Image", {
        "class": "RewardItemBG"
      }, _el$4),
      _el$7 = libs.createElement("Image", {
        "class": "RewardRuneIcon",
        get src() {
          return getRewardRuneIconPath(props.reward.rune_item_id);
        }
      }, _el$4);
    libs.setProp(_el$4, "onmouseover", panel => equipment_utils.ShowServerRuneTooltip(panel, {
      id1: props.reward.id
    }));
    libs.setProp(_el$4, "onmouseout", panel => HideCustomTooltip(panel, "server_rune"));
    libs.setProp(_el$4, "onload", async panel => {
      await Timer.Wait(revealDelay() + 0.05);
      if (!panel.IsValid()) {
        return;
      }
      const cardFx = panel.FindChildTraverse("CardFx");
      if (cardFx?.IsValid()) {
        cardFx.ReloadScene();
      }
      await Timer.Wait(0.28);
      if (!panel.IsValid()) {
        return;
      }
      const cardFlashFx = panel.FindChildTraverse("CardFlashFx");
      if (cardFlashFx?.IsValid()) {
        cardFlashFx.ReloadScene();
        cardFlashFx.AddClass("FxShow");
      }
    });
    libs.insert(_el$4, libs.createComponent(libs.Show, {
      get when() {
        return cardFxName();
      },
      get children() {
        const _el$5 = libs.createElement("DOTAParticleScenePanel", {
          id: "CardFx",
          get particleName() {
            return cardFxName();
          },
          cameraOrigin: "0 0 320",
          lookAt: "0 0 0",
          fov: 90,
          hittest: false
        }, null);
        libs.effect(_$p => libs.setProp(_el$5, "particleName", cardFxName(), _$p));
        return _el$5;
      }
    }), _el$6);
    libs.insert(_el$4, libs.createComponent(libs.Show, {
      get when() {
        return rewardRarity() >= 4;
      },
      get children() {
        const _el$8 = libs.createElement("DOTAParticleScenePanel", {
          id: "CardFlashFx",
          particleName: ABYSSAL_REWARD_CARD_FLASH_PARTICLE,
          cameraOrigin: "0 0 159",
          lookAt: "0 0 0",
          fov: 90,
          hittest: false
        }, null);
        libs.setProp(_el$8, "particleName", ABYSSAL_REWARD_CARD_FLASH_PARTICLE);
        return _el$8;
      }
    }), null);
    libs.effect(_p$ => {
      const _v$5 = libs.classNames("AbyssalRewardItemCard", `Rarity${props.reward.rarity}`),
        _v$6 = {
          animationDelay: revealDelay() + "s"
        },
        _v$7 = getRewardRuneIconPath(props.reward.rune_item_id);
      _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$4, "class", _v$5, _p$._v$5));
      _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$4, "style", _v$6, _p$._v$6));
      _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$7, "src", _v$7, _p$._v$7));
      return _p$;
    }, {
      _v$5: undefined,
      _v$6: undefined,
      _v$7: undefined
    });
    return _el$4;
  })();
};
const AbyssalRewardsPreviewPanel = props => {
  return (() => {
    const _el$9 = libs.createElement("Panel", {
        id: "AbyssalRewardsPreviewPanel",
        "class": "AbyssalContentSubPanel",
        hittest: true
      }, null),
      _el$0 = libs.createElement("Panel", {
        id: "RewardsPreviewList",
        scroll: "y"
      }, _el$9),
      _el$1 = libs.createElement("Panel", {
        id: "RewardsPreviewBottom",
        hittest: true,
        get onactivate() {
          return props.onClose;
        }
      }, _el$9);
      libs.createElement("Label", {
        text: "#AbyssalEndScreen_RewardsPreviewClose",
        hittest: false
      }, _el$1);
    libs.setProp(_el$0, "scroll", "y");
    libs.insert(_el$0, libs.createComponent(libs.For, {
      get each() {
        return [...props.rewards].sort((a, b) => (b.rarity ?? 0) - (a.rarity ?? 0));
      },
      children: (reward, index) => libs.createComponent(RewardItemCard, {
        reward: reward,
        get index() {
          return index();
        }
      })
    }));
    libs.effect(_$p => libs.setProp(_el$1, "onactivate", props.onClose, _$p));
    return _el$9;
  })();
};
const AbyssalRewardsBoxPanel = props => {
  const playerTokens = solid_utils.createServiceNetData("player_tokens", {});
  const playerCounters = solid_utils.createServiceNetData("player_counters", {});
  let rewardBoxNormalParticle;
  const usedFreeRewardCount = libs.createMemo(() => playerCounters()?.["daily_free_abyssal_rewards"]?.count ?? 0);
  const remainingFreeRewardCount = libs.createMemo(() => Math.max(0, ABYSSAL_DAILY_FREE_REWARD_LIMIT - usedFreeRewardCount()));
  const isFree = libs.createMemo(() => remainingFreeRewardCount() > 0);
  const abyssalRewardKeyCount = libs.createMemo(() => playerTokens()?.[String(ABYSSAL_REWARD_COST_TOKEN_ID)]?.amounts ?? 0);
  const hasEnoughAbyssalRewardKey = libs.createMemo(() => abyssalRewardKeyCount() >= ABYSSAL_REWARD_COST_COUNT);
  const claimDisabled = () => props.claimState != "idle" || !props.settled || !isFree() && !hasEnoughAbyssalRewardKey();
  libs.createEffect(libs.on(() => props.rewardsVisible, async visible => {
    if (!visible) {
      return;
    }
    await Timer.Wait(0.05);
    if (!props.rewardsVisible || props.claimState == "received" || !rewardBoxNormalParticle?.IsValid()) {
      return;
    }
    rewardBoxNormalParticle.ReloadScene();
  }));
  return (() => {
    const _el$11 = libs.createElement("Panel", {
        id: "AbyssalRewardsBoxPanel",
        "class": "AbyssalContentSubPanel",
        hittest: true
      }, null),
      _el$16 = libs.createElement("Panel", {
        id: "RewardsOperations"
      }, _el$11),
      _el$17 = libs.createElement("Panel", {
        "class": "RewardsOperationButtonContainer"
      }, _el$16),
      _el$18 = libs.createElement("Panel", {
        "class": "RewardsOperationButtonContainer"
      }, _el$16);
    libs.insert(_el$11, libs.createComponent(libs.Show, {
      when: true,
      get children() {
        const _el$12 = libs.createElement("Panel", {
            id: "RewardBoxList",
            "class": "RewardBoxList"
          }, null),
          _el$13 = libs.createElement("Panel", {}, _el$12),
          _el$15 = libs.createElement("Panel", {
            "class": "RewardBoxItemIcon Box1"
          }, _el$13);
        libs.insert(_el$13, libs.createComponent(libs.Show, {
          get when() {
            return props.claimState != "received";
          },
          get children() {
            const _el$14 = libs.createElement("DOTAParticleScenePanel", {
              id: "RewardBoxNormalParticle",
              "class": "RewardBoxNormalParticle",
              particleName: ABYSSAL_BOX_NORMAL_PARTICLE,
              cameraOrigin: "0 0 210",
              fov: 90,
              lookAt: "0 0 0",
              hittest: false,
              squarePixels: true
            }, null);
            const _ref$ = rewardBoxNormalParticle;
            typeof _ref$ === "function" ? libs.use(_ref$, _el$14) : rewardBoxNormalParticle = _el$14;
            libs.setProp(_el$14, "particleName", ABYSSAL_BOX_NORMAL_PARTICLE);
            return _el$14;
          }
        }), _el$15);
        libs.insert(_el$13, libs.createComponent(libs.Show, {
          get when() {
            return props.claimParticleTrigger > 0;
          },
          get children() {
            return libs.createComponent(solid_utils.DynamicKey, {
              key: () => props.claimParticleTrigger,
              children: () => (() => {
                const _el$26 = libs.createElement("DOTAParticleScenePanel", {
                  "class": "RewardBoxFlashParticle",
                  particleName: ABYSSAL_BOX_Open_FLASH_PARTICLE,
                  cameraOrigin: "0 0 420",
                  fov: 90,
                  lookAt: "0 0 0",
                  hittest: false,
                  squarePixels: true
                }, null);
                libs.setProp(_el$26, "particleName", ABYSSAL_BOX_Open_FLASH_PARTICLE);
                return _el$26;
              })()
            });
          }
        }), _el$15);
        libs.effect(_$p => libs.setProp(_el$13, "classList", {
          "RewardBoxItem": true,
          "BoxSelected": true,
          "Opening": props.claimState == "opening",
          "Locked": props.claimState == "idle",
          "Received": props.claimState == "received"
        }, _$p));
        return _el$12;
      }
    }), _el$16);
    libs.insert(_el$17, libs.createComponent(EOM_Button.EOM_Button, {
      id: "RewardsCancelButton",
      color: "Cancel",
      text: "#AbyssalEndScreen_RewardsBoxClose",
      get onactivate() {
        return props.onCancel;
      }
    }));
    libs.insert(_el$18, libs.createComponent(libs.Show, {
      get when() {
        return !isFree();
      },
      get children() {
        const _el$19 = libs.createElement("Panel", {
            id: "RewardsClaimDesc",
            hittest: false
          }, null);
          libs.createElement("Image", {
            id: "ClaimDescBG",
            hittest: false
          }, _el$19);
          const _el$21 = libs.createElement("Panel", {
            id: "ClaimCostContent"
          }, _el$19),
          _el$22 = libs.createElement("Label", {
            id: "ClaimDescLabel",
            get text() {
              return `x${ABYSSAL_REWARD_COST_COUNT} (${abyssalRewardKeyCount()})`;
            }
          }, _el$21);
        libs.insert(_el$21, libs.createComponent(StoreItem.StoreItemImage, {
          itemid: ABYSSAL_REWARD_COST_TOKEN_ID
        }), _el$22);
        libs.effect(_p$ => {
          const _v$8 = {
              NotEnough: !hasEnoughAbyssalRewardKey()
            },
            _v$9 = `x${ABYSSAL_REWARD_COST_COUNT} (${abyssalRewardKeyCount()})`;
          _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$22, "classList", _v$8, _p$._v$8));
          _v$9 !== _p$._v$9 && (_p$._v$9 = libs.setProp(_el$22, "text", _v$9, _p$._v$9));
          return _p$;
        }, {
          _v$8: undefined,
          _v$9: undefined
        });
        return _el$19;
      }
    }), null);
    libs.insert(_el$18, libs.createComponent(libs.Show, {
      get when() {
        return isFree();
      },
      get children() {
        const _el$23 = libs.createElement("Panel", {
            id: "RewardsFreeClaimDesc",
            hittest: false
          }, null);
          libs.createElement("Image", {
            id: "FreeClaimDescBG",
            hittest: false
          }, _el$23);
          const _el$25 = libs.createElement("Label", {
            id: "FreeClaimDescLabel",
            get text() {
              return LocalizeWithVars("#AbyssalEndScreen_FreeClaimDesc", {
                fcount: remainingFreeRewardCount()
              });
            }
          }, _el$23);
        libs.effect(_$p => libs.setProp(_el$25, "text", LocalizeWithVars("#AbyssalEndScreen_FreeClaimDesc", {
          fcount: remainingFreeRewardCount()
        }), _$p));
        return _el$23;
      }
    }), null);
    libs.insert(_el$18, libs.createComponent(EOM_Button.EOM_Button, {
      id: "RewardsFreeClaimButton",
      color: "Green",
      get enabled() {
        return !claimDisabled();
      },
      get text() {
        return props.settled ? "#AbyssalEndScreen_FreeClaimButton" : "#AbyssalEndScreen_SummaryInSettle";
      },
      get onactivate() {
        return props.onClaim;
      }
    }), null);
    return _el$11;
  })();
};
const AbyssalRewardsPanel = props => {
  const lastAbyssalSummary = solid_utils.createPlayerNetDataSignal("player_data", "last_abyssal_end_summary");
  const difficulty = libs.createMemo(() => lastAbyssalSummary()?.difficulty ?? 0);
  return (() => {
    const _el$27 = libs.createElement("Panel", {
        id: "AbyssalRewardsPanel",
        "class": "AbyssalContentPanel"
      }, null);
      libs.createElement("DOTAParticleScenePanel", {
        id: "BottomParticle",
        particleName: "particles/ui/game/ui_game_general_special_effects_05_1_fx.vpcf",
        cameraOrigin: "0 0 800",
        fov: 90,
        lookAt: "0 0 0",
        hittest: false,
        squarePixels: true
      }, _el$27);
      const _el$29 = libs.createElement("Panel", {
        id: "RewardsHeaderContainer"
      }, _el$27),
      _el$30 = libs.createElement("Panel", {
        id: "RewardsHeader"
      }, _el$29),
      _el$31 = libs.createElement("Label", {
        id: "RewardsHeaderText",
        get text() {
          return LocalizeWithVars("#AbyssalEndScreen_RewardsTitle", {
            diff: difficulty()
          });
        }
      }, _el$30),
      _el$32 = libs.createElement("Panel", {
        id: "RewardsHeaderInfoIcon",
        "class": "ToolTipInfo"
      }, _el$30);
      libs.createElement("Image", {
        id: "RewardsDivider",
        hittest: false
      }, _el$29);
      const _el$34 = libs.createElement("Panel", {
        id: "RewardsScoreContainer"
      }, _el$29);
      libs.createElement("Label", {
        id: "RewardsScoreTitleText",
        text: "#AbyssalEndScreen_CurrentScore"
      }, _el$34);
      const _el$36 = libs.createElement("Label", {
        id: "RewardsScoreValue",
        get text() {
          return props.score;
        }
      }, _el$34);
    libs.setProp(_el$32, "tooltip_text", "#AbyssalEndScreen_RewardsInfoIconTooltip");
    libs.insert(_el$27, libs.createComponent(libs.Show, {
      get when() {
        return props.view == "preview";
      },
      get children() {
        return libs.createComponent(AbyssalRewardsPreviewPanel, {
          get rewards() {
            return props.rewards;
          },
          get onClose() {
            return props.onPreviewClose;
          }
        });
      }
    }), null);
    libs.insert(_el$27, libs.createComponent(libs.Show, {
      get when() {
        return props.view == "rewards";
      },
      get children() {
        return libs.createComponent(AbyssalRewardsBoxPanel, {
          get claimState() {
            return props.claimState;
          },
          get claimParticleTrigger() {
            return props.claimParticleTrigger;
          },
          get rewardsVisible() {
            return props.rewardsVisible;
          },
          get settled() {
            return props.settled;
          },
          get onCancel() {
            return props.onCancel;
          },
          get onClaim() {
            return props.onClaim;
          }
        });
      }
    }), null);
    libs.effect(_p$ => {
      const _v$0 = LocalizeWithVars("#AbyssalEndScreen_RewardsTitle", {
          diff: difficulty()
        }),
        _v$1 = props.score;
      _v$0 !== _p$._v$0 && (_p$._v$0 = libs.setProp(_el$31, "text", _v$0, _p$._v$0));
      _v$1 !== _p$._v$1 && (_p$._v$1 = libs.setProp(_el$36, "text", _v$1, _p$._v$1));
      return _p$;
    }, {
      _v$0: undefined,
      _v$1: undefined
    });
    return _el$27;
  })();
};
const AbyssalSummary = props => {
  const lastEndScreenMeta = solid_utils.createNetDataSignal("common", "last_end_screen_meta");
  const lastEndScreenMvp = solid_utils.createNetDataSignal("common", "last_end_screen_mvp");
  const settle_info = solid_utils.createNetDataSignal("common", "settle_info", {
    end_time: -1,
    show_menu_bar: false,
    end_by_custom: false
  });
  const [countDown, setCountDown] = libs.createSignal(0);
  let countDownTimer;
  const localHeroSelection = solid_utils.createPlayerNetDataSignal("common", "hero_selection");
  const lastAbyssalSummary = solid_utils.createPlayerNetDataSignal("player_data", "last_abyssal_end_summary");
  const lastAbyssalBattle = solid_utils.createPlayerNetDataSignal("player_data", "last_abyssal_end_battle");
  const lastAbyssalBuild = solid_utils.createPlayerNetDataSignal("player_data", "last_abyssal_end_build");
  const lastAbyssalRewardPreview = solid_utils.createPlayerNetDataSignal("player_data", "last_abyssal_reward_preview");
  const snapshotID = libs.createMemo(() => lastEndScreenMeta()?.mode == "abyssal" ? lastEndScreenMeta()?.snapshot_id : undefined);
  const isCurrentSnapshot = data => snapshotID() != undefined && data?.snapshot_id == snapshotID();
  const activeSummary = libs.createMemo(() => {
    const snapshot = lastAbyssalSummary();
    return isCurrentSnapshot(snapshot) ? snapshot : undefined;
  });
  const activeBattle = libs.createMemo(() => {
    const snapshot = lastAbyssalBattle();
    return isCurrentSnapshot(snapshot) ? snapshot : undefined;
  });
  const activeBuild = libs.createMemo(() => {
    const snapshot = lastAbyssalBuild();
    return isCurrentSnapshot(snapshot) ? snapshot : undefined;
  });
  const activeRewards = libs.createMemo(() => {
    const snapshot = lastAbyssalRewardPreview();
    if (isCurrentSnapshot(snapshot)) {
      return snapshot?.rewards ?? [];
    }
    return [];
  });
  const activeMvpSummary = libs.createMemo(() => {
    const snapshot = lastEndScreenMvp();
    return isCurrentSnapshot(snapshot) ? snapshot : undefined;
  });
  const mvpPlayerID = libs.createMemo(() => activeMvpSummary()?.player_id);
  const mvpSteamID = libs.createMemo(() => {
    const playerID = mvpPlayerID();
    if (playerID === undefined) {
      return Game.GetPlayerInfo(Players.GetLocalPlayer())?.player_steamid ?? "-1";
    }
    return Game.GetPlayerInfo(playerID)?.player_steamid ?? "-1";
  });
  const heroName = libs.createMemo(() => activeMvpSummary()?.hero_name ?? DEFAULT_HERO_NAME);
  const blessingList = libs.createMemo(() => activeBuild()?.blessings ?? []);
  const artifactList = libs.createMemo(() => activeBuild()?.artifacts ?? []);
  const abilityUpgradeList = libs.createMemo(() => activeBuild()?.ability_upgrades ?? []);
  const aliveTime = libs.createMemo(() => formatDuration(activeSummary()?.alive_time ?? 0));
  const summaryDifficulty = libs.createMemo(() => activeSummary()?.difficulty ?? 0);
  const summaryScore = libs.createMemo(() => `${activeSummary()?.score ?? 0}`);
  const stageProgressMetrics = libs.createMemo(() => {
    const summary = activeSummary();
    return [{
      label: "#EndScreen_ClearTime",
      value: aliveTime()
    }, {
      label: "#EndScreen_Difficulty",
      value: `${summary?.difficulty ?? 0}`
    }, {
      label: "#EndScreen_Score",
      value: `${summary?.score ?? 0}`
    }, {
      label: "#EndScreen_KillCount",
      value: `${summary?.kill_count ?? 0}`
    }];
  });
  const battleMetrics = libs.createMemo(() => {
    const summary = activeSummary();
    return [{
      label: "#EndScreen_MaxMultiplier",
      value: `${(summary?.combo_multiplier_max ?? 0).toFixed(1)}`
    }, {
      label: "#EndScreen_KillCount",
      value: `${summary?.kill_count ?? 0}`
    }];
  });
  const skillDamageTotal = libs.createMemo(() => activeBattle()?.skill_damage_total ?? 0);
  const isWaitingForPlayers = libs.createMemo(() => settle_info().end_by_custom === true && settle_info().end_time < 0);
  const isCountDownActive = libs.createMemo(() => settle_info().end_by_custom === false && countDown() > 0);
  const damageSources = libs.createMemo(() => {
    const sources = activeBattle()?.ability_damage_sources ?? [];
    const blessings = blessingList();
    const artifacts = artifactList();
    const heroIndex = localHeroSelection()?.heroIndex;
    return buildDamageSourceItems(sources, blessings, artifacts, heroIndex);
  });
  libs.createEffect(libs.on(() => settle_info().end_time, endTime => {
    if (countDownTimer != undefined) {
      clearInterval(countDownTimer);
      countDownTimer = undefined;
    }
    if (endTime == undefined) {
      setCountDown(0);
      return;
    }
    const updateCountDown = () => {
      const remaining = Math.max(0, Math.ceil(endTime - Game.GetGameTime()));
      setCountDown(remaining);
      if (remaining <= 0 && countDownTimer != undefined) {
        clearInterval(countDownTimer);
        countDownTimer = undefined;
      }
    };
    updateCountDown();
    if (endTime - Game.GetGameTime() > 0) {
      countDownTimer = setInterval(updateCountDown, 100);
    }
  }));
  libs.onCleanup(() => {
    if (countDownTimer != undefined) {
      clearInterval(countDownTimer);
      countDownTimer = undefined;
    }
  });
  return (() => {
    const _el$40 = libs.createElement("Panel", {
        id: "AbyssalSummaryStage"
      }, null),
      _el$41 = libs.createElement("Panel", {
        id: "Certificate"
      }, _el$40),
      _el$42 = libs.createElement("Panel", {
        id: "Header"
      }, _el$41),
      _el$43 = libs.createElement("Panel", {
        id: "SummaryHeaderContainer"
      }, _el$42),
      _el$44 = libs.createElement("Panel", {
        id: "SummaryHeader"
      }, _el$43),
      _el$45 = libs.createElement("Label", {
        id: "SummaryHeaderText",
        get text() {
          return LocalizeWithVars("#AbyssalEndScreen_RewardsTitle", {
            diff: summaryDifficulty()
          });
        }
      }, _el$44),
      _el$46 = libs.createElement("Panel", {
        id: "SummaryHeaderInfoIcon",
        "class": "ToolTipInfo"
      }, _el$44);
      libs.createElement("Image", {
        id: "SummaryDivider",
        hittest: false
      }, _el$43);
      const _el$48 = libs.createElement("Panel", {
        id: "SummaryScoreContainer"
      }, _el$43);
      libs.createElement("Label", {
        id: "SummaryScoreTitleText",
        text: "#AbyssalEndScreen_CurrentScore"
      }, _el$48);
      const _el$50 = libs.createElement("Label", {
        id: "SummaryScoreValue",
        get text() {
          return summaryScore();
        }
      }, _el$48),
      _el$51 = libs.createElement("Panel", {
        id: "HalfHero"
      }, _el$41),
      _el$52 = libs.createElement("Panel", {
        id: "MvpInfo"
      }, _el$51),
      _el$53 = libs.createElement("Panel", {
        "class": "Mvp"
      }, _el$52);
      libs.createElement("Image", {}, _el$53);
      const _el$55 = libs.createElement("Panel", {
        "class": "PlayerInfo"
      }, _el$52),
      _el$56 = libs.createElement("Panel", {
        "class": "NamePanel"
      }, _el$55),
      _el$57 = libs.createElement("Panel", {
        "class": "PlayerAvatar"
      }, _el$55);
      libs.createElement("Panel", {
        "class": "CustomBorder"
      }, _el$57);
      const _el$59 = libs.createElement("DOTAAvatarImage", {
        get steamid() {
          return mvpSteamID();
        },
        align: "center center",
        width: "71%",
        height: "71%",
        hittest: false
      }, _el$57),
      _el$60 = libs.createElement("Panel", {
        id: "CertificateBody"
      }, _el$41),
      _el$61 = libs.createElement("Panel", {
        id: "InfoColumn"
      }, _el$60),
      _el$62 = libs.createElement("Panel", {
        "class": "DataSection Bless"
      }, _el$61),
      _el$63 = libs.createElement("Panel", {
        "class": "SectionTitleRow"
      }, _el$62);
      libs.createElement("Image", {
        "class": "TitleIcon"
      }, _el$63);
      libs.createElement("Label", {
        "class": "SectionTitle",
        text: "#EndScreen_Blessing"
      }, _el$63);
      libs.createElement("Panel", {
        "class": "SectionLine"
      }, _el$63);
      const _el$67 = libs.createElement("Panel", {
        "class": "BadgeList BlessingList",
        scroll: "y"
      }, _el$62),
      _el$68 = libs.createElement("Panel", {
        "class": "DataSection Artifact"
      }, _el$61),
      _el$69 = libs.createElement("Panel", {
        "class": "SectionTitleRow"
      }, _el$68);
      libs.createElement("Image", {
        "class": "TitleIcon"
      }, _el$69);
      libs.createElement("Label", {
        "class": "SectionTitle",
        text: "#EndScreen_Artifact"
      }, _el$69);
      libs.createElement("Panel", {
        "class": "SectionLine"
      }, _el$69);
      const _el$73 = libs.createElement("Panel", {
        "class": "BadgeList ArtifactList",
        scroll: "x"
      }, _el$68),
      _el$74 = libs.createElement("Panel", {
        "class": "DataSection Upgrade"
      }, _el$61),
      _el$75 = libs.createElement("Panel", {
        "class": "SectionTitleRow"
      }, _el$74);
      libs.createElement("Image", {
        "class": "TitleIcon"
      }, _el$75);
      libs.createElement("Label", {
        "class": "SectionTitle",
        text: "#EndScreen_AbilityUpgrade"
      }, _el$75);
      libs.createElement("Panel", {
        "class": "SectionLine"
      }, _el$75);
      const _el$79 = libs.createElement("Panel", {
        "class": "BadgeList UpgradeList",
        scroll: "x"
      }, _el$74),
      _el$80 = libs.createElement("Panel", {
        id: "RewardList"
      }, _el$61),
      _el$81 = libs.createElement("Panel", {
        "class": "SectionTitleRow"
      }, _el$80);
      libs.createElement("Image", {
        "class": "TitleIcon"
      }, _el$81);
      libs.createElement("Label", {
        "class": "SectionTitle",
        text: "#EndScreen_Loot"
      }, _el$81);
      libs.createElement("Panel", {
        "class": "SectionLine"
      }, _el$81);
      const _el$85 = libs.createElement("Panel", {
        id: "RewardItemList",
        scroll: "y"
      }, _el$80),
      _el$86 = libs.createElement("Panel", {
        id: "SummaryColumn"
      }, _el$60),
      _el$87 = libs.createElement("Panel", {
        "class": "SideSection ProgressSection"
      }, _el$86),
      _el$88 = libs.createElement("Panel", {
        "class": "SideTitleRow"
      }, _el$87),
      _el$89 = libs.createElement("Label", {
        "class": "SideTitle",
        horizontalAlign: "center",
        text: "#EndScreen_StageProgress"
      }, _el$88),
      _el$90 = libs.createElement("Panel", {
        "class": "MetricsGrid"
      }, _el$86),
      _el$91 = libs.createElement("Panel", {
        "class": "SideSection DamageSection"
      }, _el$86),
      _el$92 = libs.createElement("Panel", {
        "class": "DamageHeaderRow"
      }, _el$91);
      libs.createElement("Label", {
        "class": "SideTitle DamageTitle",
        text: "#EndScreen_DamageSource"
      }, _el$92);
      const _el$94 = libs.createElement("Label", {
        "class": "DamageTotal",
        get text() {
          return FormatNumber(skillDamageTotal());
        }
      }, _el$92),
      _el$95 = libs.createElement("Panel", {
        "class": "DamageRowList",
        scroll: "y"
      }, _el$91),
      _el$96 = libs.createElement("Label", {
        id: "SummaryWaitTips",
        text: "#AbyssalEndScreen_SummaryWaitTips"
      }, _el$40);
    libs.setProp(_el$46, "tooltip_text", "#AbyssalEndScreen_RewardsInfoIconTooltip");
    libs.insert(_el$51, libs.createComponent(solid_utils.DynamicKey, {
      key: heroName,
      children: heroname => libs.createComponent(portraitsFullBodyLoadout.PortraitsFullBodyLoadout, {
        unit: heroname,
        camera: "endscreen"
      })
    }), _el$52);
    libs.insert(_el$56, libs.createComponent(Player.PlayerName, {
      get steamid() {
        return mvpSteamID();
      },
      showgGild: false
    }));
    libs.setProp(_el$59, "style", {
      borderRadius: "50%"
    });
    libs.setProp(_el$59, "align", "center center");
    libs.setProp(_el$59, "width", "71%");
    libs.setProp(_el$59, "height", "71%");
    libs.setProp(_el$67, "scroll", "y");
    libs.insert(_el$67, libs.createComponent(libs.For, {
      get each() {
        return blessingList();
      },
      children: (item, index) => libs.createComponent(common_item.CommonItem, {
        showTips: true,
        get itemName() {
          return item.name;
        },
        get rarity() {
          return item.rarity;
        },
        get transitionDelay() {
          return 0.1 + index() * 0.3 + "s";
        },
        get classList() {
          return {
            Show: props.showItems
          };
        }
      })
    }));
    libs.setProp(_el$73, "scroll", "x");
    libs.insert(_el$73, libs.createComponent(libs.For, {
      get each() {
        return artifactList();
      },
      children: (item, index) => libs.createComponent(common_item.CommonItem, {
        showTips: true,
        get itemName() {
          return item.item_name;
        },
        get transitionDelay() {
          return 0.2 + index() * 0.3 + "s";
        },
        get classList() {
          return {
            Show: props.showItems
          };
        }
      })
    }));
    libs.setProp(_el$79, "scroll", "x");
    libs.insert(_el$79, libs.createComponent(libs.For, {
      get each() {
        return abilityUpgradeList();
      },
      children: (item, index) => libs.createComponent(upgrade_icon.UpgradeIcon, {
        showTips: true,
        get upgradeID() {
          return item.name;
        },
        get transitionDelay() {
          return 0.3 + index() * 0.3 + "s";
        },
        get classList() {
          return {
            Show: props.showItems
          };
        }
      })
    }));
    libs.setProp(_el$85, "scroll", "y");
    libs.insert(_el$85, libs.createComponent(libs.For, {
      get each() {
        return [...activeRewards()].sort((a, b) => (b.rarity ?? 0) - (a.rarity ?? 0));
      },
      children: (data, index) => (() => {
        const _el$97 = libs.createElement("Panel", {
          "class": "RewardCard"
        }, null);
        libs.insert(_el$97, libs.createComponent(SummaryRewardItem, {
          reward: data,
          get transitionDelay() {
            return 0.5 + index() * 0.3 + "s";
          },
          get classList() {
            return {
              Show: props.showItems
            };
          }
        }));
        return _el$97;
      })()
    }));
    libs.setProp(_el$89, "horizontalAlign", "center");
    libs.insert(_el$87, libs.createComponent(libs.For, {
      get each() {
        return stageProgressMetrics();
      },
      children: (metric, idx) => [libs.createElement("Panel", {
        "class": "StatLine"
      }, null), (() => {
        const _el$99 = libs.createElement("Panel", {
            "class": "StatRow ProgressRow"
          }, null),
          _el$100 = libs.createElement("Panel", {
            verticalAlign: "center",
            flowChildren: "right"
          }, _el$99),
          _el$101 = libs.createElement("Image", {
            get ["class"]() {
              return "StatRowImg img" + idx();
            }
          }, _el$100),
          _el$102 = libs.createElement("Label", {
            "class": "StatLabel",
            get text() {
              return metric.label;
            },
            get vars() {
              return metric.vars;
            }
          }, _el$100),
          _el$103 = libs.createElement("Label", {
            "class": `StatValue`,
            get text() {
              return metric.value;
            },
            get vars() {
              return metric.vars;
            }
          }, _el$99);
        libs.setProp(_el$100, "verticalAlign", "center");
        libs.setProp(_el$100, "flowChildren", "right");
        libs.setProp(_el$103, "class", `StatValue`);
        libs.effect(_p$ => {
          const _v$15 = "StatRowImg img" + idx(),
            _v$16 = metric.label,
            _v$17 = metric.vars,
            _v$18 = metric.value,
            _v$19 = metric.vars;
          _v$15 !== _p$._v$15 && (_p$._v$15 = libs.setProp(_el$101, "class", _v$15, _p$._v$15));
          _v$16 !== _p$._v$16 && (_p$._v$16 = libs.setProp(_el$102, "text", _v$16, _p$._v$16));
          _v$17 !== _p$._v$17 && (_p$._v$17 = libs.setProp(_el$102, "vars", _v$17, _p$._v$17));
          _v$18 !== _p$._v$18 && (_p$._v$18 = libs.setProp(_el$103, "text", _v$18, _p$._v$18));
          _v$19 !== _p$._v$19 && (_p$._v$19 = libs.setProp(_el$103, "vars", _v$19, _p$._v$19));
          return _p$;
        }, {
          _v$15: undefined,
          _v$16: undefined,
          _v$17: undefined,
          _v$18: undefined,
          _v$19: undefined
        });
        return _el$99;
      })()]
    }), null);
    libs.insert(_el$90, libs.createComponent(libs.For, {
      get each() {
        return battleMetrics();
      },
      children: (metric, idx) => [(() => {
        const _el$104 = libs.createElement("Panel", {
            "class": `MetricCard`
          }, null),
          _el$105 = libs.createElement("Label", {
            "class": "MetricLabel",
            get text() {
              return metric.label;
            }
          }, _el$104),
          _el$106 = libs.createElement("Label", {
            "class": "MetricValue",
            get text() {
              return metric.value;
            }
          }, _el$104);
        libs.setProp(_el$104, "class", `MetricCard`);
        libs.effect(_p$ => {
          const _v$20 = metric.label,
            _v$21 = metric.value;
          _v$20 !== _p$._v$20 && (_p$._v$20 = libs.setProp(_el$105, "text", _v$20, _p$._v$20));
          _v$21 !== _p$._v$21 && (_p$._v$21 = libs.setProp(_el$106, "text", _v$21, _p$._v$21));
          return _p$;
        }, {
          _v$20: undefined,
          _v$21: undefined
        });
        return _el$104;
      })(), (() => {
        const _el$107 = libs.createElement("Panel", {
          "class": "MetricsLine"
        }, null);
        libs.effect(_$p => libs.setProp(_el$107, "visible", idx() != battleMetrics().length - 1, _$p));
        return _el$107;
      })()]
    }));
    libs.setProp(_el$95, "scroll", "y");
    libs.insert(_el$95, libs.createComponent(libs.For, {
      get each() {
        return damageSources();
      },
      children: item => (() => {
        const _el$108 = libs.createElement("Panel", {
            "class": "DamageRow"
          }, null),
          _el$109 = libs.createElement("Panel", {
            "class": "DamageBarTrack"
          }, _el$108),
          _el$110 = libs.createElement("Panel", {
            "class": "DamageBarFill",
            get style() {
              return {
                width: item.ratio > 0 ? `${Math.max(8, Math.round(item.ratio * 100))}%` : "0%"
              };
            }
          }, _el$109),
          _el$111 = libs.createElement("Label", {
            "class": "DamageAmount",
            get text() {
              return FormatNumber(item.value);
            }
          }, _el$108);
        libs.insert(_el$108, libs.createComponent(DamageSourceIcon, {
          item: item
        }), _el$109);
        libs.effect(_p$ => {
          const _v$22 = {
              width: item.ratio > 0 ? `${Math.max(8, Math.round(item.ratio * 100))}%` : "0%"
            },
            _v$23 = FormatNumber(item.value);
          _v$22 !== _p$._v$22 && (_p$._v$22 = libs.setProp(_el$110, "style", _v$22, _p$._v$22));
          _v$23 !== _p$._v$23 && (_p$._v$23 = libs.setProp(_el$111, "text", _v$23, _p$._v$23));
          return _p$;
        }, {
          _v$22: undefined,
          _v$23: undefined
        });
        return _el$108;
      })()
    }));
    libs.insert(_el$40, libs.createComponent(StoreItem.EOM_ImageNumber, {
      id: "CountDown",
      get visible() {
        return isCountDownActive();
      },
      type: "5",
      get value() {
        return countDown();
      }
    }), null);
    libs.effect(_p$ => {
      const _v$10 = LocalizeWithVars("#AbyssalEndScreen_RewardsTitle", {
          diff: summaryDifficulty()
        }),
        _v$11 = summaryScore(),
        _v$12 = mvpSteamID(),
        _v$13 = FormatNumber(skillDamageTotal()),
        _v$14 = isWaitingForPlayers();
      _v$10 !== _p$._v$10 && (_p$._v$10 = libs.setProp(_el$45, "text", _v$10, _p$._v$10));
      _v$11 !== _p$._v$11 && (_p$._v$11 = libs.setProp(_el$50, "text", _v$11, _p$._v$11));
      _v$12 !== _p$._v$12 && (_p$._v$12 = libs.setProp(_el$59, "steamid", _v$12, _p$._v$12));
      _v$13 !== _p$._v$13 && (_p$._v$13 = libs.setProp(_el$94, "text", _v$13, _p$._v$13));
      _v$14 !== _p$._v$14 && (_p$._v$14 = libs.setProp(_el$96, "visible", _v$14, _p$._v$14));
      return _p$;
    }, {
      _v$10: undefined,
      _v$11: undefined,
      _v$12: undefined,
      _v$13: undefined,
      _v$14: undefined
    });
    return _el$40;
  })();
};
const Abyssal = () => {
  const gameState = solid_utils.createNetDataSignal("common", "game_state");
  const lastEndScreenMeta = solid_utils.createNetDataSignal("common", "last_end_screen_meta");
  const lastAbyssalSummary = solid_utils.createPlayerNetDataSignal("player_data", "last_abyssal_end_summary");
  const lastAbyssalRewardPreview = solid_utils.createPlayerNetDataSignal("player_data", "last_abyssal_reward_preview");
  const [view, setView] = libs.createSignal("rewards");
  const [claimState, setClaimState] = libs.createSignal("idle");
  const [claimParticleTrigger, setClaimParticleTrigger] = libs.createSignal(0);
  const [introStage, setIntroStage] = libs.createSignal();
  let receivedTimer;
  let previewTimer;
  let abyssalMedalIntroSchedule;
  let abyssalMedalMovingSchedule;
  let abyssalSummaryEnteringSchedule;
  let abyssalSummaryVisibleSchedule;
  const snapshotID = libs.createMemo(() => lastEndScreenMeta()?.mode == "abyssal" ? lastEndScreenMeta()?.snapshot_id : undefined);
  const abyssalVictory = libs.createMemo(() => lastEndScreenMeta()?.result == "victory");
  libs.createMemo(() => gameState()?.state == "GameState_Settle" && lastEndScreenMeta()?.mode == "abyssal");
  const activeSummary = libs.createMemo(() => {
    const snapshot = lastAbyssalSummary();
    return snapshotID() != undefined && snapshot?.snapshot_id == snapshotID() ? snapshot : undefined;
  });
  const isAbyssalSettled = libs.createMemo(() => activeSummary()?.settled === true);
  const activeRewardPreview = libs.createMemo(() => {
    const snapshot = lastAbyssalRewardPreview();
    return snapshotID() != undefined && snapshot?.snapshot_id == snapshotID() ? snapshot : undefined;
  });
  const previewRewards = libs.createMemo(() => {
    return activeRewardPreview()?.rewards ?? [];
  });
  const clearPreviewTimer = () => {
    if (previewTimer != undefined) {
      $.CancelScheduled(previewTimer);
      previewTimer = undefined;
    }
  };
  const clearReceivedTimer = () => {
    if (receivedTimer != undefined) {
      $.CancelScheduled(receivedTimer);
      receivedTimer = undefined;
    }
  };
  const clearClaimRevealTimers = () => {
    clearReceivedTimer();
    clearPreviewTimer();
  };
  const clearAbyssalIntroTimers = () => {
    if (abyssalMedalIntroSchedule != undefined) {
      $.CancelScheduled(abyssalMedalIntroSchedule);
      abyssalMedalIntroSchedule = undefined;
    }
    if (abyssalMedalMovingSchedule != undefined) {
      $.CancelScheduled(abyssalMedalMovingSchedule);
      abyssalMedalMovingSchedule = undefined;
    }
    if (abyssalSummaryEnteringSchedule != undefined) {
      $.CancelScheduled(abyssalSummaryEnteringSchedule);
      abyssalSummaryEnteringSchedule = undefined;
    }
    if (abyssalSummaryVisibleSchedule != undefined) {
      $.CancelScheduled(abyssalSummaryVisibleSchedule);
      abyssalSummaryVisibleSchedule = undefined;
    }
  };
  const replayAbyssalIntro = () => {
    clearAbyssalIntroTimers();
    setIntroStage(undefined);
    abyssalMedalIntroSchedule = $.Schedule(0, () => {
      abyssalMedalIntroSchedule = undefined;
      setIntroStage("medal_intro");
    });
    abyssalMedalMovingSchedule = $.Schedule(1.0, () => {
      abyssalMedalMovingSchedule = undefined;
      setIntroStage("medal_moving");
    });
    abyssalSummaryEnteringSchedule = $.Schedule(1.15, () => {
      abyssalSummaryEnteringSchedule = undefined;
      setIntroStage("summary_entering");
    });
    abyssalSummaryVisibleSchedule = $.Schedule(1.2, () => {
      abyssalSummaryVisibleSchedule = undefined;
      setIntroStage("summary_visible");
    });
  };
  const showSummary = () => {
    clearClaimRevealTimers();
    setClaimParticleTrigger(0);
    setView("summary");
  };
  libs.createEffect(libs.on(snapshotID, () => {
    clearClaimRevealTimers();
    setView("rewards");
    setClaimState("idle");
    setClaimParticleTrigger(0);
    replayAbyssalIntro();
  }));
  libs.createEffect(libs.on(view, currentView => {
    if (currentView == "summary") {
      GameEvents.SendCustomEventToServer("abyssal_summary_ready", {});
    }
  }));
  libs.createEffect(libs.on(activeRewardPreview, preview => {
    if (preview == undefined || claimState() != "opening" || view() != "rewards") {
      return;
    }
    clearClaimRevealTimers();
    setClaimParticleTrigger(trigger => trigger + 1);
    receivedTimer = $.Schedule(1, () => {
      receivedTimer = undefined;
      if (view() == "rewards" && claimState() == "opening") {
        setClaimState("received");
      }
    });
    previewTimer = $.Schedule(2.1, () => {
      previewTimer = undefined;
      if (view() == "rewards") {
        setView("preview");
      }
    });
  }));
  const claimFailedListener = GameEvents.Subscribe("abyssal_rewards_claim_failed", event => {
    console.log("Receive Rewards Error");
    const errorLocalizationKey = event.message === "rune count reach limit" ? "#error_rune_count_reach_limit" : "#error_receive_abyssal_rewards";
    ErrorMessage(GetLocalization(errorLocalizationKey));
    clearClaimRevealTimers();
    setClaimParticleTrigger(0);
    setClaimState("idle");
  });
  libs.onCleanup(() => {
    clearClaimRevealTimers();
    clearAbyssalIntroTimers();
    GameEvents.Unsubscribe(claimFailedListener);
  });
  const claimRewards = () => {
    if (claimState() != "idle" || !isAbyssalSettled()) {
      return;
    }
    setClaimState("opening");
    GameEvents.SendCustomEventToServer("receive_abyssal_rewards", {});
  };
  return (() => {
    const _el$112 = libs.createElement("Panel", {
        id: "AbyssalSummary",
        get ["class"]() {
          return libs.classNames(abyssalVictory() ? "AbyssalVictory" : "AbyssalDefeat", {
            AbyssalStageMedalIntro: introStage() == "medal_intro",
            AbyssalStageMedalMoving: introStage() == "medal_moving",
            AbyssalStageSummaryEntering: introStage() == "summary_entering",
            AbyssalStageSummaryVisible: introStage() == "summary_visible"
          });
        }
      }, null),
      _el$113 = libs.createElement("Panel", {
        id: "AbyssalSummaryLayer"
      }, _el$112);
      libs.createElement("Image", {
        id: "SummaryBackground",
        hittest: false
      }, _el$113);
      const _el$115 = libs.createElement("Panel", {
        id: "AbyssalContentStage",
        get hittest() {
          return introStage() == "summary_visible";
        }
      }, _el$113);
    libs.insert(_el$115, libs.createComponent(libs.Show, {
      get when() {
        return view() == "rewards" || view() == "preview";
      },
      get children() {
        return libs.createComponent(AbyssalRewardsPanel, {
          get score() {
            return `${activeSummary()?.score ?? 0}`;
          },
          get killCount() {
            return `${activeSummary()?.kill_count ?? 0}`;
          },
          get aliveTime() {
            return formatDuration(activeSummary()?.alive_time ?? 0);
          },
          get view() {
            return view();
          },
          get claimState() {
            return claimState();
          },
          get claimParticleTrigger() {
            return claimParticleTrigger();
          },
          get rewardsVisible() {
            return libs.memo(() => introStage() == "summary_visible")() && view() == "rewards";
          },
          get settled() {
            return isAbyssalSettled();
          },
          get rewards() {
            return previewRewards();
          },
          onCancel: showSummary,
          onClaim: claimRewards,
          onPreviewClose: showSummary
        });
      }
    }), null);
    libs.insert(_el$115, libs.createComponent(libs.Show, {
      get when() {
        return view() == "summary";
      },
      get children() {
        return libs.createComponent(AbyssalSummary, {
          get showItems() {
            return introStage() == "summary_visible";
          }
        });
      }
    }), null);
    libs.effect(_p$ => {
      const _v$24 = libs.classNames(abyssalVictory() ? "AbyssalVictory" : "AbyssalDefeat", {
          AbyssalStageMedalIntro: introStage() == "medal_intro",
          AbyssalStageMedalMoving: introStage() == "medal_moving",
          AbyssalStageSummaryEntering: introStage() == "summary_entering",
          AbyssalStageSummaryVisible: introStage() == "summary_visible"
        }),
        _v$25 = introStage() == "summary_visible";
      _v$24 !== _p$._v$24 && (_p$._v$24 = libs.setProp(_el$112, "class", _v$24, _p$._v$24));
      _v$25 !== _p$._v$25 && (_p$._v$25 = libs.setProp(_el$115, "hittest", _v$25, _p$._v$25));
      return _p$;
    }, {
      _v$24: undefined,
      _v$25: undefined
    });
    return _el$112;
  })();
};

const bottomParticleName = ["particles/ui/game/ui_game_general_special_effects_05_fx.vpcf", "particles/ui/game/ui_game_general_special_effects_05_2_fx.vpcf"];
const resultParticleName = ["particles/ui/game/ui_game_settlement_interface_01_fx.vpcf", "particles/ui/game/ui_game_settlement_interface_02_fx.vpcf"];
const DungeonSummary = props => {
  const gameState = solid_utils.createNetDataSignal("common", "game_state");
  const lastEndScreenMeta = solid_utils.createNetDataSignal("common", "last_end_screen_meta");
  const lastEndScreenMvp = solid_utils.createNetDataSignal("common", "last_end_screen_mvp");
  const settle_info = solid_utils.createNetDataSignal("common", "settle_info", {
    end_time: -1,
    show_menu_bar: false
  });
  const vistory = libs.createMemo(() => lastEndScreenMeta()?.result == "victory");
  const [step, setStep] = libs.createSignal(1);
  const [countDown, setCountDown] = libs.createSignal(0);
  let countDownTimer;
  const localHeroSelection = solid_utils.createPlayerNetDataSignal("common", "hero_selection");
  const lastEndScreenPlayer = solid_utils.createPlayerNetDataSignal("player_data", "last_end_screen_player");
  const lastDungeonEndProgress = solid_utils.createPlayerNetDataSignal("player_data", "last_dungeon_end_progress");
  const lastDungeonEndBattle = solid_utils.createPlayerNetDataSignal("player_data", "last_dungeon_end_battle");
  const lastDungeonEndBuild = solid_utils.createPlayerNetDataSignal("player_data", "last_dungeon_end_build");
  const lastEndScreenRewards = solid_utils.createPlayerNetDataSignal("player_data", "last_end_screen_rewards");
  const snapshotID = libs.createMemo(() => lastEndScreenMeta()?.mode == "dungeon" ? lastEndScreenMeta()?.snapshot_id : undefined);
  const isCurrentSnapshot = data => snapshotID() != undefined && data?.snapshot_id == snapshotID();
  const activePlayerSnapshot = libs.createMemo(() => {
    const snapshot = lastEndScreenPlayer();
    return isCurrentSnapshot(snapshot) ? snapshot : undefined;
  });
  const activeProgress = libs.createMemo(() => {
    const snapshot = lastDungeonEndProgress();
    return isCurrentSnapshot(snapshot) ? snapshot : undefined;
  });
  const activeBattle = libs.createMemo(() => {
    const snapshot = lastDungeonEndBattle();
    return isCurrentSnapshot(snapshot) ? snapshot : undefined;
  });
  const activeBuild = libs.createMemo(() => {
    const snapshot = lastDungeonEndBuild();
    return isCurrentSnapshot(snapshot) ? snapshot : undefined;
  });
  const activeRewards = libs.createMemo(() => {
    const snapshot = lastEndScreenRewards();
    if (isCurrentSnapshot(snapshot)) {
      return snapshot?.rewards ?? [];
    }
    return [];
  });
  const sortedRewards = libs.createMemo(() => {
    return [...activeRewards()].sort((a, b) => {
      const aIsDrawing = KeyValues.info_item_drawing[a.item_id] != undefined;
      const bIsDrawing = KeyValues.info_item_drawing[b.item_id] != undefined;
      if (aIsDrawing != bIsDrawing) {
        return aIsDrawing ? -1 : 1;
      }
      const aIsKey = KeyValues.info_item_key[a.item_id] != undefined;
      const bIsKey = KeyValues.info_item_key[b.item_id] != undefined;
      if (aIsKey != bIsKey) {
        return aIsKey ? -1 : 1;
      }
      return (b.item_rarity ?? 0) - (a.item_rarity ?? 0);
    });
  });
  const activeMvpSummary = libs.createMemo(() => {
    const snapshot = lastEndScreenMvp();
    if (snapshotID() != undefined && snapshot?.snapshot_id == snapshotID()) {
      return snapshot;
    }
    return undefined;
  });
  const mvpPlayerID = libs.createMemo(() => activeMvpSummary()?.player_id);
  const mvpSteamID = libs.createMemo(() => {
    const playerID = mvpPlayerID();
    if (playerID === undefined) {
      return Game.GetPlayerInfo(Players.GetLocalPlayer())?.player_steamid ?? "-1";
    }
    return Game.GetPlayerInfo(playerID)?.player_steamid ?? "-1";
  });
  const heroName = libs.createMemo(() => activeMvpSummary()?.hero_name ?? activePlayerSnapshot()?.hero_name ?? "npc_dota_hero_vexis");
  const blessingList = libs.createMemo(() => activeBuild()?.blessings ?? []);
  const artifactList = libs.createMemo(() => activeBuild()?.artifacts ?? []);
  const abilityUpgradeList = libs.createMemo(() => activeBuild()?.ability_upgrades ?? []);
  const completionTime = libs.createMemo(() => formatDuration(activePlayerSnapshot()?.completion_time ?? 0));
  const stageProgressMetrics = libs.createMemo(() => {
    const progress = activeProgress();
    const meta = lastEndScreenMeta();
    const difficulty = meta?.difficulty ?? 1;
    const difficultyText = meta?.key_intensity == undefined ? `${difficulty}` : `${difficulty}-${meta.key_intensity}`;
    return [{
      label: "#EndScreen_ClearTime",
      value: completionTime()
    }, {
      label: "#EndScreen_Difficulty",
      value: difficultyText
    }, {
      label: "#EndScreen_ZoneProgress",
      value: progress != undefined ? `${progress.zone_index}/${progress.zone_total}` : "-"
    }, {
      label: "#EndScreen_RoomProgress",
      value: progress != undefined ? `${progress.room_step}/${progress.room_total}` : "-"
    }];
  });
  const battleMetrics = libs.createMemo(() => {
    const battle = activeBattle();
    return [{
      label: "#EndScreen_NormalKills",
      value: `${battle?.normal_kills ?? 0}`
    }, {
      label: "#EndScreen_EliteKills",
      value: `${battle?.elite_kills ?? 0}`
    }];
  });
  const skillDamageTotal = libs.createMemo(() => activeBattle()?.skill_damage_total ?? 0);
  const damageSources = libs.createMemo(() => {
    const sources = activeBattle()?.ability_damage_sources ?? [];
    const blessings = blessingList();
    const artifacts = artifactList();
    const heroIndex = localHeroSelection()?.heroIndex;
    return buildDamageSourceItems(sources, blessings, artifacts, heroIndex);
  });
  libs.createEffect(libs.on(() => settle_info().end_time, endTime => {
    if (countDownTimer != undefined) {
      clearInterval(countDownTimer);
      countDownTimer = undefined;
    }
    if (endTime == undefined) {
      setCountDown(0);
      return;
    }
    const updateCountDown = () => {
      const remaining = Math.max(0, Math.ceil(endTime - Game.GetGameTime()));
      setCountDown(remaining);
      if (remaining <= 0 && countDownTimer != undefined) {
        clearInterval(countDownTimer);
        countDownTimer = undefined;
      }
    };
    updateCountDown();
    if (endTime - Game.GetGameTime() > 0) {
      countDownTimer = setInterval(updateCountDown, 100);
    }
  }));
  libs.onCleanup(() => {
    if (countDownTimer != undefined) {
      clearInterval(countDownTimer);
      countDownTimer = undefined;
    }
  });
  libs.createEffect(() => {
    if (gameState()?.state == "GameState_Settle") {
      replay();
    } else if (gameState()?.state == "GameState_Dungeon") {
      setStep(1);
    }
  });
  const replay = async () => {
    ClientSideEvent("set_menu_bar_visible", {
      key: "endscreen",
      hide: true
    });
    setStep(1);
    Game.EmitSound(vistory() ? "dsadowski_02.stinger.radiant_win" : "dsadowski_02.stinger.dire_lose");
    await Timer.Wait(2);
    setStep(2);
    await Timer.Wait(3);
    setStep(3);
    ClientSideEvent("set_menu_bar_visible", {
      key: "endscreen",
      hide: false
    });
  };
  return (() => {
    const _el$ = libs.createElement("Panel", {
        id: "EndScreenDungeon",
        get ["class"]() {
          return libs.classNames("Step" + step(), vistory() ? "Victory" : "Defeat", {
            ShowHud: props.visible
          });
        }
      }, null);
      libs.createElement("Image", {
        id: "Background"
      }, _el$);
      libs.createElement("Image", {
        id: "BackgroundOverlay"
      }, _el$);
      const _el$4 = libs.createElement("Panel", {
        id: "ResultMedal"
      }, _el$),
      _el$5 = libs.createElement("Panel", {
        id: "ResultIcon"
      }, _el$4),
      _el$8 = libs.createElement("Panel", {
        id: "Certificate"
      }, _el$);
      libs.createElement("Panel", {
        id: "Header"
      }, _el$8);
      const _el$0 = libs.createElement("Panel", {
        id: "HalfHero"
      }, _el$8),
      _el$1 = libs.createElement("Panel", {
        id: "MvpInfo"
      }, _el$0),
      _el$10 = libs.createElement("Panel", {
        "class": "Mvp"
      }, _el$1);
      libs.createElement("Image", {}, _el$10);
      const _el$12 = libs.createElement("Panel", {
        "class": "PlayerInfo"
      }, _el$1),
      _el$13 = libs.createElement("Panel", {
        "class": "NamePanel"
      }, _el$12),
      _el$14 = libs.createElement("Panel", {
        "class": "PlayerAvatar"
      }, _el$12);
      libs.createElement("Panel", {
        "class": "CustomBorder"
      }, _el$14);
      const _el$16 = libs.createElement("DOTAAvatarImage", {
        get steamid() {
          return mvpSteamID();
        },
        align: "center center",
        width: "71%",
        height: "71%",
        hittest: false
      }, _el$14),
      _el$17 = libs.createElement("Panel", {
        id: "CertificateBody"
      }, _el$8),
      _el$18 = libs.createElement("Panel", {
        id: "InfoColumn"
      }, _el$17),
      _el$19 = libs.createElement("Panel", {
        "class": "DataSection Bless"
      }, _el$18),
      _el$20 = libs.createElement("Panel", {
        "class": "SectionTitleRow"
      }, _el$19);
      libs.createElement("Image", {
        "class": "TitleIcon"
      }, _el$20);
      libs.createElement("Label", {
        "class": "SectionTitle",
        text: "#EndScreen_Blessing"
      }, _el$20);
      libs.createElement("Panel", {
        "class": "SectionLine"
      }, _el$20);
      const _el$24 = libs.createElement("Panel", {
        "class": "BadgeList BlessingList",
        scroll: "y"
      }, _el$19),
      _el$25 = libs.createElement("Panel", {
        "class": "DataSection Artifact"
      }, _el$18),
      _el$26 = libs.createElement("Panel", {
        "class": "SectionTitleRow"
      }, _el$25);
      libs.createElement("Image", {
        "class": "TitleIcon"
      }, _el$26);
      libs.createElement("Label", {
        "class": "SectionTitle",
        text: "#EndScreen_Artifact"
      }, _el$26);
      libs.createElement("Panel", {
        "class": "SectionLine"
      }, _el$26);
      const _el$30 = libs.createElement("Panel", {
        "class": "BadgeList ArtifactList",
        scroll: "x"
      }, _el$25),
      _el$31 = libs.createElement("Panel", {
        "class": "DataSection Upgrade"
      }, _el$18),
      _el$32 = libs.createElement("Panel", {
        "class": "SectionTitleRow"
      }, _el$31);
      libs.createElement("Image", {
        "class": "TitleIcon"
      }, _el$32);
      libs.createElement("Label", {
        "class": "SectionTitle",
        text: "#EndScreen_AbilityUpgrade"
      }, _el$32);
      libs.createElement("Panel", {
        "class": "SectionLine"
      }, _el$32);
      const _el$36 = libs.createElement("Panel", {
        "class": "BadgeList UpgradeList",
        scroll: "x"
      }, _el$31),
      _el$37 = libs.createElement("Panel", {
        id: "RewardList"
      }, _el$18),
      _el$38 = libs.createElement("Panel", {
        "class": "SectionTitleRow"
      }, _el$37);
      libs.createElement("Image", {
        "class": "TitleIcon"
      }, _el$38);
      libs.createElement("Label", {
        "class": "SectionTitle",
        text: "#EndScreen_Loot"
      }, _el$38);
      libs.createElement("Panel", {
        "class": "SectionLine"
      }, _el$38);
      const _el$42 = libs.createElement("Panel", {
        id: "RewardItemList",
        scroll: "y"
      }, _el$37),
      _el$43 = libs.createElement("Panel", {
        id: "SummaryColumn"
      }, _el$17),
      _el$44 = libs.createElement("Panel", {
        "class": "SideSection ProgressSection"
      }, _el$43),
      _el$45 = libs.createElement("Panel", {
        "class": "SideTitleRow"
      }, _el$44),
      _el$46 = libs.createElement("Label", {
        "class": "SideTitle",
        horizontalAlign: "center",
        text: "#EndScreen_StageProgress"
      }, _el$45),
      _el$47 = libs.createElement("Panel", {
        "class": "MetricsGrid"
      }, _el$43),
      _el$48 = libs.createElement("Panel", {
        "class": "SideSection DamageSection"
      }, _el$43),
      _el$49 = libs.createElement("Panel", {
        "class": "DamageHeaderRow"
      }, _el$48);
      libs.createElement("Label", {
        "class": "SideTitle DamageTitle",
        text: "#EndScreen_DamageSource"
      }, _el$49);
      const _el$51 = libs.createElement("Label", {
        "class": "DamageTotal",
        get text() {
          return FormatNumber(skillDamageTotal());
        }
      }, _el$49),
      _el$52 = libs.createElement("Panel", {
        "class": "DamageRowList",
        scroll: "y"
      }, _el$48);
    libs.insert(_el$4, () => libs.createMemo(libs.on(vistory, win => (() => {
      const _el$53 = libs.createElement("DOTAParticleScenePanel", {
        id: "ResultParticle",
        get particleName() {
          return win ? resultParticleName[0] : resultParticleName[1];
        },
        cameraOrigin: "0 0 50",
        fov: 90,
        lookAt: "0 0 0",
        hittest: false,
        squarePixels: true
      }, null);
      libs.effect(_$p => libs.setProp(_el$53, "particleName", win ? resultParticleName[0] : resultParticleName[1], _$p));
      return _el$53;
    })())), _el$5);
    libs.setProp(_el$5, "onload", self => print("onload ResultIcon"));
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return step() == 2;
      },
      get children() {
        return [(() => {
          const _el$6 = libs.createElement("DOTAParticleScenePanel", {
            id: "BottomParticle",
            get particleName() {
              return vistory() ? bottomParticleName[0] : bottomParticleName[1];
            },
            cameraOrigin: "0 0 800",
            fov: 90,
            lookAt: "0 0 0",
            hittest: false,
            squarePixels: true
          }, null);
          libs.effect(_$p => libs.setProp(_el$6, "particleName", vistory() ? bottomParticleName[0] : bottomParticleName[1], _$p));
          return _el$6;
        })(), (() => {
          const _el$7 = libs.createElement("Panel", {
            id: "HeroList"
          }, null);
          libs.insert(_el$7, libs.createComponent(libs.For, {
            get each() {
              return Game.GetAllPlayerIDs();
            },
            children: playerID => (() => {
              const _el$54 = libs.createElement("Panel", {
                  "class": "HeroShow"
                }, null),
                _el$55 = libs.createElement("Panel", {
                  id: "Mvp"
                }, _el$54);
                libs.createElement("Image", {}, _el$55);
              libs.insert(_el$54, libs.createComponent(portraitsFullBodyLoadout.PortraitsFullBodyLoadout, {
                get unit() {
                  return getNetDataKey("common", "hero_selection", playerID)?.heroName ?? "npc_dota_hero_vespera";
                }
              }), null);
              libs.effect(_$p => libs.setProp(_el$54, "classList", {
                IsMvp: playerID === mvpPlayerID()
              }, _$p));
              return _el$54;
            })()
          }));
          return _el$7;
        })()];
      }
    }), _el$8);
    libs.insert(_el$0, libs.createComponent(solid_utils.DynamicKey, {
      key: heroName,
      children: heroname => libs.createComponent(portraitsFullBodyLoadout.PortraitsFullBodyLoadout, {
        unit: heroname,
        camera: "endscreen"
      })
    }), _el$1);
    libs.insert(_el$13, libs.createComponent(Player.PlayerName, {
      get steamid() {
        return mvpSteamID();
      },
      showgGild: false
    }));
    libs.setProp(_el$16, "style", {
      borderRadius: "50%"
    });
    libs.setProp(_el$16, "align", "center center");
    libs.setProp(_el$16, "width", "71%");
    libs.setProp(_el$16, "height", "71%");
    libs.setProp(_el$24, "scroll", "y");
    libs.insert(_el$24, libs.createComponent(libs.For, {
      get each() {
        return blessingList();
      },
      children: (item, index) => libs.createComponent(common_item.CommonItem, {
        showTips: true,
        get itemName() {
          return item.name;
        },
        get rarity() {
          return item.rarity;
        },
        get transitionDelay() {
          return 0.1 + index() * 0.3 + "s";
        },
        get classList() {
          return {
            Show: step() == 3
          };
        }
      })
    }));
    libs.setProp(_el$30, "scroll", "x");
    libs.insert(_el$30, libs.createComponent(libs.For, {
      get each() {
        return artifactList();
      },
      children: (item, index) => libs.createComponent(common_item.CommonItem, {
        showTips: true,
        get itemName() {
          return item.item_name;
        },
        get transitionDelay() {
          return 0.2 + index() * 0.3 + "s";
        },
        get classList() {
          return {
            Show: step() == 3
          };
        }
      })
    }));
    libs.setProp(_el$36, "scroll", "x");
    libs.insert(_el$36, libs.createComponent(libs.For, {
      get each() {
        return abilityUpgradeList();
      },
      children: (item, index) => libs.createComponent(upgrade_icon.UpgradeIcon, {
        showTips: true,
        get upgradeID() {
          return item.name;
        },
        get transitionDelay() {
          return 0.3 + index() * 0.3 + "s";
        },
        get classList() {
          return {
            Show: step() == 3
          };
        }
      })
    }));
    libs.setProp(_el$42, "scroll", "y");
    libs.insert(_el$42, libs.createComponent(libs.For, {
      get each() {
        return sortedRewards();
      },
      children: (data, index) => (() => {
        const _el$57 = libs.createElement("Panel", {
          "class": "RewardCard"
        }, null);
        libs.insert(_el$57, libs.createComponent(StoreItem.StoreItemBlock, {
          get classList() {
            return {
              Show: step() == 3
            };
          },
          get transitionDelay() {
            return 0.5 + index() * 0.3 + "s";
          },
          get item_id() {
            return data.item_id;
          },
          get uid() {
            return data.uid;
          },
          get amounts() {
            return data.amounts;
          },
          get rarity() {
            return data.item_rarity;
          }
        }));
        return _el$57;
      })()
    }));
    libs.setProp(_el$46, "horizontalAlign", "center");
    libs.insert(_el$44, libs.createComponent(libs.For, {
      get each() {
        return stageProgressMetrics();
      },
      children: (metric, idx) => [libs.createElement("Panel", {
        "class": "StatLine"
      }, null), (() => {
        const _el$59 = libs.createElement("Panel", {
            "class": "StatRow ProgressRow"
          }, null),
          _el$60 = libs.createElement("Panel", {
            verticalAlign: "center",
            flowChildren: "right"
          }, _el$59),
          _el$61 = libs.createElement("Image", {
            get ["class"]() {
              return "StatRowImg img" + idx();
            }
          }, _el$60),
          _el$62 = libs.createElement("Label", {
            "class": "StatLabel",
            get text() {
              return metric.label;
            },
            get vars() {
              return metric.vars;
            }
          }, _el$60),
          _el$63 = libs.createElement("Label", {
            "class": `StatValue`,
            get text() {
              return metric.value;
            },
            get vars() {
              return metric.vars;
            }
          }, _el$59);
        libs.setProp(_el$60, "verticalAlign", "center");
        libs.setProp(_el$60, "flowChildren", "right");
        libs.setProp(_el$63, "class", `StatValue`);
        libs.effect(_p$ => {
          const _v$4 = "StatRowImg img" + idx(),
            _v$5 = metric.label,
            _v$6 = metric.vars,
            _v$7 = metric.value,
            _v$8 = metric.vars;
          _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$61, "class", _v$4, _p$._v$4));
          _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$62, "text", _v$5, _p$._v$5));
          _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$62, "vars", _v$6, _p$._v$6));
          _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$63, "text", _v$7, _p$._v$7));
          _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$63, "vars", _v$8, _p$._v$8));
          return _p$;
        }, {
          _v$4: undefined,
          _v$5: undefined,
          _v$6: undefined,
          _v$7: undefined,
          _v$8: undefined
        });
        return _el$59;
      })()]
    }), null);
    libs.insert(_el$47, libs.createComponent(libs.For, {
      get each() {
        return battleMetrics();
      },
      children: (metric, idx) => [(() => {
        const _el$64 = libs.createElement("Panel", {
            "class": `MetricCard`
          }, null),
          _el$65 = libs.createElement("Label", {
            "class": "MetricLabel",
            get text() {
              return metric.label;
            }
          }, _el$64),
          _el$66 = libs.createElement("Label", {
            "class": "MetricValue",
            get text() {
              return metric.value;
            }
          }, _el$64);
        libs.setProp(_el$64, "class", `MetricCard`);
        libs.effect(_p$ => {
          const _v$9 = metric.label,
            _v$0 = metric.value;
          _v$9 !== _p$._v$9 && (_p$._v$9 = libs.setProp(_el$65, "text", _v$9, _p$._v$9));
          _v$0 !== _p$._v$0 && (_p$._v$0 = libs.setProp(_el$66, "text", _v$0, _p$._v$0));
          return _p$;
        }, {
          _v$9: undefined,
          _v$0: undefined
        });
        return _el$64;
      })(), (() => {
        const _el$67 = libs.createElement("Panel", {
          "class": "MetricsLine"
        }, null);
        libs.effect(_$p => libs.setProp(_el$67, "visible", idx() != battleMetrics().length - 1, _$p));
        return _el$67;
      })()]
    }));
    libs.setProp(_el$52, "scroll", "y");
    libs.insert(_el$52, libs.createComponent(libs.For, {
      get each() {
        return damageSources();
      },
      children: item => (() => {
        const _el$68 = libs.createElement("Panel", {
            "class": "DamageRow"
          }, null),
          _el$69 = libs.createElement("Panel", {
            "class": "DamageBarTrack"
          }, _el$68),
          _el$70 = libs.createElement("Panel", {
            "class": "DamageBarFill",
            get style() {
              return {
                width: item.ratio > 0 ? `${Math.max(8, Math.round(item.ratio * 100))}%` : "0%"
              };
            }
          }, _el$69),
          _el$71 = libs.createElement("Label", {
            "class": "DamageAmount",
            get text() {
              return FormatNumber(item.value);
            }
          }, _el$68);
        libs.insert(_el$68, libs.createComponent(DamageSourceIcon, {
          item: item
        }), _el$69);
        libs.effect(_p$ => {
          const _v$1 = {
              width: item.ratio > 0 ? `${Math.max(8, Math.round(item.ratio * 100))}%` : "0%"
            },
            _v$10 = FormatNumber(item.value);
          _v$1 !== _p$._v$1 && (_p$._v$1 = libs.setProp(_el$70, "style", _v$1, _p$._v$1));
          _v$10 !== _p$._v$10 && (_p$._v$10 = libs.setProp(_el$71, "text", _v$10, _p$._v$10));
          return _p$;
        }, {
          _v$1: undefined,
          _v$10: undefined
        });
        return _el$68;
      })()
    }));
    libs.insert(_el$, libs.createComponent(StoreItem.EOM_ImageNumber, {
      id: "CountDown",
      get visible() {
        return libs.memo(() => !!(props.visible && countDown() > 0))() && step() >= 3;
      },
      type: "5",
      get value() {
        return countDown();
      }
    }), null);
    libs.effect(_p$ => {
      const _v$ = libs.classNames("Step" + step(), vistory() ? "Victory" : "Defeat", {
          ShowHud: props.visible
        }),
        _v$2 = mvpSteamID(),
        _v$3 = FormatNumber(skillDamageTotal());
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$, "class", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$16, "steamid", _v$2, _p$._v$2));
      _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$51, "text", _v$3, _p$._v$3));
      return _p$;
    }, {
      _v$: undefined,
      _v$2: undefined,
      _v$3: undefined
    });
    return _el$;
  })();
};

const QUESTIONNAIRE_COMPLETED_COUNTER = "questionnaire_completed";
const EndScreen = () => {
  const gameState = solid_utils.createNetDataSignal("common", "game_state");
  const loginState = solid_utils.createNetDataSignal("common", "login_state", {});
  const lastEndScreenMeta = solid_utils.createNetDataSignal("common", "last_end_screen_meta");
  const playerCounters = solid_utils.createServiceNetData("player_counters", {});
  const [show, setShow] = solid_utils.createToggleWindowSignal("MenuButton_endscreen", gameState()?.state == "GameState_Settle");
  const summaryMode = libs.createMemo(() => lastEndScreenMeta()?.mode);
  const questionnaireCompleted = libs.createMemo(() => {
    return toFiniteNumber(playerCounters()[QUESTIONNAIRE_COMPLETED_COUNTER]?.count, 0) > 0;
  });
  let questionnaireShown = false;
  let questionnaireSchedule;
  libs.createEffect(libs.on(() => gameState()?.state, state => {
    if (state == "GameState_Settle") {
      setShow(true);
      ToggleWindow("MenuButton_endscreen", true);
    } else if (state == "GameState_Prepare") {
      $.Schedule(0.5, () => {
        if (gameState()?.state == "GameState_Prepare") {
          setShow(false);
        }
      });
    } else {
      setShow(false);
    }
  }));
  const shouldShowQuestionnaire = () => {
    const localPlayerID = Players.GetLocalPlayer();
    return gameState()?.state == "GameState_Settle" && loginState()?.[localPlayerID]?.state == PlayerLoginState.Success && !questionnaireCompleted() && !questionnaireShown;
  };
  libs.createEffect(() => {
    if (!shouldShowQuestionnaire()) {
      if (questionnaireSchedule != undefined) {
        $.CancelScheduled(questionnaireSchedule);
        questionnaireSchedule = undefined;
      }
      return;
    }
    if (questionnaireSchedule != undefined) return;
    questionnaireSchedule = $.Schedule(0.5, () => {
      questionnaireSchedule = undefined;
      if (!shouldShowQuestionnaire()) return;
      questionnaireShown = true;
      ShowPopup("CommunitySurvey", {});
    });
  });
  libs.onCleanup(() => {
    if (questionnaireSchedule != undefined) {
      $.CancelScheduled(questionnaireSchedule);
    }
  });
  return (() => {
    const _el$ = libs.createElement("Panel", {
      id: "HudEndScreenRoot",
      get ["class"]() {
        return libs.classNames("CustomHudRoot", {
          ShowHud: show()
        });
      }
    }, null);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return summaryMode() == "abyssal";
      },
      get children() {
        return libs.createComponent(Abyssal, {});
      }
    }), null);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return summaryMode() == "dungeon" || summaryMode() == "tutorial";
      },
      get children() {
        return libs.createComponent(DungeonSummary, {
          get visible() {
            return show();
          }
        });
      }
    }), null);
    libs.effect(_$p => libs.setProp(_el$, "class", libs.classNames("CustomHudRoot", {
      ShowHud: show()
    }), _$p));
    return _el$;
  })();
};
libs.render(EndScreen, $.GetContextPanel());