--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_slark_essence_shift_custom",
	"heroes/hero_slark/slark_essence_shift_custom/slark_essence_shift_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_slark_essence_shift_custom_debuff",
	"heroes/hero_slark/slark_essence_shift_custom/slark_essence_shift_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_slark_essence_shift_custom_debuff_stack",
	"heroes/hero_slark/slark_essence_shift_custom/slark_essence_shift_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_slark_essence_shift_custom_stack",
	"heroes/hero_slark/slark_essence_shift_custom/slark_essence_shift_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_slark_essence_shift_custom_buff",
	"heroes/hero_slark/slark_essence_shift_custom/slark_essence_shift_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_slark_essence_shift_custom_permanent_debuff",
	"heroes/hero_slark/slark_essence_shift_custom/slark_essence_shift_custom",
	LUA_MODIFIER_MOTION_NONE
)

slark_essence_shift_custom = class({})

function slark_essence_shift_custom:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_slark/slark_essence_shift.vpcf", context)
end

function slark_essence_shift_custom:GetIntrinsicModifierName()
	return "modifier_slark_essence_shift_custom"
end

modifier_slark_essence_shift_custom = class({})
function modifier_slark_essence_shift_custom:IsHidden()
	return self:GetStackCount() == 0
end
function modifier_slark_essence_shift_custom:IsPurgable()
	return false
end
function modifier_slark_essence_shift_custom:IsPurgeException()
	return false
end
function modifier_slark_essence_shift_custom:RemoveOnDeath()
	return false
end

function modifier_slark_essence_shift_custom:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	}
	return funcs
end

function modifier_slark_essence_shift_custom:GetModifierProcAttack_Feedback(params)
	if IsServer() and (not self:GetParent():PassivesDisabled()) then
		local target = params.target
		self:AttackTarget(params.target)
		if not params.no_attack_cooldown then
			self:PlayEffects(params.target)
		end
	end
end

function modifier_slark_essence_shift_custom:AttackTarget(target, pounce)
	if not IsServer() then
		return
	end
	local duration = self:GetAbility():GetSpecialValueFor("duration")
	target:AddNewModifier(
		self:GetParent(),
		self:GetAbility(),
		"modifier_slark_essence_shift_custom_permanent_debuff",
		{}
	)
	self:GetCaster():AddNewModifier(
		self:GetCaster(),
		self:GetAbility(),
		"modifier_slark_essence_shift_custom_stack",
		{ duration = duration }
	)
	self:GetCaster():AddNewModifier(
		self:GetCaster(),
		self:GetAbility(),
		"modifier_slark_essence_shift_custom_buff",
		{ duration = duration }
	)
	target:AddNewModifier(
		self:GetParent(),
		self:GetAbility(),
		"modifier_slark_essence_shift_custom_debuff_stack",
		{ duration = duration }
	)
	target:AddNewModifier(
		self:GetParent(),
		self:GetAbility(),
		"modifier_slark_essence_shift_custom_debuff",
		{ duration = duration }
	)
	target:CalculateStatBonus(true)
end

function modifier_slark_essence_shift_custom:GetModifierBonusStats_Agility()
	return self:GetStackCount()
end

function modifier_slark_essence_shift_custom:PlayEffects(target)
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_slark/slark_essence_shift.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target
	)
	ParticleManager:SetParticleControl(effect_cast, 1, self:GetParent():GetOrigin() + Vector(0, 0, 64))
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

modifier_slark_essence_shift_custom_debuff_stack = class({})
function modifier_slark_essence_shift_custom_debuff_stack:IsPurgable()
	return false
end
function modifier_slark_essence_shift_custom_debuff_stack:IsPurgeException()
	return false
end
function modifier_slark_essence_shift_custom_debuff_stack:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_slark_essence_shift_custom_debuff_stack:IsHidden()
	return true
end

modifier_slark_essence_shift_custom_stack = class({})
function modifier_slark_essence_shift_custom_stack:IsPurgable()
	return false
end
function modifier_slark_essence_shift_custom_stack:IsPurgeException()
	return false
end
function modifier_slark_essence_shift_custom_stack:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_slark_essence_shift_custom_stack:IsHidden()
	return true
end

modifier_slark_essence_shift_custom_debuff = class({})
function modifier_slark_essence_shift_custom_debuff:IsPurgable()
	return false
end
function modifier_slark_essence_shift_custom_debuff:IsPurgeException()
	return false
