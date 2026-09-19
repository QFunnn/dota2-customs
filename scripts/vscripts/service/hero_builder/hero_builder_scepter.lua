--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- Отслеживание владельцев аганима и реакция на его потерю.

---@param hero CDOTA_BaseNPC_Hero
function HeroBuilderService:RegisterScepterOwner(hero)
	if not hero or not hero:IsMainHero() then
		return
	end
	self.scepterOwners[hero:GetEntityIndex()] = hero
end

---@param hero CDOTA_BaseNPC_Hero
function HeroBuilderService:UnregisterScepterOwner(hero)
	if not hero or not hero:IsMainHero() then
		return
	end
	if hero:GetEntityIndex() and self.scepterOwners[hero:GetEntityIndex()] then
		self.scepterOwners[hero:GetEntityIndex()] = nil
	end
end

---@param hero CDOTA_BaseNPC_Hero
function HeroBuilderService:OnScepterLost(hero)
	if not hero or not hero:IsMainHero() then
		return
	end

	self:UnregisterScepterOwner(hero)

	for i = 0, hero:GetAbilityCount() - 1 do
		local ability = hero:GetAbilityByIndex(i)

		if ability and ability.isScepterAbility then
			local abilityName = ability:GetAbilityName()
			hero:RemoveAbilityWithRestructure(abilityName)
		end
	end

	self:RefreshAbilityOrder(hero:GetPlayerOwnerID())

	if hero:HasModifier("modifier_bloodseeker_blood_mist") then
		hero:RemoveModifierByName("modifier_bloodseeker_blood_mist")
	end

	EventDriver:Dispatch("Hero:scepter_lost", { hero = hero })
end

function HeroBuilderService:ProcessScepterOwners()
	for _, hero in pairs(self.scepterOwners) do
		if hero and not hero:IsNull() and not hero:HasScepter() then
			self:OnScepterLost(hero)
		end
	end
end