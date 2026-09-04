--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local ____exports = {}
local AKItems = require("json.ak_items")
local AKItemsPotion = require("json.ak_items_potion")
local AKItemsStone = require("json.ak_items_stone")
____exports.AK_ITEMS_ALL = __TS__ObjectAssign({}, AKItems, AKItemsPotion, AKItemsStone)
return ____exports