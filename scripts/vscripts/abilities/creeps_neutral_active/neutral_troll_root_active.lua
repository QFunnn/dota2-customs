--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_troll_root_active_effect",
	"abilities/creeps_neutral_active/neutral_troll_root_active",
	LUA_MODIFIER_MOTION_NONE
)

neutral_troll_root_active = class({})

function neutral_troll_root_active:Precache(context)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_troll_warlord/troll_warlord_bersekers_net_projectile.vpcf",
		context
	)
	PrecacheResource("particle", "particles/units/heroes/hero_troll_warlord/troll_warlord_bersekers_net.vpcf", context)
end

function neutral_troll_root_active:OnSpellStart()
	self.caster:EmitSound("n_creep_TrollWarlord.Ensnare")

	local info = {
		Target = self:GetCursorTarget(),
		Source = self.caster,
		Ability = self,
		EffectName = "particles/units/heroes/hero_troll_warlord/troll_warlord_bersekers_net_projectile.vpcf",
		iMoveSpeed = self:GetSpecialValueFor("speed"),
		bReplaceExisting = false,
		bProvidesVision = true,
		iVisionRadius = 450,
		iVisionTeamNumber = self.caster:GetTeamNumber(),
	}
	ProjectileManager:CreateTrackingProjectile(info)
end

function neutral_troll_root_active:OnProjectileHit(target, location)
	if not IsServer() then
		return
	end
	if not target then
		return
	end
	if target:TriggerSpellAbsorb(self) then
		return
	end

	target:EmitSound("Hero_Meepo.Earthbind.Target")
	target:AddNewModifier(
		self.caster,
		self,
		"modifier_troll_root_active_effect",
		{ duration = self:GetSpecialValueFor("duration") * (1 - target:GetStatusResistance()) }
	)
end

modifier_troll_root_active_effect = class(mod_hidden)
function modifier_troll_root_active_effect:IsPurgable()
	return true
end
function modifier_troll_root_active_effect:OnCreated()
	self.parent = self:GetParent()

	self.parent:GenericParticle("particles/units/heroes/hero_troll_warlord/troll_warlord_bersekers_net.vpcf", self)
end

function modifier_troll_root_active_effect:CheckState()
	return {
		[MODIFIER_STATE_ROOTED] = true,
	}
end