--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var solid_utils = require('./solid_utils.js');
var EOM_ProgressBar = require('./EOM_ProgressBar.js');
var EOM_Popup = require('./EOM_Popup.js');
var EOM_Button = require('./EOM_Button.js');
var StoreItem = require('./StoreItem.js');
require('./EOM_Countdown.js');
require('./EOM_ImageNumber.js');
require('./Player.js');
require('./service_netdata_helper.js');
require('./EOM_TextEntry.js');
require('./equipment_utils.js');

const getDisplayedHealth = entIndex => {
  const logicalHealth = CustomNetTables.GetTableValue("large_number_health", String(entIndex));
  if (logicalHealth !== undefined) {
    const current = toFiniteNumber(logicalHealth.current, -1);
    const maximum = toFiniteNumber(logicalHealth.maximum, -1);
    if (current >= 0 && maximum > 0) return {
      current,
      maximum
    };
  }
  return {
    current: Entities.GetHealth(entIndex),
    maximum: Math.max(1, Entities.GetMaxHealth(entIndex))
  };
};
const HuntBossHealthBar = props => {
  const percent = libs.createMemo(() => Math.max(0, Math.min(100, props.boss().current / props.boss().maximum * 100)));
  return (() => {
    const _el$ = libs.createElement("Panel", {
        "class": "HuntBossHealthBar",
        hittest: false
      }, null);
      libs.createElement("Panel", {
        "class": "HuntBossHealthBarBackground"
      }, _el$);
      const _el$3 = libs.createElement("Panel", {
        "class": "HuntBossHealthBarFill",
        get width() {
          return `${percent()}%`;
        }
      }, _el$),
      _el$4 = libs.createElement("Label", {
        "class": "HuntBossHealthValue",
        get text() {
          return `${FormatNumber(props.boss().current)}/${FormatNumber(props.boss().maximum)}`;
        }
      }, _el$);
    libs.effect(_p$ => {
      const _v$ = `${percent()}%`,
        _v$2 = `${FormatNumber(props.boss().current)}/${FormatNumber(props.boss().maximum)}`;
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$3, "width", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$4, "text", _v$2, _p$._v$2));
      return _p$;
    }, {
      _v$: undefined,
      _v$2: undefined
    });
    return _el$;
  })();
};
const HuntBossHealthSlot = props => {
  const boss = libs.createMemo(() => props.bosses().find(value => value.slot === props.slot));
  return (() => {
    const _el$5 = libs.createElement("Panel", {
      "class": "HuntBossHealthSlot",
      hittest: false
    }, null);
    libs.insert(_el$5, libs.createComponent(libs.Show, {
      get when() {
        return boss();
      },
      children: value => libs.createComponent(HuntBossHealthBar, {
        boss: value
      })
    }));
    return _el$5;
  })();
};
const HuntBossHealth = () => {
  const state = solid_utils.createNetDataSignal("hunt_boss", "state");
  const [bosses, setBosses] = libs.createSignal([]);
  const bossData = libs.createMemo(() => state()?.bosses ?? []);
  const isBattle = libs.createMemo(() => state()?.phase === "battle");
  libs.createEffect(() => {
    const timer = setInterval(() => {
      const values = [];
      for (const boss of bossData()) {
        if (!Entities.IsValidEntity(boss.ent_index)) continue;
        values.push({
          ...boss,
          ...getDisplayedHealth(boss.ent_index)
        });
      }
      setBosses(values);
    }, 0);
    libs.onCleanup(() => clearInterval(timer));
  });
  return libs.createComponent(libs.Show, {
    get when() {
      return libs.memo(() => !!isBattle())() && bosses().length > 0;
    },
    get children() {
      const _el$6 = libs.createElement("Panel", {
        id: "HuntBossHealthContainer",
        hittest: false
      }, null);
      libs.insert(_el$6, libs.createComponent(libs.For, {
        each: [0, 1],
        children: slot => libs.createComponent(HuntBossHealthSlot, {
          slot: slot,
          bosses: bosses
        })
      }));
      return _el$6;
    }
  });
};

