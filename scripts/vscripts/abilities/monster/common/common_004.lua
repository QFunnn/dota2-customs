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
local ____monster_warning_effects = require("modifiers.monster.monster_warning_effects")
local findHeroesInRadius = ____monster_warning_effects.findHeroesInRadius
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
--- 毒雾伤害/搜敌半径
local COMMON_004_POISON_RADIUS = 450
--- 死亡后延迟爆发时间（秒）
local COMMON_004_EXPLOSION_DELAY = 0.5
--- 周期伤害间隔（秒）
local COMMON_004_DAMAGE_INTERVAL = 0.3
--- thinker / 毒雾持续时间（秒）
local COMMON_004_DURATION = 4
--- 伤害倍率（与 MonsterDamage.damage_rate 语义一致）
local COMMON_004_DAMAGE_RATE = 5
local PARTICLE_POISON = "particles/econ/items/viper/viper_immortal_tail_ti8/viper_immortal_ti8_nethertoxin.vpcf"
--- 怪物通用技能4 - 遗言：拥有者死亡时在原地生成 thinker，持续 4 秒；
-- 每 0.2 秒对范围内敌方单位造成伤害，并播放毒雾粒子（CP0 原点、CP1 范围感，同 viper nethertoxin 惯例）。
____exports.common_004 = __TS__Class()
local common_004 = ____exports.common_004
common_004.name = "common_004"
__TS__ClassExtends(common_004, MonsterAbility_CS)
function common_004.prototype.Precache(self, context)
	PrecacheResource("particle", PARTICLE_POISON, context)
