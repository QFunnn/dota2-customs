--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');

function mountFeature(feature) {
  $.Msg(`[DotaCore] Mounting Panorama feature: ${feature.id}`);
  libs.render(() => feature.render(), $.GetContextPanel());
}

function FrameworkExampleHud() {
  const [status, setStatus] = libs.createSignal(GetLocalization("#FrameworkExample_Ready"));
  let requestId = 0;
  const listener = GameEvents.Subscribe("framework_example_pong", event => {
    setStatus(LocalizeWithVars("#FrameworkExample_Pong", {
      request_id: String(event.requestId),
      server_time: Number(event.serverTime).toFixed(2)
    }));
  });
  libs.onCleanup(() => GameEvents.Unsubscribe(listener));
  const ping = () => {
    requestId += 1;
    setStatus(LocalizeWithVars("#FrameworkExample_Waiting", {
      request_id: String(requestId)
    }));
    GameEvents.SendCustomGameEventToServer("framework_example_ping", {
      requestId
    });
  };
  return (() => {
    const _el$ = libs.createElement("Panel", {
        "class": "FrameworkExampleCard",
        flowChildren: "down"
      }, null),
      _el$2 = libs.createElement("Panel", {
        "class": "FrameworkExampleHeading"
      }, _el$);
      libs.createElement("Image", {
        "class": "FrameworkExampleIcon",
        src: "file://{images}/custom_game/framework_example/status.svg"
      }, _el$2);
      const _el$4 = libs.createElement("Label", {
        "class": "FrameworkExampleTitle",
        get text() {
          return GetLocalization("#FrameworkExample_Title");
        }
      }, _el$2),
      _el$5 = libs.createElement("Label", {
        "class": "FrameworkExampleStatus",
        get text() {
          return status();
        }
      }, _el$),
      _el$6 = libs.createElement("TextButton", {
        "class": "FrameworkExampleButton"
      }, _el$),
      _el$7 = libs.createElement("Label", {
        get text() {
          return GetLocalization("#FrameworkExample_Ping");
        }
      }, _el$6);
    libs.setProp(_el$, "flowChildren", "down");
    libs.setProp(_el$6, "onactivate", ping);
    libs.effect(_p$ => {
      const _v$ = GetLocalization("#FrameworkExample_Title"),
        _v$2 = status(),
        _v$3 = GetLocalization("#FrameworkExample_Ping");
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$4, "text", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$5, "text", _v$2, _p$._v$2));
      _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$7, "text", _v$3, _p$._v$3));
      return _p$;
    }, {
      _v$: undefined,
      _v$2: undefined,
      _v$3: undefined
    });
    return _el$;
  })();
}
mountFeature({
  id: "framework-example",
  render: () => libs.createComponent(FrameworkExampleHud, {})
});