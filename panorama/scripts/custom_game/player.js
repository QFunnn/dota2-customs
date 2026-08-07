--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('Player', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var GenericPanel = require('./GenericPanel.js');
var EOM_Button = require('./EOM_Button.js');
var EOM_Image = require('./EOM_Image.js');
var EOM_Label = require('./EOM_Label.js');

const EOM_Avatar = props => {
  let avatarImage;
  const merged = libs.mergeProps$1({
    steamid: "-1",
    accountid: "-1"
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "steamid", "accountid"]);
  const resolved = libs.children(() => local.children);
  libs.onMount(() => {
    let interval_id = setInterval(() => {
      if (avatarImage != undefined && avatarImage?.IsValid()) {
        avatarImage.accountid = local.accountid.toString();
        clearInterval(interval_id);
        interval_id = -1;
      }
    }, 10);
    libs.onCleanup(() => {
      if (interval_id != -1) {
        clearInterval(interval_id);
      }
    });
  });
  libs.createEffect(() => {
    if (avatarImage != undefined && avatarImage?.IsValid()) {
      if (local.accountid) {
        avatarImage.accountid = local.accountid.toString();
      }
    }
  });
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
        className: "EOM_Avatar"
      })), null),
      _el$2 = libs.createElement("DOTAAvatarImage", {
        get steamid() {
          return local.steamid;
        },
        hittest: false
      }, _el$);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "EOM_Avatar"
    })), true);
    const _ref$ = avatarImage;
    typeof _ref$ === "function" ? libs.use(_ref$, _el$2) : avatarImage = _el$2;
    libs.setProp(_el$2, "style", {
      width: "100%",
      height: "100%"
    });
    libs.insert(_el$, resolved, null);
    libs.effect(_$p => libs.setProp(_el$2, "steamid", local.steamid, _$p));
    return _el$;
  })();
};

const EOM_Currency = props => {
  const merged = libs.mergeProps$1({
    hasFeedback: false,
    type: EOM_Panel.ADDON_NAME
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "hasFeedback", "type", "icon", "value", "onaddbuttonactivate"]);
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("EOM_Currency", local.type)
    })), null);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("EOM_Currency", local.type)
    })), true);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return local.hasFeedback;
      },
      get children() {
        const _el$2 = libs.createElement("TextButton", {
          text: "#StoreRechargeReport"
        }, null);
        libs.setProp(_el$2, "className", "EOM_Feedback");
        libs.setProp(_el$2, "onactivate", pSelf => {});
        return _el$2;
      }
    }), null);
    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
      className: "EOM_CurrencyContainer",
      get children() {
        return [libs.createComponent(EOM_Image.EOM_Image, {
          className: "EOM_CurrencyIconBG",
          get children() {
            return libs.createComponent(EOM_Panel.EOM_Panel, {
              className: "EOM_CurrencyIcon",
              get backgroundImage() {
                return local.icon;
              }
            });
          }
        }), (() => {
          const _el$3 = libs.createElement("Panel", {}, null);
          libs.setProp(_el$3, "className", "EOM_CurrencyLabelContainer");
          libs.insert(_el$3, libs.createComponent(GenericPanel.CLabel, {
            get text() {
              return local.value;
            }
          }));
          return _el$3;
        })(), libs.createComponent(libs.Show, {
          get when() {
            return local.onaddbuttonactivate != undefined;
          },
          get children() {
            return libs.createComponent(EOM_Button.EOM_IconButton, {
              className: "EOM_CurrencyRecharge",
              get icon() {
                return libs.createComponent(EOM_Image.EOM_Image, {});
              },
              get onactivate() {
                return local.onaddbuttonactivate;
              }
            });
          }
        })];
      }
    }), null);
    return _el$;
  })();
};

