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
var solid_utils = require('./solid_utils.js');
var activity_menu = require('./activity_menu.js');
var EOM_Countdown = require('./EOM_Countdown.js');
var EOM_Button = require('./EOM_Button.js');
var EOM_DropDown = require('./EOM_DropDown.js');
var ExchangeStore = require('./ExchangeStore.js');
var RecycleView = require('./RecycleView.js');
var StoreItem = require('./StoreItem.js');
var dig_veins_logic = require('./dig_veins_logic.js');
var EOM_Loading = require('./EOM_Loading.js');
var EOM_ProgressBar = require('./EOM_ProgressBar.js');
require('./service_netdata_helper.js');
require('./EOM_RedMark.js');
require('./EOM_TextEntry.js');
require('./equipment_utils.js');

const playerBPInfo$2 = solid_utils.createServiceNetData("player_battle_passes", {});
const CurrentBPSeason = libs.createMemo(() => {
  const serverTime = Math.floor(CustomUIConfig.GetServerTimeStamp());
  let season = 1;
  for (let i = 1; i <= 1000; i++) {
    const config = KeyValues.bp_season[String(i)];
    if (!config) break;
    if (serverTime >= config.start_time) {
      season = i;
    }
  }
  return season;
});
const [selectedBPSeason, setSelectedBPSeason] = libs.createSignal(CurrentBPSeason());
const BPSeason = libs.createMemo(() => selectedBPSeason());
const availableBPSeasons = libs.createMemo(() => {
  const currentSeason = CurrentBPSeason();
  return Object.keys(KeyValues.bp_season).map(Number).filter(season => Number.isInteger(season) && season >= 1 && season <= currentSeason).sort((a, b) => b - a);
});
const currentBPInfo$2 = libs.createMemo(() => playerBPInfo$2()[BPSeason()]);
const BPConfig = libs.createMemo(() => KeyValues.bp_season[BPSeason()]);
const BPExpConfig = libs.createMemo(() => KeyValues.bp_level_exp[BPSeason()]);
const BATTLE_PASS_ENDING_REMINDER_SECONDS = 5 * 24 * 60 * 60;
const BPRewardData = libs.createMemo(() => {
  const seasonReward = KeyValues.bp_rewards[BPSeason()] ?? {};
  const seasonRewardKeys = Object.keys(seasonReward);
  const arr = [];
  const rec = {};
  for (let i = 0; i < seasonRewardKeys.length; i++) {
    let lv = seasonRewardKeys[i];
    let lvData = seasonReward[lv];
    let commonReward;
    let plusReward;
    if (lvData[0]) {
      const [itemID, amount] = lvData[0].rewards.split(":");
      commonReward = {
        id: lvData[0].id,
        itemID: Number(itemID),
        amount: Number(amount),
        rarity: lvData[0].values
      };
    }
    if (lvData[1]) {
      const [itemID, amount] = lvData[1].rewards.split(":");
      plusReward = {
        id: lvData[1].id,
        itemID: Number(itemID),
        amount: Number(amount),
        rarity: lvData[1].values
      };
    }
    let data = {
      idx: i,
      level: Number(lv),
      commonReward,
      plusReward
    };
    rec[Number(lv)] = data;
    arr.push(data);
  }
  arr.sort((a, b) => a.level - b.level);
  return {
    arr,
    rec
  };
});
const BPRewards = () => BPRewardData().arr;
const BPRewardRecord = () => BPRewardData().rec;
const RewardDimensions = {
  width: 148,
  height: 481
};
let listHandle;
const [iNextSpecial, SetNextSpecial] = libs.createSignal(10);
const [canScrollLeft, setCanScrollLeft] = libs.createSignal(false);
const [canScrollRight, setCanScrollRight] = libs.createSignal(true);
const [showPreviewReward, setShowPreviewReward] = libs.createSignal(false);
const getReceiveKey = (level, plus) => `${level}_${plus ? "plus" : "common"}`;
const isInfiniteRewardLevel = level => level > BPConfig().max_level;
const infiniteRewardIndex = libs.createMemo(() => {
  return BPRewards().findIndex(reward => isInfiniteRewardLevel(reward.level));
});
const scrollToPlayerLevel = () => {
  const playerLevel = currentBPInfo$2()?.level ?? 1;
  if (playerLevel > BPConfig().max_level) {
    const index = infiniteRewardIndex();
    return index >= 0 ? index : Math.max(BPRewards().length - 1, 0);
  }
  const index = BPRewards().findIndex(reward => reward.level >= playerLevel);
  return index >= 0 ? index : Math.max(BPRewards().length - 1, 0);
};
const getNextSpecialReward = () => {
  return BPRewardRecord()[iNextSpecial()] ?? BPRewards().find(reward => reward.level > iNextSpecial()) ?? BPRewards()[BPRewards().length - 1];
};
const updateScrollButtons = percent => {
  setCanScrollLeft(percent > 0.001);
  setCanScrollRight(percent < 0.999);
};
const isSameReceiveStateRecord = (a, b) => {
  const aKeys = Object.keys(a);
  const bKeys = Object.keys(b);
  if (aKeys.length !== bKeys.length) return false;
  for (const key of aKeys) {
    if (a[key] !== b[key]) return false;
  }
  return true;
};
const reciveStateRecord = libs.createMemo(prev => {
  const received = currentBPInfo$2()?.received || [];
  const playerLevel = currentBPInfo$2()?.level ?? 1;
  const maxLevel = BPConfig().max_level;
  const receivedSet = new Set();
  const result = {};
  for (const item of received) {
    const key = `${item.level}_${item.plus ? "plus" : "common"}`;
    receivedSet.add(key);
    if (BPRewardRecord()[item.level]) {
      result[key] = "Recviced";
    }
  }
  for (const reward of BPRewards()) {
    const commonKey = `${reward.level}_common`;
    if (!result[commonKey]) {
      if (playerLevel < reward.level) {
        result[commonKey] = "Unreached";
      } else {
        result[commonKey] = "CanRecvice";
      }
    }
    if (reward.plusReward) {
      const plusKey = `${reward.level}_plus`;
      if (!result[plusKey]) {
        if (playerLevel < reward.level) {
          result[plusKey] = "Unreached";
        } else if (currentBPInfo$2()?.plus ?? false) {
          result[plusKey] = "CanRecvice";
        }
      }
    }
  }
  const getInfiniteState = plus => {
    if (plus && !(currentBPInfo$2()?.plus ?? false)) {
      return "Unreached";
    }
    if (playerLevel <= maxLevel) {
      return "Unreached";
    }
    for (let level = maxLevel + 1; level <= playerLevel; level++) {
      if (!receivedSet.has(getReceiveKey(level, plus))) {
        return "CanRecvice";
      }
    }
    return "Recviced";
  };
  for (const reward of BPRewards()) {
    if (!isInfiniteRewardLevel(reward.level)) continue;
    if (reward.commonReward) {
      result[getReceiveKey(reward.level, false)] = getInfiniteState(false);
    }
    if (reward.plusReward) {
      result[getReceiveKey(reward.level, true)] = getInfiniteState(true);
    }
  }
  return isSameReceiveStateRecord(prev, result) ? prev : result;
}, {});
const _bpHasClaimable = libs.createMemo(() => {
  const states = reciveStateRecord();
  for (const key in states) {
    if (states[key] === "CanRecvice") return true;
  }
  return false;
});
libs.createEffect(libs.on(() => [BPSeason(), _bpHasClaimable()], ([season, red]) => {
  if (season === CurrentBPSeason()) {
    CustomUIConfig.SetRedPoint(red, "activity", "battlepass", "battlepass");
  }
}));
const BattlePass = () => {
  libs.onMount(() => {
    libs.onCleanup(() => {
      setShowPreviewReward(false);
    });
  });
  const isInfiniteLevel = () => (currentBPInfo$2()?.level ?? 1) > BPConfig().max_level;
  const progressMaxLvExp = () => {
    const expLevel = isInfiniteLevel() ? 10001 : currentBPInfo$2()?.level ?? 1;
    return BPExpConfig()[expLevel]?.exp ?? BPExpConfig()[10001]?.exp ?? 1;
  };
  const maxLvExp = () => {
    return String(progressMaxLvExp());
  };
  const expPercent = () => {
    const maxExp = progressMaxLvExp();
    if (maxExp <= 0) return 0;
    return Math.max(0, Math.min(100, (currentBPInfo$2()?.extra_exp ?? 0) / maxExp * 100));
  };
  const selectBPSeason = season => {
    setSelectedBPSeason(season);
    SetNextSpecial(10);
    setCanScrollLeft(false);
    setCanScrollRight(true);
    $.Schedule(0, () => listHandle?.scroll2Child(scrollToPlayerLevel(), "center", true));
  };
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
    id: "Battlepass",
    get ["class"]() {
      return libs.classNames({
        ShowPreviewReward: showPreviewReward()
      });
    },
    get children() {
      return [(() => {
        const _el$ = libs.createElement("Panel", {
            id: "CenterBlock",
            hittest: false
          }, null),
          _el$2 = libs.createElement("Panel", {
            id: "BPSeasonInfo"
          }, _el$),
          _el$3 = libs.createElement("Panel", {
            id: "Season"
          }, _el$2);
          libs.createElement("Image", {
            id: "S"
          }, _el$3);
          const _el$5 = libs.createElement("Image", {
            id: "SeasonNum",
            get ["class"]() {
              return String(BPSeason());
            }
          }, _el$3);
          libs.createElement("Label", {
            id: "Text",
            text: "#BP_SeasonPass"
          }, _el$3);
          libs.createElement("Panel", {
            id: "SeasonLine"
          }, _el$2);
          const _el$8 = libs.createElement("Panel", {
            id: "PassRewardListContainer"
          }, _el$),
          _el$9 = libs.createElement("Panel", {
            id: "PassType"
          }, _el$8);
          libs.createElement("Panel", {
            id: "Normal"
          }, _el$9);
          libs.createElement("Panel", {
            id: "Advanced"
          }, _el$9);
          const _el$10 = libs.createElement("Panel", {
            id: "NextSpecialRewardContainer"
          }, _el$8),
          _el$11 = libs.createElement("Panel", {
            id: "LvInfo"
          }, _el$),
          _el$12 = libs.createElement("Panel", {
            id: "Lv"
          }, _el$11),
          _el$13 = libs.createElement("Label", {
            get text() {
              return currentBPInfo$2()?.level ?? 1;
            }
          }, _el$12),
          _el$14 = libs.createElement("Panel", {
            id: "ExpInfo"
          }, _el$11),
          _el$15 = libs.createElement("Label", {
            id: "Exp",
            text: "#BP_ExpFormat",
            get dialogVariables() {
              return {
                cur: currentBPInfo$2()?.extra_exp ?? 0,
                max: maxLvExp()
              };
            }
          }, _el$14),
          _el$16 = libs.createElement("Panel", {
            id: "ExpBarContainer"
          }, _el$14),
          _el$17 = libs.createElement("Panel", {
            id: "Bar",
            get style() {
              return {
                clip: `rect( 0%, ${expPercent()}%, 100%, 0% )`
              };
            }
          }, _el$16),
          _el$18 = libs.createElement("Panel", {
            id: "Btns"
          }, _el$);
        libs.insert(_el$3, libs.createComponent(libs.Show, {
          get when() {
            return CurrentBPSeason() > 1;
          },
          get children() {
            return libs.createComponent(EOM_DropDown.EOM_DropDown, {
              type: "EquipmentDropDown",
              customWidth: "300px",
              get index() {
                return availableBPSeasons().indexOf(BPSeason());
              },
              onChange: index => {
                const season = availableBPSeasons()[index];
                if (season !== undefined) {
                  selectBPSeason(season);
                }
              },
              get children() {
                return libs.createComponent(libs.For, {
                  get each() {
                    return availableBPSeasons();
                  },
                  children: season => (() => {
                    const _el$20 = libs.createElement("Label", {
                      text: "#BP_SeasonTitle",
                      vars: {
                        value: season
                      }
                    }, null);
                    libs.setProp(_el$20, "vars", {
                      value: season
                    });
                    return _el$20;
                  })()
                });
              }
            });
          }
        }), null);
        libs.insert(_el$2, libs.createComponent(EOM_Countdown.EOM_Countdown, {
          icon: true,
          get endTime() {
            return BPConfig().end_time;
          },
          text: "#BP_EndTime2"
        }), null);
        libs.insert(_el$8, libs.createComponent(RecycleView.RecycleView, {
          id: "RewardList",
          input: BPRewards,
          direction: "Horizontal",
          childConfig: RewardDimensions,
          showBar: false,
          wheelStep: 148 * 0.5,
          onScrollPercent: updateScrollButtons,
          handle: h => listHandle = h,
          onScroll: (fScroll, handler) => {
            const pList = handler.refRoot;
            if (pList) {
              const fRightEdge = fScroll + pList.actuallayoutwidth;
              for (let i = 10; i <= BPConfig().max_level; i += 10) {
                if (i * RewardDimensions.width > fRightEdge) {
                  SetNextSpecial(i);
                  return;
                }
              }
              SetNextSpecial(BPConfig().max_level);
            }
          },
          onload: p => {
            let id = setInterval(() => {
              if (p?.IsValid() && p.actuallayoutwidth > 0 && p.actuallayoutheight > 0) {
                listHandle?.scroll2Child(scrollToPlayerLevel(), "center");
                clearInterval(id);
              }
            }, 0.1);
          },
          children: info => libs.createComponent(RewardDetails, libs.mergeProps$1(info, {
            get HighlightReward() {
              return info().level % 10 === 0;
            }
          }))
        }), _el$10);
        libs.insert(_el$10, libs.createComponent(RewardDetails, libs.mergeProps$1(getNextSpecialReward, {
          special: true
        })));
        libs.insert(_el$8, libs.createComponent(EOM_Button.EOM_BaseButton, {
          id: "RightArrow",
          get enabled() {
            return canScrollRight();
          },
          onactivate: () => {
            listHandle?.scroll(toFiniteNumber(listHandle.refRoot?.actuallayoutwidth));
          }
        }), null);
        libs.insert(_el$8, libs.createComponent(EOM_Button.EOM_BaseButton, {
          id: "LeftArrow",
          get enabled() {
            return canScrollLeft();
          },
          onactivate: () => {
            listHandle?.scroll(-toFiniteNumber(listHandle.refRoot?.actuallayoutwidth));
          }
        }), null);
        libs.insert(_el$11, libs.createComponent(EOM_Button.EOM_BaseButton, {
          id: "AddExpBtn",
          onactivate: () => {
            ClientSideEvent("directly_purchase", {
              itemid: BPConfig().exp_goods_id,
              source: "battlepass"
            });
          }
        }), null);
        libs.insert(_el$18, libs.createComponent(libs.Show, {
          get when() {
            return !(currentBPInfo$2()?.plus ?? false);
          },
          get children() {
            return libs.createComponent(EOM_Button.EOM_Button, {
              marginRight: "10px",
              color: "Confirm",
              text: "#BP_UnlockPass",
              onactivate: () => {
                if (BPConfig().end_time - CustomUIConfig.GetServerTimeStamp() <= BATTLE_PASS_ENDING_REMINDER_SECONDS) {
                  ErrorMessage("#error_bp_endtime");
                }
                ClientSideEvent("directly_purchase", {
                  itemid: BPConfig().plus_goods_id,
                  source: "battlepass"
                });
              }
            });
          }
        }), null);
        libs.insert(_el$18, libs.createComponent(EOM_Button.EOM_Button, {
          text: "#Activity_ReceiveALl",
          get enabled() {
            return _bpHasClaimable();
          },
          onactivate: () => {
            CallAction("/v1/battle_pass/receive_rewards", {
              season: BPSeason(),
              receive_all: true
            });
          }
        }), null);
        libs.insert(_el$, libs.createComponent(EOM_Button.EOM_BaseButton, {
          id: "PreviewReward",
          onactivate: () => {
            setShowPreviewReward(prev => {
              return !prev;
            });
          },
          get children() {
            return libs.createElement("Label", {
              text: "#BP_ViewRewards"
            }, null);
          }
        }), null);
        libs.effect(_p$ => {
          const _v$ = String(BPSeason()),
            _v$2 = currentBPInfo$2()?.level ?? 1,
            _v$3 = {
              cur: currentBPInfo$2()?.extra_exp ?? 0,
              max: maxLvExp()
            },
            _v$4 = {
              clip: `rect( 0%, ${expPercent()}%, 100%, 0% )`
            };
          _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$5, "class", _v$, _p$._v$));
          _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$13, "text", _v$2, _p$._v$2));
          _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$15, "dialogVariables", _v$3, _p$._v$3));
          _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$17, "style", _v$4, _p$._v$4));
          return _p$;
        }, {
          _v$: undefined,
          _v$2: undefined,
          _v$3: undefined,
          _v$4: undefined
        });
        return _el$;
      })(), libs.createComponent(libs.Show, {
        get when() {
          return showPreviewReward();
        },
        get children() {
          return libs.createComponent(PreviewRewardWindow, {});
        }
      })];
    }
  });
};
function RewardDetails(props) {
  const commonState = libs.createMemo(() => reciveStateRecord()[getReceiveKey(props.level, false)]);
  const plusState = libs.createMemo(() => reciveStateRecord()[getReceiveKey(props.level, true)]);
  const isActive = libs.createMemo(() => (currentBPInfo$2()?.level ?? 1) >= props.level || (currentBPInfo$2()?.level ?? 1) > BPConfig().max_level);
  const plusLocked = libs.createMemo(() => !(currentBPInfo$2()?.plus ?? false));
  return (() => {
    const _el$21 = libs.createElement("Panel", {
        get ["class"]() {
          return libs.classNames("RewardItem", {
            HighlightReward: props.HighlightReward
          });
        }
      }, null),
      _el$22 = libs.createElement("Panel", {
        id: "RewardLevel"
      }, _el$21);
    libs.setProp(_el$21, "onactivate", () => {
      if (commonState() == "CanRecvice" || plusState() == "CanRecvice") {
        CallAction("/v1/battle_pass/receive_rewards", {
          season: BPSeason(),
          receive_all: true
        });
      }
    });
    libs.insert(_el$22, libs.createComponent(libs.Show, {
      get when() {
        return props.level <= BPConfig().max_level;
      },
      get fallback() {
        return libs.createElement("Label", {
          text: "\u221e"
        }, null);
      },
      get children() {
        const _el$23 = libs.createElement("Label", {
          get text() {
            return props.level;
          }
        }, null);
        libs.effect(_$p => libs.setProp(_el$23, "text", props.level, _$p));
        return _el$23;
      }
    }));
    libs.insert(_el$21, libs.createComponent(libs.Show, {
      get when() {
        return props.commonReward;
      },
      children: reward => libs.createComponent(BPItem, libs.mergeProps$1(reward, {
        isPlus: false,
        get recviceState() {
          return commonState();
        },
        isLock: false
      }))
    }), null);
    libs.insert(_el$21, libs.createComponent(libs.Show, {
      get when() {
        return props.plusReward;
      },
      children: reward => libs.createComponent(BPItem, libs.mergeProps$1(reward, {
        isPlus: true,
        get recviceState() {
          return plusState();
        },
        get isLock() {
          return plusLocked();
        }
      }))
    }), null);
    libs.effect(_p$ => {
      const _v$5 = libs.classNames("RewardItem", {
          HighlightReward: props.HighlightReward
        }),
        _v$6 = {
          Active: isActive()
        };
      _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$21, "class", _v$5, _p$._v$5));
      _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$22, "classList", _v$6, _p$._v$6));
      return _p$;
    }, {
      _v$5: undefined,
      _v$6: undefined
    });
    return _el$21;
  })();
}
function BPItem(props) {
  return (() => {
    const _el$25 = libs.createElement("Panel", {
        get ["class"]() {
          return libs.classNames("BPItem", "Rarity_" + props.rarity, props.recviceState, {
            IsPlus: props.isPlus,
            Locked: props.isLock
          });
        }
      }, null),
      _el$26 = libs.createElement("Panel", {
        id: "Border",
        hittest: false
      }, _el$25);
      libs.createElement("Panel", {
        id: "LockIcon",
        hittest: false
      }, _el$25);
      libs.createElement("Panel", {
        id: "RecvicedIcon",
        hittest: false
      }, _el$25);
    libs.insert(_el$25, libs.createComponent(StoreItem.StoreItemBlock, {
      get item_id() {
        return props.itemID;
      },
      get rarity() {
        return props.rarity;
      },
      get amounts() {
        return props.amount;
      }
    }), _el$26);
    libs.effect(_$p => libs.setProp(_el$25, "class", libs.classNames("BPItem", "Rarity_" + props.rarity, props.recviceState, {
      IsPlus: props.isPlus,
      Locked: props.isLock
    }), _$p));
    return _el$25;
  })();
}
const PreviewRewardWindow = () => {
  const plusRewards = libs.createMemo(() => {
    const map = new Map();
    for (const r of BPRewards()) {
      if (!r.plusReward) continue;
      const existing = map.get(r.plusReward.itemID);
      if (existing) {
        existing.amount += r.plusReward.amount;
        existing.maxConfigRarity = Math.max(existing.maxConfigRarity, r.plusReward.rarity);
      } else {
        map.set(r.plusReward.itemID, {
          itemID: r.plusReward.itemID,
          amount: r.plusReward.amount,
          maxConfigRarity: r.plusReward.rarity
        });
      }
    }
    const items = [];
    for (const v of map.values()) {
      const rarity = KeyValues.info_item_rarity[v.itemID]?.rarity ?? v.maxConfigRarity;
      items.push({
        id: String(v.itemID),
        itemID: v.itemID,
        amount: v.amount,
        rarity
      });
    }
    items.sort((a, b) => b.rarity - a.rarity);
    return items;
  });
  const [hoverItem, setHoverItem] = libs.createSignal();
  libs.createEffect(libs.on(plusRewards, rewards => {
    const currentItemID = hoverItem()?.itemID;
    setHoverItem(rewards.find(item => item.itemID === currentItemID) ?? rewards[0]);
  }));
  const access = libs.createMemo(() => {
    if (!hoverItem()) {
      return "";
    }
    return GetLocalization(`#${hoverItem().itemID}_description`);
  });
  return (() => {
    const _el$29 = libs.createElement("Panel", {
      id: "PreviewRewardWindow"
    }, null);
    libs.insert(_el$29, libs.createComponent(ExchangeStore.EOM_DrawerLayout, {
      get title() {
        return `#${BPConfig().plus_goods_id}`;
      },
      get show() {
        return showPreviewReward();
      },
      onclose: () => setShowPreviewReward(false),
      get children() {
        return [(() => {
          const _el$30 = libs.createElement("Panel", {
            id: "ItemList",
            scroll: "y",
            "class": "VerticalScrollStyle"
          }, null);
          libs.setProp(_el$30, "scroll", "y");
          libs.insert(_el$30, libs.createComponent(libs.For, {
            get each() {
              return plusRewards();
            },
            children: reward => libs.createComponent(BPRewardCard, libs.mergeProps$1(reward, {
              onmouseover: () => setHoverItem(reward)
            }))
          }));
          return _el$30;
        })(), libs.createComponent(libs.Show, {
          get when() {
            return !(currentBPInfo$2()?.plus ?? false);
          },
          get children() {
            return libs.createComponent(EOM_Button.EOM_Button, {
              align: "center bottom",
              text: "#BP_UnlockPass",
              onactivate: () => {
                ClientSideEvent("directly_purchase", {
                  itemid: BPConfig().plus_goods_id,
                  source: "battlepass"
                });
              }
            });
          }
        })];
      }
    }), null);
    libs.insert(_el$29, libs.createComponent(libs.Show, {
      get when() {
        return hoverItem();
      },
      get children() {
        return [libs.createComponent(StoreItem.StoreItemImage, {
          id: "HoverItemImage",
          get itemid() {
            return hoverItem().itemID;
          }
        }), (() => {
          const _el$31 = libs.createElement("Panel", {
              id: "ItemInfo"
            }, null),
            _el$32 = libs.createElement("Panel", {
              flowChildren: "right"
            }, _el$31),
            _el$33 = libs.createElement("Label", {
              id: "Name",
              get text() {
                return "#" + hoverItem().itemID;
              }
            }, _el$32),
            _el$34 = libs.createElement("Label", {
              id: "Amount",
              get text() {
                return "x" + hoverItem().amount;
              }
            }, _el$32);
          libs.setProp(_el$32, "flowChildren", "right");
          libs.insert(_el$31, libs.createComponent(libs.Show, {
            get when() {
              return !access().startsWith("#");
            },
            get children() {
              return [libs.createElement("Panel", {
                "class": "Line"
              }, null), (() => {
                const _el$36 = libs.createElement("Label", {
                  id: "Access",
                  get text() {
                    return access();
                  }
                }, null);
                libs.effect(_$p => libs.setProp(_el$36, "text", access(), _$p));
                return _el$36;
              })()];
            }
          }), null);
          libs.effect(_p$ => {
            const _v$7 = "#" + hoverItem().itemID,
              _v$8 = "x" + hoverItem().amount;
            _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$33, "text", _v$7, _p$._v$7));
            _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$34, "text", _v$8, _p$._v$8));
            return _p$;
          }, {
            _v$7: undefined,
            _v$8: undefined
          });
          return _el$31;
        })()];
      }
    }), null);
    return _el$29;
  })();
};
function BPRewardCard(props) {
  return (() => {
    const _el$37 = libs.createElement("Panel", {
        get ["class"]() {
          return libs.classNames("BPRewardCard", "Rarity" + props.rarity);
        },
        get onmouseover() {
          return props.onmouseover;
        },
        get onmouseout() {
          return props.onmouseout;
        }
      }, null),
      _el$38 = libs.createElement("Label", {
        id: "ItemName",
        get text() {
          return "#" + props.itemID;
        }
      }, _el$37);
      libs.createElement("Image", {
        id: "SplitLine"
      }, _el$37);
      const _el$40 = libs.createElement("Label", {
        id: "ItemCount",
        get text() {
          return "×" + props.amount;
        },
        hittest: false
      }, _el$37);
    libs.insert(_el$37, libs.createComponent(StoreItem.StoreItemImage, {
      get itemid() {
        return props.itemID;
      }
    }), _el$40);
    libs.effect(_p$ => {
      const _v$9 = libs.classNames("BPRewardCard", "Rarity" + props.rarity),
        _v$0 = props.onmouseover,
        _v$1 = props.onmouseout,
        _v$10 = "#" + props.itemID,
        _v$11 = "×" + props.amount,
        _v$12 = props.amount > 1;
      _v$9 !== _p$._v$9 && (_p$._v$9 = libs.setProp(_el$37, "class", _v$9, _p$._v$9));
      _v$0 !== _p$._v$0 && (_p$._v$0 = libs.setProp(_el$37, "onmouseover", _v$0, _p$._v$0));
      _v$1 !== _p$._v$1 && (_p$._v$1 = libs.setProp(_el$37, "onmouseout", _v$1, _p$._v$1));
      _v$10 !== _p$._v$10 && (_p$._v$10 = libs.setProp(_el$38, "text", _v$10, _p$._v$10));
      _v$11 !== _p$._v$11 && (_p$._v$11 = libs.setProp(_el$40, "text", _v$11, _p$._v$11));
      _v$12 !== _p$._v$12 && (_p$._v$12 = libs.setProp(_el$40, "visible", _v$12, _p$._v$12));
      return _p$;
    }, {
      _v$9: undefined,
      _v$0: undefined,
      _v$1: undefined,
      _v$10: undefined,
      _v$11: undefined,
      _v$12: undefined
    });
    return _el$37;
  })();
}

const BattlepassInfo = props => {
  const BPConfig = () => KeyValues.bp_season[props.season];
  const BPExpConfig = () => KeyValues.bp_level_exp[props.season];
  const isInfiniteLevel = () => props.level > BPConfig().max_level;
  const upgradeExp = () => {
    const expLevel = isInfiniteLevel() ? 10001 : props.level;
    return BPExpConfig()[expLevel]?.exp ?? BPExpConfig()[10001]?.exp ?? 1;
  };
  const displayUpgradeExp = () => String(upgradeExp());
  const expPercent = () => {
    const maxExp = upgradeExp();
    if (maxExp <= 0) return 0;
    return Math.max(0, Math.min(100, props.extraExp / maxExp * 100));
  };
  return (() => {
    const _el$ = libs.createElement("Panel", {
        get ["class"]() {
          return "BattlepassInfo " + props.type;
        }
      }, null),
      _el$2 = libs.createElement("Panel", {
        id: "BpLevel"
      }, _el$),
      _el$3 = libs.createElement("Label", {
        get text() {
          return props.level;
        }
      }, _el$2),
      _el$4 = libs.createElement("Label", {
        id: "SeasonTitle",
        get vars() {
          return {
            value: props.season
          };
        },
        text: "#BP_SeasonTitle"
      }, _el$),
      _el$5 = libs.createElement("Panel", {
        id: "ExpBarContainer"
      }, _el$),
      _el$6 = libs.createElement("Panel", {
        id: "Bar",
        get style() {
          return {
            clip: `rect( 0%, ${expPercent()}%, 100%, 0% )`
          };
        }
      }, _el$5),
      _el$7 = libs.createElement("Label", {
        id: "ExpLabel",
        text: "#BP_ExpText",
        get vars() {
          return {
            value1: props.extraExp,
            value2: displayUpgradeExp()
          };
        }
      }, _el$),
      _el$8 = libs.createElement("Panel", {
        id: "EndTime"
      }, _el$);
      libs.createElement("Label", {
        id: "EndTimeTitle",
        text: "#BP_EndTimeTitle"
      }, _el$8);
    libs.insert(_el$, libs.createComponent(EOM_Button.EOM_Button, {
      id: "BuyBpLvBtn",
      size: "Small",
      text: "#BP_BuyLv",
      onactivate: () => {
        ClientSideEvent("directly_purchase", {
          itemid: BPConfig().exp_goods_id,
          source: "battlepass_info"
        });
      }
    }), _el$8);
    libs.insert(_el$8, libs.createComponent(EOM_Countdown.EOM_Countdown, {
      icon: true,
      get endTime() {
        return BPConfig().end_time;
      },
      text: "#BP_EndTime"
    }), null);
    libs.insert(_el$8, libs.createComponent(EOM_Button.EOM_Button, {
      id: "BuyBpPlusBtn",
      text: "#BP_Plus",
      onactivate: () => {
        ClientSideEvent("directly_purchase", {
          itemid: BPConfig().plus_goods_id,
          source: "battlepass_info"
        });
      }
    }), null);
    libs.effect(_p$ => {
      const _v$ = "BattlepassInfo " + props.type,
        _v$2 = props.level,
        _v$3 = {
          value: props.season
        },
        _v$4 = {
          clip: `rect( 0%, ${expPercent()}%, 100%, 0% )`
        },
        _v$5 = {
          value1: props.extraExp,
          value2: displayUpgradeExp()
        };
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$, "class", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$3, "text", _v$2, _p$._v$2));
      _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$4, "vars", _v$3, _p$._v$3));
      _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$6, "style", _v$4, _p$._v$4));
      _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$7, "vars", _v$5, _p$._v$5));
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

