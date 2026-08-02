--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_poison_heal"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.AbilityValue
local i = g.EOMItem
local j = g.registerEOMAbility
local k = c()
k.name = "item_poison_heal"
d(k, i)
function k.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.record = 0
	self.enable = true
end
function k.prototype.EventListener(self)
	return {
		dungeon_room_start = function()
			self.threshold = self:GetSpecialValueFor("threshold")
			self.record = 0
			self.enable = true
		end,
		damage_event = function(l, m)
			local n = self:GetCaster()
			if not self.enable or m.target ~= n then
				return
			end
			self.record = self.record + m.damage
			if self.record >= self.threshold then
				n:Heal(self:GetSpecialValueFor("heal"), self)
				local o = ParticleManager:CreateParticle(
					"particles/econ/items/juggernaut/jugg_fall20_immortal/jugg_fall20_immortal_healing_ward_death.vpcf",
					PATTACH_ABSORIGIN,
					n
				)
				ParticleManager:ReleaseParticleIndex(o)
				n:EmitSound("Hero_Alchemist.BerserkPotion.Target")
				self.enable = false
			end
		end,
	}
end
e({ h(nil) }, k.prototype, "threshold", nil)
k = e({ j(nil) }, k)
return f