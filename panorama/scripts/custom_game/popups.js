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
var CosmeticCard = require('./CosmeticCard.js');
var EOM_Label = require('./EOM_Label.js');
var GenericPanel = require('./GenericPanel.js');
var ProductItem = require('./ProductItem.js');
var netdata_utils = require('./netdata_utils.js');
var EOM_Popup = require('./EOM_Popup.js');
var EOM_Countdown = require('./EOM_Countdown.js');
var EOM_Image = require('./EOM_Image.js');
var EOM_Button = require('./EOM_Button.js');
var ProductImage = require('./ProductImage.js');
var CosmeticPreview = require('./CosmeticPreview.js');
var EOM_PortraitFullBody = require('./EOM_PortraitFullBody.js');
var EOM_NumberAdjust = require('./EOM_NumberAdjust.js');
var EOM_Separator = require('./EOM_Separator.js');
var Player = require('./Player.js');
var backpack_item = require('./backpack_item.js');
var EOM_Icon = require('./EOM_Icon.js');
var StoreItemImage = require('./StoreItemImage.js');
var HeroProficiencyIcon = require('./HeroProficiencyIcon.js');
var SectIcon = require('./SectIcon.js');
var HeroRoleCard = require('./HeroRoleCard.js');
var MenuMarkIcon = require('./MenuMarkIcon.js');
var EOM_Loading = require('./EOM_Loading.js');
var EOM_QRCode = require('./EOM_QRCode.js');
var EOM_DropDown = require('./EOM_DropDown.js');
var WinStreak = require('./WinStreak.js');
var ScoreBoardTabButtons = require('./ScoreBoardTabButtons.js');
var profile_simplify = require('./profile_simplify.js');
var InfoButton = require('./InfoButton.js');
var rookie_sect = require('./rookie_sect.js');
var StoreItem = require('./StoreItem.js');
var EOM_Portrait = require('./EOM_Portrait.js');
require('./CourierTitle.js');
require('./profile_info.js');
require('./Heroes.js');
require('./MedalBadgeIcon.js');
require('./RankTierIcon.js');
require('./game_utils.js');

const BasePopup = props => {
  const merged = libs.mergeProps$1({
    size: "normal",
    closeOnClickOuter: true,
    closeOnEsc: true,
    closeGroup: true,
    hideClose: false,
    type: EOM_Panel.ADDON_NAME
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "id", "title", "size", "closeOnClickOuter", "closeOnEsc", "closeGroup", "PopupID", "group", "hideClose", "type"]);
  const onClickOuter = () => {
    if (local.closeOnClickOuter) {
      if (local.PopupID) {
        closePopup(local.PopupID);
      }
    }
  };
  const onEsc = () => {
    if (local.closeOnEsc) {
      if (local.PopupID) {
        closePopup(local.PopupID);
      }
    }
  };
  libs.onMount(() => {
    const id = GameEvents.Subscribe("client_side_event", eventData => {
      if ("close_popup_fadeout" == eventData.event_name) {
        let data = eventData.event_data;
        if (data.PopupID) {
          if (local.PopupID == data.PopupID) {
            setPopupShow(false);
            setPopupClose(true);
          }
        } else if (data.group) {
          if (local.group == data.group) {
            setPopupShow(false);
            setPopupClose(true);
          }
        }
      }
    });
    libs.onCleanup(() => GameEvents.Unsubscribe(id));
  });
  const [popupShow, setPopupShow] = libs.createSignal(false);
  const [popupClose, setPopupClose] = libs.createSignal(false);
  return (() => {
    const _el$ = libs.createElement("Button", libs.mergeProps({
      get id() {
        return local.PopupID;
      }
    }, () => EOM_Panel.EOMProps(others, {
      className: "PopupContainer"
    })), null);
    libs.spread(_el$, libs.mergeProps({
      get id() {
        return local.PopupID;
      }
    }, () => EOM_Panel.EOMProps(others, {
      className: "PopupContainer"
    }), {
      "onactivate": self => onClickOuter(),
      "onload": self => {
        setPopupShow(true);
        self.SetFocus();
      },
      "oncancel": self => onEsc()
    }), true);
    libs.insert(_el$, libs.createComponent(EOM_Popup.EOM_Popup, {
      id: "EOM_PopupMain",
      get type() {
        return local.type;
      },
      popType: "PopupType_PopOut",
      get size() {
        return local.size;
      },
      get title() {
        return local.title;
      },
      get className() {
        return libs.classNames({
          EOM_PopupMainShow: popupShow(),
          EOM_PopupMainClose: popupClose()
        });
      },
      get hideClose() {
        return local.hideClose;
      },
      align: "center center",
      onClose: () => {
        if (local.PopupID) {
          closePopup(local.PopupID);
        }
      },
      get children() {
        return local.children;
      }
    }));
    return _el$;
  })();
};

const Popup_ActivityDrawReward = props => {
  const [local, others] = libs.splitProps(props, ["PopupID", "group", "activityID", "title"]);
  const activityID = local.activityID;
  const [activityCollection, setActivityCollection] = libs.createSignal({});
  const [rewardInfoList, setRewardInfoList] = libs.createSignal([]);
  const [progress, setProgress] = libs.createSignal(0);
  const getDefaultSelectedID = () => {
    if (props.activityID == 14001) {
      return 1;
    }
    return 0;
  };
  const [selectedID, setSelectedID] = libs.createSignal(getDefaultSelectedID());
  let inited = false;
  libs.createEffect(() => {
    let index = getDefaultSelectedID();
    const current_activityCollection = activityCollection();
    if (current_activityCollection) {
      const sortList = Object.keys(current_activityCollection).sort((a, b) => Number(b) - Number(a));
      for (const id of sortList) {
        const state = current_activityCollection[id];
        if (state != undefined && state == 2) {
          index = Number(id);
          inited = true;
          break;
        }
      }
    }
    if (!inited) {
      setSelectedID(index);
    }
  });
  const selectedReward = () => {
    let data;
    const current_selectedID = selectedID();
    const current_rewardInfoList = rewardInfoList();
    if (current_rewardInfoList[current_selectedID]) {
      data = current_rewardInfoList[current_selectedID].rewards[0];
    }
    return data;
  };
  netdata_utils.createNetDataEffect("match_activity_data", data => {
    setProgress(data[activityID]?.progress ?? 0);
    setActivityCollection(data[activityID].rewards ?? {});
  }, Players.GetLocalPlayer());
  netdata_utils.createNetDataEffect("info_activity_data", data => {
    for (const activityInfo of data) {
      if (activityInfo.activity_id == activityID) {
        const reward = JSON.parse(activityInfo.extra_information);
        setRewardInfoList(reward.rewards);
      }
    }
  });
  const progressBarInfo = libs.createMemo(() => {
    let arr = [];
    for (let index = 0; index < rewardInfoList().length; index++) {
      const currentInfo = rewardInfoList()[index];
      if (index == 0) {
        arr[index] = {
          start: 0,
          end: currentInfo.threshold
        };
        continue;
      }
      const lastInfo = rewardInfoList()[index - 1];
      arr[index] = {
        start: lastInfo.threshold,
        end: currentInfo.threshold
      };
    }
    return arr;
  });
  const receiveReward = rid => {
    callAction("activity_receive", {
      reward_id: rid,
      activity_id: activityID
    });
  };
  let previewTimer = -1;
  return libs.createComponent(BasePopup, {
    className: "Popup_ActivityDrawReward",
    get PopupID() {
      return local.PopupID;
    },
    size: "large",
    get group() {
      return local.group;
    },
    get title() {
      return local.title;
    },
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "MainContainer",
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "Title",
            flowChildren: "right",
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                "class": "BG",
                id: "BGLeft"
              }), libs.createComponent(EOM_Label.EOM_Label, {
                text: "#mail_reward"
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                "class": "BG",
                id: "BGRight"
              })];
            }
          }), libs.createComponent(libs.Show, {
            get when() {
              return local.activityID == 14001;
            },
            get children() {
              return libs.createComponent(GenericPanel.CLabel, {
                id: "TopTipsLabel",
                text: "#Activity_NewYear25_Hero"
              });
            }
          }), libs.createComponent(GenericPanel.CLabel, {
            id: "Stack",
            get text() {
              return local.title + "_stacktotal";
            },
            get dialogVariables() {
              return {
                count: progress()
              };
            }
          }), libs.createComponent(libs.Show, {
            get when() {
              return selectedReward() != undefined;
            },
            get children() {
              return libs.createComponent(libs.Show, {
                get when() {
                  return KeyValues.CosmeticsKv[selectedReward().item_id] != undefined;
                },
                get fallback() {
                  return libs.createComponent(ProductItem.ProductItem, {
                    get itemid() {
                      return selectedReward().item_id;
                    },
                    get count() {
                      return selectedReward()?.amounts;
                    },
                    get rarity() {
                      return selectedReward()?.rarity;
                    }
                  });
                },
                get children() {
                  const _el$ = libs.createElement("Image", {}, null),
                    _el$2 = libs.createElement("Panel", {}, _el$),
                    _el$3 = libs.createElement("Panel", {}, _el$2),
                    _el$4 = libs.createElement("Image", {}, _el$3),
                    _el$5 = libs.createElement("Image", {}, _el$3),
                    _el$6 = libs.createElement("Image", {}, _el$3);
                  libs.setProp(_el$2, "className", "ProductItemTitle");
                  libs.setProp(_el$3, "className", "ProductItemTitleBG");
                  libs.setProp(_el$4, "className", "Left");
                  libs.setProp(_el$5, "className", "Center");
                  libs.setProp(_el$6, "className", "Right");
                  libs.insert(_el$2, libs.createComponent(GenericPanel.CLabel, {
                    get text() {
                      return "#" + selectedReward().item_id;
                    }
                  }), null);
                  libs.insert(_el$, libs.createComponent(CosmeticCard.CosmeticImage, {
                    get itemid() {
                      return selectedReward().item_id;
                    },
                    onmouseover: self => {
                      $.DispatchEvent("DOTAShowTitleTextTooltip", self, "#" + selectedReward().item_id, "#" + selectedReward().item_id + "_description");
                    },
                    onmouseout: self => {
                      $.DispatchEvent("DOTAHideTitleTextTooltip", self);
                    }
                  }), null);
                  libs.effect(_$p => libs.setProp(_el$, "className", libs.classNames("ProductItem", "Rarity" + selectedReward()?.rarity), _$p));
                  return _el$;
                }
              });
            }
          })];
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "BottomContainer",
        scroll: "x",
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            horizontalAlign: "center",
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "ProgressBars",
                get children() {
                  return libs.createComponent(libs.Index, {
                    get each() {
                      return progressBarInfo();
                    },
                    children: (info, index) => {
                      const percentage = () => {
                        return Round(Clamp((progress() - info().start) / Math.max(1, info().end - info().start), 0, 1) * 100);
                      };
                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "ProgressBar",
                        get tooltip() {
                          return `${progress()} / ${info().end}`;
                        },
                        get children() {
                          return libs.createComponent(EOM_Panel.EOM_Panel, {
                            id: "ProgressBarBG",
                            get children() {
                              return libs.createComponent(EOM_Panel.EOM_Panel, {
                                id: "ProgressBarUp",
                                get width() {
                                  return `${percentage()}%`;
                                }
                              });
                            }
                          });
                        }
                      });
                    }
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "Targets",
                get children() {
                  return libs.createComponent(libs.Index, {
                    get each() {
                      return progressBarInfo();
                    },
                    children: (info, index) => {
                      const state = () => {
                        return activityCollection()?.[(index + 1).toString()] ?? 2;
                      };
                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "Target",
                        get className() {
                          return libs.classNames({
                            locked: state() == 2,
                            Received: state() == 1
                          });
                        },
                        get children() {
                          return libs.createComponent(GenericPanel.CLabel, {
                            get text() {
                              return `${info().end}`;
                            }
                          });
                        }
                      });
                    }
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "Rewards",
                get children() {
                  return libs.createComponent(libs.Index, {
                    get each() {
                      return rewardInfoList();
                    },
                    children: (info, index) => {
                      const itemData = () => {
                        return info().rewards[0];
                      };
                      const state = () => {
                        return activityCollection()[info().reward_id.toString()] ?? 2;
                      };
                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                        get className() {
                          return libs.classNames("MiniReawrd", {
                            Selected: selectedID() == index,
                            Receivable: state() == 0,
                            Received: state() == 1
                          });
                        },
                        onactivate: () => {
                          setSelectedID(index);
                          if (state() == 0) {
                            receiveReward(info().reward_id);
                          }
                        },
                        onmouseover: self => {
                          previewTimer = $.Schedule(0.3, () => {
                            previewTimer = -1;
                            setSelectedID(index);
                          });
                        },
                        onmouseout: self => {
                          if (previewTimer != -1) {
                            $.CancelScheduled(previewTimer);
                            previewTimer = -1;
                          }
                        },
                        get children() {
                          return [libs.createComponent(EOM_Panel.EOM_Panel, {
                            id: "SeletedBG"
                          }), libs.createComponent(libs.Show, {
                            get when() {
                              return KeyValues.CosmeticsKv[itemData().item_id] != undefined;
                            },
                            get fallback() {
                              return libs.createComponent(GenericPanel.CImage, {
                                className: "ProductImage",
                                get src() {
                                  return getSrcPath("store_items/" + itemData().item_id + ".png");
                                },
                                onmouseover: self => {
                                  $.DispatchEvent("DOTAShowTitleTextTooltip", self, "#" + itemData().item_id, "#" + itemData().item_id + "_description");
                                },
                                onmouseout: self => {
                                  $.DispatchEvent("DOTAHideTitleTextTooltip", self);
                                }
                              });
                            },
                            get children() {
                              return libs.createComponent(GenericPanel.CImage, {
                                className: "ProductImage",
                                get src() {
                                  return getCosmeticImagePath(itemData().item_id.toString());
                                },
                                onmouseover: self => {
                                  $.DispatchEvent("DOTAShowTitleTextTooltip", self, "#" + itemData().item_id, "#" + itemData().item_id + "_description");
                                },
                                onmouseout: self => {
                                  $.DispatchEvent("DOTAHideTitleTextTooltip", self);
                                }
                              });
                            }
                          }), libs.createComponent(libs.Show, {
                            get when() {
                              return libs.memo(() => !!itemData().amounts)() && itemData().amounts > 1;
                            },
                            get children() {
                              return libs.createComponent(GenericPanel.CLabel, {
                                className: "ProductCount",
                                get text() {
                                  return "" + itemData().amounts;
                                },
                                hittest: false
                              });
                            }
                          }), libs.createComponent(EOM_Panel.EOM_Panel, {
                            id: "ReceivableBG",
                            hittest: false
                          })];
                        }
                      });
                    }
                  });
                }
              })];
            }
          });
        }
      })];
    }
  });
};

let requesting = false;
const receiveTaskReward = (activity_id, task_id, unique_task_id) => {
  if (unique_task_id != undefined && !requesting) {
    requesting = true;
    serverRequest("activity_task_reward", {
      task_id: task_id,
      unique_task_id: unique_task_id
    }, ({
      status
    }) => {
      requesting = false;
      if (status == 0) {
        callAction("activity_data", {
          activity_id
        });
      }
    });
  }
};
const Popup_ActivityTask = props => {
  const activityID = () => props.activity_id ?? 10001;
  const [time, setTime] = libs.createSignal(Date.now() / 1000);
  libs.onMount(() => {
    const timer = setInterval(() => setTime(Date.now() / 1000), 1000);
    libs.onCleanup(() => {
      clearInterval(timer);
    });
  });
  const [activityProgress, setActivityProgress] = libs.createSignal(0);
  const [taskEndTime, setTaskEndTime] = libs.createSignal(1720713599);
  const [local, others] = libs.splitProps(props, ["PopupID", "group"]);
  const [activityTask, setActivityTask] = libs.createSignal({});
  const [taskProgress, setTaskProgress] = libs.createSignal({});
  const [taskLimited, setTaskLimited] = libs.createSignal(false);
  libs.createEffect(() => {
    if (activityID() == 10001 || activityID() == 10002 || activityID() == 10003 || activityID() == 10004) {
      setTaskLimited(activityProgress() >= 100);
    } else if (activityID() == 10005) {
      setTaskLimited(activityProgress() >= 180);
    }
  });
  const taskData = libs.createMemo(() => {
    if (activityTask()) {
      return Object.keys(activityTask()).map(taskID => {
        let data = {
          task_id: activityTask()[taskID].task_id,
          unique_task_id: taskProgress()[taskID]?.unique_task_id,
          progress: taskProgress()[taskID]?.progress ?? 0,
          receive_progress: taskProgress()[taskID]?.receive_progress ?? 0,
          end_time: taskProgress()[taskID]?.end_time ?? 0,
          reward: JSON.parse(activityTask()[taskID]?.reward ?? "[]"),
          target: Number(activityTask()[taskID]?.target) ?? 1
        };
        return data;
      }).sort((a, b) => {
        return multiCompare(a.receive_progress - b.receive_progress, Number(b.progress >= b.target) - Number(a.progress >= a.target), a.task_id - b.task_id);
      });
    }
    return [];
  }, []);
  const updateActivityTaskProgress = (data = getNetDataCache("activity_task_progresses", Players.GetLocalPlayer())) => {
    if (data) {
      let dayData = {};
      let dayRecord = {};
      for (const uniqueTaskId in data) {
        const progress = data[uniqueTaskId];
        const task_id = progress.task_id;
        if (activityTask()[task_id]) {
          const day = finiteNumber(Number(progress.unique_task_id.split("-")[1]), 0);
          if (day >= finiteNumber(Number(dayRecord[task_id]), -1)) {
            dayRecord[task_id] = day;
            dayData[task_id.toString()] = progress;
          }
        }
      }
      setTaskProgress(dayData);
    }
  };
  libs.onMount(() => {
    const eventIDList = [];
    eventIDList.push(useNetData("info_activity_task", data => {
      if (data) {
        const rebuild = {};
        for (const task_id in data) {
          const task_info = data[task_id];
          if (task_info.activity_id == activityID()) {
            rebuild[task_id] = task_info;
          }
        }
        setActivityTask(rebuild);
        updateActivityTaskProgress();
      }
    }));
    eventIDList.push(useNetData("info_activity_data", data => {
      for (const activityInfo of data) {
        if (activityInfo.activity_id == activityID()) {
          const reward = JSON.parse(activityInfo.extra_information);
          if (typeof reward.activity_end_time == "number") {
            setTaskEndTime(reward.activity_end_time);
          }
        }
      }
    }));
    eventIDList.push(useNetData("custom_activity_data", data => {
      setActivityProgress(data?.[activityID()]?.progress ?? 0);
    }, Players.GetLocalPlayer()));
    eventIDList.push(useNetData("activity_task_progresses", data => {
      updateActivityTaskProgress(data);
    }, Players.GetLocalPlayer()));
    libs.onCleanup(() => {
      eventIDList.forEach(id => GameEvents.Unsubscribe(id));
    });
  });
  return libs.createComponent(BasePopup, {
    get PopupID() {
      return local.PopupID;
    },
    className: "ActivityTask",
    size: "large",
    get title() {
      return "#ActivityTaskTitle_" + activityID();
    },
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "TopContainer",
        height: "50px",
        width: "100%",
        get children() {
          return [libs.createComponent(EOM_Countdown.EOM_Countdown, {
            text: "#ActivityTaskCountDown_1",
            get endTime() {
              return taskEndTime();
            }
          }), libs.createComponent(libs.Switch, {
            get children() {
              return [libs.createComponent(libs.Match, {
                get when() {
                  return props.activity_id == 10001;
                },
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("ActivityTaskInfo", "Activity_" + props.activity_id, $.Language().toLowerCase());
                    },
                    get children() {
                      return [libs.createComponent(EOM_Image.EOM_Image, {
                        width: "46px",
                        height: "46px",
                        get backgroundImage() {
                          return getImagePath("store/new/currency_icon_bg.png");
                        },
                        get children() {
                          return libs.createComponent(ProductImage.ProductImage, {
                            width: "46px",
                            height: "46px",
                            itemid: 1100019
                          });
                        }
                      }), libs.createComponent(GenericPanel.CLabel, {
                        text: "#Activity_SummerCarnivalProgress",
                        get dialogVariables() {
                          return {
                            count: activityProgress(),
                            max: 100
                          };
                        }
                      })];
                    }
                  });
                }
              }), libs.createComponent(libs.Match, {
                get when() {
                  return props.activity_id == 10002;
                },
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("ActivityTaskInfo", "Activity_" + props.activity_id, $.Language().toLowerCase());
                    },
                    get children() {
                      return [libs.createComponent(EOM_Image.EOM_Image, {
                        width: "46px",
                        height: "46px",
                        get backgroundImage() {
                          return getImagePath("store/new/currency_icon_bg.png");
                        },
                        get children() {
                          return libs.createComponent(ProductImage.ProductImage, {
                            width: "46px",
                            height: "46px",
                            itemid: 1100020
                          });
                        }
                      }), libs.createComponent(GenericPanel.CLabel, {
                        text: "#Activity_QIXiCarnivalProgress",
                        get dialogVariables() {
                          return {
                            count: activityProgress(),
                            max: 100
                          };
                        }
                      })];
                    }
                  });
                }
              }), libs.createComponent(libs.Match, {
                get when() {
                  return props.activity_id == 10003;
                },
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("ActivityTaskInfo", "Activity_" + props.activity_id, $.Language().toLowerCase());
                    },
                    get children() {
                      return [libs.createComponent(EOM_Image.EOM_Image, {
                        width: "46px",
                        height: "46px",
                        get backgroundImage() {
                          return getImagePath("store/new/currency_icon_bg.png");
                        },
                        get children() {
                          return libs.createComponent(ProductImage.ProductImage, {
                            width: "46px",
                            height: "46px",
                            itemid: 1100023
                          });
                        }
                      }), libs.createComponent(GenericPanel.CLabel, {
                        text: "#Activity_QIXiCarnivalProgress",
                        get dialogVariables() {
                          return {
                            count: activityProgress(),
                            max: 100
                          };
                        }
                      })];
                    }
                  });
                }
              }), libs.createComponent(libs.Match, {
                get when() {
                  return props.activity_id == 10004;
                },
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("ActivityTaskInfo", "Activity_" + props.activity_id, $.Language().toLowerCase());
                    },
                    get children() {
                      return [libs.createComponent(EOM_Image.EOM_Image, {
                        width: "46px",
                        height: "46px",
                        get backgroundImage() {
                          return getImagePath("store/new/currency_icon_bg.png");
                        },
                        get children() {
                          return libs.createComponent(ProductImage.ProductImage, {
                            width: "46px",
                            height: "46px",
                            itemid: 1100030
                          });
                        }
                      }), libs.createComponent(GenericPanel.CLabel, {
                        text: "#Activity_QIXiCarnivalProgress",
                        get dialogVariables() {
                          return {
                            count: activityProgress(),
                            max: 100
                          };
                        }
                      })];
                    }
                  });
                }
              }), libs.createComponent(libs.Match, {
                get when() {
                  return props.activity_id == 10005;
                },
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("ActivityTaskInfo", "Activity_" + props.activity_id, $.Language().toLowerCase());
                    },
                    get children() {
                      return [libs.createComponent(EOM_Image.EOM_Image, {
                        width: "46px",
                        height: "46px",
                        get backgroundImage() {
                          return getImagePath("store/new/currency_icon_bg.png");
                        },
                        get children() {
                          return libs.createComponent(ProductImage.ProductImage, {
                            width: "46px",
                            height: "46px",
                            itemid: 1100035
                          });
                        }
                      }), libs.createComponent(GenericPanel.CLabel, {
                        text: "#Activity_QIXiCarnivalProgress",
                        get dialogVariables() {
                          return {
                            count: activityProgress(),
                            max: 180
                          };
                        }
                      })];
                    }
                  });
                }
              })];
            }
          })];
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "TaskList",
        scroll: "y",
        horizontalAlign: "center",
        height: "670px",
        padding: "0px 20px",
        margin: "0 20px",
        flowChildren: "down",
        get children() {
          return libs.createComponent(libs.Index, {
            get each() {
              return taskData();
            },
            children: (data, index) => {
              return libs.createComponent(TaskRow$1, {
                get taskData() {
                  return data();
                },
                get time() {
                  return time();
                },
                get activity_id() {
                  return activityID();
                },
                get task_limited() {
                  return taskLimited();
                }
              });
            }
          });
        }
      })];
    }
  });
};
const TaskRow$1 = props => {
  const rewardList = () => {
    return props.taskData.reward[0];
  };
  return (() => {
    const _el$ = libs.createElement("Panel", {}, null),
      _el$2 = libs.createElement("Panel", {}, _el$);
    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
      marginLeft: "20px",
      verticalAlign: "center",
      flowChildren: "down",
      get children() {
        return [libs.createComponent(GenericPanel.CLabel, {
          className: "TaskTitle",
          get text() {
            return "#activitytask_" + props.taskData.task_id;
          }
        }), libs.createComponent(GenericPanel.CLabel, {
          className: "TaskDesc",
          get text() {
            return "#activitytask_" + props.taskData.task_id + "_Desc";
          },
          get vars() {
            return {
              value: props.taskData.target
            };
          }
        })];
      }
    }), _el$2);
    libs.setProp(_el$2, "className", "Divder");
    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
      flowChildren: "right",
      verticalAlign: "center",
      get children() {
        return libs.createComponent(libs.Index, {
          get each() {
            return Object.keys(rewardList());
          },
          children: (rewardName, index) => {
            return libs.createComponent(EOM_Panel.EOM_Panel, {
              get children() {
                return [libs.createComponent(EOM_Image.EOM_Image, {
                  width: "46px",
                  height: "46px",
                  get backgroundImage() {
                    return getImagePath("store/new/currency_icon_bg.png");
                  },
                  get children() {
                    return libs.createComponent(ProductImage.ProductImage, {
                      width: "46px",
                      height: "46px",
                      get itemid() {
                        return rewardName();
                      }
                    });
                  }
                }), (() => {
                  const _el$3 = libs.createElement("Panel", {
                    hittest: false
                  }, null);
                  libs.setProp(_el$3, "className", "RewardCount");
                  libs.insert(_el$3, libs.createComponent(GenericPanel.CLabel, {
                    get text() {
                      return rewardList()[rewardName()];
                    }
                  }));
                  return _el$3;
                })()];
              }
            });
          }
        });
      }
    }), null);
    libs.insert(_el$, libs.createComponent(libs.Switch, {
      get children() {
        return [libs.createComponent(libs.Match, {
          get when() {
            return props.time > props.taskData.end_time;
          },
          get children() {
            return libs.createComponent(GenericPanel.CLabel, {
              className: "TaskFinish",
              html: true,
              text: "#TaskFinish"
            });
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return (props.taskData.receive_progress ?? 0) == 1;
          },
          get children() {
            return libs.createComponent(GenericPanel.CImage, {
              className: "RewardActionImage"
            });
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return props.task_limited;
          },
          get children() {
            return libs.createComponent(GenericPanel.CLabel, {
              className: "RewardActionLabel",
              html: true,
              text: "#activity_task_reward_limit_day"
            });
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return props.taskData.progress >= props.taskData.target;
          },
          get children() {
            return libs.createComponent(EOM_Button.EOM_Button, {
              className: "RewardAction",
              color: "Gold",
              text: "#activity_action_receive",
              onactivate: () => {
                if (props.taskData.unique_task_id) {
                  receiveTaskReward(props.activity_id, props.taskData.task_id, props.taskData.unique_task_id);
                }
              }
            });
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return (props.taskData.receive_progress ?? 0) == 0;
          },
          get children() {
            return libs.createComponent(GenericPanel.CLabel, {
              className: "RewardActionLabel",
              html: true,
              get vars() {
                return {
                  value: props.taskData.progress ?? 0,
                  max: props.taskData.target
                };
              },
              text: "#RewardProgress"
            });
          }
        })];
      }
    }), null);
    libs.effect(_$p => libs.setProp(_el$, "className", libs.classNames("TaskRow", {
      Receive: (props.taskData.receive_progress ?? 0) > 0,
      Complete: false,
      Expire: false
    }), _$p));
    return _el$;
  })();
};

const Popup_ActivityTutu = props => {
  const [local, others] = libs.splitProps(props, ["PopupID", "group", "activity_id", "title"]);
  let activityID = local.activity_id ?? 6006;
  let activityTitle = local.title ?? "Activity_tutu2";
  const [activityCollection, setActivityCollection] = libs.createSignal({});
  const [rewardInfoList, setRewardInfoList] = libs.createSignal([]);
  const [progress, setProgress] = libs.createSignal(0);
  const [selectedID, setSelectedID] = libs.createSignal(0);
  let inited = false;
  libs.createEffect(() => {
    let index = 0;
    const current_activityCollection = activityCollection();
    if (current_activityCollection) {
      const sortList = Object.keys(current_activityCollection).sort((a, b) => Number(b) - Number(a));
      for (const id of sortList) {
        const state = current_activityCollection[id];
        if (state != undefined && state == 2) {
          index = Number(id);
          inited = true;
          break;
        }
      }
    }
    if (!inited) {
      setSelectedID(index);
    }
  });
  const selectedReward = () => {
    let data;
    const current_selectedID = selectedID();
    const current_rewardInfoList = rewardInfoList();
    if (current_rewardInfoList[current_selectedID]) {
      data = current_rewardInfoList[current_selectedID].rewards[0];
    }
    return data;
  };
  libs.onMount(() => {
    let gameEventIDList = [];
    gameEventIDList.push(useNetData("open_box_activity_data", data => {
      if (data[activityID]) {
        if (data[activityID]?.rewards != undefined) {
          setActivityCollection(data[activityID].rewards);
        }
        setProgress(data[activityID]?.progress ?? 0);
      }
    }, Players.GetLocalPlayer()));
    gameEventIDList.push(useNetData("info_activity_data", data => {
      for (const activityInfo of data) {
        if (activityInfo.activity_id == activityID) {
          const reward = JSON.parse(activityInfo.extra_information);
          setRewardInfoList(reward.rewards);
        }
      }
    }));
    libs.onCleanup(() => {
      gameEventIDList.forEach(id => GameEvents.Unsubscribe(id));
    });
  });
  const progressBarInfo = libs.createMemo(() => {
    let arr = [];
    for (let index = 0; index < rewardInfoList().length; index++) {
      const currentInfo = rewardInfoList()[index];
      if (index == 0) {
        arr[index] = {
          start: 0,
          end: currentInfo.threshold
        };
        continue;
      }
      const lastInfo = rewardInfoList()[index - 1];
      arr[index] = {
        start: lastInfo.threshold,
        end: currentInfo.threshold
      };
    }
    return arr;
  });
  const CHANCE_UP_LIST = [15, 30, 50, 120, 180, 300, 450];
  const receiveReward = rid => {
    callAction("activity_receive", {
      reward_id: rid,
      activity_id: activityID
    });
  };
  return libs.createComponent(BasePopup, {
    className: "Popup_ActivityTutu",
    get PopupID() {
      return local.PopupID;
    },
    size: "large",
    get group() {
      return local.group;
    },
    title: "#" + activityTitle,
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "MainContainer",
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "Title",
            flowChildren: "right",
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                "class": "BG",
                id: "BGLeft"
              }), libs.createComponent(EOM_Label.EOM_Label, {
                text: "#mail_reward"
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                "class": "BG",
                id: "BGRight"
              })];
            }
          }), libs.createComponent(GenericPanel.CLabel, {
            id: "Stack",
            text: "#Activity_Tutu_stacktotal",
            get dialogVariables() {
              return {
                count: progress()
              };
            }
          }), libs.createComponent(libs.Show, {
            get when() {
              return selectedReward() != undefined;
            },
            get children() {
              return libs.createComponent(ProductItem.ProductItem, {
                get itemid() {
                  return selectedReward().item_id;
                },
                get count() {
                  return selectedReward()?.amounts;
                },
                get rarity() {
                  return selectedReward()?.rarity;
                }
              });
            }
          })];
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "BottomContainer",
        scroll: "x",
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "ProgressBars",
            get children() {
              return libs.createComponent(libs.Index, {
                get each() {
                  return progressBarInfo();
                },
                children: (info, index) => {
                  const percentage = () => {
                    return Round(Clamp((progress() - info().start) / Math.max(1, info().end - info().start), 0, 1) * 100);
                  };
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "ProgressBar",
                    get tooltip() {
                      return `${progress()} / ${info().end}`;
                    },
                    get children() {
                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "ProgressBarBG",
                        get children() {
                          return libs.createComponent(EOM_Panel.EOM_Panel, {
                            id: "ProgressBarUp",
                            get width() {
                              return `${percentage()}%`;
                            }
                          });
                        }
                      });
                    }
                  });
                }
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "Targets",
            get children() {
              return libs.createComponent(libs.Index, {
                get each() {
                  return progressBarInfo();
                },
                children: (info, index) => {
                  const state = () => {
                    return activityCollection()?.[(index + 1).toString()] ?? 2;
                  };
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "Target",
                    get className() {
                      return libs.classNames({
                        locked: state() == 2,
                        Received: state() == 1
                      });
                    },
                    get children() {
                      return libs.createComponent(GenericPanel.CLabel, {
                        get text() {
                          return `${info().end}`;
                        }
                      });
                    }
                  });
                }
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "Rewards",
            get children() {
              return libs.createComponent(libs.Index, {
                get each() {
                  return rewardInfoList();
                },
                children: (info, index) => {
                  const itemData = () => {
                    return info().rewards[0];
                  };
                  const state = () => {
                    return activityCollection()[info().reward_id.toString()] ?? 2;
                  };
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("MiniReawrd", {
                        Selected: selectedID() == index,
                        Receivable: state() == 0,
                        Received: state() == 1
                      });
                    },
                    onactivate: () => {
                      setSelectedID(index);
                      if (state() == 0) {
                        receiveReward(info().reward_id);
                      }
                    },
                    get children() {
                      return [libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "SeletedBG"
                      }), libs.createComponent(ProductImage.ProductImage, {
                        get itemid() {
                          return itemData().item_id;
                        }
                      }), libs.createComponent(libs.Show, {
                        get when() {
                          return libs.memo(() => !!itemData().amounts)() && itemData().amounts > 1;
                        },
                        get children() {
                          return libs.createComponent(GenericPanel.CLabel, {
                            className: "ProductCount",
                            get text() {
                              return "" + itemData().amounts;
                            },
                            hittest: false
                          });
                        }
                      }), libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "ReceivableBG",
                        hittest: false
                      })];
                    }
                  });
                }
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "Extra",
            get children() {
              return libs.createComponent(libs.Index, {
                get each() {
                  return progressBarInfo();
                },
                children: (info, index) => {
                  return libs.createComponent(libs.Show, {
                    get when() {
                      return CHANCE_UP_LIST.includes(info().end);
                    },
                    get children() {
                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "ChanceUp",
                        x: `${150 * index}px`,
                        get children() {
                          return libs.createComponent(GenericPanel.CLabel, {
                            text: "#Activity_Tutu_chanceuptip"
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
      })];
    }
  });
};

const Popup_ArenaSettlement = props => {
  const [local, others] = libs.splitProps(props, ["PopupID", "group"]);
  const [rewardList, setRewardList] = libs.createSignal([]);
  libs.onMount(() => {
    const eventIDList = [];
    const netTableListenerIDs = [];
    eventIDList.push(useNetData("arene_settlement", data => {
      setRewardList(data.reward);
    }, Players.GetLocalPlayer()));
    libs.onCleanup(() => {
      eventIDList.forEach(id => GameEvents.Unsubscribe(id));
      netTableListenerIDs.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    });
  });
  return (() => {
    const _el$ = libs.createElement("Button", {
      get id() {
        return local.PopupID;
      }
    }, null);
    libs.setProp(_el$, "className", "ArenaSettlement");
    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
      id: "ArenaSettlementWrap",
      get children() {
        return [libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "ArenaSettlementTitle",
          get children() {
            return libs.createComponent(GenericPanel.CLabel, {
              text: "#Activity_arena_settlement"
            });
          }
        }), libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "TitleUnderline"
        }), libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "ArenaRewardList",
          scroll: "x",
          get children() {
            return libs.createComponent(libs.Index, {
              get each() {
                return rewardList();
              },
              children: (data, i) => {
                return (() => {
                  const _el$2 = libs.createElement("Panel", {}, null),
                    _el$3 = libs.createElement("Image", {}, _el$2);
                  libs.setProp(_el$3, "className", "ItemRarityBG");
                  libs.insert(_el$2, libs.createComponent(CosmeticCard.CosmeticImage, {
                    get itemid() {
                      return data().itemId.toString();
                    }
                  }), null);
                  libs.insert(_el$2, libs.createComponent(ProductImage.ProductImage, {
                    get itemid() {
                      return data().itemId.toString();
                    },
                    get count() {
                      return data().amounts;
                    }
                  }), null);
                  libs.effect(_$p => libs.setProp(_el$2, "className", libs.classNames("ArenaReward", "Rarity" + data().rarity), _$p));
                  return _el$2;
                })();
              }
            });
          }
        }), libs.createComponent(EOM_Button.EOM_Button, {
          align: "center bottom",
          marginBottom: "96px",
          color: "Blue",
          text: "#Popup_Button_Confirm",
          onactivate: () => {
            closePopup(local.PopupID);
            GameEvents.SendCustomEventToServer("confirm_arena_reward", {});
          }
        })];
      }
    }));
    libs.effect(_$p => libs.setProp(_el$, "id", local.PopupID, _$p));
    return _el$;
  })();
};

