--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var solid_utils = require('./solid_utils.js');
var EOM_Button = require('./EOM_Button.js');

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

const HuntBossProgress = () => {
  const playerID = Players.GetLocalPlayer();
  const state = solid_utils.createNetDataSignal("hunt_boss", "state");
  const [now, setNow] = libs.createSignal(Game.GetGameTime());
  const timer = setInterval(() => setNow(Game.GetGameTime()), 100);
  const isIntermission = libs.createMemo(() => state()?.phase === "intermission");
  const isCompleted = libs.createMemo(() => state()?.phase === "finished" && state()?.finish_reason === "Completed");
  const activePlayers = libs.createMemo(() => state()?.active_player_ids ?? []);
  const isParticipant = libs.createMemo(() => activePlayers().includes(playerID));
  const isReady = libs.createMemo(() => state()?.ready_player_ids?.[String(playerID)] === true);
  const remainSeconds = libs.createMemo(() => Math.max(0, Math.ceil((state()?.intermission_end_time ?? 0) - now())));
  const levelText = libs.createMemo(() => LocalizeWithVars("#HuntBossIntermission_Title", {
    level: state()?.level ?? 0
  }));
  const continueText = libs.createMemo(() => isReady() ? GetLocalization("#HuntBossIntermission_Ready") : GetLocalization("#HuntBossIntermission_Continue"));
  const progressWidth = libs.createMemo(() => `${Math.max(0, Math.min(100, remainSeconds() / 30 * 100))}%`);
  libs.createEffect(() => {
    const current = state();
    console.log(`[HuntBossProgress] state phase=${current?.phase ?? "undefined"} level=${current?.level ?? 0} localPlayer=${playerID} participant=${isParticipant()}`);
  });
  const ready = () => {
    if (!isIntermission() || !isParticipant() || isReady()) return;
    GameEvents.SendCustomEventToServer("hunt_boss_intermission_ready", {});
  };
  const retreat = () => {
    if (!isIntermission() || !isParticipant()) return;
    GameEvents.SendCustomEventToServer("hunt_boss_intermission_retreat", {});
  };
  const returnToLobby = () => {
    if (!isCompleted() || !isParticipant()) return;
    GameEvents.SendCustomEventToServer("hunt_boss_finish_return", {});
  };
  libs.onCleanup(() => clearInterval(timer));
  return libs.createComponent(libs.Show, {
    get when() {
      return libs.memo(() => !!(isIntermission() || isCompleted()))() && isParticipant();
    },
    get children() {
      const _el$ = libs.createElement("Panel", {
          id: "HuntBossProgressPanel"
        }, null),
        _el$2 = libs.createElement("Label", {
          id: "HuntBossProgressTitle",
          get text() {
            return libs.memo(() => !!isCompleted())() ? GetLocalization("#HuntBossFinished_Title") : levelText();
          }
        }, _el$),
        _el$3 = libs.createElement("Label", {
          id: "HuntBossProgressRule",
          get text() {
            return libs.memo(() => !!isCompleted())() ? GetLocalization("#HuntBossFinished_Description") : GetLocalization("#HuntBossIntermission_Rule");
          }
        }, _el$);
        libs.createElement("Panel", {
          id: "HuntBossProgressDivider"
        }, _el$);
        const _el$5 = libs.createElement("Panel", {
          id: "HuntBossProgressCountdown"
        }, _el$),
        _el$6 = libs.createElement("Panel", {
          id: "HuntBossProgressCountdownTrack"
        }, _el$5),
        _el$7 = libs.createElement("Panel", {
          id: "HuntBossProgressCountdownFill",
          get style() {
            return {
              width: isCompleted() ? "100%" : progressWidth()
            };
          }
        }, _el$6),
        _el$8 = libs.createElement("Label", {
          id: "HuntBossProgressCountdownValue",
          get text() {
            return libs.memo(() => !!isCompleted())() ? GetLocalization("#HuntBossFinished_CompleteHint") : LocalizeWithVars("#HuntBossIntermission_Countdown", {
              seconds: remainSeconds()
            });
          }
        }, _el$5),
        _el$9 = libs.createElement("Panel", {
          id: "HuntBossProgressParticipantList"
        }, _el$),
        _el$0 = libs.createElement("Panel", {
          id: "HuntBossProgressActions"
        }, _el$);
      libs.insert(_el$9, libs.createComponent(libs.For, {
        get each() {
          return activePlayers();
        },
        children: id => (() => {
          const _el$10 = libs.createElement("Label", {
            get text() {
              return id === playerID ? GetLocalization("#HuntBossIntermission_You") : LocalizeWithVars("#HuntBossIntermission_Teammate", {
                player: id + 1
              });
            }
          }, null);
          libs.effect(_p$ => {
            const _v$6 = {
                HuntBossProgressParticipant: true,
                Ready: state()?.ready_player_ids?.[String(id)] === true
              },
              _v$7 = id === playerID ? GetLocalization("#HuntBossIntermission_You") : LocalizeWithVars("#HuntBossIntermission_Teammate", {
                player: id + 1
              });
            _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$10, "classList", _v$6, _p$._v$6));
            _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$10, "text", _v$7, _p$._v$7));
            return _p$;
          }, {
            _v$6: undefined,
            _v$7: undefined
          });
          return _el$10;
        })()
      }));
      libs.insert(_el$0, libs.createComponent(libs.Show, {
        get when() {
          return isIntermission();
        },
        get fallback() {
          return libs.createComponent(EOM_Button.EOM_Button, {
            id: "HuntBossProgressReturnButton",
            color: "Cancel",
            get text() {
              return GetLocalization("#HuntBossFinished_Return");
            },
            onactivate: returnToLobby
          });
        },
        get children() {
          return [libs.createComponent(EOM_Button.EOM_Button, {
            id: "HuntBossProgressRetreatButton",
            color: "Cancel",
            get text() {
              return GetLocalization("#HuntBossIntermission_Retreat");
            },
            onactivate: retreat
          }), libs.createComponent(EOM_Button.EOM_Button, {
            id: "HuntBossProgressContinueButton",
            color: "Confirm",
            get enabled() {
              return !isReady();
            },
            get text() {
              return continueText();
            },
            onactivate: ready
          })];
        }
      }));
      libs.insert(_el$, libs.createComponent(libs.Show, {
        get when() {
          return libs.memo(() => !!isIntermission())() && isReady();
        },
        get children() {
          const _el$1 = libs.createElement("Label", {
            id: "HuntBossProgressReadyHint",
            get text() {
              return GetLocalization("#HuntBossIntermission_ReadyHint");
            }
          }, null);
          libs.effect(_$p => libs.setProp(_el$1, "text", GetLocalization("#HuntBossIntermission_ReadyHint"), _$p));
          return _el$1;
        }
      }), null);
      libs.effect(_p$ => {
        const _v$ = {
            Completed: isCompleted()
          },
          _v$2 = libs.memo(() => !!isCompleted())() ? GetLocalization("#HuntBossFinished_Title") : levelText(),
          _v$3 = libs.memo(() => !!isCompleted())() ? GetLocalization("#HuntBossFinished_Description") : GetLocalization("#HuntBossIntermission_Rule"),
          _v$4 = {
            width: isCompleted() ? "100%" : progressWidth()
          },
          _v$5 = libs.memo(() => !!isCompleted())() ? GetLocalization("#HuntBossFinished_CompleteHint") : LocalizeWithVars("#HuntBossIntermission_Countdown", {
            seconds: remainSeconds()
          });
        _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$, "classList", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$2, "text", _v$2, _p$._v$2));
        _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$3, "text", _v$3, _p$._v$3));
        _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$7, "style", _v$4, _p$._v$4));
        _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$8, "text", _v$5, _p$._v$5));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined,
        _v$3: undefined,
        _v$4: undefined,
        _v$5: undefined
      });
      return _el$;
    }
  });
};

const HuntBossHud = () => {
  const playerID = Players.GetLocalPlayer();
  const state = solid_utils.createNetDataSignal("hunt_boss", "state");
  const isParticipant = libs.createMemo(() => (state()?.active_player_ids ?? []).includes(playerID));
  const isCompleted = libs.createMemo(() => state()?.phase === "finished" && state()?.finish_reason === "Completed");
  const isVisible = libs.createMemo(() => isParticipant() && (state()?.phase === "battle" || state()?.phase === "intermission" || isCompleted()));
  return (() => {
    const _el$ = libs.createElement("Panel", {
      id: "HUDHuntBossRoot",
      get ["class"]() {
        return libs.classNames("CustomHudRoot", {
          Show: isVisible()
        });
      }
    }, null);
    libs.insert(_el$, libs.createComponent(HuntBossHealth, {}), null);
    libs.insert(_el$, libs.createComponent(HuntBossProgress, {}), null);
    libs.effect(_$p => libs.setProp(_el$, "class", libs.classNames("CustomHudRoot", {
      Show: isVisible()
    }), _$p));
    return _el$;
  })();
};
libs.render(() => libs.createComponent(HuntBossHud, {}), $.GetContextPanel());