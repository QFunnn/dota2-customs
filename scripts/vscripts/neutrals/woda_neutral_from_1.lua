--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_neutral_from_1", "neutrals/woda_neutral_from_1", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_neutral_cast", "neutrals/modifier_neutral_cast", LUA_MODIFIER_MOTION_NONE)

woda_neutral_from_1 = class({})

function woda_neutral_from_1:Precache(context)
    PrecacheResource( "particle", "particles/econ/taunts/snapfire/snapfire_taunt_bubble.vpcf", context )
end

function woda_neutral_from_1:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_neutral_cast", {})
	Timers:CreateTimer(0, function()
		if not self:GetCaster():IsAlive() then return end
		if target:IsMagicImmune() then self:GetCaster():RemoveModifierByName("modifier_neutral_cast") return end
		self:GetCaster():EmitSound("n_frogs.WaterBubble.Target")
		target:AddNewModifier(self:GetCaster(), self, "modifier_woda_neutral_from_1", {duration = self:GetSpecialValueFor("duration")})
		self:GetCaster():RemoveModifierByName("modifier_neutral_cast")
	end)
end

modifier_woda_neutral_from_1 = class({})

function modifier_woda_neutral_from_1:OnCreated()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/econ/taunts/snapfire/snapfire_taunt_bubble.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt( particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetOrigin(), true )
    self:AddParticle(particle, false, false, -1, false, false)
    self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_ice_slide", {})
    self.lop_damage = self:GetAbility():GetSpecialValueFor("damage")
end

function modifier_woda_neutral_from_1:OnDestroy()
    if not IsServer() then return end
    ApplyDamage({attacker = self:GetCaster(), victim = self:GetParent(), ability = self:GetAbility(), damage = self:GetParent():GetMaxHealth() / 100 * self.lop_damage, damage_type = DAMAGE_TYPE_MAGICAL})
    self:GetParent():RemoveModifierByName("modifier_ice_slide")
    self:GetParent():EmitSound("n_frogs.WaterBubble.Destroy")
end

function modifier_woda_neutral_from_1:CheckState()
    return 
    {
        [MODIFIER_STATE_MUTED] = true,
        [MODIFIER_STATE_DISARMED] = true,
        [MODIFIER_STATE_FLYING] = true,
        [MODIFIER_STATE_SILENCED] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
        [MODIFIER_STATE_UNTARGETABLE_ENEMY] = true,
    }
end

function modifier_woda_neutral_from_1:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
    }
end

function modifier_woda_neutral_from_1:GetOverrideAnimation()
    return ACT_DOTA_FLAIL
end