const Popup_BackpackItem = props => {
  const [local, other] = libs.splitProps(props, ["id", "num", "expire_time", "quality", "usenum", "weight", "uid", "price", "sell_token", "direct", "type", "jump", "pool", "hero_ids"]);
  const {
    PopupID
  } = other;
  const group = "backpack_item_" + local.uid;
  const desc = () => {
    let description = $.Localize("#" + local.id + "_description");
    let items = [];
    if (items.length >= 1) {
      let bundle = "<br><br>" + $.Localize("#StoreItem_BundleInfo");
      for (const itemInfo of items) {
        bundle += "<br>" + $.Localize("#" + itemInfo.item_id) + " x " + itemInfo.amounts;
      }
      description += bundle;
    }
    return description;
  };
  const [num, setNum] = libs.createSignal(1);
  const price = () => {
    return num() * (local.price ?? 0);
  };
  const max = () => {
    if (local.usenum == 0) return local.num;
    return local.usenum;
  };
  const min = () => {
    if (max() == 0) return 0;
    return 1;
  };
  const canUse = () => {
    return local.type == 2 || local.jump != undefined || local.direct == 1 || local.id == 2000098 || local.type == 3;
  };
  const sellTypeIcon = () => getPayTypeIconPath(local.sell_token ?? 0);
  return libs.createComponent(BasePopup, {
    PopupID: PopupID,
    group: group,
    title: "#Popup_BackpackItem_title",
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        horizontalAlign: "right",
        flowChildren: "right",
        marginTop: "10px",
        marginRight: "40px",
        get children() {
          return [libs.createComponent(Player.PlayerCurrency, {
            type: "moonstone"
          }), libs.createComponent(libs.Show, {
            get when() {
              return local.sell_token;
            },
            get children() {
              return libs.createComponent(Player.PlayerCurrency, {
                type: "token",
                get tokenID() {
                  return local.sell_token;
                }
              });
            }
          })];
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        width: "90%",
        flowChildren: "right",
        marginTop: "20px",
        horizontalAlign: "center",
        get children() {
          return [libs.createComponent(backpack_item.BackpackItem, local), libs.createComponent(EOM_Panel.EOM_Panel, {
            flowChildren: "down",
            width: "100%",
            marginLeft: "40px",
            get children() {
              return [libs.createComponent(EOM_Label.EOM_Label, {
                html: true,
                height: "170px",
                get text() {
                  return desc();
                },
                color: "white"
              }), libs.createComponent(EOM_Separator.EOM_Separator, {
                direction: "horizontal"
              }), libs.createComponent(libs.Show, {
                get when() {
                  return canUse() || price() > 0;
                },
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    marginTop: "20px",
                    flowChildren: "right",
                    get children() {
                      return [libs.createComponent(EOM_Panel.EOM_Panel, {
                        flowChildren: "down",
                        width: "200px",
                        get children() {
                          return libs.createComponent(EOM_Label.EOM_Label, {
                            color: "white",
                            verticalAlign: "center",
                            fontSize: "18px",
                            get text() {
                              return $.Localize("#has_num") + local.num;
                            }
                          });
                        }
                      }), libs.createComponent(EOM_Panel.EOM_Panel, {
                        flowChildren: "down",
                        width: "200px",
                        get children() {
                          return [libs.createComponent(EOM_Label.EOM_Label, {
                            fontSize: "18px",
                            verticalAlign: "center",
                            text: "#use_count",
                            color: "white"
                          }), libs.createComponent(EOM_NumberAdjust.EOM_NumberAdjust, {
                            get value() {
                              return num();
                            },
                            verticalAlign: "center",
                            marginLeft: "10px",
                            onvaluechanged: self => {
                              setNum(self.value);
                            },
                            get max() {
                              return max();
                            },
                            get min() {
                              return min();
                            }
                          })];
                        }
                      })];
                    }
                  });
                }
              })];
            }
          })];
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        width: "fit-children",
        flowChildren: "right",
        horizontalAlign: "center",
        marginTop: "60px",
        get children() {
          return [libs.createComponent(libs.Show, {
            get when() {
              return price() > 0;
            },
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "sell",
                marginRight: "40px",
                onactivate: () => {
                  if (local.price && local.price > 0) {
                    callAction("sell_prop", {
                      id: local.uid,
                      amounts: num(),
                      prop_id: local.id
                    });
                  }
                  closePopup(other.PopupID);
                },
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    verticalAlign: "center",
                    flowChildren: "right",
                    get children() {
                      return [libs.createComponent(EOM_Image.EOM_Image, {
                        get src() {
                          return sellTypeIcon();
                        },
                        width: "50px",
                        height: "50px",
                        verticalAlign: "center"
                      }), libs.createComponent(EOM_Label.EOM_Label, {
                        marginLeft: "0px",
                        get text() {
                          return price();
                        }
                      })];
                    }
                  }), libs.createComponent(EOM_Label.EOM_Label, {
                    horizontalAlign: "right",
                    marginRight: "20px",
                    text: "#sell"
                  })];
                }
              });
            }
          }), libs.createComponent(libs.Show, {
            get when() {
              return canUse();
            },
            get children() {
              return libs.createComponent(EOM_Button.EOM_Button, {
                enabled: true,
                horizontalAlign: "right",
                color: "Gold",
                text: "#use",
                onactivate: () => {
                  if (local.id == 2000098) {
                    serverRequest("box_open", {
                      bid: 2000098,
                      pool: 93000001,
                      amounts: num()
                    }, data => {
                      if (data.status == 0 && data?.data != undefined) {
                        clientSideEvent("active_draw_box", data.data);
                        GameEvents.SendEventClientSide("custom_ui_toggle_windows", {
                          window_name: "MenuButton_active_star",
                          state: 1
                        });
                      } else {
                        console.log("fail");
                      }
                    });
                  } else if (local.type == 3 && local.hero_ids) {
                    showPopup("UniversalHeroCard", {
                      hero_ids: local.hero_ids,
                      prop_id: local.id,
                      uid: local.uid
                    });
                  } else if (local.direct && local.direct == 1) {
                    callAction("use_prop", {
                      id: local.uid,
                      amounts: num(),
                      prop_id: local.id,
                      params: []
                    });
                  } else if (local.jump) {
                    if (local.jump == "draw") {
                      clientSideEvent("switchDrawPool", {
                        pid: local.pool
                      });
                    } else if (local.jump == "activity") {
                      clientSideEvent("switchActivityTag", {
                        id: local.pool
                      });
                    } else if (local.jump == "cosmetics") {
                      clientSideEvent("cosmetic_jump_tag", {
                        type: local.pool
                      });
                    }
                    ToggleWindows('MenuButton_' + local.jump, true);
                  }
                  closePopup(other.PopupID);
                }
              });
            }
          })];
        }
      })];
    }
  });
};
const Popup_BackpackItemUse = props => {
  const {
    PopupID,
    group,
    id
  } = props;
  const [selectedData, setSelectedData] = libs.createSignal();
  const [usingID, setUsingID] = libs.createSignal();
  const [num, setNum] = libs.createSignal(1);
  const [playerHero, setPlayerHero] = libs.createSignal();
  const [playerOrnament, setPlayerOrnament] = libs.createSignal();
  const sortedSelectionList = libs.createMemo(() => {
    if (selectedData() && selectedData().param) {
      return selectedData().param.sort((a, b) => Number(isOwner(a.item_id)) - Number(isOwner(b.item_id)));
    }
    return [];
  });
  let now = Math.floor(Date.now() / 1000);
  const updateItemData = () => {
    const info_prop = getNetDataCache("info_prop");
    const data = getNetDataCache("player_props", Players.GetLocalPlayer());
    if (info_prop) {
      const redata = {
        prop_id: id,
        amounts: 0,
        type: "all",
        param: []
      };
      let _info = info_prop[id.toString()];
      if (_info) {
        let _param = JSON.parseSafe(_info.param);
        if (Object.keys(_param).length > 0) {
          let s1 = finiteNumber(Number(_param.type), -1);
          if (s1 != -1) {
            if (_param.type.length == 7 && (_param.type.startsWith("300") || _param.type.startsWith("5"))) {
              redata.param = [{
                item_id: _param.type,
                amounts: 1
              }];
            }
          } else {
            redata.type = _param.type;
          }
          if (_param.hero_ids && _param.hero_ids.length > 0) {
            redata.param = redata.param.concat(_param.hero_ids.map(v => ({
              item_id: v.toString(),
              amounts: 1
            })));
          }
          if (_param.items) {
            if (_info.type == 5 && _param.type) {
              if (_param.type == "any") {
                redata.param = _param.items.map(v => ({
                  item_id: v.toString(),
                  amounts: 1
                }));
              } else {
                redata.param = [{
                  item_id: _param.type.toString(),
                  amounts: 1
                }];
              }
            } else {
              if (Object.keys(_param.items).length > 0) {
                redata.param = redata.param.concat(Object.entries(_param.items).map(([item_id, amounts], index) => {
                  return {
                    item_id,
                    amounts
                  };
                }));
              }
            }
          }
          if (redata.param.length > 0) {
            setPreviewID(Number(redata.param[0].item_id));
          }
        }
        let _price = JSON.parseSafe(_info.price);
        if (Object.keys(_price).length > 0) {
          let value = Object.entries(_price);
          redata.priceID = value[0][0];
          redata.price = value[0][1];
        }
      }
      if (data) {
        let filteredData = Object.values(data).find(v => {
          if (v.expire_time && v.expire_time <= now || v.amounts <= 0) return false;
          return v.prop_id == id;
        });
        if (filteredData) {
          redata.id = filteredData.id;
          redata.amounts = filteredData.amounts;
          redata.expire_time = filteredData.expire_time;
        }
      }
      setSelectedData(redata);
    }
  };
  libs.onMount(() => {
    const eventIdList = [];
    const netTableIdList = [];
    eventIdList.push(useNetData("info_prop", () => {
      updateItemData();
    }));
    eventIdList.push(useNetData("player_props", () => {
      updateItemData();
    }, Players.GetLocalPlayer()));
    eventIdList.push(useNetData("player_hero", data => {
      setPlayerHero(data);
    }, Players.GetLocalPlayer()));
    eventIdList.push(useNetData("player_ornament", data => {
      setPlayerOrnament(data);
    }, Players.GetLocalPlayer()));
    libs.onCleanup(() => {
      eventIdList.forEach(id => GameEvents.Unsubscribe(id));
      netTableIdList.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    });
  });
  const [previewID, setPreviewID] = libs.createSignal(-1);
  const isOwner = itemID => {
    if (itemID.startsWith("300")) {
      const player_hero = playerHero();
      if (player_hero && player_hero[itemID] && player_hero[itemID].Permanent == 1) {
        return true;
      }
    } else if (KeyValues.CosmeticsKv[itemID]) {
      const player_ornament = playerOrnament();
      if (player_ornament && player_ornament[itemID] && player_ornament[itemID].permanent == 1) {
        return true;
      }
    }
    return false;
  };
  const maxValue = () => {
    if (selectedData() == undefined) {
      return 1;
    }
    if (usingID() != undefined && KeyValues.CosmeticsKv[usingID()] == undefined) {
      return selectedData()?.amounts ?? 0;
    }
    if (selectedData().type == "any" && selectedData().param.length > 1) {
      return 1;
    }
    return selectedData().amounts ?? 0;
  };
  const buttonEnable = () => {
    if (selectedData() == undefined) {
      return false;
    }
    if (selectedData().type == "any" && selectedData().param.length > 1) {
      if (usingID() == undefined || !Object.values(selectedData().param).some(v => v.item_id == usingID().toString())) {
        return false;
      }
      if (isOwner(usingID().toString())) {
        return false;
      }
      if (num() > maxValue() || num() > selectedData().amounts) {
        return false;
      }
    } else if (num() > selectedData().amounts) {
      return false;
    }
    const kv = KeyValues.BackpackKv[selectedData().prop_id];
    if (!(kv && kv.direct == 1 && selectedData().id != undefined)) {
      return false;
    }
    return true;
  };
  const previewIDSwtiched = () => {
    if (previewID().toString().startsWith("300")) {
      let heroName = GetHeroNameByGoodID(Number(previewID()));
      if (heroName) {
        return heroName;
      }
    }
    return previewID();
  };
  const isHero = () => {
    return previewIDSwtiched() != previewID();
  };
  return libs.createComponent(BasePopup, {
    className: "Popup_BackpackItemUse",
    PopupID: PopupID,
    group: group,
    title: "#Popup_BackpackItem_title",
    size: "large",
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "LeftPreview",
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "Preview3D",
            get children() {
              return [libs.createComponent(libs.Show, {
                get when() {
                  return libs.memo(() => selectedData() != undefined)() && (selectedData().expire_time ?? 0) > 0;
                },
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    get classList() {
                      return {
                        StoreCountdown: true,
                        LowTime: now > (selectedData().expire_time ?? 0) - 24 * 60 * 60,
                        [$.Language().toLowerCase()]: true
                      };
                    },
                    get children() {
                      return [(() => {
                        const _el$ = libs.createElement("Image", {}, null);
                        libs.setProp(_el$, "className", "CountDownIcon");
                        return _el$;
                      })(), libs.createComponent(EOM_Countdown.EOM_Countdown, {
                        get endTime() {
                          return Number(selectedData().expire_time ?? 0);
                        }
                      })];
                    }
                  });
                }
              }), libs.createComponent(libs.Switch, {
                get children() {
                  return [libs.createComponent(libs.Match, {
                    get when() {
                      return isHero();
                    },
                    get children() {
                      return libs.createComponent(EOM_PortraitFullBody.EOM_PortraitFullBody, {
                        align: "center center",
                        width: "100%",
                        height: "100%",
                        get unitname() {
                          return previewIDSwtiched().toString();
                        }
                      });
                    }
                  }), libs.createComponent(libs.Match, {
                    get when() {
                      return KeyValues.CosmeticsKv[previewID()] != undefined;
                    },
                    get children() {
                      return libs.createComponent(CosmeticPreview.CosmeticPreview, {
                        get cosmetic_id() {
                          return previewID();
                        },
                        showPedestal: true,
                        showCourierPedestal: true
                      });
                    }
                  }), libs.createComponent(libs.Match, {
                    get when() {
                      return KeyValues.CosmeticsKv[previewID()] == undefined;
                    },
                    get children() {
                      return [libs.createComponent(CosmeticCard.CosmeticImage, {
                        className: "CosmeticPreviewImage",
                        get itemid() {
                          return previewID().toString();
                        }
                      }), libs.createComponent(ProductImage.ProductImage, {
                        className: "CosmeticPreviewImage",
                        get itemid() {
                          return previewID();
                        }
                      })];
                    }
                  })];
                }
              })];
            }
          }), libs.createComponent(libs.Show, {
            get when() {
              return previewID() != -1;
            },
            get children() {
              const _el$2 = libs.createElement("Panel", {
                id: "CosmeticDesc"
              }, null);
              libs.insert(_el$2, libs.createComponent(GenericPanel.CLabel, {
                id: "CosmeticName",
                get text() {
                  return '#' + previewIDSwtiched();
                }
              }), null);
              libs.insert(_el$2, libs.createComponent(EOM_Separator.EOM_Separator, {
                size: "short"
              }), null);
              libs.insert(_el$2, libs.createComponent(GenericPanel.CLabel, {
                id: "CosmeticAccess",
                get text() {
                  return GetCosmeticAccessDescription(previewID());
                }
              }), null);
              return _el$2;
            }
          })];
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "RightUse",
        get children() {
          return libs.createComponent(libs.Show, {
            get when() {
              return selectedData() != undefined;
            },
            get children() {
              const _el$3 = libs.createElement("Panel", {
                  id: "ExchangeList"
                }, null),
                _el$4 = libs.createElement("Panel", {
                  id: "ExchangeContent"
                }, _el$3),
                _el$5 = libs.createElement("Image", {
                  id: "Divider"
                }, _el$4);
              libs.setProp(_el$3, "onactivate", () => {});
              libs.insert(_el$3, libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "ExchangeListTitle",
                get children() {
                  return libs.createComponent(GenericPanel.CLabel, {
                    id: "ExchangeListTitleLabel",
                    get text() {
                      return "#" + selectedData().prop_id;
                    }
                  });
                }
              }), _el$4);
              libs.insert(_el$4, libs.createComponent(GenericPanel.CLabel, {
                id: "PackDesc",
                get text() {
                  return "#" + selectedData().prop_id + "_description";
                }
              }), _el$5);
              libs.insert(_el$4, libs.createComponent(EOM_Panel.EOM_Panel, {
                width: "100%",
                horizontalAlign: "center",
                get children() {
                  return [libs.createComponent(libs.Show, {
                    get when() {
                      return sortedSelectionList().length > 3;
                    },
                    get children() {
                      return libs.createComponent(EOM_Button.EOM_BaseButton, {
                        id: "ArrowLeft",
                        enabled: false
                      });
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "PackItemListContainer",
                    get children() {
                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "PackItemList",
                        flowChildren: "right",
                        scroll: "x",
                        get children() {
                          return libs.createComponent(libs.Index, {
                            get each() {
                              return sortedSelectionList();
                            },
                            children: (storeItem, index) => {
                              const rarity = libs.createMemo(() => {
                                if (storeItem() && KeyValues.CosmeticsKv[storeItem().item_id]) return KeyValues.CosmeticsKv[storeItem().item_id].rarity;
                                return 1;
                              });
                              const owned = libs.createMemo(() => {
                                return isOwner(storeItem().item_id);
                              });
                              return libs.createComponent(EOM_Panel.EOM_Panel, {
                                get className() {
                                  return libs.classNames("ExchangeItem", {
                                    CanPreview: previewID() != undefined,
                                    Previewing: previewID() != undefined && storeItem().item_id == (usingID() ?? -1).toString(),
                                    owned: owned()
                                  });
                                },
                                onactivate: () => {
                                  setPreviewID(Number(storeItem().item_id));
                                  setUsingID(Number(storeItem().item_id));
                                },
                                get children() {
                                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                                    id: "ProductItemContainer",
                                    get children() {
                                      return [libs.createComponent(ProductItem.ProductItem, {
                                        get itemid() {
                                          return storeItem().item_id;
                                        },
                                        get count() {
                                          return storeItem().amounts;
                                        },
                                        get rarity() {
                                          return rarity();
                                        }
                                      }), libs.createComponent(CosmeticCard.CosmeticImage, {
                                        get itemid() {
                                          return storeItem().item_id;
                                        },
                                        hittest: false,
                                        verticalAlign: "center"
                                      }), libs.createElement("Panel", {
                                        id: "HoverBorder",
                                        hittest: false
                                      }, null)];
                                    }
                                  }), libs.createComponent(libs.Show, {
                                    get when() {
                                      return owned();
                                    },
                                    get children() {
                                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                                        className: "Owned",
                                        hittest: false
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
                  }), libs.createComponent(libs.Show, {
                    get when() {
                      return sortedSelectionList().length > 3;
                    },
                    get children() {
                      return libs.createComponent(EOM_Button.EOM_BaseButton, {
                        id: "ArrowRight",
                        enabled: false
                      });
                    }
                  })];
                }
              }), null);
              libs.insert(_el$4, libs.createComponent(EOM_Panel.EOM_Panel, {
                flowChildren: "right",
                horizontalAlign: "center",
                marginTop: "50px",
                get children() {
                  return [libs.createComponent(GenericPanel.CLabel, {
                    className: "CostDescLabel",
                    get text() {
                      return $.Localize("#has_num") + selectedData().amounts;
                    }
                  }), libs.createComponent(EOM_Label.EOM_Label, {
                    marginLeft: "160px",
                    className: "CostDescLabel",
                    text: "#use_count"
                  }), libs.createComponent(EOM_NumberAdjust.EOM_NumberAdjust, {
                    verticalAlign: "center",
                    get value() {
                      return num();
                    },
                    get max() {
                      return maxValue();
                    },
                    min: 1,
                    onvaluechanged: self => {
                      setNum(self.value);
                    },
                    marginLeft: "18px"
                  })];
                }
              }), null);
              libs.insert(_el$4, libs.createComponent(EOM_Panel.EOM_Panel, {
                width: "fit-children",
                flowChildren: "right",
                horizontalAlign: "center",
                marginTop: "50px",
                get children() {
                  return [libs.createComponent(libs.Show, {
                    get when() {
                      return selectedData().price != undefined;
                    },
                    get children() {
                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "sell",
                        marginRight: "80px",
                        onactivate: () => {
                          let itemData = selectedData();
                          if (itemData && itemData.id != undefined && itemData.amounts >= num()) {
                            callAction("sell_prop", {
                              id: itemData.id,
                              amounts: num(),
                              prop_id: itemData.prop_id
                            });
                          }
                          closePopup(PopupID);
                        },
                        get children() {
                          return [libs.createComponent(EOM_Panel.EOM_Panel, {
                            verticalAlign: "center",
                            flowChildren: "right",
                            get children() {
                              return [libs.createComponent(EOM_Image.EOM_Image, {
                                get src() {
                                  return getTokenSrcPath(Number(selectedData().priceID));
                                },
                                width: "50px",
                                height: "50px",
                                marginRight: "6px",
                                verticalAlign: "center"
                              }), libs.createComponent(EOM_Label.EOM_Label, {
                                marginLeft: "-10px",
                                get text() {
                                  return (selectedData().price ?? 0) * num();
                                }
                              })];
                            }
                          }), libs.createComponent(EOM_Label.EOM_Label, {
                            horizontalAlign: "right",
                            marginRight: "20px",
                            text: "#sell"
                          })];
                        }
                      });
                    }
                  }), libs.createComponent(EOM_Button.EOM_Button, {
                    get enabled() {
                      return buttonEnable();
                    },
                    horizontalAlign: "right",
                    color: "Gold",
                    text: "#use",
                    onactivate: () => {
                      const kv = KeyValues.BackpackKv[selectedData().prop_id];
                      if (kv && kv.direct == 1 && selectedData().id != undefined) {
                        if (selectedData().amounts >= num()) {
                          let data = {
                            id: selectedData().id,
                            amounts: num(),
                            prop_id: selectedData().prop_id,
                            params: []
                          };
                          if (selectedData().type == "any") {
                            if (previewID() != -1) {
                              data.params.push(previewID().toString());
                              callAction("use_prop", data);
                            }
                          } else {
                            callAction("use_prop", data);
                          }
                          closePopup(PopupID);
                        }
                      }
                    }
                  })];
                }
              }), null);
              return _el$3;
            }
          });
        }
      })];
    }
  });
};

const bountyRuleTables = [{
  title: "#BaseRule",
  headers: ["#CurrentPoint", "#BountyFirst", "#BountySecond", "#BountyThird", "#BountyFourth", "#BountyFifth", "#BountySixth", "#BountySeventh", "#BountyEighth"],
  rows: [["0-400", "40", "32", "26", "20", "18", "15", "12", "8"], ["401-800", "40", "30", "24", "18", "10", "6", "-15", "-21"], ["801-1200", "40", "28", "20", "16", "-16", "-20", "-28", "-40"], ["1201+", "30", "20", "15", "10", "-22", "-28", "-36", "-55"]]
}, {
  title: "#DoubleRule",
  headers: ["#CurrentPoint", "#BountyFirst", "#BountySecond", "#BountyThird", "#BountyFourth"],
  rows: [["0-400", "40", "26", "15", "8"], ["401-800", "40", "24", "6", "-21"], ["801-1200", "40", "20", "-20", "-40"], ["1201+", "30", "15", "-28", "-55"]]
}];
const revenueRuleItems = [{
  title: "#RevenueRuleCostTitle",
  desc: "#RevenueRuleCostDesc"
}, {
  title: "#RevenueRulePoolTitle",
  desc: "#RevenueRulePoolDesc"
}, {
  title: "#RevenueRuleShareTitle",
  desc: "#RevenueRuleShareDesc"
}, {
  title: "#RevenueRuleBonusTitle",
  desc: "#RevenueRuleBonusDesc"
}, {
  title: "#RevenueRuleFormulaTitle",
  desc: "#RevenueRuleFormulaDesc"
}, {
  title: "#RevenueRuleFactorTitle",
  desc: "#RevenueRuleFactorDesc"
}];
const revenueRuleItemsDou = [{
  title: "#RevenueRuleCostTitle",
  desc: "#RevenueRuleCostDesc"
}, {
  title: "#RevenueRulePoolTitle",
  desc: "#RevenueRulePoolDesc"
}, {
  title: "#RevenueRuleShareTitle",
  desc: "#RevenueRuleShareDesc_Dou"
}, {
  title: "#RevenueRuleFormulaTitle",
  desc: "#RevenueRuleFormulaDesc_Dou"
}, {
  title: "#RevenueRuleFactorTitle",
  desc: "#RevenueRuleFactorDesc_Dou"
}];
const Popup_BountyCompetitionRule = props => {
  const table = () => bountyRuleTables[props.is_team ? 1 : 0];
  return libs.createComponent(BasePopup, {
    className: "Popup_BountyCompetitionRule",
    get PopupID() {
      return props.PopupID;
    },
    size: "large",
    title: "#RankRuleTitle",
    get children() {
      return libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "BountyRulePopupContent",
        flowChildren: "down",
        scroll: "y",
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "Part",
            flowChildren: "down",
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "TitleRow",
                flowChildren: "right",
                get children() {
                  return [libs.createComponent(EOM_Image.EOM_Image, {
                    className: "TextIcon"
                  }), libs.createComponent(GenericPanel.CLabel, {
                    text: "#RankRuleTitle"
                  })];
                }
              }), libs.createComponent(GenericPanel.CLabel, {
                className: "Content",
                get text() {
                  return props.is_team ? "#RankRule_Dou" : "#RankRule";
                }
              })];
            }
          }), libs.memo(() => (() => libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "RuleBlock",
            flowChildren: "down",
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "RuleTitleRow",
                flowChildren: "right",
                get children() {
                  return [libs.createComponent(EOM_Image.EOM_Image, {
                    className: "TextIcon"
                  }), libs.createComponent(GenericPanel.CLabel, {
                    get text() {
                      return table().title;
                    }
                  })];
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "RuleTable",
                flowChildren: "down",
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    className: "RuleTableRow Header",
                    flowChildren: "right",
                    get children() {
                      return libs.createComponent(libs.Index, {
                        get each() {
                          return table().headers;
                        },
                        children: (header, columnIndex) => libs.createComponent(GenericPanel.CLabel, {
                          get className() {
                            return libs.classNames("RuleCell", {
                              FirstCol: columnIndex == 0
                            });
                          },
                          get text() {
                            return header();
                          }
                        })
                      });
                    }
                  }), libs.createComponent(libs.Index, {
                    get each() {
                      return table().rows;
                    },
                    children: (row, rowIndex) => libs.createComponent(EOM_Panel.EOM_Panel, {
                      get className() {
                        return libs.classNames("RuleTableRow", rowIndex % 2 == 0 ? "Odd" : "Even");
                      },
                      flowChildren: "right",
                      get children() {
                        return libs.createComponent(libs.Index, {
                          get each() {
                            return row();
                          },
                          children: (cell, columnIndex) => libs.createComponent(GenericPanel.CLabel, {
                            get className() {
                              return libs.classNames("RuleCell", {
                                FirstCol: columnIndex == 0
                              });
                            },
                            get text() {
                              return cell();
                            }
                          })
                        });
                      }
                    })
                  })];
                }
              })];
            }
          }))()), libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "RuleBlock",
            flowChildren: "down",
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "RuleTitleRow",
                flowChildren: "right",
                get children() {
                  return [libs.createComponent(EOM_Image.EOM_Image, {
                    className: "TextIcon"
                  }), libs.createComponent(GenericPanel.CLabel, {
                    text: "#RevenueRuleTitle"
                  })];
                }
              }), libs.createComponent(GenericPanel.CLabel, {
                className: "Content",
                get text() {
                  return props.is_team ? "#RevenueRuleIntro_Dou" : "#RevenueRuleIntro";
                }
              }), libs.createComponent(libs.Index, {
                get each() {
                  return props.is_team ? revenueRuleItemsDou : revenueRuleItems;
                },
                children: item => {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    className: "RevenueItem",
                    flowChildren: "down",
                    get children() {
                      return [libs.createComponent(GenericPanel.CLabel, {
                        className: "RevenueItemTitle",
                        get text() {
                          return item().title;
                        }
                      }), libs.createComponent(GenericPanel.CLabel, {
                        className: "RevenueItemDesc",
                        get text() {
                          return item().desc;
                        }
                      })];
                    }
                  });
                }
              }), libs.createComponent(GenericPanel.CLabel, {
                className: "RevenueRuleFootnote",
                get text() {
                  return props.is_team ? "#RevenueRuleFootnote_Dou" : "#RevenueRuleFootnote";
                }
              })];
            }
          })];
        }
      });
    }
  });
};

const Popup_CloseRookie = props => {
  const [local, others] = libs.splitProps(props, ["PopupID", "group"]);
  return (libs.createComponent(BasePopup, {
      get PopupID() {
        return local.PopupID;
      },
      get group() {
        return local.group;
      },
      title: "#RookieTitle",
      size: "small",
      get children() {
        return [libs.createComponent(EOM_Panel.EOM_Panel, {
          height: '80%',
          width: '100%',
          get children() {
            return libs.createComponent(EOM_Label.EOM_Label, {
              color: "white",
              fontSize: "24px",
              html: true,
              align: 'center center',
              text: "#RookieCloseDesc"
            });
          }
        }), libs.createComponent(EOM_Panel.EOM_Panel, {
          align: 'center bottom',
          flowChildren: "right",
          get children() {
            return [libs.createComponent(EOM_Button.EOM_Button, {
              horizontalAlign: "right",
              color: "Red",
              text: "#RookieCloseFull",
              onactivate: () => {
                GameEvents.SendCustomEventToServer("PlayerSettingToggleBoolean", {
                  setting_name: "rookie",
                  value: "0"
                });
                closePopup(local.PopupID);
              }
            }), libs.createComponent(EOM_Button.EOM_Button, {
              horizontalAlign: "right",
              marginLeft: "100px",
              color: "Blue",
              text: "#RookieClose",
              onactivate: () => {
                clientSideEvent("rookie_close", {});
                closePopup(local.PopupID);
              }
            })];
          }
        })];
      }
    })
  );
};

