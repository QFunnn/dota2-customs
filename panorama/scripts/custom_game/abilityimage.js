--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('AbilityImage', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');

const AbilityImage = props => {
  const tooltip = libs.createMemo(() => {
    return {
      name: "hero_ability",
      abilityName: props.abilityName,
      entIndex: props.entIndex,
      player_id: props.playerID
    };
  });
  let oldTexture = "";
  const [refresh, setRefresh] = libs.createSignal(false);
  let timer;
  libs.createEffect(() => {
    if (props.abilityName && props.abilityIndex && props.abilityIndex != -1) {
      if (timer != undefined) {
        clearInterval(timer);
        timer = undefined;
      }
      oldTexture = Abilities.GetAbilityTextureName(props.abilityIndex);
      timer = setInterval(() => {
        let newTexture = Abilities.GetAbilityTextureName(props.abilityIndex);
        if (newTexture != oldTexture) {
          oldTexture = newTexture;
          setRefresh(v => !v);
        }
      }, 100);
    } else {
      if (timer != undefined) {
        clearInterval(timer);
        timer = undefined;
      }
    }
  });
  libs.onCleanup(() => {
    if (timer != undefined) {
      clearInterval(timer);
    }
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    className: "AbilityImage",
    get customTooltip() {
      return tooltip();
    },
    get children() {
      return (() => {
        refresh();
        return (() => {
          const _el$ = libs.createElement("DOTAAbilityImage", {
            get abilityname() {
              return props.abilityName;
            },
            get contextEntityIndex() {
              return props.abilityIndex;
            }
          }, null);
          libs.effect(_p$ => {
            const _v$ = props.abilityName,
              _v$2 = props.abilityIndex;
            _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$, "abilityname", _v$, _p$._v$));
            _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$, "contextEntityIndex", _v$2, _p$._v$2));
            return _p$;
          }, {
            _v$: undefined,
            _v$2: undefined
          });
          return _el$;
        })();
      })();
    }
  });
};

exports.AbilityImage = AbilityImage;