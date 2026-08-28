--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var solid_utils = require('./solid_utils.js');

const EMPTY_SNAPSHOT = {
  sequence: 0,
  updatedAt: 0,
  windowSeconds: 1,
  systems: {}
};
const LEVEL_META = {
  idle: {
    text: "空闲",
    color: "#7f8aa9",
    bg: "#1a2030"
  },
  ok: {
    text: "稳定",
    color: "#64d98b",
    bg: "#173021"
  },
  warn: {
    text: "偏热",
    color: "#f0c35b",
    bg: "#352b15"
  },
  hot: {
    text: "热点",
    color: "#ff6b76",
    bg: "#3a1920"
  }
};
const MODE_LABELS = {
  avg: "平均耗时",
  max: "峰值耗时",
  calls: "调用次数"
};
function formatMs(value) {
  if (value < 0.01) {
    return "0.00ms";
  }
  if (value < 10) {
    return value.toFixed(2) + "ms";
  }
  return value.toFixed(1) + "ms";
}
function formatCount(value) {
  if (value >= 10000) {
    return (value / 10000).toFixed(1) + "w";
  }
  if (value >= 1000) {
    return (value / 1000).toFixed(1) + "k";
  }
  return String(Math.floor(value));
}
function formatClock(gameTime) {
  const seconds = Math.max(0, Math.floor(gameTime));
  const minutes = Math.floor(seconds / 60);
  const rest = seconds % 60;
  return String(minutes).padStart(2, "0") + ":" + String(rest).padStart(2, "0");
}
function getModeValue(metric, mode) {
  if (mode === "avg") {
    return metric.avgMs;
  }
  if (mode === "max") {
    return metric.maxMs;
  }
  return metric.calls;
}
function formatModeValue(metric, mode) {
  if (mode === "calls") {
    return formatCount(metric.calls);
  }
  return formatMs(getModeValue(metric, mode));
}
function buildMetricViews(metrics, mode) {
  const sorted = [...metrics].sort((left, right) => getModeValue(right, mode) - getModeValue(left, mode));
  let maxValue = 0;
  for (let i = 0; i < sorted.length; i++) {
    maxValue = Math.max(maxValue, getModeValue(sorted[i], mode));
  }
  return sorted.map(metric => {
    const meta = LEVEL_META[metric.level] ?? LEVEL_META.idle;
    const value = getModeValue(metric, mode);
    return {
      ...metric,
      value,
      share: maxValue > 0 ? Math.max(4, Math.round(value / maxValue * 100)) : 0,
      color: meta.color,
      backgroundColor: meta.bg,
      levelText: meta.text
    };
  });
}
function MetricModeButton(props) {
  return (() => {
    const _el$ = libs.createElement("Button", {
        "class": "PerfModeButton"
      }, null),
      _el$2 = libs.createElement("Label", {
        get text() {
          return MODE_LABELS[props.mode];
        }
      }, _el$);
    libs.setProp(_el$, "onactivate", () => props.onSelect(props.mode));
    libs.effect(_p$ => {
      const _v$ = {
          Active: props.current === props.mode
        },
        _v$2 = MODE_LABELS[props.mode];
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$, "classList", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$2, "text", _v$2, _p$._v$2));
      return _p$;
    }, {
      _v$: undefined,
      _v$2: undefined
    });
    return _el$;
  })();
}
function SummaryChip(props) {
  return (() => {
    const _el$3 = libs.createElement("Panel", {
        get ["class"]() {
          return "PerfSummaryChip " + props.accent;
        }
      }, null),
      _el$4 = libs.createElement("Label", {
        "class": "PerfSummaryValue",
        get text() {
          return props.value;
        }
      }, _el$3),
      _el$5 = libs.createElement("Label", {
        "class": "PerfSummaryLabel",
        get text() {
          return props.label;
        }
      }, _el$3);
    libs.effect(_p$ => {
      const _v$3 = "PerfSummaryChip " + props.accent,
        _v$4 = props.value,
        _v$5 = props.label;
      _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$3, "class", _v$3, _p$._v$3));
      _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$4, "text", _v$4, _p$._v$4));
      _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$5, "text", _v$5, _p$._v$5));
      return _p$;
    }, {
      _v$3: undefined,
      _v$4: undefined,
      _v$5: undefined
    });
    return _el$3;
  })();
}
function MetricRow(props) {
  return (() => {
    const _el$6 = libs.createElement("Button", {
        "class": "PerfMetricRow",
        get onactivate() {
          return props.onSelect;
        }
      }, null),
      _el$7 = libs.createElement("Panel", {
        "class": "PerfMetricTop"
      }, _el$6),
      _el$8 = libs.createElement("Panel", {
        "class": "PerfMetricInfo"
      }, _el$7),
      _el$9 = libs.createElement("Label", {
        "class": "PerfMetricName",
        get text() {
          return props.metric.label;
        }
      }, _el$8),
      _el$0 = libs.createElement("Label", {
        "class": "PerfMetricGroup",
        get text() {
          return props.metric.group + " · " + props.metric.key;
        }
      }, _el$8),
      _el$1 = libs.createElement("Panel", {
        "class": "PerfMetricValueWrap"
      }, _el$7),
      _el$10 = libs.createElement("Label", {
        "class": "PerfMetricValue",
        get text() {
          return formatModeValue(props.metric, props.mode);
        },
        get style() {
          return {
            color: props.metric.color
          };
        }
      }, _el$1),
      _el$11 = libs.createElement("Panel", {
        "class": "PerfLevelPill",
        get style() {
          return {
            backgroundColor: props.metric.backgroundColor,
            borderColor: props.metric.color
          };
        }
      }, _el$1),
      _el$12 = libs.createElement("Label", {
        get text() {
          return props.metric.levelText;
        },
        get style() {
          return {
            color: props.metric.color
          };
        }
      }, _el$11),
      _el$13 = libs.createElement("Panel", {
        "class": "PerfMetricBarTrack"
      }, _el$6),
      _el$14 = libs.createElement("Panel", {
        "class": "PerfMetricBarFill",
        get style() {
          return {
            width: props.metric.share + "%",
            backgroundColor: props.metric.color
          };
        }
      }, _el$13);
    libs.effect(_p$ => {
      const _v$6 = {
          Active: props.selected
        },
        _v$7 = props.onSelect,
        _v$8 = props.metric.label,
        _v$9 = props.metric.group + " · " + props.metric.key,
        _v$0 = formatModeValue(props.metric, props.mode),
        _v$1 = {
          color: props.metric.color
        },
        _v$10 = {
          backgroundColor: props.metric.backgroundColor,
          borderColor: props.metric.color
        },
        _v$11 = props.metric.levelText,
        _v$12 = {
          color: props.metric.color
        },
        _v$13 = {
          width: props.metric.share + "%",
          backgroundColor: props.metric.color
        };
      _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$6, "classList", _v$6, _p$._v$6));
      _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$6, "onactivate", _v$7, _p$._v$7));
      _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$9, "text", _v$8, _p$._v$8));
      _v$9 !== _p$._v$9 && (_p$._v$9 = libs.setProp(_el$0, "text", _v$9, _p$._v$9));
      _v$0 !== _p$._v$0 && (_p$._v$0 = libs.setProp(_el$10, "text", _v$0, _p$._v$0));
      _v$1 !== _p$._v$1 && (_p$._v$1 = libs.setProp(_el$10, "style", _v$1, _p$._v$1));
      _v$10 !== _p$._v$10 && (_p$._v$10 = libs.setProp(_el$11, "style", _v$10, _p$._v$10));
      _v$11 !== _p$._v$11 && (_p$._v$11 = libs.setProp(_el$12, "text", _v$11, _p$._v$11));
      _v$12 !== _p$._v$12 && (_p$._v$12 = libs.setProp(_el$12, "style", _v$12, _p$._v$12));
      _v$13 !== _p$._v$13 && (_p$._v$13 = libs.setProp(_el$14, "style", _v$13, _p$._v$13));
      return _p$;
    }, {
      _v$6: undefined,
      _v$7: undefined,
      _v$8: undefined,
      _v$9: undefined,
      _v$0: undefined,
      _v$1: undefined,
      _v$10: undefined,
      _v$11: undefined,
      _v$12: undefined,
      _v$13: undefined
    });
    return _el$6;
  })();
}
function DetailPanel(props) {
  return (() => {
    const _el$15 = libs.createElement("Panel", {
      "class": "PerfDetailPanel"
    }, null);
    libs.insert(_el$15, libs.createComponent(libs.Show, {
      get when() {
        return props.metric !== undefined;
      },
      get fallback() {
        return (() => {
          const _el$27 = libs.createElement("Panel", {
              "class": "PerfEmptyState"
            }, null);
            libs.createElement("Label", {
              "class": "PerfEmptyTitle",
              text: "等待性能快照"
            }, _el$27);
            libs.createElement("Label", {
              "class": "PerfEmptyDesc",
              text: "打开调试开关后，后端会每秒同步各系统采样。"
            }, _el$27);
          return _el$27;
        })();
      },
      get children() {
        return [(() => {
          const _el$16 = libs.createElement("Panel", {
              "class": "PerfDetailHeader"
            }, null),
            _el$17 = libs.createElement("Panel", {
              "class": "PerfDetailTitleBlock"
            }, _el$16),
            _el$18 = libs.createElement("Label", {
              "class": "PerfDetailTitle",
              get text() {
                return props.metric?.label ?? "-";
              }
            }, _el$17),
            _el$19 = libs.createElement("Label", {
              "class": "PerfDetailSub",
              get text() {
                return (props.metric?.group ?? "-") + " · " + (props.metric?.key ?? "-");
              }
            }, _el$17),
            _el$20 = libs.createElement("Panel", {
              "class": "PerfDetailBadge",
              get style() {
                return {
                  backgroundColor: props.metric?.backgroundColor,
                  borderColor: props.metric?.color
                };
              }
            }, _el$16),
            _el$21 = libs.createElement("Label", {
              get text() {
                return props.metric?.levelText ?? "-";
              },
              get style() {
                return {
                  color: props.metric?.color
                };
              }
            }, _el$20);
          libs.effect(_p$ => {
            const _v$14 = props.metric?.label ?? "-",
              _v$15 = (props.metric?.group ?? "-") + " · " + (props.metric?.key ?? "-"),
              _v$16 = {
                backgroundColor: props.metric?.backgroundColor,
                borderColor: props.metric?.color
              },
              _v$17 = props.metric?.levelText ?? "-",
              _v$18 = {
                color: props.metric?.color
              };
            _v$14 !== _p$._v$14 && (_p$._v$14 = libs.setProp(_el$18, "text", _v$14, _p$._v$14));
            _v$15 !== _p$._v$15 && (_p$._v$15 = libs.setProp(_el$19, "text", _v$15, _p$._v$15));
            _v$16 !== _p$._v$16 && (_p$._v$16 = libs.setProp(_el$20, "style", _v$16, _p$._v$16));
            _v$17 !== _p$._v$17 && (_p$._v$17 = libs.setProp(_el$21, "text", _v$17, _p$._v$17));
            _v$18 !== _p$._v$18 && (_p$._v$18 = libs.setProp(_el$21, "style", _v$18, _p$._v$18));
            return _p$;
          }, {
            _v$14: undefined,
            _v$15: undefined,
            _v$16: undefined,
            _v$17: undefined,
            _v$18: undefined
          });
          return _el$16;
        })(), (() => {
          const _el$22 = libs.createElement("Panel", {
            "class": "PerfDetailStats"
          }, null);
          libs.insert(_el$22, libs.createComponent(SummaryChip, {
            label: "平均耗时",
            get value() {
              return formatMs(props.metric?.avgMs ?? 0);
            },
            accent: "Green"
          }), null);
          libs.insert(_el$22, libs.createComponent(SummaryChip, {
            label: "峰值耗时",
            get value() {
              return formatMs(props.metric?.maxMs ?? 0);
            },
            get accent() {
              return (props.metric?.level ?? "idle") === "hot" ? "Red" : "Gold";
            }
          }), null);
          libs.insert(_el$22, libs.createComponent(SummaryChip, {
            label: "调用次数",
            get value() {
              return formatCount(props.metric?.calls ?? 0);
            },
            accent: "Green"
          }), null);
          return _el$22;
        })(), (() => {
          const _el$23 = libs.createElement("Panel", {
              "class": "PerfDetailFooter"
            }, null),
            _el$24 = libs.createElement("Label", {
              get text() {
                return "最近一次 " + formatMs(props.metric?.lastMs ?? 0);
              }
            }, _el$23),
            _el$25 = libs.createElement("Label", {
              get text() {
                return "样本 " + formatCount(props.metric?.samples ?? 0);
              }
            }, _el$23),
            _el$26 = libs.createElement("Label", {
              get text() {
                return "当前排序 " + MODE_LABELS[props.mode];
              }
            }, _el$23);
          libs.effect(_p$ => {
            const _v$19 = "最近一次 " + formatMs(props.metric?.lastMs ?? 0),
              _v$20 = "样本 " + formatCount(props.metric?.samples ?? 0),
              _v$21 = "当前排序 " + MODE_LABELS[props.mode];
            _v$19 !== _p$._v$19 && (_p$._v$19 = libs.setProp(_el$24, "text", _v$19, _p$._v$19));
            _v$20 !== _p$._v$20 && (_p$._v$20 = libs.setProp(_el$25, "text", _v$20, _p$._v$20));
            _v$21 !== _p$._v$21 && (_p$._v$21 = libs.setProp(_el$26, "text", _v$21, _p$._v$21));
            return _p$;
          }, {
            _v$19: undefined,
            _v$20: undefined,
            _v$21: undefined
          });
          return _el$23;
        })()];
      }
    }));
    return _el$15;
  })();
}
function PerformanceHeatmap() {
  const snapshotSignal = solid_utils.createNetDataSignal("common", "performance_heatmap", EMPTY_SNAPSHOT);
  const snapshot = libs.createMemo(() => snapshotSignal());
  const [collapsed, setCollapsed] = libs.createSignal(true);
  const [mode, setMode] = libs.createSignal("avg");
  const [selectedKey, setSelectedKey] = libs.createSignal(undefined);
  const metricViews = libs.createMemo(() => {
    const raw = Object.values(snapshot().systems);
    const views = buildMetricViews(raw, mode());
    if (views.length > 0 && selectedKey() === undefined) {
      setSelectedKey(views[0].key);
    }
    return views;
  });
  const selectedMetric = libs.createMemo(() => {
    const key = selectedKey();
    const metrics = metricViews();
    for (let i = 0; i < metrics.length; i++) {
      if (metrics[i].key === key) {
        return metrics[i];
      }
    }
    return metrics[0];
  });
  const hotCount = libs.createMemo(() => metricViews().filter(metric => metric.level === "hot").length);
  const warnCount = libs.createMemo(() => metricViews().filter(metric => metric.level === "warn").length);
  const statusText = libs.createMemo(() => {
    if (snapshot().sequence <= 0) {
      return "等待后端快照";
    }
    return "Seq " + snapshot().sequence + " · " + formatClock(snapshot().updatedAt);
  });
  return (() => {
    const _el$30 = libs.createElement("Panel", {
        id: "PerformanceHeatmapRoot",
        hittest: false
      }, null),
      _el$31 = libs.createElement("Panel", {
        id: "PerformanceHeatmapDock",
        hittest: false
      }, _el$30),
      _el$32 = libs.createElement("Button", {
        id: "PerformanceHeatmapToggle",
        "class": "PerformanceHeatmapClickTarget"
      }, _el$31),
      _el$33 = libs.createElement("Label", {
        "class": "PerformanceHeatmapToggleArrow",
        get text() {
          return collapsed() ? "◀" : "▶";
        }
      }, _el$32),
      _el$34 = libs.createElement("Panel", {
        id: "PerformanceHeatmapViewport",
        hittest: false
      }, _el$31),
      _el$35 = libs.createElement("Panel", {
        id: "PerformanceHeatmapPanel"
      }, _el$34),
      _el$36 = libs.createElement("Panel", {
        "class": "PerfHeader"
      }, _el$35),
      _el$37 = libs.createElement("Panel", {
        "class": "PerfTitleRow"
      }, _el$36),
      _el$38 = libs.createElement("Panel", {
        "class": "PerfHeaderIcon"
      }, _el$37);
      libs.createElement("Label", {
        text: "▦"
      }, _el$38);
      const _el$40 = libs.createElement("Panel", {
        "class": "PerfTitleText"
      }, _el$37);
      libs.createElement("Label", {
        "class": "PerfTitle",
        text: "性能热力图"
      }, _el$40);
      const _el$42 = libs.createElement("Label", {
        "class": "PerfSubtitle",
        get text() {
          return statusText();
        }
      }, _el$40),
      _el$43 = libs.createElement("Panel", {
        "class": "PerfSummaryRow"
      }, _el$36),
      _el$44 = libs.createElement("Panel", {
        "class": "PerfModeBar"
      }, _el$35),
      _el$45 = libs.createElement("Panel", {
        "class": "PerfListHeader"
      }, _el$35);
      libs.createElement("Label", {
        text: "系统采样"
      }, _el$45);
      const _el$47 = libs.createElement("Label", {
        get text() {
          return MODE_LABELS[mode()];
        }
      }, _el$45),
      _el$48 = libs.createElement("Panel", {
        "class": "PerfMetricList"
      }, _el$35);
    libs.setProp(_el$32, "onactivate", () => setCollapsed(!collapsed()));
    libs.insert(_el$43, libs.createComponent(SummaryChip, {
      label: "系统数",
      get value() {
        return formatCount(metricViews().length);
      },
      accent: "Green"
    }), null);
    libs.insert(_el$43, libs.createComponent(SummaryChip, {
      label: "偏热",
      get value() {
        return formatCount(warnCount());
      },
      accent: "Gold"
    }), null);
    libs.insert(_el$43, libs.createComponent(SummaryChip, {
      label: "热点",
      get value() {
        return formatCount(hotCount());
      },
      accent: "Red"
    }), null);
    libs.insert(_el$44, libs.createComponent(MetricModeButton, {
      mode: "avg",
      get current() {
        return mode();
      },
      onSelect: setMode
    }), null);
    libs.insert(_el$44, libs.createComponent(MetricModeButton, {
      mode: "max",
      get current() {
        return mode();
      },
      onSelect: setMode
    }), null);
    libs.insert(_el$44, libs.createComponent(MetricModeButton, {
      mode: "calls",
      get current() {
        return mode();
      },
      onSelect: setMode
    }), null);
    libs.insert(_el$35, libs.createComponent(DetailPanel, {
      get metric() {
        return selectedMetric();
      },
      get mode() {
        return mode();
      }
    }), _el$45);
    libs.insert(_el$48, libs.createComponent(libs.For, {
      get each() {
        return metricViews();
      },
      children: metric => libs.createComponent(MetricRow, {
        metric: metric,
        get selected() {
          return selectedKey() === metric.key;
        },
        get mode() {
          return mode();
        },
        onSelect: () => setSelectedKey(metric.key)
      })
    }), null);
    libs.insert(_el$48, libs.createComponent(libs.Show, {
      get when() {
        return metricViews().length === 0;
      },
      get children() {
        const _el$49 = libs.createElement("Panel", {
            "class": "PerfEmptyState"
          }, null);
          libs.createElement("Label", {
            "class": "PerfEmptyTitle",
            text: "暂无采样数据"
          }, _el$49);
          libs.createElement("Label", {
            "class": "PerfEmptyDesc",
            text: "进入游戏后等待下一次同步。"
          }, _el$49);
        return _el$49;
      }
    }), null);
    libs.effect(_p$ => {
      const _v$22 = {
          Collapsed: collapsed()
        },
        _v$23 = collapsed() ? "◀" : "▶",
        _v$24 = {
          Collapsed: collapsed()
        },
        _v$25 = statusText(),
        _v$26 = MODE_LABELS[mode()];
      _v$22 !== _p$._v$22 && (_p$._v$22 = libs.setProp(_el$32, "classList", _v$22, _p$._v$22));
      _v$23 !== _p$._v$23 && (_p$._v$23 = libs.setProp(_el$33, "text", _v$23, _p$._v$23));
      _v$24 !== _p$._v$24 && (_p$._v$24 = libs.setProp(_el$35, "classList", _v$24, _p$._v$24));
      _v$25 !== _p$._v$25 && (_p$._v$25 = libs.setProp(_el$42, "text", _v$25, _p$._v$25));
      _v$26 !== _p$._v$26 && (_p$._v$26 = libs.setProp(_el$47, "text", _v$26, _p$._v$26));
      return _p$;
    }, {
      _v$22: undefined,
      _v$23: undefined,
      _v$24: undefined,
      _v$25: undefined,
      _v$26: undefined
    });
    return _el$30;
  })();
}
function PerformanceHeatmapHUD() {
  const [demoSetting, _setDemoSetting] = libs.createSignal(CustomNetTables.GetTableValue("common", "demo_settings"));
  libs.createEffect(() => {
    const id = CustomNetTables.SubscribeNetTableListener("common", function (_, k, v) {
      if (k === "demo_settings") {
        _setDemoSetting(v);
      }
    });
    libs.onCleanup(() => {
      CustomNetTables.UnsubscribeNetTableListener(id);
    });
  });
  return libs.createComponent(libs.Show, {
    get when() {
      return demoSetting()?.performance_heatmap == 1;
    },
    get children() {
      return libs.createComponent(PerformanceHeatmap, {});
    }
  });
}
libs.render(() => libs.createComponent(PerformanceHeatmapHUD, {}), $.GetContextPanel());