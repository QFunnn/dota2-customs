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
local modifier_normal_041_dark_slow
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local SHIELD_MAX_HEALTH_PCT = 20
local SHIELD_DURATION = 10
local SHIELD_COOLDOWN = 10
local BREAK_SLOW_RADIUS = 500
local BREAK_SLOW_PCT = 80
local BREAK_SLOW_DURATION = 0.5
local APHOTIC_SHIELD_EFFECT = "particles/units/heroes/hero_abaddon/abaddon_aphotic_shield.vpcf"
local APHOTIC_SHIELD_SOUND = "Hero_Abaddon.AphoticShield.Cast"
--- 普通技能41 - 灭光护壳：周期性获得吞光护盾，破裂时拖慢附近敌方英雄
____exports.normal_041 = __TS__Class()
local normal_041 = ____exports.normal_041
normal_041.name = "normal_041"
__TS__ClassExtends(normal_041, MonsterAbility_CS)
function normal_041.prototype.Precache(self, context)
	PrecacheResource("particle", APHOTIC_SHIELD_EFFECT, context)
end
function normal_041.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0, cooldown = SHIELD_COOLDOWN }
end
function normal_041.prototype.GetIntrinsicModifierName(self)
	return "modifier_normal_041_dark_shell"
end
normal_041 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_041)
____exports.normal_041 = normal_041
local modifier_normal_041_dark_shell = __TS__Class()
modifier_normal_041_dark_shell.name = "modifier_normal_041_dark_shell"
__TS__ClassExtends(modifier_normal_041_dark_shell, MonsterModifier_CS)
function modifier_normal_041_dark_shell.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.nextShieldTime = 0
	self.shieldExpireTime = 0
end
function modifier_normal_041_dark_shell.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.nextShieldTime = GameRules:GetGameTime()
	self:StartIntervalThink(0.1)
end
function modifier_normal_041_dark_shell.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	if self:HasShield() and GameRules:GetGameTime() >= self.shieldExpireTime then
		self:ClearShield()
	end
	if self:HasShield() then
		return
	end
	if GameRules:GetGameTime() < self.nextShieldTime then
		return
	end
	self:GrantShield(parent)
