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
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local BaseHeroModifier = _____base_hero_ability.BaseHeroModifier
local LINA_013_LIGHT_STRIKE_PARTICLE = "particles/lina_spell_light_strike_array_2.vpcf"
local LINA_013_DIVINITY_LIGHT_STRIKE_PARTICLE = "particles/units/heroes/hero_lina/lina_spell_light_strike_array.vpcf"
local LINA_013_FIERY_SOUL_PARTICLE = "particles/units/heroes/hero_lina/lina_fiery_soul.vpcf"
local LINA_013_DIVINITY_OVERLOAD_PARTICLE = "particles/hero/lina/lina_013/item_p107buff_model_2.vpcf"
local LINA_013_DIVINITY_MOVESPEED_PCT = 50
local LINA_013_DIVINITY_ATTACK_SPEED_PCT = 50
local LINA_013_DIVINITY_OUTGOING_DAMAGE_PCT = 20
local LINA_013_DIVINITY_DAMAGE_REDUCTION_PCT = 20
local LINA_013_DIVINITY_BONUS_ATTACK_RANGE = 100
local LINA_013_DIVINITY_LIGHT_STRIKE_DAMAGE_PCT = 20
local LINA_013_DIVINITY_LIGHT_STRIKE_STUN_DURATION_PCT = 50
--- 符印：化神，神格状态持续时间增加百分比
local LINA_013_DIVINITY_DURATION_PCT_KEY = "lina_013_divinity_duration_pct"
____exports.lina_013 = __TS__Class()
local lina_013 = ____exports.lina_013
lina_013.name = "lina_013"
__TS__ClassExtends(lina_013, BaseHeroAbility)
function lina_013.prototype.Precache(self, context)
	PrecacheResource("particle", LINA_013_LIGHT_STRIKE_PARTICLE, context)
	PrecacheResource("particle", LINA_013_DIVINITY_LIGHT_STRIKE_PARTICLE, context)
	PrecacheResource("particle", LINA_013_FIERY_SOUL_PARTICLE, context)
	PrecacheResource("particle", LINA_013_DIVINITY_OVERLOAD_PARTICLE, context)
end
function lina_013.prototype.GetAbilityConfig(self)
	return {
		castPoint = 0.25,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		animationPlaybackRate = 1.35,
		behavior = DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE,
	}
end
function lina_013.prototype.GetAOERadius(self)
	return self:GetSpecialValue("lina_013", "damage_radius")
end
function lina_013.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local center = GetGroundPosition(self:GetCursorPosition(), caster)
	local radius = self:GetSpecialValue("lina_013", "damage_radius")
	local intDamagePct = self:GetSpecialValue("lina_013", "int_damage_pct")
	local stunDuration = self:GetSpecialValue("lina_013", "stun_duration")
	local isDivinityLightStrike = self:IsDivinityLightStrike(caster)
	local ____isDivinityLightStrike_0
	if isDivinityLightStrike then
		____isDivinityLightStrike_0 = 100 + LINA_013_DIVINITY_LIGHT_STRIKE_DAMAGE_PCT
	else
		____isDivinityLightStrike_0 = 100
	end
	local damageMultiplierPct = ____isDivinityLightStrike_0
	local ____isDivinityLightStrike_1
	if isDivinityLightStrike then
		____isDivinityLightStrike_1 = 100 + LINA_013_DIVINITY_LIGHT_STRIKE_STUN_DURATION_PCT
	else
		____isDivinityLightStrike_1 = 100
	end
	local stunMultiplierPct = ____isDivinityLightStrike_1
	local damage = self:GetIntelligence(caster) * intDamagePct / 100 * (damageMultiplierPct / 100)
	local finalStunDuration = stunDuration * (stunMultiplierPct / 100)
	self:PlayLightStrike(center, radius, isDivinityLightStrike)
	if MyGameDestructibleManager ~= nil then
		MyGameDestructibleManager:BreakCircleForHero(caster, center, radius, self)
	end
	local enemies = self:FindMonsterEnemies(center, radius)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue8
			end
			local ____opt_4 = enemy.GetUnitType
			local unitType = ____opt_4 and ____opt_4(enemy)
			if unitType == UnitType.BUILDING or unitType == UnitType.DESTRUCTIBLE then
				goto __continue8
			end
			Damage:ApplyDamage({
				attacker = caster,
				victim = enemy,
				damage = damage + 120,
				damage_type = 2,
				ability = self,
				extra_data = { source_name = self:GetAbilityName() },
			})
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = finalStunDuration })
		end
		::__continue8::
	end
	if ____exports.modifier_lina_013_light_strike_overload:find_on(caster) then
		return
	end
	self:AddOrRefreshLightStrikeStacks(caster)
