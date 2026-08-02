--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


const FACES = [$("#TC_Face1"), $("#TC_Face2"), $("#TC_Face3"), $("#TC_Face4"), $("#TC_Face5"), $("#TC_Face6")];
const CUBE_ROOT = $("#EA_TestCube");
function ClearCube() {
	for (const face of FACES) {
		face.ClearPropertyFromCode("transform");
		face.style.x = "0px";
		face.style.y = "0px";
	}
}

function Place(face, x, y, rot) {
	face.style.x = x + "px";
	face.style.y = y + "px";
	face.style.transform = rot;
}

function CreateCube() {
	const s = 120;
	const h = s / 2;

	CUBE_ROOT.style.transform = "rotateX(0deg);";
	// Перед
	const a1 = 0;
	const a2 = -45;
	const a3 = 0;
	const f = 50;
	const fh = f / 2;
	Place(FACES[0], 50, 50, `rotateX(${a1}deg) rotateY(${a2}deg) rotateZ(${a3}deg);`);
	// FACES[0].style.position = "50px 0px 0px";

	// Правая
	Place(FACES[1], h, 0, "rotateY(-90deg) rotateX(35deg) rotateY(-35deg)");

	// Левая
	Place(FACES[2], -h, 0, "rotateY(90deg) rotateX(35deg) rotateY(-35deg)");

	// Верх
	Place(FACES[3], 0, -h, "rotateX(-90deg) rotateX(35deg) rotateY(-35deg)");

	// Низ
	Place(FACES[4], 0, h, "rotateX(90deg) rotateX(35deg) rotateY(-35deg)");

	// Задняя
	Place(FACES[5], 0, 0, "rotateY(180deg) rotateX(35deg) rotateY(-35deg)");
}

(function () {
	ClearCube();
	CreateCube();
})();