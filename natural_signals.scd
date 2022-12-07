(
p[\sinHarmAmp] = {MapIn.kr("nature/sinHarm/amp", 0.0, 0.6)};
p[\sinHarmRate] = {MapIn.kr("nature/sinHarm/rate", 0.1, 1.0)};
p[\sin_harm_bass].map(\amp, p[\sinHarmAmp]);
p[\sin_harm_bass].map(\rate, p[\sinHarmRate]);

p[\leavesAmp] = {MapIn.kr("nature/leaves/amp", 0, 0.4)};
p[\leaves].map(\amp, p[\leavesAmp]);

p[\padAmp] = {MapIn.kr("nature/pad/amp", 0, 0.6)};
p[\saw_pad1].map(\amp, p[\padAmp]);
p[\saw_pad2].map(\amp, p[\padAmp]);

p[\leadFeedback] = {MapIn.kr("nature/lead/feedback", 0.0, 0.75)};
p[\leadCutoff] = {MapIn.kr("nature/lead/cutoff", 400, 1500)};
p[\leadAmp] = {MapIn.kr("nature/lead/amp", 0, 0.4)};
p[\sin_syn].map(\fb, p[\leadFeedback]);
p[\sin_syn].map(\cutoff, p[\leadCutoff]);
p[\sin_syn].map(\amp, p[\leadAmp]);

p[\crunchyAmp] =  {MapIn.kr("nature/crunchy/amp", 0, 0.6)};
p[\branchAmp] = {MapIn.kr("nature/branch/amp", 0, 1)};
p[\crunchy].map(\amp, p[\crunchyAmp]);
p[\branch].map(\amp, p[\branchAmp]);

)