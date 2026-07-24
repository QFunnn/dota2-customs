--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_pudge_flesh_heap_custom_active", "heroes/npc_dota_hero_pudge_custom/pudge_flesh_heap_custom", LUA_MODIFIER_MOTION_NONE)

pudge_flesh_heap_custom = class({})
pudge_flesh_heap_custom.modifier_pudge_8 = {30,60,90}
pudge_flesh_heap_custom.modifier_pudge_14 = 50

function pudge_flesh_heap_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_pudge/pudge_fleshheap_count.vpcf", context )
    PrecacheResource( "particle", "particles/pudge_fleshheap_talentstatus_effect.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_pudge/pudge_fleshheap_status_effect.vpcf", context )
end

function pudge_flesh_heap_custom:OnSpellStart()
	if not IsServer() then return end
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_pudge_flesh_heap_custom_active", {duration = self:GetSpecialValueFor("duration")})
end

modifier_pudge_flesh_heap_custom_active = class({})

function modifier_pudge_flesh_heap_custom_active:IsPurgable() return false end

function modifier_pudge_flesh_heap_custom_active:OnCreated()
	if not IsServer() then return end
	self.talent = false
	if self:GetCaster():HasModifier("modifier_pudge_14") then
		self.talent = true
		local talent = ParticleManager:CreateParticle("particles/pudge_fleshheap_talentstatus_effect.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
		self:AddParticle(talent, false, true, 10, true, false)
	else
		local talent = ParticleManager:CreateParticle("particles/units/heroes/hero_pudge/pudge_fleshheap_block_activation.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
		self:AddParticle(talent, false, true, 10, true, false)
	end
end

function modifier_pudge_flesh_heap_custom_active:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end

function modifier_pudge_flesh_heap_custom_active:GetModifierTotal_ConstantBlock(kv)
    if not IsServer() then return end
    return self:GetAbility():GetSpecialValueFor("damage_block")
end

function modifier_pudge_flesh_heap_custom_active:GetModifierAttackSpeedBonus_Constant()
	if not self:GetCaster():HasModifier("modifier_pudge_8") then return end
    return self:GetAbility().modifier_pudge_8[self:GetCaster():GetTalentLevel("modifier_pudge_8")]
end

function modifier_pudge_flesh_heap_custom_active:GetModifierTotalDamageOutgoing_Percentage()
	if not self.talent then return end
	return self:GetAbility().modifier_pudge_14
end

function modifier_pudge_flesh_heap_custom_active:GetModifierIncomingDamage_Percentage()
	if not self.talent then return end
	return self:GetAbility().modifier_pudge_14 / 5
end