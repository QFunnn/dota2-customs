--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Tooltip = require('./EOM_Tooltip.js');
var EOM_Label = require('./EOM_Label.js');

let pTooltipPanel = $.GetContextPanel();
pTooltipPanel.style.minHeight = "0px";
pTooltipPanel.FindAncestor("greevil_record").FindChildTraverse("LeftArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("greevil_record").FindChildTraverse("RightArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("greevil_record").FindChildTraverse("TopArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("greevil_record").FindChildTraverse("BottomArrow").style.opacity = "0";
const recordTypeAliasMap = {
  attribute: "attribute",
  effect: "greevil_effect",
  greevil_effect: "greevil_effect",
  card_effect: "card_effect",
  trait: "trait"
};
const recordTypeTitleMap = {
  attribute: "#AttributeTitle",
  greevil_effect: "#Greevil_Record_Effect",
  card_effect: "#Greevil_Record_Rune",
  trait: "#RuneReward"
};
function localizeText(key) {
  const localized = $.Localize(key);
  return localized == key ? key : localized;
}
function getAttribute(attrType, value) {
  let localize = $.Localize('#dota_tooltip_item_variable_' + attrType);
  localize = replaceInfo(localize);
  const bHasPercentSign = localize.search(/%/g) == 0;
  let name = localize.substring(bHasPercentSign ? 2 : 1, localize.length);
  if (value < 0) {
    name = "<font color='#e03f2f'>" + name + '</font>';
  }
  return (value >= 0 ? '+' : '-') + " <span class='GameplayValues GameplayVariable'>" + Math.abs(value) + (bHasPercentSign ? '%' : '') + '</span> ' + name;
}
function getAbilityTitle(abilityName) {
  const key = `#DOTA_Tooltip_ability_${abilityName}`;
  const localized = $.Localize(key);
  if (localized != key) {
    return localized;
  }
  return abilityName;
}
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
function EmptyText() {
  return libs.createComponent(EOM_Label.EOM_Label, {
    id: "RecordEmpty",
    get text() {
      return localizeText("#Greevil_Shop_Record_None");
    }
  });
}
function AttributeRecordList(props) {
  const list = Object.entries(props.attributes).sort((a, b) => Math.abs(b[1]) - Math.abs(a[1]));
  return libs.createComponent(libs.Show, {
    get when() {
      return list.length > 0;
    },
    get fallback() {
      return libs.createComponent(EmptyText, {});
    },
    get children() {
      return libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "RecordList",
        flowChildren: "down",
        get children() {
          return libs.createComponent(libs.For, {
            each: list,
            children: ([attrType, value]) => {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "RecordRow",
                flowChildren: "right",
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    className: "RecordAttribute",
                    get text() {
                      return getAttribute(attrType, value);
                    },
                    html: true
                  });
                }
              });
            }
          });
        }
      });
    }
  });
}
function buildArtifactDetailMap(effectNames, playerID) {
  const abilityUpgradeList = {};
  const abilityExtraDataList = {};
  const abilityExtraStringDataList = {};
  if (playerID != Players.GetLocalPlayer()) {
    return {
      abilityUpgradeList,
      abilityExtraDataList,
      abilityExtraStringDataList
    };
  }
  const unitEnt = Players.GetPlayerHeroEntityIndex(playerID);
  if (unitEnt == -1) {
    return {
      abilityUpgradeList,
      abilityExtraDataList,
      abilityExtraStringDataList
    };
  }
  const abilityCached = getNetDataCache("artifact_abilities", playerID);
  const extraDataCached = getNetDataCache("artifact_extra_data", playerID);
  const extraStringDataCached = getNetDataCache("artifact_extra_string_data", playerID);
  for (const effectName of effectNames) {
    const ent = Entities.GetAbilityByName(unitEnt, effectName);
    if (ent == -1) {
      continue;
    }
    if (abilityCached?.[ent]) {
      abilityUpgradeList[effectName] = abilityCached[ent];
    }
    if (extraDataCached?.[ent]) {
      abilityExtraDataList[effectName] = extraDataCached[ent];
    }
    if (extraStringDataCached?.[ent]) {
      abilityExtraStringDataList[effectName] = extraStringDataCached[ent];
    }
  }
  return {
    abilityUpgradeList,
    abilityExtraDataList,
    abilityExtraStringDataList
  };
}
function GreevilEffectRecordList(props) {
  const combineList = [...props.greevilEffects, ...props.traits];
  const limitCount = 3;
  return libs.createComponent(libs.Show, {
    get when() {
      return combineList.length > 0;
    },
    get fallback() {
      return libs.createComponent(EmptyText, {});
    },
    get children() {
      return libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "RecordList",
        flowChildren: "down",
        get children() {
          return libs.createComponent(libs.For, {
            each: combineList,
            children: effectName => {
              const upgrades = props.abilityUpgradeList[effectName] ?? [];
              const extraData = props.abilityExtraDataList[effectName] ?? {};
              const extraStringData = props.abilityExtraStringDataList[effectName] ?? {};
              const recentUpgrades = upgrades.filter((v, i) => upgrades.length - i <= limitCount);
              const isGreevilGift = KeyValues.GreevilGiftList.includes(effectName);
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "RecordAbilityRow",
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    width: "100%",
                    flowChildren: "right",
                    get children() {
                      return [libs.createComponent(libs.Show, {
                        when: !isGreevilGift,
                        get fallback() {
                          return (() => {
                            const _el$2 = libs.createElement("Image", {}, null);
                            libs.setProp(_el$2, "className", "RecordAbilityImage GreevilGift");
                            return _el$2;
                          })();
                        },
                        get children() {
                          const _el$ = libs.createElement("DOTAAbilityImage", {
                            get abilityname() {
                              return KeyValues.TraitKv[effectName] != undefined ? "greevil_effect_replace" : effectName;
                            }
                          }, null);
                          libs.setProp(_el$, "className", "RecordAbilityImage");
                          libs.effect(_$p => libs.setProp(_el$, "abilityname", KeyValues.TraitKv[effectName] != undefined ? "greevil_effect_replace" : effectName, _$p));
                          return _el$;
                        }
                      }), libs.createComponent(EOM_Panel.EOM_Panel, {
                        className: "RecordAbilityContent",
                        flowChildren: "down",
                        get children() {
                          return [libs.createComponent(EOM_Label.EOM_Label, {
                            className: "RecordAbilityName",
                            get text() {
                              return getAbilityTitle(effectName);
                            }
                          }), libs.createComponent(libs.Show, {
                            get when() {
                              return getCardDescription(effectName) != "";
                            },
                            get children() {
                              return libs.createComponent(EOM_Label.EOM_Label, {
                                className: "RecordAbilityDescription",
                                html: true,
                                get text() {
                                  return getCardDescription(effectName);
                                }
                              });
                            }
                          })];
                        }
                      })];
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    "class": "RecordExtraInfoBlock",
                    get children() {
                      return [libs.createComponent(libs.For, {
                        get each() {
                          return Object.entries(extraData);
                        },
                        children: ([key, value]) => libs.createComponent(libs.Show, {
                          when: value > 0,
                          get children() {
                            return libs.createComponent(EOM_Label.EOM_Label, {
                              className: "RecordAbilityExtra",
                              html: true,
                              text: "#artifact_extra_data",
                              get dialogVariables() {
                                return {
                                  key: ` ${$.Localize("#" + key)}`,
                                  value: value
                                };
                              }
                            });
                          }
                        })
                      }), libs.createComponent(libs.For, {
                        get each() {
                          return Object.entries(extraStringData);
                        },
                        children: ([key, value]) => libs.createComponent(EOM_Label.EOM_Label, {
                          className: "RecordAbilityExtra",
                          html: true,
                          text: "#artifact_extra_string_data",
                          get dialogVariables() {
                            return {
                              key: ` ${$.Localize("#" + key)}`,
                              value: ` ${$.Localize(value) == value ? value : $.Localize(value)}`
                            };
                          }
                        })
                      }), libs.createComponent(libs.Show, {
                        get when() {
                          return upgrades.length > 0;
                        },
                        get children() {
                          return libs.createComponent(EOM_Panel.EOM_Panel, {
                            margin: "0 6px",
                            width: "100%",
                            flowChildren: "down",
                            get children() {
                              return [libs.createComponent(libs.Show, {
                                get when() {
                                  return upgrades.length > limitCount;
                                },
                                get children() {
                                  return libs.createComponent(EOM_Label.EOM_Label, {
                                    className: "RecordAbilityLimitTip",
                                    text: "#landEffect_AbilityMaxCount",
                                    dialogVariables: {
                                      count: limitCount
                                    }
                                  });
                                }
                              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                get className() {
                                  return `AbilityList ${upgrades.length >= limitCount ? "OverFlow" : ""}`;
                                },
                                flowChildren: "down",
                                get children() {
                                  return [libs.createComponent(libs.For, {
                                    each: recentUpgrades,
                                    children: abilityUpgradeID => {
                                      const abilityUpgradeInfo = GameUI.CustomUIConfig().AbilityUpgradesKv[abilityUpgradeID];
                                      const rarity = abilityUpgradeInfo?.rarity;
                                      const titleKey = "#DOTA_Tooltip_ability_mechanics_" + abilityUpgradeID;
                                      const localizedTitle = $.Localize(titleKey);
                                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                                        className: "AbilityRow",
                                        flowChildren: "right",
                                        get children() {
                                          return [(() => {
                                            const _el$3 = libs.createElement("Image", {
                                              get src() {
                                                return abilityUpgradeInfo?.Texture ? `file://{images}/spellicons/${abilityUpgradeInfo.Texture}.png` : "";
                                              }
                                            }, null);
                                            libs.setProp(_el$3, "className", "AbilityImage");
                                            libs.effect(_$p => libs.setProp(_el$3, "src", abilityUpgradeInfo?.Texture ? `file://{images}/spellicons/${abilityUpgradeInfo.Texture}.png` : "", _$p));
                                            return _el$3;
                                          })(), libs.createComponent(EOM_Panel.EOM_Panel, {
                                            flowChildren: "down",
                                            marginLeft: "8px",
                                            get children() {
                                              return [libs.createComponent(EOM_Label.EOM_Label, {
                                                className: `SectName ${rarity == "r" ? "Rare" : rarity == "sr" ? "SuperRare" : ""}`,
                                                html: true,
                                                text: localizedTitle == titleKey ? abilityUpgradeID : localizedTitle
                                              }), libs.createComponent(libs.Show, {
                                                when: abilityUpgradeInfo != undefined,
                                                get children() {
                                                  return libs.createComponent(EOM_Label.EOM_Label, {
                                                    className: "AbilityDescription",
                                                    html: true,
                                                    get text() {
                                                      return getSectDescription(abilityUpgradeID, 1, true, props.player_id);
                                                    }
                                                  });
                                                }
                                              })];
                                            }
                                          })];
                                        }
                                      });
                                    }
                                  }), libs.createComponent(EOM_Label.EOM_Label, {
                                    id: "ExtraAbilityCount",
                                    get text() {
                                      return `${$.Localize("#has_num")} ${upgrades.length}`;
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
              });
            }
          });
        }
      });
    }
  });
}
function CardEffectRecordList(props) {
  const validCardEffects = props.cardEffects.filter(cardName => KeyValues.CardEffectKv[cardName] != undefined);
  return libs.createComponent(libs.Show, {
    get when() {
      return validCardEffects.length > 0;
    },
    get fallback() {
      return libs.createComponent(EmptyText, {});
    },
    get children() {
      return libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "RecordList",
        get children() {
          return libs.createComponent(libs.For, {
            each: validCardEffects,
            children: cardName => libs.createComponent(EOM_Panel.EOM_Panel, {
              className: "RecordAbilityRow",
              flowChildren: "right",
              get children() {
                return [(() => {
                  const _el$4 = libs.createElement("Image", {}, null);
                  libs.setProp(_el$4, "className", "RecordAbilityImage CardEffect");
                  return _el$4;
                })(), libs.createComponent(EOM_Panel.EOM_Panel, {
                  className: "RecordAbilityContent",
                  flowChildren: "down",
                  get children() {
                    return [libs.createComponent(EOM_Label.EOM_Label, {
                      className: "RecordAbilityName",
                      get text() {
                        return getAbilityTitle(cardName);
                      }
                    }), libs.createComponent(libs.Show, {
                      get when() {
                        return getCardDescription(cardName) != "";
                      },
                      get children() {
                        return libs.createComponent(EOM_Label.EOM_Label, {
                          className: "RecordAbilityDescription",
                          html: true,
                          get text() {
                            return getCardDescription(cardName);
                          }
                        });
                      }
                    })];
                  }
                })];
              }
            })
          });
        }
      });
    }
  });
}
function TooltipContents({
  record_type,
  player_id,
  greevil_effects_json,
  trait_json,
  card_effect_json
}) {
  const isBattleRecord = greevil_effects_json != undefined && greevil_effects_json !== "" || trait_json != undefined && trait_json !== "" || card_effect_json != undefined && card_effect_json !== "";
  const greevilRecordData = isBattleRecord ? undefined : getSyncDataKey("common", "greevil_shop_record", player_id);
  const attributes = greevilRecordData?.attribute ?? {};
  KeyValues.GreevilShopKV;
  const greevilEffects = isBattleRecord ? Object.values(JSON.parseSafe(greevil_effects_json ?? "") ?? []).map(v => "greevil_effect_" + v).filter(v => KeyValues.GreevilEffectKV[v] != undefined) : greevilRecordData?.greevil_effect ?? [];
  const cardEffects = isBattleRecord ? Object.values(JSON.parseSafe(card_effect_json ?? "") ?? []).map(v => "card_effect_" + v).filter(v => KeyValues.CardEffectKv[v] != undefined) : greevilRecordData?.card_effect ?? [];
  const traits = isBattleRecord ? Object.values(JSON.parseSafe(trait_json ?? "") ?? []).map(v => "trait_" + v).filter(v => KeyValues.TraitKv[v] != undefined) : greevilRecordData?.trait ?? [];
  const {
    abilityUpgradeList,
    abilityExtraDataList,
    abilityExtraStringDataList
  } = buildArtifactDetailMap([...greevilEffects, ...traits], player_id);
  return libs.createComponent(EOM_Tooltip.EOM_Tooltip, {
    id: "GreevilRecordTooltip",
    flowChildren: "down",
    get children() {
      return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
        id: "RecordHeader",
        get children() {
          return libs.createComponent(EOM_Label.EOM_Label, {
            get text() {
              return localizeText(recordTypeTitleMap[record_type]);
            }
          });
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "TooltipContent",
        flowChildren: "right",
        get children() {
          return [libs.createComponent(libs.Show, {
            when: record_type == "attribute",
            get children() {
              return libs.createComponent(AttributeRecordList, {
                attributes: attributes
              });
            }
          }), libs.createComponent(libs.Show, {
            when: record_type == "greevil_effect",
            get children() {
              return libs.createComponent(GreevilEffectRecordList, {
                greevilEffects: greevilEffects,
                traits: traits,
                abilityUpgradeList: abilityUpgradeList,
                abilityExtraDataList: abilityExtraDataList,
                abilityExtraStringDataList: abilityExtraStringDataList,
                player_id: player_id
              });
            }
          }), libs.createComponent(libs.Show, {
            when: record_type == "card_effect",
            get children() {
              return libs.createComponent(CardEffectRecordList, {
                cardEffects: cardEffects
              });
            }
          })];
        }
      })];
    }
  });
}
function SetupTooltip() {
  let recordType = pTooltipPanel.GetAttributeString("record_type", "");
  if (!recordTypeAliasMap[recordType]) {
    recordType = "attribute";
  }
  const normalizedRecordType = recordTypeAliasMap[recordType];
  const playerID = pTooltipPanel.GetAttributeInt("player_id", Players.GetLocalPlayer());
  const greevil_effects_json = pTooltipPanel.GetAttributeString("greevil_effects_json", "") || undefined;
  const trait_json = pTooltipPanel.GetAttributeString("trait_json", "") || undefined;
  const card_effect_json = pTooltipPanel.GetAttributeString("card_effect_json", "") || undefined;
  libs.render(() => libs.createComponent(TooltipContents, {
    record_type: normalizedRecordType,
    player_id: playerID,
    greevil_effects_json: greevil_effects_json,
    trait_json: trait_json,
    card_effect_json: card_effect_json
  }), pTooltipPanel);
}
(function () {
  pTooltipPanel.SetPanelEvent("ontooltiploaded", SetupTooltip);
})();