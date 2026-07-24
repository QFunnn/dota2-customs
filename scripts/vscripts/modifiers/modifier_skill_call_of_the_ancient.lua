--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_skill_call_of_the_ancient_buff = class({})

function modifier_skill_call_of_the_ancient_buff:IsPurgable() return false end
function modifier_skill_call_of_the_ancient_buff:IsHidden() return false end
function modifier_skill_call_of_the_ancient_buff:IsDebuff() return false end
function modifier_skill_call_of_the_ancient_buff:GetTexture() return "modifier_skill_zoo_director" end

function modifier_skill_call_of_the_ancient_buff:OnCreated()
	if not IsServer() then return end
    self.exseptions = 
    {
        ["enigma_demonic_conversion_custom"] = true,
        ["night_stalker_hunter_in_the_night_custom"] = true,
        ["night_stalker_darkness_passive"] = true,
        ["doom_bringer_devour_custom"] = true,
        ["pudge_meat_hook"] = true,
        ["mirana_arrow"] = true,
        ["item_hand_of_midas_custom"] = true,
    }
end

function modifier_skill_call_of_the_ancient_buff:DeclareFunctions()
    local funcs = 
    {
		MODIFIER_PROPERTY_AVOID_DAMAGE,
	}
	return funcs
end

function modifier_skill_call_of_the_ancient_buff:GetModifierAvoidDamage(params)
    if params.attacker and params.inflictor then
        if params.inflictor ~= nil then
            if self.exseptions[params.inflictor:GetAbilityName()] ~= nil then
                return 1
            end
        end
    end
end