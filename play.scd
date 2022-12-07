(
var branch_synth, branchAzi, crunchy_synth, crunchAzi, lead_synth, leadAzi;
var ringBg_synth, ringBgAzi, ringMel_synth, ringMelAzi, crack_synth, crackAzi;


branchAzi = Mapper.makeInSignalBus(s, "nature/spatial/branchAzi", -90, 90);
crunchAzi = Mapper.makeInSignalBus(s, "nature/spatial/crunchAzi", -90, 90);
leadAzi = Mapper.makeInSignalBus(s, "nature/spatial/leadAzi", -90, 90);
ringBgAzi = Mapper.makeInSignalBus(s, "humans/spatial/ringBgAzi", -90, 90);
ringMelAzi = Mapper.makeInSignalBus(s, "humans/spatial/ringMelAzi", -90, 90);
crackAzi = Mapper.makeInSignalBus(s, "humans/spatial/crackAzi", -90, 90);

m = Bus.audio(s,1);
n = Bus.audio(s,1);
o = Bus.audio(s,1);
q = Bus.audio(s,1);
r = Bus.audio(s,1);
s = Bus.audio(s,1);

branch_synth = ~satie.makeSourceInstance("branch_satie", \busIn, \default, synthArgs: [\bus, m]);
branch_synth.set(\gainDB, 0);
branch_synth.map(\aziDeg, branchAzi);
crunchy_synth = ~satie.makeSourceInstance("crunchy_satie", \busIn, \default, synthArgs: [\bus, n]);
crunchy_synth.set(\gainDB, 0);
crunchy_synth.map(\aziDeg, crunchAzi);
lead_synth = ~satie.makeSourceInstance("lead_satie", \busIn, \default, synthArgs: [\bus, o]);
lead_synth.set(\gainDB, 0);
lead_synth.map(\aziDeg, leadAzi);

ringBg_synth = ~satie.makeSourceInstance("ringBg_satie", \busIn, \default, synthArgs: [\bus, q]);
ringBg_synth.set(\gainDB, 0);
ringBg_synth.map(\aziDeg, ringBgAzi);
ringMel_synth = ~satie.makeSourceInstance("ringMel_satie", \busIn, \default, synthArgs: [\bus, r]);
ringMel_synth.set(\gainDB, 0);
ringMel_synth.map(\aziDeg, ringMelAzi);
crack_synth = ~satie.makeSourceInstance("crack_satie", \busIn, \default, synthArgs: [\bus, s]);
crack_synth.set(\gainDB, 0);
crack_synth.map(\aziDeg, crackAzi);

p[\sin_harm_bass].play;
p[\verb_leaves].play;
p[\verb_pad].play;

{Out.ar(m, p[\total_branch])}.play;
{Out.ar(n, p[\crunchy_verb])}.play;
{Out.ar(o, p[\verb_sin])}.play;


p[\bp_saw].play;
p[\bp_saw2].play;
p[\bp_saw3].play;
p[\grain].play;

{Out.ar(q, p[\ring1])}.play;
{Out.ar(q, p[\ring2])}.play;
{Out.ar(r, p[\ring3])}.play;
{Out.ar(s, p[\crack])}.play;

)