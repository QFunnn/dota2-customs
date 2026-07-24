--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("game/upgrades/generic_upgrades/modifier_base_generic_upgrade")
modifier_generic_burning_aura_upgrade = class(modifier_base_generic_upgrade)


-- made visible to give other players a hint
function modifier_generic_burning_aura_upgrade:IsHidden() return false end
function modifier_generic_burning_aura_upgrade:GetTexture() return "../items/radiance" end


function modifier_generic_burning_aura_upgrade:GetEffectName()
	return "particles/econ/events/fall_2022/radiance/radiance_owner_fall2022.vpcf"
end


function modifier_generic_burning_aura_upgrade:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end


function modifier_generic_burning_aura_upgrade:RecalculateBonusPerUpgrade()
	self.burn_damage = self:CalculateBonusPerUpgrade("burn_damage")

	self.burn_interval = self:GetUpgradeValueFor("fixed_burn_interval")
	self.burn_radius = self:GetUpgradeValueFor("fixed_burn_radius")

	if IsServer() then
		self.damage_table = {
			victim = nil,
			attacker = self:GetParent(),
			ability = self.internal_item,
			damage = self.burn_damage,
			damage_type = DAMAGE_TYPE_MAGICAL
		}
	end
end


function modifier_generic_burning_aura_upgrade:OnCreated()
	self:RecalculateBonusPerUpgrade()

	if IsServer() then
		if not self.internal_item then
			self.internal_item = CreateItem("item_burning_aura_source", self:GetParent(), nil)
			self.damage_table.ability = self.internal_item
		end
		self:StartIntervalThink(self.burn_interval)
	end
end


function modifier_generic_burning_aura_upgrade:OnRefresh(old_stack_count)
	self:RecalculateBonusPerUpgrade()
end


function modifier_generic_burning_aura_upgrade:OnIntervalThink()
	local parent = self:GetParent()
	if not IsValidEntity(parent) or not parent:IsAlive() then return end

	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		self.burn_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(enemies or {}) do
		if IsValidEntity(enemy) then
			self.damage_table.victim = enemy
			ApplyDamage(self.damage_table)
		end
	end
end


function modifier_generic_burning_aura_upgrade:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOOLTIP,
	}
end


function modifier_generic_burning_aura_upgrade:OnTooltip()
	return self.burn_damage
end