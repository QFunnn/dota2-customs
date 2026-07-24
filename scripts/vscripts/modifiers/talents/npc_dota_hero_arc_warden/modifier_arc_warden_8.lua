--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_arc_warden_8_buff", "modifiers/talents/npc_dota_hero_arc_warden/modifier_arc_warden_8", LUA_MODIFIER_MOTION_NONE )

modifier_arc_warden_8=class({})

function modifier_arc_warden_8:IsHidden() return true end
function modifier_arc_warden_8:IsPurgable() return false end
function modifier_arc_warden_8:IsPurgeException() return false end
function modifier_arc_warden_8:RemoveOnDeath() return false end

function modifier_arc_warden_8:OnCreated()
    self.bonus_duration = {4,8}
	if not IsServer() then return end
	self:SetStackCount(1)
    self.exceptions = 
    {
        ["item_clarity"] = true,
        ["item_enchanted_mango"] = true,
        ["item_bottle"] = true,
        ["item_smoke_of_deceit"] = true,
        ["item_flask"] = true,
        ["item_tango"] = true,
        ["item_faerie_fire"] = true,
        ["item_dust_custom"] = true,
        ["item_book_str"] = true,
        ["item_book_agi"] = true,
        ["item_book_int"] = true,
        ["item_power_treads"] = true,
        ["item_aghanims_treads"] = true,
        ["item_aghanims_shard_custom"] = true,
        ["item_health_radiance"] = true,
        ["item_mana_radiance"] = true,
        ["item_radiance_custom"] = true,
        ["item_spear_of_mordiggian"] = true,
        ["item_vambrace"] = true,
        ["item_ward_dispenser_custom"] = true,
        ["item_moon_aghanim"] = true,
        ["item_moon_kaya"] = true,
        ["item_moon_yasha"] = true,
        ["item_moon_sange"] = true,
        ["item_moon_aghanim"] = true,
        ["item_moon_shard"] = true,      
        ["item_royale_with_cheese"] = true,  
        ["item_talant_book"] = true,  
    }
end

function modifier_arc_warden_8:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end 

function modifier_arc_warden_8:DeclareFunctions()
    return
    {
         
    }

end
function modifier_arc_warden_8:OnAbilityFullyCast( params )
	if IsServer() then
		local hAbility = params.ability
		if hAbility == nil or not ( hAbility:GetCaster() == self:GetParent() ) then
			return 0
		end
		if hAbility:IsToggle() then
			return 0
		end
		if not hAbility:IsItem() then 
			return 0
		end
        if self.exceptions[hAbility:GetAbilityName()] ~= nil then return end
        self:GetCaster():AddNewModifier(self:GetCaster(), nil, "modifier_arc_warden_8_buff", {duration = self.bonus_duration[self:GetStackCount()]})
	end
end

modifier_arc_warden_8_buff = class({})
function modifier_arc_warden_8_buff:IsPurgable() return false end
function modifier_arc_warden_8_buff:IsPurgeException() return false end
function modifier_arc_warden_8_buff:GetTexture()
    return "roshan_8"
end

function modifier_arc_warden_8_buff:OnCreated()
    if not IsServer() then return end
    self:IncrementStackCount()
    local mod = self
    Timers:CreateTimer(mod:GetRemainingTime(), function()
        if mod and not mod:IsNull() then
            mod:DecrementStackCount()
        end
    end)
end

function modifier_arc_warden_8_buff:OnRefresh()
    self:OnCreated()
end

function modifier_arc_warden_8_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }
end

function modifier_arc_warden_8_buff:GetModifierAttackSpeedBonus_Constant()
    return 30 * self:GetStackCount()
end