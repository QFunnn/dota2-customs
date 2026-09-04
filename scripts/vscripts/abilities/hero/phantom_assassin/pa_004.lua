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
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local modifier_pa_004_dash
local ____modifier_generic_motion = require("modifiers.modifier_generic_motion")
local modifier_generic_dash = ____modifier_generic_motion.modifier_generic_dash
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local PA_004_DASH_DURATION = 0.35
local PA_004_DAMAGE_REDUCTION_PCT = 50
local PA_004_HIT_KNOCKBACK_DURATION = 0.2
local PA_004_DASH_START_SOUND = "Hero_PhantomAssassin.Strike.Start"
local PA_004_DASH_END_SOUND = "Hero_PhantomAssassin.Strike.End"
--- 符印：无限猎手，命中时移除控制效果。
local PA_004_DISABLE_HIT_CONTROL_KEY = "pa_004_disable_hit_control"
--- 幻影刺客技能 004 位移,冲刺到目标位置
____exports.pa_004 = __TS__Class()
local pa_004 = ____exports.pa_004
pa_004.name = "pa_004"
__TS__ClassExtends(pa_004, BaseHeroAbility)
function pa_004.prototype.GetCastRange(self, _location, _target)
	if IsClient() then
		return self:GetSpecialValue("axe_004", "dash_distance")
	end
	return 25000
end
function pa_004.prototype.GetAbilityConfig(self)
	return { castPoint = 0, castAnimation = ACT_DOTA_CAST_ABILITY_4, behavior = DOTA_ABILITY_BEHAVIOR_POINT }
end
function pa_004.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	caster:EmitSound(PA_004_DASH_START_SOUND)
	local point = self:GetCursorPosition()
	local origin = caster:GetAbsOrigin()
	local dir = GetDirection(nil, point, origin)
	local dashDistance = self:GetSpecialValue("pa_004", "dash_distance")
	local playerDistance = origin:__sub(point):Length2D()
	local minDistance = dashDistance * 0.618
	local maxDistance = dashDistance
	local distance = math.min(math.max(minDistance, playerDistance), maxDistance)
	caster:AddNewModifier(
		caster,
		self,
		"modifier_cs_damage_reduction",
		{ duration = PA_004_DASH_DURATION, damage_reduction_pct = PA_004_DAMAGE_REDUCTION_PCT }
	)
	modifier_pa_004_dash:applys(caster, caster, self, {
		distance = distance,
		dir = dir,
		duration = PA_004_DASH_DURATION,
		corridor_half_width = 500,
		cell_size = 80,
		break_destructibles = 1,
	})
	local pfx = MyGameHeroParticleManager:CreateParticle(
		"particles/hero/pa/juggernaut_blade_fury_abyssal_start_pa004.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster,
		caster
	)
	MyGameHeroParticleManager:SetParticleControl(pfx, 0, caster:GetAbsOrigin())
	MyGameHeroParticleManager:SetParticleControl(pfx, 1, caster:GetAbsOrigin())
	MyGameHeroParticleManager:SetParticleControl(pfx, 2, caster:GetAbsOrigin())
	MyGameHeroParticleManager:ReleaseParticleIndex(pfx)
end
function pa_004.prototype.HasDisableHitControlGem(self, caster)
	if caster == nil then
		caster = self:GetCaster()
	end
	local ____tonumber_2 = tonumber
	local ____this_1
	____this_1 = caster
	local ____opt_0 = ____this_1.GetCustomValue
	return ____tonumber_2(____opt_0 and ____opt_0(____this_1, PA_004_DISABLE_HIT_CONTROL_KEY) or 0) > 0
end
pa_004 = __TS__DecorateLegacy({ registerAbility(nil) }, pa_004)
____exports.pa_004 = pa_004
modifier_pa_004_dash = __TS__Class()
modifier_pa_004_dash.name = "modifier_pa_004_dash"
__TS__ClassExtends(modifier_pa_004_dash, modifier_generic_dash)
function modifier_pa_004_dash.prototype.____constructor(self, ...)
	modifier_generic_dash.prototype.____constructor(self, ...)
	self.hitTargetSet = __TS__New(Set)
	self.dashHitRadius = 250
	self.dashHitDamageMultiplierPct = 150
	self.disableHitControl = false
