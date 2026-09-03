--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var Player = require('./Player.js');
var tooltip_base = require('./tooltip_base.js');
var StoreItem = require('./StoreItem.js');
require('./solid_utils.js');
require('./service_netdata_helper.js');
require('./EOM_Button.js');
require('./EOM_TextEntry.js');
require('./EOM_Countdown.js');
require('./EOM_ImageNumber.js');
require('./equipment_utils.js');

function ActivityVeinsTooltip(props) {
  const currentDepthMulIndex = libs.createMemo(() => {
    const depthMul = props.depthMul;
    if (depthMul == undefined) {
      return -1;
    }
    let currentIndex = -1;
    for (let index = 0; index < depthMul.record.length; index++) {
      if (depthMul.nowDepth >= depthMul.record[index].depth) {
        currentIndex = index;
      }
    }
    return currentIndex;
  });
  const getDepthMulState = index => {
    const currentIndex = currentDepthMulIndex();
    if (index == currentIndex) {
      return "Current";
    }
    if (currentIndex >= 0 && index < currentIndex) {
      return "Past";
    }
    return "Future";
  };
  return (() => {
    const _el$ = libs.createElement("Panel", {
      id: "ActivityVeinsTooltip"
    }, null);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return props.title != undefined && props.title != "";
      },
      get children() {
        const _el$2 = libs.createElement("Panel", {
            "class": "ActivityVeinsTooltipTitle"
          }, null),
          _el$3 = libs.createElement("Label", {
            "class": "ActivityVeinsTooltipTitleLabel",
            get text() {
              return props.title ?? "";
            }
          }, _el$2);
        libs.effect(_$p => libs.setProp(_el$3, "text", props.title ?? "", _$p));
        return _el$2;
      }
    }), null);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return props.description != undefined && props.description != "";
      },
      get children() {
        const _el$4 = libs.createElement("Panel", {
            "class": "ActivityVeinsTooltipDesc"
          }, null),
          _el$5 = libs.createElement("Label", {
            "class": "ActivityVeinsTooltipDescLabel",
            get text() {
              return props.description ?? "";
            }
          }, _el$4);
        libs.effect(_$p => libs.setProp(_el$5, "text", props.description ?? "", _$p));
        return _el$4;
      }
    }), null);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return props.rankTip;
      },
      keyed: true,
      children: rankTip => (() => {
        const _el$9 = libs.createElement("Panel", {
            "class": "ActivityVeinsTooltipRankTip"
          }, null),
          _el$0 = libs.createElement("Label", {
            "class": "ActivityVeinsTooltipRankTipText",
            html: true,
            get text() {
              return rankTip.text;
            }
          }, _el$9),
          _el$1 = libs.createElement("Panel", {
            "class": "ActivityVeinsTooltipRankTitleContainer"
          }, _el$9),
          _el$10 = libs.createElement("Label", {
            "class": "ActivityVeinsTooltipRankTipSubText",
            html: true,
            get text() {
              return rankTip.subText;
            }
          }, _el$9);
        libs.insert(_el$1, libs.createComponent(Player.PlayerTitle, {
          "class": "ActivityVeinsTooltipRankTitle",
          get titleid() {
            return rankTip.titleID;
          }
        }));
        libs.effect(_p$ => {
          const _v$ = rankTip.text,
            _v$2 = rankTip.subText;
          _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$0, "text", _v$, _p$._v$));
          _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$10, "text", _v$2, _p$._v$2));
          return _p$;
        }, {
          _v$: undefined,
          _v$2: undefined
        });
        return _el$9;
      })()
    }), null);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return (props.rewards?.length ?? 0) > 0;
      },
      get children() {
        const _el$6 = libs.createElement("Panel", {
          "class": "ActivityVeinsTooltipRewards"
        }, null);
        libs.insert(_el$6, libs.createComponent(libs.For, {
          get each() {
            return props.rewards;
          },
          children: reward => (() => {
            const _el$11 = libs.createElement("Panel", {
                "class": "ActivityVeinsTooltipReward"
              }, null),
              _el$12 = libs.createElement("Panel", {
                "class": "ActivityVeinsTooltipRewardIcon"
              }, _el$11);
              libs.createElement("Image", {
                "class": "ActivityVeinsTooltipRewardIconBG"
              }, _el$12);
              const _el$14 = libs.createElement("Panel", {
                "class": "ActivityVeinsTooltipRewardInfo"
              }, _el$11),
              _el$15 = libs.createElement("Label", {
                "class": "ActivityVeinsTooltipRewardInfoName",
                html: true,
                get text() {
                  return GetLocalization(`#${reward.item_id}`);
                }
              }, _el$14),
              _el$16 = libs.createElement("Label", {
                "class": "ActivityVeinsTooltipRewardInfoAmount",
                get text() {
                  return `x${reward.amounts}`;
                }
              }, _el$14);
            libs.insert(_el$12, libs.createComponent(StoreItem.StoreItemImage, {
              get itemid() {
                return reward.item_id;
              },
              hideTips: true
            }), null);
            libs.insert(_el$11, libs.createComponent(libs.Show, {
              get when() {
                return reward.weightText != undefined && reward.weightText != "";
              },
              get children() {
                const _el$17 = libs.createElement("Label", {
                  "class": "ActivityVeinsTooltipRewardWeight",
                  get text() {
                    return reward.weightText ?? "";
                  }
                }, null);
                libs.effect(_$p => libs.setProp(_el$17, "text", reward.weightText ?? "", _$p));
                return _el$17;
              }
            }), null);
            libs.effect(_p$ => {
              const _v$3 = GetLocalization(`#${reward.item_id}`),
                _v$4 = `x${reward.amounts}`;
              _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$15, "text", _v$3, _p$._v$3));
              _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$16, "text", _v$4, _p$._v$4));
              return _p$;
            }, {
              _v$3: undefined,
              _v$4: undefined
            });
            return _el$11;
          })()
        }));
        return _el$6;
      }
    }), null);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return props.depthMul != undefined && props.depthMul.record.length > 0;
      },
      get children() {
        const _el$7 = libs.createElement("Panel", {
            "class": "ActivityVeinsTooltipDepthMul"
          }, null),
          _el$8 = libs.createElement("Label", {
            html: true,
            "class": "ActivityVeinsTooltipDepthMulLabel DepthMulTitle",
            get text() {
              return GetLocalization("#ActivityVeins_Tooltip_DepthMulTipTitle");
            }
          }, _el$7);
        libs.insert(_el$7, libs.createComponent(libs.For, {
          get each() {
            return props.depthMul?.record ?? [];
          },
          children: (record, index) => {
            const isCurrent = () => index() == currentDepthMulIndex();
            const text = () => {
              const depthMulTip = LocalizeWithVars("#ActivityVeins_Tooltip_DepthMulTip", {
                depth: record.depth,
                mul: record.mul.toFixed(1)
              });
              return isCurrent() ? depthMulTip + GetLocalization("#ActivityVeins_Tooltip_DepthMulNowTip") : depthMulTip;
            };
            return (() => {
              const _el$18 = libs.createElement("Label", {
                get ["class"]() {
                  return libs.classNames("ActivityVeinsTooltipDepthMulLabel", getDepthMulState(index()));
                },
                get text() {
                  return text();
                }
              }, null);
              libs.effect(_p$ => {
                const _v$5 = libs.classNames("ActivityVeinsTooltipDepthMulLabel", getDepthMulState(index())),
                  _v$6 = text();
                _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$18, "class", _v$5, _p$._v$5));
                _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$18, "text", _v$6, _p$._v$6));
                return _p$;
              }, {
                _v$5: undefined,
                _v$6: undefined
              });
              return _el$18;
            })();
          }
        }), null);
        libs.effect(_$p => libs.setProp(_el$8, "text", GetLocalization("#ActivityVeins_Tooltip_DepthMulTipTitle"), _$p));
        return _el$7;
      }
    }), null);
    return _el$;
  })();
}
const root = $.GetContextPanel();
function SetupTooltip() {
  const parsedRewards = JSON.parseSafe(root.GetAttributeString("rewards", "[]"));
  const rewards = Array.isArray(parsedRewards) ? parsedRewards.filter(reward => {
    return reward != undefined && (typeof reward.item_id == "string" || typeof reward.item_id == "number") && typeof reward.amounts == "number" && Number.isFinite(reward.amounts) && reward.amounts > 0 && (reward.weightText == undefined || typeof reward.weightText == "string");
  }) : [];
  const parsedDepthMul = JSON.parseSafe(root.GetAttributeString("depthMul", "{}"));
  const nowDepth = parsedDepthMul != undefined && typeof parsedDepthMul == "object" ? parsedDepthMul.nowDepth : undefined;
  const parsedDepthMulRecords = parsedDepthMul != undefined && typeof parsedDepthMul == "object" ? parsedDepthMul.record : undefined;
  const depthMulRecords = Array.isArray(parsedDepthMulRecords) ? parsedDepthMulRecords.filter(record => {
    return record != undefined && typeof record == "object" && typeof record.depth == "number" && Number.isFinite(record.depth) && record.depth >= 0 && typeof record.mul == "number" && Number.isFinite(record.mul) && record.mul > 0;
  }).sort((a, b) => a.depth - b.depth) : [];
  const depthMul = typeof nowDepth == "number" && Number.isFinite(nowDepth) && nowDepth >= 0 && depthMulRecords.length > 0 ? {
    record: depthMulRecords,
    nowDepth
  } : undefined;
  const parsedRankTip = JSON.parseSafe(root.GetAttributeString("rankTip", "{}"));
  const rankTip = parsedRankTip != undefined && typeof parsedRankTip == "object" && typeof parsedRankTip.text == "string" && parsedRankTip.text != "" && (typeof parsedRankTip.titleID == "string" || typeof parsedRankTip.titleID == "number") && String(parsedRankTip.titleID) != "" && String(parsedRankTip.titleID) != "0" ? parsedRankTip : undefined;
  libs.render(() => libs.createComponent(ActivityVeinsTooltip, {
    get title() {
      return root.GetAttributeString("title", "");
    },
    get description() {
      return root.GetAttributeString("description", "");
    },
    rewards: rewards,
    depthMul: depthMul,
    rankTip: rankTip
  }), root);
}
(function () {
  tooltip_base.InitTooltipStyle(root, "BaseTooltip");
  root.SetPanelEvent("ontooltiploaded", SetupTooltip);
})();