const dayrewardConfig = KeyValues.dayreward ?? {};
const dayBoxEntry = Object.entries(dayrewardConfig)[0];
const dayBoxNeedCount = dayBoxEntry ? dayBoxEntry[1].task_num : 5;
const playerBPInfo$1 = solid_utils.createServiceNetData("player_battle_passes", {});
const currentSeason$1 = libs.createMemo(() => {
  const serverTime = Math.floor(CustomUIConfig.GetServerTimeStamp());
  let season = 1;
  for (let i = 1; i <= 1000; i++) {
    const config = KeyValues.bp_season[String(i)];
    if (!config) break;
    if (serverTime >= config.start_time) {
      season = i;
    }
  }
  return season;
});
const currentBPInfo$1 = libs.createMemo(() => playerBPInfo$1()[currentSeason$1()]);
const daily_task = solid_utils.createServiceNetData("player_daily_tasks", {});
const player_blessings$2 = solid_utils.createServiceNetData("player_blessings", {});
const player_daily_task_box_receive_records = solid_utils.createServiceNetData("player_daily_task_box_receive_records", {});
const BEIJING_TIME_OFFSET_SECONDS = 8 * 60 * 60;
const [currentServerTime, setCurrentServerTime] = libs.createSignal(Math.floor(CustomUIConfig.GetServerTimeStamp()));
setInterval(() => {
  setCurrentServerTime(Math.floor(CustomUIConfig.GetServerTimeStamp()));
}, 1000);
function getBeijingDayStart(timestamp) {
  const seconds = Math.floor(timestamp);
  return seconds - (seconds + BEIJING_TIME_OFFSET_SECONDS) % 86400;
}
function isTaskUnlocked$1(taskID, serverTime = currentServerTime()) {
  const blessingCondition = KeyValues.task[taskID]?.blessing_condition ?? 0;
  if (blessingCondition <= 0) return true;
  const buffData = player_blessings$2()?.[blessingCondition];
  if (buffData == undefined) return false;
  if (buffData.permanent) return true;
  return buffData.expire_time > serverTime;
}
function getTaskRewardList(taskID) {
  const kv = KeyValues.task[taskID];
  if (!kv) return [];
  return Object.entries(kv.rewards).map(([id, num]) => {
    return {
      id,
      num
    };
  });
}
const taskList$1 = libs.createMemo(() => {
  const timestamp = CustomUIConfig.GetServerTimeStamp();
  return Object.values(daily_task()).filter(task => {
    let kv = KeyValues.task[task.task_id];
    if (!kv || kv.type != 1) return false;
    if (task.end_time < timestamp) return false;
    if (task.start_time > timestamp) return false;
    return true;
  }).sort((a, b) => {
    const canReceive1 = a.progress >= a.target ? 1 : 0;
    const canReceive2 = b.progress >= b.target ? 1 : 0;
    const buff_condition1 = KeyValues.task[a.task_id]?.blessing_condition ?? 0;
    const buff_condition2 = KeyValues.task[b.task_id]?.blessing_condition ?? 0;
    return multiCompare(a.receive_progress - b.receive_progress, canReceive2 - canReceive1, buff_condition2 - buff_condition1);
  });
});
const receiveDailyTaskCount = libs.createMemo(() => taskList$1().filter(t => t.receive_progress == 1 && isTaskUnlocked$1(t.task_id)).length);
const isDailyBoxReceived = libs.createMemo(() => {
  const records = player_daily_task_box_receive_records();
  const today = String(getBeijingDayStart(CustomUIConfig.GetServerTimeStamp()));
  const record = records[today];
  return record != undefined;
});
const _dailyHasClaimable = libs.createMemo(() => {
  const tasks = taskList$1();
  for (let i = 0; i < tasks.length; i++) {
    const task = tasks[i];
    if (task.receive_progress == 1) continue;
    if (!isTaskUnlocked$1(task.task_id)) continue;
    if (task.progress >= task.target) return true;
  }
  if (receiveDailyTaskCount() >= dayBoxNeedCount && !isDailyBoxReceived()) {
    return true;
  }
  return false;
});
libs.createEffect(libs.on(_dailyHasClaimable, red => {
  CustomUIConfig.SetRedPoint(red, "activity", "battlepass", "daily_task");
}));
function DailyTask() {
  const [bRequesting, SetRequesting] = libs.createSignal(false);
  const canReciveDailyBox = () => receiveDailyTaskCount() >= dayBoxNeedCount;
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
    id: "DailyTask",
    get children() {
      const _el$ = libs.createElement("Panel", {
          id: "CenterBlock",
          hittest: false
        }, null),
        _el$2 = libs.createElement("Panel", {
          id: "BattlepassInfoContainer"
        }, _el$),
        _el$3 = libs.createElement("Panel", {
          id: "DailyTaskContent"
        }, _el$),
        _el$4 = libs.createElement("Panel", {
          id: "DailyBox"
        }, _el$3),
        _el$5 = libs.createElement("Panel", {
          id: "DailyBoxIcon"
        }, _el$4);
        libs.createElement("Panel", {
          id: "DailyBoxReceived"
        }, _el$5);
        const _el$7 = libs.createElement("Panel", {
          id: "DailyBoxTitle"
        }, _el$4);
        libs.createElement("Label", {
          text: "#DailyTask_Box"
        }, _el$7);
        const _el$9 = libs.createElement("Label", {
          id: "DailyBoxProgressTitle",
          text: "#DailyTask_Progress",
          dialogVariables: {
            count: dayBoxNeedCount
          }
        }, _el$4),
        _el$0 = libs.createElement("Panel", {
          id: "ProgressContainer"
        }, _el$4),
        _el$1 = libs.createElement("Panel", {
          id: "ProgressBG"
        }, _el$0),
        _el$10 = libs.createElement("Panel", {
          id: "Bar",
          get style() {
            return {
              clip: `rect( 0%, ${receiveDailyTaskCount() / dayBoxNeedCount * 100}%, 100%, 0% )`
            };
          }
        }, _el$1),
        _el$11 = libs.createElement("Label", {
          id: "DailyBoxProgressValue",
          get text() {
            return `${receiveDailyTaskCount()}/${dayBoxNeedCount}`;
          }
        }, _el$0),
        _el$12 = libs.createElement("Panel", {
          id: "TaskList",
          flowChildren: "down",
          scroll: "y"
        }, _el$3);
      libs.insert(_el$2, libs.createComponent(BattlepassInfo, {
        type: "Long",
        get extraExp() {
          return currentBPInfo$1()?.extra_exp ?? 0;
        },
        get level() {
          return currentBPInfo$1()?.level ?? 1;
        },
        get season() {
          return currentSeason$1();
        }
      }));
      libs.setProp(_el$9, "dialogVariables", {
        count: dayBoxNeedCount
      });
      libs.insert(_el$4, libs.createComponent(libs.Show, {
        get when() {
          return !isDailyBoxReceived();
        },
        get fallback() {
          return libs.createElement("Panel", {
            id: "ReceivedTag"
          }, null);
        },
        get children() {
          return libs.createComponent(EOM_Button.EOM_Button, {
            id: "DailyBoxGetButton",
            get enabled() {
              return canReciveDailyBox();
            },
            text: "#DailyTask_Get",
            onactivate: () => {
              if (bRequesting()) {
                return;
              }
              SetRequesting(true);
              CallActionRequest("/v1/task/receive_daily_task_box", {
                day: getBeijingDayStart(CustomUIConfig.GetServerTimeStamp()),
                task_num: dayBoxNeedCount
              }, data => {
                SetRequesting(false);
              });
            }
          });
        }
      }), null);
      libs.setProp(_el$12, "flowChildren", "down");
      libs.setProp(_el$12, "scroll", "y");
      libs.insert(_el$12, libs.createComponent(libs.Index, {
        get each() {
          return taskList$1();
        },
        children: task => {
          const buffCondition = () => KeyValues.task[task().task_id].blessing_condition;
          const state = () => {
            if (!isTaskUnlocked$1(task().task_id)) return "Locked";
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
            return getTaskRewardList(task().task_id);
          };
          return (() => {
            const _el$14 = libs.createElement("Panel", {
                get ["class"]() {
                  return "TaskItem " + state();
                }
              }, null),
              _el$16 = libs.createElement("Label", {
                id: "TaskDes",
                get text() {
                  return "#Task_Desc_" + descID();
                },
                get vars() {
                  return {
                    target: GetLocalization(String(taskConfig().target)),
                    v1: GetLocalization(String(taskConfig().param_1)),
                    v2: GetLocalization(String(taskConfig().param_2)),
                    v3: GetLocalization(String(taskConfig().param_3))
                  };
                }
              }, _el$14),
              _el$17 = libs.createElement("Panel", {
                id: "TaskProgressContainer"
              }, _el$14),
              _el$18 = libs.createElement("Panel", {
                id: "ProgressBarBg"
              }, _el$17),
              _el$19 = libs.createElement("Panel", {
                id: "Bar",
                get style() {
                  return {
                    clip: `rect( 0%, ${task().progress / task().target * 100}%, 100%, 0% )`
                  };
                }
              }, _el$18),
              _el$20 = libs.createElement("Label", {
                get text() {
                  return `${task().progress}/${task().target}`;
                }
              }, _el$17),
              _el$21 = libs.createElement("Panel", {
                id: "TaskRewardList"
              }, _el$14);
            libs.insert(_el$14, libs.createComponent(libs.Show, {
              get when() {
                return buffCondition() > 0;
              },
              get children() {
                const _el$15 = libs.createElement("Image", {
                  id: "BuffIcon",
                  get src() {
                    return getSrcPath("tokens/" + buffCondition() + ".png");
                  }
                }, null);
                libs.effect(_$p => libs.setProp(_el$15, "src", getSrcPath("tokens/" + buffCondition() + ".png"), _$p));
                return _el$15;
              }
            }), _el$16);
            libs.insert(_el$21, libs.createComponent(libs.For, {
              get each() {
                return rewards();
              },
              children: reward => {
                return libs.createComponent(StoreItem.StoreItemBlock, {
                  id: "TaskReward",
                  get item_id() {
                    return Number(reward.id);
                  },
                  get amounts() {
                    return reward.num;
                  }
                });
              }
            }));
            libs.insert(_el$14, libs.createComponent(libs.Show, {
              get when() {
                return state() != "Received";
              },
              get fallback() {
                return libs.createElement("Panel", {
                  id: "ReceivedTag"
                }, null);
              },
              get children() {
                return libs.createComponent(EOM_Button.EOM_Button, {
                  size: "Small",
                  id: "TaskReceiveBtn",
                  get enabled() {
                    return state() == "CanReceive";
                  },
                  get text() {
                    return libs.memo(() => state() == "Locked")() ? "#Task_NeedUnlock" : `#Task_${state()}`;
                  },
                  get vars() {
                    return libs.memo(() => state() == "Locked")() ? {
                      name: GetLocalization(String(buffCondition()))
                    } : undefined;
                  },
                  onactivate: () => {
                    const currentTask = task();
                    const serverTime = Math.floor(CustomUIConfig.GetServerTimeStamp());
                    if (bRequesting() || currentTask.receive_progress == 1 || currentTask.progress < currentTask.target || !isTaskUnlocked$1(currentTask.task_id, serverTime)) {
                      return;
                    }
                    SetRequesting(true);
                    CallActionRequest("/v1/task/receive_rewards", {
                      task_id: currentTask.task_id,
                      extra_id: currentTask.extra_id
                    }, data => {
                      SetRequesting(false);
                    });
                  }
                });
              }
            }), null);
            libs.effect(_p$ => {
              const _v$4 = "TaskItem " + state(),
                _v$5 = "#Task_Desc_" + descID(),
                _v$6 = {
                  target: GetLocalization(String(taskConfig().target)),
                  v1: GetLocalization(String(taskConfig().param_1)),
                  v2: GetLocalization(String(taskConfig().param_2)),
                  v3: GetLocalization(String(taskConfig().param_3))
                },
                _v$7 = {
                  clip: `rect( 0%, ${task().progress / task().target * 100}%, 100%, 0% )`
                },
                _v$8 = `${task().progress}/${task().target}`;
              _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$14, "class", _v$4, _p$._v$4));
              _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$16, "text", _v$5, _p$._v$5));
              _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$16, "vars", _v$6, _p$._v$6));
              _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$19, "style", _v$7, _p$._v$7));
              _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$20, "text", _v$8, _p$._v$8));
              return _p$;
            }, {
              _v$4: undefined,
              _v$5: undefined,
              _v$6: undefined,
              _v$7: undefined,
              _v$8: undefined
            });
            return _el$14;
          })();
        }
      }));
      libs.effect(_p$ => {
        const _v$ = (() => {
            const rewards = {};
            if (dayBoxEntry) {
              for (const pair of dayBoxEntry[1].rewards.split("|")) {
                const [id, num] = pair.split(":");
                rewards[id] = Number(num);
              }
            }
            return {
              name: "bundle_preview",
              item_list: JSON.stringify(rewards)
            };
          })(),
          _v$2 = {
            clip: `rect( 0%, ${receiveDailyTaskCount() / dayBoxNeedCount * 100}%, 100%, 0% )`
          },
          _v$3 = `${receiveDailyTaskCount()}/${dayBoxNeedCount}`;
        _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$4, "customTooltip", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$10, "style", _v$2, _p$._v$2));
        _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$11, "text", _v$3, _p$._v$3));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined,
        _v$3: undefined
      });
      return _el$;
    }
  });
}

const player_weekly_tasks = solid_utils.createServiceNetData("player_weekly_tasks", {});
const player_blessings$1 = solid_utils.createServiceNetData("player_blessings");
const playerBPInfo = solid_utils.createServiceNetData("player_battle_passes", {});
const currentSeason = libs.createMemo(() => {
  const serverTime = Math.floor(CustomUIConfig.GetServerTimeStamp());
  let season = 1;
  for (let i = 1; i <= 1000; i++) {
    const config = KeyValues.bp_season[String(i)];
    if (!config) break;
    if (serverTime >= config.start_time) {
      season = i;
    }
  }
  return season;
});
const currentBPInfo = libs.createMemo(() => playerBPInfo()[currentSeason()]);
function isTaskUnlocked(taskID) {
  const blessingCondition = KeyValues.task[taskID]?.blessing_condition ?? 0;
  if (blessingCondition <= 0) return true;
  const buffData = player_blessings$1()?.[blessingCondition];
  return buffData != undefined && !(buffData.expire_time != -1 && buffData.permanent == false && buffData.expire_time < Math.floor(CustomUIConfig.GetServerTimeStamp()));
}
function getTaskState(task) {
  if (!isTaskUnlocked(task.task_id)) return "Locked";
  if (task.receive_progress == 1) return "Received";
  if (task.progress >= task.target) return "CanReceive";
  return "WaitFinish";
}
function isTaskClaimable(task) {
  return getTaskState(task) == "CanReceive";
}
function getTaskSortWeight(task) {
  if (task.receive_progress == 1) return 2;
  if (isTaskClaimable(task)) return 0;
  return 1;
}
function getTaskRewardTooltip(taskID) {
  const kv = KeyValues.task[taskID];
  const rewards = {};
  if (kv) {
    for (const [id, num] of Object.entries(kv.rewards)) {
      rewards[id] = num;
    }
  }
  return {
    name: "bundle_preview",
    item_list: JSON.stringify(rewards)
  };
}
const taskList = libs.createMemo(() => {
  const timestamp = CustomUIConfig.GetServerTimeStamp();
  return Object.values(player_weekly_tasks()).filter(task => {
    let kv = KeyValues.task[task.task_id];
    if (!kv || kv.type != 2) return false;
    if (task.end_time < timestamp) return false;
    if (task.start_time > timestamp) return false;
    return true;
  }).sort((a, b) => getTaskSortWeight(a) - getTaskSortWeight(b));
});
const _weekHasClaimable = libs.createMemo(() => {
  const tasks = taskList();
  for (let i = 0; i < tasks.length; i++) {
    const task = tasks[i];
    if (isTaskClaimable(task)) return true;
  }
  return false;
});
libs.createEffect(libs.on(_weekHasClaimable, red => {
  CustomUIConfig.SetRedPoint(red, "activity", "battlepass", "week_task");
}));
function WeekTask() {
  const [bRequesting, SetRequesting] = libs.createSignal(false);
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
    id: "WeekTask",
    get children() {
      const _el$ = libs.createElement("Panel", {
          id: "CenterBlock",
          hittest: false
        }, null),
        _el$2 = libs.createElement("Panel", {
          id: "BattlepassInfoContainer"
        }, _el$),
        _el$3 = libs.createElement("Panel", {
          id: "WeekTaskContent",
          flowChildren: "right",
          scroll: "x"
        }, _el$);
      libs.insert(_el$2, libs.createComponent(BattlepassInfo, {
        type: "Long",
        get extraExp() {
          return currentBPInfo()?.extra_exp ?? 0;
        },
        get level() {
          return currentBPInfo()?.level ?? 1;
        },
        get season() {
          return currentSeason();
        }
      }));
      libs.setProp(_el$3, "flowChildren", "right");
      libs.setProp(_el$3, "scroll", "x");
      libs.insert(_el$3, libs.createComponent(libs.Index, {
        get each() {
          return taskList();
        },
        children: task => {
          const buffCondition = () => KeyValues.task[task().task_id].blessing_condition;
          const state = () => getTaskState(task());
          const taskConfig = () => KeyValues.task[task().task_id];
          const descID = () => {
            const config = taskConfig();
            if (config.task_description == 1) {
              return config.task_id;
            } else {
              return config.event_id;
            }
          };
          return (() => {
            const _el$4 = libs.createElement("Panel", {
                "class": "TaskBox"
              }, null),
              _el$6 = libs.createElement("Panel", {
                id: "TaskBoxIcon"
              }, _el$4),
              _el$7 = libs.createElement("Panel", {
                id: "TaskBoxTitle"
              }, _el$4);
              libs.createElement("Label", {
                text: "#WeekTask_Box"
              }, _el$7);
              const _el$9 = libs.createElement("Label", {
                id: "TaskBoxProgressTitle",
                get text() {
                  return "#Task_Desc_" + descID();
                },
                get vars() {
                  return {
                    target: GetLocalization(String(taskConfig().target)),
                    v1: GetLocalization(String(taskConfig().param_1)),
                    v2: GetLocalization(String(taskConfig().param_2)),
                    v3: GetLocalization(String(taskConfig().param_3))
                  };
                }
              }, _el$4),
              _el$0 = libs.createElement("Panel", {
                id: "ProgressContainer"
              }, _el$4),
              _el$1 = libs.createElement("Panel", {
                id: "ProgressBG"
              }, _el$0),
              _el$10 = libs.createElement("Panel", {
                id: "Bar",
                get style() {
                  return {
                    clip: `rect( 0%, ${task().progress / task().target * 100}%, 100%, 0% )`
                  };
                }
              }, _el$1),
              _el$11 = libs.createElement("Label", {
                id: "TaskBoxProgressValue",
                get text() {
                  return `${task().progress}/${task().target}`;
                }
              }, _el$0);
            libs.insert(_el$4, libs.createComponent(libs.Show, {
              get when() {
                return buffCondition() > 0;
              },
              get children() {
                const _el$5 = libs.createElement("Image", {
                  id: "BuffIcon",
                  get src() {
                    return getSrcPath("tokens/" + buffCondition() + ".png");
                  }
                }, null);
                libs.effect(_$p => libs.setProp(_el$5, "src", getSrcPath("tokens/" + buffCondition() + ".png"), _$p));
                return _el$5;
              }
            }), _el$6);
            libs.insert(_el$4, libs.createComponent(libs.Show, {
              get when() {
                return state() != "Received";
              },
              get fallback() {
                return libs.createElement("Panel", {
                  id: "ReceivedTag"
                }, null);
              },
              get children() {
                return libs.createComponent(EOM_Button.EOM_Button, {
                  id: "TaskBoxGetButton",
                  get enabled() {
                    return state() == "CanReceive";
                  },
                  get text() {
                    return libs.memo(() => state() == "Locked")() ? "#Task_NeedUnlock" : `#Task_${state()}`;
                  },
                  get vars() {
                    return libs.memo(() => state() == "Locked")() ? {
                      name: GetLocalization(String(buffCondition()))
                    } : undefined;
                  },
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
                  }
                });
              }
            }), null);
            libs.effect(_p$ => {
              const _v$ = getTaskRewardTooltip(task().task_id),
                _v$2 = "#Task_Desc_" + descID(),
                _v$3 = {
                  target: GetLocalization(String(taskConfig().target)),
                  v1: GetLocalization(String(taskConfig().param_1)),
                  v2: GetLocalization(String(taskConfig().param_2)),
                  v3: GetLocalization(String(taskConfig().param_3))
                },
                _v$4 = {
                  clip: `rect( 0%, ${task().progress / task().target * 100}%, 100%, 0% )`
                },
                _v$5 = `${task().progress}/${task().target}`;
              _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$6, "customTooltip", _v$, _p$._v$));
              _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$9, "text", _v$2, _p$._v$2));
              _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$9, "vars", _v$3, _p$._v$3));
              _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$10, "style", _v$4, _p$._v$4));
              _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$11, "text", _v$5, _p$._v$5));
              return _p$;
            }, {
              _v$: undefined,
              _v$2: undefined,
              _v$3: undefined,
              _v$4: undefined,
              _v$5: undefined
            });
            return _el$4;
          })();
        }
      }));
      return _el$;
    }
  });
}

function clampFrame(index, frameCount) {
  if (frameCount <= 0) {
    return 0;
  }
  return Math.max(0, Math.min(frameCount - 1, Math.floor(index)));
}
function normalizeInterval(interval) {
  return interval != undefined && Number.isFinite(interval) ? Math.max(1, interval) : 100;
}
function createSequenceFrame(options) {
  const frames = libs.createMemo(() => typeof options.frames === "function" ? options.frames() : options.frames);
  const frameCount = libs.createMemo(() => frames().length);
  const [controlledIsLoop, setControlledIsLoop] = libs.createSignal();
  const isLoop = libs.createMemo(() => {
    const controlled = controlledIsLoop();
    if (controlled != undefined) {
      return controlled;
    }
    return typeof options.isLoop === "function" ? options.isLoop() : options.isLoop ?? true;
  });
  const autoPlay = options.autoPlay ?? true;
  const [controlledInterval, setControlledInterval] = libs.createSignal();
  const interval = libs.createMemo(() => {
    const controlled = controlledInterval();
    if (controlled != undefined) {
      return controlled;
    }
    const optionInterval = typeof options.interval === "function" ? options.interval() : options.interval;
    return normalizeInterval(optionInterval);
  });
  const [currentFrame, setCurrentFrame] = libs.createSignal(0);
  const [isPlaying, setIsPlaying] = libs.createSignal(false);
  const [isFinished, setIsFinished] = libs.createSignal(frameCount() <= 1 && !isLoop());
  let timer;
  let timerInterval;
  function clearTimer() {
    if (timer != undefined) {
      clearInterval(timer);
      timer = undefined;
      timerInterval = undefined;
    }
  }
  function startTimer() {
    timerInterval = interval();
    timer = setInterval(tick, timerInterval);
  }
  function restartTimer() {
    clearTimer();
    startTimer();
  }
  function finish() {
    clearTimer();
    setIsPlaying(false);
    setIsFinished(true);
  }
  function tick() {
    const count = frameCount();
    if (count <= 0) {
      finish();
      setCurrentFrame(0);
      return;
    }
    if (count <= 1) {
      if (!isLoop()) {
        finish();
      }
      setCurrentFrame(0);
      return;
    }
    setCurrentFrame(frame => {
      const lastFrame = count - 1;
      if (frame >= lastFrame) {
        if (isLoop()) {
          return 0;
        }
        finish();
        return lastFrame;
      }
      return frame + 1;
    });
  }
  function play() {
    if (timer != undefined || isPlaying()) {
      return;
    }
    const count = frameCount();
    if (count <= 0) {
      setCurrentFrame(0);
      setIsFinished(true);
      setIsPlaying(false);
      return;
    }
    if (count <= 1) {
      setCurrentFrame(0);
      setIsFinished(!isLoop());
      setIsPlaying(false);
      return;
    }
    if (!isLoop() && isFinished()) {
      return;
    }
    setIsFinished(false);
    setIsPlaying(true);
    startTimer();
  }
  function pause() {
    clearTimer();
    setIsPlaying(false);
  }
  function reset() {
    pause();
    setCurrentFrame(0);
    setIsFinished(frameCount() <= 1 && !isLoop());
  }
  function stop() {
    reset();
  }
  function replay() {
    reset();
    play();
  }
  function gotoFrame(index) {
    setCurrentFrame(clampFrame(index, frameCount()));
    setIsFinished(false);
  }
  function setLoop(loop) {
    setControlledIsLoop(loop);
    if (loop && isFinished()) {
      setIsFinished(false);
    }
  }
  function setFrameInterval(frameInterval) {
    setControlledInterval(normalizeInterval(frameInterval));
  }
  libs.createEffect(() => {
    const nextInterval = interval();
    if (timer != undefined && timerInterval !== nextInterval && libs.untrack(isPlaying)) {
      restartTimer();
    }
  });
  libs.createEffect(previous => {
    const frameList = frames();
    const count = frameList.length;
    const loop = isLoop();
    setCurrentFrame(frame => clampFrame(frame, count));
    if (count <= 1) {
      clearTimer();
      setIsPlaying(false);
      setIsFinished(!loop);
    } else if (previous != undefined && (previous.frames !== frameList || previous.loop !== loop) && libs.untrack(isFinished)) {
      setIsFinished(false);
    }
    return {
      frames: frameList,
      loop
    };
  });
  libs.onMount(() => {
    if (autoPlay) {
      play();
    }
  });
  libs.onCleanup(() => {
    clearTimer();
  });
  const SequenceFrame = props => {
    const merged = libs.mergeProps(props, {
      class: libs.classNames("SequenceFrame", props.class, props.className)
    });
    const [local, others] = libs.splitProps(merged, ["children", "className"]);
    return (() => {
      const _el$ = libs.createElement("Panel", others, null);
      libs.spread(_el$, others, true);
      libs.insert(_el$, libs.createComponent(libs.Index, {
        get each() {
          return frames();
        },
        children: (src, index) => (() => {
          const _el$2 = libs.createElement("Image", {
            "class": "SequenceFrameImage",
            get src() {
              return src();
            },
            hittest: false
          }, null);
          libs.effect(_p$ => {
            const _v$ = src(),
              _v$2 = currentFrame() == index;
            _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$2, "src", _v$, _p$._v$));
            _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$2, "visible", _v$2, _p$._v$2));
            return _p$;
          }, {
            _v$: undefined,
            _v$2: undefined
          });
          return _el$2;
        })()
      }), null);
      libs.insert(_el$, () => local.children, null);
      return _el$;
    })();
  };
  return {
    SequenceFrame,
    currentFrame,
    isPlaying,
    isFinished,
    isLoop,
    interval,
    frameCount,
    setLoop,
    setFrameInterval,
    play,
    pause,
    stop,
    reset,
    replay,
    gotoFrame
  };
}

