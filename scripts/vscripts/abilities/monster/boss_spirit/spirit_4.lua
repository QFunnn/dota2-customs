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
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
require("abilities.monster.boss_spirit.spirit_base_modifier")
local pfx5 = "particles/status_fx/status_effect_void_spirit_pulse_buff.vpcf"
local pfx10 = "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_debuff.vpcf"
local spirit_4 = __TS__Class()
spirit_4.name = "spirit_4"
__TS__ClassExtends(spirit_4, MonsterAbility_CS)
function spirit_4.prototype.OnAbilityPhaseStart(self)
	if not IsServer() then
		return true
	end
	local caster = self:GetCaster()
	local origin = caster:GetSpawnPoint()
	if origin and (caster:GetOrigin() - origin):Length2D() > 2600 then
		return false
	end
	return MonsterAbility_CS.prototype.OnAbilityPhaseStart(self)
end
function spirit_4.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = 2,
		castDuration = 4.3,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		isNotMove = true,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local origin = caster:GetSpawnPoint()
			if origin then
				local arr = generatePoints(nil, origin, 30, 1800, 500)
				arr[#arr + 1] = origin
				caster.spirit_4_arr = arr
			end
			self:PlayEffects_pre(caster)
			self:Timer(1.5, function()
				if IsValidAlive(nil, caster) then
					caster:AddNewModifier(caster, self, "spirit_4_modifier_start_pre", { duration = 4.3 })
				end
			end)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self:GetCaster():StartGesture(ACT_DOTA_CAST_ABILITY_2)
			caster:SetForwardVector(caster.spirit_4_arr[1]:__sub(caster:GetOrigin()):Normalized())
			self:Timer(0.15, function()
				caster:AddNewModifier(caster, self, "spirit_4_modifier_start", { duration = 4.3 })
			end)
		end,
		OnFinish = function()
			local caster = self:GetCaster()
			caster:RemoveModifierByName("spirit_4_modifier_start_pre")
		end,
	}
end
function spirit_4.prototype.Slash(self, origin2, target, radius)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	if not caster:IsAlive() then
		return
	end
	caster:SetOrigin(target)
	ScreenShake(caster:GetAbsOrigin(), 8, 8, 0.1, 3500, 0, true)
	caster:SetForwardVector(target:__sub(origin2):Normalized())
	local enemies = FindUnitsInLine(
		caster:GetTeamNumber(),
		origin2,
		target,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue17
			end
			caster:PerformAttack(enemy, true, true, true, false, true, false, true)
			enemy:AddNewModifier(caster, self, "modifier_spirit_astral_step_debuff", { duration = 1 })
			self:PlayEffects2(enemy)
		end
		::__continue17::
	end
	self:PlayEffects1(origin2, target)
end
function spirit_4.prototype.PlayEffects1_pre(self, origin, target)
	local particle_cast = "particles/void_spirit_astral_step2.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, origin:__add(Vector(0, 0, 128)))
	ParticleManager:SetParticleControl(effect_cast, 1, target:__add(Vector(0, 0, 128)))
	ParticleManager:ReleaseParticleIndex(effect_cast)
end
function spirit_4.prototype.PlayEffects1(self, origin, target)
	local particle_cast = "particles/boss/void_spirit_astral_step.vpcf"
	local sound_start = "Hero_VoidSpirit.AstralStep.Start"
	local sound_end = "Hero_VoidSpirit.AstralStep.End"
	if not IsValidAlive(nil, self:GetCaster()) then
		return
	end
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl(effect_cast, 0, origin)
	ParticleManager:SetParticleControl(effect_cast, 1, target)
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOnLocationWithCaster(origin, sound_start, self:GetCaster())
	EmitSoundOnLocationWithCaster(target, sound_end, self:GetCaster())
	self:GetCaster():StartGesture(ACT_DOTA_CAST_ABILITY_2_END)
end
function spirit_4.prototype.PlayEffects2(self, target)
	local particle_cast = "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_impact.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end
function spirit_4.prototype.PlayEffects_pre(self, target)
	local particle_cast = "particles/units/heroes/hero_void_spirit/dissimilate/void_spirit_dissimilate.vpcf"
	local sound_cast = "Hero_VoidSpirit.Dissimilate.Portals"
	local point = target:GetSpawnPoint()
	if not point then
		return
	end
	local radius = 200
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, target)
	ParticleManager:SetParticleControl(effect_cast, 0, target:GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(radius, 0, 1))
	ParticleManager:SetParticleControl(effect_cast, 2, Vector(1, 0, 0))
	local effect_cast2 = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, target)
	ParticleManager:SetParticleControl(effect_cast2, 0, point)
	ParticleManager:SetParticleControl(effect_cast2, 1, Vector(radius, 0, 1))
	target:AddNoDraw()
	EmitSoundOnLocationWithCaster(point, sound_cast, target)
	self:Timer(0.6, function()
		ParticleManager:DestroyParticle(effect_cast, false)
		ParticleManager:ReleaseParticleIndex(effect_cast)
		ParticleManager:DestroyParticle(effect_cast2, false)
		ParticleManager:ReleaseParticleIndex(effect_cast2)
		if not IsValidAlive(nil, target) then
			return
		end
		FindClearSpaceForUnit(target, point, false)
		target:RemoveNoDraw()
		target:StartGesture(ACT_DOTA_CAST_ABILITY_3_END)
		self:PlayEffects_pre2(point, 1)
		return
	end)
