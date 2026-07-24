--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_tinker_rearm_datadriven", "heroes/hero_tinker/rearm", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_tinker_rearm_datadriven_debuff", "heroes/hero_tinker/rearm", LUA_MODIFIER_MOTION_NONE)

tinker_rearm_datadriven = class({})

function tinker_rearm_datadriven:GetChannelAnimation()
    if self:GetLevel() >= 3 then
        return ACT_DOTA_TINKER_REARM3
    elseif self:GetLevel() >= 2 then
        return ACT_DOTA_TINKER_REARM2
    elseif self:GetLevel() >= 1 then
        return ACT_DOTA_TINKER_REARM1
    end
end

-- [NP-18] Время канала читаем из AbilityValues "channel_tooltip" — там привязан талант
-- 25 ур. special_bonus_unique_tinker_rearm_channel_time (-0.25с). Через топ-левел
-- AbilityChannelTime талант не применялся (кастомная абилка).
function tinker_rearm_datadriven:GetChannelTime()
    return self:GetSpecialValueFor("channel_tooltip")
end

function tinker_rearm_datadriven:OnSpellStart()
    if not IsServer() then return end
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_tinker_rearm_datadriven", {})
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_tinker/tinker_rearm.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControl(particle, 0, self:GetCaster():GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle)
end

function tinker_rearm_datadriven:OnChannelFinish(bInterrupted)
    if bInterrupted then
        return 
    end
	local ability_exempt_table = {}
    ability_exempt_table["ability_phoenix_supernova"]=true
    ability_exempt_table["arc_warden_tempest_double"]=true
    ability_exempt_table["arc_warden_tempest_double_lua"]=true
    ability_exempt_table["zuus_thundergods_wrath"]=true
    ability_exempt_table["furion_wrath_of_nature"]=true
    ability_exempt_table["ancient_apparition_ice_blast"]=true
    ability_exempt_table["spectre_haunt"]=true
    ability_exempt_table["silencer_global_silence"]=true
    ability_exempt_table["skeleton_king_reincarnation"]=true
    ability_exempt_table["abaddon_borrowed_time_custom"]=true
    ability_exempt_table["oracle_false_promise_custom"]=true
    ability_exempt_table["dazzle_shallow_grave"]=true
    ability_exempt_table["slark_shadow_dance"]=true
    ability_exempt_table["dark_willow_shadow_realm"]=true
    ability_exempt_table["slark_depth_shroud"]=true
    ability_exempt_table["undying_tombstone_lua"]=true
    ability_exempt_table["shadow_shaman_mass_serpent_ward"]=true
    ability_exempt_table["warlock_rain_of_chaos"]=true
    ability_exempt_table["rattletrap_overclocking"]=true
    ability_exempt_table["rattletrap_jetpack"]=true
    ability_exempt_table["dazzle_good_juju"]=true
    ability_exempt_table["bounty_drop_custom"]=true
    ability_exempt_table["slark_depth_shroud_custom"]=true
    ability_exempt_table["slark_shadow_dance_custom"]=true
    ability_exempt_table["chen_holy_persuasion_custom"]=true
    ability_exempt_table["razor_static_link"]=true
    ability_exempt_table["puck_phase_shift_custom"]=true
    ability_exempt_table["muerta_pierce_the_veil"]=true
    ability_exempt_table["ability_disruptor_aeon"]=true
    ability_exempt_table["ability_undying_reincarnate"]=true
    ability_exempt_table["ability_marci_special_delivery"]=true

    local ability_discount_table = {}
    ability_discount_table["faceless_void_chronosphere"]= 0.4
    ability_discount_table["zuus_cloud_custom"]= 0.5
    ability_discount_table["mirana_arrow"]= 0.5
    ability_discount_table["night_stalker_hunter_in_the_night_custom"]= 0.5
    ability_discount_table["doom_bringer_devour_custom"]= 0.5
    ability_discount_table["pudge_meat_hook"]= 0.5
    ability_discount_table["life_stealer_infest"]= 0.5
    ability_discount_table["enigma_demonic_conversion_custom"]= 0.5
    ability_discount_table["snapfire_gobble_up_custom"]= 0.5
    

    local caster = self:GetCaster()

	for i = 0, caster:GetAbilityCount() - 1 do
		local hAbility = caster:GetAbilityByIndex( i )
		if hAbility
		and not ability_exempt_table[hAbility:GetAbilityName()] 
		and not (caster:HasModifier("modifier_hero_refreshing") and "razor_eye_of_the_storm"==hAbility:GetAbilityName())   then

			local flRatio = 1
		    if ability_discount_table[hAbility:GetAbilityName()]~=nil then
	           flRatio = ability_discount_table[hAbility:GetAbilityName()]
	        end

	        local flEffectiveCooldown = hAbility:GetEffectiveCooldown(hAbility:GetLevel()-1)
	        local flCurrentCooldown = hAbility:GetCooldownTimeRemaining()

	        --如果100%刷新
	        if flRatio>0.99 then
	           hAbility:EndCooldown()
	        else
		        if flCurrentCooldown - flEffectiveCooldown*flRatio<=0 then
		        	hAbility:EndCooldown()
		        else
		            hAbility:EndCooldown()
		            hAbility:StartCooldown(flCurrentCooldown-flEffectiveCooldown*flRatio)
		        end
		    end

		end
	end
	
	-- [NP-18] Rearm НЕ перезаряжает предметы (в этом отличие от ванили — там КД предметов
	-- тоже сбрасывается). Перезаряжаются только способности (выше, с учётом REARM_EXEMPT/DISCOUNT).
	-- Блок сброса КД предметов намеренно удалён.

    local modifier_tinker_rearm_datadriven_debuff = self:GetCaster():FindModifierByName("modifier_tinker_rearm_datadriven_debuff")
    if modifier_tinker_rearm_datadriven_debuff then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_tinker_rearm_datadriven_debuff", {duration = 6})
        modifier_tinker_rearm_datadriven_debuff:IncrementStackCount()
    else
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_tinker_rearm_datadriven_debuff", {duration = 6})
    end
end

modifier_tinker_rearm_datadriven_debuff = class({})
function modifier_tinker_rearm_datadriven_debuff:IsPurgable() return false end
function modifier_tinker_rearm_datadriven_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
    }
end
function modifier_tinker_rearm_datadriven_debuff:GetModifierTotalDamageOutgoing_Percentage()
    return -25 * self:GetStackCount()
end

modifier_tinker_rearm_datadriven = class({})
function modifier_tinker_rearm_datadriven:IsHidden() return true end
function modifier_tinker_rearm_datadriven:IsPurgable() return false end
function modifier_tinker_rearm_datadriven:IsPurgeException() return false end
function modifier_tinker_rearm_datadriven:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION
    }
end
function modifier_tinker_rearm_datadriven:GetEffectName()
    return "particles/units/heroes/hero_tinker/tinker_rearm.vpcf"
end
function modifier_tinker_rearm_datadriven:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end