const MINE_GRID_COLUMNS = 8;
const MINE_GRID_VISIBLE_ROWS = 5;
const MINE_GRID_CELL_MARGIN = 3;
const MINE_GRID_CELL_STRIDE = 112;
const MINE_GRID_SCROLL_ANIMATION_DURATION = 0.2;
const MINE_GRID_CELL_REMOVE_STAGE_DURATION = 0.8;
const MINE_GRID_TIMELINE_TICK_INTERVAL = 0.05;
const MINE_GRID_TIMELINE_RENDER_BARRIER_DURATION = 0.05;
const MINE_GRID_DRILL_CELL_INTERVAL = 0.2;
const MINE_GRID_DRILL_EFFECT_TO_HIDE_DELAY = 0.2;
const MINE_GRID_DRILL_CELL_FADE_DURATION = 0.2;
const MINE_GRID_DRILL_FINISH_HOLD_DURATION = 0.4;
const DIG_VEINS_PICKAXE_PRESENTATION_DELAY = 0.32;
const DIG_VEINS_BOMB_PRESENTATION_DELAY = 0.4;
const DIG_VEINS_DRILL_PRESENTATION_DELAY = 0.08;
const DIG_VEINS_PICKAXE_FLOW_WAIT_DURATION = 0.4;
const DIG_VEINS_BOMB_FLOW_WAIT_DURATION = 0.4;
const DIG_VEINS_PICKAXE_EFFECT_DURATION = 1.2;
const DIG_VEINS_BOMB_EFFECT_DURATION = 1.2;
const DIG_VEINS_PICKAXE_SECOND_SOUND_DELAY = 0.88;
const DIG_VEINS_SOUND_EVENT_PICKAXE_FIRST = "UI.Wakuang.TieGao1";
const DIG_VEINS_SOUND_EVENT_PICKAXE_SECOND = "UI.Wakuang.TieGao2";
const DIG_VEINS_SOUND_EVENT_BOMB = "UI.Wakuang.ZhaDan1";
const DIG_VEINS_SOUND_EVENT_DRILL = "UI.Wakuang.DianZuan1";
const TOOL_CURSOR_ICON_SIZE = 64;
const DIG_VEINS_DEFAULT_COIN_RATE = 100;
const DIG_VEINS_DEPTH_DISPLAY_SCALE$1 = 5;
const DIG_VEINS_DEPTH_PROGRESS_VISIBLE_STAGE_COUNT = 4;
const DIG_VEINS_DEPTH_PROGRESS_PAGE_STEP = 3;
const DIG_VEINS_PICKAXE_PRODUCT_ID = 802307;
const DIG_VEINS_DRILL_PRODUCT_ID = 802308;
const DIG_VEINS_SPECIAL_REWARD_ITEM_ID = 190004;
const DIG_VEINS_REWARD_TIP_VISIBLE_DURATION = 2;
const getDigVeinsDisplayDepth$1 = depth => depth * DIG_VEINS_DEPTH_DISPLAY_SCALE$1;
const openVeinsGift = () => {
  JumpToMenu({
    window_name: "activity",
    menu: "mining",
    menu2: "veins_gift",
    force: true
  });
};
const purchaseVeinsTool = productID => {
  ClientSideEvent("directly_purchase", {
    itemid: productID,
    source: "veins_game_tool_bar"
  });
};
const PICKAXE_SEQ_FRAMES = [getSrcPath("m4_mining/seq_pickaxe/01.png"), getSrcPath("m4_mining/seq_pickaxe/02.png"), getSrcPath("m4_mining/seq_pickaxe/03.png"), getSrcPath("m4_mining/seq_pickaxe/04.png"), getSrcPath("m4_mining/seq_pickaxe/05.png"), getSrcPath("m4_mining/seq_pickaxe/06.png"), getSrcPath("m4_mining/seq_pickaxe/07.png"), getSrcPath("m4_mining/seq_pickaxe/01.png"), getSrcPath("m4_mining/seq_pickaxe/02.png"), getSrcPath("m4_mining/seq_pickaxe/03.png"), getSrcPath("m4_mining/seq_pickaxe/04.png"), getSrcPath("m4_mining/seq_pickaxe/05.png"), getSrcPath("m4_mining/seq_pickaxe/06.png"), getSrcPath("m4_mining/seq_pickaxe/07.png"), getSrcPath("m4_mining/seq_pickaxe/08.png")];
const DRILL_SEQ_FRAMES = [getSrcPath("m4_mining/seq_drill/01.png"), getSrcPath("m4_mining/seq_drill/02.png"), getSrcPath("m4_mining/seq_drill/03.png"), getSrcPath("m4_mining/seq_drill/04.png"), getSrcPath("m4_mining/seq_drill/02.png"), getSrcPath("m4_mining/seq_drill/03.png"), getSrcPath("m4_mining/seq_drill/04.png"), getSrcPath("m4_mining/seq_drill/02.png"), getSrcPath("m4_mining/seq_drill/03.png"), getSrcPath("m4_mining/seq_drill/04.png"), getSrcPath("m4_mining/seq_drill/02.png"), getSrcPath("m4_mining/seq_drill/03.png"), getSrcPath("m4_mining/seq_drill/04.png"), getSrcPath("m4_mining/seq_drill/05.png"), getSrcPath("m4_mining/seq_drill/06.png"), getSrcPath("m4_mining/seq_drill/07.png"), getSrcPath("m4_mining/seq_drill/08.png")];
const BOMB_SEQ_FRAMES = [getSrcPath("m4_mining/seq_bomb/01.png"), getSrcPath("m4_mining/seq_bomb/02.png"), getSrcPath("m4_mining/seq_bomb/03.png"), getSrcPath("m4_mining/seq_bomb/04.png"), getSrcPath("m4_mining/seq_bomb/05.png"), getSrcPath("m4_mining/seq_bomb/06.png"), getSrcPath("m4_mining/seq_bomb/07.png"), getSrcPath("m4_mining/seq_bomb/08.png")];
const DIG_VEINS_SLOT_TYPE = {
  none: false,
  bedrock: true,
  blackstone: false,
  chest: true,
  diamond: true,
  gold: true,
  iron: true,
  soil: true,
  token: true
};
const DIG_VEINS_SLOT_DURABILITY = {
  bedrock: 1,
  blackstone: 0,
  chest: 0,
  diamond: 0,
  gold: 0,
  iron: 0,
  soil: 0,
  token: 0
};
const DIG_VEINS_SERVICE_SLOT_TYPE = {
  "1": "soil",
  "2": "bedrock",
  "b": "chest",
  "c": "token"
};
const parseDigVeinsRewardList = rewardValue => {
  if (rewardValue.length == 0) {
    return [];
  }
  return rewardValue.split("|").flatMap(entry => {
    const [itemID, rawAmount] = entry.split(":");
    const amounts = Number(rawAmount);
    if (itemID == undefined || itemID.length == 0 || !Number.isFinite(amounts) || amounts <= 0) {
      return [];
    }
    return [{
      item_id: itemID,
      amounts
    }];
  });
};
const parseDigVeinsWeightedRewardList = rewardValue => {
  if (rewardValue.length == 0) {
    return [];
  }
  return rewardValue.split("|").flatMap(entry => {
    const [itemID, rawAmount, rawWeight] = entry.split(":");
    const amounts = Number(rawAmount);
    const weight = Number(rawWeight);
    if (itemID == undefined || itemID.length == 0 || !Number.isFinite(amounts) || amounts <= 0 || !Number.isFinite(weight) || weight < 0) {
      return [];
    }
    return [{
      item_id: itemID,
      amounts,
      weightText: `${(weight / 10).toFixed(1)}%`
    }];
  });
};
const parseDigVeinsDurability = durabilityValue => {
  if (typeof durabilityValue != "string" || durabilityValue.length == 0) {
    return [];
  }
  return durabilityValue.split("|").map(rawValue => {
    const value = Number(rawValue);
    return Number.isInteger(value) && value > 0 ? value : undefined;
  });
};
const getDigVeinsProgressStages = () => {
  const nodes = Object.values(GameUI.CustomUIConfig().activity_mining_node ?? {}).filter(node => node.activity_id == dig_veins_logic.ACTIVITY_MINING_ID && Number.isFinite(node.depth_num) && node.depth_num > 0).sort((a, b) => a.depth_num - b.depth_num || a.id - b.id);
  return nodes.map((node, index) => ({
    id: node.id,
    fromDepth: index == 0 ? 0 : nodes[index - 1].depth_num,
    toDepth: node.depth_num,
    reward: node.reward,
    coinRate: node.coin_rate
  }));
};
const getDigVeinsCoinRateByDepth = (depth, stages) => {
  for (let index = stages.length - 1; index >= 0; index--) {
    const stage = stages[index];
    if (depth >= stage.toDepth) {
      return Number.isFinite(stage.coinRate) && stage.coinRate > 0 ? stage.coinRate : DIG_VEINS_DEFAULT_COIN_RATE;
    }
  }
  return DIG_VEINS_DEFAULT_COIN_RATE;
};
const getDigVeinsDepthProgressPageStartIndex = (progressCount, stageCount) => {
  const requestedPageStartIndex = progressCount < DIG_VEINS_DEPTH_PROGRESS_VISIBLE_STAGE_COUNT ? 0 : DIG_VEINS_DEPTH_PROGRESS_PAGE_STEP + Math.floor((progressCount - DIG_VEINS_DEPTH_PROGRESS_VISIBLE_STAGE_COUNT) / DIG_VEINS_DEPTH_PROGRESS_PAGE_STEP) * DIG_VEINS_DEPTH_PROGRESS_PAGE_STEP;
  const maxPageStartIndex = Math.max(0, stageCount - DIG_VEINS_DEPTH_PROGRESS_VISIBLE_STAGE_COUNT);
  return Math.max(0, Math.min(requestedPageStartIndex, maxPageStartIndex));
};
const getDigVeinsDepthProgressPageStartIndexByDepth = (depth, stages) => {
  const completedStageCount = stages.filter(stage => depth >= stage.toDepth).length;
  return getDigVeinsDepthProgressPageStartIndex(completedStageCount, stages.length);
};
const DIG_VEINS_TOOL_OPERATE_TYPE = {
  Pickaxe: 1,
  Bomb: 2,
  Drill: 3
};
const getDigVeinsVisibleStartRow = depth => depth - MINE_GRID_VISIBLE_ROWS + 1;
const createEmptyDigVeinsMapRow = () => Array.from({
  length: MINE_GRID_COLUMNS
}, () => undefined);
const parseDigVeinsMap = (mapValue, startRow, endRow) => {
  const rows = {};
  for (let row = startRow; row <= endRow; row++) {
    rows[row] = createEmptyDigVeinsMapRow();
  }
  if (typeof mapValue != "string" || mapValue.length == 0) {
    return rows;
  }
  for (const rawRow of mapValue.split("|")) {
    const separatorIndex = rawRow.indexOf(":");
    if (separatorIndex < 0) {
      continue;
    }
    const depth = Number(rawRow.slice(0, separatorIndex));
    if (!Number.isInteger(depth) || depth < 0 || depth < startRow || depth > endRow) {
      continue;
    }
    const layout = rawRow.slice(separatorIndex + 1);
    rows[depth] = Array.from({
      length: MINE_GRID_COLUMNS
    }, (_, column) => {
      return DIG_VEINS_SERVICE_SLOT_TYPE[layout[column]];
    });
  }
  return rows;
};
const cloneDigVeinsMapRows = rows => {
  const clonedRows = {};
  for (const key of Object.keys(rows)) {
    const row = Number(key);
    const slots = rows[row];
    if (slots != undefined) {
      clonedRows[row] = slots.slice();
    }
  }
  return clonedRows;
};
const parseDigVeinsSnapshot = (data, startRow) => {
  if (data == undefined || !Number.isFinite(data.activity_id) || !Number.isInteger(data.depth) || data.depth < 0 || typeof data.map != "string") {
    return undefined;
  }
  const snapshotStartRow = startRow ?? getDigVeinsVisibleStartRow(data.depth);
  return {
    activityID: data.activity_id,
    depth: data.depth,
    rows: parseDigVeinsMap(data.map, snapshotStartRow, data.depth)
  };
};
const cloneDigVeinsSnapshot = snapshot => ({
  activityID: snapshot.activityID,
  depth: snapshot.depth,
  rows: cloneDigVeinsMapRows(snapshot.rows)
});
const getDigVeinsSnapshotWindow = (snapshot, startRow, endRow) => {
  const rows = {};
  for (let row = startRow; row <= endRow; row++) {
    rows[row] = snapshot.rows[row]?.slice() ?? createEmptyDigVeinsMapRow();
  }
  return {
    activityID: snapshot.activityID,
    depth: snapshot.depth,
    rows
  };
};
const getDigVeinsSnapshotDiff = (previous, next) => {
  const removedTiles = [];
  const addedTiles = [];
  const removedRows = [];
  const addedRows = [];
  const rowKeys = {};
  for (const key of Object.keys(previous.rows)) {
    rowKeys[Number(key)] = true;
  }
  for (const key of Object.keys(next.rows)) {
    rowKeys[Number(key)] = true;
  }
  const rows = Object.keys(rowKeys).map(Number).sort((a, b) => a - b);
  for (const row of rows) {
    const previousRow = previous.rows[row];
    const nextRow = next.rows[row];
    if (previousRow != undefined && nextRow == undefined) {
      removedRows.push(row);
    } else if (previousRow == undefined && nextRow != undefined) {
      addedRows.push(row);
    }
    for (let column = 0; column < MINE_GRID_COLUMNS; column++) {
      const previousType = previousRow?.[column];
      const nextType = nextRow?.[column];
      if (previousType === nextType) {
        continue;
      }
      const index = row * MINE_GRID_COLUMNS + column;
      if (previousType != undefined) {
        removedTiles.push({
          index,
          type: previousType
        });
      }
      if (nextType != undefined) {
        addedTiles.push({
          index,
          type: nextType
        });
      }
    }
  }
  return {
    removedTiles,
    addedTiles,
    removedRows,
    addedRows
  };
};
const buildDigVeinsPickaxeTimeline = (context, previousSnapshot, targetSnapshot, diff) => {
  const events = [];
  let nextOrder = 0;
  let elapsed = DIG_VEINS_PICKAXE_PRESENTATION_DELAY;
  const push = (at, command) => {
    events.push({
      at,
      order: nextOrder++,
      command
    });
  };
  push(0, {
    type: "startToolSequenceFrame",
    state: {
      actionID: context.id,
      tool: context.tool,
      row: context.row,
      column: context.column
    }
  });
  push(elapsed, {
    type: "playSound",
    soundEvent: DIG_VEINS_SOUND_EVENT_PICKAXE_FIRST
  });
  push(elapsed, {
    type: "showToolEffect",
    effect: {
      id: `${context.id}|main`,
      actionID: context.id,
      tool: context.tool,
      row: context.row,
      column: context.column
    }
  });
  push(DIG_VEINS_PICKAXE_SECOND_SOUND_DELAY, {
    type: "playSound",
    soundEvent: DIG_VEINS_SOUND_EVENT_PICKAXE_SECOND
  });
  elapsed += DIG_VEINS_PICKAXE_FLOW_WAIT_DURATION;
  const hasRemovedTiles = diff.removedTiles.length > 0 || diff.removedRows.length > 0;
  const hasAddedTiles = diff.addedTiles.length > 0 || diff.addedRows.length > 0;
  if (hasRemovedTiles) {
    push(elapsed, {
      type: "startRemove",
      tiles: diff.removedTiles
    });
    elapsed += MINE_GRID_CELL_REMOVE_STAGE_DURATION;
    push(elapsed, {
      type: "commitRemove",
      tiles: diff.removedTiles,
      rows: diff.removedRows
    });
  }
  if (hasAddedTiles) {
    push(elapsed, {
      type: "applyAdd",
      tiles: diff.addedTiles,
      rows: diff.addedRows
    });
  }
  if (previousSnapshot.depth !== targetSnapshot.depth) {
    if (hasRemovedTiles || hasAddedTiles) {
      elapsed += MINE_GRID_TIMELINE_RENDER_BARRIER_DURATION;
      push(elapsed, {
        type: "enableTransition"
      });
    }
    push(elapsed, {
      type: "startScroll",
      fromDepth: previousSnapshot.depth,
      toDepth: targetSnapshot.depth
    });
    elapsed += MINE_GRID_SCROLL_ANIMATION_DURATION;
    push(elapsed, {
      type: "finishScroll"
    });
  }
  push(elapsed, {
    type: "calibrate"
  });
  elapsed += MINE_GRID_TIMELINE_RENDER_BARRIER_DURATION;
  push(elapsed, {
    type: "enableTransition"
  });
  push(elapsed, {
    type: "finishFlow"
  });
  const toolEffectEndTime = DIG_VEINS_PICKAXE_PRESENTATION_DELAY + DIG_VEINS_PICKAXE_EFFECT_DURATION;
  push(toolEffectEndTime, {
    type: "hideToolEffects",
    actionID: context.id
  });
  events.sort((a, b) => a.at - b.at || a.order - b.order);
  return {
    context,
    events,
    duration: Math.max(elapsed, toolEffectEndTime),
    targetSnapshot: cloneDigVeinsSnapshot(targetSnapshot),
    stableTargetSnapshot: getDigVeinsSnapshotWindow(targetSnapshot, getDigVeinsVisibleStartRow(targetSnapshot.depth), targetSnapshot.depth)
  };
};
const buildDigVeinsBombTimeline = (context, previousSnapshot, targetSnapshot, diff) => {
  const events = [];
  let nextOrder = 0;
  let elapsed = DIG_VEINS_BOMB_PRESENTATION_DELAY;
  const push = (at, command) => {
    events.push({
      at,
      order: nextOrder++,
      command
    });
  };
  push(0, {
    type: "startToolSequenceFrame",
    state: {
      actionID: context.id,
      tool: context.tool,
      row: context.row,
      column: context.column
    }
  });
  push(elapsed, {
    type: "playSound",
    soundEvent: DIG_VEINS_SOUND_EVENT_BOMB
  });
  push(elapsed, {
    type: "showToolEffect",
    effect: {
      id: `${context.id}|main`,
      actionID: context.id,
      tool: context.tool,
      row: context.row,
      column: context.column
    }
  });
  elapsed += DIG_VEINS_BOMB_FLOW_WAIT_DURATION;
  const hasRemovedTiles = diff.removedTiles.length > 0 || diff.removedRows.length > 0;
  const hasAddedTiles = diff.addedTiles.length > 0 || diff.addedRows.length > 0;
  if (hasRemovedTiles) {
    push(elapsed, {
      type: "startRemove",
      tiles: diff.removedTiles
    });
    elapsed += MINE_GRID_CELL_REMOVE_STAGE_DURATION;
    push(elapsed, {
      type: "commitRemove",
      tiles: diff.removedTiles,
      rows: diff.removedRows
    });
  }
  if (hasAddedTiles) {
    push(elapsed, {
      type: "applyAdd",
      tiles: diff.addedTiles,
      rows: diff.addedRows
    });
  }
  if (previousSnapshot.depth !== targetSnapshot.depth) {
    if (hasRemovedTiles || hasAddedTiles) {
      elapsed += MINE_GRID_TIMELINE_RENDER_BARRIER_DURATION;
      push(elapsed, {
        type: "enableTransition"
      });
    }
    push(elapsed, {
      type: "startScroll",
      fromDepth: previousSnapshot.depth,
      toDepth: targetSnapshot.depth
    });
    elapsed += MINE_GRID_SCROLL_ANIMATION_DURATION;
    push(elapsed, {
      type: "finishScroll"
    });
  }
  push(elapsed, {
    type: "calibrate"
  });
  elapsed += MINE_GRID_TIMELINE_RENDER_BARRIER_DURATION;
  push(elapsed, {
    type: "enableTransition"
  });
  push(elapsed, {
    type: "finishFlow"
  });
  const toolEffectEndTime = DIG_VEINS_BOMB_PRESENTATION_DELAY + DIG_VEINS_BOMB_EFFECT_DURATION;
  push(toolEffectEndTime, {
    type: "hideToolEffects",
    actionID: context.id
  });
  events.sort((a, b) => a.at - b.at || a.order - b.order);
  return {
    context,
    events,
    duration: Math.max(elapsed, toolEffectEndTime),
    targetSnapshot: cloneDigVeinsSnapshot(targetSnapshot),
    stableTargetSnapshot: getDigVeinsSnapshotWindow(targetSnapshot, getDigVeinsVisibleStartRow(targetSnapshot.depth), targetSnapshot.depth)
  };
};
const buildDigVeinsDrillTimeline = (context, previousSnapshot, targetSnapshot, diff) => {
  const events = [];
  let nextOrder = 0;
  let elapsed = 0;
  const push = (at, command) => {
    events.push({
      at,
      order: nextOrder++,
      command
    });
  };
  const visibleStartRow = previousSnapshot.depth - MINE_GRID_VISIBLE_ROWS + 1;
  push(0, {
    type: "startToolSequenceFrame",
    state: {
      actionID: context.id,
      tool: context.tool,
      row: visibleStartRow,
      column: context.column
    }
  });
  push(0, {
    type: "playSound",
    soundEvent: DIG_VEINS_SOUND_EVENT_DRILL
  });
  const drillTiles = diff.removedTiles.filter(tile => {
    const row = Math.floor(tile.index / MINE_GRID_COLUMNS);
    const column = tile.index % MINE_GRID_COLUMNS;
    return column === context.column && row >= visibleStartRow && row <= previousSnapshot.depth;
  }).sort((a, b) => a.index - b.index);
  const drillTileIndexes = {};
  for (const tile of drillTiles) {
    drillTileIndexes[tile.index] = true;
  }
  const otherRemovedTiles = diff.removedTiles.filter(tile => drillTileIndexes[tile.index] !== true);
  const hasRemovedTiles = diff.removedTiles.length > 0 || diff.removedRows.length > 0;
  const hasAddedTiles = diff.addedTiles.length > 0 || diff.addedRows.length > 0;
  if (drillTiles.length > 0) {
    const firstRow = Math.floor(drillTiles[0].index / MINE_GRID_COLUMNS);
    let lastHideAt = DIG_VEINS_DRILL_PRESENTATION_DELAY;
    for (const tile of drillTiles) {
      const row = Math.floor(tile.index / MINE_GRID_COLUMNS);
      const effectAt = DIG_VEINS_DRILL_PRESENTATION_DELAY + (row - firstRow) * MINE_GRID_DRILL_CELL_INTERVAL;
      const hideAt = effectAt + MINE_GRID_DRILL_EFFECT_TO_HIDE_DELAY;
      push(effectAt, {
        type: "moveToolSequenceFrame",
        actionID: context.id,
        row,
        column: context.column
      });
      push(effectAt, {
        type: "showToolEffect",
        effect: {
          id: `${context.id}|drill|${tile.index}`,
          actionID: context.id,
          tool: context.tool,
          row,
          column: context.column
        }
      });
      push(hideAt, {
        type: "startRemove",
        tiles: [tile]
      });
      lastHideAt = hideAt;
    }
    if (otherRemovedTiles.length > 0) {
      push(DIG_VEINS_DRILL_PRESENTATION_DELAY + MINE_GRID_DRILL_EFFECT_TO_HIDE_DELAY, {
        type: "startRemove",
        tiles: otherRemovedTiles
      });
    }
    elapsed = lastHideAt + MINE_GRID_DRILL_CELL_FADE_DURATION + MINE_GRID_DRILL_FINISH_HOLD_DURATION;
  } else if (hasRemovedTiles) {
    if (otherRemovedTiles.length > 0) {
      push(DIG_VEINS_DRILL_PRESENTATION_DELAY, {
        type: "startRemove",
        tiles: otherRemovedTiles
      });
    }
    elapsed = DIG_VEINS_DRILL_PRESENTATION_DELAY + MINE_GRID_DRILL_CELL_FADE_DURATION;
  } else {
    elapsed = DIG_VEINS_DRILL_PRESENTATION_DELAY;
  }
  if (hasRemovedTiles) {
    push(elapsed, {
      type: "hideToolEffects",
      actionID: context.id
    });
    push(elapsed, {
      type: "commitRemove",
      tiles: diff.removedTiles,
      rows: diff.removedRows
    });
  }
  if (hasAddedTiles) {
    push(elapsed, {
      type: "applyAdd",
      tiles: diff.addedTiles,
      rows: diff.addedRows
    });
  }
  if (previousSnapshot.depth !== targetSnapshot.depth) {
    if (hasRemovedTiles || hasAddedTiles) {
      elapsed += MINE_GRID_TIMELINE_RENDER_BARRIER_DURATION;
      push(elapsed, {
        type: "enableTransition"
      });
    }
    push(elapsed, {
      type: "startScroll",
      fromDepth: previousSnapshot.depth,
      toDepth: targetSnapshot.depth
    });
    elapsed += MINE_GRID_SCROLL_ANIMATION_DURATION;
    push(elapsed, {
      type: "finishScroll"
    });
  }
  push(elapsed, {
    type: "calibrate"
  });
  elapsed += MINE_GRID_TIMELINE_RENDER_BARRIER_DURATION;
  push(elapsed, {
    type: "enableTransition"
  });
  push(elapsed, {
    type: "finishFlow"
  });
  events.sort((a, b) => a.at - b.at || a.order - b.order);
  return {
    context,
    events,
    duration: elapsed,
    targetSnapshot: cloneDigVeinsSnapshot(targetSnapshot),
    stableTargetSnapshot: getDigVeinsSnapshotWindow(targetSnapshot, getDigVeinsVisibleStartRow(targetSnapshot.depth), targetSnapshot.depth)
  };
};
const DIG_VEINS_TOOL_TIMELINE_BUILDERS = {
  Pickaxe: buildDigVeinsPickaxeTimeline,
  Bomb: buildDigVeinsBombTimeline,
  Drill: buildDigVeinsDrillTimeline
};
const insertDigVeinsRewardTipTimelineEvent = (plan, amount) => {
  if (!Number.isFinite(amount) || amount <= 0) {
    return;
  }
  let insertIndex = plan.events.findIndex(event => event.command.type == "startScroll");
  if (insertIndex < 0) {
    insertIndex = plan.events.findIndex(event => event.command.type == "calibrate");
  }
  if (insertIndex < 0) {
    insertIndex = plan.events.findIndex(event => event.command.type == "finishFlow");
  }
  const at = insertIndex < 0 ? plan.duration : plan.events[insertIndex].at;
  if (insertIndex < 0) {
    insertIndex = plan.events.length;
  }
  plan.events.splice(insertIndex, 0, {
    at,
    order: 0,
    command: {
      type: "showRewardTip",
      amount
    }
  });
  plan.events.forEach((event, index) => event.order = index);
};
const buildDigVeinsMineGridLayout = (rows, depth) => {
  const backendRows = Object.keys(rows).map(Number).filter(Number.isInteger).sort((a, b) => a - b);
  const visibleStartRow = depth - MINE_GRID_VISIBLE_ROWS + 1;
  const startRow = Math.min(visibleStartRow, backendRows[0] ?? depth);
  const endRow = Math.max(depth, backendRows[backendRows.length - 1] ?? depth);
  const slots = [];
  const layoutRows = [];
  for (let row = startRow; row <= endRow; row++) {
    const cells = [];
    for (let column = 0; column < MINE_GRID_COLUMNS; column++) {
      const slot = {
        index: row * MINE_GRID_COLUMNS + column,
        type: rows[row]?.[column]
      };
      slots.push(slot);
      cells.push(slot);
    }
    layoutRows.push({
      row,
      cells
    });
  }
  return {
    startRow,
    endRow,
    rows: layoutRows,
    slots
  };
};
function DigVeinsMineGridCell(prop) {
  const isDisabled = () => prop.disabled === true;
  const durability = () => prop.durability;
  const showDurability = () => (durability() ?? 0) > 1;
  const tooltip = () => {
    if (prop.tooltipRewards == undefined || prop.tooltipRewards.length == 0) {
      return undefined;
    }
    return {
      name: "activity_veins",
      ...(prop.tooltipDescription == undefined ? {} : {
        description: prop.tooltipDescription
      }),
      rewards: JSON.stringify(prop.tooltipRewards)
    };
  };
  return (() => {
    const _el$ = libs.createElement("Panel", {
        get ["class"]() {
          return libs.classNames("DigVeinsMineGridCellContainer", prop.class);
        }
      }, null);
      libs.createElement("Image", {
        "class": "DigVeinsMineGrideBG"
      }, _el$);
    libs.insert(_el$, libs.createComponent(EOM_Button.EOM_BaseButton, {
      get ["class"]() {
        return libs.classNames("DigVeinsMineGridCell", prop.class, {
          Disabled: isDisabled(),
          FadingOut: prop.fadingOut === true
        });
      },
      get enabled() {
        return !isDisabled();
      },
      onmouseover: () => {
        if (isDisabled()) {
          return;
        }
        prop.oncellmouseover?.(prop.index);
      },
      onmouseout: () => {
        if (isDisabled()) {
          return;
        }
        prop.oncellmouseout?.(prop.index);
      },
      onactivate: () => {
        if (isDisabled()) {
          return;
        }
        const tool = prop.tool;
        if (tool == undefined) {
          return;
        }
        prop.oncellactivate?.(prop.index, tool);
      },
      get children() {
        return [libs.createElement("Panel", {
          "class": "DigVeinsMineGridCellHover",
          hittest: false
        }, null), libs.createElement("Panel", {
          "class": "DigVeinsMineGridCellSelected",
          hittest: false
        }, null), libs.createElement("Panel", {
          "class": "DigVeinsMineGridCellDisabled",
          hittest: false
        }, null), (() => {
          const _el$6 = libs.createElement("Label", {
            "class": "DigVeinsMineGridCellDurability",
            get text() {
              return durability() ?? "";
            },
            hittest: false
          }, null);
          libs.effect(_p$ => {
            const _v$ = durability() ?? "",
              _v$2 = showDurability();
            _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$6, "text", _v$, _p$._v$));
            _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$6, "visible", _v$2, _p$._v$2));
            return _p$;
          }, {
            _v$: undefined,
            _v$2: undefined
          });
          return _el$6;
        })()];
      }
    }), null);
    libs.effect(_p$ => {
      const _v$3 = libs.classNames("DigVeinsMineGridCellContainer", prop.class),
        _v$4 = tooltip();
      _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$, "class", _v$3, _p$._v$3));
      _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$, "customTooltip", _v$4, _p$._v$4));
      return _p$;
    }, {
      _v$3: undefined,
      _v$4: undefined
    });
    return _el$;
  })();
}
function DigVeinsToolRangePreview(prop) {
  const visible = () => prop.tool != undefined && prop.tool !== "Pickaxe" && prop.cellIndex != undefined;
  const previewX = libs.createMemo(() => {
    const cellIndex = prop.cellIndex;
    if (cellIndex == undefined) {
      return 0;
    }
    return cellIndex % MINE_GRID_COLUMNS * MINE_GRID_CELL_STRIDE + MINE_GRID_CELL_MARGIN;
  });
  const previewY = libs.createMemo(() => {
    const cellIndex = prop.cellIndex;
    if (cellIndex == undefined) {
      return 0;
    }
    if (prop.tool === "Drill") {
      return MINE_GRID_CELL_MARGIN;
    }
    const row = Math.floor(cellIndex / MINE_GRID_COLUMNS);
    return (row - prop.visibleStartRow) * MINE_GRID_CELL_STRIDE + MINE_GRID_CELL_MARGIN;
  });
  return libs.createComponent(libs.Show, {
    get when() {
      return visible();
    },
    get children() {
      const _el$7 = libs.createElement("Panel", {
          id: "DigVeinsToolRangePreviewLayer",
          hittest: false,
          hittestchildren: false
        }, null),
        _el$8 = libs.createElement("Panel", {
          get ["class"]() {
            return libs.classNames("DigVeinsToolRangePreview", prop.tool);
          },
          get style() {
            return {
              x: `${previewX()}px`,
              y: `${previewY()}px`
            };
          },
          hittest: false,
          hittestchildren: false
        }, _el$7),
        _el$9 = libs.createElement("Panel", {
          "class": "DigVeinsToolRangePreviewContent",
          hittest: false,
          hittestchildren: false
        }, _el$8);
        libs.createElement("Image", {
          "class": "DigVeinsToolRangeMask",
          hittest: false
        }, _el$9);
      libs.insert(_el$9, libs.createComponent(libs.Show, {
        get when() {
          return prop.tool === "Bomb";
        },
        get children() {
          return [libs.createElement("Image", {
            "class": "DigVeinsToolRangeArrow TopLeft",
            hittest: false
          }, null), libs.createElement("Image", {
            "class": "DigVeinsToolRangeArrow Top",
            hittest: false
          }, null), libs.createElement("Image", {
            "class": "DigVeinsToolRangeArrow TopRight",
            hittest: false
          }, null), libs.createElement("Image", {
            "class": "DigVeinsToolRangeArrow Left",
            hittest: false
          }, null), libs.createElement("Image", {
            "class": "DigVeinsToolRangeArrow Right",
            hittest: false
          }, null), libs.createElement("Image", {
            "class": "DigVeinsToolRangeArrow BottomLeft",
            hittest: false
          }, null), libs.createElement("Image", {
            "class": "DigVeinsToolRangeArrow Bottom",
            hittest: false
          }, null), libs.createElement("Image", {
            "class": "DigVeinsToolRangeArrow BottomRight",
            hittest: false
          }, null)];
        }
      }), null);
      libs.effect(_p$ => {
        const _v$5 = libs.classNames("DigVeinsToolRangePreview", prop.tool),
          _v$6 = {
            x: `${previewX()}px`,
            y: `${previewY()}px`
          };
        _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$8, "class", _v$5, _p$._v$5));
        _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$8, "style", _v$6, _p$._v$6));
        return _p$;
      }, {
        _v$5: undefined,
        _v$6: undefined
      });
      return _el$7;
    }
  });
}
const getDigVeinsTaskSortWeight = task => {
  switch (dig_veins_logic.getDigVeinsTaskState(task)) {
    case "Claimable":
      return 0;
    case "InProgress":
      return 1;
    case "Received":
      return 2;
  }
};
const getDigVeinsTaskKey = task => `${task.task_id}_${task.extra_id}`;
const shouldShowDigVeinsTaskGroup = (taskType, tasks) => {
  if (tasks.length == 0) {
    return false;
  }
  return taskType == 7 || tasks.some(task => dig_veins_logic.getDigVeinsTaskState(task) != "Received");
};
function DigVeinsTaskItem(props) {
  const taskConfig = libs.createMemo(() => KeyValues.task[props.task.task_id]);
  const rewards = libs.createMemo(() => Object.entries(taskConfig()?.rewards ?? {}).slice(0, 2));
  const taskState = libs.createMemo(() => dig_veins_logic.getDigVeinsTaskState(props.task));
  const taskDescription = libs.createMemo(() => {
    const config = taskConfig();
    if (config == undefined) {
      return "";
    }
    return LocalizeWithVars(`#Task_Desc_${props.task.task_id}`, {
      target: GetLocalization(String(config.target)),
      v1: GetLocalization(String(config.param_1)),
      v2: GetLocalization(String(config.param_2)),
      v3: GetLocalization(String(config.param_3))
    });
  });
  return (() => {
    const _el$17 = libs.createElement("Panel", {
        get ["class"]() {
          return libs.classNames("DigVeinsTaskTaskItem", taskState(), {
            Claiming: props.claiming
          });
        }
      }, null),
      _el$18 = libs.createElement("Panel", {
        "class": "DigVeinsTaskItemMain"
      }, _el$17),
      _el$19 = libs.createElement("Panel", {
        "class": "DigVeinsTaskItemContent"
      }, _el$18),
      _el$20 = libs.createElement("Panel", {
        "class": "DigVeinsTaskTitle"
      }, _el$19),
      _el$21 = libs.createElement("Label", {
        "class": "DigVeinsTaskTitleText",
        get text() {
          return GetLocalization(`#Task_Name_${props.task.task_id}`);
        }
      }, _el$20),
      _el$22 = libs.createElement("Label", {
        "class": "DigVeinsTaskTitleValue",
        get text() {
          return `(${Math.min(props.task.progress, props.task.target)}/${props.task.target})`;
        }
      }, _el$20),
      _el$23 = libs.createElement("Label", {
        "class": "DigVeinsTaskItemDescription",
        get text() {
          return taskDescription();
        }
      }, _el$19),
      _el$24 = libs.createElement("Panel", {
        "class": "DigVeinsTaskItemRewardList"
      }, _el$18);
      libs.createElement("Image", {
        "class": "DigVeinsTaskItemBottomLine"
      }, _el$17);
    libs.setProp(_el$17, "onactivate", () => {
      if (!dig_veins_logic.isDigVeinsTaskClaimable(props.task) || props.claiming) {
        return;
      }
      props.onClaim(props.task);
    });
    libs.insert(_el$24, libs.createComponent(libs.For, {
      get each() {
        return rewards();
      },
      children: reward => (() => {
        const _el$27 = libs.createElement("Panel", {
          "class": "DigVeinsTaskItemReward"
        }, null);
        libs.insert(_el$27, libs.createComponent(StoreItem.StoreItemBlock, {
          get item_id() {
            return reward[0];
          },
          get amounts() {
            return reward[1];
          }
        }), null);
        libs.insert(_el$27, libs.createComponent(libs.Show, {
          get when() {
            return taskState() == "Received";
          },
          get children() {
            return libs.createElement("Image", {
              "class": "DigVeinsTaskItemRewardReceivedIcon"
            }, null);
          }
        }), null);
        return _el$27;
      })()
    }));
    libs.insert(_el$17, libs.createComponent(libs.Show, {
      get when() {
        return taskState() == "Claimable";
      },
      get children() {
        return libs.createElement("Image", {
          "class": "DigVeinsTaskDoneBorder",
          hittest: false
        }, null);
      }
    }), null);
    libs.effect(_p$ => {
      const _v$7 = libs.classNames("DigVeinsTaskTaskItem", taskState(), {
          Claiming: props.claiming
        }),
        _v$8 = GetLocalization(`#Task_Name_${props.task.task_id}`),
        _v$9 = `(${Math.min(props.task.progress, props.task.target)}/${props.task.target})`,
        _v$0 = taskDescription();
      _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$17, "class", _v$7, _p$._v$7));
      _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$21, "text", _v$8, _p$._v$8));
      _v$9 !== _p$._v$9 && (_p$._v$9 = libs.setProp(_el$22, "text", _v$9, _p$._v$9));
      _v$0 !== _p$._v$0 && (_p$._v$0 = libs.setProp(_el$23, "text", _v$0, _p$._v$0));
      return _p$;
    }, {
      _v$7: undefined,
      _v$8: undefined,
      _v$9: undefined,
      _v$0: undefined
    });
    return _el$17;
  })();
}
function DigVeinsTaskGroup(props) {
  return (() => {
    const _el$29 = libs.createElement("Panel", {
        "class": "DigVeinsTaskContainer"
      }, null),
      _el$30 = libs.createElement("Panel", {
        get ["class"]() {
          return libs.classNames("DigVeinsTaskHeader", `DigVeinsTaskHeaderType${props.taskType}`);
        }
      }, _el$29);
      libs.createElement("Image", {
        "class": "DigVeinsTaskHeaderBG"
      }, _el$30);
      const _el$32 = libs.createElement("Label", {
        "class": "DigVeinsTaskTaskTitle",
        get text() {
          return GetLocalization(`#ActivityVeins_TaskTitleType_${props.taskType}`);
        }
      }, _el$30),
      _el$33 = libs.createElement("Panel", {
        "class": "DigVeinsTaskTaskContent"
      }, _el$29);
    libs.insert(_el$33, libs.createComponent(libs.For, {
      get each() {
        return props.tasks;
      },
      children: task => libs.createComponent(DigVeinsTaskItem, {
        task: task,
        get claiming() {
          return props.claimingTaskKey == getDigVeinsTaskKey(task);
        },
        get onClaim() {
          return props.onClaim;
        }
      })
    }));
    libs.effect(_p$ => {
      const _v$1 = libs.classNames("DigVeinsTaskHeader", `DigVeinsTaskHeaderType${props.taskType}`),
        _v$10 = GetLocalization(`#ActivityVeins_TaskTitleType_${props.taskType}`);
      _v$1 !== _p$._v$1 && (_p$._v$1 = libs.setProp(_el$30, "class", _v$1, _p$._v$1));
      _v$10 !== _p$._v$10 && (_p$._v$10 = libs.setProp(_el$32, "text", _v$10, _p$._v$10));
      return _p$;
    }, {
      _v$1: undefined,
      _v$10: undefined
    });
    return _el$29;
  })();
}
function DigVeinsDepthProgressBar(prop) {
  const progressPercent = libs.createMemo(() => {
    const span = Math.max(1, prop.toDepth - prop.fromDepth);
    const progress = Math.max(0, Math.min(prop.currentDepth - prop.fromDepth, span));
    const gap = progress > 0 ? 12 : 0;
    return gap + progress / span * (100 - gap * 2);
  });
  return (() => {
    const _el$34 = libs.createElement("Panel", {
        "class": "DigVeinsDepthProgressItem DigVeinsDepthProgressBarItemBar"
      }, null),
      _el$35 = libs.createElement("Panel", {
        "class": "DigVeinsDepthProgressBar"
      }, _el$34);
      libs.createElement("Image", {
        "class": "DigVeinsDepthProgressBarBG"
      }, _el$35);
      const _el$37 = libs.createElement("Panel", {
        "class": "DigVeinsDepthProgressBarFillClip",
        get style() {
          return {
            height: `${progressPercent()}%`
          };
        }
      }, _el$35);
      libs.createElement("Image", {
        "class": "DigVeinsDepthProgressBarFill"
      }, _el$37);
    libs.effect(_$p => libs.setProp(_el$37, "style", {
      height: `${progressPercent()}%`
    }, _$p));
    return _el$34;
  })();
}
function DigVeinsDepthProgressBox(prop) {
  const tooltip = () => {
    if (prop.tooltipRewards == undefined || prop.tooltipRewards.length == 0) {
      return undefined;
    }
    return {
      name: "activity_veins",
      rewards: JSON.stringify(prop.tooltipRewards)
    };
  };
  return (() => {
    const _el$39 = libs.createElement("Panel", {
        get ["class"]() {
          return libs.classNames("DigVeinsDepthProgressItem", "DigVeinsDepthProgressItemBox", prop.state);
        }
      }, null);
      libs.createElement("Panel", {
        "class": "DigVeinsDepthProgressBar"
      }, _el$39);
      const _el$41 = libs.createElement("Panel", {
        "class": "DigVeinsDepthProgressBox",
        get onactivate() {
          return prop.onactivate;
        }
      }, _el$39),
      _el$42 = libs.createElement("Panel", {
        "class": "DigVeinsDepthProgressBoxIconContent"
      }, _el$41);
      libs.createElement("Image", {
        "class": "DigVeinsDepthProgressBoxIcon",
        hittest: false
      }, _el$42);
      libs.createElement("Image", {
        "class": "DigVeinsDepthProgressBoxReceived",
        hittest: false
      }, _el$42);
      const _el$45 = libs.createElement("Panel", {
        "class": "DigVeinsDepthProgressBoxValueContent"
      }, _el$41);
      libs.createElement("Panel", {
        "class": "DigVeinsDepthProgressBoxValueBG"
      }, _el$45);
      const _el$47 = libs.createElement("Label", {
        "class": "DigVeinsDepthProgressBoxValue",
        get text() {
          return `${getDigVeinsDisplayDepth$1(prop.toDepth)}`;
        }
      }, _el$45);
    const _ref$ = prop.panelRef;
    typeof _ref$ === "function" ? libs.use(_ref$, _el$39) : prop.panelRef = _el$39;
    libs.effect(_p$ => {
      const _v$11 = libs.classNames("DigVeinsDepthProgressItem", "DigVeinsDepthProgressItemBox", prop.state),
        _v$12 = tooltip(),
        _v$13 = prop.onactivate,
        _v$14 = `${getDigVeinsDisplayDepth$1(prop.toDepth)}`;
      _v$11 !== _p$._v$11 && (_p$._v$11 = libs.setProp(_el$39, "class", _v$11, _p$._v$11));
      _v$12 !== _p$._v$12 && (_p$._v$12 = libs.setProp(_el$41, "customTooltip", _v$12, _p$._v$12));
      _v$13 !== _p$._v$13 && (_p$._v$13 = libs.setProp(_el$41, "onactivate", _v$13, _p$._v$13));
      _v$14 !== _p$._v$14 && (_p$._v$14 = libs.setProp(_el$47, "text", _v$14, _p$._v$14));
      return _p$;
    }, {
      _v$11: undefined,
      _v$12: undefined,
      _v$13: undefined,
      _v$14: undefined
    });
    return _el$39;
  })();
}
function DigVeinsDepthProgress(props) {
  const currentDepth = libs.createMemo(() => Number.isFinite(props.depth) ? Math.max(0, props.depth) : 0);
  const progressStages = libs.createMemo(getDigVeinsProgressStages);
  const depthMulRecords = libs.createMemo(() => {
    return progressStages().flatMap(stage => {
      if (!Number.isFinite(stage.coinRate) || stage.coinRate <= 0) {
        return [];
      }
      return [{
        depth: getDigVeinsDisplayDepth$1(stage.toDepth),
        mul: stage.coinRate / 100
      }];
    });
  });
  const currentDepthMulText = libs.createMemo(() => {
    return (getDigVeinsCoinRateByDepth(currentDepth(), progressStages()) / 100).toFixed(1);
  });
  const depthMulTooltip = libs.createMemo(() => ({
    name: "activity_veins",
    depthMul: JSON.stringify({
      record: depthMulRecords(),
      nowDepth: getDigVeinsDisplayDepth$1(currentDepth())
    })
  }));
  const [isLayoutReady, setIsLayoutReady] = libs.createSignal(false);
  const stagePanels = [];
  let positionScheduleID;
  let positionRequestVersion = 0;
  let hasInitialPositioned = false;
  let lastPositionedPageStartIndex;
  const cancelPositionSchedule = () => {
    if (positionScheduleID == undefined) {
      return;
    }
    try {
      $.CancelScheduled(positionScheduleID);
    } catch (error) {}
    positionScheduleID = undefined;
  };
  const schedulePosition = (pageStartIndex, initial) => {
    cancelPositionSchedule();
    const requestVersion = ++positionRequestVersion;
    positionScheduleID = $.Schedule(0, () => {
      positionScheduleID = undefined;
      if (requestVersion != positionRequestVersion || !props.ready || !isLayoutReady()) {
        return;
      }
      const targetPanel = stagePanels[pageStartIndex];
      if (targetPanel == undefined || !targetPanel.IsValid()) {
        return;
      }
      targetPanel.ScrollParentToMakePanelFit(1, initial || props.animated === false);
      lastPositionedPageStartIndex = pageStartIndex;
      if (initial) {
        hasInitialPositioned = true;
      }
    });
  };
  libs.createEffect(() => {
    const ready = props.ready;
    const layoutReady = isLayoutReady();
    const stages = progressStages();
    const receivedRewardIDs = props.receivedRewardIDs;
    const depth = currentDepth();
    if (hasInitialPositioned || !ready || !layoutReady || stages.length == 0) {
      return;
    }
    const firstUnreceivedStageIndex = stages.findIndex(stage => !receivedRewardIDs.has(stage.toDepth));
    const pageStartIndex = firstUnreceivedStageIndex >= 0 ? getDigVeinsDepthProgressPageStartIndex(firstUnreceivedStageIndex, stages.length) : getDigVeinsDepthProgressPageStartIndexByDepth(depth, stages);
    schedulePosition(pageStartIndex, true);
  });
  libs.createEffect(() => {
    const ready = props.ready;
    const layoutReady = isLayoutReady();
    const stages = progressStages();
    const depth = currentDepth();
    if (!hasInitialPositioned || !ready || !layoutReady || stages.length == 0) {
      return;
    }
    const pageStartIndex = getDigVeinsDepthProgressPageStartIndexByDepth(depth, stages);
    if (pageStartIndex != lastPositionedPageStartIndex) {
      schedulePosition(pageStartIndex, false);
    }
  });
  libs.onCleanup(() => {
    positionRequestVersion++;
    cancelPositionSchedule();
  });
  const getRewardState = rewardDepth => {
    if (props.receivedRewardIDs.has(rewardDepth)) {
      return "Received";
    }
    return currentDepth() >= rewardDepth ? "Claimable" : "Locked";
  };
  const handleRewardActivate = rewardDepth => {
    const state = getRewardState(rewardDepth);
    if (state == "Received") {
      return;
    }
    if (state == "Locked") {
      ErrorMessage(LocalizeWithVars("#ActivityVeins_BoxProgressNotAllow", {
        depth: getDigVeinsDisplayDepth$1(rewardDepth)
      }));
      return;
    }
    props.onReceiveReward(rewardDepth);
  };
  return [(() => {
    const _el$48 = libs.createElement("Panel", {
        id: "DigVeinsDepthProgressFadeViewport",
        hittest: true,
        hittestchildren: true
      }, null),
      _el$49 = libs.createElement("Panel", {
        id: "DigVeinsDepthProgressViewport",
        scroll: "y",
        hittest: true,
        hittestchildren: true
      }, _el$48),
      _el$50 = libs.createElement("Panel", {
        id: "DigVeinsDepthProgressScrollContent",
        hittest: false,
        hittestchildren: true
      }, _el$49),
      _el$51 = libs.createElement("Panel", {
        id: "DigVeinsDepthProgressBarTrack",
        "class": "DigVeinsDepthProgressTrack DigVeinsDepthProgressBarTrack",
        hittest: false,
        hittestchildren: false
      }, _el$50),
      _el$52 = libs.createElement("Panel", {
        id: "DigVeinsDepthProgressBoxTrack",
        "class": "DigVeinsDepthProgressTrack DigVeinsDepthProgressBoxTrack",
        hittest: false,
        hittestchildren: true
      }, _el$50);
    libs.setProp(_el$49, "scroll", "y");
    libs.setProp(_el$50, "onload", () => setIsLayoutReady(true));
    libs.insert(_el$51, libs.createComponent(libs.For, {
      get each() {
        return progressStages();
      },
      children: stage => libs.createComponent(DigVeinsDepthProgressBar, {
        get fromDepth() {
          return stage.fromDepth;
        },
        get toDepth() {
          return stage.toDepth;
        },
        get currentDepth() {
          return currentDepth();
        }
      })
    }));
    libs.insert(_el$52, libs.createComponent(libs.For, {
      get each() {
        return progressStages();
      },
      children: (stage, index) => libs.createComponent(DigVeinsDepthProgressBox, {
        get fromDepth() {
          return stage.fromDepth;
        },
        get toDepth() {
          return stage.toDepth;
        },
        get currentDepth() {
          return currentDepth();
        },
        get state() {
          return getRewardState(stage.toDepth);
        },
        get tooltipRewards() {
          return parseDigVeinsRewardList(stage.reward);
        },
        panelRef: panel => stagePanels[index()] = panel,
        onactivate: () => handleRewardActivate(stage.toDepth)
      })
    }));
    libs.effect(_p$ => {
      const _v$15 = {
          TransitionDisabled: props.animated === false
        },
        _v$16 = {
          TransitionDisabled: props.animated === false
        };
      _v$15 !== _p$._v$15 && (_p$._v$15 = libs.setProp(_el$51, "classList", _v$15, _p$._v$15));
      _v$16 !== _p$._v$16 && (_p$._v$16 = libs.setProp(_el$52, "classList", _v$16, _p$._v$16));
      return _p$;
    }, {
      _v$15: undefined,
      _v$16: undefined
    });
    return _el$48;
  })(), (() => {
    const _el$53 = libs.createElement("Panel", {
        id: "DigVeinsDepthProgressTitle"
      }, null);
      libs.createElement("Image", {
        id: "DigVeinsDepthProgressTitleBG"
      }, _el$53);
      const _el$55 = libs.createElement("Panel", {
        id: "DigVeinsDepthProgressTitleContent"
      }, _el$53),
      _el$56 = libs.createElement("Label", {
        id: "DigVeinsDepthProgressTitleTag",
        get text() {
          return GetLocalization("#ActivityVeins_DepthProgressTitle");
        }
      }, _el$55),
      _el$57 = libs.createElement("Label", {
        id: "DigVeinsDepthProgressTitleValue",
        get text() {
          return `${getDigVeinsDisplayDepth$1(currentDepth())}M`;
        }
      }, _el$55);
      libs.createElement("Image", {
        id: "DigVeinsDepthProgressTitleDivider"
      }, _el$55);
      const _el$59 = libs.createElement("Panel", {
        id: "DigVeinsDepthProgressTitleMulContent"
      }, _el$55),
      _el$60 = libs.createElement("Label", {
        id: "DigVeinsDepthProgressTitleMulTag",
        get text() {
          return GetLocalization("#ActivityVeins_DepthProgressTitleMul");
        }
      }, _el$59),
      _el$61 = libs.createElement("Label", {
        id: "DigVeinsDepthProgressTitleMulValue",
        get text() {
          return currentDepthMulText();
        }
      }, _el$59);
    libs.effect(_p$ => {
      const _v$17 = depthMulTooltip(),
        _v$18 = GetLocalization("#ActivityVeins_DepthProgressTitle"),
        _v$19 = `${getDigVeinsDisplayDepth$1(currentDepth())}M`,
        _v$20 = GetLocalization("#ActivityVeins_DepthProgressTitleMul"),
        _v$21 = currentDepthMulText();
      _v$17 !== _p$._v$17 && (_p$._v$17 = libs.setProp(_el$53, "customTooltip", _v$17, _p$._v$17));
      _v$18 !== _p$._v$18 && (_p$._v$18 = libs.setProp(_el$56, "text", _v$18, _p$._v$18));
      _v$19 !== _p$._v$19 && (_p$._v$19 = libs.setProp(_el$57, "text", _v$19, _p$._v$19));
      _v$20 !== _p$._v$20 && (_p$._v$20 = libs.setProp(_el$60, "text", _v$20, _p$._v$20));
      _v$21 !== _p$._v$21 && (_p$._v$21 = libs.setProp(_el$61, "text", _v$21, _p$._v$21));
      return _p$;
    }, {
      _v$17: undefined,
      _v$18: undefined,
      _v$19: undefined,
      _v$20: undefined,
      _v$21: undefined
    });
    return _el$53;
  })()];
}
function DigVeins() {
  const playerMiningActivityData = solid_utils.createServiceNetData("player_mining_activity_data", {});
  const playerActivityTasks = solid_utils.createServiceNetData("player_activity_tasks", {});
  const [digVeinsTaskServerTime, setDigVeinsTaskServerTime] = libs.createSignal(Math.floor(CustomUIConfig.GetServerTimeStamp()));
  const miningActivityData = libs.createMemo(() => playerMiningActivityData()?.[dig_veins_logic.ACTIVITY_MINING_ID]);
  const receivedMiningRewardIDs = libs.createMemo(() => new Set(miningActivityData()?.received?.map(reward => reward.reward_id) ?? []));
  const digVeinsTasksByType = libs.createMemo(() => {
    const timestamp = digVeinsTaskServerTime();
    const taskGroups = {
      6: [],
      7: []
    };
    Object.values(playerActivityTasks()).forEach(task => {
      if (!dig_veins_logic.isDigVeinsTask(task) || !dig_veins_logic.isDigVeinsTaskActive(task, timestamp)) {
        return;
      }
      const taskType = KeyValues.task[task.task_id].type;
      taskGroups[taskType].push(task);
    });
    taskGroups[6].sort((a, b) => getDigVeinsTaskSortWeight(a) - getDigVeinsTaskSortWeight(b) || a.index - b.index || a.task_id - b.task_id);
    taskGroups[7].sort((a, b) => getDigVeinsTaskSortWeight(a) - getDigVeinsTaskSortWeight(b) || a.index - b.index || a.task_id - b.task_id);
    return taskGroups;
  });
  const activityData = libs.createMemo(() => KeyValues.activity_data[dig_veins_logic.ACTIVITY_MINING_ID]);
  const playerTokens = solid_utils.createServiceNetData("player_tokens", {});
  const [claimingTaskKey, setClaimingTaskKey] = libs.createSignal();
  const receiveTaskReward = task => {
    const timestamp = Math.floor(CustomUIConfig.GetServerTimeStamp());
    if (!dig_veins_logic.isDigVeinsTaskActive(task, timestamp) || !dig_veins_logic.isDigVeinsTaskClaimable(task) || claimingTaskKey() != undefined) {
      return;
    }
    setClaimingTaskKey(getDigVeinsTaskKey(task));
    CallActionRequest("/v1/task/receive_rewards", {
      task_id: task.task_id,
      extra_id: task.extra_id
    }, () => {
      setClaimingTaskKey(undefined);
    }, () => {
      setClaimingTaskKey(undefined);
    });
  };
  const receiveDepthReward = rewardDepth => {
    CallAction("/v1/activity/receive_rewards", {
      activity_id: dig_veins_logic.ACTIVITY_MINING_ID,
      reward_id: rewardDepth
    });
  };
  const miningConfig = libs.createMemo(() => {
    const activityID = miningActivityData()?.activity_id;
    if (!Number.isFinite(activityID)) {
      return undefined;
    }
    return Object.values(KeyValues.activity_mining ?? {}).find(config => config.activity_id == activityID);
  });
  const durabilityConfig = libs.createMemo(() => parseDigVeinsDurability(miningConfig()?.durability));
  const chestTooltipRewards = libs.createMemo(() => parseDigVeinsWeightedRewardList(miningConfig()?.box_reward ?? ""));
  const tokenConfig = libs.createMemo(() => {
    const [rawItemID, rawBaseAmount] = (miningConfig()?.coin_config ?? "").split("|");
    const baseAmount = Number(rawBaseAmount);
    if (rawItemID == undefined || rawItemID.length == 0 || !Number.isFinite(baseAmount) || baseAmount <= 0) {
      return undefined;
    }
    return {
      itemID: rawItemID,
      baseAmount
    };
  });
  const progressStages = libs.createMemo(getDigVeinsProgressStages);
  const getTokenTooltipRewards = depth => {
    const config = tokenConfig();
    if (config == undefined) {
      return [];
    }
    const coinRate = getDigVeinsCoinRateByDepth(depth, progressStages());
    const amounts = Math.floor(config.baseAmount * coinRate / 100);
    return amounts > 0 ? [{
      item_id: config.itemID,
      amounts
    }] : [];
  };
  const getPlayerTokenAmount = itemID => {
    if (itemID == undefined || itemID <= 0) {
      return 0;
    }
    return playerTokens()[String(itemID)]?.amounts ?? 0;
  };
  const bombAmount = libs.createMemo(() => getPlayerTokenAmount(miningConfig()?.explosive_id));
  const pickaxeAmount = libs.createMemo(() => getPlayerTokenAmount(miningConfig()?.pickaxe_id));
  const drillAmount = libs.createMemo(() => getPlayerTokenAmount(miningConfig()?.bit_id));
  const getToolAmount = tool => {
    switch (tool) {
      case "Bomb":
        return bombAmount();
      case "Pickaxe":
        return pickaxeAmount();
      case "Drill":
        return drillAmount();
    }
  };
  const logoLang = libs.createMemo(() => {
    const lang = Language();
    if (lang == "schinese") {
      return "Language_schinese";
    } else if (lang == "russian") {
      return "Language_russian";
    } else {
      return "Language_english";
    }
  });
  const ruleTooltip = libs.createMemo(() => ({
    name: Language() == "schinese" ? "text" : "activity_veins_rule",
    text: "#ActivityVeins_RuleTooltip"
  }));
  const pickaxeSequence = createSequenceFrame({
    frames: PICKAXE_SEQ_FRAMES,
    interval: 60,
    isLoop: false,
    autoPlay: false
  });
  const bombSequence = createSequenceFrame({
    frames: BOMB_SEQ_FRAMES,
    interval: 80,
    isLoop: false,
    autoPlay: false
  });
  const drillSequence = createSequenceFrame({
    frames: DRILL_SEQ_FRAMES,
    interval: 80,
    isLoop: false,
    autoPlay: false
  });
  const PickaxeSequenceFrame = pickaxeSequence.SequenceFrame;
  const BombSequenceFrame = bombSequence.SequenceFrame;
  const DrillSequenceFrame = drillSequence.SequenceFrame;
  const [equippedTool, setEquippedTool] = libs.createSignal("Pickaxe");
  const [hoveredCellIndex, setHoveredCellIndex] = libs.createSignal();
  const [mineGridBottomRow, setMineGridBottomRow] = libs.createSignal(0);
  const [mineGridReady, setMineGridReady] = libs.createSignal(false);
  const [mineGridRowKeys, setMineGridRowKeys] = libs.createSignal([]);
  const [mineGridRowCellKeys, setMineGridRowCellKeys] = libs.createStore({});
  const [mineGridScrollOffset, setMineGridScrollOffset] = libs.createSignal(0);
  const [mineGridTransitionDisabled, setMineGridTransitionDisabled] = libs.createSignal(true);
  const [isMiningRequesting, setIsMiningRequesting] = libs.createSignal(false);
  const [isMineGridAnimating, setIsMineGridAnimating] = libs.createSignal(false);
  const [isMineGridScrolling, setIsMineGridScrolling] = libs.createSignal(false);
  const [isRewardTipVisible, setIsRewardTipVisible] = libs.createSignal(false);
  const [rewardTipAmount, setRewardTipAmount] = libs.createSignal(0);
  const [activeMineGridToolEffects, setActiveMineGridToolEffects] = libs.createSignal([]);
  const [activeMineGridToolSequenceFrame, setActiveMineGridToolSequenceFrame] = libs.createSignal({
    actionID: 0,
    tool: "Pickaxe",
    row: 0,
    column: 0
  });
  const [isMineGridToolSequenceFrameVisible, setIsMineGridToolSequenceFrameVisible] = libs.createSignal(false);
  const [isMineGridToolSequenceFrameMoving, setIsMineGridToolSequenceFrameMoving] = libs.createSignal(false);
  const [mineGridSlots, setMineGridSlots] = libs.createStore({});
  const [fadingOutCells, setFadingOutCells] = libs.createStore({});
  let cursorPanel;
  let mineGridViewportPanel;
  let mineGridTransitionResetScheduleId;
  let mineGridTimelineRuntime;
  let rewardTipShowScheduleID;
  let rewardTipHideScheduleID;
  let parsedMineGridSnapshot;
  let displayMineGridSnapshot;
  let lastCalibratedMineGridNetData;
  let nextMiningActionID = 0;
  let isDisposed = false;
  const mineGridSlotGenerations = {};
  const canActivateToolButton = tool => !isMiningRequesting() && (tool == "Pickaxe" || getToolAmount(tool) > 0);
  const isMineGridInteractionLocked = () => isMiningRequesting() || isMineGridScrolling();
  const canShowToolRangePreview = () => !isMineGridInteractionLocked() && equippedTool() !== "Pickaxe" && hoveredCellIndex() != undefined;
  const cancelRewardTipSchedule = scheduleID => {
    if (scheduleID == undefined) {
      return;
    }
    try {
      $.CancelScheduled(scheduleID);
    } catch (error) {}
  };
  const hideRewardTip = () => {
    cancelRewardTipSchedule(rewardTipShowScheduleID);
    cancelRewardTipSchedule(rewardTipHideScheduleID);
    rewardTipShowScheduleID = undefined;
    rewardTipHideScheduleID = undefined;
    setIsRewardTipVisible(false);
  };
  const showRewardTip = amount => {
    hideRewardTip();
    rewardTipShowScheduleID = $.Schedule(0, () => {
      rewardTipShowScheduleID = undefined;
      if (isDisposed) {
        return;
      }
      libs.batch(() => {
        setRewardTipAmount(amount);
        setIsRewardTipVisible(true);
      });
      rewardTipHideScheduleID = $.Schedule(DIG_VEINS_REWARD_TIP_VISIBLE_DURATION, () => {
        rewardTipHideScheduleID = undefined;
        hideRewardTip();
      });
    });
  };
  const getMineGridSlot = index => mineGridSlots[index];
  const getMineGridTooltipRewards = index => {
    const slotType = getMineGridSlot(index)?.type;
    if (slotType == "chest") {
      return chestTooltipRewards();
    }
    if (slotType == "token") {
      return getTokenTooltipRewards(Math.floor(index / MINE_GRID_COLUMNS));
    }
    return undefined;
  };
  const isMineGridCellFadingOut = index => fadingOutCells[index] === true;
  const replaceMineGridSlots = slots => {
    setMineGridSlots(libs.produce(record => {
      const retainedIndexes = {};
      for (const slot of slots) {
        retainedIndexes[slot.index] = true;
        const currentSlot = record[slot.index];
        if (currentSlot == undefined) {
          record[slot.index] = {
            ...slot
          };
        } else if (currentSlot.type !== slot.type) {
          currentSlot.type = slot.type;
        }
      }
      for (const key of Object.keys(record)) {
        const index = Number(key);
        if (retainedIndexes[index] !== true) {
          delete record[index];
        }
      }
    }));
  };
  const clearMineGridSlots = () => {
    setMineGridSlots(libs.produce(record => {
      for (const key of Object.keys(record)) {
        delete record[Number(key)];
      }
    }));
    setMineGridRowCellKeys(libs.produce(record => {
      for (const key of Object.keys(record)) {
        delete record[Number(key)];
      }
    }));
    setMineGridRowKeys([]);
  };
  const clearFadingOutCells = () => {
    setFadingOutCells(libs.produce(record => {
      for (const key of Object.keys(record)) {
        delete record[Number(key)];
      }
    }));
  };
  const getMineGridCellClass = index => {
    const type = getMineGridSlot(index)?.type;
    return libs.classNames({
      Empty: type == undefined
    }, type != undefined ? `SlotType-${type}` : undefined);
  };
  const getMineGridSlotDurability = index => {
    const type = getMineGridSlot(index)?.type;
    if (type == undefined || type == "none") {
      return undefined;
    }
    return durabilityConfig()[DIG_VEINS_SLOT_DURABILITY[type]];
  };
  const getLatestMineGridSnapshot = () => parsedMineGridSnapshot ?? parseDigVeinsSnapshot(miningActivityData()) ?? displayMineGridSnapshot;
  const getLogicalMineGridSlotType = index => {
    const snapshot = getLatestMineGridSnapshot();
    if (snapshot == undefined) {
      return undefined;
    }
    const row = Math.floor(index / MINE_GRID_COLUMNS);
    const column = index % MINE_GRID_COLUMNS;
    const visibleStartRow = getDigVeinsVisibleStartRow(snapshot.depth);
    if (row < visibleStartRow || row > snapshot.depth) {
      return undefined;
    }
    return snapshot.rows[row]?.[column];
  };
  const isLogicalMineGridSlotClickable = index => {
    const type = getLogicalMineGridSlotType(index);
    return type != undefined && DIG_VEINS_SLOT_TYPE[type];
  };
  const getLogicalMineGridSlotDurability = index => {
    const type = getLogicalMineGridSlotType(index);
    if (type == undefined || type == "none") {
      return undefined;
    }
    return durabilityConfig()[DIG_VEINS_SLOT_DURABILITY[type]];
  };
  const getVisibleStartRow = getDigVeinsVisibleStartRow;
  const getMineGridToolEffectAnchorStyle = effect => {
    const visibleStartRow = getVisibleStartRow(mineGridBottomRow());
    return {
      x: `${effect.column * MINE_GRID_CELL_STRIDE + MINE_GRID_CELL_STRIDE * 0.5}px`,
      y: `${(effect.row - visibleStartRow) * MINE_GRID_CELL_STRIDE + MINE_GRID_CELL_STRIDE * 0.5}px`
    };
  };
  const getMineGridToolSequenceFrameAnchorStyle = () => {
    const state = activeMineGridToolSequenceFrame();
    const visibleStartRow = getVisibleStartRow(mineGridBottomRow());
    return {
      x: `${state.column * MINE_GRID_CELL_STRIDE + MINE_GRID_CELL_STRIDE * 0.5}px`,
      y: `${(state.row - visibleStartRow) * MINE_GRID_CELL_STRIDE + MINE_GRID_CELL_STRIDE * 0.5}px`
    };
  };
  const isKnownEmptyLogicalMineGridSlot = (snapshot, row, column, visibleStartRow, visibleEndRow) => {
    if (row < visibleStartRow || row > visibleEndRow) {
      return false;
    }
    if (row < 0) {
      return true;
    }
    const slots = snapshot.rows[row];
    return slots != undefined && slots[column] == undefined;
  };
  const hasAdjacentEmptyLogicalMineGridSlot = index => {
    const snapshot = getLatestMineGridSnapshot();
    if (snapshot == undefined) {
      return false;
    }
    const row = Math.floor(index / MINE_GRID_COLUMNS);
    const column = index % MINE_GRID_COLUMNS;
    const visibleEndRow = snapshot.depth;
    const visibleStartRow = getVisibleStartRow(visibleEndRow);
    if (row < visibleStartRow || row > visibleEndRow) {
      return false;
    }
    if (isKnownEmptyLogicalMineGridSlot(snapshot, row - 1, column, visibleStartRow, visibleEndRow) || isKnownEmptyLogicalMineGridSlot(snapshot, row + 1, column, visibleStartRow, visibleEndRow)) {
      return true;
    }
    if (column > 0 && isKnownEmptyLogicalMineGridSlot(snapshot, row, column - 1, visibleStartRow, visibleEndRow)) {
      return true;
    }
    if (column < MINE_GRID_COLUMNS - 1 && isKnownEmptyLogicalMineGridSlot(snapshot, row, column + 1, visibleStartRow, visibleEndRow)) {
      return true;
    }
    return false;
  };
  const getMineGridCellIndexFromKey = key => Number(key.slice(0, key.lastIndexOf("|")));
  const bumpMineGridSlotGeneration = index => {
    mineGridSlotGenerations[index] = (mineGridSlotGenerations[index] ?? 0) + 1;
  };
  const syncMineGridLayout = snapshot => {
    const layout = buildDigVeinsMineGridLayout(snapshot.rows, snapshot.depth);
    const retainedIndexes = {};
    for (const slot of layout.slots) {
      retainedIndexes[slot.index] = true;
      const currentSlot = mineGridSlots[slot.index];
      if (currentSlot != undefined && currentSlot.type !== slot.type) {
        bumpMineGridSlotGeneration(slot.index);
      }
    }
    for (const key of Object.keys(mineGridSlotGenerations)) {
      const index = Number(key);
      if (retainedIndexes[index] !== true) {
        delete mineGridSlotGenerations[index];
      }
    }
    replaceMineGridSlots(layout.slots);
    setMineGridRowCellKeys(libs.produce(record => {
      const retainedRows = {};
      for (const layoutRow of layout.rows) {
        retainedRows[layoutRow.row] = true;
        record[layoutRow.row] = layoutRow.cells.map(slot => `${slot.index}|${mineGridSlotGenerations[slot.index] ?? 0}`);
      }
      for (const key of Object.keys(record)) {
        const row = Number(key);
        if (retainedRows[row] !== true) {
          delete record[row];
        }
      }
    }));
    setMineGridRowKeys(layout.rows.map(layoutRow => layoutRow.row));
    setMineGridScrollOffset(0);
  };
  const cancelMineGridTransitionReset = () => {
    if (mineGridTransitionResetScheduleId != undefined) {
      try {
        $.CancelScheduled(mineGridTransitionResetScheduleId);
      } catch (error) {}
      mineGridTransitionResetScheduleId = undefined;
    }
  };
  const clearMineGridToolEffects = actionID => {
    if (actionID == undefined) {
      setActiveMineGridToolEffects([]);
      return;
    }
    setActiveMineGridToolEffects(effects => effects.filter(effect => effect.actionID !== actionID));
  };
  const getMineGridToolSequenceFrame = tool => {
    switch (tool) {
      case "Pickaxe":
        return pickaxeSequence;
      case "Bomb":
        return bombSequence;
      case "Drill":
        return drillSequence;
    }
  };
  const startMineGridToolSequenceFrame = state => {
    const currentState = activeMineGridToolSequenceFrame();
    if (currentState.actionID !== state.actionID) {
      getMineGridToolSequenceFrame(currentState.tool).stop();
    }
    getMineGridToolSequenceFrame(state.tool).replay();
    libs.batch(() => {
      setIsMineGridToolSequenceFrameMoving(false);
      setActiveMineGridToolSequenceFrame({
        ...state
      });
      setIsMineGridToolSequenceFrameVisible(true);
    });
  };
  const moveMineGridToolSequenceFrame = (actionID, row, column) => {
    const state = activeMineGridToolSequenceFrame();
    if (!isMineGridToolSequenceFrameVisible() || state.actionID !== actionID || state.tool !== "Drill" || drillSequence.isFinished()) {
      return;
    }
    libs.batch(() => {
      setIsMineGridToolSequenceFrameMoving(true);
      setActiveMineGridToolSequenceFrame({
        ...state,
        row,
        column
      });
    });
  };
  const stopMineGridToolSequenceFrame = actionID => {
    const state = activeMineGridToolSequenceFrame();
    if (actionID != undefined && state.actionID !== actionID) {
      return;
    }
    getMineGridToolSequenceFrame(state.tool).stop();
    libs.batch(() => {
      setIsMineGridToolSequenceFrameMoving(false);
      setIsMineGridToolSequenceFrameVisible(false);
    });
  };
  libs.createEffect(() => {
    const state = activeMineGridToolSequenceFrame();
    if (!isMineGridToolSequenceFrameVisible() || !getMineGridToolSequenceFrame(state.tool).isFinished()) {
      return;
    }
    if (activeMineGridToolSequenceFrame().actionID === state.actionID) {
      libs.batch(() => {
        setIsMineGridToolSequenceFrameVisible(false);
        setIsMineGridToolSequenceFrameMoving(false);
      });
    }
  });
  const cancelMineGridTimeline = () => {
    const runtime = mineGridTimelineRuntime;
    stopMineGridToolSequenceFrame(runtime?.plan.context.id);
    if (runtime == undefined) {
      return;
    }
    if (runtime.scheduleID != undefined) {
      try {
        $.CancelScheduled(runtime.scheduleID);
      } catch (error) {}
    }
    clearMineGridToolEffects(runtime.plan.context.id);
    mineGridTimelineRuntime = undefined;
  };
  const setDisplayMineGridSnapshot = (snapshot, resetTransitionNextFrame = true) => {
    const displaySnapshot = cloneDigVeinsSnapshot(snapshot);
    displayMineGridSnapshot = displaySnapshot;
    cancelMineGridTransitionReset();
    libs.batch(() => {
      clearFadingOutCells();
      setMineGridTransitionDisabled(true);
      setMineGridBottomRow(displaySnapshot.depth);
      syncMineGridLayout(displaySnapshot);
      setMineGridReady(true);
      setHoveredCellIndex(undefined);
    });
    if (!resetTransitionNextFrame) {
      return;
    }
    mineGridTransitionResetScheduleId = $.Schedule(0, () => {
      mineGridTransitionResetScheduleId = undefined;
      if (isDisposed) {
        return;
      }
      setMineGridTransitionDisabled(false);
      if (!isMineGridInteractionLocked()) {
        refreshHoveredCellFromCursor();
      }
    });
  };
  const calibrateMineGridFromNetTable = (resetTransitionNextFrame = true) => {
    const netTableData = miningActivityData();
    const netTableSnapshot = parseDigVeinsSnapshot(netTableData);
    if (netTableSnapshot != undefined) {
      lastCalibratedMineGridNetData = netTableData;
      parsedMineGridSnapshot = cloneDigVeinsSnapshot(netTableSnapshot);
      setDisplayMineGridSnapshot(netTableSnapshot, resetTransitionNextFrame);
    } else if (parsedMineGridSnapshot != undefined) {
      setDisplayMineGridSnapshot(parsedMineGridSnapshot, resetTransitionNextFrame);
    }
  };
  const destroyCursorPanel = () => {
    if (cursorPanel != undefined && cursorPanel.IsValid()) {
      cursorPanel.DeleteAsync(-1);
    }
    cursorPanel = undefined;
  };
  const createCursorPanel = tool => {
    destroyCursorPanel();
    const panel = $.CreatePanel("Panel", $.GetContextPanel(), "DigVeinsEquippedToolCursor");
    panel.hittest = false;
    panel.AddClass(tool);
    cursorPanel = panel;
    libs.render(() => {
      return libs.createElement("Panel", {
        "class": "DigVeinsEquippedToolCursorIcon",
        hittest: false
      }, null);
    }, panel);
  };
  const updateCursorPosition = () => {
    if (cursorPanel == undefined || !cursorPanel.IsValid()) {
      return;
    }
    const cursor = GameUI.GetCursorPosition();
    const parent = cursorPanel.GetParent();
    const parentPosition = parent?.GetPositionWithinWindow();
    const scaleX = parent?.actualuiscale_x ?? cursorPanel.actualuiscale_x ?? 1;
    const scaleY = parent?.actualuiscale_y ?? cursorPanel.actualuiscale_y ?? 1;
    const parentX = parentPosition?.x ?? 0;
    const parentY = parentPosition?.y ?? 0;
    cursorPanel.SetPositionInPixels((cursor[0] - parentX - TOOL_CURSOR_ICON_SIZE * 0.5) / scaleX, (cursor[1] - parentY - TOOL_CURSOR_ICON_SIZE * 0.5) / scaleY, 0);
  };
  const refreshHoveredCellFromCursor = () => {
    const viewport = mineGridViewportPanel;
    if (viewport == undefined || !viewport.IsValid()) {
      setHoveredCellIndex(undefined);
      return;
    }
    const cursor = GameUI.GetCursorPosition();
    const viewportPosition = viewport.GetPositionWithinWindow();
    const scaleX = viewport.actualuiscale_x || 1;
    const scaleY = viewport.actualuiscale_y || 1;
    const localX = (cursor[0] - viewportPosition.x) / scaleX;
    const localY = (cursor[1] - viewportPosition.y) / scaleY;
    const column = Math.floor(localX / MINE_GRID_CELL_STRIDE);
    const visibleRow = Math.floor(localY / MINE_GRID_CELL_STRIDE);
    if (localX < 0 || localY < 0 || column < 0 || column >= MINE_GRID_COLUMNS || visibleRow < 0 || visibleRow >= MINE_GRID_VISIBLE_ROWS) {
      setHoveredCellIndex(undefined);
      return;
    }
    const row = getVisibleStartRow(mineGridBottomRow()) + visibleRow;
    const index = row * MINE_GRID_COLUMNS + column;
    setHoveredCellIndex(isLogicalMineGridSlotClickable(index) ? index : undefined);
  };
  const equipTool = tool => {
    libs.batch(() => {
      setHoveredCellIndex(undefined);
      setEquippedTool(tool);
    });
    createCursorPanel(tool);
    $.Schedule(0, updateCursorPosition);
  };
  const handleCellMouseOver = index => {
    setHoveredCellIndex(index);
  };
  const handleCellMouseOut = index => {
    if (hoveredCellIndex() === index) {
      setHoveredCellIndex(undefined);
    }
  };
  const validateMiningAction = (index, tool) => {
    if (isMineGridInteractionLocked() || equippedTool() !== tool || !isLogicalMineGridSlotClickable(index)) {
      return false;
    }
    if (tool == "Pickaxe") {
      const durability = getLogicalMineGridSlotDurability(index);
      if (durability == undefined) {
        return false;
      }
      if (pickaxeAmount() < durability) {
        ErrorMessage(GetLocalization("#ActivityVeins_ResourceNotEnough"));
        return false;
      }
      if (!hasAdjacentEmptyLogicalMineGridSlot(index)) {
        ErrorMessage(GetLocalization("#ActivityVeins_PickaxeNotAllow"));
        return false;
      }
    } else if (getToolAmount(tool) <= 0) {
      ErrorMessage(GetLocalization("#ActivityVeins_ResourceNotEnough"));
      return false;
    }
    return true;
  };
  const submitMiningAction = context => {
    libs.batch(() => {
      setHoveredCellIndex(undefined);
      setIsMiningRequesting(true);
    });
    CallActionRequest("/v1/activity/play_mining", {
      activity_id: dig_veins_logic.ACTIVITY_MINING_ID,
      row: context.column,
      line: context.row,
      operate_type: context.operateType
    }, result => {
      if (result.code != 0 && result.code != 200) {
        setIsMiningRequesting(false);
        if (result.message != undefined) {
          ErrorMessage(result.message);
        }
        return;
      }
      if (context.tool != "Pickaxe" && getToolAmount(context.tool) <= 0) {
        equipTool("Pickaxe");
      }
      const responseData = result.data?.player_mining_activity_data;
      const activityData = Array.isArray(responseData) ? responseData.find(data => data?.activity_id == dig_veins_logic.ACTIVITY_MINING_ID) : undefined;
      const responseStartRow = getVisibleStartRow(parsedMineGridSnapshot?.depth ?? mineGridBottomRow());
      const responseSnapshot = parseDigVeinsSnapshot(activityData, responseStartRow);
      if (responseSnapshot == undefined) {
        console.log("[DigVeins] mining request returned no valid activity snapshot");
        setIsMiningRequesting(false);
        return;
      }
      const specialRewardAmount = (result.data?.add_items?.common ?? []).reduce((amount, item) => item.item_id == DIG_VEINS_SPECIAL_REWARD_ITEM_ID ? amount + item.amounts : amount, 0);
      libs.batch(() => {
        startMineGridPresentation(context, responseSnapshot, specialRewardAmount);
        setIsMiningRequesting(false);
      });
    }, () => {
      setIsMiningRequesting(false);
    });
  };
  const handleCellActivate = (index, tool) => {
    const runtime = mineGridTimelineRuntime;
    const activeIndex = runtime == undefined ? undefined : runtime.plan.context.row * MINE_GRID_COLUMNS + runtime.plan.context.column;
    if (activeIndex === index || !validateMiningAction(index, tool)) {
      return;
    }
    if (mineGridTimelineRuntime != undefined && interruptMineGridPresentation()) {
      return;
    }
    const row = Math.floor(index / MINE_GRID_COLUMNS);
    const column = index % MINE_GRID_COLUMNS;
    const context = {
      id: ++nextMiningActionID,
      tool,
      row,
      column,
      operateType: DIG_VEINS_TOOL_OPERATE_TYPE[tool]
    };
    submitMiningAction(context);
  };
  const executeMineGridTimelineCommand = command => {
    switch (command.type) {
      case "startToolSequenceFrame":
        startMineGridToolSequenceFrame(command.state);
        return;
      case "moveToolSequenceFrame":
        moveMineGridToolSequenceFrame(command.actionID, command.row, command.column);
        return;
      case "playSound":
        Game.EmitSound(command.soundEvent);
        return;
      case "showToolEffect":
        setActiveMineGridToolEffects(effects => [...effects.filter(effect => effect.id !== command.effect.id), command.effect]);
        return;
      case "hideToolEffects":
        clearMineGridToolEffects(command.actionID);
        return;
      case "startRemove":
        setFadingOutCells(libs.produce(record => {
          for (const tile of command.tiles) {
            record[tile.index] = true;
          }
        }));
        return;
      case "commitRemove":
        libs.batch(() => {
          setMineGridTransitionDisabled(true);
          const displaySnapshot = displayMineGridSnapshot;
          if (displaySnapshot != undefined) {
            const removedRowSet = {};
            for (const row of command.rows) {
              removedRowSet[row] = true;
            }
            for (const tile of command.tiles) {
              const row = Math.floor(tile.index / MINE_GRID_COLUMNS);
              const column = tile.index % MINE_GRID_COLUMNS;
              const slots = displaySnapshot.rows[row];
              if (slots != undefined && removedRowSet[row] !== true) {
                slots[column] = undefined;
              }
            }
            for (const row of command.rows) {
              delete displaySnapshot.rows[row];
            }
            syncMineGridLayout(displaySnapshot);
          }
          setFadingOutCells(libs.produce(record => {
            for (const tile of command.tiles) {
              delete record[tile.index];
            }
          }));
        });
        return;
      case "applyAdd":
        {
          setMineGridTransitionDisabled(true);
          const displaySnapshot = displayMineGridSnapshot;
          if (displaySnapshot != undefined) {
            for (const row of command.rows) {
              displaySnapshot.rows[row] = Array.from({
                length: MINE_GRID_COLUMNS
              }, () => undefined);
            }
            for (const tile of command.tiles) {
              const row = Math.floor(tile.index / MINE_GRID_COLUMNS);
              const column = tile.index % MINE_GRID_COLUMNS;
              displaySnapshot.rows[row] ??= Array.from({
                length: MINE_GRID_COLUMNS
              }, () => undefined);
              displaySnapshot.rows[row][column] = tile.type;
            }
            syncMineGridLayout(displaySnapshot);
          }
          return;
        }
      case "enableTransition":
        setMineGridTransitionDisabled(false);
        return;
      case "showRewardTip":
        showRewardTip(command.amount);
        return;
      case "startScroll":
        {
          setIsMineGridScrolling(true);
          const nextBottomRow = command.toDepth;
          if (displayMineGridSnapshot != undefined) {
            displayMineGridSnapshot.depth = nextBottomRow;
          }
          libs.batch(() => {
            setMineGridBottomRow(nextBottomRow);
            setMineGridScrollOffset(Math.max(0, (command.toDepth - command.fromDepth) * MINE_GRID_CELL_STRIDE));
          });
          return;
        }
      case "finishScroll":
        if (mineGridTimelineRuntime != undefined) {
          mineGridTimelineRuntime.scrollFinished = true;
        }
        libs.batch(() => {
          setMineGridTransitionDisabled(true);
          if (displayMineGridSnapshot != undefined) {
            const targetDepth = displayMineGridSnapshot.depth;
            const stableSnapshot = getDigVeinsSnapshotWindow(displayMineGridSnapshot, getVisibleStartRow(targetDepth), targetDepth);
            displayMineGridSnapshot = stableSnapshot;
            syncMineGridLayout(stableSnapshot);
          }
        });
        return;
      case "calibrate":
        calibrateMineGridFromNetTable(false);
        return;
      case "finishFlow":
        libs.batch(() => {
          setIsMineGridAnimating(false);
          setIsMineGridScrolling(false);
        });
        if (!isMiningRequesting()) {
          refreshHoveredCellFromCursor();
        }
        return;
    }
  };
  const tickMineGridTimeline = runtime => {
    if (isDisposed || mineGridTimelineRuntime !== runtime) {
      return;
    }
    const elapsed = Math.max(runtime.lastElapsed, Date.now() / 1000 - runtime.startedAt);
    runtime.lastElapsed = elapsed;
    while (runtime.nextEventIndex < runtime.plan.events.length) {
      const event = runtime.plan.events[runtime.nextEventIndex];
      if (event.at > elapsed) {
        break;
      }
      runtime.nextEventIndex++;
      executeMineGridTimelineCommand(event.command);
    }
    if (runtime.nextEventIndex >= runtime.plan.events.length && elapsed >= runtime.plan.duration) {
      runtime.scheduleID = undefined;
      mineGridTimelineRuntime = undefined;
      return;
    }
    runtime.scheduleID = $.Schedule(MINE_GRID_TIMELINE_TICK_INTERVAL, () => tickMineGridTimeline(runtime));
  };
  const playMineGridTimeline = (plan, scrolling = false) => {
    cancelMineGridTimeline();
    const runtime = {
      plan,
      startedAt: Date.now() / 1000,
      lastElapsed: 0,
      nextEventIndex: 0,
      scrollFinished: false
    };
    mineGridTimelineRuntime = runtime;
    libs.batch(() => {
      setIsMineGridAnimating(true);
      setIsMineGridScrolling(scrolling);
    });
    tickMineGridTimeline(runtime);
  };
  const interruptMineGridPresentation = () => {
    const runtime = mineGridTimelineRuntime;
    if (runtime == undefined) {
      libs.batch(() => {
        setIsMineGridAnimating(false);
        setIsMineGridScrolling(false);
      });
      return false;
    }
    const scrollEvent = runtime.plan.events.find(event => event.command.type == "startScroll");
    const rewardTipEventIndex = runtime.plan.events.findIndex(event => event.command.type == "showRewardTip");
    const pendingRewardTipCommand = rewardTipEventIndex >= runtime.nextEventIndex && runtime.plan.events[rewardTipEventIndex]?.command.type == "showRewardTip" ? runtime.plan.events[rewardTipEventIndex].command : undefined;
    cancelMineGridTimeline();
    clearFadingOutCells();
    if (scrollEvent?.command.type != "startScroll" || runtime.scrollFinished) {
      if (pendingRewardTipCommand != undefined) {
        showRewardTip(pendingRewardTipCommand.amount);
      }
      setDisplayMineGridSnapshot(runtime.plan.stableTargetSnapshot);
      libs.batch(() => {
        setIsMineGridAnimating(false);
        setIsMineGridScrolling(false);
      });
      return false;
    }
    const preparedScrollSnapshot = cloneDigVeinsSnapshot(runtime.plan.targetSnapshot);
    preparedScrollSnapshot.depth = scrollEvent.command.fromDepth;
    setDisplayMineGridSnapshot(preparedScrollSnapshot, false);
    const scrollStartAt = MINE_GRID_TIMELINE_RENDER_BARRIER_DURATION;
    const scrollFinishAt = scrollStartAt + MINE_GRID_SCROLL_ANIMATION_DURATION;
    const finishFlowAt = scrollFinishAt + MINE_GRID_TIMELINE_RENDER_BARRIER_DURATION;
    const scrollOnlyEvents = [];
    let nextOrder = 0;
    if (pendingRewardTipCommand != undefined) {
      scrollOnlyEvents.push({
        at: 0,
        order: nextOrder++,
        command: pendingRewardTipCommand
      });
    }
    scrollOnlyEvents.push({
      at: scrollStartAt,
      order: nextOrder++,
      command: {
        type: "enableTransition"
      }
    }, {
      at: scrollStartAt,
      order: nextOrder++,
      command: scrollEvent.command
    }, {
      at: scrollFinishAt,
      order: nextOrder++,
      command: {
        type: "finishScroll"
      }
    }, {
      at: finishFlowAt,
      order: nextOrder++,
      command: {
        type: "enableTransition"
      }
    }, {
      at: finishFlowAt,
      order: nextOrder++,
      command: {
        type: "finishFlow"
      }
    });
    const scrollOnlyPlan = {
      context: runtime.plan.context,
      targetSnapshot: cloneDigVeinsSnapshot(runtime.plan.targetSnapshot),
      stableTargetSnapshot: cloneDigVeinsSnapshot(runtime.plan.stableTargetSnapshot),
      duration: finishFlowAt,
      events: scrollOnlyEvents
    };
    playMineGridTimeline(scrollOnlyPlan, true);
    return true;
  };
  const startMineGridPresentation = (context, responseSnapshot, specialRewardAmount) => {
    const currentParsedSnapshot = parsedMineGridSnapshot ?? parseDigVeinsSnapshot(miningActivityData()) ?? cloneDigVeinsSnapshot(responseSnapshot);
    if (parsedMineGridSnapshot == undefined) {
      parsedMineGridSnapshot = cloneDigVeinsSnapshot(currentParsedSnapshot);
    }
    if (displayMineGridSnapshot == undefined) {
      setDisplayMineGridSnapshot(currentParsedSnapshot);
    }
    const targetSnapshot = cloneDigVeinsSnapshot(responseSnapshot);
    const stableTargetSnapshot = getDigVeinsSnapshotWindow(targetSnapshot, getVisibleStartRow(targetSnapshot.depth), targetSnapshot.depth);
    const diff = getDigVeinsSnapshotDiff(currentParsedSnapshot, targetSnapshot);
    const timeline = DIG_VEINS_TOOL_TIMELINE_BUILDERS[context.tool](context, currentParsedSnapshot, targetSnapshot, diff);
    insertDigVeinsRewardTipTimelineEvent(timeline, specialRewardAmount);
    parsedMineGridSnapshot = stableTargetSnapshot;
    playMineGridTimeline(timeline);
  };
  libs.createEffect(() => {
    const netTableData = miningActivityData();
    if (!isMiningRequesting() && !isMineGridAnimating() && netTableData !== lastCalibratedMineGridNetData) {
      calibrateMineGridFromNetTable();
    }
  });
  libs.onMount(() => {
    equipTool("Pickaxe");
    const taskServerTimeTimer = setInterval(() => {
      setDigVeinsTaskServerTime(Math.floor(CustomUIConfig.GetServerTimeStamp()));
    }, 1000);
    const cursorTimer = setInterval(() => {
      updateCursorPosition();
    }, 10);
    libs.onCleanup(() => {
      isDisposed = true;
      clearInterval(taskServerTimeTimer);
      clearInterval(cursorTimer);
      cancelMineGridTimeline();
      cancelMineGridTransitionReset();
      hideRewardTip();
      clearMineGridToolEffects();
      destroyCursorPanel();
      clearFadingOutCells();
      clearMineGridSlots();
    });
  });
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
    id: "DigVeinsRoot",
    get children() {
      const _el$63 = libs.createElement("Panel", {
          id: "DigVeinsContainer",
          hittest: true
        }, null),
        _el$64 = libs.createElement("Panel", {
          id: "DigVeinsHeaderRight"
        }, _el$63),
        _el$69 = libs.createElement("Panel", {
          id: "DigVeinsDepthProgress"
        }, _el$63),
        _el$70 = libs.createElement("Panel", {
          id: "DigVeinsMainPage"
        }, _el$63),
        _el$71 = libs.createElement("Panel", {
          id: "DigVeinsTopContainer",
          hittest: false
        }, _el$70),
        _el$72 = libs.createElement("Image", {
          id: "DigVeinsTitleImage",
          get ["class"]() {
            return logoLang();
          }
        }, _el$71),
        _el$73 = libs.createElement("Panel", {
          id: "DigVeinsHeaderTime"
        }, _el$71);
        libs.createElement("Panel", {
          id: "DigVeinsHeaderTimeBG"
        }, _el$73);
        const _el$75 = libs.createElement("Panel", {
          id: "DigVeinsCoreContainer"
        }, _el$70);
        libs.createElement("Image", {
          id: "DigVeinsCoreBG"
        }, _el$75);
        const _el$77 = libs.createElement("Panel", {
          id: "DigVeinsMineGridViewport"
        }, _el$75),
        _el$78 = libs.createElement("Panel", {
          id: "DigVeinsMineGridCellContainer",
          get style() {
            return {
              transform: `translateY(${-mineGridScrollOffset()}px)`
            };
          }
        }, _el$77),
        _el$79 = libs.createElement("Panel", {
          id: "DigVeinsToolEffectLayer",
          hittest: false,
          hittestchildren: false
        }, _el$75),
        _el$80 = libs.createElement("Panel", {
          id: "DigVeinsToolSequenceFrameLayer",
          hittest: false,
          hittestchildren: false
        }, _el$75),
        _el$81 = libs.createElement("Panel", {
          id: "DigVeinsToolSequenceFrameAnchor",
          get style() {
            return getMineGridToolSequenceFrameAnchorStyle();
          },
          hittest: false,
          hittestchildren: false
        }, _el$80),
        _el$82 = libs.createElement("Panel", {
          id: "DigVeinsToolBar"
        }, _el$75),
        _el$83 = libs.createElement("Panel", {
          "class": "DigVeinsToolItem Bomb"
        }, _el$82),
        _el$88 = libs.createElement("Panel", {
          "class": "DigVeinsToolItem Pickaxe"
        }, _el$82),
        _el$93 = libs.createElement("Panel", {
          "class": "DigVeinsToolItem Drill"
        }, _el$82),
        _el$98 = libs.createElement("Panel", {
          id: "DigDepthLine"
        }, _el$75),
        _el$99 = libs.createElement("Label", {
          id: "DigDepthLineLabel",
          get text() {
            return LocalizeWithVars("#ActivityVeins_DepthLineValue", {
              depth: getDigVeinsDisplayDepth$1(mineGridBottomRow())
            });
          }
        }, _el$98);
        libs.createElement("Image", {
          id: "DigDepthLineIcon"
        }, _el$98);
        const _el$107 = libs.createElement("Panel", {
          id: "DigVeinsTaskPanel"
        }, _el$63);
        libs.createElement("Image", {
          id: "DigVeinsTaskPanelBG",
          hittest: false
        }, _el$107);
        const _el$109 = libs.createElement("Panel", {
          id: "DigVeinsTaskScrollContent",
          scroll: "y"
        }, _el$107);
      libs.insert(_el$64, libs.createComponent(EOM_Button.EOM_BaseButton, {
        "class": "DigVeinsHeaderButton DigVeinsHeaderRank",
        onactivate: () => JumpToMenu({
          window_name: "MenuButton_activity",
          menu: "mining",
          menu2: "veins_rank",
          force: true
        }),
        get children() {
          return [libs.createElement("Image", {
            "class": "DigVeinsHeaderButtonIcon"
          }, null), (() => {
            const _el$66 = libs.createElement("Label", {
              get text() {
                return GetLocalization("#ActivityVeins_HeaderRank");
              }
            }, null);
            libs.effect(_$p => libs.setProp(_el$66, "text", GetLocalization("#ActivityVeins_HeaderRank"), _$p));
            return _el$66;
          })()];
        }
      }), null);
      libs.insert(_el$64, libs.createComponent(EOM_Button.EOM_BaseButton, {
        "class": "DigVeinsHeaderButton DigVeinsHeaderRule",
        get customTooltip() {
          return ruleTooltip();
        },
        get children() {
          return [libs.createElement("Image", {
            "class": "DigVeinsHeaderButtonIcon"
          }, null), (() => {
            const _el$68 = libs.createElement("Label", {
              get text() {
                return GetLocalization("#ActivityVeins_HeaderRule");
              }
            }, null);
            libs.effect(_$p => libs.setProp(_el$68, "text", GetLocalization("#ActivityVeins_HeaderRule"), _$p));
            return _el$68;
          })()];
        }
      }), null);
      libs.insert(_el$69, libs.createComponent(DigVeinsDepthProgress, {
        get depth() {
          return mineGridBottomRow();
        },
        get ready() {
          return mineGridReady();
        },
        get receivedRewardIDs() {
          return receivedMiningRewardIDs();
        },
        onReceiveReward: receiveDepthReward,
        get animated() {
          return !mineGridTransitionDisabled();
        }
      }));
      libs.insert(_el$73, libs.createComponent(EOM_Countdown.EOM_Countdown, {
        icon: true,
        text: "#ActivityDice_TimeLimit",
        get endTime() {
          return activityData().end_time;
        }
      }), null);
      libs.use(panel => mineGridViewportPanel = panel, _el$77);
      libs.insert(_el$78, libs.createComponent(libs.For, {
        get each() {
          return mineGridRowKeys();
        },
        children: row => (() => {
          const _el$110 = libs.createElement("Panel", {
            "class": "DigVeinsMineGridRow"
          }, null);
          libs.insert(_el$110, libs.createComponent(libs.For, {
            get each() {
              return mineGridRowCellKeys[row] ?? [];
            },
            children: key => {
              const index = getMineGridCellIndexFromKey(key);
              return libs.createComponent(DigVeinsMineGridCell, {
                index: index,
                get durability() {
                  return getMineGridSlotDurability(index);
                },
                get ["class"]() {
                  return getMineGridCellClass(index);
                },
                get fadingOut() {
                  return isMineGridCellFadingOut(index);
                },
                get disabled() {
                  return isMineGridInteractionLocked() || !isLogicalMineGridSlotClickable(index);
                },
                get tool() {
                  return equippedTool();
                },
                get tooltipDescription() {
                  return libs.memo(() => getMineGridSlot(index)?.type == "chest")() ? GetLocalization("#ActivityVeins_ChestSlotDesc") : undefined;
                },
                get tooltipRewards() {
                  return getMineGridTooltipRewards(index);
                },
                oncellmouseover: handleCellMouseOver,
                oncellmouseout: handleCellMouseOut,
                oncellactivate: handleCellActivate
              });
            }
          }));
          return _el$110;
        })()
      }));
      libs.insert(_el$77, libs.createComponent(libs.Show, {
        get when() {
          return canShowToolRangePreview();
        },
        get children() {
          return libs.createComponent(DigVeinsToolRangePreview, {
            get tool() {
              return equippedTool();
            },
            get cellIndex() {
              return hoveredCellIndex();
            },
            get visibleStartRow() {
              return getVisibleStartRow(mineGridBottomRow());
            }
          });
        }
      }), null);
      libs.insert(_el$79, libs.createComponent(libs.For, {
        get each() {
          return activeMineGridToolEffects();
        },
        children: effect => [libs.createComponent(libs.Show, {
          get when() {
            return effect.tool == "Pickaxe";
          },
          get children() {
            const _el$111 = libs.createElement("Panel", {
                "class": "DigVeinsToolEffectAnchor Pickaxe",
                get style() {
                  return getMineGridToolEffectAnchorStyle(effect);
                },
                hittest: false,
                hittestchildren: false
              }, null);
              libs.createElement("DOTAParticleScenePanel", {
                "class": "DigVeinsToolEffectParticle Pickaxe",
                particleName: "particles/ui/game/ui_game_m4_broken_fx.vpcf",
                cameraOrigin: "0 0 320",
                lookAt: "0 0 0",
                fov: 90,
                hittest: false,
                squarePixels: true
              }, _el$111);
            libs.effect(_$p => libs.setProp(_el$111, "style", getMineGridToolEffectAnchorStyle(effect), _$p));
            return _el$111;
          }
        }), libs.createComponent(libs.Show, {
          get when() {
            return effect.tool == "Drill";
          },
          get children() {
            const _el$113 = libs.createElement("Panel", {
                "class": "DigVeinsToolEffectAnchor Drill",
                get style() {
                  return getMineGridToolEffectAnchorStyle(effect);
                },
                hittest: false,
                hittestchildren: false
              }, null);
              libs.createElement("DOTAParticleScenePanel", {
                "class": "DigVeinsToolEffectParticle Drill",
                particleName: "particles/ui/game/ui_game_m4_drill_fx.vpcf",
                cameraOrigin: "0 0 320",
                lookAt: "0 0 0",
                fov: 90,
                hittest: false,
                squarePixels: true
              }, _el$113);
            libs.effect(_$p => libs.setProp(_el$113, "style", getMineGridToolEffectAnchorStyle(effect), _$p));
            return _el$113;
          }
        }), libs.createComponent(libs.Show, {
          get when() {
            return effect.tool == "Bomb";
          },
          get children() {
            const _el$115 = libs.createElement("Panel", {
                "class": "DigVeinsToolEffectAnchor Bomb",
                get style() {
                  return getMineGridToolEffectAnchorStyle(effect);
                },
                hittest: false,
                hittestchildren: false
              }, null);
              libs.createElement("DOTAParticleScenePanel", {
                "class": "DigVeinsToolEffectParticle Bomb",
                particleName: "particles/ui/game/ui_game_m4_bomb_fx.vpcf",
                cameraOrigin: "0 0 320",
                lookAt: "0 0 0",
                fov: 90,
                hittest: false,
                squarePixels: true
              }, _el$115);
            libs.effect(_$p => libs.setProp(_el$115, "style", getMineGridToolEffectAnchorStyle(effect), _$p));
            return _el$115;
          }
        })]
      }));
      libs.insert(_el$81, libs.createComponent(PickaxeSequenceFrame, {
        "class": "DigVeinsToolSequenceFrame PickaxeFrame",
        get visible() {
          return libs.memo(() => !!(isMineGridToolSequenceFrameVisible() && activeMineGridToolSequenceFrame().tool == "Pickaxe"))() && !pickaxeSequence.isFinished();
        }
      }), null);
      libs.insert(_el$81, libs.createComponent(BombSequenceFrame, {
        "class": "DigVeinsToolSequenceFrame BombFrame",
        get visible() {
          return libs.memo(() => !!(isMineGridToolSequenceFrameVisible() && activeMineGridToolSequenceFrame().tool == "Bomb"))() && !bombSequence.isFinished();
        }
      }), null);
      libs.insert(_el$81, libs.createComponent(DrillSequenceFrame, {
        "class": "DigVeinsToolSequenceFrame DrillFrame",
        get visible() {
          return libs.memo(() => !!(isMineGridToolSequenceFrameVisible() && activeMineGridToolSequenceFrame().tool == "Drill"))() && !drillSequence.isFinished();
        }
      }), null);
      libs.insert(_el$83, libs.createComponent(EOM_Button.EOM_BaseButton, {
        get ["class"]() {
          return libs.classNames("DigVeinsToolButton", "Bomb", {
            Selected: equippedTool() === "Bomb"
          });
        },
        get enabled() {
          return canActivateToolButton("Bomb");
        },
        onactivate: () => equipTool("Bomb"),
        get children() {
          return [libs.createElement("Image", {
            "class": "DigVeinsToolButtonIcon",
            hittest: false
          }, null), (() => {
            const _el$85 = libs.createElement("Panel", {
                "class": "DigVeinsToolItemAmount"
              }, null),
              _el$86 = libs.createElement("Label", {
                "class": "DigVeinsToolItemAmountValue",
                get text() {
                  return bombAmount();
                }
              }, _el$85);
            libs.effect(_$p => libs.setProp(_el$86, "text", bombAmount(), _$p));
            return _el$85;
          })()];
        }
      }), null);
      libs.insert(_el$83, libs.createComponent(EOM_Button.EOM_BaseButton, {
        "class": "DigVeinsToolOption DigVeinsToolOptionAdd",
        onactivate: openVeinsGift,
        get children() {
          return libs.createElement("Image", {
            "class": "DigVeinsToolOptionIcon",
            hittest: false
          }, null);
        }
      }), null);
      libs.insert(_el$88, libs.createComponent(EOM_Button.EOM_BaseButton, {
        get ["class"]() {
          return libs.classNames("DigVeinsToolButton", "Pickaxe", {
            Selected: equippedTool() === "Pickaxe"
          });
        },
        get enabled() {
          return canActivateToolButton("Pickaxe");
        },
        onactivate: () => equipTool("Pickaxe"),
        get children() {
          return [libs.createElement("Image", {
            "class": "DigVeinsToolButtonIcon",
            hittest: false
          }, null), (() => {
            const _el$90 = libs.createElement("Panel", {
                "class": "DigVeinsToolItemAmount"
              }, null),
              _el$91 = libs.createElement("Label", {
                "class": "DigVeinsToolItemAmountValue",
                get text() {
                  return pickaxeAmount();
                }
              }, _el$90);
            libs.effect(_$p => libs.setProp(_el$91, "text", pickaxeAmount(), _$p));
            return _el$90;
          })()];
        }
      }), null);
      libs.insert(_el$88, libs.createComponent(EOM_Button.EOM_BaseButton, {
        "class": "DigVeinsToolOption DigVeinsToolOptionAdd",
        onactivate: () => purchaseVeinsTool(DIG_VEINS_PICKAXE_PRODUCT_ID),
        get children() {
          return libs.createElement("Image", {
            "class": "DigVeinsToolOptionIcon",
            hittest: false
          }, null);
        }
      }), null);
      libs.insert(_el$93, libs.createComponent(EOM_Button.EOM_BaseButton, {
        get ["class"]() {
          return libs.classNames("DigVeinsToolButton", "Drill", {
            Selected: equippedTool() === "Drill"
          });
        },
        get enabled() {
          return canActivateToolButton("Drill");
        },
        onactivate: () => equipTool("Drill"),
        get children() {
          return [libs.createElement("Image", {
            "class": "DigVeinsToolButtonIcon",
            hittest: false
          }, null), (() => {
            const _el$95 = libs.createElement("Panel", {
                "class": "DigVeinsToolItemAmount"
              }, null),
              _el$96 = libs.createElement("Label", {
                "class": "DigVeinsToolItemAmountValue",
                get text() {
                  return drillAmount();
                }
              }, _el$95);
            libs.effect(_$p => libs.setProp(_el$96, "text", drillAmount(), _$p));
            return _el$95;
          })()];
        }
      }), null);
      libs.insert(_el$93, libs.createComponent(EOM_Button.EOM_BaseButton, {
        "class": "DigVeinsToolOption DigVeinsToolOptionAdd",
        onactivate: () => purchaseVeinsTool(DIG_VEINS_DRILL_PRODUCT_ID),
        get children() {
          return libs.createElement("Image", {
            "class": "DigVeinsToolOptionIcon",
            hittest: false
          }, null);
        }
      }), null);
      libs.insert(_el$75, libs.createComponent(libs.Show, {
        get when() {
          return isRewardTipVisible();
        },
        get children() {
          const _el$101 = libs.createElement("Panel", {
              id: "DigRewardTipWindow",
              hittest: true,
              hittestchildren: false
            }, null),
            _el$102 = libs.createElement("Panel", {
              id: "DigRewardTipContent",
              "class": "TooltipContent",
              hittest: false,
              hittestchildren: false
            }, _el$101),
            _el$103 = libs.createElement("Label", {
              id: "DigRewardTipTitle",
              get text() {
                return GetLocalization("#ActivityVeins_SpecialRewardTitle");
              }
            }, _el$102),
            _el$104 = libs.createElement("Panel", {
              id: "DigRewardTipItemImageContainer"
            }, _el$102),
            _el$105 = libs.createElement("Label", {
              id: "DigRewardTipItemInfo",
              get text() {
                return `${GetLocalization(`#${DIG_VEINS_SPECIAL_REWARD_ITEM_ID}`)}x${rewardTipAmount()}`;
              }
            }, _el$102),
            _el$106 = libs.createElement("Label", {
              id: "DigRewardTipSkipTips",
              get text() {
                return GetLocalization("#ActivityVeins_SpecialRewardSkipTips");
              }
            }, _el$102);
          libs.setProp(_el$101, "onactivate", hideRewardTip);
          libs.insert(_el$104, libs.createComponent(StoreItem.StoreItemImage, {
            id: "DigRewardTipItemImage",
            itemid: DIG_VEINS_SPECIAL_REWARD_ITEM_ID,
            hideTips: true
          }));
          libs.effect(_p$ => {
            const _v$22 = GetLocalization("#ActivityVeins_SpecialRewardTitle"),
              _v$23 = `${GetLocalization(`#${DIG_VEINS_SPECIAL_REWARD_ITEM_ID}`)}x${rewardTipAmount()}`,
              _v$24 = GetLocalization("#ActivityVeins_SpecialRewardSkipTips");
            _v$22 !== _p$._v$22 && (_p$._v$22 = libs.setProp(_el$103, "text", _v$22, _p$._v$22));
            _v$23 !== _p$._v$23 && (_p$._v$23 = libs.setProp(_el$105, "text", _v$23, _p$._v$23));
            _v$24 !== _p$._v$24 && (_p$._v$24 = libs.setProp(_el$106, "text", _v$24, _p$._v$24));
            return _p$;
          }, {
            _v$22: undefined,
            _v$23: undefined,
            _v$24: undefined
          });
          return _el$101;
        }
      }), null);
      libs.setProp(_el$109, "scroll", "y");
      libs.insert(_el$109, libs.createComponent(libs.Show, {
        get when() {
          return shouldShowDigVeinsTaskGroup(7, digVeinsTasksByType()[7]);
        },
        get children() {
          return libs.createComponent(DigVeinsTaskGroup, {
            taskType: 7,
            get tasks() {
              return digVeinsTasksByType()[7];
            },
            get claimingTaskKey() {
              return claimingTaskKey();
            },
            onClaim: receiveTaskReward
          });
        }
      }), null);
      libs.insert(_el$109, libs.createComponent(libs.Show, {
        get when() {
          return shouldShowDigVeinsTaskGroup(6, digVeinsTasksByType()[6]);
        },
        get children() {
          return libs.createComponent(DigVeinsTaskGroup, {
            taskType: 6,
            get tasks() {
              return digVeinsTasksByType()[6];
            },
            get claimingTaskKey() {
              return claimingTaskKey();
            },
            onClaim: receiveTaskReward
          });
        }
      }), null);
      libs.effect(_p$ => {
        const _v$25 = logoLang(),
          _v$26 = {
            NoTransition: mineGridTransitionDisabled()
          },
          _v$27 = {
            transform: `translateY(${-mineGridScrollOffset()}px)`
          },
          _v$28 = {
            Moving: isMineGridToolSequenceFrameMoving()
          },
          _v$29 = isMineGridToolSequenceFrameVisible(),
          _v$30 = getMineGridToolSequenceFrameAnchorStyle(),
          _v$31 = LocalizeWithVars("#ActivityVeins_DepthLineValue", {
            depth: getDigVeinsDisplayDepth$1(mineGridBottomRow())
          });
        _v$25 !== _p$._v$25 && (_p$._v$25 = libs.setProp(_el$72, "class", _v$25, _p$._v$25));
        _v$26 !== _p$._v$26 && (_p$._v$26 = libs.setProp(_el$78, "classList", _v$26, _p$._v$26));
        _v$27 !== _p$._v$27 && (_p$._v$27 = libs.setProp(_el$78, "style", _v$27, _p$._v$27));
        _v$28 !== _p$._v$28 && (_p$._v$28 = libs.setProp(_el$81, "classList", _v$28, _p$._v$28));
        _v$29 !== _p$._v$29 && (_p$._v$29 = libs.setProp(_el$81, "visible", _v$29, _p$._v$29));
        _v$30 !== _p$._v$30 && (_p$._v$30 = libs.setProp(_el$81, "style", _v$30, _p$._v$30));
        _v$31 !== _p$._v$31 && (_p$._v$31 = libs.setProp(_el$99, "text", _v$31, _p$._v$31));
        return _p$;
      }, {
        _v$25: undefined,
        _v$26: undefined,
        _v$27: undefined,
        _v$28: undefined,
        _v$29: undefined,
        _v$30: undefined,
        _v$31: undefined
      });
      return _el$63;
    }
  });
}