const Popup_ColoringUnlock = props => {
  const playerOrnament = netdata_utils.createPlayerNetData("player_ornament", Players.GetLocalPlayer(), {});
  const isLock = () => {
    if (KeyValues.CosmeticsKv[props.cosmeticId] && KeyValues.CosmeticsKv[props.cosmeticId].coloring) {
      return playerOrnament()[KeyValues.CosmeticsKv[props.cosmeticId].coloring]?.permanent != 1;
    }
    return true;
  };
  const [infoColorConfig, setInfoColorConfig] = libs.createSignal();
  const [playerTokens, setPlayerTokens] = libs.createSignal({});
  const consumablesList = libs.createMemo(() => {
    let list = [];
    const current_infoColorConfig = infoColorConfig();
    if (current_infoColorConfig != undefined) {
      return Object.keys(current_infoColorConfig.consume);
    }
    return list;
  });
  const enabled = libs.createMemo(() => {
    let _enable = false;
    const current_playerTokens = playerTokens();
    const current_infoColorConfig = infoColorConfig();
    if (current_infoColorConfig != undefined) {
      _enable = true;
      for (const token_id in current_infoColorConfig.consume) {
        const needAmounts = finiteNumber(Number(current_infoColorConfig.consume[token_id]), -1);
        if (needAmounts < 0 || (current_playerTokens[token_id]?.num ?? 0) < needAmounts) {
          _enable = false;
        }
      }
    }
    return _enable;
  });
  const buyItem = () => {
    if (isLock()) {
      showPopup("ErrorMessage", {
        msg: "#cosmetic_origin_skin_locked"
      });
      return;
    }
    if (!enabled()) {
      closePopup(props.PopupID);
      showPopup("StoreBuyItemResult", {
        result: "failure",
        reason: "no_enough_token",
        group: String(props.cosmeticId)
      });
      return;
    }
    let PopupID = showPopup("StoreBuyItemResult", {
      result: "loading",
      group: String(props.cosmeticId)
    });
    serverRequest("unlock_color_skin", {
      oid: props.cosmeticId
    }, res => {
      if (res.status == 0) {
        closePopup(props.PopupID);
        showPopup("StoreBuyItemResult", {
          result: "success",
          PopupID: PopupID,
          group: String(props.cosmeticId)
        });
      } else {
        showPopup("StoreBuyItemResult", {
          result: "failure",
          PopupID: PopupID,
          group: String(props.cosmeticId)
        });
      }
    });
  };
  libs.onMount(() => {
    const eventIDs = [];
    eventIDs.push(useNetData("info_skin", data => {
      setInfoColorConfig(data?.[props.cosmeticId]);
    }));
    eventIDs.push(useNetData("player_token", data => {
      setPlayerTokens(data);
    }, Players.GetLocalPlayer()));
    eventIDs.push(useNetData("info_skin", data => {
      setInfoColorConfig(data?.[props.cosmeticId]);
    }));
    libs.onCleanup(() => {
      eventIDs.forEach(id => GameEvents.Unsubscribe(id));
    });
  });
  const rarity = KeyValues.CosmeticsKv[props.cosmeticId]?.rarity ?? 0;
  return libs.createComponent(BasePopup, {
    get PopupID() {
      return props.PopupID;
    },
    className: "ColoringUnlock",
    get group() {
      return props.group;
    },
    title: "#Popup_ColoringUnlock_title",
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        horizontalAlign: "right",
        flowChildren: "right",
        marginTop: "10px",
        marginRight: "40px",
        get children() {
          return libs.createComponent(libs.Index, {
            get each() {
              return consumablesList();
            },
            children: (id, _) => {
              return libs.createComponent(Player.PlayerCurrency, {
                type: "token",
                get tokenID() {
                  return Number(id());
                }
              });
            }
          });
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        width: "90%",
        flowChildren: "right",
        marginTop: "20px",
        horizontalAlign: "center",
        get children() {
          return [libs.createComponent(StoreItemImage.StoreItemImage, {
            get itemName() {
              return `#${props.cosmeticId}`;
            },
            rarity: rarity,
            get itemImage() {
              return getCosmeticImagePath(props.cosmeticId.toString());
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            flowChildren: "down",
            width: "100%",
            marginLeft: "40px",
            get children() {
              return [libs.createComponent(EOM_Label.EOM_Label, {
                html: true,
                height: "170px",
                get text() {
                  return "#" + props.cosmeticId + "_description";
                },
                color: "white"
              }), libs.createComponent(EOM_Separator.EOM_Separator, {
                direction: "horizontal"
              }), libs.createComponent(EOM_Label.EOM_Label, {
                text: "#ColoringUnlockConsume",
                marginTop: "20px",
                fontSize: "18px",
                color: "#FFFFFF"
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                marginTop: "20px",
                flowChildren: "right-wrap",
                get children() {
                  return libs.createComponent(libs.Index, {
                    get each() {
                      return consumablesList();
                    },
                    children: (id, index) => {
                      const amounts = () => infoColorConfig()?.consume?.[id()] ?? -1;
                      const playerTokenAmounts = () => playerTokens()[id()]?.num ?? 0;
                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                        get visible() {
                          return amounts() > 0;
                        },
                        get className() {
                          return libs.classNames("ConsumeContainer", {
                            enough: playerTokenAmounts() >= amounts()
                          });
                        },
                        get children() {
                          return [libs.createComponent(EOM_Icon.EOM_Icon, {
                            size: "48",
                            get src() {
                              return getSrcPath(`tokens/${id()}.png`);
                            },
                            get tooltip_text() {
                              return `#${id()}`;
                            }
                          }), libs.createComponent(EOM_Panel.EOM_Panel, {
                            id: "consume",
                            get children() {
                              return libs.createComponent(EOM_Label.EOM_Label, {
                                get text() {
                                  return playerTokenAmounts() + "<font color='#ffffff'> / " + amounts() + "</font>";
                                },
                                html: true
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
          })];
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        width: "50%",
        horizontalAlign: "center",
        marginTop: "60px",
        get children() {
          return [libs.createComponent(EOM_Button.EOM_Button, {
            color: "Gray",
            text: "#Popup_Button_Cancel",
            onactivate: () => {
              closePopup(props.PopupID);
            }
          }), libs.createComponent(EOM_Button.EOM_Button, {
            horizontalAlign: "right",
            color: "Gold",
            text: "#Popup_Button_Confirm",
            onactivate: () => {
              buyItem();
            }
          })];
        }
      })];
    }
  });
};

const Popup_Comfirm = props => {
  const [local, others] = libs.splitProps(props, ["title", "msg", "PopupID", "group", "callback"]);
  return libs.createComponent(BasePopup, {
    className: "Popup_Comfirm",
    get PopupID() {
      return local.PopupID;
    },
    get group() {
      return local.group;
    },
    get title() {
      return local.title;
    },
    size: "small",
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        height: '80%',
        width: '100%',
        get children() {
          return libs.createComponent(EOM_Label.EOM_Label, {
            color: 'white',
            fontSize: '30px',
            align: 'center center',
            get text() {
              return local.msg;
            }
          });
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        align: 'center bottom',
        flowChildren: 'right',
        get children() {
          return [libs.createComponent(EOM_Button.EOM_Button, {
            color: "Gray",
            text: "#Popup_Button_Cancel",
            onactivate: () => {
              closePopup(local.PopupID);
            }
          }), libs.createComponent(EOM_Button.EOM_Button, {
            marginLeft: '30px',
            color: "Gold",
            text: "#Popup_Button_Confirm",
            onactivate: () => {
              if (local.callback != undefined) {
                local.callback();
              }
              GameEvents.SendEventClientSide("client_side_event", {
                event_name: "Popup_Confrim",
                event_data: local.PopupID
              });
              closePopup(local.PopupID);
            }
          })];
        }
      })];
    }
  });
};

const Popup_DianFengRule = props => {
  const [countdown, setCountdown] = libs.createSignal(5);
  libs.onMount(() => {
    const id = setInterval(() => {
      setCountdown(v => Math.max(0, v - 1));
    }, 1000);
    libs.onCleanup(() => {
      clearInterval(id);
    });
  });
  return libs.createComponent(BasePopup, {
    className: "Popup_DianFengRule",
    get PopupID() {
      return props.PopupID;
    },
    title: "#DianFengRule",
    get children() {
      return libs.createComponent(EOM_Panel.EOM_Panel, {
        width: "100%",
        height: "100%",
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "MainContainer",
            width: "100%",
            height: "100%",
            align: "center top",
            flowChildren: "down",
            scroll: "y",
            paddingTop: "25px",
            paddingBottom: "25px",
            get children() {
              return [libs.createComponent(EOM_Label.EOM_Label, {
                horizontalAlign: "left",
                text: "#rule1",
                html: true
              }), libs.createComponent(EOM_Label.EOM_Label, {
                horizontalAlign: "left",
                text: "#rule2",
                html: true
              }), libs.createComponent(EOM_Label.EOM_Label, {
                horizontalAlign: "left",
                text: "#rule3",
                html: true
              }), libs.createComponent(EOM_Label.EOM_Label, {
                horizontalAlign: "left",
                text: "#rule4",
                html: true
              }), libs.createComponent(EOM_Label.EOM_Label, {
                horizontalAlign: "left",
                text: "#rule5",
                html: true
              }), libs.createComponent(EOM_Label.EOM_Label, {
                horizontalAlign: "left",
                text: "#rule6",
                html: true
              }), libs.createComponent(EOM_Label.EOM_Label, {
                horizontalAlign: "left",
                text: "#rule7",
                html: true
              }), libs.createComponent(EOM_Label.EOM_Label, {
                horizontalAlign: "left",
                text: "#rule8",
                html: true
              }), libs.createComponent(EOM_Label.EOM_Label, {
                horizontalAlign: "left",
                text: "#rule9",
                html: true
              }), libs.createComponent(EOM_Label.EOM_Label, {
                horizontalAlign: "left",
                text: "#rule10",
                html: true
              }), libs.createComponent(EOM_Label.EOM_Label, {
                horizontalAlign: "left",
                text: "#rule11",
                html: true
              }), libs.createComponent(EOM_Label.EOM_Label, {
                horizontalAlign: "left",
                text: "#rule12",
                html: true
              }), libs.createComponent(EOM_Label.EOM_Label, {
                horizontalAlign: "left",
                text: "#rule13",
                html: true
              }), libs.createComponent(EOM_Label.EOM_Label, {
                horizontalAlign: "left",
                text: "#rule14",
                html: true
              }), libs.createComponent(EOM_Label.EOM_Label, {
                horizontalAlign: "left",
                text: "#rule15",
                html: true
              })];
            }
          });
        }
      });
    }
  });
};

const Popup_DrawBuyBox = props => {
  const [local, others] = libs.splitProps(props, ["itemId", "count", "cost", "pay_type", "callback_event", "PopupID", "group"]);
  return (libs.createComponent(BasePopup, {
      get PopupID() {
        return local.PopupID;
      },
      get group() {
        return local.group;
      },
      title: "#Popup_StoreBuyItem_title",
      size: "small",
      get children() {
        return [libs.createComponent(EOM_Panel.EOM_Panel, {
          horizontalAlign: "right",
          flowChildren: "right",
          marginTop: "10px",
          marginRight: "40px",
          get children() {
            return [libs.createComponent(Player.PlayerCurrency, {
              type: "moonstone"
            }), libs.createComponent(Player.PlayerCurrency, {
              type: "token",
              get tokenID() {
                return local.pay_type == 1000001 ? 1100001 : local.pay_type;
              }
            })];
          }
        }), libs.createComponent(EOM_Panel.EOM_Panel, {
          width: "90%",
          flowChildren: "right",
          marginTop: "20px",
          horizontalAlign: "center",
          get children() {
            return [libs.createComponent(StoreItemImage.StoreItemImage, {
              get itemName() {
                return "#" + local.itemId;
              },
              get itemImage() {
                return "file://{images}/custom_game/store_items/" + local.itemId + ".png";
              }
            }), libs.createComponent(EOM_Panel.EOM_Panel, {
              flowChildren: "down",
              width: "100%",
              marginLeft: "40px",
              get children() {
                return [libs.createComponent(EOM_Label.EOM_Label, {
                  html: true,
                  height: "170px",
                  get text() {
                    return "#" + local.itemId + "_description";
                  },
                  color: "white"
                }), libs.createComponent(EOM_Separator.EOM_Separator, {
                  direction: "horizontal"
                }), libs.createComponent(EOM_Panel.EOM_Panel, {
                  marginTop: "20px",
                  flowChildren: "right",
                  get children() {
                    return [libs.createComponent(EOM_Panel.EOM_Panel, {
                      flowChildren: "down",
                      width: "200px",
                      get children() {
                        return [libs.createComponent(EOM_Label.EOM_Label, {
                          text: "#Popup_StoreBuyItem_cost",
                          color: "white"
                        }), libs.createComponent(EOM_Panel.EOM_Panel, {
                          flowChildren: "right",
                          get children() {
                            return [libs.createComponent(EOM_Image.EOM_Image, {
                              get src() {
                                return getSrcPath("tokens/" + local.pay_type + ".png");
                              },
                              width: "29px",
                              height: "29px",
                              marginTop: "10px"
                            }), libs.createComponent(EOM_Label.EOM_Label, {
                              color: "#FFD05F",
                              fontSize: "24px",
                              marginTop: "10px",
                              get text() {
                                return local.cost;
                              }
                            })];
                          }
                        })];
                      }
                    }), libs.createComponent(EOM_Panel.EOM_Panel, {
                      flowChildren: "down",
                      width: "200px",
                      get children() {
                        return [libs.createComponent(EOM_Label.EOM_Label, {
                          text: "#Popup_StoreBuyItem_count",
                          color: "white"
                        }), () => {
                          let count = local.count;
                          return libs.createComponent(EOM_NumberAdjust.EOM_NumberAdjust, {
                            marginTop: "10px",
                            value: count,
                            enabled: false,
                            onvaluechanged: self => {},
                            min: count,
                            max: count
                          });
                        }];
                      }
                    })];
                  }
                })];
              }
            })];
          }
        }), libs.createComponent(EOM_Panel.EOM_Panel, {
          width: "50%",
          horizontalAlign: "center",
          marginTop: "60px",
          get children() {
            return [libs.createComponent(EOM_Button.EOM_Button, {
              color: "Gray",
              text: "#Popup_Button_Cancel",
              onactivate: () => {
                closePopup(local.PopupID);
              }
            }), libs.createComponent(EOM_Button.EOM_Button, {
              horizontalAlign: "right",
              color: "Gold",
              text: "#Popup_Button_Confirm",
              onactivate: () => {
                GameEvents.SendEventClientSide("custom_callback", {
                  event: local.callback_event
                });
                closePopup(local.PopupID);
              }
            })];
          }
        })];
      }
    })
  );
};

const Popup_ErrorMessage = props => {
  const merged = libs.mergeProps$1({
    title: "#Popup_Error_title"
  }, props);
  const [local, others] = libs.splitProps(merged, ["title", "msg", "PopupID", "group"]);
  return (libs.createComponent(BasePopup, {
      get PopupID() {
        return local.PopupID;
      },
      get group() {
        return local.group;
      },
      get title() {
        return local.title;
      },
      size: "small",
      get children() {
        return [libs.createComponent(EOM_Panel.EOM_Panel, {
          height: '80%',
          width: '100%',
          get children() {
            return libs.createComponent(EOM_Label.EOM_Label, {
              align: 'center center',
              get text() {
                return local.msg;
              }
            });
          }
        }), libs.createComponent(EOM_Panel.EOM_Panel, {
          align: 'center bottom',
          get children() {
            return libs.createComponent(EOM_Button.EOM_Button, {
              horizontalAlign: "right",
              color: "Red",
              text: "#Popup_Button_Confirm",
              onactivate: () => {
                closePopup(local.PopupID);
              }
            });
          }
        })];
      }
    })
  );
};

const Popup_ExchangeActivityList = props => {
  const activityID = props.activityID;
  const localPlayerID = Players.GetLocalPlayer();
  const FuCardIDList = [1100147, 1100148, 1100149, 1100150, 1100151, 1100152, 1100153, 1100154, 1100155, 1100156, 1100157, 1100158, 1100159];
  const [exchangedCountData, setExchangedCountData] = libs.createSignal({});
  const [exchangeRewardData, setExchangeRewardData] = libs.createSignal([]);
  const [player_token, setPlayerToken] = libs.createSignal({});
  let selectionCardPopupID;
  const [selectedFuCardData, setSelectedFuCardData] = libs.createStore({});
  const [num, setNum] = libs.createSignal(1);
  libs.onMount(() => {
    let gameEventIDs = [];
    gameEventIDs.push(useNetData("info_activity_data", data => {
      for (const activityInfo of data) {
        if (activityInfo.activity_id == activityID) {
          const reward = JSON.parse(activityInfo.extra_information);
          setExchangeRewardData(reward.rewards.sort((a, b) => {
            return multiCompare(b.token_type_need - a.token_type_need, b.token_num_need - a.token_num_need);
          }));
          break;
        }
      }
    }));
    gameEventIDs.push(useNetData("exchange_activity_data", data => {
      if (data && data[activityID]) {
        setExchangedCountData(data[activityID].exchange_times ?? {});
      }
    }, localPlayerID));
    gameEventIDs.push(useNetData('player_token', data => {
      setPlayerToken(data);
    }, Players.GetLocalPlayer()));
    gameEventIDs.push(useClientSideEvent("chooseFuCard", data => {
      if (data && data.popupID && data.popupID == selectionCardPopupID) {
        setSelectedFuCardData(data.slot, data.card_id);
      }
    }));
    libs.onCleanup(() => {
      gameEventIDs.forEach(id => GameEvents.Unsubscribe(id));
    });
  });
  const [showingExchangeData, setShowingExchangeData] = libs.createSignal();
  const previewID = () => {
    if (showingExchangeData()) {
      return showingExchangeData()?.rewards[0]?.item_id ?? -1;
    }
    return -1;
  };
  const previewAmount = () => {
    if (showingExchangeData()) {
      return showingExchangeData()?.rewards[0]?.amounts ?? 1;
    }
    return 1;
  };
  libs.createEffect(libs.on(exchangeRewardData, v => {
    if (v.length > 0 && v[0].rewards.length > 0) {
      setShowingExchangeData(v[0]);
    }
  }));
  const FuCardNeedType = () => showingExchangeData()?.token_type_need ?? 0;
  const FuCardNeedNum = () => {
    let value = showingExchangeData()?.token_num_need ?? 0;
    return num() * value;
  };
  const showingExchangeLimit = () => showingExchangeData()?.exchange_limit ?? 0;
  const exchangeMax = () => {
    if (showingExchangeData() != undefined) {
      if (showingExchangeData().exchange_limit > 0) {
        return Math.max(1, showingExchangeLimit() - (exchangedCountData()[showingExchangeData().reward_id.toString()] ?? 0));
      }
      return 99;
    }
    return 1;
  };
  const showingExchangeAmounts = () => {
    if (showingExchangeData()) {
      return exchangedCountData()[showingExchangeData().reward_id.toString()] ?? 0;
    }
    return 0;
  };
  const FuCardNeedList = () => Array(FuCardNeedType());
  libs.createEffect(libs.on(showingExchangeData, v => {
    for (const slot in selectedFuCardData) {
      setSelectedFuCardData(Number(slot), undefined);
    }
    if (selectionCardPopupID != undefined) {
      closePopup(selectionCardPopupID);
    }
    if (v?.token_type_need == 13) {
      FuCardIDList.forEach((id, index) => {
        setSelectedFuCardData(index, id);
      });
    }
    selectionCardPopupID = undefined;
  }));
  const selectedFuCardType = () => Object.values(selectedFuCardData).filter(v => v != undefined).reduce((prev, cur) => cur != undefined ? prev + 1 : prev, 0);
  const cardAmountEnable = () => {
    return !Object.values(selectedFuCardData).filter(v => v != undefined).some(v => (player_token()[v.toString()]?.num ?? 0) < FuCardNeedNum());
  };
  const [cooldown, setCooldown] = libs.createSignal(true);
  const typeEnable = () => {
    if (FuCardNeedType() != 13) {
      return FuCardNeedType() == selectedFuCardType();
    }
    return true;
  };
  const exchangeLimitEnable = () => {
    if (showingExchangeData()) {
      return (exchangedCountData()[showingExchangeData().reward_id.toString()] ?? 0) < showingExchangeData().exchange_limit;
    }
    return false;
  };
  const exchangeEnable = () => {
    return typeEnable() && cardAmountEnable() && cooldown() && exchangeLimitEnable();
  };
  return libs.createComponent(BasePopup, {
    className: "Popup_ExchangeActivityList",
    get PopupID() {
      return props.PopupID;
    },
    get group() {
      return props.group;
    },
    get title() {
      return props.title;
    },
    size: "large",
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "ExchangeActivity_Main",
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "ExchangeMain",
            get children() {
              return [libs.createComponent(EOM_Label.EOM_Label, {
                id: "ExchangeRewardTitle",
                text: "#Activity_Anniversary_exchange_title1"
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "Divider"
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "ExchangeList",
                scroll: "x",
                get children() {
                  return libs.createComponent(libs.Index, {
                    get each() {
                      return exchangeRewardData();
                    },
                    children: (data, i) => {
                      const exchangedCount = () => exchangedCountData()[data().reward_id.toString()] ?? 0;
                      const itemID = () => data().rewards?.[0]?.item_id ?? -1;
                      const amounts = () => data().rewards?.[0]?.amounts ?? 1;
                      const rarity = () => data().rewards?.[0]?.rarity ?? 1;
                      return libs.createComponent(EOM_Button.EOM_BaseButton, {
                        get className() {
                          return libs.classNames("ExchangeActivityReward", "Rarity" + rarity(), {
                            Limited: exchangedCount() >= data().exchange_limit,
                            Selected: showingExchangeData()?.reward_id == data().reward_id
                          });
                        },
                        onactivate: () => {
                          if (showingExchangeData()?.reward_id == data().reward_id) {
                            return;
                          }
                          setShowingExchangeData(data());
                        },
                        get children() {
                          return [libs.createComponent(EOM_Panel.EOM_Panel, {
                            id: "ExchangeActivityRewardBG"
                          }), libs.createComponent(libs.Show, {
                            get when() {
                              return KeyValues.CosmeticsKv[itemID()] != undefined;
                            },
                            get fallback() {
                              return libs.createComponent(ProductImage.ProductImage, {
                                get itemid() {
                                  return itemID();
                                }
                              });
                            },
                            get children() {
                              return libs.createComponent(CosmeticCard.CosmeticImage, {
                                get itemid() {
                                  return itemID();
                                },
                                onmouseover: self => {
                                  $.DispatchEvent("DOTAShowTextTooltip", self, "#" + itemID());
                                },
                                onmouseout: self => {
                                  $.DispatchEvent("DOTAHideTextTooltip", self);
                                }
                              });
                            }
                          }), libs.createComponent(libs.Show, {
                            get when() {
                              return amounts() > 1;
                            },
                            get children() {
                              return libs.createComponent(EOM_Label.EOM_Label, {
                                id: "ExchangeActivityRewardCount",
                                get text() {
                                  return "×" + amounts();
                                },
                                hittest: false
                              });
                            }
                          }), libs.createComponent(EOM_Panel.EOM_Panel, {
                            id: "ExchangeActivityRewardLight",
                            hittest: false
                          }), libs.createComponent(EOM_Icon.EOM_Icon, {
                            id: "RewardReceived",
                            hittest: false
                          })];
                        }
                      });
                    }
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "ExchangeCenter",
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "FuCardNeed",
                    get children() {
                      return [libs.createComponent(EOM_Label.EOM_Label, {
                        id: "FuCardNeedTitle",
                        text: "#Activity_Anniversary_exchange_title3"
                      }), libs.createComponent(EOM_Separator.EOM_Separator, {}), libs.createComponent(EOM_Panel.EOM_Panel, {
                        flowChildren: 'right-wrap',
                        get children() {
                          return libs.createComponent(libs.Index, {
                            get each() {
                              return FuCardNeedList();
                            },
                            children: (_, i) => {
                              const isAllCard = () => FuCardNeedType() == 13;
                              const selectedCard = () => {
                                if (isAllCard()) {
                                  return FuCardIDList[i];
                                }
                                if (selectedFuCardData[i]) {
                                  return selectedFuCardData[i];
                                }
                              };
                              const cardImagePath = () => {
                                if (selectedCard()) {
                                  return getImagePath(`store_items/${selectedCard()}.png`);
                                }
                                return getImagePath("activity/anniversary2/f2_random_card.png");
                              };
                              const selectedCardAmounts = () => {
                                if (selectedCard()) {
                                  return `${player_token()[selectedCard().toString()]?.num ?? 0}`;
                                }
                                return `?`;
                              };
                              const amountsHas = () => {
                                if (selectedCard()) {
                                  return (player_token()[selectedCard().toString()]?.num ?? 0) >= FuCardNeedNum();
                                }
                                return true;
                              };
                              const buttonText = () => {
                                if (selectedCard() != undefined) {
                                  return "#" + selectedCard();
                                }
                                return "#Activity_Anniversary_changeCard";
                              };
                              const buttonColor = () => {
                                if (selectedCard() != undefined) {
                                  return "Blue";
                                }
                                return "Green";
                              };
                              return libs.createComponent(EOM_Panel.EOM_Panel, {
                                className: "FuCardClass",
                                get children() {
                                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                                    get className() {
                                      return libs.classNames("FuCardButton", {
                                        Selected: selectedCard() != undefined,
                                        NotHas: !amountsHas()
                                      });
                                    },
                                    get enabled() {
                                      return libs.memo(() => !!!isAllCard())() && selectedCard() == undefined;
                                    },
                                    get children() {
                                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                                        id: "FuCardImage",
                                        get backgroundImage() {
                                          return cardImagePath();
                                        }
                                      });
                                    }
                                  }), libs.createComponent(EOM_Label.EOM_Label, {
                                    get className() {
                                      return libs.classNames("FuCardNeedAmounts", {
                                        NotHas: !amountsHas()
                                      });
                                    },
                                    get text() {
                                      return `<font color='${amountsHas() ? "#4fec54" : "#f64d4d"}'>${selectedCardAmounts()}</font>/${FuCardNeedNum()}`;
                                    },
                                    hittest: false,
                                    html: true
                                  }), libs.createComponent(libs.Show, {
                                    get when() {
                                      return !isAllCard();
                                    },
                                    get children() {
                                      return libs.createComponent(EOM_Button.EOM_Button, {
                                        id: "changeFuCardType",
                                        get color() {
                                          return buttonColor();
                                        },
                                        get text() {
                                          return buttonText();
                                        },
                                        onactivate: () => {
                                          selectionCardPopupID = showPopup("FuCardSelection", {
                                            selectedList: Object.values(selectedFuCardData).filter(v => v != undefined),
                                            slot: i
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
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "ExchangeLimit",
                    get children() {
                      return [libs.createComponent(EOM_Separator.EOM_Separator, {
                        size: "short"
                      }), libs.createComponent(EOM_Panel.EOM_Panel, {
                        flowChildren: "right",
                        get children() {
                          return [libs.createComponent(libs.Show, {
                            get when() {
                              return showingExchangeLimit() > 0;
                            },
                            get children() {
                              return libs.createComponent(EOM_Label.EOM_Label, {
                                id: "ExchangeLimitLabel",
                                verticalAlign: 'center',
                                text: "#LimitBuy",
                                get dialogVariables() {
                                  return {
                                    count: showingExchangeAmounts(),
                                    max: showingExchangeLimit()
                                  };
                                }
                              });
                            }
                          }), libs.createComponent(EOM_Label.EOM_Label, {
                            verticalAlign: 'center',
                            marginLeft: "160px",
                            className: "CostDescLabel",
                            text: "#Popup_StoreBuyItem_count"
                          }), libs.createComponent(EOM_NumberAdjust.EOM_NumberAdjust, {
                            verticalAlign: "center",
                            get value() {
                              return num();
                            },
                            get max() {
                              return exchangeMax();
                            },
                            min: 1,
                            onvaluechanged: self => {
                              setNum(self.value);
                            },
                            marginLeft: "18px"
                          })];
                        }
                      })];
                    }
                  })];
                }
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "PreviewMain",
            get children() {
              return libs.createComponent(libs.Show, {
                get when() {
                  return previewID() != -1;
                },
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "Preview3D",
                    get children() {
                      return libs.createComponent(libs.Switch, {
                        get children() {
                          return [libs.createComponent(libs.Match, {
                            get when() {
                              return KeyValues.CosmeticsKv[previewID()] != undefined;
                            },
                            get children() {
                              return libs.createComponent(CosmeticPreview.CosmeticPreview, {
                                get cosmetic_id() {
                                  return previewID();
                                },
                                showPedestal: true,
                                showCourierPedestal: true
                              });
                            }
                          }), libs.createComponent(libs.Match, {
                            get when() {
                              return KeyValues.CosmeticsKv[previewID()] == undefined;
                            },
                            get children() {
                              return [libs.createComponent(CosmeticCard.CosmeticImage, {
                                className: "CosmeticPreviewImage",
                                get itemid() {
                                  return previewID().toString();
                                }
                              }), libs.createComponent(ProductImage.ProductImage, {
                                className: "CosmeticPreviewImage",
                                get itemid() {
                                  return previewID();
                                },
                                get count() {
                                  return previewAmount();
                                }
                              })];
                            }
                          })];
                        }
                      });
                    }
                  }), (() => {
                    const _el$ = libs.createElement("Panel", {
                      id: "CosmeticDesc"
                    }, null);
                    libs.insert(_el$, libs.createComponent(GenericPanel.CLabel, {
                      id: "CosmeticName",
                      get text() {
                        return '#' + previewID();
                      }
                    }), null);
                    libs.insert(_el$, libs.createComponent(EOM_Separator.EOM_Separator, {
                      size: "short"
                    }), null);
                    libs.insert(_el$, libs.createComponent(GenericPanel.CLabel, {
                      id: "CosmeticAccess",
                      get text() {
                        return GetCosmeticAccessDescription(previewID());
                      }
                    }), null);
                    return _el$;
                  })()];
                }
              });
            }
          })];
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        align: 'center bottom',
        width: '500px',
        get children() {
          return [libs.createComponent(EOM_Button.EOM_Button, {
            horizontalAlign: "left",
            get enabled() {
              return libs.memo(() => !!cooldown())() && exchangeLimitEnable();
            },
            get color() {
              return exchangeEnable() ? "Green" : "Red";
            },
            text: "#Store_Exchange_Button",
            onactivate: () => {
              if (exchangeEnable()) {
                setCooldown(false);
                $.Schedule(1, () => {
                  setCooldown(true);
                });
                callAction("activity_receive", {
                  activity_id: activityID,
                  reward_id: showingExchangeData().reward_id,
                  exchange_activity_params: {
                    params: Object.values(selectedFuCardData).filter(v => v != undefined),
                    amounts: num()
                  }
                });
              } else {
                if (FuCardNeedType() < 13 && selectedFuCardType() != FuCardNeedType()) {
                  ErrorMessage("#Activity_Anniversary_exchange_error1");
                } else {
                  ErrorMessage("#Activity_Anniversary_exchange_error2");
                }
              }
            }
          }), libs.createComponent(EOM_Button.EOM_Button, {
            horizontalAlign: "right",
            color: "Gray",
            text: "#Popup_Button_Cancel",
            onactivate: () => {
              closePopup(props.PopupID);
            }
          })];
        }
      })];
    }
  });
};

const Popup_Feedback = props => {
  const feedbackTypeList = ["bug", "suggestion", "other"];
  const maxFeedbackCount = 1;
  const [feedbackText, setFeedbackText] = libs.createSignal("");
  const [selectedType, setSelectedType] = libs.createSignal(-1);
  const seletedTypeStr = () => feedbackTypeList[selectedType() - 1];
  let refEntry;
  const blurTextEntry = () => {
    if (refEntry?.IsValid()) {
      $.DispatchEvent("DropInputFocus", refEntry);
    }
  };
  const [playerFeedbackCount, setPlayerFeedbackCount] = libs.createSignal(0);
  const [feedbackState, setState] = libs.createSignal(0);
  const SubmitFeedback = () => {
    const type = seletedTypeStr();
    if (type != undefined) {
      GameEvents.SendCustomEventToServer("report_feedback", {
        type,
        message: feedbackText()
      });
      setState(1);
    }
  };
  libs.createEffect(libs.on(playerFeedbackCount, count => {
    if (count >= maxFeedbackCount) {
      setState(1);
    }
  }));
  libs.onMount(() => {
    const id = useNetTableKeyHasDefaultValue("player_data", Players.GetLocalPlayer().toString(), data => {
      setPlayerFeedbackCount(data?.feedbackCount ?? 0);
    });
    libs.onCleanup(() => {
      CustomNetTables.UnsubscribeNetTableListener(id);
    });
  });
  libs.createEffect(libs.on(feedbackState, _state => {
    if (_state == 0) {
      setFeedbackText("");
      setSelectedType(-1);
    }
  }));
  return libs.createComponent(BasePopup, {
    className: "Popup_Feedback",
    title: "#Feedback_Title",
    get PopupID() {
      return props.PopupID;
    },
    get group() {
      return props.group;
    },
    get children() {
      return libs.createComponent(EOM_Panel.EOM_Panel, {
        width: "100%",
        height: "100%",
        onactivate: () => blurTextEntry(),
        get children() {
          return libs.createComponent(libs.Switch, {
            get children() {
              return [libs.createComponent(libs.Match, {
                get when() {
                  return feedbackState() == 0;
                },
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "FeedbackMain",
                    get children() {
                      return [libs.createComponent(EOM_Label.EOM_Label, {
                        horizontalAlign: "center",
                        text: "#Feedback_Illustrate"
                      }), libs.createComponent(EOM_Panel.EOM_Panel, {
                        marginTop: "30px",
                        horizontalAlign: "center",
                        width: "100%",
                        flowChildren: "down",
                        get children() {
                          return [libs.createComponent(EOM_Label.EOM_Label, {
                            margin: "0 10px",
                            id: "FeedbackTypeTitle",
                            color: "#ffffff",
                            fontSize: "20px",
                            text: "#Feedback_SelectType"
                          }), libs.createComponent(EOM_Panel.EOM_Panel, {
                            id: "FeedbackTypeList",
                            get children() {
                              return [libs.createComponent(EOM_Button.EOM_BaseButton, {
                                horizontalAlign: "left",
                                get className() {
                                  return libs.classNames("FeebackTypeButton", {
                                    Selected: selectedType() == 1
                                  });
                                },
                                onactivate: () => {
                                  setSelectedType(1);
                                  blurTextEntry();
                                },
                                get children() {
                                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                                    id: "FeebackTypeCircle"
                                  }), libs.createComponent(EOM_Label.EOM_Label, {
                                    text: "#Feedback_Type1"
                                  })];
                                }
                              }), libs.createComponent(EOM_Button.EOM_BaseButton, {
                                horizontalAlign: "center",
                                get className() {
                                  return libs.classNames("FeebackTypeButton", {
                                    Selected: selectedType() == 2
                                  });
                                },
                                onactivate: () => {
                                  setSelectedType(2);
                                  blurTextEntry();
                                },
                                get children() {
                                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                                    id: "FeebackTypeCircle"
                                  }), libs.createComponent(EOM_Label.EOM_Label, {
                                    text: "#Feedback_Type2"
                                  })];
                                }
                              }), libs.createComponent(EOM_Button.EOM_BaseButton, {
                                horizontalAlign: "right",
                                get className() {
                                  return libs.classNames("FeebackTypeButton", {
                                    Selected: selectedType() == 3
                                  });
                                },
                                onactivate: () => {
                                  setSelectedType(3);
                                  blurTextEntry();
                                },
                                get children() {
                                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                                    id: "FeebackTypeCircle"
                                  }), libs.createComponent(EOM_Label.EOM_Label, {
                                    text: "#Feedback_Type3"
                                  })];
                                }
                              })];
                            }
                          })];
                        }
                      }), libs.createComponent(Player.EOM_TextEntry, {
                        id: "FeedbackTextEntry",
                        ref(r$) {
                          const _ref$ = refEntry;
                          typeof _ref$ === "function" ? _ref$(r$) : refEntry = r$;
                        },
                        get className() {
                          return $.Language().toLowerCase();
                        },
                        placeholder: "#Feedback_PreviousLabel",
                        onChange: self => {
                          setFeedbackText(self.text);
                        },
                        oninputsubmit: self => {
                          setFeedbackText(self.text);
                        }
                      })];
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "FeedbackBottom",
                    get children() {
                      return libs.createComponent(EOM_Button.EOM_Button, {
                        get enabled() {
                          return libs.memo(() => !!(selectedType() != -1 && feedbackText() != ""))() && playerFeedbackCount() < maxFeedbackCount;
                        },
                        horizontalAlign: "center",
                        text: "#SubmitFeedBack",
                        onactivate: () => {
                          SubmitFeedback();
                        }
                      });
                    }
                  })];
                }
              }), libs.createComponent(libs.Match, {
                get when() {
                  return feedbackState() == 1;
                },
                get children() {
                  return [libs.createComponent(EOM_Icon.EOM_Icon, {
                    horizontalAlign: "center",
                    size: "48",
                    marginTop: "150px",
                    get src() {
                      return getSrcPath("icon/icon_party_ready_psd.png");
                    }
                  }), libs.createComponent(EOM_Label.EOM_Label, {
                    fontSize: "26px",
                    style: {
                      textAlign: "center"
                    },
                    color: "white",
                    horizontalAlign: "center",
                    marginTop: "220px",
                    text: "#Succ_SubmitFeedBack"
                  })];
                }
              })];
            }
          });
        }
      });
    }
  });
};

const Popup_FuCardSelection = props => {
  const selectedList = props.selectedList;
  Players.GetLocalPlayer();
  const FuCardIDList = [1100147, 1100148, 1100149, 1100150, 1100151, 1100152, 1100153, 1100154, 1100155, 1100156, 1100157, 1100158, 1100159];
  const [player_token, setPlayerToken] = libs.createSignal({});
  libs.onMount(() => {
    let gameEventIDs = [];
    gameEventIDs.push(useNetData('player_token', data => {
      setPlayerToken(data);
    }, Players.GetLocalPlayer()));
    libs.onCleanup(() => {
      gameEventIDs.forEach(id => GameEvents.Unsubscribe(id));
    });
  });
  const [selectedID, setSelectedID] = libs.createSignal();
  libs.createEffect(() => {
    console.log("selectedID", selectedID());
  });
  const confirmEnable = () => selectedID() != undefined && !selectedList.includes(selectedID());
  return libs.createComponent(BasePopup, {
    className: "Popup_FuCardSelection",
    get PopupID() {
      return props.PopupID;
    },
    get group() {
      return props.group;
    },
    title: "#Activity_Anniversary_changeCard",
    size: "normal",
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "Main",
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "CardList",
            scroll: "y",
            get children() {
              return FuCardIDList.map((cardID, index) => {
                let amount = () => player_token()[cardID.toString()]?.num ?? 0;
                return libs.createComponent(EOM_Panel.EOM_Panel, {
                  get className() {
                    return libs.classNames("FuCard", {
                      Has: amount() > 0,
                      Selected: selectedID() == cardID
                    });
                  },
                  get children() {
                    return [libs.createComponent(EOM_Panel.EOM_Panel, {
                      get children() {
                        return [libs.createComponent(EOM_Button.EOM_BaseButton, {
                          get enabled() {
                            return !selectedList.includes(cardID);
                          },
                          onactivate: () => setSelectedID(cardID),
                          get children() {
                            return libs.createComponent(EOM_Image.EOM_Image, {
                              id: "Card",
                              get src() {
                                return getSrcPath(`store_items/${cardID}.png`);
                              }
                            });
                          }
                        }), libs.createComponent(EOM_Label.EOM_Label, {
                          id: "CardName",
                          text: `#${cardID}`,
                          hittest: false
                        })];
                      }
                    }), libs.createComponent(EOM_Label.EOM_Label, {
                      id: "amount",
                      get text() {
                        return `x${amount()}`;
                      },
                      hittest: false
                    })];
                  }
                });
              });
            }
          });
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        align: 'center bottom',
        get children() {
          return libs.createComponent(EOM_Button.EOM_Button, {
            horizontalAlign: "right",
            get enabled() {
              return confirmEnable();
            },
            color: "Blue",
            text: "#Popup_Button_Confirm",
            onactivate: () => {
              clientSideEvent("chooseFuCard", {
                card_id: selectedID(),
                slot: props.slot,
                popupID: props.PopupID
              });
              closePopup(props.PopupID);
            }
          });
        }
      })];
    }
  });
};

