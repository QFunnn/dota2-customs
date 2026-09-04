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
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local KATANA_TRIGGER_CHANCE = 100
local KATANA_PARRY_DURATION = 1
local KATANA_COOLDOWN = 5
local PARRY_PARTICLE = "particles/unit/boss_kez_4.vpcf"
local PARRY_CIRCLE_RADIUS = 35
local AMBIENT_PARTICLE = "particles/units/heroes/hero_enigma/enigma_ambient_body.vpcf"
local EYE_L_PARTICLE = "particles/units/heroes/hero_enigma/enigma_ambient_eye_l.vpcf"
local EYE_R_PARTICLE = "particles/units/heroes/hero_enigma/enigma_ambient_eye_r.vpcf"
--- 在 Boss 身前面向攻击者方向播放招架粒子
local function emitParryParticle(self, boss, attacker)
	local bossPos = boss:GetAbsOrigin()
	local attackerDir = attacker:GetAbsOrigin():__sub(bossPos):Normalized()
	local forwardPoint = bossPos:__add(attackerDir:__mul(PARRY_CIRCLE_RADIUS))
	local particle = ParticleManager:CreateParticle(PARRY_PARTICLE, PATTACH_POINT, boss)
	ParticleManager:SetParticleControlTransformForward(particle, 1, forwardPoint, attackerDir)
	ParticleManager:ReleaseParticleIndex(particle)
end
____exports.boss_kez_4 = __TS__Class()
local boss_kez_4 = ____exports.boss_kez_4
boss_kez_4.name = "boss_kez_4"
__TS__ClassExtends(boss_kez_4, MonsterAbility_CS)
function boss_kez_4.prototype.Precache(self, context)
	PrecacheResource("particle", AMBIENT_PARTICLE, context)
	PrecacheResource("particle", EYE_L_PARTICLE, context)
	PrecacheResource("particle", EYE_R_PARTICLE, context)
end
function boss_kez_4.prototype.GetMosnterAbilityConfig(self)
	return { castPoint = 0, castDuration = 0, behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE + DOTA_ABILITY_BEHAVIOR_HIDDEN }
end
function boss_kez_4.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_boss_kez_4_passive.name
end
boss_kez_4 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_kez_4)
____exports.boss_kez_4 = boss_kez_4
--- 始终存在的被动 modifier，根据 stance 在受击时触发效果
____exports.modifier_boss_kez_4_passive = __TS__Class()
local modifier_boss_kez_4_passive = ____exports.modifier_boss_kez_4_passive
modifier_boss_kez_4_passive.name = "modifier_boss_kez_4_passive"
__TS__ClassExtends(modifier_boss_kez_4_passive, BaseModifier_CS)
function modifier_boss_kez_4_passive.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self._katanaLastCheckTime = 0
end
function modifier_boss_kez_4_passive.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(1)
end
function modifier_boss_kez_4_passive.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function modifier_boss_kez_4_passive.prototype.GetActivityTranslationModifiers(self)
	return "aggressive"
