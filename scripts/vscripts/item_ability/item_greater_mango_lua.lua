--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_greater_mango_lua", "item_ability/item_greater_mango_lua.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if item_greater_mango_lua == nil then
	item_greater_mango_lua = class({})
end
function item_greater_mango_lua:OnSpellStart()
	local hCaster = self:GetCaster()
	local hp = self:GetSpecialValueFor("hp")
	local duration = self:GetSpecialValueFor("duration")

	if IsValid(hCaster) and not hCaster:HasModifier("modifier_hero_refreshing") then
		for i = 0, hCaster:GetAbilityCount() - 1 do
			local ability = hCaster:GetAbilityByIndex(i)
			if ability ~= nil and string.find(ability:GetAbilityName(), "special_bonus_") ~= nil and ability:GetAbilityName() ~= "special_bonus_attributes" then
				local ap = hCaster:GetAbilityPoints()
				hCaster:SetAbilityPoints(ap + 1)
				hCaster:UpgradeAbility(ability)
			end
		end
		hCaster:SetHealth(hp)
		hCaster:AddNewModifier(hCaster, self, "modifier_item_greater_mango_lua", { duration = duration })
		self:SpendCharge()
		local particleID = ParticleManager:CreateParticle("particles/items3_fx/mango_active.vpcf", PATTACH_ABSORIGIN_FOLLOW, hCaster)
		ParticleManager:ReleaseParticleIndex(particleID)
		EmitSoundOn("DOTA_Item.Mango.Activate", hCaster)
	end

end
---------------------------------------------------------------------
--Modifiers
if modifier_item_greater_mango_lua == nil then
	modifier_item_greater_mango_lua = class({})
end
function modifier_item_greater_mango_lua:GetTexture()
	return "item_greater_mango"
end
function modifier_item_greater_mango_lua:IsDebuff()
	return true
end
function modifier_item_greater_mango_lua:IsHidden()
	return false
end
function modifier_item_greater_mango_lua:IsPurgable()
	return false
end
function modifier_item_greater_mango_lua:IsPurgeException()
	return false
end
function modifier_item_greater_mango_lua:OnCreated(params)
	if IsServer() then
		self:StartIntervalThink(0)
	end
end
function modifier_item_greater_mango_lua:OnRefresh(params)
	if IsServer() then
	end
end
function modifier_item_greater_mango_lua:OnIntervalThink()
	local hParent = self:GetParent()
	if hParent:HasModifier("modifier_hero_refreshing") then
		if self.duration_remain == nil then
			self.duration_remain = self:GetRemainingTime()
		end
		self:SetDuration(self.duration_remain, true)
	else
		if self.duration_remain ~= nil then
			self.duration_remain = nil
		end
	end
end
function modifier_item_greater_mango_lua:OnDestroy()
	if IsServer() then
	end
end
function modifier_item_greater_mango_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_DISABLE_HEALING,
	}
end
function modifier_item_greater_mango_lua:GetModifierHPRegenAmplify_Percentage(params)
	return -10000
end
function modifier_item_greater_mango_lua:GetDisableHealing(params)
	return 1
end