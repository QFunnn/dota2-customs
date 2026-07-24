--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



--Abilities
if item_thanksgiving_turkey == nil then
	item_thanksgiving_turkey = class({})
end
function item_thanksgiving_turkey:OnSpellStart()
	local hCaster = self:GetCaster()

	if IsValid(hCaster) then
		EmitSoundOn("DOTA_Item.Cheese.Activate", hCaster)
		local UptoLevel = self:GetSpecialValueFor("UptoLevel")
		while hCaster:GetLevel() < UptoLevel do
			hCaster:HeroLevelUp(true)
		end
		self:SpendCharge()
	end
end