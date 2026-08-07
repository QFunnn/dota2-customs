--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_MenuLayout = require('./EOM_MenuLayout.js');
var EOM_Button = require('./EOM_Button.js');
var StoreItem = require('./StoreItem.js');
require('./service_netdata_helper.js');
require('./EOM_RedMark.js');

require('./Player.js');
require('./EOM_TextEntry.js');
require('./equipment_utils.js');

const MONOPOLY_BOARD_COLUMN_COUNT = 8;
const MONOPOLY_BOARD_ROW_COUNT = 7;
const MONOPOLY_BOARD_CELL_SIZE = 72;
const MONOPOLY_PLAYER_PIECE_SIZE = 52;
const MONOPOLY_PLAYER_MOVE_STEP_DURATION = 0.24;
const TilePath = [8, 9, 10, 2, 3, 4, 5, 13, 14, 22, 30, 31, 39, 47, 46, 54, 53, 52, 51, 50, 42, 41, 33, 25, 24, 16];
const monopolyBoardRows = Array.from({
  length: MONOPOLY_BOARD_ROW_COUNT
}, (_, rowIndex) => Array.from({
  length: MONOPOLY_BOARD_COLUMN_COUNT
}, (_, columnIndex) => {
  const tileIndex = rowIndex * MONOPOLY_BOARD_COLUMN_COUNT + columnIndex;
  const id = tileIndex + 1;
  return {
    id,
    tileIndex,
    progress: `${tileIndex}/${MONOPOLY_BOARD_COLUMN_COUNT * MONOPOLY_BOARD_ROW_COUNT - 1}`,
    shouldRenderPiece: TilePath.includes(tileIndex)
  };
}));
function MonopolyTaskItem(props) {
  return (() => {
    const _el$ = libs.createElement("Panel", {
        "class": "MonopolyTaskItem"
      }, null);
      libs.createElement("Image", {
        "class": "MonopolyTaskItemBG"
      }, _el$);
      const _el$3 = libs.createElement("Panel", {
        "class": "MonopolyTaskItemLayer"
      }, _el$),
      _el$4 = libs.createElement("Panel", {
        "class": "MonopolyTaskContent"
      }, _el$3),
      _el$5 = libs.createElement("Panel", {
        "class": "MonopolyTaskHeader"
      }, _el$4),
      _el$6 = libs.createElement("Label", {
        "class": "MonopolyTaskTitle",
        get text() {
          return props.title;
        }
      }, _el$5),
      _el$7 = libs.createElement("Label", {
        "class": "MonopolyTaskProgress",
        get text() {
          return props.progress;
        }
      }, _el$5),
      _el$8 = libs.createElement("Label", {
        "class": "MonopolyTaskDescription",
        get text() {
          return props.description;
        }
      }, _el$4),
      _el$9 = libs.createElement("Panel", {
        "class": "MonopolyTaskReward"
      }, _el$3),
      _el$0 = libs.createElement("Label", {
        "class": "MonopolyTaskRewardValue",
        get text() {
          return props.reward;
        }
      }, _el$9);
    libs.insert(_el$9, libs.createComponent(StoreItem.StoreItemImage, {
      "class": "MonopolyTaskRewardIcon",
      itemid: 110007
    }), _el$0);
    libs.effect(_p$ => {
      const _v$ = props.title,
        _v$2 = props.progress,
        _v$3 = props.description,
        _v$4 = props.reward;
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$6, "text", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$7, "text", _v$2, _p$._v$2));
      _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$8, "text", _v$3, _p$._v$3));
      _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$0, "text", _v$4, _p$._v$4));
      return _p$;
    }, {
      _v$: undefined,
      _v$2: undefined,
      _v$3: undefined,
      _v$4: undefined
    });
    return _el$;
  })();
}
function MonopolyTaskGroup(props) {
  return (() => {
    const _el$1 = libs.createElement("Panel", {
        "class": "MonopolyTaskGroup"
      }, null),
      _el$10 = libs.createElement("Label", {
        "class": "MonopolyTaskGroupTitle",
        get text() {
          return props.title;
        }
      }, _el$1),
      _el$11 = libs.createElement("Panel", {
        "class": "MonopolyTaskGroupContent"
      }, _el$1);
    libs.insert(_el$11, libs.createComponent(MonopolyTaskItem, {
      title: "#Abyss_Activity_MonopolyTaskTitle1",
      progress: "(0/1)",
      description: "#Abyss_Activity_MonopolyTaskDesc1",
      reward: "100"
    }), null);
    libs.insert(_el$11, libs.createComponent(MonopolyTaskItem, {
      title: "#Abyss_Activity_MonopolyTaskTitle2",
      progress: "(3/10)",
      description: "#Abyss_Activity_MonopolyTaskDesc2",
      reward: "200"
    }), null);
    libs.insert(_el$11, libs.createComponent(MonopolyTaskItem, {
      title: "#Abyss_Activity_MonopolyTaskTitle3",
      progress: "(0/3)",
      description: "#Abyss_Activity_MonopolyTaskDesc3",
      reward: "300"
    }), null);
    libs.effect(_$p => libs.setProp(_el$10, "text", props.title, _$p));
    return _el$1;
  })();
}
function MonopolyGamePiece(props) {
  return (() => {
    const _el$12 = libs.createElement("Panel", {
        "class": "MonopolyGamePiece"
      }, null),
      _el$13 = libs.createElement("Panel", {
        "class": "MonopolyGameTileRotate"
      }, _el$12);
      libs.createElement("Image", {
        "class": "MonopolyGamePieceBG"
      }, _el$13);
      const _el$15 = libs.createElement("Label", {
        "class": "MonopolyGamePieceLevelProgress",
        get text() {
          return props.progress;
        }
      }, _el$12);
    libs.effect(_$p => libs.setProp(_el$15, "text", props.progress, _$p));
    return _el$12;
  })();
}
function MonopolyGamePiecePlaceholder() {
  return libs.createElement("Panel", {
    "class": "MonopolyGamePiecePlaceholder"
  }, null);
}
function MonopolyGamePlayerPiece(props) {
  return (() => {
    const _el$17 = libs.createElement("Panel", {
        "class": "MonopolyGamePlayerPiece",
        get style() {
          return {
            position: props.position
          };
        }
      }, null);
      libs.createElement("Panel", {
        "class": "MonopolyGamePlayerPieceCore"
      }, _el$17);
    libs.effect(_p$ => {
      const _v$5 = {
          Moving: props.moving
        },
        _v$6 = {
          position: props.position
        };
      _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$17, "classList", _v$5, _p$._v$5));
      _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$17, "style", _v$6, _p$._v$6));
      return _p$;
    }, {
      _v$5: undefined,
      _v$6: undefined
    });
    return _el$17;
  })();
}
function Monopoly() {
  const [playerPathIndex, setPlayerPathIndex] = libs.createSignal(0);
  const [isPlayerMoving, setIsPlayerMoving] = libs.createSignal(false);
  let moveScheduleID;
  const clearMoveSchedule = () => {
    if (moveScheduleID !== undefined) {
      $.CancelScheduled(moveScheduleID);
      moveScheduleID = undefined;
    }
  };
  const playerPiecePosition = libs.createMemo(() => {
    const tileIndex = TilePath[playerPathIndex()];
    const rowIndex = Math.floor(tileIndex / MONOPOLY_BOARD_COLUMN_COUNT);
    const columnIndex = tileIndex % MONOPOLY_BOARD_COLUMN_COUNT;
    const left = columnIndex * MONOPOLY_BOARD_CELL_SIZE + (MONOPOLY_BOARD_CELL_SIZE - MONOPOLY_PLAYER_PIECE_SIZE) / 2;
    const top = rowIndex * MONOPOLY_BOARD_CELL_SIZE + (MONOPOLY_BOARD_CELL_SIZE - MONOPOLY_PLAYER_PIECE_SIZE) / 2;
    return `${left}px ${top}px 0px`;
  });
  const finishPlayerMove = () => {
    moveScheduleID = undefined;
    setIsPlayerMoving(false);
  };
  const movePlayerBySteps = steps => {
    if (steps <= 0) {
      finishPlayerMove();
      return;
    }
    setPlayerPathIndex(index => (index + 1) % TilePath.length);
    moveScheduleID = $.Schedule(MONOPOLY_PLAYER_MOVE_STEP_DURATION, () => {
      moveScheduleID = undefined;
      movePlayerBySteps(steps - 1);
    });
  };
  const rollDiceAndMovePlayer = () => {
    if (isPlayerMoving()) {
      return;
    }
    clearMoveSchedule();
    setIsPlayerMoving(true);
    movePlayerBySteps(Math.floor(Math.random() * 10) + 1);
  };
  libs.onCleanup(clearMoveSchedule);
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
    id: "SubMenu_monopoly",
    get children() {
      return [libs.createElement("Image", {
        id: "MonopolyBG"
      }, null), (() => {
        const _el$20 = libs.createElement("Panel", {
            id: "MonopolyTopLeft"
          }, null);
          libs.createElement("Label", {
            id: "MonopolyTopTitle",
            text: "#Abyss_Activity_MonopolyTitle"
          }, _el$20);
          const _el$22 = libs.createElement("Panel", {
            id: "MonopolyTopSubTitle"
          }, _el$20);
          libs.createElement("Image", {
            id: "MonopolyTopSubTitleIcon"
          }, _el$22);
          libs.createElement("Label", {
            id: "MonopolyTopSubTitleText",
            text: "33d 16h 20m"
          }, _el$22);
        return _el$20;
      })(), (() => {
        const _el$25 = libs.createElement("Panel", {
            id: "MonopolyTopRight"
          }, null),
          _el$26 = libs.createElement("Panel", {
            id: "MonopolyRuleTip"
          }, _el$25),
          _el$27 = libs.createElement("Image", {
            id: "MonopolyRuleTipIcon"
          }, _el$26);
          libs.createElement("Label", {
            id: "MonopolyRuleTipLabel",
            text: "#Abyss_Activity_MonopolyRuleTipLabel"
          }, _el$26);
        libs.setProp(_el$27, "tooltip_text", "#AbyssActivity_MonopolyRuleTooltip");
        return _el$25;
      })(), (() => {
        const _el$29 = libs.createElement("Panel", {
          id: "MonopolyActivityTask",
          scroll: "y"
        }, null);
        libs.setProp(_el$29, "scroll", "y");
        libs.insert(_el$29, libs.createComponent(MonopolyTaskGroup, {
          title: "#Abyss_Activity_MonopolyDailyTask"
        }), null);
        libs.insert(_el$29, libs.createComponent(MonopolyTaskGroup, {
          title: "#Abyss_Activity_MonopolyWeeklyTask"
        }), null);
        return _el$29;
      })(), (() => {
        const _el$30 = libs.createElement("Panel", {
            id: "MonopolyGameContainer"
          }, null),
          _el$31 = libs.createElement("Panel", {
            id: "MonopolyGameBoard"
          }, _el$30),
          _el$32 = libs.createElement("Panel", {
            id: "MonopolyGamePieceLayerRotated"
          }, _el$31),
          _el$33 = libs.createElement("Panel", {
            id: "MonopolyGamePieceGrid"
          }, _el$32),
          _el$34 = libs.createElement("Panel", {
            id: "MonopolyGamePlayerLayer"
          }, _el$32),
          _el$35 = libs.createElement("Panel", {
            id: "MonopolyGameOperation"
          }, _el$30),
          _el$36 = libs.createElement("Panel", {
            id: "MonopolyGameCostInfo"
          }, _el$35),
          _el$37 = libs.createElement("Label", {
            id: "MonopolyGameCostValue",
            text: "x1"
          }, _el$36);
        libs.insert(_el$33, libs.createComponent(libs.For, {
          each: monopolyBoardRows,
          children: row => (() => {
            const _el$38 = libs.createElement("Panel", {
              "class": "MonopolyGamePieceRow"
            }, null);
            libs.insert(_el$38, libs.createComponent(libs.For, {
              each: row,
              children: piece => (() => {
                const _el$39 = libs.createElement("Panel", {
                  "class": "MonopolyGamePieceCell"
                }, null);
                libs.insert(_el$39, libs.createComponent(libs.Show, {
                  get when() {
                    return piece.shouldRenderPiece;
                  },
                  get children() {
                    return libs.createComponent(MonopolyGamePiece, {
                      get id() {
                        return piece.id;
                      },
                      get tileIndex() {
                        return piece.tileIndex;
                      },
                      get progress() {
                        return piece.progress;
                      },
                      get shouldRenderPiece() {
                        return piece.shouldRenderPiece;
                      }
                    });
                  }
                }), null);
                libs.insert(_el$39, libs.createComponent(libs.Show, {
                  get when() {
                    return !piece.shouldRenderPiece;
                  },
                  get children() {
                    return libs.createComponent(MonopolyGamePiecePlaceholder, {});
                  }
                }), null);
                return _el$39;
              })()
            }));
            return _el$38;
          })()
        }));
        libs.insert(_el$34, libs.createComponent(MonopolyGamePlayerPiece, {
          get position() {
            return playerPiecePosition();
          },
          get moving() {
            return isPlayerMoving();
          }
        }));
        libs.insert(_el$36, libs.createComponent(StoreItem.StoreItemImage, {
          itemid: 210001
        }), _el$37);
        libs.insert(_el$35, libs.createComponent(EOM_Button.EOM_Button, {
          id: "MonopolyGameRollButton",
          color: "Green",
          get enabled() {
            return !isPlayerMoving();
          },
          text: "#Abyss_Activity_MonopolyGameRoll",
          onactivate: rollDiceAndMovePlayer
        }), null);
        return _el$30;
      })()];
    }
  });
}

const MENU_LIST = {
  AbyssActivity_Menu: ["SubMenu_monopoly"]
};
const {
  LayoutMenu,
  show,
  secondTabName,
  menuName
} = EOM_MenuLayout.createMenuLayout("abyss_activity", () => MENU_LIST);
function HUDAbyssActivity() {
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout, {
    id: "HUDAbyssActivityRoot",
    name: "MenuButton_abyss_activity",
    renderOnShow: true,
    get show() {
      return show();
    },
    get children() {
      return [libs.createComponent(LayoutMenu, {}), libs.createComponent(libs.Switch, {
        get children() {
          return libs.createComponent(libs.Match, {
            get when() {
              return secondTabName() == "SubMenu_monopoly";
            },
            get children() {
              return libs.createComponent(Monopoly, {});
            }
          });
        }
      })];
    }
  });
}
libs.render(() => libs.createComponent(HUDAbyssActivity, {}), $.GetContextPanel());