--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "units/player_portraits/player_portrait_7"
local b = require("lualib_bundle")
local c = b.__TS__ObjectAssign
local d = b.__TS__SourceMapTraceBack
d(
	debug.getinfo(1).short_src,
	{
		["5"] = 2,
		["6"] = 3,
		["7"] = 4,
		["10"] = 7,
		["11"] = 8,
		["12"] = 9,
		["13"] = 9,
		["14"] = 9,
		["16"] = 9,
		["17"] = 10,
		["20"] = 11,
		["21"] = 11,
		["22"] = 11,
		["24"] = 11,
		["25"] = 11,
		["26"] = 11,
		["28"] = 11,
		["29"] = 12,
		["30"] = 13,
		["31"] = 14,
		["32"] = 15,
		["34"] = 17,
		["35"] = 17,
		["36"] = 17,
		["38"] = 17,
		["39"] = 18,
		["42"] = 19,
		["43"] = 20,
		["44"] = 21,
		["45"] = 21,
		["46"] = 21,
		["47"] = 21,
		["49"] = 21,
		["50"] = 22,
		["51"] = 23,
		["53"] = 25,
		["54"] = 28,
		["55"] = 28,
		["56"] = 28,
		["57"] = 28,
		["58"] = 28,
		["59"] = 28,
		["60"] = 28,
		["61"] = 28,
		["62"] = 28,
		["63"] = 28,
		["64"] = 28,
		["65"] = 28,
		["66"] = 28,
		["67"] = 28,
		["68"] = 28,
		["69"] = 28,
		["70"] = 28,
		["71"] = 28,
		["72"] = 28,
		["73"] = 28,
		["74"] = 28,
		["75"] = 28,
		["76"] = 28,
		["77"] = 28,
		["78"] = 28,
		["79"] = 28,
		["80"] = 28,
		["81"] = 28,
		["82"] = 28,
		["83"] = 28,
		["84"] = 28,
		["85"] = 28,
		["86"] = 28,
		["87"] = 28,
		["88"] = 28,
		["90"] = 65,
		["91"] = 65,
		["95"] = 65,
		["97"] = 65,
		["98"] = 65,
		["99"] = 65,
		["101"] = 65,
		["102"] = 66,
		["103"] = 67,
		["105"] = 68,
		["106"] = 68,
		["107"] = 69,
		["108"] = 70,
		["109"] = 71,
		["111"] = 68,
		["116"] = 75,
		["117"] = 75,
		["118"] = 76,
		["119"] = 77,
		["120"] = 78,
		["121"] = 78,
		["122"] = 78,
		["124"] = 78,
		["126"] = 78,
		["127"] = 78,
		["128"] = 78,
		["130"] = 78,
		["132"] = 78,
		["133"] = 79,
		["134"] = 80,
		["135"] = 81,
		["136"] = 82,
		["138"] = 84,
		["139"] = 85,
		["140"] = 86,
		["141"] = 87,
		["145"] = 75,
		["149"] = 93,
		["150"] = 96,
		["151"] = 96,
		["152"] = 96,
		["153"] = 96,
		["154"] = 96,
		["155"] = 96,
		["156"] = 96,
		["157"] = 96,
		["158"] = 96,
		["159"] = 96,
		["160"] = 96,
		["161"] = 96,
		["162"] = 96,
		["163"] = 96,
		["164"] = 96,
		["165"] = 96,
		["166"] = 96,
		["167"] = 96,
		["168"] = 96,
		["169"] = 96,
		["170"] = 96,
		["171"] = 96,
		["172"] = 96,
		["173"] = 96,
		["174"] = 121,
		["175"] = 121,
		["176"] = 121,
		["177"] = 121,
		["178"] = 121,
		["179"] = 121,
		["180"] = 121,
		["181"] = 121,
		["182"] = 121,
		["183"] = 121,
		["184"] = 121,
		["185"] = 121,
		["186"] = 121,
		["187"] = 121,
		["188"] = 121,
		["189"] = 121,
		["190"] = 121,
		["191"] = 121,
		["192"] = 121,
		["193"] = 140,
		["194"] = 142,
		["195"] = 144,
		["197"] = 2,
	}
)
function Spawn(self, e)
	local f = Client:GetPlayerPortraitData(7)
	if not f then
		return
	end
	local g = f.unit_name
	local h = f.playerID
	local i = KeyValues.UnitsKv[g]
	if i == nil then
		i = KeyValues.CosmeticsKV[g]
	end
	local j = i
	if j == nil then
		return
	end
	local k = j.portraitmodel
	if k == nil then
		k = j.Model
	end
	local l = k
	if l == nil then
		l = j.resource
	end
	local m = l
	local n = m
	local o = Wearable:getUnitPortraitReplaceModel(n, h)
	if o then
		n = o
	end
	local p = KeyValues.Portrait[n]
	if p == nil then
		p = {}
	end
	local q = c(p, KeyValues.PortraitCustom[n])
	if q == nil then
		return
	end
	local r = q.cameras.default or q.cameras.Default
	local s = Wearable:getUnitPortraitReplaceSkin(n, h)
	local t = tostring
	local u = j.Skin
	if u == nil then
		u = ""
	end
	local v = t(u)
	if s then
		v = tostring(s)
	end
	local w = {}
	local x = {
		classname = "portrait_world_unit",
		targetname = "portraitUnit",
		origin = "0 0 0",
		model = n,
		skin = v,
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
	local y
	if j ~= nil then
		y = j.Creature
	end
	local z
	if y ~= nil then
		z = y.AttachWearables
	end
	local A = z
	if A == nil then
		A = {}
	end
	local B = A
	local C = Wearable:getUnitWearablesModifier(m, h)
	if C then
		do
			local D = 0
			while D <= 9 do
				local E = C[D + 1]
				if E then
					x["item_def" .. tostring(D)] = E
				end
				D = D + 1
			end
		end
	else
		do
			local D = 0
			while D <= 9 do
				local F = "item_def" .. tostring(D)
				local G = "style_index" .. tostring(D)
				local H = j["wearable" .. tostring(D + 1)]
				if H == nil then
					local I = B[tostring(D + 1)]
					if I ~= nil then
						I = I.ItemDef
					end
					local J = I
					if J == nil then
						J = -1
					end
					H = J
				end
				local E = H
				local K = j[("wearable" .. tostring(D + 1)) .. "style"]
				x[F] = E
				if K ~= nil then
					x[G] = K
				else
					local L = KeyValues.ItemsGame[tostring(E)]
					if L ~= nil then
						if L.visuals and L.visuals.skin then
							x[G] = L.visuals.skin
						end
					end
				end
				D = D + 1
			end
		end
	end
	table.insert(w, x)
	table.insert(
		w,
		{
			classname = "point_camera",
			targetname = "camera_1",
			origin = r.PortraitPosition,
			angles = r.PortraitAngles,
			fov = r.PortraitFOV,
			ZFar = r.PortraitFar or KeyValues.Portrait.default_entity_replacement.cameras.default.PortraitFar,
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
		w,
		{
			classname = "env_global_light",
			targetname = "portrait_light",
			origin = q.PortraitLightPosition or KeyValues.Portrait.default_entity_replacement.PortraitLightPosition,
			angles = q.PortraitLightAngles or KeyValues.Portrait.default_entity_replacement.PortraitLightPosition,
			fov = q.PortraitLightFOV or KeyValues.Portrait.default_entity_replacement.PortraitLightFOV,
			nearz = q.PortraitLightDistance or KeyValues.Portrait.default_entity_replacement.PortraitLightDistance,
			Color = q.PortraitLightColor or KeyValues.Portrait.default_entity_replacement.PortraitLightColor,
			ambientcolor2 = q.PortraitShadowColor or KeyValues.Portrait.default_entity_replacement.PortraitShadowColor,
			ambientscale2 = q.PortraitShadowScale or KeyValues.Portrait.default_entity_replacement.PortraitShadowScale,
			ambientcolor1 = q.PortraitAmbientColor
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientColor,
			ambientscale1 = q.PortraitAmbientScale
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientScale,
			specularcolor = q.PortraitSpecularColor
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularColor,
			specularpower = q.PortraitSpecularPower
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularPower,
			specularangles = q.PortraitSpecularDirection
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularDirection,
			lightscale = q.PortraitLightScale or KeyValues.Portrait.default_entity_replacement.PortraitLightScale,
			groundscale = q.PortraitGroundShadowScale
				or KeyValues.Portrait.default_entity_replacement.PortraitGroundShadowScale,
			ambientangles = q.PortraitAmbientDirection
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientDirection,
		}
	)
	SpawnEntityListFromTableSynchronous(w)
	if q.PortraitParticle ~= nil then
		local M = ParticleManager:CreateParticle(q.PortraitParticle, PATTACH_ABSORIGIN_FOLLOW, thisEntity)
	end
end