const ACTIVITY_VEINS_ID$1 = 1001;
function getVeinsStoreItems$1(infoProducts) {
  const result = [];
  const now = Date.now() / 1000;
  for (const itemname in KeyValues.info_shop_product) {
    const itemdata = KeyValues.info_shop_product[itemname];
    const info_product = infoProducts[itemdata.id];
    const effective_start_time = info_product ? info_product.start_time : itemdata.start_time;
    const effective_end_time = info_product ? info_product.end_time : itemdata.end_time;
    if ((effective_start_time < now || effective_start_time == 0) && (effective_end_time > now || effective_end_time == 0) && (itemdata.hide_time > now || !itemdata.hide_time) && itemdata.hide == 0 || itemdata.tag == "Privilege") {
      const tags = itemdata.tag.split("|");
      if (tags.includes("MiningGift")) {
        result.push(itemdata);
      }
    }
  }
  result.sort((a, b) => b.orderby - a.orderby);
  return result;
}
function VeinsGift() {
  const activityData = libs.createMemo(() => KeyValues.activity_data[ACTIVITY_VEINS_ID$1]);
  const logoLang = libs.createMemo(() => {
    const lang = Language();
    if (lang == "schinese") {
      return "Language_schinese";
    } else if (lang == "russian") {
      return "Language_russian";
    } else {
      return "Language_english";
    }
  });
  const infoProducts = solid_utils.createGlobalServiceNetData("info_products", {});
  const purchasedProduct = solid_utils.createServiceNetData("player_shop_product_limits", {});
  const storeItems = libs.createMemo(() => getVeinsStoreItems$1(infoProducts()));
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
    id: "VeinsGift",
    "class": "VeinsStoreGift",
    shadow_border: true,
    get children() {
      return [(() => {
        const _el$ = libs.createElement("Panel", {
            id: "VeinsGiftTitleContent"
          }, null),
          _el$2 = libs.createElement("Panel", {
            id: "VeinsGiftTitleTop"
          }, _el$),
          _el$3 = libs.createElement("Image", {
            id: "VeinsGiftTitleIcon",
            get ["class"]() {
              return logoLang();
            }
          }, _el$2),
          _el$4 = libs.createElement("Image", {
            get ["class"]() {
              return libs.classNames("VeinsStoreGiftTitleTooltipIcon", logoLang());
            }
          }, _el$2),
          _el$5 = libs.createElement("Panel", {
            id: "VeinsGiftTitleTime",
            "class": "VeinsStoreGiftTitleTime"
          }, _el$);
          libs.createElement("Image", {
            id: "VeinsTopSubTitleBG",
            "class": "VeinsStoreGiftTitleTimeBG"
          }, _el$5);
        libs.insert(_el$5, libs.createComponent(EOM_Countdown.EOM_Countdown, {
          icon: true,
          text: "#ActivityVeins_VeinsGift_TimeLimit",
          get endTime() {
            return activityData().end_time;
          }
        }), null);
        libs.effect(_p$ => {
          const _v$ = logoLang(),
            _v$2 = libs.classNames("VeinsStoreGiftTitleTooltipIcon", logoLang()),
            _v$3 = GetLocalization("#ActivityVeins_VeinsGift_TimeTooltip");
          _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$3, "class", _v$, _p$._v$));
          _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$4, "class", _v$2, _p$._v$2));
          _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$4, "tooltip_text", _v$3, _p$._v$3));
          return _p$;
        }, {
          _v$: undefined,
          _v$2: undefined,
          _v$3: undefined
        });
        return _el$;
      })(), (() => {
        const _el$7 = libs.createElement("Panel", {
          id: "VeinsGiftList",
          "class": "VerticalScrollStyle VeinsStoreGiftList",
          scroll: "y"
        }, null);
        libs.setProp(_el$7, "scroll", "y");
        libs.insert(_el$7, libs.createComponent(libs.Index, {
          get each() {
            return storeItems();
          },
          children: data => {
            return libs.createComponent(StoreItem.StoreItem, {
              get itemid() {
                return data().id;
              },
              get purchased_num() {
                return purchasedProduct()[data().id];
              },
              endTime: 0
            });
          }
        }));
        return _el$7;
      })()];
    }
  });
}