const Popup_HeroProficiencyInfo = props => {
  const [local, others] = libs.splitProps(props, ["PopupID", "group"]);
  const [proficiencyLevelValues, setProficiencyLevelValues] = libs.createSignal([]);
  libs.onMount(() => {
    let gameEventIDList = [];
    gameEventIDList.push(useNetData("info_hero_medal_level", data => {
      if (data) {
        setProficiencyLevelValues([0].concat(data.map(v => v.medal)));
      }
    }));
    libs.onCleanup(() => {
      gameEventIDList.forEach(id => GameEvents.Unsubscribe(id));
    });
  });
  return libs.createComponent(BasePopup, {
    className: "Popup_HeroProficiencyInfo",
    get PopupID() {
      return local.PopupID;
    },
    size: "normal",
    get group() {
      return local.group;
    },
    title: "#HeroProficiencyInfo",
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "TitleContainer",
        get children() {
          return libs.createComponent(GenericPanel.CLabel, {
            text: "#HeroProficiencyInfo_desc"
          });
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "ProficiencyList",
        get children() {
          return libs.createComponent(libs.Index, {
            get each() {
              return proficiencyLevelValues();
            },
            children: (medal, index) => {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "ProficiencyInfo",
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "ProficiencyIconContainer",
                    get children() {
                      return libs.createComponent(HeroProficiencyIcon.HeroProficiencyIcon, {
                        override_level: index,
                        showParticle: true
                      });
                    }
                  }), libs.createComponent(GenericPanel.CLabel, {
                    id: "ProficiencyInfoLabel",
                    text: `#HeroProficiency_${index}`
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

const Popup_HeroSelectCard = props => {
  const [banListNet, _setBanListNet] = libs.createSignal(CustomNetTables.GetTableValue("common", "ban_list"));
  const [customMatchType, setCustomMatchType] = libs.createSignal(0);
  const [selectTrait, setSelectTrait] = libs.createSignal();
  const banList = () => Object.values(banListNet() ?? {});
  const pickList = () => Object.keys(GameUI.CustomUIConfig().SectAbilitiesKv).filter(sectName => !banList().includes(sectName));
  const [player_hero, setPlayerHero] = libs.createSignal({});
  const [match_hero_list, setMatchHeroList] = libs.createSignal([]);
  netdata_utils.createNetTableEffect("common", "match_hero_list", v => {
    setMatchHeroList(Object.values(v));
  });
  const [HeroList, setHeroList] = libs.createSignal([]);
  const [playerData] = libs.createSignal(CustomNetTables.GetTableValue("player_data", Players.GetLocalPlayer()));
  const [banHeroResult, setBanHeroResult] = libs.createSignal(Object.values(CustomNetTables.GetTableValue("common", "hero_ban_list") ?? {}));
  const [freeHero, setFreeHero] = libs.createSignal(false);
  const unlock_hero = () => playerData()?.service_config?.unlock_hero == "1";
  const allUnlock = () => freeHero() && unlock_hero();
  const experienceHeroData = () => {
    const experienceHeroData = {};
    Object.values(player_props()).forEach(v => {
      if (v.amounts > 0) {
        let propInfo = info_prop()[v.prop_id];
        if (propInfo && propInfo.type == 3) {
          let params = JSON.parseSafe(propInfo.param);
          if (params.type && params.type != "any") {
            experienceHeroData[params.type] = {
              prop_id: v.prop_id,
              id: v.id
            };
          }
        }
      }
    });
    return experienceHeroData;
  };
  libs.createEffect(libs.on([match_hero_list, player_hero, experienceHeroData, allUnlock, banHeroResult], () => {
    let list = [];
    if (allUnlock()) {
      match_hero_list().forEach(name => {
        if (banHeroResult().includes(name)) {
          return;
        }
        const hid = KeyValues.UnitsCommonKv[name]?.Hid;
        if (typeof hid == "number") {
          list.push(hid.toString());
        }
      });
    } else {
      match_hero_list().forEach(name => {
        if (banHeroResult().includes(name)) {
          return;
        }
        const kv = KeyValues.UnitsCommonKv[name];
        if (kv && typeof kv.Hid == "number") {
          const hid = kv.Hid.toString();
          if (kv.Access == "default") {
            list.push(hid);
            return;
          }
          if (player_hero()[hid] || experienceHeroData()[hid]) {
            list.push(hid);
            return;
          }
        }
      });
    }
    list.sort((a, b) => {
      return multiCompare((experienceHeroData()[b] != undefined ? 1 : 0) - (experienceHeroData()[a] != undefined ? 1 : 0), (player_hero()[a] != undefined ? 1 : 0) - (player_hero()[b] != undefined ? 1 : 0));
    });
    setHeroList(list);
  }));
  const [collectedHeroIds, setCollectedHeroIds] = libs.createSignal([]);
  const [onlyShowCollected, setOnlyShowCollected] = libs.createSignal(false);
  const [sectFilter, setSectFilter] = libs.createSignal('');
  const [selectedHeroName, setSelectedHeroName] = libs.createSignal('');
  const [herocardUseCount, setHerocardUseCount] = libs.createSignal(getPlayerData(Players.GetLocalPlayer(), "herocardUseCount") ?? 1);
  const [info_prop, setInfoProp] = libs.createSignal({});
  const [player_props, setPlayerProps] = libs.createSignal({});
  const [propId, setPropId] = libs.createSignal(-1);
  const [cardNum, setCardNum] = libs.createSignal(0);
  const GetHeroName = hid => {
    return Object.entries(KeyValues.UnitsCommonKv).filter(([name, v]) => {
      return v.Hid == hid;
    }).map(([name, v]) => name)[0];
  };
  libs.onMount(() => {
    let gameEventIDList = [];
    const NetTableListeners = [];
    gameEventIDList.push(useNetData('player_hero', data => {
      setPlayerHero(data);
    }, Players.GetLocalPlayer()));
    NetTableListeners.push(useNetTableKeyHasDefaultValue("common", "hero_ban_list", data => {
      setBanHeroResult(Object.values(data).map(v => (GetGoodIDByHeroName(v) ?? -1).toString()));
    }));
    gameEventIDList.push(useNetData("info_activity_data", data => {
      let now = Math.floor(Date.now() / 1000);
      for (const activityInfo of data) {
        if (activityInfo.activity_id == 11001 && (activityInfo.end_time > now || activityInfo.end_time == 0)) {
          setFreeHero(true);
          break;
        }
      }
    }));
    gameEventIDList.push(useNetData('player_props', data => {
      libs.batch(() => {
        setPlayerProps(data);
        for (let v of Object.values(data)) {
          if (v.prop_id == 9310001) {
            setCardNum(v.amounts);
            setPropId(v.id);
            return;
          }
        }
      });
    }, Players.GetLocalPlayer()));
    NetTableListeners.push(useNetTableKeyHasDefaultValue("common", "custom_match_type", data => {
      if (data?.type != undefined) {
        setCustomMatchType(data.type);
      }
    }));
    gameEventIDList.push(useNetData('info_prop', data => {
      setInfoProp(data);
    }));
    NetTableListeners.push(CustomNetTables.SubscribeNetTableListener("player_data", (tableName, key, data) => {
      if (Number(key) == Players.GetLocalPlayer()) {
        setHerocardUseCount(data.herocardUseCount);
      }
    }));
    NetTableListeners.push(useServiceNetTable("player_hero_collection", data => {
      let collected_hero_ids = [];
      for (const sect in data) {
        data[sect].hero.forEach(id => {
          collected_hero_ids.push(id);
        });
      }
      setCollectedHeroIds(collected_hero_ids);
    }, Players.GetLocalPlayer()));
    NetTableListeners.push(useNetTableKey("common", "hero_ban_list", data => {
      setBanHeroResult(Object.values(data));
    }));
    libs.onCleanup(() => {
      for (const id of gameEventIDList) {
        GameEvents.Unsubscribe(id);
      }
      NetTableListeners.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    });
  });
  libs.createEffect(libs.on(banHeroResult, () => {
    setSelectedHeroName("");
  }));
  const buttonEnable = () => herocardUseCount() > 0 && cardNum() > 0 && selectedHeroName() != "" && (props.trait == undefined || selectTrait() != undefined);
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
  return libs.createComponent(BasePopup, {
    get PopupID() {
      return props.PopupID;
    },
    size: "large",
    title: "#Popup_HeroPick_title",
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "SectList",
        flowChildren: "right",
        horizontalAlign: "center",
        get children() {
          return [libs.createComponent(libs.Index, {
            get each() {
              return pickList();
            },
            children: sectName => {
              return libs.createComponent(EOM_Button.EOM_BaseButton, {
                width: "82px",
                margin: "0px 10px",
                get customTooltip() {
                  return {
                    name: "player_sect_list",
                    sr_reveal: 1,
                    sectName: sectName(),
                    concise: 1
                  };
                },
                padding: "4px",
                tooltipPosition: "top",
                onactivate: () => {
                  setSectFilter(v => v == sectName() ? "" : sectName());
                },
                get children() {
                  return [libs.createComponent(SectIcon.SectIcon, {
                    large: true,
                    active: true,
                    get sectName() {
                      return sectName();
                    },
                    horizontalAlign: "center",
                    width: "56px",
                    height: "56px"
                  }), libs.createComponent(libs.Show, {
                    get when() {
                      return sectName() == sectFilter();
                    },
                    get children() {
                      return libs.createElement("Image", {
                        id: "SectSelected"
                      }, null);
                    }
                  })];
                }
              });
            }
          }), libs.createComponent(libs.Index, {
            get each() {
              return banList();
            },
            children: sectName => {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                width: "82px",
                margin: "0px 10px",
                get customTooltip() {
                  return {
                    name: "player_sect_list",
                    sr_reveal: 1,
                    sectName: sectName(),
                    concise: 1
                  };
                },
                padding: "4px",
                tooltipPosition: "top",
                get children() {
                  return [libs.createComponent(SectIcon.SectIcon, {
                    large: true,
                    active: false,
                    get sectName() {
                      return sectName();
                    },
                    horizontalAlign: "center",
                    width: "56px",
                    height: "56px"
                  }), libs.createComponent(EOM_Image.EOM_Image, {
                    width: "56px",
                    height: "56px",
                    horizontalAlign: "center",
                    get backgroundImage() {
                      return getImagePath("icon/s_ban.png");
                    },
                    hittest: false
                  })];
                }
              });
            }
          })];
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "HeroList",
        width: "1377px",
        height: "570px",
        backgroundColor: "#1F243C",
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "HeroListContent",
            flowChildren: "right-wrap",
            scroll: "y",
            marginLeft: "4%",
            width: "95%",
            height: "100%",
            get children() {
              return libs.createComponent(libs.Index, {
                get each() {
                  return HeroList();
                },
                children: hid => {
                  let heroName = () => GetHeroName(hid());
                  return libs.createComponent(EOM_Button.EOM_BaseButton, {
                    get className() {
                      return libs.classNames('HeroCardButton', {
                        Show: (!onlyShowCollected() || collectedHeroIds().includes(Number(hid()))) && true && (sectFilter() == '' || (KeyValues.UnitsCommonKv[heroName()].Sect ?? '').includes(sectFilter()))
                      });
                    },
                    onactivate: () => {
                      if (experienceHeroData()[hid()] != undefined && player_hero()[hid()] == undefined) {
                        ShowComfirmPopup($.Localize("#use_hero_experience_card") + $.Localize("#" + experienceHeroData()[hid()]?.prop_id), () => {
                          callAction("use_prop", {
                            id: experienceHeroData()[hid()]?.id ?? 0,
                            prop_id: experienceHeroData()[hid()]?.prop_id ?? 0,
                            amounts: 1,
                            params: [hid()]
                          });
                        });
                      } else {
                        setSelectedHeroName(heroName());
                      }
                    },
                    get children() {
                      return [libs.createComponent(HeroRoleCard.HeroRoleCard, {
                        get heroName() {
                          return heroName();
                        },
                        get collected() {
                          return collectedHeroIds().includes(Number(hid()));
                        },
                        get children() {
                          return libs.createComponent(libs.Show, {
                            get when() {
                              return libs.memo(() => experienceHeroData()[hid()] != undefined)() && player_hero()[hid()] == undefined;
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
                          });
                        }
                      }), libs.createComponent(libs.Show, {
                        get when() {
                          return heroName() == selectedHeroName();
                        },
                        get children() {
                          return libs.createComponent(EOM_Image.EOM_Image, {
                            get backgroundImage() {
                              return getImagePath("icon/selected.png");
                            },
                            id: "PickIcon"
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
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        width: "100%",
        id: "bottomBar",
        verticalAlign: "bottom",
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            verticalAlign: "center",
            flowChildren: "right",
            get children() {
              return libs.createComponent(libs.For, {
                get each() {
                  return props.trait;
                },
                children: (traitName, index) => {
                  return libs.createComponent(EOM_Button.EOM_BaseButton, {
                    className: "TraitCardSelect",
                    height: "86px",
                    width: "86px",
                    margin: "0px 10px",
                    onactivate: () => {
                      setSelectTrait(traitName);
                    },
                    customTooltip: {
                      name: "hero_ability",
                      abilityName: traitName
                    },
                    get children() {
                      return [libs.createComponent(EOM_Panel.EOM_Panel, {
                        get children() {
                          return [libs.createComponent(GenericPanel.CImage, {
                            "class": "TraitAbilityImage_Image",
                            get src() {
                              return `file://{images}/spellicons/${KeyValues.TraitKv[traitName]?.AbilityTextureName ?? ""}.png`;
                            }
                          }), libs.createComponent(GenericPanel.CImage, {
                            "class": "TraitMask"
                          })];
                        }
                      }), libs.createComponent(libs.Show, {
                        get when() {
                          return selectTrait() == traitName;
                        },
                        get children() {
                          return libs.createElement("Image", {
                            "class": "TraitSelect"
                          }, null);
                        }
                      })];
                    }
                  });
                }
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            verticalAlign: "center",
            horizontalAlign: "right",
            marginRight: "250px",
            tooltip: "#SelectHeroCard_desc",
            get dialogVariables() {
              return {
                "num": cardNum()
              };
            },
            get children() {
              return [libs.createComponent(EOM_Image.EOM_Image, {
                get backgroundImage() {
                  return getImagePath("store_items/9310001.png");
                },
                width: "100px",
                height: "100px"
              }), libs.createComponent(EOM_Label.EOM_Label, {
                get text() {
                  return "x" + cardNum();
                },
                align: "right bottom",
                fontSize: "32px",
                color: "white",
                marginBottom: "6px"
              })];
            }
          }), libs.createComponent(EOM_Button.EOM_BaseButton, {
            verticalAlign: "center",
            horizontalAlign: "right",
            get className() {
              return libs.classNames("CollecttionFilter", {
                Active: onlyShowCollected()
              });
            },
            onactivate: () => setOnlyShowCollected(v => !v),
            get children() {
              return [libs.createComponent(EOM_Icon.EOM_Icon, {
                id: "CollecttionFilterIcon"
              }), libs.createComponent(GenericPanel.CLabel, {
                id: "CollecttionFilterText",
                text: "#hero_collection_filter"
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            verticalAlign: "center",
            horizontalAlign: "center",
            flowChildren: "right",
            get children() {
              return [libs.createComponent(EOM_Button.EOM_Button, {
                text: "#Popup_Button_Cancel",
                color: "Gray",
                onactivate: () => closePopup(props.PopupID)
              }), libs.createComponent(EOM_Button.EOM_Button, {
                id: "Use",
                marginLeft: "70px",
                text: "#UseSelectHeroCard",
                get enabled() {
                  return buttonEnable();
                },
                get color() {
                  return buttonEnable() ? "Purple" : "Gray";
                },
                onactivate: () => {
                  if (buttonEnable()) {
                    GameEvents.SendCustomEventToServer("specify_hero", {
                      heroName: selectedHeroName(),
                      trait: selectTrait()
                    });
                    callAction("use_prop", {
                      id: propId(),
                      prop_id: 9310001,
                      amounts: 1,
                      params: []
                    });
                  }
                  closePopup(props.PopupID);
                }
              })];
            }
          })];
        }
      })];
    }
  });
};

const Popup_IkunWinterTask = props => {
  const language = $.Language().toLowerCase();
  const activityID = 12001;
  const [playerOrnament, setPlayerOrnament] = libs.createSignal({});
  const [activityCollection, setActivityCollection] = libs.createSignal({});
  const [rewardState, setRewardState] = libs.createSignal({});
  const [taskIDList, setTaskIDList] = libs.createSignal([]);
  const [greatRewardData, setGreatRewardData] = libs.createSignal();
  libs.createEffect(libs.on(() => ({
    v: activityCollection(),
    s: rewardState()
  }), ({
    v,
    s
  }) => {
    if (v && v["1200109"]) {
      setGreatRewardData(v["1200109"]);
    }
    setTaskIDList(Object.keys(activityCollection()).filter(v => v != "1200109").sort((a, b) => {
      let p_a = 1;
      let p_b = 1;
      let s_a = s[a] ?? 2;
      let s_b = s[b] ?? 2;
      if (s_a == 1) {
        p_a = 2;
      } else if (s_a == 0) {
        p_a = 0;
      }
      if (s_b == 1) {
        p_b = 2;
      } else if (s_b == 0) {
        p_b = 0;
      }
      return p_a - p_b;
    }));
  }));
  const isOwnOrnament = oid => {
    if (playerOrnament()[oid.toString()] && playerOrnament()[oid.toString()].permanent == 1) {
      return true;
    }
    return false;
  };
  libs.onMount(() => {
    const gameEventIDList = [];
    const netTableIDList = [];
    gameEventIDList.push(useNetData("info_activity_collect_rewards", data => {
      if (data[activityID.toString()]) {
        setActivityCollection(data[activityID.toString()]);
      }
    }));
    gameEventIDList.push(useNetData("collect_activity_data", data => {
      if (data[activityID.toString()]) {
        setRewardState(data[activityID.toString()]?.rewards ?? {});
      }
    }, Players.GetLocalPlayer()));
    gameEventIDList.push(useNetData("player_ornament", data => {
      setPlayerOrnament(data);
    }, Players.GetLocalPlayer()));
    libs.onCleanup(() => {
      gameEventIDList.forEach(id => GameEvents.Unsubscribe(id));
      netTableIDList.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    });
  });
  return libs.createComponent(BasePopup, {
    className: "Popup_IkunWinterTask",
    get PopupID() {
      return props.PopupID;
    },
    size: "large",
    title: "#Activity_IkunWinterCollection",
    get children() {
      return libs.createComponent(EOM_Panel.EOM_Panel, {
        width: "100%",
        height: "100%",
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "TopBar",
            get children() {
              return [libs.createComponent(EOM_Label.EOM_Label, {
                id: "TopRule",
                text: "#Activity_IkunWinterCollection_Description"
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "TopTitle",
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "Title_Collection",
                    get children() {
                      return libs.createComponent(EOM_Label.EOM_Label, {
                        text: "#Activity_IkunWinterTitle1"
                      });
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "Title_Progress",
                    get children() {
                      return libs.createComponent(EOM_Label.EOM_Label, {
                        text: "#Activity_IkunWinterTitle2"
                      });
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "Title_Reward",
                    get children() {
                      return libs.createComponent(EOM_Label.EOM_Label, {
                        text: "#Activity_Dianfengsai_3"
                      });
                    }
                  })];
                }
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            marginBottom: "130px",
            marginTop: "86px",
            width: "100%",
            height: "100%",
            flowChildren: "down",
            scroll: "y",
            get children() {
              return libs.createComponent(libs.Index, {
                get each() {
                  return taskIDList();
                },
                children: (taskid, index) => {
                  const collections = libs.createMemo(() => {
                    return activityCollection()[taskid()].items.split(",").sort((a, b) => {
                      const kv_a = KeyValues.CosmeticsKv[a];
                      const kv_b = KeyValues.CosmeticsKv[b];
                      return multiCompare((isOwnOrnament(a) ? 0 : 1) - (isOwnOrnament(b) ? 0 : 1), (kv_b.rarity ?? 0) - (kv_a.rarity ?? 0), Number(a) - Number(b));
                    });
                  });
                  const state = libs.createMemo(() => {
                    return rewardState()[taskid()] ?? 2;
                  });
                  const progress = libs.createMemo(() => {
                    let value = collections().length;
                    if (state() == 2) {
                      value = collections().reduce((prev, cur) => prev + (isOwnOrnament(cur) ? 1 : 0), 0);
                    }
                    return {
                      max: collections().length,
                      value: value
                    };
                  });
                  const rewards = libs.createMemo(() => {
                    return JSON.parseSafe(activityCollection()[taskid()].rewards);
                  });
                  const rewardsList = () => Object.keys(rewards());
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("IkunTaskCollect", {
                        Receive: state() == 0
                      });
                    },
                    get children() {
                      return [libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "TaskCollections",
                        scroll: "x",
                        get children() {
                          return libs.createComponent(libs.Index, {
                            get each() {
                              return collections();
                            },
                            children: (cid, _) => {
                              const rarity = () => {
                                return KeyValues.CosmeticsKv[cid()]?.rarity ?? 0;
                              };
                              const cosmeticTag = () => {
                                if (cid()) {
                                  return cid().toString().slice(0, 3);
                                }
                              };
                              return libs.createComponent(EOM_Panel.EOM_Panel, {
                                get className() {
                                  return libs.classNames("TaskCollection", "Rarity" + rarity(), {
                                    Own: isOwnOrnament(cid())
                                  });
                                },
                                onmouseover: self => {
                                  $.DispatchEvent("DOTAShowTitleTextTooltip", self, "#" + cid(), "#" + cid() + "_description");
                                },
                                onmouseout: self => {
                                  $.DispatchEvent("DOTAHideTitleTextTooltip", self);
                                },
                                get children() {
                                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                                    id: "TaskCollectionBG"
                                  }), libs.createComponent(CosmeticCard.CosmeticImage, {
                                    get itemid() {
                                      return cid();
                                    }
                                  }), libs.createComponent(libs.Show, {
                                    get when() {
                                      return cosmeticTag() != undefined;
                                    },
                                    get children() {
                                      return libs.createComponent(EOM_Image.EOM_Image, {
                                        className: "ExchangeItemImage_Tag",
                                        get src() {
                                          return getSrcPath(`store/cosmetic_tag/${cosmeticTag()}_${language == "schinese" ? "ch" : language == "russian" ? "ru" : "en"}.png`);
                                        }
                                      });
                                    }
                                  })];
                                }
                              });
                            }
                          });
                        }
                      }), libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "IkunTaskCollectLabel",
                        get children() {
                          return libs.createComponent(EOM_Label.EOM_Label, {
                            text: "#RewardProgress",
                            get dialogVariables() {
                              return {
                                value: progress().value,
                                max: progress().max
                              };
                            },
                            html: true
                          });
                        }
                      }), libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "IkunTaskCollectRight",
                        get children() {
                          return libs.createComponent(libs.Index, {
                            get each() {
                              return rewardsList();
                            },
                            children: (itemID, i) => {
                              return libs.createComponent(EOM_Button.EOM_BaseButton, {
                                get className() {
                                  return libs.classNames("IkunTaskCollectReward", {
                                    Receive: state() == 1
                                  });
                                },
                                get enabled() {
                                  return state() == 0;
                                },
                                onactivate: () => {
                                  callAction("activity_receive", {
                                    activity_id: activityID,
                                    reward_id: Number(taskid())
                                  });
                                },
                                get children() {
                                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                                    id: "IkunTaskCollectRewardBG"
                                  }), libs.createComponent(libs.Show, {
                                    get when() {
                                      return KeyValues.CosmeticsKv[itemID()] != undefined;
                                    },
                                    get fallback() {
                                      return libs.createComponent(ProductImage.ProductImage, {
                                        get itemid() {
                                          return itemID();
                                        }
                                      });
                                    },
                                    get children() {
                                      return libs.createComponent(CosmeticCard.CosmeticImage, {
                                        get itemid() {
                                          return itemID();
                                        },
                                        onmouseover: self => {
                                          $.DispatchEvent("DOTAShowTextTooltip", self, "#" + itemID());
                                        },
                                        onmouseout: self => {
                                          $.DispatchEvent("DOTAHideTextTooltip", self);
                                        }
                                      });
                                    }
                                  }), libs.createComponent(libs.Show, {
                                    get when() {
                                      return (rewards()[itemID()] ?? 1) > 1;
                                    },
                                    get children() {
                                      return libs.createComponent(EOM_Label.EOM_Label, {
                                        id: "IkunTaskCollectRewardCount",
                                        get text() {
                                          return "×" + (rewards()[itemID()] ?? 1);
                                        },
                                        hittest: false
                                      });
                                    }
                                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                    id: "IkunTaskCollectRewardLight",
                                    hittest: false
                                  }), libs.createComponent(EOM_Icon.EOM_Icon, {
                                    id: "RewardReceived",
                                    size: "48",
                                    get src() {
                                      return getSrcPath("icon/selected.png");
                                    },
                                    hittest: false
                                  }), libs.createComponent(libs.Show, {
                                    get when() {
                                      return state() == 0;
                                    },
                                    get children() {
                                      return libs.createComponent(MenuMarkIcon.MenuMarkIcon, {
                                        type: "default",
                                        hittest: false
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
                }
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "BottomBar",
            get children() {
              return libs.createComponent(libs.Show, {
                get when() {
                  return greatRewardData() != undefined;
                },
                get children() {
                  return (() => {
                    const collections = libs.createMemo(() => {
                      return (greatRewardData()?.items ?? "").split(",").sort((a, b) => {
                        const kv_a = KeyValues.CosmeticsKv[a];
                        const kv_b = KeyValues.CosmeticsKv[b];
                        return multiCompare((isOwnOrnament(a) ? 0 : 1) - (isOwnOrnament(b) ? 0 : 1), (kv_b.rarity ?? 0) - (kv_a.rarity ?? 0), Number(a) - Number(b));
                      });
                    });
                    const state = libs.createMemo(() => {
                      return rewardState()["1200109"] ?? 2;
                    });
                    const progress = libs.createMemo(() => {
                      let value = collections().length;
                      if (state() == 2) {
                        value = collections().reduce((prev, cur) => prev + (isOwnOrnament(cur) ? 1 : 0), 0);
                      }
                      return {
                        max: collections().length,
                        value: value
                      };
                    });
                    const rewards = libs.createMemo(() => {
                      return JSON.parseSafe(activityCollection()["1200109"].rewards);
                    });
                    const rewardsList = () => Object.keys(rewards());
                    return libs.createComponent(EOM_Panel.EOM_Panel, {
                      get className() {
                        return libs.classNames("IkunTaskCollect", {
                          Receive: state() == 0,
                          IsGreat: true
                        });
                      },
                      get children() {
                        return [libs.createComponent(EOM_Panel.EOM_Panel, {
                          id: "TaskCollections",
                          scroll: "x",
                          get children() {
                            return libs.createComponent(libs.Index, {
                              get each() {
                                return collections();
                              },
                              children: (cid, _) => {
                                const rarity = () => {
                                  return KeyValues.CosmeticsKv[cid()]?.rarity ?? 0;
                                };
                                const cosmeticTag = () => {
                                  if (cid()) {
                                    return cid().toString().slice(0, 3);
                                  }
                                };
                                return libs.createComponent(EOM_Panel.EOM_Panel, {
                                  get className() {
                                    return libs.classNames("TaskCollection", "Rarity" + rarity(), {
                                      Own: isOwnOrnament(cid())
                                    });
                                  },
                                  onmouseover: self => {
                                    $.DispatchEvent("DOTAShowTitleTextTooltip", self, "#" + cid(), "#" + cid() + "_description");
                                  },
                                  onmouseout: self => {
                                    $.DispatchEvent("DOTAHideTitleTextTooltip", self);
                                  },
                                  get children() {
                                    return [libs.createComponent(EOM_Panel.EOM_Panel, {
                                      id: "TaskCollectionBG"
                                    }), libs.createComponent(CosmeticCard.CosmeticImage, {
                                      get itemid() {
                                        return cid();
                                      }
                                    }), libs.createComponent(libs.Show, {
                                      get when() {
                                        return cosmeticTag() != undefined;
                                      },
                                      get children() {
                                        return libs.createComponent(EOM_Image.EOM_Image, {
                                          className: "ExchangeItemImage_Tag",
                                          get src() {
                                            return getSrcPath(`store/cosmetic_tag/${cosmeticTag()}_${language == "schinese" ? "ch" : language == "russian" ? "ru" : "en"}.png`);
                                          }
                                        });
                                      }
                                    })];
                                  }
                                });
                              }
                            });
                          }
                        }), libs.createComponent(EOM_Panel.EOM_Panel, {
                          id: "IkunTaskCollectLabel",
                          get children() {
                            return libs.createComponent(EOM_Label.EOM_Label, {
                              text: "#RewardProgress",
                              get dialogVariables() {
                                return {
                                  value: progress().value,
                                  max: progress().max
                                };
                              },
                              html: true
                            });
                          }
                        }), libs.createComponent(EOM_Panel.EOM_Panel, {
                          id: "IkunTaskCollectRight",
                          get children() {
                            return libs.createComponent(libs.Index, {
                              get each() {
                                return rewardsList();
                              },
                              children: (itemID, i) => {
                                return libs.createComponent(EOM_Button.EOM_BaseButton, {
                                  get className() {
                                    return libs.classNames("IkunTaskCollectReward", {
                                      Receive: state() == 1
                                    });
                                  },
                                  get enabled() {
                                    return state() == 0;
                                  },
                                  onactivate: () => {
                                    callAction("activity_receive", {
                                      activity_id: activityID,
                                      reward_id: Number("1200109")
                                    });
                                  },
                                  get children() {
                                    return [libs.createComponent(EOM_Panel.EOM_Panel, {
                                      id: "IkunTaskCollectRewardBG"
                                    }), libs.createComponent(libs.Show, {
                                      get when() {
                                        return KeyValues.CosmeticsKv[itemID()] != undefined;
                                      },
                                      get fallback() {
                                        return libs.createComponent(ProductImage.ProductImage, {
                                          get itemid() {
                                            return itemID();
                                          }
                                        });
                                      },
                                      get children() {
                                        return libs.createComponent(CosmeticCard.CosmeticImage, {
                                          get itemid() {
                                            return itemID();
                                          },
                                          onmouseover: self => {
                                            $.DispatchEvent("DOTAShowTextTooltip", self, "#" + itemID());
                                          },
                                          onmouseout: self => {
                                            $.DispatchEvent("DOTAHideTextTooltip", self);
                                          }
                                        });
                                      }
                                    }), libs.createComponent(libs.Show, {
                                      get when() {
                                        return (rewards()[itemID()] ?? 1) > 1;
                                      },
                                      get children() {
                                        return libs.createComponent(EOM_Label.EOM_Label, {
                                          id: "IkunTaskCollectRewardCount",
                                          get text() {
                                            return "×" + (rewards()[itemID()] ?? 1);
                                          },
                                          hittest: false
                                        });
                                      }
                                    }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                      id: "IkunTaskCollectRewardLight",
                                      hittest: false
                                    }), libs.createComponent(EOM_Icon.EOM_Icon, {
                                      id: "RewardReceived",
                                      size: "48",
                                      get src() {
                                        return getSrcPath("icon/selected.png");
                                      },
                                      hittest: false
                                    }), libs.createComponent(libs.Show, {
                                      get when() {
                                        return state() == 0;
                                      },
                                      get children() {
                                        return libs.createComponent(MenuMarkIcon.MenuMarkIcon, {
                                          type: "default",
                                          hittest: false
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
                  })();
                }
              });
            }
          })];
        }
      });
    }
  });
};

function removeHtmlTags(text) {
  return text.replace(/<.*?>/g, '');
}
const Popup_NewPlayerInvited = props => {
  const passwordText = () => {
    return removeHtmlTags($.Localize("#invitation_password"));
  };
  const [copiedPassword, setCopiedPassword] = libs.createSignal(false);
  const mainText = () => {
    return $.Localize("#copy_password") + ": " + $.Localize("#invitation_password");
  };
  return libs.createComponent(BasePopup, {
    get PopupID() {
      return props.PopupID;
    },
    title: "#Activity_NewPlayer",
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        height: '80%',
        width: '100%',
        get children() {
          return [libs.createComponent(libs.Show, {
            get when() {
              return copiedPassword();
            },
            get children() {
              return libs.createComponent(EOM_Icon.EOM_Icon, {
                size: "48",
                horizontalAlign: "center",
                marginTop: "100px",
                get src() {
                  return getSrcPath("icon/icon_party_ready_psd.png");
                }
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            align: 'center center',
            flowChildren: "down",
            get children() {
              return [libs.createComponent(EOM_Label.EOM_Label, {
                horizontalAlign: "center",
                fontSize: "26px",
                style: {
                  textAlign: "center"
                },
                color: "white",
                text: "#Activity_NewPlayerInvited",
                html: true
              }), libs.createComponent(EOM_Label.EOM_Label, {
                marginTop: "40px",
                horizontalAlign: "center",
                fontSize: "26px",
                style: {
                  textAlign: "center"
                },
                color: "white",
                get text() {
                  return mainText();
                },
                html: true
              })];
            }
          })];
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        align: 'center bottom',
        flowChildren: "right",
        get children() {
          return [libs.createComponent(EOM_Button.EOM_Button, {
            horizontalAlign: "right",
            color: "Blue",
            text: "#Popup_Button_Confirm",
            onactivate: () => {
              closePopup(props.PopupID);
            }
          }), libs.createComponent(EOM_Button.EOM_Button, {
            horizontalAlign: "right",
            get color() {
              return copiedPassword() ? "Gray" : "Gold";
            },
            text: "#copy_password",
            onactivate: () => {
              setCopiedPassword(true);
              $.DispatchEvent("CopyStringToClipboard", passwordText(), null);
            }
          })];
        }
      })];
    }
  });
};

const EOM_SearchBox = props => {
  const [local, others] = libs.splitProps(props, ["children", "onChange", "oninputsubmit", "text", "searchOnInput", "onSearch"]);
  let ref = undefined;
  const [value, setValue] = libs.createSignal(local.text ?? "");
  const onSearch = text => {
    if (local.onSearch) {
      local.onSearch(text ?? value(), ref);
    }
  };
  const onChange = text => {
    setValue(text);
    if (local.searchOnInput) {
      onSearch(text);
    }
  };
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "EOM_SearchBox",
      style: {
        whiteSpace: props.multiline ? "normal" : undefined
      }
    })), null);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "EOM_SearchBox",
      style: {
        whiteSpace: props.multiline ? "normal" : undefined
      }
    })), true);
    libs.insert(_el$, libs.createComponent(Player.EOM_TextEntry, {
      ref(r$) {
        const _ref$ = ref;
        typeof _ref$ === "function" ? _ref$(r$) : ref = r$;
      },
      placeholder: "#DOTA_Search",
      onChange: self => onChange(self.text),
      oninputsubmit: self => onSearch(self.text)
    }), null);
    libs.insert(_el$, libs.createComponent(EOM_Button.EOM_IconButton, {
      align: "right center",
      margin: "0px 8px",
      get icon() {
        return libs.createComponent(EOM_Image.EOM_Image, {
          width: "24px",
          height: "24px",
          backgroundImage: "url('s2r://panorama/images/control_icons/icon_search_shadow_psd.vtex')"
        });
      },
      onactivate: () => onSearch()
    }), null);
    return _el$;
  })();
};

GameEvents.Subscribe("order_payed", event => {
  if (event.state == 1) {
    showPopup("PaymentSuccess", {
      product_id: event.p_id,
      count: event.count
    });
  }
});
function RequestPaymentOrder(data, callback) {
  let request = {
    title: $.Localize("#" + data.product_id),
    body: $.Localize("#" + data.product_id + "_description"),
    product_id: data.product_id,
    product_num: data.count,
    contributor: GameUI.CustomUIConfig()._Player_Region,
    unique: data.unique,
    fast: data.fast ? 1 : 0
  };
  let pay_type = finiteNumber(Number(data.pay_way), -1);
  if (pay_type == -1) {
    pay_type = KeyValues.PaymentsOrderKV[data.pay_way]?.pid ?? -1;
  }
  if (pay_type == -1) {
    return "";
  }
  request.pay_type = pay_type;
  return serverRequest("order_create", request, response => {
    if (response.status == 0) {
      callback(true, response.data.payment_order.link);
    } else {
      callback(false, response.msg);
    }
  });
}
function recordPaymentHistory(payWay) {
  let max = 3;
  let historyList = [];
  const config = getPlayerData(Players.GetLocalPlayer(), "service_config");
  if (config != undefined) {
    historyList = (config.history_payment_type ?? "").split(",");
    let sameRecord = {};
    historyList.unshift(payWay);
    historyList = historyList.filter(item => {
      if (sameRecord[item]) {
        return false;
      }
      sameRecord[item] = true;
      return true;
    });
    if (historyList.length > max) {
      historyList = historyList.slice(0, max);
    }
    GameEvents.SendCustomEventToServer("PlayerSetKeyBind", {
      event_name: "history_payment_type",
      key: historyList.join(",")
    });
  }
  return historyList;
}
function getPaymentHistory() {
  const config = getPlayerData(Players.GetLocalPlayer(), "service_config");
  if (config != undefined) {
    return (config?.history_payment_type ?? "").split(",").filter(item => KeyValues.PaymentsOrderKV[item] != undefined).slice(0, 3);
  }
  return [];
}
const Popup_PaymentOrder = props => {
  const language = $.Language().toLowerCase();
  const [local, others] = libs.splitProps(props, ["itemData", "PopupID", "group", "count"]);
  const {
    itemData,
    count,
    group,
    PopupID
  } = local;
  const [tab, setTab] = libs.createSignal(0);
  const [filteredRegionIndex, setFilteredRegionIndex] = libs.createSignal(-1);
  const [searchText, setSearchText] = libs.createSignal("");
  const ChineseDefaultPayWay = ["Alipay", "WeChat_Pay"];
  const [qrinfo, setQrinfo] = libs.createStore({});
  const [payStateConfirm, setPayStateConfirm] = libs.createSignal(false);
  const mainPaymentList = [];
  let otherDefaultList = [];
  let paymentsRegions = [];
  let payPopupUnique = "";
  function createNewPopupUnique() {
    if (payPopupUnique != "") {
      payUniqueList = payUniqueList.filter(v => v != payPopupUnique);
    }
    payPopupUnique = doUniqueString(Players.GetLocalPlayer().toString() + "_");
  }
  let payUniqueList = [];
  createNewPopupUnique();
  const [historyPaymentList, setHistoryPaymentList] = libs.createSignal(getPaymentHistory());
  function PaymentWaySort(list, all = false) {
    return list.sort((a, b) => multiCompare(all ? (KeyValues.PaymentsOrderKV[b].region == "" ? 1 : 0) - (KeyValues.PaymentsOrderKV[a].region == "" ? 1 : 0) : (KeyValues.PaymentsOrderKV[a].region == "" ? 1 : 0) - (KeyValues.PaymentsOrderKV[b].region == "" ? 1 : 0), a < b ? -1 : a > b ? 1 : 0));
  }
  {
    Object.keys(KeyValues.PaymentsOrderKV).forEach(key => {
      if (KeyValues.PaymentsOrderKV[key].state != 1) {
        return;
      }
      let region = KeyValues.PaymentsOrderKV[key].region ?? "";
      if (region != "" && !paymentsRegions.includes(region)) {
        paymentsRegions.push(region);
      }
      let flag = false;
      if (language == "schinese") {
        flag = region == "CN";
      } else if (language == "russian") {
        flag = region == "RU" || region == "";
      } else {
        flag = region == "";
      }
      if (flag) {
        mainPaymentList.push(key);
      }
      otherDefaultList.push(key);
    });
    otherDefaultList = PaymentWaySort(otherDefaultList, true);
    paymentsRegions = paymentsRegions.sort((a, b) => a < b ? -1 : a > b ? 1 : 0);
    paymentsRegions.push("Global");
  }
  const [filteredPaymentList, setFilteredPaymentList] = libs.createSignal([]);
  libs.createEffect(() => {
    let filteredRegion = "";
    let otherList = otherDefaultList.concat([]);
    if (filteredRegionIndex() >= 0) {
      filteredRegion = paymentsRegions[filteredRegionIndex()];
      otherList = otherList.filter(v => KeyValues.PaymentsOrderKV[v].region == filteredRegion || KeyValues.PaymentsOrderKV[v].region == "");
    }
    if (searchText() != "") {
      let filteredList = [];
      let entries = searchText().toLowerCase().split(" ").filter(s => s != "");
      otherList.filter(key => {
        let localize = $.Localize("#PaymentWay_" + key).toLowerCase();
        if (entries.some(v => localize.includes(v) || key.toLowerCase().includes(v))) {
          filteredList.push(key);
        }
      });
      setFilteredPaymentList(PaymentWaySort(filteredList, filteredRegionIndex() == -1));
    } else {
      setFilteredPaymentList(PaymentWaySort(otherList, filteredRegionIndex() == -1));
    }
  });
  if (language == "schinese") {
    libs.onMount(() => {
      let requestIDList = [];
      ChineseDefaultPayWay.forEach(payWay => {
        let unique = doUniqueString(Players.GetLocalPlayer().toString() + "_");
        payUniqueList.push(unique);
        requestIDList.push(RequestPaymentOrder({
          product_id: itemData.id,
          count: count,
          pay_way: payWay,
          unique: unique
        }, (success, msg) => {
          if (success && msg) {
            setQrinfo(payWay, msg);
          }
        }));
      });
      libs.onCleanup(() => {
        requestIDList.forEach(id => cancelRequest(id));
      });
    });
  }
  libs.onMount(() => {
    let id = GameEvents.Subscribe("order_payed", event => {
      if (payUniqueList.includes(event.unique)) {
        if (event.state == 1) {
          closePopup(PopupID);
        } else {
          setPayStateConfirm(false);
        }
      }
    });
    libs.onCleanup(() => {
      GameEvents.Unsubscribe(id);
    });
  });
  function showOrderCreaterPopup(way) {
    setHistoryPaymentList(recordPaymentHistory(way));
    showPopup("PaymentOrderCreater", {
      product_id: itemData.id,
      count: count,
      pay_way: way,
      unique: payPopupUnique
    });
    payUniqueList.push(payPopupUnique);
    setPayStateConfirm(true);
  }
  libs.onCleanup(() => {
    payUniqueList.forEach(unique => {
      GameEvents.SendCustomEventToServer("order_pay_choice", {
        unique: unique,
        state: 0
      });
    });
  });
  return libs.createComponent(BasePopup, {
    PopupID: PopupID,
    group: group,
    "class": "Popup_PaymentOrder",
    title: "#Popup_StoreMoneyPayment_Title",
    closeOnClickOuter: false,
    closeOnEsc: false,
    get children() {
      return libs.createComponent(libs.Show, {
        get when() {
          return !payStateConfirm();
        },
        get fallback() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            align: "center center",
            id: "PaymentOrderMain",
            "class": language,
            get children() {
              return libs.createComponent(EOM_Label.EOM_Label, {
                horizontalAlign: "center",
                marginTop: "175px",
                text: "#PaymentOrder_isPaid"
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "PaymentOrderBottom",
            get children() {
              return [libs.createComponent(EOM_Button.EOM_Button, {
                align: "center center",
                marginLeft: "300px",
                color: "Green",
                text: "#PaymentOrder_Payed",
                onactivate: () => {
                  setPayStateConfirm(false);
                  GameEvents.SendCustomEventToServer("order_pay_choice", {
                    unique: payPopupUnique,
                    state: 1
                  });
                  createNewPopupUnique();
                }
              }), libs.createComponent(EOM_Button.EOM_Button, {
                align: "center center",
                marginRight: "300px",
                color: "Red",
                text: "#PaymentOrder_NotPayed",
                onactivate: () => {
                  setPayStateConfirm(false);
                  GameEvents.SendCustomEventToServer("order_pay_choice", {
                    unique: payPopupUnique,
                    state: 0
                  });
                  createNewPopupUnique();
                }
              })];
            }
          })];
        },
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "PaymentOrderTitle",
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "PaymentOrderInfo",
                get children() {
                  return [libs.createComponent(EOM_Label.EOM_Label, {
                    "class": "PaymentTitleLabel",
                    get text() {
                      return $.Localize("#StoreItemName") + ":";
                    }
                  }), libs.createComponent(EOM_Label.EOM_Label, {
                    width: "150px",
                    textOverflow: "shrink",
                    marginRight: "20px",
                    get text() {
                      return "#" + props.itemData.id;
                    }
                  }), libs.createComponent(EOM_Label.EOM_Label, {
                    "class": "PaymentTitleLabel",
                    get text() {
                      return $.Localize("#PaymentAmount") + ":";
                    }
                  }), libs.createComponent(EOM_Label.EOM_Label, {
                    color: "#FFD05F",
                    fontSize: "24px",
                    get text() {
                      return getStoreItemCost(itemData, count);
                    }
                  })];
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "PaymentOrderSearcher",
                get visible() {
                  return tab() == 1;
                },
                get children() {
                  return [libs.createComponent(EOM_DropDown.EOM_DropDown, {
                    id: "RegionFilterDropDown",
                    placeholder: "#PaymentRegion_Choice",
                    hasClear: true,
                    onChange: (index, item) => {
                      setFilteredRegionIndex(index);
                    },
                    onClear: () => {
                      setFilteredRegionIndex(-1);
                    },
                    get children() {
                      return paymentsRegions.map(region => libs.createComponent(EOM_Label.EOM_Label, {
                        text: `#PaymentRegion_${region}`
                      }));
                    }
                  }), libs.createComponent(EOM_SearchBox, {
                    searchOnInput: true,
                    onSearch: (text, self) => {
                      setSearchText(text);
                    }
                  })];
                }
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "PaymentOrderMain",
            "class": language,
            get children() {
              return libs.createComponent(libs.Switch, {
                get children() {
                  return [libs.createComponent(libs.Match, {
                    get when() {
                      return tab() == 1;
                    },
                    get children() {
                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                        "class": "PaymentsTypeList",
                        height: "100%",
                        get children() {
                          return libs.createComponent(libs.For, {
                            get each() {
                              return filteredPaymentList();
                            },
                            children: payWay => {
                              return (() => {
                                const _el$2 = libs.createElement("Panel", {
                                  "class": "Paytype"
                                }, null);
                                libs.setProp(_el$2, "onactivate", () => showOrderCreaterPopup(payWay));
                                libs.insert(_el$2, libs.createComponent(GenericPanel.CImage, {
                                  src: `file://{images}/custom_game/payment/payermax_icon/${payWay}.png`
                                }));
                                return _el$2;
                              })();
                            }
                          });
                        }
                      });
                    }
                  }), libs.createComponent(libs.Match, {
                    get when() {
                      return tab() == 0;
                    },
                    get children() {
                      return libs.createComponent(libs.Show, {
                        when: language != "schinese",
                        get fallback() {
                          return libs.createComponent(EOM_Panel.EOM_Panel, {
                            align: "center center",
                            flowChildren: "right",
                            get children() {
                              return ChineseDefaultPayWay.map(payType => {
                                return libs.createComponent(EOM_Panel.EOM_Panel, {
                                  width: "250px",
                                  height: "250px",
                                  margin: "0 40px",
                                  get children() {
                                    return libs.createComponent(libs.Show, {
                                      get when() {
                                        return qrinfo[payType] != undefined;
                                      },
                                      get fallback() {
                                        return libs.createComponent(EOM_Loading.EOM_Loading, {
                                          align: "center center",
                                          type: "Wave"
                                        });
                                      },
                                      get children() {
                                        return libs.createComponent(EOM_QRCode.EOM_QRCode, {
                                          align: "center center",
                                          get value() {
                                            return qrinfo[payType];
                                          },
                                          qrcodesize: 200,
                                          imageSrc: `file://{images}/custom_game/payment/${payType}_logo.png`
                                        });
                                      }
                                    });
                                  }
                                });
                              });
                            }
                          });
                        },
                        get children() {
                          return [libs.createComponent(libs.Show, {
                            get when() {
                              return historyPaymentList().length > 0;
                            },
                            get children() {
                              return libs.createComponent(EOM_Panel.EOM_Panel, {
                                width: "100%",
                                flowChildren: "right",
                                get children() {
                                  return [libs.createComponent(EOM_Label.EOM_Label, {
                                    "class": "PaymentTitleLabel",
                                    marginTop: "40px",
                                    text: "#PaymentWayLast"
                                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                    "class": "PaymentsTypeList NoBorder",
                                    get children() {
                                      return libs.createComponent(libs.For, {
                                        get each() {
                                          return historyPaymentList();
                                        },
                                        children: payWay => (() => {
                                          const _el$3 = libs.createElement("Panel", {
                                            "class": "Paytype"
                                          }, null);
                                          libs.setProp(_el$3, "onactivate", () => showOrderCreaterPopup(payWay));
                                          libs.insert(_el$3, libs.createComponent(GenericPanel.CImage, {
                                            src: `file://{images}/custom_game/payment/payermax_icon/${payWay}.png`
                                          }));
                                          return _el$3;
                                        })()
                                      });
                                    }
                                  })];
                                }
                              });
                            }
                          }), libs.createComponent(EOM_Panel.EOM_Panel, {
                            width: "100%",
                            marginTop: "50px",
                            flowChildren: "right",
                            get children() {
                              return [libs.createComponent(EOM_Label.EOM_Label, {
                                "class": "PaymentTitleLabel",
                                marginTop: "40px",
                                text: "#PaymentWayUsual"
                              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                "class": "PaymentsTypeList NoBorder",
                                get children() {
                                  return libs.createComponent(libs.For, {
                                    each: mainPaymentList,
                                    children: payWay => (() => {
                                      const _el$4 = libs.createElement("Panel", {
                                        "class": "Paytype"
                                      }, null);
                                      libs.setProp(_el$4, "onactivate", () => showOrderCreaterPopup(payWay));
                                      libs.insert(_el$4, libs.createComponent(GenericPanel.CImage, {
                                        src: `file://{images}/custom_game/payment/payermax_icon/${payWay}.png`
                                      }));
                                      return _el$4;
                                    })()
                                  });
                                }
                              })];
                            }
                          })];
                        }
                      });
                    }
                  })];
                }
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "PaymentOrderBottom",
            get children() {
              return libs.createComponent(libs.Show, {
                get when() {
                  return tab();
                },
                get fallback() {
                  return libs.createComponent(EOM_Button.EOM_BaseButton, {
                    "class": "PaymentOrderTabButton",
                    onactivate: () => setTab(1),
                    get children() {
                      return [libs.createElement("Panel", {
                        id: "PaymentOrderTabButtonBG"
                      }, null), libs.createComponent(EOM_Label.EOM_Label, {
                        text: "#PaymentMoreType"
                      })];
                    }
                  });
                },
                get children() {
                  return libs.createComponent(EOM_Button.EOM_BaseButton, {
                    "class": "PaymentOrderTabButton reverse",
                    onactivate: () => setTab(0),
                    get children() {
                      return [libs.createElement("Panel", {
                        id: "PaymentOrderTabButtonBG"
                      }, null), libs.createComponent(EOM_Label.EOM_Label, {
                        text: "#PaymentNormalType"
                      })];
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
};
const Popup_PaymentOrderCreater = props => {
  const [local, others] = libs.splitProps(props, ["product_id", "PopupID", "group", "count", "unique", "pay_way"]);
  const {
    product_id,
    count,
    unique,
    pay_way,
    group,
    PopupID
  } = local;
  let isQRCode = KeyValues.PaymentsOrderKV[pay_way]?.QRCode == 1;
  const [state, setState] = libs.createSignal(0);
  const [msg, setMsg] = libs.createSignal("");
  libs.onMount(() => {
    let requestID = RequestPaymentOrder({
      product_id: product_id,
      count: count,
      pay_way: pay_way,
      unique: unique
    }, (success, msg) => {
      libs.batch(() => {
        if (success) {
          if (isQRCode) {
            setState(2);
          } else {
            if (msg) {
              $.DispatchEvent("ExternalBrowserGoToURL", msg);
            }
            setState(1);
          }
        } else {
          setState(-1);
        }
        setMsg(msg ?? "");
      });
    });
    let id = GameEvents.Subscribe("order_payed", event => {
      if (event.unique == unique) {
        closePopup(PopupID);
      }
    });
    libs.onCleanup(() => {
      GameEvents.Unsubscribe(id);
    });
    libs.onCleanup(() => {
      cancelRequest(requestID);
    });
  });
  return libs.createComponent(BasePopup, {
    PopupID: PopupID,
    group: group,
    "class": "Popup_PaymentOrderCreater",
    title: "#Popup_StoreMoneyPayment_Title",
    closeOnClickOuter: false,
    closeOnEsc: false,
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        width: "100%",
        height: "450px",
        horizontalAlign: "center",
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            align: "center center",
            flowChildren: "down",
            get children() {
              return libs.createComponent(libs.Switch, {
                get children() {
                  return [libs.createComponent(libs.Match, {
                    get when() {
                      return state() == 0;
                    },
                    get children() {
                      return [libs.createElement("Label", {
                        "class": "PopupMainLabel",
                        text: "#PaymentOrder_OrderCreating"
                      }, null), libs.createComponent(EOM_Loading.EOM_Loading, {
                        horizontalAlign: "center",
                        type: "Wave"
                      })];
                    }
                  }), libs.createComponent(libs.Match, {
                    get when() {
                      return state() == 1;
                    },
                    get children() {
                      return [libs.createElement("Label", {
                        "class": "PopupMainLabel",
                        text: "#PaymentOrder_OrderCreated"
                      }, null), (() => {
                        const _el$8 = libs.createElement("Label", {
                          "class": "PopupMainLabel",
                          id: "BrowserUrl",
                          text: "#PaymentOrder_OrderCreatedLink"
                        }, null);
                        libs.setProp(_el$8, "onactivate", () => {
                          $.DispatchEvent("CopyStringToClipboard", msg(), null);
                        });
                        return _el$8;
                      })()];
                    }
                  }), libs.createComponent(libs.Match, {
                    get when() {
                      return state() == 2;
                    },
                    get children() {
                      return libs.createComponent(EOM_QRCode.EOM_QRCode, {
                        align: "center center",
                        get value() {
                          return msg();
                        },
                        qrcodesize: 200,
                        imageSrc: `file://{images}/custom_game/payment/${pay_way}_logo.png`
                      });
                    }
                  }), libs.createComponent(libs.Match, {
                    get when() {
                      return state() == -1;
                    },
                    get children() {
                      return [libs.createElement("Image", {
                        "class": "PaymentOrderStateIcon Failure"
                      }, null), (() => {
                        const _el$0 = libs.createElement("Label", {
                          "class": "PopupMainLabel",
                          text: "#PaymentOrder_Failure",
                          get dialogVariables() {
                            return {
                              error: msg()
                            };
                          }
                        }, null);
                        libs.effect(_$p => libs.setProp(_el$0, "dialogVariables", {
                          error: msg()
                        }, _$p));
                        return _el$0;
                      })()];
                    }
                  })];
                }
              });
            }
          });
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        align: "center bottom",
        flowChildren: "right",
        get children() {
          return libs.createComponent(EOM_Button.EOM_Button, {
            text: "#Popup_Button_Cancel",
            onactivate: () => {
              closePopup(PopupID);
            }
          });
        }
      })];
    }
  });
};
const Popup_PaymentSuccess = props => {
  const [local, others] = libs.splitProps(props, ["product_id", "PopupID", "group", "count"]);
  const {
    product_id,
    count,
    group,
    PopupID
  } = local;
  const shop_data = getNetDataCache("info_shop_product_group_by_tag");
  let itemData = undefined;
  Object.values(shop_data).forEach(_list => {
    if (itemData == undefined) {
      itemData = _list.find(item => item.id == product_id);
    }
  });
  let cost = itemData != undefined ? getStoreItemCost(itemData, count) : undefined;
  return libs.createComponent(BasePopup, {
    PopupID: PopupID,
    group: group,
    "class": "Popup_PaymentSuccess",
    title: "#Popup_StoreMoneyPayment_Title",
    closeOnClickOuter: true,
    closeOnEsc: true,
    size: "small",
    get children() {
      return libs.createComponent(EOM_Panel.EOM_Panel, {
        width: "100%",
        height: "450px",
        horizontalAlign: "center",
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            align: "center center",
            flowChildren: "down",
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                horizontalAlign: "center",
                flowChildren: "right",
                marginBottom: "50px",
                get children() {
                  return [libs.createComponent(EOM_Label.EOM_Label, {
                    "class": "PaymentTitleLabel",
                    fontSize: "24px",
                    get text() {
                      return $.Localize("#StoreItemName") + ":";
                    }
                  }), libs.createComponent(EOM_Label.EOM_Label, {
                    width: "150px",
                    fontSize: "24px",
                    color: "#fff",
                    textOverflow: "shrink",
                    marginRight: "20px",
                    text: "#" + product_id
                  }), libs.createComponent(libs.Show, {
                    when: cost != undefined,
                    get children() {
                      return [libs.createComponent(EOM_Label.EOM_Label, {
                        "class": "PaymentTitleLabel",
                        fontSize: "24px",
                        get text() {
                          return $.Localize("#PaymentAmount") + ":";
                        }
                      }), libs.createComponent(EOM_Label.EOM_Label, {
                        color: "#FFD05F",
                        fontSize: "24px",
                        text: cost
                      })];
                    }
                  })];
                }
              }), libs.createElement("Image", {
                "class": "PaymentOrderStateIcon Success"
              }, null), libs.createComponent(EOM_Label.EOM_Label, {
                marginTop: "20px",
                horizontalAlign: "center",
                text: "#PaymentOrder_Success"
              })];
            }
          });
        }
      });
    }
  });
};

const Popup_PeakArena = props => {
  const [countdown, setCountdown] = libs.createSignal(5);
  libs.onMount(() => {
    const id = setInterval(() => {
      setCountdown(v => Math.max(0, v - 1));
    }, 1000);
    libs.onCleanup(() => {
      clearInterval(id);
    });
  });
  const buttonText = () => {
    let text = $.Localize("#Peak_Arena_Enter");
    if (countdown() > 0) {
      text += " (" + countdown() + ")";
    }
    return text;
  };
  return libs.createComponent(BasePopup, {
    className: "Popup_PeakArena",
    get PopupID() {
      return props.PopupID;
    },
    title: "#Peak_Arena",
    get children() {
      return libs.createComponent(EOM_Panel.EOM_Panel, {
        width: "100%",
        height: "100%",
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "MainContainer",
            align: "center top",
            marginTop: "25px",
            flowChildren: "down",
            get children() {
              return [libs.createComponent(EOM_Label.EOM_Label, {
                horizontalAlign: "center",
                id: "SubTitle",
                text: "#PeakScoreSchedule",
                html: true
              }), libs.createComponent(EOM_Label.EOM_Label, {
                horizontalAlign: "center",
                color: "#ffffff",
                text: "#PeakScore5_2",
                html: true,
                marginBottom: "25px"
              }), libs.createComponent(EOM_Label.EOM_Label, {
                id: "SubTitle",
                text: "#PeakScore5_at_4",
                html: true
              }), libs.createComponent(EOM_Label.EOM_Label, {
                text: "#PeakScore5_18",
                html: true
              }), libs.createComponent(EOM_Label.EOM_Label, {
                text: "#PeakScore5_19",
                html: true
              }), libs.createComponent(EOM_Label.EOM_Label, {
                text: "#PeakScore5_20",
                html: true
              })];
            }
          }), libs.createComponent(EOM_Button.EOM_Button, {
            id: "MainButton",
            align: "center bottom",
            get enabled() {
              return countdown() == 0;
            },
            color: "Blue",
            get text() {
              return buttonText();
            },
            onactivate: () => {
              $.DispatchEvent('DOTAShowCustomGamePage', 2852945816);
              $.DispatchEvent('DOTASubscribeToCustomGame', 2852945816);
            }
          })];
        }
      });
    }
  });
};

const Popup_PeakCupReward = props => {
  const rewardAllInfo = {
    "1": [{
      item_id: "temp_9",
      amounts: 1
    }, {
      item_id: "9314004",
      amounts: 1
    }, {
      item_id: "5750075",
      amounts: 1
    }, {
      item_id: "temp_6_0",
      amounts: 1
    }],
    "2": [{
      item_id: "temp_10",
      amounts: 1
    }, {
      item_id: "5750076",
      amounts: 1
    }, {
      item_id: "temp_6_90",
      amounts: 1
    }],
    "3": [{
      item_id: "temp_11",
      amounts: 1
    }, {
      item_id: "5750077",
      amounts: 1
    }, {
      item_id: "temp_6_90",
      amounts: 1
    }],
    "4": [{
      item_id: "temp_12",
      amounts: 1
    }, {
      item_id: "5750078",
      amounts: 1
    }, {
      item_id: "temp_6_90",
      amounts: 1
    }]
  };
  const rewardInfo = {
    "1": [{
      item_id: "1000001",
      amounts: 2000
    }, {
      item_id: "9310101",
      amounts: 1
    }, {
      item_id: "5750070",
      amounts: 1
    }, {
      item_id: "enter",
      amounts: 1
    }],
    "2": [{
      item_id: "1000001",
      amounts: 2000
    }, {
      item_id: "9310101",
      amounts: 1
    }, {
      item_id: "5750071",
      amounts: 1
    }, {
      item_id: "enter",
      amounts: 1
    }],
    "3": [{
      item_id: "1000001",
      amounts: 2000
    }, {
      item_id: "9310101",
      amounts: 1
    }, {
      item_id: "5750072",
      amounts: 1
    }, {
      item_id: "enter",
      amounts: 1
    }],
    "4": [{
      item_id: "1000001",
      amounts: 2000
    }, {
      item_id: "9310101",
      amounts: 1
    }, {
      item_id: "5750073",
      amounts: 1
    }, {
      item_id: "enter",
      amounts: 1
    }],
    "5-8": [{
      item_id: "1000001",
      amounts: 1000
    }, {
      item_id: "9310101",
      amounts: 1
    }, {
      item_id: "5750074",
      amounts: 1
    }],
    "9-16": [{
      item_id: "9310100",
      amounts: 1
    }, {
      item_id: "temp_8_30",
      amounts: 1
    }],
    "17-32": [{
      item_id: "9310100",
      amounts: 1
    }, {
      item_id: "temp_8_21",
      amounts: 1
    }],
    "33-64": [{
      item_id: "9310100",
      amounts: 1
    }, {
      item_id: "temp_8_14",
      amounts: 1
    }]
  };
  const [index, setindex] = libs.createSignal(1);
  const reward_info = libs.createMemo(() => {
    if (index() == 1) {
      return rewardInfo;
    }
    return rewardAllInfo;
  });
  return libs.createComponent(BasePopup, {
    className: "Popup_PeakCupReward",
    get PopupID() {
      return props.PopupID;
    },
    size: "large",
    title: "#Activity_Dianfengsai_Rankreward1",
    get children() {
      return libs.createComponent(EOM_Panel.EOM_Panel, {
        width: "100%",
        height: "100%",
        get children() {
          return [libs.createComponent(ScoreBoardTabButtons.ScoreBoardTabButtons, {
            group: "dianfengsai_rankreward",
            list: ["#PeakCup_Reward1", "#PeakCup_Reward2"],
            selected: 1,
            onChange: (index, item) => {
              setindex(index);
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "PeakRewardMain",
            scroll: "y",
            get children() {
              return libs.createComponent(libs.Index, {
                get each() {
                  return (() => Object.keys(reward_info()))();
                },
                children: (rank, i) => {
                  const reward = () => {
                    return reward_info()[rank()];
                  };
                  const [dialog, setDialog] = libs.createSignal();
                  const [rankText, setRankText] = libs.createSignal("");
                  libs.createEffect(() => {
                    const rankList = rank().split("-");
                    let data = {};
                    let text = "#Activity_Dianfengsai_Rankreward2";
                    if (rankList.length > 1) {
                      data = {
                        count1: finiteNumber(Number(rankList[0]), -1),
                        count2: finiteNumber(Number(rankList[1]), -1)
                      };
                      text = "#Activity_Dianfengsai_Rankreward3";
                    } else if (rankList) {
                      data = {
                        count: finiteNumber(Number(rank()), -1)
                      };
                    }
                    setRankText(text);
                    setDialog(data);
                  });
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("PeakCupRankReward", "Index" + i);
                    },
                    get children() {
                      return [libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "RankNumber",
                        get children() {
                          return i > 2 ? libs.createComponent(EOM_Label.EOM_Label, {
                            id: "RankNumberLabel",
                            get text() {
                              return rankText();
                            },
                            get dialogVariables() {
                              return dialog();
                            }
                          }) : libs.createComponent(EOM_Image.EOM_Image, {
                            id: "RankNumberImage"
                          });
                        }
                      }), libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "RewardList",
                        get children() {
                          return libs.createComponent(libs.Index, {
                            get each() {
                              return reward();
                            },
                            children: (info, index) => {
                              const [tempID, setTempID] = libs.createSignal(-1);
                              const [customTooltipData, setCustomTooltipData] = libs.createSignal();
                              const [rewardLabel, setRewardLabel] = libs.createSignal();
                              const [TempClass, setTempClass] = libs.createSignal("");
                              libs.createEffect(libs.on(info, _info => {
                                let rewardID = -1;
                                let expireTime = -1;
                                let tempID = -1;
                                let TempClass = "";
                                let customTooltipData;
                                let rewardLabel = "";
                                if (_info.item_id == "enter") {
                                  TempClass = "enter";
                                  rewardLabel = $.Localize("#Dianfengsai_tempReward_enter");
                                } else if (_info.item_id.startsWith("temp_")) {
                                  const idList = _info.item_id.split("_");
                                  TempClass = idList[1];
                                  tempID = finiteNumber(Number(idList[1]), -1);
                                  expireTime = finiteNumber(Number(idList[2]), -1);
                                  if (expireTime == 0) {
                                    rewardLabel = $.Localize("#Dianfengsai_tempReward_" + tempID, $.GetContextPanel());
                                    rewardLabel += `<br>(${$.Localize("#Expire_Permanent")})`;
                                  } else {
                                    rewardLabel = $.Localize("#Dianfengsai_tempReward_" + tempID, $.GetContextPanel()).replace(`[!d:count]`, expireTime.toString());
                                    if (expireTime > 0) {
                                      rewardLabel += `<br>(${expireTime + $.Localize("#day")})`;
                                    }
                                  }
                                  if (tempID == 6) {
                                    customTooltipData = {
                                      name: "cosmetic_tooltip",
                                      cosmeticID: 5200015,
                                      text: rewardLabel,
                                      showPreview: 1
                                    };
                                  }
                                  if (tempID == 8) {
                                    TempClass += "_" + expireTime;
                                  }
                                } else {
                                  const idList = _info.item_id.split("_");
                                  if (idList.length > 1) {
                                    rewardID = finiteNumber(Number(idList[0]), -1);
                                    tempID = rewardID;
                                    TempClass = _info.item_id;
                                    expireTime = finiteNumber(Number(idList[1]), -1);
                                    rewardLabel += $.Localize(`#${rewardID}`);
                                    if (expireTime >= 0) {
                                      if (expireTime == 0) {
                                        rewardLabel += `<br>(${$.Localize("#Expire_Permanent")})`;
                                      } else {
                                        rewardLabel += `<br>(${expireTime + $.Localize("#day")})`;
                                      }
                                    }
                                  } else {
                                    rewardID = finiteNumber(Number(_info.item_id), -1);
                                    tempID = rewardID;
                                    TempClass = _info.item_id;
                                    rewardLabel += $.Localize(`#${rewardID}`);
                                  }
                                }
                                if (_info.amounts > 1) {
                                  rewardLabel += "<br>x" + _info.amounts;
                                }
                                setTempID(tempID);
                                setCustomTooltipData(customTooltipData);
                                setRewardLabel(rewardLabel);
                                setTempClass(TempClass);
                              }));
                              return libs.createComponent(EOM_Panel.EOM_Panel, {
                                get className() {
                                  return libs.classNames("RewardContainer", "Index" + index);
                                },
                                get children() {
                                  return [libs.createComponent(libs.Switch, {
                                    get fallback() {
                                      return libs.createComponent(libs.Show, {
                                        get when() {
                                          return customTooltipData();
                                        },
                                        get fallback() {
                                          return libs.createComponent(EOM_Image.EOM_Image, {
                                            get className() {
                                              return libs.classNames("RewardImage", "Temp" + TempClass());
                                            }
                                          });
                                        },
                                        get children() {
                                          return libs.createComponent(EOM_Image.EOM_Image, {
                                            get className() {
                                              return libs.classNames("RewardImage", "Temp" + TempClass());
                                            },
                                            get customTooltip() {
                                              return customTooltipData();
                                            }
                                          });
                                        }
                                      });
                                    },
                                    get children() {
                                      return [libs.createComponent(libs.Match, {
                                        get when() {
                                          return KeyValues.CosmeticsKv[tempID()]?.tool == 1;
                                        },
                                        get children() {
                                          return libs.createComponent(EOM_Image.EOM_Image, {
                                            get className() {
                                              return libs.classNames("RewardImage");
                                            },
                                            get tooltip() {
                                              return "#" + tempID();
                                            }
                                          });
                                        }
                                      }), libs.createComponent(libs.Match, {
                                        get when() {
                                          return libs.memo(() => !!(tempID().toString().length == 7 && tempID().toString().startsWith("5")))() && tempID().toString().startsWith("575");
                                        },
                                        get children() {
                                          return libs.createComponent(libs.Show, {
                                            get when() {
                                              return $.BImageFileExists(getCosmeticImagePath(tempID().toString(), undefined, false));
                                            },
                                            get fallback() {
                                              return libs.createComponent(EOM_Image.EOM_Image, {
                                                get className() {
                                                  return libs.classNames("RewardImage");
                                                }
                                              });
                                            },
                                            get children() {
                                              return libs.createComponent(WinStreak.PlayerAvatarMedal, {
                                                get oid() {
                                                  return tempID().toString();
                                                },
                                                get tooltip() {
                                                  return "#" + tempID();
                                                }
                                              });
                                            }
                                          });
                                        }
                                      }), libs.createComponent(libs.Match, {
                                        get when() {
                                          return libs.memo(() => tempID().toString().length == 7)() && tempID().toString().startsWith("5");
                                        },
                                        get children() {
                                          return libs.createComponent(EOM_Image.EOM_Image, {
                                            className: "CosmeticImage",
                                            get src() {
                                              return getCosmeticImagePath(tempID().toString());
                                            },
                                            get tooltip() {
                                              return "#" + tempID();
                                            }
                                          });
                                        }
                                      }), libs.createComponent(libs.Match, {
                                        get when() {
                                          return libs.memo(() => tempID().toString().length == 7)() && tempID().toString().startsWith("9");
                                        },
                                        get children() {
                                          return libs.createComponent(EOM_Image.EOM_Image, {
                                            className: "CosmeticImage",
                                            get src() {
                                              return getSrcPath(`backpack_items/${tempID().toString()}.png`);
                                            },
                                            get tooltip() {
                                              return "#" + tempID();
                                            }
                                          });
                                        }
                                      }), libs.createComponent(libs.Match, {
                                        get when() {
                                          return tempID().toString().length == 7;
                                        },
                                        get children() {
                                          return libs.createComponent(EOM_Image.EOM_Image, {
                                            className: "CosmeticImage",
                                            get src() {
                                              return getSrcPath(`store_items/${tempID().toString()}.png`);
                                            },
                                            get tooltip() {
                                              return "#" + tempID();
                                            }
                                          });
                                        }
                                      })];
                                    }
                                  }), libs.createComponent(EOM_Label.EOM_Label, {
                                    id: "RewardName",
                                    html: true,
                                    get text() {
                                      return rewardLabel();
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
                }
              });
            }
          })];
        }
      });
    }
  });
};

const Popup_PeakCupScore = props => {
  const [PeakCupInfo, setPeakCupInfo] = libs.createSignal(getServiceNetTable("peak_cup_information")?.round_info?.[props.round.toString()]?.[props.region]?.[props.team.toString()] ?? []);
  libs.onMount(() => {
    const id = useServiceNetTable("peak_cup_information", data => {
      setPeakCupInfo(data?.round_info?.[props.round.toString()]?.[props.region]?.[props.team.toString()] ?? []);
    });
    libs.onCleanup(() => {
      CustomNetTables.UnsubscribeNetTableListener(id);
    });
  });
  const hasResult = libs.createMemo(() => {
    return PeakCupInfo().some(v => v.score_rank != undefined && v.score_rank != 0);
  });
  const InfoList = () => {
    return PeakCupInfo().sort((a, b) => {
      return multiCompare((a.score_rank ?? 10) - (b.score_rank ?? 10), (a.location ?? 0) - (b.location ?? 0));
    });
  };
  return libs.createComponent(BasePopup, {
    className: "Popup_PeakCupScore",
    get PopupID() {
      return props.PopupID;
    },
    title: "#Activity_Dianfengsai_Rank3",
    get children() {
      return libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "PeakScoreMain",
        scroll: "y",
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "Title",
            flowChildren: "right",
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                get visible() {
                  return hasResult();
                },
                "class": "c1",
                get children() {
                  return libs.createElement("Label", {
                    text: "#Activity_Dianfengsai_Rank1"
                  }, null);
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                "class": "c2",
                get children() {
                  return libs.createElement("Label", {
                    text: "#Activity_Dianfengsai_Rank2"
                  }, null);
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                "class": "c3",
                get children() {
                  return libs.createElement("Label", {
                    text: "#Activity_Dianfengsai_Rank3"
                  }, null);
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                "class": "c4",
                get children() {
                  return libs.createElement("Label", {
                    text: "#Activity_Dianfengsai_Rank4"
                  }, null);
                }
              })];
            }
          }), libs.createComponent(libs.Index, {
            get each() {
              return InfoList();
            },
            children: (info, i) => {
              const playerRank = () => info().score_rank ?? 0;
              const playerWin = () => info().win_state == 1;
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("PeakScoreRow", "Rank" + playerRank());
                },
                flowChildren: "right",
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    get visible() {
                      return hasResult();
                    },
                    "class": "c1",
                    get children() {
                      return libs.createComponent(libs.Switch, {
                        get children() {
                          return [libs.createComponent(libs.Match, {
                            get when() {
                              return playerRank() > 3;
                            },
                            get children() {
                              const _el$5 = libs.createElement("Label", {
                                id: "RankNumberLabel",
                                text: "#player_rank",
                                get dialogVariables() {
                                  return {
                                    rank: playerRank()
                                  };
                                }
                              }, null);
                              libs.effect(_$p => libs.setProp(_el$5, "dialogVariables", {
                                rank: playerRank()
                              }, _$p));
                              return _el$5;
                            }
                          }), libs.createComponent(libs.Match, {
                            get when() {
                              return libs.memo(() => playerRank() > 0)() && playerRank() <= 3;
                            },
                            get children() {
                              return libs.createComponent(EOM_Image.EOM_Image, {
                                id: "RankNumberImage"
                              });
                            }
                          })];
                        }
                      });
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    "class": "c2",
                    get children() {
                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "PlayerInfo",
                        get children() {
                          return [libs.createComponent(EOM_Panel.EOM_Panel, {
                            id: "AvatorContainter",
                            get children() {
                              return libs.createComponent(Player.EOM_Avatar, {
                                get accountid() {
                                  return info().uid.toString();
                                }
                              });
                            }
                          }), libs.createComponent(libs.Show, {
                            get when() {
                              return playerWin();
                            },
                            get children() {
                              return libs.createComponent(EOM_Panel.EOM_Panel, {
                                id: "PlayerWin",
                                get children() {
                                  return libs.createElement("Label", {
                                    text: "#Activity_Dianfengsai_22"
                                  }, null);
                                }
                              });
                            }
                          }), libs.createComponent(Player.EOM_UserName, {
                            get accountid() {
                              return info().uid.toString();
                            }
                          })];
                        }
                      });
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    "class": "c3",
                    get children() {
                      const _el$7 = libs.createElement("Label", {
                        get text() {
                          return info().score;
                        }
                      }, null);
                      libs.effect(_$p => libs.setProp(_el$7, "text", info().score, _$p));
                      return _el$7;
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    "class": "c4",
                    get children() {
                      const _el$8 = libs.createElement("Label", {
                        get text() {
                          return info().score_detail ?? "#Access_none";
                        }
                      }, null);
                      libs.effect(_$p => libs.setProp(_el$8, "text", info().score_detail ?? "#Access_none", _$p));
                      return _el$8;
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

const Popup_PeakSignUp = props => {
  const language = $.Language().toLowerCase();
  const [select1, setSelect1] = libs.createSignal(props.region);
  const [select2, setSelect2] = libs.createSignal();
  (() => {
    let enable = false;
    let _time = getPeakScoreRegionTime();
    let server_time = ServerTimestamp();
    if (server_time >= _time.start_time && server_time < _time.end_time) {
      enable = true;
    }
    return enable;
  })();
  libs.createEffect(libs.on(select1, v => {
    setSelect2();
  }));
  const buttonEnable = () => {
    return select2() != undefined && select1() != undefined && contactWarn1() == 2 && contactWarn2() == 2;
  };
  const [cooldown, setCooldown] = libs.createSignal(false);
  libs.createSignal(false);
  const [contact1, setContact1] = libs.createSignal("");
  const [contactWarn1, setContactWarn1] = libs.createSignal(0);
  const [contact2, setContact2] = libs.createSignal("");
  const [contactWarn2, setContactWarn2] = libs.createSignal(0);
  let searchEntry1;
  let searchEntry2;
  libs.createEffect(libs.on(contact1, v => {
    if (!v || v == "") {
      setContactWarn1(0);
    } else {
      if (language == "schinese") {
        let qq = finiteNumber(Number(v), -1);
        if (qq != -1 && !v.includes(" ")) {
          setContactWarn1(2);
        } else {
          setContactWarn1(1);
        }
      } else {
        if (v.includes(" ")) {
          setContactWarn1(1);
        } else {
          setContactWarn1(2);
        }
      }
    }
  }));
  libs.createEffect(libs.on([contact1, contact2], () => {
    if (contact1() != "" && contact2() != "" && contactWarn1() == 2) {
      if (contact1() != contact2()) {
        if (!contact1().startsWith(contact2())) {
          setContactWarn2(1);
        } else {
          setContactWarn2(0);
        }
      } else {
        setContactWarn2(2);
      }
    } else {
      setContactWarn2(0);
    }
  }));
  return libs.createComponent(BasePopup, {
    className: "Popup_PeakCupScore",
    get PopupID() {
      return props.PopupID;
    },
    title: "#PeakCup_SelectRegion",
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "SelectRegionMain",
        marginBottom: "120px",
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "SelectRegionMainIn",
            scroll: "y",
            flowChildren: "down",
            height: "100%",
            width: "100%",
            onactivate: () => {
              if (searchEntry1?.IsValid()) {
                setContact1(searchEntry1.text);
                $.DispatchEvent("DropInputFocus", searchEntry1);
              }
              if (searchEntry2?.IsValid()) {
                setContact2(searchEntry2.text);
                $.DispatchEvent("DropInputFocus", searchEntry2);
              }
            },
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "subTitle",
                get children() {
                  return [libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#PeakCup_SignUp1"
                  }), libs.createComponent(EOM_Separator.EOM_Separator, {})];
                }
              }), libs.createComponent(EOM_Button.EOM_BaseButton, {
                get className() {
                  return libs.classNames("FeebackTypeButton", {
                    Selected: select1() == "1"
                  });
                },
                onactivate: () => {
                  setSelect1("1");
                },
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "FeebackTypeCircle"
                  }), libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#PeakCup_SignUpRegion_1"
                  })];
                }
              }), libs.createComponent(EOM_Button.EOM_BaseButton, {
                get className() {
                  return libs.classNames("FeebackTypeButton", {
                    Selected: select1() == "2"
                  });
                },
                onactivate: () => {
                  setSelect1("2");
                },
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "FeebackTypeCircle"
                  }), libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#PeakCup_SignUpRegion_2"
                  })];
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "subTitle",
                get children() {
                  return [libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#PeakCup_SignUp2"
                  }), libs.createComponent(EOM_Separator.EOM_Separator, {})];
                }
              }), libs.createComponent(EOM_Button.EOM_BaseButton, {
                get className() {
                  return libs.classNames("FeebackTypeButton", {
                    Selected: select2() == "1"
                  });
                },
                onactivate: () => {
                  setSelect2("1");
                },
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "FeebackTypeCircle"
                  }), () => {
                    const text = () => {
                      if (select1()) {
                        return `#PeakCup_SignUp2_${select1()}1`;
                      }
                      return "#PeakCup_SignUp2_11";
                    };
                    return libs.createComponent(EOM_Label.EOM_Label, {
                      get text() {
                        return text();
                      }
                    });
                  }];
                }
              }), libs.createComponent(EOM_Button.EOM_BaseButton, {
                get className() {
                  return libs.classNames("FeebackTypeButton", {
                    Selected: select2() == "2"
                  });
                },
                onactivate: () => {
                  setSelect2("2");
                },
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "FeebackTypeCircle"
                  }), () => {
                    const text = () => {
                      if (select1()) {
                        return `#PeakCup_SignUp2_${select1()}2`;
                      }
                      return "#PeakCup_SignUp2_12";
                    };
                    return libs.createComponent(EOM_Label.EOM_Label, {
                      get text() {
                        return text();
                      }
                    });
                  }];
                }
              }), libs.createComponent(EOM_Button.EOM_BaseButton, {
                get className() {
                  return libs.classNames("FeebackTypeButton", {
                    Selected: select2() == "3"
                  });
                },
                onactivate: () => {
                  setSelect2("3");
                },
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "FeebackTypeCircle"
                  }), libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#PeakCup_SignUp3"
                  })];
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "subTitle",
                get children() {
                  return [libs.createComponent(libs.Show, {
                    when: language == "schinese",
                    get fallback() {
                      return libs.createComponent(EOM_Label.EOM_Label, {
                        text: "#Contact_2"
                      });
                    },
                    get children() {
                      return libs.createComponent(EOM_Label.EOM_Label, {
                        text: "#Contact_1"
                      });
                    }
                  }), libs.createComponent(EOM_Separator.EOM_Separator, {})];
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                flowChildren: "right",
                get children() {
                  return [libs.createComponent(Player.EOM_TextEntry, {
                    ref(r$) {
                      const _ref$ = searchEntry1;
                      typeof _ref$ === "function" ? _ref$(r$) : searchEntry1 = r$;
                    },
                    placeholder: "#InputWarn",
                    onChange: (self, previousText, changedText) => {
                      setContact1(changedText);
                    }
                  }), libs.createComponent(libs.Switch, {
                    get children() {
                      return [libs.createComponent(libs.Match, {
                        get when() {
                          return contactWarn1() == 1;
                        },
                        get children() {
                          return libs.createComponent(EOM_Label.EOM_Label, {
                            id: "ContactWarn",
                            text: "#InputInvalid"
                          });
                        }
                      }), libs.createComponent(libs.Match, {
                        get when() {
                          return libs.memo(() => contactWarn1() == 2)() && contactWarn2() == 2;
                        },
                        get children() {
                          return libs.createComponent(EOM_Label.EOM_Label, {
                            id: "ContactWarn",
                            "class": "Right",
                            text: "#InputPass"
                          });
                        }
                      })];
                    }
                  })];
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "subTitle",
                get children() {
                  return [libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#ContactAgain"
                  }), libs.createComponent(EOM_Separator.EOM_Separator, {})];
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                flowChildren: "right",
                get children() {
                  return [libs.createComponent(Player.EOM_TextEntry, {
                    ref(r$) {
                      const _ref$2 = searchEntry2;
                      typeof _ref$2 === "function" ? _ref$2(r$) : searchEntry2 = r$;
                    },
                    placeholder: "#InputWarn",
                    oninputsubmit: self => {},
                    onChange: (self, previousText, changedText) => {
                      setContact2(changedText);
                    }
                  }), libs.createComponent(libs.Switch, {
                    get children() {
                      return [libs.createComponent(libs.Match, {
                        get when() {
                          return contactWarn2() == 1;
                        },
                        get children() {
                          return libs.createComponent(EOM_Label.EOM_Label, {
                            id: "ContactWarn",
                            text: "#InputNotSame"
                          });
                        }
                      }), libs.createComponent(libs.Match, {
                        get when() {
                          return libs.memo(() => contactWarn1() == 2)() && contactWarn2() == 2;
                        },
                        get children() {
                          return libs.createComponent(EOM_Label.EOM_Label, {
                            id: "ContactWarn",
                            "class": "Right",
                            text: "#InputPass"
                          });
                        }
                      })];
                    }
                  })];
                }
              })];
            }
          });
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "BottomContainer",
        get children() {
          return [libs.createComponent(EOM_Label.EOM_Label, {
            id: "PeakCupTips1",
            text: "#PeakCup_SignUp4",
            html: true
          }), libs.createComponent(EOM_Label.EOM_Label, {
            id: "PeakCupTips2",
            text: "#PeakCup_SignUp5",
            html: true
          }), libs.createComponent(EOM_Button.EOM_Button, {
            id: "PeakSignUpButton",
            get enabled() {
              return libs.memo(() => !!!cooldown())() && buttonEnable();
            },
            color: "Blue",
            text: "#Popup_Button_Confirm",
            onactivate: () => {
              setCooldown(true);
              $.Schedule(3, () => {
                setCooldown(false);
              });
              if (props.count < 5) {
                showPopup("ErrorMessage", {
                  msg: "#PeakScoreSignIn_ERROR1"
                });
                return;
              }
              let region = select1() ?? "default";
              let valid_date = "any_time";
              if (select2() == "1") {
                valid_date = "20260115";
              } else if (select2() == "2") {
                valid_date = "20260116";
              }
              let contact_information = "discord ";
              if (language == "schinese") {
                contact_information = "qq ";
              }
              contact_information += contact2();
              serverRequest("competition_update_region", {
                region,
                valid_date,
                contact_information
              }, data => {
                if (data.status == 0) {
                  showPopup("Confrim", {
                    title: "#PeakCup_SelectRegion",
                    msg: "#PeakCup_SignUpSuccess",
                    callback: () => {
                      closePopup(props.PopupID);
                    }
                  });
                } else {
                  showPopup("Confrim", {
                    title: "#PeakCup_SelectRegion",
                    msg: "#PeakCup_SignUpFailed"
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

const Popup_PlayerProfile = props => {
  const [loading, setLoading] = libs.createSignal(true);
  const [winCount, setWinCount] = libs.createSignal(0);
  const [fourCount, setFourCount] = libs.createSignal(0);
  const [allCount, setAllCount] = libs.createSignal(0);
  const [heroCount, setHeroCount] = libs.createSignal(0);
  const [medalCount, setMedalCount] = libs.createSignal(0);
  const [loginDay, setLoginDay] = libs.createSignal(0);
  const [playerVipExpire, setPlayerVipExpire] = libs.createSignal(0);
  const [player_rank_score, setPlayerRankScore] = libs.createSignal({});
  const [season_game_summary, setSeasonGameSummary] = libs.createSignal({});
  const [player_ornament_slots, setPlayerOrnamentSlots] = libs.createSignal([]);
  const maxCup = () => {
    let max = 0;
    const data = player_rank_score();
    for (let season in data) {
      let v = data[season];
      if (v.highest_rank_score > max) {
        max = v.highest_rank_score;
      }
    }
    return max;
  };
  const heroName = libs.createMemo(() => {
    const data = player_ornament_slots().find(v => v.slot == 21);
    if (data) {
      return data.oid.toString();
    }
  });
  const courierName = libs.createMemo(() => {
    const data = player_ornament_slots().find(v => v.slot == 20);
    if (data) {
      return data.oid.toString();
    }
  });
  libs.onMount(() => {
    if (props.uid) {
      serverRequest("player_brief", {
        uid: props.uid
      }, data => {
        setLoading(false);
        if (data.status == 0 && data.data) {
          libs.batch(() => {
            setMedalCount(data.data.player_medal?.now_medal ?? 0);
            setWinCount(data.data.game_summary?.rank_1_count ?? 0);
            setFourCount(data.data.game_summary?.win_count ?? 0);
            setAllCount(data.data.game_summary?.total_count ?? 0);
            setHeroCount(data.data.player_hero_count ?? 0);
            setLoginDay(data.data.login_data?.total_login_days ?? 0);
            setPlayerRankScore(data.data.player_rank_score ?? {});
            setSeasonGameSummary(data.data.season_game_summary ?? {});
            setPlayerOrnamentSlots(data.data.player_ornament_slots ?? []);
            setPlayerVipExpire(data.data.player_vip?.expire ?? 0);
          });
        }
      });
    }
  });
  return libs.createComponent(BasePopup, {
    get PopupID() {
      return props.PopupID;
    },
    className: "Popup_PlayerProfile",
    size: "large",
    title: "#ProfileTag_SelfInfo",
    get children() {
      return libs.createComponent(profile_simplify.ProfileInfoLayout, {
        get medalCount() {
          return medalCount();
        },
        get winCount() {
          return winCount();
        },
        get fourCount() {
          return fourCount();
        },
        get allCount() {
          return allCount();
        },
        get maxCup() {
          return maxCup();
        },
        get heroCount() {
          return heroCount();
        },
        get loginDay() {
          return loginDay();
        },
        get heroName() {
          return heroName();
        },
        get courierName() {
          return courierName();
        },
        get playerVipExpire() {
          return playerVipExpire();
        },
        get popupInfo() {
          return {
            uid: (props.uid ?? -1).toString(),
            player_rank_score: player_rank_score(),
            season_game_summary: season_game_summary(),
            ornament: props.ornament_equipted ?? {},
            player_ornament_slots: player_ornament_slots()
          };
        },
        get ban() {
          return props.ban;
        }
      });
    }
  });
};

const language = $.Language().toLowerCase();
const Popup_PlayerQuestionnaire = props => {
  const [playerQuestionnaireList, setPlayerQuestionnaireList] = libs.createSignal([]);
  const [questionnaireVersion, setQuestionnaireVersion] = libs.createSignal("");
  libs.onMount(() => {
    const id = useNetData("player_questionnaire", data => {
      if (data && data.questions) {
        if (data.questions) {
          setPlayerQuestionnaireList(data.questions);
        }
        if (data.version) {
          setQuestionnaireVersion(data.version);
        }
      }
    }, Players.GetLocalPlayer());
    libs.onCleanup(() => {
      GameEvents.Unsubscribe(id);
    });
  });
  const [questionnaireAnswer, setQuestionnaireAnswer] = libs.createSignal({});
  const updateQuestionnaireAnswer = (AnswerIndex, newAnswer) => {
    let newAnswerData = Object.assign({}, questionnaireAnswer());
    newAnswerData[AnswerIndex] = newAnswer;
    const list = playerQuestionnaireList();
    let questionnaireData = list[Number(AnswerIndex)];
    if (questionnaireData) {
      list.forEach((item, index) => {
        if (item.condition && item.condition[AnswerIndex] != undefined) {
          if (questionnaireData.options) {
            let optionsList = questionnaireData.options.map(v => v.choice);
            if (optionsList[item.condition[AnswerIndex]] && newAnswer.indexOf(optionsList[item.condition[AnswerIndex]]) != -1) ; else {
              delete newAnswerData[index];
            }
          }
        }
      });
    }
    setQuestionnaireAnswer(newAnswerData);
  };
  const [cooldown, setCooldown] = libs.createSignal(false);
  const submitEnable = () => {
    if (cooldown()) {
      return false;
    }
    const _playerQuestionnaireList = playerQuestionnaireList();
    const _questionnaireAnswer = questionnaireAnswer();
    for (let i = 0; i < _playerQuestionnaireList.length; i++) {
      if (_playerQuestionnaireList[i].condition == undefined && (_questionnaireAnswer[i.toString()] == undefined || _questionnaireAnswer[i.toString()] == "")) {
        return false;
      }
    }
    return true;
  };
  const [submitted, setSubmitted] = libs.createSignal(false);
  const submit = () => {
    serverRequest("QuestionnaireSubmition", {
      version: questionnaireVersion(),
      lang: language,
      answer: questionnaireAnswer()
    }, data => {
      if (data.status == 0) {
        setSubmitted(true);
      }
    });
  };
  return libs.createComponent(BasePopup, {
    get PopupID() {
      return props.PopupID;
    },
    className: "Popup_PlayerQuestionnaire",
    title: "#Popup_PlayerQuestionnaire",
    get children() {
      return libs.createComponent(libs.Show, {
        get when() {
          return !submitted();
        },
        get fallback() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            align: "center center",
            flowChildren: "right",
            get children() {
              return [libs.createComponent(EOM_Image.EOM_Image, {
                verticalAlign: "center",
                get backgroundImage() {
                  return getImagePath("icon/icon_party_ready_psd.png");
                },
                width: "35px",
                height: "34px"
              }), libs.createComponent(EOM_Label.EOM_Label, {
                verticalAlign: "center",
                color: "#ffffff",
                text: "#Popup_PlayerQuestionnaire_Thank"
              })];
            }
          });
        },
        get children() {
          return [libs.createComponent(EOM_Label.EOM_Label, {
            id: "PlayerQuestionnaireMain",
            text: "#Popup_PlayerQuestionnaire_Main",
            html: true
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            scroll: "y",
            flowChildren: "down",
            width: "100%",
            height: "100%",
            marginBottom: "70px",
            get children() {
              return libs.createComponent(libs.Index, {
                get each() {
                  return playerQuestionnaireList();
                },
                children: (item, itemIndex) => {
                  const type = () => item().type;
                  const condition = () => item().condition;
                  const questions = () => item().options;
                  const QuestionShow = libs.createMemo(() => {
                    const _condition = condition();
                    if (_condition == undefined) {
                      return true;
                    }
                    const questionnaireList = playerQuestionnaireList();
                    const _questionnaireAnswer = questionnaireAnswer();
                    let f = true;
                    for (const id in _condition) {
                      let _conditionID = Number(id);
                      const questionnaire = questionnaireList[_conditionID];
                      let ff = false;
                      if (questionnaire && questionnaire.options && questionnaire.options.length > 0 && (questionnaire.type == "single" || questionnaire.type == "multiple")) {
                        const answer = _questionnaireAnswer[_conditionID.toString()];
                        if (answer) {
                          const questionnaireOptions = questionnaire.options;
                          const optionsIndex = _condition[id];
                          if (answer) {
                            let _answerList = answer.split(",");
                            for (let j = 0; j < _answerList.length; j++) {
                              if (optionsIndex == questionnaireOptions.findIndex(v => v.choice == _answerList[j])) {
                                ff = true;
                                break;
                              }
                            }
                          }
                        }
                      }
                      if (!ff) {
                        f = false;
                        break;
                      }
                    }
                    return f;
                  });
                  let content_text = () => {
                    let defualtText = item().content.en ?? "...";
                    let extraText = "";
                    if (type() == "multiple") {
                      extraText = ` ${$.Localize("#questionnaire_multiple")}`;
                    }
                    switch (language) {
                      case "schinese":
                        return (item().content.cn ?? defualtText) + extraText;
                      case "tchinese":
                        return (item().content.cn ?? defualtText) + extraText;
                      case "russian":
                        return (item().content.ru ?? defualtText) + extraText;
                      default:
                        return (item().content.en ?? defualtText) + extraText;
                    }
                  };
                  return libs.createComponent(libs.Show, {
                    get when() {
                      return QuestionShow();
                    },
                    get children() {
                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                        get className() {
                          return libs.classNames("PlayerQuestionnaire", {
                            Show: true
                          });
                        },
                        get children() {
                          return [libs.createComponent(EOM_Label.EOM_Label, {
                            id: "PlayerQuestionnaireContent",
                            get text() {
                              return content_text();
                            }
                          }), libs.createComponent(libs.Switch, {
                            get children() {
                              return [libs.createComponent(libs.Match, {
                                get when() {
                                  return type() == "single" || type() == "multiple";
                                },
                                get children() {
                                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                                    id: "QuestionnaireOption",
                                    get children() {
                                      return libs.createComponent(libs.Show, {
                                        get when() {
                                          return questions() != undefined;
                                        },
                                        get children() {
                                          return libs.createComponent(libs.Index, {
                                            get each() {
                                              return questions();
                                            },
                                            children: (question, _i) => {
                                              let question_text = () => {
                                                let defualtText = question().content.en ?? "...";
                                                switch (language) {
                                                  case "schinese":
                                                    return question().content.cn ?? defualtText;
                                                  case "tchinese":
                                                    return question().content.cn ?? defualtText;
                                                  case "russian":
                                                    return question().content.ru ?? defualtText;
                                                  default:
                                                    return question().content.en ?? defualtText;
                                                }
                                              };
                                              const selected = () => {
                                                const data = questionnaireAnswer()[itemIndex.toString()];
                                                if (data) {
                                                  let _list = data.split(",");
                                                  return _list.includes(question().choice);
                                                }
                                                return false;
                                              };
                                              const emoji_level = () => {
                                                return question()?.emoji_level ?? 0;
                                              };
                                              return libs.createComponent(EOM_Button.EOM_BaseButton, {
                                                get className() {
                                                  return libs.classNames("QuestionButton", {
                                                    Selected: selected()
                                                  });
                                                },
                                                onactivate: () => {
                                                  let _id = itemIndex.toString();
                                                  const data = questionnaireAnswer()[_id];
                                                  let answer = question().choice;
                                                  if (type() == "single") {
                                                    if (answer == data) {
                                                      answer = "";
                                                    }
                                                  } else {
                                                    if (data) {
                                                      let _list = data.split(",");
                                                      let index = _list.indexOf(question().choice);
                                                      if (index > -1) {
                                                        _list.splice(index, 1);
                                                      } else {
                                                        _list.push(answer);
                                                      }
                                                      answer = _list.join(",");
                                                    }
                                                  }
                                                  updateQuestionnaireAnswer(_id, answer);
                                                },
                                                get children() {
                                                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                                                    className: "QuestionRadioButton"
                                                  }), libs.createComponent(libs.Show, {
                                                    get when() {
                                                      return emoji_level() > 0;
                                                    },
                                                    get children() {
                                                      return libs.createComponent(EOM_Image.EOM_Image, {
                                                        get className() {
                                                          return libs.classNames("EmojiIcon", "level_" + emoji_level());
                                                        },
                                                        get src() {
                                                          return getSrcPath("icon/questionnaire_white_" + emoji_level() + ".png");
                                                        }
                                                      });
                                                    }
                                                  }), libs.createComponent(EOM_Label.EOM_Label, {
                                                    get text() {
                                                      return question_text();
                                                    }
                                                  })];
                                                }
                                              });
                                            }
                                          });
                                        }
                                      });
                                    }
                                  });
                                }
                              }), libs.createComponent(libs.Match, {
                                get when() {
                                  return type() == "text";
                                },
                                get children() {
                                  return (() => {
                                    return libs.createComponent(Player.EOM_TextEntry, {
                                      id: "QuestionTextEntry",
                                      get className() {
                                        return $.Language().toLowerCase();
                                      },
                                      placeholder: "#Feedback_PreviousLabel",
                                      onChange: self => {
                                        let _id = itemIndex.toString();
                                        updateQuestionnaireAnswer(_id, self.text);
                                      },
                                      oninputsubmit: self => {
                                        let _id = itemIndex.toString();
                                        updateQuestionnaireAnswer(_id, self.text);
                                      }
                                    });
                                  })();
                                }
                              })];
                            }
                          })];
                        }
                      });
                    }
                  });
                }
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "Buttons",
            get children() {
              return [libs.createComponent(EOM_Button.EOM_Button, {
                marginRight: "200px",
                get enabled() {
                  return submitEnable();
                },
                horizontalAlign: "center",
                text: "#SubmitFeedBack",
                onactivate: () => {
                  setCooldown(true);
                  $.Schedule(1, () => {
                    setCooldown(false);
                  });
                  submit();
                }
              }), libs.createComponent(EOM_Button.EOM_Button, {
                marginLeft: "200px",
                color: "Red",
                horizontalAlign: "center",
                text: "#Popup_Button_Cancel",
                onactivate: () => {
                  closePopup(props.PopupID);
                }
              })];
            }
          })];
        }
      });
    }
  });
};

const Popup_RankInfo = props => {
  const [local, others] = libs.splitProps(props, ["PopupID", "group"]);
  const kv = Object.values(KeyValues.RankConfigKv);
  const rankData = {};
  kv.forEach(rankInfo => {
    if (!rankData[rankInfo.icon]) {
      rankData[rankInfo.icon] = {
        min: rankInfo.num,
        medal: rankInfo.medal,
        max: 1
      };
    } else {
      rankData[rankInfo.icon].max = rankInfo.num;
    }
  });
  return libs.createComponent(BasePopup, {
    get PopupID() {
      return local.PopupID;
    },
    className: "RankInfo",
    size: "large",
    get children() {
      return [(() => {
        const _el$ = libs.createElement("Panel", {
            id: "RankText"
          }, null),
          _el$2 = libs.createElement("Image", {
            id: "div",
            get src() {
              return getSrcPath("profile/detail/d_line.png");
            }
          }, _el$);
        libs.insert(_el$, libs.createComponent(GenericPanel.CLabel, {
          id: "title",
          text: "#RankInfo_Title"
        }), _el$2);
        libs.insert(_el$, libs.createComponent(GenericPanel.CLabel, {
          id: "desc",
          text: "#RankInfo_Desc",
          html: true
        }), null);
        libs.insert(_el$, libs.createComponent(libs.Show, {
          get when() {
            return IsRankRewardShow();
          },
          get children() {
            return libs.createComponent(InfoButton.InfoButton, {
              id: "RewardInfo",
              info: "#RewardInfo",
              customTooltip: {
                name: "custom_text",
                text: "#RewardInfoDetail"
              }
            });
          }
        }), null);
        libs.effect(_$p => libs.setProp(_el$2, "src", getSrcPath("profile/detail/d_line.png"), _$p));
        return _el$;
      })(), (() => {
        const _el$3 = libs.createElement("Panel", {
          id: "RankDetailList"
        }, null);
        libs.insert(_el$3, libs.createComponent(libs.For, {
          each: [1, 2, 3, 4, 5, 6, 7, 8, 0],
          children: tier => {
            let height = 50 + tier * 50;
            if (tier == 0) {
              height = 50 + 9 * 50;
            }
            let rank_data;
            if (rankData[tier]) {
              rank_data = rankData[tier];
            }
            return (() => {
              const _el$4 = libs.createElement("Panel", {
                  id: "RankDetail"
                }, null),
                _el$5 = libs.createElement("Panel", {
                  id: "rankMedal"
                }, _el$4),
                _el$6 = libs.createElement("Image", {
                  id: "medalIcon",
                  get src() {
                    return getSrcPath("profile/cup_icon.png");
                  }
                }, _el$5),
                _el$7 = libs.createElement("Panel", {
                  id: "MedalText"
                }, _el$5);
              libs.setProp(_el$5, "classList", {
                Top100: tier == 0
              });
              libs.insert(_el$7, libs.createComponent(EOM_Panel.EOM_Panel, {
                align: 'center center',
                get children() {
                  return libs.createComponent(libs.Switch, {
                    get children() {
                      return [libs.createComponent(libs.Match, {
                        when: tier == 0,
                        get children() {
                          return libs.createComponent(GenericPanel.CLabel, {
                            id: "Top100Label",
                            text: "#RankMedal_0_Description",
                            dialogVariables: {
                              rank: 100
                            }
                          });
                        }
                      }), libs.createComponent(libs.Match, {
                        when: rank_data,
                        get children() {
                          return [libs.createComponent(GenericPanel.CLabel, {
                            get text() {
                              return rank_data.medal;
                            }
                          }), (() => {
                            const _el$8 = libs.createElement("Image", {
                              id: "MedalUp",
                              get src() {
                                return getSrcPath("profile/detail/d_icon_05.png");
                              }
                            }, null);
                            libs.effect(_$p => libs.setProp(_el$8, "src", getSrcPath("profile/detail/d_icon_05.png"), _$p));
                            return _el$8;
                          })()];
                        }
                      })];
                    }
                  });
                }
              }));
              libs.insert(_el$4, libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "rankPole",
                classList: {
                  Top100: tier == 0
                },
                height: height + "px"
              }), null);
              libs.insert(_el$4, libs.createComponent(libs.Show, {
                when: tier != 8 && tier != 0,
                get children() {
                  const _el$9 = libs.createElement("Panel", {
                      id: "rankDesc"
                    }, null),
                    _el$0 = libs.createElement("Image", {
                      get src() {
                        return getSrcPath("profile/detail/d_icon_04.png");
                      }
                    }, _el$9);
                  libs.insert(_el$9, libs.createComponent(libs.Show, {
                    when: rank_data,
                    get children() {
                      return libs.createComponent(GenericPanel.CLabel, {
                        get text() {
                          return rank_data.min;
                        }
                      });
                    }
                  }), _el$0);
                  libs.insert(_el$9, libs.createComponent(libs.Show, {
                    when: rank_data,
                    get children() {
                      return libs.createComponent(GenericPanel.CLabel, {
                        get text() {
                          return rank_data.max;
                        }
                      });
                    }
                  }), null);
                  libs.effect(_$p => libs.setProp(_el$0, "src", getSrcPath("profile/detail/d_icon_04.png"), _$p));
                  return _el$9;
                }
              }), null);
              libs.insert(_el$4, libs.createComponent(GenericPanel.CLabel, {
                id: "rankName",
                text: "#RankTitle_" + tier
              }), null);
              libs.insert(_el$4, libs.createComponent(EOM_Image.EOM_Image, {
                id: "rankIcon",
                get backgroundImage() {
                  return getImagePath("ladder/j_rank_icon_0" + tier + "_150.png");
                }
              }), null);
              libs.effect(_$p => libs.setProp(_el$6, "src", getSrcPath("profile/cup_icon.png"), _$p));
              return _el$4;
            })();
          }
        }));
        return _el$3;
      })()];
    }
  });
};

const Popup_RankNotice = props => {
  const [local, others] = libs.splitProps(props, ["PopupID", "group", "rankAlarm"]);
  return libs.createComponent(BasePopup, {
    get PopupID() {
      return local.PopupID;
    },
    className: "RankNotice",
    size: "small",
    title: "#RankTips",
    get children() {
      return [(() => {
        const _el$ = libs.createElement("Label", {
          id: "RankTips_description",
          html: true,
          text: "#RankTips_description",
          get dialogVariables() {
            return {
              value: (1 - local.rankAlarm) * 100
            };
          }
        }, null);
        libs.effect(_$p => libs.setProp(_el$, "dialogVariables", {
          value: (1 - local.rankAlarm) * 100
        }, _$p));
        return _el$;
      })(), (() => {
        const _el$2 = libs.createElement("Panel", {
            id: "ImageExample"
          }, null),
          _el$3 = libs.createElement("Image", {
            id: "RankLow"
          }, _el$2);
          libs.createElement("Label", {
            text: "#LadderHelp_7_desc"
          }, _el$3);
          const _el$5 = libs.createElement("Image", {
            id: "RankHigh"
          }, _el$2);
          libs.createElement("Label", {
            text: "#LadderHelp_8_desc"
          }, _el$5);
        return _el$2;
      })(), libs.createComponent(EOM_Button.EOM_Button, {
        id: "Confirm",
        color: "Blue",
        text: "#Popup_Button_Confirm",
        onactivate: () => {
          closePopup(local.PopupID);
        }
      })];
    }
  });
};

const [time, setTime] = libs.createSignal(Date.now() / 1000);
libs.onMount(() => {
  const timer = setInterval(() => setTime(Date.now() / 1000), 1000);
  libs.onCleanup(() => {
    clearInterval(timer);
  });
});
const Popup_RankTask = props => {
  const [local, others] = libs.splitProps(props, ["PopupID", "group", "season"]);
  const season = local.season;
  const [page, setPage] = libs.createSignal(1);
  const [ladderTask, setLadderTask] = libs.createSignal({});
  const [taskProgress, setTaskProgress] = libs.createSignal([]);
  const [weekInfo, setWeekInfo] = libs.createSignal({});
  const isCurrentWeek = () => {
    return weekInfo()[page()] != undefined && time() >= weekInfo()[page()].startTime;
  };
  const taskData = libs.createMemo(() => {
    if (taskProgress()[page()]) {
      return taskProgress()[page()].sort((a, b) => {
        let canReceive_a = false;
        if (a.target) {
          let step_a = a.target.findIndex(v => (a.progress ?? 0) < v) ?? -1;
          canReceive_a = (step_a == -1 ? a.target.length : step_a) > (a.receive_progress ?? 0);
        }
        let canReceive_b = false;
        if (b.target) {
          let step_b = b.target.findIndex(v => (b.progress ?? 0) < v) ?? -1;
          canReceive_b = (step_b == -1 ? b.target.length : step_b) > (b.receive_progress ?? 0);
        }
        return multiCompare(Number(canReceive_b) - Number(canReceive_a), ((a.target?.length ?? 0) == (a.receive_progress ?? 0) ? 1 : 0) - ((b.target?.length ?? 0) == (b.receive_progress ?? 0) ? 1 : 0), a.task_id - b.task_id);
      });
    }
  }, []);
  libs.onMount(() => {
    let init = true;
    const eventIDList = [];
    eventIDList.push(useNetData("info_bp_task", data => {
      const rebuild = {};
      for (const key in data) {
        const element = data[key];
        if (element.season_id == season) {
          rebuild[key] = element;
        }
      }
      setLadderTask(rebuild);
    }));
    eventIDList.push(useNetData("bp_task_progresses", data => {
      let weekData = {};
      if (Object.keys(ladderTask()).length > 0) {
        for (const taskid in data) {
          const progress = data[taskid];
          if (ladderTask()[progress.task_id]) {
            const week = progress.unique_task_id.split("-")[1];
            if (weekData[week] == undefined) {
              weekData[week] = [];
            }
            let config = ladderTask()[progress.task_id];
            progress.target = config?.target?.split("|").map(v => Number(v)) ?? [1, 2, 3];
            progress.reward = JSON.parse(config?.reward ?? "[]");
            weekData[week].push(progress);
          }
        }
      }
      setTaskProgress(weekData);
      let weekInfoResult = {};
      for (const week in weekData) {
        weekInfoResult[week] = {
          week: Number(week),
          startTime: weekData[week][0].start_time,
          endTime: weekData[week][0].end_time
        };
      }
      setWeekInfo(weekInfoResult);
      if (init) {
        for (const key in weekInfoResult) {
          if (weekInfoResult[key].startTime <= time() && weekInfoResult[key].endTime >= time()) {
            setPage(Number(key));
            init = false;
          }
        }
      }
    }, Players.GetLocalPlayer()));
    libs.onCleanup(() => {
      eventIDList.forEach(id => GameEvents.Unsubscribe(id));
    });
  });
  return libs.createComponent(BasePopup, {
    get PopupID() {
      return local.PopupID;
    },
    className: "RankTask",
    size: "large",
    title: "#Popup_LadderTask_title",
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "TaskList",
        scroll: "y",
        horizontalAlign: "center",
        height: "670px",
        padding: "0px 20px",
        margin: "0px 20px",
        flowChildren: "down",
        get children() {
          return [libs.createComponent(libs.Show, {
            get when() {
              return libs.memo(() => !!(taskData() != undefined && taskProgress()[page()] != undefined))() && isCurrentWeek();
            },
            get children() {
              return libs.createComponent(libs.Index, {
                get each() {
                  return taskData();
                },
                children: (data, index) => {
                  return libs.createComponent(TaskRow, {
                    get taskData() {
                      return data();
                    }
                  });
                }
              });
            }
          }), libs.createComponent(libs.Show, {
            get when() {
              return !isCurrentWeek();
            },
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "TaskBanned",
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#TaskBanned"
                  });
                }
              });
            }
          })];
        }
      }), (() => {
        const _el$ = libs.createElement("Panel", {
            id: "BottomBar"
          }, null),
          _el$2 = libs.createElement("Panel", {
            id: "WeekAction"
          }, _el$);
        libs.insert(_el$2, libs.createComponent(EOM_Button.EOM_BaseButton, {
          get enabled() {
            return page() != 1;
          },
          onactivate: () => setPage(page() - 1),
          className: "PageButton PageLeft",
          get children() {
            return [libs.createComponent(GenericPanel.CImage, {
              className: "BG"
            }), libs.createComponent(GenericPanel.CImage, {
              className: "PageArrow"
            })];
          }
        }), null);
        libs.insert(_el$2, libs.createComponent(EOM_Panel.EOM_Panel, {
          flowChildren: "down",
          get children() {
            return [libs.createComponent(GenericPanel.CLabel, {
              id: "CurrentWeek",
              text: "#CurrentWeek",
              get vars() {
                return {
                  week: page()
                };
              }
            }), (() => {
              const _el$3 = libs.createElement("Panel", {
                id: "CountDownContainer"
              }, null);
              libs.insert(_el$3, libs.createComponent(GenericPanel.CImage, {
                className: "CountDownIcon"
              }), null);
              libs.insert(_el$3, libs.createComponent(libs.Show, {
                get when() {
                  return libs.memo(() => weekInfo()[page()] != undefined)() && isCurrentWeek();
                },
                get children() {
                  return libs.createComponent(EOM_Countdown.EOM_Countdown, {
                    get endTime() {
                      return weekInfo()[page()].endTime;
                    }
                  });
                }
              }), null);
              return _el$3;
            })()];
          }
        }), null);
        libs.insert(_el$2, libs.createComponent(EOM_Button.EOM_BaseButton, {
          get enabled() {
            return page() != Object.keys(weekInfo()).length;
          },
          onactivate: () => setPage(page() + 1),
          className: "PageButton PageRight",
          get children() {
            return [libs.createComponent(GenericPanel.CImage, {
              className: "BG"
            }), libs.createComponent(GenericPanel.CImage, {
              className: "PageArrow"
            })];
          }
        }), null);
        return _el$;
      })()];
    }
  });
};
const TaskRow = props => {
  const step = () => {
    let progress = props.taskData.progress ?? 0;
    let v = props.taskData.target.findIndex(v => progress < v);
    return v == -1 ? props.taskData.target.length : v;
  };
  const currentStep = () => {
    return props.taskData.receive_progress ?? 0;
  };
  const rewardList = () => {
    return props.taskData.reward[Math.min(Math.max(0, currentStep()), props.taskData.target.length - 1)];
  };
  return (() => {
    const _el$4 = libs.createElement("Panel", {}, null),
      _el$5 = libs.createElement("Panel", {}, _el$4),
      _el$6 = libs.createElement("Panel", {}, _el$4);
    libs.setProp(_el$5, "className", "StarRect");
    libs.insert(_el$5, libs.createComponent(GenericPanel.CImage, {
      id: "Star1",
      get className() {
        return libs.classNames("TaskStar", {
          Fill: currentStep() >= 1
        });
      }
    }), null);
    libs.insert(_el$5, libs.createComponent(GenericPanel.CImage, {
      id: "Star2",
      get className() {
        return libs.classNames("TaskStar", {
          Fill: currentStep() >= 2
        });
      }
    }), null);
    libs.insert(_el$5, libs.createComponent(GenericPanel.CImage, {
      id: "Star3",
      get className() {
        return libs.classNames("TaskStar", {
          Fill: currentStep() >= 3
        });
      }
    }), null);
    libs.insert(_el$4, libs.createComponent(EOM_Panel.EOM_Panel, {
      marginLeft: "20px",
      verticalAlign: "center",
      flowChildren: "down",
      get children() {
        return [libs.createComponent(GenericPanel.CLabel, {
          className: "TaskTitle",
          get text() {
            return "#task_" + props.taskData.task_id;
          }
        }), libs.createComponent(GenericPanel.CLabel, {
          className: "TaskDesc",
          get text() {
            return "#task_" + props.taskData.task_id + "_Desc";
          },
          get vars() {
            return {
              value: props.taskData.target[Math.min(Math.max(0, currentStep()), props.taskData.target.length - 1)]
            };
          }
        })];
      }
    }), _el$6);
    libs.setProp(_el$6, "className", "Divder");
    libs.insert(_el$4, libs.createComponent(EOM_Panel.EOM_Panel, {
      flowChildren: "right",
      verticalAlign: "center",
      get children() {
        return libs.createComponent(libs.Index, {
          get each() {
            return Object.keys(rewardList());
          },
          children: (rewardName, index) => {
            return libs.createComponent(EOM_Panel.EOM_Panel, {
              get children() {
                return [libs.createComponent(EOM_Image.EOM_Image, {
                  width: "46px",
                  height: "46px",
                  get backgroundImage() {
                    return getImagePath("store/new/currency_icon_bg.png");
                  },
                  get children() {
                    return libs.createComponent(ProductImage.ProductImage, {
                      width: "46px",
                      height: "46px",
                      get itemid() {
                        return rewardName();
                      }
                    });
                  }
                }), (() => {
                  const _el$7 = libs.createElement("Panel", {
                    hittest: false
                  }, null);
                  libs.setProp(_el$7, "className", "RewardCount");
                  libs.insert(_el$7, libs.createComponent(GenericPanel.CLabel, {
                    get text() {
                      return rewardList()[rewardName()];
                    }
                  }));
                  return _el$7;
                })()];
              }
            });
          }
        });
      }
    }), null);
    libs.insert(_el$4, libs.createComponent(libs.Switch, {
      get children() {
        return [libs.createComponent(libs.Match, {
          get when() {
            return step() > (props.taskData.receive_progress ?? 0);
          },
          get children() {
            return libs.createComponent(EOM_Button.EOM_Button, {
              className: "RewardAction",
              color: "Gold",
              text: "#activity_action_receive",
              onactivate: () => {
                callAction("bp_task_reward", {
                  task_id: props.taskData.task_id,
                  unique_task_id: props.taskData.unique_task_id
                });
              }
            });
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return time() > props.taskData.end_time;
          },
          get children() {
            return libs.createComponent(GenericPanel.CLabel, {
              className: "TaskFinish",
              html: true,
              text: "#TaskFinish"
            });
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return props.taskData.target.length == (props.taskData.receive_progress ?? 0);
          },
          get children() {
            return libs.createComponent(GenericPanel.CImage, {
              className: "RewardActionImage"
            });
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return step() == (props.taskData.receive_progress ?? 0);
          },
          get children() {
            return libs.createComponent(GenericPanel.CLabel, {
              className: "RewardActionLabel",
              html: true,
              get vars() {
                return {
                  value: props.taskData.progress ?? 0,
                  max: props.taskData.target[Math.min(Math.max(0, currentStep()), props.taskData.target.length - 1)]
                };
              },
              text: "#RewardProgress"
            });
          }
        })];
      }
    }), null);
    libs.effect(_$p => libs.setProp(_el$4, "className", libs.classNames("TaskRow", {
      Receive: step() > (props.taskData.receive_progress ?? 0),
      Complete: false,
      Expire: false
    }), _$p));
    return _el$4;
  })();
};

const Popup_RookieSect = props => {
  return libs.createComponent(BasePopup, {
    get PopupID() {
      return props.PopupID;
    },
    className: "Popup_RookieSect",
    title: "#SectFlow",
    size: "large",
    get children() {
      return libs.createComponent(rookie_sect.RookieSect, {});
    }
  });
};

const Popup_SelectCollections = props => {
  const tags = {
    CosmeticTag_hero: [10],
    CosmeticTag_courier: [20, 21, 23, 24, 25],
    CosmeticTag_world: [OrnamentType.MAP, OrnamentType.BUNNY_GIRL],
    CosmeticTag_battle: [OrnamentType.TELEPORT, OrnamentType.KILL, OrnamentType.BROADCAST, OrnamentType.WISP_SKIN],
    CosmeticTag_emotion: [50, 51],
    CosmeticTag_account: [OrnamentType.AVATAR_BORDER, OrnamentType.AVATAR_BACKGROUND, OrnamentType.AVATAR_DECORATION],
    CosmeticTag_coloring: [10, 20]
  };
  const {
    collections} = profile_simplify.useCollections({
    playerId: Players.GetLocalPlayer()
  });
  const [selectTag, setSelectTag] = libs.createSignal("CosmeticTag_hero");
  const [playerOrnament, setPlayerOrnament] = libs.createSignal({});
  const [selectSlot, setSelectSlot] = libs.createSignal(-1);
  const [highlightSlot, setHightlightSlot] = libs.createSignal(-1);
  const collectSlotCount = 10;
  const collectSlotArr = [...Array(collectSlotCount)].map((_, i) => i);
  const emptySlotIndex = () => {
    return collectSlotArr.find(slot => collections()[slot] == undefined) ?? -1;
  };
  libs.createEffect(libs.on(() => ({
    a: highlightSlot(),
    b: collections()
  }), v => {
    if (highlightSlot() == -1) {
      setSelectSlot(emptySlotIndex());
    } else {
      setSelectSlot(highlightSlot());
    }
  }));
  const [selectSubTag, setselectSubTag] = libs.createSignal(10);
  const subTags = () => tags[selectTag()];
  const cosmeticList = () => getAllCosmetics().filter(cosmeticInfo => {
    if (subTags().indexOf(cosmeticInfo.slot) != -1) {
      if (selectTag() == "CosmeticTag_coloring" && KeyValues.CosmeticsKv[cosmeticInfo.oid]?.coloring != undefined) {
        return true;
      } else if (selectTag() != "CosmeticTag_coloring" && KeyValues.CosmeticsKv[cosmeticInfo.oid]?.coloring == undefined) {
        return true;
      }
    }
  }).sort((a, b) => {
    let aDefault = a.default ? 1 : 0;
    let bDefault = b.default ? 1 : 0;
    const aOwned = playerOrnament()[a.oid.toString()] == undefined && !a.default ? 0 : 1;
    const bOwned = playerOrnament()[b.oid.toString()] == undefined && !b.default ? 0 : 1;
    return multiCompare(bDefault - aDefault, bOwned - aOwned, b.orderby - a.orderby, b.rarity - a.rarity);
  });
  libs.createEffect(libs.on(selectTag, () => {
    setselectSubTag(tags[selectTag()][0]);
  }));
  const isEquip = cosmeticID => {
    let index = Object.values(collections()).indexOf(cosmeticID);
    return index >= 0 && index < 19;
  };
  const hasColoring = cosmeticID => {
    if (KeyValues.CosmeticsKv[cosmeticID] && KeyValues.CosmeticsKv[cosmeticID].hasColoring == 1) {
      return true;
    }
    return false;
  };
  libs.onMount(() => {
    let gameEventIDList = [];
    gameEventIDList.push(useNetData('player_ornament', data => {
      setPlayerOrnament(data);
    }, Players.GetLocalPlayer()));
    libs.onCleanup(() => {
      for (const id of gameEventIDList) {
        GameEvents.Unsubscribe(id);
      }
    });
  });
  return libs.createComponent(BasePopup, {
    get PopupID() {
      return props.PopupID;
    },
    className: "Select_Collections",
    size: "large",
    title: "#Select_Collections",
    get children() {
      return [libs.createComponent(profile_simplify.CollectionList, {
        onClick: slot => {
          if (highlightSlot() == slot) {
            setHightlightSlot(-1);
          } else {
            setHightlightSlot(slot);
          }
        },
        get selectedSlot() {
          return highlightSlot();
        },
        onClose: slot => {
          callAction("equip_collection", {
            slot: slot + 1,
            oid: 0,
            group: 1
          });
          setHightlightSlot(-1);
        }
      }), (() => {
        const _el$ = libs.createElement("Panel", {
            id: "cosmetic"
          }, null),
          _el$2 = libs.createElement("Panel", {
            id: "cosmeticTag"
          }, _el$),
          _el$3 = libs.createElement("Panel", {}, _el$),
          _el$4 = libs.createElement("Panel", {
            id: "CosmeticShelf"
          }, _el$);
        libs.insert(_el$2, libs.createComponent(libs.For, {
          get each() {
            return Object.keys(tags);
          },
          children: (tag, index) => {
            return [(() => {
              const _el$5 = libs.createElement("Panel", {}, null),
                _el$6 = libs.createElement("Label", {
                  text: "#" + tag
                }, _el$5);
              libs.setProp(_el$5, "onactivate", () => setSelectTag(tag));
              libs.setProp(_el$6, "text", "#" + tag);
              libs.effect(_$p => libs.setProp(_el$5, "classList", {
                tag: true,
                Selected: selectTag() == tag
              }, _$p));
              return _el$5;
            })(), libs.createComponent(libs.Show, {
              get when() {
                return index() != Object.keys(tags).length;
              },
              get children() {
                const _el$7 = libs.createElement("Panel", {}, null);
                libs.setProp(_el$7, "className", "div");
                return _el$7;
              }
            })];
          }
        }));
        libs.setProp(_el$3, "className", "div2");
        libs.insert(_el$4, libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "CosmeticSlots",
          get children() {
            return [libs.createComponent(EOM_Panel.EOM_Panel, {
              id: "CosmeticSlotShadow"
            }), libs.createComponent(EOM_Panel.EOM_Panel, {
              id: "CosmeticSlotContainer",
              flowChildren: "down",
              get children() {
                return libs.createComponent(libs.Index, {
                  get each() {
                    return subTags();
                  },
                  children: (subTag, i) => {
                    return libs.createComponent(EOM_Button.EOM_BaseButton, {
                      get className() {
                        return libs.classNames('CosmeticSlot', {
                          Selected: selectSubTag() == subTag()
                        });
                      },
                      get id() {
                        return 'cosmetic_slot_' + subTag();
                      },
                      onactivate: self => {
                        setselectSubTag(subTag());
                      },
                      get children() {
                        return libs.createComponent(EOM_Image.EOM_Image, {
                          get src() {
                            return 'file://{images}/custom_game/cosmetics/slot_' + subTag() + '.png';
                          }
                        });
                      }
                    });
                  }
                });
              }
            })];
          }
        }), null);
        libs.insert(_el$4, libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "CosmeticItems",
          flowChildren: "down",
          get children() {
            return libs.createComponent(EOM_Panel.EOM_Panel, {
              id: "CosmeticList",
              flowChildren: "right-wrap",
              scroll: "y",
              get children() {
                return libs.createComponent(libs.Index, {
                  get each() {
                    return cosmeticList();
                  },
                  children: (cosmetic, i) => {
                    const lock = () => {
                      if (cosmetic().default) return false;
                      let info = playerOrnament()[cosmetic().oid.toString()];
                      if (info == undefined || info.permanent != 1) return true;
                    };
                    const equipped = libs.createMemo(() => isEquip(cosmetic().oid.toString()));
                    return libs.createComponent(CosmeticCard.CosmeticCard, {
                      get visible() {
                        return selectSubTag() == cosmetic().slot;
                      },
                      get itemid() {
                        return cosmetic().oid.toString();
                      },
                      get lock() {
                        return lock();
                      },
                      get equip() {
                        return equipped();
                      },
                      get rarity() {
                        return cosmetic().rarity;
                      },
                      get mark() {
                        return cosmetic().mark;
                      },
                      get hasColoring() {
                        return hasColoring(cosmetic().oid.toString());
                      },
                      onactivate: () => {
                        if (selectSlot() == -1 || lock()) return;
                        if (highlightSlot() == -1 && (cosmetic().default || Object.values(collections()).includes(cosmetic().oid.toString()))) {
                          return;
                        }
                        callAction("equip_collection", {
                          slot: selectSlot() + 1,
                          oid: cosmetic().default ? 0 : cosmetic().oid,
                          group: 1
                        });
                        setHightlightSlot(-1);
                      }
                    });
                  }
                });
              }
            });
          }
        }), null);
        return _el$;
      })()];
    }
  });
};

function getFakeItemData(id, heroid) {
  return {
    id: id,
    start_time: 1,
    end_time: 1,
    pay_type: 1,
    order_by: 1,
    overseas_origin_price: 1,
    overseas_real_price: 1,
    russia_origin_price: 1,
    russia_real_price: 1,
    status: 1,
    origin_price: 1,
    real_price: 1,
    discount: 1,
    limit_type: 0,
    limit_count: 0,
    items: [{
      item_id: heroid,
      amounts: 1
    }],
    tag: "",
    title: 1,
    img: ""
  };
}
const Popup_FirstRecharge = props => {
  const getRewardList = player_hero => {
    return [{
      itemid: 1100001,
      heroid: 1100001,
      owned: false,
      count: 3000
    }, {
      itemid: 9900303,
      heroid: 3000012,
      owned: getHerobyStoreItem(getFakeItemData(9900303, 3000012), player_hero),
      count: 1
    }, {
      itemid: 9900302,
      heroid: 3000018,
      owned: getHerobyStoreItem(getFakeItemData(9900302, 3000018), player_hero),
      count: 1
    }, {
      itemid: 9900307,
      heroid: 3000004,
      owned: getHerobyStoreItem(getFakeItemData(9900303, 3000004), player_hero),
      count: 1
    }, {
      itemid: 9900316,
      heroid: 3000037,
      owned: getHerobyStoreItem(getFakeItemData(9900316, 3000037), player_hero),
      count: 1
    }];
  };
  const [rewardList, setRewardList] = libs.createSignal([]);
  libs.onMount(() => {
    let gameEventIDList = [];
    gameEventIDList.push(useNetData('player_hero', data => {
      setRewardList(getRewardList(data));
    }, Players.GetLocalPlayer()));
    libs.onCleanup(() => {
      for (const id of gameEventIDList) {
        GameEvents.Unsubscribe(id);
      }
    });
  });
  return libs.createComponent(BasePopup, {
    get PopupID() {
      return props.PopupID;
    },
    className: "Select_Collections",
    size: "normal",
    title: "#RechargeHeroSelect",
    get children() {
      return [libs.createElement("Label", {
        id: "Title",
        text: "#first_recharge_select_reward"
      }, null), libs.createElement("Image", {
        id: "Divider"
      }, null), libs.createComponent(EOM_Panel.EOM_Panel, {
        width: "100%",
        marginTop: "50px",
        scroll: "x",
        flowChildren: "right",
        get children() {
          return libs.createComponent(libs.Index, {
            get each() {
              return rewardList().sort((a, b) => {
                return a.owned ? 1 : -1;
              });
            },
            children: (data, index) => {
              return libs.createComponent(RewardSelection, {
                get itemid() {
                  return data().itemid;
                },
                get owned() {
                  return data().owned;
                },
                get heroid() {
                  return data().heroid;
                },
                get count() {
                  return data().count;
                },
                get popupID() {
                  return props.PopupID;
                }
              });
            }
          });
        }
      })];
    }
  });
};
const RewardSelection = props => {
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    margin: "10px",
    flowChildren: "down",
    get children() {
      return [(() => {
        const _el$3 = libs.createElement("Panel", {
          "class": "RewardCard"
        }, null);
        libs.insert(_el$3, libs.createComponent(ProductItem.ProductItem, {
          get itemid() {
            return props.itemid;
          },
          rarity: 2,
          get count() {
            return props.count;
          },
          get enabled() {
            return !props.owned;
          }
        }), null);
        libs.insert(_el$3, libs.createComponent(libs.Show, {
          get when() {
            return props.owned;
          },
          get children() {
            return [(() => {
              const _el$4 = libs.createElement("Image", {}, null);
              libs.setProp(_el$4, "className", "Owned");
              return _el$4;
            })(), (() => {
              const _el$5 = libs.createElement("Label", {
                text: "#LimitOwned"
              }, null);
              libs.setProp(_el$5, "className", "OwnedLabel");
              return _el$5;
            })(), (() => {
              const _el$6 = libs.createElement("Image", {}, null);
              libs.setProp(_el$6, "className", "OwnedMask");
              return _el$6;
            })()];
          }
        }), null);
        return _el$3;
      })(), libs.createComponent(libs.Show, {
        get when() {
          return !props.owned;
        },
        get children() {
          return libs.createComponent(EOM_Button.EOM_Button, {
            get enabled() {
              return !props.owned;
            },
            color: "Green",
            horizontalAlign: "center",
            text: "#Popup_Button_Confirm",
            onactivate: () => {
              callAction("set_key", {
                key: "activity1002-hid",
                value: String(props.heroid)
              });
              closePopup(props.popupID);
            }
          });
        }
      })];
    }
  });
};

