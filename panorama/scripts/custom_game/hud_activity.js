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
var Player = require('./Player.js');
var solid_utils = require('./solid_utils.js');
var activity_menu = require('./activity_menu.js');
var EOM_Countdown = require('./EOM_Countdown.js');
var EOM_Button = require('./EOM_Button.js');
var EOM_DropDown = require('./EOM_DropDown.js');
var ExchangeStore = require('./ExchangeStore.js');
var RecycleView = require('./RecycleView.js');
var StoreItem = require('./StoreItem.js');
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

const DICE_EVENT_KEYS = ["move_dice", "move_pos", "move_neg", "move_start", "add_slot_exp", "add_type_exp", "receive_rewards", "receive_box", "generate_box", "reward_next_slot"];
const SORTED_DICE_EVENT_KEYS = [...DICE_EVENT_KEYS].sort((left, right) => right.length - left.length);
const DICE_EVENT_ARG_COUNTS = {
  move_dice: 1,
  move_pos: 1,
  move_neg: 1,
  move_start: 0,
  add_slot_exp: 2,
  add_type_exp: 2,
  receive_rewards: 1,
  receive_box: 3,
  generate_box: 1,
  reward_next_slot: 1
};
const getMatchedDiceEventKey = event => {
  return SORTED_DICE_EVENT_KEYS.find(key => event == key || event.startsWith(`${key}_`));
};
const getRawArgs = (event, key) => {
  if (event == key) {
    return [];
  }
  return event.slice(key.length + 1).split("_");
};
const parseNumberArgs = rawArgs => {
  const args = [];
  for (const rawArg of rawArgs) {
    if (!/^-?\d+$/.test(rawArg)) {
      return {
        args,
        reason: `invalid number arg: ${rawArg}`
      };
    }
    args.push(Number(rawArg));
  }
  return {
    args
  };
};
const parseDiceEvent = event => {
  const key = getMatchedDiceEventKey(event);
  if (key == undefined) {
    return {
      raw: event,
      key: "unknown",
      matched: false,
      valid: false,
      args: [],
      reason: "unknown dice event key"
    };
  }
  const rawArgs = getRawArgs(event, key);
  const numberArgsResult = parseNumberArgs(rawArgs);
  const args = numberArgsResult.args;
  if (numberArgsResult.reason != undefined) {
    return {
      raw: event,
      key,
      matched: true,
      valid: false,
      args,
      reason: numberArgsResult.reason
    };
  }
  const expectedArgCount = DICE_EVENT_ARG_COUNTS[key];
  if (args.length != expectedArgCount) {
    return {
      raw: event,
      key,
      matched: true,
      valid: false,
      args,
      reason: `invalid arg count: expected ${expectedArgCount}, got ${args.length}`
    };
  }
  return {
    raw: event,
    key,
    matched: true,
    valid: true,
    args: args
  };
};
const parseDicePlayResult = result => {
  return (result ?? []).map((item, index) => ({
    index,
    slotID: item.slot_id,
    event: parseDiceEvent(item.event),
    raw: item
  }));
};

