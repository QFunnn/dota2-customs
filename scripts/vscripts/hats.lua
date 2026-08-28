--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


function isNewYearNow()
	local month, day = string.match(GetSystemDate(), "(%d+)/(%d+)")

	month = tonumber(month)
	day = tonumber(day)

	return (month == 12 and day >= 15) or (month == 1 and day <= 10)
end

HAT_TYPE = {
	NEW_YEAR = 1,
}

local hatTypeToParticle = {
	[HAT_TYPE.NEW_YEAR] = "particles/hny/anniversary_10th_hat_ambient_%s.vpcf",
}

local buggedHats = {
	["npc_dota_hero_dado"] = true,
}

function CBaseEntity:SetupHat(hatType)
	self:RemoveHat()

	local hatParticleTemplate = hatTypeToParticle[hatType]
	if not hatParticleTemplate then
		return
	end

	local unitName = self:GetUnitName()
	unitName = BOSS_NAME_TO_HERO_NAME[unitName] or unitName

	if buggedHats[unitName] then
		return
	end

	local hatParticle =
		ParticleManager:CreateParticle(string.format(hatParticleTemplate, unitName), PATTACH_CUSTOMORIGIN, self)
	if not hatParticle then
		return
	end

	ParticleManager:SetParticleControlEnt(hatParticle, 0, self, PATTACH_ABSORIGIN_FOLLOW, "", self:GetAbsOrigin(), true)
	-- ParticleManager:SetParticleControl(hatParticle, 7, Vector(1.0, 1.0, 1.0))

	self.hatParticle = hatParticle
end

function CBaseEntity:RemoveHat()
	if not self.hatParticle then
		return
	end

	ParticleManager:DestroyParticle(self.hatParticle, true)
	ParticleManager:ReleaseParticleIndex(self.hatParticle)

	self.hatParticle = nil
end