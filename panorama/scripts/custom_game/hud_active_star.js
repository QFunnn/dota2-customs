--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var CosmeticCard = require('./CosmeticCard.js');
var EOM_Button = require('./EOM_Button.js');
var ProductItem = require('./ProductItem.js');
require('./EOM_Panel.js');
require('./EOM_Countdown.js');
require('./GenericPanel.js');
require('./EOM_Label.js');
require('./EOM_Icon.js');
require('./ProductImage.js');

const maxUpCount = 3;
function ActiveStar() {
  let scene;
  let imageRef;
  const [show, setShow] = libs.createSignal(false);
  const [playerActiveBox, setPlayerActiveBox] = libs.createSignal();
  const [drawResult, setDrawResult] = libs.createSignal([{
    amounts: 1,
    itemId: 5720202,
    type: 1,
    rarity: 3,
    origin_item_id: 5720202,
    debris_exchange_token_id: 1100098,
    debris_exchange_token_amount: 20
  }]);
  const showItemData = () => drawResult()?.[0];
  const [step, setStep] = libs.createSignal(0);
  const [rarityStep, setRarityStep] = libs.createSignal([0, 0, 0, 0]);
  const getRarityStep = max => {
    const result = [0, 0, 0, max];
    for (let i = 2; i > 0; i--) {
      result[i] = $.RandomInt(0, 100) <= 50 ? Math.min(i, result[i + 1]) : Math.max(0, result[i + 1] - 1);
    }
    return result;
  };
  const getParticleCode = step => {
    return `
			if (thisEntity.particle) then
				ParticleManager:DestroyParticle(thisEntity.particle, true)
			end
			local p = ParticleManager:CreateParticle("particles/eom/ui/ui_fx/ui_fx_s2_huoyuezhixing.vpcf", 0, thisEntity)
			ParticleManager:SetParticleControl(p, 0, Vector(${step}, 0, 0))
			thisEntity.particle = p`;
  };
  const prefix = () => {
    const id = showItemData().origin_item_id ?? showItemData().itemId;
    const first = String(id ?? "").slice(0, 1) ?? "0";
    const left = $.Language().toLowerCase() == "schinese" ? "【" : "[";
    const right = $.Language().toLowerCase() == "schinese" ? "】" : "]";
    const type = String(id ?? "").slice(1, 3) ?? "0";
    if (first == "5") {
      return left + $.Localize("#CosmeticSlot_" + type) + right;
    }
    return "";
  };
  libs.onMount(() => {
    const eventIDList = [];
    eventIDList.push(useToggleWindow("MenuButton_active_star", show, setShow));
    eventIDList.push(useNetData("player_active_box", data => {
      setPlayerActiveBox(data);
    }, Players.GetLocalPlayer()));
    eventIDList.push(useClientSideEvent("active_draw_box", data => {
      data.rarity = data.rarity ?? 0;
      DeepPrint(data);
      setStep(0);
      if (scene) {
        scene.FireEntityInput("root", "RunScriptCode", getParticleCode(0));
      }
      setDrawResult(data);
      setRarityStep(getRarityStep(data?.[0]?.rarity ?? 0));
    }));
    libs.onCleanup(() => {
      eventIDList.forEach(id => GameEvents.Unsubscribe(id));
    });
  });
  return (() => {
    const _el$ = libs.createElement("Panel", {
        id: "ActiveStar",
        get ["class"]() {
          return libs.classNames({
            Show: show()
          }, $.Language().toLowerCase());
        }
      }, null);
      libs.createElement("Image", {
        id: "BG"
      }, _el$);
      const _el$4 = libs.createElement("DOTAScenePanel", {
        id: "StarScene",
        get ["class"]() {
          return libs.classNames({
            Show: step() <= maxUpCount
          });
        },
        particleonly: false,
        light: "preview_light",
        camera: "preview_camera",
        map: "scene/active_star_preview"
      }, _el$);
    libs.setProp(_el$, "onactivate", () => {
      if (drawResult().length == 0) {
        return;
      }
      if (step() < maxUpCount) {
        if (scene) {
          scene.FireEntityInput("root", "RunScriptCode", getParticleCode(rarityStep()[step() + 1]));
        }
        Game.EmitSound("Item.DropGemShop");
        setStep(step() + 1);
      } else if (step() == maxUpCount) {
        setStep(step() + 1);
        Game.EmitSound("ui.badge_levelup");
      } else {
        setStep(0);
        if (drawResult().length > 1) {
          drawResult().shift();
          setDrawResult(drawResult());
          setRarityStep(getRarityStep(drawResult()?.[0]?.rarity ?? 0));
        } else {
          setDrawResult([]);
          setRarityStep([0, 0, 0, 0]);
          setShow(false);
        }
        if (scene) {
          scene.FireEntityInput("root", "RunScriptCode", getParticleCode(0));
        }
      }
    });
    libs.insert(_el$, libs.createComponent(EOM_Button.EOM_CloseButton, {
      onactivate: () => setShow(false)
    }), _el$4);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return step() <= maxUpCount;
      },
      get children() {
        const _el$3 = libs.createElement("Image", {
          id: "RarityImage",
          get ["class"]() {
            return libs.classNames({
              common: rarityStep()[step()] == 0,
              rare: rarityStep()[step()] == 1,
              epic: rarityStep()[step()] == 2,
              legendary: rarityStep()[step()] == 3
            });
          }
        }, null);
        const _ref$ = imageRef;
        typeof _ref$ === "function" ? libs.use(_ref$, _el$3) : imageRef = _el$3;
        libs.effect(_$p => libs.setProp(_el$3, "class", libs.classNames({
          common: rarityStep()[step()] == 0,
          rare: rarityStep()[step()] == 1,
          epic: rarityStep()[step()] == 2,
          legendary: rarityStep()[step()] == 3
        }), _$p));
        return _el$3;
      }
    }), _el$4);
    const _ref$2 = scene;
    typeof _ref$2 === "function" ? libs.use(_ref$2, _el$4) : scene = _el$4;
    libs.setProp(_el$4, "onload", self => {
      self.FireEntityInput("root", "RunScriptCode", getParticleCode(0));
    });
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return step() == maxUpCount + 1;
      },
      get children() {
        return [libs.createElement("Image", {
          id: "Congratulations"
        }, null), (() => {
          const _el$6 = libs.createElement("DOTAParticleScenePanel", {
            id: "ResultScene",
            particleonly: true,
            get particleName() {
              return `particles/eom/ui/ui_fx/ui_fx_s2_huoyuezhixing_0${(showItemData()?.rarity ?? 0) + 1}.vpcf`;
            },
            lookAt: "0 0 0",
            cameraOrigin: "400 0 0",
            fov: "18"
          }, null);
          libs.effect(_$p => libs.setProp(_el$6, "particleName", `particles/eom/ui/ui_fx/ui_fx_s2_huoyuezhixing_0${(showItemData()?.rarity ?? 0) + 1}.vpcf`, _$p));
          return _el$6;
        })(), (() => {
          const _el$7 = libs.createElement("Panel", {
            id: "RewardContainer"
          }, null);
          libs.insert(_el$7, libs.createComponent(ProductItem.ProductItem, {
            id: "StoreItemImage",
            get itemid() {
              return showItemData().origin_item_id ?? showItemData().itemId;
            },
            get rarity() {
              return showItemData().rarity;
            },
            get count() {
              return libs.memo(() => showItemData().origin_item_id == undefined)() ? showItemData().amounts : 1;
            }
          }), null);
          libs.insert(_el$7, libs.createComponent(libs.Show, {
            get when() {
              return showItemData().type != 930;
            },
            get children() {
              return libs.createComponent(CosmeticCard.CosmeticImage, {
                hittest: false,
                width: "200px",
                height: "200px",
                y: "-10px",
                align: "center center",
                get itemid() {
                  return (showItemData().origin_item_id ?? showItemData().itemId).toString();
                }
              });
            }
          }), null);
          libs.insert(_el$7, libs.createComponent(libs.Show, {
            get when() {
              return showItemData().debris_exchange_token_id != undefined;
            },
            get children() {
              const _el$8 = libs.createElement("Panel", {
                  id: "ConversionTip"
                }, null);
                libs.createElement("Image", {
                  id: "ConversionBG"
                }, _el$8);
                const _el$0 = libs.createElement("Panel", {
                  id: "ConversionInfo"
                }, _el$8),
                _el$1 = libs.createElement("Label", {
                  id: "TokenCount",
                  get text() {
                    return $.Localize("#ConversionFull");
                  }
                }, _el$0);
              libs.effect(_$p => libs.setProp(_el$1, "text", $.Localize("#ConversionFull"), _$p));
              return _el$8;
            }
          }), null);
          libs.insert(_el$7, libs.createComponent(libs.Show, {
            get when() {
              return showItemData().origin_item_id != undefined || showItemData().debris_exchange_token_id != undefined;
            },
            get children() {
              const _el$10 = libs.createElement("Panel", {
                  id: "Conversion"
                }, null);
                libs.createElement("Image", {
                  id: "ConversionBG"
                }, _el$10);
                const _el$12 = libs.createElement("Panel", {
                  id: "ConversionInfo"
                }, _el$10),
                _el$13 = libs.createElement("Label", {
                  id: "TokenCount",
                  get text() {
                    return $.Localize("#Conversion");
                  }
                }, _el$12),
                _el$14 = libs.createElement("Image", {
                  id: "TokenIcon",
                  get src() {
                    return getPayTypeIconPath(showItemData().debris_exchange_token_id ?? showItemData().itemId);
                  }
                }, _el$12),
                _el$15 = libs.createElement("Label", {
                  id: "TokenCount",
                  get text() {
                    return "×" + (showItemData().debris_exchange_token_amount ?? showItemData().amounts);
                  }
                }, _el$12);
              libs.effect(_p$ => {
                const _v$ = $.Localize("#Conversion"),
                  _v$2 = getPayTypeIconPath(showItemData().debris_exchange_token_id ?? showItemData().itemId),
                  _v$3 = "×" + (showItemData().debris_exchange_token_amount ?? showItemData().amounts);
                _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$13, "text", _v$, _p$._v$));
                _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$14, "src", _v$2, _p$._v$2));
                _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$15, "text", _v$3, _p$._v$3));
                return _p$;
              }, {
                _v$: undefined,
                _v$2: undefined,
                _v$3: undefined
              });
              return _el$10;
            }
          }), null);
          return _el$7;
        })(), (() => {
          const _el$16 = libs.createElement("Panel", {
              id: "RewardDesc"
            }, null);
            libs.createElement("Image", {
              id: "Left",
              "class": "LittleStar"
            }, _el$16);
            const _el$18 = libs.createElement("Label", {
              get text() {
                return prefix() + $.Localize("#" + (showItemData().origin_item_id ?? showItemData().itemId));
              }
            }, _el$16);
            libs.createElement("Image", {
              id: "Right",
              "class": "LittleStar"
            }, _el$16);
          libs.effect(_$p => libs.setProp(_el$18, "text", prefix() + $.Localize("#" + (showItemData().origin_item_id ?? showItemData().itemId)), _$p));
          return _el$16;
        })()];
      }
    }), null);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return step() < maxUpCount;
      },
      get children() {
        return [(() => {
          const _el$20 = libs.createElement("Panel", {
              id: "ActiveStarDesc"
            }, null);
            libs.createElement("Image", {
              id: "Left",
              "class": "LittleStar"
            }, _el$20);
            libs.createElement("Label", {
              text: "#Active_Star_Click"
            }, _el$20);
            libs.createElement("Image", {
              id: "Right",
              "class": "LittleStar"
            }, _el$20);
          return _el$20;
        })(), (() => {
          const _el$24 = libs.createElement("Panel", {
              id: "PointContainer"
            }, null),
            _el$25 = libs.createElement("Image", {
              get ["class"]() {
                return libs.classNames("Point", {
                  Current: step() == 0
                });
              }
            }, _el$24),
            _el$26 = libs.createElement("Image", {
              get ["class"]() {
                return libs.classNames("Point", {
                  Current: step() == 1,
                  Full: step() < 1
                });
              }
            }, _el$24),
            _el$27 = libs.createElement("Image", {
              get ["class"]() {
                return libs.classNames("Point", {
                  Current: step() == 2,
                  Full: step() < 2
                });
              }
            }, _el$24);
          libs.effect(_p$ => {
            const _v$4 = libs.classNames("Point", {
                Current: step() == 0
              }),
              _v$5 = libs.classNames("Point", {
                Current: step() == 1,
                Full: step() < 1
              }),
              _v$6 = libs.classNames("Point", {
                Current: step() == 2,
                Full: step() < 2
              });
            _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$25, "class", _v$4, _p$._v$4));
            _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$26, "class", _v$5, _p$._v$5));
            _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$27, "class", _v$6, _p$._v$6));
            return _p$;
          }, {
            _v$4: undefined,
            _v$5: undefined,
            _v$6: undefined
          });
          return _el$24;
        })()];
      }
    }), null);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return step() == maxUpCount;
      },
      get children() {
        return libs.createElement("Label", {
          id: "OpenDesc",
          text: "#Active_Star_Open"
        }, null);
      }
    }), null);
    libs.effect(_p$ => {
      const _v$7 = libs.classNames({
          Show: show()
        }, $.Language().toLowerCase()),
        _v$8 = libs.classNames({
          Show: step() <= maxUpCount
        });
      _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$, "class", _v$7, _p$._v$7));
      _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$4, "class", _v$8, _p$._v$8));
      return _p$;
    }, {
      _v$7: undefined,
      _v$8: undefined
    });
    return _el$;
  })();
}
if (!isSpectator()) {
  libs.render(() => libs.createComponent(ActiveStar, {}), $.GetContextPanel());
}