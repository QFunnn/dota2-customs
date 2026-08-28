--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var AbilityDescription = require('./AbilityDescription.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Tooltip = require('./EOM_Tooltip.js');
var EOM_Icon = require('./EOM_Icon.js');
var EOM_Label = require('./EOM_Label.js');
var EOM_Portrait = require('./EOM_Portrait.js');
var EOM_XP = require('./EOM_XP.js');
var GenericPanel = require('./GenericPanel.js');
var SectIcon = require('./SectIcon.js');
var ShardAbility = require('./ShardAbility.js');
require('./EOM_Image.js');

let pTooltipPanel = $.GetContextPanel();
pTooltipPanel.style.minHeight = "0px";
pTooltipPanel.FindAncestor("hero_detail").FindChildTraverse("LeftArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("hero_detail").FindChildTraverse("RightArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("hero_detail").FindChildTraverse("TopArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("hero_detail").FindChildTraverse("BottomArrow").style.opacity = "0";
function TooltipContents({
  hero_name,
  skin_id
}) {
  const getTalentData = heroName => {
    const result = new Map();
    for (const talentName in KeyValues.HeroTalentKv) {
      const talentData = KeyValues.HeroTalentKv[talentName];
      if (talentData.Hero === heroName && talentData.RequiredLevel !== undefined) {
        if (!result.has(talentData.RequiredLevel)) {
          result.set(talentData.RequiredLevel, []);
        }
        result.get(talentData.RequiredLevel)?.push(talentName);
      }
    }
    result.forEach((talents, level) => {
      let leftTalent;
      let rightTalent;
      let otherTalents = [];
      talents.forEach(talentName => {
        const kv = KeyValues.HeroTalentKv[talentName];
        if (kv.UIDirection == "left" && !leftTalent) {
          leftTalent = talentName;
        } else if (kv.UIDirection == "right" && !rightTalent) {
          rightTalent = talentName;
        } else {
          otherTalents.push(talentName);
        }
      });
      const organizedTalents = [];
      if (!leftTalent) {
        let r = otherTalents.shift();
        if (r) {
          organizedTalents.push(r);
        }
      } else {
        organizedTalents.push(leftTalent);
      }
      if (rightTalent) {
        organizedTalents.push(rightTalent);
      }
      organizedTalents.push(...otherTalents);
      result.set(level, organizedTalents);
    });
    return Object.fromEntries(result);
  };
  const heroTalent = getTalentData(hero_name);
  const heroData = GameUI.CustomUIConfig().UnitsCommonKv[hero_name];
  const abliityList = [].concat(KeyValues.HeroAbilityDisplayList[hero_name]);
  if (abliityList != undefined && typeof heroData?.InteractiveAbilityName == "string") {
    abliityList.push(heroData.InteractiveAbilityName);
  }
  let customManaType = 0;
  if (KeyValues.UnitsCommonKv[hero_name]) {
    customManaType = KeyValues.UnitsCommonKv[hero_name].CustomManaType;
  }
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "Content",
    flowChildren: 'down',
    get children() {
      return [libs.createComponent(EOM_Tooltip.EOM_Tooltip, {
        id: "HeroInfoTooltip",
        flowChildren: 'down',
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "HeroInfo",
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                flowChildren: "down",
                get children() {
                  return libs.createComponent(EOM_Portrait.EOM_Portrait, {
                    width: "100px",
                    height: "125px",
                    unitname: skin_id != "" ? skin_id : hero_name,
                    get model() {
                      return KeyValues.UnitsKv[hero_name]?.Model ?? "";
                    },
                    get children() {
                      return [libs.createComponent(EOM_Panel.EOM_Panel, {
                        flowChildren: "down",
                        marginTop: "-6px",
                        marginLeft: "-6px",
                        get children() {
                          return (heroData?.Sect ?? "").split("|").map((sectName, index) => {
                            if (sectName != "") {
                              return libs.createComponent(SectIcon.SectIcon, {
                                sectName: sectName,
                                marginBottom: "-14px",
                                tooltip: "#DOTA_Tooltip_ability_" + sectName
                              });
                            }
                          });
                        }
                      }), libs.createComponent(EOM_Label.EOM_Label, {
                        align: "center bottom",
                        backgroundColor: '#000000cc',
                        paddingTop: '4px',
                        width: "100%",
                        height: "22px",
                        color: "#fff",
                        fontSize: "18px",
                        textOverflow: "shrink",
                        style: {
                          textAlign: "center"
                        },
                        text: "#" + hero_name
                      })];
                    }
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "HeroAttribute",
                flowChildren: "down",
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    className: "AttributeBox health",
                    get children() {
                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "HealthBar",
                        get children() {
                          return libs.createComponent(GenericPanel.CLabel, {
                            className: "BarValue",
                            get text() {
                              return KeyValues.UnitsKv[hero_name]?.StatusHealth ?? '';
                            }
                          });
                        }
                      });
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    className: "AttributeBox health",
                    get children() {
                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "ManaBar",
                        className: "ManaType_" + customManaType,
                        get children() {
                          return [libs.createComponent(GenericPanel.CLabel, {
                            className: "BarValue",
                            get text() {
                              return KeyValues.UnitsKv[hero_name]?.StatusMana ?? '';
                            }
                          }), libs.createComponent(GenericPanel.CLabel, {
                            className: "BarRegenValue",
                            get text() {
                              return '+' + (KeyValues.UnitsKv[hero_name]?.ManaRegen ?? '');
                            }
                          })];
                        }
                      });
                    }
                  }), (() => {
                    const _el$ = libs.createElement("Panel", {
                      id: "AttributeList"
                    }, null);
                    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
                      get className() {
                        return libs.classNames("AttributeBox", "attribute");
                      },
                      get children() {
                        const _el$2 = libs.createElement("Panel", {}, null),
                          _el$3 = libs.createElement("Image", {}, _el$2),
                          _el$4 = libs.createElement("Panel", {}, _el$2);
                        libs.setProp(_el$2, "className", "AttributeRow");
                        libs.setProp(_el$2, "tooltip_text", "#Tooltip_Attribute_Attack");
                        libs.setProp(_el$3, "className", "AttributeIcon Attack");
                        libs.setProp(_el$4, "className", "AttributeValue");
                        libs.insert(_el$4, libs.createComponent(GenericPanel.CLabel, {
                          get text() {
                            return KeyValues.UnitsKv[hero_name]?.AttackDamage ?? '';
                          }
                        }));
                        return _el$2;
                      }
                    }), null);
                    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
                      get className() {
                        return libs.classNames("AttributeBox", "attribute");
                      },
                      get children() {
                        const _el$5 = libs.createElement("Panel", {}, null),
                          _el$6 = libs.createElement("Image", {}, _el$5),
                          _el$7 = libs.createElement("Panel", {}, _el$5);
                        libs.setProp(_el$5, "className", "AttributeRow");
                        libs.setProp(_el$5, "tooltip_text", "#Tooltip_Attribute_Attackspeed");
                        libs.setProp(_el$6, "className", "AttributeIcon AttackSpeed");
                        libs.setProp(_el$7, "className", "AttributeValue");
                        libs.insert(_el$7, libs.createComponent(GenericPanel.CLabel, {
                          get text() {
                            return Round(1 / Number(KeyValues.UnitsKv[hero_name]?.AttackRate), 2) ?? '';
                          }
                        }));
                        return _el$5;
                      }
                    }), null);
                    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
                      get className() {
                        return libs.classNames("AttributeBox", "attribute");
                      },
                      get children() {
                        const _el$8 = libs.createElement("Panel", {}, null),
                          _el$9 = libs.createElement("Image", {}, _el$8),
                          _el$0 = libs.createElement("Panel", {}, _el$8);
                        libs.setProp(_el$8, "className", "AttributeRow");
                        libs.setProp(_el$8, "tooltip_text", "#Tooltip_Attribute_CritChance");
                        libs.setProp(_el$9, "className", "AttributeIcon Crit");
                        libs.setProp(_el$0, "className", "AttributeValue");
                        libs.insert(_el$0, libs.createComponent(GenericPanel.CLabel, {
                          get text() {
                            return KeyValues.UnitsKv[hero_name]?.PhysicalCritChance ?? '';
                          }
                        }));
                        return _el$8;
                      }
                    }), null);
                    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
                      get className() {
                        return libs.classNames("AttributeBox", "attribute");
                      },
                      get children() {
                        const _el$1 = libs.createElement("Panel", {}, null),
                          _el$10 = libs.createElement("Image", {}, _el$1),
                          _el$11 = libs.createElement("Panel", {}, _el$1);
                        libs.setProp(_el$1, "className", "AttributeRow");
                        libs.setProp(_el$1, "tooltip_text", "#Tooltip_Attribute_Evasion");
                        libs.setProp(_el$10, "className", "AttributeIcon Evade");
                        libs.setProp(_el$11, "className", "AttributeValue");
                        libs.insert(_el$11, libs.createComponent(GenericPanel.CLabel, {
                          get text() {
                            return KeyValues.UnitsKv[hero_name]?.Evasion ?? '';
                          }
                        }));
                        return _el$1;
                      }
                    }), null);
                    return _el$;
                  })()];
                }
              })];
            }
          });
        }
      }), libs.createComponent(EOM_Tooltip.EOM_Tooltip, {
        marginTop: '0px',
        "max-width": "1100px",
        flowChildren: "down-wrap",
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            width: '500px',
            className: "InfoColumn",
            get children() {
              return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
                get children() {
                  return libs.createComponent(GenericPanel.CLabel, {
                    id: "Title",
                    text: "#PlayerInfoTitle_HeroAbility"
                  });
                }
              }), libs.memo(() => abliityList.map((name, i) => libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "AbilityRow",
                flowChildren: "right",
                get children() {
                  return [(() => {
                    const _el$12 = libs.createElement("DOTAAbilityImage", {
                      abilityname: name
                    }, null);
                    libs.setProp(_el$12, "abilityname", name);
                    return _el$12;
                  })(), libs.createComponent(EOM_Panel.EOM_Panel, {
                    flowChildren: "down",
                    marginLeft: "6px",
                    get children() {
                      return [libs.createComponent(GenericPanel.CLabel, {
                        className: "AbilityName",
                        get text() {
                          return $.Localize("#DOTA_Tooltip_ability_" + name);
                        }
                      }), libs.createComponent(GenericPanel.CLabel, {
                        className: "AbilityType",
                        get text() {
                          return $.Localize("#" + (GameUI.CustomUIConfig().AbilitiesKv[name]?.AbilityType ?? ""));
                        }
                      }), libs.createComponent(GenericPanel.CLabel, {
                        html: true,
                        className: "AbilityDescription",
                        get text() {
                          return getAbilityDescription(name);
                        }
                      })];
                    }
                  })];
                }
              })))];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            width: '500px',
            className: "InfoColumn",
            get children() {
              return [libs.memo(() => (() => {
                let shardAbility = "shard_empty";
                let shardLevel = 1;
                if (KeyValues.AbilitiesKv[hero_name + "_shard"]) {
                  shardAbility = hero_name + "_shard";
                  shardLevel = KeyValues.AbilitiesKv[hero_name + "_shard"].ShardLevel ?? 1;
                }
                let kv = KeyValues.AbilitiesKv[shardAbility];
                let cost_config = CustomNetTables.GetTableValue("common", "constant")?.SHARD_LEVEL_COST;
                let costLabel = "";
                if (cost_config?.[shardLevel]) {
                  costLabel = `${cost_config?.[shardLevel].origin}`;
                }
                let mainDescription = $.Localize("#DOTA_Tooltip_ability_" + shardAbility + "_description");
                const showMainDescription = mainDescription != "" && mainDescription != "#DOTA_Tooltip_ability_" + shardAbility + "_description";
                const relativeAbilities = kv?.relative_ability == undefined ? [] : kv.relative_ability.split("|");
                return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
                  get children() {
                    return [libs.createComponent(GenericPanel.CLabel, {
                      id: "Title",
                      text: "#HeroShard"
                    }), libs.createComponent(EOM_Panel.EOM_Panel, {
                      id: "ShardCost",
                      visible: costLabel != "",
                      get children() {
                        return [libs.createComponent(EOM_Icon.EOM_Icon, {
                          get src() {
                            return getSrcPath("icon/icon_gold_bevel_psd.png");
                          }
                        }), libs.createComponent(EOM_Label.EOM_Label, {
                          text: costLabel
                        })];
                      }
                    })];
                  }
                }), libs.createComponent(EOM_Panel.EOM_Panel, {
                  width: "100%",
                  flowChildren: "down",
                  marginTop: '4px',
                  marginBottom: '4px',
                  marginLeft: "6px",
                  get children() {
                    return [libs.createComponent(libs.Show, {
                      when: showMainDescription,
                      get children() {
                        return libs.createComponent(AbilityDescription.AbilityDescription, {
                          className: "ShardAbilityMainDescription",
                          abilityName: shardAbility
                        });
                      }
                    }), libs.createComponent(libs.For, {
                      each: relativeAbilities,
                      children: (name, i) => {
                        return libs.createComponent(EOM_Panel.EOM_Panel, {
                          className: "ShardRelativeContainer",
                          get children() {
                            return [libs.createComponent(EOM_Panel.EOM_Panel, {
                              id: "ShardRelativeTitle",
                              get children() {
                                return [(() => {
                                  const _el$13 = libs.createElement("DOTAAbilityImage", {
                                    abilityname: name
                                  }, null);
                                  libs.setProp(_el$13, "className", "ShardRelativeAbilityImage");
                                  libs.setProp(_el$13, "abilityname", name);
                                  return _el$13;
                                })(), libs.createComponent(EOM_Panel.EOM_Panel, {
                                  flowChildren: "down",
                                  marginLeft: "8px",
                                  height: "100%",
                                  get children() {
                                    return [libs.createComponent(GenericPanel.CLabel, {
                                      id: "SectNameHeader",
                                      html: true,
                                      text: "#DOTA_Tooltip_ability_" + name
                                    }), libs.createComponent(GenericPanel.CLabel, {
                                      className: "ShardRelativeType",
                                      text: "#ShardAbilityUpgrade"
                                    })];
                                  }
                                })];
                              }
                            }), libs.createComponent(ShardAbility.ShardRelativeDescription, {
                              abilityName: shardAbility,
                              relativeAbilityName: name
                            })];
                          }
                        });
                      }
                    })];
                  }
                })];
              })()), libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
                get children() {
                  return libs.createComponent(GenericPanel.CLabel, {
                    id: "Title",
                    text: "#TalentBranch_Title"
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "TalentBranchContent",
                get children() {
                  return (() => {
                    let _talents = Object.keys(heroTalent);
                    if (_talents.length > 0) {
                      return _talents.sort((a, b) => {
                        return Number(b) - Number(a);
                      }).map((level, index) => {
                        const talents = heroTalent[Number(level)];
                        const isThreeColumn = talents.length >= 3;
                        const leftTalent = talents[0];
                        const rightTalent = talents[1];
                        const descLeft = getHeroTalentDescription(leftTalent);
                        const descRight = getHeroTalentDescription(rightTalent);
                        if (isThreeColumn) {
                          return libs.createComponent(EOM_Panel.EOM_Panel, {
                            className: "TalentBranchLevelRow ThreeColumn",
                            flowChildren: "down",
                            get children() {
                              return [libs.createComponent(EOM_XP.EOM_XP, {
                                get level() {
                                  return Number(level);
                                },
                                horizontalAlign: "center"
                              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                className: "TalentBranchChoices",
                                flowChildren: "right",
                                get children() {
                                  return libs.createComponent(libs.For, {
                                    each: talents,
                                    children: talentName => libs.createComponent(EOM_Panel.EOM_Panel, {
                                      get className() {
                                        return libs.classNames("TalentRow", "ThreeColumn");
                                      },
                                      get children() {
                                        return libs.createComponent(EOM_Label.EOM_Label, {
                                          html: true,
                                          verticalAlign: "center",
                                          get text() {
                                            return getHeroTalentDescription(talentName);
                                          }
                                        });
                                      }
                                    })
                                  });
                                }
                              })];
                            }
                          });
                        }
                        return libs.createComponent(EOM_Panel.EOM_Panel, {
                          className: "TalentBranchLevelRow",
                          flowChildren: "right",
                          get children() {
                            return [libs.createComponent(EOM_Panel.EOM_Panel, {
                              get className() {
                                return libs.classNames("TalentRow");
                              },
                              get children() {
                                return libs.createComponent(EOM_Label.EOM_Label, {
                                  html: true,
                                  verticalAlign: "center",
                                  text: descLeft
                                });
                              }
                            }), libs.createComponent(EOM_XP.EOM_XP, {
                              get level() {
                                return Number(level);
                              },
                              verticalAlign: 'center'
                            }), libs.createComponent(EOM_Panel.EOM_Panel, {
                              get className() {
                                return libs.classNames("TalentRow");
                              },
                              get children() {
                                return libs.createComponent(EOM_Label.EOM_Label, {
                                  html: true,
                                  verticalAlign: "center",
                                  text: descRight
                                });
                              }
                            })];
                          }
                        });
                      });
                    }
                  })();
                }
              })];
            }
          })];
        }
      })];
    }
  });
}
function SetupTooltip() {
  const hero_name = pTooltipPanel.GetAttributeString("hero_name", "");
  let skin_id = pTooltipPanel.GetAttributeString("skin_id", "");
  if (skin_id == "undefined") {
    skin_id = "";
  }
  libs.render(() => libs.createComponent(TooltipContents, {
    hero_name: hero_name,
    skin_id: skin_id
  }), pTooltipPanel);
}
(function () {
  pTooltipPanel.SetPanelEvent("ontooltiploaded", SetupTooltip);
  {
    let pArrow = pTooltipPanel.GetParent()?.FindChildTraverse("LeftArrow");
    if (pArrow) {
      pArrow.style.washColor = "#12141a";
    }
    pArrow = pTooltipPanel.GetParent()?.FindChildTraverse("RightArrow");
    if (pArrow) {
      pArrow.style.washColor = "#12141a";
    }
  }
  {
    let pArrow = pTooltipPanel.GetParent()?.GetParent()?.FindChildTraverse("TopArrow");
    if (pArrow) {
      pArrow.style.washColor = "#12141a";
    }
    pArrow = pTooltipPanel.GetParent()?.GetParent()?.FindChildTraverse("BottomArrow");
    if (pArrow) {
      pArrow.style.washColor = "#12141a";
    }
  }
  pTooltipPanel.style.minHeight = "150px";
})();