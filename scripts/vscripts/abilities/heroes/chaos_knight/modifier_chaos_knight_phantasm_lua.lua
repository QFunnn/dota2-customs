--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_chaos_knight_phantasm_lua = modifier_chaos_knight_phantasm_lua or class({})


function modifier_chaos_knight_phantasm_lua:IsHidden() return true end
function modifier_chaos_knight_phantasm_lua:IsPurgable() return false end


function modifier_chaos_knight_phantasm_lua:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end


if not IsServer() then return end


function modifier_chaos_knight_phantasm_lua:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.parent:EmitSound("Hero_ChaosKnight.Phantasm")

	local particle_name = ParticleManager:GetParticleReplacement("particles/units/heroes/hero_chaos_knight/chaos_knight_phantasm.vpcf", self.parent)

	local phantasm_particle = ParticleManager:CreateParticle(particle_name, PATTACH_ABSORIGIN, self.parent)
	ParticleManager:SetParticleControl(phantasm_particle, 0, self.parent:GetAbsOrigin())

	self.parent:Purge(false, true, false, false, false)
	self.parent:Stop()
	ProjectileManager:ProjectileDodge(self.parent)

	self:AddParticle(phantasm_particle, false, false, 1, false, false)
end


function modifier_chaos_knight_phantasm_lua:OnDestroy()
	if not IsValidEntity(self.ability) or not IsValidEntity(self.parent) then return end

	local parent_origin = self.parent:GetAbsOrigin()

	local distance = 150

	local parent_right_offset = self.parent:GetRightVector() * distance
	local parent_forward_offset = self.parent:GetForwardVector() * distance

	local images_count = self.ability:GetSpecialValueFor("images_count")
	local ally_image_count = self.ability:GetSpecialValueFor("ally_image_count")
	local illusion_duration = self.ability:GetSpecialValueFor("illusion_duration")

	images_count = images_count + ally_image_count

	for _, illusion in pairs(self.ability.illusions or {}) do
		if IsValidEntity(illusion) and illusion:IsAlive() then
			illusion:ForceKill(false)
		end
	end

	self.ability.illusions = {}

	local illusions = self.ability:CreateIllusionsAt(self.parent, images_count, illusion_duration)

	-- randomize positions in "+" formation
	local positions = table.shuffle({
		parent_origin, 							-- center
		parent_origin + parent_right_offset,	-- right
		parent_origin - parent_right_offset,	-- left
		parent_origin + parent_forward_offset,	-- forward
		parent_origin - parent_forward_offset	-- back
	})

	self.parent:SetOrigin(positions[1])

	for index, illusion in pairs(illusions or {}) do
		illusion:SetOrigin(positions[index + 1])
	end

	-- timer-based ally illusion creation is running in the background, to make sure those illusions don't get overridden - insert them
	-- instead of table assignment
	table.extend(self.ability.illusions, illusions)

	ResolveNPCPositions(parent_origin, 450)
end