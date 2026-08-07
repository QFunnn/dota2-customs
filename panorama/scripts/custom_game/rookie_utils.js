--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('rookie_utils', exports); const require = GameUI.__require;

var libs = require('./libs.js');

function useRookieV2Effect(params, createDelay, customToggleOn = false) {
  const [_ref, setRef] = libs.createSignal();
  const [enable, setEnable] = libs.createSignal(false);
  const [lightingPanel, setLightingPanel] = libs.createSignal([]);
  let localStage = -1;
  let hidden = false;
  if (KeyValues.RookieGuideKV[params.key]) {
    if (typeof KeyValues.RookieGuideKV[params.key].orderby == "number") {
      localStage = KeyValues.RookieGuideKV[params.key].orderby;
    }
    if (KeyValues.RookieGuideKV[params.key].hidden == 1) {
      hidden = true;
    }
  } else {
    hidden = true;
  }
  let closed = hidden;
  const [tempHide, setTempHide] = libs.createSignal(false);
  const [customToggleState, setCustomToggleState] = libs.createSignal(!customToggleOn);
  const showState = () => enable() && !tempHide();
  const [rookie_v2, setRookieV2Enable] = libs.createSignal(false);
  libs.createEffect(libs.on(rookie_v2, v => {
    checkRookieProgress();
  }));
  libs.createEffect(libs.on(customToggleState, v => {
    if (v) {
      checkRookieProgress();
    }
  }));
  const checkRookieProgress = (data = getClientGlobalData("rookie_v2_progress")) => {
    if (rookie_v2() && data) {
      if (closed) {
        setEnable(false);
        return;
      }
      if (localStage == -1) return;
      if (!customToggleOn || customToggleState()) {
        onToggleRookieProgess(data);
      }
    } else {
      setEnable(false);
    }
  };
  const onToggleRookieProgess = (data = getClientGlobalData("rookie_v2_progress")) => {
    if (closed) return;
    if (data.stage == localStage - 1 && !data.state) {
      if (createDelay) {
        $.Schedule(createDelay, () => {
          setEnable(true);
          if (tempHide()) {
            clientSideEvent("rookieV2_hide", {
              key: params.key,
              state: true
            });
          }
          let v = Object.assign({
            state: true,
            stage: localStage
          }, params);
          setClientGlobalData("rookie_v2_progress", v, true);
          GameEvents.SendCustomEventToServer("rookie_v2_progress", v);
        });
      } else {
        setEnable(true);
        if (tempHide()) {
          clientSideEvent("rookieV2_hide", {
            key: params.key,
            state: true
          });
        }
        let v = Object.assign({
          state: true,
          stage: localStage
        }, params);
        setClientGlobalData("rookie_v2_progress", v, true);
        GameEvents.SendCustomEventToServer("rookie_v2_progress", v);
      }
    } else if (data.stage != localStage) {
      setEnable(false);
    }
  };
  libs.createEffect(() => {
    if (closed) return;
    if (enable() && lightingPanel().length > 0) {
      setClientGlobalData("rookie_v2_lightings", {
        [params.key]: lightingPanel()
      }, true);
    }
  });
  let resumeTipsID;
  const resumeTips = (delay = 0) => {
    if (closed) return;
    if (!tempHide()) return;
    if (resumeTipsID != undefined) {
      $.CancelScheduled(resumeTipsID);
      resumeTipsID = undefined;
    }
    if (!enable()) {
      setTempHide(false);
      resumeTipsID = $.Schedule(delay, () => {
        resumeTipsID = undefined;
        let ref = _ref();
        if (ref?.IsValid()) {
          let pos = ref.GetPositionWithinWindow();
          if (isFinite(pos.x)) {
            setLightingPanel([{
              x: pos.x - padding_x,
              y: pos.y - padding_y,
              width: ref.actuallayoutwidth + padding_x * 2,
              height: ref.actuallayoutheight + padding_y * 2,
              uiscaleX: ref.actualuiscale_x,
              uiscaleY: ref.actualuiscale_y
            }]);
          }
        }
      });
      return;
    } else {
      if (_ref()?.IsValid()) {
        resumeTipsID = $.Schedule(delay, () => {
          resumeTipsID = undefined;
          clientSideEvent("rookieV2_hide", {
            key: params.key,
            state: false
          });
          let ref = _ref();
          if (ref?.IsValid()) {
            let pos = ref.GetPositionWithinWindow();
            if (isFinite(pos.x)) {
              setLightingPanel([{
                x: pos.x - padding_x,
                y: pos.y - padding_y,
                width: ref.actuallayoutwidth + padding_x * 2,
                height: ref.actuallayoutheight + padding_y * 2,
                uiscaleX: ref.actualuiscale_x,
                uiscaleY: ref.actualuiscale_y
              }]);
            }
          }
        });
      } else {
        clientSideEvent("rookieV2_hide", {
          key: params.key,
          state: false
        });
      }
    }
  };
  const hideTips = () => {
    if (closed) return;
    if (resumeTipsID != undefined) {
      $.CancelScheduled(resumeTipsID);
      resumeTipsID = undefined;
    }
    if (tempHide()) return;
    if (!enable()) {
      setTempHide(true);
    } else {
      clientSideEvent("rookieV2_hide", {
        key: params.key,
        state: true
      });
    }
  };
  libs.onMount(() => {
    const gameEventIDList = [];
    gameEventIDList.push(useClientGlobalData("rookie_v2", data => {
      setRookieV2Enable(data.state);
    }));
    if (localStage != -1) {
      gameEventIDList.push(useClientGlobalData("rookie_v2_progress", data => {
        if (closed) return;
        checkRookieProgress();
        if (data.stage == -1 || data.stage == localStage) {
          setEnable(data.state);
        }
      }));
      gameEventIDList.push(useClientSideEvent("rookieV2_close", data => {
        let stage = -1;
        if (KeyValues.RookieGuideKV[data.key] && typeof KeyValues.RookieGuideKV[data.key].orderby == "number") {
          stage = KeyValues.RookieGuideKV[data.key].orderby;
        }
        if (stage == -1) return;
        if (stage >= localStage) {
          closed = true;
          setEnable(false);
          setLightingPanel([]);
        }
      }));
      gameEventIDList.push(useClientSideEvent("rookieV2_hide", data => {
        if (data.key == params.key) {
          setTempHide(data.state);
        }
      }));
    }
    libs.onCleanup(() => {
      if (resumeTipsID != undefined) {
        $.CancelScheduled(resumeTipsID);
        resumeTipsID = undefined;
      }
      closeRookieV2Tip(params.key);
      gameEventIDList.forEach(id => GameEvents.Unsubscribe(id));
    });
  });
  let padding_x = 8;
  let padding_y = 8;
  const createLightingOnPanel = (delay = 0) => {
    $.Schedule(delay, () => {
      let ref = _ref();
      if (ref?.IsValid()) {
        let pos = ref.GetPositionWithinWindow();
        if (isFinite(pos.x)) {
          setLightingPanel([{
            x: pos.x - padding_x,
            y: pos.y - padding_y,
            width: ref.actuallayoutwidth + padding_x * 2,
            height: ref.actuallayoutheight + padding_y * 2,
            uiscaleX: ref.actualuiscale_x,
            uiscaleY: ref.actualuiscale_y
          }]);
        }
      }
    });
  };
  libs.createEffect(libs.on([enable, _ref], () => {
    if (enable()) {
      createLightingOnPanel();
    }
  }));
  return {
    setRef: setRef,
    state: showState,
    temp_hide: tempHide,
    createLightingOnPanel: createLightingOnPanel,
    resumeTips: resumeTips,
    hideTips: hideTips,
    customToggleOn: setCustomToggleState
  };
}
function useRookieV2Effect_Override(params, createDelay) {
  const [_ref, setRef] = libs.createSignal();
  const [enable, setEnable] = libs.createSignal(false);
  const [rookie_v2, setRookieV2Enable] = libs.createSignal(false);
  let delayTimer;
  let completed = false;
  let rookieGroup = KeyValues.RookieGuideKV[params.key]?.group;
  let localGroupOrderby = KeyValues.RookieGuideKV[params.key]?.group_orderby;
  const [customState, setCustomState] = libs.createSignal((() => {
    if (rookieGroup != undefined && localGroupOrderby != undefined && localGroupOrderby > 1) {
      return false;
    }
    return true;
  })());
  const OnOpenRookie = () => {
    if (completed) return;
    if (!rookie_v2()) {
      setEnable(false);
      return;
    }
    setEnable(true);
  };
  const OnCloseRookie = () => {
    if (delayTimer != undefined) {
      $.CancelScheduled(delayTimer);
      delayTimer = undefined;
    }
    if (enable()) {
      if (rookieGroup) {
        setClientGlobalData("rookie_v2_override_group", {
          [rookieGroup]: "DELETE"
        });
      }
    }
    setClientGlobalData("rookie_v2_override_data", {
      state: false,
      key: params.key
    }, true);
  };
  const OnComplete = () => {
    OnCloseRookie();
    completed = true;
    if (rookieGroup && localGroupOrderby != undefined) {
      setClientGlobalData("rookie_v2_override_group", {
        [rookieGroup]: localGroupOrderby
      });
    }
  };
  libs.onMount(() => {
    const gameEventIDList = [];
    gameEventIDList.push(useClientGlobalData("rookie_v2", data => {
      setRookieV2Enable(data.state);
    }));
    gameEventIDList.push(useClientGlobalData("rookie_v2_override_data", data => {
      if (!data.state && (data.key == "" || data.key == params.key)) {
        setEnable(false);
      }
    }));
    gameEventIDList.push(useClientGlobalData("rookie_v2_override_group", data => {
      if (!rookieGroup) {
        return;
      }
      if (data?.[rookieGroup] == undefined) {
        if (localGroupOrderby == 1 || localGroupOrderby == undefined) {
          setCustomState(true);
          return;
        }
      } else {
        if (localGroupOrderby && localGroupOrderby == data[rookieGroup] + 1) {
          setCustomState(true);
          return;
        }
      }
      setCustomState(false);
    }));
    libs.onCleanup(() => {
      if (delayTimer != undefined) {
        $.CancelScheduled(delayTimer);
        delayTimer = undefined;
      }
      gameEventIDList.forEach(id => GameEvents.Unsubscribe(id));
    });
  });
  libs.createEffect(libs.on(() => {
    return {
      enable: enable(),
      customState: customState(),
      _ref: _ref()
    };
  }, () => {
    if (enable() && customState() && _ref()?.IsValid()) {
      if (createDelay) {
        delayTimer = $.Schedule(createDelay, () => {
          delayTimer = undefined;
          syncData();
        });
      } else {
        syncData();
      }
    }
  }));
  let padding_x = 8;
  let padding_y = 8;
  const syncData = () => {
    if (!enable()) return;
    let ref = _ref();
    if (ref?.IsValid()) {
      let pos = ref.GetPositionWithinWindow();
      if (isFinite(pos.x)) {
        setClientGlobalData("rookie_v2_override_data", {
          state: true,
          key: params.key,
          params: params.params,
          lighting: [{
            x: pos.x - padding_x,
            y: pos.y - padding_y,
            width: ref.actuallayoutwidth + padding_x * 2,
            height: ref.actuallayoutheight + padding_y * 2,
            uiscaleX: ref.actualuiscale_x,
            uiscaleY: ref.actualuiscale_y
          }]
        }, true);
      }
    }
  };
  return {
    setRef: setRef,
    state: enable,
    open: OnOpenRookie,
    close: OnCloseRookie,
    complete: OnComplete
  };
}

exports.useRookieV2Effect = useRookieV2Effect;
exports.useRookieV2Effect_Override = useRookieV2Effect_Override;