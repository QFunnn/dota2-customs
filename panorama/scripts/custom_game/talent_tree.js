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
var EOM_XP = require('./EOM_XP.js');
var GenericPanel = require('./GenericPanel.js');

let pTooltipPanel = $.GetContextPanel();
pTooltipPanel.style.minHeight = "0px";
pTooltipPanel.FindAncestor("talent_tree").FindChildTraverse("LeftArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("talent_tree").FindChildTraverse("RightArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("talent_tree").FindChildTraverse("TopArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("talent_tree").FindChildTraverse("BottomArrow").style.opacity = "0";
function TooltipContents(props) {
  const getTalent = () => {
    const result = [];
    if (props.playerID != undefined) {
      const net = CustomNetTables.GetTableValue("common", "hero_talent_" + props.playerID);
      if (net) {
        for (const key in net) {
          const talentName = net[key];
          result.push(talentName);
        }
      }
    }
    return result;
  };
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
  const heroTalent = () => getTalentData(props.heroName);
  const talentList = props.override_talents ? props.override_talents : getTalent();
  const getKeyWordList = str => {
    let arr = [];
    str.replace(/{KeyWord:(\w+?)}/g, (a, b, c) => {
      arr.push(b);
      return b;
    });
    return arr;
  };
  const getInfoList = str => {
    let arr = [];
    str.replace(/{Info:(\w+?)}/g, (a, b, c) => {
      arr.push(b);
      return b;
    });
    return arr;
  };
  let keywordList = [];
  let infoList = [];
  for (const talentName in KeyValues.HeroTalentKv) {
    const talentData = KeyValues.HeroTalentKv[talentName];
    if (talentData.Hero == props.heroName) {
      keywordList = keywordList.concat(...getKeyWordList($.Localize(`#DOTA_Tooltip_ability_${talentName}_description`)));
      infoList = infoList.concat(...getInfoList($.Localize(`#DOTA_Tooltip_ability_${talentName}_description`)));
    }
  }
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    flowChildren: "down",
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "Header",
        get children() {
          return libs.createComponent(GenericPanel.CLabel, {
            text: "#TalentBranch_Title"
          });
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "Content",
        get children() {
          return libs.createComponent(libs.For, {
            get each() {
              return Object.keys(heroTalent()).sort((a, b) => {
                return Number(b) - Number(a);
              });
            },
            children: (level, index) => {
              const talents = heroTalent()[Number(level)];
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
                              return libs.classNames("TalentRow", "ThreeColumn", {
                                Selected: talentList.includes(talentName)
                              });
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
                      return libs.classNames("TalentRow", {
                        Selected: talentList.includes(leftTalent)
                      });
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
                      return libs.classNames("TalentRow", {
                        Selected: talentList.includes(rightTalent)
                      });
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
            }
          });
        }
      }), libs.memo(() => libs.memo(() => !!(keywordList.length > 0 || infoList.length > 0))() && libs.createComponent(EOM_Tooltip.EOM_Tooltip, {
        width: "100%",
        flowChildren: "down",
        get children() {
          return [libs.memo(() => libs.memo(() => keywordList.length > 0)() && libs.createComponent(KeyWordList, {
            keywordList: keywordList
          })), libs.memo(() => libs.memo(() => infoList.length > 0)() && libs.createComponent(InfoList, {
            keywordList: infoList,
            get marginTop() {
              return keywordList.length > 0 ? "4px" : "0px";
            }
          }))];
        }
      }))];
    }
  });
}
function KeyWordList(props) {
  const keywordList = removeRepeatKeyword(props.keywordList);
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    width: "100%",
    flowChildren: "down",
    get children() {
      return keywordList.map((keyword, index) => {
        return libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
          flowChildren: "down",
          marginTop: index == 0 ? "0px" : "4px",
          get children() {
            return [libs.createComponent(EOM_Label.EOM_Label, {
              html: true,
              fontSize: "18px",
              get text() {
                return replaceKeyword(`{KeyWord:${keyword}}`);
              }
            }), libs.createComponent(EOM_Label.EOM_Label, {
              html: true,
              fontSize: "16px",
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
    width: "100%",
    flowChildren: "down",
    get children() {
      return keywordList.map((keyword, index) => {
        return libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
          flowChildren: "down",
          marginTop: index == 0 ? marginTop : "4px",
          get children() {
            return [libs.createComponent(EOM_Label.EOM_Label, {
              html: true,
              fontSize: "18px",
              text: "#" + keyword
            }), libs.createComponent(EOM_Label.EOM_Label, {
              html: true,
              fontSize: "16px",
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
  let heroName = pTooltipPanel.GetAttributeString("heroName", "");
  let playerID = pTooltipPanel.GetAttributeInt("playerID", -1);
  let override_talentsTooltip = JSON.parseSafe(pTooltipPanel.GetAttributeString("override_talents", ""));
  let override_talents = Array.isArray(override_talentsTooltip) ? override_talentsTooltip : undefined;
  libs.render(() => libs.createComponent(TooltipContents, {
    heroName: heroName,
    playerID: playerID,
    override_talents: override_talents
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