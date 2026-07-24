--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_talant_book=class({})

function item_talant_book:Spawn()
    if not IsServer() then return end
    self:UseBook()
end

function item_talant_book:UseBook()
	if not IsServer() then return end
	local caster = self:GetCaster()
	Timers:CreateTimer(FrameTime(),function()
        if not caster then
            caster = self:GetCaster()
            return 0.1
        end
        if self:IsNull() then return end
		WodaTalents:AddPoint(caster:GetPlayerOwnerID(),1)
		local particle = ParticleManager:CreateParticle("particles/items3_fx/warmage_recipient.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
		self:GetCaster():EmitSound("Item.TomeOfKnowledge")
		UTIL_Remove( self )
		if caster.book == nil then 
			caster.book = 1
		else
			caster.book = caster.book + 1
		end
	end)
end