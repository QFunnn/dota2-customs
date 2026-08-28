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
var EOM_Label = require('./EOM_Label.js');
var GenericPanel = require('./GenericPanel.js');

const tooltipPanel = $.GetContextPanel();
tooltipPanel.style.minHeight = '0px';
const tooltipRoot = tooltipPanel.FindAncestor('treasure_list');
const hideTooltipArrow = arrowID => {
  const arrow = tooltipRoot?.FindChildTraverse(arrowID);
  if (arrow != undefined) {
    arrow.style.opacity = '0';
  }
};
hideTooltipArrow('LeftArrow');
hideTooltipArrow('RightArrow');
hideTooltipArrow('TopArrow');
hideTooltipArrow('BottomArrow');
var KeywordListTooltipTypes = function (KeywordListTooltipTypes) {
  KeywordListTooltipTypes["keyword"] = "KeyWord";
  KeywordListTooltipTypes["info"] = "Info";
  KeywordListTooltipTypes["ability"] = "Ability";
  return KeywordListTooltipTypes;
}(KeywordListTooltipTypes || {});
const TreasureListTooltip = props => {
  const [treasureList, setTreasureList] = libs.createSignal(props.override_list ?? []);
  const [artifactData, setArtifactData] = libs.createSignal({
    abilities: {},
    extraData: {},
    extraStringData: {}
  });
  const keywordList = libs.createMemo(() => {
    const keywords = [];
    const seenKeywords = {};
    for (const treasureAbilityName of treasureList()) {
      for (const keyword of getKeyWordList($.Localize(`#DOTA_Tooltip_ability_${treasureAbilityName}_description`))) {
        const key = `${keyword.type}:${keyword.value}`;
        if (!seenKeywords[key]) {
          seenKeywords[key] = true;
          keywords.push(keyword);
        }
      }
    }
    return keywords.sort((a, b) => Number(b.type == KeywordListTooltipTypes.ability) - Number(a.type == KeywordListTooltipTypes.ability));
  });
  if (props.playerID != -1) {
    libs.onMount(() => {
      const listenerID = useNetTableKeyHasDefaultValue('player_data', props.playerID.toString(), data => {
        setTreasureList((data?.treasure == undefined ? [] : Object.values(data.treasure)).sort((a, b) => (KeyValues.treasure_abilities[b]?.TreasureType ?? 0) - (KeyValues.treasure_abilities[a]?.TreasureType ?? 0)));
      });
      const eventIDList = [];
      if (props.playerID == Players.GetLocalPlayer()) {
        setArtifactData({
          abilities: getNetDataCache('artifact_abilities', props.playerID) ?? {},
          extraData: getNetDataCache('artifact_extra_data', props.playerID) ?? {},
          extraStringData: getNetDataCache('artifact_extra_string_data', props.playerID) ?? {}
        });
        eventIDList.push(useNetData('artifact_abilities', abilities => {
          setArtifactData(data => ({
            ...data,
            abilities
          }));
        }, props.playerID));
        eventIDList.push(useNetData('artifact_extra_data', extraData => {
          setArtifactData(data => ({
            ...data,
            extraData
          }));
        }, props.playerID));
        eventIDList.push(useNetData('artifact_extra_string_data', extraStringData => {
          setArtifactData(data => ({
            ...data,
            extraStringData
          }));
        }, props.playerID));
      }
      libs.onCleanup(() => {
        CustomNetTables.UnsubscribeNetTableListener(listenerID);
        eventIDList.forEach(eventID => GameEvents.Unsubscribe(eventID));
      });
    });
  }
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    flowChildren: "down",
    get children() {
      return [libs.createComponent(EOM_Tooltip.EOM_Tooltip, {
        width: "380px",
        flowChildren: "down",
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "TreasureList",
            flowChildren: "down",
            get children() {
              return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
                className: "TreasureListTitle",
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#RuneReward_Treasure"
                  });
                }
              }), libs.createComponent(libs.Show, {
                get when() {
                  return treasureList().length > 0;
                },
                get fallback() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    className: "TreasureListEmpty",
                    text: "#TreasureList_Empty"
                  });
                },
                get children() {
                  return libs.createComponent(libs.For, {
                    get each() {
                      return treasureList();
                    },
                    children: treasureAbilityName => libs.createComponent(TreasureAbility, {
                      abilityName: treasureAbilityName,
                      get playerID() {
                        return props.playerID;
                      },
                      get artifactData() {
                        return artifactData();
                      }
                    })
                  });
                }
              })];
            }
          });
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return keywordList().length > 0;
        },
        get children() {
          return libs.createComponent(EOM_Tooltip.EOM_Tooltip, {
            width: "380px",
            flowChildren: "down",
            get children() {
              return libs.createComponent(libs.For, {
                get each() {
                  return keywordList();
                },
                children: (keyword, index) => libs.createComponent(TreasureKeyword, {
                  keyword: keyword,
                  get index() {
                    return index();
                  }
                })
              });
            }
          });
        }
      })];
    }
  });
};
const TreasureAbility = props => {
  const upgradeLimit = 5;
  const abilityEntityIndex = libs.createMemo(() => {
    const heroEntityIndex = Players.GetPlayerHeroEntityIndex(props.playerID);
    return heroEntityIndex == -1 ? -1 : Entities.GetAbilityByName(heroEntityIndex, props.abilityName);
  });
  const extraData = libs.createMemo(() => props.artifactData.extraData[abilityEntityIndex()] ?? {});
  const extraStringData = libs.createMemo(() => props.artifactData.extraStringData[abilityEntityIndex()] ?? {});
  const upgradeList = libs.createMemo(() => props.artifactData.abilities[abilityEntityIndex()] ?? []);
  const visibleUpgradeList = libs.createMemo(() => upgradeList().slice(-upgradeLimit));
  let TreasureType = KeyValues.treasure_abilities[props.abilityName]?.TreasureType ?? 0;
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    className: "TreasureListAbility",
    flowChildren: "down",
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        get className() {
          return libs.classNames("TreasureListAbilityHeader", "Type_" + TreasureType);
        },
        get children() {
          return [(() => {
            const _el$ = libs.createElement("Image", {}, null);
            libs.setProp(_el$, "className", "TreasureAbilityImage");
            return _el$;
          })(), libs.createComponent(EOM_Label.EOM_Label, {
            get text() {
              return `#DOTA_Tooltip_ability_${props.abilityName}`;
            }
          })];
        }
      }), libs.createComponent(AbilityDescription.AbilityDescription, {
        className: "TreasureListAbilityDescription",
        get abilityName() {
          return props.abilityName;
        },
        level: 1
      }), libs.createComponent(libs.Index, {
        get each() {
          return Object.keys(extraData());
        },
        children: key => libs.createComponent(libs.Show, {
          get when() {
            return extraData()[key()] > 0;
          },
          get children() {
            return libs.createComponent(GenericPanel.CLabel, {
              id: "extraText",
              html: true,
              text: "#artifact_extra_data",
              get vars() {
                return {
                  key: ` ${$.Localize(`#${key()}`)}`,
                  value: extraData()[key()]
                };
              }
            });
          }
        })
      }), libs.createComponent(libs.Index, {
        get each() {
          return Object.keys(extraStringData());
        },
        children: key => libs.createComponent(libs.Show, {
          get when() {
            return extraStringData()[key()] != '';
          },
          get children() {
            return libs.createComponent(GenericPanel.CLabel, {
              id: "extraText",
              html: true,
              text: "#artifact_extra_string_data",
              get vars() {
                return {
                  key: ` ${$.Localize(`#${key()}`)}`,
                  value: ` ${localizeValue(extraStringData()[key()])}`
                };
              }
            });
          }
        })
      }), libs.createComponent(libs.Show, {
        get when() {
          return upgradeList().length > 0;
        },
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "TreasureAbilityUpgradeList",
            flowChildren: "down",
            get children() {
              return [libs.createComponent(libs.Show, {
                get when() {
                  return upgradeList().length >= upgradeLimit;
                },
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    className: "TreasureUpgradeLimit",
                    text: "#landEffect_AbilityMaxCount",
                    dialogVariables: {
                      count: upgradeLimit
                    }
                  });
                }
              }), (() => {
                const _el$2 = libs.createElement("Panel", {}, null);
                libs.insert(_el$2, libs.createComponent(libs.For, {
                  get each() {
                    return visibleUpgradeList();
                  },
                  children: abilityUpgradeID => libs.createComponent(TreasureUpgrade, {
                    abilityUpgradeID: abilityUpgradeID
                  })
                }));
                libs.effect(_$p => libs.setProp(_el$2, "className", libs.classNames("TreasureAbilityUpgradeList_List", {
                  Overflow: upgradeList().length > upgradeLimit
                }), _$p));
                return _el$2;
              })(), libs.createComponent(EOM_Label.EOM_Label, {
                className: "TreasureUpgradeCount",
                get text() {
                  return `${$.Localize('#has_num')} ${upgradeList().length}`;
                }
              })];
            }
          });
        }
      })];
    }
  });
};
const TreasureUpgrade = props => {
  const abilityUpgradeInfo = GameUI.CustomUIConfig().AbilityUpgradesKv[props.abilityUpgradeID];
  if (abilityUpgradeInfo == undefined) {
    return null;
  }
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    className: "TreasureAbilityUpgrade",
    flowChildren: "right",
    get children() {
      return [libs.createComponent(GenericPanel.CImage, {
        className: "TreasureUpgradeImage",
        get src() {
          return `file://{images}/spellicons/${abilityUpgradeInfo.Texture}.png`;
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        flowChildren: "down",
        marginLeft: "8px",
        get children() {
          return [libs.createComponent(GenericPanel.CLabel, {
            get className() {
              return libs.classNames('TreasureUpgradeName', {
                Rare: abilityUpgradeInfo.rarity == 'r',
                SuperRare: abilityUpgradeInfo.rarity == 'sr'
              });
            },
            html: true,
            get text() {
              return `#DOTA_Tooltip_ability_mechanics_${props.abilityUpgradeID}`;
            }
          }), libs.createComponent(GenericPanel.CLabel, {
            className: "TreasureUpgradeDescription",
            html: true,
            get text() {
              return getSectDescription(props.abilityUpgradeID, 1, true);
            }
          })];
        }
      })];
    }
  });
};
const TreasureKeyword = props => {
  if (props.keyword.type == KeywordListTooltipTypes.ability) {
    return libs.createComponent(TreasureRelatedAbility, {
      get abilityName() {
        return props.keyword.value;
      },
      get index() {
        return props.index;
      }
    });
  }
  const isKeyword = props.keyword.type == KeywordListTooltipTypes.keyword;
  const title = isKeyword ? replaceAll(`{KeyWord:${props.keyword.value}}`) : $.Localize(`#${props.keyword.value}`);
  const descriptionToken = isKeyword ? `#KeyWord_${props.keyword.value}_description` : `#${props.keyword.value}_description`;
  const description = replaceAll($.Localize(descriptionToken));
  return libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
    padding: '6px',
    flowChildren: "down",
    get marginTop() {
      return props.index == 0 ? '0px' : '4px';
    },
    get children() {
      return [libs.createComponent(EOM_Label.EOM_Label, {
        html: true,
        fontSize: "18px",
        text: title
      }), libs.createComponent(EOM_Label.EOM_Label, {
        html: true,
        fontSize: "16px",
        marginTop: "2px",
        color: "#9bb1cd",
        text: description == descriptionToken ? '' : description
      })];
    }
  });
};
const TreasureRelatedAbility = props => {
  const abilityUpgradeInfo = KeyValues.AbilityUpgradesKv[props.abilityName];
  const abilityKV = KeyValues.AbilitiesKv[props.abilityName];
  if (abilityUpgradeInfo != undefined) {
    return libs.createComponent(EOM_Panel.EOM_Panel, {
      className: "TreasureRelatedAbility",
      get marginTop() {
        return props.index == 0 ? '0px' : '4px';
      },
      flowChildren: "down",
      get children() {
        return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
          flowChildren: "right",
          get children() {
            return [libs.createComponent(GenericPanel.CImage, {
              className: "TreasureRelatedAbilityImage",
              get src() {
                return `file://{images}/spellicons/${abilityUpgradeInfo.Texture}.png`;
              }
            }), libs.createComponent(GenericPanel.CLabel, {
              className: "TreasureRelatedAbilityName",
              html: true,
              get text() {
                return `#DOTA_Tooltip_ability_mechanics_${props.abilityName}`;
              }
            })];
          }
        }), libs.createComponent(GenericPanel.CLabel, {
          className: "TreasureRelatedAbilityDescription",
          html: true,
          get text() {
            return getSectDescription(props.abilityName, -1, false);
          }
        })];
      }
    });
  }
  if (abilityKV != undefined) {
    return libs.createComponent(EOM_Panel.EOM_Panel, {
      className: "TreasureRelatedAbility",
      get marginTop() {
        return props.index == 0 ? '0px' : '4px';
      },
      flowChildren: "down",
      get children() {
        return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
          flowChildren: "right",
          get children() {
            return [(() => {
              const _el$3 = libs.createElement("DOTAAbilityImage", {
                get abilityname() {
                  return props.abilityName;
                }
              }, null);
              libs.setProp(_el$3, "className", "TreasureRelatedAbilityImage");
              libs.effect(_$p => libs.setProp(_el$3, "abilityname", props.abilityName, _$p));
              return _el$3;
            })(), libs.createComponent(GenericPanel.CLabel, {
              className: "TreasureRelatedAbilityName",
              html: true,
              get text() {
                return `#DOTA_Tooltip_ability_${props.abilityName}`;
              }
            })];
          }
        }), libs.createComponent(AbilityDescription.AbilityDescription, {
          className: "TreasureRelatedAbilityDescription",
          get abilityName() {
            return props.abilityName;
          }
        })];
      }
    });
  }
  return null;
};
const localizeValue = value => {
  const localizedValue = $.Localize(value);
  return localizedValue == value ? value : localizedValue;
};
const setupTooltip = () => {
  let playerID = tooltipPanel.GetAttributeInt('player_id', -1);
  const override_list = tooltipPanel.GetAttributeString("override_list", "null") || undefined;
  let list;
  if (override_list != "null") {
    list = Object.values(JSON.parseSafe(override_list ?? "") ?? []).map(v => "treasure_" + v).filter(v => KeyValues.treasure_abilities[v] != undefined);
  } else {
    playerID = playerID == -1 ? Players.GetLocalPlayer() : playerID;
  }
  libs.render(() => libs.createComponent(TreasureListTooltip, {
    playerID: playerID,
    override_list: list
  }), tooltipPanel);
};
tooltipPanel.SetPanelEvent('ontooltiploaded', setupTooltip);