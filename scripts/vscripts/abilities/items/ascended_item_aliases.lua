--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local ____item_0151 = require("abilities.items.item_0151")
local item_0175 = ____item_0151.item_0175
local ____item_0168 = require("abilities.items.item_0168")
local item_0168 = ____item_0168.item_0168
local ____item_0225 = require("abilities.items.item_0225")
local item_0225 = ____item_0225.item_0225
local ____item_0240 = require("abilities.items.item_0240")
local item_0240 = ____item_0240.item_0240
local ____item_0250 = require("abilities.items.item_0250")
local item_0250 = ____item_0250.item_0250
local ____item_0255 = require("abilities.items.item_0255")
local item_0255 = ____item_0255.item_0255
local ____item_0270 = require("abilities.items.item_0270")
local item_0270 = ____item_0270.item_0270
local ____item_0273 = require("abilities.items.item_0273")
local item_0273 = ____item_0273.item_0273
local ____item_0282 = require("abilities.items.item_0282")
local item_0282 = ____item_0282.item_0282
local ____item_0289 = require("abilities.items.item_0289")
local item_0289 = ____item_0289.item_0289
local ____item_0296 = require("abilities.items.item_0296")
local item_0296 = ____item_0296.item_0296
local ____item_0305 = require("abilities.items.item_0305")
local item_0305 = ____item_0305.item_0305
local ____item_0329 = require("abilities.items.item_0329")
local item_0329 = ____item_0329.item_0329
local ____item_0332 = require("abilities.items.item_0332")
local item_0332 = ____item_0332.item_0332
local ____item_0336 = require("abilities.items.item_0336")
local item_0336 = ____item_0336.item_0336
local ____item_0339 = require("abilities.items.item_0339")
local item_0339 = ____item_0339.item_0339
local ____item_0360 = require("abilities.items.item_0360")
local item_0360 = ____item_0360.item_0360
local ____item_0365 = require("abilities.items.item_0365")
local item_0365 = ____item_0365.item_0365
local ____item_0406 = require("abilities.items.item_0406")
local item_0406 = ____item_0406.item_0406
local ____item_0428 = require("abilities.items.item_0428")
local item_0428 = ____item_0428.item_0428
local ____item_0444 = require("abilities.items.item_0444")
local item_0444 = ____item_0444.item_0444
local ____item_0456 = require("abilities.items.item_0456")
local item_0456 = ____item_0456.item_0456
local ____item_0459 = require("abilities.items.item_0459")
local item_0459 = ____item_0459.item_0459
local ____item_0460 = require("abilities.items.item_0460")
local item_0460 = ____item_0460.item_0460
local ____item_0461 = require("abilities.items.item_0461")
local item_0461 = ____item_0461.item_0461
local ____items = require("abilities.items.items")
local item_0238 = ____items.item_0238
local item_0300 = ____items.item_0300
local ____item_0210 = require("abilities.items.item_0210")
local item_0210 = ____item_0210.item_0210
local ____item_0307 = require("abilities.items.item_0307")
local item_0307 = ____item_0307.item_0307
local ____item_0338 = require("abilities.items.item_0338")
local item_0338 = ____item_0338.item_0338
local ____item_0340 = require("abilities.items.item_0340")
local item_0340 = ____item_0340.item_0340
local ____item_0515 = require("abilities.items.item_0515")
local item_0515 = ____item_0515.item_0515
local ____item_0516 = require("abilities.items.item_0516")
local item_0516 = ____item_0516.item_0516
local ____item_0518 = require("abilities.items.item_0518")
local item_0518 = ____item_0518.item_0518
local ____item_0520 = require("abilities.items.item_0520")
local item_0520 = ____item_0520.item_0520
local ____item_0523 = require("abilities.items.item_0523")
local item_0523 = ____item_0523.item_0523
local ____item_0526 = require("abilities.items.item_0526")
local item_0526 = ____item_0526.item_0526
local ____item_0527 = require("abilities.items.item_0527")
local item_0527 = ____item_0527.item_0527
local ____item_0528 = require("abilities.items.item_0528")
local item_0528 = ____item_0528.item_0528
local ____item_0534 = require("abilities.items.item_0534")
local item_0534 = ____item_0534.item_0534
local ____item_0544 = require("abilities.items.item_0544")
local item_0544 = ____item_0544.item_0544
local ____item_0550 = require("abilities.items.item_0550")
local item_0550 = ____item_0550.item_0550
local ____item_0551 = require("abilities.items.item_0551")
local item_0551 = ____item_0551.item_0551
local ____item_0564 = require("abilities.items.item_0564")
local item_0564 = ____item_0564.item_0564
local ____item_0567 = require("abilities.items.item_0567")
local item_0567 = ____item_0567.item_0567
local ____item_0220 = require("abilities.items.item_0220")
local item_0220 = ____item_0220.item_0220
local ____item_0346 = require("abilities.items.item_0346")
local item_0346 = ____item_0346.item_0346
local ____item_0348 = require("abilities.items.item_0348")
local item_0348 = ____item_0348.item_0348
local ____item_0362 = require("abilities.items.item_0362")
local item_0362 = ____item_0362.item_0362
local ____item_0368 = require("abilities.items.item_0368")
local item_0368 = ____item_0368.item_0368
local ____item_0382 = require("abilities.items.item_0382")
local item_0382 = ____item_0382.item_0382
local ____item_0391 = require("abilities.items.item_0391")
local item_0391 = ____item_0391.item_0391
local ____item_0651 = require("abilities.items.item_0651")
local item_0651 = ____item_0651.item_0651
local ____item_0394 = require("abilities.items.item_0394")
local item_0394 = ____item_0394.item_0394
local ____item_0395 = require("abilities.items.item_0395")
local item_0395 = ____item_0395.item_0395
local ____item_0401 = require("abilities.items.item_0401")
local item_0401 = ____item_0401.item_0401
local ____item_0420 = require("abilities.items.item_0420")
local item_0420 = ____item_0420.item_0420
require("abilities.items.ascended_item_aliases2")
local ASCENDED_ITEM_ALIASES = {
	{ "item_0425", item_0305 },
	{ "item_0701", item_0168 },
	{ "item_0702", item_0175 },
	{ "item_0703", item_0225 },
	{ "item_0704", item_0238 },
	{ "item_0705", item_0240 },
	{ "item_0706", item_0250 },
	{ "item_0707", item_0255 },
	{ "item_0708", item_0270 },
	{ "item_0709", item_0273 },
	{ "item_0710", item_0282 },
	{ "item_0711", item_0289 },
	{ "item_0712", item_0296 },
	{ "item_0714", item_0329 },
	{ "item_0715", item_0332 },
	{ "item_0716", item_0336 },
	{ "item_0717", item_0339 },
	{ "item_0718", item_0360 },
	{ "item_0719", item_0365 },
	{ "item_0720", BaseItem_CS },
	{ "item_0721", item_0406 },
	{ "item_0722", item_0428 },
	{ "item_0723", item_0444 },
	{ "item_0724", item_0456 },
	{ "item_0725", item_0459 },
	{ "item_0726", item_0460 },
	{ "item_0727", item_0461 },
	{ "item_0728", item_0340 },
	{ "item_0729", item_0210 },
	{ "item_0730", item_0300 },
	{ "item_0731", item_0307 },
	{ "item_0732", item_0338 },
	{ "item_0760", item_0515 },
	{ "item_0761", item_0516 },
	{ "item_0762", item_0518 },
	{ "item_0763", item_0520 },
	{ "item_0764", item_0523 },
	{ "item_0765", item_0526 },
	{ "item_0766", item_0527 },
	{ "item_0767", item_0528 },
	{ "item_0768", item_0534 },
	{ "item_0769", item_0544 },
	{ "item_0770", item_0550 },
	{ "item_0771", item_0551 },
	{ "item_0772", item_0564 },
	{ "item_0773", item_0567 },
	{ "item_0774", BaseItem_CS },
	{ "item_0775", item_0220 },
	{ "item_0776", item_0346 },
	{ "item_0777", item_0348 },
	{ "item_0778", item_0362 },
	{ "item_0779", item_0368 },
	{ "item_0780", item_0382 },
	{ "item_0781", item_0394 },
	{ "item_0782", item_0395 },
	{ "item_0783", item_0401 },
	{ "item_0784", item_0420 },
	{ "item_0834", item_0391 },
	{ "item_0879", item_0651 },
}
local function registerAscendedItem(self, itemName, SourceItem)
	local ____class_0 = __TS__Class()
	____class_0.name = "AscendedItem"
	__TS__ClassExtends(____class_0, SourceItem)
	local AscendedItem = ____class_0
	registerAbility(nil, itemName)(nil, AscendedItem)
end
for ____, ____value in ipairs(ASCENDED_ITEM_ALIASES) do
	local itemName = ____value[1]
	local SourceItem = ____value[2]
	registerAscendedItem(nil, itemName, SourceItem)
end
return ____exports