--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_aluneth_root", "item_ability/item_aluneth.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_stargazing_staff", "item_ability/item_stargazing_staff.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_stargazing_staff_cd", "item_ability/item_stargazing_staff.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_stargazing_staff_debuff", "item_ability/item_stargazing_staff.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_stargazing_staff_buff", "item_ability/item_stargazing_staff.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if item_aluneth == nil then
	item_aluneth = class({})
end
function item_aluneth:GetIntrinsicModifierName()
	return "modifier_item_stargazing_staff"
end
function item_aluneth:GetAOERadius()
	return self:GetSpecialValueFor("debuff_radius")
end
function item_aluneth:OnSpellStart()
	local hCaster = self:GetCaster()
	local vPos = self:GetCursorPosition()
	local debuff_radius = self:GetSpecialValueFor("debuff_radius")
	local debuff_duration = self:GetSpecialValueFor("debuff_duration")
	local root_duration = self:GetSpecialValueFor("root_duration")

	if IsValid(hCaster) then
		local particleID = ParticleManager:CreateParticle("particles/items2_fx/veil_of_discord.vpcf", PATTACH_WORLDORIGIN, hCaster)
		ParticleManager:SetParticleControl(particleID, 0, vPos)
		ParticleManager:SetParticleControl(particleID, 1, Vector(debuff_radius, 0, 0))
		ParticleManager:ReleaseParticleIndex(particleID)

		local units = FindUnitsInRadius(hCaster:GetTeamNumber(), vPos, nil, debuff_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
		for _, unit in pairs(units) do
			if IsValid(unit) and unit:IsAlive() then
				unit:AddNewModifier(hCaster, self, "modifier_item_stargazing_staff_debuff", { duration = debuff_duration * unit:GetStatusResistanceFactor(hCaster) })
				unit:AddNewModifier(hCaster, self, "modifier_item_aluneth_root", { duration = root_duration * unit:GetStatusResistanceFactor(hCaster) })
				EmitSoundOn("DOTA_Item.RodOfAtos.Target", unit)
			end
		end
		EmitSoundOn("DOTA_Item.VeilofDiscord.Activate", hCaster)
	end

end
---------------------------------------------------------------------
--Modifiers
if modifier_item_aluneth_root == nil then
	modifier_item_aluneth_root = class({})
end
function modifier_item_aluneth_root:IsHidden()
	return false
end
function modifier_item_aluneth_root:IsDebuff()
	return true
end
function modifier_item_aluneth_root:IsPurgable()
	return true
end
function modifier_item_aluneth_root:IsPurgeException()
	return true
end
function modifier_item_aluneth_root:OnCreated(params)
	if IsServer() then
		self.mana = 0
		local hParent = self:GetParent()
		local hAbility = self:GetAbility()
		if IsValid(hParent) and not hParent:IsConsideredHero() and hParent:GetMana() > 0 then
			self.mana = hParent:GetMana()
			SendOverheadEventMessage(nil, OVERHEAD_ALERT_MANA_LOSS, hParent, hParent:GetMana(), nil)
			hParent:Script_ReduceMana(hParent:GetMana(), hAbility)
		end
	end
end
function modifier_item_aluneth_root:OnRefresh(params)
	if IsServer() then
		local hParent = self:GetParent()
		local hAbility = self:GetAbility()
		if not hParent:IsConsideredHero() then
			self.mana = self.mana + hParent:GetMana()
			SendOverheadEventMessage(nil, OVERHEAD_ALERT_MANA_LOSS, hParent, hParent:GetMana(), nil)
			hParent:Script_ReduceMana(hParent:GetMana(), hAbility)
		end
	end
end
function modifier_item_aluneth_root:OnDestroy(params)
	if IsServer() then
		local hParent = self:GetParent()
		if IsValid(hParent) and self.mana > 0 then
			hParent:GiveMana(self.mana)
			SendOverheadEventMessage(nil, OVERHEAD_ALERT_MANA_ADD, hParent, self.mana, nil)
		end
	end
end
function modifier_item_aluneth_root:CheckState()
	return {
		[MODIFIER_STATE_ROOTED] = true,
	}
end
function modifier_item_aluneth_root:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_item_aluneth_root:GetEffectName()
	return "particles/items2_fx/rod_of_atos.vpcf"
end