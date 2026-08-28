--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_pet_dagon_passive", "components/items/item_dagon.lua", LUA_MODIFIER_MOTION_NONE)

pet_dagon = class({})

local function DagonizeIt(caster, ability, source, target, damage)
	local dagon_pfx =
		ParticleManager:CreateParticle("particles/items_fx/dagon.vpcf", PATTACH_RENDERORIGIN_FOLLOW, source)
	ParticleManager:SetParticleControlEnt(
		dagon_pfx,
		0,
		source,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		source:GetAbsOrigin(),
		false
	)
	ParticleManager:SetParticleControlEnt(
		dagon_pfx,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		false
	)
	ParticleManager:SetParticleControl(dagon_pfx, 2, Vector(damage, 0, 0))
	ParticleManager:SetParticleControl(dagon_pfx, 3, Vector(0.3, 0, 0))
	ParticleManager:ReleaseParticleIndex(dagon_pfx)

	if target:IsAlive() then
		ApplyDamage({
			attacker = caster,
			victim = target,
			ability = ability,
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
		})
	end
end

function pet_dagon:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	if target:GetTeam() ~= caster:GetTeam() then
		if target:TriggerSpellAbsorb(self) then
			return nil
		end
	end

	if target:IsMagicImmune() then
		return nil
	end

	local damage = self:GetSpecialValueFor("damage")

	caster:EmitSound("DOTA_Item.Dagon.Activate")
	target:EmitSound("DOTA_Item.Dagon1.Target")

	if target:IsIllusion() and not Custom_bIsStrongIllusion(target) then
		target:Kill(self, caster)
	end

	DagonizeIt(caster, self, caster, target, damage)
end