const getStoreItemProps = ({
  itemData,
  purchased_num,
  playerOrnament,
  playerHeroes
}) => {
  const item_data = libs.createMemo(() => {
    return {
      ...itemData,
      purchased_num: purchased_num
    };
  });
  const tagName = () => StoreItem.getTagName(item_data());
  const owned = libs.createMemo(() => {
    return getCosmeticByStoreItem(item_data(), playerOrnament) || getHerobyStoreItem(item_data(), playerHeroes);
  });
  const enabled = () => {
    return item_data().status == 1 && (item_data().limit_type == 1 ? finiteNumber(Number(item_data().purchased_num)) < item_data().limit_count : true) && !owned();
  };
  const labels = () => {
    return StoreItem.getLabels(item_data());
  };
  return {
    itemId: item_data().id,
    itemName: $.Localize("#" + item_data().id),
    itemImage: getProductSrc(item_data().id),
    itemCount: item_data().items && item_data().items.length == 1 ? item_data()?.items?.[0]?.amounts ?? 1 : 1,
    enabled: false,
    end_time: item_data().end_time,
    tagName: tagName(),
    owned: !enabled(),
    rarity: Number(item_data().title),
    labels: labels()
  };
};
const Popup_StoreBuyItem = props => {
  const [local, others] = libs.splitProps(props, ["itemData", "initCount", "purchased_num", "playerOrnament", "playerHeroes", "limit_num", "custom_buy_callback", "PopupID", "group"]);
  return libs.createComponent(BasePopup, {
    get PopupID() {
      return local.PopupID;
    },
    get group() {
      return String(local.itemData.id);
    },
    title: "#Popup_StoreBuyItem_title",
    get children() {
      return libs.createComponent(StoreBuyItemContainer, local);
    }
  });
};
const Popup_StoreBuyItemMult = props => {
  const merged = libs.mergeProps$1({
    initCount: 1
  }, props);
  const [local, others] = libs.splitProps(merged, ["playerOrnament", "playerHeroes", "limit_num", "PopupID", "group"]);
  const itemDataList = libs.createMemo(() => {
    return props.itemData.sort((a, b) => a.items.length - b.items.length);
  });
  const [selectedItemData, setSelectedItemData] = libs.createSignal(itemDataList().length > 0 ? itemDataList()[0] : undefined);
  const [purchased_product, setPurchasedProduct] = libs.createSignal({});
  const purchased_num = libs.createMemo(() => {
    let data = selectedItemData();
    if (data && purchased_product()[data.id]) {
      return purchased_product()[data.id];
    }
  });
  const [initCount, setInitCount] = libs.createSignal(merged.initCount);
  const paywayList = libs.createMemo(() => {
    let list = [];
    itemDataList().forEach((v, index) => {
      if (v.pay_type != 0) {
        list.push({
          pay_type: v.pay_type.toString(),
          list_index: index
        });
      }
    });
    return list;
  });
  libs.onMount(() => {
    let gameEventIDList = [];
    let NetTableIDList = [];
    gameEventIDList.push(useNetData("player_purchased_products", data => {
      setPurchasedProduct(data.purchased_products);
    }, Players.GetLocalPlayer()));
    libs.onCleanup(() => {
      for (const id of gameEventIDList) {
        GameEvents.Unsubscribe(id);
      }
      NetTableIDList.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    });
  });
  return libs.createComponent(BasePopup, {
    get PopupID() {
      return local.PopupID;
    },
    get group() {
      return String(local.group);
    },
    title: "#Popup_StoreBuyItem_title",
    get children() {
      return libs.createComponent(EOM_Panel.EOM_Panel, {
        width: "100%",
        height: "100%",
        get children() {
          return [libs.createComponent(libs.Show, {
            get when() {
              return itemDataList().length > 1;
            },
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "Popup_StoreBuyItemMult_Top",
                get children() {
                  return [libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#select_payway"
                  }), libs.createComponent(rookie_sect.EOM_Breadcrumb, {
                    get list() {
                      return (() => paywayList().map(v => v.pay_type))();
                    },
                    selected: 1,
                    onChange: (i, item) => {
                      let index = i - 1;
                      if (paywayList()[index]?.list_index != undefined && itemDataList()[paywayList()[index].list_index]) {
                        setSelectedItemData(itemDataList()[paywayList()[index].list_index]);
                      }
                    }
                  })];
                }
              });
            }
          }), libs.createComponent(libs.Show, {
            get when() {
              return selectedItemData() != undefined;
            },
            get children() {
              return (() => {
                let data = selectedItemData();
                return libs.createComponent(StoreBuyItemContainer, libs.mergeProps({
                  onChangeCount: v => setInitCount(v),
                  get purchased_num() {
                    return purchased_num();
                  },
                  get initCount() {
                    return initCount();
                  },
                  itemData: data
                }, local));
              })();
            }
          })];
        }
      });
    }
  });
};
const StoreBuyItemContainer = props => {
  const merged = libs.mergeProps$1({
    initCount: 1
  }, props);
  const [local, others] = libs.splitProps(merged, ["itemData", "initCount", "purchased_num", "playerOrnament", "playerHeroes", "custom_buy_callback", "limit_num", "PopupID", "group"]);
  const getCost = () => {
    if (getMaxCount() == 0) {
      return 0;
    }
    return getStoreItemCost(local.itemData, count());
  };
  const getSkinDebrisLabel = libs.createMemo(() => {
    let isSkinDebris = Math.floor(local.itemData.id / 100) == 98098;
    if (isSkinDebris) {
      const key = local.itemData.id % 100;
      const storeData = getNetDataCache("info_shop_product_group_by_tag");
      const tokenData = getNetDataCache("player_token", Players.GetLocalPlayer());
      if (storeData) {
        const store_id = 9901100 + key;
        for (const tag in storeData) {
          let data = storeData[tag].find(v => v.id == store_id);
          if (data) {
            return `${tokenData?.[1100100 + key]?.num ?? 0} / ${data.real_price}`;
          }
        }
      }
    }
  });
  const getMaxCount = () => {
    if (local.itemData?.step_purchased_num !== undefined) {
      return 1;
    }
    if (local.itemData.id == 9900102) {
      const info_bp_level_exp = getNetDataCache("info_bp_level_exp") ?? [];
      let totalExp = 0;
      info_bp_level_exp.map(v => {
        if (v.season == 1 && v.level < 100) {
          totalExp += v.exp;
        }
      });
      let exp = getNetDataCache("player_battle_passes", Players.GetLocalPlayer())?.["1"]?.totalXp ?? 0;
      if (exp > totalExp) {
        return 0;
      }
      return Math.ceil((totalExp - exp) / 1000);
    }
    if (local.itemData.id == 9900107) {
      const info_bp_level_exp = getNetDataCache("info_bp_level_exp") ?? [];
      let totalExp = 0;
      info_bp_level_exp.map(v => {
        if (v.season == 2 && v.level < 100) {
          totalExp += v.exp;
        }
      });
      let exp = getNetDataCache("player_battle_passes", Players.GetLocalPlayer())?.["2"]?.totalXp ?? 0;
      if (exp > totalExp) {
        return 0;
      }
      return Math.ceil((totalExp - exp) / 200);
    }
    if (local.itemData.id == 9900230) {
      const info_bp_level_exp = getNetDataCache("info_bp_level_exp") ?? [];
      let totalExp = 0;
      info_bp_level_exp.map(v => {
        if (v.season == 99 && v.level < 30) {
          totalExp += v.exp;
        }
      });
      let exp = getNetDataCache("player_battle_passes", Players.GetLocalPlayer())?.["99"]?.totalXp ?? 0;
      if (exp > totalExp) {
        return 0;
      }
      return Math.ceil((totalExp - exp) / 100);
    }
    if (local.itemData.id == 9900237) {
      const info_bp_level_exp = getNetDataCache("info_bp_level_exp") ?? [];
      let totalExp = 0;
      info_bp_level_exp.map(v => {
        if (v.season == 98 && v.level < 30) {
          totalExp += v.exp;
        }
      });
      let exp = getNetDataCache("player_battle_passes", Players.GetLocalPlayer())?.["98"]?.totalXp ?? 0;
      if (exp > totalExp) {
        return 0;
      }
      return Math.ceil((totalExp - exp) / 100);
    }
    if (local.itemData.id == 9900233) {
      const info_bp_level_exp = getNetDataCache("info_bp_level_exp") ?? [];
      let totalExp = 0;
      info_bp_level_exp.map(v => {
        if (v.season == 3 && v.level < 60) {
          totalExp += v.exp;
        }
      });
      let exp = getNetDataCache("player_battle_passes", Players.GetLocalPlayer())?.["3"]?.totalXp ?? 0;
      if (exp > totalExp) {
        return 0;
      }
      return Math.ceil((totalExp - exp) / 200);
    }
    if (local.itemData.id == 9900250) {
      const info_bp_level_exp = getNetDataCache("info_bp_level_exp") ?? [];
      let totalExp = 0;
      info_bp_level_exp.map(v => {
        if (v.season == 4 && v.level < 60) {
          totalExp += v.exp;
        }
      });
      let exp = getNetDataCache("player_battle_passes", Players.GetLocalPlayer())?.["4"]?.totalXp ?? 0;
      if (exp > totalExp) {
        return 0;
      }
      return Math.ceil((totalExp - exp) / 200);
    }
    if (local.itemData.id == 9900257) {
      const info_bp_level_exp = getNetDataCache("info_bp_level_exp") ?? [];
      let totalExp = 0;
      info_bp_level_exp.map(v => {
        if (v.season == 5 && v.level < 90) {
          totalExp += v.exp;
        }
      });
      let exp = getNetDataCache("player_battle_passes", Players.GetLocalPlayer())?.["5"]?.totalXp ?? 0;
      if (exp > totalExp) {
        return 0;
      }
      return Math.ceil((totalExp - exp) / 200);
    } else if (local.itemData.id == 9900270) {
      const info_bp_level_exp = getNetDataCache("info_bp_level_exp") ?? [];
      let totalExp = 0;
      info_bp_level_exp.map(v => {
        if (v.season == 6 && v.level < 90) {
          totalExp += v.exp;
        }
      });
      let exp = getNetDataCache("player_battle_passes", Players.GetLocalPlayer())?.["6"]?.totalXp ?? 0;
      if (exp > totalExp) {
        return 0;
      }
      return Math.ceil((totalExp - exp) / 200);
    } else if (local.itemData.id == 9900283) {
      const info_bp_level_exp = getNetDataCache("info_bp_level_exp") ?? [];
      let totalExp = 0;
      info_bp_level_exp.map(v => {
        if (v.season == 7 && v.level < 90) {
          totalExp += v.exp;
        }
      });
      let exp = getNetDataCache("player_battle_passes", Players.GetLocalPlayer())?.["7"]?.totalXp ?? 0;
      if (exp > totalExp) {
        return 0;
      }
      return Math.ceil((totalExp - exp) / 200);
    } else if (local.itemData.id == 9900288) {
      const info_bp_level_exp = getNetDataCache("info_bp_level_exp") ?? [];
      let totalExp = 0;
      info_bp_level_exp.map(v => {
        if (v.season == 8 && v.level < 90) {
          totalExp += v.exp;
        }
      });
      let exp = getNetDataCache("player_battle_passes", Players.GetLocalPlayer())?.["8"]?.totalXp ?? 0;
      if (exp > totalExp) {
        return 0;
      }
      return Math.ceil((totalExp - exp) / 200);
    } else if (local.itemData.id == 9900403) {
      const info_bp_level_exp = getNetDataCache("info_bp_level_exp") ?? [];
      let totalExp = 0;
      info_bp_level_exp.map(v => {
        if (v.season == 9 && v.level < 90) {
          totalExp += v.exp;
        }
      });
      let exp = getNetDataCache("player_battle_passes", Players.GetLocalPlayer())?.["9"]?.totalXp ?? 0;
      if (exp > totalExp) {
        return 0;
      }
      return Math.ceil((totalExp - exp) / 200);
    } else if (local.itemData.id == 9900406) {
      const info_bp_level_exp = getNetDataCache("info_bp_level_exp") ?? [];
      let totalExp = 0;
      info_bp_level_exp.map(v => {
        if (v.season == 10 && v.level < 90) {
          totalExp += v.exp;
        }
      });
      let exp = getNetDataCache("player_battle_passes", Players.GetLocalPlayer())?.["10"]?.totalXp ?? 0;
      if (exp > totalExp) {
        return 0;
      }
      return Math.ceil((totalExp - exp) / 200);
    } else if (local.itemData.id == 9900409) {
      const info_bp_level_exp = getNetDataCache("info_bp_level_exp") ?? [];
      let totalExp = 0;
      info_bp_level_exp.map(v => {
        if (v.season == 11 && v.level < 90) {
          totalExp += v.exp;
        }
      });
      let exp = getNetDataCache("player_battle_passes", Players.GetLocalPlayer())?.["11"]?.totalXp ?? 0;
      if (exp > totalExp) {
        return 0;
      }
      return Math.ceil((totalExp - exp) / 200);
    }
    if (local.limit_num) {
      return local.limit_num;
    }
    return local.itemData.limit_type > 0 ? local.itemData.limit_count : 999;
  };
  const buyItem = () => {
    if (local.custom_buy_callback) {
      local.custom_buy_callback();
      closePopup(PopupID);
      return;
    }
    const itemData = local.itemData;
    if (itemData.pay_type == PayType.MOON) {
      if (getNetDataCache("player_wallet", Players.GetLocalPlayer()).moonstone < itemData.real_price) {
        closePopup(PopupID);
        showPopup("StoreBuyItemResult", {
          result: "failure",
          reason: "no_enough_moon",
          group: String(itemData.id)
        });
        return;
      }
    } else if (itemData.pay_type == PayType.COIN) {
      if ((getNetDataCache("player_token", Players.GetLocalPlayer())[PayType.COIN]?.num ?? 0) < itemData.real_price) {
        closePopup(PopupID);
        showPopup("StoreBuyItemResult", {
          result: "failure",
          reason: "no_enough_coin",
          group: String(itemData.id)
        });
        return;
      }
    } else if (Math.floor(itemData.pay_type / 100) == 11001) {
      const infoShopData = getNetDataCache("info_shop_product_group_by_tag");
      const playerTokens = getNetDataCache("player_token", Players.GetLocalPlayer());
      let needAmounts = itemData.real_price - (playerTokens[itemData.pay_type.toString()]?.num ?? 0);
      if (needAmounts > 0) {
        if (infoShopData) {
          const storeID = Number(9809800 + itemData.pay_type % 100);
          for (const tag in infoShopData) {
            const storeData = infoShopData[tag].find(v => v.id == storeID);
            if (storeData) {
              closePopup(PopupID);
              showPopup("StoreBuyItem", {
                itemData: storeData,
                limit_num: needAmounts,
                group: "StoreBuyItem"
              });
              return;
            }
          }
        }
      }
    } else if (itemData.pay_type == 1100098) {
      const infoShopData = getNetDataCache("info_shop_product_group_by_tag");
      const playerTokens = getNetDataCache("player_token", Players.GetLocalPlayer());
      let needAmounts = itemData.real_price - (playerTokens[itemData.pay_type.toString()]?.num ?? 0);
      if (needAmounts > 0) {
        if (infoShopData) {
          const storeID = 9900248;
          for (const tag in infoShopData) {
            const storeData = infoShopData[tag].find(v => v.id == storeID);
            if (storeData) {
              closePopup(PopupID);
              showPopup("StoreBuyItem", {
                itemData: storeData,
                group: "StoreBuyItem"
              });
              return;
            }
          }
        }
      }
    }
    closePopup(PopupID);
    if (itemData.pay_type == PayType.MONEY) {
      showPopup("PaymentOrder", {
        itemData: itemData,
        count: count(),
        group: String(itemData.id)
      });
    } else {
      let PopupID = showPopup("StoreBuyItemResult", {
        result: "loading",
        group: String(itemData.id)
      });
      serverRequest("product_buy", {
        product_id: itemData.id,
        product_num: count()
      }, res => {
        if (res.status == 0) {
          showPopup("StoreBuyItemResult", {
            result: "success",
            PopupID: PopupID,
            group: String(itemData.id)
          });
        } else {
          showPopup("StoreBuyItemResult", {
            result: "failure",
            PopupID: PopupID,
            group: String(itemData.id)
          });
        }
      });
    }
  };
  const [count, setCount] = libs.createSignal(local.initCount);
  const payTypeIcon = () => getPayTypeIconPath(local.itemData.pay_type);
  const {
    itemData,
    PopupID
  } = local;
  const desc = () => {
    let description = $.Localize("#" + itemData.id + "_description");
    if (local.itemData.items && local.itemData.items.length >= 1) {
      let bundle = "<br><br>" + $.Localize("#StoreItem_BundleInfo");
      for (const itemInfo of local.itemData.items) {
        bundle += "<br>" + $.Localize("#" + itemInfo.item_id) + " x " + itemInfo.amounts;
      }
      description += bundle;
    }
    return description;
  };
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    className: "StoreBuyItemContainer",
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        horizontalAlign: "right",
        flowChildren: "right",
        marginTop: "10px",
        marginRight: "40px",
        get children() {
          return [libs.createComponent(Player.PlayerCurrency, {
            type: "moonstone"
          }), libs.createComponent(libs.Show, {
            get when() {
              return local.itemData.pay_type != 0;
            },
            get children() {
              return libs.createComponent(Player.PlayerCurrency, {
                type: "token",
                get tokenID() {
                  return local.itemData.pay_type == 1000001 ? 1100001 : local.itemData.pay_type;
                }
              });
            }
          })];
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "StoreBuyItemMain",
        width: "90%",
        flowChildren: "right",
        marginTop: "20px",
        horizontalAlign: "center",
        get children() {
          return [libs.createComponent(StoreItem.StoreItem, libs.mergeProps(() => getStoreItemProps({
            itemData: props.itemData,
            purchased_num: props.purchased_num,
            playerOrnament: props.playerOrnament,
            playerHeroes: props.playerHeroes
          }), {
            get children() {
              return libs.createComponent(libs.Show, {
                get when() {
                  return getSkinDebrisLabel() != undefined;
                },
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    align: "center bottom",
                    fontSize: "24px",
                    marginBottom: "20px",
                    color: "#edbc0e",
                    textShadow: "0 0 4px 2 #000000",
                    get text() {
                      return getSkinDebrisLabel();
                    }
                  });
                }
              });
            }
          })), libs.createComponent(EOM_Panel.EOM_Panel, {
            flowChildren: "down",
            width: "100%",
            marginLeft: "40px",
            get children() {
              return [libs.createComponent(EOM_Label.EOM_Label, {
                html: true,
                height: "170px",
                get text() {
                  return desc();
                },
                color: "white"
              }), libs.createComponent(EOM_Separator.EOM_Separator, {
                direction: "horizontal"
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                marginTop: "20px",
                flowChildren: "right",
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    flowChildren: "down",
                    width: "200px",
                    get children() {
                      return [libs.createComponent(EOM_Label.EOM_Label, {
                        text: "#Popup_StoreBuyItem_cost",
                        color: "white"
                      }), libs.createComponent(EOM_Panel.EOM_Panel, {
                        flowChildren: "right",
                        get children() {
                          return [libs.memo(() => libs.memo(() => payTypeIcon() != "")() && libs.createComponent(EOM_Image.EOM_Image, {
                            get src() {
                              return payTypeIcon();
                            },
                            width: "29px",
                            height: "29px",
                            marginTop: "10px"
                          })), libs.createComponent(EOM_Label.EOM_Label, {
                            color: "#FFD05F",
                            fontSize: "24px",
                            marginTop: "10px",
                            get text() {
                              return getCost();
                            }
                          })];
                        }
                      })];
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    flowChildren: "down",
                    width: "200px",
                    get children() {
                      return [libs.createComponent(EOM_Label.EOM_Label, {
                        text: "#Popup_StoreBuyItem_count",
                        color: "white"
                      }), libs.createComponent(EOM_NumberAdjust.EOM_NumberAdjust, {
                        marginTop: "10px",
                        get value() {
                          return local.initCount;
                        },
                        onvaluechanged: self => {
                          setCount(self.value);
                          if (props.onChangeCount) {
                            props.onChangeCount(self.value);
                          }
                        },
                        get min() {
                          return getMaxCount() == 0 ? 0 : 1;
                        },
                        get max() {
                          return getMaxCount();
                        }
                      })];
                    }
                  })];
                }
              })];
            }
          })];
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        width: "50%",
        horizontalAlign: "center",
        marginTop: "60px",
        get children() {
          return [libs.createComponent(EOM_Button.EOM_Button, {
            color: "Gray",
            text: "#Popup_Button_Cancel",
            onactivate: () => closePopup(PopupID)
          }), libs.createComponent(EOM_Button.EOM_Button, {
            get enabled() {
              return getMaxCount() > 0;
            },
            horizontalAlign: "right",
            color: "Gold",
            text: "#Popup_Button_Buy",
            onactivate: () => buyItem()
          })];
        }
      })];
    }
  });
};

