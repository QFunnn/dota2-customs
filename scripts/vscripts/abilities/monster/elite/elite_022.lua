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
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ELITE_022_CAST_POINT = 0.54
local ELITE_022_BOMB_DELAY = 5
local ELITE_022_BOMB_RADIUS = 200
local ELITE_022_CAST_RANGE = 600
local ELITE_022_DAMAGE_RATE = 20
--- 精英技能22 - 蓄力在前方放置炸弹，5秒后爆炸造成范围伤害
____exports.elite_022 = __TS__Class()
local elite_022 = ____exports.elite_022
elite_022.name = "elite_022"
__TS__ClassExtends(elite_022, MonsterAbility_CS)
function elite_022.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = ELITE_022_CAST_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = ELITE_022_CAST_POINT,
		castDuration = 0.5,
		animationPlaybackRate = 0.5,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsServer() or not IsValidAlive(nil, caster) then
				return
			end
			caster:LockTargetForSpeed(caster, ELITE_022_CAST_POINT, 1)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsServer() or not IsValidAlive(nil, caster) then
				return
			end
			caster:EmitSound("Hero_Ancient_Apparition.IceBlastRelease.Cast")
			local origin = caster:GetAbsOrigin()
			local pos_array = GetRandomPointsInCircle(nil, origin, ELITE_022_CAST_RANGE, 8, ELITE_022_BOMB_RADIUS)
			__TS__ArrayForEach(pos_array, function(____, pos)
				CreateModifierThinker(
					caster,
					self,
					"modifier_elite_022_bomb_thinker",
					{ duration = ELITE_022_BOMB_DELAY },
					pos,
					caster:GetTeamNumber(),
					false
				)
			end)
		end,
	}
end
elite_022 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_022)
____exports.elite_022 = elite_022
local modifier_elite_022_bomb_thinker = __TS__Class()
modifier_elite_022_bomb_thinker.name = "modifier_elite_022_bomb_thinker"
__TS__ClassExtends(modifier_elite_022_bomb_thinker, MonsterModifier_CS)
function modifier_elite_022_bomb_thinker.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self._remaining = ELITE_022_BOMB_DELAY - math.random(0, 3)
end
function modifier_elite_022_bomb_thinker.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	local pos = parent:GetAbsOrigin()
	local counterPos = Vector(pos.x, pos.y, pos.z + 125)
	self._pfxMarker = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_ancient_apparition/ancient_apparition_ice_blast_marker.vpcf",
		PATTACH_WORLDORIGIN,
		parent
	)
	ParticleManager:SetParticleControl(self._pfxMarker, 0, counterPos)
	ParticleManager:SetParticleControl(self._pfxMarker, 1, Vector(ELITE_022_BOMB_RADIUS, 1, 1))
	ParticleManager:SetParticleShouldCheckFoW(self._pfxMarker, false)
	self._pfxCounter = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_drow/drow_hypothermia_counter_stack.vpcf",
		PATTACH_WORLDORIGIN,
		parent
	)
	ParticleManager:SetParticleControl(self._pfxCounter, 0, counterPos)
	ParticleManager:SetParticleControl(self._pfxCounter, 1, Vector(0, self._remaining, 0))
	ParticleManager:SetParticleShouldCheckFoW(self._pfxCounter, false)
	local pfx_name = "particles/units/heroes/hero_ancient_apparition/ancient_ice_vortex.vpcf"
	local pfx_vortex = ParticleManager:CreateParticle(pfx_name, PATTACH_WORLDORIGIN, parent)
	ParticleManager:SetParticleControl(pfx_vortex, 0, pos + Vector(0, 0, 75))
	ParticleManager:SetParticleControl(pfx_vortex, 1, Vector(ELITE_022_BOMB_RADIUS, 0, 0))
	ParticleManager:SetParticleControl(pfx_vortex, 2, Vector(ELITE_022_BOMB_RADIUS, 0, 0))
	ParticleManager:SetParticleControl(pfx_vortex, 3, Vector(ELITE_022_BOMB_RADIUS, 0, 0))
	ParticleManager:SetParticleControl(pfx_vortex, 4, Vector(ELITE_022_BOMB_RADIUS, 0, 0))
	ParticleManager:SetParticleControl(pfx_vortex, 5, Vector(ELITE_022_BOMB_RADIUS, 0, 0))
	ParticleManager:SetParticleShouldCheckFoW(pfx_vortex, false)
	self:AddParticle(pfx_vortex, false, false, -1, false, false)
	self:StartIntervalThink(1)
end
function modifier_elite_022_bomb_thinker.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if self._remaining <= 0 then
		return
	end
	self._remaining = self._remaining - 1
	if self._pfxCounter ~= nil then
		local value = math.max(self._remaining, 1)
		ParticleManager:SetParticleControl(self._pfxCounter, 1, Vector(0, value, 0))
	end
	if self._remaining <= 0 then
		self:Destroy()
	end
end
function modifier_elite_022_bomb_thinker.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if self._pfxMarker ~= nil then
		ParticleManager:DestroyParticle(self._pfxMarker, false)
		ParticleManager:ReleaseParticleIndex(self._pfxMarker)
		self._pfxMarker = nil
	end
	if self._pfxCounter ~= nil then
		ParticleManager:DestroyParticle(self._pfxCounter, false)
		ParticleManager:ReleaseParticleIndex(self._pfxCounter)
		self._pfxCounter = nil
	end
	if not IsValidAlive(nil, caster) or not IsValid(nil, parent) or parent:IsNull() or not ability then
		if IsValid(nil, parent) and not parent:IsNull() then
			parent:RemoveSelf()
		end
		return
	end
	local pos = parent:GetAbsOrigin()
	local explodePfx = ParticleManager:CreateParticle(
		"particles/econ/items/ancient_apparition/aa_blast_ti_5/ancient_apparition_ice_blast_explode_ti5.vpcf",
		PATTACH_WORLDORIGIN,
		parent
	)
	ParticleManager:SetParticleControl(explodePfx, 0, pos)
	ParticleManager:SetParticleControl(explodePfx, 3, pos)
	ParticleManager:SetParticleShouldCheckFoW(explodePfx, false)
	ParticleManager:ReleaseParticleIndex(explodePfx)
	local enemies = self:FindHeroesInRadius(ELITE_022_BOMB_RADIUS)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue22
			end
			AddDeBuffStatus(nil, enemy, caster, ability, DebuffStatusType.ICE_SLOW, { stack = 5, duration = 1 })
			caster:MonsterDamage({ victim = enemy, damage_rate = ELITE_022_DAMAGE_RATE, ability = ability })
		end
		::__continue22::
	end
	ScreenShake(pos, 5, 5, 0.5, 1000, 0, true)
	if IsValid(nil, parent) and not parent:IsNull() then
		parent:RemoveSelf()
	end
end
modifier_elite_022_bomb_thinker =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_022_bomb_thinker") }, modifier_elite_022_bomb_thinker)
return ____exports