--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5e0d361 
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('arena_formation_stage', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Button = require('./EOM_Button.js');
var Player = require('./Player.js');
var hero_card = require('./hero_card.js');

function ArenaOpponentInfo(props) {
  return libs.createComponent(libs.Show, {
    get when() {
      return props.opponent;
    },
    children: opponent => (() => {
      const _el$ = libs.createElement("Panel", {
          "class": "ArenaSidePanel ArenaSelectedOpponent",
          hittest: true
        }, null),
        _el$2 = libs.createElement("Panel", {
          "class": "ArenaSideTitle"
        }, _el$),
        _el$3 = libs.createElement("Label", {
          "class": "TitleLabel",
          get text() {
            return GetLocalization("#Arena_OpponentInfo");
          }
        }, _el$2),
        _el$4 = libs.createElement("Panel", {
          "class": "ArenaSelectedRank"
        }, _el$),
        _el$5 = libs.createElement("Label", {
          "class": "RankLabel",
          get text() {
            return LocalizeWithVars("#Arena_Rank", {
              value: opponent().rank
            });
          },
          html: true
        }, _el$4),
        _el$6 = libs.createElement("Panel", {
          "class": "ArenaSelectedAvatarRoot"
        }, _el$),
        _el$7 = libs.createElement("Label", {
          "class": "ArenaSelectedName",
          get text() {
            return GetLocalization(opponent().name, `${opponent().id}`);
          }
        }, _el$),
        _el$8 = libs.createElement("Panel", {
          "class": "ArenaScore ArenaSelectedScore"
        }, _el$);
        libs.createElement("Panel", {
          "class": "ScoreBG"
        }, _el$8);
        const _el$0 = libs.createElement("Panel", {
          "class": "ScoreFlow"
        }, _el$8);
        libs.createElement("Image", {
          "class": "ArenaRankBadge"
        }, _el$0);
        const _el$10 = libs.createElement("Label", {
          get text() {
            return `${opponent().score}`;
          }
        }, _el$0);
      libs.insert(_el$6, libs.createComponent(Player.PlayerAvatar, {
        classList: {
          ArenaSelectedAvatar: true
        },
        get accountid() {
          return opponent().accountID;
        },
        borderid: "1710000"
      }));
      libs.insert(_el$, libs.createComponent(EOM_Button.EOM_Button, {
        marginTop: "23px",
        horizontalAlign: "center",
        size: "Small",
        get onactivate() {
          return props.onReselect;
        },
        get text() {
          return GetLocalization("#Arena_ReselectOpponent");
        }
      }), null);
      libs.effect(_p$ => {
        const _v$ = GetLocalization("#Arena_OpponentInfo"),
          _v$2 = LocalizeWithVars("#Arena_Rank", {
            value: opponent().rank
          }),
          _v$3 = GetLocalization(opponent().name, `${opponent().id}`),
          _v$4 = `${opponent().score}`;
        _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$3, "text", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$5, "text", _v$2, _p$._v$2));
        _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$7, "text", _v$3, _p$._v$3));
        _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$10, "text", _v$4, _p$._v$4));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined,
        _v$3: undefined,
        _v$4: undefined
      });
      return _el$;
    })()
  });
}
function ArenaTeamSelection(props) {
  return (() => {
    const _el$11 = libs.createElement("Panel", {
        "class": "ArenaTeamSelection",
        hittest: true
      }, null),
      _el$12 = libs.createElement("Panel", {
        "class": "ArenaTeamNumberList"
      }, _el$11),
      _el$13 = libs.createElement("Panel", {
        "class": "ArenaTeamPowerPanel"
      }, _el$11),
      _el$14 = libs.createElement("Panel", {
        "class": "ArenaTeamPowerHeader"
      }, _el$13),
      _el$15 = libs.createElement("Label", {
        get text() {
          return LocalizeWithVars("#Arena_TeamNumber", {
            value: 1
          });
        }
      }, _el$14),
      _el$16 = libs.createElement("Label", {
        "class": "ArenaTeamPower",
        get text() {
          return LocalizeWithVars("#Arena_CombatPower", {
            value: 0
          });
        }
      }, _el$13),
      _el$17 = libs.createElement("Panel", {
        "class": "ArenaTeamSelectionActions"
      }, _el$13);
    libs.insert(_el$12, libs.createComponent(libs.For, {
      each: [1, 2, 3, 4],
      children: teamNumber => libs.createComponent(EOM_Button.EOM_BaseButton, {
        "class": "ArenaTeamNumberButton",
        classList: {
          Selected: teamNumber === 1
        },
        get children() {
          return [libs.createElement("Panel", {
            "class": "SelectBorder"
          }, null), (() => {
            const _el$19 = libs.createElement("Label", {
              text: `${teamNumber}`
            }, null);
            libs.setProp(_el$19, "text", `${teamNumber}`);
            return _el$19;
          })()];
        }
      })
    }));
    libs.insert(_el$14, libs.createComponent(EOM_Button.EOM_BaseButton, {
      "class": "EditName"
    }), null);
    libs.insert(_el$17, libs.createComponent(EOM_Button.EOM_Button, {
      size: "Small",
      get text() {
        return GetLocalization("#Arena_Equipment");
      }
    }), null);
    libs.insert(_el$17, libs.createComponent(EOM_Button.EOM_Button, {
      size: "Small",
      get onactivate() {
        return props.onEdit;
      },
      get text() {
        return GetLocalization("#Arena_EditFormation");
      }
    }), null);
    libs.effect(_p$ => {
      const _v$5 = LocalizeWithVars("#Arena_TeamNumber", {
          value: 1
        }),
        _v$6 = LocalizeWithVars("#Arena_CombatPower", {
          value: 0
        });
      _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$15, "text", _v$5, _p$._v$5));
      _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$16, "text", _v$6, _p$._v$6));
      return _p$;
    }, {
      _v$5: undefined,
      _v$6: undefined
    });
    return _el$11;
  })();
}
function ArenaHeroRoster(props) {
  return (() => {
    const _el$20 = libs.createElement("Panel", {
        "class": "ArenaHeroRoster"
      }, null),
      _el$21 = libs.createElement("Panel", {
        "class": "HeroList",
        scroll: "y"
      }, _el$20);
    libs.setProp(_el$21, "scroll", "y");
    libs.insert(_el$21, libs.createComponent(libs.For, {
      get each() {
        return props.roster;
      },
      children: heroName => (() => {
        const _el$22 = libs.createElement("Panel", {
            "class": "CardItem"
          }, null),
          _el$23 = libs.createElement("Panel", {
            "class": "HeroLv"
          }, _el$22);
          libs.createElement("Label", {
            "class": "HeroLvLabel",
            text: "1"
          }, _el$23);
          const _el$25 = libs.createElement("Label", {
            "class": "HeroName",
            get text() {
              return GetLocalization(heroName);
            }
          }, _el$22);
        libs.insert(_el$22, libs.createComponent(hero_card.HeroCard, {
          "class": "ArenaHeroCard",
          heroName: heroName
        }), _el$23);
        libs.effect(_$p => libs.setProp(_el$25, "text", GetLocalization(heroName), _$p));
        return _el$22;
      })()
    }));
    libs.effect(_$p => libs.setProp(_el$20, "classList", {
      Compact: props.compact == true
    }, _$p));
    return _el$20;
  })();
}
function ArenaTeamPanel(props) {
  return (() => {
    const _el$26 = libs.createElement("Panel", {
        "class": "ArenaTeamPanel",
        hittest: true
      }, null);
      libs.createElement("Panel", {
        "class": "ArenaTeamPanelBackground"
      }, _el$26);
      const _el$28 = libs.createElement("Panel", {
        "class": "ArenaTeamHeader"
      }, _el$26),
      _el$29 = libs.createElement("Panel", {
        width: "100%",
        padding: "0px 5px",
        horizontalAlign: "center",
        flowChildren: "right"
      }, _el$28),
      _el$30 = libs.createElement("Label", {
        "class": "HeaderLabel",
        get text() {
          return GetLocalization("#Arena_TeamComposition");
        }
      }, _el$29);
      libs.createElement("Panel", {
        "class": "CustomInfoIcon"
      }, _el$29);
      const _el$32 = libs.createElement("Label", {
        "class": "ArenaTeamCount",
        get text() {
          return LocalizeWithVars("#Arena_TeamCount", {
            current: props.roster.length,
            total: 4
          });
        }
      }, _el$29);
      libs.createElement("Panel", {
        "class": "HeaderLine"
      }, _el$28);
      const _el$34 = libs.createElement("Panel", {
        horizontalAlign: "center",
        flowChildren: "right"
      }, _el$26);
    libs.setProp(_el$29, "width", "100%");
    libs.setProp(_el$29, "padding", "0px 5px");
    libs.setProp(_el$29, "horizontalAlign", "center");
    libs.setProp(_el$29, "flowChildren", "right");
    libs.insert(_el$26, libs.createComponent(ArenaHeroRoster, {
      get roster() {
        return props.roster;
      }
    }), _el$34);
    libs.setProp(_el$34, "horizontalAlign", "center");
    libs.setProp(_el$34, "flowChildren", "right");
    libs.insert(_el$34, libs.createComponent(EOM_Button.EOM_Button, {
      size: "Small",
      get onactivate() {
        return props.onSave;
      },
      get text() {
        return GetLocalization("#Arena_SaveFormation");
      }
    }), null);
    libs.insert(_el$34, libs.createComponent(EOM_Button.EOM_Button, {
      marginLeft: "9px",
      size: "Small",
      get onactivate() {
        return props.onExit;
      },
      get text() {
        return GetLocalization("#Arena_ExitFormation");
      }
    }), null);
    libs.effect(_p$ => {
      const _v$7 = GetLocalization("#Arena_TeamComposition"),
        _v$8 = LocalizeWithVars("#Arena_TeamCount", {
          current: props.roster.length,
          total: 4
        });
      _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$30, "text", _v$7, _p$._v$7));
      _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$32, "text", _v$8, _p$._v$8));
      return _p$;
    }, {
      _v$7: undefined,
      _v$8: undefined
    });
    return _el$26;
  })();
}
function ArenaFormationStage(props) {
  const selectedOpponent = libs.createMemo(() => props.session.opponents.find(opponent => opponent.id == props.session.selectedOpponentID));
  return (() => {
    const _el$35 = libs.createElement("Panel", {
      "class": "ArenaFormationStage",
      hittest: false
    }, null);
    libs.insert(_el$35, libs.createComponent(libs.Show, {
      get when() {
        return !props.session.formationEditing;
      },
      get children() {
        return [libs.createComponent(ArenaOpponentInfo, {
          get opponent() {
            return selectedOpponent();
          },
          onReselect: () => GameEvents.SendCustomEventToServer("arena_reselect_opponent", {})
        }), libs.createComponent(ArenaTeamSelection, {
          onEdit: () => GameEvents.SendCustomEventToServer("arena_edit_formation", {})
        }), libs.createComponent(EOM_Button.EOM_Button, {
          "class": "ArenaStartBattle ArenaOrnateButton",
          get text() {
            return GetLocalization("#Arena_StartBattle");
          },
          hittest: true,
          onactivate: () => GameEvents.SendCustomEventToServer("arena_start_battle", {})
        })];
      }
    }), null);
    libs.insert(_el$35, libs.createComponent(libs.Show, {
      get when() {
        return props.session.formationEditing;
      },
      get children() {
        return libs.createComponent(ArenaTeamPanel, {
          get roster() {
            return props.session.roster;
          },
          onSave: () => GameEvents.SendCustomEventToServer("arena_save_formation", {}),
          onExit: () => GameEvents.SendCustomEventToServer("arena_exit_formation", {})
        });
      }
    }), null);
    libs.effect(_$p => libs.setProp(_el$35, "classList", {
      Editing: props.session.formationEditing == true
    }, _$p));
    return _el$35;
  })();
}

exports.ArenaFormationStage = ArenaFormationStage;
exports.ArenaHeroRoster = ArenaHeroRoster;