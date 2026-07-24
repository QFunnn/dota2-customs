--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


elf_wolf_cripple = class({})
LinkLuaModifier("modifier_elf_wolf_cripple", "creature_ability/elf_wolf_cripple", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_elf_wolf_cripple_debuff", "creature_ability/elf_wolf_cripple", LUA_MODIFIER_MOTION_NONE)
function elf_wolf_cripple:GetIntrinsicModifierName()
	return "modifier_elf_wolf_cripple"
end
---------------------------------------------------
modifier_elf_wolf_cripple = class({})
function modifier_elf_wolf_cripple:IsHidden()
	return true
end
function modifier_elf_wolf_cripple:IsPurgable()
	return false
end
function modifier_elf_wolf_cripple:IsPurgeException()
	return false
end
function modifier_elf_wolf_cripple:IsDebuff()
	return false
end
function modifier_elf_wolf_cripple:OnCreated(kv)
	self.maim_chance = self:GetAbilitySpecialValueFor("maim_chance")
	self.maim_duration = self:GetAbilitySpecialValueFor("maim_duration")
end
function modifier_elf_wolf_cripple:OnRefresh(kv)
	self.maim_chance = self:GetAbilitySpecialValueFor("maim_chance")
	self.maim_duration = self:GetAbilitySpecialValueFor("maim_duration")
end
function modifier_elf_wolf_cripple:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK
	}
end
function modifier_elf_wolf_cripple:GetModifierProcAttack_Feedback(params)
	local hParent = self:GetParent()
	if RandomFloat(0, 100) < self.maim_chance then
		if IsValid(params.target) then
			params.target:AddNewModifier(hParent, self:GetAbility(), "modifier_elf_wolf_cripple_debuff", { duration = self.maim_duration })
		end
	end
end
---------------------------------------------------
modifier_elf_wolf_cripple_debuff = class({})
function modifier_elf_wolf_cripple_debuff:IsHidden()
	return false
end
function modifier_elf_wolf_cripple_debuff:IsPurgable()
	return true
end
function modifier_elf_wolf_cripple_debuff:IsPurgeException()
	return true
end
function modifier_elf_wolf_cripple_debuff:IsDebuff()
	return true
end
function modifier_elf_wolf_cripple_debuff:OnCreated(kv)
	self.maim_movement_speed = self:GetAbilitySpecialValueFor("maim_movement_speed")
	self.maim_attack_speed = self:GetAbilitySpecialValueFor("maim_attack_speed")
	self.maim_damage = self:GetAbilitySpecialValueFor("maim_damage")
	if IsServer() then
		EmitSoundOn("DOTA_Item.Maim", self:GetParent())
		self:StartIntervalThink(1)
	end
end
function modifier_elf_wolf_cripple_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end
function modifier_elf_wolf_cripple_debuff:GetModifierMoveSpeedBonus_Percentage()
	return -self.maim_movement_speed
end
function modifier_elf_wolf_cripple_debuff:GetModifierAttackSpeedBonus_Constant()
	return -self.maim_attack_speed
end
function modifier_elf_wolf_cripple_debuff:GetEffectName()
	return "particles/items2_fx/sange_maim.vpcf"
end
function modifier_elf_wolf_cripple_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_elf_wolf_cripple_debuff:OnIntervalThink()
	local hParent = self:GetParent()
	local hCaster = self:GetCaster()

	ApplyDamage({
		victim = hParent,
		attacker = hCaster,
		damage = self.maim_damage,
		damage_type = DAMAGE_TYPE_PHYSICAL,
		ability = self:GetAbility()
	})
end
function modifier_elf_wolf_cripple_debuff:OnTooltip()
	return self.maim_damage
end