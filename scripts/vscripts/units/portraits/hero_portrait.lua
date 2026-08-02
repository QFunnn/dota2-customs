--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "units/portraits/hero_portrait"
local b = require("lualib_bundle")
local c = b.__TS__ObjectAssign
local d = b.__TS__SourceMapTraceBack
d(
	debug.getinfo(1).short_src,
	{
		["6"] = 1,
		["7"] = 1,
		["8"] = 4,
		["9"] = 5,
		["10"] = 6,
		["11"] = 7,
		["12"] = 8,
		["13"] = 9,
		["14"] = 10,
		["16"] = 13,
		["17"] = 13,
		["18"] = 13,
		["19"] = 13,
		["20"] = 14,
		["23"] = 17,
		["24"] = 17,
		["25"] = 17,
		["27"] = 17,
		["28"] = 18,
		["31"] = 19,
		["32"] = 19,
		["33"] = 19,
		["35"] = 19,
		["36"] = 20,
		["37"] = 21,
		["38"] = 22,
		["39"] = 23,
		["41"] = 25,
		["42"] = 26,
		["43"] = 27,
		["45"] = 29,
		["46"] = 29,
		["47"] = 29,
		["49"] = 29,
		["50"] = 30,
		["53"] = 31,
		["54"] = 33,
		["55"] = 34,
		["56"] = 34,
		["57"] = 34,
		["58"] = 34,
		["60"] = 34,
		["61"] = 35,
		["62"] = 36,
		["64"] = 38,
		["65"] = 41,
		["66"] = 41,
		["67"] = 41,
		["68"] = 41,
		["69"] = 41,
		["70"] = 41,
		["71"] = 41,
		["72"] = 41,
		["73"] = 41,
		["74"] = 41,
		["75"] = 41,
		["76"] = 41,
		["77"] = 41,
		["78"] = 41,
		["79"] = 41,
		["80"] = 41,
		["81"] = 41,
		["82"] = 41,
		["83"] = 41,
		["84"] = 41,
		["85"] = 41,
		["86"] = 41,
		["87"] = 41,
		["88"] = 41,
		["89"] = 41,
		["90"] = 41,
		["91"] = 41,
		["92"] = 41,
		["93"] = 41,
		["94"] = 41,
		["95"] = 41,
		["96"] = 41,
		["97"] = 41,
		["98"] = 41,
		["99"] = 41,
		["101"] = 78,
		["102"] = 78,
		["106"] = 78,
		["108"] = 78,
		["109"] = 78,
		["110"] = 78,
		["112"] = 78,
		["113"] = 79,
		["114"] = 80,
		["116"] = 81,
		["117"] = 81,
		["118"] = 82,
		["119"] = 83,
		["120"] = 84,
		["122"] = 81,
		["127"] = 88,
		["128"] = 88,
		["129"] = 89,
		["130"] = 90,
		["131"] = 91,
		["132"] = 91,
		["133"] = 91,
		["135"] = 91,
		["137"] = 91,
		["138"] = 91,
		["139"] = 91,
		["141"] = 91,
		["143"] = 91,
		["144"] = 92,
		["145"] = 92,
		["146"] = 92,
		["148"] = 92,
		["149"] = 93,
		["150"] = 94,
		["151"] = 95,
		["153"] = 97,
		["154"] = 98,
		["155"] = 99,
		["156"] = 100,
		["160"] = 88,
		["164"] = 106,
		["165"] = 109,
		["166"] = 109,
		["167"] = 109,
		["168"] = 109,
		["169"] = 109,
		["170"] = 109,
		["171"] = 109,
		["172"] = 109,
		["173"] = 109,
		["174"] = 109,
		["175"] = 109,
		["176"] = 109,
		["177"] = 109,
		["178"] = 109,
		["179"] = 109,
		["180"] = 109,
		["181"] = 109,
		["182"] = 109,
		["183"] = 109,
		["184"] = 109,
		["185"] = 109,
		["186"] = 109,
		["187"] = 109,
		["188"] = 109,
		["189"] = 134,
		["190"] = 134,
		["191"] = 134,
		["192"] = 134,
		["193"] = 134,
		["194"] = 134,
		["195"] = 134,
		["196"] = 134,
		["197"] = 134,
		["198"] = 134,
		["199"] = 134,
		["200"] = 134,
		["201"] = 134,
		["202"] = 134,
		["203"] = 134,
		["204"] = 134,
		["205"] = 134,
		["206"] = 134,
		["207"] = 134,
		["208"] = 153,
		["209"] = 155,
		["210"] = 156,
		["212"] = 13,
		["213"] = 13,
	}
)
local e = {}
local f = require("lib.dota_ts_adapter")
local g = f.registerEntityFunction
local h
local i
if #_G.HeroPortraitDataQueue > 0 then
	local j = table.remove(_G.HeroPortraitDataQueue, 1)
	h = j.unit_name
	i = j.player_id
	Client:SendLocalConsoleMessage("hero_portrait_loaded", j)
