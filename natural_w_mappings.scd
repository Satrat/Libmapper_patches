"setup/Setup.scd".loadRelative;
Mapper.enable("Natural");

(
//drone, sum up harmonics and oscillate between random volumes
~sin_harm_bass = {arg freq = 103, rate = 1.0, amp = 1.0;
	var n = 8;
	Mix.fill(n, {arg index;
		var f;
		f = freq * (index + 1);
		SinOsc.ar([f, f * 1.01], 0.0, 1/n * amp * MapIn.kr(\sinHarmAmp, 0, 1) * LFNoise1.kr(MapIn.kr(\sinHarmRate, 0.1, 10)))
	})
};
~sin_harm_bass.set(\freq, (60 - 24).midicps, \rate, 0.1, \amp, 0.4);

//play loops of leaves
b=Buffer.read(s,thisProcess.nowExecutingPath.dirname++"/audio/leaf_loop3_breath.wav");
~leaves = Pbind(\instrument,\bplay,\buf,b,\dur,16,\amp,0.2);
~verb_leaves = {FreeVerb.ar(~leaves,0.1,0.9)  * MapIn.kr(\leavesAmp, 0, 1)};

//interperse crackling
h=Buffer.read(s,thisProcess.nowExecutingPath.dirname++"/audio/crunchy_wood_seg2.wav");
~crunchy = Pbind(\instrument, \bplay, \buf, h, \dur, Prand([15, 20, 10],inf), \amp, 0.4);
~crunchy_delay = {CombC.ar(~crunchy, 5.0, MapIn.kr(\crunchyDelay, 0.05, 0.9), MapIn.kr(\crunchyDecay, 0.5, 5.0), 0.4, 0.0)};
~crunchy_verb = {FreeVerb.ar(~crunchy + ~crunchy_delay,0.2,0.8) * MapIn.kr(\crunchyAmp, 0, 1)};

//use branch cracking as percussion
l = Prewrite(2, // start with 1
        (    2: [4,2,4],
             4: [4,4,8,2,1],
		     8: [8,2,2],
        ), 4);
e = Buffer.read(s,thisProcess.nowExecutingPath.dirname++"/audio/branch_beat2.wav");
~branch = Pbind(\instrument,\bplay,\buf,e,\dur,l,\amp,0.4);
~delayed_branch = {CombC.ar(~branch, 5.0, MapIn.kr(\branchDelay, 0.05, 0.5), MapIn.kr(\branchDecay, 0.0, 1.5) , 0.2, 0.0)};
~total_branch = {(~branch + ~delayed_branch) * MapIn.kr(\branchAmp, 0, 1)};

//chord pad
~saw_pad1 = Pbind(\instrument, \bpfsaw, \f,Pkey(\freq), \scale, Scale.major, \root,0,\degree, Prand([Pseq([0,4]), Pseq([0,-3])],inf), \octave,4,\amp,0.5, \atk, 0.3, \sus, 0.7, \rel, 0.1, \ts, 8, \c1,0, \c2,1,\cfhzmin, 0.5, \cfhzmax, 1.0, \cfmin, MapIn.kr(\padMinCutoff, 100, 200), \cfmax, MapIn.kr(\padMaxCutoff, 500, 1000), \rqmin, 0.1, \rqmax, 0.5, \lsf, 1, \dur, 16);
~saw_pad2 = Pbind(\instrument, \bpfsaw, \f,Pkey(\freq), \scale, Scale.major, \root,0, \degree, Prand([Pseq([2,1]), Pseq([0,-1])],inf), \octave,5,\amp,0.5, \atk, 0.3, \sus, 0.7, \rel, 0.1, \ts, 8, \c1,0, \c2,1,\cfhzmin, 0.1, \cfhzmax, 1.0, \cfmin, MapIn.kr(\padMinCutoff, 100, 200), \cfmax, MapIn.kr(\padMaxCutoff, 500, 1000), \rqmin, 0.1, \rqmax, 0.5, \lsf, 1, \dur, 16);
~verb_pad = {FreeVerb.ar(~saw_pad1 + ~saw_pad2,0.3,1.2) * MapIn.kr(\padAmp, 0, 1)};

//Lead line, fluttery sine
SynthDef(\sin_synth, { | out=0, freq = 220, amp = 0.3, atk=0.01, sus=0.2, rel=0.1, ts=1 |
	var sig, env;
	env = EnvGen.kr(Env([0,1,0.8,0],[atk,sus,rel]),timeScale:ts,doneAction:2);
	sig = SinOscFB.ar(freq, MapIn.kr(\leadFB, 0.0, 0.75));
	sig = BLowPass.ar(sig*env*amp,MapIn.kr(\leadCutoff, 400, 1500),2.0,1.0,0.0);
	Out.ar(out,[sig, sig]);
}).add;
~sin_syn = Pbind(\instrument,\sin_synth,\f,Pkey(\freq),\scale,Scale.major,\root,0,\degree,Prand([0,2,4,6,7],inf),\octave,6, \dur,Pwrand([Pseq([0.5,0.5]),Pseq([0.25,0.25,0.25,0.25]), Pseq([0.5,0.5,8])],[0.3,0.3, 0.4],inf),\amp,0.4,\sus,0.1,\atk,0.05, \rel,0.5,\fb,Pexprand(0.6,1.1),\amp,0.2);
~verb_sin = {FreeVerb.ar(~sin_syn,0.6,1.2)  * MapIn.kr(\leadAmp, 0, 1)};
)

(
~sin_harm_bass.play;
~verb_leaves.play;
~verb_pad.play;
~crunchy_verb.play;
~total_branch.play;
~verb_sin.play;
)

(
~sin_harm_bass.stop;
~verb_leaves.stop;
~verb_pad.stop;
~crunchy_verb.stop;
~total_branch.stop;
~verb_sin.stop;
)

// dummy mappings for testing
{MapOut.kr(SinOsc.kr(0.5), \sineTest, 0, 1)}.play;
{MapOut.kr(Control.kr(1.0), \staticTest, 0, 1)}.play; //default amplitudes
{MapOut.kr(Control.kr(0.1), \staticTestLow, 0.01, 10)}.play; //default harmRate
