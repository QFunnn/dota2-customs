--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 05:45:25 UTC
  ~ auto-generated — do not edit
]]


custom_twin_gate_portal_warp = custom_twin_gate_portal_warp or class({})

function custom_twin_gate_portal_warp:GetManaCost(level)
	return 0
end

function custom_twin_gate_portal_warp:GetCooldown(level)
	return 0
end

function custom_twin_gate_portal_warp:GetChannelAnimation()
	return ACT_DOTA_GENERIC_CHANNEL_1
end

function custom_twin_gate_portal_warp:CastFilterResultTarget(target)
	local caster = self:GetCaster()
	if custom_twin_gate and custom_twin_gate.CanHeroUsePortal and custom_twin_gate:CanHeroUsePortal(caster, target) then
		return UF_SUCCESS
	end
	return UF_FAIL_CUSTOM
end

function custom_twin_gate_portal_warp:GetCustomCastErrorTarget(target)
	return "#dota_hud_error_cant_use_twin_gate"
end

function custom_twin_gate_portal_warp:CleanupPortalChannel()
	if IsValid(self.target) then
		self.target:RemoveGesture(ACT_DOTA_CHANNEL_ABILITY_1)
		self.target:StopSound("TwinGate.Channel")
	end
	if IsValid(self.pair) then
		self.pair:RemoveGesture(ACT_DOTA_CHANNEL_ABILITY_1)
		self.pair:StopSound("TwinGate.Channel")
	end
end

function custom_twin_gate_portal_warp:OnSpellStart()
	self.target = self:GetCursorTarget()
	self.pair = custom_twin_gate and custom_twin_gate:GetTwinTeleport(self.target) or nil

	if not IsValid(self.target, self.pair) or not custom_twin_gate:CanHeroUsePortal(self:GetCaster(), self.target) then
		self.target = nil
		self.pair = nil
		self:GetCaster():Interrupt()
		return
	end

	self.target:StartGestureFadeWithSequenceSettings(ACT_DOTA_CHANNEL_ABILITY_1)
	self.pair:StartGestureFadeWithSequenceSettings(ACT_DOTA_CHANNEL_ABILITY_1)
	self.target:EmitSound("TwinGate.Channel")
	self.pair:EmitSound("TwinGate.Channel")
end

function custom_twin_gate_portal_warp:OnChannelFinish(interrupted)
	local caster = self:GetCaster()
	local target = self.target
	local pair = self.pair

	self:CleanupPortalChannel()
	self.target = nil
	self.pair = nil

	if interrupted then
		return
	end
	if not IsValid(caster, target, pair) then
		return
	end
	if not custom_twin_gate or not custom_twin_gate:CanHeroUsePortal(caster, target) then
		return
	end

	local pair_meta = custom_twin_gate:GetPortalMeta(pair)

	EmitSoundOnLocationWithCaster(target:GetAbsOrigin(), "TwinGate.Channel.End", caster)

	local offset = tonumber(self:GetSpecialValueFor("teleport_offset")) or 80
	local direction = pair:GetForwardVector()
	if not (pair_meta and pair_meta.is_island_portal == true) then
		direction = direction * -1
	end
	local pos = pair:GetAbsOrigin() + direction * offset
	FindClearSpaceForUnit(caster, pos, true)
	if wave_manager and wave_manager.FocusPlayerCameraOnHero then
		wave_manager:FocusPlayerCameraOnHero(caster)
	end
	if pair_meta then
		custom_twin_gate:SetHeroIslandState(caster, pair_meta.is_island_portal == true)
	end

	EmitSoundOnLocationWithCaster(pair:GetAbsOrigin(), "TwinGate.Teleport.Appear", caster)
end