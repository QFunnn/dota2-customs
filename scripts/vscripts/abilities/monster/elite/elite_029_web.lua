--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local modifier_elite_029_web_aura_effect
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local WEB_PARTICLE = "particles/econ/items/broodmother/broodmother_2022_immortal/broodmother_2022_immortal_web.vpcf"
local WEB_RADIUS = 1000
local WEB_ACTIVATE_DELAY = 0.5
local WEB_APPLY_INTERVAL = 1
local WEB_EFFECT_DURATION = 1.2
local ALLY_MOVESPEED_PCT = 30
local ALLY_ATTACK_SPEED = 30
local ENEMY_SLOW_PCT = 20
--- 精英技能29-蛛网：以自身为中心强化友军并减速敌人
____exports.elite_029_web = __TS__Class()
local elite_029_web = ____exports.elite_029_web
elite_029_web.name = "elite_029_web"
__TS__ClassExtends(elite_029_web, MonsterAbility_CS)
function elite_029_web.prototype.Precache(self, context)
	PrecacheResource("particle", WEB_PARTICLE, context)
end
function elite_029_web.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function elite_029_web.prototype.GetIntrinsicModifierName(self)
	return "modifier_elite_029_web_owner"
end
elite_029_web = __TS__DecorateLegacy({ registerAbility(nil) }, elite_029_web)
____exports.elite_029_web = elite_029_web
local modifier_elite_029_web_owner = __TS__Class()
modifier_elite_029_web_owner.name = "modifier_elite_029_web_owner"
__TS__ClassExtends(modifier_elite_029_web_owner, MonsterModifier_CS)
function modifier_elite_029_web_owner.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.applyElapsed = WEB_APPLY_INTERVAL
end
function modifier_elite_029_web_owner.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	self.applyElapsed = WEB_APPLY_INTERVAL
	self:Timer(WEB_ACTIVATE_DELAY, function()
		if not IsValidAlive(nil, parent) then
			return
		end
		local thinker = CreateModifierThinker(
			nil,
			self:GetAbility(),
			"modifier_elite_029_web_aura",
			{},
			parent:GetAbsOrigin(),
			DOTA_TEAM_GOODGUYS,
			false
		)
		self.webThinker = thinker
		self:StartIntervalThink(FrameTime())
	end)
end
function modifier_elite_029_web_owner.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local thinker = self.webThinker
	if not IsValidAlive(nil, thinker) then
		return
	end
	if not IsValidAlive(nil, parent) or not IsValid(nil, thinker) or thinker:IsNull() then
		self:Destroy()
		return
	end
	thinker:SetAbsOrigin(parent:GetAbsOrigin())
	self.applyElapsed = self.applyElapsed + FrameTime()
	if self.applyElapsed < WEB_APPLY_INTERVAL then
		return
	end
	self.applyElapsed = 0
	self:ApplyWebEffects(parent, thinker)
end
function modifier_elite_029_web_owner.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	local thinker = self.webThinker
	if IsValid(nil, thinker) and not thinker:IsNull() then
		thinker:RemoveSelf()
	end
	self.webThinker = nil
end
function modifier_elite_029_web_owner.prototype.IsHidden(self)
	return true
end
function modifier_elite_029_web_owner.prototype.IsPurgable(self)
	return false
end
function modifier_elite_029_web_owner.prototype.ApplyWebEffects(self, caster, thinker)
	local ability = self:GetAbility()
	if not ability or ability:IsNull() then
		return
	end
	if not IsValidAlive(nil, caster) then
		return
	end
	if not IsValidAlive(nil, thinker) then
		return
	end
	local units = FindUnitsInRadius(
		caster:GetTeamNumber(),
		thinker:GetAbsOrigin(),
		nil,
		WEB_RADIUS,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, unit in ipairs(units) do
		do
			if not IsValidAlive(nil, unit) then
				goto __continue23
			end
			if self:ShouldIgnoreWebTarget(unit) then
				goto __continue23
			end
			modifier_elite_029_web_aura_effect:applys(unit, caster, ability, { duration = WEB_EFFECT_DURATION })
		end
		::__continue23::
	end
end
function modifier_elite_029_web_owner.prototype.ShouldIgnoreWebTarget(self, unit)
	if not IsValidAlive(nil, unit) then
		return true
	end
	local ____this_1
	____this_1 = unit
	local ____opt_0 = ____this_1.GetUnitType
	local unitType = ____opt_0 and ____opt_0(____this_1)
	return unitType == UnitType.BUILDING or unitType == UnitType.DESTRUCTIBLE
end
modifier_elite_029_web_owner =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_029_web_owner") }, modifier_elite_029_web_owner)
local modifier_elite_029_web_aura = __TS__Class()
modifier_elite_029_web_aura.name = "modifier_elite_029_web_aura"
__TS__ClassExtends(modifier_elite_029_web_aura, MonsterModifier_CS)
function modifier_elite_029_web_aura.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local pfx = ParticleManager:CreateParticle(WEB_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleShouldCheckFoW(pfx, false)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		pfx,
		1,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(pfx, 2, Vector(WEB_RADIUS, WEB_RADIUS, WEB_RADIUS))
	ParticleManager:SetParticleControlEnt(
		pfx,
		3,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(WEB_RADIUS, WEB_RADIUS, WEB_RADIUS),
		true
	)
	self:AddParticle(pfx, false, false, -1, false, false)
end
function modifier_elite_029_web_aura.prototype.IsHidden(self)
	return true
end
function modifier_elite_029_web_aura.prototype.IsPurgable(self)
	return false
end
modifier_elite_029_web_aura =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_029_web_aura") }, modifier_elite_029_web_aura)
modifier_elite_029_web_aura_effect = __TS__Class()
modifier_elite_029_web_aura_effect.name = "modifier_elite_029_web_aura_effect"
__TS__ClassExtends(modifier_elite_029_web_aura_effect, MonsterModifier_CS)
function modifier_elite_029_web_aura_effect.prototype.GetAttributeBonus(self)
	local caster = self:GetCaster()
	local parent = self:GetParent()
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, parent) then
		return {}
	end
	if parent:GetTeamNumber() == caster:GetTeamNumber() then
		return { bonus_movespeed_pct = ALLY_MOVESPEED_PCT, attack_speed = ALLY_ATTACK_SPEED }
	end
	return { bonus_movespeed_pct = -ENEMY_SLOW_PCT }
end
function modifier_elite_029_web_aura_effect.prototype.IsHidden(self)
	return false
end
function modifier_elite_029_web_aura_effect.prototype.IsDebuff(self)
	local caster = self:GetCaster()
	local parent = self:GetParent()
	return parent:GetTeamNumber() ~= caster:GetTeamNumber()
end
function modifier_elite_029_web_aura_effect.prototype.IsPurgable(self)
	return false
end
function modifier_elite_029_web_aura_effect.GetLocalizationCN(self)
	return {
		name = "蛛网领域",
		description = "蛛网内的蜘蛛友军获得移动速度和攻击速度，敌人移动速度降低20%。",
	}
end
modifier_elite_029_web_aura_effect = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_029_web_aura_effect") },
	modifier_elite_029_web_aura_effect
)
return ____exports