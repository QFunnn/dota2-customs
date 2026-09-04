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
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local px2 = "particles/void_spirit_astral_step_impact_blue.vpcf"
local phantome_ab2 = __TS__Class()
phantome_ab2.name = "phantome_ab2"
__TS__ClassExtends(phantome_ab2, MonsterAbility_CS)
function phantome_ab2.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = 1,
		castDuration = 2,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		isNotMove = true,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		animationPlaybackRate = 0.35,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			caster:Mover(caster:GetOrigin():__add(Vector(0, 0, 100)), 1.3)
		end,
		OnStart = function()
			return self:Start()
		end,
	}
end
function phantome_ab2.prototype.armParticleLifetime(self, pid, lifeSec)
	if not IsServer() then
		return
	end
	local done = false
	Timers:CreateTimer(lifeSec, function()
		if done then
			return nil
		end
		done = true
		ParticleManager:DestroyParticle(pid, false)
		ParticleManager:ReleaseParticleIndex(pid)
		return nil
	end)
end
function phantome_ab2.prototype.Start(self)
	local caster = self:GetCaster()
	caster:SetAnimation("attack_swing")
	caster:EmitSound("Hero_Broodmother.SilkenBola.Target")
	local pfx_name = "particles/aghanim_beam_channel_ground_rings_red2.vpcf"
	local pfx = ParticleManager:CreateParticle(pfx_name, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControl(pfx, 0, caster:GetAbsOrigin())
	self:armParticleLifetime(pfx, 0.22)
	Timers:CreateTimer(0.2, function()
		self:Pull()
		caster:Mover(caster:GetOrigin():__sub(Vector(0, 0, 100)), 0.1)
		local pfx_name = "particles/boss/juggernaut_blade_fury_abyssal_start_p_2x.vpcf"
		ScreenShake(caster:GetAbsOrigin(), 20, 20, 0.3, 3000, 0, true)
		local pfx2 = ParticleManager:CreateParticle(pfx_name, PATTACH_ABSORIGIN_FOLLOW, caster)
		ParticleManager:SetParticleControl(pfx2, 0, caster:GetAbsOrigin())
		self:armParticleLifetime(pfx2, 0.28)
		caster:SetAnimation("attack_crit")
		caster:EmitSound("Hero_Broodmother.SilkenBola.Target")
		self:PlayDamage(caster)
		Timers:CreateTimer(0.25, function()
			self:Pull()
			GridNav:DestroyTreesAroundPoint(caster:GetAbsOrigin(), 600, false)
			local pfx_name = "particles/juggernaut_blade_fury_abyssal_start_p_3x.vpcf"
			ScreenShake(caster:GetAbsOrigin(), 20, 20, 0.3, 3000, 0, true)
			local pfx3 = ParticleManager:CreateParticle(pfx_name, PATTACH_ABSORIGIN_FOLLOW, caster)
			ParticleManager:SetParticleControl(pfx3, 0, caster:GetAbsOrigin())
			self:armParticleLifetime(pfx3, 0.28)
			caster:SetAnimation("attack_spin")
			self:PlayDamage(caster)
			caster:EmitSound("Hero_Broodmother.SilkenBola.Target")
			Timers:CreateTimer(0.25, function()
				self:Pull()
				local pfx_name = "particles/juggernaut_blade_fury_abyssal_start_p_2x.vpcf"
				ScreenShake(caster:GetAbsOrigin(), 20, 20, 0.3, 3000, 0, true)
				local pfx4 = ParticleManager:CreateParticle(pfx_name, PATTACH_ABSORIGIN_FOLLOW, caster)
				self:PlayDamage(caster)
				caster:EmitSound("Hero_Broodmother.SilkenBola.Target")
				ParticleManager:SetParticleControl(pfx4, 0, caster:GetAbsOrigin())
				self:armParticleLifetime(pfx4, 0.28)
				Timers:CreateTimer(0.2, function()
					self:PlayDamage(caster)
				end)
			end)
		end)
	end)
end
function phantome_ab2.prototype.PlayDamage(self, caster)
	local pos = caster:GetAbsOrigin()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		pos,
		nil,
		620,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NOT_MAGIC_IMMUNE_ALLIES,
		0,
		false
	)
	__TS__ArrayForEach(enemies, function(____, enemy)
		caster:MonsterDamage({ victim = enemy, damage_rate = 15, ability = self, effectName = px2 })
	end)
end
function phantome_ab2.prototype.Pull(self)
	local caster = self:GetCaster()
	local pos = caster:GetAbsOrigin()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		pos,
		nil,
		760,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NOT_MAGIC_IMMUNE_ALLIES,
		0,
		false
	)
	__TS__ArrayForEach(enemies, function(____, enemy)
		local distance = GetDistance(nil, caster:GetAbsOrigin(), enemy:GetAbsOrigin())
		if distance > 300 then
			local fow = GetDirection(nil, enemy:GetAbsOrigin(), caster:GetAbsOrigin())
			enemy:Mover(enemy:GetAbsOrigin():__add(fow:__mul(-distance * 0.18)), 0.15)
		end
	end)
end
phantome_ab2 = __TS__DecorateLegacy({ registerAbility(nil) }, phantome_ab2)
return ____exports