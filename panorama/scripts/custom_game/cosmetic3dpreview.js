--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5e0d361 
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('cosmetic3DPreview', exports); const require = GameUI.__require;

var libs = require('./libs.js');

const Cosmetic3DPreview = props => {
  const [local, others] = libs.splitProps(props, ["class", "children", "cosmeticID"]);
  const cosmeticData = () => KeyValues.info_item_cosmetic[String(local.cosmeticID)];
  const [key, setKey] = libs.createSignal();
  const [sceneEnabled, setSceneEnabled] = libs.createSignal(false);
  const entityName = "cosmetic_3d_preview";
  let queueReleased = false;
  let reload = false;
  let queueToken = QueueSerialSceneEntityLoad(entityName, () => setSceneEnabled(true));
  const releaseQueueToken = () => {
    if (queueReleased) return;
    queueReleased = true;
    ReleaseSerialSceneEntityLoad(entityName, queueToken);
  };
  libs.onCleanup(() => {
    const waitingKey = key();
    if (waitingKey != undefined) {
      StopWaitSceneEntityLoad(entityName, waitingKey);
      setKey(undefined);
    }
    releaseQueueToken();
  });
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps$1(others, {
      get ["class"]() {
        return libs.classNames("Cosmetic3DPreview", local.class);
      }
    }), null);
    libs.spread(_el$, libs.mergeProps$1(others, {
      get ["class"]() {
        return libs.classNames("Cosmetic3DPreview", local.class);
      }
    }), true);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return libs.memo(() => !!sceneEnabled())() && cosmeticData()?.model;
      },
      get children() {
        const _el$2 = libs.createElement("DOTAScenePanel", {
          id: "Cosmetic3DPreviewScene",
          "animate-during-pause": true,
          map: "scene/cosmetic_3d_preview",
          camera: "camera_1",
          light: "portrait_light",
          renderdeferred: true,
          rendershadows: true,
          deferredalpha: true,
          particleonly: false,
          allowrotation: true,
          antialias: true
        }, null);
        libs.use(scene => {
          reload = false;
          setKey(WaitSceneEntityLoad(entityName, {
            cosmetic_id: String(local.cosmeticID)
          }));
          const checkUpdate = () => {
            const waitingKey = key();
            if (!scene.IsValid() || waitingKey == undefined) {
              if (waitingKey != undefined) {
                StopWaitSceneEntityLoad(entityName, waitingKey);
                setKey(undefined);
              }
              releaseQueueToken();
              return;
            }
            $.Schedule(0, checkUpdate);
          };
          checkUpdate();
        }, _el$2);
        libs.setProp(_el$2, "onload", () => {
          if (reload) {
            setSceneEnabled(false);
            queueReleased = false;
            queueToken = QueueSerialSceneEntityLoad(entityName, () => setSceneEnabled(true));
            return;
          }
          const waitingKey = key();
          if (waitingKey != undefined) {
            StopWaitSceneEntityLoad(entityName, waitingKey);
            setKey(undefined);
          }
          releaseQueueToken();
          reload = true;
        });
        return _el$2;
      }
    }), null);
    libs.insert(_el$, () => local.children, null);
    return _el$;
  })();
};

exports.Cosmetic3DPreview = Cosmetic3DPreview;