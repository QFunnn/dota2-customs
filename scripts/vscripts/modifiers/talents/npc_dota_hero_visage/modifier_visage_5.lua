--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_visage_5=class({})

function modifier_visage_5:IsHidden() return true end
function modifier_visage_5:IsPurgable() return false end
function modifier_visage_5:IsPurgeException() return false end
function modifier_visage_5:RemoveOnDeath() return false end

function modifier_visage_5:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local visage_summon_familiars_custom = self:GetCaster():FindAbilityByName("visage_summon_familiars_custom")
    if visage_summon_familiars_custom then
        if visage_summon_familiars_custom.familiar_table and #visage_summon_familiars_custom.familiar_table >= 2 then
            local alive_count = 0
            for _, familiar in pairs(visage_summon_familiars_custom.familiar_table) do
                if familiar and not familiar:IsNull() and familiar:IsAlive() then
                    alive_count = alive_count + 1
                    if alive_count >= 2 then
                        familiar:ForceKill(false)
                        break
                    end
                end
            end
        end
    end
end

function modifier_visage_5:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_visage_5:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS
	}
end

function modifier_visage_5:GetModifierExtraHealthBonus()
    if not IsServer() then return end
	local visage_summon_familiars_custom = self:GetParent():FindAbilityByName("visage_summon_familiars_custom")
	if not visage_summon_familiars_custom then return 0 end
	return visage_summon_familiars_custom:GetFamiliarHealth()
end