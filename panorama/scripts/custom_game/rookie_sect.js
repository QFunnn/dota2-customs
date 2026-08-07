--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('rookie_sect', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var GenericPanel = require('./GenericPanel.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Label = require('./EOM_Label.js');
var SectIcon = require('./SectIcon.js');

const EOM_Breadcrumb = props => {
  const merged = libs.mergeProps$1({
    list: [],
    activateType: "onactivate",
    group: doUniqueString("EOM_Breadcrumb")
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "list", "defaultSelected", "selected", "group", "activateType"]);
  const [selectedIndex, setSelectedIndex] = libs.createSignal(local.defaultSelected != undefined ? Math.min(local.list.length - 1, Math.max(0, local.defaultSelected - 1)) : undefined);
  const onHover = index => {
    if (local.activateType == "onhover") {
      onSelect(index);
    }
  };
  const onSelect = index => {
    setSelectedIndex(index);
    if (others.onChange) {
      others.onChange(index + 1, local.list[index]);
    }
  };
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "EOM_Breadcrumb"
    })), null);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "EOM_Breadcrumb"
    })), true);
    libs.insert(_el$, libs.createComponent(GenericPanel.DynamicKey, {
      key: () => local.selected,
      children: selected => libs.createComponent(libs.For, {
        get each() {
          return local.list;
        },
        children: (name, index) => libs.createComponent(libs.Show, {
          get when() {
            return index() > 0;
          },
          get fallback() {
            return libs.createComponent(GenericPanel.TabButton, {
              get selected() {
                return selected != undefined ? selected - 1 == index() : selectedIndex() == index();
              },
              get group() {
                return local.group;
              },
              onactivate: () => onSelect(index()),
              text: "#" + name,
              onmouseover: () => onHover(index())
            });
          },
          get children() {
            return [libs.createComponent(GenericPanel.CLabel, {
              className: "EOM_BreadcrumbSeparator",
              text: "/"
            }), libs.createComponent(GenericPanel.TabButton, {
              get selected() {
                return selected != undefined ? selected - 1 == index() : selectedIndex() == index();
              },
              get group() {
                return local.group;
              },
              onactivate: () => onSelect(index()),
              text: "#" + name,
              onmouseover: () => onHover(index())
            })];
          }
        })
      })
    }));
    return _el$;
  })();
};

