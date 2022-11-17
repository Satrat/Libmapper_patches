Platform.userExtensionDir

"./howto_co34pt_liveCode/Setup/Setup.scd".loadRelative;
s.reboot;

p.fadeTime = 1;

//drone, sum up harmonics and oscillate between random volumes
(
~sin_harm_bass = {arg freq = 103, rate = 1.0, amp = 1.0;
	var n = 8;
	Mix.fill(n, {arg index;
		var f;
		f = freq * (index + 1);
		SinOsc.ar([f, f * 1.01], 0.0, 1/n * amp * LFNoise1.kr(rate))
	})
};
)

~sin_harm_bass.set(\freq, (60 - 24).midicps, \rate, 0.1, \amp, 0.4);
~sin_harm_bass.play;
~sin_harm_bass.stop;

b=Buffer.read(s,thisProcess.nowExecutingPath.dirname++"/audio/leaf_loop3_breath.wav");

//play loops of leaves
//volume of leaves would be a good control
~leaves = Pbind(\instrument,\bplay,\buf,b,\dur,16,\amp,0.2);
~verb_leaves = {FreeVerb.ar(~leaves,0.1,0.9)};
~verb_leaves.play;
~verb_leaves.stop(1);

//interperse crackling
g=Buffer.read(s,thisProcess.nowExecutingPath.dirname++"/audio/crunchy_wood_seg1.wav");
h=Buffer.read(s,thisProcess.nowExecutingPath.dirname++"/audio/crunchy_wood_seg2.wav");
~crunchy = Pbind(\instrument, \bplay, \buf, h, \dur, Prand([15, 20, 10],inf), \amp, 0.4);
~crunchy_delay = {CombC.ar(~crunchy, 5.0, 0.15, 1.0, 0.4, 0.0)};
~crunchy_verb = {FreeVerb.ar(~crunchy + ~crunchy_delay,0.2,0.8)};

~crunchy_verb.play;
~crunchy_verb.stop;

//use branch cracking as percussion
//TODO: slower rhythm
l = Prewrite(1, // start with 1
        (    1: [0.25,2],
            0.25: [3,3,2]/4,
        3/4: [0.25,1,0.125,0.125],
        ), 4);
l = Prewrite(1, // start with 1
        (    1: [0.5,2],
            0.5: [0.25,0.5,0.25],
		0.25: [0.5,0.5,1]
        ), 4);
l = Prewrite(2, // start with 1
        (    2: [4,2,4],
             4: [4,4,8,2,1],
		     8: [8,2,2],
        ), 4);
e = Buffer.read(s,thisProcess.nowExecutingPath.dirname++"/audio/branch_beat2.wav");
~branch = Pbind(\instrument,\bplay,\buf,e,\dur,l,\amp,0.4);
~delayed_branch = {CombC.ar(~branch, 5.0, 0.15, 1.0, 0.2, 0.0)};
~branch.play;
~delayed_branch.play;
~branch.stop;
~delayed_branch.stop;

//chord pad
//4 1 5 6
// 3 5 0 IV
// 0 2 4 I
// 4 6 1 V
// 5 0 2 vi
// Pseq([3, 0, -2, -3],inf) for saw1
// Prand([Pseq([0,2,1,2]), Pseq([5,4,2,0]), Pseq([0,3,1,2])],inf) for saw2
//TODO: more chord progression variation
~saw_pad1 = Pbind(\instrument, \bpfsaw, \f,Pkey(\freq), \scale, Scale.major, \root,0,\degree, Prand([Pseq([0,4]), Pseq([0,-3])],inf), \octave,4,\amp,0.5, \atk, 0.3, \sus, 0.7, \rel, 0.1, \ts, 8, \c1,0, \c2,1,\cfhzmin, 0.5, \cfhzmax, 1.0, \cfmin, 200, \cfmax,500, \rqmin, 0.1, \rqmax, 0.5, \lsf, 1, \dur, 16);
~saw_pad2 = Pbind(\instrument, \bpfsaw, \f,Pkey(\freq), \scale, Scale.major, \root,0, \degree, Prand([Pseq([2,1]), Pseq([0,-1])],inf), \octave,5,\amp,0.5, \atk, 0.3, \sus, 0.7, \rel, 0.1, \ts, 8, \c1,0, \c2,1,\cfhzmin, 0.1, \cfhzmax, 1.0, \cfmin, 200, \cfmax,500, \rqmin, 0.1, \rqmax, 0.5, \lsf, 1, \dur, 16);


~verb_pad = {FreeVerb.ar(~saw_pad1 + ~saw_pad2,0.3,1.2)};
~verb_pad.play;
~verb_pad.stop;

//Lead line, fluttery sine
(
SynthDef(\sin_synth, { | out=0, freq = 220, amp = 0.3, atk=0.01, sus=0.2, rel=0.1, ts=1,fb=0.5 |
	var sig, env;
	env = EnvGen.kr(Env([0,1,0.8,0],[atk,sus,rel]),timeScale:ts,doneAction:2);
	sig = SinOscFB.ar(freq, fb);
	sig = BLowPass.ar(sig*env*amp,600,2.0,1.0,0.0);
	Out.ar(out,[sig, sig]);
}).add;
)

~sin_syn = Pbind(\instrument,\sin_synth,\f,Pkey(\freq),\scale,Scale.major,\root,0,\degree,Prand([0,2,4,6,7],inf),\octave,6, \dur,Pwrand([Pseq([0.5,0.5]),Pseq([0.25,0.25,0.25,0.25]), Pseq([0.5,0.5,8])],[0.3,0.3, 0.4],inf),\amp,0.4,\sus,0.1,\atk,0.05, \rel,0.5,\fb,Pexprand(0.6,1.1),\amp,0.2);
~delayed_sin = {CombC.ar(~sin_syn, 5.0, 0.1, 3.0, 1, 0.0)};
~verb_sin = {FreeVerb.ar(~sin_syn + ~delay_sin,0.6,1.2)};
~verb_sin.play
~verb_sin.stop
