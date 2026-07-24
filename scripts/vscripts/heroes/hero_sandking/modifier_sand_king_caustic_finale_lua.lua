--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_sand_king_caustic_finale_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sand_king_caustic_finale_lua:IsHidden()
	return true
end

function modifier_sand_king_caustic_finale_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sand_king_caustic_finale_lua:OnCreated( kv )
	self.duration = self:GetAbility():GetSpecialValueFor( "caustic_finale_duration" ) -- special value
end

function modifier_sand_king_caustic_finale_lua:OnRefresh( kv )
	self.duration = self:GetAbility():GetSpecialValueFor( "caustic_finale_duration" ) -- special value	
end

function modifier_sand_king_caustic_finale_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sand_king_caustic_finale_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}

	return funcs
end

function modifier_sand_king_caustic_finale_lua:GetModifierProcAttack_Feedback( params )
	if IsServer() then

		if self:GetParent():PassivesDisabled() then 
		   return 
		end

		if self:GetAbility():GetLevel()<1 then
           return
		end

		if params.target:GetTeamNumber()==self:GetParent():GetTeamNumber() then 
		   return 
		end

		if params.target:IsMagicImmune() then 
		   return 
		end

		-- add debuff if not present
		local modifier = params.target:FindModifierByNameAndCaster( "modifier_sand_king_caustic_finale_lua_debuff", self:GetParent() )
		if not modifier then
            
            local bHasTalent = false
			local hTalent = self:GetCaster():FindAbilityByName("special_bonus_unique_sand_king_6")
		    if hTalent and hTalent:GetLevel() > 0 then
		       bHasTalent = true
		    end
			params.target:AddNewModifier(
				self:GetParent(), -- player source
				self:GetAbility(), -- ability source
				"modifier_sand_king_caustic_finale_lua_debuff", -- modifier name
				{ duration = self.duration, has_talent=bHasTalent } -- kv
			)
		else
			modifier:SetDuration(self.duration, true)
		end
	end
end