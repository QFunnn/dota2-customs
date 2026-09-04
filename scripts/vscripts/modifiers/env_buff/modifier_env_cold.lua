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
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
--- 寒冷环境 Debuff（寒冷）
-- 冰雪地图施加的层数型 debuff。
-- - 每层减速 2% 移速 + 攻速
-- - 每 3 秒获得 1 层，最大 20 层
-- - 达到最大层数时，每秒受到 1% 最大生命 + 5 点伤害
-- - 靠近火堆（modifier_env_warmth）时会减少层数
____exports.modifier_env_cold = __TS__Class()
local modifier_env_cold = ____exports.modifier_env_cold
modifier_env_cold.name = "modifier_env_cold"
__TS__ClassExtends(modifier_env_cold, BaseModifier_CS)
function modifier_env_cold.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self._tickCount = 0
end
function modifier_env_cold.prototype.OnCreated(self, _params)
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
	self:StartIntervalThink(1)
	if self:GetParent():GetCustomValue("寒冷抗性") then
		local coldResistance = tonumber(self:GetParent():GetCustomValue("寒冷抗性") or 0)
		if math.random(0, 100) < coldResistance then
			self:Destroy()
		end
	end
end
function modifier_env_cold.prototype.OnRefresh(self, _params)
	if not IsServer() then
		return
	end
	local stacks = self:GetStackCount()
	if self:GetParent():GetCustomValue("寒冷抗性") then
		local coldResistance = tonumber(self:GetParent():GetCustomValue("寒冷抗性") or 0)
		if math.random(0, 100) < coldResistance then
			return
		end
	end
	if stacks < ____exports.modifier_env_cold.MAX_STACKS then
		self:AddStackCount(1)
	end
end
function modifier_env_cold.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local stacks = self:GetStackCount()
	if stacks >= ____exports.modifier_env_cold.MAX_STACKS then
		local maxHp = parent:GetMaxHealth()
		local damage = maxHp * (____exports.modifier_env_cold.MAX_STACK_DAMAGE_PCT / 100)
			+ ____exports.modifier_env_cold.MAX_STACK_DAMAGE_FLAT
		local attacker = self:GetDamageAttacker(parent)
		Damage:ApplyDamage({
			attacker = attacker,
			victim = parent,
			damage = damage,
			damage_type = 4,
			damage_flag = ApplyDamageFlag.HP_LOSS,
			extra_data = {
				custom_tag = "modifier_env_cold",
				source_name = "modifier_env_cold",
				damage_tags = DamageTag.DOT,
			},
		})
		local player = parent:GetPlayerOwner()
		if player then
			local fx = ParticleManager:CreateParticleForPlayer(
				"particles/bb/es_earthshaker_arcana_aftershock_screen.vpcf",
				PATTACH_OVERHEAD_FOLLOW,
				parent,
				player
			)
			ParticleManager:ReleaseParticleIndex(fx)
		end
	end
end
function modifier_env_cold.prototype.GetDamageAttacker(self, parent)
	local ____this_1
	____this_1 = parent
	local ____opt_0 = ____this_1.GetPlayerOwnerID
	local playerId = ____opt_0 and ____opt_0(____this_1)
	if playerId ~= nil and playerId >= 0 then
		local ____opt_2 = MyGameRoomManager:GetPlayerRoom(playerId)
		local roomDummy = ____opt_2 and ____opt_2:GetRoomDummy()
		if roomDummy and IsValid(nil, roomDummy) and not roomDummy:IsNull() then
			return roomDummy
		end
	end
	local caster = self:GetCaster()
	if caster and IsValid(nil, caster) and not caster:IsNull() then
		return caster
	end
	return parent
end
function modifier_env_cold.prototype.IsHidden(self)
	return false
end
function modifier_env_cold.prototype.IsDebuff(self)
	return true
end
function modifier_env_cold.prototype.IsPurgable(self)
	return true
end
function modifier_env_cold.prototype.IsPurgeException(self)
	return true
end
function modifier_env_cold.prototype.GetAttributeBonus(self)
	local stacks = self:GetStackCount()
	local slowPct = -(stacks * ____exports.modifier_env_cold.SLOW_PCT_PER_STACK)
	local attackSpeed = stacks * ____exports.modifier_env_cold.SLOW_ATTACK_SPEED_PER_STACK
	return { bonus_movespeed_pct = slowPct, attack_speed = attackSpeed }
end
function modifier_env_cold.prototype.GetStatusEffectName(self)
	return "particles/status_fx/status_effect_frost.vpcf"
end
function modifier_env_cold.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_env_cold.prototype.GetTexture(self)
	return "crystal_maiden_brilliance_aura_persona"
end
modifier_env_cold.SLOW_PCT_PER_STACK = 2
modifier_env_cold.SLOW_ATTACK_SPEED_PER_STACK = -1
modifier_env_cold.MAX_STACKS = 20
modifier_env_cold.MAX_STACK_DAMAGE_PCT = 3
modifier_env_cold.MAX_STACK_DAMAGE_FLAT = 6
modifier_env_cold = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_env_cold)
____exports.modifier_env_cold = modifier_env_cold
return ____exports