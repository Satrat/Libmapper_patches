# LibMapper Controls

## Natural: natural_w_mappings.scd

* sinHarmAmp: volume of sinusoidal drone, ~sine_harm_bass
* sinHarmRate: rate(Hz) at which ~sine_harm_bass choices a new harmonic spectrum

* leavesAmp: volume of background leaf rustling, ~leaves

* crunchyAmp: volume of sporadic samples of crunchy leaves, ~crunchy
* crunchyDelay: delay in seconds of each ~crunchy hit
* crunchyDecay: decay in seconds of each ~crunchy hit

* branchAmp: volume of percussion line, made from sampled branch snap, ~branch
* branchDelay: delay in seconds of each ~branch hit
* branchDecay: decay in seconds of each ~branch hit

* padAmp: volume of sawtooth pads
* padMinCutoff: min cutoff frequency of ~saw_pad1 and ~saw_pad2
* padMaxCutoff: max cutoff frequency of ~saw_pad1 and ~saw_pad2

* leadAmp: volume of fluttery sinusoid lead line, ~sin_syn
* leadFB: amount of feedback in ~sin_syn
* leadCutoff: lowpass cutoff frequency for ~sin_syn

## Artificial: artificial_w_mappings.scd

* sawPad1Amp: volume of sawtooth drone ~bp_saw (sawPad2Amp, sawPad3Amp similarly control ~bp_saw2 and ~bp_saw3)
* sawPad1MaxMod: max Hz cutoff frequency of ~bp_saw is modulated by (sawPad2MaxMod, sawPad3MaxMod similarly control ~bp_saw2 and ~bp_saw3)

* grainAmp: volume of granular synthesizer, ~grain
* grainSize: length of each grain in seconds
* grainRand: how much grain length is randomized
* grainFreqScale: multiplicative pitch shift on ~grain

* ring1Amp: volume of ring mod countermelody ~ring1
* ring2Amp: volume of ring mod countermelody ~ring2
* ring3Amp: volume of ring mod melody ~ring3
* ringDecay: decay time in sec on each ~ring3 note
* ringMult: upper bound for ~ring3 modulation multiplication factor

* chaosAmp: volume of noise drum, ~crack
* chaosRelease: release time of ~crack in seconds
* chaosAmnt: amount of crackling in ~crack
