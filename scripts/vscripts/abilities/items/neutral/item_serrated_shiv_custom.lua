--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_item_serrated_shiv_custom",
	"abilities/items/neutral/item_serrated_shiv_custom",
	LUA_MODIFIER_MOTION_NONE
)

item_serrated_shiv_custom = class({})

function item_serrated_shiv_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end
	PrecacheResource("particle", "particles/items4_fx/serrated_shiv_hit.vpcf", context)
end

function item_serrated_shiv_custom:GetIntrinsicModifierName()
	if not self:GetCaster():IsRealHero() then
		return
	end
	return "modifier_item_serrated_shiv_custom"
end

function item_serrated_shiv_custom:Spawn()
	self.proc_chance = self:GetSpecialValueFor("proc_chance")
	self.damage = self:GetSpecialValueFor("damage")
	self.damage_health = self:GetSpecialValueFor("damage_health") / 100
	self.creeps_damage = self:GetSpecialValueFor("creeps_damage")
end

modifier_item_serrated_shiv_custom = class(mod_hidden)
function modifier_item_serrated_shiv_custom:RemoveOnDeath()
	return false
end
function modifier_item_serrated_shiv_custom:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.records = {}

	if not IsServer() then
		return
	end
	self.damageTable = { attacker = self.parent, ability = self.ability, damage_type = DAMAGE_TYPE_PHYSICAL }
	self:RollProc()

	self.parent:AddRecordDestroyEvent(self, true)
	self.parent:AddAttackStartEvent_out(self)
	self.parent:AddAttackEvent_out(self, true)
end

function modifier_item_serrated_shiv_custom:CheckState()
	if not IsServer() then
		return
	end
	if not IsValid(self.parent) then
		return
	end
	if not self.parent:HasCd("serrated_shiv_proc", 3) then
		return
	end
	return {
		[MODIFIER_STATE_CANNOT_MISS] = true,
	}
end

function modifier_item_serrated_shiv_custom:RecordDestroyEvent(params)
	if not self.records[params.record] then
		return
	end
	self.records[params.record] = nil
end

function modifier_item_serrated_shiv_custom:RollProc()
	if not IsServer() then
		return
	end
	if not RollPseudoRandomPercentage(self.ability.proc_chance, 7417, self.parent) then
		return
	end

	self.parent:StartCd("serrated_shiv_proc")
end

function modifier_item_serrated_shiv_custom:AttackStartEvent_out(params)
	if not IsServer() then
		return
	end
	if not IsValid(self.ability) then
		return
	end
	if not params.target:IsUnit() then
		return
	end
	if self.parent ~= params.attacker then
		return
	end
	if params.target:GetTeamNumber() == self.parent:GetTeamNumber() then
		return
	end

	if self.parent:HasCd("serrated_shiv_proc", 3) and self.ability:IsFullyCastable() then
		self.records[params.record] = true
		self.ability:StartCd()
	end

	self.parent:RemoveCd("serrated_shiv_proc")
	self:RollProc()
end

function modifier_item_serrated_shiv_custom:AttackEvent_out(params)
	if not IsServer() then
		return
	end
	if not IsValid(self.ability) then
		return
	end
	if not params.target:IsUnit() then
		return
	end
	if self.parent ~= params.attacker then
		return
	end
	if not self.records[params.record] then
		return
	end

	local target = params.target
	self.damageTable.victim = target
	self.damageTable.damage = target:IsCreep() and self.ability.creeps_damage
		or self.ability.damage + target:GetHealth() * self.ability.damage_health
	local real_damage = DoDamage(self.damageTable)
	target:SendNumber(115, real_damage)

	target:EmitSound("item_serrated_shiv")
	local particle =
		ParticleManager:CreateParticle("particles/items4_fx/serrated_shiv_hit.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControlEnt(
		particle,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		particle,
		3,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.parent:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(particle)
end