const ACTIVITY_DICE_ID$3 = 801;
const DICE_ROLL_ONCE_TIMES = 1;
const DICE_ROLL_TEN_TIMES = 10;
const DICE_TILE_FINISH_EFFECT_DURATION_SECONDS = 3;
const DICE_TILE_LEVEL_UP_EFFECT_DURATION_SECONDS = 1.5;
const DICE_BOX_PREVIEW_DURATION_SECONDS = 2;
const SLOT_TYPE_START = 1;
const SLOT_TYPE_TOKEN = 2;
const SLOT_TYPE_EVENT = 3;
const SLOT_TYPE_REWARD = 4;
const DEFAULT_SLOT_LEVEL = 0;
const DEFAULT_TILE_CONFIG = {
  tileType: "stone",
  decorationType: "none",
  iconType: "none"
};
const STOREITEMIMAGE_SRCPATH = {
  [110013]: getSrcPath("activity/a4_dice/a4_product_token.png"),
  [110014]: getSrcPath("activity/a4_dice/a4_product_dice.png")
};
const SLOT_TYPE_TILE_CONFIG = {
  [SLOT_TYPE_START]: {
    tileType: "grass",
    decorationType: "start"
  },
  [SLOT_TYPE_EVENT]: {
    tileType: "grass",
    decorationType: "que"
  }
};
const SLOT_LEVEL_TILE_CONFIG = {
  0: "stone",
  1: "level1",
  2: "level2",
  3: "level3"
};
const SLOT_LEVEL_RARITY_CONFIG = {
  0: 1,
  1: 3,
  2: 4,
  3: 5
};
const REWARD_SLOT_ICON_CONFIG = {
  110011: "icon3",
  110006: "icon3",
  110009: "icon2",
  110010: "icon2",
  110013: "icon1",
  120001: "icon1",
  120002: "icon1",
  120003: "icon1",
  120008: "icon1"
};
const PLAYER_IDLE_SEQUENCE_FRAMES = [getSrcPath("activity/a4_dice/player_idle/1_1.png"), getSrcPath("activity/a4_dice/player_idle/1_2.png"), getSrcPath("activity/a4_dice/player_idle/1_3.png"), getSrcPath("activity/a4_dice/player_idle/1_4.png"), getSrcPath("activity/a4_dice/player_idle/1_5.png"), getSrcPath("activity/a4_dice/player_idle/1_6.png"), getSrcPath("activity/a4_dice/player_idle/1_7.png"), getSrcPath("activity/a4_dice/player_idle/1_8.png")];
const PLAYER_JUMP_SEQUENCE_FRAMES = [getSrcPath("activity/a4_dice/player_jump/2_1.png"), getSrcPath("activity/a4_dice/player_jump/2_2.png"), getSrcPath("activity/a4_dice/player_jump/2_3.png"), getSrcPath("activity/a4_dice/player_jump/2_4.png"), getSrcPath("activity/a4_dice/player_jump/2_5.png"), getSrcPath("activity/a4_dice/player_jump/2_6.png"), getSrcPath("activity/a4_dice/player_jump/2_7.png"), getSrcPath("activity/a4_dice/player_jump/2_8.png")];
const DICE_SEQUENCE_FRAMES = [getSrcPath("activity/a4_dice/dice_cube/1.png"), getSrcPath("activity/a4_dice/dice_cube/2.png"), getSrcPath("activity/a4_dice/dice_cube/3.png"), getSrcPath("activity/a4_dice/dice_cube/4.png"), getSrcPath("activity/a4_dice/dice_cube/5.png"), getSrcPath("activity/a4_dice/dice_cube/6.png"), getSrcPath("activity/a4_dice/dice_cube/7.png"), getSrcPath("activity/a4_dice/dice_cube/8.png"), getSrcPath("activity/a4_dice/dice_cube/9.png"), getSrcPath("activity/a4_dice/dice_cube/10.png"), getSrcPath("activity/a4_dice/dice_cube/11.png")];
const DICE_RESULT_FRAME_BY_VALUE = {
  1: getSrcPath("activity/a4_dice/dice_cube/end_1.png"),
  2: getSrcPath("activity/a4_dice/dice_cube/end_2.png"),
  3: getSrcPath("activity/a4_dice/dice_cube/end_3.png"),
  4: getSrcPath("activity/a4_dice/dice_cube/end_4.png"),
  5: getSrcPath("activity/a4_dice/dice_cube/end_5.png"),
  6: getSrcPath("activity/a4_dice/dice_cube/end_6.png")
};
const SUMMARY_EVENT = {
  "add_type_exp": "#ActivityDice_SummaryEvent_AddTypeExp",
  "move_pos": "#ActivityDice_SummaryEvent_MovePos",
  "move_neg": "#ActivityDice_SummaryEvent_MoveNeg",
  "move_start": "#ActivityDice_SummaryEvent_MoveStart",
  "receive_box": "#ActivityDice_SummaryEvent_ReceiveBox",
  "generate_box": "#ActivityDice_SummaryEvent_GenerateBox"
};
const isDiceSummaryEventKey = key => key in SUMMARY_EVENT;
const PLAYER_SEQUENCE_FRAME_IDLE_INTERVAL = 130;
const PLAYER_SEQUENCE_FRAME_JUMP_INTERVAL = 70;
const DICE_SEQUENCE_FRAME_INTERVAL = 65;
const FAST_PLAYER_SEQUENCE_FRAME_JUMP_INTERVAL = 20;
const NORMAL_DICE_PLAYBACK_CONFIG = {
  playerJumpFrameIntervalMs: PLAYER_SEQUENCE_FRAME_JUMP_INTERVAL,
  diceFrameIntervalMs: DICE_SEQUENCE_FRAME_INTERVAL,
  playerMoveStepDurationSeconds: PLAYER_JUMP_SEQUENCE_FRAMES.length * PLAYER_SEQUENCE_FRAME_JUMP_INTERVAL / 1000,
  moveEventDelaySeconds: 1,
  eventLayerDisplayDurationSeconds: 2.5
};
const FAST_DICE_PLAYBACK_CONFIG = {
  playerJumpFrameIntervalMs: FAST_PLAYER_SEQUENCE_FRAME_JUMP_INTERVAL,
  diceFrameIntervalMs: 32,
  playerMoveStepDurationSeconds: PLAYER_JUMP_SEQUENCE_FRAMES.length * FAST_PLAYER_SEQUENCE_FRAME_JUMP_INTERVAL / 1000,
  moveEventDelaySeconds: 0,
  eventLayerDisplayDurationSeconds: 0.2
};
const DICE_BOARD_COLUMN_COUNT = 8;
const DICE_BOARD_ROW_COUNT = 7;
const DICE_BOARD_CELL_WIDTH = 96;
const DICE_BOARD_CELL_HEIGHT = 82;
const DICE_BOARD_ROW_OFFSET_X_LIST = [150, 100, 50, 0, -50, -100, -150];
const DICE_PLAYER_PIECE_SIZE = 400 * 0.5;
const DICE_PLAYER_ANCHOR_X = DICE_PLAYER_PIECE_SIZE / 2 + 50;
const DICE_PLAYER_ANCHOR_Y = DICE_PLAYER_PIECE_SIZE;
const DICE_PLAYER_OFFSET_X = 0;
const DICE_PLAYER_OFFSET_Y = 30;
const DICE_EVENT_LAYER_OFFSET_X = 12;
const DICE_EVENT_LAYER_OFFSET_Y = 0;
const TilePath = [8, 9, 10, 2, 3, 4, 5, 13, 14, 22, 30, 31, 39, 47, 46, 54, 53, 52, 51, 50, 42, 41, 33, 25, 24, 16];
const getBoardSlotConfigMap = activityID => {
  const boardSlotRewardConfig = KeyValues.activity_boardslot_reward ?? {};
  return Object.values(boardSlotRewardConfig).reduce((slotConfigMap, slotConfig) => {
    if (slotConfig.activity_id == activityID) {
      slotConfigMap[slotConfig.slot_id] = slotConfig;
    }
    return slotConfigMap;
  }, {});
};
const getBoardSlotConfigBySlotID = (activityID, slotID) => {
  return getBoardSlotConfigMap(activityID)[slotID];
};
const parseDiceNumberList = value => {
  if (value == undefined || value.length == 0) {
    return [];
  }
  return value.split("|").map(item => Number(item)).filter(item => Number.isFinite(item));
};
const getRewardNumList = slotConfig => {
  return parseDiceNumberList(slotConfig?.reward_num);
};
const getLevelupExpList = slotConfig => {
  return parseDiceNumberList(slotConfig?.levelup_exp);
};
const getSlotMaxLevel = slotConfig => {
  const rewardNumList = getRewardNumList(slotConfig);
  const levelupExpList = getLevelupExpList(slotConfig);
  return Math.max(DEFAULT_SLOT_LEVEL, rewardNumList.length > 0 ? rewardNumList.length - 1 : levelupExpList.length);
};
const clampSlotLevel = (slotConfig, level) => {
  const maxLevel = getSlotMaxLevel(slotConfig);
  const normalizedLevel = Number.isFinite(level) ? Math.trunc(Number(level)) : DEFAULT_SLOT_LEVEL;
  return Math.max(DEFAULT_SLOT_LEVEL, Math.min(maxLevel, normalizedLevel));
};
const calculateSlotLevelExp = (slotConfig, currentLevel, currentExp, addExp) => {
  const levelupExpList = getLevelupExpList(slotConfig);
  const maxLevel = getSlotMaxLevel(slotConfig);
  let level = clampSlotLevel(slotConfig, currentLevel);
  let exp = Math.max(0, Number(currentExp) || 0) + Math.max(0, addExp);
  while (level < maxLevel) {
    const needExp = levelupExpList[level];
    if (needExp == undefined || needExp <= 0 || exp < needExp) {
      break;
    }
    exp -= needExp;
    level += 1;
  }
  return {
    level,
    exp
  };
};
const getSlotRewardAmount = (slotConfig, level) => {
  const rewardNumList = getRewardNumList(slotConfig);
  if (rewardNumList.length == 0) {
    return 0;
  }
  const rewardLevel = clampSlotLevel(slotConfig, level);
  return rewardNumList[rewardLevel] ?? 0;
};
const isRewardSlot = slotConfig => {
  return slotConfig.slot_type == SLOT_TYPE_REWARD;
};
const isLevelableSlot = slotConfig => {
  return slotConfig.slot_type == SLOT_TYPE_TOKEN || slotConfig.slot_type == SLOT_TYPE_REWARD;
};
const getSlotTileType = (slotConfig, slotData) => {
  const level = clampSlotLevel(slotConfig, slotData?.level);
  return SLOT_LEVEL_TILE_CONFIG[level] ?? DEFAULT_TILE_CONFIG.tileType;
};
const getSlotRarity = level => {
  return SLOT_LEVEL_RARITY_CONFIG[level] ?? SLOT_LEVEL_RARITY_CONFIG[DEFAULT_SLOT_LEVEL];
};
const getTileConfigBySlotConfig = (slotConfig, slotData) => {
  if (slotConfig == undefined) {
    return DEFAULT_TILE_CONFIG;
  }
  const tileConfig = SLOT_TYPE_TILE_CONFIG[slotConfig.slot_type];
  if (tileConfig !== undefined) {
    return {
      ...tileConfig,
      decorationType: slotData?.with_box ? "box" : tileConfig.decorationType
    };
  }
  if (isLevelableSlot(slotConfig)) {
    const rewardID = Number(slotConfig.reward_id);
    return {
      tileType: getSlotTileType(slotConfig, slotData),
      iconType: isRewardSlot(slotConfig) ? REWARD_SLOT_ICON_CONFIG[rewardID] ?? "none" : "none",
      decorationType: slotData?.with_box ? "box" : slotConfig.slot_type == SLOT_TYPE_TOKEN ? "token" : "none"
    };
  }
  return DEFAULT_TILE_CONFIG;
};
const buildTileConfigMap = (activityID, activitySlotData) => {
  const slotConfigMap = getBoardSlotConfigMap(activityID);
  return TilePath.reduce((tileConfigMap, _tileIndex, index) => {
    const slotID = index + 1;
    const slotData = activitySlotData?.[slotID];
    tileConfigMap[slotID] = getTileConfigBySlotConfig(slotConfigMap[slotID], slotData);
    return tileConfigMap;
  }, {});
};
const getActivitySlotData = slotData => {
  return Object.values(slotData ?? {}).reduce((activitySlotData, data) => {
    if (data.activity_id == ACTIVITY_DICE_ID$3) {
      activitySlotData[data.slot_id] = data;
    }
    return activitySlotData;
  }, {});
};
const getActivityGameData = gameData => {
  return gameData?.[ACTIVITY_DICE_ID$3];
};
const getActivityBoardslotConfig = activityID => {
  return KeyValues.activity_boardslot?.[activityID];
};
const getDiceSlotTooltipData = (activityID, slotID, slotData) => {
  const slotConfig = getBoardSlotConfigBySlotID(activityID, slotID);
  if (slotConfig == undefined) {
    return undefined;
  }
  const levelable = isLevelableSlot(slotConfig);
  const level = clampSlotLevel(slotConfig, slotData?.level);
  const maxLevel = getSlotMaxLevel(slotConfig);
  const levelupExpList = getLevelupExpList(slotConfig);
  const requiredExp = levelupExpList[level] ?? 0;
  const currentExp = Math.max(0, Number(slotData?.extra_exp) || 0);
  const rewardID = Number(slotConfig.reward_id);
  const rewardAmount = getSlotRewardAmount(slotConfig, level);
  const rewards = [];
  const nextRewards = [];
  if (Number.isFinite(rewardID) && rewardAmount > 0) {
    rewards.push({
      item_id: rewardID,
      amount: rewardAmount,
      src_path: STOREITEMIMAGE_SRCPATH[rewardID]
    });
  }
  if (slotData?.with_box) {
    const boxID = 1800008;
    if (Number.isFinite(boxID) && boxID > 0) {
      rewards.push({
        item_id: boxID,
        amount: 1,
        src_path: STOREITEMIMAGE_SRCPATH[boxID]
      });
    }
  }
  const nextLevel = level + 1;
  const nextRewardAmount = levelable && level < maxLevel ? getSlotRewardAmount(slotConfig, nextLevel) : 0;
  if (Number.isFinite(rewardID) && nextRewardAmount > 0) {
    nextRewards.push({
      item_id: rewardID,
      amount: nextRewardAmount,
      src_path: STOREITEMIMAGE_SRCPATH[rewardID]
    });
  }
  const hasNextReward = nextRewards.length > 0;
  const nextRequiredExp = levelupExpList[nextLevel] ?? 0;
  const description = slotConfig.slot_type == SLOT_TYPE_START || slotConfig.slot_type == SLOT_TYPE_EVENT ? GetLocalization(`#ActivityDice_TileDescription_${slotConfig.slot_type}`) : "";
  return {
    title: GetLocalization(`#ActivityDice_TileType_${slotConfig.slot_type}`),
    level_key: levelable ? GetLocalization(`#ActivityDice_RewardRarity_${level}`) : undefined,
    rarity: levelable ? getSlotRarity(level) : undefined,
    exp_desc: levelable && level < maxLevel && requiredExp > 0 ? LocalizeWithVars(`#ActivityDice_DiceTooltip_ExpDesc`, {
      current_exp: currentExp,
      exp_max: requiredExp
    }) : "",
    description,
    rewards,
    next_level_key: hasNextReward ? GetLocalization(`#ActivityDice_RewardRarity_${nextLevel}`) : undefined,
    next_rarity: hasNextReward ? getSlotRarity(nextLevel) : undefined,
    next_exp_desc: hasNextReward && nextLevel < maxLevel && nextRequiredExp > 0 ? LocalizeWithVars(`#ActivityDice_DiceTooltip_ExpDesc`, {
      current_exp: 0,
      exp_max: nextRequiredExp
    }) : "",
    next_rewards: nextRewards
  };
};
const getPlayerPathIndexBySlotID = slotID => {
  if (slotID == undefined) {
    return 0;
  }
  const index = slotID - 1;
  if (index < 0 || index >= TilePath.length) {
    return 0;
  }
  return index;
};
const getDiceBoardRowOffsetX = rowIndex => {
  return DICE_BOARD_ROW_OFFSET_X_LIST[rowIndex] ?? 0;
};
const getDiceBoardPiecePosition = tileIndex => {
  const rowIndex = Math.floor(tileIndex / DICE_BOARD_COLUMN_COUNT);
  const columnIndex = tileIndex % DICE_BOARD_COLUMN_COUNT;
  return {
    left: columnIndex * DICE_BOARD_CELL_WIDTH + getDiceBoardRowOffsetX(rowIndex),
    top: rowIndex * DICE_BOARD_CELL_HEIGHT
  };
};
const normalizePlayerPathIndex = index => {
  return (index % TilePath.length + TilePath.length) % TilePath.length;
};
const isPlayerSlotFacingForward = pathIndex => {
  const slotID = normalizePlayerPathIndex(pathIndex) + 1;
  return slotID <= 6 || slotID >= 20;
};
const isDiceValue = value => {
  return value != undefined && value >= 1 && value <= 6;
};
const getValidDiceRollValue = parsedResult => {
  const {
    event
  } = parsedResult;
  if (event.key != "move_dice" || !event.valid) {
    return undefined;
  }
  const diceValue = event.args[0];
  return isDiceValue(diceValue) ? diceValue : undefined;
};
const getValidDiceRollValues = parsedResults => {
  return parsedResults.map(getValidDiceRollValue).filter(diceValue => diceValue != undefined);
};
const getBatchLastMovement = (startPathIndex, parsedResults) => {
  let currentPathIndex = startPathIndex;
  let lastMovement;
  for (const parsedResult of parsedResults) {
    const {
      event
    } = parsedResult;
    if (!event.matched || !event.valid) {
      continue;
    }
    switch (event.key) {
      case "move_dice":
        if (!isDiceValue(event.args[0])) {
          break;
        }
        currentPathIndex = normalizePlayerPathIndex(currentPathIndex + event.args[0]);
        lastMovement = {
          eventIndex: parsedResult.index,
          pathIndex: currentPathIndex
        };
        break;
      case "move_pos":
        currentPathIndex = normalizePlayerPathIndex(currentPathIndex + event.args[0]);
        lastMovement = {
          eventIndex: parsedResult.index,
          pathIndex: currentPathIndex
        };
        break;
      case "move_neg":
        currentPathIndex = normalizePlayerPathIndex(currentPathIndex - event.args[0]);
        lastMovement = {
          eventIndex: parsedResult.index,
          pathIndex: currentPathIndex
        };
        break;
      case "move_start":
        currentPathIndex = 0;
        lastMovement = {
          eventIndex: parsedResult.index,
          pathIndex: currentPathIndex
        };
        break;
    }
  }
  return lastMovement;
};
const buildDiceBoardLayoutRows = () => {
  const slotIDByTileIndex = TilePath.reduce((slotIDMap, tileIndex, index) => {
    slotIDMap[tileIndex] = index + 1;
    return slotIDMap;
  }, {});
  return Array.from({
    length: DICE_BOARD_ROW_COUNT
  }, (_, rowIndex) => Array.from({
    length: DICE_BOARD_COLUMN_COUNT
  }, (_, columnIndex) => {
    const tileIndex = rowIndex * DICE_BOARD_COLUMN_COUNT + columnIndex;
    const id = tileIndex + 1;
    const slotID = slotIDByTileIndex[tileIndex];
    const progress = `${tileIndex}/${DICE_BOARD_COLUMN_COUNT * DICE_BOARD_ROW_COUNT - 1}`;
    if (slotID === undefined) {
      return {
        id,
        tileIndex,
        progress,
        shouldRenderPiece: false
      };
    }
    return {
      id,
      tileIndex,
      progress,
      shouldRenderPiece: true,
      slotID
    };
  }));
};
const DICE_BOARD_LAYOUT_ROWS = buildDiceBoardLayoutRows();
const cloneDiceNetDataRecord = data => {
  if (data == undefined) {
    return undefined;
  }
  return Object.keys(data).reduce((clonedData, key) => {
    const numericKey = Number(key);
    clonedData[numericKey] = {
      ...data[numericKey]
    };
    return clonedData;
  }, {});
};
const getDiceTaskState = task => {
  if (task.receive_progress == 1) {
    return "Received";
  }
  if (task.progress >= task.target) {
    return "Claimable";
  }
  return "InProgress";
};
const isDiceTaskClaimable = task => getDiceTaskState(task) == "Claimable";
const isDiceTaskActive = (task, timestamp) => {
  const isActive = task.start_time <= timestamp && task.end_time >= timestamp;
  return isActive;
};
const getDiceTaskSortWeight = task => {
  switch (getDiceTaskState(task)) {
    case "Claimable":
      return 0;
    case "InProgress":
      return 1;
    case "Received":
      return 2;
  }
};
const getDiceTaskKey = task => `${task.task_id}_${task.extra_id}`;
const shouldShowDiceTaskGroup = tasks => tasks.some(task => getDiceTaskState(task) != "Received");
const player_activity_tasks$1 = solid_utils.createServiceNetData("player_activity_tasks", {});
const [diceTaskServerTime, setDiceTaskServerTime] = libs.createSignal(Math.floor(CustomUIConfig.GetServerTimeStamp()));
setInterval(() => {
  setDiceTaskServerTime(Math.floor(CustomUIConfig.GetServerTimeStamp()));
}, 1000);
const diceTasksByType = libs.createMemo(() => {
  const timestamp = diceTaskServerTime();
  const taskGroups = {
    6: [],
    7: []
  };
  Object.values(player_activity_tasks$1()).forEach(task => {
    const taskConfig = KeyValues.task[task.task_id];
    if (!taskConfig || taskConfig.activity_id != ACTIVITY_DICE_ID$3) return;
    if (taskConfig.type != 6 && taskConfig.type != 7) return;
    if (!isDiceTaskActive(task, timestamp)) return;
    taskGroups[taskConfig.type].push(task);
  });
  taskGroups[6].sort((a, b) => getDiceTaskSortWeight(a) - getDiceTaskSortWeight(b) || a.index - b.index || a.task_id - b.task_id);
  taskGroups[7].sort((a, b) => getDiceTaskSortWeight(a) - getDiceTaskSortWeight(b) || a.index - b.index || a.task_id - b.task_id);
  return taskGroups;
});
libs.createEffect(() => {
  const hasClaimableTask = diceTasksByType()[6].some(isDiceTaskClaimable) || diceTasksByType()[7].some(isDiceTaskClaimable);
  CustomUIConfig.SetRedPoint(hasClaimableTask, "activity", "boardslot", "dice_game");
});
function DiceTaskItem(props) {
  const taskConfig = libs.createMemo(() => KeyValues.task[props.task.task_id]);
  const reward = libs.createMemo(() => Object.entries(taskConfig().rewards ?? {})[0]);
  const taskState = libs.createMemo(() => getDiceTaskState(props.task));
  return (() => {
    const _el$ = libs.createElement("Panel", {
        get ["class"]() {
          return libs.classNames("DiceTaskItem", taskState(), {
            Claiming: props.claiming
          });
        }
      }, null);
      libs.createElement("Image", {
        "class": "DiceTaskItemBG"
      }, _el$);
      const _el$3 = libs.createElement("Panel", {
        "class": "DiceTaskItemLayer"
      }, _el$),
      _el$4 = libs.createElement("Panel", {
        "class": "DiceTaskContent"
      }, _el$3),
      _el$5 = libs.createElement("Panel", {
        "class": "DiceTaskHeader"
      }, _el$4),
      _el$6 = libs.createElement("Label", {
        "class": "DiceTaskTitle",
        get text() {
          return GetLocalization(`#Task_Name_${props.task.task_id}`);
        }
      }, _el$5),
      _el$7 = libs.createElement("Label", {
        "class": "DiceTaskProgress",
        get text() {
          return `(${Math.min(props.task.progress, props.task.target)}/${props.task.target})`;
        }
      }, _el$5),
      _el$8 = libs.createElement("Label", {
        "class": "DiceTaskDescription",
        get text() {
          return LocalizeWithVars(`#Task_Desc_${props.task.task_id}`, {
            target: GetLocalization(String(taskConfig().target)),
            v1: GetLocalization(String(taskConfig().param_1)),
            v2: GetLocalization(String(taskConfig().param_2)),
            v3: GetLocalization(String(taskConfig().param_3))
          });
        }
      }, _el$4);
      libs.createElement("Panel", {
        "class": "DiceTaskItemBottomLine"
      }, _el$);
    libs.setProp(_el$, "onactivate", () => {
      if (!isDiceTaskClaimable(props.task) || props.claiming) {
        return;
      }
      props.onClaim(props.task);
    });
    libs.insert(_el$3, libs.createComponent(libs.Show, {
      get when() {
        return reward();
      },
      children: rewardEntry => (() => {
        const _el$0 = libs.createElement("Panel", {
            "class": "DiceTaskReward"
          }, null);
          libs.createElement("Image", {
            "class": "DiceTaskRewardBG"
          }, _el$0);
          const _el$11 = libs.createElement("Label", {
            "class": "DiceTaskRewardValue",
            get text() {
              return String(rewardEntry()[1]);
            }
          }, _el$0);
        libs.insert(_el$0, libs.createComponent(libs.Show, {
          get when() {
            return taskState() == "Claimable";
          },
          get children() {
            return libs.createElement("Image", {
              "class": "DiceTaskBorder"
            }, null);
          }
        }), _el$11);
        libs.insert(_el$0, libs.createComponent(StoreItem.StoreItemImage, {
          "class": "DiceTaskRewardIcon",
          get itemid() {
            return rewardEntry()[0];
          },
          get src() {
            return STOREITEMIMAGE_SRCPATH[Number(rewardEntry()[0])];
          }
        }), _el$11);
        libs.effect(_$p => libs.setProp(_el$11, "text", String(rewardEntry()[1]), _$p));
        return _el$0;
      })()
    }), null);
    libs.effect(_p$ => {
      const _v$ = libs.classNames("DiceTaskItem", taskState(), {
          Claiming: props.claiming
        }),
        _v$2 = GetLocalization(`#Task_Name_${props.task.task_id}`),
        _v$3 = `(${Math.min(props.task.progress, props.task.target)}/${props.task.target})`,
        _v$4 = LocalizeWithVars(`#Task_Desc_${props.task.task_id}`, {
          target: GetLocalization(String(taskConfig().target)),
          v1: GetLocalization(String(taskConfig().param_1)),
          v2: GetLocalization(String(taskConfig().param_2)),
          v3: GetLocalization(String(taskConfig().param_3))
        });
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$, "class", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$6, "text", _v$2, _p$._v$2));
      _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$7, "text", _v$3, _p$._v$3));
      _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$8, "text", _v$4, _p$._v$4));
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
function DiceTaskGroup(props) {
  return (() => {
    const _el$12 = libs.createElement("Panel", {
        "class": "DiceTaskGroup"
      }, null),
      _el$13 = libs.createElement("Panel", {
        "class": "DiceTaskGroupTitle"
      }, _el$12);
      libs.createElement("Image", {
        "class": "DiceTaskGroupTitleBG"
      }, _el$13);
      const _el$15 = libs.createElement("Label", {
        get text() {
          return GetLocalization(`#ActivityDice_TaskTitleType_${props.taskType}`);
        }
      }, _el$13),
      _el$16 = libs.createElement("Panel", {
        "class": "DiceTaskGroupContent"
      }, _el$12);
    libs.insert(_el$16, libs.createComponent(libs.For, {
      get each() {
        return props.tasks;
      },
      children: task => libs.createComponent(DiceTaskItem, {
        task: task,
        get claiming() {
          return props.claimingTaskKey == getDiceTaskKey(task);
        },
        get onClaim() {
          return props.onClaim;
        }
      })
    }));
    libs.effect(_$p => libs.setProp(_el$15, "text", GetLocalization(`#ActivityDice_TaskTitleType_${props.taskType}`), _$p));
    return _el$12;
  })();
}
function DiceGamePiece(props) {
  return (() => {
    const _el$17 = libs.createElement("Panel", {
        "class": "DiceGamePiece"
      }, null),
      _el$18 = libs.createElement("Panel", {
        "class": "DiceGameTileRotate"
      }, _el$17),
      _el$19 = libs.createElement("Image", {
        get ["class"]() {
          return libs.classNames("DiceGamePieceBG", `PieceType_${props.tileType}`);
        }
      }, _el$18),
      _el$20 = libs.createElement("Image", {
        get ["class"]() {
          return libs.classNames("DiceGamePieceIcon", `IconType_${props.iconType}`);
        }
      }, _el$18),
      _el$21 = libs.createElement("Image", {
        get ["class"]() {
          return libs.classNames("DiceGamePieceDecoration", `DecorationType_${props.decorationType}`);
        }
      }, _el$18);
    libs.insert(_el$17, libs.createComponent(libs.Show, {
      get when() {
        return props.finishEffectToken;
      },
      keyed: true,
      children: () => libs.createElement("DOTAParticleScenePanel", {
        "class": "DiceGameTileEffect1",
        particleName: "particles/ui/game/ui_game_checkerboard/ui_game_checkerboard_fx.vpcf",
        cameraOrigin: "0 0 320",
        lookAt: "0 0 0",
        fov: 90,
        hittest: false
      }, null)
    }), null);
    libs.insert(_el$17, libs.createComponent(libs.Show, {
      get when() {
        return props.levelUpEffectToken;
      },
      keyed: true,
      children: () => libs.createElement("DOTAParticleScenePanel", {
        "class": "DiceGameTileEffectLevelUp",
        particleName: "particles/ui/game/ui_game_checkerboard/ui_game_checkerboard_up_fx.vpcf",
        cameraOrigin: "0 0 320",
        lookAt: "0 0 0",
        fov: 90,
        hittest: false
      }, null)
    }), null);
    libs.effect(_p$ => {
      const _v$5 = libs.classNames("DiceGamePieceBG", `PieceType_${props.tileType}`),
        _v$6 = libs.classNames("DiceGamePieceIcon", `IconType_${props.iconType}`),
        _v$7 = libs.classNames("DiceGamePieceDecoration", `DecorationType_${props.decorationType}`);
      _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$19, "class", _v$5, _p$._v$5));
      _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$20, "class", _v$6, _p$._v$6));
      _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$21, "class", _v$7, _p$._v$7));
      return _p$;
    }, {
      _v$5: undefined,
      _v$6: undefined,
      _v$7: undefined
    });
    return _el$17;
  })();
}
function DiceGamePiecePlaceholder() {
  return libs.createElement("Panel", {
    "class": "DiceGamePiecePlaceholder"
  }, null);
}
function DiceGamePlayerPiece(props) {
  const IdleSequenceFrame = props.IdleSequenceFrame;
  const JumpSequenceFrame = props.JumpSequenceFrame;
  return (() => {
    const _el$25 = libs.createElement("Panel", {
      get ["class"]() {
        return libs.classNames("DiceGamePlayerPiece", {
          PlayerMoving: props.positionTransitionEnabled,
          FastForward: props.fastForward,
          FacingForward: props.facingForward
        });
      },
      get style() {
        return {
          position: props.position
        };
      }
    }, null);
    libs.insert(_el$25, libs.createComponent(IdleSequenceFrame, {
      "class": "DiceGamePlayerSequenceFrame",
      get visible() {
        return !props.moving;
      }
    }), null);
    libs.insert(_el$25, libs.createComponent(JumpSequenceFrame, {
      "class": "DiceGamePlayerSequenceFrame",
      get visible() {
        return props.moving;
      }
    }), null);
    libs.effect(_p$ => {
      const _v$8 = libs.classNames("DiceGamePlayerPiece", {
          PlayerMoving: props.positionTransitionEnabled,
          FastForward: props.fastForward,
          FacingForward: props.facingForward
        }),
        _v$9 = {
          position: props.position
        };
      _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$25, "class", _v$8, _p$._v$8));
      _v$9 !== _p$._v$9 && (_p$._v$9 = libs.setProp(_el$25, "style", _v$9, _p$._v$9));
      return _p$;
    }, {
      _v$8: undefined,
      _v$9: undefined
    });
    return _el$25;
  })();
}
function DiceGameDiceCube(props) {
  const SequenceFrame = props.SequenceFrame;
  return (() => {
    const _el$26 = libs.createElement("Panel", {
      id: "DiceGameDiceCube",
      hittest: false,
      hittestchildren: false
    }, null);
    libs.insert(_el$26, libs.createComponent(SequenceFrame, {
      "class": "DiceGameDiceSequenceFrame"
    }));
    libs.effect(_$p => libs.setProp(_el$26, "visible", props.visible, _$p));
    return _el$26;
  })();
}
function Dice() {
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
  const [isMultiRollPlaying, setIsMultiRollPlaying] = libs.createSignal(false);
  const dicePlaybackConfig = libs.createMemo(() => isMultiRollPlaying() ? FAST_DICE_PLAYBACK_CONFIG : NORMAL_DICE_PLAYBACK_CONFIG);
  const playerIdle = createSequenceFrame({
    frames: PLAYER_IDLE_SEQUENCE_FRAMES,
    interval: PLAYER_SEQUENCE_FRAME_IDLE_INTERVAL,
    isLoop: true,
    autoPlay: true
  });
  const playerJump = createSequenceFrame({
    frames: PLAYER_JUMP_SEQUENCE_FRAMES,
    interval: () => dicePlaybackConfig().playerJumpFrameIntervalMs,
    isLoop: false,
    autoPlay: false
  });
  const [diceResult, setDiceResult] = libs.createSignal(1);
  const diceSequence = createSequenceFrame({
    frames: () => [...DICE_SEQUENCE_FRAMES, DICE_RESULT_FRAME_BY_VALUE[diceResult()]],
    interval: () => dicePlaybackConfig().diceFrameIntervalMs,
    isLoop: false,
    autoPlay: false
  });
  const activityData = libs.createMemo(() => KeyValues.activity_data[ACTIVITY_DICE_ID$3]);
  const [claimingTaskKey, setClaimingTaskKey] = libs.createSignal();
  const receiveDiceTaskReward = task => {
    const timestamp = Math.floor(CustomUIConfig.GetServerTimeStamp());
    if (!isDiceTaskActive(task, timestamp) || !isDiceTaskClaimable(task) || claimingTaskKey() != undefined) {
      return;
    }
    setClaimingTaskKey(getDiceTaskKey(task));
    CallActionRequest("/v1/task/receive_rewards", {
      task_id: task.task_id,
      extra_id: task.extra_id
    }, () => {
      setClaimingTaskKey(undefined);
    }, () => {
      setClaimingTaskKey(undefined);
    });
  };
  const diceTileData = solid_utils.createServiceNetData("player_boardslot_activity_slot_data", {});
  const diceGameData = solid_utils.createServiceNetData("player_boardslot_activity_data", {});
  const playerTokens = solid_utils.createServiceNetData("player_tokens", {});
  const playerProps = solid_utils.createServiceNetData("player_props", {});
  const [displayTileData, setDisplayTileData] = libs.createSignal(cloneDiceNetDataRecord(diceTileData()));
  const [displayGameData, setDisplayGameData] = libs.createSignal(cloneDiceNetDataRecord(diceGameData()));
  const [isDisplaySyncPaused, setIsDisplaySyncPaused] = libs.createSignal(false);
  const activityBoardslotConfig = libs.createMemo(() => getActivityBoardslotConfig(ACTIVITY_DICE_ID$3));
  const diceTicketID = libs.createMemo(() => activityBoardslotConfig()?.ticket_id ?? 0);
  const diceTicketCount = libs.createMemo(() => {
    playerTokens();
    playerProps();
    return GetServiceItemCount(diceTicketID());
  });
  const maxDiceRollTimes = libs.createMemo(() => Math.min(DICE_ROLL_TEN_TIMES, Math.max(0, Math.trunc(diceTicketCount()))));
  const diceRoll10ButtonTimes = libs.createMemo(() => maxDiceRollTimes() >= DICE_ROLL_ONCE_TIMES ? maxDiceRollTimes() : DICE_ROLL_TEN_TIMES);
  const hasEnoughDiceTicket = playTimes => diceTicketCount() >= playTimes;
  const activitySlotData = libs.createMemo(() => getActivitySlotData(displayTileData()));
  const activityGameData = libs.createMemo(() => getActivityGameData(displayGameData()));
  const nextSlotExtraExp = libs.createMemo(() => Math.max(0, Number(activityGameData()?.next_slot_extra_exp) || 0));
  const hasPlayerEvent = libs.createMemo(() => nextSlotExtraExp() > 0);
  const tileConfigMap = libs.createMemo(() => buildTileConfigMap(ACTIVITY_DICE_ID$3, activitySlotData()));
  const [diceEventQueue, setDiceEventQueue] = libs.createSignal([]);
  const [currentDiceEvent, setCurrentDiceEvent] = libs.createSignal();
  const [isExecutingDiceEvents, setIsExecutingDiceEvents] = libs.createSignal(false);
  const [currentBatchLastMovement, setCurrentBatchLastMovement] = libs.createSignal();
  const [playerPathIndex, setPlayerPathIndex] = libs.createSignal(0);
  const [remainingMoveSteps, setRemainingMoveSteps] = libs.createSignal(0);
  const [isPlayerMoveStepping, setIsPlayerMoveStepping] = libs.createSignal(false);
  const [playerMoveDirection, setPlayerMoveDirection] = libs.createSignal(0);
  const [isDiceVisible, setIsDiceVisible] = libs.createSignal(false);
  const [isRollRequesting, setIsRollRequesting] = libs.createSignal(false);
  const [isDiceEventLayerVisible, setIsDiceEventLayerVisible] = libs.createSignal(false);
  const [diceEventLayerPosition, setDiceEventLayerPosition] = libs.createSignal("0px 0px 0px");
  const [diceEventLayerTitle, setDiceEventLayerTitle] = libs.createSignal(GetLocalization("#ActivityDice_DiceEventTitle"));
  const [diceEventLayerDescription, setDiceEventLayerDescription] = libs.createSignal("");
  const [diceEventLayerType, setDiceEventLayerType] = libs.createSignal("good");
  const [isMultiRollPointLayerVisible, setIsMultiRollPointLayerVisible] = libs.createSignal(false);
  const [multiRollPointValue, setMultiRollPointValue] = libs.createSignal(1);
  const [multiRollCurrentIndex, setMultiRollCurrentIndex] = libs.createSignal(0);
  const [multiRollTotalCount, setMultiRollTotalCount] = libs.createSignal(0);
  const [multiRollSummaryItems, setMultiRollSummaryItems] = libs.createSignal([]);
  const [isMultiRollSummaryLayerVisible, setIsMultiRollSummaryLayerVisible] = libs.createSignal(false);
  const [isBoxPreviewLayerVisible, setIsBoxPreviewLayerVisible] = libs.createSignal(false);
  const [boxPreviewReward, setBoxPreviewReward] = libs.createSignal();
  const [finishTileEffect, setFinishTileEffect] = libs.createSignal();
  const [levelUpTileEffectTokens, setLevelUpTileEffectTokens] = libs.createSignal({});
  let moveScheduleID;
  let diceEventDelayScheduleID;
  let boxPreviewScheduleID;
  let finishTileEffectScheduleID;
  let nextTileEffectToken = 0;
  let diceEventRunID = 0;
  let finishDiceRoll;
  const pendingRewardItems = new Map();
  const levelUpTileEffectScheduleIDs = new Map();
  const clearMoveSchedule = () => {
    if (moveScheduleID !== undefined) {
      $.CancelScheduled(moveScheduleID);
      moveScheduleID = undefined;
    }
  };
  const clearDiceEventDelaySchedule = () => {
    if (diceEventDelayScheduleID !== undefined) {
      $.CancelScheduled(diceEventDelayScheduleID);
      diceEventDelayScheduleID = undefined;
    }
  };
  const clearBoxPreview = () => {
    if (boxPreviewScheduleID !== undefined) {
      $.CancelScheduled(boxPreviewScheduleID);
      boxPreviewScheduleID = undefined;
    }
    setIsBoxPreviewLayerVisible(false);
    setBoxPreviewReward(undefined);
  };
  const clearFinishTileEffectSchedule = () => {
    if (finishTileEffectScheduleID !== undefined) {
      $.CancelScheduled(finishTileEffectScheduleID);
      finishTileEffectScheduleID = undefined;
    }
  };
  const showFinishTileEffect = slotID => {
    clearFinishTileEffectSchedule();
    const token = ++nextTileEffectToken;
    setFinishTileEffect({
      slotID,
      token
    });
    finishTileEffectScheduleID = $.Schedule(DICE_TILE_FINISH_EFFECT_DURATION_SECONDS, () => {
      finishTileEffectScheduleID = undefined;
      setFinishTileEffect(currentEffect => currentEffect?.token == token ? undefined : currentEffect);
    });
  };
  const showLevelUpTileEffect = slotID => {
    const currentScheduleID = levelUpTileEffectScheduleIDs.get(slotID);
    if (currentScheduleID !== undefined) {
      $.CancelScheduled(currentScheduleID);
    }
    const token = ++nextTileEffectToken;
    setLevelUpTileEffectTokens(currentTokens => ({
      ...currentTokens,
      [slotID]: token
    }));
    const scheduleID = $.Schedule(DICE_TILE_LEVEL_UP_EFFECT_DURATION_SECONDS, () => {
      levelUpTileEffectScheduleIDs.delete(slotID);
      setLevelUpTileEffectTokens(currentTokens => {
        if (currentTokens[slotID] != token) {
          return currentTokens;
        }
        const nextTokens = {
          ...currentTokens
        };
        delete nextTokens[slotID];
        return nextTokens;
      });
    });
    levelUpTileEffectScheduleIDs.set(slotID, scheduleID);
  };
  const clearTileEffectSchedules = () => {
    clearFinishTileEffectSchedule();
    for (const scheduleID of levelUpTileEffectScheduleIDs.values()) {
      $.CancelScheduled(scheduleID);
    }
    levelUpTileEffectScheduleIDs.clear();
  };
  const syncDisplayDataFromNetData = () => {
    setDisplayTileData(cloneDiceNetDataRecord(diceTileData()));
    setDisplayGameData(cloneDiceNetDataRecord(diceGameData()));
  };
  const pauseDisplaySync = () => {
    syncDisplayDataFromNetData();
    setIsDisplaySyncPaused(true);
  };
  const resumeDisplaySync = () => {
    setIsDisplaySyncPaused(false);
    syncDisplayDataFromNetData();
  };
  const resetMultiRollState = () => {
    setIsMultiRollPlaying(false);
    setIsMultiRollPointLayerVisible(false);
    setMultiRollPointValue(1);
    setMultiRollCurrentIndex(0);
    setMultiRollTotalCount(0);
  };
  const clearMultiRollSummary = () => {
    setMultiRollSummaryItems([]);
    setIsMultiRollSummaryLayerVisible(false);
  };
  const clearPendingRewardItems = () => {
    pendingRewardItems.clear();
  };
  const initializePendingRewardItems = rewardItems => {
    clearPendingRewardItems();
    if (!Array.isArray(rewardItems)) {
      console.log("[DiceReward] missing add_items.common", rewardItems);
      return;
    }
    for (const rewardItem of rewardItems) {
      const {
        item_id: itemID,
        amounts,
        item_rarity: itemRarity
      } = rewardItem;
      if (!Number.isInteger(itemID) || itemID <= 0 || !Number.isFinite(amounts) || amounts <= 0) {
        console.log("[DiceReward] invalid reward item", rewardItem);
        continue;
      }
      const normalizedRarity = Number.isFinite(itemRarity) ? itemRarity : GetServiceItemRarity(itemID);
      if (!Number.isFinite(itemRarity)) {
        console.log("[DiceReward] invalid item rarity", rewardItem);
      }
      const pendingRewardItem = pendingRewardItems.get(itemID);
      if (pendingRewardItem == undefined) {
        pendingRewardItems.set(itemID, {
          item_id: itemID,
          amounts,
          item_rarity: normalizedRarity
        });
        continue;
      }
      if (pendingRewardItem.item_rarity != normalizedRarity) {
        console.log("[DiceReward] inconsistent item rarity", pendingRewardItem, rewardItem);
      }
      pendingRewardItems.set(itemID, {
        ...pendingRewardItem,
        amounts: pendingRewardItem.amounts + amounts
      });
    }
  };
  const getPendingRewardItems = () => Array.from(pendingRewardItems.values()).filter(rewardItem => rewardItem.amounts > 0);
  const emitDiceRewardToast = rewardItems => {
    if (rewardItems.length == 0) {
      return;
    }
    ClientSideEvent("ReceiveRewards", {
      json: JSON.stringify(rewardItems)
    });
  };
  const consumePendingRewardItem = rewardItem => {
    const pendingRewardItem = pendingRewardItems.get(rewardItem.item_id);
    if (pendingRewardItem == undefined) {
      console.log("[DiceReward] displayed reward missing from pending rewards", rewardItem);
      return;
    }
    if (rewardItem.amounts >= pendingRewardItem.amounts) {
      if (rewardItem.amounts > pendingRewardItem.amounts) {
        console.log("[DiceReward] displayed reward exceeds pending amount", rewardItem, pendingRewardItem);
      }
      pendingRewardItems.delete(rewardItem.item_id);
      return;
    }
    pendingRewardItems.set(rewardItem.item_id, {
      ...pendingRewardItem,
      amounts: pendingRewardItem.amounts - rewardItem.amounts
    });
  };
  const showAndConsumeDiceRewards = rewardItems => {
    emitDiceRewardToast(rewardItems);
    for (const rewardItem of rewardItems) {
      consumePendingRewardItem(rewardItem);
    }
  };
  const finishPendingRewardItems = () => {
    const remainingRewardItems = getPendingRewardItems();
    if (remainingRewardItems.length > 0) {
      console.log("[DiceReward] rewards remain after normal playback", remainingRewardItems);
    }
    clearPendingRewardItems();
  };
  const finishMultiRollState = () => {
    const shouldShowSummary = isMultiRollPlaying() && multiRollSummaryItems().length > 0;
    resetMultiRollState();
    setIsMultiRollSummaryLayerVisible(shouldShowSummary);
  };
  const syncPlayerPathIndexFromDisplayData = () => {
    setPlayerPathIndex(getPlayerPathIndexBySlotID(getActivityGameData(displayGameData())?.now_slot_id));
  };
  const updateDisplaySlotExp = (slotID, addExp) => {
    const slotConfig = getBoardSlotConfigBySlotID(ACTIVITY_DICE_ID$3, slotID);
    if (slotConfig == undefined) {
      console.log("[DiceEvent] missing slot config for add exp", slotID);
      return;
    }
    let didLevelUp = false;
    setDisplayTileData(currentData => {
      const nextData = cloneDiceNetDataRecord(currentData) ?? {};
      const currentSlotData = nextData[slotID];
      const currentSlotExp = currentSlotData?.extra_exp;
      const currentLevel = clampSlotLevel(slotConfig, currentSlotData?.level);
      const nextLevelExp = calculateSlotLevelExp(slotConfig, currentSlotData?.level, currentSlotExp, addExp);
      didLevelUp = nextLevelExp.level > currentLevel;
      nextData[slotID] = {
        ...(currentSlotData ?? {}),
        activity_id: ACTIVITY_DICE_ID$3,
        slot_id: slotID,
        level: nextLevelExp.level,
        extra_exp: nextLevelExp.exp
      };
      return nextData;
    });
    if (didLevelUp) {
      showLevelUpTileEffect(slotID);
    }
  };
  const getUpgradedSlotIDs = (currentData, finalData) => {
    const currentActivitySlotData = getActivitySlotData(currentData);
    const finalActivitySlotData = getActivitySlotData(finalData);
    const slotConfigMap = getBoardSlotConfigMap(ACTIVITY_DICE_ID$3);
    return Object.values(slotConfigMap).filter(slotConfig => isLevelableSlot(slotConfig)).filter(slotConfig => {
      const slotID = slotConfig.slot_id;
      const currentLevel = clampSlotLevel(slotConfig, currentActivitySlotData[slotID]?.level);
      const finalLevel = clampSlotLevel(slotConfig, finalActivitySlotData[slotID]?.level);
      return finalLevel > currentLevel;
    }).map(slotConfig => slotConfig.slot_id);
  };
  const updateDisplaySlotTypeExp = (slotType, addExp) => {
    const slotConfigMap = getBoardSlotConfigMap(ACTIVITY_DICE_ID$3);
    for (const slotConfig of Object.values(slotConfigMap)) {
      if (slotConfig.slot_type != slotType) {
        continue;
      }
      updateDisplaySlotExp(slotConfig.slot_id, addExp);
    }
  };
  const updateDisplaySlotBox = (slotID, withBox) => {
    if (getBoardSlotConfigBySlotID(ACTIVITY_DICE_ID$3, slotID) == undefined) {
      console.log("[DiceEvent] missing slot config for box update", slotID);
      return;
    }
    setDisplayTileData(currentData => {
      const nextData = cloneDiceNetDataRecord(currentData) ?? {};
      const currentSlotData = nextData[slotID];
      nextData[slotID] = {
        ...(currentSlotData ?? {}),
        activity_id: ACTIVITY_DICE_ID$3,
        slot_id: slotID,
        with_box: withBox
      };
      return nextData;
    });
  };
  const showDiceReceiveRewardToast = slotID => {
    const slotConfig = getBoardSlotConfigBySlotID(ACTIVITY_DICE_ID$3, slotID);
    if (slotConfig == undefined || slotConfig.reward_id == undefined || slotConfig.reward_id.length == 0) {
      console.log("[DiceEvent] missing reward config", slotID);
      return;
    }
    const slotData = activitySlotData()[slotID];
    const rewardID = Number(slotConfig.reward_id);
    const rewardAmount = getSlotRewardAmount(slotConfig, slotData?.level);
    if (!Number.isFinite(rewardID) || rewardAmount <= 0) {
      console.log("[DiceEvent] invalid reward data", slotID, slotConfig);
      return;
    }
    const rewardItem = {
      item_id: rewardID,
      amounts: rewardAmount,
      item_rarity: pendingRewardItems.get(rewardID)?.item_rarity ?? GetServiceItemRarity(rewardID)
    };
    showAndConsumeDiceRewards([rewardItem]);
  };
  const showDiceReceiveBoxToast = (itemID, amounts) => {
    const rewardItem = {
      item_id: itemID,
      amounts,
      item_rarity: pendingRewardItems.get(itemID)?.item_rarity ?? GetServiceItemRarity(itemID)
    };
    showAndConsumeDiceRewards([rewardItem]);
  };
  const playerPiecePosition = libs.createMemo(() => {
    const tileIndex = TilePath[playerPathIndex()];
    const piecePosition = getDiceBoardPiecePosition(tileIndex);
    const targetLeft = piecePosition.left + DICE_BOARD_CELL_WIDTH / 2;
    const targetTop = piecePosition.top + DICE_BOARD_CELL_HEIGHT / 2;
    const left = targetLeft - DICE_PLAYER_ANCHOR_X + DICE_PLAYER_OFFSET_X;
    const top = targetTop - DICE_PLAYER_ANCHOR_Y + DICE_PLAYER_OFFSET_Y;
    return `${left}px ${top}px 0px`;
  });
  const isPlayerPieceFacingForward = libs.createMemo(() => {
    const slotFacingForward = isPlayerSlotFacingForward(playerPathIndex());
    const isMovingBackward = playerMoveDirection() == -1;
    return slotFacingForward != isMovingBackward;
  });
  const showDiceEventLayer = () => {
    setIsDiceEventLayerVisible(true);
  };
  const hideDiceEventLayer = () => {
    setIsDiceEventLayerVisible(false);
  };
  const setDiceEventLayerContent = (description, eventType = "good") => {
    setDiceEventLayerTitle(GetLocalization("#ActivityDice_DiceEventTitle"));
    setDiceEventLayerDescription(description);
    setDiceEventLayerType(eventType);
  };
  const setDiceEventLayerPositionToSlot = slotID => {
    const pathIndex = getPlayerPathIndexBySlotID(slotID);
    const tileIndex = TilePath[pathIndex];
    const piecePosition = getDiceBoardPiecePosition(tileIndex);
    const left = piecePosition.left + DICE_BOARD_CELL_WIDTH + DICE_EVENT_LAYER_OFFSET_X;
    const top = piecePosition.top + DICE_EVENT_LAYER_OFFSET_Y;
    setDiceEventLayerPosition(`${left}px ${top}px 0px`);
  };
  const setupDiceEventLayer = (parsedResult, description, eventType = "good") => {
    setDiceEventLayerContent(description, eventType);
    setDiceEventLayerPositionToSlot(parsedResult.slotID);
  };
  const getDiceTileTypeLocalization = slotType => {
    return GetLocalization(`#ActivityDice_TileType_${slotType}`);
  };
  const getDiceEventDescription = parsedResult => {
    const {
      event
    } = parsedResult;
    if (!event.matched || !event.valid) {
      return "";
    }
    switch (event.key) {
      case "add_type_exp":
        return LocalizeWithVars("#ActivityDice_DiceEvent_AddTypeExp", {
          slot_type: getDiceTileTypeLocalization(event.args[0]),
          slot_exp: event.args[1]
        });
      case "add_slot_exp":
        {
          const slotConfig = getBoardSlotConfigBySlotID(ACTIVITY_DICE_ID$3, event.args[0]);
          return LocalizeWithVars("#ActivityDice_DiceEvent_AddTypeExp", {
            slot_type: getDiceTileTypeLocalization(slotConfig?.slot_type ?? 0),
            slot_exp: event.args[1]
          });
        }
      case "move_pos":
        return LocalizeWithVars("#ActivityDice_DiceEvent_MovePos", {
          step: event.args[0]
        });
      case "move_neg":
        return LocalizeWithVars("#ActivityDice_DiceEvent_MoveNeg", {
          step: event.args[0]
        });
      case "move_start":
        return GetLocalization("#ActivityDice_DiceEvent_MoveStart");
      case "reward_next_slot":
        return GetLocalization("#ActivityDice_DiceEvent_RewardNextSlot");
      default:
        return "";
    }
  };
  const formatAddTypeExpSummary = (parsedResult, localizationKey) => {
    const {
      event
    } = parsedResult;
    if (event.key != "add_type_exp" || !event.valid) {
      return undefined;
    }
    return LocalizeWithVars(localizationKey, {
      slot_type: getDiceTileTypeLocalization(event.args[0]),
      slot_exp: event.args[1]
    });
  };
  const formatMovePosSummary = (parsedResult, localizationKey) => {
    const {
      event
    } = parsedResult;
    if (event.key != "move_pos" || !event.valid) {
      return undefined;
    }
    return LocalizeWithVars(localizationKey, {
      step: event.args[0]
    });
  };
  const formatMoveNegSummary = (parsedResult, localizationKey) => {
    const {
      event
    } = parsedResult;
    if (event.key != "move_neg" || !event.valid) {
      return undefined;
    }
    return LocalizeWithVars(localizationKey, {
      step: event.args[0]
    });
  };
  const formatMoveStartSummary = (parsedResult, localizationKey) => {
    const {
      event
    } = parsedResult;
    if (event.key != "move_start" || !event.valid) {
      return undefined;
    }
    return GetLocalization(localizationKey);
  };
  const formatReceiveBoxSummary = (parsedResult, localizationKey) => {
    const {
      event
    } = parsedResult;
    if (event.key != "receive_box" || !event.valid) {
      return undefined;
    }
    return LocalizeWithVars(localizationKey, {
      item_name: GetLocalization(`#${event.args[1]}`),
      item_amount: event.args[2]
    });
  };
  const formatGenerateBoxSummary = (parsedResult, localizationKey) => {
    const {
      event
    } = parsedResult;
    if (event.key != "generate_box" || !event.valid) {
      return undefined;
    }
    return LocalizeWithVars(localizationKey, {
      slot: event.args[0]
    });
  };
  const diceSummaryEventFormatters = {
    add_type_exp: formatAddTypeExpSummary,
    move_pos: formatMovePosSummary,
    move_neg: formatMoveNegSummary,
    move_start: formatMoveStartSummary,
    receive_box: formatReceiveBoxSummary,
    generate_box: formatGenerateBoxSummary
  };
  const getDiceSummaryEventDescription = parsedResult => {
    const {
      event
    } = parsedResult;
    if (!event.matched || !event.valid || !isDiceSummaryEventKey(event.key)) {
      return undefined;
    }
    return diceSummaryEventFormatters[event.key](parsedResult, SUMMARY_EVENT[event.key]);
  };
  const buildDiceMultiRollSummary = parsedResults => {
    return parsedResults.map(getDiceSummaryEventDescription).filter(description => description != undefined && description.length > 0);
  };
  const isCurrentDiceEventRun = runID => {
    return runID == diceEventRunID;
  };
  const clearDiceAnimation = () => {
    finishDiceRoll = undefined;
    diceSequence.stop();
    setIsDiceVisible(false);
  };
  const movePlayerInstantlyToPathIndex = pathIndex => {
    clearMoveSchedule();
    playerJump.stop();
    setIsPlayerMoveStepping(false);
    setPlayerMoveDirection(0);
    setPlayerPathIndex(normalizePlayerPathIndex(pathIndex));
    setRemainingMoveSteps(0);
  };
  const movePlayerBySteps = (steps, done, runID) => {
    if (!isCurrentDiceEventRun(runID)) {
      return;
    }
    clearMoveSchedule();
    let remainingSteps = Math.abs(steps);
    const stepDirection = steps >= 0 ? 1 : -1;
    if (remainingSteps == 0) {
      setPlayerMoveDirection(0);
      done();
      return;
    }
    setRemainingMoveSteps(remainingSteps);
    setPlayerMoveDirection(stepDirection);
    const startNextMoveStep = () => {
      if (!isCurrentDiceEventRun(runID)) {
        return;
      }
      if (remainingSteps <= 0) {
        setRemainingMoveSteps(0);
        setIsPlayerMoveStepping(false);
        setPlayerMoveDirection(0);
        playerJump.stop();
        done();
        return;
      }
      setIsPlayerMoveStepping(true);
      setPlayerPathIndex(index => normalizePlayerPathIndex(index + stepDirection));
      playerJump.replay();
      Game.EmitSound("Hero_Zuus.Taunt.Jump");
      moveScheduleID = $.Schedule(dicePlaybackConfig().playerMoveStepDurationSeconds, () => {
        moveScheduleID = undefined;
        if (!isCurrentDiceEventRun(runID)) {
          return;
        }
        remainingSteps -= 1;
        setRemainingMoveSteps(remainingSteps);
        setIsPlayerMoveStepping(false);
        if (remainingSteps <= 0) {
          setPlayerMoveDirection(0);
          playerJump.stop();
          done();
          return;
        }
        startNextMoveStep();
      });
    };
    startNextMoveStep();
  };
  const movePlayerToPathIndex = (targetPathIndex, done, runID) => {
    if (!isCurrentDiceEventRun(runID)) {
      return;
    }
    movePlayerInstantlyToPathIndex(targetPathIndex);
    done();
  };
  const playDiceRoll = (value, done, runID) => {
    if (!isCurrentDiceEventRun(runID)) {
      return;
    }
    clearMoveSchedule();
    setDiceResult(value);
    setIsDiceVisible(true);
    diceSequence.replay();
    Game.EmitSound("UI.Dice.Roll");
    finishDiceRoll = () => {
      if (!isCurrentDiceEventRun(runID)) {
        return;
      }
      done();
    };
  };
  const resetDiceEventExecutionState = () => {
    clearMoveSchedule();
    clearDiceEventDelaySchedule();
    clearBoxPreview();
    clearDiceAnimation();
    playerJump.stop();
    hideDiceEventLayer();
    setRemainingMoveSteps(0);
    setIsPlayerMoveStepping(false);
    setPlayerMoveDirection(0);
    setCurrentDiceEvent(undefined);
    setDiceEventQueue([]);
    setIsExecutingDiceEvents(false);
  };
  const skipDiceEvents = () => {
    if (!isExecutingDiceEvents()) {
      return;
    }
    diceEventRunID += 1;
    const batchLastMovement = currentBatchLastMovement();
    const finalPathIndex = batchLastMovement?.pathIndex ?? playerPathIndex();
    const finalSlotID = normalizePlayerPathIndex(finalPathIndex) + 1;
    const upgradedSlotIDs = getUpgradedSlotIDs(displayTileData(), diceTileData());
    const remainingRewardItems = getPendingRewardItems();
    resetDiceEventExecutionState();
    finishMultiRollState();
    movePlayerInstantlyToPathIndex(finalPathIndex);
    setCurrentBatchLastMovement(undefined);
    resumeDisplaySync();
    syncPlayerPathIndexFromDisplayData();
    emitDiceRewardToast(remainingRewardItems);
    clearPendingRewardItems();
    if (batchLastMovement != undefined) {
      showFinishTileEffect(finalSlotID);
    }
    for (const slotID of upgradedSlotIDs) {
      showLevelUpTileEffect(slotID);
    }
  };
  const finishCurrentDiceEvent = runID => {
    if (!isCurrentDiceEventRun(runID)) {
      return;
    }
    const finishedEvent = currentDiceEvent();
    const isLastEvent = diceEventQueue().length <= 1;
    const batchLastMovement = currentBatchLastMovement();
    if (finishedEvent?.event.key == "move_dice") {
      clearDiceAnimation();
    }
    if (batchLastMovement != undefined && finishedEvent?.index == batchLastMovement.eventIndex) {
      const finalSlotID = normalizePlayerPathIndex(batchLastMovement.pathIndex) + 1;
      showFinishTileEffect(finalSlotID);
    }
    setDiceEventQueue(queue => queue.slice(1));
    setCurrentDiceEvent(undefined);
    setIsExecutingDiceEvents(false);
    if (isLastEvent) {
      finishMultiRollState();
      setCurrentBatchLastMovement(undefined);
      resumeDisplaySync();
      syncPlayerPathIndexFromDisplayData();
      finishPendingRewardItems();
    }
  };
  const executeMoveDiceEvent = (parsedResult, done, runID) => {
    const {
      event
    } = parsedResult;
    if (event.key != "move_dice" || !event.valid) {
      done();
      return;
    }
    const diceValue = event.args[0];
    if (!isDiceValue(diceValue)) {
      console.log("[DiceEvent] invalid dice value", parsedResult);
      done();
      return;
    }
    if (isMultiRollPointLayerVisible()) {
      const remainingRollCount = getValidDiceRollValues(diceEventQueue()).length;
      const currentRollIndex = multiRollTotalCount() - remainingRollCount + 1;
      setMultiRollPointValue(diceValue);
      setMultiRollCurrentIndex(Math.max(1, Math.min(multiRollTotalCount(), currentRollIndex)));
    }
    playDiceRoll(diceValue, () => {
      movePlayerBySteps(diceValue, done, runID);
    }, runID);
  };
  const executeMovePosEvent = (parsedResult, done, runID) => {
    const {
      event
    } = parsedResult;
    if (event.key != "move_pos" || !event.valid) {
      done();
      return;
    }
    if (isMultiRollPlaying()) {
      movePlayerBySteps(event.args[0], done, runID);
      return;
    }
    setupDiceEventLayer(parsedResult, getDiceEventDescription(parsedResult), "good");
    showDiceEventLayer();
    clearDiceEventDelaySchedule();
    diceEventDelayScheduleID = $.Schedule(dicePlaybackConfig().moveEventDelaySeconds, () => {
      diceEventDelayScheduleID = undefined;
      if (!isCurrentDiceEventRun(runID)) {
        return;
      }
      movePlayerBySteps(event.args[0], () => {
        hideDiceEventLayer();
        done();
      }, runID);
    });
  };
  const executeMoveNegEvent = (parsedResult, done, runID) => {
    const {
      event
    } = parsedResult;
    if (event.key != "move_neg" || !event.valid) {
      done();
      return;
    }
    if (isMultiRollPlaying()) {
      movePlayerBySteps(-event.args[0], done, runID);
      return;
    }
    setupDiceEventLayer(parsedResult, getDiceEventDescription(parsedResult), "bad");
    showDiceEventLayer();
    clearDiceEventDelaySchedule();
    diceEventDelayScheduleID = $.Schedule(dicePlaybackConfig().moveEventDelaySeconds, () => {
      diceEventDelayScheduleID = undefined;
      if (!isCurrentDiceEventRun(runID)) {
        return;
      }
      movePlayerBySteps(-event.args[0], () => {
        hideDiceEventLayer();
        done();
      }, runID);
    });
  };
  const executeMoveStartEvent = (parsedResult, done, runID) => {
    const {
      event
    } = parsedResult;
    if (event.key != "move_start" || !event.valid) {
      done();
      return;
    }
    if (isMultiRollPlaying()) {
      movePlayerToPathIndex(0, done, runID);
      return;
    }
    setupDiceEventLayer(parsedResult, getDiceEventDescription(parsedResult), "good");
    showDiceEventLayer();
    clearDiceEventDelaySchedule();
    diceEventDelayScheduleID = $.Schedule(dicePlaybackConfig().moveEventDelaySeconds, () => {
      diceEventDelayScheduleID = undefined;
      if (!isCurrentDiceEventRun(runID)) {
        return;
      }
      movePlayerToPathIndex(0, () => {
        hideDiceEventLayer();
        done();
      }, runID);
    });
  };
  const executeTimedDiceEvent = (parsedResult, done, runID) => {
    if (isMultiRollPlaying()) {
      done();
      return;
    }
    setupDiceEventLayer(parsedResult, getDiceEventDescription(parsedResult), "good");
    showDiceEventLayer();
    clearDiceEventDelaySchedule();
    diceEventDelayScheduleID = $.Schedule(dicePlaybackConfig().eventLayerDisplayDurationSeconds, () => {
      diceEventDelayScheduleID = undefined;
      if (!isCurrentDiceEventRun(runID)) {
        return;
      }
      hideDiceEventLayer();
      done();
    });
  };
  const executeAddSlotExpEvent = (parsedResult, done, _runID) => {
    const {
      event
    } = parsedResult;
    if (event.key != "add_slot_exp" || !event.valid) {
      done();
      return;
    }
    updateDisplaySlotExp(event.args[0], event.args[1]);
    done();
  };
  const executeAddTypeExpEvent = (parsedResult, done, runID) => {
    const {
      event
    } = parsedResult;
    if (event.key != "add_type_exp" || !event.valid) {
      done();
      return;
    }
    updateDisplaySlotTypeExp(event.args[0], event.args[1]);
    executeTimedDiceEvent(parsedResult, done, runID);
  };
  const executeReceiveRewardsEvent = (parsedResult, done) => {
    const {
      event
    } = parsedResult;
    if (event.key != "receive_rewards" || !event.valid) {
      done();
      return;
    }
    showDiceReceiveRewardToast(event.args[0]);
    done();
  };
  const executeReceiveBoxEvent = (parsedResult, done, runID) => {
    const {
      event
    } = parsedResult;
    if (event.key != "receive_box" || !event.valid) {
      done();
      return;
    }
    const [slotID, itemID, itemAmounts] = event.args;
    if (!Number.isInteger(slotID) || slotID <= 0 || !Number.isInteger(itemID) || itemID <= 0 || !Number.isFinite(itemAmounts) || itemAmounts <= 0) {
      console.log("[DiceEvent] invalid receive box data", parsedResult);
      done();
      return;
    }
    updateDisplaySlotBox(slotID, false);
    showDiceReceiveBoxToast(itemID, itemAmounts);
    Game.EmitSound("UI.Dice.Treasure");
    if (isMultiRollPlaying()) {
      done();
      return;
    }
    clearBoxPreview();
    setBoxPreviewReward({
      item_id: itemID,
      amounts: itemAmounts,
      item_rarity: pendingRewardItems.get(itemID)?.item_rarity ?? GetServiceItemRarity(itemID)
    });
    setIsBoxPreviewLayerVisible(true);
    boxPreviewScheduleID = $.Schedule(DICE_BOX_PREVIEW_DURATION_SECONDS, () => {
      boxPreviewScheduleID = undefined;
      if (!isCurrentDiceEventRun(runID)) {
        return;
      }
      setIsBoxPreviewLayerVisible(false);
      setBoxPreviewReward(undefined);
      done();
    });
  };
  const executeGenerateBoxEvent = (parsedResult, done) => {
    const {
      event
    } = parsedResult;
    if (event.key != "generate_box" || !event.valid) {
      done();
      return;
    }
    updateDisplaySlotBox(event.args[0], true);
    done();
  };
  const diceEventExecutors = {
    move_dice: executeMoveDiceEvent,
    add_type_exp: executeAddTypeExpEvent,
    add_slot_exp: executeAddSlotExpEvent,
    receive_rewards: executeReceiveRewardsEvent,
    receive_box: executeReceiveBoxEvent,
    generate_box: executeGenerateBoxEvent,
    move_pos: executeMovePosEvent,
    move_neg: executeMoveNegEvent,
    move_start: executeMoveStartEvent,
    reward_next_slot: executeTimedDiceEvent
  };
  const executeDiceEvent = (parsedResult, done, runID) => {
    const {
      event
    } = parsedResult;
    if (!event.matched || !event.valid) {
      console.log("[DiceEvent] invalid or unknown event", parsedResult);
      done();
      return;
    }
    const executor = diceEventExecutors[event.key];
    if (executor == undefined) {
      console.log("[DiceEvent] unhandled event", parsedResult);
      done();
      return;
    }
    executor(parsedResult, done, runID);
  };
  const requestRollDice = playTimes => {
    if (isRollRequesting() || isExecutingDiceEvents() || diceEventQueue().length > 0) {
      return;
    }
    const actualPlayTimes = Math.min(Math.max(0, Math.trunc(playTimes)), Math.max(0, Math.trunc(diceTicketCount())));
    if (actualPlayTimes < DICE_ROLL_ONCE_TIMES) {
      ErrorMessage(GetLocalization("#ActivityDice_RollTokenNotAllow"));
      return;
    }
    resetMultiRollState();
    clearMultiRollSummary();
    clearBoxPreview();
    clearPendingRewardItems();
    setCurrentBatchLastMovement(undefined);
    pauseDisplaySync();
    const gameData = activityGameData();
    setIsRollRequesting(true);
    CallActionRequest("/v1/activity/play_boardslot", {
      activity_id: ACTIVITY_DICE_ID$3,
      play_times: actualPlayTimes,
      play_num: gameData?.play_num ?? 0
    }, result => {
      setIsRollRequesting(false);
      if (result.code != 0 && result.code != 200) {
        console.log("[DiceEvent] roll dice request failed");
        resetMultiRollState();
        clearMultiRollSummary();
        clearPendingRewardItems();
        resumeDisplaySync();
        syncPlayerPathIndexFromDisplayData();
        if (result.message != undefined) {
          ErrorMessage(result.message);
        }
        return;
      }
      const gameResult = result.data?.player_boardslot_activity_play_result;
      if (!Array.isArray(gameResult) || gameResult.length == 0) {
        console.log("[DiceEvent] roll dice request returned empty result");
        resetMultiRollState();
        clearMultiRollSummary();
        clearPendingRewardItems();
        resumeDisplaySync();
        syncPlayerPathIndexFromDisplayData();
        return;
      }
      const parsedResults = parseDicePlayResult(gameResult);
      if (parsedResults.length == 0) {
        console.log("[DiceEvent] roll dice request returned no valid events");
        resetMultiRollState();
        clearMultiRollSummary();
        clearPendingRewardItems();
        resumeDisplaySync();
        syncPlayerPathIndexFromDisplayData();
        return;
      }
      const diceRollValues = getValidDiceRollValues(parsedResults);
      initializePendingRewardItems(result.data?.add_items?.common);
      if (actualPlayTimes > DICE_ROLL_ONCE_TIMES && diceRollValues.length > DICE_ROLL_ONCE_TIMES) {
        setIsMultiRollPlaying(true);
        setMultiRollPointValue(diceRollValues[0]);
        setMultiRollCurrentIndex(1);
        setMultiRollTotalCount(diceRollValues.length);
        setIsMultiRollPointLayerVisible(true);
        setMultiRollSummaryItems(buildDiceMultiRollSummary(parsedResults));
        setIsMultiRollSummaryLayerVisible(false);
      } else {
        resetMultiRollState();
        clearMultiRollSummary();
      }
      setCurrentBatchLastMovement(getBatchLastMovement(playerPathIndex(), parsedResults));
      setDiceEventQueue(currentQueue => [...currentQueue, ...parsedResults]);
    }, () => {
      console.log("[DiceEvent] roll dice request failed (network error) ");
      setIsRollRequesting(false);
      resetMultiRollState();
      clearMultiRollSummary();
      clearPendingRewardItems();
      resumeDisplaySync();
      syncPlayerPathIndexFromDisplayData();
    }, false);
  };
  libs.createEffect(() => {
    const latestTileData = diceTileData();
    const latestGameData = diceGameData();
    if (isDisplaySyncPaused()) {
      return;
    }
    setDisplayTileData(cloneDiceNetDataRecord(latestTileData));
    setDisplayGameData(cloneDiceNetDataRecord(latestGameData));
  });
  libs.createEffect(() => {
    if (isExecutingDiceEvents()) {
      return;
    }
    const nextEvent = diceEventQueue()[0];
    if (nextEvent == undefined) {
      return;
    }
    const runID = diceEventRunID;
    setCurrentDiceEvent(nextEvent);
    setIsExecutingDiceEvents(true);
    executeDiceEvent(nextEvent, () => finishCurrentDiceEvent(runID), runID);
  });
  libs.createEffect(() => {
    if (!isDiceVisible() || !diceSequence.isFinished()) {
      return;
    }
    finishDiceRoll?.();
    finishDiceRoll = undefined;
  });
  const isPlayerMoving = libs.createMemo(() => remainingMoveSteps() > 0);
  const isRollBusy = libs.createMemo(() => isRollRequesting() || isExecutingDiceEvents() || diceEventQueue().length > 0 || isDisplaySyncPaused());
  const canRollDice = libs.createMemo(() => !isRollBusy());
  libs.createEffect(() => {
    if (isDisplaySyncPaused()) {
      return;
    }
    if (isExecutingDiceEvents()) {
      return;
    }
    syncPlayerPathIndexFromDisplayData();
  });
  libs.onCleanup(() => {
    clearMoveSchedule();
    clearDiceEventDelaySchedule();
    clearBoxPreview();
    clearTileEffectSchedules();
    clearPendingRewardItems();
  });
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
    id: "SubMenu_dice",
    get children() {
      return [(() => {
        const _el$27 = libs.createElement("Panel", {
            id: "DiceTopRight"
          }, null),
          _el$28 = libs.createElement("Panel", {
            id: "DiceTopTitle"
          }, _el$27),
          _el$29 = libs.createElement("Image", {
            id: "DiceTopTitleIcon",
            get ["class"]() {
              return logoLang();
            }
          }, _el$28),
          _el$30 = libs.createElement("Image", {
            id: "DiceTopTitleTooltipIcon",
            get ["class"]() {
              return logoLang();
            }
          }, _el$28),
          _el$31 = libs.createElement("Panel", {
            id: "DiceTopSubTitle"
          }, _el$27);
          libs.createElement("Image", {
            id: "DiceTopSubTitleBG"
          }, _el$31);
          const _el$33 = libs.createElement("Panel", {
            id: "DiceActivityTask"
          }, _el$27);
          libs.createElement("Image", {
            id: "DiceActivityTaskBG"
          }, _el$33);
          const _el$35 = libs.createElement("Panel", {
            id: "DiceActivityTaskContent",
            scroll: "y"
          }, _el$33);
        libs.insert(_el$31, libs.createComponent(EOM_Countdown.EOM_Countdown, {
          icon: true,
          text: "#ActivityDice_TimeLimit",
          get endTime() {
            return activityData().end_time;
          }
        }), null);
        libs.setProp(_el$35, "scroll", "y");
        libs.insert(_el$35, libs.createComponent(DiceTaskGroup, {
          taskType: 7,
          get tasks() {
            return diceTasksByType()[7];
          },
          get claimingTaskKey() {
            return claimingTaskKey();
          },
          onClaim: receiveDiceTaskReward
        }), null);
        libs.insert(_el$35, libs.createComponent(libs.Show, {
          get when() {
            return shouldShowDiceTaskGroup(diceTasksByType()[6]);
          },
          get children() {
            return libs.createComponent(DiceTaskGroup, {
              taskType: 6,
              get tasks() {
                return diceTasksByType()[6];
              },
              get claimingTaskKey() {
                return claimingTaskKey();
              },
              onClaim: receiveDiceTaskReward
            });
          }
        }), null);
        libs.effect(_p$ => {
          const _v$0 = logoLang(),
            _v$1 = logoLang(),
            _v$10 = GetLocalization("#ActivityDice_TitleTooltip");
          _v$0 !== _p$._v$0 && (_p$._v$0 = libs.setProp(_el$29, "class", _v$0, _p$._v$0));
          _v$1 !== _p$._v$1 && (_p$._v$1 = libs.setProp(_el$30, "class", _v$1, _p$._v$1));
          _v$10 !== _p$._v$10 && (_p$._v$10 = libs.setProp(_el$30, "tooltip_text", _v$10, _p$._v$10));
          return _p$;
        }, {
          _v$0: undefined,
          _v$1: undefined,
          _v$10: undefined
        });
        return _el$27;
      })(), (() => {
        const _el$36 = libs.createElement("Panel", {
            id: "DiceGameContainer"
          }, null),
          _el$37 = libs.createElement("Panel", {
            id: "DiceGameBoardLocation"
          }, _el$36);
          libs.createElement("Image", {
            id: "DiceGameBoardBG"
          }, _el$37);
          const _el$39 = libs.createElement("Panel", {
            id: "DiceGamePieceLayerRotated"
          }, _el$37),
          _el$40 = libs.createElement("Panel", {
            id: "DiceGamePieceGrid"
          }, _el$39),
          _el$41 = libs.createElement("Panel", {
            id: "DiceGamePlayerLayer",
            hittest: false,
            hittestchildren: false
          }, _el$39),
          _el$42 = libs.createElement("Panel", {
            id: "DiceEventLayer",
            "class": "DiceLayer",
            get style() {
              return {
                position: diceEventLayerPosition()
              };
            },
            hittest: false,
            hittestchildren: false
          }, _el$37);
          libs.createElement("Panel", {
            "class": "DiceLayerBG"
          }, _el$42);
          libs.createElement("Panel", {
            "class": "DiceLayerBorder"
          }, _el$42);
          const _el$45 = libs.createElement("Image", {
            id: "DiceEventHeadIcon",
            get ["class"]() {
              return libs.classNames({
                DiceEventGoodEvent: diceEventLayerType() == "good",
                DiceEventBadEvent: diceEventLayerType() == "bad"
              });
            }
          }, _el$42),
          _el$46 = libs.createElement("Panel", {
            "class": "DiceLayerContent"
          }, _el$42),
          _el$47 = libs.createElement("Panel", {
            "class": "DiceLayerTitleContent"
          }, _el$46),
          _el$48 = libs.createElement("Label", {
            "class": "DiceLayerTitleContentText",
            get text() {
              return diceEventLayerTitle();
            }
          }, _el$47),
          _el$49 = libs.createElement("Panel", {
            "class": "DiceLayerBodyContent"
          }, _el$46),
          _el$50 = libs.createElement("Label", {
            "class": "DiceLayerContentDesc",
            get text() {
              return diceEventLayerDescription();
            }
          }, _el$49),
          _el$51 = libs.createElement("Panel", {
            id: "DiceMultiRollPointLayer",
            "class": "DiceLayer",
            hittest: false,
            hittestchildren: false
          }, _el$37);
          libs.createElement("Panel", {
            "class": "DiceLayerBG"
          }, _el$51);
          libs.createElement("Panel", {
            "class": "DiceLayerBorder"
          }, _el$51);
          const _el$54 = libs.createElement("Panel", {
            "class": "DiceLayerContent"
          }, _el$51),
          _el$55 = libs.createElement("Panel", {
            "class": "DiceLayerTitleContent"
          }, _el$54),
          _el$56 = libs.createElement("Label", {
            "class": "DiceLayerTitleContentText",
            get text() {
              return GetLocalization("#ActivityDice_MultiRollPointTitle");
            }
          }, _el$55),
          _el$57 = libs.createElement("Panel", {
            "class": "DiceLayerBodyContent"
          }, _el$54),
          _el$58 = libs.createElement("Label", {
            id: "DiceMultiRollPointValue",
            "class": "DiceLayerContentDesc",
            get text() {
              return `${multiRollPointValue()}`;
            }
          }, _el$57),
          _el$59 = libs.createElement("Label", {
            id: "DiceMultiRollPointProgress",
            "class": "DiceLayerContentDesc",
            get text() {
              return `${multiRollCurrentIndex()}/${multiRollTotalCount()}`;
            }
          }, _el$57),
          _el$60 = libs.createElement("Panel", {
            id: "DiceMultiBoxPreviewLayer",
            "class": "DiceLayer",
            hittest: false,
            hittestchildren: true
          }, _el$37);
          libs.createElement("Panel", {
            "class": "DiceLayerBG"
          }, _el$60);
          libs.createElement("Panel", {
            "class": "DiceLayerBorder"
          }, _el$60);
          const _el$63 = libs.createElement("Panel", {
            "class": "DiceLayerContent"
          }, _el$60),
          _el$64 = libs.createElement("Panel", {
            "class": "DiceLayerTitleContent"
          }, _el$63),
          _el$65 = libs.createElement("Label", {
            "class": "DiceLayerTitleContentText",
            get text() {
              return GetLocalization("#ActivityDice_BoxRewardPreviewTitle");
            }
          }, _el$64),
          _el$66 = libs.createElement("Panel", {
            "class": "DiceLayerBodyContent"
          }, _el$63),
          _el$67 = libs.createElement("Label", {
            "class": "DiceLayerContentDesc",
            get text() {
              return GetLocalization("#ActivityDice_BoxRewardPreviewContent");
            }
          }, _el$66),
          _el$68 = libs.createElement("Panel", {
            "class": "DiceTaskReward"
          }, _el$66);
          libs.createElement("Image", {
            "class": "DiceTaskRewardBG"
          }, _el$68);
          const _el$70 = libs.createElement("Label", {
            "class": "DiceTaskRewardValue",
            get text() {
              return boxPreviewReward()?.amounts ?? 0;
            }
          }, _el$68),
          _el$71 = libs.createElement("Panel", {
            id: "DiceMultiRollSummaryLayer",
            "class": "DiceLayer",
            hittest: true,
            hittestchildren: true
          }, _el$37);
          libs.createElement("Panel", {
            "class": "DiceLayerBG"
          }, _el$71);
          libs.createElement("Panel", {
            "class": "DiceLayerBorder"
          }, _el$71);
          const _el$74 = libs.createElement("Panel", {
            "class": "DiceLayerContent"
          }, _el$71),
          _el$75 = libs.createElement("Panel", {
            "class": "DiceLayerTitleContent"
          }, _el$74),
          _el$76 = libs.createElement("Label", {
            "class": "DiceLayerTitleContentText",
            get text() {
              return GetLocalization("#ActivityDice_MultiRollSummaryTitle");
            }
          }, _el$75),
          _el$77 = libs.createElement("Panel", {
            "class": "DiceLayerBodyContent"
          }, _el$74),
          _el$78 = libs.createElement("Panel", {
            id: "DiceGameOperation"
          }, _el$36),
          _el$79 = libs.createElement("Panel", {
            id: "DiceGamePlayerEventContainer",
            get hittest() {
              return hasPlayerEvent();
            },
            get hittestchildren() {
              return hasPlayerEvent();
            }
          }, _el$78),
          _el$80 = libs.createElement("Label", {
            id: "DiceGamePlayerEventTitle",
            get text() {
              return GetLocalization("#ActivityDice_PlayerEventTitle");
            }
          }, _el$79),
          _el$81 = libs.createElement("Panel", {
            id: "DiceGamePlayerEventContent"
          }, _el$79),
          _el$82 = libs.createElement("Panel", {
            "class": "DiceGamePlayerEventItem"
          }, _el$81);
          libs.createElement("Image", {
            id: "DiceGamePlayerEventBG"
          }, _el$82);
          const _el$84 = libs.createElement("Panel", {
            "class": "DiceGamePlayerEventItemContent"
          }, _el$82),
          _el$85 = libs.createElement("Label", {
            "class": "DiceGamePlayerEventDesc",
            get text() {
              return GetLocalization("#ActivityDice_PlayerEvent_RewardNextSlot");
            }
          }, _el$84),
          _el$87 = libs.createElement("Panel", {
            id: "DiceGameRollButtonContainer"
          }, _el$78),
          _el$88 = libs.createElement("Panel", {
            id: "DiceGameCostInfo"
          }, _el$87);
          libs.createElement("Image", {
            id: "DiceGameCostInfoBG"
          }, _el$88);
          const _el$90 = libs.createElement("Panel", {
            id: "DiceGameCostInfoContent"
          }, _el$88),
          _el$91 = libs.createElement("Label", {
            id: "DiceGameCostValue",
            text: `x${DICE_ROLL_ONCE_TIMES}`
          }, _el$90);
        libs.insert(_el$40, libs.createComponent(libs.For, {
          each: DICE_BOARD_LAYOUT_ROWS,
          children: (row, index) => (() => {
            const _el$98 = libs.createElement("Panel", {
              get ["class"]() {
                return `DiceGamePieceRow DiceGamePieceRow_${index()}`;
              }
            }, null);
            libs.insert(_el$98, libs.createComponent(libs.For, {
              each: row,
              children: piece => {
                const tileConfig = () => piece.shouldRenderPiece ? tileConfigMap()[piece.slotID] ?? DEFAULT_TILE_CONFIG : DEFAULT_TILE_CONFIG;
                return (() => {
                  const _el$99 = libs.createElement("Panel", {
                    "class": "DiceGamePieceCell"
                  }, null);
                  libs.insert(_el$99, (() => {
                    const _c$ = libs.memo(() => !!piece.shouldRenderPiece);
                    return () => _c$() ? libs.createComponent(DiceGamePiece, {
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
                      },
                      get tileType() {
                        return tileConfig().tileType;
                      },
                      get decorationType() {
                        return tileConfig().decorationType ?? "none";
                      },
                      get iconType() {
                        return tileConfig().iconType ?? "none";
                      },
                      get finishEffectToken() {
                        return libs.memo(() => finishTileEffect()?.slotID == piece.slotID)() ? finishTileEffect()?.token : undefined;
                      },
                      get levelUpEffectToken() {
                        return levelUpTileEffectTokens()[piece.slotID];
                      }
                    }) : libs.createComponent(DiceGamePiecePlaceholder, {});
                  })());
                  libs.effect(_$p => libs.setProp(_el$99, "customTooltip", piece.shouldRenderPiece ? (() => {
                    const tooltipData = getDiceSlotTooltipData(ACTIVITY_DICE_ID$3, piece.slotID, activitySlotData()[piece.slotID]);
                    if (tooltipData == undefined) {
                      return undefined;
                    }
                    const tooltipParams = {
                      ...tooltipData,
                      rewards: JSON.stringify(tooltipData.rewards),
                      next_rewards: JSON.stringify(tooltipData.next_rewards)
                    };
                    const definedTooltipParams = Object.entries(tooltipParams).reduce((params, [key, value]) => {
                      if (typeof value == "string" || typeof value == "number") {
                        params[key] = value;
                      }
                      return params;
                    }, {});
                    return {
                      name: "activity_dice",
                      ...definedTooltipParams
                    };
                  })() : undefined, _$p));
                  return _el$99;
                })();
              }
            }));
            libs.effect(_$p => libs.setProp(_el$98, "class", `DiceGamePieceRow DiceGamePieceRow_${index()}`, _$p));
            return _el$98;
          })()
        }));
        libs.insert(_el$41, libs.createComponent(DiceGamePlayerPiece, {
          get position() {
            return playerPiecePosition();
          },
          get moving() {
            return isPlayerMoving();
          },
          get positionTransitionEnabled() {
            return isPlayerMoveStepping();
          },
          get fastForward() {
            return isMultiRollPlaying();
          },
          get facingForward() {
            return isPlayerPieceFacingForward();
          },
          get IdleSequenceFrame() {
            return playerIdle.SequenceFrame;
          },
          get JumpSequenceFrame() {
            return playerJump.SequenceFrame;
          }
        }));
        libs.insert(_el$37, libs.createComponent(DiceGameDiceCube, {
          get visible() {
            return isDiceVisible();
          },
          get SequenceFrame() {
            return diceSequence.SequenceFrame;
          }
        }), _el$42);
        libs.insert(_el$68, libs.createComponent(StoreItem.StoreItemImage, {
          "class": "DiceTaskRewardIcon",
          get itemid() {
            return boxPreviewReward()?.item_id ?? 1800008;
          }
        }), _el$70);
        libs.insert(_el$77, libs.createComponent(libs.For, {
          get each() {
            return multiRollSummaryItems();
          },
          children: summaryText => (() => {
            const _el$100 = libs.createElement("Label", {
              "class": "DiceLayerContentDesc",
              text: summaryText
            }, null);
            libs.setProp(_el$100, "text", summaryText);
            return _el$100;
          })()
        }));
        libs.insert(_el$84, libs.createComponent(libs.Show, {
          get when() {
            return nextSlotExtraExp() > 1;
          },
          get children() {
            const _el$86 = libs.createElement("Label", {
              "class": "DiceGamePlayerEventValue",
              get text() {
                return `x${nextSlotExtraExp()}`;
              }
            }, null);
            libs.effect(_$p => libs.setProp(_el$86, "text", `x${nextSlotExtraExp()}`, _$p));
            return _el$86;
          }
        }), null);
        libs.insert(_el$90, libs.createComponent(StoreItem.StoreItemImage, {
          get itemid() {
            return diceTicketID();
          },
          get src() {
            return STOREITEMIMAGE_SRCPATH[diceTicketID()];
          }
        }), _el$91);
        libs.setProp(_el$91, "text", `x${DICE_ROLL_ONCE_TIMES}`);
        libs.insert(_el$87, libs.createComponent(EOM_Button.EOM_BaseButton, {
          id: "DiceGameRollButton",
          "class": "DiceGameActionButton",
          get enabled() {
            return canRollDice();
          },
          onactivate: () => requestRollDice(DICE_ROLL_ONCE_TIMES),
          get children() {
            return [libs.createElement("Image", {
              "class": "DiceGameActionButtonBG"
            }, null), libs.createElement("Label", {
              "class": "DiceGameActionButtonText",
              text: "#ActivityDice_RollAction"
            }, null)];
          }
        }), null);
        libs.insert(_el$78, libs.createComponent(EOM_Button.EOM_BaseButton, {
          "class": "DiceGameRollMiniButton",
          get enabled() {
            return !isRollBusy();
          },
          onactivate: () => requestRollDice(maxDiceRollTimes()),
          get children() {
            return [libs.createElement("Image", {
              "class": "DiceGameRollMiniButtonBG"
            }, null), (() => {
              const _el$95 = libs.createElement("Label", {
                "class": "DiceGameRollMiniButtonText",
                get text() {
                  return `x${diceRoll10ButtonTimes()}`;
                }
              }, null);
              libs.effect(_$p => libs.setProp(_el$95, "text", `x${diceRoll10ButtonTimes()}`, _$p));
              return _el$95;
            })()];
          }
        }), null);
        libs.insert(_el$78, libs.createComponent(libs.Show, {
          get when() {
            return isExecutingDiceEvents();
          },
          get children() {
            return libs.createComponent(EOM_Button.EOM_BaseButton, {
              id: "DiceGameSkipButton",
              "class": "DiceGameRollMiniButton",
              enabled: true,
              onactivate: skipDiceEvents,
              get children() {
                return [libs.createElement("Image", {
                  "class": "DiceGameRollMiniButtonBG"
                }, null), libs.createElement("Label", {
                  "class": "DiceGameRollMiniButtonText",
                  text: "#ActivityDice_SkipAction"
                }, null)];
              }
            });
          }
        }), null);
        libs.effect(_p$ => {
          const _v$11 = isDiceEventLayerVisible(),
            _v$12 = {
              position: diceEventLayerPosition()
            },
            _v$13 = libs.classNames({
              DiceEventGoodEvent: diceEventLayerType() == "good",
              DiceEventBadEvent: diceEventLayerType() == "bad"
            }),
            _v$14 = diceEventLayerTitle(),
            _v$15 = diceEventLayerDescription(),
            _v$16 = isMultiRollPointLayerVisible(),
            _v$17 = GetLocalization("#ActivityDice_MultiRollPointTitle"),
            _v$18 = `${multiRollPointValue()}`,
            _v$19 = `${multiRollCurrentIndex()}/${multiRollTotalCount()}`,
            _v$20 = isBoxPreviewLayerVisible(),
            _v$21 = GetLocalization("#ActivityDice_BoxRewardPreviewTitle"),
            _v$22 = GetLocalization("#ActivityDice_BoxRewardPreviewContent"),
            _v$23 = boxPreviewReward()?.amounts ?? 0,
            _v$24 = isMultiRollSummaryLayerVisible(),
            _v$25 = GetLocalization("#ActivityDice_MultiRollSummaryTitle"),
            _v$26 = {
              NoEvents: !hasPlayerEvent()
            },
            _v$27 = hasPlayerEvent(),
            _v$28 = hasPlayerEvent(),
            _v$29 = GetLocalization("#ActivityDice_PlayerEventTitle"),
            _v$30 = GetLocalization("#ActivityDice_PlayerEvent_RewardNextSlot"),
            _v$31 = {
              NotEnough: !hasEnoughDiceTicket(DICE_ROLL_ONCE_TIMES)
            };
          _v$11 !== _p$._v$11 && (_p$._v$11 = libs.setProp(_el$42, "visible", _v$11, _p$._v$11));
          _v$12 !== _p$._v$12 && (_p$._v$12 = libs.setProp(_el$42, "style", _v$12, _p$._v$12));
          _v$13 !== _p$._v$13 && (_p$._v$13 = libs.setProp(_el$45, "class", _v$13, _p$._v$13));
          _v$14 !== _p$._v$14 && (_p$._v$14 = libs.setProp(_el$48, "text", _v$14, _p$._v$14));
          _v$15 !== _p$._v$15 && (_p$._v$15 = libs.setProp(_el$50, "text", _v$15, _p$._v$15));
          _v$16 !== _p$._v$16 && (_p$._v$16 = libs.setProp(_el$51, "visible", _v$16, _p$._v$16));
          _v$17 !== _p$._v$17 && (_p$._v$17 = libs.setProp(_el$56, "text", _v$17, _p$._v$17));
          _v$18 !== _p$._v$18 && (_p$._v$18 = libs.setProp(_el$58, "text", _v$18, _p$._v$18));
          _v$19 !== _p$._v$19 && (_p$._v$19 = libs.setProp(_el$59, "text", _v$19, _p$._v$19));
          _v$20 !== _p$._v$20 && (_p$._v$20 = libs.setProp(_el$60, "visible", _v$20, _p$._v$20));
          _v$21 !== _p$._v$21 && (_p$._v$21 = libs.setProp(_el$65, "text", _v$21, _p$._v$21));
          _v$22 !== _p$._v$22 && (_p$._v$22 = libs.setProp(_el$67, "text", _v$22, _p$._v$22));
          _v$23 !== _p$._v$23 && (_p$._v$23 = libs.setProp(_el$70, "text", _v$23, _p$._v$23));
          _v$24 !== _p$._v$24 && (_p$._v$24 = libs.setProp(_el$71, "visible", _v$24, _p$._v$24));
          _v$25 !== _p$._v$25 && (_p$._v$25 = libs.setProp(_el$76, "text", _v$25, _p$._v$25));
          _v$26 !== _p$._v$26 && (_p$._v$26 = libs.setProp(_el$79, "classList", _v$26, _p$._v$26));
          _v$27 !== _p$._v$27 && (_p$._v$27 = libs.setProp(_el$79, "hittest", _v$27, _p$._v$27));
          _v$28 !== _p$._v$28 && (_p$._v$28 = libs.setProp(_el$79, "hittestchildren", _v$28, _p$._v$28));
          _v$29 !== _p$._v$29 && (_p$._v$29 = libs.setProp(_el$80, "text", _v$29, _p$._v$29));
          _v$30 !== _p$._v$30 && (_p$._v$30 = libs.setProp(_el$85, "text", _v$30, _p$._v$30));
          _v$31 !== _p$._v$31 && (_p$._v$31 = libs.setProp(_el$91, "classList", _v$31, _p$._v$31));
          return _p$;
        }, {
          _v$11: undefined,
          _v$12: undefined,
          _v$13: undefined,
          _v$14: undefined,
          _v$15: undefined,
          _v$16: undefined,
          _v$17: undefined,
          _v$18: undefined,
          _v$19: undefined,
          _v$20: undefined,
          _v$21: undefined,
          _v$22: undefined,
          _v$23: undefined,
          _v$24: undefined,
          _v$25: undefined,
          _v$26: undefined,
          _v$27: undefined,
          _v$28: undefined,
          _v$29: undefined,
          _v$30: undefined,
          _v$31: undefined
        });
        return _el$36;
      })()];
    }
  });
}

