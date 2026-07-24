--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



modifier_vengefulspirit_command_aura_scepter_debuff_lua = class({})

function modifier_vengefulspirit_command_aura_scepter_debuff_lua:IsHidden() return false end
function modifier_vengefulspirit_command_aura_scepter_debuff_lua:IsDebuff() return true end
function modifier_vengefulspirit_command_aura_scepter_debuff_lua:IsPurgable() return false end

function modifier_vengefulspirit_command_aura_scepter_debuff_lua:OnCreated(keys)
	self.parent = self:GetParent()
	if not IsValidEntity(self.parent) then return end
	self.ability = self:GetAbility()
	if not IsValidEntity(self.ability) then return end
end

function modifier_vengefulspirit_command_aura_scepter_debuff_lua:OnRefresh(keys)
	self:OnCreated(keys)
end

function modifier_vengefulspirit_command_aura_scepter_debuff_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_DEATH,
	}
end

function modifier_vengefulspirit_command_aura_scepter_debuff_lua:OnDeath(event)
	if not self or self:IsNull() then return end
	if not IsServer() then return end
	if not IsValidEntity(self.parent) then return end
	if not IsValidEntity(self.ability) then return end
	if event.unit ~= self.parent then return end

	Timers:CreateTimer(0.1, function()
		local illusions = FindUnitsInRadius(
			self.parent:GetTeamNumber(),
			self.parent:GetAbsOrigin(),
			nil,
			-1,
			DOTA_UNIT_TARGET_TEAM_FRIENDLY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		for _, illusion in pairs(illusions) do
			if IsValidEntity(illusion) and
			illusion:IsIllusion() and
			illusion:GetPlayerOwnerID() == self.parent:GetPlayerOwnerID() and
			illusion:HasModifier("modifier_vengefulspirit_hybrid_special") then
				illusion:RemoveSelf()
			end
		end
	end)
end