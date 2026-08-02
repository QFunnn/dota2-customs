--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('battle_pass_config', exports); const require = GameUI.__require;

const BP_SEASON_CONFIG = {
  [1]: {
    exp: 9900102,
    maxLevel: 100,
    expPerPurchase: 1000
  },
  [2]: {
    exp: 9900107,
    maxLevel: 100,
    expPerPurchase: 200
  },
  [3]: {
    exp: 9900233,
    maxLevel: 60,
    expPerPurchase: 200
  },
  [4]: {
    exp: 9900250,
    maxLevel: 60,
    expPerPurchase: 200
  },
  [5]: {
    exp: 9900257,
    maxLevel: 90,
    expPerPurchase: 200
  },
  [6]: {
    exp: 9900270,
    maxLevel: 90,
    expPerPurchase: 200
  },
  [7]: {
    plus: 9900281,
    rush: 9900282,
    exp: 9900283,
    maxLevel: 90,
    expPerPurchase: 200,
    preview: 5100008
  },
  [8]: {
    plus: 9900286,
    rush: 9900287,
    exp: 9900288,
    maxLevel: 90,
    expPerPurchase: 200,
    preview: 5100022
  },
  [9]: {
    plus: 9900401,
    rush: 9900402,
    exp: 9900403,
    maxLevel: 90,
    expPerPurchase: 200,
    preview: 5100032
  },
  [10]: {
    plus: 9900404,
    rush: 9900405,
    exp: 9900406,
    maxLevel: 90,
    expPerPurchase: 200,
    preview: 5100041
  },
  [11]: {
    plus: 9900407,
    rush: 9900408,
    exp: 9900409,
    maxLevel: 90,
    expPerPurchase: 200,
    preview: 5100008
  },
  [12]: {
    plus: 9900410,
    rush: 9900411,
    exp: 9900412,
    maxLevel: 90,
    expPerPurchase: 200,
    preview: 5100014
  },
  [98]: {
    exp: 9900237,
    maxLevel: 30,
    expPerPurchase: 100
  },
  [99]: {
    exp: 9900230,
    maxLevel: 30,
    expPerPurchase: 100
  }
};
function getBattlePassSeasonByExpProduct(productID) {
  for (const season in BP_SEASON_CONFIG) {
    if (BP_SEASON_CONFIG[season].exp == productID) return Number(season);
  }
  return undefined;
}

exports.BP_SEASON_CONFIG = BP_SEASON_CONFIG;
exports.getBattlePassSeasonByExpProduct = getBattlePassSeasonByExpProduct;