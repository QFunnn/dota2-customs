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
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local BaseHeroModifier = _____base_hero_ability.BaseHeroModifier
local DROW_003_FROST_PROJECTILE = "particles/units/heroes/hero_drow/drow_frost_arrow.vpcf"
--- 冰冻层数演出：CP0 原点，CP1 的 Y 为堆栈数量
local DROW_003_STACK_COUNTER_PFX = "particles/units/heroes/hero_drow/drow_hypothermia_counter_stack.vpcf"
--- 004 子攻击来源标记：不耗蓝，但可触发霜冻命中
local DROW_004_SUB_ATTACK_TAG = "drow_004_sub_attack"
--- 卓尔游侠技能 003（霜寒之箭）
-- 开关开启时：普攻弹道改为寒冰箭；命中施加冰冻，结算伤害为「层数×总敏捷×agility_damage_pct÷100 + fixed_damage」。`agility_damage_pct`、`fixed_damage`、`slow_duration`、`stacks_per_hit` 见表。
____exports.drow_003 = __TS__Class()
local drow_003 = ____exports.drow_003
drow_003.name = "drow_003"
__TS__ClassExtends(drow_003, BaseHeroAbility)
function drow_003.prototype.____constructor(self, ...)
	BaseHeroAbility.prototype.____constructor(self, ...)
	self._originalProjectileName = ""
	self._hasCachedOriginalProjectile = false
end
function drow_003.prototype.Precache(self, context)
	PrecacheResource("particle", DROW_003_FROST_PROJECTILE, context)
	PrecacheResource("particle", DROW_003_STACK_COUNTER_PFX, context)
end
function drow_003.prototype.GetAbilityConfig(self)
	return {
		castPoint = 0,
		castAnimation = "",
		behavior = DOTA_ABILITY_BEHAVIOR_TOGGLE + DOTA_ABILITY_BEHAVIOR_NO_TARGET,
	}
end
function drow_003.prototype.Spawn(self)
	BaseHeroAbility.prototype.Spawn(self)
	if not IsServer() then
		return
	end
	self:CacheOriginalProjectileName()
	if not self:GetToggleState() then
		self:ToggleAbility()
	end
end
function drow_003.prototype.OnToggle(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not caster or caster:IsNull() then
		return
	end
	self:CacheOriginalProjectileName()
	local projectileName = caster:GetModelName() == "models/items/drow/drow_arcana/drow_arcana.vmdl"
			and "particles/econ/items/drow/drow_arcana/drow_arcana_frost_arrow.vpcf"
		or DROW_003_FROST_PROJECTILE
	local ____caster_SetRangedProjectileName_1 = caster.SetRangedProjectileName
	local ____table_GetToggleState_result_0
	if self:GetToggleState() then
		____table_GetToggleState_result_0 = projectileName
	else
		____table_GetToggleState_result_0 = self:GetOriginalProjectileName()
	end
	____caster_SetRangedProjectileName_1(caster, ____table_GetToggleState_result_0)
end
function drow_003.prototype.GetIntrinsicModifierName(self)
	return "modifier_drow_003_frost_arrow"
end
function drow_003.prototype.GetOriginalProjectileName(self)
	return self._originalProjectileName
end
function drow_003.prototype.CacheOriginalProjectileName(self)
	if self._hasCachedOriginalProjectile then
		return
	end
	local caster = self:GetCaster()
	if not caster or caster:IsNull() then
		return
	end
	local currentName = caster:GetRangedProjectileName()
	self._originalProjectileName = currentName or ""
	self._hasCachedOriginalProjectile = true
end
drow_003 = __TS__DecorateLegacy({ registerAbility(nil) }, drow_003)
____exports.drow_003 = drow_003
____exports.modifier_drow_003_frost_chill_fx = __TS__Class()
local modifier_drow_003_frost_chill_fx = ____exports.modifier_drow_003_frost_chill_fx
modifier_drow_003_frost_chill_fx.name = "modifier_drow_003_frost_chill_fx"
__TS__ClassExtends(modifier_drow_003_frost_chill_fx, BaseModifier_CS)
function modifier_drow_003_frost_chill_fx.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) then
		return
	end
	self.stackCounterPfx = MyGameHeroParticleManager:CreateParticle(
		DROW_003_STACK_COUNTER_PFX,
		PATTACH_OVERHEAD_FOLLOW,
		parent,
		self:GetCaster()
	)
	self:RefreshStackCounterParticle()
	self:StartIntervalThink(0.1)
end
function modifier_drow_003_frost_chill_fx.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:RefreshStackCounterParticle()
end
function modifier_drow_003_frost_chill_fx.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self.stackCounterPfx ~= nil then
		MyGameHeroParticleManager:DestroyParticle(self.stackCounterPfx, false)
		MyGameHeroParticleManager:ReleaseParticleIndex(self.stackCounterPfx)
		self.stackCounterPfx = nil
	end
end
function modifier_drow_003_frost_chill_fx.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if not IsValidAlive(nil, self:GetParent()) then
		return
	end
	local freezeModifier = self:GetParent():FindModifierByNameAndCaster("modifier_generic_slow", self:GetCaster())
	if not freezeModifier or freezeModifier:GetStackCount() <= 0 then
		self:Destroy()
		return
	end
	self:RefreshStackCounterParticle()
end
function modifier_drow_003_frost_chill_fx.prototype.RefreshStackCounterParticle(self)
	if not IsServer() then
		return
	end
	local pfx = self.stackCounterPfx
	if pfx == nil then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	if not IsValid(nil, parent) then
		return
	end
	local freezeModifier = parent:FindModifierByNameAndCaster("modifier_generic_slow", self:GetCaster())
	local stacks = math.max(freezeModifier and freezeModifier:GetStackCount() or 0, 0)
	MyGameHeroParticleManager:SetParticleControl(pfx, 0, parent:GetAbsOrigin())
	MyGameHeroParticleManager:SetParticleControl(pfx, 1, Vector(0, stacks, 0))
