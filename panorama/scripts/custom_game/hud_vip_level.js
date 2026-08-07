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
var solid_utils = require('./solid_utils.js');
var EOM_CostLabel = require('./EOM_CostLabel.js');
var EOM_RedMark = require('./EOM_RedMark.js');
var EOM_Button = require('./EOM_Button.js');
var StoreItem = require('./StoreItem.js');
require('./Player.js');
require('./EOM_TextEntry.js');
require('./equipment_utils.js');

const TREASURE_RARITY_LEVEL_LIMIT_TOOLTIPS = {
  2: "#TreasureRarityLevelLimit2",
  3: "#TreasureRarityLevelLimit3",
  4: "#TreasureRarityLevelLimit4",
  5: "#TreasureRarityLevelLimit5"
};
function clampPercent(value) {
  return Math.max(0, Math.min(100, value));
}
function normalizeDisplayNumber(value) {
  if (!Number.isFinite(value)) return 0;
  const integer = Math.round(value);
  if (Math.abs(value - integer) < 1e-9) {
    return integer;
  }
  return Number(value.toPrecision(12));
}
function attributeTexts(attribute) {
  return Object.entries(attribute ?? {}).map(([attributeName, value]) => {
    return GetPropertyLocalization(attributeName, toFiniteNumber(value, 0));
  });
}
function privilegeTexts(effect, level) {
  if (!effect) return [];
  return effect.split("|").map(privilege => {
    const privilegeID = privilege.trim();
    if (!privilegeID) return "";
    const privilegeData = KeyValues.privilege[privilegeID];
    if (privilegeData == undefined) return "";
    return getKeyValueDescription(GetLocalization(`#DOTA_Tooltip_ability_${privilegeID}`, ""), privilegeData.AbilityValues, {
      level,
      onlyShowNowLevel: true
    });
  }).filter(text => text != "");
}
function levelEffectTexts(data, level) {
  return [...attributeTexts(data.attribute), ...privilegeTexts(data.effect, level)].filter(text => text != "");
}
function CurrentAttributeRow(props) {
  return (() => {
    const _el$ = libs.createElement("Panel", {
        "class": "CurrentAttributeRow"
      }, null);
      libs.createElement("Image", {
        "class": "CurrentAttributeRowDot"
      }, _el$);
      const _el$3 = libs.createElement("Panel", {
        "class": "CurrentAttributeRowContent"
      }, _el$);
      libs.createElement("Image", {
        "class": "CurrentAttributeRowBG"
      }, _el$3);
      const _el$5 = libs.createElement("Label", {
        "class": "CurrentAttributeRowText",
        html: true,
        get text() {
          return props.text;
        }
      }, _el$3);
    libs.effect(_$p => libs.setProp(_el$5, "text", props.text, _$p));
    return _el$;
  })();
}
function LevelEffectRow(props) {
  const hasExp = libs.createMemo(() => {
    return props.expItemID != undefined && (props.expAmount ?? 0) > 0;
  });
  return (() => {
    const _el$6 = libs.createElement("Panel", {
        "class": "LevelEffectRow"
      }, null),
      _el$7 = libs.createElement("Panel", {
        "class": "LevelEffectRowDotContent"
      }, _el$6);
      libs.createElement("Image", {
        "class": "LevelEffectRowDot"
      }, _el$7);
      const _el$9 = libs.createElement("Label", {
        "class": "LevelEffectRowLevelText",
        get text() {
          return `${props.level}`;
        }
      }, _el$7),
      _el$0 = libs.createElement("Panel", {}, _el$6);
      libs.createElement("Image", {
        "class": "LevelEffectRowDescriptionBG"
      }, _el$0);
      const _el$10 = libs.createElement("Panel", {
        "class": "LevelEffectRowDescriptionList"
      }, _el$0);
    libs.insert(_el$10, libs.createComponent(libs.For, {
      get each() {
        return props.effectTexts;
      },
      children: (text, index) => (() => {
        const _el$15 = libs.createElement("Label", {
          html: true,
          text: text
        }, null);
        libs.setProp(_el$15, "text", text);
        libs.effect(_$p => libs.setProp(_el$15, "classList", {
          "LevelEffectRowDescriptionText": true,
          "FirstRow": index() === 0
        }, _$p));
        return _el$15;
      })()
    }));
    libs.insert(_el$6, libs.createComponent(libs.Show, {
      get when() {
        return hasExp();
      },
      get children() {
        const _el$11 = libs.createElement("Panel", {
            "class": "LevelEffectRowExpContent"
          }, null);
          libs.createElement("Image", {
            "class": "LevelEffectRowExpBG"
          }, _el$11);
          const _el$13 = libs.createElement("Panel", {
            "class": "LevelEffectRowExpDescrioption"
          }, _el$11),
          _el$14 = libs.createElement("Label", {
            "class": "LevelEffectRowExpText",
            get text() {
              return `+${props.expAmount}`;
            }
          }, _el$13);
        libs.insert(_el$13, libs.createComponent(StoreItem.StoreItemImage, {
          itemid: 210002
        }), _el$14);
        libs.effect(_$p => libs.setProp(_el$14, "text", `+${props.expAmount}`, _$p));
        return _el$11;
      }
    }), null);
    libs.effect(_p$ => {
      const _v$ = {
          Locked: props.locked
        },
        _v$2 = `${props.level}`,
        _v$3 = {
          "LevelEffectRowDescriptionContent": true,
          "WithExp": hasExp()
        };
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$6, "classList", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$9, "text", _v$2, _p$._v$2));
      _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$0, "classList", _v$3, _p$._v$3));
      return _p$;
    }, {
      _v$: undefined,
      _v$2: undefined,
      _v$3: undefined
    });
    return _el$6;
  })();
}
function CollectionTreasure() {
  const playerTreasures = solid_utils.createServiceNetData("player_collection_treasures", {});
  const treasureList = libs.createMemo(() => {
    return Object.entries(KeyValues.collection_treasure ?? {}).map(([itemID, levelConfig]) => {
      const levels = Object.entries(levelConfig ?? {}).map(([level, data]) => ({
        level: toFiniteNumber(level, 0),
        data: data
      })).filter(({
        level
      }) => level > 0).sort((a, b) => a.level - b.level);
      return {
        itemID,
        rarity: GetServiceItemRarity(itemID),
        levels
      };
    }).filter(({
      levels
    }) => levels.length > 0).sort((a, b) => b.rarity - a.rarity || toFiniteNumber(a.itemID) - toFiniteNumber(b.itemID));
  });
  const treasureByRarity = libs.createMemo(() => {
    const result = {};
    for (const treasure of treasureList()) {
      result[treasure.rarity] ??= [];
      result[treasure.rarity].push(treasure);
    }
    return result;
  });
  const rarityList = libs.createMemo(() => {
    return Object.keys(treasureByRarity()).sort((a, b) => Number(b) - Number(a));
  });
  const [selectedID, setSelectedID] = libs.createSignal("");
  libs.createEffect(() => {
    const selected = selectedID();
    if (selected && treasureList().some(treasure => treasure.itemID == selected)) {
      return;
    }
    setSelectedID(treasureList()[0]?.itemID ?? "");
  });
  const getTreasureConfig = itemID => {
    return treasureList().find(treasure => treasure.itemID == itemID);
  };
  const getTreasureLevelConfig = (itemID, level) => {
    const treasure = getTreasureConfig(itemID);
    return treasure?.levels.find(entry => entry.level == level);
  };
  const selectedTreasure = libs.createMemo(() => {
    return getTreasureConfig(selectedID());
  });
  const selectedLevels = libs.createMemo(() => selectedTreasure()?.levels ?? []);
  const maxLevel = libs.createMemo(() => {
    return selectedLevels()[selectedLevels().length - 1]?.level ?? 0;
  });
  const getPlayerTreasureData = itemID => {
    const treasureData = playerTreasures()[itemID];
    return {
      collection_treasure_id: treasureData?.collection_treasure_id ?? itemID,
      level: Math.max(0, toFiniteNumber(treasureData?.level, 0)),
      extra_exp: Math.max(0, toFiniteNumber(treasureData?.extra_exp, 0))
    };
  };
  const selectedPlayerTreasure = libs.createMemo(() => {
    return getPlayerTreasureData(selectedID());
  });
  const currentLevel = libs.createMemo(() => {
    const max = maxLevel();
    return max > 0 ? Math.min(selectedPlayerTreasure().level, max) : 0;
  });
  const nextLevel = libs.createMemo(() => {
    return currentLevel() + 1;
  });
  const nextLevelConfig = libs.createMemo(() => {
    const level = nextLevel();
    return selectedLevels().find(entry => entry.level == level);
  });
  const isMaxLevel = libs.createMemo(() => {
    const max = maxLevel();
    return max > 0 && currentLevel() >= max;
  });
  libs.createMemo(() => {
    const max = maxLevel();
    if (max <= 0) return 0;
    return clampPercent(currentLevel() / max * 100);
  });
  libs.createMemo(() => {
    const max = maxLevel();
    const level = currentLevel();
    if (max <= 0 || level <= 1) return [];
    return Array.from({
      length: level - 1
    }, (_, index) => {
      return clampPercent((index + 1) / max * 100);
    });
  });
  const currentAttributes = libs.createMemo(() => {
    const totals = {};
    const privileges = [];
    const level = currentLevel();
    if (level <= 0) return [];
    for (const entry of selectedLevels()) {
      if (entry.level > level) continue;
      for (const [attributeName, value] of Object.entries(entry.data.attribute ?? {})) {
        totals[attributeName] = (totals[attributeName] ?? 0) + toFiniteNumber(value, 0);
      }
      const text = privilegeTexts(entry.data.effect, entry.level).join("<br>");
      if (text != "") {
        privileges.push(text);
      }
    }
    const attributes = Object.entries(totals).map(([attributeName, value]) => {
      return GetPropertyLocalization(attributeName, normalizeDisplayNumber(value));
    });
    return [...attributes, ...privileges];
  });
  const currentAttributeState = libs.createMemo(() => {
    if (currentLevel() <= 0) return "locked";
    if (currentAttributes().length <= 0) return "empty";
    return "content";
  });
  const nextLevelCost = libs.createMemo(() => {
    return nextLevelConfig()?.data.level_cost ?? 0;
  });
  const canTreasureLevelUp = treasure => {
    const treasureMaxLevel = treasure.levels[treasure.levels.length - 1]?.level ?? 0;
    if (treasureMaxLevel <= 0) return false;
    const treasureData = getPlayerTreasureData(treasure.itemID);
    const treasureLevel = Math.min(treasureData.level, treasureMaxLevel);
    if (treasureLevel >= treasureMaxLevel) return false;
    const treasureNextLevelConfig = treasure.levels.find(entry => entry.level == treasureLevel + 1);
    const treasureNextLevelCost = treasureNextLevelConfig?.data.level_cost ?? 0;
    return treasureNextLevelCost > 0 && treasureData.extra_exp >= treasureNextLevelCost;
  };
  const canLevelUp = libs.createMemo(() => {
    const treasure = selectedTreasure();
    return treasure != undefined && canTreasureLevelUp(treasure);
  });
  const costItemID = libs.createMemo(() => {
    return toFiniteNumber(selectedID(), 0);
  });
  const fastUpgradeIDs = libs.createMemo(() => {
    return treasureList().filter(treasure => canTreasureLevelUp(treasure)).map(treasure => toFiniteNumber(treasure.itemID, 0)).filter(itemID => itemID > 0);
  });
  const [requesting, setRequesting] = libs.createSignal(false);
  let refImageBg;
  function ShowLevelupFx() {
    if (!refImageBg?.IsValid()) return;
    $.CreatePanel("DOTAParticleScenePanel", refImageBg, "LevelupFx", {
      particleName: "particles/ui/game/ui_game_falling_star_01.vpcf",
      cameraOrigin: "0 0 256",
      lookAt: "0 0 0",
      squarePixels: true,
      fov: 90,
      hittest: false
    }).DeleteAsync(3);
    Game.EmitSound("ui.npe_badge");
  }
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
    id: "CollectionTreasureRoot",
    get children() {
      const _el$16 = libs.createElement("Panel", {
          id: "CollectionTreasurePanel"
        }, null);
        libs.createElement("Image", {
          id: "CollectionTreasureBG"
        }, _el$16);
        const _el$18 = libs.createElement("Panel", {
          id: "CollectionDetails"
        }, _el$16),
        _el$19 = libs.createElement("Panel", {
          id: "CollectionTopContent"
        }, _el$18),
        _el$20 = libs.createElement("Panel", {
          id: "CollectionItemIconContent"
        }, _el$19),
        _el$21 = libs.createElement("Panel", {
          id: "CollectionTopRightContent"
        }, _el$19),
        _el$22 = libs.createElement("Panel", {
          id: "CollectionTitle"
        }, _el$21),
        _el$23 = libs.createElement("Label", {
          id: "CollectionTitleText",
          get ["class"]() {
            return "Rarity" + (selectedTreasure()?.rarity ?? 1);
          },
          get text() {
            return `#${selectedID()}`;
          }
        }, _el$22),
        _el$24 = libs.createElement("Panel", {
          id: "CollectionSubTitle"
        }, _el$21);
        libs.createElement("Image", {
          id: "CollectionSubTitleBG"
        }, _el$24);
        const _el$26 = libs.createElement("Label", {
          id: "CollectionSubTitleText",
          text: `#TreasureSubTitle`
        }, _el$24),
        _el$27 = libs.createElement("Panel", {
          id: "CollectionLevelContentWithBorder"
        }, _el$21);
        libs.createElement("Image", {
          "class": "CollectionLevelBG"
        }, _el$27);
        const _el$29 = libs.createElement("Panel", {
          id: "CollectionLevelBorderTextContent"
        }, _el$27),
        _el$30 = libs.createElement("Label", {
          "class": "CollectionLevelBorderText BorderText",
          get text() {
            return libs.memo(() => !!isMaxLevel())() ? `${currentLevel()}` : `${currentLevel()}`;
          }
        }, _el$29);
        libs.createElement("Image", {
          "class": "CollectionDivider"
        }, _el$18);
        const _el$32 = libs.createElement("Panel", {
          id: "CollectionCurrentAttributes"
        }, _el$18);
        libs.createElement("Image", {
          "class": "CollectionDivider"
        }, _el$18);
        const _el$36 = libs.createElement("Panel", {
          id: "CollectionLevelEffects"
        }, _el$18),
        _el$37 = libs.createElement("Panel", {
          id: "CollectionLevelEffectsTitleContent"
        }, _el$36);
        libs.createElement("Image", {
          id: "CollectionCurrentAttributesBG"
        }, _el$37);
        libs.createElement("Label", {
          id: "CollectionCurrentAttributesText",
          text: "#TreasureCurrentEffectTag"
        }, _el$37);
        const _el$40 = libs.createElement("Panel", {
          id: "CollectionLevelEffectsList"
        }, _el$36),
        _el$45 = libs.createElement("Panel", {
          id: "CollectionRightContainer"
        }, _el$16),
        _el$46 = libs.createElement("Panel", {
          id: "CollectionList",
          scroll: "y"
        }, _el$45),
        _el$47 = libs.createElement("Panel", {
          id: "CollectionRightOperations"
        }, _el$45);
      const _ref$ = refImageBg;
      typeof _ref$ === "function" ? libs.use(_ref$, _el$20) : refImageBg = _el$20;
      libs.insert(_el$20, libs.createComponent(StoreItem.StoreItemImage, {
        id: "CollectionItemIcon",
        get itemid() {
          return costItemID();
        },
        hittest: false
      }));
      libs.setProp(_el$26, "text", `#TreasureSubTitle`);
      libs.insert(_el$32, libs.createComponent(libs.Show, {
        get when() {
          return currentAttributeState() == "locked";
        },
        get fallback() {
          return [(() => {
            const _el$48 = libs.createElement("Panel", {
                id: "CollectionCurrentAttributesTitle"
              }, null);
              libs.createElement("Image", {
                id: "CollectionCurrentAttributesBG"
              }, _el$48);
              libs.createElement("Label", {
                id: "CollectionCurrentAttributesText",
                text: "#TreasureCurrentAttributeTag"
              }, _el$48);
            return _el$48;
          })(), (() => {
            const _el$51 = libs.createElement("Panel", {
              id: "CollectionAttributesList"
            }, null);
            libs.insert(_el$51, libs.createComponent(libs.Show, {
              get when() {
                return currentAttributeState() == "empty";
              },
              get fallback() {
                return libs.createComponent(libs.For, {
                  get each() {
                    return currentAttributes();
                  },
                  children: text => libs.createComponent(CurrentAttributeRow, {
                    text: text
                  })
                });
              },
              get children() {
                return libs.createElement("Label", {
                  "class": "CollectionAttributesPlaceholder",
                  text: "#TreasureCurrentAttributeNoDescription"
                }, null);
              }
            }));
            return _el$51;
          })()];
        },
        get children() {
          const _el$33 = libs.createElement("Panel", {
              id: "CollectionCurrentAttributesLockedContent"
            }, null);
            libs.createElement("Label", {
              id: "CollectionCurrentAttributesLockedText",
              text: "#TreasureCurrentAttributeLocked"
            }, _el$33);
          return _el$33;
        }
      }));
      libs.insert(_el$40, libs.createComponent(libs.For, {
        get each() {
          return selectedLevels();
        },
        children: ({
          level,
          data
        }) => {
          const expEntry = Object.entries(data.treasure_level_exp ?? {})[0];
          const expItemID = expEntry ? toFiniteNumber(expEntry[0], 0) : undefined;
          const expAmount = expEntry ? toFiniteNumber(expEntry[1], 0) : undefined;
          return libs.createComponent(LevelEffectRow, {
            level: level,
            get effectTexts() {
              return levelEffectTexts(data, level);
            },
            get locked() {
              return level > currentLevel();
            },
            expItemID: expItemID,
            expAmount: expAmount
          });
        }
      }));
      libs.insert(_el$18, libs.createComponent(libs.Show, {
        get when() {
          return !isMaxLevel();
        },
        get children() {
          const _el$41 = libs.createElement("Panel", {
              id: "CollectionUpgradeSection"
            }, null),
            _el$42 = libs.createElement("Panel", {
              id: "CollectionUpgradeCostLabel"
            }, _el$41),
            _el$43 = libs.createElement("Label", {
              id: "CollectionUpgradeCostText2",
              text: "#TreasureUpgradeCostText"
            }, _el$42),
            _el$44 = libs.createElement("Panel", {
              id: "CollectionUpgradeItemBlock"
            }, _el$41);
          libs.insert(_el$44, libs.createComponent(StoreItem.StoreItemBlock, {
            get item_id() {
              return costItemID();
            },
            get amounts() {
              return selectedPlayerTreasure().extra_exp;
            },
            get visible() {
              return !isMaxLevel();
            }
          }), null);
          libs.insert(_el$44, libs.createComponent(libs.Show, {
            get when() {
              return canLevelUp();
            },
            get children() {
              return libs.createComponent(EOM_RedMark.EOM_RedMark, {
                align: "right top"
              });
            }
          }), null);
          libs.insert(_el$41, libs.createComponent(EOM_CostLabel.EOM_CostLabel, {
            id: "UpgradeCost",
            get have() {
              return selectedPlayerTreasure().extra_exp;
            },
            get cost() {
              return nextLevelCost();
            },
            get visible() {
              return !isMaxLevel();
            }
          }), null);
          libs.insert(_el$41, libs.createComponent(EOM_Button.EOM_Button, {
            id: "UpgradeBtn",
            text: "#TreasureUpgradeBtn",
            color: "Confirm",
            visible: true,
            get enabled() {
              return libs.memo(() => !!!requesting())() && canLevelUp();
            },
            onactivate: self => {
              if (requesting()) return;
              if (!canLevelUp()) return;
              setRequesting(true);
              CallActionRequest("/v1/collection/levelup_treasure", {
                collection_treasure_ids: [costItemID()]
              }, () => {
                setRequesting(false);
                ShowLevelupFx();
              });
            }
          }), null);
          libs.effect(_$p => libs.setProp(_el$43, "visible", !isMaxLevel(), _$p));
          return _el$41;
        }
      }), null);
      libs.setProp(_el$46, "scroll", "y");
      libs.insert(_el$46, libs.createComponent(libs.For, {
        get each() {
          return rarityList();
        },
        children: rarity => [(() => {
          const _el$53 = libs.createElement("Panel", {
              "class": `CollectionRarityTitle Rarity${rarity}`
            }, null),
            _el$54 = libs.createElement("Panel", {
              "class": `CollectionRarityTitleContent Rarity${rarity}`
            }, _el$53),
            _el$55 = libs.createElement("Label", {
              "class": `RarityTitle Rarity${rarity}`,
              text: `#Collection_Rarity_Treasure${rarity}`
            }, _el$54),
            _el$56 = libs.createElement("Image", {
              "class": `CollectionRarityIcon Rarity${rarity}`
            }, _el$54);
          libs.setProp(_el$53, "class", `CollectionRarityTitle Rarity${rarity}`);
          libs.setProp(_el$54, "class", `CollectionRarityTitleContent Rarity${rarity}`);
          libs.setProp(_el$55, "class", `RarityTitle Rarity${rarity}`);
          libs.setProp(_el$55, "text", `#Collection_Rarity_Treasure${rarity}`);
          libs.setProp(_el$56, "class", `CollectionRarityIcon Rarity${rarity}`);
          libs.setProp(_el$56, "onmouseover", panel => {
            const tooltip = TREASURE_RARITY_LEVEL_LIMIT_TOOLTIPS[rarity];
            if (tooltip) {
              ShowCustomTooltip(panel, "text", {
                text: tooltip
              });
            }
          });
          libs.setProp(_el$56, "onmouseout", panel => HideCustomTooltip(panel, "text"));
          return _el$53;
        })(), libs.createComponent(libs.For, {
          get each() {
            return treasureByRarity()[rarity];
          },
          children: treasure => {
            const treasureData = () => getPlayerTreasureData(treasure.itemID);
            const treasureMaxLevel = () => treasure.levels[treasure.levels.length - 1]?.level ?? 0;
            const treasureLevel = () => Math.min(treasureData().level, treasureMaxLevel());
            const treasureIsMax = () => treasureMaxLevel() > 0 && treasureLevel() >= treasureMaxLevel();
            return (() => {
              const _el$57 = libs.createElement("Panel", {
                  "class": "CollectionTreasureItem"
                }, null),
                _el$59 = libs.createElement("Panel", {
                  id: "CardBG"
                }, _el$57),
                _el$60 = libs.createElement("Label", {
                  id: "Name",
                  get ["class"]() {
                    return `Rarity${treasure.rarity}`;
                  },
                  get text() {
                    return `#${treasure.itemID}`;
                  }
                }, _el$57);
                libs.createElement("Image", {
                  id: "LockIcon",
                  hittest: false
                }, _el$57);
                const _el$62 = libs.createElement("Label", {
                  id: "CollectionLevel",
                  get text() {
                    return `Lv.${treasureLevel()}${treasureIsMax() ? "(MAX)" : ""}`;
                  }
                }, _el$57),
                _el$63 = libs.createElement("Panel", {
                  id: "SelectedHover",
                  hittest: false
                }, _el$57);
              libs.setProp(_el$57, "onactivate", () => setSelectedID(treasure.itemID));
              libs.insert(_el$57, libs.createComponent(libs.Show, {
                get when() {
                  return selectedID() == treasure.itemID;
                },
                get children() {
                  return libs.createElement("DOTAParticleScenePanel", {
                    id: "BorderParticle",
                    particleName: "particles/ui/game/ui_game_general_special_effects_03_fx.vpcf",
                    cameraOrigin: "0 0 93",
                    fov: 45,
                    lookAt: "0 0 0",
                    hittest: false,
                    squarePixels: true
                  }, null);
                }
              }), _el$59);
              libs.insert(_el$57, libs.createComponent(StoreItem.StoreItemImage, {
                id: "CollectionIcon",
                get itemid() {
                  return treasure.itemID;
                }
              }), _el$60);
              libs.insert(_el$57, libs.createComponent(EOM_CostLabel.EOM_CostLabel, {
                id: "CollectionNumberCount",
                hiddenCostOnZero: true,
                get have() {
                  return getPlayerTreasureData(treasure.itemID).extra_exp;
                },
                get cost() {
                  return getTreasureLevelConfig(treasure.itemID, treasureLevel() + 1)?.data.level_cost ?? 0;
                }
              }), _el$63);
              libs.insert(_el$57, libs.createComponent(libs.Show, {
                get when() {
                  return canTreasureLevelUp(treasure);
                },
                get children() {
                  return libs.createComponent(EOM_RedMark.EOM_RedMark, {
                    align: "right top"
                  });
                }
              }), null);
              libs.effect(_p$ => {
                const _v$8 = {
                    [`Rarity${treasure.rarity}`]: true,
                    Lock: treasureLevel() <= 0,
                    Selected: selectedID() == treasure.itemID
                  },
                  _v$9 = `Rarity${treasure.rarity}`,
                  _v$0 = `#${treasure.itemID}`,
                  _v$1 = {
                    Max: treasureIsMax()
                  },
                  _v$10 = treasureLevel() > 0,
                  _v$11 = `Lv.${treasureLevel()}${treasureIsMax() ? "(MAX)" : ""}`;
                _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$57, "classList", _v$8, _p$._v$8));
                _v$9 !== _p$._v$9 && (_p$._v$9 = libs.setProp(_el$60, "class", _v$9, _p$._v$9));
                _v$0 !== _p$._v$0 && (_p$._v$0 = libs.setProp(_el$60, "text", _v$0, _p$._v$0));
                _v$1 !== _p$._v$1 && (_p$._v$1 = libs.setProp(_el$62, "classList", _v$1, _p$._v$1));
                _v$10 !== _p$._v$10 && (_p$._v$10 = libs.setProp(_el$62, "visible", _v$10, _p$._v$10));
                _v$11 !== _p$._v$11 && (_p$._v$11 = libs.setProp(_el$62, "text", _v$11, _p$._v$11));
                return _p$;
              }, {
                _v$8: undefined,
                _v$9: undefined,
                _v$0: undefined,
                _v$1: undefined,
                _v$10: undefined,
                _v$11: undefined
              });
              return _el$57;
            })();
          }
        })]
      }));
      libs.insert(_el$47, libs.createComponent(EOM_Button.EOM_Button, {
        id: "FastUpgradeBtn",
        text: "#TreasureFastUpgradeBtn",
        color: "Gold",
        visible: true,
        get enabled() {
          return libs.memo(() => !!!requesting())() && fastUpgradeIDs().length > 0;
        },
        onactivate: self => {
          if (requesting()) return;
          const ids = fastUpgradeIDs();
          if (ids.length <= 0) return;
          setRequesting(true);
          CallActionRequest("/v1/collection/levelup_treasure", {
            collection_treasure_ids: ids
          }, () => {
            setRequesting(false);
            if (ids.includes(costItemID())) {
              ShowLevelupFx();
            }
          });
        }
      }));
      libs.effect(_p$ => {
        const _v$4 = "Rarity" + (selectedTreasure()?.rarity ?? 1),
          _v$5 = `#${selectedID()}`,
          _v$6 = libs.memo(() => !!isMaxLevel())() ? `${currentLevel()}` : `${currentLevel()}`,
          _v$7 = {
            MaxLevel: isMaxLevel()
          };
        _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$23, "class", _v$4, _p$._v$4));
        _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$23, "text", _v$5, _p$._v$5));
        _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$30, "text", _v$6, _p$._v$6));
        _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$36, "classList", _v$7, _p$._v$7));
        return _p$;
      }, {
        _v$4: undefined,
        _v$5: undefined,
        _v$6: undefined,
        _v$7: undefined
      });
      return _el$16;
    }
  });
}

