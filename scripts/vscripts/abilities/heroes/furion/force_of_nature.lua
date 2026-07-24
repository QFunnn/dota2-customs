--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


furion_force_of_nature_custom = furion_force_of_nature_custom or class({})
LinkLuaModifier("modifier_force_of_nature_treant_lua", "abilities/heroes/furion/force_of_nature", LUA_MODIFIER_MOTION_NONE)


function furion_force_of_nature_custom:GetAOERadius()
	return self:GetSpecialValueFor("area_of_effect")
end


function furion_force_of_nature_custom:OnAbilityPhaseStart()
	self.position = self:GetCursorPosition()
	self.aoe = self:GetSpecialValueFor("area_of_effect")
	self.trees = GridNav:GetAllTreesAroundPoint(self.position, self.aoe, false)
	self.caster = self:GetCaster()
	if not self.caster or self.caster:IsNull() then return end

	if #self.trees == 0 then
		DisplayError(self.caster:GetPlayerID(), "dota_hud_error_cant_cast_on_non_tree")
		return false
	end

	return true
end

function furion_force_of_nature_custom:OnSpellStart()
	if not IsServer() then return end

	local treant_count = self:GetSpecialValueFor("treant_count")
	local duration = self:GetSpecialValueFor("duration")
	local treant_hp = self:GetSpecialValueFor("treant_hp")
	local treant_damage = self:GetSpecialValueFor("treant_damage")

	local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_furion/furion_force_of_nature_cast.vpcf", PATTACH_CUSTOMORIGIN, self.caster )
	ParticleManager:SetParticleControlEnt( particle, 0, self.caster, PATTACH_POINT_FOLLOW, "attach_staff_base", self.caster:GetOrigin(), true )
	ParticleManager:SetParticleControl( particle, 1, self.position )
	ParticleManager:SetParticleControl( particle, 2, Vector( self.aoe, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( particle )

	GridNav:DestroyTreesAroundPoint(self.position, self.aoe, false)
	EmitSoundOnLocationWithCaster(self.position, "Hero_Furion.ForceOfNature", self.caster )

	local day_vision = self:GetSpecialValueFor("treant_vision_day")
	local night_vision = self:GetSpecialValueFor("treant_vision_night")

	local spirit_of_the_forest = self.caster:FindAbilityByName("furion_spirit_of_the_forest")

	for i = 1, treant_count do
		if i <= #self.trees then
			local treant = CreateUnitByName("npc_dota_furion_treant" , self.position, false, self.caster, self.caster, self.caster:GetTeamNumber())
			if treant and not treant:IsNull() then
				treant:AddNewModifier(self.caster, self, "modifier_phased", {duration = FrameTime()})
				treant:AddNewModifier(self.caster, self, "modifier_kill", {duration = duration})
				treant:AddNewModifier(self.caster, self, "modifier_force_of_nature_treant_lua", {duration = duration})
				treant:AddNewModifier(self.caster, spirit_of_the_forest, "modifier_furion_spirit_of_the_forest", nil)

				if self:GetSpecialValueFor("treewalking") >= 1 then
					treant:AddNewModifier(self.caster, self, "modifier_special_bonus_tree_walking", nil)
				end

				treant:SetOwner(self.caster)
				treant:SetControllableByPlayer(self.caster:GetPlayerID(), true)

				treant:SetBaseMaxHealth(treant_hp)
				treant:SetMaxHealth(treant_hp)
				treant:SetHealth(treant_hp)
				treant:SetBaseDamageMin(treant_damage - 2)
				treant:SetBaseDamageMax(treant_damage + 2)
				treant:SetDayTimeVisionRange(day_vision)
				treant:SetNightTimeVisionRange(night_vision)


				if treant_count == 1 then
					treant:SetModelScale(1.6)
				end
			end
		end
	end
end



modifier_force_of_nature_treant_lua = modifier_force_of_nature_treant_lua or class({})

function modifier_force_of_nature_treant_lua:IsHidden() return true end
function modifier_force_of_nature_treant_lua:IsPurgable() return false end


function modifier_force_of_nature_treant_lua:OnCreated()
	local ability = self:GetAbility()
	if not IsValidEntity(ability) then return end

	self.movespeed = ability:GetSpecialValueFor("treant_movespeed")
end


function modifier_force_of_nature_treant_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BASE_OVERRIDE, -- GetModifierMoveSpeedOverride
	}
end


function modifier_force_of_nature_treant_lua:GetModifierMoveSpeedOverride()
	return self.movespeed or 300
end