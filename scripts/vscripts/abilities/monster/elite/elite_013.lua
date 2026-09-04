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
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local THINKER_DURATION = 8
local EXPLOSION_RADIUS = 300
local WARNING_RADIUS = 350
local WARNING_DELAY = 1
local DAMAGE_RATE = 20
local SLOW_MOVESPEED_PCT = 60
local SLOW_DURATION = 2
--- 精英技能13 - 雪人炸弹：雪球投射落地生成雪人，延迟爆炸
____exports.elite_013 = __TS__Class()
local elite_013 = ____exports.elite_013
elite_013.name = "elite_013"
__TS__ClassExtends(elite_013, MonsterAbility_CS)
function elite_013.prototype.Precache(self, context)
	PrecacheResource(
		"particle",
		"particles/econ/items/drow/drow_ti9_immortal/drow_ti9_frost_arrow_debuff.vpcf",
		context
	)
	PrecacheResource("particle", "particles/status_fx/status_effect_drow_frost_arrow.vpcf", context)
end
function elite_013.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = 2000,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = 0.5,
		castDuration = 0.5,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		animationPlaybackRate = 0.5,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(3500)
			caster:LockTargetForSpeed(target, 0.5, 8)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsServer() or not IsValidAlive(nil, caster) then
				return
			end
			caster:EmitSound("Hero_Tusk.Snowball.Cast")
			local origin = caster:GetAbsOrigin():__add(Vector(0, 0, 96))
			local targetUnit = caster:GetMinDistanceUnit(2000)
			local targetPos
			if targetUnit and IsValidAlive(nil, targetUnit) then
				targetPos = targetUnit:GetAbsOrigin()
			else
				local forward = caster:GetForwardVector()
				targetPos = caster:GetAbsOrigin() + forward:__mul(900)
			end
			CreateProjectile(nil, {
				ability = self,
				projectile_type = "collideground",
				caster = caster,
				effect_name = "particles/econ/events/snowball/snowball_projectile.vpcf",
				projectile_speed = 900,
				start_point = origin,
				target = targetPos,
				on_hit = function(____, _target, location, _extra)
					if not IsServer() or not IsValidAlive(nil, caster) then
						return
					end
					local groundZ = GetGroundHeight(location, caster) or location.z
					local pos = Vector(location.x, location.y, groundZ)
					CreateModifierThinker(
						caster,
						self,
						"modifier_elite_013_snowman_thinker",
						{ duration = THINKER_DURATION },
						pos,
						caster:GetTeamNumber(),
						false
					)
					return true
				end,
			})
		end,
	}
end
elite_013 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_013)
____exports.elite_013 = elite_013
local modifier_elite_013_snowman_thinker = __TS__Class()
modifier_elite_013_snowman_thinker.name = "modifier_elite_013_snowman_thinker"
__TS__ClassExtends(modifier_elite_013_snowman_thinker, MonsterModifier_CS)
function modifier_elite_013_snowman_thinker.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.inWarning = false
	self.exploded = false
	self.thinkerStartTime = 0
	self.firstCheckTime = 0
	self.explodeTime = 0
end
function modifier_elite_013_snowman_thinker.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	self.thinkerStartTime = GameRules:GetGameTime()
	self.firstCheckTime = 0
	self.explodeTime = 0
	parent:SetOriginalModel("models/props_frostivus/frostivus_snowman.vmdl")
	parent:SetModel("models/props_frostivus/frostivus_snowman.vmdl")
	self:StartIntervalThink(0.15)
end
function modifier_elite_013_snowman_thinker.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if self.pfxSnowman ~= nil then
		ParticleManager:DestroyParticle(self.pfxSnowman, false)
		ParticleManager:ReleaseParticleIndex(self.pfxSnowman)
		self.pfxSnowman = nil
	end
	if not IsValidAlive(nil, caster) then
		if IsValid(nil, parent) and not parent:IsNull() then
			parent:RemoveSelf()
		end
		return
	end
	if not self.exploded and IsValidAlive(nil, caster) then
		self:DoExplosion()
	end