function CollectionCard(props) {
  const stateClass = props.state === "received" ? "Received" : props.state === "claimable" ? "Claimable" : "Locked";
  return (() => {
    const _el$ = libs.createElement("Panel", {
        get ["class"]() {
          return libs.classNames("CollectionCard", `Rarity${props.rarity}`, stateClass, {
            Selected: props.selected,
            EmptyReward: !props.hasReward
          });
        },
        get onactivate() {
          return props.onactivate;
        }
      }, null),
      _el$2 = libs.createElement("Panel", {
        "class": "CollectionCardRoot"
      }, _el$),
      _el$3 = libs.createElement("Panel", {
        "class": "CollectionCardMain"
      }, _el$2),
      _el$4 = libs.createElement("Panel", {
        "class": "CollectionCardFxLayer"
      }, _el$3);
      libs.createElement("DOTAParticleScenePanel", {
        "class": "CollectionCardFx",
        particleName: "particles/ui/game/ui_game_fx_chouka_pinzhi_jinse_zong.vpcf",
        cameraOrigin: "0 0 320",
        lookAt: "0 0 0",
        fov: 90,
        hittest: false
      }, _el$4);
      libs.createElement("Image", {
        "class": "CollectionCardBG"
      }, _el$3);
      const _el$7 = libs.createElement("Panel", {
        "class": "CollectionCardFxLayerTop"
      }, _el$3);
      libs.createElement("DOTAParticleScenePanel", {
        "class": "CollectionCardFx",
        particleName: "particles/ui/game/ui_game_fx_chouka_pinzhi_jinse_zong.vpcf",
        cameraOrigin: "0 0 320",
        lookAt: "0 0 0",
        fov: 90,
        hittest: false
      }, _el$7);
      const _el$9 = libs.createElement("Panel", {
        "class": "CollectionCardContent"
      }, _el$3);
      libs.createElement("Image", {
        "class": "CollectionCardRecived"
      }, _el$3);
      libs.createElement("Image", {
        "class": "CollectionCardRedPoint"
      }, _el$3);
      const _el$12 = libs.createElement("Panel", {
        get ["class"]() {
          return libs.classNames("RewardLevelMarker", stateClass, {
            Current: props.selected
          });
        }
      }, _el$);
      libs.createElement("Image", {
        "class": "RewardLevelMarkerBG"
      }, _el$12);
      const _el$14 = libs.createElement("Label", {
        "class": "RewardLevelLabel",
        get text() {
          return props.level;
        }
      }, _el$12),
      _el$15 = libs.createElement("Label", {
        "class": "RewardLevelExp",
        get vars() {
          return {
            need_exp: props.exp ?? 0
          };
        },
        text: "#RewardTagNeedExp"
      }, _el$12);
    const _ref$ = props.panelRef;
    typeof _ref$ === "function" ? libs.use(_ref$, _el$) : props.panelRef = _el$;
    libs.insert(_el$9, libs.createComponent(libs.Show, {
      get when() {
        return props.reward_id != undefined;
      },
      get children() {
        return [(() => {
          const _el$0 = libs.createElement("Label", {
            "class": "CollectionCardName",
            get text() {
              return `#${props.reward_id}`;
            }
          }, null);
          libs.effect(_$p => libs.setProp(_el$0, "text", `#${props.reward_id}`, _$p));
          return _el$0;
        })(), libs.createComponent(StoreItem.StoreItemImage, {
          "class": "CollectionCardIcon",
          get itemid() {
            return props.reward_id;
          }
        }), (() => {
          const _el$1 = libs.createElement("Label", {
            "class": "CollectionCardAmount",
            get text() {
              return `x${props.amount}`;
            }
          }, null);
          libs.effect(_p$ => {
            const _v$ = `x${props.amount}`,
              _v$2 = (props.amount ?? 0) > 1;
            _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$1, "text", _v$, _p$._v$));
            _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$1, "visible", _v$2, _p$._v$2));
            return _p$;
          }, {
            _v$: undefined,
            _v$2: undefined
          });
          return _el$1;
        })()];
      }
    }));
    libs.effect(_p$ => {
      const _v$3 = libs.classNames("CollectionCard", `Rarity${props.rarity}`, stateClass, {
          Selected: props.selected,
          EmptyReward: !props.hasReward
        }),
        _v$4 = props.onactivate,
        _v$5 = libs.classNames("RewardLevelMarker", stateClass, {
          Current: props.selected
        }),
        _v$6 = props.level,
        _v$7 = (props.exp ?? 0) > 0,
        _v$8 = {
          need_exp: props.exp ?? 0
        };
      _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$, "class", _v$3, _p$._v$3));
      _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$, "onactivate", _v$4, _p$._v$4));
      _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$12, "class", _v$5, _p$._v$5));
      _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$14, "text", _v$6, _p$._v$6));
      _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$15, "visible", _v$7, _p$._v$7));
      _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$15, "vars", _v$8, _p$._v$8));
      return _p$;
    }, {
      _v$3: undefined,
      _v$4: undefined,
      _v$5: undefined,
      _v$6: undefined,
      _v$7: undefined,
      _v$8: undefined
    });
    return _el$;
  })();
}
function CollectionVip() {
  const REWARD_PROGRESS_START_OFFSET = -27;
  const REWARD_PROGRESS_END_OFFSET = 27;
  const REWARD_WHEEL_SCROLL_STEP = 160;
  let rewardContentRef;
  let rewardViewportRef;
  let rewardListRef;
  let rewardCardRefs = [];
  const [scrollOffset, setScrollOffset] = libs.createSignal(0);
  const [canScrollLeft, setCanScrollLeft] = libs.createSignal(false);
  const [canScrollRight, setCanScrollRight] = libs.createSignal(false);
  const [requesting, setRequesting] = libs.createSignal(false);
  const [rewardProgressPercent, setRewardProgressPercent] = libs.createSignal(0);
  const [rewardProgressLayout, setRewardProgressLayout] = libs.createSignal({
    x: 0,
    width: 0
  });
  const [isRewardDragging, setIsRewardDragging] = libs.createSignal(false);
  let rewardDragLastX = 0;
  let rewardDragScheduleId;
  let rewardAutoScrollDone = false;
  let rewardUserScrolled = false;
  const playerAccountLevels = solid_utils.createServiceNetData("player_account_levels", {});
  const rewardReceiveRecordsRaw = solid_utils.createServiceNetData("player_account_level_rewards_receive_records", {});
  const rewardReceiveRecords = libs.createMemo(() => {
    console.log("rewardReceiveRecordsRaw ", rewardReceiveRecordsRaw());
    return rewardReceiveRecordsRaw().collection_treasure ?? {};
  });
  const rewardConfigList = libs.createMemo(() => {
    return Object.values(KeyValues.collection_treasure_level_reward ?? {}).map(config => config).sort((a, b) => a.level - b.level);
  });
  const maxLevel = libs.createMemo(() => rewardConfigList()[rewardConfigList().length - 1]?.level ?? 0);
  const currentVipLevel = libs.createMemo(() => {
    const level = Math.max(1, toFiniteNumber(playerAccountLevels().collection_treasure?.level, 1));
    const max = maxLevel();
    return max > 0 ? Math.min(level, max) : level;
  });
  const currentExp = libs.createMemo(() => Math.max(0, toFiniteNumber(playerAccountLevels().collection_treasure?.extra_exp, 0)));
  const nextVipLevel = libs.createMemo(() => {
    const max = maxLevel();
    return max > 0 ? Math.min(currentVipLevel() + 1, max) : currentVipLevel() + 1;
  });
  const currentLevelConfig = libs.createMemo(() => {
    const currentLevel = currentVipLevel();
    return rewardConfigList().find(config => config.level === currentLevel) ?? rewardConfigList().find(config => config.level === currentLevel + 1);
  });
  const nextExp = libs.createMemo(() => {
    if (currentVipLevel() >= maxLevel()) return 0;
    return Math.max(0, toFiniteNumber(currentLevelConfig()?.level_cost, 0));
  });
  const expPercent = libs.createMemo(() => {
    const maxExp = nextExp();
    if (currentVipLevel() >= maxLevel()) return 100;
    if (maxExp <= 0) return 0;
    return Math.max(0, Math.min(100, currentExp() / maxExp * 100));
  });
  const remainingExp = libs.createMemo(() => Math.max(0, nextExp() - currentExp()));
  const vipRewards = libs.createMemo(() => {
    const currentLevel = currentVipLevel();
    const received = rewardReceiveRecords();
    const rewardConfigs = rewardConfigList();
    return rewardConfigs.map(config => {
      const rewardEntry = Object.entries(config.reward ?? {})[0];
      const rewardID = rewardEntry ? toFiniteNumber(rewardEntry[0]) : undefined;
      const amount = rewardEntry ? toFiniteNumber(rewardEntry[1]) : undefined;
      const previousLevelCost = rewardConfigs.find(rewardConfig => rewardConfig.level === config.level - 1)?.level_cost;
      const exp = Math.max(0, toFiniteNumber(previousLevelCost, 0));
      const state = received[String(config.level)] === true ? "received" : config.level <= currentLevel ? "claimable" : "locked";
      const rarity = rewardID != undefined ? GetServiceItemRarity(rewardID) : 1;
      return {
        level: config.level,
        reward_id: rewardID,
        amount,
        rarity: rarity,
        state,
        exp: exp > 0 ? exp : undefined,
        hasReward: rewardID != undefined
      };
    });
  });
  const hasClaimableReward = libs.createMemo(() => vipRewards().some(reward => reward.state === "claimable" && reward.hasReward));
  const vipLogoLang = libs.createMemo(() => {
    const lang = Language();
    if (lang == "schinese") {
      return "Language_schinese";
    } else if (lang == "russian") {
      return "Language_russian";
    } else {
      return "Language_english";
    }
  });
  function handleReceiveRewards(level) {
    if (requesting() || !hasClaimableReward()) {
      return;
    }
    setRequesting(true);
    CallActionRequest("/v1/account_level/receive_rewards", {
      account_type: "collection_treasure",
      level: level ?? 0
    }, () => {
      setRequesting(false);
    }, () => {
      setRequesting(false);
    });
  }
  function handleReceiveReward(reward) {
    if (reward.state !== "claimable" || !reward.hasReward) {
      return;
    }
    handleReceiveRewards(reward.level);
  }
  function getMaxScroll() {
    if (!rewardViewportRef?.IsValid() || !rewardListRef?.IsValid()) return 0;
    const viewportWidth = rewardViewportRef.actuallayoutwidth;
    const validCards = rewardCardRefs.filter(panel => !!panel?.IsValid());
    const lastCard = validCards[validCards.length - 1];
    const listWidth = lastCard?.IsValid() ? lastCard.GetPositionWithinAncestor(rewardListRef).x + lastCard.actuallayoutwidth : rewardListRef.actuallayoutwidth;
    return Math.max(0, listWidth - viewportWidth);
  }
  function clampScrollOffset(offset) {
    const maxScroll = getMaxScroll();
    return Math.max(0, Math.min(maxScroll, offset));
  }
  function updateRewardScrollState() {
    const maxScroll = getMaxScroll();
    const nextOffset = clampScrollOffset(scrollOffset());
    const tolerance = 2;
    if (Math.abs(nextOffset - scrollOffset()) > tolerance) {
      setScrollOffset(nextOffset);
    }
    setCanScrollLeft(nextOffset > tolerance);
    setCanScrollRight(nextOffset < maxScroll - tolerance);
    updateRewardProgressState(nextOffset, maxScroll);
  }
  function getCurrentRewardIndex() {
    const rewards = vipRewards();
    if (rewards.length === 0) return 0;
    const currentLevel = currentVipLevel();
    let currentIndex = 0;
    for (let index = 0; index < rewards.length; index++) {
      if (rewards[index].level <= currentLevel) {
        currentIndex = index;
      } else {
        break;
      }
    }
    return currentIndex;
  }
  function getInitialRewardIndex() {
    const rewards = vipRewards();
    if (rewards.length === 0) return 0;
    const firstClaimableIndex = rewards.findIndex(reward => reward.state === "claimable" && reward.hasReward);
    return firstClaimableIndex >= 0 ? firstClaimableIndex : getCurrentRewardIndex();
  }
  function scrollToRewardIndex(index, type = "center") {
    if (!rewardViewportRef?.IsValid() || !rewardListRef?.IsValid()) return false;
    const targetCard = rewardCardRefs[index];
    if (!targetCard?.IsValid()) return false;
    const viewportWidth = rewardViewportRef.actuallayoutwidth;
    const cardWidth = targetCard.actuallayoutwidth;
    if (viewportWidth <= 0 || cardWidth <= 0) return false;
    const cardX = targetCard.GetPositionWithinAncestor(rewardListRef).x;
    let targetOffset = cardX;
    if (type === "center") {
      targetOffset -= (viewportWidth - cardWidth) / 2;
    } else if (type === "end") {
      targetOffset -= viewportWidth - cardWidth;
    }
    setScrollOffset(clampScrollOffset(targetOffset));
    $.Schedule(0, updateRewardScrollState);
    return true;
  }
  function updateRewardProgressState(currentOffset = scrollOffset(), maxScroll = getMaxScroll()) {
    if (!rewardViewportRef?.IsValid() || !rewardListRef?.IsValid()) {
      setRewardProgressPercent(0);
      setRewardProgressLayout({
        x: 0,
        width: 0
      });
      return;
    }
    const rewards = vipRewards();
    const lastIndex = rewards.length - 1;
    if (lastIndex <= 0) {
      setRewardProgressPercent(lastIndex === 0 ? 100 : 0);
      setRewardProgressLayout({
        x: 0,
        width: 0
      });
      return;
    }
    const viewportWidth = rewardViewportRef.actuallayoutwidth;
    const viewportStart = currentOffset;
    const viewportEnd = currentOffset + viewportWidth;
    const visibleIndexes = [];
    rewardCardRefs.forEach((panel, index) => {
      if (!panel?.IsValid()) return;
      const cardX = panel.GetPositionWithinAncestor(rewardListRef).x;
      const cardCenter = cardX + panel.actuallayoutwidth / 2;
      if (cardCenter >= viewportStart && cardCenter <= viewportEnd) {
        visibleIndexes.push(index);
      }
    });
    let visibleStartIndex = visibleIndexes[0] ?? 0;
    let visibleEndIndex = visibleIndexes[visibleIndexes.length - 1] ?? lastIndex;
    if (visibleIndexes.length === 0) {
      let closestIndex = 0;
      let closestDistance = Number.MAX_VALUE;
      const viewportCenter = viewportStart + viewportWidth / 2;
      rewardCardRefs.forEach((panel, index) => {
        if (!panel?.IsValid()) return;
        const cardX = panel.GetPositionWithinAncestor(rewardListRef).x;
        const cardCenter = cardX + panel.actuallayoutwidth / 2;
        const distance = Math.abs(cardCenter - viewportCenter);
        if (distance < closestDistance) {
          closestDistance = distance;
          closestIndex = index;
        }
      });
      visibleStartIndex = closestIndex;
      visibleEndIndex = closestIndex;
    }
    const firstPage = currentOffset <= 2 || visibleStartIndex <= 0;
    const lastPage = currentOffset >= maxScroll - 2 || visibleEndIndex >= lastIndex;
    const progressStartIndex = firstPage ? 0 : Math.max(0, visibleStartIndex - 1);
    const progressEndIndex = lastPage ? lastIndex : Math.min(lastIndex, visibleEndIndex + 1);
    const progressRange = Math.max(1, progressEndIndex - progressStartIndex);
    const currentIndex = getCurrentRewardIndex();
    const levelProgress = currentVipLevel() >= maxLevel() || nextExp() <= 0 ? 0 : Math.max(0, Math.min(1, currentExp() / nextExp()));
    const currentProgressIndex = currentIndex >= lastIndex ? lastIndex : Math.min(lastIndex, currentIndex + levelProgress);
    const localPercent = (currentProgressIndex - progressStartIndex) / progressRange * 100;
    const startCard = rewardCardRefs[progressStartIndex];
    const endCard = rewardCardRefs[progressEndIndex];
    if (startCard?.IsValid() && endCard?.IsValid()) {
      const startX = startCard.GetPositionWithinAncestor(rewardListRef).x;
      const endX = endCard.GetPositionWithinAncestor(rewardListRef).x;
      const startCenterX = startX + startCard.actuallayoutwidth / 2 + REWARD_PROGRESS_START_OFFSET;
      const endCenterX = endX + endCard.actuallayoutwidth / 2 + REWARD_PROGRESS_END_OFFSET;
      const barWidth = endCenterX - startCenterX;
      setRewardProgressLayout(barWidth > 0 ? {
        x: startCenterX - currentOffset,
        width: barWidth
      } : {
        x: 0,
        width: 0
      });
    } else {
      setRewardProgressLayout({
        x: 0,
        width: 0
      });
    }
    setRewardProgressPercent(Math.max(0, Math.min(100, localPercent)));
  }
  function scrollRewardList(direction) {
    if (!rewardViewportRef?.IsValid()) return;
    const viewportWidth = rewardViewportRef.actuallayoutwidth;
    const pageStep = Math.max(1, Math.floor(viewportWidth * 0.8));
    rewardUserScrolled = true;
    setScrollOffset(clampScrollOffset(scrollOffset() + direction * pageStep));
    $.Schedule(0, updateRewardScrollState);
  }
  function scrollRewardListByDelta(delta) {
    if (!rewardViewportRef?.IsValid()) return;
    rewardUserScrolled = true;
    setScrollOffset(clampScrollOffset(scrollOffset() + delta));
    $.Schedule(0, updateRewardScrollState);
  }
  function stopRewardDragThinker() {
    if (rewardDragScheduleId !== undefined) {
      try {
        $.CancelScheduled(rewardDragScheduleId);
      } catch (error) {}
      rewardDragScheduleId = undefined;
    }
  }
  function rewardDragThinker() {
    rewardDragScheduleId = undefined;
    if (!isRewardDragging() || !rewardViewportRef?.IsValid()) {
      return;
    }
    const cursorX = GameUI.GetCursorPosition()[0];
    const deltaX = (cursorX - rewardDragLastX) / (rewardViewportRef.actualuiscale_x || 1);
    if (Math.abs(deltaX) >= 1) {
      setScrollOffset(clampScrollOffset(scrollOffset() - deltaX));
      updateRewardScrollState();
      rewardDragLastX = cursorX;
    }
    rewardDragScheduleId = $.Schedule(Math.max(1 / 90, Game.GetGameFrameTime()), rewardDragThinker);
  }
  function startRewardDrag(dragCallbacks) {
    if (!rewardViewportRef?.IsValid() || getMaxScroll() <= 0) {
      return;
    }
    rewardUserScrolled = true;
    const dragPanel = $.CreatePanel("Panel", $.GetContextPanel(), "CollectionVipRewardDragPanel");
    dragPanel.visible = false;
    dragCallbacks.displayPanel = dragPanel;
    dragCallbacks.offsetX = 0;
    dragCallbacks.offsetY = 0;
    stopRewardDragThinker();
    rewardDragLastX = GameUI.GetCursorPosition()[0];
    setIsRewardDragging(true);
    rewardDragThinker();
  }
  function endRewardDrag(draggedPanel) {
    stopRewardDragThinker();
    setIsRewardDragging(false);
    if (draggedPanel?.IsValid()) {
      draggedPanel.DeleteAsync(-1);
    }
    updateRewardScrollState();
  }
  libs.createEffect(() => {
    setScrollOffset(0);
    rewardAutoScrollDone = false;
    rewardUserScrolled = false;
    let scheduleId;
    let disposed = false;
    const tick = () => {
      if (disposed) return;
      if (!rewardAutoScrollDone && !rewardUserScrolled) {
        rewardAutoScrollDone = scrollToRewardIndex(getInitialRewardIndex(), "center");
      }
      updateRewardScrollState();
      scheduleId = $.Schedule(0.1, tick);
    };
    scheduleId = $.Schedule(0, tick);
    libs.onCleanup(() => {
      disposed = true;
      if (scheduleId !== undefined) {
        try {
          $.CancelScheduled(scheduleId);
        } catch (error) {}
      }
    });
  });
  libs.onMount(() => {
    const mouseEventName = DoUniqueString("CollectionVipRewardList");
    CustomUIConfig.SubscribeMouseEvent(mouseEventName, ({
      event_name: eventName,
      value
    }) => {
      const isRewardListHovered = rewardViewportRef?.IsValid() && rewardViewportRef.BHasHoverStyle() || rewardContentRef?.IsValid() && rewardContentRef.BHasHoverStyle();
      if (!isRewardListHovered) {
        return;
      }
      if (eventName === "wheeled") {
        if (value === 1) {
          scrollRewardListByDelta(-REWARD_WHEEL_SCROLL_STEP);
        } else if (value === -1) {
          scrollRewardListByDelta(REWARD_WHEEL_SCROLL_STEP);
        }
      } else if (eventName === "pressed") {
        if (value === 5) {
          scrollRewardListByDelta(-REWARD_WHEEL_SCROLL_STEP);
        } else if (value === 6) {
          scrollRewardListByDelta(REWARD_WHEEL_SCROLL_STEP);
        }
      }
    });
    libs.onCleanup(() => {
      try {
        CustomUIConfig.UnsubscribeMouseEvent(mouseEventName);
      } catch (error) {}
    });
  });
  libs.onCleanup(() => {
    stopRewardDragThinker();
  });
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
    id: "CollectionVipRoot",
    className: "CollectionVipPanel",
    get children() {
      const _el$16 = libs.createElement("Panel", {
          id: "CollectionVipContent"
        }, null),
        _el$17 = libs.createElement("Panel", {
          id: "CollectionVipTopLeft"
        }, _el$16),
        _el$18 = libs.createElement("Panel", {
          id: "CollectionVipLevel"
        }, _el$17);
        libs.createElement("Image", {
          id: "CollectionVipLevelBG"
        }, _el$18);
        const _el$20 = libs.createElement("Label", {
          id: "VipLevelNumber",
          get text() {
            return currentVipLevel();
          }
        }, _el$18),
        _el$21 = libs.createElement("Panel", {
          id: "CollectionVipProgress"
        }, _el$17),
        _el$22 = libs.createElement("Label", {
          id: "VipProgressTitle",
          get vars() {
            return {
              need_exp: remainingExp(),
              next_level: nextVipLevel()
            };
          },
          text: "#VIPLevelNeedExp"
        }, _el$21),
        _el$23 = libs.createElement("Panel", {
          id: "VipProgressBarContainer"
        }, _el$21);
        libs.createElement("Panel", {
          id: "ProgressBarBG"
        }, _el$23);
        const _el$25 = libs.createElement("Panel", {
          id: "ProgressBar",
          get style() {
            return {
              clip: `rect( 0%, ${expPercent()}%, 100%, 0% )`
            };
          }
        }, _el$23),
        _el$26 = libs.createElement("Label", {
          id: "ProgressBarText",
          get text() {
            return `${currentExp()} / ${nextExp()}`;
          }
        }, _el$23);
        libs.createElement("Label", {
          id: "VipProgressDesc",
          text: "#VIPLevelExpDescription"
        }, _el$21);
        const _el$28 = libs.createElement("Panel", {
          id: "CollectionVipTopRight"
        }, _el$16),
        _el$29 = libs.createElement("Image", {
          id: "CollectionVipTopRightBG",
          get ["class"]() {
            return vipLogoLang();
          }
        }, _el$28),
        _el$30 = libs.createElement("Panel", {
          id: "CollectionVipBottomCenter"
        }, _el$16),
        _el$31 = libs.createElement("Panel", {
          id: "CollectionVipCenter"
        }, _el$16),
        _el$32 = libs.createElement("Panel", {
          id: "RewardsContent",
          get ["class"]() {
            return libs.classNames({
              Dragging: isRewardDragging()
            });
          }
        }, _el$31),
        _el$33 = libs.createElement("Panel", {
          id: "RewardProgressBar",
          get ["class"]() {
            return libs.classNames("RewardProgressBar");
          },
          get style() {
            return {
              transform: `translateX(${rewardProgressLayout().x}px)`,
              width: `${rewardProgressLayout().width}px`
            };
          }
        }, _el$32);
        libs.createElement("Panel", {
          id: "ProgressBarBG"
        }, _el$33);
        const _el$35 = libs.createElement("Panel", {
          id: "ProgressBar",
          get style() {
            return {
              clip: `rect( 0%, ${rewardProgressPercent()}%, 100%, 0% )`
            };
          }
        }, _el$33),
        _el$36 = libs.createElement("Panel", {
          id: "RewardCardViewport",
          draggable: true
        }, _el$32),
        _el$37 = libs.createElement("Panel", {
          id: "RewardCardList",
          get style() {
            return {
              transform: `translateX(${-scrollOffset()}px)`
            };
          }
        }, _el$36);
      libs.setProp(_el$17, "className", "CollectionVipTopLeft");
      libs.setProp(_el$21, "className", "CollectionVipProgress");
      libs.setProp(_el$28, "className", "CollectionVipTopRight");
      libs.insert(_el$30, libs.createComponent(EOM_Button.EOM_Button, {
        id: "ReciveRewardButton",
        color: "Gold",
        size: "Normal",
        text: "#ClaimRewardsBtnTxt",
        get enabled() {
          return libs.memo(() => !!!requesting())() && hasClaimableReward();
        },
        onactivate: () => handleReceiveRewards(0)
      }));
      libs.setProp(_el$31, "className", "CollectionVipCenter");
      libs.insert(_el$31, libs.createComponent(EOM_Button.EOM_BaseButton, {
        id: "LeftArrow",
        get ["class"]() {
          return libs.classNames("SwitchArrow", "LeftArrow");
        },
        get enabled() {
          return canScrollLeft();
        },
        onactivate: () => scrollRewardList(-1)
      }), _el$32);
      libs.use(panel => rewardContentRef = panel, _el$32);
      libs.use(panel => rewardViewportRef = panel, _el$36);
      libs.setProp(_el$36, "onDragStart", (_panel, dragCallbacks) => startRewardDrag(dragCallbacks));
      libs.setProp(_el$36, "onDragEnd", (_panel, draggedPanel) => endRewardDrag(draggedPanel));
      libs.use(panel => rewardListRef = panel, _el$37);
      libs.insert(_el$37, () => vipRewards().map((reward, index) => libs.createComponent(CollectionCard, libs.mergeProps$1({
        panelRef: panel => rewardCardRefs[index] = panel
      }, reward, {
        get selected() {
          return reward.level === currentVipLevel();
        },
        onactivate: () => handleReceiveReward(reward)
      }))));
      libs.insert(_el$31, libs.createComponent(EOM_Button.EOM_BaseButton, {
        id: "RightArrow",
        get ["class"]() {
          return libs.classNames("SwitchArrow", "RightArrow");
        },
        get enabled() {
          return canScrollRight();
        },
        onactivate: () => scrollRewardList(1)
      }), null);
      libs.effect(_p$ => {
        const _v$9 = currentVipLevel(),
          _v$0 = {
            need_exp: remainingExp(),
            next_level: nextVipLevel()
          },
          _v$1 = {
            clip: `rect( 0%, ${expPercent()}%, 100%, 0% )`
          },
          _v$10 = `${currentExp()} / ${nextExp()}`,
          _v$11 = vipLogoLang(),
          _v$12 = libs.classNames({
            Dragging: isRewardDragging()
          }),
          _v$13 = libs.classNames("RewardProgressBar"),
          _v$14 = {
            transform: `translateX(${rewardProgressLayout().x}px)`,
            width: `${rewardProgressLayout().width}px`
          },
          _v$15 = {
            clip: `rect( 0%, ${rewardProgressPercent()}%, 100%, 0% )`
          },
          _v$16 = {
            transform: `translateX(${-scrollOffset()}px)`
          };
        _v$9 !== _p$._v$9 && (_p$._v$9 = libs.setProp(_el$20, "text", _v$9, _p$._v$9));
        _v$0 !== _p$._v$0 && (_p$._v$0 = libs.setProp(_el$22, "vars", _v$0, _p$._v$0));
        _v$1 !== _p$._v$1 && (_p$._v$1 = libs.setProp(_el$25, "style", _v$1, _p$._v$1));
        _v$10 !== _p$._v$10 && (_p$._v$10 = libs.setProp(_el$26, "text", _v$10, _p$._v$10));
        _v$11 !== _p$._v$11 && (_p$._v$11 = libs.setProp(_el$29, "class", _v$11, _p$._v$11));
        _v$12 !== _p$._v$12 && (_p$._v$12 = libs.setProp(_el$32, "class", _v$12, _p$._v$12));
        _v$13 !== _p$._v$13 && (_p$._v$13 = libs.setProp(_el$33, "class", _v$13, _p$._v$13));
        _v$14 !== _p$._v$14 && (_p$._v$14 = libs.setProp(_el$33, "style", _v$14, _p$._v$14));
        _v$15 !== _p$._v$15 && (_p$._v$15 = libs.setProp(_el$35, "style", _v$15, _p$._v$15));
        _v$16 !== _p$._v$16 && (_p$._v$16 = libs.setProp(_el$37, "style", _v$16, _p$._v$16));
        return _p$;
      }, {
        _v$9: undefined,
        _v$0: undefined,
        _v$1: undefined,
        _v$10: undefined,
        _v$11: undefined,
        _v$12: undefined,
        _v$13: undefined,
        _v$14: undefined,
        _v$15: undefined,
        _v$16: undefined
      });
      return _el$16;
    }
  });
}

