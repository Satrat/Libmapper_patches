(
~sinHarmAmp = {MapIn.kr("nature/sinHarm/amp", 0.0, 0.6)};
~sinHarmRate = {MapIn.kr("nature/sinHarm/rate", 0.1, 1.0)};
~sin_harm_bass.map(\amp, ~sinHarmAmp);
~sin_harm_bass.map(\rate, ~sinHarmRate);

~leavesAmp = {MapIn.kr("nature/leaves/amp", 0, 0.4)};
~leaves.map(\amp, ~leavesAmp);

//~padMinBus = {MapIn.kr("nature/pad/minCutoff", 100, 200)};
//~padMaxBus = {MapIn.kr("nature/pad/maxCutoff", 500, 1500)};
~padAmp = {MapIn.kr("nature/pad/amp", 0, 0.6)};
//~saw_pad1.map(\cfmin, ~padMinBus);
//~saw_pad2.map(\cfmin, ~padMinBus);
//~saw_pad1.map(\cfmax, ~padMaxBus);
//~saw_pad2.map(\cfmax, ~padMaxBus);
~saw_pad1.map(\amp, ~padAmp);
~saw_pad2.map(\amp, ~padAmp);

~leadFeedback = {MapIn.kr("nature/lead/feedback", 0.0, 0.75)};
~leadCutoff = {MapIn.kr("nature/lead/cutoff", 400, 1500)};
~leadAmp = {MapIn.kr("nature/lead/amp", 0, 0.4)};
~sin_syn.map(\fb, ~leadFeedback);
~sin_syn.map(\cutoff, ~leadCutoff);
~sin_syn.map(\amp, ~leadAmp);

~crunchyAmp =  {MapIn.kr("nature/crunchy/amp", 0, 0.6)};
~branchAmp = {MapIn.kr("nature/branch/amp", 0, 1)};
~crunchy.map(\amp, ~crunchyAmp);
~branch.map(\amp, ~branchAmp);
)