const Popup_StoreBuyItemResult = props => {
  const [local, others] = libs.splitProps(props, ["result", "PopupID", "group"]);
  const getTitle = () => {
    switch (local.result) {
      case "loading":
        return "#Popup_StoreBuyItem_Result";
      case "success":
        return "#Popup_StoreBuyItem_Success";
      case "failure":
        return "#Popup_StoreBuyItem_Failure";
      case "gotoUrl":
        return "#Popup_StoreBuyItem_GotoURL";
      default:
        return "#Popup_StoreBuyItem_Result";
    }
  };
  return libs.createComponent(BasePopup, {
    get PopupID() {
      return local.PopupID;
    },
    get group() {
      return local.group;
    },
    get title() {
      return getTitle();
    },
    size: "small",
    get children() {
      return libs.createComponent(EOM_Panel.EOM_Panel, {
        width: "100%",
        height: "100%",
        get children() {
          return [libs.createComponent(libs.Switch, {
            get fallback() {
              return libs.createComponent(EOM_Loading.EOM_Loading, {
                horizontalAlign: "center",
                marginTop: "50px",
                type: "Wave"
              });
            },
            get children() {
              return [libs.createComponent(libs.Match, {
                get when() {
                  return local.result == "loading";
                },
                get children() {
                  return libs.createComponent(EOM_Loading.EOM_Loading, {
                    horizontalAlign: "center",
                    marginTop: "50px",
                    type: "Wave"
                  });
                }
              }), libs.createComponent(libs.Match, {
                get when() {
                  return local.result == "success";
                },
                get children() {
                  return libs.createComponent(EOM_Image.EOM_Image, {
                    className: "Popup_StoreBuyItemResultIcon",
                    horizontalAlign: "center",
                    marginTop: "50px",
                    get backgroundImage() {
                      return getImagePath("icon/icon_party_ready_psd.png");
                    },
                    width: "64px",
                    height: "64px"
                  });
                }
              }), libs.createComponent(libs.Match, {
                get when() {
                  return local.result == "failure";
                },
                get children() {
                  return libs.createComponent(EOM_Image.EOM_Image, {
                    className: "Popup_StoreBuyItemResultIcon",
                    horizontalAlign: "center",
                    marginTop: "50px",
                    get backgroundImage() {
                      return getImagePath("icon/icon_party_reject_psd.png");
                    },
                    width: "64px",
                    height: "64px"
                  });
                }
              })];
            }
          }), libs.createComponent(libs.Switch, {
            fallback: () => libs.createComponent(EOM_Panel.EOM_Panel, {
              align: "center bottom",
              flowChildren: "right",
              get children() {
                return libs.createComponent(EOM_Button.EOM_Button, {
                  color: "Gray",
                  text: "#GameUI_Close",
                  onactivate: () => {
                    closePopup(local.PopupID);
                  }
                });
              }
            }),
            get children() {
              return [libs.createComponent(libs.Match, {
                get when() {
                  return props.reason == "no_enough_moon";
                },
                get children() {
                  return [libs.createComponent(GenericPanel.CLabel, {
                    id: "ErrorMsg",
                    text: "#no_enough_moon"
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    align: "center bottom",
                    flowChildren: "right",
                    get children() {
                      return [libs.createComponent(EOM_Button.EOM_Button, {
                        color: "Gray",
                        text: "#no_thanks",
                        onactivate: () => {
                          closePopup(local.PopupID);
                        }
                      }), libs.createComponent(EOM_Button.EOM_Button, {
                        color: "Blue",
                        text: "#go_buy",
                        onactivate: () => {
                          closePopup(local.PopupID);
                          clientSideEvent("toggle_store_tag", {
                            menu: "Resource"
                          });
                        }
                      })];
                    }
                  })];
                }
              }), libs.createComponent(libs.Match, {
                get when() {
                  return props.reason == "no_enough_coin";
                },
                get children() {
                  return [libs.createComponent(GenericPanel.CLabel, {
                    id: "ErrorMsg",
                    text: "#no_enough_token"
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    align: "center bottom",
                    flowChildren: "right",
                    get children() {
                      return [libs.createComponent(EOM_Button.EOM_Button, {
                        color: "Gray",
                        text: "#no_thanks",
                        onactivate: () => {
                          closePopup(local.PopupID);
                        }
                      }), libs.createComponent(EOM_Button.EOM_Button, {
                        color: "Blue",
                        text: "#go_buy",
                        onactivate: () => {
                          closePopup(local.PopupID);
                          clientSideEvent("directly_purchase", {
                            itemid: 9900208
                          });
                        }
                      })];
                    }
                  })];
                }
              }), libs.createComponent(libs.Match, {
                get when() {
                  return props.reason == "no_enough_token";
                },
                get children() {
                  return [libs.createComponent(GenericPanel.CLabel, {
                    id: "ErrorMsg",
                    text: "#no_enough_token_2"
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    align: "center bottom",
                    flowChildren: "right",
                    get children() {
                      return [libs.createComponent(EOM_Button.EOM_Button, {
                        color: "Gray",
                        text: "#no_thanks",
                        onactivate: () => {
                          closePopup(local.PopupID);
                        }
                      }), libs.createComponent(EOM_Button.EOM_Button, {
                        color: "Blue",
                        text: "#CosmeticGet",
                        onactivate: () => {
                          closePopup(local.PopupID);
                          ToggleWindows('MenuButton_draw', true);
                        }
                      })];
                    }
                  })];
                }
              })];
            }
          })];
        }
      });
    }
  });
};

