--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "scene/hero_preview"
local b = require("lualib_bundle")
local c = b.__TS__ArrayIncludes
data = Client:GetSceneEntityData("hero_preview")
local d = data and data.heroName
if d == nil then
	d = "npc_dota_hero_vexis"
end
heroName = d
bodyGroup = data and data.bodyGroup
bodyGroupChoice = data and data.bodyGroupChoice
heroKV = KeyValues.heroes[heroName]
heroID = heroKV.HeroID
heroCosmeticType = {
	COSMETIC_TYPE.HEAD,
	COSMETIC_TYPE.SHOULDER,
	COSMETIC_TYPE.BACK,
	COSMETIC_TYPE.TAIL,
	COSMETIC_TYPE.WING,
	COSMETIC_TYPE.MISC,
}
function Spawn(self, e)
	entities = {}
	local f = thisEntity
	do
		local g = 0
		while g < 19 do
			entities[f:GetName()] = f
			f = Entities:Next(f)
			g = g + 1
		end
	end
	local h = SpawnEntityFromTableSynchronous(
		"prop_dynamic_clientside",
		{
			parentname = "root",
			targetname = heroName,
			origin = "0 0 0",
			angles = "0 0 0",
			scales = "1 1 1",
			model = heroKV.Model,
			IdleAnim = "ACT_DOTA_IDLE",
			add_modifier = "",
			bodygroups = ((("{" .. tostring(bodyGroup)) .. " = ") .. tostring(bodyGroupChoice)) .. "}",
		}
	)
	entities[heroName] = h
	local i = {}
	for j, k in pairs(KeyValues.weapon) do
		if k.model ~= nil and (k.hero == nil or tostring(k.hero) == tostring(heroID)) then
			local l = i
			local m = j
			local n = k.model
			local o
			if k.animate and k.animate ~= "" then
				o = k.animate
			else
				o = "ACT_DOTA_IDLE"
			end
			l[#l + 1] = {
				origin = "0 0 0",
				classname = "prop_dynamic_clientside",
				targetname = m,
				angles = "0 0 0",
				model = n,
				scales = "1 1 1",
				StartingAnim = o,
				StartingAnimationLoopMode = "ANIM_LOOP_MODE_USE_SEQUENCE_SETTINGS",
				parentname = heroName,
				parentAttachmentName = "!bonemerge",
			}
		end
	end
	for j, k in pairs(KeyValues.info_item_cosmetic) do
		if
			c(heroCosmeticType, k.type)
			and k.model ~= nil
			and (k.hero_id == nil or tostring(k.hero_id) == tostring(heroID))
		then
			local p = i
			local q = j
			local r = k.model
			local s
			if k.animate and k.animate ~= "" then
				s = k.animate
			else
				s = "ACT_DOTA_IDLE"
			end
			p[#p + 1] = {
				origin = "0 0 0",
				classname = "prop_dynamic_clientside",
				targetname = q,
				angles = "0 0 0",
				model = r,
				scales = "1 1 1",
				StartingAnim = s,
				StartingAnimationLoopMode = "ANIM_LOOP_MODE_USE_SEQUENCE_SETTINGS",
				parentname = heroName,
				parentAttachmentName = "!bonemerge",
			}
		end
	end
	SpawnEntityListFromTableSynchronous(i)
end
function Clear()
	currentFootParticle = nil
	currentAuraParticle = nil
	ParticleManager:DestroyParticle(auraParticle or -1, true)
	ParticleManager:DestroyParticle(footParticle or -1, true)
end
function SwitchToFoot(t)
	if t == nil then
		currentFootParticle = nil
		ParticleManager:DestroyParticle(footParticle or -1, true)
	elseif t ~= currentFootParticle then
		currentFootParticle = t
		ParticleManager:DestroyParticle(footParticle or -1, true)
		footParticle = ParticleManager:CreateParticle(t, PATTACH_ABSORIGIN_FOLLOW, entities.runner)
	end
end
function SwitchToAura(t)
	if t == nil then
		currentAuraParticle = nil
		ParticleManager:DestroyParticle(auraParticle or -1, true)
	elseif t ~= currentAuraParticle then
		currentAuraParticle = t
		ParticleManager:DestroyParticle(auraParticle or -1, true)
		auraParticle = ParticleManager:CreateParticle(t, PATTACH_ABSORIGIN_FOLLOW, thisEntity)
	end
end
function PlayAttack(u)
	local v = 1
	local w = { "vespera_attack_1", "vespera_attack_2", "vespera_attack_3", "vespera_attack_4" }
	local x = 0
	thisEntity:SetContextThink("attack", function()
		if x >= #w then
			x = 0
		end
		FireInputString(entities[heroName], "SetAnimationNotLooping", w[x + 1])
		x = x + 1
		return v
	end, v)
end
function StopAttack()
	thisEntity:StopThink("attack")
end