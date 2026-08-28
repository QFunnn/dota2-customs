--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/vexis/vexis_wisp_attack"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = require("abilities.eom_ability")
local k = j.EOMAbility
local l = j.registerEOMAbility
local m = c()
m.name = "vexis_wisp_attack"
d(m, k)
function m.prototype.ProcsMagicStick(self)
	return false
end
function m.prototype.GetCooldown(self, n)
	return self:GetCaster():GetSecondsPerAttack(false) - self:GetCastPoint()
end
function m.prototype.GetCastPoint(self)
	if IsServer() then
		return self:GetCaster():GetAttackAnimationPoint()
			* self:GetCaster():GetSecondsPerAttack(false)
			/ self:GetCaster():GetBaseAttackTime(false)
	end
	return 0
end
function m.prototype.GetCastRange(self, o, p)
	return self:GetCaster():Script_GetAttackRange()
end
function m.prototype.GetPlaybackRateOverride(self)
	return self:GetCaster():GetAttackSpeed(false)
end
function m.prototype.OnCreated(self)
	if IsServer() then
		local q = self:GetCaster()
		local r = q:GetOwner()
		if not IsValid(r) then
			return
		end
		local s = r:GetAbilityByTag(AbilityTag.Attack)
		if not IsValid(s) then
			return
		end
		self.attackAbility = s
		self.summoner = r
	end
end
function m.prototype.OnSpellStart(self)
	local q = self:GetCaster()
	local p = self:GetCursorTarget()
	if not IsValid(p) or not IsValid(self.summoner) or not IsValid(self.attackAbility) then
		return
	end
	if self.attackAbility.WispAttack == nil then
		return
	end
	local t = self:GetStackCount()
	local u = t >= 1
	if not u then
		u = self:PRD(self.attackAbility:GetSpecialValueFor("attack_chance"))
	end
	if u then
		self:DecrementStackCount(1, false)
	end
	self.attackAbility:WispAttack(
		q:GetAttachmentPosition("attach_attack1") + Vector(0, 0, 75),
		p:GetAbsOrigin(),
		u,
		GetWispDamage(self.summoner) / 100
	)
end
function m.prototype.GetIntrinsicModifierName(self)
	return "modifier_vexis_wisp_attack"
end
function m.prototype.EventListener(self)
	return {
		ability_cast_complete = function(v, w)
			if w.caster ~= self.summoner then
				return
			end
			if
				w.abilityTag == AbilityTag.Dodge
				or w.abilityTag == AbilityTag.Skill
				or w.abilityTag == AbilityTag.Defense
				or w.abilityTag == AbilityTag.Ultimate
			then
				local x = self.attackAbility:GetSpecialValueFor("max_stack")
				if self:GetStackCount() < x then
					self:IncrementStackCount(1, false)
				end
			end
		end,
	}
end
m = e({ l(nil) }, m)
local y = c()
y.name = "modifier_vexis_wisp_attack"
d(y, h)
function y.prototype.StaticDeclare(self)
	return { [MODIFIER_PROPERTY_VISUAL_Z_DELTA] = 75 }
end
y = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	y
)
return f