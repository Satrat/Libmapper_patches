(
var branch_synth, branchAzi, crunchy_synth, crunchAzi, lead_synth, leadAzi;


branchAzi = Mapper.makeInSignalBus(s, "human/spatial/branchAzi", -90, 90);
crunchAzi = Mapper.makeInSignalBus(s, "human/spatial/crunchAzi", -90, 90);
leadAzi = Mapper.makeInSignalBus(s, "human/spatial/leadAzi", -90, 90);

m = Bus.audio(s,1);
n = Bus.audio(s,1);
o = Bus.audio(s,1);

branch_synth = ~satie.makeSourceInstance("branch_satie", \busIn, \default, synthArgs: [\bus, m]);
branch_synth.set(\gainDB, 0);
branch_synth.map(\aziDeg, branchAzi);

crunchy_synth = ~satie.makeSourceInstance("crunchy_satie", \busIn, \default, synthArgs: [\bus, n]);
crunchy_synth.set(\gainDB, 0);
crunchy_synth.map(\aziDeg, crunchAzi);

lead_synth = ~satie.makeSourceInstance("lead_satie", \busIn, \default, synthArgs: [\bus, o]);
lead_synth.set(\gainDB, 0);
lead_synth.map(\aziDeg, leadAzi);

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
p[\ring1].play;
p[\ring2].play;
p[\ring3].play;
p[\crack].play;

)