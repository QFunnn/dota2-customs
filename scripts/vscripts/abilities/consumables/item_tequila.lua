--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/consumables/item_tequila"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.dota_ts_adapter")
local h = g.registerAbility
local i = require("abilities.eom_ability")
local j = i.EOMItem
local k = c()
k.name = "item_tequila"
d(k, j)
function k.prototype.OnCreated(self)
	self:StartThink(0, function()
		self:OnSpellStart()
	end)
end
function k.prototype.OnSpellStart(self)
	local l = self:GetCaster()
	l:AddProperty(PropertyFunction.ATTACKSPEED, self:GetSpecialValueFor("attack_speed"))
	l:EmitSoundParams("Hero_Tusk.DrinkingBuddies.Cast", 0, 0.5, 0)
	l:RemoveItem(self)
end
k = e({ h(nil) }, k)
return f