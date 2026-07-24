--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_terrorblade_conjure_image_custom", "heroes/npc_dota_hero_terrorblade_custom/terrorblade_conjure_image_custom", LUA_MODIFIER_MOTION_NONE)

terrorblade_conjure_image_custom = class({})

terrorblade_conjure_image_custom.modifier_terrorblade_8 = {50,100}
terrorblade_conjure_image_custom.modifier_terrorblade_9 = {5,10}
terrorblade_conjure_image_custom.modifier_terrorblade_12 = {7.5,15}


function terrorblade_conjure_image_custom:GetBehavior()
	if self:GetCaster():HasModifier("modifier_terrorblade_9") then
		return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
	end
	return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function terrorblade_conjure_image_custom:OnSpellStart()
	if not IsServer() then return end

	local illusion_duration = self:GetSpecialValueFor("illusion_duration")
	local illusion_outgoing_damage = self:GetSpecialValueFor("illusion_outgoing_damage") - 100
	local illusion_incoming_damage = self:GetSpecialValueFor("illusion_incoming_damage") - 100

	if self:GetCaster():HasModifier("modifier_terrorblade_8") then
		illusion_incoming_damage = illusion_incoming_damage - self.modifier_terrorblade_8[self:GetCaster():GetTalentLevel("modifier_terrorblade_8")]
	end

	if self:GetCaster():HasModifier("modifier_terrorblade_9") then
		illusion_duration = illusion_duration + self.modifier_terrorblade_9[self:GetCaster():GetTalentLevel("modifier_terrorblade_9")]
	end

	if self:GetCaster():HasModifier("modifier_terrorblade_12") then
		illusion_outgoing_damage = illusion_outgoing_damage + self.modifier_terrorblade_12[self:GetCaster():GetTalentLevel("modifier_terrorblade_12")]
	end

	local illusions = CreateIllusions(self:GetCaster(), self:GetCaster(), { outgoing_damage = illusion_outgoing_damage, incoming_damage	= illusion_incoming_damage, bounty_base	= nil, bounty_growth = nil, outgoing_damage_structure = nil, outgoing_damage_roshan = nil, duration = illusion_duration }, 1, 108, false, true)

	for _, illusion in pairs(illusions) do
        illusion:AddNewModifier(self:GetCaster(), self, "modifier_terrorblade_conjure_image_custom", {})
        illusion:AddNewModifier(self:GetCaster(), self, "modifier_terrorblade_conjureimage", {})
		self:GetCaster():EmitSound("Hero_Terrorblade.ConjureImage")
		illusion:StartGesture(ACT_DOTA_CAST_ABILITY_3_END)
	end
end


modifier_terrorblade_conjure_image_custom = class({})
function modifier_terrorblade_conjure_image_custom:IsPurgable() return false end
function modifier_terrorblade_conjure_image_custom:IsHidden() return true end
function modifier_terrorblade_conjure_image_custom:GetStatusEffectName() return "particles/status_fx/status_effect_terrorblade_reflection.vpcf" end
function modifier_terrorblade_conjure_image_custom:StatusEffectPriority() return 10000000 end
function modifier_terrorblade_conjure_image_custom:GetModifierModelScale() return 30 end
function modifier_terrorblade_conjure_image_custom:GetModelScale() return 2 end