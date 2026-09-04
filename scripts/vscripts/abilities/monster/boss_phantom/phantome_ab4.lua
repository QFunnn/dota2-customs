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
local BaseModifier = ____dota_ts_adapter.BaseModifier
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local px2 = "particles/void_spirit_astral_step_impact_blue.vpcf"
local phantome_ab4 = __TS__Class()
phantome_ab4.name = "phantome_ab4"
__TS__ClassExtends(phantome_ab4, MonsterAbility_CS)
function phantome_ab4.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = 0.9,
		castDuration = 2,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		isNotMove = true,
		animationPlaybackRate = 1.2,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(3500)
			local ____target_0
			if target then
				____target_0 = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
			else
				____target_0 = caster:GetForwardVector()
			end
			local forward = ____target_0
			if target then
				local ____ = target and self:GetCaster():LockTargetForSpeed(target, 0.7, 15)
				caster:LockTargetForSpeed(target, 0.6, 4)
			end
			caster:Mover(caster:GetAbsOrigin():__add(forward:__mul(-100)), 0.6)
			caster:SetAnimation("c4_fan_of_knives_effigy")
		end,
		OnStart = function()
			return self:Start()
		end,
	}
end
function phantome_ab4.prototype.armParticleLifetime(self, pid, lifeSec)
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
function phantome_ab4.prototype.Start(self)
	local caster = self:GetCaster()
	caster:SetAnimation("attack_swing")
	caster:EmitSound("Hero_Broodmother.SilkenBola.Target")
	caster:AddNewModifier(caster, self, "phantome_ab4_pre", { duration = 0.5 })
	Timers:CreateTimer(0.2, function()
		local pfx_name = "particles/juggernaut_blade_fury_abyssal_start_p_2x.vpcf"
		ScreenShake(caster:GetAbsOrigin(), 20, 20, 0.3, 3000, 0, true)
		local pfx = ParticleManager:CreateParticle(pfx_name, PATTACH_ABSORIGIN_FOLLOW, caster)
		ParticleManager:SetParticleControl(pfx, 0, caster:GetAbsOrigin())
		self:armParticleLifetime(pfx, 0.35)
		caster:SetAnimation("attack_crit")
		caster:EmitSound("Hero_Broodmother.SilkenBola.Target")
		caster:EmitSound("Greevil.BladeFuryStart")
		self:PlayDamage(caster)
		caster:Mover(caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(400)), 0.3)
		Timers:CreateTimer(0.25, function()
			local pfx_name = "particles/juggernaut_blade_fury_abyssal_start_p_2x.vpcf"
			ScreenShake(caster:GetAbsOrigin(), 20, 20, 0.3, 3000, 0, true)
			local pfx2 = ParticleManager:CreateParticle(pfx_name, PATTACH_ABSORIGIN_FOLLOW, caster)
			ParticleManager:SetParticleControl(pfx2, 0, caster:GetAbsOrigin())
			self:armParticleLifetime(pfx2, 0.35)
			caster:SetAnimation("attack_spin")
			caster:EmitSound("Hero_Broodmother.SilkenBola.Target")
			self:PlayDamage(caster)
			local target = self:GetCaster():GetMinDistanceUnit(3500)
			if target then
				caster:LockTargetForSpeed(target, 0.25, 4)
			end
			Timers:CreateTimer(0.25, function()
				local pfx_name = "particles/juggernaut_blade_fury_abyssal_start_p_3x.vpcf"
				ScreenShake(caster:GetAbsOrigin(), 20, 20, 0.3, 3000, 0, true)
				caster:EmitSound("Hero_Broodmother.SilkenBola.Target")
				local pfx3 = ParticleManager:CreateParticle(pfx_name, PATTACH_ABSORIGIN_FOLLOW, caster)
				self:PlayDamage(caster)
				caster:Mover(caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(700)), 0.6)
				ParticleManager:SetParticleControl(pfx3, 0, caster:GetAbsOrigin())
				self:armParticleLifetime(pfx3, 0.35)
				Timers:CreateTimer(0.35, function()
					ScreenShake(caster:GetAbsOrigin(), 20, 20, 0.3, 3000, 0, true)
					caster:EmitSound("Hero_Broodmother.SilkenBola.Target")
					caster:StopSound("Greevil.BladeFuryStart")
					local pfx_name = "particles/juggernaut_blade_fury_abyssal_start_p_2x.vpcf"
					local pfx4 = ParticleManager:CreateParticle(pfx_name, PATTACH_ABSORIGIN_FOLLOW, caster)
					ParticleManager:SetParticleControl(pfx4, 0, caster:GetAbsOrigin())
					self:armParticleLifetime(pfx4, 0.35)
					caster:SetAnimation("attack_spin")
					self:PlayDamage(caster)
					Timers:CreateTimer(0.15, function()
						self:PlayDamage(caster)
					end)
				end)
			end)
		end)
	end)
end
function phantome_ab4.prototype.PlayDamage(self, caster)
	local pos = caster:GetAbsOrigin()
	GridNav:DestroyTreesAroundPoint(pos, 600, false)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		pos,
		nil,
		550,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NOT_MAGIC_IMMUNE_ALLIES,
		0,
		false
	)
	__TS__ArrayForEach(enemies, function(____, enemy)
		caster:MonsterDamage({ victim = enemy, damage_rate = 20, ability = self, effectName = px2 })
	end)
end
phantome_ab4 = __TS__DecorateLegacy({ registerAbility(nil) }, phantome_ab4)
local phantome_ab4_pre = __TS__Class()
phantome_ab4_pre.name = "phantome_ab4_pre"
__TS__ClassExtends(phantome_ab4_pre, BaseModifier)
function phantome_ab4_pre.prototype.OnCreated(self, params)
	local caster = self:GetCaster()
	local pfx_name = "particles/aghanim_beam_channel_ground_rings_red3.vpcf"
	local pfx = ParticleManager:CreateParticle(pfx_name, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControl(pfx, 0, caster:GetAbsOrigin())
	self.pfx = pfx
end
function phantome_ab4_pre.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	ParticleManager:DestroyParticle(self.pfx, false)
	ParticleManager:ReleaseParticleIndex(self.pfx)
end
phantome_ab4_pre = __TS__DecorateLegacy({ registerModifier(nil) }, phantome_ab4_pre)
return ____exports