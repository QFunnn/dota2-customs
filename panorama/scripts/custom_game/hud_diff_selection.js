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
var solid_utils = require('./solid_utils.js');
var portraitsFullBodyLoadout = require('./portraitsFullBodyLoadout.js');
var StoreItem = require('./StoreItem.js');
var EOM_GamePad = require('./EOM_GamePad.js');
var equipment_comp = require('./equipment_comp.js');
var Player = require('./Player.js');
var RecycleView = require('./RecycleView.js');
var server_dungeon_key = require('./server_dungeon_key.js');
require('./EOM_Countdown.js');
require('./equipment_utils.js');
require('./service_netdata_helper.js');
require('./EOM_TextEntry.js');

const HERO_OFFSET_Y$1 = -50;
const HERO_SPACING_2$1 = 250;
const HERO_SPACING_3$1 = 400;
const HERO_SPACING_4_INNER$1 = 180;
const HERO_SPACING_4_OUTER$1 = 500;
const HERO_NAME_Y_OFFSET$1 = {
  "npc_dota_hero_solthra": 170,
  "npc_dota_hero_vespera": 150
};
const DEFAULT_NAME_Y$1 = 120;
function getHeroPosition$1(index, total) {
  if (total === 1) {
    return {
      x: 0,
      y: HERO_OFFSET_Y$1,
      zIndex: 1
    };
  } else if (total === 2) {
    if (index === 0) return {
      x: -HERO_SPACING_2$1,
      y: HERO_OFFSET_Y$1,
      zIndex: 2
    };
    if (index === 1) return {
      x: HERO_SPACING_2$1,
      y: HERO_OFFSET_Y$1,
      zIndex: 1
    };
  } else if (total === 3) {
    if (index === 0) return {
      x: 0,
      y: HERO_OFFSET_Y$1,
      zIndex: 2
    };
    if (index === 1) return {
      x: HERO_SPACING_3$1,
      y: HERO_OFFSET_Y$1 * 2,
      zIndex: 1
    };
    if (index === 2) return {
      x: -HERO_SPACING_3$1,
      y: HERO_OFFSET_Y$1 * 2,
      zIndex: 3
    };
  } else if (total === 4) {
    if (index === 0) return {
      x: -HERO_SPACING_4_INNER$1,
      y: HERO_OFFSET_Y$1,
      zIndex: 3
    };
    if (index === 1) return {
      x: HERO_SPACING_4_INNER$1,
      y: HERO_OFFSET_Y$1,
      zIndex: 2
    };
    if (index === 2) return {
      x: -HERO_SPACING_4_OUTER$1,
      y: HERO_OFFSET_Y$1 * 2,
      zIndex: 4
    };
    if (index === 3) return {
      x: HERO_SPACING_4_OUTER$1,
      y: HERO_OFFSET_Y$1 * 2,
      zIndex: 1
    };
  }
  return {
    x: 0,
    y: 0,
    zIndex: 1
  };
}
const AbyssalSelection = () => {
  const playerID = Players.GetLocalPlayer();
  const gameState = solid_utils.createNetDataSignal("common", "game_state");
  const gameModeState = solid_utils.createNetDataSignal("common", "game_mode_state");
  const gameModeProfiles = solid_utils.createNetDataSignal("common", "game_mode_profiles");
  const difficultySelection = solid_utils.createNetDataSignal("common", "game_mode_difficulty_selection");
  const inputMode = solid_utils.createPlayerNetDataSignal("common", "input_mode", {
    mode: "keyboard",
    isGamepad: 0
  });
  const selectedModeProfile = libs.createMemo(() => {
    const selectedModeId = gameModeState()?.selectedModeId;
    if (selectedModeId == undefined) {
      return undefined;
    }
    return gameModeProfiles()?.registeredModes?.[String(selectedModeId)];
  });
  const diffList = libs.createMemo(() => {
    const result = new Set();
    for (const difficulty of selectedModeProfile()?.configuredDifficulties ?? []) {
      if (Number.isFinite(difficulty) && KeyValues.rune_drop[difficulty.toString()] != undefined) {
        result.add(difficulty);
      }
    }
    return Array.from(result).sort((a, b) => a - b);
  });
  const diffSet = libs.createMemo(() => new Set(diffList()));
  const [countdown, setCountdown] = libs.createSignal(0);
  let countdownTimer;
  const stopCountdown = () => {
    if (countdownTimer !== undefined) {
      clearInterval(countdownTimer);
      countdownTimer = undefined;
    }
  };
  const restartCountdown = () => {
    stopCountdown();
    const endTime = difficultySelection()?.endTime;
    if (endTime === undefined) {
      setCountdown(0);
      return;
    }
    const updateCountdown = () => {
      setCountdown(Math.max(0, Math.ceil(endTime - Game.GetGameTime())));
    };
    updateCountdown();
    if (endTime > Game.GetGameTime()) {
      countdownTimer = setInterval(updateCountdown, 1000);
    }
  };
  const player_diff_first_passes = solid_utils.createServiceNetData("player_abyssal_first_passes", {});
  const isGamepad = libs.createMemo(() => inputMode().isGamepad == 1);
  const [heroModelList, setHeroModelList] = libs.createSignal([]);
  const [diff, setDiff] = libs.createSignal(1);
  const updateSelectedDiff = nextValue => {
    setDiff(nextValue);
    GameEvents.SendCustomEventToServer("game_mode_select_difficulty", {
      difficulty: nextValue
    });
  };
  const isCountdownActive = libs.createMemo(() => difficultySelection()?.state === "pending");
  const isModeStarting = libs.createMemo(() => gameModeState()?.startingModeId !== undefined);
  const canEditSelection = libs.createMemo(() => isCountdownActive() == false && isModeStarting() == false);
  const isMultiplayer = libs.createMemo(() => heroModelList().length > 1);
  const availableDiffList = libs.createMemo(() => {
    return (selectedModeProfile()?.availableDifficulties ?? []).filter(info => info.available !== false).map(info => info.difficulty).filter(difficulty => diffSet().has(difficulty)).sort((a, b) => a - b);
  });
  const availableDiffSet = libs.createMemo(() => {
    const set = new Set();
    for (const value of availableDiffList()) {
      set.add(value);
    }
    return set;
  });
  const fallbackDiff = libs.createMemo(() => {
    const availableDiffs = availableDiffList();
    if (availableDiffs.length <= 0) {
      return 1;
    }
    const defaultDifficulty = selectedModeProfile()?.defaultDifficulty;
    if (defaultDifficulty != undefined && availableDiffSet().has(defaultDifficulty)) {
      return defaultDifficulty;
    }
    return availableDiffs[0];
  });
  const canMoveDiff = delta => {
    const availableDiffs = availableDiffList();
    const currentIndex = availableDiffs.indexOf(diff());
    return canEditSelection() && currentIndex >= 0 && currentIndex + delta >= 0 && currentIndex + delta < availableDiffs.length;
  };
  const isInitiatorPlayer = libs.createMemo(() => {
    if (isMultiplayer() == false) {
      return true;
    }
    return difficultySelection()?.initiatorPlayerId === playerID;
  });
  const teamDiff = libs.createMemo(() => {
    return difficultySelection()?.resolvedDifficulty ?? diff();
  });
  const config = libs.createMemo(() => KeyValues.rune_drop[diff().toString()]);
  const starRewards = libs.createMemo(() => {
    const cfg = config();
    if (!cfg) return [];
    return [1, 2, 3].map(star => ({
      star,
      items: Object.entries(cfg[`star_reward${star}`] ?? {}).map(([itemId, count]) => ({
        itemId,
        count
      })),
      title: `#DiffSelection_StarReward${star}`
    }));
  });
  libs.createEffect(libs.on(() => [difficultySelection()?.endTime, difficultySelection()?.state, gameState()?.state], () => {
    restartCountdown();
  }));
  libs.createEffect(() => {
    const selection = difficultySelection();
    if (selection !== undefined && selection.state === "pending" && selection.resolvedDifficulty !== undefined) {
      setDiff(selection.resolvedDifficulty);
    }
  });
  libs.createEffect(() => {
    if (canEditSelection() == false) {
      return;
    }
    if (!availableDiffSet().has(diff())) {
      setDiff(fallbackDiff());
    }
  });
  libs.createEffect(libs.on(() => gameState()?.state, state => {
    if (state === "GameState_DiffSelection") {
      setHeroModelList(Game.GetPlayerIDsOnTeam(DOTATeam_t.DOTA_TEAM_GOODGUYS).map(id => ({
        id,
        heroName: getNetDataKey("common", "hero_selection", id)?.heroName ?? ""
      })));
    }
  }));
  libs.createEffect(libs.on(() => difficultySelection()?.playerDifficulties?.[playerID], difficulty => {
    if (canEditSelection()) {
      setDiff(difficulty !== undefined && availableDiffSet().has(difficulty) ? difficulty : fallbackDiff());
    }
  }));
  libs.onCleanup(() => {
    stopCountdown();
  });
  const createStarChecked = star => {
    return libs.createMemo(() => {
      const data = player_diff_first_passes();
      const diffKey = diff().toString();
      const playerStar = data?.[diffKey]?.star ?? 0;
      return playerStar >= star;
    });
  };
  const moveDiffSelection = delta => {
    if (canEditSelection() == false) {
      return;
    }
    const availableDiffs = availableDiffList();
    if (availableDiffs.length <= 0) {
      return;
    }
    const currentIndex = availableDiffs.indexOf(diff());
    const nextIndex = currentIndex + delta;
    if (nextIndex < 0 || nextIndex >= availableDiffs.length) {
      return;
    }
    updateSelectedDiff(availableDiffs[nextIndex]);
  };
  const startSelectedDiff = () => {
    if (canEditSelection() == false || isInitiatorPlayer() == false || availableDiffSet().has(diff()) == false) {
      return;
    }
    GameEvents.SendCustomEventToServer("game_mode_confirm_difficulty", {
      difficulty: diff()
    });
  };
  useClientSideEvent("key_pressed", data => {
    if (isGamepad() != true || gameState()?.state != "GameState_DiffSelection" || gameModeState()?.selectedModeId !== "abyssal") {
      return;
    }
    if (data.keyFunction == KeyFunction.OptionUp) {
      moveDiffSelection(-1);
      return;
    }
    if (data.keyFunction == KeyFunction.OptionDown) {
      moveDiffSelection(1);
      return;
    }
    if (data.keyFunction == KeyFunction.OptionConfirm) {
      startSelectedDiff();
    }
  });
  let refBGScene;
  return (() => {
    const _el$ = libs.createElement("Panel", {
        id: "AbyssalSelection"
      }, null),
      _el$2 = libs.createElement("Panel", {
        id: "CenterModels",
        hittest: false
      }, _el$);
      libs.createElement("DOTAParticleScenePanel", {
        id: "BottomParticle",
        particleName: "particles/ui/game/ui_game_general_special_effects_05_1_fx.vpcf",
        cameraOrigin: "0 0 800",
        fov: 90,
        lookAt: "0 0 0",
        hittest: false,
        squarePixels: true
      }, _el$2);
      const _el$4 = libs.createElement("DOTAParticleScenePanel", {
        id: "BGScene",
        particleName: "particles/ui/lottery/ui_lottery_back_fx.vpcf",
        cameraOrigin: "0 0 500",
        lookAt: "0 0 0",
        fov: 90,
        hittest: false
      }, _el$2),
      _el$5 = libs.createElement("Panel", {
        id: "DiffRight"
      }, _el$),
      _el$6 = libs.createElement("Panel", {
        id: "DiffInfo"
      }, _el$5);
      libs.createElement("Label", {
        id: "DiffSelectionTitleLabel",
        text: "#DiffSelection_Title"
      }, _el$6);
      const _el$8 = libs.createElement("Panel", {
        id: "DiffContainer"
      }, _el$6),
      _el$9 = libs.createElement("Panel", {
        id: "DiffList",
        hittest: true
      }, _el$8),
      _el$0 = libs.createElement("Panel", {
        id: "DiffDetail"
      }, _el$5);
      libs.createElement("Label", {
        id: "NormalReward",
        html: true,
        text: "#DiffSelection_NormalReward"
      }, _el$0);
      libs.createElement("Panel", {
        id: "DiffDetailDivider"
      }, _el$0);
      const _el$11 = libs.createElement("Label", {
        id: "NormalRewardDesc",
        html: true,
        get text() {
          return "#AbyssalDiffSelection_NormalReward" + diff();
        }
      }, _el$0);
      libs.createElement("Label", {
        id: "ChallengeReward",
        html: true,
        text: "#DiffSelection_ChallengeReward"
      }, _el$0);
      libs.createElement("Panel", {
        id: "DiffDetailDivider"
      }, _el$0);
      const _el$14 = libs.createElement("Panel", {
        id: "StarRewardList"
      }, _el$0);
      libs.createElement("Label", {
        id: "RewardCondition",
        text: "#DiffSelection_RewardCondition"
      }, _el$0);
      libs.createElement("Panel", {
        id: "DiffDetailDivider"
      }, _el$0);
      const _el$17 = libs.createElement("Panel", {
        id: "StarConditionList"
      }, _el$0),
      _el$18 = libs.createElement("Panel", {
        height: "fill-parent-flow(1)"
      }, _el$5),
      _el$19 = libs.createElement("Panel", {
        id: "Teammate"
      }, _el$5),
      _el$20 = libs.createElement("Panel", {
        id: "TeammateDiff"
      }, _el$19),
      _el$21 = libs.createElement("Label", {
        text: "#DiffSelection_TeamDiff",
        get vars() {
          return {
            diff: teamDiff()
          };
        }
      }, _el$20),
      _el$22 = libs.createElement("Label", {
        id: "StartCountdown",
        text: "#DiffSelection_StartCountdown",
        get vars() {
          return {
            value: countdown()
          };
        }
      }, _el$19);
    libs.insert(_el$2, libs.createComponent(libs.For, {
      get each() {
        return heroModelList();
      },
      children: (player, idx) => {
        const hero = libs.createMemo(() => player.heroName);
        const nameY = libs.createMemo(() => HERO_NAME_Y_OFFSET$1[hero()] ?? DEFAULT_NAME_Y$1);
        const pos = libs.createMemo(() => getHeroPosition$1(idx(), heroModelList().length));
        const playerName = libs.createMemo(() => Players.GetPlayerName(player.id));
        const playerDiff = libs.createMemo(() => difficultySelection()?.playerDifficulties?.[player.id] ?? fallbackDiff());
        const duration = 0.25;
        const fxTime = 0.25;
        const interval = 0;
        return (() => {
          const _el$24 = libs.createElement("Panel", {
              "class": "HeroWithShowFx",
              get style() {
                return {
                  x: pos().x + "px",
                  y: pos().y + "px",
                  zIndex: pos().zIndex
                };
              }
            }, null),
            _el$25 = libs.createElement("Panel", {
              "class": "PlayerName",
              get style() {
                return {
                  x: 0 + "px",
                  y: nameY() + "px"
                };
              }
            }, _el$24),
            _el$26 = libs.createElement("Label", {
              id: "Diff",
              get text() {
                return "#DiffSelection_DiffName" + playerDiff();
              }
            }, _el$25),
            _el$27 = libs.createElement("Label", {
              id: "Name",
              get text() {
                return playerName();
              }
            }, _el$25);
          libs.insert(_el$24, libs.createComponent(portraitsFullBodyLoadout.PortraitsFullBodyLoadout, {
            id: "HeroModelScene",
            get unit() {
              return hero();
            },
            get style() {
              return {
                animationDuration: duration + "s",
                animationDelay: fxTime + (duration + interval) * idx() + "s",
                animationFillMode: "both",
                animationName: "AbyssalHeroShow"
              };
            }
          }), _el$25);
          libs.effect(_p$ => {
            const _v$6 = {
                x: pos().x + "px",
                y: pos().y + "px",
                zIndex: pos().zIndex
              },
              _v$7 = {
                x: 0 + "px",
                y: nameY() + "px"
              },
              _v$8 = "#DiffSelection_DiffName" + playerDiff(),
              _v$9 = playerName();
            _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$24, "style", _v$6, _p$._v$6));
            _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$25, "style", _v$7, _p$._v$7));
            _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$26, "text", _v$8, _p$._v$8));
            _v$9 !== _p$._v$9 && (_p$._v$9 = libs.setProp(_el$27, "text", _v$9, _p$._v$9));
            return _p$;
          }, {
            _v$6: undefined,
            _v$7: undefined,
            _v$8: undefined,
            _v$9: undefined
          });
          return _el$24;
        })();
      }
    }), _el$4);
    const _ref$ = refBGScene;
    typeof _ref$ === "function" ? libs.use(_ref$, _el$4) : refBGScene = _el$4;
    libs.insert(_el$8, libs.createComponent(EOM_Button.EOM_BaseButton, {
      get visible() {
        return diffList().length >= 3;
      },
      id: "LeftArrow",
      "class": "DiffSelectionArrow",
      get enabled() {
        return canMoveDiff(-1);
      },
      onactivate: () => {
        moveDiffSelection(-1);
      }
    }), _el$9);
    libs.insert(_el$9, libs.createComponent(libs.For, {
      get each() {
        return diffList();
      },
      children: _diff => {
        const posIndex = () => {
          const currentIndex = diffList().indexOf(diff());
          const itemIndex = diffList().indexOf(_diff);
          const offset = itemIndex - currentIndex;
          if (offset < -2) return -2;
          if (offset > 2) return 2;
          return offset;
        };
        return (() => {
          const _el$28 = libs.createElement("Panel", {
              get ["class"]() {
                return libs.classNames("Diff", "Index" + posIndex());
              }
            }, null);
            libs.createElement("DOTAParticleScenePanel", {
              "class": "SelectParticle",
              particleName: "particles/ui/game/ui_game_general_special_effects_02_fx.vpcf",
              cameraOrigin: "0 0 60",
              fov: 60,
              lookAt: "0 0 0",
              hittest: false,
              squarePixels: true
            }, _el$28);
          libs.insert(_el$28, libs.createComponent(EOM_Button.EOM_BaseButton, {
            "class": "DiffButton",
            get classList() {
              return {
                "Select": posIndex() == 0
              };
            },
            get enabled() {
              return libs.memo(() => !!availableDiffSet().has(_diff))() && canEditSelection();
            },
            onactivate: () => {
              updateSelectedDiff(_diff);
            },
            get children() {
              const _el$30 = libs.createElement("Label", {
                "class": "DiffName",
                text: _diff
              }, null);
              libs.setProp(_el$30, "text", _diff);
              return _el$30;
            }
          }), null);
          libs.effect(_$p => libs.setProp(_el$28, "class", libs.classNames("Diff", "Index" + posIndex()), _$p));
          return _el$28;
        })();
      }
    }));
    libs.insert(_el$8, libs.createComponent(EOM_Button.EOM_BaseButton, {
      get visible() {
        return diffList().length >= 3;
      },
      id: "RightArrow",
      "class": "DiffSelectionArrow",
      get enabled() {
        return canMoveDiff(1);
      },
      onactivate: () => {
        moveDiffSelection(1);
      }
    }), null);
    libs.insert(_el$14, libs.createComponent(libs.For, {
      get each() {
        return starRewards();
      },
      children: reward => {
        const isChecked = createStarChecked(reward.star);
        return libs.createComponent(libs.For, {
          get each() {
            return reward.items;
          },
          children: item => libs.createComponent(StoreItem.StoreItemBlock, {
            get item_id() {
              return item.itemId;
            },
            get amounts() {
              return item.count;
            },
            get children() {
              return [libs.createComponent(libs.Show, {
                get when() {
                  return isChecked();
                },
                get children() {
                  return libs.createElement("Image", {
                    id: "CheckTag",
                    hittest: false
                  }, null);
                }
              }), (() => {
                const _el$32 = libs.createElement("Panel", {
                  width: "100%",
                  height: "100%"
                }, null);
                libs.setProp(_el$32, "width", "100%");
                libs.setProp(_el$32, "height", "100%");
                libs.effect(_$p => libs.setProp(_el$32, "customTooltip", {
                  name: "title_image_text",
                  title: GetLocalization(String(item.itemId)),
                  image: getSrcPath("store_items/" + item.itemId + ".png"),
                  text: GetLocalization(item.itemId + "_description") + "<br>" + GetLocalization("DiffSelection_StarReward" + reward.star)
                }, _$p));
                return _el$32;
              })()];
            }
          })
        });
      }
    }));
    libs.insert(_el$17, libs.createComponent(libs.For, {
      get each() {
        return starRewards();
      },
      children: reward => {
        const isChecked = createStarChecked(reward.star);
        return (() => {
          const _el$33 = libs.createElement("Panel", {
              get ["class"]() {
                return libs.classNames("StarCondition", {
                  Unfilled: !isChecked()
                });
              }
            }, null);
            libs.createElement("Image", {
              "class": "DiffStar"
            }, _el$33);
            const _el$35 = libs.createElement("Label", {
              "class": "StarConditionText",
              get text() {
                return "#AbyssalDiffSelection_StarCondition" + reward.star;
              }
            }, _el$33);
          libs.effect(_p$ => {
            const _v$0 = libs.classNames("StarCondition", {
                Unfilled: !isChecked()
              }),
              _v$1 = "#AbyssalDiffSelection_StarCondition" + reward.star;
            _v$0 !== _p$._v$0 && (_p$._v$0 = libs.setProp(_el$33, "class", _v$0, _p$._v$0));
            _v$1 !== _p$._v$1 && (_p$._v$1 = libs.setProp(_el$35, "text", _v$1, _p$._v$1));
            return _p$;
          }, {
            _v$0: undefined,
            _v$1: undefined
          });
          return _el$33;
        })();
      }
    }));
    libs.setProp(_el$18, "height", "fill-parent-flow(1)");
    libs.insert(_el$5, libs.createComponent(EOM_Button.EOM_BaseButton, {
      id: "Start",
      get visible() {
        return libs.memo(() => !!isInitiatorPlayer())() && canEditSelection();
      },
      get enabled() {
        return availableDiffSet().has(diff());
      },
      onactivate: startSelectedDiff,
      get children() {
        return libs.createElement("Label", {
          text: "#DiffSelection_Start"
        }, null);
      }
    }), null);
    libs.effect(_p$ => {
      const _v$ = "#AbyssalDiffSelection_NormalReward" + diff(),
        _v$2 = isCountdownActive(),
        _v$3 = {
          diff: teamDiff()
        },
        _v$4 = isCountdownActive(),
        _v$5 = {
          value: countdown()
        };
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$11, "text", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$19, "visible", _v$2, _p$._v$2));
      _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$21, "vars", _v$3, _p$._v$3));
      _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$22, "visible", _v$4, _p$._v$4));
      _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$22, "vars", _v$5, _p$._v$5));
      return _p$;
    }, {
      _v$: undefined,
      _v$2: undefined,
      _v$3: undefined,
      _v$4: undefined,
      _v$5: undefined
    });
    return _el$;
  })();
};

