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
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local modifier_elite_021_knockup
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ELITE_021_CHANNEL_TIME = 1.5
local ELITE_021_DASH_TIME = 0.35
local ELITE_021_DASH_DISTANCE = 1000
local ELITE_021_DAMAGE_RATE = 15
--- 精英技能21 - 蓄力后向前冲刺，对路径上的敌人造成击飞
____exports.elite_021 = __TS__Class()
local elite_021 = ____exports.elite_021
elite_021.name = "elite_021"
__TS__ClassExtends(elite_021, MonsterAbility_CS)
function elite_021.prototype.GetCastAnimation(self)
	return ""
end
function elite_021.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = ELITE_021_DASH_DISTANCE - 200,
		castPoint = ELITE_021_CHANNEL_TIME,
		castDuration = ELITE_021_DASH_TIME,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsServer() or not IsValidAlive(nil, caster) then
				return
			end
			caster:EmitSound("Hero_Tusk.WalrusPunch.Cast")
			caster:AddActivityModifier("punch")
			self._caster:StartGestureWithPlaybackRate(ACT_DOTA_IDLE, 2)
			local origin = caster:GetAbsOrigin()
			local forward = caster:GetForwardVector()
			local targetPos = origin:__add(forward:__mul(ELITE_021_DASH_DISTANCE))
			local target = caster:GetMinDistanceUnit(3500)
			caster:LockTargetForSpeed(target, ELITE_021_CHANNEL_TIME)
			self._caster:AddNewModifier(self._caster, self, "modifier_elite_021_pfx", { duration = 1.6 })
			self:WarningEffect(origin, targetPos, ELITE_021_CHANNEL_TIME, {
				getDirection = function()
					return self._caster:GetForwardVector()
				end,
			})
		end,
		OnStart = function()
			if not IsServer() then
				return
			end
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:EmitSound("Hero_Tusk.WalrusPunch.Cast")
			local casterPos = caster:GetAbsOrigin()
			local forward = caster:GetForwardVector()
			local targetPos = casterPos:__add(forward:__mul(ELITE_021_DASH_DISTANCE))
			self._caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 1)
			self._caster:AddNewModifier(self._caster, self, "modifier_pause_actions", { duration = 1 })
			self._caster:FadeGesture(ACT_DOTA_SHARPEN_WEAPON)
			local hitTargets = {}
			self._caster:Mover(targetPos, ELITE_021_DASH_TIME, function(____, position)
				local target = self:GetMinDistanceUnit(80, position)
				if target and not __TS__ArrayIncludes(hitTargets, target:entindex()) then
					modifier_elite_021_knockup:applys(target, self._caster, self, { duration = 1 })
					ScreenShake(caster:GetAbsOrigin(), 10, 10, 0.1, 1000, 0, true)
					self._caster:MonsterDamage({ victim = target, damage_rate = ELITE_021_DAMAGE_RATE, ability = self })
					self:PlayEffects(target)
					hitTargets[#hitTargets + 1] = target:entindex()
					target:EmitSound("Hero_Tusk.WalrusKick.Target")
				end
			end)
		end,
		OnFinish = function()
			if not IsServer() then
				return
			end
			self._caster:ClearActivityModifiers()
			self._caster:FadeGesture(ACT_DOTA_IDLE)
		end,
	}
