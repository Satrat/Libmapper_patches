(

p[\grainSize] = {MapIn.kr("humans/grain/size", 0.0, 0.55)}; //gets offset by 0.05
p[\grainRand] = {MapIn.kr("humans/grain/rand", 0, 0.5)};
p[\grainFreqScale] = {MapIn.kr("humans/grain/freqScale", 0.0, 0.50)}; //gets offset by 0.75
p[\grainAmp] = {MapIn.kr("humans/grain/amp", 0.0, 0.6)};
p[\grain].map(\size, p[\grainSize]);
p[\grain].map(\rand, p[\grainRand]);
p[\grain].map(\scale, p[\grainFreqScale]);
p[\grain].map(\amp, p[\grainAmp]);

p[\ring1Amp] = {MapIn.kr("humans/ring/amp1", 0.0, 0.8)};
p[\ring2Amp] = {MapIn.kr("humans/ring/amp2", 0.0, 0.8)};
p[\ring3Amp] = {MapIn.kr("humans/ring/amp3", 0.0, 0.6)};
p[\ringDecay] = {MapIn.kr("humans/ring/decay", 0.1, 0.5)};
p[\ringMult] = {MapIn.kr("humans/ring/ringMult", 0.6, 20)};
p[\ring1].map(\amp, p[\ring1Amp]);
p[\ring2].map(\amp, p[\ring2Amp]);
p[\ring3].map(\amp, p[\ring3Amp]);
p[\ring3].map(\d, p[\ringDecay]);
p[\ring3].map(\amax, p[\ringMult]);

p[\chaosAmp] = {MapIn.kr("humans/chaos/amp", 0.0, 1.0)};
p[\chaosAmnt] = {MapIn.kr("humans/chaos/amnt", 1.0, 2.0)};
p[\chaosRelease] = {MapIn.kr("humans/chaos/release", 0.01, 0.5)};
p[\crack].map(\rel, p[\chaosRelease]);
p[\crack].map(\chaos, p[\chaosAmnt]);
p[\crack].map(\amp, p[\chaosAmp]);

p[\sawAmp] = {MapIn.kr("humans/pad/sawAmp", 0.0, 0.3)};
p[\sawPadMaxMod] = {MapIn.kr("humans/pad/sawPadMaxMod", 2, 50)};
p[\bp_saw].map(\amp, p[\sawAmp]);
p[\bp_saw2].map(\amp, p[\sawAmp]);
p[\bp_saw3].map(\amp, p[\sawAmp]);
p[\bp_saw].map(\cfhzmax, p[\sawPadMaxMod]);
p[\bp_saw2].map(\cfhzmax, p[\sawPadMaxMod]);
p[\bp_saw3].map(\cfhzmax, p[\sawPadMaxMod]);

)