const PAGE_SIZE = 10;
const MAX_PAGE = 10;
const DEFAULT_AVATAR_BORDER_ID = "1710000";
const LEADERBOARD_TYPE = "activity_score";
const LEADERBOARD_EXTRA_KEY = "1001";
const MIN_REQUEST_INTERVAL_MS = 30 * 1000;
const DIG_VEINS_DEPTH_DISPLAY_SCALE = 5;
const VEINS_RANK_REWARD_TITLE_ID = "1711003";
const getDigVeinsDisplayDepth = depth => depth * DIG_VEINS_DEPTH_DISPLAY_SCALE;
const leaderboardCache = CustomUIConfig.__veinsLeaderboardCache ??= {};
const lastRequestTimes = {};
function getLeaderboardPageKey(page) {
  return `${LEADERBOARD_TYPE}:${LEADERBOARD_EXTRA_KEY}:page:${page}`;
}
function safeParseTeamExtraData(data) {
  if (data == undefined || data == "") {
    return {};
  }
  const result = JSON.parseSafe(data);
  if (result == undefined || typeof result != "object") {
    return {};
  }
  return result;
}
function normalizeRankData(data) {
  const accountID = toString(data.team_id) ?? "";
  const playerExtraData = data.player_extra_data?.[accountID]?.extra_data;
  const teamExtraData = safeParseTeamExtraData(data.team_extra_data);
  const score = toFiniteNumber(teamExtraData.score, NaN);
  const borderID = playerExtraData?.border;
  return {
    accountID,
    rank: toFiniteNumber(data.rank, 0),
    score: isFinite(score) ? score : undefined,
    borderID: borderID == undefined || borderID == "" || borderID == "0" ? DEFAULT_AVATAR_BORDER_ID : borderID,
    titleID: playerExtraData?.title ?? "",
    invalidAvatar: playerExtraData?.invalid_avatar == "1",
    invalidName: playerExtraData?.invalid_name == "1"
  };
}
function openPlayerInfo(player) {
  if (player.accountID == "" || player.invalidName) {
    return;
  }
  JumpToMenu({
    window_name: "book",
    menu: "PlayerInfo_Menu",
    force: true,
    data: {
      steamID: player.accountID
    }
  });
}
function PlayerAvatar(props) {
  const avatarAccountID = () => props.player.invalidAvatar || props.player.accountID == "" ? "0" : props.player.accountID;
  const playerInfoTooltip = () => avatarAccountID() == "0" || props.player.invalidName ? undefined : {
    name: "player_info",
    steam_id: props.player.accountID
  };
  return (() => {
    const _el$ = libs.createElement("Panel", {
      "class": "PlayerAvatar"
    }, null);
    libs.insert(_el$, libs.createComponent(Player.AvatarBorder, {
      get borderid() {
        return props.player.borderID;
      },
      get children() {
        return [libs.createComponent(Player.EOM_Avatar, {
          "class": "Avatar",
          get accountid() {
            return avatarAccountID();
          }
        }), (() => {
          const _el$2 = libs.createElement("Panel", {
            "class": "TipsArea"
          }, null);
          libs.setProp(_el$2, "onactivate", () => openPlayerInfo(props.player));
          libs.effect(_$p => libs.setProp(_el$2, "customTooltip", playerInfoTooltip(), _$p));
          return _el$2;
        })()];
      }
    }));
    return _el$;
  })();
}
function PlayerDisplayName(props) {
  if (props.player.accountID == "") {
    return (() => {
      const _el$3 = libs.createElement("Label", {
        get ["class"]() {
          return props.class;
        },
        text: "-"
      }, null);
      libs.effect(_$p => libs.setProp(_el$3, "class", props.class, _$p));
      return _el$3;
    })();
  }
  if (props.player.invalidName) {
    return (() => {
      const _el$4 = libs.createElement("Label", {
        get ["class"]() {
          return props.class;
        },
        get text() {
          return GetLocalization("#Rank_AnonymousPlayer");
        }
      }, null);
      libs.effect(_p$ => {
        const _v$ = props.class,
          _v$2 = GetLocalization("#Rank_AnonymousPlayer");
        _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$4, "class", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$4, "text", _v$2, _p$._v$2));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined
      });
      return _el$4;
    })();
  }
  return libs.createComponent(Player.PlayerName, {
    get ["class"]() {
      return props.class;
    },
    get accountid() {
      return props.player.accountID;
    }
  });
}
function VeinsRankTopItem(props) {
  return (() => {
    const _el$5 = libs.createElement("Panel", {}, null);
      libs.createElement("Panel", {
        "class": "VeinsRankTopItemBG"
      }, _el$5);
      const _el$7 = libs.createElement("Panel", {
        "class": "VeinsRankTopItemContent"
      }, _el$5);
    libs.insert(_el$7, libs.createComponent(libs.Show, {
      get when() {
        return props.player;
      },
      keyed: true,
      get fallback() {
        return [libs.createElement("Panel", {
          "class": "VeinsRankTitleContainer"
        }, null), libs.createElement("Panel", {
          "class": "VeinsRankAvatarContainer"
        }, null), (() => {
          const _el$0 = libs.createElement("Panel", {
              "class": "VeinsRankNameContainer"
            }, null),
            _el$1 = libs.createElement("Label", {
              "class": "VeinsRankEmptyName",
              get text() {
                return GetLocalization("#EmptyRankName");
              }
            }, _el$0);
          libs.effect(_$p => libs.setProp(_el$1, "text", GetLocalization("#EmptyRankName"), _$p));
          return _el$0;
        })()];
      },
      children: player => [(() => {
        const _el$10 = libs.createElement("Panel", {
          "class": "VeinsRankTitleContainer"
        }, null);
        libs.insert(_el$10, libs.createComponent(libs.Show, {
          get when() {
            return player.titleID != "";
          },
          get children() {
            return libs.createComponent(Player.PlayerTitle, {
              "class": "VeinsRankPlayerTitle",
              get titleid() {
                return player.titleID;
              }
            });
          }
        }));
        return _el$10;
      })(), (() => {
        const _el$11 = libs.createElement("Panel", {
          "class": "VeinsRankAvatarContainer"
        }, null);
        libs.insert(_el$11, libs.createComponent(PlayerAvatar, {
          player: player
        }));
        return _el$11;
      })(), (() => {
        const _el$12 = libs.createElement("Panel", {
          "class": "VeinsRankNameContainer"
        }, null);
        libs.insert(_el$12, libs.createComponent(PlayerDisplayName, {
          "class": "VeinsRankPlayerName",
          player: player
        }));
        return _el$12;
      })()]
    }));
    libs.effect(_$p => libs.setProp(_el$5, "className", libs.classNames("VeinsRankTopItem", `Rank${props.rank}`), _$p));
    return _el$5;
  })();
}
function VeinsRankTop(props) {
  return (() => {
    const _el$13 = libs.createElement("Panel", {
      id: "VeinsRankTop"
    }, null);
    libs.insert(_el$13, libs.createComponent(VeinsRankTopItem, {
      rank: 2,
      get player() {
        return props.players[1];
      }
    }), null);
    libs.insert(_el$13, libs.createComponent(VeinsRankTopItem, {
      rank: 1,
      get player() {
        return props.players[0];
      }
    }), null);
    libs.insert(_el$13, libs.createComponent(VeinsRankTopItem, {
      rank: 3,
      get player() {
        return props.players[2];
      }
    }), null);
    return _el$13;
  })();
}
function VeinsRankHeader() {
  return (() => {
    const _el$14 = libs.createElement("Panel", {
        "class": "VeinsRankHeader VeinsRankRowContent"
      }, null),
      _el$15 = libs.createElement("Panel", {
        "class": "VeinsRankHeaderCol RankNumber"
      }, _el$14),
      _el$16 = libs.createElement("Label", {
        get text() {
          return GetLocalization("#ActivityVeins_VeinsRank_RankValue");
        }
      }, _el$15),
      _el$17 = libs.createElement("Panel", {
        "class": "VeinsRankHeaderCol RankPlayer"
      }, _el$14),
      _el$18 = libs.createElement("Label", {
        get text() {
          return GetLocalization("#ActivityVeins_VeinsRank_PlayerInfo");
        }
      }, _el$17),
      _el$19 = libs.createElement("Panel", {
        "class": "VeinsRankHeaderCol RankScore"
      }, _el$14),
      _el$20 = libs.createElement("Label", {
        get text() {
          return GetLocalization("#ActivityVeins_VeinsRank_DepthScore");
        }
      }, _el$19);
    libs.effect(_p$ => {
      const _v$3 = GetLocalization("#ActivityVeins_VeinsRank_RankValue"),
        _v$4 = GetLocalization("#ActivityVeins_VeinsRank_PlayerInfo"),
        _v$5 = GetLocalization("#ActivityVeins_VeinsRank_DepthScore");
      _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$16, "text", _v$3, _p$._v$3));
      _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$18, "text", _v$4, _p$._v$4));
      _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$20, "text", _v$5, _p$._v$5));
      return _p$;
    }, {
      _v$3: undefined,
      _v$4: undefined,
      _v$5: undefined
    });
    return _el$14;
  })();
}
function VeinsRanksRow(props) {
  return (() => {
    const _el$21 = libs.createElement("Panel", {
        get id() {
          return props.id;
        },
        "class": "VeinsRanksRow"
      }, null);
      libs.createElement("Image", {
        "class": "VeinsRankRowBG"
      }, _el$21);
      const _el$23 = libs.createElement("Panel", {
        "class": "VeinsRankRowContent"
      }, _el$21),
      _el$24 = libs.createElement("Panel", {
        "class": "VeinsRankRowCol RankNumber"
      }, _el$23),
      _el$25 = libs.createElement("Panel", {
        "class": "VeinsRankRowRank"
      }, _el$24),
      _el$27 = libs.createElement("Panel", {
        "class": "VeinsRankRowCol RankPlayer"
      }, _el$23),
      _el$28 = libs.createElement("Panel", {
        "class": "VeinsRankPlayerAvatar"
      }, _el$27),
      _el$29 = libs.createElement("Panel", {
        "class": "VeinsRankRowCol RankScore"
      }, _el$23),
      _el$30 = libs.createElement("Label", {
        "class": "VeinsRankScoreValue",
        get text() {
          return libs.memo(() => !!props.rankData.score)() ? `${getDigVeinsDisplayDepth(props.rankData.score)}M` : "-";
        }
      }, _el$29);
    libs.insert(_el$25, libs.createComponent(libs.Show, {
      get when() {
        return props.rankData.rank >= 1 && props.rankData.rank <= 3;
      },
      get fallback() {
        return [libs.createElement("Image", {
          "class": "VeinsRankRankBG"
        }, null), (() => {
          const _el$32 = libs.createElement("Label", {
            "class": "VeinsRankRankValue",
            get text() {
              return props.rankData.rank > 0 ? props.rankData.rank : "-";
            }
          }, null);
          libs.effect(_$p => libs.setProp(_el$32, "text", props.rankData.rank > 0 ? props.rankData.rank : "-", _$p));
          return _el$32;
        })()];
      },
      get children() {
        const _el$26 = libs.createElement("Image", {
          get ["class"]() {
            return libs.classNames("VeinsRankRankIcon", `VeinsRankIcon_${props.rankData.rank}`);
          }
        }, null);
        libs.effect(_$p => libs.setProp(_el$26, "class", libs.classNames("VeinsRankRankIcon", `VeinsRankIcon_${props.rankData.rank}`), _$p));
        return _el$26;
      }
    }));
    libs.insert(_el$28, libs.createComponent(PlayerAvatar, {
      get player() {
        return props.rankData;
      }
    }), null);
    libs.insert(_el$28, libs.createComponent(PlayerDisplayName, {
      "class": "VeinsRankPlayerName",
      get player() {
        return props.rankData;
      }
    }), null);
    libs.effect(_p$ => {
      const _v$6 = props.id,
        _v$7 = libs.memo(() => !!props.rankData.score)() ? `${getDigVeinsDisplayDepth(props.rankData.score)}M` : "-";
      _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$21, "id", _v$6, _p$._v$6));
      _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$30, "text", _v$7, _p$._v$7));
      return _p$;
    }, {
      _v$6: undefined,
      _v$7: undefined
    });
    return _el$21;
  })();
}
function VeinsRankTable(props) {
  return (() => {
    const _el$33 = libs.createElement("Panel", {
        id: "VeinsRankTable"
      }, null);
      libs.createElement("Panel", {
        "class": "VeinsRankTableBG"
      }, _el$33);
      const _el$35 = libs.createElement("Panel", {
        "class": "VeinsRankTableContent"
      }, _el$33),
      _el$36 = libs.createElement("Panel", {
        "class": "VeinsRankListViewport"
      }, _el$35),
      _el$37 = libs.createElement("Panel", {
        "class": "VeinsRankList VerticalScrollStyle",
        flowChildren: "down",
        scroll: "y"
      }, _el$36);
    libs.insert(_el$35, libs.createComponent(VeinsRankHeader, {}), _el$36);
    libs.setProp(_el$37, "flowChildren", "down");
    libs.setProp(_el$37, "scroll", "y");
    libs.insert(_el$37, libs.createComponent(libs.Show, {
      get when() {
        return props.ranks.length > 0;
      },
      get fallback() {
        return libs.createComponent(libs.Show, {
          get when() {
            return !props.loading;
          },
          get children() {
            const _el$38 = libs.createElement("Panel", {
                id: "VeinsRankEmpty"
              }, null),
              _el$39 = libs.createElement("Label", {
                get text() {
                  return GetLocalization("#Rank_Empty");
                }
              }, _el$38);
            libs.effect(_$p => libs.setProp(_el$39, "text", GetLocalization("#Rank_Empty"), _$p));
            return _el$38;
          }
        });
      },
      get children() {
        return libs.createComponent(libs.For, {
          get each() {
            return props.ranks;
          },
          children: rankData => libs.createComponent(VeinsRanksRow, {
            rankData: rankData
          })
        });
      }
    }));
    libs.insert(_el$35, libs.createComponent(libs.Show, {
      get when() {
        return props.selfRank;
      },
      keyed: true,
      children: selfRank => libs.createComponent(VeinsRanksRow, {
        id: "VeinsRankRowSelf",
        rankData: selfRank
      })
    }), null);
    return _el$33;
  })();
}
function VeinsRankPagination(props) {
  return (() => {
    const _el$40 = libs.createElement("Panel", {
        id: "VeinsRankPagination"
      }, null),
      _el$41 = libs.createElement("Panel", {
        "class": "VeinsRankPageContainer"
      }, _el$40);
    libs.insert(_el$40, libs.createComponent(EOM_Button.EOM_BaseButton, {
      get enabled() {
        return props.page > 1;
      },
      onactivate: () => props.setPage(props.page - 1),
      "class": "VeinsRankPageArrow PageLeft"
    }), _el$41);
    libs.insert(_el$41, libs.createComponent(libs.For, {
      each: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
      children: page => libs.createComponent(EOM_Button.EOM_BaseButton, {
        onactivate: () => props.setPage(page),
        get className() {
          return libs.classNames("VeinsRankPageButton", {
            Selected: props.page == page
          });
        },
        get children() {
          const _el$42 = libs.createElement("Label", {
            text: page
          }, null);
          libs.setProp(_el$42, "text", page);
          return _el$42;
        }
      })
    }));
    libs.insert(_el$40, libs.createComponent(EOM_Button.EOM_BaseButton, {
      get enabled() {
        return props.page < MAX_PAGE;
      },
      onactivate: () => props.setPage(props.page + 1),
      "class": "VeinsRankPageArrow PageRight"
    }), null);
    return _el$40;
  })();
}
function VeinsRank() {
  const [page, setPage] = libs.createSignal(1);
  const [loading, setLoading] = libs.createSignal(false);
  const [rankDataCache, setRankDataCache] = libs.createSignal({});
  const getCachedRankData = pageKey => rankDataCache()[pageKey] ?? leaderboardCache[pageKey]?.data;
  const currentPageKey = libs.createMemo(() => getLeaderboardPageKey(page()));
  const currentPageData = libs.createMemo(() => getCachedRankData(currentPageKey()));
  const firstPageData = libs.createMemo(() => getCachedRankData(getLeaderboardPageKey(1)));
  const displayRanks = libs.createMemo(() => (currentPageData()?.leaderboard ?? []).map(normalizeRankData));
  const topRanks = libs.createMemo(() => (firstPageData()?.leaderboard ?? []).slice(0, 3).map(normalizeRankData));
  const displaySelfRank = libs.createMemo(() => {
    const data = firstPageData()?.selfRank;
    return data == undefined ? undefined : normalizeRankData(data);
  });
  let disposed = false;
  let pendingRequestTimer;
  const cancelPendingRequest = () => {
    if (pendingRequestTimer == undefined) return;
    clearTimeout(pendingRequestTimer);
    pendingRequestTimer = undefined;
  };
  const finishCurrentRequest = (pageKey, requestTime) => {
    if (lastRequestTimes[pageKey] != requestTime || disposed || currentPageKey() != pageKey) return;
    setLoading(false);
  };
  const requestRankData = requestedPage => {
    const pageKey = getLeaderboardPageKey(requestedPage);
    const cached = getCachedRankData(pageKey);
    const requestTime = Date.now();
    lastRequestTimes[pageKey] = requestTime;
    setLoading(cached == undefined);
    CallActionRequest("/v1/leaderboard/fetch", {
      leaderboard_type: LEADERBOARD_TYPE,
      extra_keys: [LEADERBOARD_EXTRA_KEY],
      start: (requestedPage - 1) * PAGE_SIZE + 1,
      end: requestedPage * PAGE_SIZE
    }, result => {
      const isLatestPageRequest = lastRequestTimes[pageKey] == requestTime;
      if (result?.code == 0) {
        const leaderboardData = result.data?.leaderboard_datas?.[0];
        const cacheData = {
          leaderboard: leaderboardData?.leaderboard_data ?? [],
          selfRank: leaderboardData?.self_data
        };
        if (isLatestPageRequest) {
          leaderboardCache[pageKey] = {
            data: cacheData,
            updatedAt: Date.now() / 1000
          };
          if (!disposed) {
            setRankDataCache(cache => ({
              ...cache,
              [pageKey]: cacheData
            }));
          }
        }
      }
      finishCurrentRequest(pageKey, requestTime);
    }, () => finishCurrentRequest(pageKey, requestTime));
  };
  const scheduleRankDataRequest = requestedPage => {
    cancelPendingRequest();
    const pageKey = getLeaderboardPageKey(requestedPage);
    const cached = getCachedRankData(pageKey);
    const lastRequestTime = lastRequestTimes[pageKey] ?? (leaderboardCache[pageKey]?.updatedAt ?? 0) * 1000;
    const delay = Math.max(0, lastRequestTime + MIN_REQUEST_INTERVAL_MS - Date.now());
    if (delay == 0) {
      requestRankData(requestedPage);
      return;
    }
    setLoading(cached == undefined);
    pendingRequestTimer = setTimeout(() => {
      pendingRequestTimer = undefined;
      if (disposed || page() != requestedPage) return;
      requestRankData(requestedPage);
    }, delay);
  };
  libs.createEffect(libs.on(page, currentPage => {
    setLoading(false);
    scheduleRankDataRequest(currentPage);
  }));
  libs.onCleanup(() => {
    disposed = true;
    cancelPendingRequest();
  });
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
    id: "VeinsRank",
    shadow_border: true,
    get children() {
      return [(() => {
        const _el$43 = libs.createElement("Panel", {
            id: "VeinsRankRoot"
          }, null),
          _el$44 = libs.createElement("Panel", {
            id: "VeinsRankPanel"
          }, _el$43),
          _el$45 = libs.createElement("Panel", {
            id: "VeinsRankContent"
          }, _el$44);
        libs.insert(_el$45, libs.createComponent(VeinsRankTop, {
          get players() {
            return topRanks();
          }
        }), null);
        libs.insert(_el$45, libs.createComponent(VeinsRankTable, {
          get ranks() {
            return displayRanks();
          },
          get selfRank() {
            return displaySelfRank();
          },
          get loading() {
            return loading();
          }
        }), null);
        libs.insert(_el$44, libs.createComponent(VeinsRankPagination, {
          get page() {
            return page();
          },
          setPage: setPage
        }), null);
        libs.insert(_el$43, libs.createComponent(EOM_Button.EOM_BaseButton, {
          "class": "VeinsRankRuleButton",
          get customTooltip() {
            return {
              name: "activity_veins",
              rankTip: JSON.stringify({
                text: GetLocalization("#ActivityVeins_VeinsRank_RuleTooltip"),
                titleID: VEINS_RANK_REWARD_TITLE_ID,
                subText: GetLocalization("#ActivityVeins_VeinsRank_RuleTooltip2")
              })
            };
          },
          get children() {
            return [libs.createElement("Image", {
              "class": "VeinsRankRuleButtonIcon"
            }, null), (() => {
              const _el$47 = libs.createElement("Label", {
                get text() {
                  return GetLocalization("#ActivityVeins_VeinsRank_RuleButton");
                }
              }, null);
              libs.effect(_$p => libs.setProp(_el$47, "text", GetLocalization("#ActivityVeins_VeinsRank_RuleButton"), _$p));
              return _el$47;
            })()];
          }
        }), null);
        return _el$43;
      })(), libs.memo(() => libs.memo(() => !!loading())() && libs.createComponent(EOM_Loading.EOM_Loading, {
        align: "center center",
        type: "PointSpin"
      }))];
    }
  });
}