end
function modifier_slark_essence_shift_custom_debuff:IsHidden()
	return false
end
function modifier_slark_essence_shift_custom_debuff:OnCreated()
	if not IsServer() then
		return
	end
	self:StartIntervalThink(FrameTime())
end

function modifier_slark_essence_shift_custom_debuff:OnIntervalThink()
	if not IsServer() then
		return
	end
	local modifier_slark_essence_shift_custom_debuff_stack =
		self:GetParent():FindAllModifiersByName("modifier_slark_essence_shift_custom_debuff_stack")
	self:SetStackCount(#modifier_slark_essence_shift_custom_debuff_stack)
end

function modifier_slark_essence_shift_custom_debuff:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_slark_essence_shift_custom_debuff:OnTooltip()
	return self:GetStackCount()
end

function modifier_slark_essence_shift_custom_debuff:GetModifierBonusStats_Strength()
	if self:GetStackCount() == 0 then
		return
	end
	return self:GetStackCount() * -1
end

function modifier_slark_essence_shift_custom_debuff:GetModifierBonusStats_Agility()
	if self:GetStackCount() == 0 then
		return
	end
	return self:GetStackCount() * -1
end

function modifier_slark_essence_shift_custom_debuff:GetModifierBonusStats_Intellect()
	if self:GetStackCount() == 0 then
		return
	end
	return self:GetStackCount() * -1
end

function modifier_slark_essence_shift_custom_debuff:OnDeath(params)
	local target = params.unit
	if self:GetCaster():GetTeamNumber() == target:GetTeamNumber() then
		return
	end
	if target:IsReincarnating() then
		return
	end
	if not self:GetCaster():IsRealHero() then
		return
	end
	if not target:IsRealHero() then
		return
	end
	if not target:HasModifier("modifier_slark_essence_shift_custom_debuff") then
		return
	end
	if
		((self:GetCaster():GetAbsOrigin() - target:GetAbsOrigin()):Length2D() <= 300)
		or (params.attacker and params.attacker == self:GetCaster())
	then
		local modifier_slark_essence_shift_custom = self:GetCaster()
			:FindModifierByName("modifier_slark_essence_shift_custom")
		if modifier_slark_essence_shift_custom then
			modifier_slark_essence_shift_custom:IncrementStackCount()
		end
		local modifier_slark_essence_shift_custom_permanent_debuff =
			target:FindModifierByName("modifier_slark_essence_shift_custom_permanent_debuff")
		if modifier_slark_essence_shift_custom_permanent_debuff then
			modifier_slark_essence_shift_custom_permanent_debuff:IncrementStackCount()
		end
	end
end

modifier_slark_essence_shift_custom_buff = class({})
function modifier_slark_essence_shift_custom_buff:IsPurgable()
	return false
end
function modifier_slark_essence_shift_custom_buff:IsPurgeException()
	return false
end

function modifier_slark_essence_shift_custom_buff:OnCreated()
	if not IsServer() then
		return
	end
	self:StartIntervalThink(FrameTime())
end

function modifier_slark_essence_shift_custom_buff:OnIntervalThink()
	if not IsServer() then
		return
	end
	local modifier_slark_essence_shift_custom_stack =
		self:GetParent():FindAllModifiersByName("modifier_slark_essence_shift_custom_stack")
	self:SetStackCount(#modifier_slark_essence_shift_custom_stack)
end

function modifier_slark_essence_shift_custom_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	}
end

function modifier_slark_essence_shift_custom_buff:GetModifierBonusStats_Agility()
	return self:GetStackCount() * self:GetAbility():GetSpecialValueFor("agi_gain")
end

modifier_slark_essence_shift_custom_permanent_debuff = class({})
function modifier_slark_essence_shift_custom_permanent_debuff:IsPurgable()
	return false
end
function modifier_slark_essence_shift_custom_permanent_debuff:IsPurgeException()
	return false
end
function modifier_slark_essence_shift_custom_permanent_debuff:IsHidden()
	return true
end
function modifier_slark_essence_shift_custom_permanent_debuff:RemoveOnDeath()
	return false
end

function modifier_slark_essence_shift_custom_permanent_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	}
end

function modifier_slark_essence_shift_custom_permanent_debuff:GetModifierBonusStats_Agility()
	if self:GetStackCount() == 0 then
		return
	end
	return self:GetStackCount() * -1
end