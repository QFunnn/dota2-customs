--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const HUD = {
	CONTEXT: $.GetContextPanel(),
	KV_REASONS: $("#KV_Reasons"),
	REASONS_CONTAINER: $("#KV_Reasons_Container"),
	KV_TIMER: $("#KV_VP_Timer"),
	MODEL_CONTAINER: $("#KV_VP_TargetModelContainer"),
	VOTES: $("#KV_VP_CurrentVotes"),
	KV_VOTING_PROCESS: $("#KV_VotingProcess"),
	KV_VOTING_PROCESS_INITIATOR_ROOT: $("#KV_VP_Initiator"),
	KV_VOTING_PROCESS_INITIATOR_ICON: $("#KV_VP_I_HeroIcon"),
	KV_NOTIFICATION: $("#KV_Notification"),
	KV_NOTIFICATION_ICON: $("#KV_N_HeroIcon"),
	REPORT_BUTTON: $("#KV_VP_Button_Report"),
};

const REASONS = ["feeding", "ability_abuse", "toxicity", "afk"];
const REASONS_PER_LINE = 2;
const KV_DURATION = 40;