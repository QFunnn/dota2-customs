--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_neutral_icegire_bomb", "neutrals/woda_neutral_icegire_bomb", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_neutral_cast", "neutrals/modifier_neutral_cast", LUA_MODIFIER_MOTION_NONE)

woda_neutral_icegire_bomb = class({})

function woda_neutral_icegire_bomb:Precache(context)
    PrecacheResource( "particle", "particles/neutral_fx/icefire_bomb.vpcf", context )
    PrecacheResource( "particle", "particles/neutral_fx/icefire_bomb_debuff.vpcf", context )
    PrecacheResource( "particle", "particles/status_fx/status_effect_burn.vpcf", context )
end

function woda_neutral_icegire_bomb:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()

	self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_neutral_cast", {})

	Timers:CreateTimer(0, function()
		if not self:GetCaster():IsAlive() then return end
		local info = {
	        EffectName = "particles/neutral_fx/icefire_bomb.vpcf",
	        Ability = self,
	        iMoveSpeed = 700,
	        Source = self:GetCaster(),
	        Target = target,
	        iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_2
	    }
    	self:GetCaster():EmitSound("n_creep_ice_shaman.IceBomb.Cast")
    	ProjectileManager:CreateTrackingProjectile( info )
		self:GetCaster():RemoveModifierByName("modifier_neutral_cast")
	end)
end

function woda_neutral_icegire_bomb:OnProjectileHit_ExtraData( target, location, ExtraData )
	if not IsServer() then return end
	if target == nil then return end
	if target:IsMagicImmune() then return end
	local duration = self:GetSpecialValueFor("duration")
	target:EmitSound("n_creep_ice_shaman.IceBomb.Target")
	target:AddNewModifier(self:GetCaster(), self, "modifier_woda_neutral_icegire_bomb", {duration = duration * (1 - target:GetStatusResistance())})
end

modifier_woda_neutral_icegire_bomb = class({})

function modifier_woda_neutral_icegire_bomb:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(1)
end

function modifier_woda_neutral_icegire_bomb:OnIntervalThink()
	if not IsServer() then return end
	local damage = self:GetParent():GetHealth() / 100 * self:GetAbility():GetSpecialValueFor("damage")
	ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
end

function modifier_woda_neutral_icegire_bomb:GetEffectName()
	return "particles/neutral_fx/icefire_bomb_debuff.vpcf"
end

function modifier_woda_neutral_icegire_bomb:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_woda_neutral_icegire_bomb:GetStatusEffectName()
	return "particles/status_fx/status_effect_burn.vpcf"
end

function modifier_woda_neutral_icegire_bomb:StatusEffectPriority()
	return 10
end