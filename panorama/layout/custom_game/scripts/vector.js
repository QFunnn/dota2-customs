--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


const Vector = {};

Vector.len = (vec_array) => {
	return Math.sqrt(vec_array[0] * vec_array[0] + vec_array[1] * vec_array[1] + vec_array[2] * vec_array[2]);
};

Vector.sub = (vec_1, vec_2) => {
	const res = [0, 0, 0];

	res[0] = vec_1[0] - vec_2[0];
	res[1] = vec_1[1] - vec_2[1];
	res[2] = vec_1[2] - vec_2[2];

	return res;
};