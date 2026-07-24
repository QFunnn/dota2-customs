--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_abaddon_4=class({})

function modifier_abaddon_4:IsHidden() return false end
function modifier_abaddon_4:IsPurgable() return false end
function modifier_abaddon_4:IsPurgeException() return false end
function modifier_abaddon_4:RemoveOnDeath() return false end
function modifier_abaddon_4:GetTexture() return "abaddon_4" end
function modifier_abaddon_4:OnCreated()
    self.bonus = {5,7.5,10}
	if not IsServer() then return end
	self:SetStackCount(1)
    local abaddon_aphotic_shield_custom = self:GetCaster():FindAbilityByName("abaddon_aphotic_shield_custom")
    if abaddon_aphotic_shield_custom then
        abaddon_aphotic_shield_custom:SetLevel(0)
        abaddon_aphotic_shield_custom:SetHidden(true)
    end
    self:GetParent():RemoveModifierByName("modifier_abaddon_aphotic_shield_custom")
    self:GetParent():RemoveModifierByName("modifier_abaddon_aphotic_shield_custom_handler")
end

function modifier_abaddon_4:OnRefresh()
    self.bonus = {5,7.5,10}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_abaddon_4:OnTakeDamage(params)
	if not IsServer() then return end
	local attacker = params.attacker
	local target = params.unit
	local original_damage = params.original_damage
	local damage_type = params.damage_type
	local damage_flags = params.damage_flags
	if params.unit == self:GetParent() and not params.attacker:IsBuilding() and params.attacker:GetTeamNumber() ~= self:GetParent():GetTeamNumber() and bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) ~= DOTA_DAMAGE_FLAG_HPLOSS and bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) ~= DOTA_DAMAGE_FLAG_REFLECTION and not attacker:IsMagicImmune() then	
		if not params.unit:IsOther() then
			EmitSoundOnClient("DOTA_Item.BladeMail.Damage", params.attacker:GetPlayerOwner())
			ApplyDamage({ victim = params.attacker, damage = params.original_damage / 100 * self.bonus[self:GetStackCount()], damage_type = params.damage_type, damage_flags = DOTA_DAMAGE_FLAG_REFLECTION + DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, attacker = self:GetParent(), ability = nil })
		end
	end
end