const Popup_StoreQRCodePayment = props => {
  const [local, others] = libs.splitProps(props, ["result", "PopupID", "group", "link", "logo", "parentPopupID"]);
  const getTitle = () => {
    switch (local.result) {
      case "loading":
        return "#Popup_StoreBuyItem_Result";
      case "success":
        return "#Popup_StoreBuyItem_Success";
      case "failure":
        return "#Popup_StoreBuyItem_Failure";
      default:
        return "#Popup_StoreBuyItem_Result";
    }
  };
  return libs.createComponent(BasePopup, {
    get group() {
      return local.group;
    },
    get PopupID() {
      return local.PopupID;
    },
    id: "Popup_StoreQRCodePayment",
    get title() {
      return getTitle();
    },
    size: "small",
    get children() {
      return libs.createComponent(EOM_Panel.EOM_Panel, {
        width: "100%",
        height: "100%",
        get children() {
          return [libs.memo(() => libs.memo(() => !!(local.result == "loading" && local.link == ""))() && libs.createComponent(EOM_Loading.EOM_Loading, {
            align: "center center",
            type: "Wave"
          })), libs.memo(() => libs.memo(() => !!(local.result == "loading" && local.link != ""))() && libs.createComponent(EOM_QRCode.EOM_QRCode, {
            align: "center center",
            get value() {
              return local.link;
            },
            qrcodesize: 200,
            get imageSrc() {
              return local.logo;
            }
          })), libs.memo(() => libs.memo(() => local.result == "success")() && libs.createComponent(EOM_Image.EOM_Image, {
            className: "Popup_StoreBuyItemResultIcon",
            align: "center center",
            get backgroundImage() {
              return getImagePath("icon/icon_party_ready_psd.png");
            },
            width: "64px",
            height: "64px"
          })), libs.memo(() => libs.memo(() => local.result == "failure")() && libs.createComponent(EOM_Image.EOM_Image, {
            className: "Popup_StoreBuyItemResultIcon",
            align: "center center",
            get backgroundImage() {
              return getImagePath("icon/icon_party_reject_psd.png");
            },
            width: "64px",
            height: "64px"
          }))];
        }
      });
    }
  });
};