const ACTIVITY_VEINS_ID = 1001;
const ACTIVITY_MENU_GRACE_SECONDS = 7 * 24 * 60 * 60;
function getVeinsStoreItems(infoProducts) {
  const result = [];
  const now = Date.now() / 1000;
  for (const itemname in KeyValues.info_shop_product) {
    const itemdata = KeyValues.info_shop_product[itemname];
    const info_product = infoProducts[itemdata.id];
    const effective_start_time = info_product ? info_product.start_time : itemdata.start_time;
    const effective_end_time = info_product ? info_product.end_time : itemdata.end_time;
    if ((effective_start_time < now || effective_start_time == 0) && (effective_end_time > now || effective_end_time == 0) && (itemdata.hide_time > now || !itemdata.hide_time) && itemdata.hide == 0 || itemdata.tag == "Privilege") {
      const tags = itemdata.tag.split("|");
      if (tags.includes("Mining")) {
        result.push(itemdata);
      }
    }
  }
  result.sort((a, b) => b.orderby - a.orderby);
  return result;
}
function VeinsStore() {
  const activityData = libs.createMemo(() => KeyValues.activity_data[ACTIVITY_VEINS_ID]);
  const logoLang = libs.createMemo(() => {
    const lang = Language();
    if (lang == "schinese") {
      return "Language_schinese";
    } else if (lang == "russian") {
      return "Language_russian";
    } else {
      return "Language_english";
    }
  });
  const infoProducts = solid_utils.createGlobalServiceNetData("info_products", {});
  const purchasedProduct = solid_utils.createServiceNetData("player_shop_product_limits", {});
  const storeItems = libs.createMemo(() => getVeinsStoreItems(infoProducts()));
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
    id: "VeinsStore",
    shadow_border: true,
    get children() {
      return [(() => {
        const _el$ = libs.createElement("Panel", {
            id: "VeinsStoreTitleContent"
          }, null),
          _el$2 = libs.createElement("Panel", {
            id: "VeinsStoreTitleTop"
          }, _el$),
          _el$3 = libs.createElement("Image", {
            id: "VeinsStoreTitleIcon",
            get ["class"]() {
              return logoLang();
            }
          }, _el$2),
          _el$4 = libs.createElement("Image", {
            get ["class"]() {
              return libs.classNames("VeinsStoreGiftTitleTooltipIcon", logoLang());
            }
          }, _el$2),
          _el$5 = libs.createElement("Panel", {
            id: "VeinsStoreTitleTime",
            "class": "VeinsStoreGiftTitleTime"
          }, _el$);
          libs.createElement("Image", {
            "class": "VeinsStoreGiftTitleTimeBG"
          }, _el$5);
        libs.insert(_el$5, libs.createComponent(EOM_Countdown.EOM_Countdown, {
          icon: true,
          text: "#ActivityVeins_VeinsStore_TimeLimit",
          get endTime() {
            return activityData().end_time + ACTIVITY_MENU_GRACE_SECONDS;
          }
        }), null);
        libs.effect(_p$ => {
          const _v$ = logoLang(),
            _v$2 = libs.classNames("VeinsStoreGiftTitleTooltipIcon", logoLang()),
            _v$3 = GetLocalization("#ActivityVeins_VeinsStore_TimeTooltip");
          _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$3, "class", _v$, _p$._v$));
          _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$4, "class", _v$2, _p$._v$2));
          _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$4, "tooltip_text", _v$3, _p$._v$3));
          return _p$;
        }, {
          _v$: undefined,
          _v$2: undefined,
          _v$3: undefined
        });
        return _el$;
      })(), (() => {
        const _el$7 = libs.createElement("Panel", {
          id: "VeinsStoreList",
          "class": "VerticalScrollStyle",
          scroll: "y"
        }, null);
        libs.setProp(_el$7, "scroll", "y");
        libs.insert(_el$7, libs.createComponent(libs.Index, {
          get each() {
            return storeItems();
          },
          children: data => {
            return libs.createComponent(StoreItem.StoreItem, {
              get itemid() {
                return data().id;
              },
              get purchased_num() {
                return purchasedProduct()[data().id];
              },
              endTime: 0
            });
          }
        }));
        return _el$7;
      })()];
    }
  });
}

