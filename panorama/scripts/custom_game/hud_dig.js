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
var EOM_Button = require('./EOM_Button.js');
var StoreItem = require('./StoreItem.js');
require('./service_netdata_helper.js');
require('./solid_utils.js');
require('./EOM_RedMark.js');
require('./EOM_Countdown.js');
require('./Player.js');
require('./EOM_TextEntry.js');
require('./equipment_utils.js');

const MINE_GRID_COLUMNS = 8;
const MINE_GRID_VISIBLE_ROWS = 5;
const MINE_GRID_PRELOAD_ROWS = 4;
const MINE_GRID_BUFFER_ROWS_BEFORE = 2;
const MINE_GRID_BUFFER_ROWS_AFTER = 4;
const MINE_GRID_CELL_STRIDE = 112;
const MINE_GRID_SCROLL_ANIMATION_DURATION = 0.35;
const TOOL_CURSOR_ICON_SIZE = 64;
const DIG_VEINS_DEPTH_PROGRESS_CURRENT = 1200;
const DIG_VEINS_DEPTH_PROGRESS_STAGES = [200, 400, 800, 1600, 3200, 6400];
function DigVeinsMineGridCell(prop) {
  const isDisabled = () => prop.disabled === true;
  return libs.createComponent(EOM_Button.EOM_BaseButton, {
    get ["class"]() {
      return libs.classNames("DigVeinsMineGridCell", prop.class, {
        Disabled: isDisabled()
      });
    },
    get enabled() {
      return !isDisabled();
    },
    onmouseover: () => {
      if (isDisabled()) {
        return;
      }
    },
    onmouseout: () => {
      if (isDisabled()) {
        return;
      }
    },
    onactivate: () => {
      if (isDisabled()) {
        return;
      }
      const tool = prop.tool;
      if (tool == undefined) {
        return;
      }
      prop.oncellactivate?.(prop.index, tool);
    },
    get children() {
      return [libs.createElement("Panel", {
        "class": "DigVeinsMineGridCellHover",
        hittest: false
      }, null), libs.createElement("Panel", {
        "class": "DigVeinsMineGridCellSelected",
        hittest: false
      }, null), libs.createElement("Panel", {
        "class": "DigVeinsMineGridCellDisabled",
        hittest: false
      }, null)];
    }
  });
}
function DigVeinsTaskTaskItem() {
  return (() => {
    const _el$4 = libs.createElement("Panel", {
        "class": "DigVeinsTaskTaskItem"
      }, null),
      _el$5 = libs.createElement("Panel", {
        "class": "DigVeinsTaskItemContent"
      }, _el$4),
      _el$6 = libs.createElement("Panel", {
        "class": "DigVeinsTaskTitle"
      }, _el$5);
      libs.createElement("Label", {
        "class": "DigVeinsTaskTitleText",
        text: "TaskName1"
      }, _el$6);
      libs.createElement("Label", {
        "class": "DigVeinsTaskTitleValue",
        text: "(0/10)"
      }, _el$6);
      libs.createElement("Label", {
        "class": "DigVeinsTaskItemDescription",
        text: "Task description here"
      }, _el$5);
      const _el$0 = libs.createElement("Panel", {
        "class": "DigVeinsTaskItemReward"
      }, _el$4);
      libs.createElement("Image", {
        "class": "DigVeinsTaskItemBottomLine"
      }, _el$4);
    libs.insert(_el$0, libs.createComponent(StoreItem.StoreItemBlock, {
      item_id: 110002,
      amounts: 1
    }));
    return _el$4;
  })();
}
function DigVeinsTaskContainer() {
  return (() => {
    const _el$10 = libs.createElement("Panel", {
        "class": "DigVeinsTaskContainer"
      }, null),
      _el$11 = libs.createElement("Panel", {
        "class": "DigVeinsTaskHeader"
      }, _el$10);
      libs.createElement("Image", {
        "class": "DigVeinsTaskHeaderBG"
      }, _el$11);
      libs.createElement("Label", {
        "class": "DigVeinsTaskTaskTitle",
        text: "#DigVeins_TaskTitle_DailyTask"
      }, _el$11);
      const _el$14 = libs.createElement("Panel", {
        "class": "DigVeinsTaskTaskContent"
      }, _el$10);
    libs.insert(_el$14, libs.createComponent(DigVeinsTaskTaskItem, {}), null);
    libs.insert(_el$14, libs.createComponent(DigVeinsTaskTaskItem, {}), null);
    libs.insert(_el$14, libs.createComponent(DigVeinsTaskTaskItem, {}), null);
    return _el$10;
  })();
}
function DigVeinsDepthProgressBar(prop) {
  const progressPercent = libs.createMemo(() => {
    const span = Math.max(1, prop.toDepth - prop.fromDepth);
    const progress = Math.max(0, Math.min(prop.currentDepth - prop.fromDepth, span));
    return progress / span * 100;
  });
  return (() => {
    const _el$15 = libs.createElement("Panel", {
        "class": "DigVeinsDepthProgressItem DigVeinsDepthProgressBarItemBar"
      }, null),
      _el$16 = libs.createElement("Panel", {
        "class": "DigVeinsDepthProgressBar"
      }, _el$15);
      libs.createElement("Image", {
        "class": "DigVeinsDepthProgressBarBG"
      }, _el$16);
      const _el$18 = libs.createElement("Panel", {
        "class": "DigVeinsDepthProgressBarFillClip",
        get style() {
          return {
            height: `${progressPercent()}%`
          };
        }
      }, _el$16);
      libs.createElement("Image", {
        "class": "DigVeinsDepthProgressBarFill"
      }, _el$18);
    libs.effect(_$p => libs.setProp(_el$18, "style", {
      height: `${progressPercent()}%`
    }, _$p));
    return _el$15;
  })();
}
function DigVeinsDepthProgressBox(prop) {
  libs.createMemo(() => {
    const span = Math.max(1, prop.toDepth - prop.fromDepth);
    const progress = Math.max(0, Math.min(prop.currentDepth - prop.fromDepth, span));
    return progress / span * 100;
  });
  return (() => {
    const _el$20 = libs.createElement("Panel", {
        "class": "DigVeinsDepthProgressItem DigVeinsDepthProgressItemBox"
      }, null);
      libs.createElement("Panel", {
        "class": "DigVeinsDepthProgressBar"
      }, _el$20);
      const _el$22 = libs.createElement("Panel", {
        "class": "DigVeinsDepthProgressBox"
      }, _el$20);
      libs.createElement("Image", {
        "class": "DigVeinsDepthProgressBoxIcon"
      }, _el$22);
      const _el$24 = libs.createElement("Panel", {
        "class": "DigVeinsDepthProgressBoxValueContent"
      }, _el$22);
      libs.createElement("Panel", {
        "class": "DigVeinsDepthProgressBoxValueBG"
      }, _el$24);
      const _el$26 = libs.createElement("Label", {
        "class": "DigVeinsDepthProgressBoxValue",
        get text() {
          return `${prop.toDepth}`;
        }
      }, _el$24);
    libs.effect(_$p => libs.setProp(_el$26, "text", `${prop.toDepth}`, _$p));
    return _el$20;
  })();
}
function DigVeinsDepthProgress() {
  const progressStages = libs.createMemo(() => DIG_VEINS_DEPTH_PROGRESS_STAGES.map((toDepth, index) => ({
    fromDepth: index === 0 ? 0 : DIG_VEINS_DEPTH_PROGRESS_STAGES[index - 1],
    toDepth
  })));
  return [(() => {
    const _el$27 = libs.createElement("Panel", {
      id: "DigVeinsDepthProgressContent"
    }, null);
    libs.insert(_el$27, libs.createComponent(libs.For, {
      get each() {
        return progressStages();
      },
      children: stage => libs.createComponent(DigVeinsDepthProgressBar, {
        get fromDepth() {
          return stage.fromDepth;
        },
        get toDepth() {
          return stage.toDepth;
        },
        currentDepth: DIG_VEINS_DEPTH_PROGRESS_CURRENT
      })
    }));
    return _el$27;
  })(), (() => {
    const _el$28 = libs.createElement("Panel", {
      id: "DigVeinsDepthProgressContent"
    }, null);
    libs.insert(_el$28, libs.createComponent(libs.For, {
      get each() {
        return progressStages();
      },
      children: stage => libs.createComponent(DigVeinsDepthProgressBox, {
        get fromDepth() {
          return stage.fromDepth;
        },
        get toDepth() {
          return stage.toDepth;
        },
        currentDepth: DIG_VEINS_DEPTH_PROGRESS_CURRENT
      })
    }));
    return _el$28;
  })(), libs.createElement("Panel", {
    id: "DigVeinsDepthProgressBottomFade",
    hittest: false
  }, null), (() => {
    const _el$30 = libs.createElement("Panel", {
        id: "DigVeinsDepthProgressTitle"
      }, null);
      libs.createElement("Image", {
        id: "DigVeinsDepthProgressTitleBG"
      }, _el$30);
      libs.createElement("Label", {
        id: "DigVeinsDepthProgressTitleTag",
        text: "Depth"
      }, _el$30);
      const _el$33 = libs.createElement("Label", {
        id: "DigVeinsDepthProgressTitleValue",
        text: `${DIG_VEINS_DEPTH_PROGRESS_CURRENT}M`
      }, _el$30);
    libs.setProp(_el$33, "text", `${DIG_VEINS_DEPTH_PROGRESS_CURRENT}M`);
    return _el$30;
  })()];
}
function DigVeins() {
  const [selectedCellIndex, setSelectedCellIndex] = libs.createSignal();
  const [equippedTool, setEquippedTool] = libs.createSignal();
  const [mineGridBottomRow, setMineGridBottomRow] = libs.createSignal(MINE_GRID_VISIBLE_ROWS - 1);
  const [renderStartRow, setRenderStartRow] = libs.createSignal(0);
  const [renderEndRow, setRenderEndRow] = libs.createSignal(MINE_GRID_VISIBLE_ROWS + MINE_GRID_BUFFER_ROWS_AFTER - 1);
  const [mineGridScrollOffset, setMineGridScrollOffset] = libs.createSignal(0);
  const [mineGridTransitionDisabled, setMineGridTransitionDisabled] = libs.createSignal(false);
  const [mineGridScrolling, setMineGridScrolling] = libs.createSignal(false);
  let cursorPanel;
  let mineGridTrimScheduleId;
  const getVisibleStartRow = bottomRow => Math.max(0, bottomRow - MINE_GRID_VISIBLE_ROWS + 1);
  const getTrimmedRenderStartRow = bottomRow => Math.max(0, getVisibleStartRow(bottomRow) - MINE_GRID_BUFFER_ROWS_BEFORE);
  const getRenderEndRow = bottomRow => bottomRow + MINE_GRID_BUFFER_ROWS_AFTER;
  const getScrollOffset = (bottomRow, startRow) => Math.max(0, (getVisibleStartRow(bottomRow) - startRow) * MINE_GRID_CELL_STRIDE);
  const mineGridCellIndexes = libs.createMemo(() => {
    const startRow = renderStartRow();
    const rowCount = Math.max(0, renderEndRow() - startRow + 1);
    return Array.from({
      length: rowCount * MINE_GRID_COLUMNS
    }).map((_, localIndex) => {
      const row = startRow + Math.floor(localIndex / MINE_GRID_COLUMNS);
      const column = localIndex % MINE_GRID_COLUMNS;
      return row * MINE_GRID_COLUMNS + column;
    });
  });
  const cancelMineGridTrimSchedule = () => {
    if (mineGridTrimScheduleId == undefined) {
      return;
    }
    try {
      $.CancelScheduled(mineGridTrimScheduleId);
    } catch (error) {}
    mineGridTrimScheduleId = undefined;
  };
  const scheduleMineGridTrim = bottomRow => {
    cancelMineGridTrimSchedule();
    mineGridTrimScheduleId = $.Schedule(MINE_GRID_SCROLL_ANIMATION_DURATION, () => {
      const nextRenderStartRow = getTrimmedRenderStartRow(bottomRow);
      setMineGridTransitionDisabled(true);
      setRenderStartRow(nextRenderStartRow);
      setRenderEndRow(getRenderEndRow(bottomRow));
      setMineGridScrollOffset(getScrollOffset(bottomRow, nextRenderStartRow));
      setMineGridScrolling(false);
      mineGridTrimScheduleId = undefined;
      $.Schedule(0, () => setMineGridTransitionDisabled(false));
    });
  };
  const destroyCursorPanel = () => {
    if (cursorPanel != undefined && cursorPanel.IsValid()) {
      cursorPanel.DeleteAsync(-1);
    }
    cursorPanel = undefined;
  };
  const resetEquippedTool = () => {
    setEquippedTool(undefined);
    destroyCursorPanel();
  };
  const createCursorPanel = tool => {
    destroyCursorPanel();
    const panel = $.CreatePanel("Panel", $.GetContextPanel(), "DigVeinsEquippedToolCursor");
    panel.hittest = false;
    panel.AddClass(tool);
    cursorPanel = panel;
    libs.render(() => {
      return libs.createElement("Panel", {
        "class": "DigVeinsEquippedToolCursorIcon",
        hittest: false
      }, null);
    }, panel);
  };
  const updateCursorPosition = () => {
    if (cursorPanel == undefined || !cursorPanel.IsValid()) {
      return;
    }
    const cursor = GameUI.GetCursorPosition();
    const parent = cursorPanel.GetParent();
    const parentPosition = parent?.GetPositionWithinWindow();
    const scaleX = parent?.actualuiscale_x ?? cursorPanel.actualuiscale_x ?? 1;
    const scaleY = parent?.actualuiscale_y ?? cursorPanel.actualuiscale_y ?? 1;
    const parentX = parentPosition?.x ?? 0;
    const parentY = parentPosition?.y ?? 0;
    cursorPanel.SetPositionInPixels((cursor[0] - parentX - TOOL_CURSOR_ICON_SIZE * 0.5) / scaleX, (cursor[1] - parentY - TOOL_CURSOR_ICON_SIZE * 0.5) / scaleY, 0);
  };
  const equipTool = tool => {
    setEquippedTool(tool);
    createCursorPanel(tool);
    $.Schedule(0, updateCursorPosition);
  };
  const handleCellActivate = (index, tool) => {
    if (mineGridScrolling()) {
      return;
    }
    $.Msg(`[DigVeins] activate cell index=${index} tool=${tool}`);
    setSelectedCellIndex(index);
    const nextBottomRow = mineGridBottomRow() + MINE_GRID_PRELOAD_ROWS;
    const currentRenderStartRow = renderStartRow();
    setMineGridScrolling(true);
    setMineGridBottomRow(nextBottomRow);
    setRenderEndRow(getRenderEndRow(nextBottomRow));
    setMineGridScrollOffset(getScrollOffset(nextBottomRow, currentRenderStartRow));
    scheduleMineGridTrim(nextBottomRow);
  };
  libs.onMount(() => {
    resetEquippedTool();
    const timer = setInterval(() => {
      if (equippedTool() == undefined) {
        return;
      }
      updateCursorPosition();
    }, 10);
    libs.onCleanup(() => {
      clearInterval(timer);
      cancelMineGridTrimSchedule();
      resetEquippedTool();
    });
  });
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
    id: "DigVeinsRoot",
    get children() {
      return [libs.createElement("Image", {
        id: "DigVeinsBG"
      }, null), (() => {
        const _el$36 = libs.createElement("Panel", {
            id: "DigVeinsContainer",
            hittest: true
          }, null),
          _el$37 = libs.createElement("Panel", {
            id: "DigVeinsHeaderRight"
          }, _el$36),
          _el$40 = libs.createElement("Panel", {
            id: "DigVeinsDepthProgress"
          }, _el$36),
          _el$41 = libs.createElement("Panel", {
            id: "DigVeinsMainPage"
          }, _el$36),
          _el$42 = libs.createElement("Panel", {
            id: "DigVeinsTopContainer",
            hittest: false
          }, _el$41);
          libs.createElement("Image", {
            id: "DigVeinsTitleImage"
          }, _el$42);
          const _el$44 = libs.createElement("Panel", {
            id: "DigVeinsHeaderTime"
          }, _el$42);
          libs.createElement("Panel", {
            id: "DigVeinsHeaderTimeBG"
          }, _el$44);
          const _el$46 = libs.createElement("Panel", {
            id: "DigVeinsHeaderTimeContent"
          }, _el$44);
          libs.createElement("Image", {
            id: "DigVeinsHeaderTimeIcon"
          }, _el$46);
          libs.createElement("Label", {
            id: "DigVeinsHeaderTime",
            text: "11d 10h 33min"
          }, _el$46);
          const _el$49 = libs.createElement("Panel", {
            id: "DigVeinsCoreContainer"
          }, _el$41);
          libs.createElement("Image", {
            id: "DigVeinsCoreBG"
          }, _el$49);
          const _el$51 = libs.createElement("Panel", {
            id: "DigVeinsMineGridViewport"
          }, _el$49),
          _el$52 = libs.createElement("Panel", {
            id: "DigVeinsMineGridCellContainer",
            get style() {
              return {
                transform: `translateY(${-mineGridScrollOffset()}px)`
              };
            }
          }, _el$51),
          _el$53 = libs.createElement("Panel", {
            id: "DigVeinsToolBar"
          }, _el$49),
          _el$54 = libs.createElement("Panel", {
            "class": "DigVeinsToolItem Bomb"
          }, _el$53),
          _el$56 = libs.createElement("Panel", {
            "class": "DigVeinsToolItem Pickaxe"
          }, _el$53),
          _el$60 = libs.createElement("Panel", {
            "class": "DigVeinsToolItem Drill"
          }, _el$53),
          _el$62 = libs.createElement("Panel", {
            id: "DigDepthLine"
          }, _el$49);
          libs.createElement("Label", {
            id: "DigDepthLineLabel",
            text: "453m"
          }, _el$62);
          libs.createElement("Image", {
            id: "DigDepthLineIcon"
          }, _el$62);
          const _el$65 = libs.createElement("Panel", {
            id: "DigVeinsTaskPanel",
            scroll: "y"
          }, _el$36);
        libs.setProp(_el$36, "oncontextmenu", resetEquippedTool);
        libs.insert(_el$37, libs.createComponent(EOM_Button.EOM_BaseButton, {
          "class": "DigVeinsHeaderButton DigVeinsHeaderRank",
          get children() {
            return libs.createElement("Label", {
              text: "#DigVeins_Header_Rank"
            }, null);
          }
        }), null);
        libs.insert(_el$37, libs.createComponent(EOM_Button.EOM_BaseButton, {
          "class": "DigVeinsHeaderButton DigVeinsHeaderRule",
          get children() {
            return libs.createElement("Label", {
              text: "#DigVeins_Header_Rule"
            }, null);
          }
        }), null);
        libs.insert(_el$40, libs.createComponent(DigVeinsDepthProgress, {}));
        libs.insert(_el$52, libs.createComponent(libs.For, {
          get each() {
            return mineGridCellIndexes();
          },
          children: index => libs.createComponent(DigVeinsMineGridCell, {
            index: index,
            "class": `OreVariant${index % 5}`,
            get selected() {
              return selectedCellIndex() === index;
            },
            disabled: index % 13 === 0,
            get tool() {
              return equippedTool();
            },
            oncellactivate: handleCellActivate
          })
        }));
        libs.insert(_el$54, libs.createComponent(EOM_Button.EOM_BaseButton, {
          get ["class"]() {
            return libs.classNames("DigVeinsToolButton", "Bomb", {
              Selected: equippedTool() === "Bomb"
            });
          },
          onactivate: () => equipTool("Bomb"),
          oncontextmenu: resetEquippedTool,
          get children() {
            return libs.createElement("Image", {
              "class": "DigVeinsToolButtonIcon",
              hittest: false
            }, null);
          }
        }));
        libs.insert(_el$56, libs.createComponent(EOM_Button.EOM_BaseButton, {
          "class": "DigVeinsToolOption DigVeinsToolOptionSub",
          onactivate: () => {},
          get children() {
            return libs.createElement("Image", {
              "class": "DigVeinsToolOptionIcon",
              hittest: false
            }, null);
          }
        }), null);
        libs.insert(_el$56, libs.createComponent(EOM_Button.EOM_BaseButton, {
          get ["class"]() {
            return libs.classNames("DigVeinsToolButton", "Pickaxe", {
              Selected: equippedTool() === "Pickaxe"
            });
          },
          onactivate: () => equipTool("Pickaxe"),
          oncontextmenu: resetEquippedTool,
          get children() {
            return libs.createElement("Image", {
              "class": "DigVeinsToolButtonIcon",
              hittest: false
            }, null);
          }
        }), null);
        libs.insert(_el$56, libs.createComponent(EOM_Button.EOM_BaseButton, {
          "class": "DigVeinsToolOption DigVeinsToolOptionAdd",
          onactivate: () => {},
          get children() {
            return libs.createElement("Image", {
              "class": "DigVeinsToolOptionIcon",
              hittest: false
            }, null);
          }
        }), null);
        libs.insert(_el$60, libs.createComponent(EOM_Button.EOM_BaseButton, {
          get ["class"]() {
            return libs.classNames("DigVeinsToolButton", "Drill", {
              Selected: equippedTool() === "Drill"
            });
          },
          onactivate: () => equipTool("Drill"),
          oncontextmenu: resetEquippedTool,
          get children() {
            return libs.createElement("Image", {
              "class": "DigVeinsToolButtonIcon",
              hittest: false
            }, null);
          }
        }));
        libs.setProp(_el$65, "scroll", "y");
        libs.insert(_el$65, libs.createComponent(DigVeinsTaskContainer, {}), null);
        libs.insert(_el$65, libs.createComponent(DigVeinsTaskContainer, {}), null);
        libs.effect(_p$ => {
          const _v$ = {
              NoTransition: mineGridTransitionDisabled()
            },
            _v$2 = {
              transform: `translateY(${-mineGridScrollOffset()}px)`
            };
          _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$52, "classList", _v$, _p$._v$));
          _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$52, "style", _v$2, _p$._v$2));
          return _p$;
        }, {
          _v$: undefined,
          _v$2: undefined
        });
        return _el$36;
      })()];
    }
  });
}

const MENU_LIST = {
  DigVeins: ["SubMenu_DigVeins", "SubMenu_DigVeins_Store"]
};
const {
  LayoutMenu,
  show,
  secondTabName,
  menuName
} = EOM_MenuLayout.createMenuLayout("dig_veins", () => MENU_LIST);
function HUDDigVeins() {
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout, {
    id: "HUDDigVeinsRoot",
    name: "MenuButton_dig_veins",
    renderOnShow: true,
    get show() {
      return show();
    },
    get children() {
      return [libs.createComponent(LayoutMenu, {}), libs.createComponent(libs.Switch, {
        get children() {
          return libs.createComponent(libs.Match, {
            get when() {
              return secondTabName() == "SubMenu_DigVeins";
            },
            get children() {
              return libs.createComponent(DigVeins, {});
            }
          });
        }
      })];
    }
  });
}
libs.render(() => libs.createComponent(HUDDigVeins, {}), $.GetContextPanel());