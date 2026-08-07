--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('HeroRoleCard', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Image = require('./EOM_Image.js');
var EOM_Portrait = require('./EOM_Portrait.js');
var GenericPanel = require('./GenericPanel.js');
var SectIcon = require('./SectIcon.js');

const HeroRoleCard = props => {
  const merged = libs.mergeProps$1({
    collected: false
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "heroName", "collected"]);
  const resolved = libs.children(() => local.children);
  const sectList = () => {
    let list = [];
    if (GameUI.CustomUIConfig().UnitsCommonKv[local.heroName].Sect) {
      list = GameUI.CustomUIConfig().UnitsCommonKv[local.heroName].Sect.split("|");
    }
    return list;
  };
  const [skinID, setSkinID] = libs.createSignal();
  const updateSkin = heroName => {
    const netTableData = getServiceNetTable("player_equipped_ornament", Players.GetLocalPlayer())?.[OrnamentType.HERO_SKIN];
    let _skinID;
    if (netTableData) {
      for (const oid in netTableData) {
        const kv = KeyValues.CosmeticsKv[oid];
        if (kv && kv.hero && GetHeroNameByGoodID(finiteNumber(Number(kv.hero))) == local.heroName) {
          _skinID = oid;
        }
      }
    }
    setSkinID(_skinID);
  };
  libs.createEffect(() => {
    updateSkin(local.heroName);
  });
  libs.onMount(() => {
    const id = useServiceNetTable("player_equipped_ornament", (data, playerID) => {
      updateSkin(local.heroName);
    }, Players.GetLocalPlayer());
    libs.onCleanup(() => {
      CustomNetTables.UnsubscribeNetTableListener(id);
    });
  });
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
        className: "HeroRoleCard"
      })), null),
      _el$2 = libs.createElement("Image", {}, _el$);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "HeroRoleCard"
    })), true);
    libs.setProp(_el$2, "className", "HeroCardBorder");
    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
      className: "HeroRoleCardContainer",
      get children() {
        return [libs.createComponent(EOM_Portrait.EOM_Portrait, {
          className: "HeroCardImage",
          get unitname() {
            return skinID() ?? local.heroName;
          },
          get model() {
            return GameUI.CustomUIConfig().UnitsCommonKv[local.heroName]?.Model;
          }
        }), (() => {
          const _el$3 = libs.createElement("Image", {}, null);
          libs.setProp(_el$3, "className", "HeroRoleCardBTMask");
          return _el$3;
        })(), libs.createComponent(GenericPanel.CLabel, {
          className: "UnitName",
          get text() {
            return "#" + local.heroName;
          }
        }), (() => {
          const _el$4 = libs.createElement("Panel", {}, null);
          libs.setProp(_el$4, "className", "SectIcons");
          libs.insert(_el$4, () => sectList().map((sectName, index) => {
            return libs.createComponent(SectIcon.SectIcon, {
              sectName: sectName,
              marginBottom: "-12px"
            });
          }));
          return _el$4;
        })(), libs.createComponent(libs.Show, {
          get when() {
            return local.collected;
          },
          get children() {
            return libs.createComponent(EOM_Image.EOM_Image, {
              className: "CollectedIcon"
            });
          }
        }), libs.memo(() => resolved())];
      }
    }), null);
    return _el$;
  })();
};

exports.HeroRoleCard = HeroRoleCard;