end
function modifier_drow_003_frost_chill_fx.prototype.IsHidden(self)
	return true
end
function modifier_drow_003_frost_chill_fx.prototype.IsDebuff(self)
	return false
end
function modifier_drow_003_frost_chill_fx.prototype.IsPurgable(self)
	return false
end
modifier_drow_003_frost_chill_fx = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_drow_003_frost_chill_fx)
____exports.modifier_drow_003_frost_chill_fx = modifier_drow_003_frost_chill_fx
____exports.modifier_drow_003_frost_arrow = __TS__Class()
local modifier_drow_003_frost_arrow = ____exports.modifier_drow_003_frost_arrow
modifier_drow_003_frost_arrow.name = "modifier_drow_003_frost_arrow"
__TS__ClassExtends(modifier_drow_003_frost_arrow, BaseHeroModifier)
function modifier_drow_003_frost_arrow.prototype.____constructor(self, ...)
	BaseHeroModifier.prototype.____constructor(self, ...)
	self.paidAttackRecords = __TS__New(Set)
	self.paidNoRecordCount = 0
end
function modifier_drow_003_frost_arrow.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_drow_003_frost_arrow.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK, BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_drow_003_frost_arrow.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	local target = event.target
	local ability = self:GetAbility()
	if not ability or not ability:GetToggleState() then
		return
	end
	if not target or not IsValidAlive(nil, target) then
		return
	end
	local ____opt_4 = target.GetUnitType
	local targetType = ____opt_4 and ____opt_4(target)
	if targetType == UnitType.BUILDING or targetType == UnitType.DESTRUCTIBLE then
		return
	end
	local ____temp_11 = event.is_sub_attack == true
	if ____temp_11 then
		local ____opt_6 = event.extra_data
		local ____temp_10 = (____opt_6 and ____opt_6.custom_tag) == DROW_004_SUB_ATTACK_TAG
		if not ____temp_10 then
			local ____opt_8 = event.extra_data
			____temp_10 = (____opt_8 and ____opt_8.source_name) == "drow_004"
		end
		____temp_11 = ____temp_10
	end
	local from004MarkedSubAttack = ____temp_11
	local from004ExtraBuffSubAttack = event.is_sub_attack == true
		and parent:FindModifierByName("modifier_drow_004_extra_arrow") ~= nil
	if not from004MarkedSubAttack and not from004ExtraBuffSubAttack and not self:ConsumePaidAttack(event.record) then
		return
	end
	local slowDuration = self:GetSpecialValue("drow_003", "slow_duration")
	local agilityDamagePct = self:GetSpecialValue("drow_003", "agility_damage_pct")
	local fixedDamage = self:GetSpecialValue("drow_003", "fixed_damage")
	local stacksPerHit = math.floor(self:GetSpecialValue("drow_003", "stacks_per_hit"))
	AddDeBuffStatus(nil, target, parent, ability, DebuffStatusType.ICE_SLOW, {
		stack = math.max(1, stacksPerHit),
		duration = slowDuration,
		effect_name = "particles/units/heroes/hero_drow/drow_frost_arrow_debuff.vpcf",
		status_effect_name = "particles/status_fx/status_effect_drow_frost_arrow.vpcf",
	})
	____exports.modifier_drow_003_frost_chill_fx:applys(target, parent, ability, { duration = slowDuration })
	local freezeModifier = target:FindModifierByNameAndCaster("modifier_generic_slow", parent)
	local freezeStacks = math.max(freezeModifier and freezeModifier:GetStackCount() or 0, 0)
	if freezeStacks <= 0 then
		return
	end
	local agility = MyGameAttribute:GetAttribute(parent, "total_agility")
	local damage = freezeStacks * agility * agilityDamagePct / 100 + fixedDamage
	Damage:ApplyDamage({
		attacker = parent,
		victim = target,
		damage = damage,
		damage_type = 2,
		ability = ability,
	})
end
function modifier_drow_003_frost_arrow.prototype.OnAttack_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
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
	local ____opt_14 = target.GetUnitType
	local targetType = ____opt_14 and ____opt_14(target)
	if targetType == UnitType.BUILDING or targetType == UnitType.DESTRUCTIBLE then
		return
	end
	local ability = self:GetAbility()
	if not ability or not ability:GetToggleState() then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	local manaCost = ability:GetManaCost(math.max(ability:GetLevel() - 1, 0))
	if manaCost > 0 then
		if parent:GetMana() < manaCost then
			return
		end
		parent:SpendMana(manaCost, ability)
	end
	event.projectile_name = DROW_003_FROST_PROJECTILE
	self:MarkPaidAttack(event.record)
	EmitSoundOn("Hero_DrowRanger.FrostArrows", parent)
end
function modifier_drow_003_frost_arrow.prototype.MarkPaidAttack(self, record)
	if record ~= nil then
		self.paidAttackRecords:add(record)
		return
	end
	self.paidNoRecordCount = self.paidNoRecordCount + 1
end
function modifier_drow_003_frost_arrow.prototype.ConsumePaidAttack(self, record)
	if record ~= nil then
		if not self.paidAttackRecords:has(record) then
			return false
		end
		self.paidAttackRecords:delete(record)
		return true
	end
	if self.paidNoRecordCount <= 0 then
		return false
	end
	self.paidNoRecordCount = self.paidNoRecordCount - 1
	return true
end
modifier_drow_003_frost_arrow = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_drow_003_frost_arrow)
____exports.modifier_drow_003_frost_arrow = modifier_drow_003_frost_arrow
return ____exports