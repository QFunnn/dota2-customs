--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_techies_death_passive", "abilities/creeps_lane/npc_techies_death", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_techies_death_passive_death",
	"abilities/creeps_lane/npc_techies_death",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier("modifier_techies_death_debuf", "abilities/creeps_lane/npc_techies_death", LUA_MODIFIER_MOTION_NONE)

npc_techies_death = class({})

function npc_techies_death:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_techies/techies_blast_off.vpcf", context)
	PrecacheResource("particle", "particles/generic_gameplay/generic_disarm.vpcf", context)
end

function npc_techies_death:GetIntrinsicModifierName()
	return "modifier_techies_death_passive"
end

modifier_techies_death_passive = class(mod_hidden)
function modifier_techies_death_passive:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.damage = self.ability:GetSpecialValueFor("damage")
	self.ability.duration = self.ability:GetSpecialValueFor("duration")
	self.ability.radius = self.ability:GetSpecialValueFor("radius")

	self.parent:AddNewModifier(self.parent, self.ability, "modifier_techies_death_passive_death", {})
end

modifier_techies_death_passive_death = class(mod_hidden)
function modifier_techies_death_passive_death:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
end

function modifier_techies_death_passive_death:OnDestroy()
	if not IsServer() then
		return
	end
	if self.parent:IsAlive() then
		return
	end
	if self.parent:HasModifier("modifier_death") then
		return
	end

	self.parent:EmitSound("Hero_Techies.Suicide")

	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_techies/techies_blast_off.vpcf",
		PATTACH_WORLDORIGIN,
		self.parent
	)
	ParticleManager:SetParticleControl(particle, 0, self.parent:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle)

	for _, target in pairs(self.parent:FindTargets(self.ability.radius)) do
		if target:GetTeam() ~= DOTA_TEAM_NEUTRALS and not target:IsBuilding() then
			target:AddNewModifier(
				self.parent,
				self.ability,
				"modifier_techies_death_debuf",
				{ duration = self.ability.duration * (1 - target:GetStatusResistance()) }
			)
			DoDamage({
				victim = target,
				attacker = self.parent,
				damage = self.ability.damage,
				damage_type = DAMAGE_TYPE_PURE,
				ability = self.ability,
			})
		end
	end
end

modifier_techies_death_debuf = class(mod_visible)
function modifier_techies_death_debuf:IsPurgable()
	return true
end
function modifier_techies_death_debuf:GetEffectName()
	return "particles/generic_gameplay/generic_disarm.vpcf"
end
function modifier_techies_death_debuf:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
function modifier_techies_death_debuf:CheckState()
	return { [MODIFIER_STATE_DISARMED] = true }
end