const EOM_UserName = props => {
  const merged = libs.mergeProps$1({
    showgGild: false
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "steamid", "accountid", "showgGild"]);
  const resolved = libs.children(() => local.children);
  const showgGild = libs.createMemo(() => local.showgGild);
  let userNamePanel;
  const [username, setUserName] = libs.createSignal("");
  let p_timer = -1;
  const updateName = () => {
    if (p_timer != -1) {
      clearInterval(p_timer);
    }
    p_timer = setInterval(() => {
      if (userNamePanel != undefined && userNamePanel.IsValid()) {
        let label = userNamePanel.GetChild(0);
        let gild = label.text.match(/\[.*?\]/g);
        if (gild && gild.length > 0) {
          let lastMatch = gild[gild.length - 1];
          let updatedText = label.text.replace(lastMatch, "");
          setUserName(updatedText);
        }
        if (gild && gild[gild.length - 1]) {
          setUserName(label.text.replace(gild[gild.length - 1], ""));
        } else {
          setUserName(label.text);
        }
      }
    }, 10);
  };
  libs.onMount(() => {
    let interval_id = setInterval(() => {
      if (userNamePanel != undefined && userNamePanel.IsValid()) {
        if (local.accountid) {
          userNamePanel.accountid = local.accountid.toString();
        }
        if (local.showgGild == false) {
          userNamePanel.visible = false;
          updateName();
        }
        clearInterval(interval_id);
        interval_id = -1;
      }
    }, 10);
    libs.onCleanup(() => {
      if (interval_id != -1) {
        clearInterval(interval_id);
      }
      if (p_timer = -1) {
        clearInterval(p_timer);
      }
    });
  });
  libs.createEffect(libs.on(showgGild, show_gild => {
    if (userNamePanel) {
      if (!show_gild) {
        userNamePanel.visible = false;
        updateName();
      } else {
        userNamePanel.visible = true;
        if (p_timer != -1) {
          clearInterval(p_timer);
        }
      }
    }
  }));
  libs.createEffect(() => {
    if (userNamePanel && local.accountid != undefined) {
      userNamePanel.accountid = local.accountid.toString();
    }
  });
  return (() => {
    const _el$2 = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
        className: "EOM_UserName"
      })), null),
      _el$3 = libs.createElement("DOTAUserName", {
        get steamid() {
          return local.steamid;
        },
        hittest: false
      }, _el$2);
    libs.spread(_el$2, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "EOM_UserName"
    })), true);
    libs.insert(_el$2, libs.createComponent(GenericPanel.CLabel, {
      get text() {
        return username();
      }
    }), _el$3);
    const _ref$ = userNamePanel;
    typeof _ref$ === "function" ? libs.use(_ref$, _el$3) : userNamePanel = _el$3;
    libs.insert(_el$2, resolved, null);
    libs.effect(_$p => libs.setProp(_el$3, "steamid", local.steamid, _$p));
    return _el$2;
  })();
};

const EOM_TextEntry = props => {
  const [local, others] = libs.splitProps(props, ["children", "onChange", "oninputsubmit", "text"]);
  const resolved = libs.children(() => local.children);
  const [text, setText] = libs.createSignal(local.text ?? "");
  return (() => {
    const _el$ = libs.createElement("TextEntry", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames(props.className, "EOM_TextEntry"),
      style: {
        whiteSpace: others.multiline ? "normal" : undefined
      }
    })), null);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames(props.className, "EOM_TextEntry"),
      style: {
        whiteSpace: others.multiline ? "normal" : undefined
      }
    }), {
      "ontextentrychange": self => {
        if (local.onChange) {
          local.onChange(self, text(), self.text);
        }
        setText(self.text);
      },
      "oninputsubmit": self => {
        if (local.oninputsubmit) {
          local.oninputsubmit(self);
        }
        if (local.onChange) {
          local.onChange(self, text(), self.text);
        }
        setText(self.text);
      },
      "onload": self => {
        self.text = text();
        self.SetDisableFocusOnMouseDown(false);
        self.SetPanelEvent("onblur", () => {
          $.DispatchEvent("DropInputFocus", self);
        });
      }
    }), true);
    libs.insert(_el$, resolved);
    return _el$;
  })();
};

