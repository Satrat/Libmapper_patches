(
var branch_synth, branchAzi, crunchy_synth, crunchAzi, lead_synth, leadAzi;
var ringBg_synth, ringBgAzi, ringMel_synth, ringMelAzi, crack_synth, crackAzi;

branchAzi = Mapper.makeInSignalBus(s, "nature/spatial/branchAzi", -180, 180);
crunchAzi = Mapper.makeInSignalBus(s, "nature/spatial/crunchAzi", -180, 180);
leadAzi = Mapper.makeInSignalBus(s, "nature/spatial/leadAzi", -180, 180);

ringBgAzi = Mapper.makeInSignalBus(s, "humans/spatial/ringBgAzi", -180, 180);
ringMelAzi = Mapper.makeInSignalBus(s, "humans/spatial/ringMelAzi", -180, 180);
crackAzi = Mapper.makeInSignalBus(s, "humans/spatial/crackAzi", -180, 180);

a = Bus.audio(s,2);
c = Bus.audio(s,2);
d = Bus.audio(s,2);
m = Bus.audio(s,1);
n = Bus.audio(s,1);
o = Bus.audio(s,1);
q = Bus.audio(s,1);
r = Bus.audio(s,1);
t = Bus.audio(s,1);

branch_synth = ~satie.makeSourceInstance("branch_satie", \busIn, \default, synthArgs: [\bus, m]);
branch_synth.set(\gainDB, 0, \spread, 0);
branch_synth.map(\aziDeg, branchAzi);
crunchy_synth = ~satie.makeSourceInstance("crunchy_satie", \busIn, \default, synthArgs: [\bus, n]);
crunchy_synth.set(\gainDB, 0, \spread, 0);
crunchy_synth.map(\aziDeg, crunchAzi);
lead_synth = ~satie.makeSourceInstance("lead_satie", \busIn, \default, synthArgs: [\bus, o]);
lead_synth.set(\gainDB, 0, \spread, 0);
lead_synth.map(\aziDeg, leadAzi);

ringBg_synth = ~satie.makeSourceInstance("ringBg_satie", \busIn, \default, synthArgs: [\bus, q]);
ringBg_synth.set(\gainDB, 0, \spread, 0);
ringBg_synth.map(\aziDeg, ringBgAzi);
ringMel_synth = ~satie.makeSourceInstance("ringMel_satie", \busIn, \default, synthArgs: [\bus, r]);
ringMel_synth.set(\gainDB, 0, \spread, 0);
ringMel_synth.map(\aziDeg, ringMelAzi);
crack_synth = ~satie.makeSourceInstance("crack_satie", \busIn, \default, synthArgs: [\bus, t]);
crack_synth.set(\gainDB, 0, \spread, 0);
crack_synth.map(\aziDeg, crackAzi);

{Out.ar(m, p[\total_branch])}.play;
{Out.ar(n, p[\crunchy_verb])}.play;
{Out.ar(o, p[\verb_sin])}.play;

{Out.ar(q, p[\ring1])}.play;
{Out.ar(q, p[\ring2])}.play;
{Out.ar(r, p[\ring3])}.play;
{Out.ar(t, p[\crack])}.play;

{Out.ar(c, p[\sin_harm_bass])}.play;
{Out.ar(c, p[\verb_leaves])}.play;
{Out.ar(c, p[\verb_pad])}.play;

{Out.ar(d, p[\bp_saw])}.play;
{Out.ar(d, p[\bp_saw2])}.play;
{Out.ar(d, p[\bp_saw3])}.play;
{Out.ar(d, p[\grain])}.play;

{Out.ar(a, p[\lossy_leaves])}.play;
{Out.ar(a, p[\total_between_branch])}.play;
{Out.ar(a, p[\lossy_lead])}.play;
{Out.ar(a, p[\ring1B])}.play;
{Out.ar(a, p[\ring2B])}.play;
{Out.ar(a, p[\bp_sawB])}.play;
{Out.ar(a, p[\bp_saw2B])}.play;
{Out.ar(a, p[\bp_saw3B])}.play;

p[\router] = { |busNature, busHuman, busBetween, switcher=1, out=0|
	var patches;
	patches = [In.ar(busNature,2), In.ar(busHuman,2), In.ar(busBetween,2)];
	Out.ar(0, Select.ar(switcher, patches));
};

p[\router].set(\busNature, c, \busHuman, d, \busBetween, a);
p[\router].play;

p[\session_id] = {MapIn.kr("session_id", 0, 2)};
p[\router].map(\switcher, p[\session_id]);
)