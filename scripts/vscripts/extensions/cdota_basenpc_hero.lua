--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function CDOTA_BaseNPC_Hero:QueueMadstones(count)
	-- If there isn't already a queue going, start one
	if not self.madstone_count or self.madstone_count == 0 then
		self.madstone_count = count

		Timers:CreateTimer(0.2, function()
			if not IsValidEntity(self) then return end

			-- Madstone bundles cannot be consumed while dead, wait till after respawn to continue
			if not self:IsAlive() then
				return self:GetTimeUntilRespawn() + 0.2
			end

			-- Madstones can't be consumed while the player is affected by some stuns/mutes (but not all??) so we wait until stuns are removed
			if self:IsStunned() or self:IsMuted() then 
				return 0.2
			end

			-- Madstones can sometimes interrupt channels, so wait for that too
			if self:IsChanneling() or self:HasModifier("modifier_snapfire_mortimer_kisses") then
				return 0.2
			end

			-- Madstones can sometimes interrupt invisibility, so check for invisibility
			-- Ignore the check if the player is riki, since his invis doesn't get interrupted
			if self:IsInvisible() and not self:GetUnitName() == "npc_dota_hero_riki" then
				return 0.2
			end

			-- Sometimes bundles dont get consumed for some reason ???
			-- So we check if the player has an existing bundle and then consume it
			local existing_bundle = self:GetItemInSlot(DOTA_ITEM_TRANSIENT_CAST_ITEM)

			if existing_bundle then
				existing_bundle:OnSpellStart()

				return 0.2
			end

			self:AddItemByName("item_madstone_bundle")
			self.madstone_count = self.madstone_count - 1

			if self.madstone_count > 0 then
				return 0.2
			end
		end)
	else
		-- Add to the queue, no need to start a new timer
		self.madstone_count = self.madstone_count + count
	end
end