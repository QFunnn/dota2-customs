--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/potion/item_potion_vitality"
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
k.name = "item_potion_vitality"
d(k, j)
function k.prototype.OnCreated(self)
	self:SetStackCount(self:GetSpecialValueFor("charge"))
end
function k.prototype.UseCharge(self)
	if self:GetStackCount() > 0 then
		self:DecrementStackCount()
		if self:GetStackCount() <= 0 then
			self:GetCaster():RemoveItem(self)
		end
	end
end
function k.prototype.Effect(self)
	local l = self:GetCaster()
	l:Heal(self:GetSpecialValueFor("value"), nil)
	local m = ParticleManager:CreateParticle(
		"particles/econ/items/juggernaut/jugg_fall20_immortal/jugg_fall20_immortal_healing_ward_death.vpcf",
		PATTACH_ABSORIGIN,
		l
	)
	ParticleManager:ReleaseParticleIndex(m)
	l:EmitSound("Hero_Alchemist.BerserkPotion.Target")
end
function k.prototype.EventListener(self)
	return {
		dungeon_room_start = function(n, o)
			self:Effect()
		end,
		dungeon_room_clear = function(n, o)
			self:UseCharge()
		end,
	}
end
k = e({ h(nil) }, k)
return f