--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('carnival_entry', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Label = require('./EOM_Label.js');
var EOM_Button = require('./EOM_Button.js');

const NewRegressionIcon = props => {
  const [local, others] = libs.splitProps(props, ["show_tooltip", "children"]);
  let timer;
  libs.onCleanup(() => {
    if (timer) {
      $.CancelScheduled(timer);
    }
  });
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
        className: libs.classNames("NewRegressionIcon", {
          ShowTooltip: local.show_tooltip
        })
      }), {
        get hittest() {
          return !local.show_tooltip;
        }
      }), null);
      libs.createElement("DOTAParticleScenePanel", {
        id: "NewRegressionIcon_Particle",
        hittest: false,
        particleName: "particles/eom/ui/ui_fx/activity_special_player.vpcf",
        squarePixels: true,
        startActive: false,
        cameraOrigin: "0 0 300",
        lookAt: "0 0 0",
        fov: 25
      }, _el$);
      const _el$3 = libs.createElement("Image", {
        id: "NewRegressionIcon_Image"
      }, _el$);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("NewRegressionIcon", {
        ShowTooltip: local.show_tooltip
      })
    }), {
      get hittest() {
        return !local.show_tooltip;
      }
    }), true);
    libs.setProp(_el$3, "onmouseover", self => {
      if (local.show_tooltip) {
        if (timer) {
          $.CancelScheduled(timer);
        }
        timer = $.Schedule(0.2, () => {
          timer = undefined;
          if (self?.IsValid()) {
            let p = self.GetParent();
            let scene = p?.FindChild("NewRegressionIcon_Particle");
            if (scene) {
              scene.style.opacity = ".7";
              scene.StartParticles();
            }
            self.AddClass("Hover");
            $.DispatchEvent("DOTAShowTitleTextTooltip", self, "#ActivitySpecialPlayer", "#ActivitySpecialPlayer_description");
          }
        });
      }
    });
    libs.setProp(_el$3, "onmouseout", self => {
      if (timer) {
        $.CancelScheduled(timer);
      }
      timer = undefined;
      let p = self.GetParent();
      let scene = p?.FindChild("NewRegressionIcon_Particle");
      if (scene) {
        scene.style.opacity = "0.01";
        scene.StopParticlesWithEndcaps();
      }
      self.RemoveClass("Hover");
      $.DispatchEvent("DOTAHideTitleTextTooltip", self);
    });
    return _el$;
  })();
};

const CARNIVAL_ACTIVITY_ID = 1006;
const isCarnivalActivityOpen = data => {
  const now = Math.floor(Date.now() / 1000);
  return data?.some(activityInfo => activityInfo.activity_id == CARNIVAL_ACTIVITY_ID && activityInfo.start_time <= now && (activityInfo.end_time > now || activityInfo.end_time == 0)) == true;
};
const useCarnivalActivityOpen = () => {
  const [open, setOpen] = libs.createSignal(false);
  let boundaryTimer;
  libs.onMount(() => {
    const updateActivityState = data => {
      if (boundaryTimer != undefined) {
        $.CancelScheduled(boundaryTimer);
        boundaryTimer = undefined;
      }
      setOpen(isCarnivalActivityOpen(data));
      const activityInfo = data?.find(info => info.activity_id == CARNIVAL_ACTIVITY_ID);
      if (!activityInfo) return;
      const now = Math.floor(Date.now() / 1000);
      const boundaryTime = now < activityInfo.start_time ? activityInfo.start_time : activityInfo.end_time > now ? activityInfo.end_time : 0;
      if (boundaryTime > now) {
        boundaryTimer = $.Schedule(boundaryTime - now + 0.1, () => updateActivityState(data));
      }
    };
    const gameEventID = useNetData("info_activity_data", updateActivityState);
    callAction("activity_data", {
      activity_id: CARNIVAL_ACTIVITY_ID
    });
    libs.onCleanup(() => {
      GameEvents.Unsubscribe(gameEventID);
      if (boundaryTimer != undefined) $.CancelScheduled(boundaryTimer);
    });
  });
  return open;
};
const openCarnivalActivity = () => {
  ToggleWindows("MenuButton_activity", true);
  clientSideEvent("switchActivityTag", {
    id: "Activity_Carnival"
  });
};
const CarnivalEntry = props => {
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    get className() {
      return libs.classNames("CarnivalEntry", props.variant);
    },
    get children() {
      return [libs.createComponent(EOM_Button.EOM_BaseButton, {
        className: "CarnivalEntryButton",
        get customTooltip() {
          return props.variant == "hero" ? {
            name: "carnival_hero_tip"
          } : undefined;
        },
        tooltipPosition: "bottom",
        onactivate: openCarnivalActivity,
        get children() {
          return libs.createComponent(libs.Show, {
            get when() {
              return props.variant != "icon";
            },
            get children() {
              const _el$ = libs.createElement("DOTAParticleScenePanel", {
                particleName: "particles/eom/ui/ui_fx/ui_game_k3_buttom_fx.vpcf",
                cameraOrigin: "0 0 400",
                lookAt: "0 0 0",
                fov: 25,
                squarePixels: true,
                particleonly: true,
                hittest: false
              }, null);
              libs.setProp(_el$, "className", "CarnivalEntryButtonParticle");
              return _el$;
            }
          });
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return props.variant == "icon";
        },
        get children() {
          return libs.createComponent(EOM_Label.EOM_Label, {
            className: "CarnivalEntryIconLabel",
            text: "#Activity_Carnival",
            hittest: false
          });
        }
      })];
    }
  });
};

exports.CarnivalEntry = CarnivalEntry;
exports.NewRegressionIcon = NewRegressionIcon;
exports.useCarnivalActivityOpen = useCarnivalActivityOpen;