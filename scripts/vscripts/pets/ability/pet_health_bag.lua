--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_pet_health_bag_buff", "pets/ability/pet_health_bag", LUA_MODIFIER_MOTION_NONE)

pet_health_bag = class({})

function pet_health_bag:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	local duration = self:GetSpecialValueFor("duration")
	EmitSoundOn("DOTA_Item.UrnOfShadows.Activate", self:GetCaster())
	target:AddNewModifier(caster, self, "modifier_pet_health_bag_buff", { duration = duration })
end
-------------------------------------------------------------------------------------------------------------------------

modifier_pet_health_bag_buff = class({})

function modifier_pet_health_bag_buff:GetEffectName()
	return "particles/items2_fx/urn_of_shadows_heal.vpcf"
end

function modifier_pet_health_bag_buff:GetTexture()
	return "health_bag"
end

if IsServer() then
	function modifier_pet_health_bag_buff:OnCreated()
		local ability = self:GetAbility()

		if not ability then
			self:Destroy()
			return
		end

		self.heal_pct = ability:GetSpecialValueFor("heal_pct")

		local think_interval = ability:GetSpecialValueFor("heal_interval")
		self:StartIntervalThink(think_interval)
	end

	function modifier_pet_health_bag_buff:OnIntervalThink()
		local ability = self:GetAbility()
		local parent = self:GetParent()

		if ability and parent then
			local heal_amount = parent:GetMaxHealth() / 100 * self.heal_pct
			parent:Heal(heal_amount, self:GetCaster())
		end
	end
end