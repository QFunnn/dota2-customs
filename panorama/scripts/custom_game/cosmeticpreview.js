--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('CosmeticPreview', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var CourierTitle = require('./CourierTitle.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Image = require('./EOM_Image.js');
var EOM_PortraitFullBody = require('./EOM_PortraitFullBody.js');
var EOM_Button = require('./EOM_Button.js');
var GenericPanel = require('./GenericPanel.js');
var Player = require('./Player.js');
var WinStreak = require('./WinStreak.js');
var profile_info = require('./profile_info.js');

const CosmeticPreview = props => {
  const merged = libs.mergeProps$1({
    showPedestal: true,
    showCourierPedestal: true
  }, props);
  const [local, others] = libs.splitProps(merged, ["cosmetic_id", "children", "showPedestal", "showCourierPedestal"]);
  const cosmeticData = libs.createMemo(() => getCosmeticData(local.cosmetic_id));
  const slot = libs.createMemo(() => {
    if (cosmeticData() && cosmeticData().slot) {
      return (cosmeticData().slot + 500).toString();
    }
    let id = local.cosmetic_id.toString();
    if (id.length == 7) {
      return id.substring(0, 3);
    }
    return "0";
  });
  let scene;
  function RefreshPreview() {
    if (scene?.IsValid()) {
      const current_slot = slot();
      const data = cosmeticData();
      if (data) {
        if (current_slot == "545") {
          GameEvents.SendEventClientSide("custom_update_preview_attacker_model", {
            model: data.resource ?? ""
          });
        }
        const resource = data.resource;
        const headType = current_slot.slice(0, 2);
        if (current_slot == "546") {
          scene.FireEntityInput('holy_light_dummy_0', 'TurnOn', '');
          scene.FireEntityInput('holy_light_dummy_1', 'TurnOn', '');
          scene.FireEntityInput('holy_light_dummy_2', 'TurnOn', '');
          scene.FireEntityInput('holy_light_dummy_3', 'TurnOn', '');
          scene.FireEntityInput('holy_light_dummy_4', 'TurnOn', '');
          scene.FireEntityInput('holy_light_dummy_5', 'TurnOn', '');
          scene.FireEntityInput('root', 'RunScriptCode', `SwitchToHolyLight('${resource}')`);
          scene.FireEntityInput('attacker', 'TurnOff', '');
          scene.FireEntityInput('dummy', 'TurnOff', '');
        } else {
          scene.FireEntityInput('holy_light_dummy_0', 'TurnOff', '');
          scene.FireEntityInput('holy_light_dummy_1', 'TurnOff', '');
          scene.FireEntityInput('holy_light_dummy_2', 'TurnOff', '');
          scene.FireEntityInput('holy_light_dummy_3', 'TurnOff', '');
          scene.FireEntityInput('holy_light_dummy_4', 'TurnOff', '');
          scene.FireEntityInput('holy_light_dummy_5', 'TurnOff', '');
        }
        if (headType == "52") {
          scene.FireEntityInput('courier', current_slot == "521" || current_slot == "522" ? 'TurnOn' : 'TurnOff', '');
          scene.FireEntityInput('pedestal_small', current_slot == "521" || current_slot == "522" ? 'TurnOn' : 'TurnOff', '');
          scene.FireEntityInput('pedestal_large', current_slot == "523" || current_slot == "524" ? 'TurnOn' : 'TurnOff', '');
          scene.FireEntityInput('attacker', current_slot == "523" ? 'TurnOn' : 'TurnOff', '');
          scene.FireEntityInput('dummy', current_slot == "523" ? 'TurnOn' : 'TurnOff', '');
          scene.FireEntityInput('runner', current_slot == "524" ? 'TurnOn' : 'TurnOff', '');
          scene.LerpToCameraEntity(current_slot == "521" || current_slot == "522" ? 'preview_camera' : 'preview_camera_far', 0.25);
          if (current_slot == "521" || current_slot == "522") {
            scene.FireEntityInput('root', 'RunScriptCode', `SwitchToAmbient('${resource}')`);
          } else if (current_slot == "523") {
            scene.FireEntityInput('root', 'RunScriptCode', `SwitchToProjectile('${resource}')`);
          } else if (current_slot == "524") {
            scene.FireEntityInput('root', 'RunScriptCode', `SwitchToTrail('${resource}')`);
          }
        } else if (headType == "54") {
          const resource = data.resource;
          scene.FireEntityInput('courier', 'TurnOff', '');
          scene.FireEntityInput('pedestal_small', 'TurnOff', '');
          scene.FireEntityInput('pedestal_large', 'TurnOn', '');
          scene.FireEntityInput('runner', 'TurnOff', '');
          if (current_slot == "541") {
            scene.FireEntityInput('attacker', 'TurnOff', '');
            scene.FireEntityInput('dummy', 'TurnOff', '');
            scene.FireEntityInput('root', 'RunScriptCode', `SwitchToAmbient('${resource}')`);
          } else if (current_slot == "545") {
            scene.FireEntityInput('attacker', 'TurnOn', '');
            scene.FireEntityInput('dummy', 'TurnOn', '');
            let projectile = data.wisp_launch ?? "particles/units/heroes/hero_wisp/wisp_base_attack.vpcf";
            scene.FireEntityInput('root', 'RunScriptCode', `SwitchToProjectile('${projectile}')`);
          }
        }
      }
    }
  }
  libs.createEffect(libs.on(() => local.cosmetic_id, cid => {
    GameEvents.SendEventClientSide("custom_update_preview_attacker_model", {
      model: ""
    });
    if (slot() != "521" && slot() != "522" && slot() != "523" && slot() != "546") {
      if (scene?.IsValid()) {
        scene.ReloadScene();
      }
    }
    RefreshPreview();
  }));
  const [mapSkinList, setMapSkinList] = libs.createSignal((cosmeticData()?.ui_map_skin_list ?? "").split("|"));
  const [mapName, setMapName] = libs.createSignal(mapSkinList().length > 1 ? mapSkinList()[0] : cosmeticData()?.resource ?? "");
  const [previewMapName, setPreviewMapName] = libs.createSignal(mapName());
  const [mapSkinSwitchData, setMapSkinSwitchData] = libs.createSignal();
  libs.createEffect(libs.on(cosmeticData, v => {
    if (v) {
      let _data = v;
      let skinList = (v?.ui_map_skin_list ?? "").split("|");
      libs.batch(() => {
        setMapName(skinList.length > 1 ? skinList[0] : v?.resource ?? "");
        setMapSkinList(skinList);
        if (_data.ui_map_skin_switch != undefined) {
          setMapSkinSwitchData({
            path: _data.ui_map_skin_switch,
            fov: 30,
            z: 400
          });
        } else {
          setMapSkinSwitchData();
        }
      });
    }
  }));
  let skinSwtichFXContainer;
  let switchMapTimer;
  libs.createEffect(libs.on(mapName, v => {
    if (switchMapTimer != undefined) {
      $.CancelScheduled(switchMapTimer);
      switchMapTimer = undefined;
    }
    if (mapSkinSwitchData() && skinSwtichFXContainer?.IsValid()) {
      let p = $.CreatePanel("DOTAParticleScenePanel", skinSwtichFXContainer, "MapSkinSwitchFX", {
        light: "light",
        camera: "camera_top",
        map: "scene/draw_open",
        particleName: mapSkinSwitchData().path,
        cameraOrigin: `0 0 ${mapSkinSwitchData().z}`,
        lookAt: "0 0 0",
        fov: mapSkinSwitchData().fov,
        particleonly: true,
        hittest: false
      });
      switchMapTimer = $.Schedule(1, () => {
        setPreviewMapName(v);
        switchMapTimer = undefined;
      });
      p.DeleteAsync(3);
    } else {
      setPreviewMapName(v);
    }
  }));
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "CosmeticPreview"
    })), null);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "CosmeticPreview"
    })), true);
    libs.insert(_el$, libs.createComponent(libs.Switch, {
      get children() {
        return [libs.createComponent(libs.Match, {
          get when() {
            return slot() == '510' || slot() == '300';
          },
          get children() {
            const _el$2 = libs.createElement("Panel", {
              get id() {
                return "_" + local.cosmetic_id;
              }
            }, null);
            libs.setProp(_el$2, "className", "PreviewContainer");
            libs.insert(_el$2, () => {
              const unitName = () => {
                if (slot() == "300") {
                  for (const heroName in KeyValues.UnitsCommonKv) {
                    const kv = KeyValues.UnitsCommonKv[heroName];
                    if (kv && kv.Hid && kv.Hid == local.cosmetic_id) {
                      return heroName;
                    }
                  }
                }
                return local.cosmetic_id.toString();
              };
              return libs.createComponent(EOM_PortraitFullBody.EOM_PortraitFullBody, {
                id: "Hero3D",
                get showPedestal() {
                  return local.showPedestal;
                },
                get unitname() {
                  return unitName();
                }
              });
            });
            libs.effect(_$p => libs.setProp(_el$2, "id", "_" + local.cosmetic_id, _$p));
            return _el$2;
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return slot() == '520';
          },
          get children() {
            const _el$3 = libs.createElement("Panel", {
              get id() {
                return "_" + local.cosmetic_id;
              }
            }, null);
            libs.setProp(_el$3, "className", "PreviewContainer");
            libs.insert(_el$3, libs.createComponent(EOM_PortraitFullBody.EOM_PortraitFullBody, {
              id: "Courier3D",
              get showPedestal() {
                return local.showCourierPedestal;
              },
              width: "100%",
              height: "100%",
              get unitname() {
                return local.cosmetic_id?.toString();
              }
            }));
            libs.effect(_$p => libs.setProp(_el$3, "id", "_" + local.cosmetic_id, _$p));
            return _el$3;
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return slot() == '521' || slot() == '522' || slot() == '523' || slot() == '524';
          },
          get children() {
            const _el$4 = libs.createElement("Panel", {
                get id() {
                  return "_" + local.cosmetic_id;
                }
              }, null),
              _el$5 = libs.createElement("DOTAScenePanel", {
                id: "CourierScene",
                particleonly: false,
                allowrotation: true,
                light: "preview_light",
                camera: "camera_dist",
                map: "scene/courier_preview",
                renderwaterreflections: true,
                deferredalpha: true,
                rendershadows: true,
                allowsuspendrepaint: true
              }, _el$4);
            libs.setProp(_el$4, "className", "PreviewContainer");
            const _ref$ = scene;
            typeof _ref$ === "function" ? libs.use(_ref$, _el$5) : scene = _el$5;
            libs.setProp(_el$5, "className", "PreviewScene");
            libs.setProp(_el$5, "onload", RefreshPreview);
            libs.effect(_$p => libs.setProp(_el$4, "id", "_" + local.cosmetic_id, _$p));
            return _el$4;
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return slot() == "525";
          },
          get children() {
            return libs.createComponent(EOM_Panel.EOM_Panel, {
              className: "PreviewContainer",
              get id() {
                return "_" + local.cosmetic_id;
              },
              get children() {
                return libs.createComponent(CourierTitle.CourierTitle, {
                  get oid() {
                    return local.cosmetic_id;
                  }
                });
              }
            });
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return slot() == '530';
          },
          get children() {
            return libs.createComponent(EOM_Panel.EOM_Panel, {
              width: "100%",
              height: "100%",
              get children() {
                return [libs.createComponent(EOM_Panel.EOM_Panel, {
                  width: "100%",
                  height: "100%",
                  get children() {
                    const _el$6 = libs.createElement("Panel", {}, null),
                      _el$7 = libs.createElement("DOTAScenePanel", {
                        id: "BattleFieldScene",
                        get map() {
                          return 'scene/' + (previewMapName() ?? '');
                        },
                        particleonly: false,
                        camera: "preview_camera",
                        light: "preview_light",
                        allowrotation: true,
                        antialias: true,
                        renderwaterreflections: true,
                        deferredalpha: true,
                        rendershadows: true,
                        allowsuspendrepaint: true
                      }, _el$6);
                    libs.setProp(_el$6, "className", "PreviewContainer");
                    libs.setProp(_el$7, "className", "PreviewScene");
                    libs.setProp(_el$7, "style", {
                      width: '100%',
                      height: '100%'
                    });
                    libs.effect(_$p => libs.setProp(_el$7, "map", 'scene/' + (previewMapName() ?? ''), _$p));
                    return _el$6;
                  }
                }), libs.createComponent(EOM_Panel.EOM_Panel, {
                  id: "MapSkinSwitchFXContainer",
                  hittest: false,
                  ref(r$) {
                    const _ref$2 = skinSwtichFXContainer;
                    typeof _ref$2 === "function" ? _ref$2(r$) : skinSwtichFXContainer = r$;
                  }
                }), libs.createComponent(libs.Show, {
                  get when() {
                    return mapSkinList().length > 1;
                  },
                  get children() {
                    return libs.createComponent(EOM_Panel.EOM_Panel, {
                      className: "SwitchSkinButtons",
                      get children() {
                        return libs.createComponent(libs.Index, {
                          get each() {
                            return mapSkinList();
                          },
                          children: (name, index) => libs.createComponent(EOM_Button.EOM_BaseButton, {
                            get className() {
                              return libs.classNames("CosmeticSkinButton", {
                                Selected: name() == mapName()
                              });
                            },
                            onactivate: () => {
                              setMapName(name());
                            },
                            get children() {
                              return libs.createComponent(GenericPanel.CLabel, {
                                text: "#battle_map_skin_" + index
                              });
                            }
                          })
                        });
                      }
                    });
                  }
                })];
              }
            });
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return slot() == '531';
          },
          get children() {
            const _el$8 = libs.createElement("Panel", {
              get id() {
                return "_" + local.cosmetic_id;
              }
            }, null);
            libs.setProp(_el$8, "className", "PreviewContainer");
            libs.insert(_el$8, libs.createComponent(EOM_PortraitFullBody.EOM_PortraitFullBody, {
              id: "Bunnry3D",
              showPedestal: true,
              get unitname() {
                return local.cosmetic_id?.toString();
              }
            }));
            libs.effect(_$p => libs.setProp(_el$8, "id", "_" + local.cosmetic_id, _$p));
            return _el$8;
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return slot() == '541';
          },
          get children() {
            const _el$9 = libs.createElement("Panel", {
                get id() {
                  return "_" + local.cosmetic_id;
                }
              }, null),
              _el$0 = libs.createElement("DOTAScenePanel", {
                id: "TeleportScene",
                particleonly: false,
                allowrotation: true,
                light: "preview_light",
                camera: "preview_camera_far",
                map: "scene/courier_preview",
                renderwaterreflections: true,
                deferredalpha: true,
                rendershadows: true,
                allowsuspendrepaint: true
              }, _el$9);
            libs.setProp(_el$9, "className", "PreviewContainer");
            const _ref$3 = scene;
            typeof _ref$3 === "function" ? libs.use(_ref$3, _el$0) : scene = _el$0;
            libs.setProp(_el$0, "className", "PreviewScene");
            libs.setProp(_el$0, "style", {
              width: '100%',
              height: '100%'
            });
            libs.setProp(_el$0, "onload", RefreshPreview);
            libs.effect(_$p => libs.setProp(_el$9, "id", "_" + local.cosmetic_id, _$p));
            return _el$9;
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return slot() == '542';
          },
          get children() {
            const _el$1 = libs.createElement("Panel", {
              get id() {
                return "_" + local.cosmetic_id;
              }
            }, null);
            libs.setProp(_el$1, "className", "PreviewContainer");
            libs.insert(_el$1, libs.createComponent(CourierTitle.BattleWin, {
              get oid() {
                return local.cosmetic_id;
              },
              type: 'preview'
            }));
            libs.effect(_$p => libs.setProp(_el$1, "id", "_" + local.cosmetic_id, _$p));
            return _el$1;
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return slot() == '544';
          },
          get children() {
            const _el$10 = libs.createElement("Panel", {
              get id() {
                return "_" + local.cosmetic_id;
              }
            }, null);
            libs.setProp(_el$10, "className", "PreviewContainer");
            libs.insert(_el$10, libs.createComponent(WinStreak.WinStreak, {
              type: "preview",
              get oid() {
                return local.cosmetic_id;
              }
            }));
            libs.effect(_$p => libs.setProp(_el$10, "id", "_" + local.cosmetic_id, _$p));
            return _el$10;
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return slot() == '545';
          },
          get children() {
            const _el$11 = libs.createElement("DOTAScenePanel", {
              id: "CourierScene",
              particleonly: false,
              allowrotation: true,
              light: "preview_light",
              camera: "preview_camera_far",
              map: "scene/courier_preview",
              renderwaterreflections: true,
              deferredalpha: true,
              rendershadows: true,
              allowsuspendrepaint: true
            }, null);
            const _ref$4 = scene;
            typeof _ref$4 === "function" ? libs.use(_ref$4, _el$11) : scene = _el$11;
            libs.setProp(_el$11, "className", "PreviewScene");
            libs.setProp(_el$11, "onload", RefreshPreview);
            return _el$11;
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return slot() == '546';
          },
          get children() {
            const _el$12 = libs.createElement("Panel", {
                get id() {
                  return "_" + local.cosmetic_id;
                }
              }, null),
              _el$13 = libs.createElement("DOTAScenePanel", {
                id: "HolyLightScene",
                particleonly: false,
                allowrotation: true,
                light: "preview_light",
                camera: "preview_camera_far",
                map: "scene/courier_preview",
                renderwaterreflections: true,
                deferredalpha: true,
                rendershadows: true,
                allowsuspendrepaint: true
              }, _el$12);
            libs.setProp(_el$12, "className", "PreviewContainer");
            const _ref$5 = scene;
            typeof _ref$5 === "function" ? libs.use(_ref$5, _el$13) : scene = _el$13;
            libs.setProp(_el$13, "className", "PreviewScene");
            libs.setProp(_el$13, "style", {
              width: '100%',
              height: '100%'
            });
            libs.setProp(_el$13, "onload", RefreshPreview);
            libs.effect(_$p => libs.setProp(_el$12, "id", "_" + local.cosmetic_id, _$p));
            return _el$12;
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return slot() == '550' || slot() == '551';
          },
          get children() {
            const _el$14 = libs.createElement("Panel", {
                get id() {
                  return "_" + local.cosmetic_id;
                }
              }, null),
              _el$15 = libs.createElement("Panel", {}, _el$14);
            libs.setProp(_el$14, "className", "PreviewContainer");
            libs.setProp(_el$15, "className", "PreviewEmoji");
            libs.insert(_el$15, libs.createComponent(GenericPanel.CImage, {
              get src() {
                return getCosmeticImagePath(local.cosmetic_id.toString());
              }
            }));
            libs.effect(_$p => libs.setProp(_el$14, "id", "_" + local.cosmetic_id, _$p));
            return _el$14;
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return slot() == '570';
          },
          get children() {
            const _el$16 = libs.createElement("Panel", {
              get id() {
                return "_" + local.cosmetic_id;
              }
            }, null);
            libs.setProp(_el$16, "className", "PreviewContainer");
            libs.insert(_el$16, libs.createComponent(profile_info.ProfileInfo, {
              get player_id() {
                return Players.GetLocalPlayer();
              },
              get avatar_frame() {
                return local.cosmetic_id;
              }
            }));
            libs.effect(_$p => libs.setProp(_el$16, "id", "_" + local.cosmetic_id, _$p));
            return _el$16;
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return slot() == '571';
          },
          get children() {
            const _el$17 = libs.createElement("Panel", {
              get id() {
                return "_" + local.cosmetic_id;
              }
            }, null);
            libs.setProp(_el$17, "className", "PreviewContainer");
            libs.insert(_el$17, libs.createComponent(profile_info.ProfileInfo, {
              get player_id() {
                return Players.GetLocalPlayer();
              },
              get avatar_border() {
                return local.cosmetic_id;
              }
            }));
            libs.effect(_$p => libs.setProp(_el$17, "id", "_" + local.cosmetic_id, _$p));
            return _el$17;
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return slot() == '572';
          },
          get children() {
            const _el$18 = libs.createElement("Panel", {
              get id() {
                return "_" + local.cosmetic_id;
              }
            }, null);
            libs.setProp(_el$18, "className", "PreviewContainer");
            libs.insert(_el$18, libs.createComponent(profile_info.ProfileInfo, {
              get player_id() {
                return Players.GetLocalPlayer();
              },
              get avatar_background() {
                return local.cosmetic_id;
              }
            }));
            libs.effect(_$p => libs.setProp(_el$18, "id", "_" + local.cosmetic_id, _$p));
            return _el$18;
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return slot() == '573';
          },
          get children() {
            const _el$19 = libs.createElement("Panel", {
              get id() {
                return "_" + local.cosmetic_id;
              }
            }, null);
            libs.setProp(_el$19, "className", "PreviewContainer");
            libs.insert(_el$19, libs.createComponent(profile_info.ProfileInfo, {
              get player_id() {
                return Players.GetLocalPlayer();
              },
              get avatar_decoration() {
                return local.cosmetic_id;
              }
            }));
            libs.effect(_$p => libs.setProp(_el$19, "id", "_" + local.cosmetic_id, _$p));
            return _el$19;
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return slot() == "575";
          },
          get children() {
            const _el$20 = libs.createElement("Panel", {
              get id() {
                return "_" + local.cosmetic_id;
              }
            }, null);
            libs.setProp(_el$20, "className", "PreviewContainer");
            libs.insert(_el$20, libs.createComponent(EOM_Panel.EOM_Panel, {
              className: "PlayerInfoPreview",
              get children() {
                return [libs.createComponent(Player.PlayerRowBGOrnament, {
                  get children() {
                    return libs.createComponent(EOM_Panel.EOM_Panel, {
                      id: "HealthCircle",
                      get children() {
                        return [libs.createComponent(EOM_Image.EOM_Image, {
                          className: "Circle"
                        }), libs.createComponent(GenericPanel.CLabel, {
                          text: 50
                        })];
                      }
                    });
                  }
                }), libs.createComponent(EOM_Panel.EOM_Panel, {
                  id: "PlayerRowMainContainer",
                  get children() {
                    return [libs.createComponent(Player.PlayerAvatar, {
                      get steamID() {
                        return getPlayerData(Players.GetLocalPlayer(), "steamID");
                      },
                      get playerID() {
                        return Players.GetLocalPlayer();
                      },
                      ban: false
                    }), libs.createComponent(EOM_Panel.EOM_Panel, {
                      className: "InfoContainer",
                      hittest: false,
                      get children() {
                        return libs.createComponent(EOM_Panel.EOM_Panel, {
                          marginLeft: "23px",
                          width: "100%",
                          height: "100%",
                          get children() {
                            return [libs.createComponent(Player.PlayerName, {
                              get steamID() {
                                return getPlayerData(Players.GetLocalPlayer(), "steamID");
                              },
                              get playerID() {
                                return Players.GetLocalPlayer();
                              },
                              get ban() {
                                return isNameBan(Players.GetLocalPlayer());
                              }
                            }), libs.createComponent(EOM_Panel.EOM_Panel, {
                              flowChildren: "right",
                              verticalAlign: "bottom",
                              get children() {
                                return [libs.createComponent(GenericPanel.CImage, {
                                  id: "GoldIcon"
                                }), libs.createComponent(GenericPanel.CLabel, {
                                  id: "LevelLabel",
                                  text: "300"
                                }), libs.createComponent(GenericPanel.CImage, {
                                  id: "DamageIcon"
                                }), libs.createComponent(GenericPanel.CLabel, {
                                  id: "DamageLabel",
                                  text: "3"
                                })];
                              }
                            })];
                          }
                        });
                      }
                    })];
                  }
                }), libs.createComponent(WinStreak.PlayerAvatarMedal, {
                  get oid() {
                    return local.cosmetic_id.toString();
                  }
                })];
              }
            }));
            libs.effect(_$p => libs.setProp(_el$20, "id", "_" + local.cosmetic_id, _$p));
            return _el$20;
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return slot() == "576";
          },
          get children() {
            const _el$21 = libs.createElement("Panel", {
              get id() {
                return "_" + local.cosmetic_id;
              }
            }, null);
            libs.setProp(_el$21, "className", "PreviewContainer");
            libs.insert(_el$21, libs.createComponent(EOM_Panel.EOM_Panel, {
              className: "PlayerInfoPreview",
              get children() {
                return [libs.createComponent(Player.PlayerRowBGOrnament, {
                  get oid() {
                    return local.cosmetic_id;
                  },
                  get children() {
                    return libs.createComponent(EOM_Panel.EOM_Panel, {
                      id: "HealthCircle",
                      get children() {
                        return [libs.createComponent(EOM_Image.EOM_Image, {
                          className: "Circle"
                        }), libs.createComponent(GenericPanel.CLabel, {
                          text: 50
                        })];
                      }
                    });
                  }
                }), libs.createComponent(EOM_Panel.EOM_Panel, {
                  id: "PlayerRowMainContainer",
                  get children() {
                    return [libs.createComponent(Player.PlayerAvatar, {
                      get steamID() {
                        return getPlayerData(Players.GetLocalPlayer(), "steamID");
                      },
                      get playerID() {
                        return Players.GetLocalPlayer();
                      },
                      ban: false
                    }), libs.createComponent(EOM_Panel.EOM_Panel, {
                      className: "InfoContainer",
                      hittest: false,
                      get children() {
                        return libs.createComponent(EOM_Panel.EOM_Panel, {
                          marginLeft: "23px",
                          width: "100%",
                          height: "100%",
                          get children() {
                            return [libs.createComponent(Player.PlayerName, {
                              get steamID() {
                                return getPlayerData(Players.GetLocalPlayer(), "steamID");
                              },
                              get playerID() {
                                return Players.GetLocalPlayer();
                              },
                              get ban() {
                                return isNameBan(Players.GetLocalPlayer());
                              }
                            }), libs.createComponent(EOM_Panel.EOM_Panel, {
                              flowChildren: "right",
                              verticalAlign: "bottom",
                              get children() {
                                return [libs.createComponent(GenericPanel.CImage, {
                                  id: "GoldIcon"
                                }), libs.createComponent(GenericPanel.CLabel, {
                                  id: "LevelLabel",
                                  text: "300"
                                }), libs.createComponent(GenericPanel.CImage, {
                                  id: "DamageIcon"
                                }), libs.createComponent(GenericPanel.CLabel, {
                                  id: "DamageLabel",
                                  text: "3"
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
            }));
            libs.effect(_$p => libs.setProp(_el$21, "id", "_" + local.cosmetic_id, _$p));
            return _el$21;
          }
        })];
      }
    }));
    return _el$;
  })();
};

exports.CosmeticPreview = CosmeticPreview;