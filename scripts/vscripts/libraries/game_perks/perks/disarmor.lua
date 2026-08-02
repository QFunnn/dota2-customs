--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

disarmor = class(base_game_perk)

function disarmor:DeclareFunctions()
	return { MODIFIER_PROPERTY_PROCATTACK_FEEDBACK }
end

function disarmor:GetModifierProcAttack_Feedback(params)
	local target = params.target
	if not IsValidEntity(target) then
		return
	end

	if not IsValidEntity(self.parent) then
		return
	end

	if self.parent:IsIllusion() or self.parent:IsMonkeyKingSoldier() then
		return
	end
	if target:IsBuilding() or target:GetUnitName() == "npc_dota_roshan" then
		return
	end

	local modifier = target:AddNewModifier(self.parent, nil, "modifier_disarmor_perk_debuff", { duration = 0 })

	if modifier then
		modifier.armor_reduction = self.disarmor
	end
end

modifier_disarmor_perk_debuff = modifier_disarmor_perk_debuff or class({})

function modifier_disarmor_perk_debuff:IsHidden()
	return true
end
function modifier_disarmor_perk_debuff:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_disarmor_perk_debuff:DeclareFunctions()
	return { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS }
end

function modifier_disarmor_perk_debuff:GetModifierPhysicalArmorBonus()
	if IsClient() then
		return
	end

	if not self.lock and self.armor_reduction then
		local parent = self:GetParent()

		self.lock = true
		local armor = math.max(parent:GetPhysicalArmorValue(false), 0)
		self.lock = nil

		self:Destroy()

		return -math.min(self.armor_reduction, armor)
	end
end