--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('RuneRewardCard', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Icon = require('./EOM_Icon.js');
var EOM_Label = require('./EOM_Label.js');

const RuneRewardCard = props => {
  const [local, others] = libs.splitProps(props, ["trait", "children"]);
  const resolved = libs.children(() => local.children);
  const runeDescription = () => getAbilityDescription(local.trait);
  const kv = libs.createMemo(() => {
    return KeyValues.TraitKv[local.trait];
  });
  const gold = () => {
    return finiteNumber(Number(kv()?.CustomGainGold));
  };
  const refreshCount = () => {
    return kv()?.CustomRefresh ?? 0;
  };
  const goldText = () => {
    if (gold() == 0) {
      return `${gold()}`;
    }
    if (gold() > 0) {
      return `+${gold()}`;
    }
    return `-${gold()}`;
  };
  const refreshTooltipText = () => {
    return $.Localize("#RuneExtraRefreshCount").replace(/\$\{count\}/g, `<font color='#ffdb70'>${refreshCount()}</font>`);
  };
  const goldTooltipText = () => {
    if (gold() > 0) {
      return $.Localize("#RuneExtraGoldGain").replace(/\$\{count\}/g, `<font color='#b9ff89'>${gold()}</font>`);
    }
    return $.Localize("#RuneExtraGoldCost").replace(/\$\{count\}/g, `<font color='#ff6868'>${gold()}</font>`);
  };
  return libs.createComponent(EOM_Panel.EOM_Panel, libs.mergeProps(() => EOM_Panel.EOMProps(others), {
    get className() {
      return libs.classNames("RuneRewardCard", $.Language().toLowerCase());
    },
    get customTooltip() {
      return libs.memo(() => !!hasKeyWord($.Localize("#DOTA_Tooltip_ability_" + local.trait + "_description")))() ? {
        name: "keyword_list",
        keyword_list: JSON.stringify(getKeyWordList($.Localize("#DOTA_Tooltip_ability_" + local.trait + "_description")))
      } : undefined;
    },
    get children() {
      return libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "RuneRewardCardMain",
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "RuneRewardCardBG"
          }), libs.createElement("DOTAParticleScenePanel", {
            id: "RuneRewardIconParticle",
            particleName: "particles/eom/ui/ui_fx/ui_game_gem_float_fx.vpcf",
            lookAt: "0 0 0",
            cameraOrigin: "0 0 250",
            fov: 24
          }, null), libs.createComponent(EOM_Label.EOM_Label, {
            id: "RuneRewardTitle",
            get text() {
              return "#DOTA_Tooltip_ability_" + local.trait;
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "ExtraInfoRow",
            get children() {
              return [libs.createComponent(libs.Show, {
                get when() {
                  return refreshCount() > 0;
                },
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("RuneExtraInfo", "Refresh");
                    },
                    get tooltip_text() {
                      return refreshTooltipText();
                    },
                    get children() {
                      return [libs.createComponent(EOM_Icon.EOM_Icon, {
                        className: "RuneExtraIcon refresh"
                      }), libs.createComponent(EOM_Label.EOM_Label, {
                        get text() {
                          return refreshCount();
                        }
                      })];
                    }
                  });
                }
              }), libs.createComponent(libs.Show, {
                get when() {
                  return gold() != 0;
                },
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("RuneExtraInfo", "Gold", {
                        Add: gold() > 0
                      });
                    },
                    get tooltip_text() {
                      return goldTooltipText();
                    },
                    get children() {
                      return [libs.createComponent(EOM_Icon.EOM_Icon, {
                        className: "RuneExtraIcon gold"
                      }), libs.createComponent(EOM_Label.EOM_Label, {
                        get text() {
                          return goldText();
                        }
                      })];
                    }
                  });
                }
              })];
            }
          }), libs.createComponent(EOM_Label.EOM_Label, {
            html: true,
            id: "RuneRewardDescription",
            get text() {
              return runeDescription();
            }
          }), libs.memo(() => resolved())];
        }
      });
    }
  }));
};

exports.RuneRewardCard = RuneRewardCard;