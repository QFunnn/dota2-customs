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
var EOM_Loading = require('./EOM_Loading.js');

$.GetContextPanel().AddClass("CosmeticPreviewLiveHidden");
const GameStart = () => {
  const [gameState, _setGameState] = libs.createSignal(CustomNetTables.GetTableValue("common", "game_state"));
  libs.createSignal(false);
  libs.createSignal("random");
  const [loginState, setLoginState] = libs.createSignal({
    step: 0,
    maxStep: 9
  });
  const [allPlayerConnect, setAllPlayerConnect] = libs.createSignal((CustomNetTables.GetTableValue("common", "all_player_connect")?.state ?? 1) == 1);
  libs.onMount(() => {
    const eventIdList = [];
    const NetTableListenerIDList = [];
    NetTableListenerIDList.push(useNetTableKey("common", "all_player_connect", data => {
      setAllPlayerConnect((data?.state ?? 1) == 1);
    }));
    eventIdList.push(useNetData("login_state", data => {
      setLoginState(data);
    }));
    libs.onCleanup(() => {
      eventIdList.forEach(id => GameEvents.Unsubscribe(id));
      NetTableListenerIDList.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    });
  });
  let isMapTest = !isTurboMode() && !isCompetitionMode() && !isKingsRankMode() && !IsCasualMode() && !isRankMode() && !isGroupMode();
  libs.createEffect(() => {
    const id = CustomNetTables.SubscribeNetTableListener("common", function (_, k, v) {
      if (k === "game_state") {
        _setGameState(v);
      }
    });
    libs.onCleanup(() => {
      CustomNetTables.UnsubscribeNetTableListener(id);
    });
  });
  return (() => {
    const _el$ = libs.createElement("Panel", {
      id: "GameStart"
    }, null);
    libs.setProp(_el$, "onactivate", () => {});
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return allPlayerConnect();
      },
      fallback: () => libs.createComponent(EOM_Panel.EOM_Panel, {
        align: "center center",
        flowChildren: "down",
        marginTop: "-40px",
        width: "800px",
        get children() {
          return [libs.createComponent(EOM_Label.EOM_Label, {
            text: "#Notice_NotAllPlayerConnect_Title",
            color: "#ff0000cc",
            fontSize: "32px",
            horizontalAlign: "center"
          }), libs.createComponent(EOM_Label.EOM_Label, {
            text: "#Notice_NotAllPlayerConnect",
            color: "#fff",
            horizontalAlign: "center",
            fontSize: "24px",
            marginTop: "50px"
          }), libs.createComponent(EOM_Label.EOM_Label, {
            text: "#Notice_NotAllPlayerConnect2",
            horizontalAlign: "center",
            fontSize: "16px",
            marginTop: "10px"
          })];
        }
      }),
      get children() {
        return libs.createComponent(EOM_Panel.EOM_Panel, {
          align: "center center",
          flowChildren: "down",
          width: "200px",
          height: "200px",
          get children() {
            return [libs.createComponent(EOM_Loading.EOM_Loading, {
              type: "PointSpin",
              horizontalAlign: "center",
              marginTop: "20px"
            }), libs.createComponent(EOM_Label.EOM_Label, {
              get text() {
                return `[${loginState().step}/${loginState().maxStep}]Loading...`;
              },
              horizontalAlign: "center",
              marginTop: "20px"
            })];
          }
        });
      }
    }));
    libs.effect(_$p => libs.setProp(_el$, "className", libs.classNames({
      Hidden: isMapTest || (gameState()?.state ?? "GameState_None") != "GameState_None"
    }), _$p));
    return _el$;
  })();
};
libs.render(() => libs.createComponent(GameStart, {}), $.GetContextPanel());