const HERO_OFFSET_Y = -50;
const HERO_SPACING_2 = 250;
const HERO_SPACING_3 = 400;
const HERO_SPACING_4_INNER = 180;
const HERO_SPACING_4_OUTER = 500;
const TRAIN_DIFF = 1;
const HERO_NAME_Y_OFFSET = {
  "npc_dota_hero_solthra": 170,
  "npc_dota_hero_vespera": 150
};
const DEFAULT_NAME_Y = 120;
const KEY_RARITY_COUNT = 7;
function getKeyIntensity(data) {
  if (!data) {
    return 0;
  }
  return data.intensity;
}
function getKeyClassLevel(data) {
  if (!data) {
    return 0;
  }
  return toFiniteNumber(KeyValues.info_item_key[String(data.key_item_id)]?.class, 1);
}
function getHeroPosition(index, total) {
  if (total === 1) {
    return {
      x: 0,
      y: HERO_OFFSET_Y,
      zIndex: 1
    };
  } else if (total === 2) {
    if (index === 0) return {
      x: -HERO_SPACING_2,
      y: HERO_OFFSET_Y,
      zIndex: 2
    };
    if (index === 1) return {
      x: HERO_SPACING_2,
      y: HERO_OFFSET_Y,
      zIndex: 1
    };
  } else if (total === 3) {
    if (index === 0) return {
      x: 0,
      y: HERO_OFFSET_Y,
      zIndex: 2
    };
    if (index === 1) return {
      x: HERO_SPACING_3,
      y: HERO_OFFSET_Y * 2,
      zIndex: 1
    };
    if (index === 2) return {
      x: -HERO_SPACING_3,
      y: HERO_OFFSET_Y * 2,
      zIndex: 3
    };
  } else if (total === 4) {
    if (index === 0) return {
      x: -HERO_SPACING_4_INNER,
      y: HERO_OFFSET_Y,
      zIndex: 3
    };
    if (index === 1) return {
      x: HERO_SPACING_4_INNER,
      y: HERO_OFFSET_Y,
      zIndex: 2
    };
    if (index === 2) return {
      x: -HERO_SPACING_4_OUTER,
      y: HERO_OFFSET_Y * 2,
      zIndex: 4
    };
    if (index === 3) return {
      x: HERO_SPACING_4_OUTER,
      y: HERO_OFFSET_Y * 2,
      zIndex: 1
    };
  }
  return {
    x: 0,
    y: 0,
    zIndex: 1
  };
}
function isDifficultyWithinMax(difficulty) {
  return difficulty <= MAX_DIFFICULTY;
}
const DungeonSelection = () => {
  const playerID = Players.GetLocalPlayer();
  const gameState = solid_utils.createNetDataSignal("common", "game_state");
  const gameModeState = solid_utils.createNetDataSignal("common", "game_mode_state");
  const gameModeProfiles = solid_utils.createNetDataSignal("common", "game_mode_profiles");
  const difficultySelection = solid_utils.createNetDataSignal("common", "game_mode_difficulty_selection");
  const inputMode = solid_utils.createPlayerNetDataSignal("common", "input_mode", {
    mode: "keyboard",
    isGamepad: 0
  });
  const selectedModeProfile = libs.createMemo(() => {
    const selectedModeId = gameModeState()?.selectedModeId;
    if (selectedModeId == undefined) {
      return undefined;
    }
    return gameModeProfiles()?.registeredModes?.[String(selectedModeId)];
  });
  const diffList = libs.createMemo(() => Object.keys(KeyValues.diff_star_rewards).map(id => Number(id)).filter(difficulty => isDifficultyWithinMax(difficulty)).sort((a, b) => a - b));
  const [countdown, setCountdown] = libs.createSignal(0);
  let countdownTimer;
  const stopCountdown = () => {
    if (countdownTimer !== undefined) {
      clearInterval(countdownTimer);
      countdownTimer = undefined;
    }
  };
  const restartCountdown = () => {
    stopCountdown();
    const endTime = difficultySelection()?.endTime;
    if (endTime === undefined) {
      setCountdown(0);
      return;
    }
    const updateCountdown = () => {
      setCountdown(Math.max(0, Math.ceil(endTime - Game.GetGameTime())));
    };
    updateCountdown();
    if (endTime > Game.GetGameTime()) {
      countdownTimer = setInterval(updateCountdown, 1000);
    }
  };
  const player_diff_first_passes = solid_utils.createServiceNetData("player_common_first_passes", {});
  const player_keys = solid_utils.createServiceNetData("player_keys", {});
  const isGamepad = libs.createMemo(() => inputMode().isGamepad == 1);
  const player_key_values = solid_utils.createServiceNetData("player_key_values", {});
  const [gamepadBindings, setGamepadBindings] = libs.createSignal({
    ...DEFAULT_GAMEPAD_BINDINGS
  });
  libs.createEffect(libs.on(player_key_values, data => {
    const nextGamepadBindings = {
      ...DEFAULT_GAMEPAD_BINDINGS
    };
    for (const key in data) {
      if (key.startsWith("keybind_gamepad_")) {
        const func = key.replace("keybind_gamepad_", "");
        nextGamepadBindings[func] = data[key].value;
      }
    }
    setGamepadBindings(nextGamepadBindings);
  }));
  const getGamepadHotkey = func => {
    return gamepadBindings()[func] ?? DEFAULT_GAMEPAD_BINDINGS[func] ?? "";
  };
  const [heroModelList, setHeroModelList] = libs.createSignal([]);
  const difficultyKey = solid_utils.createNetDataSignal("common", "difficulty_key");
  const [showKeyList, setShowKeyList] = libs.createSignal(false);
  const [showKeyFilter, setShowKeyFilter] = libs.createSignal(false);
  const [filterRarity, setFilterRarity] = libs.createSignal({});
  const [diff, setDiff] = libs.createSignal(1);
  const updateSelectedDiff = nextValue => {
    setDiff(nextValue);
    GameEvents.SendCustomEventToServer("game_mode_select_difficulty", {
      difficulty: nextValue
    });
  };
  const isCountdownActive = libs.createMemo(() => difficultySelection()?.state === "pending");
  const isModeStarting = libs.createMemo(() => gameModeState()?.startingModeId !== undefined);
  const isDungeonSelectionVisible = libs.createMemo(() => {
    return gameState()?.state === "GameState_DiffSelection" && isModeStarting() == false && gameModeState()?.selectedModeId === "common";
  });
  const canEditSelection = libs.createMemo(() => isCountdownActive() == false && isModeStarting() == false);
  const isMultiplayer = libs.createMemo(() => heroModelList().length > 1);
  const availableDiffList = libs.createMemo(() => {
    return (selectedModeProfile()?.availableDifficulties ?? []).filter(info => info.available !== false).map(info => info.difficulty).filter(difficulty => isDifficultyWithinMax(difficulty)).filter(difficulty => KeyValues.diff_star_rewards[difficulty.toString()] != undefined).sort((a, b) => a - b);
  });
  const availableDiffSet = libs.createMemo(() => {
    const set = new Set();
    for (const value of availableDiffList()) {
      set.add(value);
    }
    return set;
  });
  const fallbackDiff = libs.createMemo(() => {
    const availableDiffs = availableDiffList();
    if (availableDiffs.length <= 0) {
      return 1;
    }
    const defaultDifficulty = selectedModeProfile()?.defaultDifficulty;
    if (defaultDifficulty != undefined && availableDiffSet().has(defaultDifficulty)) {
      return defaultDifficulty;
    }
    return availableDiffs[availableDiffs.length - 1];
  });
  const canMoveDiff = delta => {
    const availableDiffs = availableDiffList();
    const currentIndex = availableDiffs.indexOf(diff());
    return canEditSelection() && currentIndex >= 0 && currentIndex + delta >= 0 && currentIndex + delta < availableDiffs.length;
  };
  const isInitiatorPlayer = libs.createMemo(() => {
    if (isMultiplayer() == false) {
      return true;
    }
    return difficultySelection()?.initiatorPlayerId === playerID;
  });
  const teamDiff = libs.createMemo(() => {
    return difficultySelection()?.resolvedDifficulty ?? diff();
  });
  const config = libs.createMemo(() => KeyValues.diff_star_rewards[diff().toString()]);
  const keyDiffSetting = libs.createMemo(() => {
    const config = GameUI.CustomUIConfig().key_diff_setting;
    return config?.[diff().toString()];
  });
  const canUseKey = libs.createMemo(() => keyDiffSetting() != undefined);
  const keyClassLevelMax = libs.createMemo(() => toFiniteNumber(keyDiffSetting()?.class_max, 0));
  const selectedKeyID = libs.createMemo(() => {
    const key = toFiniteNumber(difficultyKey()?.key, 0);
    return key > 0 ? String(key) : undefined;
  });
  const selectedKeyData = libs.createMemo(() => difficultyKey()?.key_data);
  libs.createMemo(() => getKeyClassLevel(selectedKeyData()));
  const updateDifficultyKey = keyID => {
    print("updateDifficultyKey", keyID);
    GameEvents.SendCustomEventToServer("use_key", {
      key: keyID ? toFiniteNumber(keyID, 0) : 0
    });
  };
  const removeDifficultyKey = () => {
    if (!canEditSelection()) {
      return;
    }
    const selectedKey = difficultyKey();
    if (selectedKey == undefined) {
      return;
    }
    updateDifficultyKey();
    setShowKeyList(false);
  };
  const activeRarityFilter = libs.createMemo(() => {
    const rarityFilter = filterRarity();
    return Object.keys(rarityFilter).reduce((result, rarity) => {
      if (rarityFilter[Number(rarity)]) {
        result[Number(rarity)] = true;
      }
      return result;
    }, {});
  });
  const availableKeyIDs = libs.createMemo(() => {
    const rarityFilter = activeRarityFilter();
    const hasRarityFilter = Object.keys(rarityFilter).length > 0;
    const classLevelMax = keyClassLevelMax();
    const allKeys = player_keys();
    return Object.keys(allKeys).filter(id => {
      const data = allKeys[id];
      return data != undefined && (!hasRarityFilter || rarityFilter[data.rarity] === true);
    }).sort((a, b) => {
      const intensityA = getKeyIntensity(allKeys[a]);
      const intensityB = getKeyIntensity(allKeys[b]);
      const classLevelA = getKeyClassLevel(allKeys[a]);
      const classLevelB = getKeyClassLevel(allKeys[b]);
      const exceedsMaxDiff = Number(classLevelA > classLevelMax) - Number(classLevelB > classLevelMax);
      if (exceedsMaxDiff != 0) {
        return exceedsMaxDiff;
      }
      const intensityDiff = intensityB - intensityA;
      if (intensityDiff != 0) {
        return intensityDiff;
      }
      return Number(a) - Number(b);
    });
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
  const starRewards = libs.createMemo(() => {
    const cfg = config();
    if (!cfg) return [];
    return [1, 2, 3].map(star => ({
      star,
      items: Object.entries(cfg[`star_reward${star}`] ?? {}).map(([itemId, count]) => ({
        itemId,
        count
      })),
      title: `#DiffSelection_StarReward${star}`
    }));
  });
  libs.createEffect(libs.on(() => [difficultySelection()?.endTime, difficultySelection()?.state, gameState()?.state], () => {
    restartCountdown();
  }));
  libs.createEffect(() => {
    const selection = difficultySelection();
    if (selection !== undefined && selection.state === "pending" && selection.resolvedDifficulty !== undefined) {
      setDiff(selection.resolvedDifficulty);
    }
  });
  libs.createEffect(() => {
    if (canEditSelection() == false) {
      return;
    }
    if (!availableDiffSet().has(diff())) {
      setDiff(fallbackDiff());
    }
  });
  libs.createEffect(() => {
    if (!canUseKey()) {
      setShowKeyList(false);
    }
  });
  libs.createEffect(libs.on(isDungeonSelectionVisible, visible => {
    if (visible) {
      setShowKeyList(false);
    }
  }));
  libs.createEffect(libs.on(() => gameState()?.state, state => {
    if (state === "GameState_DiffSelection") {
      setHeroModelList(Game.GetPlayerIDsOnTeam(DOTATeam_t.DOTA_TEAM_GOODGUYS).map(id => ({
        id,
        heroName: getNetDataKey("common", "hero_selection", id)?.heroName ?? ""
      })));
    }
  }));
  libs.createEffect(libs.on(() => difficultySelection()?.playerDifficulties?.[playerID], difficulty => {
    if (canEditSelection()) {
      const nextDiff = difficulty !== undefined && availableDiffSet().has(difficulty) ? difficulty : fallbackDiff();
      setDiff(nextDiff);
    }
  }));
  libs.onCleanup(() => {
    stopCountdown();
  });
  const createStarChecked = star => {
    return libs.createMemo(() => {
      const data = player_diff_first_passes();
      const diffKey = diff().toString();
      const playerStar = data?.[diffKey]?.star ?? 0;
      return playerStar >= star;
    });
  };
  const moveDiffSelection = delta => {
    if (canEditSelection() == false) {
      return;
    }
    const availableDiffs = availableDiffList();
    if (availableDiffs.length <= 0) {
      return;
    }
    const currentIndex = availableDiffs.indexOf(diff());
    const nextIndex = currentIndex + delta;
    if (nextIndex < 0 || nextIndex >= availableDiffs.length) {
      return;
    }
    updateSelectedDiff(availableDiffs[nextIndex]);
  };
  const startSelectedDiff = () => {
    if (canEditSelection() == false || isInitiatorPlayer() == false || availableDiffSet().has(diff()) == false) {
      return;
    }
    GameEvents.SendCustomEventToServer("game_mode_confirm_difficulty", {
      difficulty: diff()
    });
  };
  useClientSideEvent("key_pressed", data => {
    if (isGamepad() != true || gameState()?.state != "GameState_DiffSelection" || gameModeState()?.selectedModeId !== "common") {
      return;
    }
    if (data.keyFunction == KeyFunction.OptionUp || data.keyFunction == KeyFunction.Left) {
      moveDiffSelection(-1);
      return;
    }
    if (data.keyFunction == KeyFunction.OptionDown || data.keyFunction == KeyFunction.Right) {
      moveDiffSelection(1);
      return;
    }
    if (data.keyFunction == KeyFunction.OptionConfirm) {
      startSelectedDiff();
    }
  });
  let refDiffList;
  let refBGScene;
  libs.onMount(() => {
    const mouseEventName = DoUniqueString("DungeonSelectionDiffList");
    CustomUIConfig.SubscribeMouseEvent(mouseEventName, ({
      event_name: eventName,
      value
    }) => {
      if (!refDiffList?.IsValid() || !refDiffList.BHasHoverStyle()) {
        return;
      }
      if (eventName === "wheeled") {
        if (value === 1) {
          moveDiffSelection(-1);
        } else if (value === -1) {
          moveDiffSelection(1);
        }
      }
    });
    libs.onCleanup(() => {
      try {
        CustomUIConfig.UnsubscribeMouseEvent(mouseEventName);
      } catch (error) {}
    });
  });
  return [(() => {
    const _el$ = libs.createElement("Panel", {
        id: "CenterModels",
        hittest: false
      }, null);
      libs.createElement("DOTAParticleScenePanel", {
        id: "BottomParticle",
        particleName: "particles/ui/game/ui_game_general_special_effects_05_1_fx.vpcf",
        cameraOrigin: "0 0 800",
        fov: 90,
        lookAt: "0 0 0",
        hittest: false,
        squarePixels: true
      }, _el$);
      const _el$3 = libs.createElement("DOTAParticleScenePanel", {
        id: "BGScene",
        particleName: "particles/ui/lottery/ui_lottery_back_fx.vpcf",
        cameraOrigin: "0 0 500",
        lookAt: "0 0 0",
        fov: 90,
        hittest: false
      }, _el$);
    libs.insert(_el$, libs.createComponent(libs.For, {
      get each() {
        return heroModelList();
      },
      children: (player, idx) => {
        const hero = libs.createMemo(() => player.heroName);
        const nameY = libs.createMemo(() => HERO_NAME_Y_OFFSET[hero()] ?? DEFAULT_NAME_Y);
        const pos = libs.createMemo(() => getHeroPosition(idx(), heroModelList().length));
        const playerName = libs.createMemo(() => Players.GetPlayerName(player.id));
        const playerDiff = libs.createMemo(() => difficultySelection()?.playerDifficulties?.[player.id] ?? fallbackDiff());
        const duration = 0.25;
        const fxTime = 0.25;
        const interval = 0;
        return (() => {
          const _el$43 = libs.createElement("Panel", {
              "class": "HeroWithShowFx",
              get style() {
                return {
                  x: pos().x + "px",
                  y: pos().y + "px",
                  zIndex: pos().zIndex
                };
              }
            }, null),
            _el$44 = libs.createElement("Panel", {
              "class": "PlayerName",
              get style() {
                return {
                  x: 0 + "px",
                  y: nameY() + "px"
                };
              }
            }, _el$43),
            _el$45 = libs.createElement("Label", {
              id: "Diff",
              get text() {
                return "#DiffSelection_DiffName" + playerDiff();
              }
            }, _el$44),
            _el$46 = libs.createElement("Label", {
              id: "Name",
              get text() {
                return playerName();
              }
            }, _el$44);
          libs.insert(_el$43, libs.createComponent(portraitsFullBodyLoadout.PortraitsFullBodyLoadout, {
            id: "HeroModelScene",
            get unit() {
              return hero();
            },
            get style() {
              return {
                animationDuration: duration + "s",
                animationDelay: fxTime + (duration + interval) * idx() + "s",
                animationFillMode: "both",
                animationName: "HeroShow"
              };
            }
          }), _el$44);
          libs.effect(_p$ => {
            const _v$8 = {
                x: pos().x + "px",
                y: pos().y + "px",
                zIndex: pos().zIndex
              },
              _v$9 = {
                x: 0 + "px",
                y: nameY() + "px"
              },
              _v$0 = "#DiffSelection_DiffName" + playerDiff(),
              _v$1 = playerName();
            _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$43, "style", _v$8, _p$._v$8));
            _v$9 !== _p$._v$9 && (_p$._v$9 = libs.setProp(_el$44, "style", _v$9, _p$._v$9));
            _v$0 !== _p$._v$0 && (_p$._v$0 = libs.setProp(_el$45, "text", _v$0, _p$._v$0));
            _v$1 !== _p$._v$1 && (_p$._v$1 = libs.setProp(_el$46, "text", _v$1, _p$._v$1));
            return _p$;
          }, {
            _v$8: undefined,
            _v$9: undefined,
            _v$0: undefined,
            _v$1: undefined
          });
          return _el$43;
        })();
      }
    }), _el$3);
    const _ref$ = refBGScene;
    typeof _ref$ === "function" ? libs.use(_ref$, _el$3) : refBGScene = _el$3;
    return _el$;
  })(), (() => {
    const _el$4 = libs.createElement("Panel", {
        id: "DiffRight"
      }, null),
      _el$5 = libs.createElement("Panel", {
        id: "DiffInfo",
        get opacity() {
          return !showKeyList() ? 1 : 0;
        }
      }, _el$4);
      libs.createElement("Label", {
        id: "DiffSelectionTitleLabel",
        text: "#DiffSelection_Title"
      }, _el$5);
      const _el$7 = libs.createElement("Panel", {
        id: "DiffContainer"
      }, _el$5),
      _el$8 = libs.createElement("Panel", {
        id: "DiffList"
      }, _el$7),
      _el$9 = libs.createElement("Panel", {
        height: "fill-parent-flow(1)",
        horizontalAlign: "center",
        scroll: "y",
        get opacity() {
          return !showKeyList() ? 1 : 0;
        }
      }, _el$4),
      _el$0 = libs.createElement("Panel", {
        id: "DiffDetail"
      }, _el$9),
      _el$10 = libs.createElement("Label", {
        id: "NormalReward",
        html: true,
        text: "#DiffSelection_NormalReward"
      }, _el$0);
      libs.createElement("Panel", {
        id: "DiffDetailDivider"
      }, _el$0);
      const _el$12 = libs.createElement("Label", {
        id: "NormalRewardDesc",
        html: true,
        get text() {
          return "#DiffSelection_NormalReward" + diff();
        }
      }, _el$0);
      libs.createElement("Label", {
        id: "ChallengeReward",
        html: true,
        text: "#DiffSelection_ChallengeReward"
      }, _el$0);
      libs.createElement("Panel", {
        id: "DiffDetailDivider"
      }, _el$0);
      const _el$15 = libs.createElement("Panel", {
        id: "StarRewardList"
      }, _el$0);
      libs.createElement("Label", {
        id: "RewardCondition",
        text: "#DiffSelection_RewardCondition"
      }, _el$0);
      libs.createElement("Panel", {
        id: "DiffDetailDivider"
      }, _el$0);
      const _el$18 = libs.createElement("Panel", {
        id: "StarConditionList"
      }, _el$0),
      _el$37 = libs.createElement("Panel", {
        id: "Teammate"
      }, _el$4),
      _el$38 = libs.createElement("Panel", {
        id: "TeammateDiff"
      }, _el$37),
      _el$39 = libs.createElement("Label", {
        text: "#DiffSelection_TeamDiff",
        get vars() {
          return {
            diff: teamDiff()
          };
        }
      }, _el$38),
      _el$40 = libs.createElement("Label", {
        id: "StartCountdown",
        text: "#DiffSelection_StartCountdown",
        get vars() {
          return {
            value: countdown()
          };
        }
      }, _el$37);
    libs.insert(_el$7, libs.createComponent(EOM_Button.EOM_BaseButton, {
      get visible() {
        return diffList().length >= 3;
      },
      id: "LeftArrow",
      "class": "DiffSelectionArrow",
      get enabled() {
        return canMoveDiff(-1);
      },
      onactivate: () => {
        moveDiffSelection(-1);
      }
    }), _el$8);
    const _ref$2 = refDiffList;
    typeof _ref$2 === "function" ? libs.use(_ref$2, _el$8) : refDiffList = _el$8;
    libs.insert(_el$8, libs.createComponent(libs.For, {
      get each() {
        return diffList();
      },
      children: _diff => {
        const posIndex = () => {
          const a = _diff - diff();
          if (a < -2) return -2;
          if (a > 2) return 2;
          return a;
        };
        return (() => {
          const _el$47 = libs.createElement("Panel", {
              get ["class"]() {
                return libs.classNames("Diff", "Index" + posIndex());
              }
            }, null),
            _el$48 = libs.createElement("Panel", {
              "class": "DiffTop"
            }, _el$47);
            libs.createElement("DOTAParticleScenePanel", {
              "class": "SelectParticle",
              particleName: "particles/ui/game/ui_game_general_special_effects_02_fx.vpcf",
              cameraOrigin: "0 0 60",
              fov: 60,
              lookAt: "0 0 0",
              hittest: false,
              squarePixels: true
            }, _el$48);
          libs.insert(_el$48, libs.createComponent(EOM_Button.EOM_BaseButton, {
            "class": "DiffButton",
            get classList() {
              return {
                "Select": posIndex() == 0
              };
            },
            get enabled() {
              return libs.memo(() => !!availableDiffSet().has(_diff))() && canEditSelection();
            },
            onactivate: () => {
              updateSelectedDiff(_diff);
            },
            get children() {
              const _el$50 = libs.createElement("Label", {
                "class": "DiffName",
                text: _diff
              }, null);
              libs.setProp(_el$50, "text", _diff);
              return _el$50;
            }
          }), null);
          libs.insert(_el$47, libs.createComponent(libs.Show, {
            when: _diff <= TRAIN_DIFF,
            get children() {
              const _el$51 = libs.createElement("Label", {
                "class": "DiffDesc",
                verticalAlign: "bottom",
                text: "#DiffSelection_TrainDiff"
              }, null);
              libs.setProp(_el$51, "verticalAlign", "bottom");
              return _el$51;
            }
          }), null);
          libs.effect(_$p => libs.setProp(_el$47, "class", libs.classNames("Diff", "Index" + posIndex()), _$p));
          return _el$47;
        })();
      }
    }));
    libs.insert(_el$7, libs.createComponent(EOM_Button.EOM_BaseButton, {
      get visible() {
        return diffList().length >= 3;
      },
      id: "RightArrow",
      "class": "DiffSelectionArrow",
      get enabled() {
        return canMoveDiff(1);
      },
      onactivate: () => {
        moveDiffSelection(1);
      }
    }), null);
    libs.setProp(_el$9, "height", "fill-parent-flow(1)");
    libs.setProp(_el$9, "horizontalAlign", "center");
    libs.setProp(_el$9, "className", "VerticalScrollStyle");
    libs.setProp(_el$9, "scroll", "y");
    libs.insert(_el$0, libs.createComponent(libs.Show, {
      get when() {
        return diff() <= TRAIN_DIFF;
      },
      get children() {
        return libs.createElement("Label", {
          id: "TrainInfo",
          html: true,
          text: "#DiffSelection_TrainInfo"
        }, null);
      }
    }), _el$10);
    libs.insert(_el$15, libs.createComponent(libs.For, {
      get each() {
        return starRewards();
      },
      children: reward => {
        const isChecked = createStarChecked(reward.star);
        return libs.createComponent(libs.For, {
          get each() {
            return reward.items;
          },
          children: item => libs.createComponent(StoreItem.StoreItemBlock, {
            get item_id() {
              return item.itemId;
            },
            get amounts() {
              return item.count;
            },
            get children() {
              return [libs.createComponent(libs.Show, {
                get when() {
                  return isChecked();
                },
                get children() {
                  return libs.createElement("Image", {
                    id: "CheckTag",
                    hittest: false
                  }, null);
                }
              }), (() => {
                const _el$53 = libs.createElement("Panel", {
                  width: "100%",
                  height: "100%"
                }, null);
                libs.setProp(_el$53, "width", "100%");
                libs.setProp(_el$53, "height", "100%");
                libs.effect(_$p => libs.setProp(_el$53, "customTooltip", {
                  name: "title_image_text",
                  title: GetLocalization(String(item.itemId)),
                  image: getSrcPath("store_items/" + item.itemId + ".png"),
                  text: GetLocalization(item.itemId + "_description") + "<br>" + GetLocalization("DiffSelection_StarReward" + reward.star)
                }, _$p));
                return _el$53;
              })()];
            }
          })
        });
      }
    }));
    libs.insert(_el$18, libs.createComponent(libs.For, {
      get each() {
        return starRewards();
      },
      children: reward => {
        const isChecked = createStarChecked(reward.star);
        return (() => {
          const _el$54 = libs.createElement("Panel", {
              get ["class"]() {
                return libs.classNames("StarCondition", {
                  Unfilled: !isChecked()
                });
              }
            }, null);
            libs.createElement("Image", {
              "class": "DiffStar"
            }, _el$54);
            const _el$56 = libs.createElement("Label", {
              "class": "StarConditionText",
              get text() {
                return "#DiffSelection_StarCondition" + reward.star;
              }
            }, _el$54);
          libs.effect(_p$ => {
            const _v$10 = libs.classNames("StarCondition", {
                Unfilled: !isChecked()
              }),
              _v$11 = "#DiffSelection_StarCondition" + reward.star;
            _v$10 !== _p$._v$10 && (_p$._v$10 = libs.setProp(_el$54, "class", _v$10, _p$._v$10));
            _v$11 !== _p$._v$11 && (_p$._v$11 = libs.setProp(_el$56, "text", _v$11, _p$._v$11));
            return _p$;
          }, {
            _v$10: undefined,
            _v$11: undefined
          });
          return _el$54;
        })();
      }
    }));
    libs.insert(_el$4, libs.createComponent(libs.Show, {
      get when() {
        return canUseKey();
      },
      get children() {
        const _el$19 = libs.createElement("Panel", {
            id: "KeySelectionWrapper"
          }, null),
          _el$20 = libs.createElement("Panel", {
            flowChildren: "right"
          }, _el$19);
          libs.createElement("Label", {
            id: "KeySelectionTitle",
            text: "#DiffSelection_Key"
          }, _el$20);
          const _el$22 = libs.createElement("Panel", {
            "class": "ToolTipInfo"
          }, _el$20);
          libs.createElement("Panel", {
            id: "DiffDetailDivider"
          }, _el$19);
          const _el$24 = libs.createElement("Panel", {
            id: "KeySelectionRow"
          }, _el$19),
          _el$27 = libs.createElement("Label", {
            id: "KeyIntensityLimit",
            text: "#DiffSelection_KeyCondition",
            get vars() {
              return {
                diff: diff(),
                value: keyClassLevelMax()
              };
            }
          }, _el$19);
        libs.setProp(_el$20, "flowChildren", "right");
        libs.setProp(_el$22, "tooltip_text", "#Equipment_DiffKeyTips");
        libs.insert(_el$24, libs.createComponent(EOM_Button.EOM_BaseButton, {
          id: "KeyActionSlot",
          get classList() {
            return {
              HasKey: selectedKeyData() != undefined
            };
          },
          get enabled() {
            return canEditSelection();
          },
          onactivate: () => {
            setShowKeyList(prev => !prev);
          },
          get children() {
            return [libs.createElement("Panel", {
              id: "Bg"
            }, null), libs.createComponent(libs.Show, {
              get when() {
                return selectedKeyData();
              },
              get children() {
                return [libs.createComponent(server_dungeon_key.DungeonKey, {
                  get data() {
                    return selectedKeyData();
                  },
                  oncontextmenu: removeDifficultyKey
                }), libs.createComponent(EOM_Button.EOM_CloseButton, {
                  "class": "SelectedKeyCloseButton",
                  onactivate: removeDifficultyKey
                })];
              }
            })];
          }
        }), null);
        libs.insert(_el$24, libs.createComponent(libs.Show, {
          get when() {
            return difficultyKey()?.owner_id != undefined;
          },
          get children() {
            return [libs.createElement("Label", {
              id: "KeyOwnerLabel",
              text: "#DiffSelection_KeyOwner"
            }, null), libs.createComponent(Player.PlayerAvatar, {
              id: "KeyOwnerAvatar",
              get playerid() {
                return difficultyKey().owner_id;
              }
            })];
          }
        }), null);
        libs.effect(_$p => libs.setProp(_el$27, "vars", {
          diff: diff(),
          value: keyClassLevelMax()
        }, _$p));
        return _el$19;
      }
    }), _el$37);
    libs.insert(_el$4, libs.createComponent(libs.Show, {
      get when() {
        return showKeyList();
      },
      get children() {
        const _el$28 = libs.createElement("Panel", {
            id: "KeyListRoot"
          }, null),
          _el$29 = libs.createElement("Panel", {
            id: "KeyListBox"
          }, _el$28),
          _el$34 = libs.createElement("Panel", {
            id: "BtnsContainer"
          }, _el$28),
          _el$35 = libs.createElement("Panel", {
            align: "center center",
            flowChildren: "right"
          }, _el$34),
          _el$36 = libs.createElement("Button", {
            id: "ResetBtn",
            "class": "SecondaryButtonStates"
          }, _el$35);
        libs.insert(_el$29, libs.createComponent(libs.Show, {
          get when() {
            return showKeyFilter();
          },
          get fallback() {
            return libs.createComponent(RecycleView.RecycleView, {
              id: "DungeonKeysList",
              input: availableKeyIDs,
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
                const disabled = libs.createMemo(() => {
                  const data = keyData();
                  return data == undefined || getKeyClassLevel(data) > keyClassLevelMax();
                });
                return (() => {
                  const _el$58 = libs.createElement("Panel", {
                      "class": "Item"
                    }, null),
                    _el$59 = libs.createElement("Panel", {
                      "class": "SelectedBorder",
                      hittest: false
                    }, _el$58);
                  libs.setProp(_el$58, "onactivate", () => {
                    if (disabled()) {
                      return;
                    }
                    updateDifficultyKey(id());
                    setShowKeyList(false);
                  });
                  libs.insert(_el$58, libs.createComponent(server_dungeon_key.DungeonKey, {
                    get keyID() {
                      return id();
                    }
                  }), _el$59);
                  libs.effect(_$p => libs.setProp(_el$58, "classList", {
                    Selected: selectedKeyID() == id(),
                    InAction: selectedKeyID() == id(),
                    Gray: disabled()
                  }, _$p));
                  return _el$58;
                })();
              }
            });
          },
          get children() {
            const _el$30 = libs.createElement("Panel", {
                id: "KeyFilterWindow"
              }, null);
              libs.createElement("Label", {
                id: "RarityLabel",
                "class": "Subheading",
                text: "#Equipment_Rarity"
              }, _el$30);
              libs.createElement("Panel", {
                "class": "FilterLine"
              }, _el$30);
              const _el$33 = libs.createElement("Panel", {
                id: "RarityFilterList",
                "class": "CheckBoxList"
              }, _el$30);
            libs.insert(_el$33, libs.createComponent(libs.For, {
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
            return _el$30;
          }
        }));
        libs.setProp(_el$35, "align", "center center");
        libs.setProp(_el$35, "flowChildren", "right");
        libs.insert(_el$35, libs.createComponent(equipment_comp.EquipmentCommonBtn, {
          id: "FilterBtn",
          get classList() {
            return {
              ShowBtnBorder: showKeyFilter()
            };
          },
          text: "#Hud_Equipment_Filter",
          onactivate: () => {
            setShowKeyFilter(prev => !prev);
          }
        }), _el$36);
        libs.setProp(_el$36, "onactivate", () => {
          setFilterRarity({});
        });
        return _el$28;
      }
    }), _el$37);
    libs.insert(_el$4, libs.createComponent(EOM_Button.EOM_BaseButton, {
      id: "Start",
      get visible() {
        return isInitiatorPlayer();
      },
      get enabled() {
        return libs.memo(() => !!availableDiffSet().has(diff()))() && canEditSelection();
      },
      onactivate: startSelectedDiff,
      get children() {
        const _el$41 = libs.createElement("Panel", {
            align: "center center",
            flowChildren: "right"
          }, null);
          libs.createElement("Label", {
            id: "StartLabel",
            text: "#DiffSelection_Start"
          }, _el$41);
        libs.setProp(_el$41, "align", "center center");
        libs.setProp(_el$41, "flowChildren", "right");
        libs.insert(_el$41, libs.createComponent(libs.Show, {
          get when() {
            return isGamepad();
          },
          get children() {
            return libs.createComponent(EOM_GamePad.EOM_GamePad, {
              get keyName() {
                return getGamepadHotkey(KeyFunction.OptionConfirm);
              }
            });
          }
        }), null);
        return _el$41;
      }
    }), null);
    libs.effect(_p$ => {
      const _v$ = !showKeyList() ? 1 : 0,
        _v$2 = !showKeyList() ? 1 : 0,
        _v$3 = "#DiffSelection_NormalReward" + diff(),
        _v$4 = isCountdownActive(),
        _v$5 = {
          diff: teamDiff()
        },
        _v$6 = isCountdownActive(),
        _v$7 = {
          value: countdown()
        };
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$5, "opacity", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$9, "opacity", _v$2, _p$._v$2));
      _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$12, "text", _v$3, _p$._v$3));
      _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$37, "visible", _v$4, _p$._v$4));
      _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$39, "vars", _v$5, _p$._v$5));
      _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$40, "visible", _v$6, _p$._v$6));
      _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$40, "vars", _v$7, _p$._v$7));
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
    return _el$4;
  })()];
};

