--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
--- 与 `modifier_gem_multicast` 一致的多重施法头顶特效与音效，供其它符印/技能复用。
local MULTICAST_PARTICLE = "particles/units/heroes/hero_ogre_magi/ogre_magi_multicast.vpcf"
function ____exports.PlayGemMulticastFeedback(self, parent, totalCount, extraCount)
	local pfx = ParticleManager:CreateParticle(MULTICAST_PARTICLE, PATTACH_OVERHEAD_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		parent,
		PATTACH_OVERHEAD_FOLLOW,
		"attach_overhead",
		parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(pfx, 1, Vector(totalCount, 0, 0))
	ParticleManager:ReleaseParticleIndex(pfx)
	local soundIndex = math.max(1, math.min(3, extraCount))
	parent:EmitSound("Hero_OgreMagi.Fireblast.x" .. tostring(soundIndex))
end
return ____exports