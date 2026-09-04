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
local modifier_elite_056_frenzy
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_POINT = 0.35
local BUFF_DURATION = 6
local BONUS_MOVESPEED_PCT = 45
local BONUS_ATTACK_SPEED = 80
local CLEAVE_RADIUS = 260
local CLEAVE_DAMAGE_RATE = 10
local CLEAVE_COOLDOWN = 0.6
local CLEAVE_PARTICLE = "particles/units/heroes/hero_sven/sven_spell_great_cleave.vpcf"
local FRENZY_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_sven.vsndevts"
local FRENZY_CAST_SOUND = "Hero_Sven.WarCry"
--- 精英技能56 - 结晶狂热：提升速度，攻击命中时对目标附近追加晶刃伤害
____exports.elite_056 = __TS__Class()
local elite_056 = ____exports.elite_056
elite_056.name = "elite_056"
__TS__ClassExtends(elite_056, MonsterAbility_CS)
function elite_056.prototype.Precache(self, context)
	PrecacheResource("particle", CLEAVE_PARTICLE, context)
	PrecacheResource("soundfile", FRENZY_SOUND_EVENTS, context)
end
function elite_056.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = 0.5,
		castAnimation = ACT_DOTA_CAST_ABILITY_3,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			EmitSoundOn(FRENZY_CAST_SOUND, caster)
			modifier_elite_056_frenzy:applys(caster, caster, self, { duration = BUFF_DURATION })
		end,
	}
end
elite_056 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_056)
____exports.elite_056 = elite_056
modifier_elite_056_frenzy = __TS__Class()
modifier_elite_056_frenzy.name = "modifier_elite_056_frenzy"
__TS__ClassExtends(modifier_elite_056_frenzy, MonsterModifier_CS)
function modifier_elite_056_frenzy.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.lastCleaveTime = 0
end
function modifier_elite_056_frenzy.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_elite_056_frenzy.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	if event.attacker ~= parent then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, target) then
		return
	end
	local now = GameRules:GetGameTime()
	if now - self.lastCleaveTime < CLEAVE_COOLDOWN then
		return
	end
	self.lastCleaveTime = now
	local origin = target:GetAbsOrigin()
	local pfx = ParticleManager:CreateParticle(CLEAVE_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:ReleaseParticleIndex(pfx)
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		origin,
		nil,
		CLEAVE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		if IsValidAlive(nil, enemy) then
			parent:MonsterDamage({ victim = enemy, damage_rate = CLEAVE_DAMAGE_RATE, ability = ability })
		end
	end
end
function modifier_elite_056_frenzy.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = BONUS_MOVESPEED_PCT, attack_speed = BONUS_ATTACK_SPEED }
end
function modifier_elite_056_frenzy.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = false, isPurgable = false }
end
function modifier_elite_056_frenzy.GetLocalizationCN(self)
	return {
		name = "结晶狂热",
		description = "移动速度和攻击速度提升，攻击会追加小范围晶刃伤害。",
	}
end
modifier_elite_056_frenzy =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_056_frenzy") }, modifier_elite_056_frenzy)
return ____exports