const RookieSect = props => {
  let canvasRef;
  let graphRoot;
  let sectFlowConfig = ["sect_attack|sect_crit", "sect_wisp|sect_crit", "sect_ulti|sect_crit", "sect_attack|sect_evade", "sect_wisp|sect_evade", "sect_ulti|sect_evade", "sect_crit|sect_regen", "sect_evade|sect_regen", "sect_health|sect_regen", "sect_regen|sect_shield", "sect_shield|sect_injury", "sect_injury|sect_ice", "sect_ice|sect_fury", "sect_fury|sect_poison", "sect_poison|sect_chaos"];
  const onRenderFinish = () => {
    if (graphRoot?.IsValid() && canvasRef?.IsValid()) {
      canvasRef.style.uiScaleX = `${1 / graphRoot.actualuiscale_x * 100}%`;
      canvasRef.style.uiScaleY = `${1 / graphRoot.actualuiscale_y * 100}%`;
      sectFlowConfig.forEach(single => {
        const [start, end] = single.split("|");
        DrawLineBetweenSect(start, end);
      });
    }
  };
  const DrawLineBetweenSect = (start_sect, end_sect) => {
    let pStartSect = graphRoot?.FindChildTraverse(start_sect);
    let pEndSect = graphRoot?.FindChildTraverse(end_sect);
    if (pStartSect?.IsValid() && pEndSect?.IsValid()) {
      let startOffset = {
        x: pStartSect.actualxoffset,
        y: pStartSect.actualyoffset
      };
      let pStartParent = pStartSect.GetParent();
      if (pStartParent?.IsValid()) {
        startOffset.x += pStartParent.actualxoffset;
        startOffset.y += pStartParent.actualyoffset;
      }
      let endOffset = {
        x: pEndSect.actualxoffset,
        y: pEndSect.actualyoffset
      };
      let pEndParent = pEndSect.GetParent();
      if (pEndParent?.IsValid()) {
        endOffset.x += pEndParent.actualxoffset;
        endOffset.y += pEndParent.actualyoffset;
      }
      let points = [];
      points.push(startOffset.x + pStartSect.actuallayoutwidth, startOffset.y + pStartSect.actuallayoutheight / 2);
      points.push(endOffset.x - 30, startOffset.y + pStartSect.actuallayoutheight / 2);
      points.push(endOffset.x - 30, endOffset.y + pEndSect.actuallayoutheight / 2);
      points.push(endOffset.x, endOffset.y + pEndSect.actuallayoutheight / 2);
      canvasRef?.DrawSoftLinePointsJS(4, points, 2, 1, "#ffffff");
    }
  };
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    className: "RookieSect",
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "SectFlowGraphMain",
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "SectFlowGraphTitle",
            get children() {
              return libs.createComponent(EOM_Label.EOM_Label, {
                text: "#Rookie_Sect_title"
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "SectFlowGraphBox",
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "SectFlowGraph",
                ref(r$) {
                  const _ref$ = graphRoot;
                  typeof _ref$ === "function" ? _ref$(r$) : graphRoot = r$;
                },
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "SectFlowGraphIn",
                    flowChildren: "right",
                    get children() {
                      return [libs.createComponent(EOM_Panel.EOM_Panel, {
                        className: "SectFlowGraphRow",
                        id: "SectFlowGraphRow1",
                        flowChildren: "down",
                        get children() {
                          return [libs.createComponent(SectIcon.SectIcon, {
                            id: "sect_attack",
                            sectName: "sect_attack",
                            active: true,
                            tooltip_text: "#DOTA_Tooltip_ability_sect_attack"
                          }), libs.createComponent(SectIcon.SectIcon, {
                            id: "sect_wisp",
                            sectName: "sect_wisp",
                            active: true,
                            tooltip_text: "#DOTA_Tooltip_ability_sect_wisp"
                          }), libs.createComponent(SectIcon.SectIcon, {
                            id: "sect_ulti",
                            sectName: "sect_ulti",
                            active: true,
                            tooltip_text: "#DOTA_Tooltip_ability_sect_ulti"
                          }), libs.createComponent(SectIcon.SectIcon, {
                            id: "sect_health",
                            sectName: "sect_health",
                            active: true,
                            tooltip_text: "#DOTA_Tooltip_ability_sect_health"
                          })];
                        }
                      }), libs.createComponent(EOM_Panel.EOM_Panel, {
                        className: "SectFlowGraphRow",
                        id: "SectFlowGraphRow2",
                        flowChildren: "down",
                        get children() {
                          return [libs.createComponent(SectIcon.SectIcon, {
                            id: "sect_crit",
                            sectName: "sect_crit",
                            active: true,
                            tooltip_text: "#DOTA_Tooltip_ability_sect_crit"
                          }), libs.createComponent(SectIcon.SectIcon, {
                            id: "sect_evade",
                            sectName: "sect_evade",
                            active: true,
                            tooltip_text: "#DOTA_Tooltip_ability_sect_evade"
                          })];
                        }
                      }), libs.createComponent(EOM_Panel.EOM_Panel, {
                        className: "SectFlowGraphRow",
                        id: "SectFlowGraphRow3",
                        flowChildren: "right",
                        get children() {
                          return [libs.createComponent(SectIcon.SectIcon, {
                            id: "sect_regen",
                            sectName: "sect_regen",
                            active: true,
                            tooltip_text: "#DOTA_Tooltip_ability_sect_regen"
                          }), libs.createComponent(SectIcon.SectIcon, {
                            id: "sect_shield",
                            sectName: "sect_shield",
                            active: true,
                            tooltip_text: "#DOTA_Tooltip_ability_sect_shield"
                          }), libs.createComponent(SectIcon.SectIcon, {
                            id: "sect_injury",
                            sectName: "sect_injury",
                            active: true,
                            tooltip_text: "#DOTA_Tooltip_ability_sect_injury"
                          }), libs.createComponent(SectIcon.SectIcon, {
                            id: "sect_ice",
                            sectName: "sect_ice",
                            active: true,
                            tooltip_text: "#DOTA_Tooltip_ability_sect_ice"
                          }), libs.createComponent(SectIcon.SectIcon, {
                            id: "sect_fury",
                            sectName: "sect_fury",
                            active: true,
                            tooltip_text: "#DOTA_Tooltip_ability_sect_fury"
                          }), libs.createComponent(SectIcon.SectIcon, {
                            id: "sect_poison",
                            sectName: "sect_poison",
                            active: true,
                            tooltip_text: "#DOTA_Tooltip_ability_sect_poison"
                          }), libs.createComponent(SectIcon.SectIcon, {
                            id: "sect_chaos",
                            sectName: "sect_chaos",
                            active: true,
                            tooltip_text: "#DOTA_Tooltip_ability_sect_chaos",
                            onload: () => {
                              $.Schedule(0.1, () => {
                                onRenderFinish();
                              });
                            }
                          })];
                        }
                      }), libs.createComponent(GenericPanel.UICanvas, {
                        id: "SectUICanvas",
                        ref(r$) {
                          const _ref$2 = canvasRef;
                          typeof _ref$2 === "function" ? _ref$2(r$) : canvasRef = r$;
                        }
                      })];
                    }
                  });
                }
              });
            }
          })];
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "Detail",
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "SectDetail",
            get children() {
              return [libs.createComponent(SectIcon.SectIcon, {
                sectName: "sect_attack",
                active: true,
                tooltip_text: "#DOTA_Tooltip_ability_sect_attack"
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "SectDetailLabel",
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#Rookie_sect_attack"
                  });
                }
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "SectDetail",
            get children() {
              return [libs.createComponent(SectIcon.SectIcon, {
                sectName: "sect_wisp",
                active: true,
                tooltip_text: "#DOTA_Tooltip_ability_sect_wisp"
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "SectDetailLabel",
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#Rookie_sect_wisp"
                  });
                }
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "SectDetail",
            get children() {
              return [libs.createComponent(SectIcon.SectIcon, {
                sectName: "sect_ulti",
                active: true,
                tooltip_text: "#DOTA_Tooltip_ability_sect_ulti"
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "SectDetailLabel",
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#Rookie_sect_ulti"
                  });
                }
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "SectDetail",
            get children() {
              return [libs.createComponent(SectIcon.SectIcon, {
                sectName: "sect_regen",
                active: true,
                tooltip_text: "#DOTA_Tooltip_ability_sect_regen"
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "SectDetailLabel",
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#Rookie_sect_regen"
                  });
                }
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "SectDetail",
            get children() {
              return [libs.createComponent(SectIcon.SectIcon, {
                sectName: "sect_health",
                active: true,
                tooltip_text: "#DOTA_Tooltip_ability_sect_health"
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "SectDetailLabel",
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#Rookie_sect_health"
                  });
                }
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "SectDetail",
            get children() {
              return [libs.createComponent(SectIcon.SectIcon, {
                sectName: "sect_crit",
                active: true,
                tooltip_text: "#DOTA_Tooltip_ability_sect_crit"
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "SectDetailLabel",
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#Rookie_sect_crit"
                  });
                }
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "SectDetail",
            get children() {
              return [libs.createComponent(SectIcon.SectIcon, {
                sectName: "sect_evade",
                active: true,
                tooltip_text: "#DOTA_Tooltip_ability_sect_evade"
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "SectDetailLabel",
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#Rookie_sect_evade"
                  });
                }
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "SectDetail",
            get children() {
              return [libs.createComponent(SectIcon.SectIcon, {
                sectName: "sect_shield",
                active: true,
                tooltip_text: "#DOTA_Tooltip_ability_sect_shield"
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "SectDetailLabel",
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#Rookie_sect_shield"
                  });
                }
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "SectDetail",
            get children() {
              return [libs.createComponent(SectIcon.SectIcon, {
                sectName: "sect_injury",
                active: true,
                tooltip_text: "#DOTA_Tooltip_ability_sect_injury"
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "SectDetailLabel",
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#Rookie_sect_injury"
                  });
                }
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "SectDetail",
            get children() {
              return [libs.createComponent(SectIcon.SectIcon, {
                sectName: "sect_ice",
                active: true,
                tooltip_text: "#DOTA_Tooltip_ability_sect_ice"
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "SectDetailLabel",
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#Rookie_sect_ice"
                  });
                }
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "SectDetail",
            get children() {
              return [libs.createComponent(SectIcon.SectIcon, {
                sectName: "sect_fury",
                active: true,
                tooltip_text: "#DOTA_Tooltip_ability_sect_fury"
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "SectDetailLabel",
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#Rookie_sect_fury"
                  });
                }
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "SectDetail",
            get children() {
              return [libs.createComponent(SectIcon.SectIcon, {
                sectName: "sect_poison",
                active: true,
                tooltip_text: "#DOTA_Tooltip_ability_sect_poison"
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "SectDetailLabel",
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#Rookie_sect_poison"
                  });
                }
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "SectDetail",
            get children() {
              return [libs.createComponent(SectIcon.SectIcon, {
                sectName: "sect_chaos",
                active: true,
                tooltip_text: "#DOTA_Tooltip_ability_sect_chaos"
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "SectDetailLabel",
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#Rookie_sect_chaos"
                  });
                }
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "SectDetail",
            get children() {
              return [libs.createComponent(SectIcon.SectIcon, {
                sectName: "sect_none",
                active: true,
                tooltip_text: "#DOTA_Tooltip_ability_sect_none"
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "SectDetailLabel",
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#Rookie_sect_none"
                  });
                }
              })];
            }
          })];
        }
      })];
    }
  });
};

exports.EOM_Breadcrumb = EOM_Breadcrumb;
exports.RookieSect = RookieSect;