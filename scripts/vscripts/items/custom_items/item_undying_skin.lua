--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_undying_skin", "items/custom_items/item_undying_skin.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_item_undying_skin_debuff",
	"items/custom_items/item_undying_skin.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_undying_skin_debuff_slow",
	"items/custom_items/item_undying_skin.lua",
	LUA_MODIFIER_MOTION_NONE
)

item_undying_skin = class({})

function item_undying_skin:GetIntrinsicModifierName()
	return "modifier_item_undying_skin"
end

--------------------------------------

modifier_item_undying_skin = class({})

function modifier_item_undying_skin:IsHidden()
	return true
end

function modifier_item_undying_skin:IsDebuff()
	return false
end

function modifier_item_undying_skin:IsPurgable()
	return false
end

function modifier_item_undying_skin:OnCreated(kv)
	if IsServer() then
		self.duration = self:GetAbility():GetSpecialValueFor("duration")
	end
end

function modifier_item_undying_skin:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_EVENT_ON_ATTACK_START,
	}
	return funcs
end

function modifier_item_undying_skin:OnAttackStart(params)
	if IsServer() then
		if params.target ~= self:GetParent() then
			return
		end
		if params.attacker:IsMagicImmune() then
			return
		end
		if self:GetParent():PassivesDisabled() then
			return
		end
		if params.attacker:HasModifier("modifier_item_undying_skin_debuff") then
			params.attacker:AddNewModifier(
				self:GetParent(), -- player source
				self:GetAbility(), -- ability source
				"modifier_item_undying_skin_debuff_slow", -- modifier name
				{} -- kv
			)
		end
	end
end

function modifier_item_undying_skin:OnDeath(params)
	if self:GetParent() == params.unit then
		UTIL_Remove(self:GetAbility())
	end
end

function modifier_item_undying_skin:OnTakeDamage(params)
	if not IsServer() then
		return
	end
	if params.unit ~= self:GetParent() then
		return
	end
	if self:GetParent():PassivesDisabled() then
		return
	end
	if params.attacker:GetTeamNumber() == self:GetParent():GetTeamNumber() then
		return
	end

	params.attacker:AddNewModifier(
		self:GetParent(), -- player source
		self:GetAbility(), -- ability source
		"modifier_item_undying_skin_debuff", -- modifier name
		{ duration = self.duration } -- kv
	)
	-- EmitSoundOn( "hero_viper.CorrosiveSkin", params.attacker )
end

-----------------------------------------------

modifier_item_undying_skin_debuff = class({})

function modifier_item_undying_skin_debuff:IsHidden()
	return true
end

function modifier_item_undying_skin_debuff:IsDebuff()
	return true
end

function modifier_item_undying_skin_debuff:IsStunDebuff()
	return false
end

function modifier_item_undying_skin_debuff:IsPurgable()
	return true
end

function modifier_item_undying_skin_debuff:OnCreated(kv)
	self.hp_regen = -self:GetAbility():GetSpecialValueFor("hp_regen")
	if not IsServer() then
		return
	end
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self:GetAbility():GetSpecialValueFor("damage"),
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(), --Optional.
		damage_flags = DOTA_DAMAGE_FLAG_REFLECTION + DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN, --Optional.
	}
	self:StartIntervalThink(1)
end

function modifier_item_undying_skin_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	}
	return funcs
end

function modifier_item_undying_skin_debuff:GetModifierHPRegenAmplify_Percentage()
	return self.hp_regen
end

function modifier_item_undying_skin_debuff:OnIntervalThink()
	ApplyDamage(self.damageTable)
end

function modifier_item_undying_skin_debuff:GetEffectName()
	return "particles/units/heroes/hero_viper/viper_corrosive_debuff.vpcf"
end

function modifier_item_undying_skin_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

----------------------------------------------

modifier_item_undying_skin_debuff_slow = class({})

function modifier_item_undying_skin_debuff_slow:IsHidden()
	return true
end

function modifier_item_undying_skin_debuff_slow:IsDebuff()
	return true
end

function modifier_item_undying_skin_debuff_slow:IsStunDebuff()
	return false
end

function modifier_item_undying_skin_debuff_slow:IsPurgable()
	return true
end

function modifier_item_undying_skin_debuff_slow:OnCreated(kv)
	self.slow = -self:GetAbility():GetSpecialValueFor("slow_attack_speed")
	self.duration = 1
end

function modifier_item_undying_skin_debuff_slow:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PRE_ATTACK,
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ATTACK_FINISHED,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
	return funcs
end

function modifier_item_undying_skin_debuff_slow:GetModifierPreAttack(params)
	if IsServer() then
		if not self.HasAttacked then
			self.record = params.record
		end
		if params.target ~= self:GetCaster() then
			self.attackOther = true
		end
	end
end

function modifier_item_undying_skin_debuff_slow:OnAttack(params)
	if IsServer() then
		if params.record ~= self.record then
			return
		end
		self:SetDuration(self.duration, true)
		self.HasAttacked = true
	end
end

function modifier_item_undying_skin_debuff_slow:OnAttackFinished(params)
	if IsServer() then
		if params.attacker ~= self:GetParent() then
			return
		end
		if not self.HasAttacked then
			self:Destroy()
		end
		if self.attackOther then
			self:Destroy()
		end
	end
end

function modifier_item_undying_skin_debuff_slow:GetModifierAttackSpeedBonus_Constant()
	if IsServer() then
		if self:GetParent():GetAggroTarget() == self:GetCaster() then
			return self.slow
		else
			return 0
		end
	end
	return self.slow
end