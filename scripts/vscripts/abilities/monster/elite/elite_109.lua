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
local modifier_elite_109_thunder_strike_slow
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_RANGE = 800
local CAST_POINT = 0.8
local COOLDOWN = 18
local MANA_COST = 125
local STRIKE_RADIUS = 260
local STRIKE_COUNT = 4
local STRIKE_INTERVAL = 2
local STRIKE_DAMAGE = 30
local SLOW_DURATION = 0.3
local SLOW_AMOUNT = 100
local THUNDER_DURATION = STRIKE_INTERVAL * (STRIKE_COUNT - 1)
local VISION_RADIUS = 450
local VISION_LINGER_DURATION = 3.34
local RANDOM_POINT_TRY_COUNT = 16
local THUNDER_BUFF_PARTICLE = "particles/units/heroes/hero_disruptor/disruptor_thunder_strike_buff.vpcf"
local THUNDER_BOLT_PARTICLE = "particles/units/heroes/hero_disruptor/disruptor_thunder_strike_bolt.vpcf"
local THUNDER_AOE_PARTICLE = "particles/units/heroes/hero_disruptor/disruptor_thunder_strike_aoe.vpcf"
local THUNDER_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_disruptor.vsndevts"
local THUNDER_TARGET_SOUND = "Hero_Disruptor.ThunderStrike.Target"
____exports.elite_109 = __TS__Class()
local elite_109 = ____exports.elite_109
elite_109.name = "elite_109"
__TS__ClassExtends(elite_109, MonsterAbility_CS)
function elite_109.prototype.Precache(self, context)
	PrecacheResource("particle", THUNDER_BUFF_PARTICLE, context)
	PrecacheResource("particle", THUNDER_BOLT_PARTICLE, context)
	PrecacheResource("particle", THUNDER_AOE_PARTICLE, context)
	PrecacheResource("soundfile", THUNDER_SOUND_EVENTS, context)
end
function elite_109.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = 0,
		cooldown = COOLDOWN,
		manaCost = MANA_COST,
		castAnimation = ACT_DOTA_THUNDER_STRIKE,
		canCast = function()
			local caster = self:GetCaster()
			local ____temp_0
			if IsValidAlive(nil, caster) and IsValidAlive(nil, caster:GetMinDistanceUnit(CAST_RANGE)) then
				____temp_0 = UF_SUCCESS
			else
				____temp_0 = UF_FAIL_CUSTOM
			end
			return ____temp_0
		end,
		castError = function()
			return "附近没有可释放风雷之击的目标"
		end,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self.targetPoint = self:FindRandomCastPoint(caster)
			self:FacePoint(caster, self.targetPoint)
			self:WarningRingEffect(self.targetPoint, STRIKE_RADIUS, CAST_POINT)
		end,
		OnInterrupt = function()
			self.targetPoint = nil
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsServer() or not IsValidAlive(nil, caster) then
				return
			end
			local point = self.targetPoint or self:FindRandomCastPoint(caster)
			self:FacePoint(caster, point)
			EmitSoundOnLocationWithCaster(point, THUNDER_TARGET_SOUND, caster)
			CreateModifierThinker(
				caster,
				self,
				"modifier_elite_109_thunder_strike_area",
				{ duration = THUNDER_DURATION + VISION_LINGER_DURATION },
				point,
				caster:GetTeamNumber(),
				false
			)
			self.targetPoint = nil
		end,
		OnFinish = function()
			self.targetPoint = nil
		end,
	}
end
function elite_109.prototype.GetAOERadius(self)
	return STRIKE_RADIUS
end
function elite_109.prototype.StrikeAt(self, point, anchor)
	local caster = self:GetCaster()
	if not IsServer() or not IsValidAlive(nil, caster) then
		return
	end
	local strikePoint = GetGroundPosition(point, caster)
	self:PlayStrikeEffects(strikePoint, caster, anchor)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		strikePoint,
		nil,
		STRIKE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue15
			end
			modifier_elite_109_thunder_strike_slow:applys(enemy, caster, self, { duration = SLOW_DURATION })
			Damage:ApplyDamage({
				victim = enemy,
				attacker = caster,
				damage = STRIKE_DAMAGE,
				damage_type = 2,
				ability = self,
			})
		end
		::__continue15::
	end
end
function elite_109.prototype.FindRandomCastPoint(self, caster)
	local origin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	do
		local i = 0
		while i < RANDOM_POINT_TRY_COUNT do
			local candidate = origin:__add(RandomVector(RandomFloat(0, CAST_RANGE)))
			local point = GetGroundPosition(candidate, caster)
			if self:IsValidRandomCastPoint(origin, point) then
				return point
			end
			i = i + 1
		end
	end
	local target = self:GetMinDistanceUnit(CAST_RANGE)
	if IsValidAlive(nil, target) then
		return GetGroundPosition(target:GetAbsOrigin(), caster)
	end
	return origin
