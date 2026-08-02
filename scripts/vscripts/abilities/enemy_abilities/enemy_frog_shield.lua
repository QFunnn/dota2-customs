--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/enemy_abilities/enemy_frog_shield"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayFilter
local f = b.__TS__DecorateLegacy
local g = {}
local h = require("modifiers.eom_modifier.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
local k = require("abilities.ability_ai")
local l = k.EOMAbilityAI
local m = require("abilities.eom_ability")
local n = m.registerEOMAbility
local o = c()
o.name = "enemy_frog_shield"
d(o, l)
function o.prototype.OnAbilityPhaseStart(self)
	local p = self:GetCursorTarget()
	if p ~= nil then
		p:SaveData("__SHIELDED", true)
	end
	return true
end
function o.prototype.OnSpellStart(self)
	local p = self:GetCursorTarget()
	if IsValid(p) then
		p:AddNewModifier(p, self, "modifier_enemy_frog_shield", {})
	end
end
o = f(
	{ n(nil, {
		funcUnitsCallback = function(q, r)
			return e(r, function(q, s)
				return not s:LoadData("__SHIELDED", false)
			end)
		end,
	}) },
	o
)
local t = c()
t.name = "modifier_enemy_frog_shield"
d(t, i)
function t.prototype.GetAbilitySpecialValue(self)
	self.shield = self:GetAbilitySpecialValueFor("shield")
end
function t.prototype.OnCreated(self, u)
	local v = self:GetParent()
	if IsServer() then
		v:AddShield(self.shield, "enemy_frog_shield", "override", "permanent")
		v:EmitSound("n_frogs.WaterBubble.Target")
	else
		local w =
			ParticleManager:CreateParticle("particles/units/enemy/enemy_frog_shield.vpcf", PATTACH_CENTER_FOLLOW, v)
		ParticleManager:SetParticleControl(w, 1, Vector(100, 0, 0))
		self:AddParticle(w, false, false, -1, false, false)
	end
end
function t.prototype.OnDestroy(self)
	if IsServer() then
		local v = self:GetParent()
		v:RemoveShield("enemy_frog_shield")
		v:EmitSound("n_frogs.WaterBubble.Destroy")
	end
end
function t.prototype.EventListener(self)
	return {
		consume_shield = function(q, x)
			if self:GetParent():GetShield("enemy_frog_shield") <= 0 then
				self:Destroy()
			end
		end,
	}
end
t = f(
	{
		j(
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
	t
)
return g