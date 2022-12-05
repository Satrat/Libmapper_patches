(
//var pad1MinBus = Mapper.makeInSignalBus(s, "nature/pad1/minCutoff", 100, 200);
//var pad2MinBus = Mapper.makeInSignalBus(s, "nature/pad2/minCutoff", 100, 200);
//var pad1MaxBus = Mapper.makeInSignalBus(s, "nature/pad1/maxCutoff", 500, 1500);
//var pad2MaxBus = Mapper.makeInSignalBus(s, "nature/pad2/maxCutoff", 500, 1500);

var saw1Amp = Mapper.makeInSignalBus(s, "humans/saw1Amp", 0.0, 0.25);
var saw2Amp = Mapper.makeInSignalBus(s, "humans/saw2Amp", 0.0, 0.25);
var saw3Amp = Mapper.makeInSignalBus(s, "humans/saw3Amp", 0.0, 0.25);
var sawPad1MaxMod = Mapper.makeInSignalBus(s, "humans/sawPad1MaxMod", 1, 20);
var sawPad2MaxMod = Mapper.makeInSignalBus(s, "humans/sawPad2MaxMod", 1, 30);
var sawPad3MaxMod = Mapper.makeInSignalBus(s, "humans/sawPad3MaxMod", 1, 50);
var ring1Amp = Mapper.makeInSignalBus(s, "humans/ring/amp1", 0.0, 0.4);
var ring2Amp = Mapper.makeInSignalBus(s, "humans/ring/amp2", 0.0, 0.5);
var ring3Amp = Mapper.makeInSignalBus(s, "humans/ring/amp3", 0.0, 0.3);
var ringDecay = Mapper.makeInSignalBus(s, "humans/ring/decay", 0.1, 0.5);
var ringMult = Mapper.makeInSignalBus(s, "humans/ring/mult", 1.0, 50);
var chaosAmp = Mapper.makeInSignalBus(s, "humans/chaos/amp", 0.0, 1.0);
var chaosAmnt = Mapper.makeInSignalBus(s, "humans/chaos/amnt", 1.0, 2.0);
var chaosRelease = Mapper.makeInSignalBus(s, "humans/chaos/release", 0.01, 0.2);

//~saw_pad1.map(\cfmin, pad1MinBus);
//~saw_pad2.map(\cfmin, pad2MinBus);
//~saw_pad1.map(\cfmax, pad1MaxBus);
//~saw_pad2.map(\cfmax, pad2MaxBus);

~bp_saw.map(\amp, saw1Amp);
~bp_saw2.map(\amp, saw2Amp);
~bp_saw3.map(\amp, saw3Amp);
~bp_saw.map(\cfhzmax, sawPad1MaxMod);
~bp_saw2.map(\cfhzmax, sawPad2MaxMod);
~bp_saw3.map(\cfhzmax, sawPad3MaxMod);
~ring1.map(\amp, ring1Amp);
~ring2.map(\amp, ring2Amp);
~ring3.map(\amp, ring3Amp);
~ring3.map(\d, ringDecay);
~ring3.map(\amax, ringMult);
~crack.map(\rel, chaosRelease);
~crack.map(\chaos, chaosAmnt);
~crack.map(\amp, chaosAmp);
)