const titleIconPaths = {
  "301": ["f4_title_en", "f4_title_cn", "f4_title_ru"]
};
const player_growth_fund_activity_data = solid_utils.createServiceNetData("player_growth_fund_activity_data", {});
const [activityID, SetActivityID] = libs.createSignal("301");
libs.createMemo(() => KeyValues.activity_data[activityID()]);
const allActivityID = ["301"];
const hasAnyUnreceived = libs.createMemo(() => {
  const fund_Playerdata = () => player_growth_fund_activity_data();
  const fundConfig = () => KeyValues.activity_growth_fund_rewards;
  let temp = {};
  for (const activityID of allActivityID) {
    temp[activityID] = false;
    const playerProgress = fund_Playerdata()[activityID]?.progress;
    const playerReceived = fund_Playerdata()[activityID]?.received;
    const playerPlus = fund_Playerdata()[activityID]?.plus;
    const growthReward = Object.values(fundConfig()[parseInt(activityID)]).sort((a, b) => a.reward_id - b.reward_id);
    for (let j = 0; j < growthReward.length; j++) {
      if (growthReward[j].plus == 1 && !playerPlus) {
        break;
      }
      if (playerProgress >= growthReward[j].num) {
        if (playerReceived == undefined || !playerReceived.some(r => r.reward_id === growthReward[j].reward_id)) {
          temp[activityID] = true;
          break;
        }
      }
    }
  }
  for (let i = 0; i < allActivityID.length; i++) {
    temp[allActivityID[i]] = false;
    const playerProgress = fund_Playerdata()[allActivityID[i]]?.progress;
    const playerReceived = fund_Playerdata()[allActivityID[i]]?.received;
    const playerPlus = fund_Playerdata()[allActivityID[i]]?.plus;
    const growthReward = Object.values(fundConfig()[parseInt(allActivityID[i])]).sort((a, b) => a.reward_id - b.reward_id);
    for (let j = 0; j < growthReward.length; j++) {
      if (growthReward[j].plus == 1 && !playerPlus) {
        break;
      }
      if (playerProgress >= growthReward[j].num) {
        if (playerReceived == undefined || !playerReceived.some(r => r.reward_id === growthReward[j].reward_id)) {
          temp[allActivityID[i]] = true;
          break;
        }
      }
    }
  }
  return temp;
});
libs.createEffect(() => {
  CustomUIConfig.SetRedPoint(hasAnyUnreceived()["301"], "activity", "growth_fund", "growth_fund_301");
});
const lang = Language();
function GrowthFund(params) {
  SetActivityID(params.activityID);
  const growth_fund_activity_data = libs.createMemo(() => player_growth_fund_activity_data()?.[activityID()] || {
    progress: 0,
    received: [],
    plus: false
  });
  const progress = () => growth_fund_activity_data()?.progress;
  let currentMaxProgress = 0;
  const plus = () => growth_fund_activity_data().plus ? 1 : 0;
  let imagePath = titleIconPaths[params.activityID][0];
  if (lang == "schinese") {
    imagePath = titleIconPaths[params.activityID][1];
  } else if (lang == "russian") {
    imagePath = titleIconPaths[params.activityID][2];
  }
  const FundConfig = KeyValues.activity_growth_fund[params.activityID];
  const FundPlusProductID = FundConfig.product_id;
  const growthRewards = Object.values(KeyValues.activity_growth_fund_rewards[parseInt(activityID())]).sort((a, b) => a.num - b.num);
  const currentFundMaxValue = growthRewards[growthRewards.length - 1]?.num;
  switch (activityID()) {
    case "301":
      Math.min(Math.floor(progress() / 2), currentFundMaxValue);
      currentMaxProgress = Object.keys(KeyValues.hero_level_exp).length;
      break;
  }
  return (() => {
    const _el$ = libs.createElement("Panel", {
        id: "GrowthFund"
      }, null);
      libs.createElement("Panel", {
        id: "BG"
      }, _el$);
      const _el$3 = libs.createElement("Panel", {
        id: "TopContent"
      }, _el$),
      _el$4 = libs.createElement("Image", {
        id: "ImgTitle",
        src: `file://{images}/custom_game/activity/growth_fund/imgTitle/${imagePath}.png`
      }, _el$3),
      _el$5 = libs.createElement("Panel", {
        id: "Info"
      }, _el$3),
      _el$6 = libs.createElement("Label", {
        id: "InfoText",
        get text() {
          return "#Info_" + activityID();
        }
      }, _el$5),
      _el$7 = libs.createElement("Image", {
        id: "InfoIcon"
      }, _el$5),
      _el$8 = libs.createElement("Image", {
        id: "LevelBG"
      }, _el$3),
      _el$9 = libs.createElement("Label", {
        id: "LevelNumber",
        get text() {
          return Math.min(progress(), currentFundMaxValue);
        }
      }, _el$8),
      _el$0 = libs.createElement("Label", {
        id: "LevelTitle",
        get text() {
          return "#LevelInfo_" + activityID();
        }
      }, _el$3),
      _el$1 = libs.createElement("Panel", {
        id: "ExpBarContainer"
      }, _el$3);
      libs.createElement("Panel", {
        id: "ExpBarBG"
      }, _el$1);
      const _el$11 = libs.createElement("Panel", {
        id: "Bar",
        get style() {
          return {
            clip: `rect( 0%, ${Math.min(progress(), currentFundMaxValue) / currentMaxProgress * 100}%, 100%, 0% )`
          };
        }
      }, _el$1),
      _el$12 = libs.createElement("Label", {
        id: "ExpValue",
        get text() {
          return Math.min(progress(), currentFundMaxValue) + "/" + currentMaxProgress;
        }
      }, _el$3),
      _el$13 = libs.createElement("Panel", {
        id: "RewardList",
        scroll: "x"
      }, _el$),
      _el$14 = libs.createElement("Panel", {
        id: "RewardFirstBG"
      }, _el$13);
      libs.createElement("Image", {
        id: "TopImg"
      }, _el$14);
      libs.createElement("Label", {
        id: "TopText",
        text: "#SimpleBook"
      }, _el$14);
      const _el$17 = libs.createElement("Image", {
        id: "BottomImg"
      }, _el$14),
      _el$18 = libs.createElement("Image", {
        id: "Lock"
      }, _el$17);
      libs.createElement("Label", {
        id: "BottomText",
        text: "#LuxuryBook"
      }, _el$14);
      const _el$20 = libs.createElement("Panel", {}, _el$),
      _el$21 = libs.createElement("Label", {
        id: "PlusTipText",
        get text() {
          return "#PlusTipText_" + activityID();
        }
      }, _el$20),
      _el$22 = libs.createElement("Panel", {
        id: "BottomContent"
      }, _el$);
    libs.setProp(_el$4, "src", `file://{images}/custom_game/activity/growth_fund/imgTitle/${imagePath}.png`);
    libs.setProp(_el$13, "scroll", "x");
    libs.insert(_el$13, libs.createComponent(libs.For, {
      each: growthRewards,
      children: (rewardConfig, i) => {
        if (i() % 2 != 1) {
          let received = () => {
            return growth_fund_activity_data().received && growth_fund_activity_data().received.some(r => r.reward_id === rewardConfig.reward_id);
          };
          let receivedPlus = () => {
            return growth_fund_activity_data().received && growth_fund_activity_data().received.some(r => r.reward_id === growthRewards[i() + 1].reward_id);
          };
          let canReceive = () => {
            return !received() && progress() >= rewardConfig.num;
          };
          let canReceivePlus = () => {
            return !receivedPlus() && plus() && progress() >= growthRewards[i() + 1].num;
          };
          let topReward = rewardConfig.rewards.split(':');
          let IsDouble = false;
          let bottomSolo;
          let bottomItem1;
          let bottomItem2;
          if (growthRewards[i() + 1].rewards.includes('|')) {
            IsDouble = true;
            let rewards = growthRewards[i() + 1].rewards.split('|');
            bottomItem1 = rewards[0].split(':');
            bottomItem2 = rewards[1].split(':');
          } else {
            bottomSolo = growthRewards[i() + 1].rewards.split(':');
          }
          return (() => {
            const _el$23 = libs.createElement("Panel", {
                id: "RewardBG"
              }, null),
              _el$24 = libs.createElement("Panel", {
                id: "Reward",
                "class": "Top"
              }, _el$23),
              _el$25 = libs.createElement("Image", {
                id: "Lock"
              }, _el$24),
              _el$26 = libs.createElement("Image", {
                hittest: false
              }, _el$24),
              _el$27 = libs.createElement("Panel", {
                "class": "Top",
                hittest: false
              }, _el$23),
              _el$28 = libs.createElement("Panel", {
                "class": "Top",
                hittest: false
              }, _el$23),
              _el$29 = libs.createElement("Panel", {
                id: "CenterIcon"
              }, _el$23),
              _el$30 = libs.createElement("Label", {
                id: "CenterText",
                get text() {
                  return rewardConfig.num;
                }
              }, _el$29);
            libs.setProp(_el$24, "onactivate", () => {
              if (!received() && canReceive()) {
                CallActionRequest("/v1/activity/receive_rewards", {
                  activity_id: Number(activityID()),
                  reward_id: rewardConfig.reward_id
                }, () => {});
              }
            });
            libs.insert(_el$24, libs.createComponent(StoreItem.StoreItemBlock, {
              get classList() {
                return {
                  black: received()
                };
              },
              get item_id() {
                return topReward[0];
              },
              get rarity() {
                return GetServiceItemRarity(topReward[0]);
              },
              get amounts() {
                return toFiniteNumber(topReward[1]);
              }
            }), _el$25);
            libs.setProp(_el$28, "style", {
              animationDelay: "0.9s"
            });
            libs.insert(_el$23, libs.createComponent(libs.Show, {
              when: IsDouble,
              fallback: () => {
                return [(() => {
                  const _el$41 = libs.createElement("Panel", {
                      id: "Reward",
                      "class": "BottomSolo"
                    }, null),
                    _el$42 = libs.createElement("Image", {
                      id: "Lock"
                    }, _el$41),
                    _el$43 = libs.createElement("Image", {
                      hittest: false
                    }, _el$41);
                  libs.setProp(_el$41, "onactivate", () => {
                    if (!receivedPlus() && canReceivePlus()) {
                      CallActionRequest("/v1/activity/receive_rewards", {
                        activity_id: Number(activityID()),
                        reward_id: growthRewards[i() + 1].reward_id
                      }, () => {});
                    }
                  });
                  libs.insert(_el$41, libs.createComponent(StoreItem.StoreItemBlock, {
                    get classList() {
                      return {
                        black: receivedPlus()
                      };
                    },
                    get item_id() {
                      return bottomSolo[0];
                    },
                    get rarity() {
                      return GetServiceItemRarity(bottomSolo[0]);
                    },
                    get amounts() {
                      return toFiniteNumber(bottomSolo[1]);
                    }
                  }), _el$42);
                  libs.effect(_p$ => {
                    const _v$17 = {
                        Hide: receivedPlus() || canReceivePlus()
                      },
                      _v$18 = {
                        Received: receivedPlus()
                      };
                    _v$17 !== _p$._v$17 && (_p$._v$17 = libs.setProp(_el$42, "classList", _v$17, _p$._v$17));
                    _v$18 !== _p$._v$18 && (_p$._v$18 = libs.setProp(_el$43, "classList", _v$18, _p$._v$18));
                    return _p$;
                  }, {
                    _v$17: undefined,
                    _v$18: undefined
                  });
                  return _el$41;
                })(), (() => {
                  const _el$44 = libs.createElement("Panel", {
                    "class": "BottomSolo",
                    hittest: false
                  }, null);
                  libs.effect(_$p => libs.setProp(_el$44, "classList", {
                    RewardBoraderAnimation: canReceivePlus() && !receivedPlus()
                  }, _$p));
                  return _el$44;
                })(), (() => {
                  const _el$45 = libs.createElement("Panel", {
                    "class": "BottomSolo",
                    hittest: false
                  }, null);
                  libs.setProp(_el$45, "style", {
                    animationDelay: "0.9s"
                  });
                  libs.effect(_$p => libs.setProp(_el$45, "classList", {
                    RewardBoraderAnimation: canReceivePlus() && !receivedPlus()
                  }, _$p));
                  return _el$45;
                })()];
              },
              get children() {
                return [(() => {
                  const _el$31 = libs.createElement("Panel", {
                      id: "Reward",
                      "class": "BottomOne"
                    }, null),
                    _el$32 = libs.createElement("Image", {
                      id: "Lock"
                    }, _el$31),
                    _el$33 = libs.createElement("Image", {
                      hittest: false
                    }, _el$31);
                  libs.setProp(_el$31, "onactivate", () => {
                    if (!receivedPlus() && canReceivePlus()) {
                      CallActionRequest("/v1/activity/receive_rewards", {
                        activity_id: Number(activityID()),
                        reward_id: growthRewards[i() + 1].reward_id
                      }, () => {});
                    }
                  });
                  libs.insert(_el$31, libs.createComponent(StoreItem.StoreItemBlock, {
                    get classList() {
                      return {
                        black: receivedPlus()
                      };
                    },
                    get item_id() {
                      return bottomItem1[0];
                    },
                    get rarity() {
                      return GetServiceItemRarity(bottomItem1[0]);
                    },
                    get amounts() {
                      return toFiniteNumber(bottomItem1[1]);
                    }
                  }), _el$32);
                  libs.effect(_p$ => {
                    const _v$0 = {
                        Hide: receivedPlus() || canReceivePlus()
                      },
                      _v$1 = {
                        Received: receivedPlus()
                      };
                    _v$0 !== _p$._v$0 && (_p$._v$0 = libs.setProp(_el$32, "classList", _v$0, _p$._v$0));
                    _v$1 !== _p$._v$1 && (_p$._v$1 = libs.setProp(_el$33, "classList", _v$1, _p$._v$1));
                    return _p$;
                  }, {
                    _v$0: undefined,
                    _v$1: undefined
                  });
                  return _el$31;
                })(), (() => {
                  const _el$34 = libs.createElement("Panel", {
                    "class": "BottomOne",
                    hittest: false
                  }, null);
                  libs.effect(_$p => libs.setProp(_el$34, "classList", {
                    RewardBoraderAnimation: canReceivePlus() && !receivedPlus()
                  }, _$p));
                  return _el$34;
                })(), (() => {
                  const _el$35 = libs.createElement("Panel", {
                    "class": "BottomOne",
                    hittest: false
                  }, null);
                  libs.setProp(_el$35, "style", {
                    animationDelay: "0.9s"
                  });
                  libs.effect(_$p => libs.setProp(_el$35, "classList", {
                    RewardBoraderAnimation: canReceivePlus() && !receivedPlus()
                  }, _$p));
                  return _el$35;
                })(), (() => {
                  const _el$36 = libs.createElement("Panel", {
                      id: "Reward",
                      "class": "BottomTwo"
                    }, null),
                    _el$37 = libs.createElement("Image", {
                      id: "Lock"
                    }, _el$36),
                    _el$38 = libs.createElement("Image", {
                      hittest: false
                    }, _el$36);
                  libs.setProp(_el$36, "onactivate", () => {
                    if (!receivedPlus() && canReceivePlus()) {
                      CallActionRequest("/v1/activity/receive_rewards", {
                        activity_id: Number(activityID()),
                        reward_id: growthRewards[i() + 1].reward_id
                      }, () => {});
                    }
                  });
                  libs.insert(_el$36, libs.createComponent(StoreItem.StoreItemBlock, {
                    get classList() {
                      return {
                        black: receivedPlus()
                      };
                    },
                    get item_id() {
                      return bottomItem2[0];
                    },
                    get rarity() {
                      return GetServiceItemRarity(bottomItem2[0]);
                    },
                    get amounts() {
                      return toFiniteNumber(bottomItem2[1]);
                    }
                  }), _el$37);
                  libs.effect(_p$ => {
                    const _v$10 = {
                        Hide: receivedPlus() || canReceivePlus()
                      },
                      _v$11 = {
                        Received: receivedPlus()
                      };
                    _v$10 !== _p$._v$10 && (_p$._v$10 = libs.setProp(_el$37, "classList", _v$10, _p$._v$10));
                    _v$11 !== _p$._v$11 && (_p$._v$11 = libs.setProp(_el$38, "classList", _v$11, _p$._v$11));
                    return _p$;
                  }, {
                    _v$10: undefined,
                    _v$11: undefined
                  });
                  return _el$36;
                })(), (() => {
                  const _el$39 = libs.createElement("Panel", {
                    "class": "BottomTwo",
                    hittest: false
                  }, null);
                  libs.effect(_$p => libs.setProp(_el$39, "classList", {
                    RewardBoraderAnimation: canReceivePlus() && !receivedPlus()
                  }, _$p));
                  return _el$39;
                })(), (() => {
                  const _el$40 = libs.createElement("Panel", {
                    "class": "BottomTwo",
                    hittest: false
                  }, null);
                  libs.setProp(_el$40, "style", {
                    animationDelay: "0.9s"
                  });
                  libs.effect(_$p => libs.setProp(_el$40, "classList", {
                    RewardBoraderAnimation: canReceivePlus() && !receivedPlus()
                  }, _$p));
                  return _el$40;
                })()];
              }
            }), null);
            libs.effect(_p$ => {
              const _v$12 = {
                  Hide: received() || canReceive()
                },
                _v$13 = {
                  Received: received()
                },
                _v$14 = {
                  RewardBoraderAnimation: canReceive() && !received()
                },
                _v$15 = {
                  RewardBoraderAnimation: canReceive() && !received()
                },
                _v$16 = rewardConfig.num;
              _v$12 !== _p$._v$12 && (_p$._v$12 = libs.setProp(_el$25, "classList", _v$12, _p$._v$12));
              _v$13 !== _p$._v$13 && (_p$._v$13 = libs.setProp(_el$26, "classList", _v$13, _p$._v$13));
              _v$14 !== _p$._v$14 && (_p$._v$14 = libs.setProp(_el$27, "classList", _v$14, _p$._v$14));
              _v$15 !== _p$._v$15 && (_p$._v$15 = libs.setProp(_el$28, "classList", _v$15, _p$._v$15));
              _v$16 !== _p$._v$16 && (_p$._v$16 = libs.setProp(_el$30, "text", _v$16, _p$._v$16));
              return _p$;
            }, {
              _v$12: undefined,
              _v$13: undefined,
              _v$14: undefined,
              _v$15: undefined,
              _v$16: undefined
            });
            return _el$23;
          })();
        }
      }
    }), null);
    libs.insert(_el$22, libs.createComponent(EOM_Button.EOM_Button, {
      id: "ReceiveAllBtn",
      get classList() {
        return {
          Plus: plus() == 1,
          NoPlus: plus() == 0
        };
      },
      get enabled() {
        return hasAnyUnreceived()[params.activityID];
      },
      text: "#Activity_ReceiveALl",
      onactivate: () => {
        CallActionRequest("/v1/activity/batch_receive_rewards", {
          activity_id: Number(activityID())
        }, () => {});
      }
    }), null);
    libs.insert(_el$22, libs.createComponent(libs.Show, {
      get when() {
        return !plus();
      },
      get children() {
        return libs.createComponent(EOM_Button.EOM_Button, {
          id: "BuyPlusBtn",
          get enabled() {
            return !plus();
          },
          color: "Gold",
          text: "#Fund_BuyPlus",
          onactivate: () => {
            ClientSideEvent("directly_purchase", {
              itemid: FundPlusProductID,
              source: "growth_fund"
            });
          }
        });
      }
    }), null);
    libs.effect(_p$ => {
      const _v$ = "#Info_" + activityID(),
        _v$2 = "#Introduction_" + activityID(),
        _v$3 = Math.min(progress(), currentFundMaxValue),
        _v$4 = "#LevelInfo_" + activityID(),
        _v$5 = {
          clip: `rect( 0%, ${Math.min(progress(), currentFundMaxValue) / currentMaxProgress * 100}%, 100%, 0% )`
        },
        _v$6 = Math.min(progress(), currentFundMaxValue) + "/" + currentMaxProgress,
        _v$7 = {
          Hide: growth_fund_activity_data().plus
        },
        _v$8 = {
          PlusTip: plus() == 0
        },
        _v$9 = "#PlusTipText_" + activityID();
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$6, "text", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$7, "tooltip_text", _v$2, _p$._v$2));
      _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$9, "text", _v$3, _p$._v$3));
      _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$0, "text", _v$4, _p$._v$4));
      _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$11, "style", _v$5, _p$._v$5));
      _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$12, "text", _v$6, _p$._v$6));
      _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$18, "classList", _v$7, _p$._v$7));
      _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$20, "classList", _v$8, _p$._v$8));
      _v$9 !== _p$._v$9 && (_p$._v$9 = libs.setProp(_el$21, "text", _v$9, _p$._v$9));
      return _p$;
    }, {
      _v$: undefined,
      _v$2: undefined,
      _v$3: undefined,
      _v$4: undefined,
      _v$5: undefined,
      _v$6: undefined,
      _v$7: undefined,
      _v$8: undefined,
      _v$9: undefined
    });
    return _el$;
  })();
}

const ID = 101;
const rewards = Object.entries(KeyValues.activity_login[ID]).map(([day, reward]) => {
  let [item_id, amounts] = reward.rewards.split(":");
  return {
    item_id: Number(item_id),
    amounts: Number(amounts),
    day: Number(day)
  };
});
const player_login_activity_data$1 = solid_utils.createServiceNetTableDataStore("player_login_activity_data", Game.GetLocalPlayerID());
const login_data = libs.createMemo(() => player_login_activity_data$1?.[ID]);
var ReceiveState = function (ReceiveState) {
  ReceiveState[ReceiveState["WaitReceive"] = 0] = "WaitReceive";
  ReceiveState[ReceiveState["CanReceive"] = 1] = "CanReceive";
  ReceiveState[ReceiveState["Received"] = 2] = "Received";
  return ReceiveState;
}(ReceiveState || {});
libs.createEffect(() => {
  let anyCanReceive = false;
  for (let i = 0; i < 7; i++) {
    let day = i + 1;
    const state = (() => {
      if (!login_data()) return ReceiveState.WaitReceive;
      if (day <= login_data().step) {
        return ReceiveState.Received;
      }
      if (login_data().next_can_receive && day == login_data().step + 1) {
        return ReceiveState.CanReceive;
      }
      return ReceiveState.WaitReceive;
    })();
    if (state == ReceiveState.CanReceive) {
      anyCanReceive = true;
      break;
    }
  }
  CustomUIConfig.SetRedPoint(anyCanReceive, "activity", "seven_days");
});
function SevenDaysRoot() {
  return (() => {
    const _el$ = libs.createElement("Panel", {
        id: "SevenDaysRoot"
      }, null);
      libs.createElement("Image", {
        id: "MainBg",
        hittest: false
      }, _el$);
      libs.createElement("Image", {
        id: "DrawIllust",
        hittest: false
      }, _el$);
      libs.createElement("Image", {
        id: "TitleImg",
        hittest: false
      }, _el$);
      const _el$5 = libs.createElement("Panel", {
        id: "SevenDaysList"
      }, _el$);
    libs.insert(_el$5, libs.createComponent(libs.For, {
      each: rewards,
      children: (reward, index) => {
        let day = index() + 1;
        const state = () => {
          if (!login_data()) return ReceiveState.WaitReceive;
          if (day <= login_data().step) {
            return ReceiveState.Received;
          }
          if (login_data().next_can_receive && day == login_data().step + 1) {
            return ReceiveState.CanReceive;
          }
          return ReceiveState.WaitReceive;
        };
        const isGold = reward.item_id.toString().startsWith("190") && reward.amounts >= 10;
        const stateClass = () => {
          switch (state()) {
            case ReceiveState.WaitReceive:
              return "WaitReceive";
            case ReceiveState.CanReceive:
              return "CanReceive";
            case ReceiveState.Received:
              return "Received";
          }
        };
        const [showReceiveParticle, setShowReceiveParticle] = libs.createSignal(false);
        return (() => {
          const _el$6 = libs.createElement("Panel", {}, null);
            libs.createElement("Image", {
              "class": "PanelBg",
              hittest: false
            }, _el$6);
            const _el$9 = libs.createElement("Panel", {
              hittest: false
            }, _el$6);
            libs.createElement("Label", {
              id: "nth",
              text: "#nth"
            }, _el$9);
            libs.createElement("Image", {
              hittest: false
            }, _el$9);
            libs.createElement("Label", {
              id: "day",
              text: "#day"
            }, _el$9);
          libs.insert(_el$6, libs.createComponent(libs.Show, {
            get when() {
              return state() == ReceiveState.Received;
            },
            get children() {
              return libs.createElement("Image", {
                "class": "ReceivedMask",
                hittest: false
              }, null);
            }
          }), _el$9);
          libs.insert(_el$6, libs.createComponent(StoreItem.StoreItemBlock, {
            get item_id() {
              return reward.item_id;
            },
            get amounts() {
              return reward.amounts;
            }
          }), null);
          libs.insert(_el$6, libs.createComponent(libs.Show, {
            get when() {
              return state() == ReceiveState.Received;
            },
            get children() {
              return libs.createElement("Image", {
                id: "ReceivedTick",
                hittest: false
              }, null);
            }
          }), null);
          libs.insert(_el$6, libs.createComponent(libs.Show, {
            get when() {
              return state() == ReceiveState.CanReceive;
            },
            get fallback() {
              return (() => {
                const _el$15 = libs.createElement("Image", {
                    hittest: false
                  }, null),
                  _el$16 = libs.createElement("Label", {
                    get text() {
                      return state() == ReceiveState.Received ? "#TaskFinished" : "#WaitReceive";
                    }
                  }, _el$15);
                libs.effect(_p$ => {
                  const _v$3 = libs.classNames("FrameImg", {
                      Received: state() == ReceiveState.Received
                    }),
                    _v$4 = state() == ReceiveState.Received ? "#TaskFinished" : "#WaitReceive";
                  _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$15, "className", _v$3, _p$._v$3));
                  _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$16, "text", _v$4, _p$._v$4));
                  return _p$;
                }, {
                  _v$3: undefined,
                  _v$4: undefined
                });
                return _el$15;
              })();
            },
            get children() {
              return libs.createComponent(EOM_Button.EOM_BaseButton, {
                id: "ReceiveBtn",
                onactivate: () => {
                  CallAction("/v1/activity/receive_rewards", {
                    activity_id: ID,
                    reward_id: day
                  });
                  setShowReceiveParticle(true);
                },
                get children() {
                  return [libs.createElement("Image", {
                    id: "ReceiveBtnBg",
                    hittest: false
                  }, null), libs.createElement("Label", {
                    id: "btnText",
                    text: "#TaskReceive"
                  }, null)];
                }
              });
            }
          }), null);
          libs.insert(_el$6, libs.createComponent(libs.Show, {
            get when() {
              return state() == ReceiveState.CanReceive;
            },
            get children() {
              return libs.createElement("Image", {
                id: "RedMark",
                hittest: false
              }, null);
            }
          }), null);
          libs.effect(_p$ => {
            const _v$ = libs.classNames("SevenDaysItem", stateClass(), {
                Gold: isGold,
                Received: state() == ReceiveState.Received
              }),
              _v$2 = libs.classNames("DayNum", "Day" + day);
            _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$6, "className", _v$, _p$._v$));
            _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$9, "className", _v$2, _p$._v$2));
            return _p$;
          }, {
            _v$: undefined,
            _v$2: undefined
          });
          return _el$6;
        })();
      }
    }));
    libs.effect(_$p => libs.setProp(_el$, "className", libs.classNames("RootContainer"), _$p));
    return _el$;
  })();
}

