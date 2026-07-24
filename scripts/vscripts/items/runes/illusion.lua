--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- LinkLuaModifier( "modifier_item_custom_rune_illusion", "items/runes/illusion.lua", LUA_MODIFIER_MOTION_NONE )

if item_custom_rune_illusion == nil then
	item_custom_rune_illusion = class({})
end

function item_custom_rune_illusion:OnSpellStart()
	local caster = self:GetCaster()
	local RealOwner = GetRealUnit(caster)
	if RealOwner and IsRealHero(RealOwner) then
		for i = 1, 2 do
			local unit = CreateUnitByName(caster:GetUnitName(), caster:GetAbsOrigin() + RandomVector(RandomFloat(0, 100)), true, RealOwner, RealOwner, caster:GetTeamNumber())
        	if unit then
				unit:SetControllableByPlayer(RealOwner:GetPlayerID(), true)
            	unit:SetOwner(RealOwner)
				unit:SetBaseDamageMin(1)
				unit:SetBaseDamageMax(1)
				unit.is_custom_illusion = true
				unit:AddNewModifier(unit, nil, "modifier_illusion", {duration=10, outgoing_damage = 0, incoming_damage = 100})
				unit:AddNewModifier(RealOwner, nil, "modifier_minigames_unit", {team=caster:GetTeamNumber()})
				unit:AddNewModifier(RealOwner, nil, "modifier_cha_vision", {})

				local ModifName = "modifier_minigames_arena"
				if caster:GetUnitName() == "npc_minigames_pudge" then
					ModifName = "modifier_minigames_pudge"
				elseif caster:GetUnitName() == "npc_minigames_mirana" then
					ModifName = "modifier_minigames_mirana"
				end

				unit:AddNewModifier(RealOwner, nil, ModifName, {})
				unit:MakeIllusion()

				if not unit:HasModifier("modifier_player_cosmetics") then
					unit:AddNewModifier(RealOwner, nil, "modifier_player_cosmetics", {})
				end

				-- Иллюзии создаются с тем же % HP что и у кастера
				local hp_pct = caster:GetHealthPercent() * 0.01
				unit:SetHealth(math.max(1, unit:GetMaxHealth() * hp_pct))

				local fx = ParticleManager:CreateParticle("particles/generic_gameplay/illusion_created.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
				ParticleManager:ReleaseParticleIndex(fx)
			end
		end

		local fx2 = ParticleManager:CreateParticle("particles/generic_gameplay/illusion_created.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
		ParticleManager:ReleaseParticleIndex(fx2)

		FindClearSpaceForUnit(caster, caster:GetAbsOrigin() + RandomVector(RandomFloat(0, 100)), true)
        ResolveNPCPositions(caster:GetAbsOrigin(), 300)

		EmitGlobalSound("Rune.Illusion")
	end

	UTIL_Remove(self)
end

-- modifier_item_custom_rune_illusion = class({
--     IsHidden                = function(self) return false end,
--     IsPurgable              = function(self) return false end,
--     IsPurgeException        = function(self) return false end,
--     IsDebuff                = function(self) return false end,

-- 	DeclareFunctions        = function(self)
--         return {
--             -- MODIFIER_PROPERTY_IS_ILLUSION,
-- 			MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE 
--         }
--     end,

--     -- GetIsIllusion           = function(self) return 1 end,
-- 	GetModifierIncomingDamage_Percentage	= function(self) return 100 end,
-- })

-- function modifier_item_custom_rune_illusion:OnCreate()
-- 	if not IsServer() then return end

-- 	local fx = ParticleManager:CreateParticle("particles/generic_gameplay/illusion_created.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
-- 	ParticleManager:ReleaseParticleIndex(fx)

-- 	local fxIllus = ParticleManager:CreateParticleForTeam("particles/status_fx/status_effect_illusion.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent(), self:GetParent():GetTeamNumber())
-- 	self:AddParticle(fxIllus, false, true, 99999, false, false)

-- 	EmitSoundOn("General.Illusion.Create", self:GetParent())
-- end

-- function modifier_item_custom_rune_illusion:OnDestroy()
-- 	if not IsServer() then return end

-- 	local fx = ParticleManager:CreateParticle("particles/generic_gameplay/illusion_killed.vpcf", PATTACH_WORLDORIGIN, nil)
-- 	ParticleManager:SetParticleControl(fx, 0, self:GetParent():GetAbsOrigin())
-- 	ParticleManager:ReleaseParticleIndex(fx)

-- 	EmitSoundOnLocationWithCaster(self:GetParent():GetAbsOrigin(), "General.Illusion.Destroy", self:GetParent())
-- end
function item_custom_rune_illusion:OnChargeCountChanged(iCharges) end