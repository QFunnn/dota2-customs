--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
	if IsValid(s) then
		local t = s:CutDownTree(q)
		if IsValid(t) then
			t:AddNewModifier(r, self, "modifier_boss_treant_5", {})
		else
			q:AddNewModifier(r, self, "modifier_boss_treant_5", {})
		end
	else
		q:AddNewModifier(r, self, "modifier_boss_treant_5", {})
	end
	r:SimulateCast({ duration = 0.4 })
end
p = f(
	{
		o(nil, {
			funcCondition = function(u, s)
				return s:GetCatchUnit() == nil
			end,
			funcUnitsCallback = function(u, v)
				return e(v, function(u, w)
					return w:HasModifier("modifier_boss_treant_5")
				end)
			end,
		}),
	},
	p
)
local x = c()
x.name = "modifier_boss_treant_5"
d(x, j)
function x.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.hitlocOffset = Vector(0, 0, 0)
end
function x.prototype.OnCreated(self, y)
	if IsServer() then
		local z = self:GetParent()
		local A = z:GetAttachmentPosition("attach_hitloc")
		self.hitlocOffset = z:GetAbsOrigin() - A
		if not self:ApplyHorizontalMotionController() or not self:ApplyVerticalMotionController() then
			self:Destroy()
			return
		end
		local s = self:GetAbility()
		s.catch_unit = z
	end
end
function x.prototype.OnDestroy(self)
	if IsServer() then
		local s = self:GetAbility()
		s.catch_unit = nil
	end
end
function x.prototype.OnHorizontalMotionInterrupted(self)
	if IsServer() then
		self:Destroy()
	end
end
function x.prototype.OnVerticalMotionInterrupted(self)
	if IsServer() then
		self:Destroy()
	end
end
function x.prototype.UpdateVerticalMotion(self, B, C)
	local r = self:GetCaster()
	if IsValid(r) then
		B:SetAbsOrigin(r:GetAttachmentPosition("attach_hand_l") + self.hitlocOffset)
	end
end
function x.prototype.UpdateHorizontalMotion(self, B, C)
	local r = self:GetCaster()
	if IsValid(r) then
		local D = r:GetAttachmentAngles(r:ScriptLookupAttachment("attach_hand_l"))
		B:SetAbsOrigin(r:GetAttachmentPosition("attach_hand_l") + self.hitlocOffset)
	end
end
function x.prototype.StaticDeclare(self)
	return { [MODIFIER_PROPERTY_OVERRIDE_ANIMATION] = ACT_DOTA_FLAIL }
end
function x.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true }
end
function x.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true, [MODIFIER_STATE_NO_UNIT_COLLISION] = true, [MODIFIER_STATE_INVULNERABLE] = true }
end
x = f(
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
	x
)
local E = c()
E.name = "modifier_boss_treant_5_movespeed"
d(E, i)
function E.prototype.StaticProperty(self)
	return { [PropertyFunction.MOVESPEED_AMPLIFY] = 150 }
end
E = f(
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
	E
)
return g