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
var ItemImage = require('./ItemImage.js');
var SectIcon = require('./SectIcon.js');
require('./EOM_Image.js');

let pTooltipPanel = $.GetContextPanel();
pTooltipPanel.style.minHeight = "0px";
pTooltipPanel.FindAncestor("greevil_card").FindChildTraverse("LeftArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("greevil_card").FindChildTraverse("RightArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("greevil_card").FindChildTraverse("TopArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("greevil_card").FindChildTraverse("BottomArrow").style.opacity = "0";
function getCardDescription(abilityName, level = 1, entIndex = -1, onlyShowNowLevel = false) {
  const abilityKV = GameUI.CustomUIConfig().AbilitiesKv[abilityName] ?? KeyValues.GreevilEffectKV[abilityName] ?? KeyValues.TraitKv[abilityName] ?? KeyValues.CardEffectKv[abilityName];
  let str = $.Localize('#DOTA_Tooltip_ability_' + abilityName + '_description');
  str = replaceInfo(str);
  str = replaceKeyword(str);
  str = replaceAbility(str);
  str = replaceBuffEnum(str);
  str = replaceAbilityValues(str);
  str = getKeyValueDescription(abilityKV?.AbilityValues ?? {}, str, {
    entIndex,
    level,
    onlyShowNowLevel: onlyShowNowLevel
  });
  return str;
}
function TooltipContents(props) {
  KeyValues.GreevilEffectKV[props.name] ?? KeyValues.TraitKv[props.name] ?? KeyValues.CardEffectKv[props.name];
  const greevilGift = GameUI.CustomUIConfig().GreevilGiftList.includes(props.name);
  let abilityImage = "s2r://panorama/images/custom_game/icon/greevil_icon_png.vtex";
  if (greevilGift) {
    abilityImage = `s2r://panorama/images/custom_game/greevil_shop/greevil_gift_ability_icon_png.vtex`;
  } else {
    if (props.type == "trait") {
      abilityImage = `s2r://panorama/images/custom_game/greevil_shop/greevil_effect_icon_png.vtex`;
    } else if (props.type == "greevil_effect") {
      abilityImage = `s2r://panorama/images/custom_game/icon/greevil_icon_png.vtex`;
    } else if (props.type == "card_effect") {
      abilityImage = `s2r://panorama/images/custom_game/card/card_effect_icon_png.vtex`;
    }
  }
  let list = [];
  list = list.concat(getKeyWordList($.Localize("#DOTA_Tooltip_ability_" + props.name + "_description")));
  const keywordList = [];
  const infoList = [];
  const abilityList = [];
  list.forEach(v => {
    if (v.type == "KeyWord") {
      if (!keywordList.includes(v.value)) {
        keywordList.push(v.value);
      }
    } else if (v.type == "Ability") {
      if (!abilityList.includes(v.value)) {
        abilityList.push(v.value);
      }
    } else if (v.type == "Info") {
      if (!infoList.includes(v.value)) {
        infoList.push(v.value);
      }
    }
  });
  const abilityDescription = getCardDescription(props.name);
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    flowChildren: "down-wrap",
    get children() {
      return [libs.createComponent(EOM_Tooltip.EOM_Tooltip, {
        width: "380px",
        flowChildren: "down",
        onload: () => {
          $.GetContextPanel().style.minHeight = "0px";
        },
        get children() {
          return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
            flowChildren: "right",
            get children() {
              return [libs.createComponent(libs.Show, {
                get when() {
                  return props.type == "greevil_effect";
                },
                get fallback() {
                  return (() => {
                    const _el$2 = libs.createElement("Image", {
                      src: abilityImage
                    }, null);
                    libs.setProp(_el$2, "className", "GreevilAbilityImage");
                    libs.setProp(_el$2, "src", abilityImage);
                    return _el$2;
                  })();
                },
                get children() {
                  const _el$ = libs.createElement("DOTAAbilityImage", {
                    get abilityname() {
                      return props.name;
                    }
                  }, null);
                  libs.setProp(_el$, "className", "GreevilAbilityImage");
                  libs.effect(_$p => libs.setProp(_el$, "abilityname", props.name, _$p));
                  return _el$;
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                flowChildren: "down",
                marginLeft: "8px",
                height: "100%",
                get children() {
                  return [libs.createComponent(GenericPanel.CLabel, {
                    id: "SectNameHeader",
                    html: true,
                    get text() {
                      return "#DOTA_Tooltip_ability_" + props.name;
                    }
                  }), libs.createComponent(libs.Switch, {
                    get fallback() {
                      return libs.createComponent(GenericPanel.CLabel, {
                        className: "AbilityType",
                        text: "#Greevil_Record_Effect"
                      });
                    },
                    get children() {
                      return [libs.createComponent(libs.Match, {
                        when: greevilGift,
                        get children() {
                          return libs.createComponent(GenericPanel.CLabel, {
                            className: "AbilityType",
                            text: "#GreevilGift"
                          });
                        }
                      }), libs.createComponent(libs.Match, {
                        get when() {
                          return props.type == "card_effect";
                        },
                        get children() {
                          return libs.createComponent(GenericPanel.CLabel, {
                            className: "AbilityType",
                            text: "#Greevil_Record_Rune"
                          });
                        }
                      })];
                    }
                  })];
                }
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "SectRow",
            flowChildren: "right",
            get children() {
              return libs.createComponent(GenericPanel.CLabel, {
                className: "AbilityDescription",
                html: true,
                text: abilityDescription
              });
            }
          })];
        }
      }), libs.memo(() => libs.memo(() => !!(keywordList.length > 0 || infoList.length > 0 || abilityList.length > 0))() && libs.createComponent(EOM_Tooltip.EOM_Tooltip, {
        width: "380px",
        flowChildren: "down",
        get children() {
          return [libs.memo(() => libs.memo(() => abilityList.length > 0)() && libs.createComponent(AbilityList, {
            keywordList: abilityList,
            marginTop: "0px",
            entityIndex: -1
          })), libs.memo(() => libs.memo(() => keywordList.length > 0)() && libs.createComponent(KeyWordList, {
            keywordList: keywordList,
            get marginTop() {
              return abilityList.length > 0 ? "4px" : "0px";
            }
          })), libs.memo(() => libs.memo(() => infoList.length > 0)() && libs.createComponent(InfoList, {
            keywordList: infoList,
            get marginTop() {
              return abilityList.length > 0 || keywordList.length > 0 ? "4px" : "0px";
            }
          }))];
        }
      }))];
    }
  });
}
function KeyWordList({
  keywordList,
  marginTop
}) {
  keywordList = removeRepeatKeyword(keywordList);
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    width: "380px",
    flowChildren: "down",
    get children() {
      return keywordList.map((keyword, index) => {
        return libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
          flowChildren: "down",
          marginTop: index == 0 ? marginTop : "4px",
          get children() {
            return [libs.createComponent(EOM_Label.EOM_Label, {
              html: true,
              fontSize: "16px",
              get text() {
                return replaceKeyword(`{KeyWord:${keyword}}`);
              }
            }), libs.createComponent(EOM_Label.EOM_Label, {
              html: true,
              fontSize: "14px",
              marginTop: "2px",
              get text() {
                return replaceAll($.Localize("#KeyWord_" + keyword + "_description"));
              }
            })];
          }
        });
      });
    }
  });
}
function InfoList({
  keywordList,
  marginTop
}) {
  keywordList = removeRepeatKeyword(keywordList);
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    width: "380px",
    flowChildren: "down",
    get children() {
      return keywordList.map((keyword, index) => {
        return libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
          flowChildren: "down",
          marginTop: index == 0 ? marginTop : "4px",
          get children() {
            return [libs.createComponent(EOM_Label.EOM_Label, {
              html: true,
              fontSize: "16px",
              text: "#" + keyword
            }), libs.createComponent(EOM_Label.EOM_Label, {
              html: true,
              fontSize: "14px",
              marginTop: "2px",
              get text() {
                return replaceAll($.Localize("#" + keyword + "_description"));
              }
            })];
          }
        });
      });
    }
  });
}
function AbilityList({
  keywordList,
  marginTop,
  entityIndex
}) {
  keywordList = removeRepeatKeyword(keywordList);
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    width: "380px",
    flowChildren: "down",
    get children() {
      return keywordList.map((keyword, index) => {
        return libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
          padding: '0px',
          flowChildren: "down",
          marginTop: index == 0 ? marginTop : "4px",
          get children() {
            return libs.createComponent(AbilityKeyWordContainer, {
              abilityName: keyword,
              index: index,
              entityIndex: entityIndex
            });
          }
        });
      });
    }
  });
}
const AbilityKeyWordContainer = props => {
  const {
    abilityName,
    index,
    entityIndex
  } = props;
  const abilityUpgradeInfo = KeyValues.AbilityUpgradesKv[abilityName];
  const abilityKV = KeyValues.AbilitiesKv[abilityName];
  const itemKV = KeyValues.ItemsKv[abilityName];
  if (abilityUpgradeInfo != undefined) {
    const sectList = abilityUpgradeInfo.sect.split("|");
    const lore = replaceBuffEnum($.Localize("#DOTA_Tooltip_ability_mechanics_" + abilityName + "_Lore"));
    return libs.createComponent(EOM_Panel.EOM_Panel, {
      className: "AbilityKeyWordContainer Sect",
      flowChildren: 'down',
      get children() {
        return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
          flowChildren: "right",
          get children() {
            return [libs.createComponent(GenericPanel.CImage, {
              className: "SectAbilityImage",
              get src() {
                return `file://{images}/spellicons/${abilityUpgradeInfo.Texture}.png`;
              }
            }), libs.createComponent(EOM_Panel.EOM_Panel, {
              flowChildren: "down",
              marginLeft: "8px",
              height: "100%",
              get children() {
                return [libs.createComponent(GenericPanel.CLabel, {
                  id: "SectNameHeader",
                  html: true,
                  get text() {
                    return $.Localize("#DOTA_Tooltip_ability_mechanics_" + abilityName);
                  }
                }), libs.createComponent(EOM_Panel.EOM_Panel, {
                  flowChildren: "right",
                  verticalAlign: "bottom",
                  get children() {
                    return sectList.map((sectName, index) => {
                      return libs.createComponent(SectIcon.SectIcon, {
                        width: "28px",
                        height: "28px",
                        sectName: sectName
                      });
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
            return libs.createComponent(GenericPanel.CLabel, {
              className: "SectDescription",
              html: true,
              get text() {
                return getSectDescription(abilityName, -1, false);
              }
            });
          }
        }), libs.memo(() => lore != "#DOTA_Tooltip_ability_mechanics_" + abilityName + "_Lore" && libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "LoreContainer",
          get children() {
            return libs.createComponent(GenericPanel.CLabel, {
              html: true,
              text: lore
            });
          }
        }))];
      }
    });
  } else if (abilityKV) {
    return libs.createComponent(EOM_Panel.EOM_Panel, {
      className: "AbilityKeyWordContainer Ability",
      flowChildren: 'down',
      get children() {
        return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
          flowChildren: "right",
          get children() {
            return [(() => {
              const _el$3 = libs.createElement("DOTAAbilityImage", {
                abilityname: abilityName,
                scaling: "stretch-to-cover-preserve-aspect"
              }, null);
              libs.setProp(_el$3, "className", "SectAbilityImage");
              libs.setProp(_el$3, "abilityname", abilityName);
              return _el$3;
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
                    return abilityKV.AbilityType != undefined;
                  },
                  get children() {
                    return libs.createComponent(GenericPanel.CLabel, {
                      className: "AbilityType",
                      get text() {
                        return "#" + abilityKV.AbilityType;
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
              abilityName: abilityName,
              entityIndex: entityIndex
            });
          }
        })];
      }
    });
  } else if (itemKV) {
    const itemname = abilityName;
    const lore = replaceBuffEnum($.Localize("#DOTA_Tooltip_ability_" + itemname + "_Lore"));
    const sectList = itemKV.Sect?.split("|") ?? [];
    let bHasDescription = $.Localize("#DOTA_Tooltip_ability_" + itemname + "_description") != "#DOTA_Tooltip_ability_" + itemname + "_description";
    let sAttributes = getItemArrtibute(itemname);
    const text = getItemDescription(itemname);
    return libs.createComponent(EOM_Panel.EOM_Panel, {
      className: "AbilityKeyWordContainer Item",
      flowChildren: 'down',
      get children() {
        return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
          flowChildren: "right",
          get children() {
            return [libs.createComponent(ItemImage.ItemImage, {
              width: "60px",
              height: "45px",
              align: "center center",
              itemName: itemname
            }), libs.createComponent(EOM_Panel.EOM_Panel, {
              flowChildren: "down",
              marginLeft: "8px",
              height: "100%",
              get children() {
                return [libs.createComponent(GenericPanel.CLabel, {
                  id: "SectNameHeader",
                  html: true,
                  get text() {
                    return $.Localize("#DOTA_Tooltip_ability_" + itemname);
                  }
                }), libs.createComponent(EOM_Panel.EOM_Panel, {
                  flowChildren: "right",
                  verticalAlign: "bottom",
                  get children() {
                    return [libs.memo(() => sectList.map((sectName, index) => {
                      return libs.createComponent(SectIcon.SectIcon, {
                        width: "28px",
                        height: "28px",
                        sectName: sectName
                      });
                    })), libs.createComponent(libs.Show, {
                      get when() {
                        return libs.memo(() => itemKV?.Repeat == undefined)() && itemname.indexOf("item_artifact_") != -1;
                      },
                      get children() {
                        const _el$4 = libs.createElement("Label", {
                          text: "#DOTA_SHOP_CATEGORY_UNIQUES"
                        }, null);
                        libs.setProp(_el$4, "className", "AbilityType");
                        return _el$4;
                      }
                    })];
                  }
                })];
              }
            })];
          }
        }), libs.createComponent(EOM_Panel.EOM_Panel, {
          className: "SectRow",
          flowChildren: "down",
          get children() {
            return [libs.memo(() => sAttributes != "" && libs.createComponent(GenericPanel.CLabel, {
              className: "Attribute",
              html: true,
              text: sAttributes
            })), libs.memo(() => bHasDescription && text != "" && libs.createComponent(GenericPanel.CLabel, {
              className: "SectDescription",
              html: true,
              text: text
            }))];
          }
        }), libs.memo(() => lore != "" && lore != "#DOTA_Tooltip_ability_" + itemname + "_Lore" && libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "LoreContainer",
          get children() {
            return libs.createComponent(GenericPanel.CLabel, {
              html: true,
              text: lore
            });
          }
        }))];
      }
    });
  }
};
function removeRepeatKeyword(keywordList) {
  var newList = [];
  for (const keyword of keywordList) {
    if (newList.indexOf(keyword) == -1) {
      newList.push(keyword);
    }
  }
  return newList;
}
function SetupTooltip() {
  const name = pTooltipPanel.GetAttributeString("ability_name", "");
  const type = pTooltipPanel.GetAttributeString("type", "");
  let flag = false;
  if (type == "greevil_effect") {
    flag = KeyValues.GreevilEffectKV[name] != undefined;
  } else if (type == "trait") {
    flag = KeyValues.TraitKv[name] != undefined;
  } else if (type == "card_effect") {
    flag = KeyValues.CardEffectKv[name] != undefined;
  }
  if (!flag) return;
  libs.render(() => libs.createComponent(TooltipContents, {
    name: name,
    type: type
  }), pTooltipPanel);
}
(function () {
  pTooltipPanel.SetPanelEvent("ontooltiploaded", SetupTooltip);
})();