end
function lina_013.prototype.AddOrRefreshLightStrikeStacks(self, caster)
	local stackDuration = self:GetSpecialValue("lina_013", "stack_duration")
	local maxStacks = math.max(1, math.floor(self:GetSpecialValue("lina_013", "max_stacks")))
	local stackModifier =
		____exports.modifier_lina_013_light_strike_stack:applys(caster, caster, self, { duration = stackDuration })
	if stackModifier:GetStackCount() >= maxStacks then
		stackModifier:Destroy()
		____exports.modifier_lina_013_light_strike_overload:applys(
			caster,
			caster,
			self,
			{ duration = self:GetDivinityDuration(caster) }
		)
	end
end
function lina_013.prototype.GetDivinityDuration(self, caster)
	local baseDuration = self:GetSpecialValue("lina_013", "max_stack_duration")
	local ____tonumber_8 = tonumber
	local ____this_7
	____this_7 = caster
	local ____opt_6 = ____this_7.GetCustomValue
	local bonusPct = ____tonumber_8(____opt_6 and ____opt_6(____this_7, LINA_013_DIVINITY_DURATION_PCT_KEY) or 0)
	return baseDuration * (1 + bonusPct / 100)
end
function lina_013.prototype.IsDivinityLightStrike(self, caster)
	if ____exports.modifier_lina_013_light_strike_overload:find_on(caster) then
		return true
	end
	local stackModifier = ____exports.modifier_lina_013_light_strike_stack:find_on(caster)
	if not stackModifier then
		return false
	end
	local maxStacks = math.max(1, math.floor(self:GetSpecialValue("lina_013", "max_stacks")))
	return stackModifier:GetStackCount() >= maxStacks - 1
end
function lina_013.prototype.PlayLightStrike(self, center, radius, isDivinityLightStrike)
	local particleName = isDivinityLightStrike and LINA_013_DIVINITY_LIGHT_STRIKE_PARTICLE
		or LINA_013_LIGHT_STRIKE_PARTICLE
	local caster = self:GetCaster()
	local pfx = MyGameHeroParticleManager:CreateParticle(particleName, PATTACH_WORLDORIGIN, caster, caster)
	MyGameHeroParticleManager:SetParticleControl(pfx, 0, center)
	MyGameHeroParticleManager:SetParticleControl(pfx, 1, Vector(radius, 1, 1))
	MyGameHeroParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOnLocationWithCaster(center, "Ability.LightStrikeArray", caster)
end
lina_013 = __TS__DecorateLegacy({ registerAbility(nil) }, lina_013)
____exports.lina_013 = lina_013
____exports.modifier_lina_013_light_strike_stack = __TS__Class()
local modifier_lina_013_light_strike_stack = ____exports.modifier_lina_013_light_strike_stack
modifier_lina_013_light_strike_stack.name = "modifier_lina_013_light_strike_stack"
__TS__ClassExtends(modifier_lina_013_light_strike_stack, BaseHeroModifier)
function modifier_lina_013_light_strike_stack.GetLocalizationCN(self)
	return { name = "光击阵余威", description = "每层提高移动速度。" }
end
function modifier_lina_013_light_strike_stack.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_lina_013_light_strike_stack.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
	self:RefreshAttributes()
	self:EnsureParticleAndUpdate()
