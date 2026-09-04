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
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local BaseHeroModifier = _____base_hero_ability.BaseHeroModifier
--- 阵内友军扫描间隔（秒）
local DROW_010_SCAN_INTERVAL = 0.5
--- 单次刷新的增益持续（秒）：离阵后自然过期
local DROW_010_BUFF_LINGER = 1
--- 追击结算延迟（秒），与魅影模糊追击一致
local DROW_010_FOLLOWUP_DELAY = 0.35
--- 额外施加的冰冻层数与持续：当前全项目单次冰冻施加均为 1 层，补 1 层即「额外施加一次」等效
local DROW_010_REFREEZE_STACK = 1
local DROW_010_REFREEZE_DURATION = 3
--- 冰冻视觉（全项目冰冻统一语义）
local DROW_010_FREEZE_EFFECT = "particles/units/heroes/hero_drow/drow_frost_arrow_debuff.vpcf"
local DROW_010_FREEZE_STATUS_EFFECT = "particles/status_fx/status_effect_drow_frost_arrow.vpcf"
--- 阵地雪场氛围（项目现役：boss_chaos_phase_summon 极寒雪场同款）
local DROW_010_FIELD_EFFECT =
	"particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/maiden_freezing_field_snow_arcana1.vpcf"
local DROW_010_CAST_SOUND = "Ability.FrostNova"
--- 卓尔游侠技能 010 - 凛冬之阵
-- 主动（R 槽）：在自身位置展开大范围冰霜之阵。阵中（施法者位于阵内）：
-- 施加冰冻时额外施加一次；普攻命中追加一次敏捷百分比物理伤害并触发一次攻击。
-- 阵内的己方英雄获得攻击速度与减伤增益。
____exports.drow_010 = __TS__Class()
local drow_010 = ____exports.drow_010
drow_010.name = "drow_010"
__TS__ClassExtends(drow_010, BaseHeroAbility)
function drow_010.prototype.Precache(self, context)
	PrecacheResource("particle", DROW_010_FIELD_EFFECT, context)
