--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('HeroCard', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Image = require('./EOM_Image.js');
var EOM_Portrait = require('./EOM_Portrait.js');
var GenericPanel = require('./GenericPanel.js');
var SectIcon = require('./SectIcon.js');
var TalentTree = require('./TalentTree.js');

const HeroCard = props => {
  const merged = libs.mergeProps$1({
    showAbility: true,
    showAbilityTooltip: true,
    showTalent: true,
    showCollection: false,
    type: "portrait"
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "showAbility", "showTalent", "type", "heroName", "trait", "showCollection", "skinID", "showAbilityTooltip", "hero_selection"]);
  const resolved = libs.children(() => local.children);
  const showCollection = () => !(isRankMode() || isKingsRankMode()) && local.showCollection;
  const getAbilityList = heroName => {
    let abilityList = [];
    for (let i = 1; i <= 2; i++) {
      abilityList.push(GameUI.CustomUIConfig().UnitsKv[heroName]["DefaultAbility" + i]);
    }
    return abilityList;
  };
  const abilityList = () => getAbilityList(local.heroName);
  const getSectList = () => {
    if (GameUI.CustomUIConfig().UnitsKv[local.heroName].Sect) {
      return GameUI.CustomUIConfig().UnitsKv[local.heroName].Sect.split("|");
    }
    return [];
  };
  let sectList = () => getSectList();
  const [collected, setCollected] = libs.createSignal(false);
  libs.createEffect(libs.on(() => showCollection(), _showCollection => {
    if (!_showCollection) {
      setCollected(false);
    }
  }));
  const checkCollectionState = data => {
    if (!showCollection()) return;
    const heroID = KeyValues.UnitsCommonKv[local.heroName].Hid;
    if (typeof heroID != "number") return;
    if (data && Object.values(data).some(v => v.hero.includes(heroID))) {
      setCollected(true);
    } else {
      setCollected(false);
    }
  };
  libs.createEffect(libs.on(() => local.heroName, _heroName => {
    checkCollectionState(getServiceNetTable("player_hero_collection", Players.GetLocalPlayer()));
  }));
  libs.onMount(() => {
    const netTableListner = useServiceNetTable("player_hero_collection", data => {
      checkCollectionState(data);
    }, Players.GetLocalPlayer());
    libs.onCleanup(() => {
      CustomNetTables.UnsubscribeNetTableListener(netTableListner);
    });
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
    className: "HeroCard"
  }), {
    get children() {
      return [libs.createComponent(libs.Switch, {
        get children() {
          return [libs.createComponent(libs.Match, {
            get when() {
              return local.type == "portrait";
            },
            get children() {
              return libs.createComponent(EOM_Portrait.EOM_Portrait, {
                className: "HeroCardImage",
                get unitname() {
                  return local.skinID ?? local.heroName;
                },
                get model() {
                  return libs.memo(() => !!local.hero_selection)() ? undefined : GameUI.CustomUIConfig().UnitsKv[local.heroName]?.Model;
                }
              });
            }
          }), libs.createComponent(libs.Match, {
            get when() {
              return local.type == "landscape";
            },
            get children() {
              const _el$ = libs.createElement("DOTAHeroImage", {
                heroimagestyle: "portrait",
                get heroname() {
                  return local.heroName;
                }
              }, null);
              libs.setProp(_el$, "className", "HeroCardImage");
              libs.effect(_$p => libs.setProp(_el$, "heroname", local.heroName, _$p));
              return _el$;
            }
          })];
        }
      }), (() => {
        const _el$2 = libs.createElement("Image", {
          hittest: false
        }, null);
        libs.setProp(_el$2, "className", "HeroCardBorder");
        return _el$2;
      })(), libs.createComponent(GenericPanel.CLabel, {
        className: "UnitName",
        get text() {
          return "#" + local.heroName;
        }
      }), (() => {
        const _el$3 = libs.createElement("Panel", {}, null);
        libs.setProp(_el$3, "className", "SectIcons");
        libs.insert(_el$3, () => sectList().map(sectName => {
          return libs.createComponent(SectIcon.SectIcon, {
            sectName: sectName,
            marginBottom: "-12px"
          });
        }));
        return _el$3;
      })(), libs.createComponent(libs.Show, {
        get when() {
          return local.showAbility;
        },
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "AbilityMask",
            get children() {
              return [libs.memo(() => abilityList().map((abilityName, index) => {
                return libs.createComponent(EOM_Panel.EOM_Panel, {
                  className: "AbilityContainer",
                  get customTooltip() {
                    return local.showAbilityTooltip ? {
                      name: "hero_ability",
                      abilityName: abilityName
                    } : undefined;
                  },
                  get children() {
                    const _el$6 = libs.createElement("DOTAAbilityImage", {
                      abilityname: abilityName
                    }, null);
                    libs.setProp(_el$6, "abilityname", abilityName);
                    return _el$6;
                  }
                });
              })), libs.createElement("Panel", {
                id: "Blank"
              }, null), libs.createComponent(libs.Show, {
                get when() {
                  return local.trait;
                },
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    className: "AbilityContainer",
                    get customTooltip() {
                      return local.showAbilityTooltip ? {
                        name: "hero_ability",
                        abilityName: local.trait ?? ""
                      } : undefined;
                    },
                    get children() {
                      const _el$5 = libs.createElement("DOTAAbilityImage", {
                        get abilityname() {
                          return local.trait;
                        }
                      }, null);
                      libs.effect(_$p => libs.setProp(_el$5, "abilityname", local.trait, _$p));
                      return _el$5;
                    }
                  });
                }
              }), libs.createComponent(libs.Show, {
                get when() {
                  return local.showTalent;
                },
                get children() {
                  return libs.createComponent(TalentTree.TalentTree, {
                    get heroName() {
                      return local.heroName;
                    },
                    get showTooltip() {
                      return local.showAbilityTooltip;
                    },
                    tooltipPosition: "bottom"
                  });
                }
              })];
            }
          }), libs.createComponent(EOM_Image.EOM_Image, {
            id: "EyebrowLeft"
          }), libs.createComponent(EOM_Image.EOM_Image, {
            id: "EyebrowRight"
          })];
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return collected();
        },
        get children() {
          return libs.createComponent(EOM_Image.EOM_Image, {
            className: "CollectedIcon"
          });
        }
      }), libs.memo(() => resolved())];
    }
  }));
};

exports.HeroCard = HeroCard;