const ACTIVITY_DICE_ID$2 = 801;
function getDiceStoreItems$1(infoProducts) {
  const result = [];
  const now = Date.now() / 1000;
  for (const itemname in KeyValues.info_shop_product) {
    const itemdata = KeyValues.info_shop_product[itemname];
    const info_product = infoProducts[itemdata.id];
    const effective_start_time = info_product ? info_product.start_time : itemdata.start_time;
    const effective_end_time = info_product ? info_product.end_time : itemdata.end_time;
    if ((effective_start_time < now || effective_start_time == 0) && (effective_end_time > now || effective_end_time == 0) && (itemdata.hide_time > now || !itemdata.hide_time) && itemdata.hide == 0 || itemdata.tag == "Privilege") {
      const tags = itemdata.tag.split("|");
      if (tags.includes("BoardSlotGift")) {
        result.push(itemdata);
      }
    }
  }
  result.sort((a, b) => b.orderby - a.orderby);
  return result;
}
function DiceGift() {
  const activityData = libs.createMemo(() => KeyValues.activity_data[ACTIVITY_DICE_ID$2]);
  const infoProducts = solid_utils.createServiceNetData("info_products", {});
  const purchasedProduct = solid_utils.createServiceNetData("player_shop_product_limits", {});
  const storeItems = libs.createMemo(() => getDiceStoreItems$1(infoProducts()));
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
    id: "DiceGift",
    "class": "DiceStoreGift",
    shadow_border: true,
    get children() {
      return [(() => {
        const _el$ = libs.createElement("Panel", {
            id: "DiceGiftTitleTime",
            "class": "DiceStoreGiftTitleTime"
          }, null);
          libs.createElement("Image", {
            id: "DiceTopSubTitleBG",
            "class": "DiceStoreGiftTitleTimeBG"
          }, _el$);
          const _el$3 = libs.createElement("Panel", {
            "class": "DiceStoreGiftTitleTimeContent"
          }, _el$),
          _el$4 = libs.createElement("Image", {
            "class": "DiceStoreGiftTitleTooltipIcon"
          }, _el$3);
        libs.insert(_el$3, libs.createComponent(EOM_Countdown.EOM_Countdown, {
          icon: true,
          text: "#ActivityDice_DiceGift_TimeLimit",
          get endTime() {
            return activityData().end_time;
          }
        }), _el$4);
        libs.effect(_$p => libs.setProp(_el$4, "tooltip_text", GetLocalization("#ActivityDice_DiceGift_TimeTooltip"), _$p));
        return _el$;
      })(), (() => {
        const _el$5 = libs.createElement("Panel", {
          id: "DiceGiftList",
          "class": "VerticalScrollStyle DiceStoreGiftList",
          scroll: "y"
        }, null);
        libs.setProp(_el$5, "scroll", "y");
        libs.insert(_el$5, libs.createComponent(libs.Index, {
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
        return _el$5;
      })()];
    }
  });
}

const ACTIVITY_DICE_ID$1 = 801;
const ACTIVITY_MENU_GRACE_SECONDS = 7 * 24 * 60 * 60;
function getDiceStoreItems(infoProducts) {
  const result = [];
  const now = Date.now() / 1000;
  for (const itemname in KeyValues.info_shop_product) {
    const itemdata = KeyValues.info_shop_product[itemname];
    const info_product = infoProducts[itemdata.id];
    const effective_start_time = info_product ? info_product.start_time : itemdata.start_time;
    const effective_end_time = info_product ? info_product.end_time : itemdata.end_time;
    if ((effective_start_time < now || effective_start_time == 0) && (effective_end_time > now || effective_end_time == 0) && (itemdata.hide_time > now || !itemdata.hide_time) && itemdata.hide == 0 || itemdata.tag == "Privilege") {
      const tags = itemdata.tag.split("|");
      if (tags.includes("BoardSlot")) {
        result.push(itemdata);
      }
    }
  }
  result.sort((a, b) => b.orderby - a.orderby);
  return result;
}
function DiceStore() {
  const activityData = libs.createMemo(() => KeyValues.activity_data[ACTIVITY_DICE_ID$1]);
  const infoProducts = solid_utils.createServiceNetData("info_products", {});
  const purchasedProduct = solid_utils.createServiceNetData("player_shop_product_limits", {});
  const storeItems = libs.createMemo(() => getDiceStoreItems(infoProducts()));
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
    id: "DiceStore",
    shadow_border: true,
    get children() {
      return [(() => {
        const _el$ = libs.createElement("Panel", {
            id: "DiceGiftTitleTime",
            "class": "DiceStoreGiftTitleTime"
          }, null);
          libs.createElement("Image", {
            "class": "DiceStoreGiftTitleTimeBG"
          }, _el$);
          const _el$3 = libs.createElement("Panel", {
            "class": "DiceStoreGiftTitleTimeContent"
          }, _el$),
          _el$4 = libs.createElement("Image", {
            "class": "DiceStoreGiftTitleTooltipIcon"
          }, _el$3);
        libs.insert(_el$3, libs.createComponent(EOM_Countdown.EOM_Countdown, {
          icon: true,
          text: "#ActivityDice_DiceStore_TimeLimit",
          get endTime() {
            return activityData().end_time + ACTIVITY_MENU_GRACE_SECONDS;
          }
        }), _el$4);
        libs.effect(_$p => libs.setProp(_el$4, "tooltip_text", GetLocalization("#ActivityDice_DiceStore_TimeTooltip"), _$p));
        return _el$;
      })(), (() => {
        const _el$5 = libs.createElement("Panel", {
          id: "DiceStoreList",
          "class": "VerticalScrollStyle",
          scroll: "y"
        }, null);
        libs.setProp(_el$5, "scroll", "y");
        libs.insert(_el$5, libs.createComponent(libs.Index, {
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
        return _el$5;
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
  boardslot: ["dice_game", "dice_store", "dice_gift"]
};
const player_activity_tasks = solid_utils.createServiceNetData("player_activity_tasks", {});
const player_login_activity_data = solid_utils.createServiceNetData("player_login_activity_data", {});
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
for (const activity_id in KeyValues.activity_data) {
  const ad = KeyValues.activity_data[activity_id];
  if (ad.config) {
    const config = SymbolSpliter(ad.config, "|", ";");
    if (config.task_id) continue;
  }
  CallAction("/v1/activity/data", {
    activity_id: Number(activity_id)
  });
}
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
              return secondTabName() == "dice_game";
            },
            get children() {
              return libs.createComponent(Dice, {});
            }
          }), libs.createComponent(libs.Match, {
            get when() {
              return secondTabName() == "dice_store";
            },
            get children() {
              return libs.createComponent(DiceStore, {});
            }
          }), libs.createComponent(libs.Match, {
            get when() {
              return secondTabName() == "dice_gift";
            },
            get children() {
              return libs.createComponent(DiceGift, {});
            }
          })];
        }
      })];
    }
  });
}
libs.render(() => libs.createComponent(ActivityRoot, {}), $.GetContextPanel());