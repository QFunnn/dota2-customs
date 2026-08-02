--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Tooltip = require('./EOM_Tooltip.js');
var EOM_Label = require('./EOM_Label.js');
var GenericPanel = require('./GenericPanel.js');
var Heroes = require('./Heroes.js');
var Player = require('./Player.js');
require('./EOM_Button.js');
require('./EOM_Icon.js');
require('./EOM_Image.js');

let pTooltipPanel = $.GetContextPanel();
pTooltipPanel.style.minHeight = "0px";
pTooltipPanel.FindAncestor("hero_ban").FindChildTraverse("LeftArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("hero_ban").FindChildTraverse("RightArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("hero_ban").FindChildTraverse("TopArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("hero_ban").FindChildTraverse("BottomArrow").style.opacity = "0";
function TooltipContents() {
  const banedList = Object.values(CustomNetTables.GetTableValue("common", "hero_ban_list") ?? {});
  const playerBanList = CustomNetTables.GetTableValue("common", "ban_vote") ?? {};
  const heroBanData = {};
  for (const id in playerBanList) {
    const playerID = Number(id);
    const arr = Object.values(playerBanList[id]);
    arr.forEach((heroName, Index) => {
      if (heroBanData[heroName] == undefined) {
        heroBanData[heroName] = [];
      }
      heroBanData[heroName].push(playerID);
    });
  }
  const heroList = Object.keys(heroBanData).sort((a, b) => {
    return multiCompare(heroBanData[b].length - heroBanData[a].length, banedList.indexOf(b) - banedList.indexOf(a));
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "Content",
    get children() {
      return libs.createComponent(EOM_Tooltip.EOM_Tooltip, {
        get children() {
          return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
            get children() {
              return libs.createComponent(GenericPanel.CLabel, {
                id: "Title",
                text: "#ban_hero_title"
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "BanList",
            get children() {
              return heroList.map((heroName, i) => {
                const playerList = heroBanData[heroName];
                return libs.createComponent(EOM_Panel.EOM_Panel, {
                  get className() {
                    return libs.classNames("HeroBanRow", {
                      HighLight: banedList.includes(heroName)
                    });
                  },
                  get children() {
                    return [libs.createComponent(EOM_Panel.EOM_Panel, {
                      id: "HeroImageContainer",
                      get children() {
                        return [libs.createComponent(Heroes.HeroImage, {
                          hero_name: heroName
                        }), libs.createComponent(EOM_Label.EOM_Label, {
                          get text() {
                            return playerList.length;
                          }
                        })];
                      }
                    }), libs.createComponent(EOM_Panel.EOM_Panel, {
                      id: "PlayerList",
                      get children() {
                        return playerList.map(id => libs.createComponent(Player.PlayerAvatar, {
                          get steamID() {
                            return getPlayerData(id, "steamID");
                          },
                          playerID: id,
                          avatar_border: -1
                        }));
                      }
                    })];
                  }
                });
              });
            }
          })];
        }
      });
    }
  });
}
function SetupTooltip() {
  libs.render(() => libs.createComponent(TooltipContents, {}), pTooltipPanel);
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