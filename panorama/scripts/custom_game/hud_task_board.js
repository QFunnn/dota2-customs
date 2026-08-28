--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_MenuLayout = require('./EOM_MenuLayout.js');
var Player = require('./Player.js');
var StoreTagPage = require('./StoreTagPage.js');
var EOM_Countdown = require('./EOM_Countdown.js');
var EOM_Icon = require('./EOM_Icon.js');
var EOM_RedMark = require('./EOM_RedMark.js');
var EOM_Button = require('./EOM_Button.js');
var StoreItem = require('./StoreItem.js');
var solid_utils = require('./solid_utils.js');
require('./service_netdata_helper.js');
require('./EOM_TextEntry.js');
require('./equipment_utils.js');

const daily_bounty_tasks = solid_utils.createServiceNetData("player_daily_bounty_tasks", {});
const weekly_bounty_tasks = solid_utils.createServiceNetData("player_weekly_bounty_tasks", {});
const TASK_BOX_POSITIONS = [{
  x: 75,
  y: 0,
  rotation: -4
}, {
  x: 330,
  y: 80,
  rotation: 4
}, {
  x: 585,
  y: 0,
  rotation: -4
}, {
  x: 830,
  y: 80,
  rotation: 4
}, {
  x: 1080,
  y: 0,
  rotation: -4
}];
const today = new Date().setHours(0, 0, 0, 0) / 1000;
const nextDay = new Date().setHours(24, 0, 0, 0) / 1000;
let [taskStartTime, setTaskStartTime] = libs.createSignal(today);
let [taskEndTime, setTaskEndTime] = libs.createSignal(nextDay);
const needShowRedPoint = source => {
  const timestamp = CustomUIConfig.GetServerTimeStamp();
  return Object.values(source).some(t => t.receive_progress != 1 && t.progress >= t.target && t.end_time >= timestamp && t.start_time <= timestamp);
};
const needShowDailyRedPoint = () => needShowRedPoint(daily_bounty_tasks());
const needShowWeeklyRedPoint = () => needShowRedPoint(weekly_bounty_tasks());
const taskList = secondTabName => libs.createMemo(() => {
  const tabName = secondTabName();
  const source = tabName === "daily_board" ? daily_bounty_tasks : weekly_bounty_tasks;
  const timestamp = CustomUIConfig.GetServerTimeStamp();
  return Object.values(source()).filter(task => {
    let kv = KeyValues.task[task.task_id];
    if (!kv) return false;
    if (task.end_time < timestamp) return false;
    if (task.start_time > timestamp) return false;
    if (task.index < 1 || task.index > 5) return false;
    setTaskStartTime(task.start_time);
    setTaskEndTime(task.end_time);
    return true;
  }).sort((a, b) => a.index - b.index);
});
const TaskBoard = props => {
  const [bRequesting, SetRequesting] = libs.createSignal(false);
  const [page, setPage] = libs.createSignal(1);
  const secondTabName = () => props.secondTabName;
  const list = taskList(secondTabName);
  const player_blessings = solid_utils.createServiceNetData("player_blessings", {});
  libs.createEffect(libs.on(secondTabName, () => {
    setPage(1);
  }));
  const pageSize = 5;
  const totalPages = () => Math.max(1, Math.ceil(list().length / pageSize));
  const pageList = libs.createMemo(() => {
    const start = (page() - 1) * pageSize;
    return list().slice(start, start + pageSize);
  });
  const weeklyTotalCount = libs.createMemo(() => {
    const timestamp = CustomUIConfig.GetServerTimeStamp();
    return Object.values(weekly_bounty_tasks()).filter(t => t.end_time >= timestamp && t.start_time <= timestamp).length;
  });
  const weeklyCompletedCount = libs.createMemo(() => {
    const timestamp = CustomUIConfig.GetServerTimeStamp();
    return Object.values(weekly_bounty_tasks()).filter(t => t.receive_progress == 1 && t.end_time >= timestamp && t.start_time <= timestamp).length;
  });
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
    id: "TaskBoard",
    get children() {
      return [(() => {
        const _el$ = libs.createElement("Panel", {
            id: "CenterBlock",
            hittest: false
          }, null),
          _el$2 = libs.createElement("Panel", {
            id: "TaskBoardCountdown"
          }, _el$),
          _el$4 = libs.createElement("Panel", {
            id: "TaskBoardContent"
          }, _el$);
        libs.insert(_el$2, libs.createComponent(EOM_Countdown.EOM_Countdown, {
          icon: true,
          get endTime() {
            return taskEndTime();
          },
          text: "#CountdownTime"
        }), null);
        libs.insert(_el$2, libs.createComponent(libs.Show, {
          get when() {
            return secondTabName() !== "daily_board";
          },
          get children() {
            const _el$3 = libs.createElement("Label", {
              id: "ProgressLabelShow",
              get text() {
                return LocalizeWithVars("#TaskBoard_WeeklyCompleteProgress", {
                  completed: weeklyCompletedCount(),
                  total: weeklyTotalCount()
                });
              }
            }, null);
            libs.effect(_$p => libs.setProp(_el$3, "text", LocalizeWithVars("#TaskBoard_WeeklyCompleteProgress", {
              completed: weeklyCompletedCount(),
              total: weeklyTotalCount()
            }), _$p));
            return _el$3;
          }
        }), null);
        libs.insert(_el$4, libs.createComponent(libs.Index, {
          get each() {
            return pageList();
          },
          children: (task, index) => {
            const pos = TASK_BOX_POSITIONS[index];
            const state = () => {
              if (task().receive_progress == 1) return "Received";
              if (task().progress >= task().target) return "CanReceive";
              return "WaitFinish";
            };
            const taskConfig = () => KeyValues.task[task().task_id];
            const descID = () => {
              let config = taskConfig();
              if (config.task_description == 1) {
                return config.task_id;
              } else {
                return config.event_id;
              }
            };
            const rewards = () => {
              const kv = KeyValues.task[task().task_id];
              if (!kv || !kv.rewards) return [];
              const list = [];
              for (const [id, num] of Object.entries(kv.rewards)) {
                list.push({
                  id,
                  num
                });
              }
              if (kv.blessing_reward) {
                const now = Math.floor(Date.now() / 1000);
                const buffData = player_blessings()[kv.vip_blessing];
                const hasBuff = buffData != undefined && (buffData.permanent == true || now < buffData.expire_time && buffData.expire_time != -1);
                for (const [id, num] of Object.entries(kv.blessing_reward)) {
                  list.push({
                    id,
                    num,
                    lock: !hasBuff,
                    vip: kv.vip_blessing
                  });
                }
              }
              return list;
            };
            return (() => {
              const _el$5 = libs.createElement("Panel", {
                  get ["class"]() {
                    return "TaskBoxWrapper " + state();
                  },
                  get style() {
                    return {
                      x: `${pos.x}px`,
                      y: `${pos.y}px`,
                      transform: `rotateZ(${pos.rotation}deg)`
                    };
                  }
                }, null),
                _el$6 = libs.createElement("Panel", {
                  "class": "TaskBox"
                }, _el$5);
                libs.createElement("Image", {
                  id: "TaskBoxHoverFrame",
                  hittest: false
                }, _el$6);
                const _el$8 = libs.createElement("Panel", {
                  id: "TaskBoxTop",
                  flowChildren: "down"
                }, _el$6),
                _el$9 = libs.createElement("Label", {
                  id: "TaskBoxTitle",
                  get text() {
                    return "#Task_Name_" + descID();
                  }
                }, _el$8),
                _el$0 = libs.createElement("Image", {
                  id: "TaskBoxIcon",
                  get src() {
                    return `file://{images}/custom_game/task_icons/${taskConfig().icon}.png`;
                  }
                }, _el$8),
                _el$1 = libs.createElement("Panel", {
                  id: "TaskBoxDescLine",
                  flowChildren: "right"
                }, _el$8),
                _el$10 = libs.createElement("Label", {
                  id: "TaskBoxDesc",
                  get text() {
                    return "#Task_Desc_" + descID();
                  }
                }, _el$1),
                _el$11 = libs.createElement("Label", {
                  id: "ProgressLabel",
                  get text() {
                    return `(${task().progress}/${task().target})`;
                  }
                }, _el$1),
                _el$12 = libs.createElement("Panel", {
                  id: "TaskBoxBottom"
                }, _el$6);
                libs.createElement("Panel", {
                  id: "TaskRewardLine"
                }, _el$12);
                const _el$14 = libs.createElement("Panel", {
                  id: "TaskRewardList"
                }, _el$12);
                libs.createElement("Image", {
                  id: "TaskBoxReceived",
                  hittest: false,
                  src: "file://{images}/custom_game/r2_reward/r2_cross.png"
                }, _el$5);
              libs.setProp(_el$8, "flowChildren", "down");
              libs.setProp(_el$1, "flowChildren", "right");
              libs.insert(_el$14, libs.createComponent(libs.Index, {
                get each() {
                  return rewards();
                },
                children: reward => (() => {
                  const _el$23 = libs.createElement("Panel", {
                      "class": "TaskRewardItem"
                    }, null),
                    _el$24 = libs.createElement("Panel", {
                      id: "VIPIcon",
                      get ["class"]() {
                        return "Buff" + reward().vip;
                      }
                    }, _el$23);
                  libs.insert(_el$23, libs.createComponent(StoreItem.StoreItemBlock, {
                    id: "TaskReward",
                    get item_id() {
                      return Number(reward().id);
                    },
                    get amounts() {
                      return reward().num;
                    }
                  }), _el$24);
                  libs.insert(_el$23, libs.createComponent(EOM_Icon.EOM_Icon, {
                    id: "TaskRewardLock",
                    type: "LockSmall"
                  }), _el$24);
                  libs.effect(_p$ => {
                    const _v$7 = {
                        RewardLock: reward().lock ?? false,
                        Vip: reward().vip != undefined && reward().vip > 0
                      },
                      _v$8 = "Buff" + reward().vip,
                      _v$9 = "#" + reward().vip;
                    _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$23, "classList", _v$7, _p$._v$7));
                    _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$24, "class", _v$8, _p$._v$8));
                    _v$9 !== _p$._v$9 && (_p$._v$9 = libs.setProp(_el$24, "tooltip", _v$9, _p$._v$9));
                    return _p$;
                  }, {
                    _v$7: undefined,
                    _v$8: undefined,
                    _v$9: undefined
                  });
                  return _el$23;
                })()
              }));
              libs.insert(_el$12, libs.createComponent(libs.Show, {
                get when() {
                  return state() == "WaitFinish";
                },
                get children() {
                  const _el$15 = libs.createElement("Panel", {
                      id: "DoingTag",
                      flowChildren: "right"
                    }, null);
                    libs.createElement("Image", {
                      id: "DoingIconLeft"
                    }, _el$15);
                    const _el$17 = libs.createElement("Panel", {
                      id: "DoingMiddle"
                    }, _el$15);
                    libs.createElement("Image", {
                      id: "DoingIconMid"
                    }, _el$17);
                    libs.createElement("Label", {
                      id: "DoingText",
                      text: "#Task_Bord_Doing"
                    }, _el$17);
                    libs.createElement("Image", {
                      id: "DoingIconRight"
                    }, _el$15);
                  libs.setProp(_el$15, "flowChildren", "right");
                  return _el$15;
                }
              }), null);
              libs.insert(_el$12, libs.createComponent(libs.Show, {
                get when() {
                  return state() == "CanReceive";
                },
                get children() {
                  return libs.createComponent(EOM_Button.EOM_BaseButton, {
                    id: "TaskBoxGetButton",
                    onactivate: () => {
                      if (bRequesting()) {
                        return;
                      }
                      SetRequesting(true);
                      CallActionRequest("/v1/task/receive_rewards", {
                        task_id: task().task_id,
                        extra_id: task().extra_id
                      }, data => {
                        SetRequesting(false);
                      });
                    },
                    get children() {
                      return [libs.createComponent(libs.Show, {
                        get when() {
                          return state() == "CanReceive";
                        },
                        get children() {
                          return libs.createComponent(EOM_RedMark.EOM_RedMark, {
                            align: "left top",
                            marginLeft: "10px",
                            size: "medium"
                          });
                        }
                      }), (() => {
                        const _el$21 = libs.createElement("Label", {
                          align: "center center",
                          width: "100%",
                          text: "#Task_ReceiveReward"
                        }, null);
                        libs.setProp(_el$21, "align", "center center");
                        libs.setProp(_el$21, "width", "100%");
                        return _el$21;
                      })()];
                    }
                  });
                }
              }), null);
              libs.effect(_p$ => {
                const _v$ = "TaskBoxWrapper " + state(),
                  _v$2 = {
                    x: `${pos.x}px`,
                    y: `${pos.y}px`,
                    transform: `rotateZ(${pos.rotation}deg)`
                  },
                  _v$3 = "#Task_Name_" + descID(),
                  _v$4 = `file://{images}/custom_game/task_icons/${taskConfig().icon}.png`,
                  _v$5 = "#Task_Desc_" + descID(),
                  _v$6 = `(${task().progress}/${task().target})`;
                _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$5, "class", _v$, _p$._v$));
                _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$5, "style", _v$2, _p$._v$2));
                _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$9, "text", _v$3, _p$._v$3));
                _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$0, "src", _v$4, _p$._v$4));
                _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$10, "text", _v$5, _p$._v$5));
                _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$11, "text", _v$6, _p$._v$6));
                return _p$;
              }, {
                _v$: undefined,
                _v$2: undefined,
                _v$3: undefined,
                _v$4: undefined,
                _v$5: undefined,
                _v$6: undefined
              });
              return _el$5;
            })();
          }
        }));
        return _el$;
      })(), libs.createComponent(libs.Show, {
        get when() {
          return page() > 1;
        },
        get children() {
          return libs.createComponent(EOM_Button.EOM_BaseButton, {
            id: "PagePrev",
            onactivate: () => setPage(page() - 1)
          });
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return page() < totalPages();
        },
        get children() {
          return libs.createComponent(EOM_Button.EOM_BaseButton, {
            id: "PageNext",
            onactivate: () => setPage(page() + 1)
          });
        }
      })];
    }
  });
};

