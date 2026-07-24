--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_aegis_custom_particle", "modifiers/utils/modifier_aegis_custom", LUA_MODIFIER_MOTION_NONE )

	modifier_aegis_custom = class({})

	function modifier_aegis_custom:IsHidden() return false end
	function modifier_aegis_custom:IsPurgable() return false end
	function modifier_aegis_custom:IsPurgeException() return false end
	function modifier_aegis_custom:RemoveOnDeath() return false end

	function modifier_aegis_custom:DeclareFunctions()

	    return { MODIFIER_PROPERTY_REINCARNATION, MODIFIER_PROPERTY_TOOLTIP }
	end



	function modifier_aegis_custom:OnCreated()
	  self.parent = self:GetParent()
	  self.RemoveForDuel = true
	end



	function modifier_aegis_custom:GetPriority() 
		if not IsServer() then return end
		local ability_reincarnation = self.parent:FindAbilityByName("skeleton_king_reincarnation_custom")
		if ability_reincarnation == nil or not ability_reincarnation:IsFullyCastable() then
			return 100
		end
	end

	function modifier_aegis_custom:ReincarnateTime()
		if IsServer() then
			if not self.parent:HasModifier("modifier_death") or self.parent:HasModifier("modifier_axe_culling_blade_custom_aegis") then
				local ability_reincarnation = self.parent:FindAbilityByName("skeleton_king_reincarnation_custom")
				if ability_reincarnation == nil or not ability_reincarnation:IsFullyCastable() then
					CreateModifierThinker( self.parent, nil, "modifier_aegis_custom_particle", { duration = 5 }, self.parent:GetAbsOrigin(), self.parent:GetTeamNumber(), false )
				    self:Destroy()
				    return 5
				end
			end
			return nil
		end
	end

	function modifier_aegis_custom:OnDestroy()
	  if not IsServer() then return end
	  if self.parent:IsAlive() then
	    self.parent:EmitSound("Aegis.Expire")
	    self.parent:AddNewModifier(self.parent, nil, "modifier_aegis_regen", { duration = 5 })
	  end
	end

	function modifier_aegis_custom:GetTexture()
	  return "item_aegis"
	end

	function modifier_aegis_custom:OnTooltip()
	  return self:GetRemainingTime()
	end


	modifier_aegis_custom_particle = class({})

	function modifier_aegis_custom_particle:IsHidden() return false end
	function modifier_aegis_custom_particle:IsPurgable() return false end
	function modifier_aegis_custom_particle:IsPurgeException() return false end
	function modifier_aegis_custom_particle:RemoveOnDeath() return false end

	function modifier_aegis_custom_particle:OnCreated()
	  if not IsServer() then return end
	  self.reincarnate_time = 5

	  local ReincarnateParticle = ParticleManager:CreateParticle( "particles/items_fx/aegis_timer.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	  ParticleManager:SetParticleControl(ReincarnateParticle, 0, self:GetParent():GetAbsOrigin())
	  ParticleManager:SetParticleControl(ReincarnateParticle, 1, Vector(reincarnate_time,0,0))
	  self:AddParticle(ReincarnateParticle, false, false, -1, false, false )

	  self:GetParent():EmitSound("Aegis.Timer")

	  if GameRules:IsDaytime() then
	      self.vision_radius = 1800
	  else 
	      self.vision_radius = 800
	  end

	  AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), self.vision_radius, self.reincarnate_time, true)
	end

	function modifier_aegis_custom_particle:OnDestroy()
	  local particle = ParticleManager:CreateParticle("particles/items_fx/aegis_respawn_timer.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	  ParticleManager:SetParticleControl(particle, 1, Vector(0, 0, 0))  
	  ParticleManager:SetParticleControl(particle, 3, self:GetCaster():GetAbsOrigin())
	  ParticleManager:ReleaseParticleIndex(particle)
	end

	function modifier_aegis_custom_particle:GetTexture()
	  return "item_aegis"
	end

