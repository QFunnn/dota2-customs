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
local modifier_elite_050_stone_skin
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_POINT = 0.8
local BUFF_DURATION = 5
local PULSE_INTERVAL = 1
local PULSE_RADIUS = 300
local DAMAGE_RATE = 15
local ARMOR_BONUS = 20
local PULSE_PARTICLE = "particles/units/heroes/hero_centaur/centaur_warstomp.vpcf"
local BUFF_PARTICLE = "particles/units/heroes/hero_earth_spirit/espirit_rollingboulder.vpcf"
local BUFF_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_earth_spirit.vsndevts"
local PULSE_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_centaur.vsndevts"
local BUFF_CAST_SOUND = "Hero_EarthSpirit.RollingBoulder.Cast"
local PULSE_SOUND = "Hero_Centaur.HoofStomp"
--- 精英技能50 - 石肤震荡：获得护甲并周期性震击近身敌人
____exports.elite_050 = __TS__Class()
local elite_050 = ____exports.elite_050
elite_050.name = "elite_050"
__TS__ClassExtends(elite_050, MonsterAbility_CS)
function elite_050.prototype.Precache(self, context)
	PrecacheResource("particle", PULSE_PARTICLE, context)
	PrecacheResource("particle", BUFF_PARTICLE, context)
	PrecacheResource("soundfile", BUFF_SOUND_EVENTS, context)
	PrecacheResource("soundfile", PULSE_SOUND_EVENTS, context)
end
function elite_050.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = 900,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = BUFF_DURATION,
		isNotMove = false,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			EmitSoundOn(BUFF_CAST_SOUND, caster)
			modifier_elite_050_stone_skin:applys(caster, caster, self, { duration = BUFF_DURATION })
		end,
	}
end
elite_050 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_050)
____exports.elite_050 = elite_050
modifier_elite_050_stone_skin = __TS__Class()
modifier_elite_050_stone_skin.name = "modifier_elite_050_stone_skin"
__TS__ClassExtends(modifier_elite_050_stone_skin, MonsterModifier_CS)
function modifier_elite_050_stone_skin.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.buffParticle = -1
end
function modifier_elite_050_stone_skin.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	self.buffParticle = ParticleManager:CreateParticle(BUFF_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	self:StartIntervalThink(PULSE_INTERVAL)
end
function modifier_elite_050_stone_skin.prototype.OnIntervalThink(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) or not ability then
		self:Destroy()
		return
	end
	local origin = parent:GetAbsOrigin()
	local pfx = ParticleManager:CreateParticle(PULSE_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, origin)
	ParticleManager:SetParticleControl(pfx, 1, Vector(PULSE_RADIUS, PULSE_RADIUS, PULSE_RADIUS))
	ParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOnLocationWithCaster(origin, PULSE_SOUND, parent)
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		origin,
		nil,
		PULSE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		if IsValidAlive(nil, enemy) then
			parent:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = ability })
			enemy:KnockBack(parent, ability, {
				duration = 0.2,
				distance = 200,
				height = 120,
				direction = parent:GetForwardVector(),
				stun = true,
				stunDuration = 0.2,
			})
		end
	end
end
function modifier_elite_050_stone_skin.prototype.OnDestroy(self)
	if IsServer() and self.buffParticle ~= -1 then
		ParticleManager:SetParticleControl(self.buffParticle, 3, self:GetParent():GetAbsOrigin())
		ParticleManager:DestroyParticle(self.buffParticle, false)
		ParticleManager:ReleaseParticleIndex(self.buffParticle)
	end
end
function modifier_elite_050_stone_skin.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_SCALE }
end
function modifier_elite_050_stone_skin.prototype.GetModifierModelScale(self)
	return -50
end
function modifier_elite_050_stone_skin.prototype.GetAttributeBonus(self)
	return { bonus_armor = ARMOR_BONUS, bonus_movespeed_pct = 100 }
end
function modifier_elite_050_stone_skin.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = false, isPurgable = false }
end
function modifier_elite_050_stone_skin.GetLocalizationCN(self)
	return { name = "石肤震荡", description = "护甲提升，并周期性震击附近敌人。" }
end
modifier_elite_050_stone_skin =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_050_stone_skin") }, modifier_elite_050_stone_skin)
return ____exports