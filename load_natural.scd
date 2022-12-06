
(
//drone, sum up harmonics and oscillate between random volumes
~sin_harm_bass = {arg freq = 65.40639132515, amp = 0.4, rate=0.1;
	var n = 8;
	Mix.fill(n, {arg index;
		var f;
		f = freq * (index + 1);
		SinOsc.ar([f, f * 1.01], 0.0, 1/n * amp * LFNoise1.kr(rate))
	})
};

//play loops of leaves
b=Buffer.read(s,thisProcess.nowExecutingPath.dirname++"/audio/leaf_loop3_breath.wav");
~leaves = Pbind(\instrument,\bplay,\buf,b,\dur,16);
~verb_leaves = {FreeVerb.ar(~leaves,0.1,0.9)};


//interperse crackling
h=Buffer.read(s,thisProcess.nowExecutingPath.dirname++"/audio/crunchy_wood_seg2.wav");
~crunchy = Pbind(\instrument, \bplay, \buf, h, \dur, Prand([15, 20, 10],inf));
~crunchy_delay = {CombL.ar(~crunchy, 5.0, MapIn.kr("nature/crunchy/delay", 0.05, 0.9), MapIn.kr("nature/crunchy/decay", 0.5, 5.0), 0.4, 0.0)};
~crunchy_verb = {FreeVerb.ar(~crunchy + ~crunchy_delay,0.2,0.8)};

//use branch cracking as percussion
l = Prewrite(2, // start with 1
        (    2: [4,2,4],
             4: [4,4,8,2,1],
		     8: [8,2,2],
        ), 4);
e = Buffer.read(s,thisProcess.nowExecutingPath.dirname++"/audio/branch_beat2.wav");
~branch = Pbind(\instrument,\bplay,\buf,e,\dur,l);
~delayed_branch = {CombL.ar(~branch, 5.0, MapIn.kr("nature/branch/delay", 0.05, 0.9), MapIn.kr("nature/branch/decay", 0.05, 1.5) , 0.2, 0.0)};
~total_branch = {(~branch + ~delayed_branch)};

//chord pad
~saw_pad1 = Pbind(\instrument, \bpfsaw, \f,Pkey(\freq), \scale, Scale.major, \root,0,\degree, Prand([Pseq([0,4]), Pseq([0,-3])],inf), \octave,4, \atk, 0.3, \sus, 0.7, \rel, 0.1, \ts, 8, \c1,0, \c2,1,\cfhzmin, 0.5, \cfhzmax, 1.0,  \rqmin, 0.1, \rqmax, 0.5, \lsf, 1, \dur, 16, \cfmin, 200, \cfmax,500);
~saw_pad2 = Pbind(\instrument, \bpfsaw, \f,Pkey(\freq), \scale, Scale.major, \root,0, \degree, Prand([Pseq([2,1]), Pseq([0,-1])],inf), \octave,5, \atk, 0.3, \sus, 0.7, \rel, 0.1, \ts, 8, \c1,0, \c2,1,\cfhzmin, 0.1, \cfhzmax, 1.0, \rqmin, 0.1, \rqmax, 0.5, \lsf, 1, \dur, 16, \cfmin, 200, \cfmax,500);
~verb_pad = {FreeVerb.ar(~saw_pad1 + ~saw_pad2,0.3,1.2)};

//Lead line, fluttery sine
SynthDef(\sin_synth, { | out=0, freq = 220, amp = 0.3, atk=0.01, sus=0.2, rel=0.1, ts=1, fb=0,cutoff=400 |
	var sig, env;
	env = EnvGen.kr(Env([0,1,0.8,0],[atk,sus,rel]),timeScale:ts,doneAction:2);
	sig = SinOscFB.ar(freq, fb);
	sig = BLowPass.ar(sig*env*amp,cutoff,2.0,1.0,0.0);
	Out.ar(out,[sig, sig]);
}).add;
~sin_syn = Pbind(\instrument,\sin_synth,\f,Pkey(\freq),\scale,Scale.major,\root,0,\degree,Prand([0,2,4,6,7],inf),\octave,6, \dur,Pwrand([Pseq([0.5,0.5]),Pseq([0.25,0.25,0.25,0.25]), Pseq([0.5,0.5,8])],[0.3,0.3, 0.4],inf),\amp,0.4,\sus,0.1,\atk,0.05, \rel,0.5,\amp,0.2);
~verb_sin = {FreeVerb.ar(~sin_syn,0.6,1.2)};
)