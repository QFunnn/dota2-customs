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
var EOM_Label = require('./EOM_Label.js');
var EOM_Button = require('./EOM_Button.js');
var GenericPanel = require('./GenericPanel.js');
var Player = require('./Player.js');
require('./EOM_Icon.js');
require('./EOM_Image.js');

const CHATLINE_LIMIT = 45;
const Chat = () => {
  const localPlayerID = Players.GetLocalPlayer();
  const [chatList, setChatList] = libs.createSignal([]);
  const [show, setShow] = libs.createSignal(false);
  const [banList, setBanList] = libs.createSignal({});
  const [selfMuteList, setSelfMuteList] = libs.createSignal([]);
  const [hideChat, setHideChat] = libs.createSignal(false);
  let channelList = ["all"];
  if (isGroupMode()) {
    channelList = ["team", "all"];
  }
  const [selectChannel, setSelectChannel] = libs.createSignal(channelList[0]);
  $.RegisterKeyBind("", "key_enter", () => {
    console.log("combineTest", "enter");
    if (hideChat()) {
      setShow(false);
      return;
    }
    if (isGroupMode() && GameUI.IsShiftDown()) {
      if (GameUI.IsShiftDown()) {
        setSelectChannel("all");
      } else {
        setSelectChannel("team");
      }
    }
    setShow(true);
    const pTextEntry = $("#TextEntry");
    pTextEntry.SetAcceptsFocus(true);
    pTextEntry.SetFocus();
  });
  $.RegisterKeyBind("", "key_pad_enter", () => {
    if (hideChat()) {
      setShow(false);
      return;
    }
    setShow(true);
    const pTextEntry = $("#TextEntry");
    pTextEntry.SetAcceptsFocus(true);
    pTextEntry.SetFocus();
  });
  $.RegisterKeyBind("", "key_escape", () => {
    if (hideChat()) {
      setShow(false);
      return;
    }
    const pTextEntry = $("#TextEntry");
    if (show() && pTextEntry?.BHasKeyFocus()) {
      setShow(false);
      pTextEntry.SetAcceptsFocus(false);
    }
  });
  const onPlayerChat = event => {
    if (selfMuteList().includes(event.player)) {
      return;
    }
    AddChatList(event);
  };
  const onPause = event => {
    let info = {
      channel: "all",
      text: ""
    };
    if (event.state == 1) {
      if (event.player_id != undefined) {
        info.text = $.Localize("#PlayerPauseGame1");
      } else {
        info.text = $.Localize("#PlayerPauseGame0");
      }
    } else {
      info.text = $.Localize("#PlayerPauseGame2");
    }
    print("onPause", event);
    if (event.player_id != undefined) {
      info.player = event.player_id;
    }
    if (event.steam_id) {
      info.steamid = event.steam_id;
    }
    AddChatList(info);
  };
  const AddChatList = info => {
    if (chatList().length >= CHATLINE_LIMIT - 1) {
      setChatList([...chatList(), info].splice(chatList().length - CHATLINE_LIMIT + 1));
    } else setChatList([...chatList(), info]);
  };
  const onSubmit = () => {
    const pTextEntry = $("#TextEntry");
    if (pTextEntry.text && pTextEntry.text.length > 0) {
      if (banList()[localPlayerID]?.chat == true) {
        pTextEntry.text = "";
        AddChatList({
          text: "#ChatBannedWarning",
          text_type: "warning"
        });
        return;
      }
      let text = pTextEntry.text;
      let params = {
        player: localPlayerID,
        steamid: Game.GetPlayerInfo(localPlayerID).player_steamid,
        text: text,
        channel: selectChannel()
      };
      onPlayerChat(params);
      GameEvents.SendCustomEventToServer("custom_player_chat", params);
      GameEvents.SendCustomGameEventToServer("DemoEvent", {
        event_name: "CustomPlayerChat",
        player_id: localPlayerID,
        unit: Players.GetLocalPlayerPortraitUnit(),
        position: GameUI.GetCameraLookAtPosition(),
        str: text
      });
      pTextEntry.text = "";
      setShow(false);
    } else {
      setShow(false);
      pTextEntry.SetAcceptsFocus(false);
      $.DispatchEvent("DropInputFocus", pTextEntry);
    }
  };
  const OnTeammateSuggest = event => {
    console.log("OnTeammateSuggest", event);
    const colors = {
      [TeamSuggestAction.ShopCard]: "#9dff9a",
      [TeamSuggestAction.SpecialSelection]: "#ff9ab8",
      [TeamSuggestAction.CardEffect]: "#f0ff9a",
      [TeamSuggestAction.HeroSelection]: "#ffffff"
    };
    let text = "";
    let _type = "";
    let _item = "";
    if (event.action == TeamSuggestAction.CardEffect) {
      _type = isGroupMode() ? $.Localize("#TeamCard") : $.Localize("#CardEffect");
      _item = $.Localize("#DOTA_Tooltip_ability_" + event.extra_info);
      _type = `<font color="${colors[event.action]}">${_type}</font>`;
      _item = `<font color="${colors[event.action]}">${_item}</font>`;
      $.GetContextPanel().SetDialogVariable("string_type", _type);
      $.GetContextPanel().SetDialogVariable("string_item", _item);
      text = $.Localize("#TeammateSuggestion_Buy", $.GetContextPanel());
    } else if (event.action == TeamSuggestAction.ShopCard) {
      _type = $.Localize("#Ability_ButtonCategory");
      _item = $.Localize("#DOTA_Tooltip_ability_mechanics_" + event.extra_info);
      _type = `<font color="${colors[event.action]}">${_type}</font>`;
      _item = `<font color="${colors[event.action]}">${_item}</font>`;
      $.GetContextPanel().SetDialogVariable("string_type", _type);
      $.GetContextPanel().SetDialogVariable("string_item", _item);
      text = $.Localize("#TeammateSuggestion_Buy", $.GetContextPanel());
    } else if (event.action == TeamSuggestAction.SpecialSelection) {
      _item = $.Localize("#DOTA_Tooltip_ability_" + event.extra_info);
      _item = `<font color="${colors[event.action]}">${_item}</font>`;
      $.GetContextPanel().SetDialogVariable("string_type", _type);
      $.GetContextPanel().SetDialogVariable("string_item", _item);
      text = $.Localize("#TeammateSuggestion_Select", $.GetContextPanel());
    } else if (event.action == TeamSuggestAction.HeroSelection) {
      _item = $.Localize("#" + event.extra_info);
      _item = `<font color="${colors[event.action]}">${_item}</font>`;
      $.GetContextPanel().SetDialogVariable("string_type", _type);
      $.GetContextPanel().SetDialogVariable("string_item", _item);
      text = $.Localize("#TeammateSuggestion_Select", $.GetContextPanel());
    }
    let params = {
      player: event.player,
      steamid: getPlayerData(event.player, "steamID"),
      text: text,
      channel: "team",
      html: true
    };
    AddChatList(params);
  };
  libs.onMount(() => {
    const gameEventListeners = [];
    const NetTableListeners = [];
    let teamSuggestionCooldown;
    gameEventListeners.push(GameEvents.Subscribe("custom_player_chat", onPlayerChat));
    gameEventListeners.push(GameEvents.Subscribe("CustomPlayerPause", onPause));
    gameEventListeners.push(useClientSideEvent("teammate_suggest_action", event => {
      console.log("teammate_suggest_action get:", event);
      if (teamSuggestionCooldown) {
        return;
      }
      OnTeammateSuggest(event);
      teamSuggestionCooldown = true;
      $.Schedule(1, () => {
        teamSuggestionCooldown = undefined;
      });
    }));
    gameEventListeners.push(GameEvents.Subscribe("teammate_suggest_action", event => OnTeammateSuggest(event)));
    if (!isSpectator()) {
      NetTableListeners.push(useNetTableKeyHasDefaultValue("player_data", localPlayerID.toString(), data => {
        setSelfMuteList(Object.values(data.muteList ?? []));
        setHideChat(data.service_config.close_chat == "1");
      }));
    }
    NetTableListeners.push(useServiceNetTable("ban", (data, playerID) => {
      setBanList(Object.assign(banList(), {
        [playerID]: data
      }));
    }, -1));
    libs.onCleanup(() => {
      for (const id of gameEventListeners) {
        GameEvents.Unsubscribe(id);
      }
      for (const id of NetTableListeners) {
        CustomNetTables.UnsubscribeNetTableListener(id);
      }
    });
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "ChatView",
    hittest: false,
    get visible() {
      return !hideChat();
    },
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        width: "100%",
        hittest: false,
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "ChatContent",
            get className() {
              return libs.classNames({
                HiddenBG: !show()
              });
            },
            get hittest() {
              return show();
            },
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "ChatLinesWrapper",
                get hittest() {
                  return show();
                },
                onactivate: () => {},
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "ChatLinesPanel",
                    hittest: false,
                    get children() {
                      return libs.createComponent(libs.For, {
                        get each() {
                          return chatList();
                        },
                        children: (chatLine, index) => {
                          const prefix = () => {
                            let _prefix = "";
                            if (chatLine.channel == "team") {
                              _prefix = $.Localize("#ChatChannel_team");
                            } else if (chatLine.channel == "all") {
                              _prefix = $.Localize("#ChatChannel_all");
                            }
                            if (_prefix != "") {
                              return `(${_prefix})`;
                            }
                          };
                          return libs.createComponent(EOM_Panel.EOM_Panel, {
                            get className() {
                              return libs.classNames("ChatLine", {
                                Hidden: !show()
                              }, chatLine.channel);
                            },
                            style: {
                              flowChildren: "right"
                            },
                            onload: pSelf => {
                              pSelf.AddClass("InitShow");
                              $.Schedule(10, () => {
                                if (pSelf?.IsValid()) {
                                  pSelf.RemoveClass("InitShow");
                                }
                              });
                            },
                            get children() {
                              return [libs.createComponent(libs.Show, {
                                get when() {
                                  return chatLine.player != undefined && chatLine.steamid != undefined;
                                },
                                get children() {
                                  return [libs.createComponent(libs.Show, {
                                    get when() {
                                      return prefix() != undefined;
                                    },
                                    get children() {
                                      return libs.createComponent(EOM_Label.EOM_Label, {
                                        id: "ChannelInfo",
                                        get className() {
                                          return chatLine.channel;
                                        },
                                        get text() {
                                          return prefix();
                                        }
                                      });
                                    }
                                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                    id: "ChatLinePlayer",
                                    style: {
                                      flowChildren: "right"
                                    },
                                    get children() {
                                      return [libs.createComponent(Player.PlayerAvatar, {
                                        get steamID() {
                                          return chatLine.steamid;
                                        },
                                        get ban() {
                                          return banList()[chatLine.player]?.name == true;
                                        }
                                      }), libs.createComponent(libs.Switch, {
                                        get children() {
                                          return [libs.createComponent(libs.Match, {
                                            get when() {
                                              return banList()[chatLine.player]?.name == true;
                                            },
                                            get children() {
                                              return libs.createComponent(GenericPanel.CLabel, {
                                                text: "******"
                                              });
                                            }
                                          }), libs.createComponent(libs.Match, {
                                            get when() {
                                              return (banList()[chatLine.player]?.name ?? false) == false;
                                            },
                                            get children() {
                                              return libs.createComponent(Player.PlayerName, {
                                                get steamID() {
                                                  return chatLine.steamid;
                                                },
                                                get playerID() {
                                                  return chatLine.player;
                                                }
                                              });
                                            }
                                          })];
                                        }
                                      }), libs.createComponent(EOM_Label.EOM_Label, {
                                        text: ": "
                                      })];
                                    }
                                  })];
                                }
                              }), (() => {
                                const _el$2 = libs.createElement("Label", {
                                  id: "ChatLineText",
                                  get text() {
                                    return chatLine.text;
                                  },
                                  get html() {
                                    return chatLine.html;
                                  }
                                }, null);
                                libs.effect(_p$ => {
                                  const _v$3 = chatLine?.text_type ?? "",
                                    _v$4 = chatLine.text,
                                    _v$5 = chatLine.html;
                                  _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$2, "className", _v$3, _p$._v$3));
                                  _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$2, "text", _v$4, _p$._v$4));
                                  _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$2, "html", _v$5, _p$._v$5));
                                  return _p$;
                                }, {
                                  _v$3: undefined,
                                  _v$4: undefined,
                                  _v$5: undefined
                                });
                                return _el$2;
                              })()];
                            }
                          });
                        }
                      });
                    }
                  });
                }
              });
            }
          });
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "ChatInputContainer",
        get classList() {
          return {
            Show: show()
          };
        },
        hittest: false,
        get children() {
          return [libs.createComponent(EOM_Button.EOM_BaseButton, {
            get visible() {
              return channelList.length > 1;
            },
            id: "ChannelSwitchButton",
            onactivate: () => {
              let index = channelList.indexOf(selectChannel()) + 1;
              if (index >= channelList.length) {
                index = 0;
              }
              setSelectChannel(channelList[index]);
            },
            get children() {
              const _el$ = libs.createElement("Label", {
                id: "ChannelInfo",
                get text() {
                  return "/" + $.Localize(`#ChatChannel_${selectChannel()}`);
                }
              }, null);
              libs.effect(_p$ => {
                const _v$ = selectChannel(),
                  _v$2 = "/" + $.Localize(`#ChatChannel_${selectChannel()}`);
                _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$, "className", _v$, _p$._v$));
                _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$, "text", _v$2, _p$._v$2));
                return _p$;
              }, {
                _v$: undefined,
                _v$2: undefined
              });
              return _el$;
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "ChatInput",
            get className() {
              return selectChannel();
            },
            style: {
              flowChildren: "right"
            },
            get visible() {
              return show();
            },
            onload: self => {
              const textEntry = $.CreatePanel("TextEntry", self, "TextEntry");
              textEntry.SetPanelEvent("oninputsubmit", onSubmit);
              textEntry.SetPanelEvent("onblur", () => {
                setShow(false);
              });
            }
          })];
        }
      })];
    }
  });
};
libs.render(() => libs.createComponent(Chat, {}), $.GetContextPanel());