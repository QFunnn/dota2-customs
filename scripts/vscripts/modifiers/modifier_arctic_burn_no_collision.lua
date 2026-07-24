--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- [A61] Winter Wyvern Arctic Burn (ВАНИЛЬНЫЙ) даёт полёт через движковый
-- modifier_winter_wyvern_arctic_burn_flight — его править нельзя. Из-за полёта Wyvern запирала
-- наземного врага в дуэли (коллизия летающего остаётся на земле). Постоянный вотчер на Wyvern
-- (вешается в Players:OnNPCSpawned) включает NO_UNIT_COLLISION на время полёта: по наличию
-- флайт-модификатора добавляет/снимает state-подмодификатор с NO_UNIT_COLLISION.
LinkLuaModifier("modifier_arctic_burn_no_collision_state", "modifiers/modifier_arctic_burn_no_collision", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_infinite_form_mana_drain", "modifiers/modifier_infinite_form_mana_drain", LUA_MODIFIER_MOTION_NONE)

modifier_arctic_burn_no_collision = class({})

function modifier_arctic_burn_no_collision:IsHidden() return true end
function modifier_arctic_burn_no_collision:IsPurgable() return false end
function modifier_arctic_burn_no_collision:IsPurgeException() return false end
function modifier_arctic_burn_no_collision:RemoveOnDeath() return false end

function modifier_arctic_burn_no_collision:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(0.5)
end

function modifier_arctic_burn_no_collision:OnIntervalThink()
	if not IsServer() then return end
	local p = self:GetParent()
	if not p or p:IsNull() then return end

	-- Вотчер висит на КАЖДОМ герое (гарантия привязки) → early-return, если это не Wyvern с Arctic Burn.
	local ab = p:FindAbilityByName("winter_wyvern_arctic_burn")
	if not ab or ab:IsNull() then return end

	-- Коллизия: снимаем блокировку наземных на время полёта.
	local bFlying = p:HasModifier("modifier_winter_wyvern_arctic_burn_flight")
	local bHasState = p:HasModifier("modifier_arctic_burn_no_collision_state")
	if bFlying and not bHasState then
		p:AddNewModifier(p, nil, "modifier_arctic_burn_no_collision_state", {})
	elseif not bFlying and bHasState then
		p:RemoveModifierByName("modifier_arctic_burn_no_collision_state")
	end

	-- [MF-16] Дрейн 3%/сек. Детект по GetToggleState — аганим-Arctic Burn это НАСТОЯЩИЙ toggle
	-- (подтверждено Liquipedia), поэтому не зависим от имени флайт-модификатора. EXTERNAL-режим:
	-- дрейн только тратит, а присутствием/выключением рулим ЗДЕСЬ. Нет маны → ToggleAbility (выключит
	-- форму). Handle храним, чтобы не плодить MULTIPLE-копии.
	local bActive = ab.GetToggleState and ab:GetToggleState()
	if bActive then
		local cost = p:GetMaxMana() * 0.03 * 0.5
		if p:GetMana() < cost and ab.ToggleAbility then ab:ToggleAbility() end
		if not self.arcticDrain or self.arcticDrain:IsNull() then
			self.arcticDrain = p:AddNewModifier(p, ab, "modifier_infinite_form_mana_drain", {external = 1})
		end
	else
		if self.arcticDrain and not self.arcticDrain:IsNull() then
			self.arcticDrain:Destroy()
		end
		self.arcticDrain = nil
	end
end

modifier_arctic_burn_no_collision_state = class({})

function modifier_arctic_burn_no_collision_state:IsHidden() return true end
function modifier_arctic_burn_no_collision_state:IsPurgable() return false end
function modifier_arctic_burn_no_collision_state:IsPurgeException() return false end

function modifier_arctic_burn_no_collision_state:CheckState()
	return
	{
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end