const Popup_TeamHeroSwitch = props => {
  const localPlayerID = Players.GetLocalPlayer();
  const selfHeroInfo = CustomNetTables.GetTableValue("common", "hero_selection_" + localPlayerID);
  const selfHeroName = selfHeroInfo?.selected_hero;
  let heroSkin;
  if (selfHeroName != undefined) {
    const player_equipped_ornament = getServiceNetTable("player_equipped_ornament", localPlayerID);
    heroSkin = player_equipped_ornament?.[OrnamentType.HERO_SKIN]?.[GetGoodIDByHeroName(selfHeroName) ?? ""];
  }
  return (() => {
    const _el$ = libs.createElement("Button", {}, null);
    libs.setProp(_el$, "style", {
      width: "100%",
      height: "100%"
    });
    libs.setProp(_el$, "onactivate", () => {
      closePopup(props.PopupID, true);
    });
    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
      className: "Popup_TeamHeroSwitch",
      onactivate: () => {},
      get children() {
        return [libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "SwitchTitle",
          get children() {
            return [libs.createComponent(EOM_Image.EOM_Image, {
              className: "TitleLine Right"
            }), libs.createComponent(EOM_Image.EOM_Image, {
              className: "TitleLine"
            }), libs.createComponent(EOM_Label.EOM_Label, {
              text: "#TeamSwitchHero_Title"
            })];
          }
        }), libs.createComponent(EOM_Panel.EOM_Panel, {
          align: "center center",
          flowChildren: "right",
          get children() {
            return [libs.createComponent(EOM_Panel.EOM_Panel, {
              className: "PlayerHeroBox",
              get children() {
                return [libs.createComponent(EOM_Label.EOM_Label, {
                  align: "center top",
                  marginTop: "-32px",
                  text: "#PlayerTag",
                  hittest: false
                }), libs.createComponent(EOM_Portrait.EOM_Portrait, {
                  unitname: heroSkin ?? selfHeroName ?? ""
                }), libs.createComponent(EOM_Panel.EOM_Panel, {
                  id: "PlayerHeroBoxBorder"
                })];
              }
            }), libs.createComponent(EOM_Panel.EOM_Panel, {
              width: "66px",
              height: "66px",
              margin: "0 32px",
              verticalAlign: "center",
              style: {
                transform: "rotateZ(90deg)"
              },
              get backgroundImage() {
                return getImagePath("icon/s11_icon_exchange.png");
              },
              tooltip_text: "#TeamSwitchHero"
            }), libs.createComponent(EOM_Panel.EOM_Panel, {
              className: "PlayerHeroBox",
              get children() {
                return [libs.createComponent(EOM_Portrait.EOM_Portrait, {
                  get unitname() {
                    return props.hero_name;
                  }
                }), libs.createComponent(EOM_Panel.EOM_Panel, {
                  id: "PlayerHeroBoxBorder"
                })];
              }
            })];
          }
        }), libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "HeroSwitchButtons",
          get children() {
            return [libs.createComponent(EOM_Button.EOM_Button, {
              type: "C4glass",
              color: "Blue",
              text: "#Popup_Button_Confirm",
              onactivate: () => {
                GameEvents.SendCustomEventToServer("switch_hero", {});
                closePopup(props.PopupID);
              }
            }), libs.createComponent(EOM_Button.EOM_Button, {
              type: "C4glass",
              color: "Red",
              text: "#Popup_Button_Cancel",
              onactivate: () => closePopup(props.PopupID)
            })];
          }
        })];
      }
    }));
    return _el$;
  })();
};

const Template = props => {
  return libs.createComponent(BasePopup, {
    get PopupID() {
      return props.PopupID;
    }
  });
};

const Popup_TurntableReward = props => {
  const [local, others] = libs.splitProps(props, ["PopupID", "group", "activity_id"]);
  const activityID = local.activity_id;
  const [activityCollection, setActivityCollection] = libs.createSignal({});
  const [rewardInfoList, setRewardInfoList] = libs.createSignal([]);
  const [progress, setProgress] = libs.createSignal(0);
  const [selectedID, setSelectedID] = libs.createSignal(0);
  let inited = false;
  libs.createEffect(() => {
    let index = 0;
    const current_activityCollection = activityCollection();
    if (current_activityCollection) {
      const sortList = Object.keys(current_activityCollection).sort((a, b) => Number(b) - Number(a));
      for (const id of sortList) {
        const state = current_activityCollection[id];
        if (state != undefined && state == 2) {
          index = Number(id);
          inited = true;
          break;
        }
      }
    }
    if (!inited) {
      setSelectedID(index);
    }
  });
  const selectedReward = () => {
    let data;
    const current_selectedID = selectedID();
    const current_rewardInfoList = rewardInfoList();
    if (current_rewardInfoList[current_selectedID]) {
      data = current_rewardInfoList[current_selectedID].rewards[0];
    }
    return data;
  };
  libs.onMount(() => {
    let gameEventIDList = [];
    gameEventIDList.push(useNetData("task_activity_data", data => {
      if (data[activityID]) {
        if (data[activityID]?.rewards != undefined) {
          setActivityCollection(data[activityID].rewards);
        }
        setProgress(data[activityID]?.progress ?? 0);
      }
    }, Players.GetLocalPlayer()));
    gameEventIDList.push(useNetData("info_activity_data", data => {
      for (const activityInfo of data) {
        if (activityInfo.activity_id == activityID) {
          const reward = JSON.parse(activityInfo.extra_information);
          setRewardInfoList(reward.rewards);
        }
      }
    }));
    libs.onCleanup(() => {
      gameEventIDList.forEach(id => GameEvents.Unsubscribe(id));
    });
  });
  const progressBarInfo = libs.createMemo(() => {
    let arr = [];
    for (let index = 0; index < rewardInfoList().length; index++) {
      const currentInfo = rewardInfoList()[index];
      if (index == 0) {
        arr[index] = {
          start: 0,
          end: currentInfo.threshold
        };
        continue;
      }
      const lastInfo = rewardInfoList()[index - 1];
      arr[index] = {
        start: lastInfo.threshold,
        end: currentInfo.threshold
      };
    }
    return arr;
  });
  const receiveReward = rid => {
    callAction("activity_receive", {
      reward_id: rid,
      activity_id: activityID
    });
  };
  return libs.createComponent(BasePopup, {
    className: "Popup_TurntableReward",
    get PopupID() {
      return local.PopupID;
    },
    size: "large",
    get group() {
      return local.group;
    },
    title: "#Activity_Turntable_popuptitle" + activityID,
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "MainContainer",
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "Title",
            flowChildren: "right",
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                "class": "BG",
                id: "BGLeft"
              }), libs.createComponent(EOM_Label.EOM_Label, {
                text: "#mail_reward"
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                "class": "BG",
                id: "BGRight"
              })];
            }
          }), libs.createComponent(GenericPanel.CLabel, {
            id: "Stack",
            get text() {
              return $.Localize("#LimitOwned") + ": " + progress();
            }
          }), libs.createComponent(libs.Show, {
            get when() {
              return selectedReward() != undefined;
            },
            get children() {
              return libs.createComponent(ProductItem.ProductItem, {
                get itemid() {
                  return selectedReward().item_id;
                },
                get count() {
                  return selectedReward()?.amounts;
                },
                get rarity() {
                  return selectedReward()?.rarity;
                }
              });
            }
          })];
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "BottomContainer",
        scroll: "x",
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "ProgressBars",
            get children() {
              return libs.createComponent(libs.Index, {
                get each() {
                  return progressBarInfo();
                },
                children: (info, index) => {
                  const percentage = () => {
                    return Round(Clamp((progress() - info().start) / Math.max(1, info().end - info().start), 0, 1) * 100);
                  };
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "ProgressBar",
                    get tooltip() {
                      return `${progress()} / ${info().end}`;
                    },
                    get children() {
                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "ProgressBarBG",
                        get children() {
                          return libs.createComponent(EOM_Panel.EOM_Panel, {
                            id: "ProgressBarUp",
                            get width() {
                              return `${percentage()}%`;
                            }
                          });
                        }
                      });
                    }
                  });
                }
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "Targets",
            get children() {
              return libs.createComponent(libs.Index, {
                get each() {
                  return progressBarInfo();
                },
                children: (info, index) => {
                  const state = () => {
                    return activityCollection()?.[(index + 1).toString()] ?? 2;
                  };
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "Target",
                    get className() {
                      return libs.classNames({
                        locked: state() == 2,
                        Received: state() == 1
                      });
                    },
                    get children() {
                      return libs.createComponent(GenericPanel.CLabel, {
                        get text() {
                          return `${info().end}`;
                        }
                      });
                    }
                  });
                }
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "Rewards",
            get children() {
              return libs.createComponent(libs.Index, {
                get each() {
                  return rewardInfoList();
                },
                children: (info, index) => {
                  const itemData = () => {
                    return info().rewards[0];
                  };
                  const state = () => {
                    return activityCollection()[info().reward_id.toString()] ?? 2;
                  };
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("MiniReawrd", {
                        Selected: selectedID() == index,
                        Receivable: state() == 0,
                        Received: state() == 1
                      });
                    },
                    onactivate: () => {
                      setSelectedID(index);
                      if (state() == 0) {
                        receiveReward(info().reward_id);
                      }
                    },
                    get children() {
                      return [libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "SeletedBG"
                      }), libs.createComponent(libs.Show, {
                        get when() {
                          return KeyValues.CosmeticsKv[itemData().item_id];
                        },
                        get fallback() {
                          return libs.createComponent(ProductImage.ProductImage, {
                            get itemid() {
                              return itemData().item_id;
                            }
                          });
                        },
                        get children() {
                          return libs.createComponent(CosmeticCard.CosmeticImage, {
                            get itemid() {
                              return itemData().item_id;
                            },
                            onmouseover: self => {
                              $.DispatchEvent("DOTAShowTitleTextTooltip", self, "#" + itemData().item_id, "#" + itemData().item_id + "_description");
                            },
                            onmouseout: self => {
                              $.DispatchEvent("DOTAHideTitleTextTooltip", self);
                            }
                          });
                        }
                      }), libs.createComponent(libs.Show, {
                        get when() {
                          return libs.memo(() => !!itemData().amounts)() && itemData().amounts > 1;
                        },
                        get children() {
                          return libs.createComponent(GenericPanel.CLabel, {
                            className: "ProductCount",
                            get text() {
                              return "" + itemData().amounts;
                            }
                          });
                        }
                      }), libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "ReceivableBG"
                      })];
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

const Popup_UniversalHeroCard = props => {
  const [selectedHeroID, setSelectedHeroID] = libs.createSignal(-1);
  const playerHero = netdata_utils.createPlayerNetData("player_hero", Players.GetLocalPlayer());
  let hIds = () => {
    let heroIDList = props.hero_ids;
    if (props.hero_ids.length == 1 && props.hero_ids[0] == 3000000) {
      heroIDList = Object.entries(KeyValues.HeroIDCache).filter(([hid, heroName], i) => {
        if (KeyValues.UnitsCommonKv[heroName] && KeyValues.UnitsCommonKv[heroName].Hide != 1 && KeyValues.UnitsCommonKv[heroName].Access != "default") {
          return true;
        }
        return false;
      }).map(v => Number(v[0]));
    }
    return heroIDList.sort((a, b) => {
      let ownA = playerHero()?.[a.toString()]?.Permanent != 1 ? 0 : 1;
      let ownB = playerHero()?.[b.toString()]?.Permanent != 1 ? 0 : 1;
      return ownA - ownB;
    });
  };
  return libs.createComponent(BasePopup, {
    get PopupID() {
      return props.PopupID;
    },
    size: "large",
    title: "#Popup_UniversalHeroCard",
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "HeroList",
        width: "1377px",
        height: "570px",
        horizontalAlign: "center",
        marginTop: "40px",
        backgroundColor: "#1F243C",
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "HeroListContent",
            flowChildren: "right-wrap",
            scroll: "y",
            marginLeft: "4%",
            width: "95%",
            height: "100%",
            get children() {
              return libs.createComponent(libs.Index, {
                get each() {
                  return hIds();
                },
                children: hid => {
                  let heroName = () => GetHeroNameByGoodID(hid()) ?? "";
                  let own = () => playerHero()?.[hid().toString()]?.Permanent == 1;
                  return libs.createComponent(EOM_Button.EOM_BaseButton, {
                    get className() {
                      return libs.classNames('HeroCardButton', {
                        Show: true,
                        own: own()
                      });
                    },
                    onactivate: () => {
                      setSelectedHeroID(hid());
                    },
                    get children() {
                      return [libs.createComponent(HeroRoleCard.HeroRoleCard, {
                        get heroName() {
                          return heroName();
                        }
                      }), libs.createComponent(libs.Show, {
                        get when() {
                          return hid() == selectedHeroID();
                        },
                        get children() {
                          return libs.createComponent(EOM_Image.EOM_Image, {
                            get backgroundImage() {
                              return getImagePath("icon/selected.png");
                            },
                            id: "PickIcon"
                          });
                        }
                      }), libs.createComponent(libs.Show, {
                        get when() {
                          return own();
                        },
                        get children() {
                          return libs.createElement("Label", {
                            id: "own",
                            text: "#LimitOwned"
                          }, null);
                        }
                      })];
                    }
                  });
                }
              });
            }
          });
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        width: "100%",
        id: "bottomBar",
        verticalAlign: "bottom",
        marginBottom: "30px",
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            verticalAlign: "center",
            horizontalAlign: "center",
            flowChildren: "right",
            get children() {
              return [libs.createComponent(EOM_Button.EOM_Button, {
                text: "#Popup_Button_Cancel",
                color: "Gray",
                onactivate: () => closePopup(props.PopupID)
              }), libs.createComponent(EOM_Button.EOM_Button, {
                marginLeft: "70px",
                text: "#use",
                get enabled() {
                  return selectedHeroID() != -1;
                },
                color: "Purple",
                onactivate: () => {
                  callAction("use_prop", {
                    id: props.uid,
                    amounts: 1,
                    prop_id: props.prop_id,
                    params: [String(selectedHeroID())]
                  });
                  closePopup(props.PopupID);
                }
              })];
            }
          });
        }
      })];
    }
  });
};

GameUI.CustomUIConfig()._PopupPropsList = {};
const PopupComponents = {
  Template: Template,
  StoreBuyItem: Popup_StoreBuyItem,
  StoreBuyItemMult: Popup_StoreBuyItemMult,
  StoreBuyItemResult: Popup_StoreBuyItemResult,
  DrawBuyBox: Popup_DrawBuyBox,
  ErrorMessage: Popup_ErrorMessage,
  StoreQRCodePayment: Popup_StoreQRCodePayment,
  RankInfo: Popup_RankInfo,
  RankTask: Popup_RankTask,
  ColoringUnlock: Popup_ColoringUnlock,
  ActivityTutu: Popup_ActivityTutu,
  SelectCollections: Popup_SelectCollections,
  FirstRecharge: Popup_FirstRecharge,
  BackpackItem: Popup_BackpackItem,
  BackpackItemUse: Popup_BackpackItemUse,
  BountyCompetitionRule: Popup_BountyCompetitionRule,
  HeroSelectCard: Popup_HeroSelectCard,
  HeroProficiencyInfo: Popup_HeroProficiencyInfo,
  UniversalHeroCard: Popup_UniversalHeroCard,
  Confrim: Popup_Comfirm,
  RankNotice: Popup_RankNotice,
  ActivityTask: Popup_ActivityTask,
  CloseRookie: Popup_CloseRookie,
  NewPlayerInvited: Popup_NewPlayerInvited,
  PlayerProfile: Popup_PlayerProfile,
  Feedback: Popup_Feedback,
  PeakCupReward: Popup_PeakCupReward,
  PeakCupScore: Popup_PeakCupScore,
  PeakSignUp: Popup_PeakSignUp,
  IkunWinterTask: Popup_IkunWinterTask,
  ActivityDrawReward: Popup_ActivityDrawReward,
  ExchangeActivityList: Popup_ExchangeActivityList,
  FuCardSelection: Popup_FuCardSelection,
  PeakArena: Popup_PeakArena,
  PlayerQuestionnaire: Popup_PlayerQuestionnaire,
  RookieSect: Popup_RookieSect,
  ArenaSettlement: Popup_ArenaSettlement,
  TurntableReward: Popup_TurntableReward,
  TeamHeroSwitch: Popup_TeamHeroSwitch,
  PaymentOrder: Popup_PaymentOrder,
  PaymentOrderCreater: Popup_PaymentOrderCreater,
  PaymentSuccess: Popup_PaymentSuccess,
  DianFengRule: Popup_DianFengRule
};
const Popups = () => {
  const [popupData, setPopupData] = libs.createStore({});
  libs.onMount(() => {
    const id = GameEvents.Subscribe("client_side_event", eventData => {
      if ("show_popup" == eventData.event_name) {
        let PopupID = eventData.PopupID;
        let popupName = eventData.popupName;
        let data = Object.assign({
          PopupID,
          popupName
        }, GameUI.CustomUIConfig()._PopupPropsList[PopupID] ?? {});
        if (data.popupName && PopupComponents[data.popupName]) {
          setPopupData(data.PopupID, data);
        } else {
          console.error("invalid popupName: " + data.popupName);
        }
      }
      if ("close_popup" == eventData.event_name) {
        let data = eventData.event_data;
        if (data.PopupID) {
          setPopupData(data.PopupID, undefined);
          delete GameUI.CustomUIConfig()._PopupPropsList[data.PopupID];
        }
      }
    });
    libs.onCleanup(() => GameEvents.Unsubscribe(id));
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "Popups",
    hittest: false,
    get className() {
      return libs.classNames({
        ShowPopup: Object.keys(popupData).length > 0
      });
    },
    get children() {
      return libs.createComponent(libs.For, {
        get each() {
          return Object.keys(popupData);
        },
        children: (PopupID, index) => {
          return libs.createComponent(libs.Show, {
            get when() {
              return popupData[PopupID].popupName;
            },
            get children() {
              return PopupComponents[popupData[PopupID].popupName](popupData[PopupID]);
            }
          });
        }
      });
    }
  });
};
libs.render(() => Popups(), $.GetContextPanel());