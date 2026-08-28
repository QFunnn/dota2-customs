--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var common_item = require('./common_item.js');
var upgrade_icon = require('./upgrade_icon.js');
var EOM_Button = require('./EOM_Button.js');
var solid_utils = require('./solid_utils.js');

const ARENA_GRID_PARTICLE = 'particles/buildinghelper/square_sprite_m1.vpcf';
const ARENA_DRAG_PARTICLE = 'particles/buildinghelper/drag_path_m1.vpcf';
const ARENA_CURSOR_PARTICLE = 'particles/generic_gameplay/cursor/main.vpcf';
const ARENA_PREVIEW_HEIGHT = 260;
const AVAILABLE_CELL_COLOR = [77, 214, 152];
const TARGET_CELL_COLOR = [246, 193, 79];
const HIDDEN_PARTICLE_POSITION = [0, 0, -10000];
function HeroName({
  heroName
}) {
  return (() => {
    const _el$ = libs.createElement("Label", {
      "class": "ArenaHeroName",
      get text() {
        return GetLocalization(`#${heroName}`, heroName.replace('npc_dota_hero_', ''));
      }
    }, null);
    libs.effect(_$p => libs.setProp(_el$, "text", GetLocalization(`#${heroName}`, heroName.replace('npc_dota_hero_', '')), _$p));
    return _el$;
  })();
}
function ArenaHud() {
  const session = solid_utils.createPlayerNetDataSignal('arena', 'session');
  const [draggedHero, setDraggedHero] = libs.createSignal();
  let dragPreview;
  const editable = libs.createMemo(() => session()?.phase === 'formation');
  const statusText = libs.createMemo(() => {
    const current = session();
    if (current?.phase === 'countdown' && current.countdown !== undefined) return LocalizeWithVars('#Arena_Countdown', {
      value: current.countdown
    });
    return GetLocalization(`#Arena_Phase_${current?.phase ?? 'loading'}`);
  });
  const send = (eventName, data = {}) => GameEvents.SendCustomEventToServer(eventName, data);
  const findDraggedHero = () => {
    const current = session();
    const worldPosition = GameUI.GetScreenWorldPosition(GameUI.GetCursorPosition());
    if (!editable() || current === undefined || worldPosition == undefined) return undefined;
    let nearestHero;
    let nearestDistance = 145 * 145;
    for (const heroName of current.roster) {
      const unit = current.friendlyUnits[heroName];
      if (unit === undefined || !Entities.IsValidEntity(unit)) continue;
      const origin = Entities.GetAbsOrigin(unit);
      const deltaX = worldPosition[0] - origin[0];
      const deltaY = worldPosition[1] - origin[1];
      const distance = deltaX * deltaX + deltaY * deltaY;
      if (distance < nearestDistance) {
        nearestHero = heroName;
        nearestDistance = distance;
      }
    }
    return nearestHero;
  };
  const getHoveredCell = current => {
    const worldPosition = GameUI.GetScreenWorldPosition(GameUI.GetCursorPosition());
    if (worldPosition == undefined) return undefined;
    let nearestCell;
    let nearestDistance = Number.MAX_SAFE_INTEGER;
    for (const cell of current.boardCells ?? []) {
      const deltaX = worldPosition[0] - cell.worldX;
      const deltaY = worldPosition[1] - cell.worldY;
      if (Math.abs(deltaX) > 96 || Math.abs(deltaY) > 96) continue;
      const distance = deltaX * deltaX + deltaY * deltaY;
      if (distance < nearestDistance) {
        nearestCell = cell;
        nearestDistance = distance;
      }
    }
    return nearestCell;
  };
  const getPreviewPosition = cell => {
    return [cell.worldX, cell.worldY, ARENA_PREVIEW_HEIGHT];
  };
  const createCellParticle = (position, color) => {
    const particle = Particles.CreateParticle(ARENA_GRID_PARTICLE, ParticleAttachment_t.PATTACH_CUSTOMORIGIN, -1);
    Particles.SetParticleAlwaysSimulate(particle);
    Particles.SetParticleControl(particle, 0, position);
    Particles.SetParticleControl(particle, 1, [90, 0, 0]);
    Particles.SetParticleControl(particle, 2, color);
    Particles.SetParticleControl(particle, 3, [20, 0, 0]);
    return particle;
  };
  const destroyDragPreview = () => {
    if (dragPreview === undefined) return;
    for (const particle of dragPreview.gridParticles) Particles.DestroyParticleEffect(particle, false);
    Particles.DestroyParticleEffect(dragPreview.cursorParticle, false);
    Particles.DestroyParticleEffect(dragPreview.dragPathParticle, false);
    dragPreview = undefined;
  };
  const updateDragPreview = () => {
    const preview = dragPreview;
    const current = session();
    const heroName = draggedHero();
    if (preview === undefined || current === undefined || heroName === undefined) return;
    if (!editable()) {
      destroyDragPreview();
      setDraggedHero(undefined);
      return;
    }
    const boardCells = current.boardCells ?? [];
    const heroEntity = current.friendlyUnits[heroName];
    const heroPosition = heroEntity !== undefined && Entities.IsValidEntity(heroEntity) ? Entities.GetAbsOrigin(heroEntity) : undefined;
    const targetCell = getHoveredCell(current);
    for (let index = 0; index < boardCells.length; index++) {
      const cell = boardCells[index];
      const color = targetCell?.x === cell.x && targetCell.y === cell.y ? TARGET_CELL_COLOR : AVAILABLE_CELL_COLOR;
      Particles.SetParticleControl(preview.gridParticles[index], 2, color);
    }
    if (heroPosition !== undefined && targetCell !== undefined) {
      const targetPosition = getPreviewPosition(targetCell);
      Particles.SetParticleControl(preview.dragPathParticle, 4, heroPosition);
      Particles.SetParticleControl(preview.dragPathParticle, 5, targetPosition);
      Particles.SetParticleControl(preview.cursorParticle, 0, targetPosition);
    } else {
      Particles.SetParticleControl(preview.cursorParticle, 0, HIDDEN_PARTICLE_POSITION);
      if (heroPosition !== undefined) Particles.SetParticleControl(preview.dragPathParticle, 5, heroPosition);
    }
    $.Schedule(0, updateDragPreview);
  };
  const startDragPreview = () => {
    const current = session();
    if (current === undefined) return;
    destroyDragPreview();
    const gridParticles = (current.boardCells ?? []).map(cell => createCellParticle(getPreviewPosition(cell), AVAILABLE_CELL_COLOR));
    const cursorParticle = Particles.CreateParticle(ARENA_CURSOR_PARTICLE, ParticleAttachment_t.PATTACH_CUSTOMORIGIN, -1);
    Particles.SetParticleAlwaysSimulate(cursorParticle);
    Particles.SetParticleControl(cursorParticle, 0, HIDDEN_PARTICLE_POSITION);
    Particles.SetParticleControl(cursorParticle, 1, [192, 0, 0]);
    Particles.SetParticleControl(cursorParticle, 2, TARGET_CELL_COLOR);
    const dragPathParticle = Particles.CreateParticle(ARENA_DRAG_PARTICLE, ParticleAttachment_t.PATTACH_CUSTOMORIGIN, -1);
    Particles.SetParticleAlwaysSimulate(dragPathParticle);
    dragPreview = {
      gridParticles,
      cursorParticle,
      dragPathParticle
    };
    updateDragPreview();
  };
  libs.onMount(() => {
    const mouseEvents = GameUI.CustomUIConfig().tMouseEvents;
    const key = 'arena_scene_drag';
    mouseEvents[key] = {
      iPriority: 920,
      fCallback: event => {
        if (event.value !== 0) return false;
        if (event.event_name === 'pressed') {
          const heroName = findDraggedHero();
          if (heroName === undefined) return false;
          setDraggedHero(heroName);
          startDragPreview();
          return true;
        }
        if (event.event_name === 'released' && draggedHero() !== undefined) {
          const current = session();
          const targetCell = current === undefined ? undefined : getHoveredCell(current);
          if (targetCell !== undefined) send('arena_drag_hero', {
            heroName: draggedHero(),
            worldX: targetCell.worldX,
            worldY: targetCell.worldY
          });
          destroyDragPreview();
          setDraggedHero(undefined);
          return true;
        }
        return false;
      }
    };
    libs.onCleanup(() => {
      destroyDragPreview();
      delete mouseEvents[key];
    });
  });
  return libs.createComponent(libs.Show, {
    get when() {
      return session() !== undefined;
    },
    children: () => {
      const current = () => session();
      return (() => {
        const _el$2 = libs.createElement("Panel", {
            "class": "ArenaHud",
            hittest: false
          }, null),
          _el$3 = libs.createElement("Panel", {
            "class": "ArenaStatusPill",
            hittest: false
          }, _el$2),
          _el$4 = libs.createElement("Label", {
            "class": "ArenaStatusTitle",
            get text() {
              return GetLocalization('#Arena_Title');
            }
          }, _el$3),
          _el$5 = libs.createElement("Label", {
            "class": "ArenaStatusText",
            get text() {
              return statusText();
            }
          }, _el$3),
          _el$6 = libs.createElement("Panel", {
            "class": "ArenaInfoPanel",
            hittest: true
          }, _el$2),
          _el$7 = libs.createElement("Label", {
            "class": "ArenaPanelEyebrow",
            get text() {
              return GetLocalization('#Arena_Title');
            }
          }, _el$6),
          _el$8 = libs.createElement("Label", {
            "class": "ArenaPanelTitle",
            get text() {
              return GetLocalization('#Arena_Formation');
            }
          }, _el$6),
          _el$9 = libs.createElement("Panel", {
            "class": "ArenaFormationTabs"
          }, _el$6),
          _el$0 = libs.createElement("Label", {
            "class": "ArenaDragHint",
            get text() {
              return libs.memo(() => draggedHero() === undefined)() ? GetLocalization('#Arena_FormationHint') : LocalizeWithVars('#Arena_DraggingHero', {
                hero: GetLocalization(`#${draggedHero()}`)
              });
            }
          }, _el$6);
          libs.createElement("Panel", {
            "class": "ArenaDivider"
          }, _el$6);
          const _el$10 = libs.createElement("Panel", {
            "class": "ArenaLoadoutHeader"
          }, _el$6),
          _el$11 = libs.createElement("Label", {
            "class": "ArenaSectionTitle",
            get text() {
              return GetLocalization('#Arena_Build');
            }
          }, _el$10),
          _el$12 = libs.createElement("Panel", {
            "class": "ArenaLoadoutItems"
          }, _el$10),
          _el$14 = libs.createElement("Panel", {
            "class": "ArenaOpponentPanel",
            hittest: true
          }, _el$2),
          _el$15 = libs.createElement("Label", {
            "class": "ArenaPanelEyebrow",
            get text() {
              return GetLocalization('#Arena_Challenge');
            }
          }, _el$14),
          _el$16 = libs.createElement("Label", {
            "class": "ArenaPanelTitle",
            get text() {
              return GetLocalization('#Arena_Opponents');
            }
          }, _el$14),
          _el$17 = libs.createElement("Label", {
            "class": "ArenaOpponentHint",
            get text() {
              return GetLocalization('#Arena_OpponentHint');
            }
          }, _el$14),
          _el$18 = libs.createElement("Panel", {
            "class": "ArenaOpponentList"
          }, _el$14);
        libs.insert(_el$9, libs.createComponent(libs.For, {
          each: ['attack', 'defense'],
          children: kind => libs.createComponent(EOM_Button.EOM_BaseButton, {
            get ["class"]() {
              return `ArenaFormationTab ${current().activeFormation === kind ? 'Selected' : ''}`;
            },
            get text() {
              return GetLocalization(`#Arena_${kind}`);
            },
            onactivate: () => editable() && send('arena_set_formation_kind', {
              kind
            })
          })
        }));
        libs.insert(_el$12, libs.createComponent(libs.For, {
          get each() {
            return current().loadout?.blesses ?? [];
          },
          children: bless => libs.createComponent(common_item.CommonItem, {
            "class": "ArenaLoadoutItem",
            get itemName() {
              return bless.name;
            },
            get rarity() {
              return bless.rarity;
            },
            showTips: true
          })
        }), null);
        libs.insert(_el$12, libs.createComponent(libs.For, {
          get each() {
            return current().loadout?.artifacts ?? [];
          },
          children: artifact => libs.createComponent(common_item.CommonItem, {
            "class": "ArenaLoadoutItem",
            get itemName() {
              return artifact.name;
            },
            get rarity() {
              return artifact.rarity;
            },
            showTips: true
          })
        }), null);
        libs.insert(_el$6, libs.createComponent(libs.Show, {
          get when() {
            return current().loadout?.upgrades;
          },
          get fallback() {
            return (() => {
              const _el$23 = libs.createElement("Label", {
                "class": "ArenaEmptyBuild",
                get text() {
                  return GetLocalization('#Arena_BuildPending');
                }
              }, null);
              libs.effect(_$p => libs.setProp(_el$23, "text", GetLocalization('#Arena_BuildPending'), _$p));
              return _el$23;
            })();
          },
          get children() {
            const _el$13 = libs.createElement("Panel", {
              "class": "ArenaUpgradeList"
            }, null);
            libs.insert(_el$13, libs.createComponent(libs.For, {
              get each() {
                return current().roster;
              },
              children: heroName => (() => {
                const _el$24 = libs.createElement("Panel", {
                    "class": "ArenaUpgradeRow"
                  }, null),
                  _el$25 = libs.createElement("Panel", {
                    "class": "ArenaUpgradeIcons"
                  }, _el$24);
                libs.insert(_el$24, libs.createComponent(HeroName, {
                  heroName: heroName
                }), _el$25);
                libs.insert(_el$25, libs.createComponent(libs.For, {
                  get each() {
                    return current().loadout?.upgrades[heroName] ?? [];
                  },
                  children: upgrade => libs.createComponent(upgrade_icon.UpgradeIcon, {
                    "class": "ArenaUpgradeIcon",
                    upgradeID: upgrade,
                    showTips: true
                  })
                }));
                return _el$24;
              })()
            }));
            return _el$13;
          }
        }), null);
        libs.insert(_el$6, libs.createComponent(EOM_Button.EOM_BaseButton, {
          "class": "ArenaExitButton",
          get text() {
            return GetLocalization('#Arena_Exit');
          },
          onactivate: () => send('arena_exit')
        }), null);
        libs.insert(_el$18, libs.createComponent(libs.For, {
          get each() {
            return current().opponents;
          },
          children: opponent => (() => {
            const _el$26 = libs.createElement("Panel", {
                get ["class"]() {
                  return `ArenaOpponentCard ${current().selectedOpponentID === opponent.id ? 'Selected' : ''}`;
                }
              }, null),
              _el$27 = libs.createElement("Label", {
                "class": "ArenaOpponentName",
                get text() {
                  return GetLocalization(opponent.name, opponent.id);
                }
              }, _el$26),
              _el$28 = libs.createElement("Label", {
                "class": "ArenaOpponentPower",
                get text() {
                  return LocalizeWithVars('#Arena_Power', {
                    value: `${Math.round(opponent.combatScale * 100)}%`
                  });
                }
              }, _el$26);
            libs.setProp(_el$26, "onactivate", () => editable() && send('arena_select_opponent', {
              opponentID: opponent.id
            }));
            libs.effect(_p$ => {
              const _v$10 = `ArenaOpponentCard ${current().selectedOpponentID === opponent.id ? 'Selected' : ''}`,
                _v$11 = GetLocalization(opponent.name, opponent.id),
                _v$12 = LocalizeWithVars('#Arena_Power', {
                  value: `${Math.round(opponent.combatScale * 100)}%`
                });
              _v$10 !== _p$._v$10 && (_p$._v$10 = libs.setProp(_el$26, "class", _v$10, _p$._v$10));
              _v$11 !== _p$._v$11 && (_p$._v$11 = libs.setProp(_el$27, "text", _v$11, _p$._v$11));
              _v$12 !== _p$._v$12 && (_p$._v$12 = libs.setProp(_el$28, "text", _v$12, _p$._v$12));
              return _p$;
            }, {
              _v$10: undefined,
              _v$11: undefined,
              _v$12: undefined
            });
            return _el$26;
          })()
        }));
        libs.insert(_el$2, libs.createComponent(libs.Show, {
          get when() {
            return current().phase === 'result';
          },
          get children() {
            const _el$19 = libs.createElement("Panel", {
                "class": "ArenaResult",
                hittest: true
              }, null),
              _el$20 = libs.createElement("Label", {
                "class": "ArenaResultTitle",
                get text() {
                  return GetLocalization(`#Arena_Result_${current().result ?? 'draw'}`);
                }
              }, _el$19),
              _el$21 = libs.createElement("Label", {
                "class": "ArenaResultText",
                get text() {
                  return GetLocalization('#Arena_ResultSubtitle');
                }
              }, _el$19),
              _el$22 = libs.createElement("Panel", {
                "class": "ArenaResultActions"
              }, _el$19);
            libs.insert(_el$22, libs.createComponent(EOM_Button.EOM_BaseButton, {
              "class": "ArenaAction",
              get text() {
                return GetLocalization('#Arena_Rematch');
              },
              onactivate: () => send('arena_rematch')
            }), null);
            libs.insert(_el$22, libs.createComponent(EOM_Button.EOM_BaseButton, {
              "class": "ArenaAction",
              get text() {
                return GetLocalization('#Arena_Exit');
              },
              onactivate: () => send('arena_exit')
            }), null);
            libs.effect(_p$ => {
              const _v$ = GetLocalization(`#Arena_Result_${current().result ?? 'draw'}`),
                _v$2 = GetLocalization('#Arena_ResultSubtitle');
              _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$20, "text", _v$, _p$._v$));
              _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$21, "text", _v$2, _p$._v$2));
              return _p$;
            }, {
              _v$: undefined,
              _v$2: undefined
            });
            return _el$19;
          }
        }), null);
        libs.effect(_p$ => {
          const _v$3 = GetLocalization('#Arena_Title'),
            _v$4 = statusText(),
            _v$5 = GetLocalization('#Arena_Title'),
            _v$6 = GetLocalization('#Arena_Formation'),
            _v$7 = libs.memo(() => draggedHero() === undefined)() ? GetLocalization('#Arena_FormationHint') : LocalizeWithVars('#Arena_DraggingHero', {
              hero: GetLocalization(`#${draggedHero()}`)
            }),
            _v$8 = GetLocalization('#Arena_Build'),
            _v$9 = GetLocalization('#Arena_Challenge'),
            _v$0 = GetLocalization('#Arena_Opponents'),
            _v$1 = GetLocalization('#Arena_OpponentHint');
          _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$4, "text", _v$3, _p$._v$3));
          _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$5, "text", _v$4, _p$._v$4));
          _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$7, "text", _v$5, _p$._v$5));
          _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$8, "text", _v$6, _p$._v$6));
          _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$0, "text", _v$7, _p$._v$7));
          _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$11, "text", _v$8, _p$._v$8));
          _v$9 !== _p$._v$9 && (_p$._v$9 = libs.setProp(_el$15, "text", _v$9, _p$._v$9));
          _v$0 !== _p$._v$0 && (_p$._v$0 = libs.setProp(_el$16, "text", _v$0, _p$._v$0));
          _v$1 !== _p$._v$1 && (_p$._v$1 = libs.setProp(_el$17, "text", _v$1, _p$._v$1));
          return _p$;
        }, {
          _v$3: undefined,
          _v$4: undefined,
          _v$5: undefined,
          _v$6: undefined,
          _v$7: undefined,
          _v$8: undefined,
          _v$9: undefined,
          _v$0: undefined,
          _v$1: undefined
        });
        return _el$2;
      })();
    }
  });
}
libs.render(() => libs.createComponent(ArenaHud, {}), $.GetContextPanel());