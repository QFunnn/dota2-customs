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
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
____exports.item_gem_base = __TS__Class()
local item_gem_base = ____exports.item_gem_base
item_gem_base.name = "item_gem_base"
__TS__ClassExtends(item_gem_base, BaseItem_CS)
function item_gem_base.prototype.IsGemItem(self)
	return true
end
function item_gem_base.prototype.GetGemAssembledData(self)
	if not MyGameGemManager then
		return {
			itemName = self:GetName(),
			gemKind = "tag",
			pairs = {},
			rules = {},
			heroDataPairs = {},
			modifierNames = {},
		}
	end
	return MyGameGemManager:GetGemAssembledDataByItemName(self:GetName())
end
function item_gem_base.prototype.GetGemTagRules(self)
	return self:GetGemAssembledData().rules
end
local item_G001 = __TS__Class()
item_G001.name = "item_G001"
__TS__ClassExtends(item_G001, ____exports.item_gem_base)
item_G001 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G001)
local item_G002 = __TS__Class()
item_G002.name = "item_G002"
__TS__ClassExtends(item_G002, ____exports.item_gem_base)
item_G002 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G002)
local item_G003 = __TS__Class()
item_G003.name = "item_G003"
__TS__ClassExtends(item_G003, ____exports.item_gem_base)
item_G003 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G003)
local item_G004 = __TS__Class()
item_G004.name = "item_G004"
__TS__ClassExtends(item_G004, ____exports.item_gem_base)
item_G004 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G004)
local item_G005 = __TS__Class()
item_G005.name = "item_G005"
__TS__ClassExtends(item_G005, ____exports.item_gem_base)
item_G005 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G005)
local item_G006 = __TS__Class()
item_G006.name = "item_G006"
__TS__ClassExtends(item_G006, ____exports.item_gem_base)
item_G006 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G006)
local item_G007 = __TS__Class()
item_G007.name = "item_G007"
__TS__ClassExtends(item_G007, ____exports.item_gem_base)
item_G007 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G007)
local item_G008 = __TS__Class()
item_G008.name = "item_G008"
__TS__ClassExtends(item_G008, ____exports.item_gem_base)
item_G008 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G008)
local item_G009 = __TS__Class()
item_G009.name = "item_G009"
__TS__ClassExtends(item_G009, ____exports.item_gem_base)
item_G009 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G009)
local item_G010 = __TS__Class()
item_G010.name = "item_G010"
__TS__ClassExtends(item_G010, ____exports.item_gem_base)
item_G010 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G010)
local item_G011 = __TS__Class()
item_G011.name = "item_G011"
__TS__ClassExtends(item_G011, ____exports.item_gem_base)
item_G011 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G011)
local item_G012 = __TS__Class()
item_G012.name = "item_G012"
__TS__ClassExtends(item_G012, ____exports.item_gem_base)
item_G012 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G012)
local item_G013 = __TS__Class()
item_G013.name = "item_G013"
__TS__ClassExtends(item_G013, ____exports.item_gem_base)
item_G013 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G013)
local item_G205 = __TS__Class()
item_G205.name = "item_G205"
__TS__ClassExtends(item_G205, ____exports.item_gem_base)
item_G205 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G205)
--- 刀阵旋风：无极斩
local item_G206 = __TS__Class()
item_G206.name = "item_G206"
__TS__ClassExtends(item_G206, ____exports.item_gem_base)
item_G206 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G206)
--- 刀阵旋风：瞬身斩
local item_G207 = __TS__Class()
item_G207.name = "item_G207"
__TS__ClassExtends(item_G207, ____exports.item_gem_base)
item_G207 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G207)
--- 刀阵旋风：切割
local item_G208 = __TS__Class()
item_G208.name = "item_G208"
__TS__ClassExtends(item_G208, ____exports.item_gem_base)
item_G208 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G208)
--- 弱点打击：分影斩
local item_G209 = __TS__Class()
item_G209.name = "item_G209"
__TS__ClassExtends(item_G209, ____exports.item_gem_base)
item_G209 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G209)
local item_G001_3 = __TS__Class()
item_G001_3.name = "item_G001_3"
__TS__ClassExtends(item_G001_3, ____exports.item_gem_base)
item_G001_3 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G001_3)
local item_G004_3 = __TS__Class()
item_G004_3.name = "item_G004_3"
__TS__ClassExtends(item_G004_3, ____exports.item_gem_base)
item_G004_3 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G004_3)
local item_G007_2 = __TS__Class()
item_G007_2.name = "item_G007_2"
__TS__ClassExtends(item_G007_2, ____exports.item_gem_base)
item_G007_2 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G007_2)
local item_G023 = __TS__Class()
item_G023.name = "item_G023"
__TS__ClassExtends(item_G023, ____exports.item_gem_base)
item_G023 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G023)
local item_G024_2 = __TS__Class()
item_G024_2.name = "item_G024_2"
__TS__ClassExtends(item_G024_2, ____exports.item_gem_base)
item_G024_2 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G024_2)
local item_G026 = __TS__Class()
item_G026.name = "item_G026"
__TS__ClassExtends(item_G026, ____exports.item_gem_base)
item_G026 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G026)
local item_G026_2 = __TS__Class()
item_G026_2.name = "item_G026_2"
__TS__ClassExtends(item_G026_2, ____exports.item_gem_base)
item_G026_2 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G026_2)
local item_G100 = __TS__Class()
item_G100.name = "item_G100"
__TS__ClassExtends(item_G100, ____exports.item_gem_base)
item_G100 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G100)
local item_G101_2 = __TS__Class()
item_G101_2.name = "item_G101_2"
__TS__ClassExtends(item_G101_2, ____exports.item_gem_base)
item_G101_2 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G101_2)
local item_G102_2 = __TS__Class()
item_G102_2.name = "item_G102_2"
__TS__ClassExtends(item_G102_2, ____exports.item_gem_base)
item_G102_2 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G102_2)
local item_G103_3 = __TS__Class()
item_G103_3.name = "item_G103_3"
__TS__ClassExtends(item_G103_3, ____exports.item_gem_base)
item_G103_3 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G103_3)
local item_G104 = __TS__Class()
item_G104.name = "item_G104"
__TS__ClassExtends(item_G104, ____exports.item_gem_base)
item_G104 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G104)
local item_G104_2 = __TS__Class()
item_G104_2.name = "item_G104_2"
__TS__ClassExtends(item_G104_2, ____exports.item_gem_base)
item_G104_2 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G104_2)
local item_G105_2 = __TS__Class()
item_G105_2.name = "item_G105_2"
__TS__ClassExtends(item_G105_2, ____exports.item_gem_base)
item_G105_2 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G105_2)
local item_G106_2 = __TS__Class()
item_G106_2.name = "item_G106_2"
__TS__ClassExtends(item_G106_2, ____exports.item_gem_base)
item_G106_2 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G106_2)
local item_G107_2 = __TS__Class()
item_G107_2.name = "item_G107_2"
__TS__ClassExtends(item_G107_2, ____exports.item_gem_base)
item_G107_2 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G107_2)
local item_G108 = __TS__Class()
item_G108.name = "item_G108"
__TS__ClassExtends(item_G108, ____exports.item_gem_base)
item_G108 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G108)
local item_G109 = __TS__Class()
item_G109.name = "item_G109"
__TS__ClassExtends(item_G109, ____exports.item_gem_base)
item_G109 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G109)
local item_G110 = __TS__Class()
item_G110.name = "item_G110"
__TS__ClassExtends(item_G110, ____exports.item_gem_base)
item_G110 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G110)
local item_G112_2 = __TS__Class()
item_G112_2.name = "item_G112_2"
__TS__ClassExtends(item_G112_2, ____exports.item_gem_base)
item_G112_2 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G112_2)
local item_G200_2 = __TS__Class()
item_G200_2.name = "item_G200_2"
__TS__ClassExtends(item_G200_2, ____exports.item_gem_base)
item_G200_2 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G200_2)
local item_G201_2 = __TS__Class()
item_G201_2.name = "item_G201_2"
__TS__ClassExtends(item_G201_2, ____exports.item_gem_base)
item_G201_2 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G201_2)
local item_G202_3 = __TS__Class()
item_G202_3.name = "item_G202_3"
__TS__ClassExtends(item_G202_3, ____exports.item_gem_base)
item_G202_3 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G202_3)
local item_G203_2 = __TS__Class()
item_G203_2.name = "item_G203_2"
__TS__ClassExtends(item_G203_2, ____exports.item_gem_base)
item_G203_2 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G203_2)
local item_G203_3 = __TS__Class()
item_G203_3.name = "item_G203_3"
__TS__ClassExtends(item_G203_3, ____exports.item_gem_base)
item_G203_3 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G203_3)
local item_G204_3 = __TS__Class()
item_G204_3.name = "item_G204_3"
__TS__ClassExtends(item_G204_3, ____exports.item_gem_base)
item_G204_3 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G204_3)
local item_G206_2 = __TS__Class()
item_G206_2.name = "item_G206_2"
__TS__ClassExtends(item_G206_2, ____exports.item_gem_base)
item_G206_2 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G206_2)
local item_G208_3 = __TS__Class()
item_G208_3.name = "item_G208_3"
__TS__ClassExtends(item_G208_3, ____exports.item_gem_base)
item_G208_3 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G208_3)
local item_G209_2 = __TS__Class()
item_G209_2.name = "item_G209_2"
__TS__ClassExtends(item_G209_2, ____exports.item_gem_base)
item_G209_2 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G209_2)
local item_G209_3 = __TS__Class()
item_G209_3.name = "item_G209_3"
__TS__ClassExtends(item_G209_3, ____exports.item_gem_base)
item_G209_3 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G209_3)
local item_G210_2 = __TS__Class()
item_G210_2.name = "item_G210_2"
__TS__ClassExtends(item_G210_2, ____exports.item_gem_base)
item_G210_2 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G210_2)
local item_G300_2 = __TS__Class()
item_G300_2.name = "item_G300_2"
__TS__ClassExtends(item_G300_2, ____exports.item_gem_base)
item_G300_2 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G300_2)
local item_G302_2 = __TS__Class()
item_G302_2.name = "item_G302_2"
__TS__ClassExtends(item_G302_2, ____exports.item_gem_base)
item_G302_2 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G302_2)
local item_G312_2 = __TS__Class()
item_G312_2.name = "item_G312_2"
__TS__ClassExtends(item_G312_2, ____exports.item_gem_base)
item_G312_2 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G312_2)
local item_G314_2 = __TS__Class()
item_G314_2.name = "item_G314_2"
__TS__ClassExtends(item_G314_2, ____exports.item_gem_base)
item_G314_2 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G314_2)
local item_G315_2 = __TS__Class()
item_G315_2.name = "item_G315_2"
__TS__ClassExtends(item_G315_2, ____exports.item_gem_base)
item_G315_2 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G315_2)
local item_G316_2 = __TS__Class()
item_G316_2.name = "item_G316_2"
__TS__ClassExtends(item_G316_2, ____exports.item_gem_base)
item_G316_2 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G316_2)
local item_G114 = __TS__Class()
item_G114.name = "item_G114"
__TS__ClassExtends(item_G114, ____exports.item_gem_base)
item_G114 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G114)
local item_G114_2 = __TS__Class()
item_G114_2.name = "item_G114_2"
__TS__ClassExtends(item_G114_2, ____exports.item_gem_base)
item_G114_2 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G114_2)
local item_G114_3 = __TS__Class()
item_G114_3.name = "item_G114_3"
__TS__ClassExtends(item_G114_3, ____exports.item_gem_base)
item_G114_3 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G114_3)
return ____exports