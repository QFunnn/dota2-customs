--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('TalentTree', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Image = require('./EOM_Image.js');
var EOM_Panel = require('./EOM_Panel.js');

const TalentTree = props => {
  const merged = libs.mergeProps$1({
    showTooltip: false
  }, props);
  const [local, others] = libs.splitProps(merged, ["playerID", "heroName", "showTooltip", "override_talents", "children"]);
  const tooltips = () => {
    if (local.showTooltip) {
      return {
        name: "talent_tree",
        heroName: local.heroName,
        playerID: local.playerID,
        override_talents: local.override_talents
      };
    }
    return undefined;
  };
  const getTalentData = heroName => {
    if (heroName == undefined) {
      return {};
    }
    const result = new Map();
    for (const talentName in KeyValues.HeroTalentKv) {
      const talentData = KeyValues.HeroTalentKv[talentName];
      if (talentData.Hero === heroName && talentData.RequiredLevel !== undefined) {
        if (!result.has(talentData.RequiredLevel)) {
          result.set(talentData.RequiredLevel, []);
        }
        result.get(talentData.RequiredLevel)?.push(talentName);
      }
    }
    result.forEach((talents, level) => {
      let leftTalent;
      let rightTalent;
      let otherTalents = [];
      talents.forEach(talentName => {
        const kv = KeyValues.HeroTalentKv[talentName];
        if (kv.UIDirection == "left" && !leftTalent) {
          leftTalent = talentName;
        } else if (kv.UIDirection == "right" && !rightTalent) {
          rightTalent = talentName;
        } else {
          otherTalents.push(talentName);
        }
      });
      const organizedTalents = [];
      if (!leftTalent) {
        let r = otherTalents.shift();
        if (r) {
          organizedTalents.push(r);
        }
      } else {
        organizedTalents.push(leftTalent);
      }
      if (rightTalent) {
        organizedTalents.push(rightTalent);
      }
      organizedTalents.push(...otherTalents);
      result.set(level, organizedTalents);
    });
    return Object.fromEntries(result);
  };
  const heroTalent = () => getTalentData(local.heroName);
  const overrideTalentArr = libs.createMemo(() => {
    let arr = JSON.parseSafe(local.override_talents ?? "");
    if (Array.isArray(arr)) {
      return arr;
    }
  });
  const [activatedTalentList, setActivatedTalentList] = libs.createSignal([]);
  libs.createEffect(libs.on(overrideTalentArr, v => {
    if (v != undefined) {
      setActivatedTalentList(v);
    }
  }));
  libs.createEffect(libs.on(() => local.playerID, v => {
    if (overrideTalentArr() == undefined) {
      if (v != undefined) {
        const data = CustomNetTables.GetTableValue("common", "hero_talent_" + local.playerID);
        if (data) {
          setActivatedTalentList(Object.values(data));
          return;
        }
      }
      setActivatedTalentList([]);
    }
  }));
  const ActivatedTreeBranch = libs.createMemo(() => {
    let list = [];
    let _heroTalent = heroTalent();
    let _activatedTalentList = activatedTalentList();
    if (_heroTalent && _activatedTalentList.length > 0) {
      Object.keys(_heroTalent).sort((a, b) => Number(a) - Number(b)).map((lv, index) => {
        if (_heroTalent[Number(lv)].length >= 2) {
          for (let i = 0; i <= 1; i++) {
            if (_activatedTalentList.includes(_heroTalent[Number(lv)][i])) {
              list.push(i + index * 2 + 1);
            }
          }
        }
      });
    }
    return list;
  });
  libs.onMount(() => {
    const id = CustomNetTables.SubscribeNetTableListener("common", (_, key, value) => {
      if (local.playerID != undefined && key == "hero_talent_" + local.playerID.toString()) {
        if (overrideTalentArr() == undefined) {
          setActivatedTalentList(Object.values(value));
        }
      }
    });
    libs.onCleanup(() => {
      CustomNetTables.UnsubscribeNetTableListener(id);
    });
  });
  return libs.createComponent(EOM_Image.EOM_Image, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
    className: "TalentTree"
  }), {
    get customTooltip() {
      return tooltips();
    },
    get children() {
      return [libs.createComponent(EOM_Image.EOM_Image, {
        get className() {
          return libs.classNames("TalentTreeBranch", {
            Activated: ActivatedTreeBranch().includes(1)
          });
        },
        id: "TalentTree1",
        hittest: false
      }), libs.createComponent(EOM_Image.EOM_Image, {
        get className() {
          return libs.classNames("TalentTreeBranch", {
            Activated: ActivatedTreeBranch().includes(2)
          });
        },
        id: "TalentTree2",
        hittest: false
      }), libs.createComponent(EOM_Image.EOM_Image, {
        get className() {
          return libs.classNames("TalentTreeBranch", {
            Activated: ActivatedTreeBranch().includes(3)
          });
        },
        id: "TalentTree3",
        hittest: false
      }), libs.createComponent(EOM_Image.EOM_Image, {
        get className() {
          return libs.classNames("TalentTreeBranch", {
            Activated: ActivatedTreeBranch().includes(4)
          });
        },
        id: "TalentTree4",
        hittest: false
      }), libs.createComponent(EOM_Image.EOM_Image, {
        get className() {
          return libs.classNames("TalentTreeBranch", {
            Activated: ActivatedTreeBranch().includes(5)
          });
        },
        id: "TalentTree5",
        hittest: false
      }), libs.createComponent(EOM_Image.EOM_Image, {
        get className() {
          return libs.classNames("TalentTreeBranch", {
            Activated: ActivatedTreeBranch().includes(6)
          });
        },
        id: "TalentTree6",
        hittest: false
      })];
    }
  }));
};

exports.TalentTree = TalentTree;