const player_blessings = solid_utils.createServiceNetData("player_blessings");
const purchased_product = solid_utils.createServiceNetData("player_shop_product_limits", {});
function ShopAndTask(params) {
  const player_activity_tasks = solid_utils.createServiceNetData("player_activity_tasks", {});
  libs.createEffect(() => {
    CallAction("/v1/activity/data", {
      activity_id: Number(params.activityID)
    });
  });
  const activityData = libs.createMemo(() => KeyValues.activity_data[params.activityID]);
  const config = libs.createMemo(() => SymbolSpliter(activityData().config, "|", ";"));
  const itemList = libs.createMemo(() => {
    const list = [];
    for (const itemname in KeyValues.info_shop_product) {
      const itemdata = KeyValues.info_shop_product[itemname];
      const tags = itemdata.tag.split("|");
      if (tags.includes(config().shop_tag)) {
        list.push(itemdata);
      }
    }
    return list;
  });
  const activityTasks = libs.createMemo(() => {
    return Object.values(player_activity_tasks()).filter(task => {
      let kv = KeyValues.task[task.task_id];
      if (!kv || kv.type != 6) return false;
      if (!String(task.task_id).startsWith(config().task_id)) return false;
      return true;
    }).sort((a, b) => {
      const canReceive1 = a.progress >= a.target ? 1 : 0;
      const canReceive2 = b.progress >= b.target ? 1 : 0;
      const buff_condition1 = KeyValues.task[a.task_id]?.blessing_condition ?? 0;
      const buff_condition2 = KeyValues.task[b.task_id]?.blessing_condition ?? 0;
      return multiCompare(a.receive_progress - b.receive_progress, canReceive2 - canReceive1, buff_condition2 - buff_condition1);
    });
  });
  const titleImagePath = libs.createMemo(() => {
    const lang = Language();
    let imagePath = "title_en.png";
    if (lang == "schinese") {
      imagePath = "title_cn.png";
    } else if (lang == "russian") {
      imagePath = "title_ru.png";
    }
    return getSrcPath(`activity/shop_and_task/${params.activityID}/${imagePath}`);
  });
  return (() => {
    const _el$ = libs.createElement("Panel", {
        id: "ShopAndTaskRoot",
        get ["class"]() {
          return activityData().name;
        }
      }, null),
      _el$2 = libs.createElement("Label", {
        id: "ToolOnly",
        text: "ToolOnly"
      }, _el$),
      _el$3 = libs.createElement("Image", {
        id: "BG",
        get src() {
          return getSrcPath(`activity/shop_and_task/${params.activityID}/bg.png`);
        }
      }, _el$);
    libs.insert(_el$, libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
      get children() {
        return [(() => {
          const _el$4 = libs.createElement("Panel", {
              id: "ShopAndTaskStore"
            }, null),
            _el$5 = libs.createElement("Panel", {
              id: "TitleArea"
            }, _el$4),
            _el$6 = libs.createElement("Image", {
              id: "StoreTitleImage",
              get src() {
                return titleImagePath();
              }
            }, _el$5),
            _el$7 = libs.createElement("Panel", {
              id: "TipsIcon"
            }, _el$5),
            _el$8 = libs.createElement("Panel", {
              id: "StoreTitle"
            }, _el$4),
            _el$9 = libs.createElement("Label", {
              id: "StoreTitleLabel",
              get text() {
                return "#" + activityData().name + "_title";
              }
            }, _el$8),
            _el$0 = libs.createElement("Panel", {
              id: "StoreItemContent"
            }, _el$4),
            _el$1 = libs.createElement("Panel", {
              id: "StoreItemList",
              scroll: "y",
              flowChildren: "right-wrap",
              horizontalAlign: "center"
            }, _el$0);
          libs.setProp(_el$1, "scroll", "y");
          libs.setProp(_el$1, "flowChildren", "right-wrap");
          libs.setProp(_el$1, "horizontalAlign", "center");
          libs.insert(_el$1, libs.createComponent(libs.For, {
            get each() {
              return itemList();
            },
            children: data => libs.createComponent(StoreItem.StoreItem, {
              get itemid() {
                return data.id;
              },
              get purchased_num() {
                return purchased_product()[data.id];
              }
            })
          }));
          libs.effect(_p$ => {
            const _v$ = titleImagePath(),
              _v$2 = "#ActivityTips_" + params.activityID,
              _v$3 = "#" + activityData().name + "_title";
            _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$6, "src", _v$, _p$._v$));
            _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$7, "tooltip", _v$2, _p$._v$2));
            _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$9, "text", _v$3, _p$._v$3));
            return _p$;
          }, {
            _v$: undefined,
            _v$2: undefined,
            _v$3: undefined
          });
          return _el$4;
        })(), (() => {
          const _el$10 = libs.createElement("Panel", {
            id: "ShopAndTaskTask",
            scroll: "y",
            flowChildren: "down",
            "class": "VerticalScrollStyle"
          }, null);
          libs.setProp(_el$10, "scroll", "y");
          libs.setProp(_el$10, "flowChildren", "down");
          libs.insert(_el$10, libs.createComponent(libs.Index, {
            get each() {
              return activityTasks();
            },
            children: (task, idx) => {
              const state = () => {
                const kv = KeyValues.task[task().task_id];
                if (kv.blessing_condition > 0 && !player_blessings()?.[kv.blessing_condition]) return "Locked";
                if (task().receive_progress == 1) return "Received";
                if (task().progress >= task().target) return "CanReceive";
                return "WaitReceive";
              };
              const taskConfig = () => KeyValues.task[task().task_id];
              const DescID = () => {
                let config = taskConfig();
                if (config.task_description) {
                  return config.task_id;
                } else {
                  return config.event_id;
                }
              };
              const rewards = () => {
                const kv = KeyValues.task[task().task_id];
                if (!kv) return [];
                return Object.entries(kv.rewards).map(([id, num]) => {
                  return {
                    id: id,
                    num: num
                  };
                });
              };
              return (() => {
                const _el$11 = libs.createElement("Panel", {
                    id: "TaskRow",
                    get ["class"]() {
                      return libs.classNames(state(), {
                        Last: idx == activityTasks().length - 1
                      });
                    }
                  }, null),
                  _el$12 = libs.createElement("Image", {
                    id: "TaskIcon",
                    get src() {
                      return `file://{images}/custom_game/task_icons/${taskConfig().icon}.png`;
                    }
                  }, _el$11),
                  _el$13 = libs.createElement("Panel", {
                    flowChildren: "down",
                    marginLeft: "114px",
                    verticalAlign: "center"
                  }, _el$11),
                  _el$14 = libs.createElement("Label", {
                    color: "#968A69",
                    fontSize: "16px",
                    get text() {
                      return "#Task_Name_" + DescID();
                    }
                  }, _el$13),
                  _el$15 = libs.createElement("Label", {
                    id: "TaskDes",
                    get text() {
                      return "#Task_Desc_" + DescID();
                    },
                    get vars() {
                      return {
                        target: GetLocalization(String(taskConfig().target)),
                        v1: GetLocalization(String(taskConfig().param_1)),
                        v2: GetLocalization(String(taskConfig().param_2)),
                        v3: GetLocalization(String(taskConfig().param_3))
                      };
                    }
                  }, _el$13),
                  _el$17 = libs.createElement("Panel", {
                    id: "TaskRewardList"
                  }, _el$11);
                libs.setProp(_el$13, "flowChildren", "down");
                libs.setProp(_el$13, "marginLeft", "114px");
                libs.setProp(_el$13, "verticalAlign", "center");
                libs.insert(_el$13, libs.createComponent(EOM_ProgressBar.EOM_ProgressBar, {
                  id: "TaskProgress",
                  get value() {
                    return Clamp(task().progress / task().target, 0, 1) * 100;
                  },
                  get children() {
                    const _el$16 = libs.createElement("Label", {
                      id: "TaskProgressValue",
                      get text() {
                        return `${task().progress}/${task().target}`;
                      }
                    }, null);
                    libs.effect(_$p => libs.setProp(_el$16, "text", `${task().progress}/${task().target}`, _$p));
                    return _el$16;
                  }
                }), null);
                libs.insert(_el$17, libs.createComponent(libs.For, {
                  get each() {
                    return rewards();
                  },
                  children: reward => {
                    return libs.createComponent(StoreItem.StoreItemBlock, {
                      id: "TaskReward",
                      get item_id() {
                        return Number(reward.id);
                      },
                      get amounts() {
                        return reward.num;
                      }
                    });
                  }
                }));
                libs.insert(_el$11, libs.createComponent(libs.Switch, {
                  get children() {
                    return [libs.createComponent(libs.Match, {
                      get when() {
                        return state() == "Received";
                      },
                      get children() {
                        const _el$18 = libs.createElement("Panel", {
                            id: "TaskReceivePanel"
                          }, null);
                          libs.createElement("Label", {
                            text: "#TaskFinished"
                          }, _el$18);
                        return _el$18;
                      }
                    }), libs.createComponent(libs.Match, {
                      get when() {
                        return state() == "CanReceive";
                      },
                      get children() {
                        return libs.createComponent(EOM_Button.EOM_Button, {
                          id: "TaskBtn",
                          size: "Small",
                          color: "Gold",
                          text: "#TaskReceive",
                          onactivate: () => {
                            CallAction("/v1/task/receive_rewards", {
                              task_id: task().task_id,
                              extra_id: toFiniteNumber(task().extra_id)
                            });
                          }
                        });
                      }
                    }), libs.createComponent(libs.Match, {
                      get when() {
                        return state() == "WaitReceive";
                      },
                      get children() {
                        return libs.createElement("Label", {
                          id: "TaskUnFinished",
                          text: "#TaskUnFinished"
                        }, null);
                      }
                    }), libs.createComponent(libs.Match, {
                      get when() {
                        return state() == "Locked";
                      },
                      get children() {
                        const _el$21 = libs.createElement("Panel", {
                            id: "VipLock"
                          }, null);
                          libs.createElement("Panel", {
                            id: "VipIcon"
                          }, _el$21);
                          libs.createElement("Label", {
                            text: "#TaskVipUnLock"
                          }, _el$21);
                        libs.setProp(_el$21, "onactivate", () => {});
                        return _el$21;
                      }
                    })];
                  }
                }), null);
                libs.effect(_p$ => {
                  const _v$7 = libs.classNames(state(), {
                      Last: idx == activityTasks().length - 1
                    }),
                    _v$8 = `file://{images}/custom_game/task_icons/${taskConfig().icon}.png`,
                    _v$9 = "#Task_Name_" + DescID(),
                    _v$0 = "#Task_Desc_" + DescID(),
                    _v$1 = {
                      target: GetLocalization(String(taskConfig().target)),
                      v1: GetLocalization(String(taskConfig().param_1)),
                      v2: GetLocalization(String(taskConfig().param_2)),
                      v3: GetLocalization(String(taskConfig().param_3))
                    };
                  _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$11, "class", _v$7, _p$._v$7));
                  _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$12, "src", _v$8, _p$._v$8));
                  _v$9 !== _p$._v$9 && (_p$._v$9 = libs.setProp(_el$14, "text", _v$9, _p$._v$9));
                  _v$0 !== _p$._v$0 && (_p$._v$0 = libs.setProp(_el$15, "text", _v$0, _p$._v$0));
                  _v$1 !== _p$._v$1 && (_p$._v$1 = libs.setProp(_el$15, "vars", _v$1, _p$._v$1));
                  return _p$;
                }, {
                  _v$7: undefined,
                  _v$8: undefined,
                  _v$9: undefined,
                  _v$0: undefined,
                  _v$1: undefined
                });
                return _el$11;
              })();
            }
          }));
          return _el$10;
        })()];
      }
    }), null);
    libs.effect(_p$ => {
      const _v$4 = activityData().name,
        _v$5 = activityData().in_tool == 1,
        _v$6 = getSrcPath(`activity/shop_and_task/${params.activityID}/bg.png`);
      _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$, "class", _v$4, _p$._v$4));
      _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$2, "visible", _v$5, _p$._v$5));
      _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$3, "src", _v$6, _p$._v$6));
      return _p$;
    }, {
      _v$4: undefined,
      _v$5: undefined,
      _v$6: undefined
    });
    return _el$;
  })();
}

function Info(props) {
  const merged = libs.mergeProps(props, {
    class: libs.classNames("Info", props.class)
  });
  const [local, others] = libs.splitProps(merged, ["tooltip_text", "text", "src", "color"]);
  const tooltip = libs.createMemo(() => local.tooltip_text ?? local.text + "_desc");
  return (() => {
    const _el$ = libs.createElement("Panel", others, null),
      _el$2 = libs.createElement("Image", {
        id: "InfoIcon",
        get src() {
          return local.src;
        }
      }, _el$),
      _el$3 = libs.createElement("Panel", {
        id: "InfoLabel"
      }, _el$),
      _el$4 = libs.createElement("Label", {
        get text() {
          return local.text;
        },
        get style() {
          return {
            color: local.color
          };
        }
      }, _el$3);
    libs.spread(_el$, libs.mergeProps$1(others, {
      get tooltip_text() {
        return tooltip();
      }
    }), true);
    libs.effect(_p$ => {
      const _v$ = local.src,
        _v$2 = local.text,
        _v$3 = {
          color: local.color
        };
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$2, "src", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$4, "text", _v$2, _p$._v$2));
      _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$4, "style", _v$3, _p$._v$3));
      return _p$;
    }, {
      _v$: undefined,
      _v$2: undefined,
      _v$3: undefined
    });
    return _el$;
  })();
}

const player_starsea_activity_data = solid_utils.createServiceNetData("player_starsea_activity_data", {});
const showCount = 5;
function StarSea(params) {
  const activityData = libs.createMemo(() => KeyValues.activity_data[params.activityID]);
  const step = libs.createMemo(() => toFiniteNumber(player_starsea_activity_data()[params.activityID]?.step));
  const [showPlusPreview, SetShowPlusPreview] = libs.createSignal(false);
  const activity_starsea = libs.createMemo(() => KeyValues.activity_starsea[params.activityID]);
  const starseaRewardindexs = libs.createMemo(() => Object.keys(activity_starsea()));
  const showCardList = libs.createMemo(() => Object.keys(activity_starsea()).filter((reward_id, index) => {
    if (index - step() > showCount - 1 || index < Math.min(step(), starseaRewardindexs().length - showCount)) {
      return false;
    }
    return true;
  }));
  const showIDList = libs.createMemo(() => starseaRewardindexs().filter(reward_id => {
    const rewardData = activity_starsea()[reward_id];
    return rewardData.show == 1;
  }).map(reward_id => {
    const rewardData = activity_starsea()[reward_id];
    if (rewardData.product_id != 0) {
      return String(rewardData.product_id);
    } else {
      return Object.keys(rewardData.rewards)[0];
    }
  }));
  return (() => {
    const _el$ = libs.createElement("Panel", {
        id: "StarSeaRoot",
        "class": "RootContainer"
      }, null),
      _el$2 = libs.createElement("Panel", {
        id: "TopPanel"
      }, _el$);
      libs.createElement("Image", {
        id: "BigStar"
      }, _el$2);
      const _el$4 = libs.createElement("Panel", {
        id: "Item1",
        "class": "BubbleItem"
      }, _el$2),
      _el$5 = libs.createElement("Panel", {
        id: "Item2",
        "class": "BubbleItem"
      }, _el$2),
      _el$6 = libs.createElement("Panel", {
        id: "Item3",
        "class": "BubbleItem"
      }, _el$2);
    libs.setProp(_el$4, "style", {
      animationDuration: "5s"
    });
    libs.insert(_el$4, libs.createComponent(StoreItem.StoreItemImage, {
      get itemid() {
        return showIDList()[0];
      }
    }));
    libs.setProp(_el$5, "style", {
      animationDuration: "6s"
    });
    libs.insert(_el$5, libs.createComponent(StoreItem.StoreItemImage, {
      get itemid() {
        return showIDList()[2];
      }
    }));
    libs.setProp(_el$6, "style", {
      animationDuration: "4s"
    });
    libs.insert(_el$6, libs.createComponent(StoreItem.StoreItemImage, {
      get itemid() {
        return showIDList()[1];
      }
    }));
    libs.insert(_el$, libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
      get children() {
        return [libs.createElement("Image", {
          id: "Title"
        }, null), libs.createComponent(EOM_Button.EOM_BaseButton, {
          id: "GoExchange",
          text: "#Store_Exchange_Button",
          onactivate: () => {
            SetShowPlusPreview(true);
          }
        }), (() => {
          const _el$8 = libs.createElement("Panel", {
            id: "CountdownMain"
          }, null);
          libs.insert(_el$8, libs.createComponent(EOM_Countdown.EOM_Countdown, {
            icon: true,
            text: "#Activity_EndTime",
            get endTime() {
              return activityData().end_time;
            }
          }));
          return _el$8;
        })(), libs.createComponent(Info, {
          id: "Info",
          text: "#Activity_RuleTitle",
          get tooltip_text() {
            return "#" + activityData().name + "_desc_" + params.activityID;
          }
        }), (() => {
          const _el$9 = libs.createElement("Panel", {
              id: "ShowBubble"
            }, null),
            _el$0 = libs.createElement("Panel", {
              id: "Bubble"
            }, _el$9);
            libs.createElement("Panel", {
              id: "RightArrow"
            }, _el$9);
          libs.insert(_el$0, libs.createComponent(StoreItem.StoreItemImage, {
            get itemid() {
              return showIDList()[2];
            }
          }));
          libs.effect(_$p => libs.setProp(_el$9, "visible", step() < 26, _$p));
          return _el$9;
        })(), (() => {
          const _el$10 = libs.createElement("Panel", {
            id: "ItemList"
          }, null);
          libs.insert(_el$10, libs.createComponent(libs.For, {
            get each() {
              return showCardList();
            },
            children: (reward_id, index) => {
              const disable = libs.createMemo(() => step() + 2 <= toFiniteNumber(activity_starsea()[reward_id].reward_id));
              const received = libs.createMemo(() => activity_starsea()[reward_id].reward_id <= step());
              return [libs.createComponent(RewardItem, libs.mergeProps$1(() => activity_starsea()[reward_id], {
                get activity_id() {
                  return params.activityID;
                },
                get disabled() {
                  return disable();
                },
                get received() {
                  return received();
                }
              })), (() => {
                const _el$11 = libs.createElement("Image", {
                  id: "Arrow"
                }, null);
                libs.effect(_$p => libs.setProp(_el$11, "visible", index() != showCardList().length - 1, _$p));
                return _el$11;
              })()];
            }
          }));
          return _el$10;
        })()];
      }
    }), null);
    libs.insert(_el$, libs.createComponent(ExchangeStore.ExchangeStore, {
      tag: "StarseaShop",
      get show() {
        return showPlusPreview();
      },
      onclose: () => SetShowPlusPreview(false)
    }), null);
    return _el$;
  })();
}
const RewardItem = itemInfo => {
  const itemID = Object.keys(itemInfo.rewards)[0];
  const itemCount = itemInfo.rewards[itemID];
  const itemData = KeyValues.info_shop_product[itemInfo.product_id];
  return (() => {
    const _el$12 = libs.createElement("Panel", {
        get id() {
          return "RewardID" + itemInfo.reward_id;
        },
        "class": "RewardItem"
      }, null);
      libs.createElement("Image", {
        id: "Icon"
      }, _el$12);
      const _el$14 = libs.createElement("Label", {
        id: "ItemCount",
        text: "×" + itemCount
      }, _el$12),
      _el$15 = libs.createElement("Label", {
        id: "ItemName",
        get text() {
          return "#" + (itemInfo.product_id == 0 ? itemID : itemInfo.product_id);
        }
      }, _el$12);
    libs.insert(_el$12, libs.createComponent(libs.Switch, {
      get fallback() {
        return libs.createComponent(StoreItem.StoreItemImage, {
          itemid: itemID
        });
      },
      get children() {
        return libs.createComponent(libs.Match, {
          get when() {
            return itemInfo.product_id != 0;
          },
          get children() {
            return libs.createComponent(StoreItem.StoreItemImage, {
              get itemid() {
                return itemInfo.product_id;
              }
            });
          }
        });
      }
    }), _el$14);
    libs.setProp(_el$14, "visible", itemCount > 1);
    libs.setProp(_el$14, "text", "×" + itemCount);
    libs.insert(_el$12, libs.createComponent(libs.Show, {
      get when() {
        return itemInfo.disabled;
      },
      get children() {
        return libs.createElement("Image", {
          id: "Lock"
        }, null);
      }
    }), null);
    libs.insert(_el$12, libs.createComponent(libs.Switch, {
      get fallback() {
        return libs.createComponent(EOM_Button.EOM_Button, {
          color: "Confirm",
          id: "Receive",
          text: "#Store_Free_Button",
          onactivate: () => {
            if (!itemInfo.disabled) {
              CallAction("/v1/activity/receive_rewards", {
                activity_id: itemInfo.activity_id,
                reward_id: itemInfo.reward_id
              });
            }
          }
        });
      },
      get children() {
        return [libs.createComponent(libs.Match, {
          get when() {
            return itemInfo.received;
          },
          get children() {
            return libs.createElement("Image", {
              id: "Received"
            }, null);
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return itemInfo.product_id != 0;
          },
          get children() {
            return libs.createComponent(EOM_Button.EOM_Button, {
              id: "Receive",
              onactivate: () => {
                if (!itemInfo.disabled) {
                  ClientSideEvent("directly_purchase", {
                    itemid: itemInfo.product_id,
                    buy_count: 1,
                    source: "starsea"
                  });
                }
              },
              get children() {
                const _el$18 = libs.createElement("Panel", {
                    flowChildren: "right",
                    align: "center center"
                  }, null),
                  _el$19 = libs.createElement("Label", {
                    get text() {
                      return Float(GetStoreItemCost(itemData, 1));
                    }
                  }, _el$18);
                libs.setProp(_el$18, "flowChildren", "right");
                libs.setProp(_el$18, "align", "center center");
                libs.insert(_el$18, libs.createComponent(Player.CurrencyIcon, {
                  get tokenID() {
                    return itemData.pay_type;
                  }
                }), _el$19);
                libs.setProp(_el$19, "className", "CostLabel");
                libs.effect(_$p => libs.setProp(_el$19, "text", Float(GetStoreItemCost(itemData, 1)), _$p));
                return _el$18;
              }
            });
          }
        })];
      }
    }), null);
    libs.effect(_p$ => {
      const _v$ = "RewardID" + itemInfo.reward_id,
        _v$2 = {
          ["Rarity" + itemInfo.rarity]: true
        },
        _v$3 = "#" + (itemInfo.product_id == 0 ? itemID : itemInfo.product_id);
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$12, "id", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$12, "classList", _v$2, _p$._v$2));
      _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$15, "text", _v$3, _p$._v$3));
      return _p$;
    }, {
      _v$: undefined,
      _v$2: undefined,
      _v$3: undefined
    });
    return _el$12;
  })();
};

let activityDataMap = {};
for (const activity_id in KeyValues.activity_data) {
  const activity_data = KeyValues.activity_data[activity_id];
  activityDataMap[activity_data.name] = activity_data;
}
const ACTIVITY_DICE_ID = 801;
const storeActivityMenus = new Set(["battlepass", "growth_fund", "starsea"]);
const MENU_LIST = {
  first_celebration: [],
  battlepass: ["battlepass", "daily_task", "week_task"],
  growth_fund: ["growth_fund_301"],
  starsea: [],
  seven_days: [],
  mining: ["veins_game", "veins_rank", "veins_store", "veins_gift"]
};
const player_activity_tasks = solid_utils.createServiceNetData("player_activity_tasks", {});
const player_login_activity_data = solid_utils.createServiceNetData("player_login_activity_data", {});
const player_mining_activity_data = solid_utils.createServiceNetData("player_mining_activity_data", {});
const open_store = solid_utils.createServiceNetData("open_shop", {
  value: false
});
const getActivityMenuList = now => activity_menu.buildActivityMenuList({
  menuList: MENU_LIST,
  storeMenus: storeActivityMenus
}, {
  now,
  tasks: player_activity_tasks(),
  loginActivities: player_login_activity_data(),
  miningActivities: player_mining_activity_data(),
  openStore: open_store().value
});
function buildActivityViewSnapshot() {
  const now = CustomUIConfig.GetServerTimeStamp();
  return {
    menuList: getActivityMenuList(now),
    starseaActivityID: activity_menu.getActiveStarseaActivityID(now)
  };
}
const initialActivityViewSnapshot = buildActivityViewSnapshot();
const [displayStarseaActivityID, setDisplayStarseaActivityID] = libs.createSignal(initialActivityViewSnapshot.starseaActivityID);
const [displayMenuList, setDisplayMenuList] = libs.createSignal(initialActivityViewSnapshot.menuList);
function commitActivityViewSnapshot() {
  const snapshot = buildActivityViewSnapshot();
  libs.batch(() => {
    setDisplayStarseaActivityID(snapshot.starseaActivityID);
    setDisplayMenuList(currentMenuList => activity_menu.areActivityMenuListsEqual(currentMenuList, snapshot.menuList) ? currentMenuList : snapshot.menuList);
  });
}
const {
  LayoutMenu,
  show,
  secondTabName,
  menuName
} = EOM_MenuLayout.createMenuLayout("activity", displayMenuList, {
  beforeShow: commitActivityViewSnapshot
});
libs.createEffect(libs.on(show, visible => {
  if (!visible) commitActivityViewSnapshot();
}));
libs.createEffect(libs.on(() => open_store().value, () => {
  if (!show()) commitActivityViewSnapshot();
}));
libs.createEffect(() => {
  const tasks = player_activity_tasks();
  for (const activity_id in KeyValues.activity_data) {
    if (Number(activity_id) == ACTIVITY_DICE_ID) continue;
    const ad = KeyValues.activity_data[activity_id];
    if (!ad.config) continue;
    const config = SymbolSpliter(ad.config, "|", ";");
    if (!config.task_id) continue;
    const anyCanReceive = Object.values(tasks).some(task => {
      let kv = KeyValues.task[task.task_id];
      if (!kv || kv.type != 6) return false;
      if (!String(task.task_id).startsWith(config.task_id)) return false;
      return task.progress >= task.target && task.receive_progress != 1;
    });
    CustomUIConfig.SetRedPoint(anyCanReceive, "activity", String(ad.name));
  }
});
function ActivityRoot() {
  const activityData = libs.createMemo(() => {
    if (menuName() == "starsea") {
      const activityID = displayStarseaActivityID();
      return activityID == undefined ? undefined : KeyValues.activity_data[activityID];
    }
    return activityDataMap[menuName()];
  });
  const tokenIDs = libs.createMemo(() => {
    const data = activityData();
    if (data == undefined || data.tokens == undefined || data.tokens == "") {
      return [];
    }
    return data.tokens.split("|").map(Number);
  });
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout, {
    id: "ActivityRoot",
    name: "MenuButton_activity",
    renderOnShow: true,
    get show() {
      return show();
    },
    get children() {
      return [libs.createComponent(LayoutMenu, {}), libs.createComponent(Player.CurrencyGroup, {
        get tokens() {
          return tokenIDs();
        },
        get recentOrder() {
          return activityData()?.template == "starsea";
        }
      }), libs.createComponent(libs.Switch, {
        get children() {
          return [libs.createComponent(libs.Match, {
            get when() {
              return secondTabName() == "battlepass";
            },
            get children() {
              return libs.createComponent(BattlePass, {});
            }
          }), libs.createComponent(libs.Match, {
            get when() {
              return secondTabName() == "daily_task";
            },
            get children() {
              return libs.createComponent(DailyTask, {});
            }
          }), libs.createComponent(libs.Match, {
            get when() {
              return secondTabName() == "week_task";
            },
            get children() {
              return libs.createComponent(WeekTask, {});
            }
          }), libs.createComponent(libs.Match, {
            get when() {
              return activityData()?.template == "shop_and_task";
            },
            get children() {
              return libs.createComponent(ShopAndTask, {
                get activityID() {
                  return activityData().activity_id;
                }
              });
            }
          }), libs.createComponent(libs.Match, {
            get when() {
              return menuName() == "growth_fund";
            },
            get children() {
              return libs.createComponent(GrowthFund, {
                get activityID() {
                  return secondTabName().replace("growth_fund_", "");
                }
              });
            }
          }), libs.createComponent(libs.Match, {
            get when() {
              return libs.memo(() => menuName() == "starsea")() && displayStarseaActivityID() != undefined;
            },
            get children() {
              return libs.createComponent(StarSea, {
                get activityID() {
                  return displayStarseaActivityID();
                }
              });
            }
          }), libs.createComponent(libs.Match, {
            get when() {
              return menuName() == "seven_days";
            },
            get children() {
              return libs.createComponent(SevenDaysRoot, {});
            }
          }), libs.createComponent(libs.Match, {
            get when() {
              return secondTabName() == "veins_game";
            },
            get children() {
              return libs.createComponent(DigVeins, {});
            }
          }), libs.createComponent(libs.Match, {
            get when() {
              return secondTabName() == "veins_rank";
            },
            get children() {
              return libs.createComponent(VeinsRank, {});
            }
          }), libs.createComponent(libs.Match, {
            get when() {
              return secondTabName() == "veins_store";
            },
            get children() {
              return libs.createComponent(VeinsStore, {});
            }
          }), libs.createComponent(libs.Match, {
            get when() {
              return secondTabName() == "veins_gift";
            },
            get children() {
              return libs.createComponent(VeinsGift, {});
            }
          })];
        }
      })];
    }
  });
}
libs.render(() => libs.createComponent(ActivityRoot, {}), $.GetContextPanel());