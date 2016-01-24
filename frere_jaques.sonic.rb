# frere jacues
frere1 = [:g4, 0.5, :a4, 0.5, :b4, 0.5, :g4, 0.5]
# dormez tu?
frere2 = [:b4, 0.5, :c5, 0.5, :d5, 1.0]
# do do do do dooo dooo
frere3 = [:d5, 0.25, :e5, 0.25, :d5, 0.25, :c5, 0.25, :b4, 0.5, :g4, 0.5]
# ding dang dong
frere4 = [:g4, 0.5, :d4, 0.5, :g4, 1.0]


#bass drum
bass1 = [2,-6,1,-2,1,-8].ring
#cymbal
cymbal1 = [1,-8,1,-2,1,-6].ring

use_synth :blade
use_bpm 80

define :play_drums do |timing, instrument|
  index = 0
  loop do
    time_or_amp = timing[index]
    if time_or_amp > 0 # time_or_amp is an amplitude
      sample instrument, amp: time_or_amp
    else # time_or_amp is a time in 1/8th notes
      sleep (0.125) * (0- time_or_amp)
    end
    index = index + 1
  end
end


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


  live_loop :bass do
    play_drums bass1, :drum_bass_hard
  end

  live_loop :cymbal do
    play_drums cymbal1, :drum_cymbal_closed
  end

  play_phrase_sleeper song
