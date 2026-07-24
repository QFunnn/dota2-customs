--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_cha_vision_icon", "modifiers/modifier_cha_vision.lua", LUA_MODIFIER_MOTION_NONE )

modifier_cha_vision = class({})

function modifier_cha_vision:IsHidden() return true end
function modifier_cha_vision:IsPurgeException() return false end
function modifier_cha_vision:IsPurgable() return false end
function modifier_cha_vision:RemoveOnDeath() return false end

function modifier_cha_vision:OnCreated()
	if not IsServer() then return end
    self.icon = CreateUnitByName("npc_unit_portrait_test", self:GetParent():GetAbsOrigin(), false, nil, nil, self:GetCaster():GetTeamNumber())
    self.icon:AddNewModifier(self:GetParent(), nil, "modifier_cha_vision_icon", {})
    self:StartIntervalThink(FrameTime())
end

function modifier_cha_vision:OnIntervalThink()
    if not IsServer() then return end
    self.icon:SetAbsOrigin(self:GetParent():GetAbsOrigin())
    CustomGameEventManager:Send_ServerToAllClients("set_player_icon", { entity = self.icon:entindex(), hero = self:GetCaster():entindex() })
end

function modifier_cha_vision:OnDestroy()
	if not IsServer() then return end
	if self.icon and not self.icon:IsNull() then
		UTIL_Remove(self.icon)
        self.icon = nil
	end
end

modifier_cha_vision_icon = class({})

function modifier_cha_vision_icon:IsPurgable() return false end
function modifier_cha_vision_icon:IsHidden() return true end

function modifier_cha_vision_icon:CheckState()
    return {
        [MODIFIER_STATE_NOT_ON_MINIMAP] = (not self:GetCaster():IsAlive() or self:GetCaster():IsInvisible() or self:GetCaster():IsNull()),
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_OUT_OF_GAME] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_STUNNED] = true,
        [MODIFIER_STATE_ROOTED] = true,
        [MODIFIER_STATE_INVISIBLE] = self:GetCaster():IsInvisible(),
        [MODIFIER_STATE_MAGIC_IMMUNE] = true,
        [MODIFIER_STATE_ATTACK_IMMUNE] = true,
        [MODIFIER_STATE_PROVIDES_VISION] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
    }
end

function modifier_cha_vision_icon:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
        MODIFIER_PROPERTY_PROVIDES_FOW_POSITION
    }

    return funcs
end

function modifier_cha_vision_icon:GetAbsoluteNoDamagePhysical()
    return 1
end

function modifier_cha_vision_icon:GetAbsoluteNoDamageMagical()
    return 1
end

function modifier_cha_vision_icon:GetAbsoluteNoDamagePure()
    return 1
end

function modifier_cha_vision_icon:GetModifierProvidesFOWVision()
    return 1
end