const DiffSelection = () => {
  const gameState = solid_utils.createNetDataSignal("common", "game_state");
  const gameModeState = solid_utils.createNetDataSignal("common", "game_mode_state");
  const isModeStarting = libs.createMemo(() => gameModeState()?.startingModeId !== undefined);
  const selectedModeId = () => gameModeState()?.selectedModeId;
  const show = () => !isModeStarting() && gameState()?.state === "GameState_DiffSelection";
  return (() => {
    const _el$ = libs.createElement("Panel", {
      id: "DiffSelection",
      get ["class"]() {
        return libs.classNames({
          Show: show()
        });
      },
      acceptsfocus: true
    }, null);
    libs.insert(_el$, libs.createComponent(EOM_Button.EOM_CloseButton, {
      onactivate: () => GameEvents.SendCustomEventToServer("game_mode_cancel_selection", {})
    }), null);
    libs.insert(_el$, libs.createComponent(libs.Switch, {
      get children() {
        return [libs.createComponent(libs.Match, {
          get when() {
            return selectedModeId() === "common";
          },
          get children() {
            return libs.createComponent(DungeonSelection, {});
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return selectedModeId() === "abyssal";
          },
          get children() {
            return libs.createComponent(AbyssalSelection, {});
          }
        })];
      }
    }), null);
    libs.effect(_$p => libs.setProp(_el$, "class", libs.classNames({
      Show: show()
    }), _$p));
    return _el$;
  })();
};
libs.render(() => libs.createComponent(DiffSelection, {}), $.GetContextPanel());