end
function modifier_lina_013_light_strike_stack.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return
	end
	local maxStacks = math.max(1, math.floor(ability:GetSpecialValue("lina_013", "max_stacks")))
	local nextStacks = math.min(self:GetStackCount() + 1, maxStacks)
	self:SetStackCount(nextStacks)
	self:RefreshAttributes()
	self:EnsureParticleAndUpdate()
end
function modifier_lina_013_light_strike_stack.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self.particleId == nil then
		return
	end
	ParticleManager:DestroyParticle(self.particleId, false)
	ParticleManager:ReleaseParticleIndex(self.particleId)
	self.particleId = nil
end
function modifier_lina_013_light_strike_stack.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return {}
	end
	local stacks = self:GetStackCount()
	if stacks <= 0 then
		return {}
	end
	return { bonus_movespeed_pct = ability:GetSpecialValue("lina_013", "buff_movespeed_pct_per_stack") * stacks }
end
function modifier_lina_013_light_strike_stack.prototype.EnsureParticleAndUpdate(self)
	local parent = self:GetParent()
	if self.particleId == nil then
		self.particleId = ParticleManager:CreateParticle(LINA_013_FIERY_SOUL_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
		ParticleManager:SetParticleControlEnt(
			self.particleId,
			0,
			parent,
			PATTACH_CENTER_FOLLOW,
			"attach_hitloc",
			parent:GetAbsOrigin(),
			true
		)
		self:AddParticle(self.particleId, false, false, -1, false, false)
	end
	ParticleManager:SetParticleControl(self.particleId, 1, Vector(self:GetStackCount(), 0, 0))
end
modifier_lina_013_light_strike_stack =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_lina_013_light_strike_stack)
____exports.modifier_lina_013_light_strike_stack = modifier_lina_013_light_strike_stack
____exports.modifier_lina_013_light_strike_overload = __TS__Class()
local modifier_lina_013_light_strike_overload = ____exports.modifier_lina_013_light_strike_overload
modifier_lina_013_light_strike_overload.name = "modifier_lina_013_light_strike_overload"
__TS__ClassExtends(modifier_lina_013_light_strike_overload, BaseHeroModifier)
function modifier_lina_013_light_strike_overload.GetLocalizationCN(self)
	return {
		name = "神格状态",
		description = "提高伤害、减免伤害，并提高攻击速度和移动速度。",
	}
end
function modifier_lina_013_light_strike_overload.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_lina_013_light_strike_overload.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return {}
	end
	return {
		attack_speed_pct = LINA_013_DIVINITY_ATTACK_SPEED_PCT,
		bonus_movespeed_pct = LINA_013_DIVINITY_MOVESPEED_PCT,
		outgoing_damage_pct_2 = LINA_013_DIVINITY_OUTGOING_DAMAGE_PCT,
		damage_reduction_pct = LINA_013_DIVINITY_DAMAGE_REDUCTION_PCT,
		bonus_attack_range = LINA_013_DIVINITY_BONUS_ATTACK_RANGE,
	}
end
function modifier_lina_013_light_strike_overload.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SetOverloadStackCount()
	self:RefreshAttributes()
	self:PlayOverloadEffect()
end
function modifier_lina_013_light_strike_overload.prototype.GetEffectName(self)
	return LINA_013_DIVINITY_OVERLOAD_PARTICLE
end
function modifier_lina_013_light_strike_overload.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:SetOverloadStackCount()
	self:RefreshAttributes()
	self:PlayOverloadEffect()
end
function modifier_lina_013_light_strike_overload.prototype.SetOverloadStackCount(self)
	self:SetStackCount(0)
end
function modifier_lina_013_light_strike_overload.prototype.PlayOverloadEffect(self)
	local parent = self:GetParent()
	local pfx = ParticleManager:CreateParticle(LINA_013_FIERY_SOUL_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		parent,
		PATTACH_CENTER_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(pfx, 1, Vector(self:GetStackCount(), 0, 0))
	self:AddParticle(pfx, false, false, -1, false, false)
end
modifier_lina_013_light_strike_overload =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_lina_013_light_strike_overload)
____exports.modifier_lina_013_light_strike_overload = modifier_lina_013_light_strike_overload
return ____exports