end
function modifier_normal_041_dark_shell.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_PRE_APPLY }
end
function modifier_normal_041_dark_shell.prototype.OnDamagePreApply_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.ctx.spec.victim ~= parent then
		return
	end
	if not self:HasShield() then
		return
	end
	if CheckTag(nil, event.ctx.spec.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	local damage = self:GetCurrentPipeDamage(event.final)
	if damage <= 0 then
		return
	end
	local hasDarknessBuff = parent:HasModifier("modifier_env_monster_darkness")
	local shield = self:GetStackCount()
	local absorbed = math.min(shield, damage)
	if hasDarknessBuff then
		absorbed = math.min(shield, damage * 3)
	end
	local ____event_final_0, ____add_1 = event.final, "add"
	if ____event_final_0[____add_1] == nil then
		____event_final_0[____add_1] = {}
	end
	local ____event_final_add_2 = event.final.add
	____event_final_add_2[#____event_final_add_2 + 1] = { value = -absorbed, source = "normal_041:护盾吸收" }
	local nextShield = shield - absorbed
	if nextShield <= 0 then
		self:BreakShield(parent)
		return
	end
	self:SetStackCount(math.ceil(nextShield))
end
function modifier_normal_041_dark_shell.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:DestroyShieldParticle()
end
function modifier_normal_041_dark_shell.prototype.GrantShield(self, parent)
	if not IsValidAlive(nil, parent) then
		return
	end
	local shieldAmount = math.max(1, math.floor(parent:GetMaxHealth() * SHIELD_MAX_HEALTH_PCT / 100))
	self:SetStackCount(shieldAmount)
	self.shieldExpireTime = GameRules:GetGameTime() + SHIELD_DURATION
	self.nextShieldTime = GameRules:GetGameTime() + SHIELD_COOLDOWN
	self:CreateOrRefreshShieldParticle(parent)
	EmitSoundOn(APHOTIC_SHIELD_SOUND, parent)
	local ability = self:GetAbility()
	if ability and IsValid(nil, ability) then
		ability:StartCooldown(SHIELD_COOLDOWN)
	end
end
function modifier_normal_041_dark_shell.prototype.BreakShield(self, parent)
	self:SetStackCount(0)
	self.shieldExpireTime = 0
	self:DestroyShieldParticle()
	EmitSoundOn(APHOTIC_SHIELD_SOUND, parent)
	self:SlowNearbyHeroes(parent)
end
function modifier_normal_041_dark_shell.prototype.ClearShield(self)
	self:SetStackCount(0)
	self.shieldExpireTime = 0
	self:DestroyShieldParticle()
end
function modifier_normal_041_dark_shell.prototype.SlowNearbyHeroes(self, parent)
	local ability = self:GetAbility()
	local enemies = self:FindHeroesInRadius(BREAK_SLOW_RADIUS, parent:GetAbsOrigin())
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue30
			end
			modifier_normal_041_dark_slow:applys(enemy, parent, ability, { duration = BREAK_SLOW_DURATION })
		end
		::__continue30::
	end
end
function modifier_normal_041_dark_shell.prototype.GetCurrentPipeDamage(self, final)
	local damage = final.base
	if final.add then
		for ____, value in ipairs(final.add) do
			damage = damage + value.value
		end
	end
	if final.mul then
		for ____, value in ipairs(final.mul) do
			damage = damage * value.value
		end
	end
	return math.max(0, damage)
end
function modifier_normal_041_dark_shell.prototype.HasShield(self)
	return self:GetStackCount() > 0
end
function modifier_normal_041_dark_shell.prototype.CreateOrRefreshShieldParticle(self, parent)
	self:DestroyShieldParticle()
	if not IsValidAlive(nil, parent) then
		return
	end
	self.shieldParticle = ParticleManager:CreateParticle(APHOTIC_SHIELD_EFFECT, PATTACH_POINT_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		self.shieldParticle,
		0,
		parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(self.shieldParticle, 1, Vector(100, 100, 100))
end
function modifier_normal_041_dark_shell.prototype.DestroyShieldParticle(self)
	if self.shieldParticle == nil then
		return
	end
	ParticleManager:DestroyParticle(self.shieldParticle, false)
	ParticleManager:ReleaseParticleIndex(self.shieldParticle)
	self.shieldParticle = nil
end
function modifier_normal_041_dark_shell.prototype.IsHidden(self)
	return not self:HasShield()
end
function modifier_normal_041_dark_shell.prototype.IsPurgable(self)
	return false
end
function modifier_normal_041_dark_shell.prototype.GetTexture(self)
	return "abaddon_aphotic_shield"
end
modifier_normal_041_dark_shell =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_041_dark_shell") }, modifier_normal_041_dark_shell)
modifier_normal_041_dark_slow = __TS__Class()
modifier_normal_041_dark_slow.name = "modifier_normal_041_dark_slow"
__TS__ClassExtends(modifier_normal_041_dark_slow, MonsterModifier_CS)
function modifier_normal_041_dark_slow.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = -BREAK_SLOW_PCT }
end
function modifier_normal_041_dark_slow.prototype.IsHidden(self)
	return false
end
function modifier_normal_041_dark_slow.prototype.IsDebuff(self)
	return true
end
function modifier_normal_041_dark_slow.prototype.IsPurgable(self)
	return true
end
function modifier_normal_041_dark_slow.prototype.GetTexture(self)
	return "abaddon_aphotic_shield"
end
function modifier_normal_041_dark_slow.GetLocalizationCN(self)
	return { name = "灭光迟缓", description = "移动速度降低80%。" }
end
modifier_normal_041_dark_slow =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_041_dark_slow") }, modifier_normal_041_dark_slow)
return ____exports