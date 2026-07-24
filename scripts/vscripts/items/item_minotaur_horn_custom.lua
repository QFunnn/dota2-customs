--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_minotaur_horn_custom", "items/item_minotaur_horn_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_minotaur_horn_custom_buff", "items/item_minotaur_horn_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_minotaur_horn_custom_buff_immune", "items/item_minotaur_horn_custom", LUA_MODIFIER_MOTION_NONE)

item_minotaur_horn_custom = class({})

function item_minotaur_horn_custom:GetIntrinsicModifierName()
	return "modifier_item_minotaur_horn_custom"
end

function item_minotaur_horn_custom:OnSpellStart()
	if not IsServer() then return end
	self:GetCaster():EmitSound("DOTA_Item.MinotaurHorn.Cast")
	local duration = self:GetSpecialValueFor("duration")
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_minotaur_horn_custom_buff_immune", {duration = duration})
	self:GetCaster():Purge(false, true, false, false, false)
end

modifier_item_minotaur_horn_custom = class({})

function modifier_item_minotaur_horn_custom:IsHidden() return true end

function modifier_item_minotaur_horn_custom:IsPurgable() return false end
function modifier_item_minotaur_horn_custom:IsPurgeException() return false end

function modifier_item_minotaur_horn_custom:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(FrameTime())
end

function modifier_item_minotaur_horn_custom:OnIntervalThink()
	if not IsServer() then return end
	local health = self:GetParent():GetHealthPercent()
	local max = self:GetAbility():GetSpecialValueFor("health_pct")
	if health <= max then
		if not self:GetParent():HasModifier("modifier_item_minotaur_horn_custom_buff") then
			self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_item_minotaur_horn_custom_buff", {})
		end
	end
end

modifier_item_minotaur_horn_custom_buff = class({})

function modifier_item_minotaur_horn_custom_buff:IsPurgable() return false end

function modifier_item_minotaur_horn_custom_buff:OnCreated()
	self.bonus_strength = self:GetAbility():GetSpecialValueFor("bonus_strength")
	self.max = self:GetAbility():GetSpecialValueFor("health_pct")
	if not IsServer() then return end
	self:StartIntervalThink(FrameTime())
end

function modifier_item_minotaur_horn_custom_buff:OnIntervalThink()
	if not IsServer() then return end
	
	if self:GetParent():GetHealthPercent() > self.max then
		self:Destroy()
	end

	if not self:GetParent():HasModifier("modifier_item_minotaur_horn_custom") then
		self:Destroy()
	end
end

function modifier_item_minotaur_horn_custom_buff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	}
end

function modifier_item_minotaur_horn_custom_buff:GetModifierBonusStats_Strength()
	return self.bonus_strength
end


modifier_item_minotaur_horn_custom_buff_immune = class({})
function modifier_item_minotaur_horn_custom_buff_immune:IsPurgable() return false end

function modifier_item_minotaur_horn_custom_buff_immune:GetEffectName()
    return "particles/items_fx/black_king_bar_avatar.vpcf"
end

function modifier_item_minotaur_horn_custom_buff_immune:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_item_minotaur_horn_custom_buff_immune:CheckState()
    return 
    {
        [MODIFIER_STATE_DEBUFF_IMMUNE] = true
    }
end

function modifier_item_minotaur_horn_custom_buff_immune:GetStatusEffectName()
    return "particles/status_fx/status_effect_avatar.vpcf"
end

function modifier_item_minotaur_horn_custom_buff_immune:StatusEffectPriority()
    return 99999
end

function modifier_item_minotaur_horn_custom_buff_immune:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE
    }
end

function modifier_item_minotaur_horn_custom_buff_immune:GetAbsoluteNoDamagePure(params)
    if IsServer() then
        if params.inflictor then
            if bit.band(params.inflictor:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
                return 0
            end
        end
        return 1
    end
end

function modifier_item_minotaur_horn_custom_buff_immune:GetModifierMagicalResistanceBonus(params)
    if IsClient() then 
        return 65
    end
    if IsServer() then
        if params.inflictor then 
            if bit.band(params.inflictor:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
                return 0
            end
        end
        return 65
    end
end