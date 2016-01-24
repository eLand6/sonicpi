# frere jacues
frere1 = [:g4, :b4, :d4, 0.5, :a4, 0.5, :b4, 0.5, :g4, 0.5]
# dormez tu?
frere2 = [:b4, 0.5, :c5, 0.5, :d5, 1.0]
# do do do do dooo dooo
frere3 = [:d5, 0.25, :e5, 0.25, :d5, 0.25, :c5, 0.25, :b4, 0.5, :g4, 0.5]
# ding dang dong
frere4 = [:g4, 0.5, :d4, 0.5, :g4, 1.0]

use_synth :blade
use_bpm 120

define :play_phrase_sleeper do |phrase|
  for note_or_rest in phrase do
      if not (note_or_rest.is_a? Numeric)
        play note_or_rest
      else
        sleep note_or_rest
      end
    end
  end

  song = frere1 + frere1 + frere2 + frere2 + frere3 + frere3 + frere4 + frere4

  in_thread do
    sleep 4
    use_synth :blade
    play_phrase_sleeper song
  end


  live_loop :drums do
    sample :drum_bass_hard, amp: 2
    sample :drum_cymbal_closed
    sleep 0.75
    sample :drum_bass_hard
    sleep 0.25
    sample :drum_bass_hard
    sample :drum_cymbal_closed
    sleep 0.25
    sample :drum_cymbal_closed
    sleep 0.75
  end

  play_phrase_sleeper song
