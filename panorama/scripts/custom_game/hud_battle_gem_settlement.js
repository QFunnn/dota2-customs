--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var solid_utils = require('./solid_utils.js');
var EOM_MenuLayout = require('./EOM_MenuLayout.js');
var EOM_Button = require('./EOM_Button.js');
var server_equipment = require('./server_equipment.js');
require('./service_netdata_helper.js');
require('./EOM_RedMark.js');

const GRID_CELL_WIDTH = 108;
const GRID_CELL_HEIGHT = 78;
const GRID_CELL_PADDING = 4;
const GRID_CELL_SLOT_WIDTH = GRID_CELL_WIDTH + GRID_CELL_PADDING * 2;
const GRID_CELL_SLOT_HEIGHT = GRID_CELL_HEIGHT + GRID_CELL_PADDING * 2;
const ACTION_PIPS_WIDTH = 337;
const ACTION_PIP_MAX_SIZE = 40;
const REWARD_ITEM_SIZE = 88;
const GRID_CELL_CONTAINER_STYLE = {
  padding: `${GRID_CELL_PADDING}px`
};
const GRID_CELL_STYLE = {
  width: `${GRID_CELL_WIDTH}px`,
  height: `${GRID_CELL_HEIGHT}px`
};
const ACTION_PIPS_STYLE = {
  width: `${ACTION_PIPS_WIDTH}px`,
  height: `${ACTION_PIP_MAX_SIZE}px`
};
const REWARD_ITEM_STYLE = {
  width: `${REWARD_ITEM_SIZE}px`,
  height: `${REWARD_ITEM_SIZE}px`
};
const SPECIAL_GRID_TYPES = new Set(["cell_move_3", "gem_all_lvup", "anycell", "double_cell"]);
const EMPTY_RESOURCE_STATE = {
  essence: 0,
  material: 0
};
const EMPTY_PREVIEW_STATE = {
  total_action_chance: 0,
  base_gem_rewards: "{}",
  preview: ""
};
const GemSettlementHud = () => {
  const towerRewardsPreview = solid_utils.createServiceNetData("player_tower_rewards_preview", EMPTY_PREVIEW_STATE);
  const battleGemState = solid_utils.createNetDataSignal("common", "battle_gem_state");
  const [actions, setActions] = libs.createSignal([]);
  const [hoveredGridType, setHoveredGridType] = libs.createSignal();
  let receiveRewardsLocked = false;
  const previewData = libs.createMemo(() => towerRewardsPreview());
  const parsedPreview = libs.createMemo(() => ParseTowerPreview(previewData()));
  libs.createEffect(() => {
    previewData();
    setActions([]);
    setHoveredGridType(undefined);
    receiveRewardsLocked = false;
  });
  const isVisible = libs.createMemo(() => {
    return battleGemState()?.isFinished === true && parsedPreview() !== undefined;
  });
  const simulation = libs.createMemo(() => {
    const preview = parsedPreview();
    if (preview === undefined) {
      return undefined;
    }
    return SimulateSettlement(preview, actions());
  });
  const gridRows = libs.createMemo(() => parsedPreview()?.grid ?? []);
  const gridPixelWidth = libs.createMemo(() => {
    const rows = gridRows();
    if (rows.length <= 0) {
      return 0;
    }
    const maxColumnCount = rows.reduce((maxCount, rowData) => Math.max(maxCount, rowData.length), 0);
    if (maxColumnCount <= 0) {
      return 0;
    }
    return maxColumnCount * GRID_CELL_SLOT_WIDTH;
  });
  const gridPixelHeight = libs.createMemo(() => {
    const rowCount = gridRows().length;
    if (rowCount <= 0) {
      return 0;
    }
    return rowCount * GRID_CELL_SLOT_HEIGHT;
  });
  const gridBoxStyle = libs.createMemo(() => ({
    width: `${gridPixelWidth()}px`,
    height: `${gridPixelHeight()}px`
  }));
  const originPosition = libs.createMemo(() => {
    const preview = parsedPreview();
    if (preview === undefined) {
      return undefined;
    }
    return {
      row: preview.originRow,
      column: preview.originColumn
    };
  });
  const pathSegments = libs.createMemo(() => {
    const preview = parsedPreview();
    const origin = originPosition();
    if (preview === undefined || origin === undefined) {
      return [];
    }
    const points = [origin, ...actions()];
    const segments = [];
    for (let i = 0; i < points.length - 1; i++) {
      const start = points[i];
      const end = points[i + 1];
      const startCenter = GetCellCenter(start.row, start.column);
      const endCenter = GetCellCenter(end.row, end.column);
      const dx = endCenter.x - startCenter.x;
      const dy = endCenter.y - startCenter.y;
      segments.push({
        id: `${i}:${start.row}-${start.column}:${end.row}-${end.column}`,
        x: startCenter.x,
        y: startCenter.y - 2,
        length: Math.sqrt(dx * dx + dy * dy),
        angle: Math.atan2(dy, dx) * 180 / Math.PI
      });
    }
    return segments;
  });
  const actionCapacity = libs.createMemo(() => {
    const preview = parsedPreview();
    const result = simulation();
    if (preview === undefined || result === undefined) {
      return 0;
    }
    return Math.max(preview.totalActionChance, Math.max(0, result.remainingActionChance) + actions().length);
  });
  const actionSummaryText = libs.createMemo(() => {
    const result = simulation();
    if (result === undefined) {
      return "<font color='#E2B367'>0</font><font color='#7F7559'> / 0</font>";
    }
    return `<font color='#E2B367'>${Math.max(0, result.remainingActionChance)}</font><font color='#7F7559'> / ${actionCapacity()}</font>`;
  });
  const actionPips = libs.createMemo(() => {
    const result = simulation();
    if (result === undefined) {
      return [];
    }
    const total = actionCapacity();
    const remaining = Math.max(0, result.remainingActionChance);
    const list = [];
    for (let i = 0; i < total; i++) {
      list.push(i >= remaining ? "used" : "available");
    }
    return list;
  });
  const actionPipStyle = libs.createMemo(() => {
    const count = actionPips().length;
    const size = count > 0 ? Math.min(ACTION_PIP_MAX_SIZE, ACTION_PIPS_WIDTH / count) : ACTION_PIP_MAX_SIZE;
    return {
      width: `${size}px`,
      height: `${size}px`
    };
  });
  const gridHintText = libs.createMemo(() => {
    const gridType = hoveredGridType();
    if (gridType !== undefined && gridType !== "") {
      return GetLocalization(`#${gridType}_description`);
    }
    return GetLocalization("#BattleGemGridHintDefault");
  });
  const specialStatus = libs.createMemo(() => {
    const preview = parsedPreview();
    const result = simulation();
    if (preview === undefined || result === undefined) {
      return undefined;
    }
    const gridType = preview.grid[result.currentPosition.row]?.[result.currentPosition.column]?.grid_type ?? "";
    return SPECIAL_GRID_TYPES.has(gridType) ? gridType : undefined;
  });
  const activatedEffects = libs.createMemo(() => {
    const preview = parsedPreview();
    if (preview === undefined) {
      return [];
    }
    const list = [];
    const effectByGridType = {};
    for (const action of actions()) {
      const gridType = preview.grid[action.row]?.[action.column]?.grid_type ?? "";
      if (gridType === "") {
        continue;
      }
      const existing = effectByGridType[gridType];
      if (existing !== undefined) {
        existing.count++;
        continue;
      }
      const effect = {
        gridType,
        count: 1
      };
      effectByGridType[gridType] = effect;
      list.push(effect);
    }
    return list;
  });
  const resourceItems = libs.createMemo(() => {
    const resources = simulation()?.resources ?? EMPTY_RESOURCE_STATE;
    return [{
      itemID: "120011",
      count: resources.essence
    }, {
      itemID: "120014",
      count: resources.material
    }];
  });
  const gemPreviewItems = libs.createMemo(() => {
    const result = [];
    for (const reward of simulation()?.gemRewards ?? []) {
      if (reward.type === "perfect") {
        const id = `battle_gem_preview_${result.length}`;
        result.push({
          type: "perfect",
          id,
          gem: {
            id: -(result.length + 1),
            gem_item_id: reward.detail.gem_item_id,
            locked: false,
            level: 0,
            rarity: reward.rarity
          },
          embeddedGemData: reward.embeddedGemData
        });
        continue;
      }
      result.push({
        type: "quantity",
        id: `battle_gem_preview_${result.length}`,
        rarity: reward.rarity,
        count: reward.count
      });
    }
    return result;
  });
  const canConfirm = libs.createMemo(() => {
    return actions().length > 0;
  });
  const onCellActivate = (row, column) => {
    const preview = parsedPreview();
    if (preview === undefined || !IsInsideBoard(preview.grid, row, column)) {
      return;
    }
    const result = simulation();
    if (result === undefined || !result.isValid || result.remainingActionChance <= 0) {
      return;
    }
    const key = BuildCellKey(row, column);
    if (result.visitedKeySet[key] === true) {
      return;
    }
    if (result.anyCellChance <= 0 && !IsNeighbor(result.currentPosition, {
      row,
      column
    })) {
      return;
    }
    PlayCellPickSound(preview.grid[row][column].grid_type);
    setActions(prev => [...prev, {
      row,
      column
    }]);
  };
  const onGridContextMenu = () => {
    setActions(prev => prev.length > 0 ? prev.slice(0, prev.length - 1) : prev);
  };
  const onReceiveRewards = () => {
    if (!canConfirm() || receiveRewardsLocked) {
      return;
    }
    receiveRewardsLocked = true;
    $.Schedule(0.5, () => {
      receiveRewardsLocked = false;
    });
    GameEvents.SendCustomGameEventToServer("battle_gem_receive_rewards", {
      actions: JSON.stringify(actions().map(action => ({
        row: action.row,
        column: action.column
      })))
    });
  };
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout, {
    id: "BattleGemSettlementRoot",
    name: "MenuButton_battle_gem_settlement",
    "class": "CustomHudRoot",
    get show() {
      return isVisible();
    },
    renderOnShow: true,
    hittest: false,
    get children() {
      const _el$ = libs.createElement("Panel", {
          id: "BattleGemSettlementScreen",
          hittest: true
        }, null),
        _el$2 = libs.createElement("Panel", {
          id: "BattleGemSettlementTop"
        }, _el$),
        _el$3 = libs.createElement("Panel", {
          id: "BattleGemSettlementTitleImages",
          hittest: false
        }, _el$2);
        libs.createElement("Image", {
          "class": "BattleGemSettlementTitleLine"
        }, _el$3);
        libs.createElement("Image", {
          id: "BattleGemSettlementTitleText"
        }, _el$3);
        libs.createElement("Image", {
          "class": "BattleGemSettlementTitleLine Reversed"
        }, _el$3);
        const _el$7 = libs.createElement("Panel", {
          id: "BattleGemSettlementContent"
        }, _el$),
        _el$8 = libs.createElement("Panel", {
          id: "BattleGemLeftPanel"
        }, _el$7),
        _el$9 = libs.createElement("Panel", {
          id: "BattleGemActionBar",
          hittest: false
        }, _el$8),
        _el$0 = libs.createElement("Panel", {
          id: "BattleGemActionPips",
          hittest: false
        }, _el$9),
        _el$1 = libs.createElement("Panel", {
          id: "BattleGemActionPipList"
        }, _el$0),
        _el$10 = libs.createElement("Panel", {
          id: "BattleGemActionSummary"
        }, _el$9),
        _el$11 = libs.createElement("Label", {
          id: "BattleGemActionLabel",
          get text() {
            return GetLocalization("#BattleGemAction");
          }
        }, _el$10),
        _el$12 = libs.createElement("Label", {
          id: "BattleGemActionCount",
          html: true,
          get text() {
            return actionSummaryText();
          }
        }, _el$10),
        _el$13 = libs.createElement("Panel", {
          "class": "BattleGemInfoBlock"
        }, _el$8),
        _el$14 = libs.createElement("Panel", {
          "class": "BattleGemSectionHeader"
        }, _el$13);
        libs.createElement("Image", {
          "class": "BattleGemSectionTitleLine"
        }, _el$14);
        const _el$16 = libs.createElement("Label", {
          "class": "BattleGemSectionTitle",
          get text() {
            return GetLocalization("#BattleGemSpecialStatus");
          }
        }, _el$14);
        libs.createElement("Image", {
          "class": "BattleGemSectionTitleLine Reversed"
        }, _el$14);
        const _el$18 = libs.createElement("Panel", {
          "class": "BattleGemStatusList"
        }, _el$13),
        _el$22 = libs.createElement("Panel", {
          "class": "BattleGemInfoBlock"
        }, _el$8),
        _el$23 = libs.createElement("Panel", {
          "class": "BattleGemSectionHeader"
        }, _el$22);
        libs.createElement("Image", {
          "class": "BattleGemSectionTitleLine"
        }, _el$23);
        const _el$25 = libs.createElement("Label", {
          "class": "BattleGemSectionTitle",
          get text() {
            return GetLocalization("#BattleGemActivatedEffects");
          }
        }, _el$23);
        libs.createElement("Image", {
          "class": "BattleGemSectionTitleLine Reversed"
        }, _el$23);
        const _el$27 = libs.createElement("Panel", {
          "class": "BattleGemStatusList ActivatedEffects"
        }, _el$22),
        _el$28 = libs.createElement("Panel", {
          id: "BattleGemGridPanel"
        }, _el$7),
        _el$29 = libs.createElement("Panel", {
          id: "BattleGemGridContainer"
        }, _el$28),
        _el$30 = libs.createElement("Panel", {
          id: "BattleGemGridRows",
          get style() {
            return gridBoxStyle();
          }
        }, _el$29),
        _el$31 = libs.createElement("Panel", {
          id: "BattleGemGridPathOverlay",
          get style() {
            return gridBoxStyle();
          },
          hittest: false
        }, _el$29),
        _el$32 = libs.createElement("Label", {
          id: "BattleGemGridHint",
          get text() {
            return gridHintText();
          }
        }, _el$28),
        _el$33 = libs.createElement("Panel", {
          id: "BattleGemSidePanel"
        }, _el$7),
        _el$34 = libs.createElement("Panel", {
          "class": "BattleGemResourceBlock"
        }, _el$33),
        _el$35 = libs.createElement("Panel", {
          "class": "BattleGemSectionHeader"
        }, _el$34);
        libs.createElement("Image", {
          "class": "BattleGemSectionTitleLine"
        }, _el$35);
        const _el$37 = libs.createElement("Label", {
          "class": "BattleGemSectionTitle",
          get text() {
            return GetLocalization("#BattleGemResourceTitle");
          }
        }, _el$35);
        libs.createElement("Image", {
          "class": "BattleGemSectionTitleLine Reversed"
        }, _el$35);
        const _el$39 = libs.createElement("Panel", {
          "class": "BattleGemResourceList"
        }, _el$34),
        _el$40 = libs.createElement("Panel", {
          "class": "BattleGemRewardBlock"
        }, _el$33),
        _el$41 = libs.createElement("Panel", {
          "class": "BattleGemSectionHeader"
        }, _el$40);
        libs.createElement("Image", {
          "class": "BattleGemSectionTitleLine"
        }, _el$41);
        const _el$43 = libs.createElement("Label", {
          "class": "BattleGemSectionTitle",
          get text() {
            return GetLocalization("#BattleGemRewardTitle");
          }
        }, _el$41);
        libs.createElement("Image", {
          "class": "BattleGemSectionTitleLine Reversed"
        }, _el$41);
        const _el$45 = libs.createElement("Panel", {
          id: "BattleGemRewardList",
          "class": "VerticalScrollStyle",
          scroll: "y"
        }, _el$40),
        _el$46 = libs.createElement("Panel", {
          id: "BattleGemSettlementButtons"
        }, _el$33);
      libs.setProp(_el$0, "style", ACTION_PIPS_STYLE);
      libs.insert(_el$1, libs.createComponent(libs.For, {
        get each() {
          return actionPips();
        },
        children: state => (() => {
          const _el$47 = libs.createElement("Panel", {
            get ["class"]() {
              return libs.classNames("BattleGemActionPip", state === "used" ? "Used" : "Available");
            },
            get style() {
              return actionPipStyle();
            }
          }, null);
          libs.effect(_p$ => {
            const _v$10 = libs.classNames("BattleGemActionPip", state === "used" ? "Used" : "Available"),
              _v$11 = actionPipStyle();
            _v$10 !== _p$._v$10 && (_p$._v$10 = libs.setProp(_el$47, "class", _v$10, _p$._v$10));
            _v$11 !== _p$._v$11 && (_p$._v$11 = libs.setProp(_el$47, "style", _v$11, _p$._v$11));
            return _p$;
          }, {
            _v$10: undefined,
            _v$11: undefined
          });
          return _el$47;
        })()
      }));
      libs.insert(_el$10, libs.createComponent(EOM_Button.EOM_BaseButton, {
        id: "BattleGemActionAddButton"
      }), null);
      libs.insert(_el$18, libs.createComponent(libs.Show, {
        get when() {
          return specialStatus() !== undefined;
        },
        get children() {
          const _el$19 = libs.createElement("Panel", {
              "class": "BattleGemStatusItem"
            }, null),
            _el$20 = libs.createElement("Image", {
              "class": "BattleGemStatusIcon",
              get src() {
                return `file://{images}/custom_game/g1_gem/icon/${specialStatus()}.png`;
              }
            }, _el$19),
            _el$21 = libs.createElement("Label", {
              "class": "BattleGemStatusText",
              get text() {
                return GetLocalization(`#${specialStatus()}`);
              }
            }, _el$19);
          libs.effect(_p$ => {
            const _v$ = `file://{images}/custom_game/g1_gem/icon/${specialStatus()}.png`,
              _v$2 = GetLocalization(`#${specialStatus()}`);
            _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$20, "src", _v$, _p$._v$));
            _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$21, "text", _v$2, _p$._v$2));
            return _p$;
          }, {
            _v$: undefined,
            _v$2: undefined
          });
          return _el$19;
        }
      }));
      libs.insert(_el$27, libs.createComponent(libs.For, {
        get each() {
          return activatedEffects();
        },
        children: effect => (() => {
          const _el$48 = libs.createElement("Panel", {
              "class": "BattleGemStatusItem"
            }, null),
            _el$49 = libs.createElement("Image", {
              "class": "BattleGemStatusIcon",
              get src() {
                return `file://{images}/custom_game/g1_gem/icon/${effect.gridType}.png`;
              }
            }, _el$48),
            _el$50 = libs.createElement("Label", {
              "class": "BattleGemStatusText",
              get text() {
                return GetLocalization(`#${effect.gridType}`);
              }
            }, _el$48),
            _el$51 = libs.createElement("Label", {
              "class": "BattleGemStatusCount",
              get text() {
                return `x ${effect.count}`;
              }
            }, _el$48);
          libs.effect(_p$ => {
            const _v$12 = `file://{images}/custom_game/g1_gem/icon/${effect.gridType}.png`,
              _v$13 = GetLocalization(`#${effect.gridType}`),
              _v$14 = `x ${effect.count}`;
            _v$12 !== _p$._v$12 && (_p$._v$12 = libs.setProp(_el$49, "src", _v$12, _p$._v$12));
            _v$13 !== _p$._v$13 && (_p$._v$13 = libs.setProp(_el$50, "text", _v$13, _p$._v$13));
            _v$14 !== _p$._v$14 && (_p$._v$14 = libs.setProp(_el$51, "text", _v$14, _p$._v$14));
            return _p$;
          }, {
            _v$12: undefined,
            _v$13: undefined,
            _v$14: undefined
          });
          return _el$48;
        })()
      }));
      libs.setProp(_el$29, "oncontextmenu", onGridContextMenu);
      libs.insert(_el$30, libs.createComponent(libs.For, {
        get each() {
          return gridRows();
        },
        children: (rowData, rowIndex) => (() => {
          const _el$52 = libs.createElement("Panel", {
            "class": "BattleGemGridRow"
          }, null);
          libs.insert(_el$52, libs.createComponent(libs.For, {
            each: rowData,
            children: (cell, columnIndex) => {
              const row = rowIndex();
              const column = columnIndex();
              const key = BuildCellKey(row, column);
              const isOrigin = row === parsedPreview().originRow && column === parsedPreview().originColumn;
              const visitedOrder = libs.createMemo(() => GetVisitedOrder(actions(), row, column));
              const cellState = libs.createMemo(() => {
                const result = simulation();
                if (result === undefined) {
                  return {
                    isCurrent: false,
                    isVisited: false,
                    isReachable: false,
                    isTeleportTarget: false
                  };
                }
                const isVisited = result.visitedKeySet[key] === true;
                return {
                  isCurrent: result.currentPosition.row === row && result.currentPosition.column === column,
                  isVisited,
                  isReachable: !isVisited && result.remainingActionChance > 0 && (result.anyCellChance > 0 || IsNeighbor(result.currentPosition, {
                    row,
                    column
                  })),
                  isTeleportTarget: result.anyCellChance > 0 && !isVisited
                };
              });
              const rarity = ResolveCellRarity(cell.grid_type);
              return libs.createComponent(EOM_Button.EOM_BaseButton, {
                "class": "BattleGemGridCellContainer",
                style: GRID_CELL_CONTAINER_STYLE,
                hittestchildren: false,
                onmouseover: () => setHoveredGridType(cell.grid_type || undefined),
                onmouseout: () => setHoveredGridType(undefined),
                onactivate: () => onCellActivate(row, column),
                get children() {
                  const _el$53 = libs.createElement("Panel", {
                      get ["class"]() {
                        return libs.classNames("BattleGemGridCell", `Rarity-${rarity}`, {
                          Origin: isOrigin,
                          Visited: cellState().isVisited,
                          Current: cellState().isCurrent,
                          Reachable: cellState().isReachable,
                          Unreachable: !isOrigin && !cellState().isVisited && !cellState().isReachable,
                          TeleportTarget: cellState().isTeleportTarget
                        });
                      }
                    }, null);
                    libs.createElement("Panel", {
                      "class": "BattleGemGridCellSelection",
                      hittest: false
                    }, _el$53);
                  libs.setProp(_el$53, "style", GRID_CELL_STYLE);
                  libs.insert(_el$53, libs.createComponent(libs.Show, {
                    get when() {
                      return visitedOrder() > 0;
                    },
                    get children() {
                      const _el$55 = libs.createElement("Panel", {
                          "class": "BattleGemGridCellOrder"
                        }, null),
                        _el$56 = libs.createElement("Label", {
                          get text() {
                            return String(visitedOrder());
                          }
                        }, _el$55);
                      libs.effect(_$p => libs.setProp(_el$56, "text", String(visitedOrder()), _$p));
                      return _el$55;
                    }
                  }), null);
                  libs.insert(_el$53, libs.createComponent(libs.Show, {
                    when: isOrigin,
                    get fallback() {
                      return (() => {
                        const _el$59 = libs.createElement("Panel", {
                            "class": "BattleGemGridCellContent"
                          }, null),
                          _el$61 = libs.createElement("Label", {
                            "class": "BattleGemGridCellName",
                            get text() {
                              return GetLocalization(`#${cell.grid_type}`);
                            }
                          }, _el$59);
                        libs.insert(_el$59, libs.createComponent(libs.Show, {
                          get when() {
                            return cell.grid_type !== "";
                          },
                          get children() {
                            const _el$60 = libs.createElement("Image", {
                              "class": "BattleGemGridCellIcon",
                              get src() {
                                return `file://{images}/custom_game/g1_gem/icon/${cell.grid_type}.png`;
                              }
                            }, null);
                            libs.effect(_$p => libs.setProp(_el$60, "src", `file://{images}/custom_game/g1_gem/icon/${cell.grid_type}.png`, _$p));
                            return _el$60;
                          }
                        }), _el$61);
                        libs.effect(_$p => libs.setProp(_el$61, "text", GetLocalization(`#${cell.grid_type}`), _$p));
                        return _el$59;
                      })();
                    },
                    get children() {
                      const _el$57 = libs.createElement("Panel", {
                          "class": "BattleGemGridCellContent"
                        }, null),
                        _el$58 = libs.createElement("Label", {
                          "class": "BattleGemGridCellName",
                          verticalAlign: "center",
                          marginBottom: "0px",
                          get text() {
                            return GetLocalization("#ORIGIN_LABEL");
                          }
                        }, _el$57);
                      libs.setProp(_el$58, "verticalAlign", "center");
                      libs.setProp(_el$58, "marginBottom", "0px");
                      libs.effect(_$p => libs.setProp(_el$58, "text", GetLocalization("#ORIGIN_LABEL"), _$p));
                      return _el$57;
                    }
                  }), null);
                  libs.effect(_$p => libs.setProp(_el$53, "class", libs.classNames("BattleGemGridCell", `Rarity-${rarity}`, {
                    Origin: isOrigin,
                    Visited: cellState().isVisited,
                    Current: cellState().isCurrent,
                    Reachable: cellState().isReachable,
                    Unreachable: !isOrigin && !cellState().isVisited && !cellState().isReachable,
                    TeleportTarget: cellState().isTeleportTarget
                  }), _$p));
                  return _el$53;
                }
              });
            }
          }));
          return _el$52;
        })()
      }));
      libs.insert(_el$31, libs.createComponent(libs.For, {
        get each() {
          return pathSegments();
        },
        children: segment => (() => {
          const _el$62 = libs.createElement("Panel", {
            "class": "BattleGemPathSegment",
            get style() {
              return {
                x: `${segment.x}px`,
                y: `${segment.y}px`,
                width: `${segment.length}px`,
                transform: `rotateZ(${segment.angle}deg)`
              };
            }
          }, null);
          libs.effect(_$p => libs.setProp(_el$62, "style", {
            x: `${segment.x}px`,
            y: `${segment.y}px`,
            width: `${segment.length}px`,
            transform: `rotateZ(${segment.angle}deg)`
          }, _$p));
          return _el$62;
        })()
      }));
      libs.insert(_el$39, libs.createComponent(libs.For, {
        get each() {
          return resourceItems();
        },
        children: item => (() => {
          const _el$63 = libs.createElement("Panel", {
              "class": "BattleGemResourceItem"
            }, null),
            _el$64 = libs.createElement("Panel", {
              "class": "BattleGemResourceItemTop"
            }, _el$63),
            _el$65 = libs.createElement("Image", {
              "class": "BattleGemResourceIcon",
              get src() {
                return getSrcPath(`store_items/${item.itemID}.png`);
              }
            }, _el$64),
            _el$66 = libs.createElement("Label", {
              "class": "BattleGemResourceName",
              get text() {
                return GetLocalization(item.itemID);
              }
            }, _el$64),
            _el$67 = libs.createElement("Label", {
              "class": "BattleGemResourceCount",
              get text() {
                return String(item.count);
              }
            }, _el$64);
            libs.createElement("Image", {
              "class": "BattleGemResourceDivider"
            }, _el$63);
          libs.effect(_p$ => {
            const _v$15 = getSrcPath(`store_items/${item.itemID}.png`),
              _v$16 = GetLocalization(item.itemID),
              _v$17 = String(item.count);
            _v$15 !== _p$._v$15 && (_p$._v$15 = libs.setProp(_el$65, "src", _v$15, _p$._v$15));
            _v$16 !== _p$._v$16 && (_p$._v$16 = libs.setProp(_el$66, "text", _v$16, _p$._v$16));
            _v$17 !== _p$._v$17 && (_p$._v$17 = libs.setProp(_el$67, "text", _v$17, _p$._v$17));
            return _p$;
          }, {
            _v$15: undefined,
            _v$16: undefined,
            _v$17: undefined
          });
          return _el$63;
        })()
      }));
      libs.setProp(_el$45, "scroll", "y");
      libs.insert(_el$45, libs.createComponent(libs.For, {
        get each() {
          return gemPreviewItems();
        },
        children: preview => (() => {
          const _el$69 = libs.createElement("Panel", {
            "class": "BattleGemRewardItem"
          }, null);
          libs.setProp(_el$69, "style", REWARD_ITEM_STYLE);
          libs.insert(_el$69, (() => {
            const _c$ = libs.memo(() => preview.type === "perfect");
            return () => _c$() ? libs.createComponent(PerfectGemWithTooltip, {
              preview: preview
            }) : libs.createComponent(FakeGem, {
              get rarity() {
                return preview.rarity;
              },
              get count() {
                return preview.count;
              }
            });
          })());
          return _el$69;
        })()
      }));
      libs.insert(_el$46, libs.createComponent(EOM_Button.EOM_Button, {
        id: "BattleGemConfirmButton",
        get enabled() {
          return canConfirm();
        },
        get text() {
          return GetLocalization("#TaskReceive");
        },
        onactivate: onReceiveRewards
      }), null);
      libs.insert(_el$46, libs.createComponent(EOM_Button.EOM_Button, {
        id: "BattleGemResetButton",
        color: "Cancel",
        get text() {
          return GetLocalization("#ResetGemPath");
        },
        onactivate: () => setActions([])
      }), null);
      libs.effect(_p$ => {
        const _v$3 = GetLocalization("#BattleGemAction"),
          _v$4 = actionSummaryText(),
          _v$5 = GetLocalization("#BattleGemSpecialStatus"),
          _v$6 = GetLocalization("#BattleGemActivatedEffects"),
          _v$7 = gridBoxStyle(),
          _v$8 = gridBoxStyle(),
          _v$9 = gridHintText(),
          _v$0 = GetLocalization("#BattleGemResourceTitle"),
          _v$1 = GetLocalization("#BattleGemRewardTitle");
        _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$11, "text", _v$3, _p$._v$3));
        _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$12, "text", _v$4, _p$._v$4));
        _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$16, "text", _v$5, _p$._v$5));
        _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$25, "text", _v$6, _p$._v$6));
        _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$30, "style", _v$7, _p$._v$7));
        _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$31, "style", _v$8, _p$._v$8));
        _v$9 !== _p$._v$9 && (_p$._v$9 = libs.setProp(_el$32, "text", _v$9, _p$._v$9));
        _v$0 !== _p$._v$0 && (_p$._v$0 = libs.setProp(_el$37, "text", _v$0, _p$._v$0));
        _v$1 !== _p$._v$1 && (_p$._v$1 = libs.setProp(_el$43, "text", _v$1, _p$._v$1));
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
      return _el$;
    }
  });
};
function PerfectGemWithTooltip(props) {
  return (() => {
    const _el$70 = libs.createElement("Panel", {
      "class": "PerfectGemWithTooltip",
      hittestchildren: false
    }, null);
    libs.setProp(_el$70, "onmouseover", panel => {
      ShowCustomTooltip(panel, "server_gem", {
        id1: "",
        id2: "",
        embedded_gem_data: props.preview.embeddedGemData
      });
    });
    libs.setProp(_el$70, "onmouseout", panel => {
      HideCustomTooltip(panel, "server_gem");
    });
    libs.insert(_el$70, libs.createComponent(server_equipment.Gem, libs.mergeProps$1(() => props.preview.gem)));
    return _el$70;
  })();
}
function FakeGem(props) {
  return (() => {
    const _el$71 = libs.createElement("Panel", {
        get ["class"]() {
          return libs.classNames("FakeGem", `Rarity${props.rarity}`);
        },
        hittestchildren: false
      }, null),
      _el$72 = libs.createElement("Image", {
        "class": "FakeGemIcon",
        get src() {
          return `file://{images}/custom_game/g1_gem/gem_rarity_${props.rarity}.png`;
        }
      }, _el$71),
      _el$73 = libs.createElement("Label", {
        "class": "FakeGemCount",
        get text() {
          return String(props.count);
        }
      }, _el$71);
    libs.setProp(_el$71, "onmouseover", panel => {
      ShowCustomTooltip(panel, "text", {
        text: GetLocalization(`#gem_rarity_tip_${props.rarity}`)
      });
    });
    libs.setProp(_el$71, "onmouseout", panel => {
      HideCustomTooltip(panel, "text");
    });
    libs.effect(_p$ => {
      const _v$18 = libs.classNames("FakeGem", `Rarity${props.rarity}`),
        _v$19 = `file://{images}/custom_game/g1_gem/gem_rarity_${props.rarity}.png`,
        _v$20 = String(props.count);
      _v$18 !== _p$._v$18 && (_p$._v$18 = libs.setProp(_el$71, "class", _v$18, _p$._v$18));
      _v$19 !== _p$._v$19 && (_p$._v$19 = libs.setProp(_el$72, "src", _v$19, _p$._v$19));
      _v$20 !== _p$._v$20 && (_p$._v$20 = libs.setProp(_el$73, "text", _v$20, _p$._v$20));
      return _p$;
    }, {
      _v$18: undefined,
      _v$19: undefined,
      _v$20: undefined
    });
    return _el$71;
  })();
}
function ParseTowerPreview(raw) {
  if (raw === undefined || raw.preview === undefined || raw.preview === "") {
    return undefined;
  }
  const grid = SafeParseJson(raw.preview, []);
  if (grid.length <= 0) {
    return undefined;
  }
  const baseGemRewards = SafeParseJson(raw.base_gem_rewards, {});
  const resultBaseGemRewards = {};
  for (const key in baseGemRewards) {
    const rarity = toFiniteNumber(key, -1);
    if (rarity > 0) {
      resultBaseGemRewards[rarity] = Math.max(0, Math.floor(toFiniteNumber(baseGemRewards[key], 0)));
    }
  }
  const originIndex = Math.floor(grid.length / 2);
  const originColumn = Math.floor((grid[originIndex]?.length ?? 0) / 2);
  return {
    matchID: raw.match_id,
    totalActionChance: Math.max(0, Math.floor(toFiniteNumber(raw.total_action_chance, 0))),
    baseGemRewards: resultBaseGemRewards,
    grid,
    originRow: originIndex,
    originColumn
  };
}
function SimulateSettlement(preview, actions) {
  const result = {
    isValid: true,
    remainingActionChance: preview.totalActionChance,
    anyCellChance: 0,
    doubleRewardsChance: 0,
    currentPosition: {
      row: preview.originRow,
      column: preview.originColumn
    },
    visitedKeySet: {
      [BuildCellKey(preview.originRow, preview.originColumn)]: true
    },
    resources: {
      ...EMPTY_RESOURCE_STATE
    },
    gemRewards: [],
    allGemRarityUp: false
  };
  const gemCounts = CloneGemCounts(preview.baseGemRewards);
  const perfectGems = [];
  for (let i = 0; i < actions.length; i++) {
    const action = actions[i];
    if (result.remainingActionChance <= 0) {
      result.isValid = false;
      result.invalidReason = "action_exhausted";
      break;
    }
    if (!IsInsideBoard(preview.grid, action.row, action.column)) {
      result.isValid = false;
      result.invalidReason = "action_out_of_range";
      break;
    }
    const actionKey = BuildCellKey(action.row, action.column);
    if (result.visitedKeySet[actionKey] === true) {
      result.isValid = false;
      result.invalidReason = "action_repeated";
      break;
    }
    if (result.anyCellChance > 0) {
      result.anyCellChance -= 1;
    } else if (!IsNeighbor(result.currentPosition, action)) {
      result.isValid = false;
      result.invalidReason = "action_not_neighbor";
      break;
    }
    result.remainingActionChance -= 1;
    result.visitedKeySet[actionKey] = true;
    result.currentPosition = {
      row: action.row,
      column: action.column
    };
    let rate = 1;
    if (result.doubleRewardsChance > 0) {
      rate = 2;
      result.doubleRewardsChance -= 1;
    }
    ReceiveCellReward(preview, action.row, action.column, rate, actions.length, result, gemCounts, perfectGems);
  }
  if (result.allGemRarityUp) {
    gemCounts[6] = (gemCounts[6] ?? 0) + (gemCounts[5] ?? 0);
    gemCounts[5] = 0;
  }
  result.gemRewards = BuildGemRewardList(gemCounts, perfectGems);
  return result;
}
function ReceiveCellReward(preview, row, column, rate, totalActions, result, gemCounts, perfectGems) {
  if (!IsInsideBoard(preview.grid, row, column)) {
    return;
  }
  const cell = preview.grid[row]?.[column];
  if (cell === undefined) {
    return;
  }
  switch (cell.grid_type) {
    case "cell_move_3":
      result.remainingActionChance += 3 * rate;
      result.doubleRewardsChance += 2 * rate;
      return;
    case "item_120011_200":
      result.resources.essence += 200 * rate;
      return;
    case "gem_all_lvup":
      result.allGemRarityUp = true;
      return;
    case "gain_cell_8":
      for (let nextRow = row - 1; nextRow <= row + 1; nextRow++) {
        for (let nextColumn = column - 1; nextColumn <= column + 1; nextColumn++) {
          if (nextRow === row && nextColumn === column) {
            continue;
          }
          ReceiveCellReward(preview, nextRow, nextColumn, rate, totalActions, result, gemCounts, perfectGems);
        }
      }
      return;
    case "gem_per_cell_1":
      gemCounts[6] = (gemCounts[6] ?? 0) + Math.floor(totalActions / 3) * rate;
      return;
    case "item_120012_1":
      result.resources.material += 1 * rate;
      return;
    case "gem_per_cell_2":
      gemCounts[5] = (gemCounts[5] ?? 0) + Math.floor(totalActions / 4) * rate;
      return;
    case "full_gem_1":
      if (cell.gem_detail !== undefined) {
        const embeddedGemData = BuildEmbeddedGemData(cell.gem_detail);
        const rarity = ResolvePerfectGemRarity(cell.gem_detail);
        for (let i = 0; i < rate; i++) {
          perfectGems.push({
            type: "perfect",
            detail: cell.gem_detail,
            embeddedGemData,
            rarity
          });
        }
      }
      return;
    case "gem_rarity_up":
      for (let i = 0; i < rate; i++) {
        if ((gemCounts[5] ?? 0) > 0) {
          gemCounts[5] -= 1;
          gemCounts[6] = (gemCounts[6] ?? 0) + 1;
        }
      }
      return;
    case "cell_move_2":
      result.remainingActionChance += 2 * rate;
      return;
    case "item_120011_50":
      result.resources.essence += 50 * rate;
      return;
    case "anycell":
      result.anyCellChance += 1 * rate;
      return;
    case "gem_rarity_6":
      gemCounts[6] = (gemCounts[6] ?? 0) + 1 * rate;
      return;
    case "double_cell":
      result.doubleRewardsChance += 1 * rate;
      return;
    case "item_120011_10":
      result.resources.essence += 10 * rate;
      return;
    case "cell_move_1":
      result.remainingActionChance += 1 * rate;
      return;
    case "gem_rarity_5":
      gemCounts[5] = (gemCounts[5] ?? 0) + 1 * rate;
      return;
    default:
      return;
  }
}
function PlayCellPickSound(gridType) {
  if (gridType === "gem_rarity_up" || gridType === "gem_all_lvup") {
    Game.EmitSound("UI.Pick.GemUp");
    return;
  }
  if (gridType === "anycell") {
    Game.EmitSound("UI.Pick.Anycell");
    return;
  }
  if (gridType.startsWith("item_")) {
    Game.EmitSound("UI.Pick.GemItem");
    return;
  }
  if (gridType.startsWith("gem_rarity_") || gridType.startsWith("gem_per_cell_") || gridType === "full_gem_1") {
    Game.EmitSound("UI.Pick.Gem");
  }
}
function BuildGemRewardList(gemCounts, perfectGems) {
  const result = [];
  const orderedRarities = Object.keys(gemCounts).map(key => toFiniteNumber(key, -1)).filter(rarity => rarity > 0).sort((a, b) => b - a);
  for (let i = 0; i < orderedRarities.length; i++) {
    const rarity = orderedRarities[i];
    const count = gemCounts[rarity] ?? 0;
    if (count > 0) {
      result.push({
        type: "quantity",
        rarity,
        count
      });
    }
  }
  for (let i = 0; i < perfectGems.length; i++) {
    result.push(perfectGems[i]);
  }
  return result;
}
function GetGridEffect(gridType) {
  if (gridType === "") {
    return undefined;
  }
  const list = Object.values(GameUI.CustomUIConfig().gem_drop_entry ?? {});
  for (let i = 0; i < list.length; i++) {
    if (list[i].effect_key === gridType) {
      return list[i];
    }
  }
  return undefined;
}
function ResolveCellRarity(gridType) {
  if (gridType === "") {
    return 0;
  }
  return GetGridEffect(gridType)?.rarity ?? 0;
}
function ResolvePerfectGemRarity(detail) {
  const gemInfo = KeyValues.gem?.[String(detail.gem_item_id)];
  return Math.max(3, toFiniteNumber(gemInfo?.rarity, 6));
}
function BuildEmbeddedGemData(detail) {
  return JSON.stringify({
    ...detail,
    main_entry_data: ParseGemEntries(detail.main_entry_data),
    adverb_entry_data: ParseGemEntries(detail.adverb_entry_data),
    ability_entry_data: ParseGemEntries(detail.ability_entry_data),
    myth_entry_data: ParseGemEntries(detail.myth_entry_data),
    chaos_entry_data: ParseGemEntries(detail.chaos_entry_data)
  });
}
function ParseGemEntries(raw) {
  return SafeParseJson(raw, []);
}
function CloneGemCounts(source) {
  const result = {};
  for (const key in source) {
    const rarity = toFiniteNumber(key, -1);
    if (rarity > 0) {
      result[rarity] = source[rarity] ?? 0;
    }
  }
  return result;
}
function GetVisitedOrder(actions, row, column) {
  for (let i = 0; i < actions.length; i++) {
    if (actions[i].row === row && actions[i].column === column) {
      return i + 1;
    }
  }
  return 0;
}
function BuildCellKey(row, column) {
  return `${row}:${column}`;
}
function IsNeighbor(a, b) {
  return Math.abs(a.row - b.row) + Math.abs(a.column - b.column) === 1;
}
function IsInsideBoard(grid, row, column) {
  return row >= 0 && row < grid.length && column >= 0 && column < (grid[row]?.length ?? 0);
}
function GetCellCenter(row, column) {
  return {
    x: column * GRID_CELL_SLOT_WIDTH + GRID_CELL_SLOT_WIDTH / 2,
    y: row * GRID_CELL_SLOT_HEIGHT + GRID_CELL_SLOT_HEIGHT / 2
  };
}
function SafeParseJson(raw, fallback) {
  if (raw === undefined || raw === "") {
    return fallback;
  }
  try {
    return JSON.parse(raw);
  } catch {
    return fallback;
  }
}
libs.render(() => libs.createComponent(GemSettlementHud, {}), $.GetContextPanel());