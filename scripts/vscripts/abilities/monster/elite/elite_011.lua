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
local modifier_elite_011_buff, modifier_elite_011_knockup
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local BUFF_DURATION = 5
local SELF_MOVESPEED_SLOW_PCT = -50
--- 精英技能11 - 自身减速，下一次攻击必定暴击并击飞目标
____exports.elite_011 = __TS__Class()
local elite_011 = ____exports.elite_011
elite_011.name = "elite_011"
__TS__ClassExtends(elite_011, MonsterAbility_CS)
function elite_011.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = 600,
		castPoint = 2,
		castDuration = BUFF_DURATION,
		animationPlaybackRate = 0.5,
		isNotMove = false,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_3,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsServer() or not IsValidAlive(nil, caster) then
				return
			end
			caster:EmitSound("Hero_Tusk.WalrusPunch.Cast")
			modifier_elite_011_buff:remove(caster)
			modifier_elite_011_buff:applys(caster, caster, self, { duration = BUFF_DURATION })
		end,
	}
end
elite_011 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_011)
____exports.elite_011 = elite_011
modifier_elite_011_buff = __TS__Class()
modifier_elite_011_buff.name = "modifier_elite_011_buff"
__TS__ClassExtends(modifier_elite_011_buff, MonsterModifier_CS)
function modifier_elite_011_buff.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.consumed = false
end
function modifier_elite_011_buff.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_START, BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_elite_011_buff.prototype.OnAttackStart_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	parent:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 1)
end
function modifier_elite_011_buff.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent or self.consumed then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, target) then
		self:Destroy()
		return
	end
	self.consumed = true
	modifier_elite_011_knockup:applys(target, parent, self:GetAbility(), { duration = 1.2 })
	local damage = self:GetAllAttackDamage(parent)
	Damage:ApplyDamage({
		attacker = parent,
		victim = target,
		damage = damage,
		damage_type = 1,
		ability = self:GetAbility(),
	})
	self:Destroy()
end
function modifier_elite_011_buff.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	parent:AddActivityModifier("punch")
	self:PlayEffects2()
end
function modifier_elite_011_buff.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = SELF_MOVESPEED_SLOW_PCT }
end
function modifier_elite_011_buff.prototype.PlayEffects2(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local effect = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_tusk/tusk_walruspunch_status.vpcf",
		PATTACH_POINT_FOLLOW,
		parent
	)
	ParticleManager:SetParticleControlEnt(
		effect,
		0,
		parent,
		PATTACH_POINT_FOLLOW,
		"attach_attack2",
		parent:GetAbsOrigin(),
		true
	)
	self:AddParticle(effect, false, false, -1, false, false)
end
function modifier_elite_011_buff.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValidAlive(nil, parent) then
		parent:ClearActivityModifiers()
	end
end
modifier_elite_011_buff =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_011_buff") }, modifier_elite_011_buff)
modifier_elite_011_knockup = __TS__Class()
modifier_elite_011_knockup.name = "modifier_elite_011_knockup"
__TS__ClassExtends(modifier_elite_011_knockup, MonsterModifier_CS)
function modifier_elite_011_knockup.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self._elapsed = 0
	self._duration = 1.2
end
function modifier_elite_011_knockup.prototype.RemoveOnDeath(self)
	return false
end
function modifier_elite_011_knockup.prototype.OnCreated(self)
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
	self._duration = self:GetDuration() or 1.2
	self._elapsed = 0
	self:PlayEffects()
	self:OnIntervalThink()
	self:StartIntervalThink(FrameTime())
end
function modifier_elite_011_knockup.prototype.OnIntervalThink(self)
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
	local maxHeight = 650
	local totalYaw = 360
	local heightFactor = 4 * t * (1 - t)
	local z = self._originPos.z + maxHeight * heightFactor
	parent:SetAbsOrigin(Vector(self._originPos.x, self._originPos.y, z))
	local yaw = self._originAngles.x + totalYaw * t
	parent:SetAngles(yaw, 0, 0)
end
function modifier_elite_011_knockup.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValid(nil, parent) then
		parent:SetAngles(0, 0, 0)
		FindClearSpaceForUnit(parent, parent:GetAbsOrigin(), true)
	end
end
function modifier_elite_011_knockup.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true }
end
function modifier_elite_011_knockup.prototype.GetEffectName(self)
	return "particles/units/heroes/hero_tusk/tusk_walruspunch_tgt.vpcf"
end
function modifier_elite_011_knockup.prototype.PlayEffects(self)
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
modifier_elite_011_knockup =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_011_knockup") }, modifier_elite_011_knockup)
return ____exports