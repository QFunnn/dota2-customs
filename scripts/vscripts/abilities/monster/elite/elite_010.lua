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
local __TS__ArraySort = ____lualib.__TS__ArraySort
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local FREEZE_DURATION = 10
local HEAL_PER_SECOND_PCT = 1
local SPIKE_RADIUS = 1500
local SPIKE_COUNT = 16
local SPIKE_DAMAGE_RATE = 10
local SPIKE_AOE_RADIUS = 150
local SPIKE_INTERVAL = 1
local GLACIER_SPIKE_PARTICLE = "particles/monster/invoker_glacierwall_ground_spikes.vpcf"
--- 精英技能10 - 冰封自身持续回复，并在周围随机冰刺预警后爆发伤害
____exports.elite_010 = __TS__Class()
local elite_010 = ____exports.elite_010
elite_010.name = "elite_010"
__TS__ClassExtends(elite_010, MonsterAbility_CS)
function elite_010.prototype.Precache(self, context)
	PrecacheResource("particle", GLACIER_SPIKE_PARTICLE, context)
end
function elite_010.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = SPIKE_RADIUS,
		castPoint = 2.5,
		castDuration = 7.5,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		OnStart = function()
			local caster = self:GetCaster()
			caster:EmitSound("Hero_Crystal.FreezingField.Arcana")
			caster:AddNewModifier(caster, self, "modifier_elite_010_freeze", { duration = FREEZE_DURATION })
		end,
	}
end
elite_010 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_010)
____exports.elite_010 = elite_010
local modifier_elite_010_freeze = __TS__Class()
modifier_elite_010_freeze.name = "modifier_elite_010_freeze"
__TS__ClassExtends(modifier_elite_010_freeze, MonsterModifier_CS)
function modifier_elite_010_freeze.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.elapsed = 0
end
function modifier_elite_010_freeze.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(SPIKE_INTERVAL)
	self:SetupSpikeCycles()
end
function modifier_elite_010_freeze.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	self.elapsed = self.elapsed + SPIKE_INTERVAL
	local maxHealth = parent:GetMaxHealth()
	local healAmount = maxHealth * HEAL_PER_SECOND_PCT / 100
	parent:CustomHeal(healAmount, {
		ability = self:GetAbility(),
		source = "spell",
	})
end
function modifier_elite_010_freeze.prototype.CheckState(self)
	return { [MODIFIER_STATE_FROZEN] = true }
end
function modifier_elite_010_freeze.prototype.GetEffectName(self)
	return "particles/events/crownfall/shmup/shmup_colde_embracebuff.vpcf"
end
function modifier_elite_010_freeze.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_elite_010_freeze.prototype.SetupSpikeCycles(self)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local origin = parent:GetAbsOrigin()
	local maxCycles = math.floor((FREEZE_DURATION - 1) / 3)
	do
		local cycle = 0
		while cycle < maxCycles do
			local offset = cycle * 3
			self:ScheduleSpikeCycle(origin, offset)
			cycle = cycle + 1
		end
	end
end
function modifier_elite_010_freeze.prototype.ScheduleSpikeCycle(self, origin, offset)
	local caster = self:GetCaster()
	local parent = self:GetParent()
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, parent) then
		return
	end
	local points = {}
	do
		local i = 0
		while i < SPIKE_COUNT do
			local angle = RandomFloat(0, 360)
			local distance = RandomFloat(0, SPIKE_RADIUS)
			local rad = angle * math.pi / 180
			local pos = Vector(origin.x + math.cos(rad) * distance, origin.y + math.sin(rad) * distance, origin.z)
			local groundPos = GetGroundPosition(pos, parent)
			points[#points + 1] = groundPos
			i = i + 1
		end
	end
	__TS__ArraySort(points, function(____, a, b)
		local da = a:__sub(origin):Length2D()
		local db = b:__sub(origin):Length2D()
		return da - db
	end)
	local cycleEffectPlayed = false
	for ____, point in ipairs(points) do
		local toCenter = point:__sub(origin)
		local d = toCenter:Length2D()
		local maxTilt = 300
		local minTilt = 200
		local ____temp_0
		if d > 0 then
			____temp_0 = d / SPIKE_RADIUS
		else
			____temp_0 = 0
		end
		local t = ____temp_0
		local tilt = math.min(maxTilt, minTilt + (maxTilt - minTilt) * t)
		local ____temp_1
		if d > 0 then
			____temp_1 = toCenter:__mul(1 / d)
		else
			____temp_1 = Vector(0, 1, 0)
		end
		local dirNorm = ____temp_1
		local cp1 = point
		local cp0 = cp1:__sub(dirNorm:__mul(tilt))
		local warnDelay = offset + 2 * t
		local explodeDelay = offset + 2 + 1 * t
		local warningPfx
		self:Timer(warnDelay, function()
			if not IsValidAlive(nil, parent) then
				return
			end
			self:PlayEffect(cp1)
			self:WarningRingEffect(cp1, SPIKE_AOE_RADIUS, 2)
		end)
		self:Timer(explodeDelay, function()
			if not IsValidAlive(nil, parent) then
				return
			end
			if warningPfx ~= nil then
				ParticleManager:DestroyParticle(warningPfx, false)
				ParticleManager:ReleaseParticleIndex(warningPfx)
				warningPfx = nil
			end
			local enemies = FindUnitsInRadius(
				parent:GetTeamNumber(),
				cp1,
				nil,
				SPIKE_AOE_RADIUS,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_ANY_ORDER,
				false
			)
			for ____, enemy in ipairs(enemies) do
				do
					if not IsValidAlive(nil, enemy) then
						goto __continue26
					end
					parent:MonsterDamage({
						victim = enemy,
						damage_rate = SPIKE_DAMAGE_RATE,
						ability = self:GetAbility(),
					})
				end
				::__continue26::
			end
		end)
	end
end
function modifier_elite_010_freeze.prototype.PlayEffect(self, pos)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local pfx_name = "particles/econ/items/ancient_apparition/ancient_apparation_ti8/ancient_ice_vortex_ti8.vpcf"
	local effectId3 = ParticleManager:CreateParticle(pfx_name, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effectId3, 0, pos)
	ParticleManager:SetParticleControl(effectId3, 5, Vector(300, 300, 300))
	Timers:CreateTimer(1, function()
		local pfx_name =
			"particles/units/heroes/hero_ancient_apparition/ancient_apparition_chilling_touch_projectile.vpcf"
		local effectId = ParticleManager:CreateParticle(pfx_name, PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(effectId, 0, pos + Vector(0, 0, 3500))
		ParticleManager:SetParticleControl(effectId, 1, pos)
		ParticleManager:SetParticleControl(effectId, 2, Vector(3500, 0, 0))
		Timers:CreateTimer(1, function()
			ParticleManager:DestroyParticle(effectId, false)
			ParticleManager:ReleaseParticleIndex(effectId)
			local pfx_name = "particles/units/heroes/hero_ancient_apparition/ancient_apparition_ice_blast_explode.vpcf"
			local effectId2 = ParticleManager:CreateParticle(pfx_name, PATTACH_WORLDORIGIN, nil)
			ParticleManager:SetParticleControl(effectId2, 3, pos)
			ParticleManager:ReleaseParticleIndex(effectId2)
			ParticleManager:DestroyParticle(effectId3, false)
			ParticleManager:ReleaseParticleIndex(effectId3)
		end)
	end)
end
modifier_elite_010_freeze =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_010_freeze") }, modifier_elite_010_freeze)
return ____exports