end
function modifier_elite_013_snowman_thinker.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if self.exploded then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	local now = GameRules:GetGameTime()
	if
		not self.inWarning
		and THINKER_DURATION > WARNING_DELAY
		and now - self.thinkerStartTime >= THINKER_DURATION - WARNING_DELAY
	then
		self:StartWarning()
	end
	if self.inWarning then
		if self.firstCheckTime > 0 and now >= self.firstCheckTime and self.explodeTime == 0 then
			local enemies = self:FindHeroesInRadius(EXPLOSION_RADIUS)
			if #enemies > 0 then
				self.explodeTime = now + WARNING_DELAY
				local parent2 = self:GetParent()
				if IsValidAlive(nil, parent2) then
					local castPfx = ParticleManager:CreateParticle(
						"particles/units/heroes/hero_crystalmaiden/maiden_crystal_nova_flash_c.vpcf",
						PATTACH_ABSORIGIN_FOLLOW,
						parent2
					)
					ParticleManager:SetParticleControlEnt(
						castPfx,
						0,
						parent2,
						PATTACH_POINT_FOLLOW,
						"attach_hitloc",
						parent2:GetAbsOrigin(),
						false
					)
					ParticleManager:ReleaseParticleIndex(castPfx)
				end
			else
				if self.pfxWarning ~= nil then
					ParticleManager:DestroyParticle(self.pfxWarning, false)
					ParticleManager:ReleaseParticleIndex(self.pfxWarning)
					self.pfxWarning = nil
				end
				self.inWarning = false
				self.firstCheckTime = 0
				self.explodeTime = 0
			end
		end
		if self.explodeTime > 0 and now >= self.explodeTime then
			self:DoExplosion()
			return
		end
		return
	end
	local enemies = self:FindHeroesInRadius(WARNING_RADIUS)
	if #enemies > 0 then
		self:StartWarning()
	end
end
function modifier_elite_013_snowman_thinker.prototype.StartWarning(self)
	if not IsServer() or self.inWarning or self.exploded then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	self.inWarning = true
	local pos = parent:GetAbsOrigin()
	local now = GameRules:GetGameTime()
	self.pfxWarning = ParticleManager:CreateParticle(
		"particles/econ/events/frostivus/snowman_call_aoe.vpcf",
		PATTACH_WORLDORIGIN,
		parent
	)
	ParticleManager:SetParticleControl(self.pfxWarning, 0, pos)
	ParticleManager:SetParticleControl(self.pfxWarning, 2, Vector(EXPLOSION_RADIUS, 0, 0))
	ParticleManager:SetParticleShouldCheckFoW(self.pfxWarning, false)
	self.firstCheckTime = now + WARNING_DELAY
	self.explodeTime = 0
end
function modifier_elite_013_snowman_thinker.prototype.DoExplosion(self)
	if not IsServer() or self.exploded then
		return
	end
	self.exploded = true
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, parent) or not ability then
		if IsValid(nil, parent) and not parent:IsNull() then
			parent:RemoveSelf()
		end
		return
	end
	local pos = parent:GetAbsOrigin()
	if self.pfxWarning ~= nil then
		ParticleManager:DestroyParticle(self.pfxWarning, false)
		ParticleManager:ReleaseParticleIndex(self.pfxWarning)
		self.pfxWarning = nil
	end
	local pfxSnow =
		ParticleManager:CreateParticle("particles/hw_fx/snowball_summon_aoe_snow.vpcf", PATTACH_WORLDORIGIN, parent)
	ParticleManager:SetParticleControl(pfxSnow, 0, pos)
	ParticleManager:SetParticleShouldCheckFoW(pfxSnow, false)
	ParticleManager:ReleaseParticleIndex(pfxSnow)
	ScreenShake(caster:GetAbsOrigin(), 20, 20, 0.3, 2000, 0, true)
	local pfxExplode = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_crystalmaiden_persona/cm_persona_nova.vpcf",
		PATTACH_WORLDORIGIN,
		parent
	)
	ParticleManager:SetParticleControl(pfxExplode, 0, pos)
	ParticleManager:SetParticleControl(pfxExplode, 1, Vector(EXPLOSION_RADIUS, 2, 1000))
	ParticleManager:SetParticleShouldCheckFoW(pfxExplode, false)
	ParticleManager:ReleaseParticleIndex(pfxExplode)
	local enemies = self:FindHeroesInRadius(EXPLOSION_RADIUS)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue40
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = ability })
			AddDeBuffStatus(
				nil,
				enemy,
				caster,
				ability,
				DebuffStatusType.ICE_SLOW,
				{
					stack = 5,
					duration = SLOW_DURATION,
					effect_name = "particles/econ/items/drow/drow_ti9_immortal/drow_ti9_frost_arrow_debuff.vpcf",
					status_effect_name = "particles/status_fx/status_effect_drow_frost_arrow.vpcf",
				}
			)
		end
		::__continue40::
	end
	if IsValid(nil, parent) and not parent:IsNull() then
		parent:RemoveSelf()
	end
	self:Destroy()
end
modifier_elite_013_snowman_thinker = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_013_snowman_thinker") },
	modifier_elite_013_snowman_thinker
)
return ____exports