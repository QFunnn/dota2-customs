--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_arena_ai"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = {
	npc_dota_hero_vespera = { role = "melee" },
	npc_dota_hero_seraphon = { role = "melee" },
	npc_dota_hero_vexis = {
		role = "ranged",
		retreatTriggerDistance = 260,
		retreatRearmDistance = 450,
		retreatTargetDistance = 470,
		disableForwardDodge = true,
	},
	npc_dota_hero_solthra = {
		role = "ranged",
		retreatTriggerDistance = 260,
		retreatRearmDistance = 450,
		retreatTargetDistance = 470,
		disableForwardDodge = true,
	},
}
local k = c()
k.name = "modifier_arena_ai"
d(k, h)
function k.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.abilitySlots = { 0, 1, 2, 5 }
	self.nextAbilityRotation = 0
	self.retreatUntil = 0
end
function k.prototype.OnCreated(self, l)
	if IsServer() then
		self:StartIntervalThink(0.25)
	end
end
function k.prototype.OnIntervalThink(self)
	local m = self:GetParent()
	if not IsValid(m) or not m:IsAlive() or m:IsCasting() then
		return
	end
	local n = self:FindNearestArenaEnemy(m)
	if not IsValid(n) then
		return
	end
	local o = self:GetHeroProfile(m)
	local p = CalcDistance(m, n)
	if self:TryRetreatFromTarget(m, n, o, p) then
		return
	end
	if self:TryCastRotatingAbility(m, n) then
		return
	end
	local q = m:GetAbilityByTag(AbilityTag.Attack)
	local r = m:Script_GetAttackRange()
	if p > r + 80 then
		m:ExecuteOrder(DOTA_UNIT_ORDER_MOVE_TO_TARGET, n)
		return
	end
	if IsValid(q) and q:IsFullyCastable() then
		m:ExecuteOrder(DOTA_UNIT_ORDER_CAST_POSITION, q, n:GetAbsOrigin())
	elseif m:IsMoving() then
		m:Stop()
	end
end
function k.prototype.FindNearestArenaEnemy(self, m)
	local s = FindUnitsInRadius(
		m:GetTeamNumber(),
		m:GetAbsOrigin(),
		nil,
		3000,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	local t
	do
		local u = 0
		while u < #s do
			do
				local n = s[u + 1]
				if not IsValid(n) or not n:IsAlive() or not n:HasModifier("modifier_arena_ai") then
					goto v
				end
				local w = n
				if m:GetUnitName() == "npc_dota_hero_vespera" and self:GetHeroProfile(w).role == "ranged" then
					return w
				end
				if t == nil then
					t = w
				end
			end
			::v::
			u = u + 1
		end
	end
	return t
end
function k.prototype.TryCastRotatingAbility(self, m, n)
	do
		local x = 0
		while x < #self.abilitySlots do
			do
				local y = (self.nextAbilityRotation + x) % #self.abilitySlots
				local z = m:GetAbilityByIndex(self.abilitySlots[y + 1])
				if not self:CanCastArenaAbility(m, n, z) then
					goto A
				end
				if self:ExecuteArenaAbilityOrder(m, n, z) then
					self.nextAbilityRotation = (y + 1) % #self.abilitySlots
					return true
				end
			end
			::A::
			x = x + 1
		end
	end
	return false
end
function k.prototype.CanCastArenaAbility(self, m, n, z)
	if not IsValid(z) or z:IsPassive() or not z:IsActivated() then
		return false
	end
	if z:GetLevel() <= 0 or not z:IsFullyCastable() then
		return false
	end
	if self:GetHeroProfile(m).disableForwardDodge and z:GetAbilityTag() == AbilityTag.Dodge then
		return false
	end
	local B = self:GetArenaAbilityBehavior(z)
	local p = CalcDistance(m, n)
	local C = math.max(z:GetCastRange(vec3_zero, nil), 0)
	if B == DOTA_ABILITY_BEHAVIOR_NO_TARGET then
		return p <= math.max(C, m:Script_GetAttackRange(), 500)
	end
	if B == DOTA_ABILITY_BEHAVIOR_UNIT_TARGET then
		return p <= C + 80
	end
	if B == DOTA_ABILITY_BEHAVIOR_POINT then
		return C <= 0 or p <= C + 120
	end
	return false
end
function k.prototype.ExecuteArenaAbilityOrder(self, m, n, z)
	local B = self:GetArenaAbilityBehavior(z)
	if B == DOTA_ABILITY_BEHAVIOR_NO_TARGET then
		m:ExecuteOrder(DOTA_UNIT_ORDER_CAST_NO_TARGET, z)
		return true
	end
	if B == DOTA_ABILITY_BEHAVIOR_UNIT_TARGET then
		m:ExecuteOrder(DOTA_UNIT_ORDER_CAST_TARGET, z, n)
		return true
	end
	if B == DOTA_ABILITY_BEHAVIOR_POINT then
		m:ExecuteOrder(DOTA_UNIT_ORDER_CAST_POSITION, z, n:GetAbsOrigin())
		return true
	end
	return false
end
function k.prototype.GetHeroProfile(self, m)
	return j[m:GetUnitName()] or { role = "melee" }
end
function k.prototype.TryRetreatFromTarget(self, m, n, o, p)
	if o.role ~= "ranged" then
		return false
	end
	local D = n:entindex()
	if self.retreatedFromTarget == D and p >= o.retreatRearmDistance then
		self.retreatedFromTarget = nil
	end
	if GameRules:GetGameTime() < self.retreatUntil then
		return true
	end
	if p > o.retreatTriggerDistance or self.retreatedFromTarget == D then
		return false
	end
	self.retreatedFromTarget = D
	self.retreatUntil = GameRules:GetGameTime() + 0.6
	self:RetreatFromTarget(m, n, o.retreatTargetDistance)
	return true
end
function k.prototype.RetreatFromTarget(self, m, n, E)
	local F = m:GetAbsOrigin()
	local p = CalcDistance(m, n)
	local G = (F - n:GetAbsOrigin()):Normalized()
	local H = math.max(E - p, 160)
	m:ExecuteOrder(DOTA_UNIT_ORDER_MOVE_TO_POSITION, F + G * H)
end
function k.prototype.GetArenaAbilityBehavior(self, z)
	local B = z:GetBehaviorInt()
	if bit.band(B, DOTA_ABILITY_BEHAVIOR_NO_TARGET) == DOTA_ABILITY_BEHAVIOR_NO_TARGET then
		return DOTA_ABILITY_BEHAVIOR_NO_TARGET
	end
	if bit.band(B, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) == DOTA_ABILITY_BEHAVIOR_UNIT_TARGET then
		return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
	end
	if bit.band(B, DOTA_ABILITY_BEHAVIOR_POINT) == DOTA_ABILITY_BEHAVIOR_POINT then
		return DOTA_ABILITY_BEHAVIOR_POINT
	end
	return nil
end
k = e(
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
	k
)
return f