--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_drow_ranger_5=class({})

function modifier_drow_ranger_5:IsHidden() return true end
function modifier_drow_ranger_5:IsPurgable() return false end
function modifier_drow_ranger_5:IsPurgeException() return false end
function modifier_drow_ranger_5:RemoveOnDeath() return false end

function modifier_drow_ranger_5:OnCreated()
	self.targets_count = {1,2}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_drow_ranger_5:OnRefresh()
	self.targets_count = {1,2}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_drow_ranger_5:DeclareFunctions()
	return {
		 
	}
end

function modifier_drow_ranger_5:OnAttackLanded(params)
	if not IsServer() then return end
	if params.target == self:GetParent() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.no_attack_cooldown then return end

	local target_counter = 0

	local drow_ranger_marksmanship_custom = self:GetParent():FindAbilityByName("drow_ranger_marksmanship_custom")
	if drow_ranger_marksmanship_custom then
		local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), params.target:GetOrigin(), nil, 375, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false )
		for _, enemy in pairs(enemies) do
			if enemy ~= params.target then
				local projectile = "particles/units/heroes/hero_drow/drow_base_attack.vpcf"

				local drow_ranger_frost_arrows_custom = self:GetParent():FindAbilityByName("drow_ranger_frost_arrows_custom")

				local ultimate = false

				if drow_ranger_frost_arrows_custom then
					if drow_ranger_frost_arrows_custom:GetAutoCastState() and drow_ranger_frost_arrows_custom:IsFullyCastable() then
						projectile = "particles/units/heroes/hero_drow/drow_frost_arrow.vpcf"
						if RollPercentage(drow_ranger_marksmanship_custom:GetSpecialValueFor( "chance" )) then
							projectile = "particles/units/heroes/hero_drow/drow_marksmanship_frost_arrow.vpcf"
							ultimate = true
						end
					else
						if RollPercentage(drow_ranger_marksmanship_custom:GetSpecialValueFor( "chance" )) then
							projectile = "particles/units/heroes/hero_drow/drow_marksmanship_attack.vpcf"
							ultimate = true
						end
					end
				end

				local projectile_info = {
					Ability = drow_ranger_marksmanship_custom,	
					EffectName = projectile,
					iMoveSpeed = self:GetParent():GetProjectileSpeed(),
					iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,	
					bDodgeable = true,
					bIsAttack = true,
					Source = params.target,
					Target = enemy,
					ExtraData = {ultimate = ultimate, talent = true},
				}

				ProjectileManager:CreateTrackingProjectile( projectile_info )

				target_counter = target_counter + 1

				if target_counter >= self.targets_count[self:GetStackCount()] then
					break
				end
			end
		end
	end
end





