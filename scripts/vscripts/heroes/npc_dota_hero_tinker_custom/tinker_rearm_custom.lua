--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_tinker_rearm_custom", "heroes/npc_dota_hero_tinker_custom/tinker_rearm_custom", LUA_MODIFIER_MOTION_NONE)

tinker_rearm_custom = class({})

tinker_rearm_custom.modifier_tinker_12_mana = {25}

function tinker_rearm_custom:GetCooldown(iLevel)
    return self.BaseClass.GetCooldown(self, iLevel)
end

function tinker_rearm_custom:GetManaCost(iLevel)
    local manacost = self.BaseClass.GetManaCost(self, iLevel)
    if self:GetCaster():HasModifier("modifier_tinker_12") then
        manacost = manacost - (manacost / 100 * self.modifier_tinker_12_mana[self:GetCaster():GetTalentLevel("modifier_tinker_12")])
    end
    return manacost
end

function tinker_rearm_custom:GetChannelTime()
    return self.BaseClass.GetChannelTime(self)
end

function tinker_rearm_custom:Precache(context)
    PrecacheResource("particle", "particles/units/heroes/hero_tinker/tinker_rearm.vpcf", context)
end

function tinker_rearm_custom:GetChannelAnimation()
    if self:GetLevel() >= 3 then
        return ACT_DOTA_TINKER_REARM3
    elseif self:GetLevel() >= 2 then
        return ACT_DOTA_TINKER_REARM2
    elseif self:GetLevel() >= 1 then
        return ACT_DOTA_TINKER_REARM1
    end
end



function tinker_rearm_custom:OnSpellStart()
    if not IsServer() then return end
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_tinker_rearm_custom", {})
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_tinker/tinker_rearm.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControlEnt(particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_ambient", self:GetCaster():GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(particle)
    self:GetCaster():EmitSound("Hero_Tinker.Rearm")
end

function tinker_rearm_custom:OnChannelFinish(bInterrupted)
    if bInterrupted then return end
    local caster = self:GetCaster()
	
    for i=0, caster:GetAbilityCount() - 1 do
		local hAbility = caster:GetAbilityByIndex( i )
		if hAbility then
	        hAbility:EndCooldown()
            hAbility:RefreshCharges()
		end
	end
	
	--local exempt_table = {}
	--exempt_table["item_hand_of_midas_custom"] = true
    --exempt_table["item_hand_of_midas"] = true
    --exempt_table["item_aeon_disk"] = true
    --exempt_table["item_arcane_boots"] = true
    --exempt_table["item_black_king_bar"] = true
    --exempt_table["item_helm_of_the_dominator"] = true
    --exempt_table["item_helm_of_the_overlord"] = true
    --exempt_table["item_sphere"] = true
    --exempt_table["item_meteor_hammer"] = true
    --exempt_table["item_pipe"] = true
    --exempt_table["item_refresher"] = true
    --exempt_table["item_refresher_custom"] = true
    --exempt_table["item_ex_machina_custom"] = true
    --exempt_table["item_demonicon"] = true
    --exempt_table["item_aeon_disk_lua"] = true

	-- for i = 0, 8 do
	-- 	local item = caster:GetItemInSlot( i )
	-- 	if item and not exempt_table[item:GetAbilityName()] then
	-- 		item:EndCooldown()
	-- 	end
	-- end

    -- local neutral_item = caster:GetItemInSlot( 16 )
    -- if neutral_item then
    --     neutral_item:EndCooldown()
    -- end

    -- local tp_scroll = caster:GetItemInSlot( 15 )
    -- if tp_scroll then
    --     tp_scroll:EndCooldown()
    -- end
end

modifier_tinker_rearm_custom = class({})
function modifier_tinker_rearm_custom:IsHidden() return true end
function modifier_tinker_rearm_custom:IsPurgable() return false end
function modifier_tinker_rearm_custom:IsPurgeException() return false end
function modifier_tinker_rearm_custom:GetEffectName()
    return "particles/units/heroes/hero_tinker/tinker_rearm.vpcf"
end
function modifier_tinker_rearm_custom:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end