end
function drow_010.prototype.GetAbilityConfig(self)
	return { castPoint = 0.2, castAnimation = ACT_DOTA_CAST_ABILITY_4, behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function drow_010.prototype.GetFormationRadius(self)
	return self:GetSpecialValue("drow_010", "formation_radius")
end
function drow_010.prototype.GetFormationDuration(self)
	return self:GetSpecialValue("drow_010", "formation_duration")
end
function drow_010.prototype.GetAgilityDamagePct(self)
	return self:GetSpecialValue("drow_010", "agility_damage_pct")
end
function drow_010.prototype.GetAttackSpeedBonusPct(self)
	return self:GetSpecialValue("drow_010", "attack_speed_bonus_pct")
end
function drow_010.prototype.GetDamageReductionBonusPct(self)
	return self:GetSpecialValue("drow_010", "damage_reduction_bonus_pct")
end
function drow_010.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local center = caster:GetAbsOrigin()
	local ____opt_0 = ____exports.modifier_drow_010_formation_controller:find_on(caster)
	if ____opt_0 ~= nil then
		____opt_0:Destroy()
	end
	____exports.modifier_drow_010_formation_controller:applys(caster, caster, self, {
		duration = self:GetFormationDuration(),
		center_x = center.x,
		center_y = center.y,
		center_z = center.z,
	})
end
drow_010 = __TS__DecorateLegacy({ registerAbility(nil) }, drow_010)
____exports.drow_010 = drow_010
--- 阵控制器（挂施法者）：周期给阵内己方英雄刷增益；承载施法者专属的冰冻双倍与普攻追击
____exports.modifier_drow_010_formation_controller = __TS__Class()
local modifier_drow_010_formation_controller = ____exports.modifier_drow_010_formation_controller
modifier_drow_010_formation_controller.name = "modifier_drow_010_formation_controller"
__TS__ClassExtends(modifier_drow_010_formation_controller, BaseHeroModifier)
function modifier_drow_010_formation_controller.prototype.____constructor(self, ...)
	BaseHeroModifier.prototype.____constructor(self, ...)
	self.centerX = 0
	self.centerY = 0
	self.centerZ = 0
	self.reapplying = false
	self.followupTimer = 0
end
function modifier_drow_010_formation_controller.GetLocalizationCN(self)
	return {
		name = "凛冬之阵",
		description = "冰霜之阵已展开：施加冰冻时额外施加一次，普攻追加伤害并触发一次攻击。",
	}
end
function modifier_drow_010_formation_controller.prototype.DeclareEvents(self)
	return {
		{ event = BusinessEvents.ON_DEBUFF_STATUS_APPLIED, target = { scope = "global" } },
		BusinessEvents.ON_ATTACK_LANDED,
	}
end
function modifier_drow_010_formation_controller.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_drow_010_formation_controller.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.centerX = params.center_x or 0
	self.centerY = params.center_y or 0
	self.centerZ = params.center_z or 0
	self.reapplying = false
	self.followupTimer = 0
	local parent = self:GetParent()
	if IsValid(nil, parent) then
		parent:EmitSound(DROW_010_CAST_SOUND)
	end
	self.fieldEffect = ParticleManager:CreateParticle(DROW_010_FIELD_EFFECT, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(self.fieldEffect, false)
	ParticleManager:SetParticleControl(self.fieldEffect, 0, self:GetCenter())
	self:ScanAndBuffAllies()
	self:StartIntervalThink(DROW_010_SCAN_INTERVAL)
end
function modifier_drow_010_formation_controller.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self.fieldEffect ~= nil then
		ParticleManager:DestroyParticle(self.fieldEffect, false)
		ParticleManager:ReleaseParticleIndex(self.fieldEffect)
		self.fieldEffect = nil
	end
end
function modifier_drow_010_formation_controller.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:ScanAndBuffAllies()
end
function modifier_drow_010_formation_controller.prototype.GetCenter(self)
	return Vector(self.centerX, self.centerY, self.centerZ)
end
function modifier_drow_010_formation_controller.prototype.IsParentInFormation(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or not IsValidAlive(nil, parent) then
		return false
	end
	return GetDistance(nil, self:GetCenter(), parent:GetAbsOrigin()) <= ability:GetFormationRadius()
end
function modifier_drow_010_formation_controller.prototype.ScanAndBuffAllies(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or not IsValidAlive(nil, parent) then
		return
	end
	local allies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		self:GetCenter(),
		nil,
		ability:GetFormationRadius(),
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, ally in ipairs(allies) do
		do
			if not IsValidAlive(nil, ally) then
				goto __continue28
			end
			local existing = ally:FindModifierByName(____exports.modifier_drow_010_formation_buff.name)
			if existing and not existing:IsNull() then
				existing:SetDuration(DROW_010_BUFF_LINGER, true)
			else
				____exports.modifier_drow_010_formation_buff:applys(
					ally,
					parent,
					ability,
					{ duration = DROW_010_BUFF_LINGER }
				)
			end
		end
		::__continue28::
	end
end
function modifier_drow_010_formation_controller.prototype.OnDebuffStatusApplied_CS(self, event)
	if not IsServer() then
		return
	end
	if self.reapplying then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or not IsValidAlive(nil, parent) then
		return
	end
	if event.caster ~= parent then
		return
	end
	if event.status ~= DebuffStatusType.ICE_SLOW then
		return
	end
	local target = event.target
	if not target or target == parent then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	if not self:IsParentInFormation() then
		return
	end
	self.reapplying = true
	AddDeBuffStatus(
		nil,
		target,
		parent,
		ability,
		DebuffStatusType.ICE_SLOW,
		{
			stack = DROW_010_REFREEZE_STACK,
			duration = DROW_010_REFREEZE_DURATION,
			effect_name = DROW_010_FREEZE_EFFECT,
			status_effect_name = DROW_010_FREEZE_STATUS_EFFECT,
		}
	)
	self.reapplying = false
end
function modifier_drow_010_formation_controller.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or not IsValidAlive(nil, parent) then
		return
	end
	if event.attacker ~= parent then
		return
	end
	if event.is_sub_attack then
		return
	end
	local target = event.target
	if not target or not IsValidAlive(nil, target) then
		return
	end
	if GameRules:GetGameTime() < self.followupTimer then
		return
	end
	if not self:IsParentInFormation() then
		return
	end
	local entIndex = target:GetEntityIndex()
	self:Timer(DROW_010_FOLLOWUP_DELAY, function()
		if not IsValid(nil, ability) or not IsValidAlive(nil, parent) then
			return
		end
		if not IsValidAlive(nil, target) or target:GetEntityIndex() ~= entIndex then
			return
		end
		local agility = MyGameAttribute:GetAttribute(parent, "total_agility") or 0
		local followupDamage = agility * ability:GetAgilityDamagePct() / 100
		if followupDamage > 0 then
			Damage:ApplyDamage({
				attacker = parent,
				victim = target,
				damage = followupDamage,
				damage_type = 1,
				ability = ability,
			})
		end
		self.followupTimer = GameRules:GetGameTime() + 0.05
		MyGameAttack:PerformAttack(parent, target, { use_projectile = false, use_effect = true })
	end)
end
function modifier_drow_010_formation_controller.prototype.GetTexture(self)
	return "drow_10"
end
modifier_drow_010_formation_controller =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_drow_010_formation_controller)
____exports.modifier_drow_010_formation_controller = modifier_drow_010_formation_controller
--- 阵中增益（挂阵内己方英雄）：攻击速度与减伤
____exports.modifier_drow_010_formation_buff = __TS__Class()
local modifier_drow_010_formation_buff = ____exports.modifier_drow_010_formation_buff
modifier_drow_010_formation_buff.name = "modifier_drow_010_formation_buff"
__TS__ClassExtends(modifier_drow_010_formation_buff, BaseModifier_CS)
function modifier_drow_010_formation_buff.GetLocalizationCN(self)
	return { name = "凛冬之阵", description = "阵中庇护：攻击速度与减伤提升。" }
end
function modifier_drow_010_formation_buff.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = false, isPurgable = true, isPurgeException = false }
end
function modifier_drow_010_formation_buff.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return {}
	end
	return {
		attack_speed_pct = ability:GetAttackSpeedBonusPct(),
		damage_reduction_pct = ability:GetDamageReductionBonusPct(),
	}
end
function modifier_drow_010_formation_buff.prototype.GetTexture(self)
	return "drow_10"
end
modifier_drow_010_formation_buff = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_drow_010_formation_buff)
____exports.modifier_drow_010_formation_buff = modifier_drow_010_formation_buff
return ____exports