end
function modifier_pa_004_dash.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}
end
function modifier_pa_004_dash.prototype.GetActivityTranslationModifiers(self)
	return "loda"
end
function modifier_pa_004_dash.prototype.GetOverrideAnimationRate(self)
	return 1.5
end
function modifier_pa_004_dash.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_CAST_ABILITY_4
end
function modifier_pa_004_dash.prototype.OnCreated(self, kv)
	modifier_generic_dash.prototype.OnCreated(self, kv)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	if ability then
		self.dashHitRadius = ability:GetSpecialValue("pa_004", "dash_hit_radius")
		self.dashHitDamageMultiplierPct =
			math.max(0, ability:GetSpecialValue("pa_004", "dash_hit_damage_multiplier_pct"))
		self.dashMovespeedThreshold = ability:GetSpecialValue("pa_004", "dash_movespeed_threshold")
		self.dashMovespeedStep = ability:GetSpecialValue("pa_004", "dash_movespeed_step")
		self.disableHitControl = ability:HasDisableHitControlGem(self:GetCaster())
	end
	if self:GetCaster():GetModelName() == "models/heroes/phantom_assassin/pa_arcana.vmdl" then
		self._caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK_EVENT, 2)
	else
		self:StartIntervalThink(PA_004_DASH_DURATION - 0.2)
	end
end
function modifier_pa_004_dash.prototype.OnIntervalThink(self)
	if IsServer() then
		if not IsValidAlive(nil, self._caster) then
			return
		end
		self._caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK_EVENT, 2.5)
		self:StartIntervalThink(-1)
	end
end
function modifier_pa_004_dash.prototype.UpdateHorizontalMotion(self, me, dt)
	modifier_generic_dash.prototype.UpdateHorizontalMotion(self, me, dt)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	local caster = self:GetCaster()
	if not ability or not IsValidAlive(nil, caster) then
		return
	end
	local totalMovespeed = MyGameAttribute:GetAttribute(caster, "total_movespeed") or caster:GetIdealSpeed()
	local extraMovespeed = math.max(0, totalMovespeed - self.dashMovespeedThreshold)
	local movespeedDamageAmpPct = math.floor(extraMovespeed / self.dashMovespeedStep)
	local baseDamage = ability:GetAllAttackDamage(caster) * self.dashHitDamageMultiplierPct / 100
	local damage = baseDamage * (1 + movespeedDamageAmpPct / 100)
	local enemies = ability:FindMonsterEnemies(me:GetAbsOrigin(), self.dashHitRadius)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue23
			end
			local enemyId = enemy:GetEntityIndex()
			if self.hitTargetSet:has(enemyId) then
				goto __continue23
			end
			self.hitTargetSet:add(enemyId)
			Damage:ApplyDamage({
				attacker = caster,
				victim = enemy,
				damage = damage,
				damage_type = 1,
				ability = ability,
			})
			if not self.disableHitControl then
				local currentDistance = caster:GetAbsOrigin():__sub(enemy:GetAbsOrigin()):Length2D()
				local knockbackDistance = math.max(0, self.dashHitRadius - currentDistance)
				enemy:KnockBack(caster, ability, {
					duration = PA_004_HIT_KNOCKBACK_DURATION,
					distance = knockbackDistance,
					height = 0,
					stun = false,
					origin_pos = caster:GetAbsOrigin(),
					removeOnDeath = true,
					particleName = "",
				})
			end
			if self.hitTargetSet.size < 2 then
				MyGameAttack:PerformAttack(caster, enemy, { use_projectile = false })
			end
		end
		::__continue23::
	end
end
function modifier_pa_004_dash.prototype.OnDestroy(self)
	local caster = self:GetCaster()
	if IsServer() and IsValidAlive(nil, caster) then
		caster:EmitSound(PA_004_DASH_END_SOUND)
	end
	modifier_generic_dash.prototype.OnDestroy(self)
end
function modifier_pa_004_dash.prototype.GetEffectName(self)
	return "particles/hero/pa/dashhero/pa_dash.vpcf"
end
modifier_pa_004_dash = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_pa_004_dash)
return ____exports