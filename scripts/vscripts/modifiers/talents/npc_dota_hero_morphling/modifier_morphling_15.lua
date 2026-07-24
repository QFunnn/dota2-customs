--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_morphling_15=class({})

function modifier_morphling_15:IsHidden() return true end
function modifier_morphling_15:IsPurgable() return false end
function modifier_morphling_15:IsPurgeException() return false end
function modifier_morphling_15:RemoveOnDeath() return false end

function modifier_morphling_15:OnCreated()
	if not IsServer() then return end
	self:GetCaster():RemoveModifierByName("modifier_morphling_replicate_custom")
	self:SetStackCount(1)
	self:Swap("morphling_waveform_custom", "morphling_waterraze1_custom")
	self:Swap("morphling_adaptive_strike_agi_custom", "morphling_waterraze2_custom")
    self:Swap("morphling_replicate_ability_slot", "morphling_waterraze3_custom")
	local morphling_waterraze1_custom = self:GetCaster():FindAbilityByName("morphling_waterraze1_custom")
	if morphling_waterraze1_custom then
		morphling_waterraze1_custom:SetLevel(self:GetStackCount())
	end
	local morphling_waterraze2_custom = self:GetCaster():FindAbilityByName("morphling_waterraze2_custom")
	if morphling_waterraze2_custom then
		morphling_waterraze2_custom:SetLevel(self:GetStackCount())
	end
	local morphling_waterraze3_custom = self:GetCaster():FindAbilityByName("morphling_waterraze3_custom")
	if morphling_waterraze3_custom then
		morphling_waterraze3_custom:SetLevel(self:GetStackCount())
        morphling_waterraze3_custom:SetHidden(false)
	end
	local morphling_morph_agi_custom = self:GetCaster():FindAbilityByName("morphling_morph_agi_custom")
	if morphling_morph_agi_custom then
		morphling_morph_agi_custom:SetHidden(true)
	end
	local morphling_morph_str_custom = self:GetCaster():FindAbilityByName("morphling_morph_str_custom")
	if morphling_morph_str_custom then
		morphling_morph_str_custom:SetHidden(true)
	end
    self:GetCaster():RemoveModifierByName("modifier_morphling_morph_agi_custom_interval")
    self:GetCaster():RemoveModifierByName("modifier_morphling_morph_str_custom_interval")
	local morphling_morph = self:GetCaster():FindAbilityByName("morphling_morph")
	if morphling_morph then
		morphling_morph:RemoveSelf()
	end
    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self:GetCaster():GetPlayerOwnerID()), "morph_stats_replicated", {value = self:GetParent():HasModifier("modifier_morphling_replicate_custom"), mod = self:GetParent():HasModifier("modifier_morphling_15")}) 
end

function modifier_morphling_15:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	local morphling_waterraze1_custom = self:GetCaster():FindAbilityByName("morphling_waterraze1_custom")
	if morphling_waterraze1_custom then
		morphling_waterraze1_custom:SetLevel(self:GetStackCount())
	end
	local morphling_waterraze2_custom = self:GetCaster():FindAbilityByName("morphling_waterraze2_custom")
	if morphling_waterraze2_custom then
		morphling_waterraze2_custom:SetLevel(self:GetStackCount())
	end
	local morphling_waterraze3_custom = self:GetCaster():FindAbilityByName("morphling_waterraze3_custom")
	if morphling_waterraze3_custom then
		morphling_waterraze3_custom:SetLevel(self:GetStackCount())
	end
end

function modifier_morphling_15:Swap(name1, name2)
	if not IsServer() then return end
	local ability1 = self:GetParent():FindAbilityByName(name1)
	local ability2 = self:GetParent():FindAbilityByName(name2)
	ability1:SetHidden(true)
	ability2:SetHidden(false)
	self:GetParent():SwapAbilities(name1, name2, false, true)
end