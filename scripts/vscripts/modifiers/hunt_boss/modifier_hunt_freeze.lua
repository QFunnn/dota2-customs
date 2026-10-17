--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "modifiers/hunt_boss/modifier_hunt_freeze"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_hunt_freeze"
d(j, h)
function j.prototype.OnCreated(self, k)
	if not IsServer() then
		return
	end
	self:SetStackCount(math.max(0, toFiniteNumber(k.freezePct, 400)))
end
function j.prototype.EventListener(self)
	return {
		ability_cast_complete = function(l, m)
			if not IsServer() or m.isActualCast ~= true or m.caster ~= self:GetParent() then
				return
			end
			local n = m.ability
			if not IsValid(n) or n:IsItem() or not m.caster:IsRealHero() then
				return
			end
			local o = m.abilityTag
			if
				o ~= AbilityTag.Skill
				and o ~= AbilityTag.Dodge
				and o ~= AbilityTag.Defense
				and o ~= AbilityTag.Ultimate
			then
				return
			end
			local p = math.max(0, n:GetEffectiveCooldown(n:GetLevel() - 1))
			local q = p * self:GetStackCount() * 0.01
			if q <= 0 then
				return
			end
			self:StartThink(0, function()
				if IsValid(self) and IsValid(n) then
					n:SetFrozenCooldown(true, q)
				end
				return -1
			end)
		end,
	}
end
j = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	j
)
return f