end
g(nil, "Spawn", function(k, l)
	if h == nil then
		return
	end
	local m = KeyValues.UnitsKv[h]
	if m == nil then
		m = KeyValues.CosmeticsKV[h]
	end
	local n = m
	if n == nil then
		return
	end
	local o = n.Model
	if o == nil then
		o = n.resource
	end
	local p = o
	local q = p
	local r = GetLocalPlayerID()
	if i ~= nil then
		r = i
	end
	local s = Wearable:getUnitPortraitReplaceModel(q, r)
	if s then
		q = s
	end
	local t = KeyValues.Portrait[q]
	if t == nil then
		t = {}
	end
	local u = c(t, KeyValues.PortraitCustom[q])
	if u == nil then
		return
	end
	local v = u.cameras.default or u.cameras.Default
	local w = Wearable:getUnitPortraitReplaceSkin(q, r)
	local x = tostring
	local y = n.Skin
	if y == nil then
		y = ""
	end
	local z = x(y)
	if w then
		z = tostring(w)
	end
	local A = {}
	local B = {
		classname = "portrait_world_unit",
		targetname = "portraitUnit",
		origin = "0 0 0",
		model = q,
		skin = z,
		EnableAutoStyles = 0,
		ModelScale = 1,
		suppress_intro_effects = 1,
		spawn_background_models = 0,
		rare_loadout_anim_chance = -1,
		suppress_anim_event_sounds = 0,
		skip_pet_spawn = 0,
		flying_courier = 0,
		spawn_wearable_item_defs = 1,
		activity = "ACT_DOTA_CAPTURE",
		activity_modifier = "",
		item_def0 = 0,
		style_index0 = 0,
		item_def1 = 0,
		style_index1 = 0,
		item_def2 = 0,
		style_index2 = 0,
		item_def3 = 0,
		style_index3 = 0,
		item_def4 = 0,
		style_index4 = 0,
		item_def5 = 0,
		style_index5 = 0,
		item_def6 = 0,
		style_index6 = 0,
		item_def7 = 0,
		style_index7 = 0,
		rendercolor = "255 255 255",
	}
	local C
	if n ~= nil then
		C = n.Creature
	end
	local D
	if C ~= nil then
		D = C.AttachWearables
	end
	local E = D
	if E == nil then
		E = {}
	end
	local F = E
	local G = Wearable:getUnitWearablesModifier(p, r)
	if G then
		do
			local H = 0
			while H <= 9 do
				local I = G[H + 1]
				if I then
					B["item_def" .. tostring(H)] = I
				end
				H = H + 1
			end
		end
	else
		do
			local H = 0
			while H <= 9 do
				local J = "item_def" .. tostring(H)
				local K = "style_index" .. tostring(H)
				local L = n["wearable" .. tostring(H + 1)]
				if L == nil then
					local M = F[tostring(H + 1)]
					if M ~= nil then
						M = M.ItemDef
					end
					local N = M
					if N == nil then
						N = -1
					end
					L = N
				end
				local I = L
				local O = n[("wearable" .. tostring(H + 1)) .. "style"]
				if O == nil then
					O = 0
				end
				local P = O
				B[J] = I
				if P ~= 0 then
					B[K] = P
				else
					local Q = KeyValues.ItemsGame[tostring(I)]
					if Q ~= nil then
						if Q.visuals and Q.visuals.skin then
							B[K] = Q.visuals.skin
						end
					end
				end
				H = H + 1
			end
		end
	end
	table.insert(A, B)
	table.insert(
		A,
		{
			classname = "point_camera",
			targetname = "camera_1",
			origin = v.PortraitPosition,
			angles = v.PortraitAngles,
			fov = v.PortraitFOV,
			ZFar = v.PortraitFar or KeyValues.Portrait.default_entity_replacement.cameras.default.PortraitFar,
			ZNear = 4,
			UseScreenAspectRatio = 0,
			aspectRatio = 1,
			fogEnable = 0,
			fogColor = "0 0 0",
			fogStart = 2048,
			fogEnd = 4096,
			fogMaxDensity = 1,
			rendercolor = "128 128 128",
			override_shadow_farz = 0,
			dof_enabled = 0,
			dof_near_blurry = 250,
			dof_near_crisp = 550,
			dac_dof_far_crisp = 1200,
			dac_dof_far_blurry = 1600,
			dac_dof_tilt_to_ground = 0.75,
		}
	)
	table.insert(
		A,
		{
			classname = "env_global_light",
			targetname = "portrait_light",
			origin = u.PortraitLightPosition or KeyValues.Portrait.default_entity_replacement.PortraitLightPosition,
			angles = u.PortraitLightAngles or KeyValues.Portrait.default_entity_replacement.PortraitLightPosition,
			fov = u.PortraitLightFOV or KeyValues.Portrait.default_entity_replacement.PortraitLightFOV,
			nearz = u.PortraitLightDistance or KeyValues.Portrait.default_entity_replacement.PortraitLightDistance,
			Color = u.PortraitLightColor or KeyValues.Portrait.default_entity_replacement.PortraitLightColor,
			ambientcolor2 = u.PortraitShadowColor or KeyValues.Portrait.default_entity_replacement.PortraitShadowColor,
			ambientscale2 = u.PortraitShadowScale or KeyValues.Portrait.default_entity_replacement.PortraitShadowScale,
			ambientcolor1 = u.PortraitAmbientColor
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientColor,
			ambientscale1 = u.PortraitAmbientScale
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientScale,
			specularcolor = u.PortraitSpecularColor
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularColor,
			specularpower = u.PortraitSpecularPower
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularPower,
			specularangles = u.PortraitSpecularDirection
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularDirection,
			lightscale = u.PortraitLightScale or KeyValues.Portrait.default_entity_replacement.PortraitLightScale,
			groundscale = u.PortraitGroundShadowScale
				or KeyValues.Portrait.default_entity_replacement.PortraitGroundShadowScale,
			ambientangles = u.PortraitAmbientDirection
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientDirection,
		}
	)
	SpawnEntityListFromTableSynchronous(A)
	if u.PortraitParticle ~= nil then
		local R = ParticleManager:CreateParticle(u.PortraitParticle, PATTACH_ABSORIGIN_FOLLOW, thisEntity)
	end
end)
return e