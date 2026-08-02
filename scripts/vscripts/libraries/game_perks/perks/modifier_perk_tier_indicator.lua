--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_perk_tier_indicator = modifier_perk_tier_indicator or class({})

function modifier_perk_tier_indicator:IsPurgable()
	return false
end
function modifier_perk_tier_indicator:IsHidden()
	return true
end
function modifier_perk_tier_indicator:RemoveOnDeath()
	return false
end

function modifier_perk_tier_indicator:OnStackCountChanged(old_tier)
	local parent = self:GetParent()
	local new_tier = self:GetStackCount()

	-- print("[Perk Indicator] tier changed", old_tier, new_tier, IsServer())

	if new_tier ~= old_tier then
		if parent.current_perk_modifier then
			parent.current_perk_modifier:ForceRefresh()
			-- print(IsServer(), "force-refreshed by previous referehce")
		elseif IsServer() then -- FindAllModifiers only exists on server
			for _, modifier in pairs(parent:FindAllModifiers()) do
				if modifier.IsPerk and modifier:IsPerk() then
					modifier:ForceRefresh()
					-- print(IsServer(), "force-refreshed manually", modifier:GetName())
				end
			end
		end
	end
end