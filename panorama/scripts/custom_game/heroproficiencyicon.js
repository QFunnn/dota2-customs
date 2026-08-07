--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('HeroProficiencyIcon', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Image = require('./EOM_Image.js');

const HeroProficiencyIcon = props => {
  const merged = libs.mergeProps$1({
    value: 0,
    size: "normal",
    showtooltip: false,
    playerID: Players.GetLocalPlayer(),
    showParticle: false
  }, props);
  const [local, others] = libs.splitProps(merged, ["override_level", "size", "children", "showtooltip", "playerID", "heroID", "showParticle", "hittest"]);
  const resolved = libs.children(() => local.children);
  const [level, setLevel] = libs.createSignal(0);
  const updateLevel = () => {
    if (local.override_level != undefined) {
      setLevel(local.override_level);
      return;
    }
    let result = 0;
    if (local.heroID != undefined && local.playerID != undefined) {
      const cacheData = getServiceNetTable("player_hero_medal_level", local.playerID);
      if (cacheData) {
        result = cacheData[local.heroID.toString()] ?? 0;
      }
    }
    setLevel(result);
  };
  libs.createEffect(libs.on(() => {
    return {
      _override_level: local.override_level,
      _playerID: local.playerID,
      _heroID: local.heroID
    };
  }, () => {
    updateLevel();
  }));
  libs.onMount(() => {
    const id = useServiceNetTable("player_hero_medal_level", () => {
      updateLevel();
    }, -1);
    libs.onCleanup(() => {
      CustomNetTables.UnsubscribeNetTableListener(id);
    });
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
    className: libs.classNames("HeroProficiencyIcon", local.size, "Level" + level(), {
      TooltipMode: local.showtooltip
    })
  }), {
    get hittest() {
      return local.hittest;
    },
    onmouseover: self => {
      if (local.showtooltip) {
        $.DispatchEvent("DOTAShowTextTooltip", self, "#HeroProficiency_" + level());
      }
    },
    onmouseout: self => {
      if (local.showtooltip) {
        $.DispatchEvent("DOTAHideTextTooltip", self);
      }
    },
    get children() {
      return [libs.createComponent(libs.Show, {
        get when() {
          return local.showParticle;
        },
        get children() {
          return libs.createElement("DOTAScenePanel", {
            id: "HeroProficiencyIconFX",
            hittest: false,
            map: "scenes/rank_tier_ambient",
            camera: "camera_1"
          }, null);
        }
      }), libs.createComponent(EOM_Image.EOM_Image, {
        id: "HeroProficiencyIconMedal",
        get hittest() {
          return local.hittest;
        }
      }), libs.memo(() => resolved())];
    }
  }));
};

exports.HeroProficiencyIcon = HeroProficiencyIcon;