end
function elite_109.prototype.IsValidRandomCastPoint(self, origin, point)
	if GetDistance(nil, origin, point) > CAST_RANGE then
		return false
	end
	if not IsGridNavDisplacementWalkable(nil, point) then
		return false
	end
	if not GridNav:CanFindPath(origin, point) then
		return false
	end
	return GridNav:FindPathLength(origin, point) ~= -1
end
function elite_109.prototype.FacePoint(self, caster, point)
	local direction = GetDirection(nil, point, caster:GetAbsOrigin())
	if direction:Length2D() > 0.01 then
		caster:SetForwardVector(direction)
	end
end
function elite_109.prototype.PlayStrikeEffects(self, point, caster, anchor)
	local bolt = ParticleManager:CreateParticle(THUNDER_BOLT_PARTICLE, PATTACH_WORLDORIGIN, anchor)
	if anchor and IsValid(nil, anchor) and not anchor:IsNull() then
		ParticleManager:SetParticleControlEnt(bolt, 0, anchor, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", point, true)
		ParticleManager:SetParticleControlEnt(bolt, 1, anchor, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", point, true)
	else
		ParticleManager:SetParticleControl(bolt, 0, point)
		ParticleManager:SetParticleControl(bolt, 1, point)
	end
	ParticleManager:ReleaseParticleIndex(bolt)
	local aoe = ParticleManager:CreateParticle(THUNDER_AOE_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(aoe, 0, point)
	ParticleManager:SetParticleControl(aoe, 1, Vector(STRIKE_RADIUS, 0, 0))
	ParticleManager:ReleaseParticleIndex(aoe)
	EmitSoundOnLocationWithCaster(point, THUNDER_TARGET_SOUND, caster)
end
elite_109 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_109)
____exports.elite_109 = elite_109
local modifier_elite_109_thunder_strike_area = __TS__Class()
modifier_elite_109_thunder_strike_area.name = "modifier_elite_109_thunder_strike_area"
__TS__ClassExtends(modifier_elite_109_thunder_strike_area, MonsterModifier_CS)
function modifier_elite_109_thunder_strike_area.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.strikeCount = 0
	self.strikePoint = Vector(0, 0, 0)
end
function modifier_elite_109_thunder_strike_area.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	self.strikePoint = GetGroundPosition(parent:GetAbsOrigin(), caster)
	parent:SetAbsOrigin(self.strikePoint)
	AddFOWViewer(
		caster:GetTeamNumber(),
		self.strikePoint,
		VISION_RADIUS,
		THUNDER_DURATION + VISION_LINGER_DURATION,
		false
	)
	self.particleId = ParticleManager:CreateParticle(THUNDER_BUFF_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		self.particleId,
		0,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		self.strikePoint,
		true
	)
	self:StartIntervalThink(STRIKE_INTERVAL)
	self:Strike()
end
function modifier_elite_109_thunder_strike_area.prototype.OnIntervalThink(self)
	self:Strike()
end
function modifier_elite_109_thunder_strike_area.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	if self.particleId ~= nil then
		ParticleManager:DestroyParticle(self.particleId, false)
		ParticleManager:ReleaseParticleIndex(self.particleId)
		self.particleId = nil
	end
	local parent = self:GetParent()
	if IsValid(nil, parent) and not parent:IsNull() then
		parent:RemoveSelf()
	end
end
function modifier_elite_109_thunder_strike_area.prototype.IsHidden(self)
	return true
end
function modifier_elite_109_thunder_strike_area.prototype.IsPurgable(self)
	return false
end
function modifier_elite_109_thunder_strike_area.prototype.Strike(self)
	local ability = self:GetAbility()
	if not ability or ability:IsNull() then
		self:Destroy()
		return
	end
	ability:StrikeAt(self.strikePoint, self:GetParent())
	self.strikeCount = self.strikeCount + 1
	if self.strikeCount >= STRIKE_COUNT then
		self:Destroy()
	end
end
modifier_elite_109_thunder_strike_area = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_109_thunder_strike_area") },
	modifier_elite_109_thunder_strike_area
)
modifier_elite_109_thunder_strike_slow = __TS__Class()
modifier_elite_109_thunder_strike_slow.name = "modifier_elite_109_thunder_strike_slow"
__TS__ClassExtends(modifier_elite_109_thunder_strike_slow, MonsterModifier_CS)
function modifier_elite_109_thunder_strike_slow.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = -SLOW_AMOUNT, attack_speed = -SLOW_AMOUNT }
end
function modifier_elite_109_thunder_strike_slow.prototype.IsHidden(self)
	return false
end
function modifier_elite_109_thunder_strike_slow.prototype.IsDebuff(self)
	return true
end
function modifier_elite_109_thunder_strike_slow.prototype.IsPurgable(self)
	return true
end
function modifier_elite_109_thunder_strike_slow.prototype.GetTexture(self)
	return "disruptor_thunder_strike"
end
function modifier_elite_109_thunder_strike_slow.GetLocalizationCN(self)
	return { name = "风雷之击", description = "移动速度和攻击速度降低。" }
end
modifier_elite_109_thunder_strike_slow = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_109_thunder_strike_slow") },
	modifier_elite_109_thunder_strike_slow
)
return ____exports