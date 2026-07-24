--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_spectre_haunt_lua = modifier_spectre_haunt_lua or class({})


function modifier_spectre_haunt_lua:IsHidden() return true end
function modifier_spectre_haunt_lua:IsPurgable() return false end


function modifier_spectre_haunt_lua:OnCreated(kv)
	if not IsServer() then return end

	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.target = EntIndexToHScript(kv.target)

	self.attack_order_table = {
		UnitIndex = self.parent:GetEntityIndex(),
		OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
		TargetIndex = kv.target,
	}

	self:StartIntervalThink(0.1)
end


function modifier_spectre_haunt_lua:OnIntervalThink()
	if not IsServer() then return end

	if not IsValidEntity(self.target) or not self.target:IsAlive() then
		if IsValidEntity(self.parent) then
			self.parent:ForceKill(false)
		end
		self:Destroy()
		return
	end

	-- follow unit if invis, otherwise attack
	if not self.caster:CanEntityBeSeenByMyTeam(self.target) then
		self.parent:MoveToPosition(self.target:GetAbsOrigin())
	else
		ExecuteOrderFromTable(self.attack_order_table)
	end
end


function modifier_spectre_haunt_lua:CheckState()
	return {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}
end