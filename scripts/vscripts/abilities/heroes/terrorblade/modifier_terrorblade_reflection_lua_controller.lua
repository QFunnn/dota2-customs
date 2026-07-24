--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_terrorblade_reflection_lua_controller = modifier_terrorblade_reflection_lua_controller or class({})


function modifier_terrorblade_reflection_lua_controller:IsPurgable() return true end
function modifier_terrorblade_reflection_lua_controller:IsHidden() return true end
-- to handle rubick spell steal
function modifier_terrorblade_reflection_lua_controller:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

if not IsServer() then return end


function modifier_terrorblade_reflection_lua_controller:OnCreated(kv)
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.controlled_illusion = EntIndexToHScript(kv.controlled_illusion)

	self.attack_order_table = {
		UnitIndex = kv.controlled_illusion,
		OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
		TargetIndex = self.parent:GetEntityIndex(),
	}

	self:StartIntervalThink(0.5)
end


function modifier_terrorblade_reflection_lua_controller:OnDestroy()
	if IsValidEntity(self.controlled_illusion) then
		self.controlled_illusion:ForceKill(false)
	end
end


function modifier_terrorblade_reflection_lua_controller:OnIntervalThink()
	if not IsValidEntity(self.controlled_illusion) or not IsValidEntity(self.parent) or not IsValidEntity(self.caster) then
		self:Destroy()
		return
	end

	if not self.caster:CanEntityBeSeenByMyTeam(self.parent) then
		self.controlled_illusion:MoveToPosition(self.parent:GetAbsOrigin())
	else
		ExecuteOrderFromTable(self.attack_order_table)
	end
end