end
function common_004.prototype.GetMosnterAbilityConfig(self)
	return { castPoint = 0, castDuration = 0, behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function common_004.prototype.OnOwnerDied(self)
	if not IsServer() then
		return
	end
	local owner = self:GetCaster()
	if not owner or not IsValid(nil, owner) or owner:IsNull() then
		return
	end
	local origin = owner:GetAbsOrigin()
	local groundZ = GetGroundHeight(origin, owner)
	local ____origin_x_1 = origin.x
	local ____origin_y_2 = origin.y
	local ____temp_0
	if groundZ ~= nil then
		____temp_0 = groundZ
	else
		____temp_0 = origin.z
	end
	local spawnPos = Vector(____origin_x_1, ____origin_y_2, ____temp_0)
	local attackSnapshot = 0
	if MyGameAttribute:HasAttributes(owner) then
		attackSnapshot = MyGameAttribute:GetAttribute(owner, "total_attack_damage") or 0
	end
	local ____opt_3 = owner.GetRoomId
	local roomId = ____opt_3 and ____opt_3(owner)
	CreateModifierThinker(
		owner,
		self,
		"modifier_common_004_thinker",
		{
			duration = COMMON_004_EXPLOSION_DELAY + COMMON_004_DURATION,
			attack_snapshot = attackSnapshot,
			damage_rate = COMMON_004_DAMAGE_RATE,
			room_id = roomId,
		},
		spawnPos,
		owner:GetTeamNumber(),
		false
	)
end
function common_004.prototype.GetIntrinsicModifierName(self)
	return "modifier_common_004"
end
common_004 = __TS__DecorateLegacy({ registerAbility(nil) }, common_004)
____exports.common_004 = common_004
local modifier_common_004_thinker = __TS__Class()
modifier_common_004_thinker.name = "modifier_common_004_thinker"
__TS__ClassExtends(modifier_common_004_thinker, MonsterModifier_CS)
function modifier_common_004_thinker.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.attackSnapshot = 0
	self.damageRate = COMMON_004_DAMAGE_RATE
end
function modifier_common_004_thinker.prototype.IsHidden(self)
	return true
end
function modifier_common_004_thinker.prototype.OnCreated(self, kv)
	if not IsServer() then
		return
	end
	local thinker = self:GetParent()
	if not IsValid(nil, thinker) or thinker:IsNull() then
		return
	end
	self.attackSnapshot = kv and kv.attack_snapshot or 0
	self.damageRate = kv and kv.damage_rate or COMMON_004_DAMAGE_RATE
	self.roomId = kv and kv.room_id
	if self.roomId ~= nil then
		thinker.__room_id__ = self.roomId
	end
	Timers:CreateTimer(COMMON_004_EXPLOSION_DELAY, function()
		SafelyCall(nil, function()
			if self:IsRemoved() then
				return
			end
			self:explode()
		end)
	end)
end
function modifier_common_004_thinker.prototype.explode(self)
	local thinker = self:GetParent()
	if not IsValid(nil, thinker) or thinker:IsNull() then
		return
	end
	local origin = thinker:GetAbsOrigin()
	self.pfxPoison = ParticleManager:CreateParticle(PARTICLE_POISON, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(self.pfxPoison, false)
	ParticleManager:SetParticleControl(self.pfxPoison, 0, origin)
	ParticleManager:SetParticleControl(self.pfxPoison, 1, Vector(COMMON_004_POISON_RADIUS * 0.8, 1, 1))
	self:GetParent():EmitSound("Hero_Viper.Nethertoxin.Cast")
	self:applyPoisonDamage()
	self:StartIntervalThink(COMMON_004_DAMAGE_INTERVAL)
end
function modifier_common_004_thinker.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local thinker = self:GetParent()
	if not IsValid(nil, thinker) or thinker:IsNull() then
		return
	end
	self:applyPoisonDamage()
end
function modifier_common_004_thinker.prototype.getDamageAttacker(self, thinker)
	local ____self_roomId_13 = self.roomId
	if ____self_roomId_13 == nil then
		local ____this_12
		____this_12 = thinker
		local ____opt_11 = ____this_12.GetRoomId
		____self_roomId_13 = ____opt_11 and ____opt_11(____this_12)
	end
	local roomId = ____self_roomId_13
	if roomId == nil or roomId == nil then
		return thinker
	end
	local room = MyGameRoomManager:GetRoom(tostring(roomId))
	return room and room:GetRoomDummy() or thinker
end
function modifier_common_004_thinker.prototype.applyPoisonDamage(self)
	local thinker = self:GetParent()
	if not IsValidAlive(nil, thinker) then
		return
	end
	if not IsValid(nil, thinker) or thinker:IsNull() then
		return
	end
	local center = thinker:GetAbsOrigin()
	local attacker = self:getDamageAttacker(thinker)
	local enemies = findHeroesInRadius(nil, thinker:GetTeamNumber(), center, COMMON_004_POISON_RADIUS)
	for ____, victim in ipairs(enemies) do
		do
			if not IsValidAlive(nil, victim) then
				goto __continue27
			end
			ApplyMonsterDamage(nil, attacker, {
				victim = victim,
				damage_rate = self.damageRate,
				attack_damage_override = self.attackSnapshot,
				damage_type = 2,
				ability = self:GetAbility(),
			})
			AddDeBuffStatus(
				nil,
				victim,
				attacker,
				self:GetAbility(),
				DebuffStatusType.POISON,
				{ stack = 1, duration = 5 }
			)
		end
		::__continue27::
	end
end
function modifier_common_004_thinker.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self.pfxPoison ~= nil then
		ParticleManager:DestroyParticle(self.pfxPoison, false)
		ParticleManager:ReleaseParticleIndex(self.pfxPoison)
		self.pfxPoison = nil
	end
	local thinker = self:GetParent()
	if IsValid(nil, thinker) and not thinker:IsNull() then
		thinker:SelfRemoveSelf()
	end
end
function modifier_common_004_thinker.prototype.IsPurgable(self)
	return false
end
modifier_common_004_thinker =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_common_004_thinker") }, modifier_common_004_thinker)
local modifier_common_004 = __TS__Class()
modifier_common_004.name = "modifier_common_004"
__TS__ClassExtends(modifier_common_004, MonsterModifier_CS)
function modifier_common_004.prototype.IsHidden(self)
	return true
end
function modifier_common_004.prototype.GetEffectName(self)
	return "particles/viper_poison_crimson_debuff_ti7.vpcf"
end
modifier_common_004 = __TS__DecorateLegacy({ registerModifier(nil, "modifier_common_004") }, modifier_common_004)
return ____exports