const MENU_LIST = {
  collection_vip: [],
  collection_treasure: []
};
const {
  LayoutMenu,
  show,
  menuName
} = EOM_MenuLayout.createMenuLayout("account_vip_level", () => MENU_LIST);
const playerCollectionTreasures = solid_utils.createServiceNetData("player_collection_treasures", {});
const playerAccountLevels = solid_utils.createServiceNetData("player_account_levels", {});
const rewardReceiveRecordsRaw = solid_utils.createServiceNetData("player_account_level_rewards_receive_records", {});
function canAnyTreasureLevelUp() {
  for (const [itemID, levelConfig] of Object.entries(KeyValues.collection_treasure ?? {})) {
    const levels = Object.entries(levelConfig ?? {}).map(([level, data]) => ({
      level: toFiniteNumber(level, 0),
      data: data
    })).filter(({
      level
    }) => level > 0).sort((a, b) => a.level - b.level);
    const maxLevel = levels[levels.length - 1]?.level ?? 0;
    if (maxLevel <= 0) continue;
    const treasureData = playerCollectionTreasures()[itemID];
    const level = Math.min(Math.max(0, toFiniteNumber(treasureData?.level, 0)), maxLevel);
    if (level >= maxLevel) continue;
    const nextLevelConfig = levels.find(entry => entry.level == level + 1);
    const levelCost = toFiniteNumber(nextLevelConfig?.data.level_cost, 0);
    const extraExp = Math.max(0, toFiniteNumber(treasureData?.extra_exp, 0));
    if (levelCost > 0 && extraExp >= levelCost) {
      return true;
    }
  }
  return false;
}
function hasClaimableVipReward() {
  const playerLevel = Math.max(1, toFiniteNumber(playerAccountLevels().collection_treasure?.level, 1));
  const receivedRecords = rewardReceiveRecordsRaw().collection_treasure ?? {};
  return Object.values(KeyValues.collection_treasure_level_reward ?? {}).some(config => {
    const rewardConfig = config;
    const hasReward = Object.keys(rewardConfig.reward ?? {}).length > 0;
    return hasReward && rewardConfig.level <= playerLevel && receivedRecords[String(rewardConfig.level)] !== true;
  });
}
libs.createEffect(() => {
  CustomUIConfig.SetRedPoint(canAnyTreasureLevelUp(), "account_vip_level", "collection_treasure");
});
libs.createEffect(() => {
  CustomUIConfig.SetRedPoint(hasClaimableVipReward(), "account_vip_level", "collection_vip");
});
function HUDVIP() {
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout, {
    id: "AccountVipRoot",
    name: "MenuButtonAccountVipLevel",
    renderOnShow: true,
    get show() {
      return show();
    },
    get children() {
      return [libs.createComponent(LayoutMenu, {}), libs.createComponent(libs.Switch, {
        get children() {
          return [libs.createComponent(libs.Match, {
            get when() {
              return menuName() == "collection_vip";
            },
            get children() {
              return libs.createComponent(CollectionVip, {});
            }
          }), libs.createComponent(libs.Match, {
            get when() {
              return menuName() == "collection_treasure";
            },
            get children() {
              return libs.createComponent(CollectionTreasure, {});
            }
          })];
        }
      })];
    }
  });
}
libs.render(() => libs.createComponent(HUDVIP, {}), $.GetContextPanel());