const MENU_LIST = {
  task_board: ["daily_board", "week_board"],
  Flowers: []
};
const {
  LayoutMenu,
  show,
  secondTabName,
  menuName
} = EOM_MenuLayout.createMenuLayout("task_board", () => MENU_LIST);
const flowersRedPoint = StoreTagPage.createStoreTagRedPointData("Flowers");
function Battlepass() {
  libs.createEffect(() => {
    CustomUIConfig.SetRedPoint(needShowDailyRedPoint(), "task_board", "task_board", "daily_board");
    CustomUIConfig.SetRedPoint(needShowWeeklyRedPoint(), "task_board", "task_board", "week_board");
    CustomUIConfig.SetRedPoint(flowersRedPoint(), "task_board", "task_board", "Flowers");
  });
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout, {
    id: "TaskBoardRoot",
    name: "MenuButton_board",
    renderOnShow: true,
    get show() {
      return show();
    },
    get children() {
      return [libs.createComponent(LayoutMenu, {}), libs.createComponent(Player.CurrencyGroup, {
        tokens: [110007]
      }), libs.createComponent(libs.Switch, {
        get children() {
          return [libs.createComponent(libs.Match, {
            get when() {
              return secondTabName() == "daily_board" || secondTabName() == "week_board";
            },
            get children() {
              return libs.createComponent(TaskBoard, {
                get secondTabName() {
                  return secondTabName();
                }
              });
            }
          }), libs.createComponent(libs.Match, {
            get when() {
              return menuName() == "Flowers";
            },
            get children() {
              return libs.createComponent(StoreTagPage.StoreTagPage, {
                tag: "Flowers"
              });
            }
          })];
        }
      })];
    }
  });
}
libs.render(() => libs.createComponent(Battlepass, {}), $.GetContextPanel());