--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


--Обработчик магических критов
modifier_magic_crit = class({}) ---@class CDOTA_Modifier_Lua

function modifier_magic_crit:IsHidden() return true end
function modifier_magic_crit:IsDebuff() return false end
function modifier_magic_crit:IsPurgable() return false end
function modifier_magic_crit:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end
function modifier_magic_crit:RemoveOnDeath() return false end
function modifier_magic_crit:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
	}
end
function modifier_magic_crit:OnCreated()
	if IsServer() then
		self:SetStackCount(1)
	end
end
function modifier_magic_crit:OnRefresh()
	if IsServer() then
		self:IncrementStackCount()
	end
end
function modifier_magic_crit:OnStackCountChanged(iStackCount)
	if IsServer() then
		if self:GetStackCount() <= 0 then
			self:Destroy()
		end
	end
end
function modifier_magic_crit:GetModifierTotalDamageOutgoing_Percentage(params)
	local parent = self:GetParent()
	local target = params.target
	local ability = params.inflictor
	if IsServer() then
		if params.damage_type == DAMAGE_TYPE_MAGICAL and IsValid(parent) and IsValid(target) and target:IsAlive() and not parent:HasModifier("modifier_item_aeon_disk_lua_buff") then
			local shouldActive = true
			if ability ~= nil then
				local abilityName = ability:GetAbilityName()
				if PERCENTAGE_ABILITIES and PERCENTAGE_ABILITIES[abilityName] or (abilityName == "enigma_black_hole" and parent:HasScepter()) or (abilityName == "witch_doctor_voodoo_restoration" and parent:HasTalent("special_bonus_unique_witch_doctor_2")) then
					shouldActive = false
				else
					shouldActive = true
				end
			else
				shouldActive = true
			end
			if shouldActive then
				local magicCritResult = GetCustomModifierProps(parent, "MODIFIER_PROPERTY_MAGICAL_CRIT_DAMAGE", params, CUSTOM_MODIFIER_PROPS_CAL_TYPE_MAX)
				if magicCritResult then
					local value = magicCritResult.value
					local buff = magicCritResult.buff

					if value > 0 then
						local tParams = params
						params.crit_buff = buff
						FireCustomEvent("MODIFIER_EVENT_ON_MAGICAL_CRIT", tParams, parent, buff)
						return math.max(0, value - 100)
					end
				end
			end
		end
	end
end