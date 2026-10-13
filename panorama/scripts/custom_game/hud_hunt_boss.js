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
var EOM_Popup = require('./EOM_Popup.js');
var EOM_Button = require('./EOM_Button.js');
var server_huntloot = require('./server_huntloot2.js');

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
  const bossData = libs.createMemo(() => {
    const bosses = state()?.bosses;
    return Array.isArray(bosses) ? bosses : [];
  });
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

const toHuntlootDisplayData = reward => ({
  id: 0,
  huntloot_item_id: reward.huntloot_item_id,
  level: 0,
  locked: false,
  in_equip_suit: "",
  in_check: "",
  class: reward.class,
  huntloot_part: reward.huntloot_part,
  rarity: reward.rarity,
  need_level: 0
});
const toHuntlootTooltipData = reward => ({
  ...toHuntlootDisplayData(reward),
  adverb_entry_data: reward.adverb_entry ?? [],
  spell_entry_data: reward.spell_entry ?? []
});
const HuntBossCountdown = props => {
  return (() => {
    const _el$ = libs.createElement("Panel", {
        id: "HuntBossProgressCountdown"
      }, null),
      _el$2 = libs.createElement("Panel", {
        id: "HuntBossProgressCountdownBar",
        hittest: false
      }, _el$);
      libs.createElement("Panel", {
        id: "HuntBossProgressCountdownBarBg"
      }, _el$2);
      const _el$4 = libs.createElement("Panel", {
        id: "HuntBossProgressCountdownFillClip",
        get style() {
          return {
            width: `${props.progress.toFixed(2)}%`
          };
        }
      }, _el$2);
      libs.createElement("Panel", {
        id: "HuntBossProgressCountdownFill"
      }, _el$4);
      const _el$6 = libs.createElement("Label", {
        id: "HuntBossProgressCountdownValue",
        get text() {
          return LocalizeWithVars("#HuntBossIntermission_RemainingSeconds", {
            seconds: props.seconds
          });
        }
      }, _el$);
    libs.effect(_p$ => {
      const _v$ = {
          width: `${props.progress.toFixed(2)}%`
        },
        _v$2 = LocalizeWithVars("#HuntBossIntermission_RemainingSeconds", {
          seconds: props.seconds
        });
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$4, "style", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$6, "text", _v$2, _p$._v$2));
      return _p$;
    }, {
      _v$: undefined,
      _v$2: undefined
    });
    return _el$;
  })();
};
const HuntBossProgress = () => {
  const playerID = Players.GetLocalPlayer();
  const state = solid_utils.createNetDataSignal("hunt_boss", "state");
  const huntMatchRecords = solid_utils.createServiceNetData("player_hunt_match_records", {});
  const currentMatchRecord = libs.createMemo(() => Object.values(huntMatchRecords()).sort((a, b) => b.match_id - a.match_id)[0]);
  const rewardData = libs.createMemo(() => JSON.parseSafe(currentMatchRecord()?.reward_data ?? ""));
  const accumulatedRewards = libs.createMemo(() => {
    const rewards = rewardData()?.rewards;
    return Array.isArray(rewards) ? rewards : [];
  });
  const levelRewards = libs.createMemo(() => accumulatedRewards().filter(reward => reward.layer === state()?.level));
  const [now, setNow] = libs.createSignal(Game.GetGameTime());
  const timer = setInterval(() => setNow(Game.GetGameTime()), 100);
  const isIntermission = libs.createMemo(() => state()?.phase === "intermission");
  const activePlayers = libs.createMemo(() => {
    const playerIDs = state()?.active_player_ids;
    return Array.isArray(playerIDs) ? playerIDs : [];
  });
  const isParticipant = libs.createMemo(() => activePlayers().includes(playerID));
  const isReady = libs.createMemo(() => state()?.ready_player_ids?.[String(playerID)] === true);
  const remainTime = libs.createMemo(() => Math.max(0, (state()?.intermission_end_time ?? 0) - now()));
  const remainSeconds = libs.createMemo(() => Math.ceil(remainTime()));
  const intermissionDuration = libs.createMemo(() => state()?.intermission_duration ?? 30);
  const countdownProgress = libs.createMemo(() => {
    const duration = intermissionDuration();
    return duration > 0 ? Math.max(0, Math.min(100, (1 - remainTime() / duration) * 100)) : 100;
  });
  const levelText = libs.createMemo(() => LocalizeWithVars("#HuntBossIntermission_Title", {
    level: state()?.level ?? 0
  }));
  const continueText = libs.createMemo(() => isReady() ? GetLocalization("#HuntBossIntermission_Ready") : GetLocalization("#HuntBossIntermission_Continue"));
  const [isRewardExpanded, setIsRewardExpanded] = libs.createSignal(true);
  libs.createEffect(() => {
    const current = state();
    console.log(`[HuntBossProgress] state phase=${current?.phase ?? "undefined"} level=${current?.level ?? 0} localPlayer=${playerID} participant=${isParticipant()} matchRecord=${JSON.stringify(currentMatchRecord())}`);
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
            const _el$7 = libs.createElement("Label", {
              id: "HuntBossProgressRule",
              get text() {
                return GetLocalization("#HuntBossIntermission_Rule");
              }
            }, null);
            libs.effect(_$p => libs.setProp(_el$7, "text", GetLocalization("#HuntBossIntermission_Rule"), _$p));
            return _el$7;
          })(), (() => {
            const _el$8 = libs.createElement("Panel", {
                id: "HuntBossLevelRewards"
              }, null),
              _el$9 = libs.createElement("Label", {
                "class": "HuntBossProgressSectionTitle",
                get text() {
                  return GetLocalization("#HuntBossIntermission_LevelRewards");
                }
              }, _el$8),
              _el$0 = libs.createElement("Panel", {
                id: "HuntBossLevelRewardList"
              }, _el$8);
            libs.insert(_el$0, libs.createComponent(libs.For, {
              get each() {
                return levelRewards();
              },
              children: reward => (() => {
                const _el$22 = libs.createElement("Panel", {
                  "class": "HuntBossLevelReward"
                }, null);
                libs.insert(_el$22, libs.createComponent(server_huntloot.Huntloot, libs.mergeProps$1(() => toHuntlootDisplayData(reward), {
                  get tooltipData() {
                    return toHuntlootTooltipData(reward);
                  }
                })));
                return _el$22;
              })()
            }));
            libs.effect(_$p => libs.setProp(_el$9, "text", GetLocalization("#HuntBossIntermission_LevelRewards"), _$p));
            return _el$8;
          })(), (() => {
            const _el$1 = libs.createElement("Panel", {
                id: "HuntBossCumulativeRewards"
              }, null),
              _el$10 = libs.createElement("Panel", {
                id: "HuntBossCumulativeRewardsHeader"
              }, _el$1);
              libs.createElement("Image", {
                id: "HuntBossCumulativeRewardsChest",
                hittest: false
              }, _el$10);
              const _el$12 = libs.createElement("Label", {
                "class": "HuntBossProgressSectionTitle",
                get text() {
                  return GetLocalization("#HuntBossIntermission_CumulativeRewards");
                }
              }, _el$10),
              _el$13 = libs.createElement("Button", {
                id: "HuntBossCumulativeRewardsToggle"
              }, _el$10),
              _el$14 = libs.createElement("Label", {
                get text() {
                  return isRewardExpanded() ? "−" : "+";
                }
              }, _el$13);
            libs.setProp(_el$13, "onactivate", () => setIsRewardExpanded(value => !value));
            libs.insert(_el$1, libs.createComponent(libs.Show, {
              get when() {
                return isRewardExpanded();
              },
              get children() {
                const _el$15 = libs.createElement("Panel", {
                  id: "HuntBossCumulativeRewardList",
                  scroll: "y"
                }, null);
                libs.setProp(_el$15, "scroll", "y");
                libs.insert(_el$15, libs.createComponent(libs.For, {
                  get each() {
                    return accumulatedRewards();
                  },
                  children: reward => (() => {
                    const _el$23 = libs.createElement("Panel", {
                      "class": "HuntBossCumulativeReward"
                    }, null);
                    libs.insert(_el$23, libs.createComponent(server_huntloot.Huntloot, libs.mergeProps$1(() => toHuntlootDisplayData(reward), {
                      get tooltipData() {
                        return toHuntlootTooltipData(reward);
                      }
                    })));
                    return _el$23;
                  })()
                }));
                return _el$15;
              }
            }), null);
            libs.effect(_p$ => {
              const _v$3 = {
                  Collapsed: !isRewardExpanded()
                },
                _v$4 = GetLocalization("#HuntBossIntermission_CumulativeRewards"),
                _v$5 = isRewardExpanded() ? "−" : "+";
              _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$1, "classList", _v$3, _p$._v$3));
              _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$12, "text", _v$4, _p$._v$4));
              _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$14, "text", _v$5, _p$._v$5));
              return _p$;
            }, {
              _v$3: undefined,
              _v$4: undefined,
              _v$5: undefined
            });
            return _el$1;
          })(), libs.createComponent(HuntBossCountdown, {
            get progress() {
              return countdownProgress();
            },
            get seconds() {
              return remainSeconds();
            }
          }), (() => {
            const _el$16 = libs.createElement("Panel", {
                id: "HuntBossProgressActions"
              }, null),
              _el$17 = libs.createElement("Panel", {
                "class": "HuntBossProgressAction"
              }, _el$16),
              _el$18 = libs.createElement("Label", {
                "class": "HuntBossProgressActionHint Retreat",
                get text() {
                  return GetLocalization("#HuntBossIntermission_RetreatHint");
                }
              }, _el$17),
              _el$19 = libs.createElement("Panel", {
                "class": "HuntBossProgressAction ContinueAction"
              }, _el$16),
              _el$20 = libs.createElement("Label", {
                "class": "HuntBossProgressActionHint Continue",
                get text() {
                  return GetLocalization("#HuntBossIntermission_ContinueHint");
                }
              }, _el$19);
            libs.insert(_el$17, libs.createComponent(EOM_Button.EOM_Button, {
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
            libs.insert(_el$19, libs.createComponent(EOM_Button.EOM_Button, {
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
              const _v$6 = GetLocalization("#HuntBossIntermission_RetreatHint"),
                _v$7 = GetLocalization("#HuntBossIntermission_ContinueHint");
              _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$18, "text", _v$6, _p$._v$6));
              _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$20, "text", _v$7, _p$._v$7));
              return _p$;
            }, {
              _v$6: undefined,
              _v$7: undefined
            });
            return _el$16;
          })(), libs.createComponent(libs.Show, {
            get when() {
              return isReady();
            },
            get children() {
              const _el$21 = libs.createElement("Label", {
                id: "HuntBossProgressReadyHint",
                get text() {
                  return GetLocalization("#HuntBossIntermission_ReadyHint");
                }
              }, null);
              libs.effect(_$p => libs.setProp(_el$21, "text", GetLocalization("#HuntBossIntermission_ReadyHint"), _$p));
              return _el$21;
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
  const isParticipant = libs.createMemo(() => {
    const playerIDs = state()?.active_player_ids;
    return Array.isArray(playerIDs) && playerIDs.includes(playerID);
  });
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
        },
        hittest: false
      }, null),
      _el$2 = libs.createElement("Panel", {
        id: "HuntBossTopCenter"
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