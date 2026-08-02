--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_aegis", "items/item_aegis_lua", LUA_MODIFIER_MOTION_NONE)

item_aegis_lua = class({})

function item_aegis_lua:OnSpellStart()
	if IsServer() then
		local hCaster = self:GetCaster()
		local hPlayer = hCaster:GetPlayerOwner()
		if hCaster and hCaster:IsRealHero() and not hCaster:IsTempestDouble() then
			if hCaster:HasModifier("modifier_aegis") then
				local hModifierAegis = hCaster:FindModifierByName("modifier_aegis")
				local nCurrentStack = hModifierAegis:GetStackCount()
				hModifierAegis:SetStackCount(nCurrentStack + 1)
			else
				local hModifierAegis = hCaster:AddNewModifier(hCaster, nil, "modifier_aegis", {})
				hModifierAegis:SetStackCount(1)
			end
			self:SpendCharge(0)
			EmitSoundOn("DOTA_Item.Refresher.Activate", hCaster)
			local nParticle = ParticleManager:CreateParticle(
				"particles/items_fx/aegis_respawn_timer.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				hCaster
			)
			ParticleManager:ReleaseParticleIndex(nParticle)
		end
	end
end

--------------------------------------------------------------------------------------------------------------------------------------------

modifier_aegis = class({})

function modifier_aegis:IsHidden()
	return false
end

function modifier_aegis:GetTexture()
	return "item_aegis"
end

function modifier_aegis:RemoveOnDeath()
	return false
end

function modifier_aegis:IsPurgable()
	return false
end

function modifier_aegis:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_PROPERTY_REINCARNATION,
	}
	return funcs
end

function modifier_aegis:GetPriority()
	return 100
end

function modifier_aegis:ReincarnateTime()
	if not self:GetParent():HasModifier("modifier_guild_event") then
		return 3
	end
end

function modifier_aegis:OnDeath(keys)
	if keys.unit == self:GetParent() or keys.unit:GetCloneSource() == self:GetParent() then
		if not self:GetParent():HasModifier("modifier_guild_event") then
			PlayersSummary:HandleAegisDeath(self:GetParent())
			Timers:CreateTimer(FrameTime(), function()
				local nStackCount = self:GetStackCount()
				if nStackCount >= 2 then
					self:SetStackCount(nStackCount - 1)
				else
					self:Destroy()
				end
			end)
		end
	end
end