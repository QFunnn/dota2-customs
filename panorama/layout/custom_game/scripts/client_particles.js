--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


let cached_particles = {};
let particles_data = {};
let alt_switch = false;

function ThinkerAltHolding() {
	if (GameUI.IsAltDown() && particles_data) {
		alt_switch = true;
		Object.entries(particles_data).forEach(([idx, particle_info]) => {
			if (cached_particles[idx]) return;

			const pfx = Particles.CreateParticle(particle_info.name, particle_info.attach_type, particle_info.ent_idx);
			if (particle_info.cp)
				Object.entries(particle_info.cp).forEach(([number, value]) => {
					Particles.SetParticleControl(pfx, parseInt(number), value);
				});
			cached_particles[idx] = pfx;
		});
	} else if (alt_switch) {
		alt_switch = false;
		Object.values(cached_particles).forEach((pfx_to_destroy) => {
			Particles.DestroyParticleEffect(pfx_to_destroy, true);
			Particles.ReleaseParticleIndex(pfx_to_destroy);
		});
		cached_particles = {};
	}

	$.Schedule(0, ThinkerAltHolding);
}

function CreateAttackRangePartlceForFountain(fountain_name) {
	if (Game.GameStateIsBefore(DOTA_GameState.DOTA_GAMERULES_STATE_PRE_GAME))
		return $.Schedule(0, () => CreateAttackRangePartlceForFountain(fountain_name));

	let player_team = Players.GetTeam(Game.GetLocalPlayerID());
	if (player_team < DOTATeam_t.DOTA_TEAM_FIRST || player_team == DOTATeam_t.DOTA_TEAM_NOTEAM)
		return $.Schedule(0.5, () => CreateAttackRangePartlceForFountain(fountain_name));
	else if (player_team == 1) player_team = DOTATeam_t.DOTA_TEAM_GOODGUYS;

	const fountain = Entities.GetAllEntitiesByName(fountain_name)[0];
	if (!fountain) return $.Schedule(0, () => CreateAttackRangePartlceForFountain(fountain_name));

	const fountain_pos = Entities.GetAbsOrigin(fountain);
	const fountain_attack_range = Entities.GetAttackRange(fountain) + Entities.GetPaddedCollisionRadius(fountain);

	particles_data[`fountain_attack_range_${fountain_name}`] = {
		name: "particles/ui_mouseactions/tower_range_indicator_alt.vpcf",
		attach_type: ParticleAttachment_t.PATTACH_ABSORIGIN_FOLLOW,
		ent_idx: fountain,
		cp: {
			0: fountain_pos,
			2: fountain_pos,
			3: [fountain_attack_range, 0, 0],
			6: [0, 0, 0],
			16: player_team == Entities.GetTeamNumber(fountain) ? [0, 0, 0] : [1, 0, 0],
		},
	};
}

(() => {
	ThinkerAltHolding();
	CreateAttackRangePartlceForFountain("ent_dota_fountain_good");
	CreateAttackRangePartlceForFountain("ent_dota_fountain_bad");
})();