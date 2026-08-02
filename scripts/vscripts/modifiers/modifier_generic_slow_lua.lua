--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_generic_slow_lua = class({})

function modifier_generic_slow_lua:IsDebuff()
	return true
end
function modifier_generic_slow_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_generic_slow_lua:ShouldIgnoreControlImmunity(kv)
	return tonumber(kv and kv.levelup_ignore_control_immunity) == 1
end

-- Боссы (control-immune units) не должны замедляться обычными debuff-источниками,
-- как и для stun/root. Caller может выставить levelup_ignore_control_immunity = 1.
function modifier_generic_slow_lua:OnCreated(kv)
	self.levelup_ignore_control_immunity = self:ShouldIgnoreControlImmunity(kv)
	if
		IsServer()
		and not self.levelup_ignore_control_immunity
		and IsLevelUpControlImmuneUnit
		and IsLevelUpControlImmuneUnit(self:GetParent())
	then
		self:Destroy()
		return
	end

	local raw_slow_pct = kv and kv.slow_pct or 0
	self.slow_pct = math.max(0, raw_slow_pct)
end

function modifier_generic_slow_lua:OnRefresh(kv)
	self.levelup_ignore_control_immunity = self.levelup_ignore_control_immunity or self:ShouldIgnoreControlImmunity(kv)
	if
		IsServer()
		and not self.levelup_ignore_control_immunity
		and IsLevelUpControlImmuneUnit
		and IsLevelUpControlImmuneUnit(self:GetParent())
	then
		self:Destroy()
		return
	end

	local raw_slow_pct = kv and kv.slow_pct or 0
	self.slow_pct = math.max(0, raw_slow_pct)
end

function modifier_generic_slow_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_generic_slow_lua:GetModifierMoveSpeedBonus_Percentage()
	return -self.slow_pct
end