--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_spear_of_mordiggian", "items/item_spear_of_mordiggian", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_spear_of_mordiggian_active", "items/item_spear_of_mordiggian", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_spear_of_mordiggian_cooldown", "items/item_spear_of_mordiggian", LUA_MODIFIER_MOTION_NONE)

item_spear_of_mordiggian = class({})

function item_spear_of_mordiggian:GetIntrinsicModifierName()
	return "modifier_item_spear_of_mordiggian"
end

function item_spear_of_mordiggian:OnSpellStart()
	if not IsServer() then return end
	if self:GetCaster():HasModifier("modifier_item_spear_of_mordiggian_cooldown") then return end
    for i=0, 5 do
        local item = self:GetCaster():GetItemInSlot(i)
        if item and (item:GetAbilityName() == "item_armlet" and item:GetToggleState()) then
            item:ToggleAbility()
        end
    end
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_spear_of_mordiggian_cooldown", {duration = 0.036})
	if self:GetCaster():HasModifier("modifier_item_spear_of_mordiggian_active") then
		self:GetCaster():EmitSound("DOTA_Item.Armlet.Activate")
		self:GetCaster():RemoveModifierByName("modifier_item_spear_of_mordiggian_active")
	else
		self:GetCaster():EmitSound("DOTA_Item.Armlet.DeActivate")
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_spear_of_mordiggian_active", {})
	end
end

function item_spear_of_mordiggian:GetAbilityTextureName()
	if self:GetCaster():HasModifier("modifier_item_spear_of_mordiggian_active") then
		return "spear_of_mordiggian_1"
	else
		return "item_spear_of_mordiggian"
	end
end

modifier_item_spear_of_mordiggian_cooldown = class({})
function modifier_item_spear_of_mordiggian_cooldown:IsHidden() return true end
function modifier_item_spear_of_mordiggian_cooldown:IsPurgable() return false end

modifier_item_spear_of_mordiggian = class({})

function modifier_item_spear_of_mordiggian:IsHidden()			return true end
function modifier_item_spear_of_mordiggian:IsPurgable() return false end
function modifier_item_spear_of_mordiggian:IsPurgeException() return false end

function modifier_item_spear_of_mordiggian:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
	}
end

function modifier_item_spear_of_mordiggian:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("bonus_damage") 
end

function modifier_item_spear_of_mordiggian:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_attack_speed") 
end

function modifier_item_spear_of_mordiggian:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_armor") 
end

function modifier_item_spear_of_mordiggian:GetModifierConstantHealthRegen()
	return self:GetAbility():GetSpecialValueFor("health_regen")
end

function modifier_item_spear_of_mordiggian:GetModifierAttackRangeBonus()
	if self:GetParent():IsRangedAttacker() and not self:GetParent():HasModifier("modifier_vengefulspirit_retribution") then return 0 end
	return self:GetAbility():GetSpecialValueFor("bonus_attack_range") 
end

modifier_item_spear_of_mordiggian_active = class({})

function modifier_item_spear_of_mordiggian_active:IsDebuff() return false end
function modifier_item_spear_of_mordiggian_active:IsPurgable() return false end
function modifier_item_spear_of_mordiggian_active:GetTexture() return "spear_of_mordiggian_1" end


function modifier_item_spear_of_mordiggian_active:GetEffectName()
	return "particles/items_fx/armlet.vpcf"
end

function modifier_item_spear_of_mordiggian_active:OnCreated()
	if not self:GetAbility() then self:Destroy() return end
	
	self.unholy_bonus_strength	= self:GetAbility():GetSpecialValueFor("unholy_bonus_strength")
	self.unholy_health_drain	= self:GetAbility():GetSpecialValueFor("unhole_damage_caster") * 0.11
	self.health_per_stack		= self:GetAbility():GetSpecialValueFor("health_per_stack")
	
	self.strength = 0
	self.armor = 0
	self.strength_think = self:GetAbility():GetSpecialValueFor("unholy_bonus_strength") / 6
	self.critProc = false
	self.timer = 0
	if not IsServer() then return end
	self:StartIntervalThink(0.1)
