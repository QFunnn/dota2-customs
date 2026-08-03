--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 06:18:41 UTC
  ~ auto-generated — do not edit
]]


modifier_generic_root_lua = class({})

function modifier_generic_root_lua:IsDebuff()
	return true
end

function modifier_generic_root_lua:ShouldIgnoreControlImmunity(kv)
	return tonumber(kv and kv.levelup_ignore_control_immunity) == 1
end

function modifier_generic_root_lua:OnCreated(kv)
	if not IsServer() then
		return
	end
	self.levelup_ignore_control_immunity = self:ShouldIgnoreControlImmunity(kv)
	if
		not self.levelup_ignore_control_immunity
		and IsLevelUpControlImmuneUnit
		and IsLevelUpControlImmuneUnit(self:GetParent())
	then
		self:Destroy()
		return
	end

	local base_duration = tonumber(kv and kv.duration)
	if base_duration then
		local resist = 1 - self:GetParent():GetStatusResistance()
		self:SetDuration(base_duration * resist, true)
	end

	local pfx_name = kv and kv.particle or nil
	if pfx_name and pfx_name ~= "" then
		self.particle = LevelUpParticleManager:CreateParticle(pfx_name, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	end
end

function modifier_generic_root_lua:OnRefresh(kv)
	if not IsServer() then
		return
	end
	self.levelup_ignore_control_immunity = self.levelup_ignore_control_immunity or self:ShouldIgnoreControlImmunity(kv)
	if
		not self.levelup_ignore_control_immunity
		and IsLevelUpControlImmuneUnit
		and IsLevelUpControlImmuneUnit(self:GetParent())
	then
		self:Destroy()
		return
	end

	local base_duration = tonumber(kv and kv.duration)
	if base_duration then
		local resist = 1 - self:GetParent():GetStatusResistance()
		self:SetDuration(base_duration * resist, true)
	end
end

function modifier_generic_root_lua:OnDestroy()
	if not IsServer() then
		return
	end
	if self.particle then
		LevelUpParticleManager:DestroyParticle(self.particle, false)
		LevelUpParticleManager:ReleaseParticleIndex(self.particle)
		self.particle = nil
	end
end

function modifier_generic_root_lua:CheckState()
	return {
		[MODIFIER_STATE_ROOTED] = true,
	}
end