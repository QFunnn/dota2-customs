--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


night_stalker_blood = class({})
LinkLuaModifier(
	"modifier_night_stalker_blood",
	"heroes/hero_night_stalker/night_stalker_blood/night_stalker_blood",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_night_stalker_blood_effect",
	"heroes/hero_night_stalker/night_stalker_blood/night_stalker_blood",
	LUA_MODIFIER_MOTION_NONE
)

function night_stalker_blood:GetIntrinsicModifierName()
	return "modifier_night_stalker_blood"
end
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------

modifier_night_stalker_blood = class({})

function modifier_night_stalker_blood:IsHidden()
	return true
end

function modifier_night_stalker_blood:IsPurgable()
	return false
end

function modifier_night_stalker_blood:OnCreated(kv)
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
end

function modifier_night_stalker_blood:OnRefresh(kv)
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
end

function modifier_night_stalker_blood:OnDestroy(kv) end

function modifier_night_stalker_blood:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
	return funcs
end

function modifier_night_stalker_blood:GetModifierProcAttack_Feedback(params)
	if IsServer() then
		params.target:AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_night_stalker_blood_effect",
			{ duration = self.duration }
		)
	end
end

--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

modifier_night_stalker_blood_effect = class({})

function modifier_night_stalker_blood_effect:IsHidden()
	return false
end

function modifier_night_stalker_blood_effect:IsDebuff()
	return true
end

function modifier_night_stalker_blood_effect:IsStunDebuff()
	return false
end

function modifier_night_stalker_blood_effect:IsPurgable()
	return true
end

function modifier_night_stalker_blood_effect:OnCreated(kv)
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
	self:StartIntervalThink(0.1)
end

function modifier_night_stalker_blood_effect:OnRefresh(kv)
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
	if self:GetCaster():FindAbilityByName("npc_dota_night_stalker_int1") ~= nil then
		if self:GetCaster():FindAbilityByName("npc_dota_night_stalker_int1"):GetLevel() > 0 then
			self.damage = self:GetAbility():GetSpecialValueFor("damage") * 2
		end
	end
end

function modifier_night_stalker_blood_effect:OnIntervalThink()
	self:OnRefresh()
	if not IsServer() then
		return
	end

	self:GetCaster():Heal(self.damage, self:GetCaster())
	SendOverheadEventMessage(self:GetCaster():GetPlayerOwner(), OVERHEAD_ALERT_HEAL, self:GetCaster(), self.damage, nil)
	SendOverheadEventMessage(
		self:GetParent():GetPlayerOwner(),
		OVERHEAD_ALERT_DAMAGE,
		self:GetParent(),
		self.damage,
		nil
	)

	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(),
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
	}
	ApplyDamage(self.damageTable)
end

function modifier_night_stalker_blood_effect:GetEffectName()
	return "particles/units/heroes/hero_bloodseeker/blood_gore_arterial_drip_2.vpcf"
end

function modifier_night_stalker_blood_effect:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end