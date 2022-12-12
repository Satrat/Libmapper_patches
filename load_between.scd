(
//start glitching the leaves, level of dropout adjustable
p[\lossy_leaves] = {WaveLoss.ar(p[\leaves], 80, 100, 2)};
//p[\lossy_leaves].play;


//TODO: ratio between branch and distortion adjustable
g = Prewrite(1, // start with 1
        (    1: [2,1,1],
             2: [1,2,1,3,4],
		     4: [2,1,3],
        ), 3);
f = Buffer.read(s,thisProcess.nowExecutingPath.dirname++"/audio/branch_beat2.wav");
p[\branch_between] = Pbind(\instrument,\bplay,\buf,f,\dur,g, \amp, 0.8);
p[\distorted_branch] = {CrossoverDistortion.ar(p[\branch_between], 0.2, 0.7)};
p[\total_between_branch] = {p[\branch_between] + p[\distorted_branch]};

//level of dropout and cutoff adjustable
SynthDef(\saw_synth, { | out=0, freq = 220, amp = 0.3, atk=0.01, sus=0.2, rel=0.1, ts=1, cutoff=3000 |
	var sig, env, set_cutoff;
	set_cutoff = cutoff;
	env = EnvGen.kr(Env([0,1,0.8,0],[atk,sus,rel]),timeScale:ts,doneAction:2);
	sig = Saw.ar(freq);
	sig = BLowPass.ar(sig*env*amp,set_cutoff,2.0,1.0,0.0);
	Out.ar(out,[sig, sig]);
}).add;
p[\saw_syn] = Pbind(\instrument,\saw_synth,\f,Pkey(\freq),\scale,Scale.major,\root,0,\degree,Prand([0,2,4,6,7],inf),\octave,6, \dur,Pwrand([Pseq([0.5,0.5]),Pseq([0.25,0.25,0.5]), Pseq([0.5,0.5,4])],[0.3,0.3, 0.4],inf),\amp,0.3, \sus,0.1,\atk,0.05, \rel,0.5, \amp, 0.1);
p[\lossy_lead] = {WaveLoss.ar(p[\saw_syn], 30, 100, 1)};
//p[\lossy_lead].play;



p[\ring1] = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,Scale.major,\root,0,\degree,0,\octave,5,\dur,Pseq([0.5,0.5,1],inf),\d,1.0,\amax,0.6, \amp, 0.4);

p[\ring2] = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,Scale.major,\root,0,\degree,4,\octave,5,\dur,Pwrand([Pseq([0.25,0.25,0.25,0.25]), Pseq([0.5,0.5, 0.5]), Pseq([1,1])], [0.1, 0.2, 0.7], inf), \d,1.0,\amax,0.6, \amp, 0.4);

//p[\ring1].play;
//p[\ring2].play;

k = Buffer.read(s, thisProcess.nowExecutingPath.dirname++"/audio/leaf_loop1.wav");
p[\grain_between] =  { arg size = 0.1, rand = 0.4, scale = 1.0, amp = 1.0;
    var pointer, set_rand, set_scale, set_size;
    // pointer - move from beginning to end of soundfile over 6 seconds
    pointer = LFSaw.ar(1/15).range(0, 1);
	set_rand = rand;
	set_scale = 0.75 + scale;
	set_size = 0.05 + size;
    Warp1.ar(
        numChannels:2,
        bufnum:k,
        pointer:pointer,
        freqScale:set_scale,
        windowSize: set_size,
        envbufnum:-1,
        overlaps:4, //TODO: controllable? but needs to be an int
        windowRandRatio:set_rand,
        interp:2
	) * amp
};

//p[\grain_between].play;

p[\bp_saw] = Pbind(\instrument,\bpfsaw,\f,Pkey(\freq),\scale,Scale.major,\root,0,\degree,0,\octave,4,\dur, 1, \pan,0,\detune,0.1,\cfmin,500, \cfmax,4000, \cfhzmin, 0.1, \cfhzmax, 2, \amp, 0.15);

p[\bp_saw2] = Pbind(\instrument,\bpfsaw,\f,Pkey(\freq),\scale,Scale.major,\root,0,\degree,0,\octave,3,\dur, 1, \pan,0, \detune,0.1,\cfmin,500, \cfmax,3000, \cfhzmin, 0.1, \cfhzmax, 2, \amp, 0.15);

p[\bp_saw3] = Pbind(\instrument,\bpfsaw,\f,Pkey(\freq),\scale,Scale.major,\root,0,\degree,0,\octave,2,\dur, 1, \pan,0, \detune,0.1,\cfmin,100, \cfmax,1000, \cfhzmin, 2, \cfhzmax, 2, \lsf, 50, \amp, 0.15);

//p[\bp_saw].play;
//p[\bp_saw2].play;
//p[\bp_saw3].play;
)
