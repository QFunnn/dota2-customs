--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Image = require('./EOM_Image.js');
var EOM_Label = require('./EOM_Label.js');
var HotKeyIcon = require('./HotKeyIcon.js');
require('./GenericPanel.js');

if (!isSpectator()) {
  const Emoji = () => {
    const [show, setShow] = libs.createSignal(false);
    const [hoverIndex, setHoverIndex] = libs.createSignal(-1);
    const [playerEmoji, setPlayerEmoji] = libs.createSignal({});
    const onMouseOver = eid => {
      if (eid) {
        setHoverIndex(eid);
      }
    };
    const onMouseOut = () => {
      setHoverIndex(-1);
    };
    const onClick = eid => {
      if (eid == undefined) {
        return;
      }
      allClientSideEvent("emoji_dialog", {
        index: eid,
        playerID: Players.GetLocalPlayer()
      });
      GameEvents.SendCustomEventToServer("emoji_dialog", {
        index: eid
      });
      setHoverIndex(-1);
      setShow(false);
    };
    libs.onMount(() => {
      const eventIDList = [];
      eventIDList.push(useNetData('player_emo_slots', data => {
        setPlayerEmoji(data);
      }, Players.GetLocalPlayer()));
      let id = setInterval(() => {
        if (show()) {
          const position = GameUI.GetCursorPosition();
          const width = Game.GetScreenWidth();
          const height = Game.GetScreenHeight();
          const center = [width / 2, height / 2];
          const diff = [position[0] - width / 2, position[1] - height / 2];
          const distance = Math.sqrt(Math.pow(position[0] - width / 2, 2) + Math.pow(position[1] - height / 2, 2));
          const bubbleMaxDistance = 79;
          const arrowMaxDistance = 117;
          const bubbleRatio = bubbleMaxDistance / distance;
          const arrowRatio = arrowMaxDistance / distance;
          const normalize = Game.Normalized([position[0] - center[0], position[1] - center[1], 0]);
          const rad = normalize[0] * -1 / Math.sqrt(normalize[0] * normalize[0] + normalize[1] * normalize[1]);
          let angle = Math.acos(rad) * 180 / Math.PI;
          if (diff[1] > 0) {
            angle = 180 * (1 - angle / 180) + 180;
          }
          angle += 180;
          const Bubble = $.GetContextPanel().FindChildTraverse("Bubble");
          if (Bubble) {
            if (bubbleRatio < 1) {
              Bubble.style.x = Math.min(bubbleMaxDistance, diff[0] * bubbleRatio) + "px";
              Bubble.style.y = Math.min(bubbleMaxDistance, diff[1] * bubbleRatio) + "px";
            } else {
              Bubble.style.x = Math.min(bubbleMaxDistance, diff[0]) + "px";
              Bubble.style.y = Math.min(bubbleMaxDistance, diff[1]) + "px";
            }
          }
          const Arrow = $.GetContextPanel().FindChildTraverse("Arrow");
          if (Arrow) {
            if (arrowRatio < 1) {
              Arrow.style.x = Math.min(arrowMaxDistance, diff[0] * arrowRatio) + "px";
              Arrow.style.y = Math.min(arrowMaxDistance, diff[1] * arrowRatio) + "px";
              Arrow.style.transform = "rotateZ( " + angle + "deg )";
              Arrow.style.visibility = "visible";
            } else {
              Arrow.style.visibility = "collapse";
            }
          }
        }
      }, Game.GetGameFrameTime());
      eventIDList.push(useClientSideEvent("emoji", event => {
        if (event.show == 0 && hoverIndex() != -1) {
          allClientSideEvent("emoji_dialog", {
            index: hoverIndex(),
            playerID: Players.GetLocalPlayer()
          });
          GameEvents.SendCustomEventToServer("emoji_dialog", {
            index: hoverIndex()
          });
        }
        setShow(event.show == 1);
      }));
      eventIDList.push(useClientSideEvent("emoji_action", event => {
        setShow(!show());
      }));
      libs.onCleanup(() => {
        clearInterval(id);
        eventIDList.forEach(eventID => {
          GameEvents.Unsubscribe(eventID);
        });
      });
    });
    let sHotkey = Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL);
    return (() => {
      const _el$ = libs.createElement("Panel", {}, null),
        _el$2 = libs.createElement("Panel", {
          id: "Wheel"
        }, _el$),
        _el$3 = libs.createElement("Panel", {
          id: "Arrow"
        }, _el$2);
        libs.createElement("Panel", {
          id: "Bubble"
        }, _el$2);
      libs.setProp(_el$3, "className", "");
      libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "PhrasesContainer",
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "EmojiWheel"
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "EmojiHotKey",
            get children() {
              return [libs.createComponent(HotKeyIcon.HotKeyIcon, {
                text: sHotkey
              }), libs.createComponent(EOM_Label.EOM_Label, {
                id: "EmojiHotKeyInfo",
                get text() {
                  return $.Localize("#Emoji_HotKey").replace("${key}", `<font color='#FFEF83'>[${sHotkey}]</font>`);
                },
                html: true
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "EmojiWheelBorder",
            hittest: false,
            get children() {
              return [1, 2, 3, 4, 5, 6, 7, 8].map(index => {
                const eid = () => playerEmoji()[index.toString()]?.eid;
                return libs.createComponent(EOM_Panel.EOM_Panel, {
                  id: "HoverBoder" + index,
                  get className() {
                    return libs.classNames("HoverBoder");
                  },
                  get children() {
                    return libs.createComponent(EOM_Image.EOM_Image, {
                      get className() {
                        return libs.classNames("EmojiSlot", {
                          Empty: playerEmoji()[index.toString()] == undefined
                        });
                      },
                      get src() {
                        return getCosmeticImagePath(eid()?.toString() ?? "");
                      },
                      onactivate: () => onClick(eid()),
                      onmouseover: () => onMouseOver(eid()),
                      onmouseout: () => onMouseOut()
                    });
                  }
                });
              });
            }
          })];
        }
      }), null);
      libs.effect(_$p => libs.setProp(_el$, "className", libs.classNames("Emoji", {
        Hidden: !show()
      }), _$p));
      return _el$;
    })();
  };
  libs.render(() => libs.createComponent(Emoji, {}), $.GetContextPanel());
  (() => {
    const sCommand = String(Date.now() / 1000);
    {
      let sHotkey = Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL);
      let aHotkeys = sHotkey.split("-");
      let sKeyName = aHotkeys[aHotkeys.length - 1];
      Game.CreateCustomKeyBind(sKeyName, "+" + sKeyName + sCommand);
      Game.AddCommand("+" + sKeyName + sCommand, () => {
        clientSideEvent("emoji", {
          show: 1
        });
      }, "", 1 << 32);
      Game.AddCommand("-" + sKeyName + sCommand, () => {
        clientSideEvent("emoji", {
          show: 0
        });
      }, "", 1 << 32);
    }
  })();
}