end
function elite_021.prototype.PlayEffects(self, target)
	if not IsServer() then
		return
	end
	if not IsValidAlive(nil, target) then
		return
	end
	local effect = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_tusk/tusk_walruspunch_start.vpcf",
		PATTACH_WORLDORIGIN,
		target
	)
	ParticleManager:SetParticleControl(effect, 0, target:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(effect)
	local effect2 = ParticleManager:CreateParticle(
		"particles/econ/items/tuskarr/tusk_ti9_immortal/tusk_ti9_walruspunch_start.vpcf",
		PATTACH_WORLDORIGIN,
		target
	)
	ParticleManager:SetParticleControl(effect2, 0, target:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(effect2)
end
elite_021 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_021)
____exports.elite_021 = elite_021
modifier_elite_021_knockup = __TS__Class()
modifier_elite_021_knockup.name = "modifier_elite_021_knockup"
__TS__ClassExtends(modifier_elite_021_knockup, MonsterModifier_CS)
function modifier_elite_021_knockup.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self._elapsed = 0
	self._duration = 1.2
end
function modifier_elite_021_knockup.prototype.RemoveOnDeath(self)
	return false
end
function modifier_elite_021_knockup.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	self._originAngles = parent:GetAngles()
	local pos = parent:GetAbsOrigin()
	local groundZ = GetGroundHeight(pos, parent)
	local ____pos_x_1 = pos.x
	local ____pos_y_2 = pos.y
	local ____temp_0
	if groundZ ~= nil then
		____temp_0 = groundZ
	else
		____temp_0 = pos.z
	end
	self._originPos = Vector(____pos_x_1, ____pos_y_2, ____temp_0)
	self._forward = caster:GetForwardVector()
	if self._forward then
		self._forward = self._forward
	end
	self._duration = self:GetDuration() or 1.2
	self._elapsed = 0
	self:PlayEffects()
	self:OnIntervalThink()
	self:StartIntervalThink(FrameTime())
	self:GetCaster():MonsterDamage({
		victim = parent,
		damage_rate = ELITE_021_DAMAGE_RATE * 0.5,
		ability = self:GetAbility(),
	})
	ScreenShake(caster:GetAbsOrigin(), 10, 10, 0.1, 1000, 0, true)
end
function modifier_elite_021_knockup.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) or not self._originPos or not self._originAngles then
		self:Destroy()
		return
	end
	local dt = FrameTime()
	self._elapsed = self._elapsed + dt
	local t = math.min(self._elapsed / self._duration, 1)
	local maxHeight = 500
	local totalYaw = 360
	local heightFactor = math.sin(math.pow(t, 0.5) * math.pi)
	local z = self._originPos.z + maxHeight * heightFactor
	parent:SetAbsOrigin(Vector(self._originPos.x, self._originPos.y, z):__add(self._forward:__mul(80 * self._elapsed)))
	local easedT = 1 - (1 - t) * (1 - t)
	local yaw = self._originAngles.x + totalYaw * easedT
	parent:SetAngles(yaw, self._originAngles.y, 0)
end
function modifier_elite_021_knockup.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValid(nil, parent) then
		parent:SetAngles(0, self._originAngles.y, 0)
		FindClearSpaceForUnit(parent, parent:GetAbsOrigin(), true)
		ScreenShake(parent:GetAbsOrigin(), 20, 20, 0.15, 1500, 0, true)
		self:GetCaster():MonsterDamage({
			victim = parent,
			damage_rate = ELITE_021_DAMAGE_RATE * 0.5,
			ability = self:GetAbility(),
		})
	end
end
function modifier_elite_021_knockup.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true }
end
function modifier_elite_021_knockup.prototype.GetEffectName(self)
	return "particles/units/heroes/hero_tusk/tusk_walruspunch_tgt.vpcf"
end
function modifier_elite_021_knockup.prototype.PlayEffects(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local effect = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_tusk/tusk_walruspunch_start.vpcf",
		PATTACH_WORLDORIGIN,
		parent
	)
	ParticleManager:SetParticleControl(effect, 0, parent:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(effect)
	local effect2 = ParticleManager:CreateParticle(
		"particles/econ/items/tuskarr/tusk_ti9_immortal/tusk_ti9_walruspunch_start.vpcf",
		PATTACH_WORLDORIGIN,
		parent
	)
	ParticleManager:SetParticleControl(effect2, 0, parent:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(effect2)
end
modifier_elite_021_knockup =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_021_knockup") }, modifier_elite_021_knockup)
local pfx = "particles/status_fx/status_effect_void_spirit_pulse_buff.vpcf"
____exports.modifier_elite_021_pfx = __TS__Class()
local modifier_elite_021_pfx = ____exports.modifier_elite_021_pfx
modifier_elite_021_pfx.name = "modifier_elite_021_pfx"
__TS__ClassExtends(modifier_elite_021_pfx, MonsterModifier_CS)
function modifier_elite_021_pfx.prototype.GetStatusEffectName(self)
	return pfx
end
modifier_elite_021_pfx = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_elite_021_pfx)
____exports.modifier_elite_021_pfx = modifier_elite_021_pfx
return ____exports