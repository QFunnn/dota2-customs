--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_fake_preview"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_fake_preview"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.sequence =
		{ AbilityTag.Dodge, "attack", AbilityTag.Skill, "attack", AbilityTag.Defense, "attack", AbilityTag.Ultimate }
	self.stepIndex = 0
	self.actionIssued = false
	self.dummySearchRadius = 600
	self.rangedDesiredDistance = 300
	self.distanceTolerance = 50
end
function j.prototype.OnCreated(self, k)
	if IsServer() then
		local l = self:GetParent()
		self.attackAbility = l:GetAbilityByTag(AbilityTag.Attack)
		self.skillAbility = l:GetAbilityByTag(AbilityTag.Skill)
		self.dodgeAbility = l:GetAbilityByTag(AbilityTag.Dodge)
		self.defenseAbility = l:GetAbilityByTag(AbilityTag.Defense)
		self.ultimateAbility = l:GetAbilityByTag(AbilityTag.Ultimate)
		self:StartIntervalThink(0.3)
	end
end
function j.prototype.OnIntervalThink(self)
	local l = self:GetParent()
	if not IsValid(l) or not l:IsAlive() then
		return
	end
	local m = self:FindDemoDummy(l)
	if m == nil then
		return
	end
	l:FaceTowards(m:GetAbsOrigin())
	if self.actionIssued then
		if l:IsCasting() then
			return
		end
		self.actionIssued = false
		self.stepIndex = (self.stepIndex + 1) % #self.sequence
		return
	end
	local n = self:GetDesiredDistance(l)
	local o = CalcDistance(l, m)
	if math.abs(o - n) > self.distanceTolerance then
		local p = (l:GetAbsOrigin() - m:GetAbsOrigin()):Normalized()
		local q = m:GetAbsOrigin() + p * n
		l:ExecuteOrder(DOTA_UNIT_ORDER_MOVE_TO_POSITION, q)
		return
	end
	local r = self.sequence[self.stepIndex + 1]
	if r == "attack" then
		if IsValid(self.attackAbility) and self.attackAbility:IsFullyCastable() then
			l:ExecuteOrder(DOTA_UNIT_ORDER_CAST_POSITION, self.attackAbility, m:GetAbsOrigin())
			self.actionIssued = true
		end
	else
		local s = self:GetAbilityByTag(r)
		if IsValid(s) and s:IsFullyCastable() and not s:IsPassive() and s:IsActivated() then
			self:CastAbilityOnTarget(l, s, m)
			self.actionIssued = true
		end
	end
end
function j.prototype.GetAbilityByTag(self, t)
	repeat
		local u = t
		local v = u == AbilityTag.Skill
		if v then
			return self.skillAbility
		end
		v = v or u == AbilityTag.Dodge
		if v then
			return self.dodgeAbility
		end
		v = v or u == AbilityTag.Defense
		if v then
			return self.defenseAbility
		end
		v = v or u == AbilityTag.Ultimate
		if v then
			return self.ultimateAbility
		end
		do
			return nil
		end
	until true
end
function j.prototype.GetDesiredDistance(self, l)
	if l:GetAttackCapability() == DOTA_UNIT_CAP_RANGED_ATTACK then
		return self.rangedDesiredDistance
	end
	local w = l:Script_GetAttackRange()
	return w - 10
end
function j.prototype.FindDemoDummy(self, l)
	local x = FindUnitsInRadius(
		l:GetTeamNumber(),
		l:GetAbsOrigin(),
		nil,
		self.dummySearchRadius,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	do
		local y = 0
		while y < #x do
			if x[y + 1]:GetUnitName() == "demo_dummy" and x[y + 1]:IsAlive() then
				return x[y + 1]
			end
			y = y + 1
		end
	end
	return nil
end
function j.prototype.CastAbilityOnTarget(self, l, s, z)
	local A = tonumber(tostring(s:GetBehavior()))
	if bit.band(A, DOTA_ABILITY_BEHAVIOR_NO_TARGET) == DOTA_ABILITY_BEHAVIOR_NO_TARGET then
		l:ExecuteOrder(DOTA_UNIT_ORDER_CAST_NO_TARGET, s)
	elseif bit.band(A, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) == DOTA_ABILITY_BEHAVIOR_UNIT_TARGET then
		l:ExecuteOrder(DOTA_UNIT_ORDER_CAST_TARGET, s, z)
	elseif bit.band(A, DOTA_ABILITY_BEHAVIOR_POINT) == DOTA_ABILITY_BEHAVIOR_POINT then
		l:ExecuteOrder(DOTA_UNIT_ORDER_CAST_POSITION, s, z:GetAbsOrigin())
	end
end
function j.prototype.StaticProperty(self)
	return { [PropertyFunction.FURY_REGEN] = 100, [PropertyFunction.COOLDOWN_REDUCTION] = 90 }
end
function j.prototype.StaticState(self)
	return { [StateEnum.UNCONTROLLABLE] = true }
end
j = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
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