end
function modifier_boss_kez_4_passive.prototype.OnIntervalThink(self)
	local parent = self:GetParent()
	local ambientPfx = ParticleManager:CreateParticle(AMBIENT_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	self:AddParticle(ambientPfx, false, false, -1, false, false)
	local eyeLPfx = ParticleManager:CreateParticle(EYE_L_PARTICLE, PATTACH_POINT_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(eyeLPfx, 0, parent, PATTACH_POINT_FOLLOW, "eye_l", Vector(0, 0, 0), true)
	self:AddParticle(eyeLPfx, false, false, -1, false, false)
	local eyeRPfx = ParticleManager:CreateParticle(EYE_R_PARTICLE, PATTACH_POINT_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(eyeRPfx, 0, parent, PATTACH_POINT_FOLLOW, "eye_r", Vector(0, 0, 0), true)
	self:AddParticle(eyeRPfx, false, false, -1, false, false)
	self:StartIntervalThink(-1)
end
function modifier_boss_kez_4_passive.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_PROJECTILE_HIT_PRE_APPLY }
end
function modifier_boss_kez_4_passive.prototype.OnProjectileHitPreApply_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.target ~= parent then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	if parent:IsMonsterCasting() then
		return
	end
	self:handleKatana(event)
end
function modifier_boss_kez_4_passive.prototype.handleKatana(self, event)
	if event.projectile_type ~= "tracking" then
		return
	end
	local now = GameRules:GetGameTime()
	if now - self._katanaLastCheckTime < KATANA_COOLDOWN then
		return
	end
	self._katanaLastCheckTime = now
	if
		not RollPseudoRandomPercentage(KATANA_TRIGGER_CHANCE, DOTA_PSEUDO_RANDOM_ARMADILLO_HEARTPIERCER, self._caster)
	then
		return
	end
	event.prevent_hit = true
	event.destroy_projectile = true
	local parent = self:GetParent()
	emitParryParticle(nil, parent, event.caster)
	parent:EmitSound("Hero_DragonKnight.Attack")
	self:deflectProjectile(event, parent)
	____exports.modifier_boss_kez_4_parry:applys(parent, parent, self._ability, { duration = KATANA_PARRY_DURATION })
end
function modifier_boss_kez_4_passive.prototype.handleSai(self, _event) end
function modifier_boss_kez_4_passive.prototype.deflectProjectile(self, event, caster)
	local failPoint = caster:GetAbsOrigin():__add(RandomVector(500))
	failPoint.z = GetGroundPosition(failPoint, caster).z
	CreateProjectile(nil, {
		ability = self._ability,
		caster = caster,
		effect_name = event.effect_name,
		target = failPoint,
		start_point = caster:GetAbsOrigin(),
		projectile_type = "collideground",
		projectile_speed = 1000,
		on_hit = function(____, _hitTarget, _location)
			return true
		end,
	})
end
function modifier_boss_kez_4_passive.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false }
end
modifier_boss_kez_4_passive = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_kez_4_passive)
____exports.modifier_boss_kez_4_passive = modifier_boss_kez_4_passive
--- 招架 buff：1 秒内阻挡所有投射物
____exports.modifier_boss_kez_4_parry = __TS__Class()
local modifier_boss_kez_4_parry = ____exports.modifier_boss_kez_4_parry
modifier_boss_kez_4_parry.name = "modifier_boss_kez_4_parry"
__TS__ClassExtends(modifier_boss_kez_4_parry, BaseModifier_CS)
function modifier_boss_kez_4_parry.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function modifier_boss_kez_4_parry.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_OVERRIDE_ABILITY_3
end
function modifier_boss_kez_4_parry.prototype.GetActivityTranslationModifiers(self)
	return "parry"
end
function modifier_boss_kez_4_parry.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_PROJECTILE_HIT_PRE_APPLY }
end
function modifier_boss_kez_4_parry.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(0.2)
	self:OnIntervalThink()
end
function modifier_boss_kez_4_parry.prototype.OnIntervalThink(self)
	local sounds = { "Hero_DragonKnight.Attack", "Hero_DoomBringer.Attack" }
	local randomSound = sounds[math.floor(math.random() * #sounds) + 1]
	if not IsValidAlive(nil, self._caster) then
		return
	end
	self._caster:EmitSound(randomSound)
end
function modifier_boss_kez_4_parry.prototype.OnProjectileHitPreApply_CS(self, event)
	if not IsServer() then
		return
	end
	if event.target ~= self:GetParent() then
		return
	end
	event.prevent_hit = true
	event.destroy_projectile = true
	local parent = self:GetParent()
	parent:EmitSound("Hero_DragonKnight.Attack")
	emitParryParticle(nil, parent, event.caster)
	local failPoint = parent:GetAbsOrigin():__add(RandomVector(500))
	failPoint.z = GetGroundPosition(failPoint, parent).z
	CreateProjectile(nil, {
		ability = self._ability,
		caster = parent,
		effect_name = event.effect_name,
		target = failPoint,
		start_point = parent:GetAbsOrigin(),
		projectile_type = "collideground",
		projectile_speed = 1000,
		on_hit = function(____, _hitTarget, _location)
			return true
		end,
	})
end
function modifier_boss_kez_4_parry.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = false, isPurgable = false }
end
function modifier_boss_kez_4_parry.GetLocalizationCN(self)
	return { name = "招架", description = "阻挡所有投射物。" }
end
modifier_boss_kez_4_parry = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_kez_4_parry)
____exports.modifier_boss_kez_4_parry = modifier_boss_kez_4_parry
return ____exports