const PlayerName = props => {
  const merged = libs.mergeProps$1({
    steamID: "0",
    playerID: -1,
    ban: false
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "steamID", "playerID", "ban"]);
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "PlayerName"
    })), null);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "PlayerName"
    })), true);
    libs.insert(_el$, libs.createComponent(libs.Switch, {
      get children() {
        return [libs.createComponent(libs.Match, {
          get when() {
            return local.ban;
          },
          get children() {
            return libs.createComponent(GenericPanel.CLabel, {
              className: "EOM_UserName",
              text: "******"
            });
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return local.steamID?.indexOf("11111111111") == -1;
          },
          get children() {
            return libs.createComponent(EOM_UserName, {
              get accountid() {
                return local.steamID;
              }
            });
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return local.steamID?.indexOf("11111111111") != -1;
          },
          get children() {
            return libs.createComponent(EOM_Label.EOM_Label, {
              get text() {
                return "#" + Players.GetPlayerName(local.playerID);
              }
            });
          }
        })];
      }
    }));
    return _el$;
  })();
};
const PlayerAvatar = props => {
  const merged = libs.mergeProps$1({
    steamID: "-1",
    playerID: -2,
    illusion: false,
    disconnect: false,
    ai_host: false,
    ban: false,
    dota2tooltip: false
  }, props);
  const [local, others] = libs.splitProps(merged, ["steamID", "playerID", "illusion", "avatar_border", "avatar_frame", "disconnect", "ai_host", "className", "ban", "dota2tooltip", "children"]);
  const [avatarBorder, setAvatarBorder] = libs.createSignal();
  libs.createSignal();
  const [equippedOrnamentData, setEquippedOrnamentData] = libs.createSignal({});
  const equippedAvatarBorder = libs.createMemo(() => {
    let border = "";
    if (equippedOrnamentData()?.["71"] != undefined) {
      for (const id in equippedOrnamentData()?.["71"]) {
        border = id;
        break;
      }
    }
    return border;
  });
  libs.createEffect(libs.on(() => local.playerID, player_id => {
    let data = {};
    if (player_id != -1) {
      data = getServiceNetTable("player_equipped_ornament", player_id);
    }
    setEquippedOrnamentData(data);
  }));
  libs.createEffect(() => {
    UpdateAvatarBorder();
  });
  const UpdateAvatarBorder = () => {
    let border = local.avatar_border != undefined ? local.avatar_border.toString() : local.ai_host ? "5710000" : equippedAvatarBorder();
    if (border.length != 7 || !border.startsWith("571")) {
      border = "5710000";
    }
    if (avatarBorder() != border) {
      setAvatarBorder(border);
    }
  };
  libs.onMount(() => {
    const id = useServiceNetTable("player_equipped_ornament", (data, playerID) => {
      if (local.playerID == playerID) {
        setEquippedOrnamentData(data);
      }
    }, -1);
    libs.onCleanup(() => {
      CustomNetTables.UnsubscribeNetTableListener(id);
    });
  });
  return (() => {
    const _el$2 = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("PlayerAvatar", local.className, {})
    })), null);
    libs.spread(_el$2, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("PlayerAvatar", local.className, {})
    })), true);
    libs.insert(_el$2, libs.createComponent(libs.Switch, {
      get children() {
        return [libs.createComponent(libs.Match, {
          get when() {
            return libs.memo(() => local.steamID != "0")() && local.steamID?.indexOf("11111111111") == -1;
          },
          get children() {
            return libs.createComponent(libs.Show, {
              get when() {
                return local.ban;
              },
              fallback: () => libs.createComponent(EOM_Avatar, {
                get accountid() {
                  return local.ban ? "-1" : local.steamID;
                },
                get children() {
                  return [libs.createComponent(libs.Show, {
                    get when() {
                      return local.ai_host;
                    },
                    get children() {
                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                        width: "100%",
                        height: "100%",
                        get children() {
                          return libs.createComponent(EOM_Image.EOM_Image, {
                            align: "center center",
                            width: "100%",
                            height: "100%",
                            get backgroundImage() {
                              return getImagePath("hud/bot_avatar_" + local.playerID + ".png");
                            },
                            hittest: false
                          });
                        }
                      });
                    }
                  }), libs.createComponent(libs.Show, {
                    get when() {
                      return !local.dota2tooltip;
                    },
                    get children() {
                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                        width: "100%",
                        height: "100%"
                      });
                    }
                  })];
                }
              }),
              get children() {
                return libs.createComponent(EOM_Panel.EOM_Panel, {
                  className: "EOM_Avatar",
                  backgroundColor: "#222222",
                  get children() {
                    return libs.createComponent(EOM_Image.EOM_Image, {
                      align: "center center",
                      width: "60%",
                      height: "60%",
                      backgroundSize: "100%",
                      src: `s2r://panorama/images/pings/ping_world_question_psd.vtex`
                    });
                  }
                });
              }
            });
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return local.steamID == "0" && local.playerID == undefined;
          },
          get children() {
            return libs.createComponent(EOM_Image.EOM_Image, {
              width: "100%",
              height: "100%",
              backgroundImage: `url('s2r://panorama/images/bot_icon_unfair_png.vtex')`
            });
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return local.steamID?.indexOf("11111111111") != -1 && local.playerID != undefined;
          },
          get children() {
            return libs.createComponent(EOM_Panel.EOM_Panel, {
              width: "100%",
              height: "100%",
              get children() {
                return [libs.createComponent(EOM_Image.EOM_Image, {
                  align: "center center",
                  width: "80%",
                  height: "80%",
                  get backgroundImage() {
                    return getImagePath("hud/bot_avatar_bg_" + local.steamID.replace("11111111111", "") + ".png");
                  }
                }), libs.createComponent(EOM_Image.EOM_Image, {
                  align: "center center",
                  width: "80%",
                  height: "80%",
                  get backgroundImage() {
                    return getImagePath("hud/bot_avatar_" + local.steamID.replace("11111111111", "") + ".png");
                  }
                })];
              }
            });
          }
        })];
      }
    }), null);
    libs.insert(_el$2, libs.createComponent(libs.Show, {
      get when() {
        return local.illusion;
      },
      get children() {
        return libs.createComponent(EOM_Image.EOM_Image, {
          width: "100%",
          height: "100%",
          get backgroundImage() {
            return getImagePath("hud/avatar_image.png");
          }
        });
      }
    }), null);
    libs.insert(_el$2, libs.createComponent(libs.Show, {
      get when() {
        return local.avatar_frame != undefined;
      },
      get children() {
        return libs.createComponent(EOM_Image.EOM_Image, {
          className: "EOM_Avatar",
          get backgroundImage() {
            return getImagePath("avatar_frame/" + local.avatar_frame + ".png");
          },
          hittest: false
        });
      }
    }), null);
    libs.insert(_el$2, libs.createComponent(libs.Show, {
      get when() {
        return avatarBorder() != undefined;
      },
      get children() {
        return libs.createComponent(EOM_Image.EOM_Image, {
          className: "AvatarBorder",
          get backgroundImage() {
            return getImagePath("cosmetics_items/" + avatarBorder() + ".png");
          },
          hittest: false
        });
      }
    }), null);
    return _el$2;
  })();
};
const PlayerCurrency = props => {
  const [value, setValue] = libs.createSignal(0);
  const [tokenAccess, setTokenAccess] = libs.createSignal();
  const icon = libs.createMemo(() => {
    if (props.type == "moonstone") {
      return getImagePath("tokens/1000001.png");
    } else if (props.type == "starlight") {
      return getImagePath("eom_design/icon/eom/star.png");
    } else if (props.type == "props") {
      return getImagePath(`backpack_items/${props.tokenID}.png`);
    }
    return getImagePath(`tokens/${props.tokenID}.png`);
  });
  const getTokenID = () => {
    if (props.type == "moonstone") {
      return "1000001";
    } else if (props.type == "starlight") {
      return "1000002";
    }
    return props.tokenID?.toString() ?? "";
  };
  const hasAddbutton = () => {
    if (props.type == "moonstone") {
      return true;
    } else if (tokenAccess() != undefined) {
      return true;
    }
    return false;
  };
  const updateTokenAccess = data => {
    if (props.tokenID) {
      setTokenAccess(data?.[props.tokenID]);
    } else {
      setTokenAccess(undefined);
    }
  };
  libs.createEffect(libs.on(() => props.type, v => {
    updateCurrencyCount();
  }));
  libs.createEffect(libs.on(() => props.tokenID, id => {
    updateTokenAccess(getClientGlobalData("token_access"));
    updateCurrencyCount();
  }));
  const updateCurrencyCount = () => {
    const player_wallet = getNetDataCache("player_wallet", Players.GetLocalPlayer());
    const player_token = getNetDataCache("player_token", Players.GetLocalPlayer());
    let value = 0;
    if (props.type == "moonstone") {
      value = player_wallet?.moonstone ?? 0;
    } else if (props.type == "starlight") {
      value = player_wallet?.starlight ?? 0;
    }
    if (props.type == "token" && props.tokenID != undefined) {
      if (player_token?.[props.tokenID] != undefined) {
        value = player_token[props.tokenID].num ?? 0;
      }
    }
    setValue(value);
  };
  const onAddbutton = () => {
    if (hasAddbutton()) {
      return () => {
        if (props.type == "moonstone") {
          clientSideEvent("toggle_store_tag", {
            menu: "Resource"
          });
        } else if (tokenAccess() != undefined) {
          clientSideEvent("directly_purchase", {
            itemidList: tokenAccess()
          });
        }
      };
    }
    return;
  };
  libs.onMount(() => {
    const eventIDList = [];
    eventIDList.push(useClientGlobalData("token_access", data => {
      updateTokenAccess(data);
    }));
    if (props.type == "moonstone" || props.type == "starlight") {
      eventIDList.push(useNetData("player_wallet", data => {
        if (props.type == "moonstone") {
          updateCurrencyCount();
        } else if (props.type == "starlight") {
          updateCurrencyCount();
        }
      }, Players.GetLocalPlayer()));
    } else if (props.type == "token") {
      eventIDList.push(useNetData("player_token", data => {
        if (props.tokenID != undefined) {
          if (data[props.tokenID] != undefined) {
            updateCurrencyCount();
          }
        }
      }, Players.GetLocalPlayer()));
    } else if (props.type == "boxes") {
      eventIDList.push(useNetData("player_boxes", data => {
        if (props.tokenID != undefined) {
          if (data[props.tokenID] != undefined) {
            setValue(data[props.tokenID].amounts ?? 0);
          }
        }
      }, Players.GetLocalPlayer()));
    } else if (props.type == "consumables") {
      eventIDList.push(useNetData("player_consumables", data => {
        if (props.tokenID != undefined) {
          if (data[props.tokenID] != undefined) {
            setValue(data[props.tokenID].amounts ?? 0);
          }
        }
      }, Players.GetLocalPlayer()));
    } else if (props.type == "props") {
      eventIDList.push(useNetData("player_props_amounts", data => {
        if (props.tokenID != undefined) {
          if (data[props.tokenID] != undefined) {
            setValue(data[props.tokenID] ?? 0);
          }
        }
      }, Players.GetLocalPlayer()));
    }
    libs.onCleanup(() => {
      eventIDList.forEach(id => {
        GameEvents.Unsubscribe(id);
      });
    });
  });
  return libs.createComponent(EOM_Currency, {
    get icon() {
      return icon();
    },
    get value() {
      return value();
    },
    onmouseover: self => {
      $.DispatchEvent("DOTAShowTitleTextTooltip", self, "#" + getTokenID(), "#" + getTokenID() + "_description");
    },
    onmouseout: self => {
      $.DispatchEvent("DOTAHideTitleTextTooltip", self);
    },
    get onaddbuttonactivate() {
      return onAddbutton();
    }
  });
};
const ExchangeEntry = () => {
  const [key, setKey] = libs.createSignal("");
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    className: "ExchangeEntry",
    hittest: false,
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "ExchangeTextEntry",
        get backgroundImage() {
          return getImagePath("store/new/exchange_border.png");
        },
        get children() {
          return libs.createComponent(EOM_TextEntry, {
            style: {
              border: "0px",
              backgroundColor: "none"
            },
            get className() {
              return $.Language().toLowerCase();
            },
            placeholder: "#Store_Exchange_Placeholder",
            onChange: self => {
              setKey(self.text);
            },
            oninputsubmit: self => {
              callAction("cdk_exchange", {
                key: key()
              });
            }
          });
        }
      }), libs.createComponent(EOM_Button.EOM_BaseButton, {
        id: "ExchangeBTN",
        onactivate: () => {
          callAction("cdk_exchange", {
            key: key()
          });
        },
        get children() {
          return libs.createComponent(GenericPanel.CLabel, {
            id: "ExchangeLabel",
            text: "#Store_Exchange_Button"
          });
        }
      })];
    }
  });
};
const CurrencyGroup = props => {
  const [local, other] = libs.splitProps(props, ["children"]);
  return libs.createComponent(EOM_Panel.EOM_Panel, libs.mergeProps(() => EOM_Panel.EOMProps(other, {
    className: "CurrencyGroup"
  }), {
    flowChildren: "right",
    horizontalAlign: "right",
    marginTop: "-6px",
    marginRight: "80px",
    hittest: false,
    get children() {
      return [libs.createComponent(libs.Show, {
        get when() {
          return props.recentOrder;
        },
        get children() {
          return libs.createComponent(EOM_Button.EOM_BaseButton, {
            id: "RecentOrder",
            onactivate: self => {
              callAction("recent_order_query", {});
              self.enabled = false;
            },
            get children() {
              return libs.createElement("Label", {
                id: "RecentOrderTips",
                text: "#StoreRechargeReport"
              }, null);
            }
          });
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return props.exchangeButton;
        },
        get children() {
          return libs.createComponent(ExchangeEntry, {});
        }
      }), libs.createComponent(libs.For, {
        get each() {
          return props.tokens;
        },
        children: tokenID => {
          if (tokenID != undefined) {
            if (tokenID == 1000001 || tokenID == "moonstone") {
              return libs.createComponent(PlayerCurrency, {
                type: "moonstone"
              });
            } else if (tokenID == 1100001 || tokenID == "coin") {
              return libs.createComponent(PlayerCurrency, {
                type: "token",
                tokenID: 1100001
              });
            } else if (tokenID.toString().slice(0, 3) == "200") {
              return libs.createComponent(PlayerCurrency, {
                type: "boxes",
                tokenID: tokenID
              });
            } else if (tokenID.toString().slice(0, 3) == "931") {
              return libs.createComponent(PlayerCurrency, {
                type: "props",
                tokenID: tokenID
              });
            } else {
              return libs.createComponent(PlayerCurrency, {
                type: "token",
                tokenID: tokenID
              });
            }
          }
        }
      })];
    }
  }));
};
const PlayerRowBGOrnament = props => {
  const merged = libs.mergeProps$1({
    playerID: Players.GetLocalPlayer(),
    oid: -1
  }, props);
  const [local, others] = libs.splitProps(merged, ["playerID", "oid", "children", "team_mode"]);
  const resolved = libs.children(() => local.children);
  const [oid, setOid] = libs.createSignal(local.oid);
  libs.createEffect(libs.on(() => local.oid, _v => {
    if (_v != -1) {
      setOid(_v);
    }
  }));
  const updateOrnament = () => {
    if (local.oid != -1) return;
    let id = -1;
    const data = getServiceNetTable("player_equipped_ornament", local.playerID)?.[OrnamentType.NAME_DECORATION.toString()];
    if (data) {
      for (const _id in data) {
        id = Number(_id);
        break;
      }
    }
    setOid(id);
  };
  libs.createEffect(libs.on(() => local.playerID, v => {
    updateOrnament();
  }));
  libs.onMount(() => {
    const id = useServiceNetTable("player_equipped_ornament", data => {
      updateOrnament();
    }, -1);
    libs.onCleanup(() => {
      CustomNetTables.UnsubscribeNetTableListener(id);
    });
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
    className: libs.classNames("PlayerRowBGOrnament", "oid" + oid())
  }), {
    hittest: false,
    get children() {
      return [libs.createComponent(GenericPanel.CImage, {
        className: "PlayerRowBG",
        hittest: false
      }), libs.createComponent(libs.Show, {
        get when() {
          return oid() != -1;
        },
        get children() {
          return libs.createComponent(libs.Show, {
            get when() {
              return props.team_mode;
            },
            get fallback() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "PlayerRowNameDecoration",
                get backgroundImage() {
                  return getImagePath(`avatar_name_decoration/${oid()}.png`);
                },
                hittest: false
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "NameDecorationHealthBG",
                get backgroundImage() {
                  return getImagePath(`avatar_name_decoration/${oid()}_circle.png`);
                },
                hittest: false
              })];
            },
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "PlayerRowNameDecoration",
                get backgroundImage() {
                  return getImagePath(`avatar_name_decoration/${oid()}_team.png`);
                },
                hittest: false
              });
            }
          });
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "NameDecorationHealthBarContainer",
        hittest: false,
        get children() {
          return resolved();
        }
      })];
    }
  }));
};

exports.CurrencyGroup = CurrencyGroup;
exports.EOM_Avatar = EOM_Avatar;
exports.EOM_TextEntry = EOM_TextEntry;
exports.EOM_UserName = EOM_UserName;
exports.PlayerAvatar = PlayerAvatar;
exports.PlayerCurrency = PlayerCurrency;
exports.PlayerName = PlayerName;
exports.PlayerRowBGOrnament = PlayerRowBGOrnament;