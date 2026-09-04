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
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local modifier_boss_abyssal_phase_intro
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ____boss_simple_phase_summon = require("abilities.monster.boss.boss_simple_phase_summon")
local boss_simple_phase_summon = ____boss_simple_phase_summon.boss_simple_phase_summon
local SIMPLE_PHASE_SUMMON_COUNT = ____boss_simple_phase_summon.SIMPLE_PHASE_SUMMON_COUNT
local SIMPLE_PHASE_SUMMON_RADIUS = ____boss_simple_phase_summon.SIMPLE_PHASE_SUMMON_RADIUS
local UNDERLORD_PHASE_DARK_RIFT_DURATION = 1.5
local UNDERLORD_PHASE_DARK_RIFT_RADIUS = 600
local UNDERLORD_PHASE_DARK_RIFT_EFFECT =
	"particles/units/heroes/heroes_underlord/abbysal_underlord_darkrift_ambient.vpcf"
local UNDERLORD_PHASE_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_abyssal_underlord.vsndevts"
local UNDERLORD_PHASE_DARK_RIFT_CAST_SOUND = "Hero_AbyssalUnderlord.DarkRift.Cast"
local UNDERLORD_PHASE_DARK_RIFT_COMPLETE_SOUND = "Hero_AbyssalUnderlord.DarkRift.Complete"
local UNDERLORD_PHASE_DARK_RIFT_AFTERSHOCK_SOUND = "Hero_AbyssalUnderlord.DarkRift.Aftershock"
____exports.boss_abyssal_phase_summon = __TS__Class()
local boss_abyssal_phase_summon = ____exports.boss_abyssal_phase_summon
boss_abyssal_phase_summon.name = "boss_abyssal_phase_summon"
__TS__ClassExtends(boss_abyssal_phase_summon, boss_simple_phase_summon)
function boss_abyssal_phase_summon.prototype.Precache(self, context)
	boss_simple_phase_summon.prototype.Precache(self, context)
	PrecacheResource("particle", UNDERLORD_PHASE_DARK_RIFT_EFFECT, context)
	PrecacheResource("soundfile", UNDERLORD_PHASE_SOUND_EVENTS, context)
end
function boss_abyssal_phase_summon.prototype.GetBossPhaseTransitionConfig(self)
	local cfg = boss_simple_phase_summon.prototype.GetBossPhaseTransitionConfig(self)
	return __TS__ObjectAssign({}, cfg, {
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self:StartUnderlordPhaseTransition(caster, self:GetSimplePhaseSummonConfig())
		end,
	})
end
function boss_abyssal_phase_summon.prototype.GetSimplePhaseSummonConfig(self)
	return {
		summonUnitName = "monster_10005",
		note = "大屁股：M005 普通怪无技能综合最高之一，小法师",
	}
end
function boss_abyssal_phase_summon.prototype.StartUnderlordPhaseTransition(self, caster, config)
	local center = self:ResolveCenterPoint(caster)
	self:PlayUnderlordDarkRiftEffect(center, caster)
	self:SummonUnderlordPhaseMonsters(caster, config, center)
end
function boss_abyssal_phase_summon.prototype.SummonUnderlordPhaseMonsters(self, caster, config, center)
	local roomId = caster:GetRoomId()
	do
		local i = 0
		while i < SIMPLE_PHASE_SUMMON_COUNT do
			local currentIndex = i
			local angle = math.pi * 2 * currentIndex / SIMPLE_PHASE_SUMMON_COUNT
			local offset =
				Vector(math.cos(angle) * SIMPLE_PHASE_SUMMON_RADIUS, math.sin(angle) * SIMPLE_PHASE_SUMMON_RADIUS, 0)
			local summonPos = GetGroundPosition(center:__add(offset), caster)
			MyGameUnit:CreateSummonedUnitAsync({
				unitName = config.summonUnitName,
				summonTag = "phase_summon_" .. caster:GetUnitName(),
				maxSummons = SIMPLE_PHASE_SUMMON_COUNT,
				position = summonPos,
				roomId = roomId,
				team = caster:GetTeamNumber(),
				owner = caster,
				summoner = caster,
				destroyWithSummoner = true,
				findClearSpace = true,
				onSpawn = function(____, unit)
					if not unit or not IsValidAlive(nil, unit) then
						return
					end
					if not IsValidAlive(nil, caster) then
						MyGameUnit:DestroyUnit(unit)
						return
					end
					unit:SetForwardVectorWithoutInterrupt(GetDirection(nil, summonPos, caster:GetAbsOrigin()))
					modifier_boss_abyssal_phase_intro:applys(
						unit,
						caster,
						self,
						{ duration = UNDERLORD_PHASE_DARK_RIFT_DURATION }
					)
				end,
			})
			i = i + 1
		end
	end
end
function boss_abyssal_phase_summon.prototype.PlayUnderlordDarkRiftEffect(self, center, caster)
	local effect = ParticleManager:CreateParticle(UNDERLORD_PHASE_DARK_RIFT_EFFECT, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(effect, 0, center)
	ParticleManager:SetParticleControl(effect, 1, Vector(UNDERLORD_PHASE_DARK_RIFT_RADIUS, 0, 0))
	ParticleManager:SetParticleControl(effect, 2, center)
	ParticleManager:SetParticleControl(effect, 3, center)
	ParticleManager:SetParticleControl(effect, 4, center)
	ParticleManager:SetParticleControl(effect, 5, center)
	EmitSoundOnLocationWithCaster(center, UNDERLORD_PHASE_DARK_RIFT_CAST_SOUND, caster)
	self:Timer(UNDERLORD_PHASE_DARK_RIFT_DURATION, function()
		ParticleManager:DestroyParticle(effect, false)
		ParticleManager:ReleaseParticleIndex(effect)
		EmitSoundOnLocationWithCaster(center, UNDERLORD_PHASE_DARK_RIFT_COMPLETE_SOUND, caster)
		EmitSoundOnLocationWithCaster(center, UNDERLORD_PHASE_DARK_RIFT_AFTERSHOCK_SOUND, caster)
	end)
end
boss_abyssal_phase_summon = __TS__DecorateLegacy({ registerAbility(nil) }, boss_abyssal_phase_summon)
____exports.boss_abyssal_phase_summon = boss_abyssal_phase_summon
modifier_boss_abyssal_phase_intro = __TS__Class()
modifier_boss_abyssal_phase_intro.name = "modifier_boss_abyssal_phase_intro"
__TS__ClassExtends(modifier_boss_abyssal_phase_intro, MonsterModifier_CS)
function modifier_boss_abyssal_phase_intro.prototype.IsHidden(self)
	return true
end
function modifier_boss_abyssal_phase_intro.prototype.IsPurgable(self)
	return false
end
function modifier_boss_abyssal_phase_intro.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValidAlive(nil, parent) then
		parent:AddNoDraw()
	end
end
function modifier_boss_abyssal_phase_intro.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValidAlive(nil, parent) then
		parent:RemoveNoDraw()
		parent:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 0.8)
		EmitSoundOn(UNDERLORD_PHASE_DARK_RIFT_COMPLETE_SOUND, parent)
	end
end
function modifier_boss_abyssal_phase_intro.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
modifier_boss_abyssal_phase_intro = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_boss_abyssal_phase_intro") },
	modifier_boss_abyssal_phase_intro
)
return ____exports