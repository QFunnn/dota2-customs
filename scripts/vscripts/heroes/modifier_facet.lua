--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_facet = class({})

--------------------------------------------------------------------------------

function modifier_facet:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function modifier_facet:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEROFACET_OVERRIDE,
	}
end

function modifier_facet:GetModifierHeroFacetOverride()
	print("GetModifierHeroFacetOverride")
	return "invoker_elitist"
end