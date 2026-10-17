--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_treant/boss_treant_5"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayFilter
local f = b.__TS__DecorateLegacy
local g = {}
local h = require("modifiers.eom_modifier.eom_modifier")
local i = h.EOMModifier
local j = h.EOMModifierMotionBoth
local k = h.registerEOMModifier
local l = require("abilities.ability_ai")
local m = l.EOMAbilityAI
local n = require("abilities.eom_ability")
local o = n.registerEOMAbility
local p = c()
p.name = "boss_treant_5"
d(p, m)
function p.prototype.GetAICastRange(self)
	return self:GetCastRange(vec3_zero, nil)
end
function p.prototype.CastFilterResultTarget(self, q)
	if q == self:GetCaster() then
		return UF_FAIL_OTHER
	end
	return UF_SUCCESS
end
function p.prototype.GetCatchUnit(self)
	return self.catch_unit
end
function p.prototype.OnAbilityPhaseStart(self)
	local r = self:GetCaster()
	r:AddNewModifier(r, self, "modifier_boss_treant_5_movespeed", { duration = 3 })
	return true
end
function p.prototype.OnSpellStart(self)
	local r = self:GetCaster()
	r:RemoveModifierByName("modifier_boss_treant_5_movespeed")
	local q = self:GetCursorTarget()
	if not IsValid(q) then
		return
	end
	local s = r:FindAbilityByName("boss_shredder_1")
	local t = q
	if IsValid(s) then
		local u = s:CutDownTree(q, true, false)
		if IsValid(u) then
			t = u
		end
	end
	if not IsValid(t) or not t:IsAlive() then
		return
	end
	t:AddNewModifier(r, self, "modifier_boss_treant_5", {})
	r:SimulateCast({ duration = 0.4 })
end
p = f(
	{
		o(nil, {
			funcCondition = function(v, s)
				return s:GetCatchUnit() == nil
			end,
			funcUnitsCallback = function(v, w)
				return e(w, function(v, x)
					return x:HasModifier("modifier_boss_treant_5")
				end)
			end,
		}),
	},
	p
)
local y = c()
y.name = "modifier_boss_treant_5"
d(y, j)
function y.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.hitlocOffset = Vector(0, 0, 0)
end
function y.prototype.OnCreated(self, z)
	if IsServer() then
		local A = self:GetParent()
		local B = A:GetAttachmentPosition("attach_hitloc")
		self.hitlocOffset = A:GetAbsOrigin() - B
		if not self:ApplyHorizontalMotionController() or not self:ApplyVerticalMotionController() then
			self:Destroy()
			return
		end
		local s = self:GetAbility()
		s.catch_unit = A
	end
end
function y.prototype.OnDestroy(self)
	if IsServer() then
		local s = self:GetAbility()
		s.catch_unit = nil
	end
end
function y.prototype.OnHorizontalMotionInterrupted(self)
	if IsServer() then
		self:Destroy()
	end
end
function y.prototype.OnVerticalMotionInterrupted(self)
	if IsServer() then
		self:Destroy()
	end
end
function y.prototype.UpdateVerticalMotion(self, C, D)
	local r = self:GetCaster()
	if IsValid(r) then
		C:SetAbsOrigin(r:GetAttachmentPosition("attach_hand_l") + self.hitlocOffset)
	end
end
function y.prototype.UpdateHorizontalMotion(self, C, D)
	local r = self:GetCaster()
	if IsValid(r) then
		local E = r:GetAttachmentAngles(r:ScriptLookupAttachment("attach_hand_l"))
		C:SetAbsOrigin(r:GetAttachmentPosition("attach_hand_l") + self.hitlocOffset)
	end
end
function y.prototype.StaticDeclare(self)
	return { [MODIFIER_PROPERTY_OVERRIDE_ANIMATION] = ACT_DOTA_FLAIL }
end
function y.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true }
end
function y.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true, [MODIFIER_STATE_NO_UNIT_COLLISION] = true, [MODIFIER_STATE_INVULNERABLE] = true }
end
y = f(
	{
		k(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
			}
		),
	},
	y
)
local F = c()
F.name = "modifier_boss_treant_5_movespeed"
d(F, i)
function F.prototype.StaticProperty(self)
	return { [PropertyFunction.MOVESPEED_AMPLIFY] = 150 }
end
F = f(
	{
		k(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
			}
		),
	},
	F
)
return g