const HUNT_BOSS_PREVIEW_LEVEL_REWARDS = [{
  itemID: 110013,
  amounts: 2
}, {
  itemID: 110014,
  amounts: 5
}];
const HUNT_BOSS_PREVIEW_ACCUMULATED_REWARDS = [{
  itemID: 110023,
  amounts: 1
}, {
  itemID: 110024,
  amounts: 3
}];
const HuntBossProgress = () => {
  const playerID = Players.GetLocalPlayer();
  const state = solid_utils.createNetDataSignal("hunt_boss", "state");
  const [now, setNow] = libs.createSignal(Game.GetGameTime());
  const timer = setInterval(() => setNow(Game.GetGameTime()), 1000);
  const isIntermission = libs.createMemo(() => state()?.phase === "intermission");
  const activePlayers = libs.createMemo(() => state()?.active_player_ids ?? []);
  const isParticipant = libs.createMemo(() => activePlayers().includes(playerID));
  const isReady = libs.createMemo(() => state()?.ready_player_ids?.[String(playerID)] === true);
  const remainSeconds = libs.createMemo(() => Math.max(0, Math.ceil((state()?.intermission_end_time ?? 0) - now())));
  const intermissionDuration = libs.createMemo(() => state()?.intermission_duration ?? 30);
  const levelText = libs.createMemo(() => LocalizeWithVars("#HuntBossIntermission_Title", {
    level: state()?.level ?? 0
  }));
  const continueText = libs.createMemo(() => isReady() ? GetLocalization("#HuntBossIntermission_Ready") : GetLocalization("#HuntBossIntermission_Continue"));
  const accumulatedRewards = libs.createMemo(() => [...HUNT_BOSS_PREVIEW_ACCUMULATED_REWARDS, ...HUNT_BOSS_PREVIEW_LEVEL_REWARDS]);
  const [isRewardExpanded, setIsRewardExpanded] = libs.createSignal(true);
  libs.createEffect(() => {
    const current = state();
    console.log(`[HuntBossProgress] state phase=${current?.phase ?? "undefined"} level=${current?.level ?? 0} localPlayer=${playerID} participant=${isParticipant()}`);
  });
  const ready = () => {
    if (!isIntermission() || !isParticipant() || isReady()) return;
    GameEvents.SendCustomEventToServer("hunt_boss_intermission_ready", {});
  };
  const retreat = () => {
    if (!isIntermission() || !isParticipant() || isReady()) return;
    GameEvents.SendCustomEventToServer("hunt_boss_intermission_retreat", {});
  };
  libs.onCleanup(() => clearInterval(timer));
  return libs.createComponent(libs.Show, {
    get when() {
      return libs.memo(() => !!isIntermission())() && isParticipant();
    },
    get children() {
      return libs.createComponent(EOM_Popup.EOM_Popup, {
        id: "HuntBossProgressPanel",
        size: "normal",
        popType: "PopupType_PopOut",
        hideClose: true,
        get title() {
          return levelText();
        },
        classList: {
          EOM_PopupMainShow: true
        },
        get children() {
          return [(() => {
            const _el$ = libs.createElement("Label", {
              id: "HuntBossProgressRule",
              get text() {
                return GetLocalization("#HuntBossIntermission_Rule");
              }
            }, null);
            libs.effect(_$p => libs.setProp(_el$, "text", GetLocalization("#HuntBossIntermission_Rule"), _$p));
            return _el$;
          })(), (() => {
            const _el$2 = libs.createElement("Panel", {
                id: "HuntBossLevelRewards"
              }, null),
              _el$3 = libs.createElement("Label", {
                "class": "HuntBossProgressSectionTitle",
                get text() {
                  return GetLocalization("#HuntBossIntermission_LevelRewards");
                }
              }, _el$2),
              _el$4 = libs.createElement("Panel", {
                id: "HuntBossLevelRewardList"
              }, _el$2);
            libs.insert(_el$4, libs.createComponent(libs.For, {
              each: HUNT_BOSS_PREVIEW_LEVEL_REWARDS,
              children: reward => libs.createComponent(StoreItem.StoreItemBlock, {
                "class": "HuntBossLevelReward",
                get item_id() {
                  return reward.itemID;
                },
                get amounts() {
                  return reward.amounts;
                }
              })
            }));
            libs.effect(_$p => libs.setProp(_el$3, "text", GetLocalization("#HuntBossIntermission_LevelRewards"), _$p));
            return _el$2;
          })(), (() => {
            const _el$5 = libs.createElement("Panel", {
                id: "HuntBossCumulativeRewards"
              }, null),
              _el$6 = libs.createElement("Panel", {
                id: "HuntBossCumulativeRewardsHeader"
              }, _el$5);
              libs.createElement("Image", {
                id: "HuntBossCumulativeRewardsChest",
                hittest: false
              }, _el$6);
              const _el$8 = libs.createElement("Label", {
                "class": "HuntBossProgressSectionTitle",
                get text() {
                  return GetLocalization("#HuntBossIntermission_CumulativeRewards");
                }
              }, _el$6),
              _el$9 = libs.createElement("Button", {
                id: "HuntBossCumulativeRewardsToggle"
              }, _el$6),
              _el$0 = libs.createElement("Label", {
                get text() {
                  return isRewardExpanded() ? "−" : "+";
                }
              }, _el$9);
            libs.setProp(_el$9, "onactivate", () => setIsRewardExpanded(value => !value));
            libs.insert(_el$5, libs.createComponent(libs.Show, {
              get when() {
                return isRewardExpanded();
              },
              get children() {
                const _el$1 = libs.createElement("Panel", {
                  id: "HuntBossCumulativeRewardList",
                  scroll: "y"
                }, null);
                libs.setProp(_el$1, "scroll", "y");
                libs.insert(_el$1, libs.createComponent(libs.For, {
                  get each() {
                    return accumulatedRewards();
                  },
                  children: reward => libs.createComponent(StoreItem.StoreItemBlock, {
                    "class": "HuntBossCumulativeReward",
                    get item_id() {
                      return reward.itemID;
                    },
                    get amounts() {
                      return reward.amounts;
                    }
                  })
                }));
                return _el$1;
              }
            }), null);
            libs.effect(_p$ => {
              const _v$ = {
                  Collapsed: !isRewardExpanded()
                },
                _v$2 = GetLocalization("#HuntBossIntermission_CumulativeRewards"),
                _v$3 = isRewardExpanded() ? "−" : "+";
              _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$5, "classList", _v$, _p$._v$));
              _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$8, "text", _v$2, _p$._v$2));
              _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$0, "text", _v$3, _p$._v$3));
              return _p$;
            }, {
              _v$: undefined,
              _v$2: undefined,
              _v$3: undefined
            });
            return _el$5;
          })(), (() => {
            const _el$10 = libs.createElement("Panel", {
                id: "HuntBossProgressCountdown"
              }, null),
              _el$11 = libs.createElement("Label", {
                id: "HuntBossProgressCountdownValue",
                get text() {
                  return LocalizeWithVars("#HuntBossIntermission_RemainingSeconds", {
                    seconds: remainSeconds()
                  });
                }
              }, _el$10);
            libs.insert(_el$10, libs.createComponent(EOM_ProgressBar.EOM_ProgressBar, {
              id: "HuntBossProgressCountdownBar",
              type: "Tui12",
              min: 0,
              get max() {
                return intermissionDuration();
              },
              get value() {
                return remainSeconds();
              }
            }), _el$11);
            libs.effect(_$p => libs.setProp(_el$11, "text", LocalizeWithVars("#HuntBossIntermission_RemainingSeconds", {
              seconds: remainSeconds()
            }), _$p));
            return _el$10;
          })(), (() => {
            const _el$12 = libs.createElement("Panel", {
                id: "HuntBossProgressActions"
              }, null),
              _el$13 = libs.createElement("Panel", {
                "class": "HuntBossProgressAction"
              }, _el$12),
              _el$14 = libs.createElement("Label", {
                "class": "HuntBossProgressActionHint Retreat",
                get text() {
                  return GetLocalization("#HuntBossIntermission_RetreatHint");
                }
              }, _el$13),
              _el$15 = libs.createElement("Panel", {
                "class": "HuntBossProgressAction ContinueAction"
              }, _el$12),
              _el$16 = libs.createElement("Label", {
                "class": "HuntBossProgressActionHint Continue",
                get text() {
                  return GetLocalization("#HuntBossIntermission_ContinueHint");
                }
              }, _el$15);
            libs.insert(_el$13, libs.createComponent(EOM_Button.EOM_Button, {
              id: "HuntBossProgressRetreatButton",
              color: "Cancel",
              get enabled() {
                return !isReady();
              },
              get text() {
                return GetLocalization("#HuntBossIntermission_Retreat");
              },
              onactivate: retreat
            }), null);
            libs.insert(_el$15, libs.createComponent(EOM_Button.EOM_Button, {
              id: "HuntBossProgressContinueButton",
              color: "Confirm",
              get enabled() {
                return !isReady();
              },
              get text() {
                return continueText();
              },
              onactivate: ready
            }), null);
            libs.effect(_p$ => {
              const _v$4 = GetLocalization("#HuntBossIntermission_RetreatHint"),
                _v$5 = GetLocalization("#HuntBossIntermission_ContinueHint");
              _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$14, "text", _v$4, _p$._v$4));
              _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$16, "text", _v$5, _p$._v$5));
              return _p$;
            }, {
              _v$4: undefined,
              _v$5: undefined
            });
            return _el$12;
          })(), libs.createComponent(libs.Show, {
            get when() {
              return isReady();
            },
            get children() {
              const _el$17 = libs.createElement("Label", {
                id: "HuntBossProgressReadyHint",
                get text() {
                  return GetLocalization("#HuntBossIntermission_ReadyHint");
                }
              }, null);
              libs.effect(_$p => libs.setProp(_el$17, "text", GetLocalization("#HuntBossIntermission_ReadyHint"), _$p));
              return _el$17;
            }
          })];
        }
      });
    }
  });
};

