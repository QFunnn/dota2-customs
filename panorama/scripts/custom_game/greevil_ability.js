--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var AbilityDescription = require('./AbilityDescription.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Tooltip = require('./EOM_Tooltip.js');
var EOM_Label = require('./EOM_Label.js');
var GenericPanel = require('./GenericPanel.js');

let pTooltipPanel = $.GetContextPanel();
pTooltipPanel.style.minHeight = "0px";
pTooltipPanel.FindAncestor("greevil_ability").FindChildTraverse("LeftArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("greevil_ability").FindChildTraverse("RightArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("greevil_ability").FindChildTraverse("TopArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("greevil_ability").FindChildTraverse("BottomArrow").style.opacity = "0";
function TooltipContents({
  playerID,
  greevil_name_override,
  egg_type_override,
  level_override
}) {
  const isStatic = greevil_name_override !== undefined || egg_type_override !== undefined;
  const greevil_data = isStatic ? undefined : getSyncDataKey("common", "greevil_data", playerID);
  let greevil_egg = isStatic ? egg_type_override ?? "" : greevil_data?.egg_type ?? "";
  let abilityName = isStatic ? greevil_name_override ?? "" : greevil_data?.greevil_name ?? "";
  let overrideLevel = level_override ?? ((greevil_data?.level ?? 0) > 0 ? greevil_data.level : 1);
  let lv_effect_label = "";
  if (overrideLevel > 2) {
    lv_effect_label = "#Greevil_Skill_ReduceDamage2";
  } else if (overrideLevel > 1) {
    lv_effect_label = "#Greevil_Skill_ReduceDamage1";
  }
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    flowChildren: "down-wrap",
    get children() {
      return [libs.createComponent(libs.Show, {
        when: abilityName != "",
        get children() {
          return libs.createComponent(EOM_Tooltip.EOM_Tooltip, {
            width: "380px",
            flowChildren: "down",
            onload: () => {
              $.GetContextPanel().style.minHeight = "0px";
            },
            get children() {
              return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
                flowChildren: "right",
                get children() {
                  return [(() => {
                    const _el$ = libs.createElement("DOTAAbilityImage", {
                      abilityname: abilityName
                    }, null);
                    libs.setProp(_el$, "className", "SectImage");
                    libs.setProp(_el$, "abilityname", abilityName);
                    return _el$;
                  })(), libs.createComponent(EOM_Panel.EOM_Panel, {
                    flowChildren: "down",
                    marginLeft: "8px",
                    height: "100%",
                    get children() {
                      return [libs.createComponent(GenericPanel.CLabel, {
                        id: "SectNameHeader",
                        html: true,
                        text: "#DOTA_Tooltip_ability_" + abilityName
                      }), libs.createComponent(libs.Show, {
                        get when() {
                          return KeyValues.AbilitiesKv[abilityName].AbilityType != undefined;
                        },
                        get children() {
                          return libs.createComponent(GenericPanel.CLabel, {
                            className: "AbilityType",
                            get text() {
                              return "#" + GameUI.CustomUIConfig().AbilitiesKv[abilityName].AbilityType;
                            }
                          });
                        }
                      })];
                    }
                  })];
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "SectRow",
                flowChildren: "right",
                get children() {
                  return libs.createComponent(AbilityDescription.AbilityDescription, {
                    className: "AbilityDescription",
                    level: overrideLevel,
                    abilityName: abilityName
                  });
                }
              }), libs.createComponent(libs.Show, {
                when: lv_effect_label != "",
                get children() {
                  return libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
                    flowChildren: "right",
                    get children() {
                      return libs.createComponent(EOM_Label.EOM_Label, {
                        className: "AbilityDescription",
                        text: lv_effect_label,
                        html: true
                      });
                    }
                  });
                }
              })];
            }
          });
        }
      }), libs.createComponent(libs.Show, {
        when: greevil_egg != "",
        get children() {
          return libs.createComponent(EOM_Tooltip.EOM_Tooltip, {
            width: "380px",
            flowChildren: "down",
            onload: () => {
              $.GetContextPanel().style.minHeight = "0px";
            },
            get children() {
              return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
                flowChildren: "right",
                get children() {
                  return [(() => {
                    const _el$2 = libs.createElement("DOTAAbilityImage", {
                      abilityname: greevil_egg
                    }, null);
                    libs.setProp(_el$2, "className", "SectImage");
                    libs.setProp(_el$2, "abilityname", greevil_egg);
                    return _el$2;
                  })(), libs.createComponent(EOM_Panel.EOM_Panel, {
                    flowChildren: "down",
                    marginLeft: "8px",
                    height: "100%",
                    get children() {
                      return [libs.createComponent(GenericPanel.CLabel, {
                        id: "SectNameHeader",
                        html: true,
                        text: "#DOTA_Tooltip_ability_" + greevil_egg
                      }), libs.createComponent(libs.Show, {
                        get when() {
                          return KeyValues.AbilitiesKv[greevil_egg].AbilityType != undefined;
                        },
                        get children() {
                          return libs.createComponent(GenericPanel.CLabel, {
                            className: "AbilityType",
                            get text() {
                              return "#" + GameUI.CustomUIConfig().AbilitiesKv[greevil_egg].AbilityType;
                            }
                          });
                        }
                      })];
                    }
                  })];
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "SectRow",
                flowChildren: "right",
                get children() {
                  return libs.createComponent(AbilityDescription.AbilityDescription, {
                    className: "AbilityDescription",
                    abilityName: greevil_egg
                  });
                }
              }), libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
                margin: "10px 2px",
                flowChildren: "down",
                get children() {
                  return libs.createComponent(GenericPanel.CLabel, {
                    id: "GreevilRule",
                    html: true,
                    text: "#GreevilEnergy_BaseAccess"
                  });
                }
              })];
            }
          });
        }
      })];
    }
  });
}
function SetupTooltip() {
  const playerID = pTooltipPanel.GetAttributeInt("player_id", Players.GetLocalPlayer());
  const greevil_name_override = pTooltipPanel.GetAttributeString("greevil_name", "") || undefined;
  const egg_type_override = pTooltipPanel.GetAttributeString("egg_type", "") || undefined;
  const level_override_str = pTooltipPanel.GetAttributeString("level_override", "");
  const level_override = level_override_str ? Number(level_override_str) : undefined;
  if (!greevil_name_override && !egg_type_override) {
    const greevil_data = getSyncDataKey("common", "greevil_data", playerID);
    if (greevil_data == undefined) {
      return;
    }
  }
  libs.render(() => libs.createComponent(TooltipContents, {
    playerID: playerID,
    greevil_name_override: greevil_name_override,
    egg_type_override: egg_type_override,
    level_override: level_override
  }), pTooltipPanel);
}
(function () {
  pTooltipPanel.SetPanelEvent("ontooltiploaded", SetupTooltip);
})();