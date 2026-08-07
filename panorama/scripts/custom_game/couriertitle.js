--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('CourierTitle', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Image = require('./EOM_Image.js');
var GenericPanel = require('./GenericPanel.js');

const BattleWin = props => {
  const merged = libs.mergeProps$1({
    type: "normal",
    oid: 5420000
  }, props);
  const replay = panel => {
    if (props.type == "preview") {
      $.Schedule(1.4, () => {
        if (panel.IsValid()) {
          panel.FindChildTraverse("BattleWinSloganEffect")?.TriggerClass("BattleWinSloganEffect");
          panel.FindChildTraverse("BattleWinTextEffect")?.TriggerClass("BattleWinTextEffect");
          panel.FindChildTraverse("Left")?.TriggerClass("Left");
          panel.FindChildTraverse("Right")?.TriggerClass("Right");
          panel.FindChildTraverse("Center")?.TriggerClass("Center");
          replay(panel);
        }
      });
    }
  };
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    get className() {
      return libs.classNames("BattleWin", merged.type, merged.oid);
    },
    onload: self => replay(self),
    get children() {
      return libs.createComponent(libs.Switch, {
        get children() {
          return [libs.createComponent(libs.Match, {
            get when() {
              return merged.type == "normal";
            },
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "BattleWinSlogan",
                get backgroundImage() {
                  return getImagePath("battle_message/battle_win/" + merged.oid + ".png");
                },
                get children() {
                  return libs.createComponent(GenericPanel.CLabel, {
                    id: "BattleWinText",
                    get text() {
                      return $.Localize(`#BattleWin_default`);
                    }
                  });
                }
              });
            }
          }), libs.createComponent(libs.Match, {
            get when() {
              return merged.type == "effect";
            },
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "BattleWinSloganEffect",
                "class": "BattleWinSloganEffect",
                get children() {
                  return [libs.createComponent(EOM_Image.EOM_Image, {
                    "class": "BattleWinImage Left",
                    id: "Left",
                    get backgroundImage() {
                      return getImagePath("battle_message/battle_win/" + merged.oid + "_left.png");
                    }
                  }), libs.createComponent(EOM_Image.EOM_Image, {
                    "class": "BattleWinImage Right",
                    id: "Right",
                    get backgroundImage() {
                      return getImagePath("battle_message/battle_win/" + merged.oid + "_right.png");
                    }
                  }), libs.createComponent(EOM_Image.EOM_Image, {
                    "class": "BattleWinImage Center",
                    id: "Center",
                    get backgroundImage() {
                      return getImagePath("battle_message/battle_win/" + merged.oid + ".png");
                    }
                  }), libs.createComponent(GenericPanel.CLabel, {
                    id: "BattleWinTextEffect",
                    "class": "BattleWinTextEffect",
                    get text() {
                      return $.Localize(`#BattleWin_default`);
                    }
                  })];
                }
              });
            }
          }), libs.createComponent(libs.Match, {
            get when() {
              return merged.type == "preview";
            },
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "BattleWinSloganEffect",
                "class": "BattleWinSloganEffect",
                get children() {
                  return [libs.createComponent(EOM_Image.EOM_Image, {
                    "class": "BattleWinImage Left",
                    id: "Left",
                    get backgroundImage() {
                      return getImagePath("battle_message/battle_win/" + merged.oid + "_left.png");
                    }
                  }), libs.createComponent(EOM_Image.EOM_Image, {
                    "class": "BattleWinImage Right",
                    id: "Right",
                    get backgroundImage() {
                      return getImagePath("battle_message/battle_win/" + merged.oid + "_right.png");
                    }
                  }), libs.createComponent(EOM_Image.EOM_Image, {
                    "class": "BattleWinImage Center",
                    id: "Center",
                    get backgroundImage() {
                      return getImagePath("battle_message/battle_win/" + merged.oid + ".png");
                    }
                  }), libs.createComponent(GenericPanel.CLabel, {
                    id: "BattleWinTextEffect",
                    "class": "BattleWinTextEffect",
                    get text() {
                      return $.Localize(`#BattleWin_default`);
                    }
                  })];
                }
              });
            }
          })];
        }
      });
    }
  });
};

const CourierTitle = props => {
  const merged = libs.mergeProps$1({
    hideparticle: false
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "oid", "hideparticle"]);
  const particleName = () => {
    if (KeyValues.CosmeticsKv[local.oid] && KeyValues.CosmeticsKv[local.oid].resource != undefined) {
      return KeyValues.CosmeticsKv[local.oid].resource;
    }
  };
  const src = () => {
    if ($.BImageFileExists(`file://{images}/custom_game/overhead/${local.oid}.png`)) {
      return `file://{images}/custom_game/overhead/${local.oid}.png`;
    }
    return `file://{images}/custom_game/cosmetics_items/${local.oid}.png`;
  };
  return libs.createComponent(EOM_Panel.EOM_Panel, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
    className: libs.classNames("CourierTitle", "ID" + local.oid)
  }), {
    get children() {
      return [libs.createComponent(GenericPanel.CImage, {
        id: "CourierTitleBG",
        get src() {
          return src();
        }
      }), libs.createComponent(GenericPanel.CLabel, {
        id: "CourierTitleLabel",
        get text() {
          return `#${local.oid}`;
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return libs.memo(() => !!!local.hideparticle)() && particleName() != undefined;
        },
        get children() {
          const _el$ = libs.createElement("DOTAParticleScenePanel", {
            id: "CourierTitleParticle",
            get particleName() {
              return particleName();
            },
            cameraOrigin: "0 0 300",
            lookAt: "0 0 0",
            fov: 50,
            particleonly: true,
            hittest: false
          }, null);
          libs.effect(_$p => libs.setProp(_el$, "particleName", particleName(), _$p));
          return _el$;
        }
      })];
    }
  }));
};

exports.BattleWin = BattleWin;
exports.CourierTitle = CourierTitle;