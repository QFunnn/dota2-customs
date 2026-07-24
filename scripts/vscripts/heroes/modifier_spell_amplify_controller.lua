--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_spell_amplify_controller = class({}) ---@class CDOTA_Modifier_Lua

function modifier_spell_amplify_controller:IsHidden() return true end
function modifier_spell_amplify_controller:IsDebuff() return false end
function modifier_spell_amplify_controller:IsPurgable() return false end
function modifier_spell_amplify_controller:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end
function modifier_spell_amplify_controller:RemoveOnDeath() return false end

function modifier_spell_amplify_controller:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end


function modifier_spell_amplify_controller:OnCreated()
	self:SetHasCustomTransmitterData(true)
	if IsClient() then return end

	self:OnRefresh()
	self:StartIntervalThink(1)
end


function modifier_spell_amplify_controller:OnRefresh()
	if IsClient() then return end
	if self:IsNull() then return end

	self:SetValues()
	self:SendBuffRefreshToClients()
end

function modifier_spell_amplify_controller:OnIntervalThink()
	if IsClient() then return end
	if self:IsNull() or not self:GetParent() then return end

	self:OnRefresh()
end

function modifier_spell_amplify_controller:SetValues()

	if self and (not self:IsNull()) and self:GetParent() and (not self:GetParent():IsNull()) and self:GetParent().GetIntellect and self:GetParent().flSP then
		self.spell_amplify = self:GetParent().flSP * self:GetParent():GetIntellect(true)
	else
		self.spell_amplify = 0
	end
	--print("self.spell_amplify"..self.spell_amplify)
end

function modifier_spell_amplify_controller:AddCustomTransmitterData()
	return {
		spell_amplify = self.spell_amplify,
	}
end

function modifier_spell_amplify_controller:HandleCustomTransmitterData(data)
	self.spell_amplify = tonumber(data.spell_amplify)
end



if IsClient() then
	function modifier_spell_amplify_controller:GetModifierSpellAmplify_Percentage(params)
		return self.spell_amplify
	end
end

if IsServer() then

	function modifier_spell_amplify_controller:GetModifierSpellAmplify_Percentage(params)


		local inflictor = params.inflictor
		local target = params.target

		if params.damage_type == DAMAGE_TYPE_NONE then
			return 0
		end

		if IsServer() and inflictor and not inflictor:IsNull() then
			local ability_name = inflictor:GetAbilityName()
			local parent = self:GetParent()


			--百分比技能无效
			if PERCENTAGE_ABILITIES and PERCENTAGE_ABILITIES[ability_name] or (ability_name == "enigma_black_hole" and parent:HasScepter()) then
				return 0
			end

			--目标是否为英雄
			local bHeroTarget = false

			if target and not target:IsNull() then
				if target.IsRealHero and target:IsRealHero() and target.GetUnitName and string.find(target:GetUnitName(), "npc_dota_hero") == 1 then
					bHeroTarget = true
				end
			end

			if DOT_ABILITIES and DOT_ABILITIES[ability_name] and parent.GetIntellect and parent.flDotSP and not DamageFlagFilter(DOTA_DAMAGE_FLAG_NO_DOT, params.damage_flags) then
				if bHeroTarget then
					return 0.35 * parent.flDotSP * (parent:GetIntellect(true) + parent:GetStrength() + parent:GetAgility()) + self.spell_amplify * 0.2
				else
					local test = parent.flDotSP * (parent:GetIntellect(true) + parent:GetStrength() + parent:GetAgility()) + self.spell_amplify
					logger:Logf("damage %s", tostring(test))
					return test
				end
			end

			if bHeroTarget then
				return self.spell_amplify * 0.2
			end

		end

		return self.spell_amplify

	end

end