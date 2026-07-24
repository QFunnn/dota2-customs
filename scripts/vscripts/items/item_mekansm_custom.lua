--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_mekansm_custom = class({})

function item_mekansm_custom:GetIntrinsicModifierName()
	return "modifier_item_mekansm"
end

function item_mekansm_custom:OnSpellStart()
	if not IsServer() then return end
	
	self:GetCaster():EmitSound("DOTA_Item.Mekansm.Activate")

	local mekansm_pfx = ParticleManager:CreateParticle("particles/items2_fx/mekanism.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:ReleaseParticleIndex(mekansm_pfx)

	local heroes = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, self:GetSpecialValueFor("heal_radius"), DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, 0, false )
    for _, hero in pairs(heroes) do
    	if not hero:HasModifier("modifier_item_mekansm_noheal") then
    		local heal_amount = hero:GetMaxHealth() / 100 * self:GetSpecialValueFor("heal_amount")
			SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, hero, heal_amount, nil)
			hero:Heal(heal_amount, self)
			hero:EmitSound("DOTA_Item.Mekansm.Target")
			local mekansm_target_pfx = ParticleManager:CreateParticle("particles/items2_fx/mekanism_recipient.vpcf", PATTACH_ABSORIGIN_FOLLOW, hero)
			ParticleManager:SetParticleControl(mekansm_target_pfx, 0, self:GetCaster():GetAbsOrigin())
			ParticleManager:SetParticleControl(mekansm_target_pfx, 1, hero:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(mekansm_target_pfx)
			hero:AddNewModifier(self:GetCaster(), self, "modifier_item_mekansm_noheal", {duration = 50})
		end
    end
end