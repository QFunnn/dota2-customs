--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


broodmother_buff_spiderling_lua = class({})

LinkLuaModifier ("modifier_broodmother_spiderling_lua", "abilities/heroes/broodmother/broodmother_buff_spiderling", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier ("modifier_broodmother_spiderling_debuff_lua", "abilities/heroes/broodmother/broodmother_buff_spiderling", LUA_MODIFIER_MOTION_NONE)


function broodmother_buff_spiderling_lua:GetIntrinsicModifierName()
	return "modifier_broodmother_spiderling_lua"
end


---------------------------------------------------------------------------------------------------------------------------------------------------------


modifier_broodmother_spiderling_lua = class({})

function modifier_broodmother_spiderling_lua:IsHidden() return false end
function modifier_broodmother_spiderling_lua:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT end

function modifier_broodmother_spiderling_lua:OnCreated(keys)
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	if not self.caster or self.caster:IsNull() then return end
	if not self.ability or self.ability:IsNull() then return end

	self.debuff_duration = self.ability:GetSpecialValueFor("debuff_duration")
	self.buff_damage = self.ability:GetSpecialValueFor("buff_damage")
	self.buff_hp = self.ability:GetSpecialValueFor("buff_hp")
	self.buff_model_size = self.ability:GetSpecialValueFor("buff_model_size")
	self.buff_model_size_cap = self.ability:GetSpecialValueFor("buff_model_size_cap")

	self.lifetime_bonus = self.ability:GetSpecialValueFor("lifetime_bonus")
	self.lifetime_extention_limit = self.ability:GetSpecialValueFor("lifetime_extention_limit")
end

function modifier_broodmother_spiderling_lua:OnRefresh(keys)
	self:OnCreated(keys)
end

function modifier_broodmother_spiderling_lua:OnStackCountChanged()
	if not self or self:IsNull() then return end
	if not IsServer() then return end
	if not self.caster or self.caster:IsNull() then return end

	local spider_hp = self.caster:GetBaseMaxHealth() + self.buff_hp
	self.caster:SetBaseMaxHealth(spider_hp)
	self.caster:SetMaxHealth(spider_hp)
	self.caster:SetHealth(spider_hp)

	self:ExtendLifetime()
end

function modifier_broodmother_spiderling_lua:ExtendLifetime()
	local modifier = self.caster:FindModifierByName("modifier_kill")

	if modifier and (modifier.extended_times or 0) < self.lifetime_extention_limit then
		modifier:SetDuration(modifier:GetRemainingTime() + self.lifetime_bonus, true)
		modifier.extended_times = (modifier.extended_times or 0) + 1
	end
end

function modifier_broodmother_spiderling_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_MODEL_SCALE, -- GetModifierModelScale
	}
end

modifier_broodmother_spiderling_lua.target_exceptions = {
	--["npc_dota_broodmother_spiderling"] = true,
	["npc_dota_unit_undying_zombie_torso"] = true,
	["npc_dota_unit_undying_zombie"] = true,
	--["npc_dota_furion_treant_1"] = true,
	--["npc_dota_furion_treant_2"] = true,
	--["npc_dota_furion_treant_3"] = true,
	--["npc_dota_furion_treant_4"] = true,
	--["npc_dota_furion_treant_large"] = true,
	--["npc_dota_lesser_eidolon"] = true,
	--["npc_dota_eidolon"] = true,
	--["npc_dota_greater_eidolon"] = true,
	--["npc_dota_dire_eidolon"] = true,
	--["npc_dota_wraith_king_skeleton_warrior"] = true,
	--["npc_dota_clinkz_skeleton_archer"] = true,
	--["npc_dota_weaver_swarm"] = true,
}

function modifier_broodmother_spiderling_lua:GetModifierProcAttack_Feedback(kv)
	if not self or self:IsNull() then return end
	if not IsServer() then return end
	if kv.target:IsBuilding() then return end
	if kv.target:IsOther() then return end
	if kv.target:IsIllusion() then return end
	if self.target_exceptions[kv.target:GetUnitName()] then return end

	kv.target:AddNewModifier(self.caster, self.ability, "modifier_broodmother_spiderling_debuff_lua", {duration = self.debuff_duration * (1 - kv.target:GetStatusResistance())})
end

function modifier_broodmother_spiderling_lua:GetModifierBaseAttack_BonusDamage(kv)
	return self.buff_damage * self:GetStackCount()
end

function modifier_broodmother_spiderling_lua:GetModifierModelScale()
	return math.min(self.buff_model_size * self:GetStackCount(), self.buff_model_size_cap)
end


---------------------------------------------------------------------------------------------------------------------------------------------------------


modifier_broodmother_spiderling_debuff_lua = class({})

function modifier_broodmother_spiderling_debuff_lua:IsHidden() return false end
function modifier_broodmother_spiderling_debuff_lua:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT end

function modifier_broodmother_spiderling_debuff_lua:OnCreated(keys)
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	if not self.caster or self.caster:IsNull() then return end
	if not self.parent or self.parent:IsNull() then return end
	if not self.ability or self.ability:IsNull() then return end
end

function modifier_broodmother_spiderling_debuff_lua:OnRefresh(keys)
	self:OnCreated(keys)
end

function modifier_broodmother_spiderling_debuff_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_DEATH,
	}
end

function modifier_broodmother_spiderling_debuff_lua:OnDeath(keys)
	if not self or self:IsNull() then return end
	if not IsServer() then return end
	if keys.unit ~= self.parent then return end
	if not self.caster:GetOwner() or self.caster:GetOwner():IsNull() then return end

	local spiders = Entities:FindAllByName("npc_dota_broodmother_spiderling")
	if #spiders <= 0 then return end

	for _, spider in pairs(spiders) do
		if spider and not spider:IsNull() and spider:GetOwner() and spider:GetOwner() == self.caster:GetOwner() then
			local modifier = spider:FindModifierByName("modifier_broodmother_spiderling_lua")
			if modifier and not modifier:IsNull() then
				modifier:SetStackCount(modifier:GetStackCount() + 1)
			end
		end
	end
end