end

function modifier_item_spear_of_mordiggian_active:GetHealingDisable(parent)
    for _, mod in pairs(self:GetParent():FindAllModifiers()) do
        if mod and mod.GetDisableHealing and mod:GetDisableHealing() then
            return true
        end
    end
    return false
end

function modifier_item_spear_of_mordiggian_active:OnIntervalThink()
    local modifier_item_armlet_unholy_strength = self:GetParent():FindModifierByName("modifier_item_armlet_unholy_strength")
    if modifier_item_armlet_unholy_strength then
        self:Destroy()
        return
    end
	if not self:GetParent():HasModifier("modifier_item_spear_of_mordiggian") then
		self:Destroy()
		return
	end
	if self.timer < 0.6 then
		self.timer = self.timer + 0.1
		self.strength = self.strength + self.strength_think
		if self.strength >= self.unholy_bonus_strength then
			self.strength = self.unholy_bonus_strength
		end
        local modify_health_check = self:GetParent():GetHealth()
		self:GetCaster():CalculateStatBonus(true)
        modify_health_check = self:GetParent():GetHealth() - modify_health_check
        if not self:GetHealingDisable(self:GetParent()) then
            self:GetParent():SetHealth(self:GetParent():GetHealth() + ((22*self.strength_think) - modify_health_check))
        end
		return
	end
    self:StartIntervalThink(.11)
    if self:GetParent():IsIllusion() then return end
    self:GetParent():ModifyHealth(math.max(1, self:GetParent():GetHealth() - self.unholy_health_drain), self:GetAbility(), false, DOTA_DAMAGE_FLAG_NON_LETHAL + DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION + DOTA_DAMAGE_FLAG_HPLOSS)
end

function modifier_item_spear_of_mordiggian_active:OnRemoved()
    if not IsServer() then return end
    local modify_health_check = self:GetParent():GetHealth()
    self:GetCaster():CalculateStatBonus(true)
    modify_health_check = modify_health_check - self:GetParent():GetHealth()
    self:GetParent():SetHealth(math.max(self:GetParent():GetHealth() - ((22*self.strength) - modify_health_check), 1))
end

function modifier_item_spear_of_mordiggian_active:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_EVENT_ON_ATTACK_RECORD,
        MODIFIER_PROPERTY_SLOW_RESISTANCE 
	}
end

function modifier_item_spear_of_mordiggian_active:GetModifierBonusStats_Strength()
	return self.strength
end

function modifier_item_spear_of_mordiggian_active:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("unholy_bonus_damage")
end

function modifier_item_spear_of_mordiggian_active:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("unholy_bonus_armor")
end

function modifier_item_spear_of_mordiggian_active:GetModifierSlowResistance()
	return self:GetAbility():GetSpecialValueFor("unholy_bonus_slow_resistance")
end

function modifier_item_spear_of_mordiggian_active:OnAttackRecord(keys)
	if keys.attacker == self:GetParent() then
		if keys.target:IsOther() then
            return nil
        end
		self.critProc = true
		self.chance = self:GetAbility():GetSpecialValueFor("unholy_chance")
        if RollPercentage(100 - self.chance) then
        	self.critProc = false
        end
	end
end

function modifier_item_spear_of_mordiggian_active:OnAttackLanded(keys)
    if keys.attacker == self:GetParent() then
        if self:GetParent():IsIllusion() then return end
        if self.critProc then
        	local damage = self:GetAbility():GetSpecialValueFor("unholy_bonus_damage_active")
            ApplyDamage({victim = keys.target, attacker = self:GetParent(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
            keys.target:EmitSound("DOTA_Item.MKB.melee")
            keys.target:EmitSound("DOTA_Item.MKB.Minibash")
            SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, keys.target, damage, nil)
        end
    end
end

function modifier_item_spear_of_mordiggian_active:CheckState()
	local state = {}
	if self.critProc then
		state = {[MODIFIER_STATE_CANNOT_MISS] = true}
	end
	return state
end