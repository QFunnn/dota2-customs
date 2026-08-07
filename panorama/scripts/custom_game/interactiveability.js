--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('InteractiveAbility', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Image = require('./EOM_Image.js');
var EOM_Label = require('./EOM_Label.js');

const InteractiveAbility = props => {
  const merged = libs.mergeProps$1({
    playerID: Players.GetLocalPlayer(),
    heroName: "",
    isHUD: false
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "heroName", "isHUD", "playerID"]);
  const resolved = libs.children(() => local.children);
  const [isActivated, setIsActivated] = libs.createSignal(false);
  const [interactiveAbilityIndex, setInteractiveAbilityIndex] = libs.createSignal(-1);
  const [entIndex, setEntIndex] = libs.createSignal(-1);
  const abilityName = () => {
    if (typeof KeyValues.UnitsCommonKv[local.heroName]?.InteractiveAbilityName == "string") {
      return KeyValues.UnitsCommonKv[local.heroName].InteractiveAbilityName;
    }
    return "empty";
  };
  const [abilityTextName, setAbilityTextName] = libs.createSignal(KeyValues.AbilitiesKv[abilityName()]?.AbilityTextureName ?? "empty");
  const [abilityChargeCount, setAbilityChargeCount] = libs.createSignal(0);
  const updatePlayerData = (data = CustomNetTables.GetTableValue("player_data", local.playerID.toString())) => {
    if (data) {
      setIsActivated(data.interAbilityState == 1);
      if (data.heroEntIndex != undefined) {
        setEntIndex(data.heroEntIndex);
        if (typeof KeyValues.UnitsCommonKv[local.heroName]?.InteractiveAbilityName == "string") {
          setInteractiveAbilityIndex(Entities.GetAbilityByName(data.heroEntIndex, KeyValues.UnitsCommonKv[local.heroName].InteractiveAbilityName) ?? -1);
        }
      }
    }
  };
  libs.createEffect(libs.on(() => local.playerID, () => {
    updatePlayerData();
  }));
  let timer;
  if (local.isHUD) {
    timer = setInterval(() => {
      if (interactiveAbilityIndex() != -1) {
        setAbilityTextName(Abilities.GetAbilityTextureName(interactiveAbilityIndex()) ?? "empty");
        setAbilityChargeCount(Abilities.GetCurrentAbilityCharges(interactiveAbilityIndex()));
      } else {
        setAbilityChargeCount(0);
        if (typeof KeyValues.UnitsCommonKv[local.heroName]?.InteractiveAbilityName == "string") {
          setInteractiveAbilityIndex(Entities.GetAbilityByName(entIndex(), KeyValues.UnitsCommonKv[local.heroName].InteractiveAbilityName) ?? -1);
        }
      }
    }, 30);
  } else {
    libs.createEffect(libs.on(abilityName, v => {
      setAbilityTextName(KeyValues.AbilitiesKv[v]?.AbilityTextureName ?? "empty");
    }));
  }
  libs.onMount(() => {
    const id = CustomNetTables.SubscribeNetTableListener("player_data", (_, key, value) => {
      if (key == local.playerID.toString()) {
        updatePlayerData(value);
      }
    });
    libs.onCleanup(() => {
      CustomNetTables.UnsubscribeNetTableListener(id);
      if (timer != undefined) {
        clearInterval(timer);
        timer = undefined;
      }
    });
  });
  const tooltip = libs.createMemo(() => {
    return {
      name: "hero_ability",
      abilityName: abilityName(),
      entIndex: entIndex(),
      player_id: local.playerID
    };
  });
  const src = () => {
    if ($.BImageFileExists(`file://{images}/spellicons/${abilityTextName()}.png`)) {
      return `file://{images}/spellicons/${abilityTextName()}.png`;
    }
    return `raw://resource/flash3/images/spellicons/${abilityTextName()}.png`;
  };
  return libs.createComponent(EOM_Panel.EOM_Panel, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
    className: libs.classNames("InteractiveAbility", {
      isActivated: isActivated()
    })
  }), {
    get children() {
      return [libs.createComponent(EOM_Image.EOM_Image, {
        className: "InteractiveAbilityImage",
        get src() {
          return src();
        },
        get customTooltip() {
          return tooltip();
        }
      }), libs.createComponent(EOM_Label.EOM_Label, {
        get visible() {
          return abilityChargeCount() > 0;
        },
        id: "InteractiveAbilityCharge",
        get text() {
          return `${abilityChargeCount()}`;
        }
      }), libs.memo(() => resolved())];
    }
  }));
};

exports.InteractiveAbility = InteractiveAbility;