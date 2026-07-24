--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_kaya_2_lua = class({})
LinkLuaModifier( "modifier_item_kaya_2_lua", "items/item_kaya_2_lua", LUA_MODIFIER_MOTION_NONE )
--------------------------------------------------------------------------------
function item_kaya_2_lua:GetIntrinsicModifierName()
  return "modifier_item_kaya_2_lua"
end

modifier_item_kaya_2_lua = class({})

function modifier_item_kaya_2_lua:IsHidden()
	return true
end

function modifier_item_kaya_2_lua:IsPurgable()
	return false
end

function modifier_item_kaya_2_lua:GetAttributes() 
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end


function modifier_item_kaya_2_lua:DeclareFunctions()
	local funcs =
	{
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
		MODIFIER_PROPERTY_MP_REGEN_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_MANA_DRAIN_AMPLIFY_PERCENTAGE
	}
	return funcs
end


function modifier_item_kaya_2_lua:OnCreated()
	  if IsServer() then    
       if self:IsNull() then 
       	  return
       end
       local hCaster = self:GetParent()
       if (not hCaster) or hCaster:IsNull() then
       	  return
       end	     
	     if hCaster:HasModifier("modifier_item_kaya_3_lua") then
	        local hAbility = hCaster:FindModifierByName("modifier_item_kaya_3_lua"):GetAbility()
	        if self:GetParent():HasModifier("modifier_skill_overbuffed") then
	        	hCaster.flSP = hAbility:GetSpecialValueFor("spell_amplify") + 0.75
	        else
	        	hCaster.flSP = hAbility:GetSpecialValueFor("spell_amplify")
	        end
	     elseif hCaster:HasModifier("modifier_item_kaya_2_lua") then
	        local hAbility = hCaster:FindModifierByName("modifier_item_kaya_2_lua"):GetAbility()
	        if self:GetParent():HasModifier("modifier_skill_overbuffed") then
	        	hCaster.flSP = hAbility:GetSpecialValueFor("spell_amplify") + 0.75
	        else
	        	hCaster.flSP = hAbility:GetSpecialValueFor("spell_amplify")
	        end
	     else
	        hCaster.flSP = nil
	     end
    end
end


function modifier_item_kaya_2_lua:OnDestroy()
	  if IsServer() then    
       if self:IsNull() then 
       	  return
       end
       local hCaster = self:GetParent()
       if (not hCaster) or hCaster:IsNull() then
       	  return
       end	     
	     if hCaster:HasModifier("modifier_item_kaya_3_lua") then
	        local hAbility = hCaster:FindModifierByName("modifier_item_kaya_3_lua"):GetAbility()
	        if self:GetParent():HasModifier("modifier_skill_overbuffed") then
	        	hCaster.flSP = hAbility:GetSpecialValueFor("spell_amplify") + 0.75
	        else
	        	hCaster.flSP = hAbility:GetSpecialValueFor("spell_amplify")
	        end
	     elseif hCaster:HasModifier("modifier_item_kaya_2_lua") then
	        local hAbility = hCaster:FindModifierByName("modifier_item_kaya_2_lua"):GetAbility()
	        if self:GetParent():HasModifier("modifier_skill_overbuffed") then
	        	hCaster.flSP = hAbility:GetSpecialValueFor("spell_amplify") + 0.75
	        else
	        	hCaster.flSP = hAbility:GetSpecialValueFor("spell_amplify")
	        end
	     else
	        hCaster.flSP = nil
	     end
    end
end

function modifier_item_kaya_2_lua:GetModifierMPRegenAmplify_Percentage(params)
	return self:GetAbility():GetSpecialValueFor("mana_regen_multiplier")
end

function modifier_item_kaya_2_lua:GetModifierBonusStats_Intellect(params)
	return self:GetAbility():GetSpecialValueFor("bonus_int")
end

function modifier_item_kaya_2_lua:GetModifierPercentageManacostStacking(params)
	return self:GetAbility():GetSpecialValueFor("manacost_reduction")
end

function modifier_item_kaya_2_lua:GetModifierManadrainAmplify_Percentage(params)
	return self:GetAbility():GetSpecialValueFor("manacost_reduction")
end