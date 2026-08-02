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
var EOM_Tooltip = require('./EOM_Tooltip.js');

let pTooltipPanel = $.GetContextPanel();
pTooltipPanel.style.minHeight = "0px";
pTooltipPanel.FindAncestor("attribute_detail").FindChildTraverse("LeftArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("attribute_detail").FindChildTraverse("RightArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("attribute_detail").FindChildTraverse("TopArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("attribute_detail").FindChildTraverse("BottomArrow").style.opacity = "0";
function TooltipContents(props) {
  let {
    entIndex
  } = props;
  let unitStates = GetUnitStates(entIndex) ?? {};
  const attribute = {
    Attack: Round(unitStates.Attack ?? 0),
    Attackspeed: Round(Entities.GetAttacksPerSecond(entIndex) ?? 0, 2),
    Critical: Round(unitStates.Critical ?? 0),
    CriticalDamage: Round(unitStates.CriticalDamage ?? 0),
    Evasion: Round(unitStates.Evasion ?? 0),
    EvasionReduce: Round(unitStates.EvasionReduce ?? 0),
    Power: Round(unitStates.Power ?? 0),
    PhysicalReduce: Math.min(100, -Round(unitStates.PhysicalReduce ?? 0)),
    MagicalReduce: Math.min(100, -Round(unitStates.MagicalReduce ?? 0)),
    PhysicalDamage: Round(unitStates.PhysicalDamage ?? 0),
    MagicalDamage: Round(unitStates.MagicalDamage ?? 0),
    StateResistance: Math.min(100, Round(unitStates.StateResistance ?? 0)),
    ManaRegen: Round(unitStates.ManaRegen ?? 0),
    Shield: Round(unitStates.Shield ?? 0),
    Injury: Round(unitStates.Injury ?? 0),
    Fury: Round(unitStates.Fury ?? 0),
    Ice: Round(unitStates.Ice ?? 0),
    Poison: Round(unitStates.Poison ?? 0),
    FuryPct: Round(unitStates.FuryPct ?? 0),
    IcePct: Round(unitStates.IcePct ?? 0),
    Regen: Round(unitStates.Regen ?? 0),
    RegenPct: Round(unitStates.RegenPct ?? 0),
    WispInterval: Round(unitStates.WispInterval ?? 0, 2),
    ChaosDamage: Round(unitStates.ChaosDamage ?? 0),
    Chaos: Round(unitStates.Chaos ?? 0)
  };
  return libs.createComponent(EOM_Tooltip.EOM_Tooltip, {
    flowChildren: "down",
    get children() {
      return [(() => {
        const _el$ = libs.createElement("Panel", {
          "class": "Horizontal"
        }, null);
        libs.insert(_el$, libs.createComponent(AttributeRow, {
          name: "#Attribute_Attack",
          get value() {
            return attribute.Attack;
          }
        }), null);
        libs.insert(_el$, libs.createComponent(AttributeRow, {
          name: "#Attribute_Attackspeed",
          get value() {
            return attribute.Attackspeed;
          }
        }), null);
        return _el$;
      })(), (() => {
        const _el$2 = libs.createElement("Panel", {
          "class": "Horizontal"
        }, null);
        libs.insert(_el$2, libs.createComponent(AttributeRow, {
          name: "#Attribute_CritChance",
          get value() {
            return attribute.Critical + "%";
          }
        }), null);
        libs.insert(_el$2, libs.createComponent(AttributeRow, {
          name: "#Attribute_CritDamage",
          get value() {
            return attribute.CriticalDamage + "%";
          }
        }), null);
        return _el$2;
      })(), (() => {
        const _el$3 = libs.createElement("Panel", {
          "class": "Horizontal"
        }, null);
        libs.insert(_el$3, libs.createComponent(AttributeRow, {
          name: "#Attribute_Evasion",
          get value() {
            return attribute.Evasion + "%";
          }
        }), null);
        libs.insert(_el$3, libs.createComponent(AttributeRow, {
          name: "#Attribute_EvasionReduce",
          get value() {
            return attribute.EvasionReduce + "%";
          }
        }), null);
        return _el$3;
      })(), (() => {
        const _el$4 = libs.createElement("Panel", {
          "class": "Horizontal"
        }, null);
        libs.insert(_el$4, libs.createComponent(AttributeRow, {
          name: "#dota_ability_variable_ulti",
          get value() {
            return attribute.Power + "%";
          }
        }), null);
        libs.insert(_el$4, libs.createComponent(AttributeRow, {
          name: "#Attribute_ManaRegen",
          get value() {
            return attribute.ManaRegen;
          }
        }), null);
        return _el$4;
      })(), (() => {
        const _el$5 = libs.createElement("Panel", {
          "class": "Horizontal"
        }, null);
        libs.insert(_el$5, libs.createComponent(AttributeRow, {
          name: "#Attribute_PhysicalDamage",
          get value() {
            return attribute.PhysicalDamage + "%";
          }
        }), null);
        libs.insert(_el$5, libs.createComponent(AttributeRow, {
          name: "#Attribute_MagicalDamage",
          get value() {
            return attribute.MagicalDamage + "%";
          }
        }), null);
        return _el$5;
      })(), (() => {
        const _el$6 = libs.createElement("Panel", {
          "class": "Horizontal"
        }, null);
        libs.insert(_el$6, libs.createComponent(AttributeRow, {
          name: "#Attribute_PhysicalReduce",
          get value() {
            return attribute.PhysicalReduce + "%";
          }
        }), null);
        libs.insert(_el$6, libs.createComponent(AttributeRow, {
          name: "#Attribute_MagicalReduce",
          get value() {
            return attribute.MagicalReduce + "%";
          }
        }), null);
        return _el$6;
      })(), (() => {
        const _el$7 = libs.createElement("Panel", {
          "class": "Horizontal"
        }, null);
        libs.insert(_el$7, libs.createComponent(AttributeRow, {
          name: "#Attribute_WispInterval",
          get value() {
            return attribute.WispInterval;
          }
        }), null);
        libs.insert(_el$7, libs.createComponent(AttributeRow, {
          name: "#Attribute_Poison",
          get value() {
            return attribute.Poison;
          }
        }), null);
        return _el$7;
      })(), (() => {
        const _el$8 = libs.createElement("Panel", {
          "class": "Horizontal"
        }, null);
        libs.insert(_el$8, libs.createComponent(AttributeRow, {
          name: "#Attribute_Shield",
          get value() {
            return attribute.Shield;
          }
        }), null);
        libs.insert(_el$8, libs.createComponent(AttributeRow, {
          name: "#Attribute_Injury",
          get value() {
            return attribute.Injury;
          }
        }), null);
        return _el$8;
      })(), (() => {
        const _el$9 = libs.createElement("Panel", {
          "class": "Horizontal"
        }, null);
        libs.insert(_el$9, libs.createComponent(AttributeRow, {
          name: "#Attribute_Fury",
          get value() {
            return attribute.FuryPct + "% + " + attribute.Fury;
          }
        }), null);
        libs.insert(_el$9, libs.createComponent(AttributeRow, {
          name: "#Attribute_Ice",
          get value() {
            return attribute.IcePct + "% + " + attribute.Ice;
          }
        }), null);
        return _el$9;
      })(), (() => {
        const _el$0 = libs.createElement("Panel", {
          "class": "Horizontal"
        }, null);
        libs.insert(_el$0, libs.createComponent(AttributeRow, {
          name: "#Attribute_HealAmplify",
          get value() {
            return attribute.RegenPct + "%";
          }
        }), null);
        libs.insert(_el$0, libs.createComponent(AttributeRow, {
          name: "#Attribute_Regen",
          get value() {
            return attribute.Regen;
          }
        }), null);
        return _el$0;
      })(), (() => {
        const _el$1 = libs.createElement("Panel", {
          "class": "Horizontal"
        }, null);
        libs.insert(_el$1, libs.createComponent(AttributeRow, {
          name: "#Attribute_ChaosBonusDamage",
          get value() {
            return attribute.ChaosDamage;
          }
        }), null);
        libs.insert(_el$1, libs.createComponent(AttributeRow, {
          name: "#Attribute_Chaos",
          get value() {
            return attribute.Chaos;
          }
        }), null);
        return _el$1;
      })(), (() => {
        const _el$10 = libs.createElement("Panel", {
          "class": "Horizontal"
        }, null);
        libs.insert(_el$10, libs.createComponent(AttributeRow, {
          name: "#Attribute_StateResistance",
          get value() {
            return attribute.StateResistance + "%";
          }
        }));
        return _el$10;
      })()];
    }
  });
}
function AttributeRow(params) {
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    "class": "AttributeRow",
    get children() {
      return [(() => {
        const _el$11 = libs.createElement("Label", {
          "class": "AttributeName",
          get text() {
            return params.name;
          }
        }, null);
        libs.effect(_$p => libs.setProp(_el$11, "text", params.name, _$p));
        return _el$11;
      })(), (() => {
        const _el$12 = libs.createElement("Label", {
          "class": "AttributeValue",
          get text() {
            return params.value;
          }
        }, null);
        libs.effect(_$p => libs.setProp(_el$12, "text", params.value, _$p));
        return _el$12;
      })()];
    }
  });
}
function SetupTooltip() {
  let entIndex = pTooltipPanel.GetAttributeInt("entIndex", -1);
  libs.render(() => libs.createComponent(TooltipContents, {
    entIndex: entIndex
  }), pTooltipPanel);
}
(function () {
  pTooltipPanel.SetPanelEvent("ontooltiploaded", SetupTooltip);
  {
    let pArrow = pTooltipPanel.GetParent()?.FindChildTraverse("LeftArrow");
    if (pArrow) {
      pArrow.style.washColor = "#12141a";
    }
    pArrow = pTooltipPanel.GetParent()?.FindChildTraverse("RightArrow");
    if (pArrow) {
      pArrow.style.washColor = "#12141a";
    }
  }
  {
    let pArrow = pTooltipPanel.GetParent()?.GetParent()?.FindChildTraverse("TopArrow");
    if (pArrow) {
      pArrow.style.washColor = "#12141a";
    }
    pArrow = pTooltipPanel.GetParent()?.GetParent()?.FindChildTraverse("BottomArrow");
    if (pArrow) {
      pArrow.style.washColor = "#12141a";
    }
  }
  pTooltipPanel.style.minHeight = "150px";
})();