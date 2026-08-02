--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_breakable_container", "abilities/breakable_container", LUA_MODIFIER_MOTION_NONE)

breakable_container = class({})

function breakable_container:GetIntrinsicModifierName()
	return "modifier_breakable_container"
end

------------------------------------------------------------------------------

modifier_breakable_container = class({})

function modifier_breakable_container:IsHidden()
	return true
end

function modifier_breakable_container:OnCreated(kv)
	if IsServer() then
		if self:GetParent():GetUnitName() == "npc_dota_crate" then
			self:GetParent():SetModelScale(RandomFloat(0.6, 0.9))
			self:GetParent():SetRenderColor(139, 249, 255)
		elseif self:GetParent():GetUnitName() == "npc_dota_vase" then
			self:GetParent():SetModelScale(RandomFloat(0.3, 0.6))
		end
	end
end

function modifier_breakable_container:CheckState()
	local state = {
		[MODIFIER_STATE_LOW_ATTACK_PRIORITY] = true,
	}
	if IsServer() then
		state[MODIFIER_STATE_ROOTED] = true
		state[MODIFIER_STATE_NO_HEALTH_BAR] = true
		state[MODIFIER_STATE_BLIND] = true
		state[MODIFIER_STATE_NOT_ON_MINIMAP] = true
	end
	return state
end

function modifier_breakable_container:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_PROPERTY_PROVIDES_FOW_POSITION,
	}
	return funcs
end

function modifier_breakable_container:GetModifierProvidesFOWVision(params)
	return 1
end

function modifier_breakable_container:OnDeath(params)
	if IsServer() then
		if params.unit == self:GetParent() then
			if self:GetParent():GetUnitName() == "npc_dota_crate" then
				if RandomInt(0, 1) >= 1 then
					EmitSoundOn("Dungeon.SmashCrateShort", self:GetParent())
				else
					EmitSoundOn("Dungeon.SmashCrateLong", self:GetParent())
				end
			elseif self:GetParent():GetUnitName() == "npc_dota_vase" then
				EmitSoundOn("Dungeon.VaseBreak", self:GetParent())
			end
		end
	end
end