end
function spirit_4.prototype.PlayEffects_pre2(self, point, hit)
	local particle_cast = "particles/units/heroes/hero_void_spirit/dissimilate/void_spirit_dissimilate_dmg.vpcf"
	local particle_cast2 = "particles/units/heroes/hero_void_spirit/dissimilate/void_spirit_dissimilate_exit.vpcf"
	local sound_cast = "Hero_VoidSpirit.Dissimilate.TeleportIn"
	local sound_hit = "Hero_VoidSpirit.Dissimilate.Stun"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl(effect_cast, 0, point)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(160, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect_cast)
	local effect_cast2 = ParticleManager:CreateParticle(particle_cast2, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:ReleaseParticleIndex(effect_cast2)
	self:GetCaster():EmitSound(sound_cast)
	if hit > 0 then
		self:GetCaster():EmitSound(sound_hit)
	end
end
spirit_4 = __TS__DecorateLegacy({ registerAbility(nil) }, spirit_4)
--- 预览与斩击共用：路径点数组 + 首段起点(即 arr[30])，每 0.12s 处理一段
local function spirit_4_get_segment(self, arr, n, origin)
	if n > 30 or not arr[n + 1] then
		return nil
	end
	local ____temp_0
	if n == 0 then
		____temp_0 = origin
	else
		____temp_0 = arr[n]
	end
	local from = ____temp_0
	local to = arr[n + 1]
	return { from = from, to = to }
end
local spirit_4_modifier_start_pre = __TS__Class()
spirit_4_modifier_start_pre.name = "spirit_4_modifier_start_pre"
__TS__ClassExtends(spirit_4_modifier_start_pre, BaseModifier_CS)
function spirit_4_modifier_start_pre.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.n = 0
end
function spirit_4_modifier_start_pre.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local arr = caster.spirit_4_arr
	if not arr or #arr < 31 then
		return
	end
	self.arr = arr
	self.origin = arr[31]
	self.n = 0
	self:GetCaster():StartGesture(ACT_DOTA_CAST_ABILITY_4)
	self:StartIntervalThink(0.12)
end
function spirit_4_modifier_start_pre.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) then
		return
	end
	local seg = spirit_4_get_segment(nil, self.arr, self.n, self.origin)
	if seg then
		ability:PlayEffects1_pre(seg.from, seg.to)
	end
	self.n = self.n + 1
	if self.n > 30 then
		self:Destroy()
	end
end
spirit_4_modifier_start_pre = __TS__DecorateLegacy({ registerModifier(nil) }, spirit_4_modifier_start_pre)
local spirit_4_modifier_start = __TS__Class()
spirit_4_modifier_start.name = "spirit_4_modifier_start"
__TS__ClassExtends(spirit_4_modifier_start, BaseModifier_CS)
function spirit_4_modifier_start.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.n = 0
	self.radius = 100
end
function spirit_4_modifier_start.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local arr = caster.spirit_4_arr
	if not arr or #arr < 31 then
		return
	end
	self.arr = arr
	self.origin = arr[31]
	self.n = 0
	self:StartIntervalThink(0.12)
end
function spirit_4_modifier_start.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) then
		return
	end
	local seg = spirit_4_get_segment(nil, self.arr, self.n, self.origin)
	if seg then
		ability:Slash(seg.from, seg.to, self.radius)
	end
	self.n = self.n + 1
	if self.n > 30 then
		FindClearSpaceForUnit(caster, caster:GetOrigin(), false)
		self:StartIntervalThink(-1)
	end
end
function spirit_4_modifier_start.prototype.GetStatusEffectName(self)
	return pfx5
end
function spirit_4_modifier_start.prototype.GetEffectName(self)
	return pfx10
end
function spirit_4_modifier_start.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function spirit_4_modifier_start.prototype.StatusEffectPriority(self)
	return MODIFIER_PRIORITY_NORMAL
end
spirit_4_modifier_start = __TS__DecorateLegacy({ registerModifier(nil) }, spirit_4_modifier_start)
return ____exports