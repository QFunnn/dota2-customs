--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


modifier_generic_stunned_lua = class({})
function modifier_generic_stunned_lua:IsDebuff()
	return true
end
function modifier_generic_stunned_lua:IsStunDebuff()
	return true
end

local function read_bool(value)
	return value == true or value == 1 or value == "1" or value == "true"
end

function modifier_generic_stunned_lua:OnCreated(kv)
	self.status_effect = kv and kv.status_effect or nil
	self.status_effect_priority = tonumber(kv and kv.status_effect_priority) or MODIFIER_PRIORITY_NORMAL
	self.is_frozen = read_bool(kv and kv.frozen)
	if not IsServer() then
		return
	end
	if IsLevelUpControlImmuneUnit and IsLevelUpControlImmuneUnit(self:GetParent()) then
		self:Destroy()
		return
	end
	local pfx_name = kv.particle or "particles/generic_gameplay/generic_stunned.vpcf"
	local base_duration = tonumber(kv and kv.duration)
	if base_duration then
		local resist = 1 - self:GetParent():GetStatusResistance()
		self:SetDuration(base_duration * resist, true)
	end
	if pfx_name and pfx_name ~= "none" then
		self.particle = LevelUpParticleManager:CreateParticle(pfx_name, PATTACH_OVERHEAD_FOLLOW, self:GetParent())
	end
end

function modifier_generic_stunned_lua:OnRefresh(kv)
	self.status_effect = kv and kv.status_effect or self.status_effect
	self.status_effect_priority = tonumber(kv and kv.status_effect_priority)
		or self.status_effect_priority
		or MODIFIER_PRIORITY_NORMAL
	if kv and kv.frozen ~= nil then
		self.is_frozen = read_bool(kv.frozen)
	end
	if not IsServer() then
		return
	end
	if IsLevelUpControlImmuneUnit and IsLevelUpControlImmuneUnit(self:GetParent()) then
		self:Destroy()
		return
	end
	local base_duration = tonumber(kv and kv.duration)
	if base_duration then
		local resist = 1 - self:GetParent():GetStatusResistance()
		self:SetDuration(base_duration * resist, true)
	end
end

function modifier_generic_stunned_lua:OnDestroy()
	if not IsServer() then
		return
	end
	if self.particle then
		LevelUpParticleManager:DestroyParticle(self.particle, false)
		LevelUpParticleManager:ReleaseParticleIndex(self.particle)
		self.particle = nil
	end
end

function modifier_generic_stunned_lua:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_FROZEN] = self.is_frozen == true,
	}
end

function modifier_generic_stunned_lua:DeclareFunctions()
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end

function modifier_generic_stunned_lua:GetOverrideAnimation()
	return ACT_DOTA_DISABLED
end

function modifier_generic_stunned_lua:GetStatusEffectName()
	if self.status_effect and self.status_effect ~= "" and self.status_effect ~= "none" then
		return self.status_effect
	end
	return nil
end

function modifier_generic_stunned_lua:StatusEffectPriority()
	return self.status_effect_priority or MODIFIER_PRIORITY_NORMAL
end