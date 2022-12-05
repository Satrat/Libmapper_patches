(
var sinHarmAmp = Mapper.makeInSignalBus(s, "nature/sinHarm/amp", 0.0, 0.6);
var sinHarmRate = Mapper.makeInSignalBus(s, "nature/sinHarm/rate", 0.1, 1.0);
var leadFeedback = Mapper.makeInSignalBus(s, "nature/lead/feedback", 0.0, 0.75);
var leadCutoff = Mapper.makeInSignalBus(s, "nature/lead/cutoff", 400, 1500);
var leadAmp = Mapper.makeInSignalBus(s, "nature/lead/amp", 0, 0.4);

var padMinBus = Mapper.makeInSignalBus(s, "nature/pad/minCutoff", 100, 200);
var padMaxBus = Mapper.makeInSignalBus(s, "nature/pad/maxCutoff", 500, 1500);
var padAmp = Mapper.makeInSignalBus(s, "nature/pad/amp", 0, 0.6);

var leavesAmp = Mapper.makeInSignalBus(s, "nature/leaves/amp", 0, 0.4);
var crunchyAmp =  Mapper.makeInSignalBus(s, "nature/crunchy/amp", 0, 0.6);
var branchAmp = Mapper.makeInSignalBus(s, "nature/branch/amp", 0, 1);

~sin_harm.map(\amp, sinHarmAmp);
~sin_harm.map(\rate, sinHarmRate);
~sin_syn.map(\fb, leadFeedback);
~sin_syn.map(\cutoff, leadCutoff);
~sin_syn.map(\amp, leadAmp);

~saw_pad1.map(\cfmin, padMinBus);
~saw_pad2.map(\cfmin, padMinBus);
~saw_pad1.map(\cfmax, padMaxBus);
~saw_pad2.map(\cfmax, padMaxBus);
~saw_pad1.map(\amp, padAmp);
~saw_pad2.map(\amp, padAmp);

~leaves.map(\amp, leavesAmp);
~crunchy.map(\amp, crunchyAmp);
~branch.map(\amp, branchAmp);
)