const HuntBossHud = () => {
  const playerID = Players.GetLocalPlayer();
  const state = solid_utils.createNetDataSignal("hunt_boss", "state");
  const isParticipant = libs.createMemo(() => (state()?.active_player_ids ?? []).includes(playerID));
  const isCompleted = libs.createMemo(() => state()?.phase === "finished" && state()?.finish_reason === "Completed");
  const isVisible = libs.createMemo(() => isParticipant() && (state()?.phase === "battle" || state()?.phase === "intermission" || isCompleted()));
  const levelText = libs.createMemo(() => LocalizeWithVars("#HuntBossHudLevel", {
    level: state()?.level ?? 0
  }));
  const statusText = libs.createMemo(() => {
    switch (state()?.phase) {
      case "battle":
        return GetLocalization("#HuntBossHudStatus_Battle");
      case "intermission":
        return GetLocalization("#HuntBossHudStatus_Intermission");
      case "finished":
        return GetLocalization("#HuntBossHudStatus_Finished");
      default:
        return "";
    }
  });
  return (() => {
    const _el$ = libs.createElement("Panel", {
        id: "HUDHuntBossRoot",
        get ["class"]() {
          return libs.classNames("CustomHudRoot", {
            Show: isVisible()
          });
        }
      }, null),
      _el$2 = libs.createElement("Panel", {
        id: "HuntBossTopCenter",
        hittest: false
      }, _el$),
      _el$3 = libs.createElement("Label", {
        id: "HuntBossTitle",
        get text() {
          return GetLocalization("#HuntBossHudTitle");
        }
      }, _el$2),
      _el$4 = libs.createElement("Label", {
        id: "HuntBossStatus",
        get text() {
          return statusText();
        }
      }, _el$2),
      _el$5 = libs.createElement("Label", {
        id: "HuntBossLevel",
        get text() {
          return levelText();
        }
      }, _el$2);
    libs.insert(_el$, libs.createComponent(HuntBossHealth, {}), null);
    libs.insert(_el$, libs.createComponent(HuntBossProgress, {}), null);
    libs.effect(_p$ => {
      const _v$ = libs.classNames("CustomHudRoot", {
          Show: isVisible()
        }),
        _v$2 = GetLocalization("#HuntBossHudTitle"),
        _v$3 = statusText(),
        _v$4 = levelText();
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$, "class", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$3, "text", _v$2, _p$._v$2));
      _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$4, "text", _v$3, _p$._v$3));
      _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$5, "text", _v$4, _p$._v$4));
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
libs.render(() => libs.createComponent(HuntBossHud, {}), $.GetContextPanel());