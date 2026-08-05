--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_trade_meepo_aura", "modifiers/modifier_trade_meepo", LUA_MODIFIER_MOTION_NONE)

if modifier_trade_meepo == nil then
	modifier_trade_meepo = class({})
end

-- function modifier_trade_meepo:OnCreated()
-- self:StartIntervalThink(0.1)
-- end

-- function modifier_trade_meepo:OnIntervalThink(kv)
-- if not _G.game_start then
-- if not self.particleLeader then
-- self.particleLeader = ParticleManager:CreateParticle( "particles/econ/events/frostivus_2023/high_five_mug_overhead_model.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetCaster())
-- ParticleManager:SetParticleControl(self.particleLeader, 0, self:GetCaster():GetAbsOrigin())
-- ParticleManager:SetParticleControl(self.particleLeader, 1, self:GetCaster():GetAbsOrigin())
-- ParticleManager:SetParticleControl(self.particleLeader, 2, self:GetCaster():GetAbsOrigin())
-- end
-- else
-- if self.particleLeader then
-- ParticleManager:DestroyParticle(self.particleLeader, true)
-- ParticleManager:ReleaseParticleIndex(self.particleLeader)
-- self.particleLeader = nil
-- end
-- end
-- end

function modifier_trade_meepo:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DISABLE_AUTOATTACK,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
		MODIFIER_PROPERTY_MIN_HEALTH,
	}
	return funcs
end

function modifier_trade_meepo:CheckState()
	local state = {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = false,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_LOW_ATTACK_PRIORITY] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_UNTARGETABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = false,
	}
	return state
end

function modifier_trade_meepo:GetAbsoluteNoDamageMagical()
	return 1
end

function modifier_trade_meepo:GetAbsoluteNoDamagePhysical()
	return 1
end

function modifier_trade_meepo:GetAbsoluteNoDamagePure()
	return 1
end

function modifier_trade_meepo:GetMinHealth()
	return 1
end

function modifier_trade_meepo:IsHidden()
	return true
end

function modifier_trade_meepo:IsAura()
	return true
end

function modifier_trade_meepo:GetModifierAura()
	return "modifier_trade_meepo_aura"
end

function modifier_trade_meepo:GetAuraRadius()
	return 250
end

function modifier_trade_meepo:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO
end

function modifier_trade_meepo:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_trade_meepo:GetAuraDuration()
	return 0.1
end

--------------------------------

if modifier_trade_meepo_aura == nil then
	modifier_trade_meepo_aura = class({})
end

function modifier_trade_meepo_aura:IsHidden()
	return true
end

function modifier_trade_meepo_aura:OnCreated(t)
	if IsServer() then
		self.pid = self:GetParent():GetPlayerOwnerID()
		if not _G.game_start then
			-- CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self.pid),"ActivateTrade",{})
		end
	end
end

function modifier_trade_meepo_aura:OnDestroy(t)
	if IsServer() then
		-- CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self.pid),"DeactivateTrade",{})
	end
end