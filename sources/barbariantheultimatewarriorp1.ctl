;
; SkoolKit control file for Barbarian
;
; To build the HTML disassembly, run these commands:
;   tap2sna.py @barbarian.t2s
;   sna2skool.py -c barbarian.ctl barbarian.z80 > barbarian.skool
;   skool2html.py barbarian.ref
;
b 16384 Loading screen
D 16384 #UDGTABLE { #SCR2(loading) } UDGTABLE#
@ 16384 label=loading_screen
  16384,6144,32 Pixels
  22528,768,32 Attributes
@ 23296 label=reversal_table
b 23296 Bit-reversal lookup table (256 bytes).
D 23296 256-entry table mapping each byte value (0-255) to its bit-reversed equivalent. Built at startup by #R48946. Used to mirror sprite 3 bytes tile horizontally before blitting.
S 23296,256 a table containing 256 bytes from 255 to 0.
@ 23552 label=left_col_addr_table
b 23552 Game window left-column scanline address table.
N 23552 The updatable game window is 4 tile rows tall (4 x 21 = 84 scanlines, the height of the characters) from 23552 to 23718. Each entry is the VRAM byte address the leftmost pixel column for that scanline, ordered top to bottom.
N 23552 Built once at startup by #R48984: SP is set to #R23720 then decremented 84 times via PUSH HL, filling entries from the top downward. Precomputed to avoid the costly non-linear scanline calculation (#R36879 / #R36895) on every rendered row at runtime.
N 23552 At load time contains BASIC system variables that are never used again after the game starts.
  23552,168,2 84 scanline VRAM addresses, entries 0 top to 83 bottom.
@ 23720 label=udg_font_addr
b 23720 UDG Font Address.
D 23720 At load time this area contains BASIC loader code from the tape header block. Overwritten at runtime by #R48907 with the UDG font data from #R26112.
  23720 Start of UDF Font.
  23728 Basic loader code: 10 BORDER NOT PI: PAPER NOT PI: CLEAR VAL "25999": LOAD ""SCREEN$ : POKE VAL "23739",CODE "o": LOAD ""CODE : POKE VAL "23739",CODE " POKE ": PAUSE NOT PI: RANDOMIZE USR VAL "35240"
  23872 Empty area where it will be also written the UDF font.
  24056 End of UDF Fonts.
u 24064 Framebuffer block header.
D 24064 Two bytes immediately preceding the #R24066.
  24064,2
@ 24066 label=framebuffer  
g 24066 Framebuffer
D 24066 This whole area will be filled with the framebuffer (24066-26751). Overwritten by #R38547.
N 24066 At #R25938 there is BASIC ROM machine stack residue.
  25938 BASIC ROM machine stack residue.
  26002
@ 26112 label=font_table
b 26112 Font Table/framebuffer.
D 26112 #HTML[#UDGARRAY16,,3(26112-26455-8)(chars_table)]
N 26112 Used by #R48907 to copy the fonts to #R23720   
N 26112 this will be deleted by the framebuffer.
  26112 #UDG26112
  26120 #UDG26120
  26128 #UDG26128
  26136 #UDG26136
  26144 #UDG26144
  26152 #UDG26152
  26160 #UDG26160
  26168 #UDG26168
  26176 #UDG26176
  26184 #UDG26184
  26192 #UDG26192
  26200 #UDG26200
  26208 #UDG26208
  26216 #UDG26216
  26224 #UDG26224
  26232 #UDG26232
  26240 #UDG26240
  26248 #UDG26248
  26256 #UDG26256
  26264 #UDG26264
  26272 #UDG26272
  26280 #UDG26280
  26288 #UDG26288
  26296 #UDG26296
  26304 #UDG26304
  26312 #UDG26312
  26320 #UDG26320
  26328 #UDG26328
  26336 #UDG26336
  26344 #UDG26344
  26352 #UDG26352
  26360 #UDG26360
  26368 #UDG26368
  26376 #UDG26376
  26384 #UDG26384
  26392 #UDG26392
  26400 #UDG26400
  26408 #UDG26408
  26416 #UDG26416
  26424 #UDG26424
  26432 #UDG26432
  26440 #UDG26440
  26448 #UDG26448
g 26456 Framebuffer (cont.)
N 26480 Remnant of the system font table loaded into RAM as part of the main code block but never referenced at runtime. Overwritten at runtime when the framebuffer expands into this area.
  26480 #UDG26480
  26488 #UDG26488
  26496 #UDG26496
  26504 #UDG26504
  26512 #UDG26512
  26520 #UDG26520
  26528 #UDG26528
  26536 #UDG26536
  26544 #UDG26544
  26552 #UDG26552
  26560 #UDG26560
  26568 #UDG26568
  26576 #UDG26576
  26584 #UDG26584
  26592 #UDG26592
  26600 #UDG26600
  26608 #UDG26608
  26616 #UDG26616
  26624
  26744 End of framebuffer.
@ 26752 label=stage_1_bg
b 26752 Stage 1 Background
D 26752 Only contains the graphic values. The attr values are in #R46614
N 26752 #IMG(bg/stage1.png)
  26752,3360,28
@ 30112 label=stage_2_bg
b 30112 Stage 2 Background
D 30112 Only contains the graphic values. The attr values are in #R46467
N 30112 #IMG(bg/stage2.png)
  30112,3360,28
  
b 33472 Snake sprite data.
@ 33472 label=snake_sprite_0
N 33472 Four animation frames (1-byte header + 30 scanlines x 3 bytes each) used by #R39317 to animate the snake HUD when a fighter takes a hit. #R39367 sets the draw phase index in IY+7 bits 7-4 to 1 on impact; #R39317 advances
N 33472 it each frame through the 14-step ping-pong cycle (phases 0-13) via the pointer table at #R47528, resetting to idle (0) when complete.
N 33472 P1 snake (VRAM #N16416) uses a horizontally mirrored copy via #R38342 + #R38340.
N 33472 P2 snake (VRAM #N16445) uses the sprite in its natural orientation.
  33472,1 Snake Sprite 0
  33473,90,3 #IMG(snake/00.png")
@ 33563 label=snake_sprite_1
  33563,1 Snake Sprite 1
  33564,90,3 #IMG(snake/01.png")
@ 33654 label=snake_sprite_2
  33654,1 Snake Sprite 2
  33655,90,3 #IMG(snake/02.png")
@ 33745 label=snake_sprite_3
  33745,1 Snake Sprite 3
  33746,93,3 #IMG(snake/03.png")
  33839,1
c 33840 Music player.
N 33840 Title screen music player. Resets the melody and bass to the start, plays the music in loop and returns when a key is pressed.
@ 33840 label=play_music
  33840,6 Saves #R34105 (the main melody address) in position #R33867.
  33846,6 Saves #R34671 (the bass melody address) in position #R33871.
  33852,1 Disable interrupts.
  33853,3 Plays Music.
  33856,3 Keyboard ROM Routine. (Returns the key pressed in register E).
  33859,3 If E = 255 no key was pressed and returns.
  33862,1 Enable interrupts.
  33863,1 Returns.
g 33864 Music engine state buffers.
D 33864 12-byte working area for the 2-channel beeper music engine. Used by #R33911.
N 33864 The loop-pointer slots at #R33869 and #R33873 are unused pointers where #R33840 would store a fixed restart address. Superseded by #R33903, which reads the restart address inline from the music data stream.
@ 33864 label=melody_note
  33864,1 Current melody note index; used by #R33889 to look up period in #R34052
@ 33865 label=bass_note
  33865,1 Current bass note index; used by #R33889
@ 33866 label=beeper_state
  33866,1 Speaker output bit state, 0 or 16; toggled each half-cycle by #R33911
@ 33867 label=melody_ptr
W 33867,2 Current read position in melody sequence #R34105; updated by #R33876
@ 33869 label=melody_loop_ptr
W 33869,2 - UNUSED. Melody loop-back address; never written in the final build
@ 33871 label=bass_ptr
W 33871,2 Current read position in bass sequence #R34671; updated by #R33876
@ 33873 label=bass_loop_ptr
W 33873,2 - UNUSED. Bass loop-back address; never written in the final build
@ 33875 label=note_duration
  33875,1 Duration counter for the current note; loaded each note by #R33911
@ 33876 label=select_music_pointer
c 33876 Selects the next pointer and the note.
D 33876 Reads the next note from a music sequence and updates the pointer.
D 33876 If it finds the end marker (64), it restarts the sequence in a loop.
N 33876 INPUT: HL = address of sequence pointer (#R33867 or #R33871).
N 33876 OUTPUT: HL = next pointer, A = note value.
N 33876 DESTROYS: DE.
  33876,3 Loads the current note address into DE (low and high byte).
  33879,1 DE now points to the next note.
  33880,1 Reads the note value into A.
  33881,2 Compares with 64 (end of sequence marker).
  33883,2 If 64, jumps to #R33903 to restart.
  33885,3 Saves the new pointer (updates position in sequence).
  33888,1 Returns with note in A.
@ 33889 label=note_to_period_converter
c 33889 Converts note value to period.
D 33889 Converts a note value to a time period for the beeper.
D 33889 Adds 12 to the value (transposition) and uses #R34052 as period table.
N 33889 INPUT: HL = address of note buffer (#R33864 or #R33865).
N 33889 OUTPUT: H = note period, L = 1, DE = note value + 12 (Octave).
N 33889 DESTROYS: A.
  33889,1 Reads note value from buffer.
  33890,2 Adds 12 (octave/transposition adjustment).
  33892,1 E = adjusted note value.
  33893,2 D = 0.
  33895,3 HL = base address of period table #R34052.
  33898,1 HL = table + note index.
  33899,1 H = period from table.
  33900,2 L = initial half-cycle counter value.
  33902,1 Returns with period in HL.
@ 33903 label=restart_music
c 33903 Restarts sequence at loop point.
D 33903 Processes the end of sequence marker (64).
D 33903 Reads the restart address and updates the pointer to loop.
  33903,1 Advances to low byte of loop address.
  33904,1 Reads low byte of restart address.
  33905,1 Advances to high byte.
  33906,1 Reads high byte of restart address.
  33907,2 Goes back two bytes (returns to start of pointer).
  33909,2 Jumps to #R33880 to read note from new position.
@ 33911 label=music_engine
c 33911 Plays music (Beeper 2-channel engine).
D 33911 2-channel music engine for the beeper speaker.
N 33911 #HTML(<audio src="../audio/music.ogg" controls>Your browser does not support the <code>audio</code> element.</audio>)
N 33911 Plays melody (#R34105) and bass (#R34671) simultaneously.
N 33911 Uses port 254 (bit 4) to generate square waves.
N 33911 Technique: Channel mixing with independent period counters.
N 33911 Timing: Uses NOPs and alternate registers for precise timing.
N 33911 DESTROYS: AF, BC, DE, HL, IX, IY, AF', BC', DE', HL'.
  33911,3 Loads melody pointer address #R33867.
  33914,3 Gets next melody note (call to #R33876).
  33917,3 Saves note in melody buffer #R33864.
  33920,3 Loads bass pointer address #R33871.
  33923,3 Gets next bass note (call to #R33876).
  33926,3 Saves note in bass buffer #R33865.
  33929,3 HL = melody buffer address #R33864.
  33932,3 Converts bass melody to period (call to #R33889).
  33935,2 Rotates E left to extract bit 7 into Carry flag.
  33937,3 Dead branch: if note+12 >= 128 would jump into melody data at #R34106. The note range 0-40 makes this unreachable; the branch is residual defensive code.
  33940,1 Preserves melody period on stack.
  33941,3 HL = bass buffer address #R33865.
  33944,3 Converts bass note to period (call to #R33889).
  33947,1 Recovers melody period into DE (D=melody).
  33948,2 Checks if H (bass period) differs from 1.
  33950,2 If H-1 != 0, jumps to #R33956 (notes to play).
  33952,2 Checks if D (melody period) differs from 1.
  33954,2 If D-1 = 0, jumps to #R34022 (silence, both channels muted).
  33956,3 Loads duration/tempo from #R33875.
  33959,1 C = duration counter.
  33960,2 B = 0 (inner loop).
  33962,3 Loads initial beeper state from #R33866.
  33965,1 Saves to alternate registers (AF').
  33966,3 Reloads (preparation).
  33969,2 IXh = melody period (D).
  33971,2 D = 16 (constant for XOR with beeper - toggle bit 4).
  33973,2 NOPs for exact timing adjustment.
  33975,1 Swaps with alternate registers (AF').
  33976,1 Decrements melody period counter (E).
  33977,2 Sends current state to port 254 (beeper).
  33979,2 If E != 0, jumps to #R34004 (continues same half-cycle).
  33981,2 Reloads E with melody period (IXh).
  33983,1 Inverts beeper bit (XOR 16).
  33984,1 Returns to alternate registers.
  33985,1 Decrements bass period counter (L).
  33986,3 If L != 0, jumps to #R34011 (continues same bass half-cycle).
  33989,2 Sends bass state to beeper (port 254).
  33991,1 Reloads L with bass period (H).
  33992,1 Inverts beeper bit (XOR 16).
  33993,2 Decrements B and repeats inner loop (256 times).
  33995,1 Increments duration counter.
  33996,3 If C != 0, continues playing (jumps to #R33975).
  33999,1 End of note, returns.
u 34000 ADAM text
D 34000 ASCII bytes 97,100,97,109 = "ADAM". Coder Easter egg.
D 34000 Unreachable code between the music engine routines.
  34000,4
@ 34004 label=melody_running
c 34004 Melody counter still running; check bass counter independently.
D 34004 Reached when the melody counter (E) has not yet expired. Checks the bass counter (L) independently so both channels can change phase at different times within the same loop iteration.
  34004,2 Dead code, Z is always clear on entry; never branches.
  34006,1 Swaps with alternate registers.
  34007,1 Decrements bass counter.
  34008,3 If L = 0, jumps to #R33989 (end of bass half-cycle).
  34011,2 Sends state to beeper.
  34013,2 NOPs for timing adjustment.
  34015,2 Decrements B and returns to main loop #R33973.
  34017,1 Increments duration counter.
  34018,3 If C != 0, continues (jumps to #R33975).
  34021,1 Returns.
@ 34022 label=silence_routine
c 34022 Silence routine.
D 34022 Generates silence when both channels have period 0.
D 34022 Generates silence for the same duration as a note. Burns CPU cycles without toggling the beeper (port 254). CPL converts the duration so the loop count matches the timing of the main music engine.
  34022,3 Load duration and invert it (CPL) to compute the outer loop count.
  34026,1 C = outer loop counter (inverted duration).
  34027,2 Preserve BC and AF across the delay loops.
  34029,2 B = 0: inner loop runs 256 iterations.
  34031,4 Save HL; load address 0 (ROM) as timing operand.
  34035,2 Burn cycles: SRA on ROM address (write ignored, timing only).
  34037,2 Burn cycles: SRA on ROM address (write ignored, timing only).
  34039,2 Burn cycles: SRA on ROM address (write ignored, timing only).
  34041,1 NOP: fine-tune T-state count to match music engine loop.
  34042,1 Restore HL.
  34043,2 Inner loop: 256 iterations.
  34045,1 Decrement outer counter.
  34046,3 Repeat until duration elapsed.
  34049,1 Recovers AF.
  34050,1 Recovers BC.
  34051,1 Returns.
@ 34052 label=note_table
b 34052 Complete note period table (53 notes, 4+ octaves).
D 34052 Lookup table of 53 beeper periods covering the chromatic scale across 4+ octaves.
N 34052 Entries run from low notes (high period values) to high notes (low period values).
N 34052 Used by #R33889, which adds 12 to the note index before lookup (transposition offset).
N 34052 Adding 12 to the index shifts the pitch up one octave (12 semitones).
N 34052 Approximate frequency: 437500 / (period * duration).
  34052,13 Octave 1 (LOW): 255(C),240(C#) ,227(D),215(D#),203(E) ,192(F) ,180(F# ),171(G) ,161(G#) ,151(A) ,144(A#) ,136(B) ,128(C)
  34065,13 Octave 2: 121,114,108,102,96,91,86,81,76,72,68,64,61
  34078,13 Octave 3: 57,54,51,48,45,43,40,38,36,34,32,30,29
  34091,13 Octave 4: 28,27,25,24,23,21,20,19,18,17,16,15,14
  34104,1 Octave 5 (HIGH): 13,12
@ 34105 label=melody_data
b 34105 Melody music data.
D 34105 Main melody sequence for channel 1.
N 34105 #HTML(<audio src="../audio/melody.ogg" controls>Your browser does not support the <code>audio</code> element.</audio>)
N 34105 Note sequence: a note value followed by 41 plays it short (one tick). Repeated note values without 41 extend its duration (one tick per repetition). Value 41 acts as a timing separator between notes.
N 34105 values 0-40 = notes, 41 = control, 64 = end. (causes loop at #R33903).
N 34105 Notes (index table #R34052 + 12).
N 34105 Referenced by #R33867 (initial pointer).
N 34105 566 bytes of musical data that loop infinitely.
  34105 Melody data (includes notes, separators and controls).
N 34106 Entry point for loop restart during music playback. (Never used).
  34670,1 End marker (64).
@ 34671 label=bass_data
b 34671 Bass music data.
D 34671 Bass sequence for channel 2.
N 34671 #HTML(<audio src="../audio/bass.ogg" controls>Your browser does not support the <code>audio</code> element.</audio>)
N 34671 Format identical to #R34105: values 0-40 = notes, 41 = control, 64 = end.
N 34671 Referenced by #R33871 (initial pointer).
N 34671 565 bytes of bass data that complement the melody.
  34671 Bass data (includes notes, separators and controls).
N 34672 Entry point for loop restart during music playback. (Never used).
  35236,1 End marker (64).
u 35237
D 35237 3 unused bytes between the end of the bass music data and the game entry point at #R35240. Not referenced by any code.
  35237,3
@ 35240 label=entry_point
c 35240 Game Entry Point
D 35240 Sets up the system and runs the menu.
@ 35240 start
@ 35240 org=35240
  35240,1 Game Loaded (Entry Point)
  35241,3 Initialises the stack pointer to 0.
  35244,3 Jumps to the game start routine.
  35247,1 Disable interrupts.
  35248,3 Initialises the stack pointer to 0.
  35251,5 Write 255 to the fight counter buffer. (#R47558).
  35256,3 Runs the main menu via #R36130.
  35259,10 Clears the stack and zeroes, #R47429 and #R47431. (Scores Buffer).
  35269,3 Resets and draws the Player 1 score HUD via #R35426.
  35272,3 Resets and draws the Player 2 score HUD via #R35435.
  35275,3 Sets the time HUD screen address.
  35278,1 Loads DE = 0 for the initial time value.
  35279,2 B = 2 two digits to print.
  35281,4 Points IX to the time value buffer #R47524.
  35285,3 Converts the time value to ASCII and draws it via R36063.
  35288,3 Sets the round timer mode via #R35414.
  35291,1 A = 0.
  35292,9 Clears #R47474, #R46810 and #R46443 to 0.
  35301,3 Copies the stage 1 background to the screen buffer via #R38547.
  35304,3 Paints the stage to the screen row by row via R38849.
  35307,3 Resets the P1 state block via #R36776 tile 0, full energy, facing right.
  35310,3 Resets the P2 state block via #R36793 tile 23, full energy, facing left.
@ 35313 label=game_loop
  35313,3 Copy active stage background to screen buffer via #R38547.
  35316,3 Main character update and render dispatch (both fighters + goblin) via #R39617.
  35319,3 Severed head physics update and rendering via #R37997.
  35322,3 Snake energy bar animation update via #R39258.
  35325,3 Per-frame movement auto-update via #R39968.
  35328,1 Enable interrupts.
  35329,1 Wait for 50Hz frame interrupt (frame sync).
  35330,1 Disable interrupts.
  35331,3 Copy screen buffer to video RAM via #R38412.
  35334,3 Align hit indicator tile address via #R35450.
  35337,3 Per-frame screen effect update via #R40092.
  35340,3 Per-frame hit collision detection between fighters via #R39468.
  35343,3 Hit processor: score award and sound dispatch via #R35531.
  35346,3 Refresh player 1 score display via #R35426.
  35349,3 Refresh player 2 score display via #R35435.
  35352,3 Update time / fight counter HUD via #R36105.
  35355,3 Load quit key scancode from #R47439.
  35358,3 Test if quit key is pressed via #R35910.
  35361,2 Quit pressed (carry clear): jump to new round reset at #R35381.
  35363,3 Load pause key scancode from #R47438.
  35366,3 Test if pause key is pressed via #R35910.
@ 35369 label=pause_handler_entry
  35369,3 Pause pressed (carry clear): jump to pause handler at #R35514.
  35372,3 Read round timer #R46808.
  35375,1 Test if zero.
  35376,3 Timer = 0 (2P timeout): jump to post-fight handler at #R35487.
  35379,2 Loop back to next frame at #R35313.
@ 35381 label=game_reset
c 35381 Game Over, Game Reset.
N 35381 Resets game state and returns to the menu sequence at #R35247.
N 35381 IY+7 is a packed byte: bits 7-4 hold the snake animation draw phase (0=idle, 1-13=active cycle), bits 3-0 hold the current energy value (0-13). Writing 0x10 arms the snake animation for one step before #R36776 and #R36793 restore energy to 13.
  35381,8 Sets energy to 16 (0x10) in both player state blocks, priming the animation. Energy is restored to 13 by #R36776 at #R35307 and #R36793 at #R35310.
  35389,3 Runs one snake animation frame for both players via R39258; the HP bar UDG segments are not updated here.
  35392,1 A = 0.
  35393,3 Clear tackle collision flag #R47576.
  35396,3 Reset active stage index to 0 (stage 1) at #R46454.
  35399,3 HL = stage 1 graphics base #R26752.
  35402,3 Set active stage graphics pointer #R46459 to stage 1.
  35405,3 HL = stage 1 attribute data #R46614.
  35408,3 Set active stage attributes pointer #R46461 to stage 1.
  35411,3 Jump to game menu sequence at #R35247.
@ 35414 label=set_infinite_time
c 35414 Sets infinite time or not.
D 35414 Sets the timer depending if there are two or one (human) players.
N 35414 Called on each game restart via #R35288. If #R46808 is already 255 (initial value on load, or 1P/demo mode), returns immediately.
N 35414 Otherwise writes 101 to #R46808 for 2P mode: the extra counts above 90 compensate for the timer decrement between menu selection and game start, so the HUD reads 90 when combat begins.
N 35414 Subsequent rounds bypass this routine and load 90 directly via #R36519.
  35414,3 Load round timer #R46808 into A.
  35417,2 If 255, already in infinite time mode; return.
  35419,1 Return.
  35420,2 A = 101: 2 Player mode.
  35422,3 Later 90 will be written in the #R46808 via #R36519.
  35425,1 Return.
@ 35426 label=paint_score
c 35426 Score display updater.
D 35426 Redraws the 5-digit score for one player to the HUD.
N 35426 Called every frame from the game loop and once at initialisation via #R35240.
N 35426 Entry at #R35426 targets Player 1; entry at #R35435 targets Player 2.
N 35426 INPUT: None. OUTPUT: None. DESTROYS: AF, BC, DE, HL, IX and shadow registers.
  35426,3 Sets HL to the Player 1 score HUD tile address.
  35429,4 Loads the Player 1 score value address into DE.
  35433,2 Jumps to the shared print path.
N 35435 This entry point updates the Player 2 score.
N 35435 Used by the routines at #R35240 and #R37819.
  35435,3 First tile address of the Player 2 score HUD.
  35438,4 VRAM destination for Player 2 score R47431.
  35442,1 Preserves A.
  35443,2 Sets digit count to 5.
  35445,3 Converts and draws the score via #R36063.
  35448,1 Restores A.
  35449,1 Return.
@ 35450 label=align_hit_indicator
c 35450 Aligns the hit indicator screen address to a tile boundary.
N 35450 #R35531 stores the hit indicator address with a +2 column offset. This routine strips it each frame by applying AND F8h to the low byte of #R46806, ready for the next draw call.
N 35450 DESTROYS: A, HL
  35450,4 HL = #R46806, load the low byte into A.
  35454,2 AND F8h: clear bits 2-0, strip the +2 column offset.
  35456,1 Write aligned low byte back to #R46806.
  35457,1 Return.
@ 35458 label=change_stage_ptr
c 35458 Switches the active stage graphics and attribute pointers.
D 35458 Toggles #R46454 between 0 and 1, then resolves the corresponding graphics and attribute pointers from #R46455 and #R46463, storing them as the active stage for the next background paint.
  35458,8 Load active stage index #R46454, toggle it (XOR 1) and write back.
  35466,1 Preserve toggled index for the second lookup.
  35467,6 HL = graphics pointer table #R46455; resolve new graphics pointer via #R38304.
  35473,1 Restore index for the second lookup.
  35474,3 Store new graphics pointer in #R46459.
  35477,6 HL = attributes pointer table #R46463; resolve new attributes pointer via #R38304.
  35483,3 Store new attributes pointer in #R46461.
  35486,1 Return.
@ 35487 label=post_fight_handler
c 35487 Post-fight handler. Stage alternation and counter/time reset.
N 35487 Called from #R35376 on 2P timeout (#R46808=0) or from #R37796 on 1P win (#R46808 always 255 during combat). Alternates stage via #R35458 unless fight counter has reached 7. Resets fight counter to 0 and restores time to 90 only on timeout (2P mode). On 1P win (time=255), counter advances normally with no reset.
  35487,3 Read the fight counter buffer #R47558.
  35490,1 Increment only for comparison - will not be stored.
  35491,2 Would counter+1 reach 8? (1P fight limit)
  35493,3 If not fight 8, alternate the stage via #R35458.
  35496,3 Load time buffer #R46808: 255=won by combat, 0=timeout.
  35499,1 If 0: round ended by timeout (2P mode); if 255: P1 victory by combat.
  35500,2 If non-zero (P1 victory), skip the time reset.
  35502,1 Timeout path: Reset the fight counter to 0 at #R47558.
  35506,5 Restore the time to 90 at #R46808.
  35511,3 Return to the game loop.
@ 35514 label=pause_handler_routine
c 35514 Pause handler.
D 35514 Called from #R35369.
N 35514 Entered from the main game loop when the pause key #R47438 is pressed.
N 35514 Plays a sound via #R39944, waits 112ms to debounce the initial press, then polls #R47438 via #R35910 until the pause key is pressed again to resume.
N 35514 IN None. OUT None. DESTROYS AF, BC.
  35514,3 Play pause sound via #R39944.
  35517,3 Wait 112ms to absorb the initial key press.
  35520,3 Load pause key scancode from #R47438.
  35523,3 Test pause key state via #R35910. Carry=1 released, carry=0 pressed.
  35526,2 Key released - loop back, waiting for the second press.
  35528,3 Key pressed again - resume, jump to game loop at #R35313.
@ 35531 label=hit_processor
c 35531 Hit processor, score award and sound dispatcher.
D 35531 Called once per frame from the game loop. Reads the pending combat event from #R46803.
N 35531 If 0, returns immediately. Events 5-6 (guard) skip the visual/score logic and jump directly to sound dispatch.
N 35531 Events 1-4 (hit): draws a hit indicator glyph (#R26216) near the attacker column if the frame is in #R46747, awards score if the frame is in #R46775, then clears #R46803 and plays the sound for the event.
N 35531 Sound index: 1=#R39932, 2=#R39926, 3=#R39938, 4=#R39944, 5=#R39950, 6=#R39956.
N 35531 IN None. OUT None. DESTROYS AF, BC, DE, HL, IY.
  35531,3 Load pending event code from #R46803. Return if none.
  35534,2 Return if no event pending.
  35536,1 Save event/sound index.
  35537,10 Guard events 5-6: skip visual and score, jump directly to sound dispatch.
  35547,4 IY = attacker state block pointer from #R46804.
  35551,3 A = current animation frame index (IY+8).
  35554,3 Search hit-indicator table #R46747 for this frame. Z=1 if found, DE=row/column data.
  35557,3 Call #R38325 to search the table.
  35560,2 Frame not in table - skip drawing hit indicator.
  35562,1 Save DE (row/column data) while computing screen address.
  35563,3 E = attacker X tile column (IY+3).
  35566,2 D = 0, DE = 16-bit column index.
  35568,3 HL = start of attribute row 22848 (screen row for hit indicator).
  35571,1 HL += attacker column offset.
  35572,1 Restore DE (row offset in D, original X column in E).
  35573,2 A = D (row offset). If 0, already on the right row.
  35575,2 Skip row advance if row offset is 0.
  35577,3 Advance HL one attribute row (32 bytes) D times.
  35580,1 Advance one row.
  35581,1 Decrement row counter.
  35582,2 Loop until row offset consumed.
  35584,4 Test mirror flag (IY+2 bit 0): determines column direction for hit indicator.
  35588,2 Not mirrored - column = base + X tile.
  35590,2 Mirrored: shift right 8 columns, then subtract X tile (column = base + 8 - X).
  35592,1 HL += 8.
  35593,1 C = X tile column.
  35594,1 Clear carry before SBC.
  35595,2 HL -= X tile (mirrored column placement).
  35597,2 Jump to boundary check.
  35599,1 Not mirrored: C = X tile column.
  35600,1 HL += X tile (normal column placement).
  35601,2 Save column byte for boundary check (B = L).
  35603,2 Mask column to 0-31.
  35605,1 Skip if column is on a boundary tile (0, 1, 30 or 31).
  35606,2 Column 0 - skip.
  35608,4 Column 1 - skip.
  35612,4 Column 31 - skip.
  35616,4 Column 30 - skip.
  35620,1 Restore L from saved column byte B.
  35621,3 Align column to tile boundary (AND 248) and add 2-column offset.
  35624,2 OR 2: place indicator 2 columns into the tile.
  35626,1 Store final VRAM pixel address in HL.
  35627,3 Save hit indicator VRAM address to #R46806 for #R35450 to align each frame.
  35630,3 Convert pixel address H to attribute area: isolate sector bits (AND 3).
  35633,3 Shift sector bits left 3 to form attribute page high byte.
  35636,2 OR 64: set attribute page base (0x40xx).
  35638,1 H = attribute address high byte.
  35639,2 A = ASCII 61 (hit indicator glyph, UDG index 13).
  35641,3 Draw hit indicator glyph at computed screen address via #R35996.
  35644,3 Reload frame index (IY+8) for score table lookup.
  35647,3 Search score-award table #R46775 for this frame. Z=1 if found, DE=score delta.
  35650,3 Call #R38325 to search the table.
  35653,2 Frame not in score table - jump to sound dispatch.
  35655,2 A = attacker character type (IYl).
  35657,2 Is attacker P1 (type 89)?
  35659,2 Yes (P1) - jump to P1 score update at 35670.
  35661,3 P2 path: HL = P2 score buffer #R47431.
  35664,1 Add score delta DE to P2 score.
  35665,3 Write updated P2 score to #R47431.
  35668,2 Jump to sound dispatch.
  35670,3 P1 path: HL = P1 score buffer #R47429.
  35673,1 Add score delta DE to P1 score.
  35674,3 Write updated P1 score to #R47429.
  35677,1 Clear pending event code in #R46803.
  35678,3 Write 0 to #R46803.
  35681,1 Restore event/sound index from stack.
  35682,5 Sound 1 - kick #R39932.
  35687,5 Sound 2 - tackle #R39926.
  35692,5 Sound 3 - slash #R39938.
  35697,5 Sound 4 - head cut #R39944.
  35702,5 Sound 5 - guard 1 #R39950.
  35707,5 Sound 6 - guard 2 #R39956.
  35712,1 Return.
@ 35713 label=input_ai_dispatcher
c 35713 Input and AI dispatcher.
D 35713 Called once per character from #R39617.
N 35713 IY points to the active character state block. Selects between human input and AI, or returns immediately if the character is inactive. Human-controlled characters read the keyboard/joystick and store the key bitmask in IY+1. CPU-controlled characters call #R35765 to generate an AI key bitmask in their state block.
N 35713 IN IY character state block.
N 35713 OUT (IY+1) key state bitmask (human or AI).
N 35713 DESTROYS AF, A. IY is preserved on return.
  35713,3 A = (IY+0) controller type / active flag.
  35716,2 Test bit 7: 0 = human-controlled, 1 = CPU-controlled.
  35718,2 If bit 7 set (CPU), branch to AI path at 35729.
  35720,1 Human path: A = 0 means inactive character.
  35721,1 If inactive (IY+0 = 0), return immediately.
  35722,3 Call #R35825 to read human input for this controller type.
  35725,3 Store key bitmask returned in A into (IY+1).
  35728,1 Return (human-controlled case done).
  35729,2 CPU path: A = (IY+1) character type (89=P1, 98=P2).
  35731,2 Is this P1 type (89)?
  35733,2 If not P1, branch to P2 AI path at 35750.
  35735,3 Load P1 extra state byte from #R46442 (AI profile / difficulty).
  35738,2 Preserve caller IY.
  35740,4 Set IY to P1 state block base #R46425.
  35744,3 Call #R35765 to run P1 AI and write synthetic key state into IY+1.
  35747,2 Restore original IY.
  35749,1 Return (CPU-controlled P1 done).
  35750,3 P2 AI path: load P2 extra state byte from #R46433.
  35753,2 Preserve caller IY.
  35755,4 Set IY to P2 state block base #R46434.
  35759,3 Call #R35765 to run P2 AI and write synthetic key state into IY+1.
  35762,2 Restore original IY.
  35764,1 Return (CPU-controlled P2 done).
@ 35765 label=character_ai_engine  
c 35765 Character AI engine.
D 35765 Called by #R35713 with A = extra state byte (#R46442 for P1, #R46433 for P2) and IY pointing to the active character state block.
N 35765 Performs a 4-step lookup chain:
N 35765 1. extra state -> AI profile block (#R47798) via pointer table #R47618.
N 35765 2. Fighter distance (#R46834) -> profile column 0-7 via #R47578.
N 35765 3. Profile column -> movement block ID (0-22) -> 8-byte row in #R47974 (x8 offset).
N 35765 4. R register (pseudo-random, masked 0-31) + fight counter (#R47558) -> difficulty entry (#R47559) -> subindex (0-7) -> movement ID from #R47974.
N 35765 Maps the movement ID to a key-state bitmask and stores it in IY+1 so the movement engine sees it as real input.
N 35765 IN  A = extra state byte. IY = character state block.
N 35765 OUT (IY+1) = AI-generated key state bitmask.
N 35765 DESTROYS AF, BC, DE, HL.
  35765,3 HL = profile pointer table base #R47618. A = extra state index.
  35768,3 Resolve AI profile pointer via #R38304; HL = profile block address in #R47798.
  35771,1 Preserve profile block pointer.
  35772,3 A = fighter distance #R46834.
  35775,3 HL = secondary AI state-to-column table #R47578.
  35778,3 Map distance to profile column (0-7) via #R38318; A = column index.
  35781,1 Restore profile block pointer.
  35782,3 Read movement block ID from profile at column A via #R38318; A = block ID (0-22).
  35785,3 DE = 8 (byte stride per block in #R47974).
  35788,3 HL = A * 8 via #R35976; byte offset into the movement selection table.
  35791,3 DE = movement table base #R47974.
  35794,1 HL = table base + offset; points to the selected 8-byte movement block.
  35795,1 Preserve movement block pointer.
  35796,2 A = R register; pseudo-random source.
  35798,2 Mask A to 0-31; random index into the difficulty entry.
  35800,1 Preserve random value.
  35801,3 A = fight counter #R47558 (0-7); difficulty level index.
  35804,3 HL = difficulty table base #R47559.
  35807,3 Resolve difficulty entry pointer for this fight level via #R38304.
  35810,1 Restore random value.
  35811,3 Index into difficulty entry using random value via #R38318; A = subindex (0-7).
  35814,1 Restore movement block pointer.
  35815,3 Read movement ID from block at subindex A via #R38318; A = movement ID.
  35818,3 Mirror movement ID if necessary, via #R39142 (input-class table #R47458, mirror-corrected for IY+2 bit 0).
  35821,3 Store AI key bitmask in (IY+1).
  35824,1 Return.
@ 35825 label=human_input_reader
c 35825 Human controller input reader.
D 35825 Called by #R35713 with A = controller type (IY+0) and IY pointing to the character state block. For keyboard/Sinclair controllers, reads 5 scancodes (Fire, Up, Down, Left, Right) from the table for this controller type and builds a key-state bitmask.
D 35825 For Kempston, reads the joystick port directly. Returns A with bits 0-4 set for pressed keys: bit 0 = Right, bit 1 = Left, bit 2 = Down, bit 3 = Up, bit 4 = Fire.
N 35825 IN A = controller type (1-5). IY = character state block.
N 35825 OUT A = key state bitmask (bits 0-4). (Caller stores it in IY+1).
N 35825 DESTROYS AF, BC, DE, HL.
N 35825 Scancode tables: 1 = P1 keyboard #R47433, 2 = P2 keyboard #R47440 (Sinclair2 defaults), 3 = Sinclair2 fixed #R47445 (keys 6-0), 4 = Sinclair1 fixed #R47450 (keys 1-5), 5 = Kempston joystick (port 31).
  35825,3 HL = P1 keyboard scancode table #R47433 (default for type 1).
  35828,2 Is controller type = 1?
  35830,2 Yes: use P1 keyboard table at #R47433 (jump to scan loop).
  35832,3 HL = P2 keyboard scancode table #R47440 (type 2).
  35835,2 Is controller type = 2?
  35837,2 Yes: use P2 keyboard table at #R47440.
  35839,3 HL = Sinclair 2 fixed scancode table #R47445 (type 3).
  35842,2 Is controller type = 3?
  35844,2 Yes: use Sinclair 2 table at #R47445.
  35846,3 HL = Sinclair 1 fixed scancode table #R47450 (type 4).
  35849,2 Is controller type = 4?
  35851,2 Yes: use Sinclair 1 table at #R47450.
  35853,2 Is controller type = 5 (Kempston)?
  35855,1 If controller type is not 1-5, return with A unchanged (no input).
  35856,2 Read Kempston joystick state from port 31 into A.
  35858,2 Mask to lower 5 bits (Right, Left, Down, Up, Fire).
  35860,1 Return with Kempston key state in A.
  35861,2 E = 0 (result accumulator). D = 5 (remaining keys to scan).
  35863,2 Start of keyboard scan loop (5 keys).
  35865,1 A = (HL) read next scancode from table.
  35866,1 HL++ advance scancode table pointer.
  35867,3 Test key state via #R35910: Carry=1 released, Carry=0 pressed.
  35870,1 CCF invert carry so pressed -> Carry=1.
  35871,2 RL E rotate carry into E; builds bitmask LSB-first (Right,Left,Down,Up,Fire).
  35873,1 D- decrement remaining-key counter.
  35874,2 Loop until all 5 keys have been processed.
  35876,1 A = E: copy final key-state bitmask to A.
  35877,1 Return with A = key-state bitmask.
@ 35878 label=keyb_scan
c 35878 Keyboard scanner: detects single pressed key for input config (redefine keys).
N 35878 Scans 8 keyboard rows (port 0xFE) to find exactly one keypress. Used by key assignment (#R35937) to capture scancodes without conflicts.
N 35878 OUT: D=scancode (0-39) or 255 (none/multiple); Z=0 if valid key.
N 35878 DESTROYS: AF,BC,DE,H.
  35878,3 D = 255 (no-key sentinel); E = 111b (row/column base counter).
  35881,3 B = 0xFE (keyboard row mask); C = 0xFE (ULA keyboard port).
  35884,2 IN A,(C) read 5 key bits for this row from port 0xFE.
  35886,1 CPL invert bits (active-low): 1 = pressed, 0 = released.
  35887,2 AND 31 mask to bits 4-0 (the 5 keys of this row).
  35889,2 If no key bits set in this row, jump to next row.
  35891,1 First key in this scan: INC D makes D = 0.
  35892,1 If D was already 0, a previous row already had a key -> two keys pressed; abort and return immediately with D=0, Z clear.
  35893,1 H = pressed key bitmask for this row (5 bits).
  35894,1 A = current row/column base (E).
  35895,2 Subtract 8 repeatedly to align A to the correct row base slot.
  35897,2 SRL H shift key bitmask right; lowest set bit falls into carry.
  35899,2 If carry clear, no key at this column; loop to check next column.
  35901,1 Single column found: return now; D already holds scancode.
  35902,1 D = A: store computed scancode (row base + column offset).
  35903,1 E- advance row/column base for next row.
  35904,2 RLC B rotate row mask left to select next keyboard row.
  35906,2 If more rows remain (carry clear), loop back to read next row.
  35908,1 All rows scanned with no key found: CP A sets Z flag.
  35909,1 Return with Z set and D = 255 (no key pressed or conflict).
@ 35910 label=key_state_test
c 35910 Key state tester
N 35910 Converts the scancode and returns if the key is pressed or not in the carry flag.
N 35910 INPUT: A the scancode.
N 35910 OUTPUT: Current key state in the carry flag (1 released, 0 pressed).
N 35910 DESTROYS: A, BC, carry.
  35910,1 C scancode to test.
  35911,3 Extract row index bits 5-3 add 1 to get 1-based row number in A and B.
  35914,1 B row number used as shift counter.
  35915,6 Shift row bits into the low position to isolate the row index in A.
  35921,3 Extract column index bits 2-0 into A.
  35924,1 C column index bit position within the row byte.
  35925,2 Form keyboard port high byte for this row 0xFE base.
  35927,3 Shift row mask B times to select the correct keyboard half-row port address.
  35930,2 Read 5-key state from the ULA keyboard port into A.
  35932,4 Shift right C times to place the target key bit into the carry flag.
  35936,1 Returns with carry set key released, carry clear key pressed.
@ 35937 label=catch_key  
c 35937 Single-key capture prompt.
N 35937 Redefining keys, waits for the player to press a key, draws its glyph on screen and plays a confirmation sound. Returns the scancode of the chosen key in A. Loops indefinitely until a valid key press is detected (D != 255).
N 35937 Called from #R36347 in a loop to assign each of the 5 action keys (Fire, Up, Down, Left, Right, and optionally Pause and Quit).
N 35937 INPUT  HL = VRAM address where the key glyph will be drawn.
N 35937 OUTPUT A  = scancode of the selected key.
N 35937 DESTROYS AF, BC, DE.
  35937,1 Preserve VRAM address.
  35938,2 Load ASCII 63 ('?') as the prompt glyph.
  35940,3 Draw '?' at HL via #R35996 to signal awaiting input.
  35943,3 Short delay via #R39846.
  35946,3 Scan keyboard via #R35878; D = scancode, or 255 if no key pressed.
  35949,1 Restore VRAM address.
  35950,5 If D = 255 (no key), loop back to #R35937.
  35955,1 Save scancode.
  35956,1 Preserve VRAM address.
  35957,3 HL = key-glyph lookup table base (#R47476).
  35960,3 Read display glyph index for this scancode via #R38318.
  35963,1 Restore VRAM address.
  35964,3 Draw the key glyph at HL via #R35996.
  35967,2 Preserve IX.
  35969,3 Play confirmation sound via #R39944.
  35972,2 Restore IX.
  35974,1 Recover scancode into A.
  35975,1 Return with A = scancode of the selected key.
@ 35976 label=bin_multiply  
c 35976 Binary multiplier. Computes HL = A * DE.
N 35976 General-purpose 8bits * 16bits unsigned multiply using shift-and-add.
N 35976 Iterates 8 times, one per bit of A LSB first. If the current bit is set, adds DE to the HL accumulator. DE is left-shifted each iteration to track the positional value of each bit.
N 35976 Called from #R35765 with DE=8 to compute a byte offset into the AI movement table #R47974 (effective result: HL = A * 8).
N 35976 INPUT  A  = multiplicand (8-bit unsigned), DE = multiplier (16-bit unsigned).
N 35976 OUTPUT HL = A * DE (16-bit result).
N 35976 DESTROYS HL, DE, B.
  35976,5 HL = 0 (result accumulator). Test A; return immediately if A = 0.
  35981,2 B = 8 (bit counter, one iteration per bit of A).
  35983,5 Shift A right; bit 0 into carry. If carry clear, skip addition.
  35988,1 Bit was set: add current positional value DE to accumulator HL.
  35989,4 Left-shift DE (SLA E / RL D) to advance to next bit position.
  35993,2 Repeat for all 8 bits.
  35995,1 Return with HL = A * DE.
@ 35996 label=draw_character
c 35996 Single UDG character renderer
N 35996 Draws one 8x8 UDG tile from the font table at #R23720 to a VRAM address. Used to render scores, keys glyphs, menu labels and the hit indicator.
N 35996 Converts the ASCII code to a font index (SUB 48), multiplies by 8 to get the byte offset, and adds the UDG font base to locate the 8-byte tile data. Copies one byte per scanline row, calling #R36895 after each row to advance to the next VRAM scanline.
N 35996 INPUT: A = ASCII code (48+). HL = VRAM destination address. OUTPUT: None.
N 35996 DESTROYS: AF, BC, DE, HL.
  35996,1 Preserves the VRAM destination address.
  35997,2 Converts ASCII code to font index (index = A - 48).
  35999,3 Places font index in HL (L = index, H = 0).
  36002,3 Multiplies font index by 8 to obtain the byte offset into the font table.
  36005,3 Loads the UDG font base address #R23720 into DE.
  36008,1 HL now points to the first byte of the font data for this character.
  36009,1 Restores the VRAM destination address into DE.
  36010,1 Swaps registers so HL = VRAM destination, DE = font source.
  36011,2 Sets row counter to 8, one iteration per scanline.
  36013,2 Copies one font scanline byte to the screen.
  36015,3 Advances HL to the next VRAM scanline via #R36895.
  36018,1 Advances to the next font row.
  36019,2 Repeats for all 8 scanlines.
  36021,1 Return.
@ 36022 label=draw_word
c 36022 Null-terminated word renderer.
N 36022 Draws a null-terminated string from DE to screen at HL, one character per tile.
N 36022 Called by R36037 and R36130 to render individual words within a menu line.
N 36022 INPUT: DE = character data address (null-terminated). HL = VRAM destination address.
N 36022 OUTPUT: HL = VRAM address of the column after the last drawn character. DE: points past the null terminator.
N 36022 DESTROYS AF, BC, DE, HL.
  36022,1 Reads the first character byte into A.
  36023,2 Preserves DE and HL before the draw call.
  36025,3 Draws the character via #R35996.
  36028,2 Restores HL and DE.
  36030,2 Advances HL to the next column and DE to the next character.
  36032,1 Reads the next character byte.
  36033,1 Tests for null terminator. (0 = end of word).
  36034,2 Loops back if more characters remain.
  36036,1 Return.
@ 36037 label=draw_string
c 36037 String line renderer.
N 36037 Renders a full line of text composed of multiple words to screen.
N 36037 For each index, resolves the word address via #R36053 and draws it via #R36022. Stops when index value is 255.
N 36037 INPUT: HL = VRAM destination address. DE = string index list address (#R48795).
N 36037 OUTPUT: None. DESTROYS: HL, DE.
  36037,1 Preserves the index list pointer.
  36038,1 Reads the current word index into A.
  36039,3 Resolves word index to character data address in DE.
  36042,3 Draws the word. HL advances to the next free column.
  36045,1 Restores the index list pointer.
  36046,1 Advances to the next index.
  36047,1 Reads the next index.
  36048,2 Tests for end-of-line sentinel (255).
  36050,2 Loops back if more words remain.
  36052,1 Return.
@ 36053 label=word_addr_solver
c 36053 Word index to address resolver.
D 36053 Resolves a word index to its character data address from the string pointer table at #R48737.
N 36053 INPUT: A = word index. HL = VRAM address.
N 36053 OUTPUT: HL = VRAM address (preserved). DE = word data address. DESTROYS: None.
  36053,1 Preserves the VRAM address.
  36054,3 Loads the string pointer table base #R48737 into HL.
  36057,3 Resolves the pointer for index A via #R38304; result in HL.
  36060,1 Recovers the VRAM address into DE.
  36061,1 Swaps registers: HL=VRAM address, DE=word address.
  36062,1 Return.
@ 36063 label=print_dec_number
c 36063 Decimal number renderer.
D 36063 Converts an unsigned 16-bit value to decimal digits and draws them using the UDG font. Used at #R35426.
N 36063 Extracts each digit from most to least significant using repeated subtraction against a divider table pointed by IX (e.g. 10000, 1000, 100, 10, 1). Each digit is converted to ASCII (add 48) and drawn via #R35996. Uses the shadow register set to preserve the digit count and value across draw calls.
N 36063 Callers may set IX before jumping to #R36067 to use a narrower divider table (e.g. #R47524 for 2-digit display).
N 36063 INPUT: B = number of digits to print (1-5). DE value to convert. HL = start VRAM address. IX = divider table address.
N 36063 OUTPUT: None. DESTROYS: AF, BC, DE, HL, IX and shadow registers.
  36063,4 Loads the default 5-digit divider table #R47518 into IX; callers may skip this instruction by jumping to #R36067 with a custom IX.
  36067,5 Preserves B and DE, switches to shadow registers, moves the value into HL and restores the digit count in B.
  36072,6 Loads the current divider into DE and initialises the digit counter C to 255.
  36078,3 Clears carry before the subtraction loop.
  36081,6 Subtracts the divider from HL repeatedly, counting in C, until underflow; restores the last valid HL.
  36087,4 Converts the digit count in C to ASCII (add 48) and returns to the main register set.
  36091,6 Draws the digit via #R35996, then advances HL to the next character column.
  36097,5 Switches back to the shadow set and advances IX to the next divider entry.
  36102,2 Decrements B and loops for the remaining digits.
  36104,1 Return.
@ 36105 label=update_time_display
c 36105 Time or fight counter display updater.
N 36105 Redraws the 2-digit time HUD every frame.
N 36105 If #R46808 is 255 (infinite time, 1P/demo mode), displays the fight counter from #R47558 instead.
N 36105 INPUT: None. OUTPUT: None. DESTROYS: AF, BC, DE, HL, IX.
  36105,3 Loads the round timer from #R46808.
  36108,2 Tests for 255 (infinite time mode).
  36110,2 Non-255: uses the timer value directly.
  36112,3 255: loads the fight counter from #R47558 instead.
  36115,3 Sets HL to the 2-digit timer HUD tile address (16559).
  36118,3 Places the value into DE with high byte 0.
  36121,2 Sets B=2 for two digits.
  36123,4 Points IX to the 2-digit divider table #R47524.
  36127,3 Tail-calls the decimal printer at #R36067.
@ 36130 label=main_menu
c 36130 Main Menu loop
N 36130 Draws the main menu text and runs the rainbow colour animation loop until a valid option key (0-3) is pressed.
N 36130 On selection jumps to the corresponding game mode: 0=demo, 1=1P, 2=2P, 3=developer info screen.
N 36130 INPUT  None. OUTPUT None (tail-calls game mode entry points).
N 36130 DESTROYS AF, BC, DE, HL.
  36130,3 Fade out any previous screen content to black via #R38699.
  36133,3 Set HL to the top menu text position 18501.
  36136,3 Point DE to the first menu string pointer #R48795 ("SELECT OPTION").
  36139,3 Draw the string via #R36037.
  36142,3 Advance to next line position 18566.
  36145,1 Advance to next string pointer.
  36146,3 Draw "0 DEMO".
  36149,3 Advance to next line 18598.
  36152,1 Advance to next string.
  36153,3 Draw "1 ONE PLAYER".
  36156,3 Advance to next line 18630.
  36159,1 Advance to next string.
  36160,3 Draw "2 TWO PLAYER".
  36163,3 Run the rainbow animation #R36706.
  36166,3 Play music and wait for any key via #R33840.
  36169,5 Test for '0' key scancode 35 via #R35910.
  36174,3 Jump to demo mode #R36673 if pressed.
  36177,5 Test for '1' key scancode 36.
  36182,2 Jump to 1P mode #R36212 if pressed.
  36184,5 Test for '2' key scancode 28.
  36189,3 Jump to 2P mode #R36508 if pressed.
  36192,5 Test for '3' key scancode 20.
  36197,2 Loop back if not pressed.
  36199,3 For option 3: set HL back to top position 18501.
  36202,1 Preserve DE.
  36203,3 Point DE to developer string #R48662 ("FINAL V8:5>11>87").
  36206,3 Draw it via #R36022 (overwrites "SELECT OPTION").
  36209,1 Restore DE.
  36210,2 Loop back to animation and key wait.
@ 36212 label=one_player_mode
c 36212 One-player mode selector.
N 36212 Entered from main menu #R36130 when '1' key pressed.
N 36212 Replaces "0 DEMO" menu label with "0 START GAME", enables P1 energy loss, sets infinite time, configures P1 human/P2 CPU control.
N 36212 Then shows controller sub-menu (Sinclair2/Kempston/Keyboard) and jumps to main loop on selection.
N 36212 INPUT  None. OUTPUT None (tails to fadeout or key assignment). DESTROYS AF.
  36212,2 A=25: "START GAME" string index #R48737.
  36214,3 Patch #R48798 from 28 ("0 DEMO") to 25 ("0 START GAME").
  36217,1 A=0 (NOP opcode).
  36218,3 Self-modify #R39371 RET Z->NOP: enables P1 energy depletion.
  36221,2 A=255.
  36223,3 Set #R46808=255 (infinite time, 1P mode).
  36226,3 Load #R46425 (P1 control byte).
  36229,2 AND $7F: clear bit 7 (P1 human-controlled).
  36231,3 Store back to #R46425.
  36234,3 Load #R46434 (P2 control byte).
  36237,2 OR $80: set bit 7 (P2 CPU-controlled).
  36239,3 Store back to #R46434.
  36242,3 Fade out via #R36673.
  36245,3 HL=18566: controller sub-menu position 1.
  36248,3 DE=#R48809: controller strings table.
  36251,3 Draw first option via #R36037.
  36254,3 HL=18598: position 2.
  36257,1 Next string index.
  36258,3 Draw second option.
  36261,3 HL=18630: position 3.
  36264,1 Next string index.
  36265,3 Draw third option.
  36268,3 Rainbow animation #R36706.
  36271,2 Test '1' scancode 36.
  36273,3 Check pressed via #R35910.
  36276,2 Jump to Sinclair2 if pressed.
  36278,2 Test '2' scancode 28 (Kempston).
  36280,3 Check pressed.
  36283,2 Jump to Kempston if pressed.
  36285,2 Test '3' scancode 20 (Keyboard).
  36287,3 Check pressed.
  36290,2 Jump to keyboard setup if pressed.
  36292,2 No key pressed: loop back to animation+key test.
  36294,2 Sinclair2 path: A=3 (type 3, Sinclair Interface 2, port 2, keys 6-0).
  36296,3 Write controller type 3 to P1 state #R46425.
  36299,3 Fade out via #R36673.
  36302,3 Jump back to main menu loop #R36133.
  36305,2 Kempston path: A=5 (type 5, Kempston joystick, port 31).
  36307,3 Write controller type 5 to P1 state #R46425.
  36310,3 Fade out via #R36673.
  36313,3 Jump back to main menu loop #R36133.
  36316,1 Custom keyboard path: A=0.
  36317,3 Clear quit key scancode #R47439 (will be player-assigned).
  36320,3 Clear pause key scancode #R47438 (will be player-assigned).
  36323,4 IX=#R47433: P1 keyboard scancode table base.
  36327,5 Write type 1 (P1 keyboard) to P1 state #R46425.
  36332,5 Get #R46434 (P2 control byte) and sets as CPU-controlled (SET 7,A).
  36337,3 Store back to #R46434.
  36340,5 Write "1 " to Menu String #R48824 so it will be printed "SELECT KEYS PLAYER1".
  36345,2 Jump to shared key assignment loop #R36363.
@ 36347 label=control_setup
c 36347 P2 controller setup for key-assignment.
N 36347 Sets P2 controller type to Keyboard and jumps to #R36363 to define keyboard.
N 36347 Called from #R36508 (2P mode, options 2 and 3: P1 Sinclair + P2 Keyboard, P1 Kempston + P2 Keyboard).
N 36347 INPUT: None. OUTPUT: None (falls through to #R36363). DESTROYS: AF, IX.
  36347,4 IX=#R47440: P2 keyboard scancodes table.
  36351,5 Write controller type 2 (P2 keyboard) to P2 state block #R46434.
  36356,5 Write "2 " to Menu String #R48824 so it will be printed "SELECT KEYS PLAYER2".
  36361,2 Jump to shared key-assignment loop at #R36363.
  
@ 36363 label=key_assign
c 36363 Key assignment loop.
N 36363 Draws the key-assignment screen using the string table at #R48820, then captures 5 action keys (Fire, Up, Down, Left, Right) storing each scancode into consecutive bytes of the IX table via #R35937.
N 36363 Pause (#R47438) and Quit (#R47439) are captured conditionally: only if their buffer is 0.
N 36363 After all keys are captured, waits ~1.57s (14 x 112ms) then fades to black via #R36673 and jumps back to the main menu loop at #R36133.
N 36363 NOTE: The CALL at #R36502 is temporarily patched to RET (0xC9) by #R36508 option "4" so that P1 key capture returns here instead of jumping to #R36133, allowing a second call to #R36347 for P2 key capture.
N 36363 INPUT: IX = target scancode table (#R47433 P1 keyboard or #R47440 P2 keyboard).
N 36363 OUTPUT: IX table filled with captured scancodes. #R47438 and #R47439 updated.
N 36363 DESTROYS: AF, BC, DE, HL, IX.
  36363,3 Fades out current screen.
  36366,3 HL = 18501 (title row VRAM address).
  36369,3 DE = #R48820 (key-assignment screen string index table).
  36372,3 Draws title string. "SELECT KEYS PLAYER"
  36375,3 HL = 18566 (screen address).
  36378,1 Advances DE to next string index.
  36379,2 B = 4 (four loops).
  36381,2 Preserves BC and HL.
  36383,3 Draws string key during 4 loops (Fire, Up, Down, Left).
  36386,1 Restores HL.
  36387,3 BC = 32 (one screen row width).
  36390,1 Advances HL to next row.
  36391,1 Advances DE to next string index.
  36392,1 Restores BC.
  36393,2 Loops 4 times.
  36395,3 HL = 20486 (Fire label row, lower third of screen).
  36398,3 Draws Right key label ("KEY FOR RIGHT").
  36401,3 HL = 20518 (Pause label row).
  36404,1 Advances DE to next string index.
  36405,3 Draws Pause key label.
  36408,3 HL = 20550 (Quit label row).
  36411,1 Advances DE to next string index.
  36412,3 Draws Quit key label.
  36415,3 Draws rainbow colour animation.
  36418,3 HL = 18582 (VRAM slot for first key glyph).
  36421,2 B = 4 (key capture counter).
  36423,2 Preserves BC and HL.
  36425,3 Captures key: waits for keypress, draws glyph, returns scancode in A.
  36428,3 Stores scancode in current table slot.
  36431,2 Advances IX to next table slot.
  36433,1 Restores HL.
  36434,3 Short delay.
  36437,3 Short delay.
  36440,3 BC = 32 (one screen row).
  36443,1 Advances HL to next VRAM capture slot.
  36444,1 Restores BC.
  36445,2 Loops 4 times for capture the keys.
  36447,3 HL = 20502 (VRAM slot for Right key glyph).
  36450,3 Captures RIGHT key.
  36453,3 Stores Right scancode in table slot.
  36456,3 Short delay.
  36459,3 Short delay.
  36462,3 Reads Pause scancode buffer.
  36465,1 Tests if unassigned (0).
  36466,3 HL = 20534 (VRAM slot for Pause key glyph).
  36469,3 Captures Pause key if unassigned.
  36472,3 Stores Pause scancode.
  36475,3 Short delay.
  36478,3 Short delay.
  36481,3 Reads Quit scancode buffer.
  36484,1 Tests if unassigned (0).
  36485,3 HL = 20566 (VRAM slot for Quit key glyph).
  36488,3 Captures Quit key if unassigned.
  36491,3 Stores Quit scancode.
  36494,2 A = 14 (delay loop counter).
  36496,3 Delays 112ms.
  36499,1 Decrements counter.
  36500,2 Loops 14 times (1.57s total).
  36502,3 Fades to black and returns to main menu loop. Patched to RET by #R36508 during P1 key capture in 2P mode, redirecting control back here instead of jumping to #R36133.
  36505,3 Returns to main menu loop.
@ 36508 label=two_player_mode
c 36508 Two-player mode selector.
D 36508 Entered from main menu #R36130 when '2' key pressed.
N 36508 Replaces "0 DEMO" menu label with "0 START GAME", enables P1 energy loss, sets 90-second timer, configures both players human-controlled. Shows extended 5-option controller sub-menu and handles key assignment as needed.
N 36508 INPUT: None. OUTPUT: None (tails to fadeout or key assignment). DESTROYS: AF.
  36508,2 A=25: "START GAME" string index (#R48737).
  36510,3 Patch #R48798 from 28 ("0 DEMO") to 25 ("0 START GAME").
  36513,1 A=0 (NOP opcode).
  36514,3 Self-modify #R39371 RET Z->NOP: enables P1 energy depletion.
  36517,2 A=90.
  36519,3 Set #R46808=90 (countdown timer, 2P mode).
  36522,3 Load #R46425 (P1 control byte).
  36525,2 AND $7F: clear bit 7 (P1 human-controlled).
  36527,3 Store back to #R46425.
  36530,3 Load #R46434 (P2 control byte).
  36533,2 AND $7F: clear bit 7 (P2 human-controlled).
  36535,3 Store back to #R46434.
  36538,3 Fade out via #R36673.
  36541,3 HL=18501: controller sub-menu position 1.
  36544,3 DE=#R48854: 2P controller strings table.
  36547,3 Draw first option via #R36037.
  36550,3 HL=18566: position 2.
  36553,1 Next string index.
  36554,3 Draw second option.
  36557,3 HL=18598: position 3.
  36560,1 Next string index.
  36561,3 Draw third option.
  36564,3 HL=18630: position 4.
  36567,1 Next string index.
  36568,3 Draw fourth option.
  36571,3 HL=18662: position 5.
  36574,1 Next string index.
  36575,3 Draw fifth option.
  36578,3 Rainbow animation #R36706.
  36581,2 Test '1' scancode 36 (P1 Sinclair + P2 Sinclair).
  36583,3 Check pressed via #R35910.
  36586,2 Jump to Both Sinclair Joystick setup.
  36588,2 Test '2' scancode 28 (P1 Sinclair + P2 Keyboard).
  36590,3 Check pressed.
  36593,3 Jump to P1 Sinclair + P2 keys.
  36596,2 Test '3' scancode 20 (P1 Kempston + P2 Keyboard).
  36598,3 Check pressed.
  36601,2 Jump to P1 Kempston + P2 keys.
  36603,2 Test '4' scancode 12 (P1 keyboard + P2 Keyboard).
  36605,3 Check pressed.
  36608,2 Jump to Both keyboards setup.
  36610,2 Loop back if no key.
N 36612 Sets controller type and jumps to Control Setup.
  36612,3 Menu fade out #R36673. (Both Sinclair)
  36615,2 A=3: P1=Sinclair (port 2).
  36617,3 Store to #R46425.
  36620,1 A=4: P2=Sinclair (port 1).
  36621,3 Store to #R46434.
  36624,3 Jump to Main menu #R36133.
  36627,2 P1 Sinclair2 + P2 Keyboard: A=3.
  36629,3 Store to #R46425.
  36632,1 A=0.
  36633,3 Clear #R47439 (quit key).
  36636,3 Clear #R47438 (pause key).
  36639,3 Jump to P2 key assignment #R36347.
  36642,2 P1 Kempston + P2 Keyboard: A=5.
  36644,3 Store to #R46425.
  36647,1 A=0.
  36648,3 Clear #R47439 (quit).
  36651,3 Clear #R47438 (pause).
  36654,3 Jump to P2 key assignment #R36347.
  36657,2 Both keyboards: A=$C9 (RET opcode).
  36659,3 Patch #R36502 CALL converts to RET (stay after P1 keys).
  36662,3 P1 keyboard assignment #R36316.
  36665,2 A=$CD (CALL opcode).
  36667,3 Restore #R36502 CALL.
  36670,3 Jump to P2 key assignment #R36347.
@ 36673 label=menu_fade_out
c 36673 Menu fade-out transition.
N 36673 Gradually darkens the menu by decrementing the ink attribute of three rows over 7 steps with 112ms delay between each step, producing a fade-to-black effect. Then self-modifies #R39846 to skip its internal wait, clears the screen instantly, and restores #R39846 to its original value before returning.
N 36673 Called from #R36130 when transitioning away from the menu screen.
N 36673 DESTROYS AF, BC, HL.
  36673,2 7-step fade loop counter (3 rows each loop).
  36675,1 Saves the loop counter.
  36676,3 Points to the first tile of the game window.
  36679,1 Adds 1.
  36680,3 B=26 (Columns), C=3 (Rows).
  36683,3 Decrements ink of three menu rows.
  36686,3 Waits 112ms.
  36689,1 Restores the loop counter.
  36690,2 Repeats until counter reaches 0.
  36692,5 Self-modifying code: patches #R39846 with RET so the wait is skipped.
  36697,3 Clears the screen without waiting.
  36700,5 Restores #R39846 to its original value.
@ 36706 label=rainbow_animation  
c 36706 Menu rainbow colour animation.
D 36706 Cycles 7 times (112 ms each), incrementing ink tint across 7 menu rows: white -> yellow -> cyan -> green -> magenta -> green -> cyan (pause/quit conditional).
  36706,2 Set a counter of 7 loops.
  36708,1 Preserves the counter.
  36709,3 Waits 112 ms.
  36712,2 Target ink colour: white (7).
  36714,3 First attribute row base address for this colour step.
  36717,3 B=21 tiles per row, C=1 row to step.
  36720,3 Advance ink colour toward the target value via R38664.
  36723,1 Target ink colour: yellow (6).
  36724,3 Set the initial screen address to colour.
  36727,3 Increments in 1 the attribute ink.
  36730,1 Selects the next line below.
  36731,1 Target ink colour: cyan (5).
  36732,3 Increments in 1 the attribute ink.
  36735,1 Selects the next line below.
  36736,1 Target ink colour: green (4).
  36737,3 Increments in 1 the attribute ink.
  36740,1 Selects the next line below.
  36741,1 Target ink colour: magenta (3).
  36742,3 Increments in 1 the attribute ink.
  36745,1 Selects the next line below.
  36746,1 Target ink colour: green (4).
  36747,3 Increments in 1 the attribute ink.
N 36750 These two attribute writes only fire if #R47439 quit and #R47438 pause scancodes are still 0 not yet assigned. In practice both are non-zero during normal gameplay, so these rows are never coloured at runtime. They would only activate before any key assignment has occurred.
  36750,1 Selects the next line below.
  36751,1 Target ink colour: cyan (5) - conditional on pause/quit unassigned.
  36752,6 Compares if #R47439 is 0 (now is 032).
  36758,3 If is 0 increments in 1 the attribute ink.
  36761,1 Selects the next line below.
  36762,1 Target ink colour: cyan (5) - conditional on pause/quit unassigned.
  36763,6 Compares if #R47438 is 0 (now is 024).
  36769,3 If is 0 increments in 1 the attribute ink.
N 36772 End of the routine.
  36772,1 Recovers BC
  36773,2 Repeats the routine 7 times.
  36775,1 Returns.
@ 36776 label=reset_p1_state_block
c 36776 Reset P1 state block for new round.
D 36776 Called by #R37631 after P2 death and by #R37663 after P1 death.
N 36776 Resets player 1 to its initial combat state at the start of each round. Sets position and energy via #R36822, then clears the mirror flag so player 1 always starts facing right (towards the P2).
N 36776 INPUT: None, OUTPUT: None, DESTROYS: AF.
  36776,5 IY = #R46425 (player 1 state block). A = 0 as movement ID for #R36822.
  36781,3 Reset position to tile 0 (left side) and energy to 13 via #R36822.
  36784,8 Read #R46427 mirror/flags byte, clear bit 0 (mirror flag) so player 1 faces right at round start, write back to #R46427.
  36792,1 Return.
@ 36793 label=reset_p2_state_block
c 36793 Reset P2 state block for new round.
D 36793 Called from #R35240 at game start and from #R37631/#R37645 at the end of each fight, after the winning sequence completes.
N 36793 Increments the fight counter then place the P2 at right sid) with full energy and movement 28 (enter the arena), and sets bit 0 of IY+2 so the P2 starts mirrored (facing left, towards player 1).
N 36793 Symmetric counterpart to #R36776 which resets player 1 at tile 0, mirror flag cleared (facing right).
  36793,11 Increment fight counter #R47558; if 7 skip write.
  36804,9  Points P2 state block (#R46434); Sets A=23 (rightmost tile); call #R36822 to reset position and energy.
  36813,8  Set P2 mirror flag: SET 0 on IY+2 (#R46436) so P2 faces left towards P1.
  36821,1  Return.
@ 36822 label=pos_energy_reset
c 36822 Character position and energy reset.
N 36822 Writes A to IY+3 (X tile position), applies movement 28 (idle stand) via #R36838, sets IY+7 to 13 (full energy), then tail-calls #R39367 to immediately refresh the on-screen energy bar.
N 36822 INPUT:  A =starting X tile position (0=left for P1, 23=right for P2). IY = character state block (#R46425 or #R46434).
N 36822 OUTPUT: None. DESTROYS AF, BC.
  36822,3  Write A to IY+3: place character at starting X tile.
  36825,5  Apply movement 28 (enter the arena) to IY via #R36838.
  36830,5  Set IY+7 to 13: full energy.
  36835,3  Call #R39367 to redraw the energy bar.
@ 36838 label=set_char_moves  
c 36838 Set character movement.
N 36838 Changes and stores the active movement ID for the character pointed by IY (#R36776 or #R36793).
N 36838 Updates the mirror flag, stores the new frame data pointer and stores it.
N 36838 INPUT: A = new movement ID. IY = character state block.
N 36838 OUTPUT: IY = character state block with updated mirror flag (IY+2), frame pointer (IY+4, IY+5) initial frame index (IY+8). DESTROYS: AF, BC.
  36838,5 Load current movement ID from IY+6 into B; compare with A. Return if equal (no change).
  36843,2 Preserve HL and A.
  36845,3 Call #R39245: reads movement properties byte from table at #R44755 using A as index.
  36848,9 Load IY+2 (mirror/flags) into B; AND result with bit 7 only; merge with B; store back to IY+2.
  36857,1 Recover A (new movement ID).
  36858,3 Store new movement ID in IY+6.
  36861,3 Load #R44421 (movement frame pointer table) into HL.
  36864,3 Call #R38304: resolve 2-byte pointer from table using A as index; result in HL.
  36867,6 Store resolved frame pointer low byte in IY+4, high byte in IY+5.
  36873,4 Read first byte of frame data into A; store as initial frame index in IY+8.
  36877,1 Recover HL.
  36878,1 Return.
@ 36879 label=calc_prev_scanline_addr
c 36879 Calculates the VRAM address of the scanline above.
D 36879 Given a VRAM scanline address in HL, steps back one scanline, handling tile-row and screen-third boundaries in the non-linear ZX Spectrum screen layout.
N 36879 INPUT: HL = current VRAM scanline address. OUTPUT: HL = address of the scanline above. DESTROYS: A, F.
  36879,1 Steps back one scanline (H = $100, 256 bytes).
  36880,4 Checks whether the decrement crossed a tile boundary (lower 3 bits of H become 7 when wrapping backward).
  36884,1 Within the same tile; address is ready.
  36885,4 Moves up one tile row (L encodes the tile row; subtract 32 to reach the row above).
  36889,1 Tile-row underflow carried into the screen-third; address is ready.
  36890,4 No carry; the screen-third was over-decremented - adds 8 to H to correct it.
  36894,1 Return.
@ 36895 label=calc_next_scanline_addr
c 36895 Calculates the VRAM address of the scanline below.
D 36895 Given a VRAM scanline address in HL, steps forward one scanline, handling tile-row and screen-third boundaries in the non-linear ZX Spectrum screen layout.
N 36895 INPUT: HL = current VRAM scanline address. OUTPUT: HL = address of the scanline below. DESTROYS: A, F.
  36895,1 Steps forward one scanline (H encodes the scanline index within the tile).
  36896,3 Checks whether the increment crossed a tile boundary (lower 3 bits of H become 0 when wrapping forward).
  36899,1 Within the same tile; address is ready.
  36900,4 Moves down one tile row (L encodes the tile row; add 32 to reach the row below).
  36904,1 Tile-row overflow carried into the screen-third; address is ready.
  36905,4 No carry; the screen-third was over-incremented - subtracts 8 from H to correct it.
  36909,1 Return.
@ 36910 label=tile_render_engine
c 36910 Tile render engine.
N 36910 Reads one tile control byte from the source address and dispatches to one of four renderers based on its bit fields.
N 36910 Control byte: bit 7 = composite tile flag; bits 1-0 = render mode (00 direct copy, 11 AND-mask overlay, 01/10 edge mask); bit 6 = mirror flag, swaps left and right edge renderers when set.
N 36910 INPUT: DE = tile data address. HL = framebuffer destination address. OUT: None. DESTROYS: AF, B, C.
  36910,2 Reads the control byte from the tile source and advances the address.
  36912,5 Bit 7 set: composite tile - dispatches to #R37218.
  36917,8 Isolates bits 1-0; dispatches to AND-mask overlay (#R37159) if bits 1-0 are 11.
  36925,4 Dispatches to direct-copy renderer (#R37331) if bits 1-0 are 00.
  36929,7 Restores the control byte; if the mirror flag (bit 6) is set, flips bits 1-0 to swap left and right edge renderers.
  36936,5 Bit 0 set: dispatches to the AND-mask loop renderer (#R36996).
  36941,2 Sets the scanline counter (21) to the number of scanlines to render.
@ 36943 label=left_edge_loop
N 36943 Left-edge AND-mask renderer loop (21 scanlines).
N 36943 Outer loop for the left-edge AND-mask tile renderer. Calls #R36949 21 times (B=21), once per scanline of the tile.
  36941,2 B=21 (scanline counter)
  36943,3 Render one scanline via #R36949 (left-edge AND-mask renderer)
  36946,2 Loop 21 times
  36948,1 Return
@ 36949 label=left_edge_renderer
c 36949 Left-edge AND-mask tile renderer.
N 36949 Renders one scanline of a 3-byte-wide tile. Scans each byte for transparency (0xFF); the first visible byte receives a left-edge column mask via #R37057, and any remaining visible bytes are written directly to the framebuffer.
N 36949 Called 21 times per tile by the outer loop at #R36943. On return, DE and HL point to the start of the next scanline.
N 36949 INPUT: DE = tile source address (within a single 256-byte page). HL = framebuffer destination. OUTPUT: None. DESTROYS: AF, C.
  36949,2 Sets 0xFF as the transparent sentinel.
  36951,7 Reads byte 0; if not transparent, applies the left-edge column mask via #R37057; otherwise skips to the byte-1 check.
  36958,2 Byte 0 masked: jumps to write bytes 1 and 2 directly.
  36960,9 Byte 0 transparent: reads byte 1; if not transparent, applies the left-edge mask via #R37057; otherwise skips to the byte-2 check.
  36969,2 Byte 1 masked: jumps to write byte 2 directly.
  36971,9 Bytes 0 and 1 transparent: reads byte 2 and applies the mask if visible; falls through to the scanline advance.
  36980,8 Writes the remaining visible bytes directly to the framebuffer without masking.
  36988,8 Advances the framebuffer destination 30 bytes to the next scanline and steps the source pointer past this scanline.

@ 36996 label=right_edge_loop
c 36996 Right-edge AND-mask renderer loop (21 scanlines)
N 36996 Outer loop for the right-edge AND-mask tile renderer. Calls #R37004 21 times (B=21), once per scanline of the tile.
  36996,2 B=21 (scanline counter).
  36998,3 Render one scanline via #R37004.
  37001,2 Loop 21 times.
  37003,1 Return.
@ 37004 label=right_edge_renderer
c 37004 Right-edge tile scanline renderer.
D 37004 Renders one scanline of a 3-byte-wide tile onto the framebuffer, scanning from right to left.
D 37004 Locates the rightmost opaque byte (value != 255), applies the right-edge column mask via #R37114, then direct-blits any remaining bytes to its left.
D 37004 Counterpart to #R36949, which masks the left edge via #R37057.
N 37004 Transparent sentinel is 255. Tile bytes are ordered left to right: byte 0 (leftmost), byte 1 (middle), byte 2 (rightmost).
N 37004 IN: HL framebuffer scanline start address. DE tile source row start address.
N 37004 OUT: HL advanced by 32 to the next scanline. DE advanced by 3 to the next tile row.
N 37004 DESTROYS AF, C.
  37004,2 Set transparent sentinel (255) in C.
  37006,4 Advance both pointers to tile byte 2 (rightmost).
  37010,2 Read rightmost tile byte; test for transparency.
  37012,2 Transparent: check byte 1.
  37014,3 Rightmost byte is opaque: apply right-edge column mask via #R37114.
  37017,2 Byte 2 handled: direct-copy remaining bytes to the left.
  37019,2 Byte 2 transparent: step both pointers back to byte 1.
  37021,2 Read middle tile byte; test for transparency.
  37023,2 Transparent: check byte 0.
  37025,3 Middle byte is the rightmost opaque: apply right-edge column mask via #R37114.
  37028,2 Byte 1 handled: direct-copy byte 0 to the left.
  37030,2 Bytes 2 and 1 transparent: step both pointers back to byte 0.
  37032,2 Read leftmost tile byte; test for transparency.
  37034,3 Sole opaque byte: apply right-edge column mask via #R37114 if not transparent.
  37037,2 Jump to scanline advance.
  37039,2 Step both pointers back to byte 1.
  37041,2 Direct-blit byte 1 to framebuffer.
  37043,2 Step both pointers back to byte 0.
  37045,2 Direct-blit byte 0 to framebuffer.
  37047,6 Advance framebuffer pointer to next scanline (+32 bytes).
  37053,3 Advance tile source pointer to next tile row (+3 bytes).
  37056,1 Return.
@ 37057 label=left_mask_gen
c 37057 Generate left-edge column mask for partial tile blending.
D 37057 Called from #R36949 for non-0xFF tile bytes at left tile boundary.
N 37057 Counts leading 1-bits from bit 7 (MSB) to find first transparent column, loads MSB-packed mask (128,192,224,240,248,252,254) into A and falls through to #R37100.
N 37057 INPUT: A = left-edge tile byte, HL = framebuffer address, DE = tile source.
N 37057 OUTPUT: A = pixel mask or 0 (fully transparent). DESTROYS: A, C.
  37057,1 C = A (left-edge tile byte).
  37058,2 BIT 7,C: if bit 7 clear, byte is #00 fully transparent - jump #R37111.
  37062,2 A = 0x80 (10000000b) test bit 6.
  37064,4 if bit 6 clear: 1 visible column - jump #R37100 with mask 0x80.
  37068,2 A = 0xC0 (11000000b) test bit 5.
  37070,4 if bit 5 clear: 2 visible columns - jump #R37100 with mask 0xC0.
  37074,2 A = 0xE0 (11100000b) test bit 4.
  37076,4 if bit 4 clear: 3 visible columns - jump #R37100 with mask 0xE0.
  37080,2 A = 0xF0 (11110000b) test bit 3.
  37082,4 if bit 3 clear: 4 visible columns - jump #R37100 with mask 0xF0.
  37086,2 A = 0xF8 (11111000b) test bit 2.
  37088,4 if bit 2 clear: 5 visible columns - jump #R37100 with mask 0xF8.
  37092,2 A = 0xFC (11111100b) test bit 1.
  37094,4 if bit 1 clear: 6 visible columns - jump #R37100 with mask 0xFC.
  37098,2 all bits 7..1 set: 7 visible columns, A = 0xFE (11111110b) fall through to #R37100.
@ 37100 label=mask_and_blend
c 37100 Apply edge mask and blend tile byte to framebuffer.
N 37100 Shared endpoint for the left-edge mask generator (#R37057) and the right-edge mask generator (#R37114) when a sprite partially overlaps a tile column boundary.
N 37100 The caller passes a pixel mask in A (1,3,7,15,31,63,127 or the MSB-packed equivalents for the left edge). The routine clears the transparent columns in the framebuffer byte and overlays the visible sprite columns from the tile byte.
N 37100 INPUT: A = pixel mask. HL = framebuffer address. DE = tile source address of the byte to blend in.
N 37100 OUTPUT None. Framebuffer byte at (HL) updated in place.
N 37100 DESTROYS A, C.
  37100,1 save mask (A) into C before A is overwritten.
  37101,1 A = framebuffer byte at HL.
  37102,1 Clear the transparent pixels in the background.
  37103,1 Write back to framebuffer the masked background.
  37104,1 A = tile source byte at DE.
  37105,1 Invert mask bits to keep the visible sprite pixels.
  37106,1 Now C contains the modified tile byte.
  37107,1 A = framebuffer byte at HL (already masked).
  37108,1 OR C to overlay the sprite pixels.
  37109,1 Write blended result back to framebuffer.
  37110,1 Return.
@ 37111 label=mask_byte_clear
c 37111 Write transparent tile byte to framebuffer.
D 37111 Shared exit for #R37057/#R37114 when tile byte has no visible columns on edge.
N 37111 Tile encoding guarantees bit 7 (left) or bit 0 (right) clear = entire byte 0x00. Writes 0 to clear framebuffer destination byte, preserving background.
N 37111 INPUT: C = tile byte (0x00), HL = framebuffer address.
N 37111 OUTPUT: None. DESTROYS: A.
  37111,2 A = C (0x00 - no sprite pixels on this edge); Write 0 to framebuffer byte at HL.
  37113,1 Return.
@ 37114 label=right_mask_gen
c 37114 Generate right-edge column mask for partial tile blending.
D 37114 Called from #R37004 for non-0xFF tile bytes at right tile boundary.
N 37114 Counts trailing 1-bits from bit 0 (LSB) to find first transparent column, loads LSB-packed mask (1,3,7,15,31,63,127) into A and jumps to #R37100.
N 37114 INPUT: A = right-edge tile byte, HL = framebuffer address, DE = tile source.
N 37114 OUTPUT: A = pixel mask or 0 (fully transparent). DESTROYS: A, C.
  37114,1 C = right-edge tile byte. Tests bit 0: set means at least the rightmost pixel column is visible.
  37115,4 Bit 0 clear: byte is 0x00, no visible columns - jump to #R37111.
  37119,2 Bit 0 set. A = 0x01 (00000001b); test bit 1.
  37121,4 Bit 1 clear: 1 visible column - jump to #R37100 with mask 0x01.
  37125,2 A = 0x03 (00000011b); test bit 2.
  37127,4 Bit 2 clear: 2 visible columns - jump to #R37100 with mask 0x03.
  37131,2 A = 0x07 (00000111b); test bit 3.
  37133,4 Bit 3 clear: 3 visible columns - jump to #R37100 with mask 0x07.
  37137,2 A = 0x0F (00001111b); test bit 4.
  37139,4 Bit 4 clear: 4 visible columns - jump to #R37100 with mask 0x0F.
  37143,2 A = 0x1F (00011111b); test bit 5.
  37145,4 Bit 5 clear: 5 visible columns - jump to #R37100 with mask 0x1F.
  37149,2 A = 0x3F (00111111b); test bit 6.
  37151,4 Bit 6 clear: 6 visible columns - jump to #R37100 with mask 0x3F.
  37155,2 A = 0x7F (01111111b); bits 6..0 all set: 7 visible columns.
  37157,2 Jump to #R37100 with mask 0x7F.
@ 37159 label=tile_renderer
c 37159 Renders a 3-byte-wide sprite tile over 21 scanlines using AND masking.
D 37159 Per scanline: saves 3 framebuffer bytes to AND-mask scratch (#R47455), loads mask from tile data via #R36949, draws sprite pixels via #R37004, then ANDs with scratch mask for transparency.
N 37159 Framebuffer/tile pointers use alternate register bank (EXX) so #R37004 auto-advances to next scanline.
N 37159 INPUT: B = scanlines (21), HL = framebuffer address, DE = tile data pointer.
N 37159 OUTPUT: None. DESTROYS: AF,BC,DE,HL (and shadows).
  37159,2 B = 21 (full tile height).
  37161,1 save B (scanlines remaining).
  37162,2 save HL (framebuffer), DE (tile ptr).
  37164,1 EXX: framebuffer HL/tile DE -> alternate registers.
  37165,1 DE = tile data (recovered).
  37166,1 HL = framebuffer (recovered).
  37167,1 re-save HL for AND step (#R37199).
  37168,10 save 3 background bytes to AND-mask scratch (#R47455).
  37178,1 A = framebuffer byte 2
  37179,3 A save to scratch buffer+2 (#R47455+2)
  37182,2 DEC L x2: restore HL to start of 3-byte sequence
  37184,1 EXX: back to main registers. HL'/DE' hold framebuffer/tile pointers.
  37185,3 HL = mask scratch buffer (#R47455).
  37188,3 #R36949: load AND mask from tile data into scratch buffer.
  37191,1 EXX: activate HL=framebuffer, DE=tile for #R37004.
  37192,3 #R37004: draw one scanline of sprite pixels to framebuffer.
  37195,1 EXX: back to main registers (now point to next scanline).
  37196,3 HL = scratch buffer (reload).
  37199,1 DE = framebuffer address of the scanline just rendered.
  37200,3 framebuffer byte 0 (w/sprite); AND scratch byte 0 (mask); restore transparent areas
  37203,2 next byte
  37205,3 framebuffer byte 1; AND scratch byte 1; restore transparent areas
  37208,2 next byte
  37210,3 framebuffer byte 2; AND scratch byte 2; restore transparent areas
  37213,1 restore HL=framebuffer, DE=tile ptr (next scanline)
  37214,1 recover B=scanlines remaining
  37215,2 copied one scanline. Repeat for all scanlines
  37217,1 tile rendering complete
@ 37218 label=comp_tile_dispatcher
c 37218 Composite tile renderer dispatcher.
N 37218 Dispatches sub-tiles from a definition sequence for complex sprites that span multiple simple tiles.
N 37218 Reads control byte from DE (bit7=1 marks composite); indexes table at #R48433 for sequence pointer in BC at #R48269.
N 37218 Each sequence byte bits7-6 select renderer (11=AND-masked, 00=direct, 01/10=edge); bits4-0=scanlines for B.
N 37218 Original mirror bit6 XORs 01/10 modes to swap edge renderers. Bit5=1 on next byte ends sequence.
N 37218 INPUT: A = control byte (bit7=1, bit6=mirror, bits5-0=index 0-63). HL = framebuffer address. DE = tile pointer.
N 37218 OUTPUT: None. DESTROYS: AF,AF',BC.
N 37218 Setup: extracts index from control byte and loads definition sequence pointer.
  37218,2 Saves original control byte (C and AF') for mirror test and index extraction.
  37220,1 Recovers control byte from C to A.
  37221,5 Extracts index (0-63) stripping mirror flag and bit7; loads BC with sequence pointer via #R37317.
N 37226 Main loop: reads definition bytes and dispatches to renderer based on mode bits7-6 with mirror XOR for edges.
  37226,3 Main dispatch loop: loads next definition byte into A; isolates render mode bits7-6.
  37229,8 Tests for AND-mask mode (11) or direct-copy mode (00): branches to dedicated paths.
  37237,9 Recovers original control byte; tests mirror flag bit6; XOR 0xC0 if set to swap edge renderers.
  37246,18 Dispatches edge renderer via #R37296 (advances BC; A=next byte); tests bit5 end-of-sequence; loops or ends.
N 37264 AND-mask path: renders transparent sub-tile using B=scanline count via #R37161.
  37264,16 AND-mask path: extracts scanline count to B (bits4-0); renders sub-tile via #R37161; advances to next byte; tests bit5; loops or ends.
N 37280 Direct copy path: copies opaque sub-tile using B=scanline count via #R37333.
  37280,16 Direct copy path: extracts scanline count to B; renders sub-tile via #R37333; advances to next byte; tests bit5; loops or ends.
@ 37296 label=edge_mask_renderer  
c 37296 Edge-mask sub-tile renderer.
N 37296 Renders edge-masked sub-tile (left/right via bit6); extracts scanlines to B (bits4-0).
N 37296 Bit6=0: left-edge AND-mask via #R36910 (entry 36943). Bit6=1: full AND-mask via #R36998.
N 37296 Advances BC past current byte; returns next definition byte in A (bit5=1 ends sequence).
N 37296 IN: A=definition byte (bits7-6=01/10, bit6=renderer, bits4-0=scanlines). BC=def pointer.
N 37296 OUT: A=next def byte. BC=advanced. DESTROYS: AF, B, BC.
  37296,2 Saves def pointer (BC); C=def byte (bit6 tested after B set).
  37298,3 Extracts scanline count to B (bits4-0).
  37301,2 Tests bit6 of C: 0=left-edge AND-mask, 1=AND-mask loop.
  37303,2 Bit6=1: full AND-mask via #R36998 (B scanlines).
  37305,3 Bit6=0: left-edge AND-mask via #R36910 (entry #R36943, B scanlines).
  37308,2 Jump to common exit.
  37310,3 AND-mask via #R36998
  37313,2 Restores def pointer; advances BC to next def byte.
  37315,1 Loads next def byte to A; returns for end-test in caller.
  37316 Return: A = next byte for end-of-def test in #R37218.
@ 37317 label=comptile_ptr_resolver
c 37317 Composite tile pointer resolver.
D 37317 Converts a composite tile index A (0-63) into a pointer BC to its definition byte sequence in #R48269, via the 2-byte pointer table at #R48433.
N 37317 Gets the word offset into #R48433, reads the little-endian pointer at that entry and returns it in BC.
N 37317 INPUT A composite tile index (0-63, derived from control byte AND 0x3F). HL framebuffer address (preserved unchanged). OUTPUT BC pointer to definition bytes in #R48269. DESTROYS AF, BC.
  37317 Saves framebuffer address.
  37318 Computes 2-byte offset into pointer table.
  37319 Forms full offset from low byte.
  37325 Locates table (#R48433) entry for this index.
  37326 Reads pointer into BC.
  37329 Restores framebuffer address.
  37330 Returns with pointer in BC.
@ 37331 label=direct_copy_tile_renderer
c 37331 Direct copy tile renderer.
N 37331 Copies tile data directly to the framebuffer without masking: 3 bytes (24 pixels) wide, B scanlines high.
N 37331 Framebuffer advances 32 bytes per row; source DE stays in single 256-byte page.
N 37331 INPUT: B scanline count (21 full tile or sub-tile height). DE tile source address (low byte only advanced). HL framebuffer destination.
N 37331 OUTPUT: None. DESTROYS: AF,BC,DE,HL.
  37331,2 Sets B=21 for full tile height (entry from R36910).
  37333,1 Saves start-of-scanline HL.
  37334,2 Copies source byte 0 to framebuffer.
  37336,2 Points to the next byte and framebuffer address.
  37338,1 Saves start-of-scanline HL.
  37339,2 Copies source byte 1 to framebuffer.
  37341,2 Points to the next byte and framebuffer address.
  37343,1 Saves start-of-scanline HL.
  37344,2 Copies source byte 2 to framebuffer.
  37336,2 Points to the next byte and framebuffer address.
  37344,1 Advances past 3rd source byte.
  37345,1 Restores start-of-scanline HL.
  37346,5 Advances HL 32 bytes to next framebuffer row.
  37351,1 Recovers tile address.
  37352,2 Repeats B times for full height.
  37354,1 Returns.
@ 37355 label=resolve_tile_address
c 37355 Resolve tile address.
N 37355 Resolves tile index A to sprite RAM address DE.
N 37355 Selects by character type IYl (107=other #R40192; else barbarian #R49152). Computes DE=state block+(A*64); each tile=64 bytes (8x8).
N 37355 INPUT: A = tile index 0-255. IY = character state block. OUTPUT: DE = sprite RAM address.
N 37355 DESTROYS: AF,DE,HL.
  37355,1 Stores tile index in D to form index*256 in DE, ready for the *64 computation via two right-shifts.
  37356,2 Loads character type IYl to select tile bank. (89)P1, (98)P2 use #R49152. (107)goblin uses #R40192.
  37358,2 If IYl is 107, dispatch to the secondary state block #R40192.
  37360,1 Restores tile index to A.
  37361,2 Not goblin - branch to barbarian state block #R49152.
  37363,3 Goblin path - load secondary state block base #R40192.
  37366,2 Jump to common offset calculation.
  37368,3 Barbarian path - load barbarian state block base #R49152.
  37371,1 Preserve callers HL.
  37372,3 Load tile index into H to start index*256 in HL.
  37375,4 Two right-shifts on HL to obtain index*64 tile byte offset.
  37379,2 Add tile byte offset to block base low byte.
  37381,2 Complete 16-bit addition to form final address.
  37383,1 DE: final sprite RAM address.
  37384,1 Restore callers HL.
  37386,1 Return with DE pointing to tile data.
@ 37387 label=copy_rect
c 37387 Rectangular screen copy.
N 37387 Copies B bytes x C scanlines from DE to screen HL.
N 37387 Advances scanline via #R36895 after each row.
N 37387 Used for snake HUD (#R39258), row clears (#R38699) and stage blits.
N 37387 INPUT: B = bytes per row, C = row count, DE = source, HL = framebuffer destination.
N 37387 OUTPUT: None. DESTROYS: AF,BC,DE,HL.
  37387,1 Saves row counter.
  37388,1 Saves start-of-row destination.
  37389,2 Copies one byte from source to destination.
  37391,2 Advances source and destination pointers.
  37393,2 Repeats for all bytes in row.
  37395,1 Restores start-of-row destination.
  37396,3 Advances to next framebuffer scanline via #R36895.
  37399,1 Restores row counter.
  37400,1 Decrements row counter.
  37401,2 Repeats for all rows.
  37403,1 Returns.
@ 37404 label=draws_4_x_3_tiles
c 37404 Draws 4 rows of 3 tiles each from the sprite frame data.
N 37404 HL is set to the framebuffer base for the character's current X tile position row. H=94 (framebuffer init), L=IY+3 (X tile).
N 37404 Each of the 4 rows renders 3 tiles via #R37449 draw single tile, then advancing the framebuffer pointer by 663 bytes 21 scanlines x 32-byte stride to the next row.
N 37404 If the mirror flag IY2 bit 0 is set, adds an extra 2 to the column offset C before each row of tiles and 4 more between rows for right-side alignment.
N 37404 INPUT: DE = frame address. HL framebuffer row, L=IY+3 (X tile). C = initial column offset from frame data. IX = DE+1 tile index array.
N 37404 OUTPUT: None. DESTROYS: AF, BC, DE, HL, IX
  37404,2 B=4 outer loop counter, one iteration per sprite row 4 rows total.
  37406,2 Loads column offset from first frame data byte post-column into C.
  37408,1 Advances DE past column offset byte, now points to tile index array.
  37409,3 Saves DE tile index array start on stack, loads into IX for single-tile rendering.
@ 37412 label=4x3_outer_loop
  37412,3 Loads IY2 mirror flags.
  37415,2 Tests mirror flag bit 0.
  37417 Mirror inactive or adjustment complete: C ready for first tile of row (#R37421)..
  37419 Mirror active: increments C by 2 for right-side column adjustment before row
@ 37421 label=4x3_inner_loop
  37421 Draws first tile of row via #R37449 using current C offset.
  37424 Draws second tile of row.
  37427 Draws third tile of row, completing one sprite row.
  37430 Advances framebuffer HL by 663 bytes 21 scanlines to next sprite row.
  37434 Decrements row counter B.
  37435 Repeats for all 4 rows until B=0.
  37436 Loads mirror flag.
  37439 Tests mirror flag again.
  37441 Mirror inactive: Jumps to #R37412
  37443 Mirror active: adds 4 to C for inter-row right-side adjustment.
@ 37449 label=draw_single_tile
c 37449 Draws one sprite tile to the framebuffer.
N 37449 Used by the 4x3 tile renderer to draw individual tiles in a character sprite.
N 37449 Skips the draw if the tile index is 255 (empty slot).
N 37449 Applies mirror correction to the tile index if needed based on direction.
N 37449 INPUT: IX = column offset and sentinel; IY = character state block.
N 37449 OUTPUT: C adjusted for next tile position (INC/DEC based on mirror flag). DESTROYS: AF, B, DE, HL.
  37449,1 Preserves caller's BC value.
  37450,2 Sets sentinel comparison value.
  37452,1 Reads tile index from current slot.
  37453,1 Tests for empty slot sentinel.
  37454,2 Skips rendering if empty slot detected.
  37456,1 Restores tile index.
  37457,3 Self-modified: loads displacement offset from table.
  37460,3 Reloads tile index.
  37463,1 Preserves framebuffer address.
  37464,3 Resolves sprite RAM address for the tile.
  37467,3 Renders the tile to framebuffer.
  37470,1 Restores framebuffer address.
  37471,1 Restores caller's BC value.
  37472,3 Advances framebuffer pointer 3 bytes right (one tile).
  37475,3 Tests mirror flag in character state.
  37478,2 Checks mirror bit.
  37480,2 
  37482,2 Adjusts offset left if mirrored.
  37484,1 Adjusts offset right if not mirrored.
  37485,1 Returns with updated offset.
@ 37486 label=sprite_dispatcher
c 37486 Main sprite dispatcher.
N 37486 Draws the sprite for the character pointed by IY.
N 37486 Returns immediately if IY+0 is 0 (inactive character).
N 37486 Loads frame index from IY+8, resolves frame data pointer from table #R44189.
N 37486 Frame data starts with first byte as shape ID, followed by tile indices for the 4x3 sprite grid. Then sets the framebuffer row and calls #R37404 (4x3 tile renderer).
N 37486 INPUT: IY = character state block.
N 37486 DESTROYS: BC, DE, HL, IX.
  37486,1 Preserve AF.
  37487,4 Load IY+0
  37491,2 return if zero (character inactive).
  37493,6 Load frame data pointer from IY+4 (low) and IY+5 (high) into DE.
  37499,3 Read current frame byte from DE; compare with 17 (decapitation frame).
  37502,3 If frame=17, call #R37866 (decapitation setup)
  37505,3 Update IY+8 with result.
  37508,3 Load #R44189 (frame pointer table) into HL
  37511,3 call #R38304 to resolve frame address.
  37514,1 Preserve resolved frame address on stack.
  37515,6 IX = Sprites shapes table (#R43520) + A (shape ID)
  37521,4 Advance HL by 1; call #R38367 (sprites renderer, 12-slot loop).
  37525,6 Restore DE=frame address; set L=IY+3 (X tile), H=94 (framebuffer row)
  37531,3 Call 4x3 tile rendered (#R37404).
  37534,1 Recover AF.
  37535,1 Return.
@ 37536 label=anim_frame_stepper
c 37536 Animation frame stepper.
N 37536 Advances the animation frame pointer for the character pointed by IY, fires events for specific frame indices, and processes end-of-sequence sentinels.
N 37536 Frames 20 and 33 trigger a goblin spawn check via #R37666. Frame 87 (dying) plays the tackle sound via #R39926 (The winner kicks the loser). Sentinel 253 restarts the current movement via #R36838, 254 holds on the last frame, and 255 chains to the next queued animation.
N 37536 INPUT: IY character state block.
N 37536 OUTPUT: IY+4,IY+5 updated frame pointer. IY+8 new frame index.
N 37536 DESTROYS: AF, DE.
  37536,6 Load frame pointer from IY+4/IY+5 into DE.
  37542,1 Read current byte.
  37543,2 Compare with 20.
  37545,3 Frame 20 triggers goblin spawn check via #R37666.
  37548,1 Increment DE (advance frame pointer)
  37549,6 Store back in IY+4/IY+5
  37555,1 Read new byte into A
  37556,3 Store in IY+8.
  37559,2 Compare A with 33.
  37561,5 Frame 33 also triggers goblin spawn check via #R37666, preserving AF.
  37566,1 Increment DE.
  37568,2 Compare A with 87.
  37572,3 if frame 87 (dying), call #R39926 (loser receives a kick).
  37577,1 Read updated byte from DE.
  37578,2 Compare with 253 (end-of-sequence sentinel).
  37580,2 If <253, jump to #R37585 (normal frame, set RES 7,IY+2).
  37582,3 Call #R37622 (clear bit 7 of IY+2: non-controllable flag off).
  37585,1 Decrement DE.
  37586,1 Recover AF from stack.
  37587,3 If A<253, return (normal case).
  37590,4 If A=253, Jump forward to #R37611 (load IY+6 (movement ID) and call #R36843 to apply movement loop).
  37594,4 If A=255 concatenates next animation (call #R37627 to reset: INC DE, jump to #R37619).
  37598,1 If else (A=254): restore frame pointer to DE-1;
  37599,10 Update IY+4/IY+5 and IY+8.
  37609,2 And jump to #R37622.
  37611,6 If A=253, (load IY+6 (movement ID) and call #R36843 to apply movement loop).
  37617,2 Reset IY+2 and return.
  37619,3 (A=255) Call #R36838 (to reload next animation).
  37622,5 RES 7,IY+2; return (clears the non-controllable bit).
  37627,4 INC DE; read byte; jump to #R37619.
@ 37631 label=end_of_fight_dispatcher
c 37631 End-of-fight dispatcher.
N 37631 Called when the loser's X tile reaches 30 (off-screen, "pulled" by the goblin).
N 37631 Checks which player has won through checking who has frame 19 (victory) in IY+6, then dispatches to the appropriate end-of-fight sequence.
  37631,4 IY = player 1 state block #R46425.
  37635,3 Load movement ID (IY+6).
  37638,2 Is movement 19 (victory)?
  37640,2 No - jump to #R37648 to check time/P2 (P1 has died).
  37642,3 Yes - P1 wins: call #R37714 (score update, victory sequence (P2 has died).
  37645,3 Jump to #R36793 to reinitialise P2 block for next round.
  37648,3 Load round timer value from #R46808.
  37651,2 Is time = 255 (non-timed game = 1P game)?
  37653,3 Yes - Game over. jump to #R35381 back to menu without scoring.
  37656,4 No (It's a 2 players game); IY = P2 state block #R46434.
  37660,3 Call #R37748 to run P2-wins sequence (P1 has died, timed 2P mode).
  37663,3 Jump to #R36776 to reinitialise P1 block for next round.
@ 37666 label=goblin_entry  
c 37666 Goblin entry trigger.
D 37666 Called from #R37536 when the dying character's animation reaches frame index 20 or 33, signalling the body has settled and the goblin can enter.
D 37666 Two guard conditions are checked before spawning: the goblin is already active (R46443=255), or the severed head is still in flight (#R46810 neither 0 nor 255). If no decapitation occurred (R46810=0) or the head has already landed (#R46810=255), both guards pass and the goblin is spawned via #R37701.
N 37666 INPUT: IY = active character state block, preserved across the call.
N 37666 OUTPUT: None. Side effect: goblin state block initialised and #R46443 set to 255 if spawn conditions are met.
N 37666 DESTROYS: AF.
  37666,6 Skip if the goblin is already active (#R46443=255).
  37672,7 Head landed or no decapitation(#R46810=255): proceed to spawn.
  37679,2 Head still in flight (#R46810!=255): return and wait. 
  37681,2 Save the caller's IY before goblin initialisation overwrites it.
  37683,2 Select movement 30 (goblin entrance animation).
  37685,3 Spawn and initialise the goblin via #R37701.
  37688,10 Reset goblin frame counter (#R46446), mirror flags(#R46445), and tackle collision flag (#R47576).
  37698,2 Restore the caller's IY.
  37700,1 Return.
@ 37701 label=init_goblin
c 37701 Activate goblin and initialise its state block. 
D 37701 Called exclusively by #R37666 once all spawn guard conditions pass.
N 37701 Sets IY to #R46443 (goblin state block base) and calls #R36838 with movement ID 30 to initialise IY+2,4,5,6,8 and start the goblin entrance animation. Then, writes 255 to #R46443 (IY+0) as the active sentinel. 
N 37701 0 = goblin inactive (cleared by #R39617 when body exits screen at X=29).
N 37701 255 = goblin active (set here, guards re-entry in #R37666).
N 37701 INPUT: A = 30 (movement ID for goblin entrance animation). OUTPUT: None. DESTROYS: AF, BC, IY.
  37701,4  IY = #R46443 goblin state block base address.
  37705,3  Call #R36838 with A=30 to initialise movement and animation data.
  37708,2  A = 255: goblin active sentinel.
  37710,3  Write 255 to #R46443: marks goblin as active for #R37666 and #R39617 guard checks.
  37713,1  Return.
@ 37714 label=p1_wins_seq  
c 37714 P1-wins end-of-fight sequence.
N 37714 Called by #R37631 when P1 movement ID equals 19 (Victory), meaning P2 has been defeated.
N 37714 Updates P1 score and drains the round timer (#R37791).
  37714 Score update and timer drain via #R37791; never returns to caller.
N 37717 The rest of the routine contains UNREACHABLE CODE. In other versions of the game, after the end of fight, it applies movement 35 (walk-out animation) to exit arena on P1 state block via #R37772. This seems to be a remaining of that.
  37717 Walk-out animation (movement 35) on P1; Z set if mirror flag clear.
  37720 Mirror flag active: nothing to do.
  37721 Activate mirror flag (one-shot).
  37723 Write mirror flag to #R46427.
  37726 Read P1 row position.
  37729 Advance row by 4.
  37731 Out of bounds check (row >= 24).
  37733 Row out of bounds: return without update.
  37734 [Dead code] Unreachable compare.
  37736 [Dead code] Unreachable branch.
  37738 Write updated row position.
  37741 Return.
  37742 [Dead code] Clamp row to 23.
  37744 [Dead code] Would write clamped value.
  37747 Return.
@ 37748 label=p2_wins_seq  
c 37748 P2-wins end-of-fight sequence.
N 37748 Called by #R37631 in timed 2P mode (#R46808 != 255) with IY pointing to the P2 state block #R46434, signalling that P1 has been defeated.
N 37748 Symmetric counterpart to #R37714: same structure but operates on the P2 mirror flag (#R46436 bit 0).
N 37748 Calls #R37819 to update P2 score and decrement round timer.
  37748 Score update and timer decrement (P2 side).
N 37751 The rest of the routine contains UNREACHABLE CODE. In other versions of the game, after the end of fight, it applies movement 35 (walk-out animation) to exit arena on P2 state block via #R37772. This seems to be a remaining of that.
  37751 Walk out animation (movement 35) on P2; Z set if mirror flag clear.
  37754 Mirror flag already set: nothing to do.
  37755 Toggle bit 0 to activate mirror flag (one-shot).
  37757 Write mirror flag to #R46436.
  37760 Read P2 row position (#R46437).
  37763 Decrement row by 4.
  37765 Underflow check (row < 0 after subtraction).
  37767 Row out of bounds: return without update.
  37768 Write updated row position (#R46437).
  37771 Return.
@ 37772 label=post_fight_setup
c 37772 Post-fight winner setup. (UNUSED)
D 37772 Sets the winner's energy bar to full, applies movement 35 (walk-out animation) via #R36838, and returns the mirror flag state in Z.
N 37772 Never executed in this version: the only callers are #R37714 and #R37748, which invoke #R37791 and #R37819 immediately before the CALL to this routine. Those routines always exit via JP or JR without returning, making this entire routine unreachable. Other versions of the game do execute it and display the walk-out animation.
N 37772 INPUT: IY = winning character state block.
N 37772 OUTPUT: Z set if IY+2 bit 0 is clear (not mirrored).
N 37772 DESTROYS AF.
  37772,2 Load the full energy value (13).
  37774,3 Write it to the winner's energy display field.
  37777,3 Refresh the energy bar on screen immediately via #R39367.
  37780,2 Select movement 35 - walk-out animation.
  37782,3 Apply movement 35 to the winner's state block via #R36838.
  37785,3 Fetch the winner's current orientation state.
  37788,2 Test mirror bit; Z set if not mirrored, Z clear if mirrored.
  37790,1 Return with Z reflecting the winner's orientation.
@ 37791 label=p2_death_score_update
c 37791 P2-death score update and time drain loop.
D 37791 Called by #R37714 (P1-wins sequence) after P2 has been defeated.
N 37791 MODE 1P/DEMO (#R46808=255): jumps immediately to #R35487 end-of-match handler without touching the score. The timer is never decremented.
N 37791 MODE 2P (#R46808=0..90): awards 10 points to P1 score (#R47429) and refreshes the score display via #R35426, then calls #R37852 to decrement the timer by 1 and update the HUD. Loops until #R37852 returns Z (#R46808 has reached 0), then falls through to #R37843.
N 37791 Each iteration awards +10 to P1 and drains 1 timer unit, so the total bonus equals remaining_time * 10.
  37791 Read the round timer (#R46808).
  37794 Is it 255 (1P/demo mode - infinite time)?
  37796 Yes - jump to #R35487 end-of-match handler without scoring.
  37799 HL = current P1 score (#R47429).
  37802 DE = 10 points to add.
  37805 HL = score + 10.
  37806 Write updated score back to #R47429.
  37809 Refresh P1 score display via #R35426.
  37812 Decrement timer by 1 and update HUD via #R37852. Returns Z if timer=0.
  37815 Timer not zero - loop back to award another +10.
  37817 Timer exhausted - fall through to #R37843.
@ 37819 label=p1_death_score_update
c 37819 P1-death score update and time drain loop.
D 37819 Symmetric counterpart to #R37791. Called by #R37748 (P2-wins sequence) after P1 has been defeated.
N 37819 MODE 1P/DEMO (#R46808=255): returns immediately without scoring. The CPU never accumulates a time bonus in 1P mode.
N 37819 MODE 2P (#R46808=0..90): awards +10 to P2 score (#R47431) per timer unit drained via #R37852, until #R46808 reaches 0. Falls through to #R37843 implicitly when the loop terminates.
  37819 Read the round timer (#R46808).
  37822 Is it 255 (1P/demo mode)?
  37824 Yes - return without scoring.
  37825 HL = current P2 score (#R47431).
  37828 DE = 10 points to add.
  37831 HL = score + 10.
  37832 Write updated score back to #R47431.
  37835 Refresh P2 score display via #R35435.
  37838 Decrement timer by 1 and update HUD via #R37852. Returns Z if timer=0.
  37841 JTimer not zero - loop back to award another +10. Falls through to #R37843 when timer reaches 0.
@ 37843 label=post_drain_wait
c 37843 Post-drain wait and end-of-round jump.
D 37843 Called by #R37819 or #R37791 in a 2 Players game, once the score-drain loop terminates (#R46808=0).
N 37843 Waits 2 x 112 ms (~224 ms pause) then jumps to #R35381 to clear combat state and back to the menu.
  37843 Wait 224 ms.
  37849 Jump to #R35381 to clear state and back to the menu.
@ 37852 label=timer_tick
c 37852 Round timer tick: decrement, refresh HUD and play sound.
D 37852 Decrements #R46808 by 1, refreshes the timer display via #R36105 and plays the tick sound via #R39962.
D 37852 Called once per loop iteration by #R37791 and #R37819 while draining the remaining time as bonus score.
N 37852 INPUT: None. OUTPUT: Z set if the timer has reached 0, NZ if time remains. DESTROYS: AF.
  37852 Load timer value from #R46808 and decrement by 1.
  37853 Write updated timer value back to #R46808.
  37856 Preserve decremented value and flags across the HUD and sound calls.
  37857 Refresh the timer display via #R36105.
  37860 Play timer tick sound via #R39962.
  37863 Restore timer value and flags.
  37864 Set Z if timer reached 0, NZ if time still remains.
  37865 Return.
@ 37866 label=decap_setup  
c 37866 Decapitation setup.
D 37866 Called from #R37486 when the sprite dispatcher encounters frame index 17.
N 37866 IY points to the attacker state block on entry.
N 37866 Identifies the defender (opposite character) and applies movement 37 (decapitation fall) to them via #R36838. Then, if no head is already in flight (#R46810 != 1), computes the head spawn position in the framebuffer from the attacker X tile column plus a 15-row vertical offset, and initialises the flying-head state block at #R46809 via #R37944.
N 37866 IN: IY attacker state block (#R46425 or #R46434).
N 37866 OUT: None. #R46809 initialised if #R46810 != 1.
N 37866 DESTROYS AF, AF', IY.
  37866,1 Preserve AF (frame index that triggered this call).
  37867,2 Preserve IY (attacker state block).
  37869,2 A = attacker type: low byte of IY base address (89=P1, 98=P2).
  37871,4 Default: IY = P1 state block R46425 (defender if attacker is P2).
  37875,2 Is attacker P1 (type 89)?
  37877,2 No (attacker is P2) -> defender is P1, keep IY = #R46425.
  37879,4 Yes (attacker is P1) -> defender is P2, set IY = #R46434.
  37883,2 A = 37: movement code for decapitation fall.
  37885,3 Apply movement 37 to the defender via #R36838.
  37888,2 Restore IY: now points to the attacker block.
  37890,3 Read head active state from #R46810.
  37893,2 Is head already in flight (state = 1)?
  37895,2 Yes -> skip initialisation, jump to #R37942.
  37897,3 A = attacker X tile position (IY+3).
  37900,1 L = column offset in framebuffer.
  37901,2 H = 0x5E: framebuffer base #R24066.
  37903,3 DE = 480 (15 rows * 32): vertical offset to head spawn row.
  37906,1 HL = framebuffer address at attacker column, 15 rows down.
  37907,3 A = mirror flags byte (IY+2).
  37910,2 Isolate bit 0: mirror flag (1 = attacker facing left).
  37912,2 Not mirrored -> head spawns directly at attacker column, no adjustment needed.
  37914,3 DE = 6: hardcoded horizontal offset for head spawn position (mirrored sprites only).
  37917,1 Shift head spawn point 6 bytes right.
  37918,1 Save mirror bit to AF', free A for next operations.
  37919,1 A = 0.
  37920,3 Write 0 to #R46825 (redundant: always 0, never read from this buffer).
  37923,3 DE = #R47017: 18-entry head flight trajectory table (Dx,Dy pairs per frame).
  37926,3 BC = #R46853: P2 head tile sequence (default, used when attacker is P2).
  37929,2 A = attacker type (IY+0 low byte).
  37931,2 Is attacker P2 (type 98)?
  37933,2 Yes -> keep BC = #R46853 (P2 head tiles), jump to #R37938.
  37935,3 No (attacker is P1) -> BC = R46835 (P1 head tiles).
  37938,1 Restore A = mirror bit from AF'.
  37939,3 Initialise flying-head state block #R46809 via #R37944.
  37942,1 Restore AF.
  37943,1 Return.
@ 37944 label=head_init
c 37944 Initialise flying head state block.
D 37944 Called by #R37866 when the decapitation hit frame 17 is detected and no head is already in flight.
N 37944 Writes the direction flag and framebuffer position directly into #R46809 and #R46815, then falls through to R37950 to set the active state, trajectory pointer and tile sequence pointer.
N 37944 INPUT: A = direction flag (0=right, 1=left). HL = initial framebuffer address. DE = trajectory data pointer (#R47017). BC = tile sequence pointer (#R46835 or #R46853).
N 37944 OUTPUT: None. DESTROYS: A.
  37944,3 Write direction flag to #R46809.
  37947,3 Write framebuffer address to #R46815 (16-bit store).
@ 37950 label=head_reactivate
N 37950 Second entry point used by #R37964 when the goblin kicks the severed head. Re-activates the head with a new trajectory and tile source without touching direction #R46809 or current position #R46815; the head is already on screen and just needs a new bounce arc.
N 37950 INPUT: DE = #R47085 kicked-head bounce trajectory. BC = tile sequence pointer (#R46835or #R46853).
  37950,2 A = 1, head active and bouncing.
  37952,3 #R46810 = 1: mark head as active, re-enables R37997 movement logic.
  37955,4 #R46813 = DE: trajectory data pointer.
  37959,4 #R46811 = BC: tile frame sequence pointer.
  37963,1 Return.
@ 37964 label=goblin_kicks
c 37964 Goblin kicks the severed head off-screen.
N 37964 Called from #R39617 when the goblin X position matches the head screen column.
N 37964 Rewinds the tile sequence pointer by 16: reads the current pointer from #R46811, subtracts 16 to recover the original sequence base (#R46835 P1 or #R46853 P2), and passes it to #R37950 as BC. This restarts the head tile animation from frame 0 for the kick arc.
N 37964 Switches the trajectory to #R47085 (kicked-head bounce), which opens with a sharp upward arc (6 scanlines up per frame, control byte bit 0 = move-up).
;N 37964 Resets head direction to right (#R46809 = 0) so the head always exits toward the right screen edge regardless of the original decapitation direction.
N 37964 INPUT: B = Goblin X position. OUTPUT None. DESTROYS: AF, DE, HL.
  37964,5 Guard: A = #R46810 (head state flag); RET Z if 0 (head inactive).
  37969 Preserve goblin X position.
  37970 Plays sound tick.
  37974 Load current tile sequence pointer from #R46811.
  37977 Clear carry before subtraction.
  37978 BC = 16 (number of frames elapsed since head spawned).
  37981 Rewind pointer to start of tile sequence (base address of the original sequence).
  37983 Preserve rewound pointer.
  37984 BC = rewound tile sequence base (#R46835 P1 or #R46853 P2).
  37985,3 DE = #R47085 kicked-head bounce trajectory, will be written to #R46813 by #R37950.
  37988,3 Re-activates head via #R37950 with rewound tile sequence and kick trajectory.
  37991,4 #R46809 = 0: reset head direction to right, kicked off-screen right.
  37995,1 Restore goblin X position.
  37996,1 Return.
@ 37997 label=head_animator
c 37997 Flying head animator.
D 37997 Called once per frame from the main game loop via #R35319.
D 37997 Moves and renders the severed head using the 8-byte state block at #R46809, addressed via IX.
N 37997 Movement control data: 2-byte pairs (control byte, magnitude). Bit 0 = move up (#R38201), bit 1 = move down (#R38191). Pointer at IX+4,5 advances 2 bytes per frame.
N 37997 Tile sequence at IX+2,3 advances 1 byte per frame. When the byte value is 255, INC A wraps to 0 and triggers #R38180: sets #R46810=255 (landed), unblocking goblin spawn in #R37666.
N 37997 After horizontal movement, column byte (L AND 31) is checked against 0, 1 and 29. Any edge column triggers #R38186: sets #R46810=0 (fully inactive).
N 37997 Landed path: #R46810=255, INC A wraps to 0, JR Z jumps to #R38103 skipping all movement logic. The head is redrawn in place each frame until #R37964 re-activates it.
N 37997 IN None. OUT None. DESTROYS AF, BC, DE, HL, IX.
  37997,4 IX = #R46809 head state block base.
  38001,3 A = #R46810 state byte.
  38004,1 Test if inactive (state = 0).
  38005,1 Return if inactive.
  38006,1 INC A: wraps 255 (landed) to 0.
  38007,2 Landed: jump to draw-only path at #R38103.
  38009,3 Bouncing: draw ground shadow via #R38137.
  38012,3 Draw head tile at current position via #R38103.
  38015,6 HL = IX+4,5 (movement control pointer, #R46813).
  38021,1 C = control byte (bit 0=up, bit 1=down).
  38022,1 Advance past control byte.
  38023,1 B = magnitude (scanlines to move this frame).
  38024,6 HL = IX+6,7 (current framebuffer address, #R46815).
  38030,2 Bit 0 set: move up.
  38032,3 Move up B scanlines via #R38201.
  38035,2 Bit 1 set: move down.
  38037,3 Move down B scanlines via #R38191.
  38040,3 A = IX+0 direction flag.
  38043,2 Direction = left?
  38045,3 Yes: DEC L (move one column left) via #R38212.
  38048,3 No: INC L (move one column right) via #R38216.
  38051,6 Store updated framebuffer address back to IX+6,7 (#R46815).
  38057,1 Read column byte from updated framebuffer address (L).
  38058,2 Mask to 5 bits to get screen column (0-31).
  38060,1 Column = 0: left edge, deactivate.
  38061,2 Deactivate via #R38186.
  38063,2 Column = 1: near left edge, deactivate.
  38065,2 Deactivate via #R38186.
  38067,2 Column = 29: right edge, deactivate.
  38069,2 Deactivate via #R38186.
  38071,6 HL = IX+2,3 (tile animation sequence pointer, #R46811).
  38077,1 Advance sequence pointer by 1.
  38078,1 A = current tile index byte.
  38079,1 INC A: test for end-of-sequence sentinel (255 wraps to 0).
  38080,2 Sentinel: mark head as landed via #R38180.
  38082,6 Store updated tile sequence pointer back to IX+2,3 (#R46811).
  38088,6 HL = IX+4,5 (movement control pointer, #R46813).
  38094,2 Advance movement control pointer past the consumed pair (2 bytes).
  38096,6 Store updated movement control pointer back to IX+4,5 (#R46813).
  38102,1 Return.
@ 38103 label=render_head_tile
c 38103 Render head or P2 overlay tile to framebuffer.
N 38103 Shared tile renderer for the flying head (#R46809) and the P2 overlay (#R46817). Reads the tile index from the sequence pointer at IX+2,3, temporarily patches the sprite bank selector at #R37368 to use the head bank (#R40192), resolves the tile address via #R37355, then restores the normal bank (#R49152).
N 38103 Checks tile orientation against the head direction via #R38158; on mismatch, flips bit 6 of the tile index and mirrors the tile in-place via #R38340. Renders the result to the framebuffer at IX+6,7 via #R36910.
N 38103 INPUT: IX = state block (#R46809 flying head, #R46817 P2 overlay); IX+2,3 = tile sequence pointer; IX+6,7 = framebuffer destination.
N 38103 OUTPUT: None. DESTROYS: AF, BC, DE, HL.
  38103,6 Load tile sequence pointer low byte from IX+2,3; HL now points to the current tile.
  38109,1 Read tile index at current sequence position.
  38110,3 Load head sprite bank base address (#R40192).
  38113,3 Patch sprite bank operand at 37369 (#R37368); overrides normal bank (#R49152).
  38116,3 Resolve tile address into DE via #R37355.
  38119,3 Load normal sprite bank base address (#R49152).
  38122,3 Restore sprite bank operand at 37369 (#R37368) to normal bank.
  38125,3 Check tile orientation vs head direction via #R38158; draw mirrored variant if mismatched.
  38128,6 Load framebuffer destination IX+6,7 into HL.
  38134,3 Tail-call #R36910 to render the tile.
@ 38137 label=shadow_head
c 38137 Flying head ground shadow renderer.
N 38137 Draws a ground shadow for the flying head each frame. Calculates the shadow VRAM address from the current head column (#R46815) and the ground row, then calls #R36910 to blit the shadow tile (#R40576).
N 38137 INPUT: None. OUTPUT: None. DESTROYS: AF, DE, HL.
  38137,5 Guard: return if #R46434 is zero (never true during normal gameplay).
  38142,3 Load head shadow tile source address (#R40576).
  38145,3 Read current head column from framebuffer address (#R46815).
  38148,4 Build VRAM column byte: got the equivalent address in the ground.
  38152,3 Complete VRAM address in HL.
  38155,3 Tail-call #R36910 to render the shadow tile.
@ 38158 label=head_mirroring
c 38158 Head tile orientation selector.
D 38158 Checks the facing direction and mirrors it if required.
N 38158 On a match (Z set), returns immediately. On a mismatch, flips bit 6 of the tile index in the head sprite bank RAM (#R40192) and mirrors the tile pixel data in-place at that address via #R38340. The caller #R38103 then renders the updated tile to the framebuffer.
N 38158 INPUT: DE = tile index address in head sprite bank (#R37355 via #R38103). IX+0 = direction flag (#R46809): 1=left, 0=right.
N 38158 OUTPUT: Z set: orientation correct, no action. Z clear: orientation corrected, tile mirrored. DESTROYS AF, B.
  38158 Map direction flag to bit-6 mask (two RRCA: bit 0 -> bit 6; left=0x40, right=0x00).
  38163,1 B = expected orientation bit.
  38164,3 Read tile index; isolate orientation bit (bit 6).
  38167,2 Orientation already matches - return Z set.
  38169,1 Mismatch - save tile index pointer.
  38170,3 Reload tile index; flip orientation bit (XOR 0x40).
  38173,1 Write corrected index back to head sprite bank RAM.
  38174,1 Advance to tile pixel data.
  38175,3 Mirror tile pixel data in-place in the head sprite bank via #R38340.
  38178,1 Restore tile index pointer.
  38179,1 Return Z clear.
@ 38180 label=mark_head_landed
c 38180 Mark head landed.
D 38180 Mark flying head as landed: trajectory exhausted, enter draw-only phase.
N 38180 Reached when #R37997 detects the end-of-trajectory sentinel in the tile animation sequence.
N 38180 Sets #R46810 to 255, switching #R37997 from movement mode to draw-only mode each frame.
N 38180 Also unblocks goblin spawn: #R37666 waits for #R46810 = 255 before the goblin enters the arena.
N 38180 INPUT: None. OUTPUT: None. DESTROYS: AF.
  38180 End of bounce trajectory - mark head as landed.
  38182 Set #R46810 to 255 - head is now in draw-only landed state.
  38185 Return.
@ 38186 label=deactivate_head 
c 38186 Deactivate flying head: exited screen.
D 38186 Called from #R37997 when the head column reaches 0, 1 or 29 (screen edges).
N 38186 Writes 0 to IX+1 (#R46810): head is now fully inactive.
N 38186 INPUT: None. OUTPUT: None. DESTROYS: AF.
  38186 Head has left the screen - clear active flag.
  38187 Set #R46810 to 0: head deactivated.
@ 38191 label=move_scanl_down
c 38191 Move screen pointer down by B scanlines.
N 38191 Counterpart to #R38201. Adds 32 to HL up to B times, advancing the framebuffer address one scanline per iteration.
N 38191 INPUT: B = number of scanlines. HL = current framebuffer address. OUTPUT: HL = updated address. DESTROYS: A, DE.
  38191,3 Return immediately if B is 0.
  38194,3 DE = 32 - one scanline.
  38197,3 Advance HL by one scanline, loop B times.
  38200,1 Return.
@ 38201 label=move_scanl_up
c 38201 Move screen pointer up by B scanlines.
N 38201 Counterpart to #R38191. Subtracts 32 from HL up to B times, stepping the framebuffer address back one scanline per iteration.
N 38201 SBC HL,DE requires carry = 0 on entry; not guaranteed by all callers.
N 38201 INPUT: B number of scanlines. HL = current framebuffer address. OUTPUT: HL = updated address. DESTROYS: A, DE.
  38201,3 Return immediately if B is 0.
  38204,3 DE = 32 - one scanline.
  38207,4 Step HL back one scanline, loop B times.
  38211,1 Return.
@ 38212 label=move_col_left
c 38212 Move framebuffer pointer one column left (decrements L by 1).
N 38212 Counterpart to #R38216. Decrements L by 1 while preserving all flags.
N 38212 INPUT: HL = current framebuffer address. OUTPUT: HL = HL - 1. DESTROYS none.
  38212,2 Save flags, move one column left.
  38214,2 Restore flags and return.
@ 38216 label=move_col_right
c 38216 Move framebuffer pointer one column right.
N 38216 Counterpart to #R38212. Increments L by 1 while preserving all flags.
N 38216 INPUT: HL current framebuffer address.
N 38216 OUTPUT: HL = HL + 1. DESTROYS none.
  38216,2 Save flags, move one column right.
  38218,2 Restore flags and return.
@ 38220 label=p2_overlay_tile
c 38220 Player 2 overlay tile renderer.
D 38220 Composites a single extra tile on top of the P2 sprite each frame to visually differentiate P2 from P1, which share the same base sprite bank.
N 38220 #R47223 holds a 1-byte-per-frame overlay tile index (0-52 = tile, 255 = no draw) choosen from (#R40192) 
N 38220 #R47329 holds a 1-byte-per-frame position table: bits 0-5 = scanline offset down from row 94; bits 6-7 (after 2x RLCA) = column offset 0-3 right of P2 X tile, inverted as 6-L when P2 is mirrored.
N 38220 The overlay state block at #R46817 mirrors the layout of the head state block at #R46809, letting #R38103 and #R38158 serve both.
N 38220 INPUT: None. OUTPUT: None. DESTROYS: AF, B, DE, HL, IX.
  38220,5 Guard: return if #R46434 is zero (never true during normal gameplay).
  38225,6 Load P2 X tile (#R46437) and framebuffer row base (H = 94) into DE.
  38231,3 Load P2 frame index (#R46442) for table lookups.
  38234,1 Save DE on stack.
  38235,6 Fetch position byte for this frame from #R47329.
  38241,1 Restore DE.
  38242,1 Save full position byte in L.
  38243,3 Extract scanline offset (bits 0-5) into H.
  38246,1 Restore full position byte from L.
  38247,4 Extract column offset (bits 6-7) and shift to bits 0-1 via 2x RLCA.
  38251,1 L = column offset (0-3).
  38252,5 Read P2 mirror flag (#R46436 bit 0).
  38257,3 Store P2 mirror flag in overlay state block (#R46817 IX+0) for #R38103.
  38260,2 Not mirrored - column offset unchanged.
  38262,4 Mirrored - invert as 6-L so overlay aligns on the correct side.
  38266,3 Add column offset to P2 X tile; final framebuffer column into E.
  38269,2 B = scanline offset (H); EX DE,HL sets HL = framebuffer base (H = 94, L = column).
  38271,6 Walk HL down B scanlines (stride 32 each); HL is now the exact framebuffer destination.
  38277,3 Store framebuffer destination in overlay state block (#R46823, IX+6,7) for #R38103.
  38280,10 Reload P2 frame index; compute tile index address from #R47223 + frame index.
  38290,3 Store tile sequence pointer in overlay state block (#R46819, IX+2,3) for #R38103.
  38293,1 Read tile index for this frame.
  38294,2 255 = no overlay tile this frame.
  38296,1 Return if no tile to draw.
  38297,4 IX = #R46817, point to P2 overlay state block.
  38301,3 Tail-call #R38103 to blit tile using shared head/overlay draw path.
@ 38304 label=solve_pointer
c 38304 Generic 16-bit pointer lookup.
N 38304 Reads a pointer from a table given a index in A. Adds A*2 to HL and reads the 2-byte entry.
N 38304 INPUT: A = index. HL = table base address. OUTPUT: HL = resolved pointer. DESTROYS: AF, DE, HL.
  38304,2 Save table base (HL) on the stack.
  38306,4 HL = A * 2 (byte offset into the pointer table; each entry is 2 bytes).
  38310,1 DE = table base.
  38311,1 HL = table base + offset, points to the target entry.
  38312,3 DE = 16-bit pointer from table entry.
  38315,1 Restore HL (table base).
  38316,1 Swap DE and HL: HL = resolved pointer.
  38317,1 Return.
@ 38318 label=get_byte_value
c 38318 Read byte from address.
D 38318 Get byte value pointed by HL+A
N 38318 INPUT: A = offset. HL = base address. OUTPUT: A = Byte value. DESTROYS: HL.
  38318,2 Add the offset to the low byte of the address.
  38320,3 Handle carry: if addition overflowed, increment the high byte of the address.
  38323,1 Read the byte from the calculated address.
  38324,1 Return with the byte value in A.
@ 38325 label=find_hit_section
c 38325 Hit section table search.
D 38325 Scans the hit section table at HL for an entry whose first byte matches the attacker frame ID in A.
N 38325 Scans a table of 3-byte entries (frame ID with hit + 2 bytes) until matching A or sentinel = 128. On a match, DE is loaded with the 2-byte data pair from that entry and Z is set.
N 38325 INPUT: A = attacker frame ID. HL = base address of the hit section table (#R45015 or #R46747).
N 38325 OUTPUT: Z set on match; DE = 2-byte data pair from the matched entry. DESTROYS: HL, DE, AF, BC.
  38325,4 Read entry key into D; advance HL to the end of the 3-byte entry.
  38329,2 Sentinel reached (128): return NZ (no match).
  38332,3 Frame ID does not match: loop back to next entry.
  38335,4 Match found: backtrack HL and load the 2-byte data pair into DE.
  38339,1 Return with Z set.
@ 38340 label=mirror_tile_inplace
c 38340 Mirrors a tile horizontally in-place.
D 38340 For each scanline: reverses bits of the 3 bytes via table at #R23296.
N 38340 Called from #R38367, #R39258 and #R38158.
N 38340 INPUT: B = scanline count. DE = tile address.
N 38340 OUTPUT: DE advanced past tile. Tile mirrored in-place. DESTROYS: AF, BC, HL.
  38340,2 B=21h: full tile height.
  38342,2 HL base = bit-reversal table (#R23296).
  38344,1 A = byte 0 index from tile.
  38345,1 HL points to reversed byte 0.
  38346,1 C = reversed byte 0.
  38347,2 Next: byte 1 index.
  38349,1 HL points to reversed byte 1.
  38350,1 A = reversed byte 1.
  38351,1 Write reversed byte 1 in place.
  38352,2 Next: byte 2 index.
  38354,1 HL points to reversed byte 2.
  38355,1 A = reversed byte 2.
  38356,2 Back to byte 0 position.
  38358,2 Write reversed byte 2 to byte 0 position.
  38360,1 Advance to byte 2 position.
  38361,1 Recover reversed byte 0 (in C).
  38362,1 Write it to byte 2 position.
  38363,1 Advance DE to next scanline.
  38364,2 Repeat for B scanlines.
  38366,1 Return.
@ 38367 label=sprites_mirror_checker
c 38367 Sprites mirror checker and correcter.
N 38367 Check the 12 tiles of a sprite if needs to be mirrored and do it if required.
N 38367 Mirror correction: for each active tile, 3x RLA on the low byte of DE extracts the tile orientation bit and compares it with IY+2 bit 0 (mirror flag). If they mismatch, bit 6 of the tile index is flipped (XOR 64) and #R38340 mirrors the tile pixel data in-place.
N 38367 INPUT: IX = Current sprite shapes table. HL = frame data pointer (index 1). IY = character state block.
N 38367 OUTPUT: None. Framebuffer at H=0x5B updated in place. DESTROYS: AF, BC, DE, HL, IX.
  38367,2 B=12 tiles to draw.
  38369,3 Read slot byte from shapes table via IX+0.
  38372,1 INC A: test for empty slot (255 wraps to 0).
  38373,2 Continue to the next tile shape without changing anything else.
N 38375 Normal path. Check orientation and paint mirrored if required.
  38375,2 Read tile index from (HL). Advance HL past tile index.
  38377,3 Call #R37355 into DE.
  38380,3 Read mirror flag from IY+2, isolate bit 0 into C.
  38383,3 Store mirror flag bit in C.
  38386,1 Load low byte of DE (tile orientation byte).
  38387,1 Shift orientation bit towards bit 0 (RLA x1).
  38388,1 Shift orientation bit towards bit 0 (RLA x2).
  38389,1 Shift orientation bit towards bit 0 (RLA x3).
  38390,2 Isolate bit 0: tile orientation flag.
  38392,1 Compare tile orientation with character mirror flag.
  38393,2 Orientation matches - tile already correct, skip mirroring.
  38395,1 Orientation mismatch - reload tile index.
  38396,2 Flip orientation bit (64) to match it with the new orientation.
  38398,1 Write corrected tile index back to DE.
  38399,1 Advance to tile pixel data.
  38400,2 Preserve HL and BC across mirror call.
  38402,3 Mirror tile pixel data in-place via #R38340.
  38405,2 Restore BC and HL.
N 38407 Empty slot path: skip draw.
  38407,2 Advance IX to next slot.
  38409,2 Decrement loop counter, repeat for all 12 slots.
  38411,1 Return.
@ 38412 label=frmbuf_to_scr
c 38412 Flush framebuffer to screen.
N 38412 Copies 89 scanlines (28 bytes each) from the RAM framebuffer at #R24066 to the ZX Spectrum VRAM, using the pre-built VRAM address table at #R23552.
N 38412 SP is redirected to #R23560 (#R23552+8), stepping past the top address so only the 89 game-area rows are blitted. 28 unrolled LDI instructions copy each row without inner-loop overhead.
N 38412 Counterpart to #R38547, which fills the framebuffer each frame from the active stage background.
N 38412 INPUT: None. OUTPUT: None. DESTROYS: All registers. SP: is saved to #R46452 and restored on exit.
  38412,4 Save SP to #R46452.
  38416,3 Redirect SP to #R23560 - first game-area entry in the VRAM address table (#R23552+8 skipping the not updatable area).
  38419,3 Set HL to #R24194 - framebuffer start of the game area (128 bytes past #R24066).
  38422,2 Set B to 89 - game-area row counter.
  38424,2 Set C to 0 - required for LDI to decrement BC correctly.
  38426,1 Load the next VRAM row address into DE via POP from the redirected SP.
  38427,56 Copy one 28-byte scanline from framebuffer to VRAM via 28 unrolled LDI instructions.
  38483,4 Skip the 4-byte border gap to keep HL aligned to the next framebuffer row.
  38487,2 Repeat for all 89 game-area rows.
  38489,4 Restore SP from #R46452.
  38493,1 Return.
@ 38494 label=i_v_t_generator
c 38494 Interrupt Vector Table Generator
N 38494 Will generate all the 257 bytes of the interrupt table where, in loading time, are the game start routines never used later.
N 38494 INPUT: C = 240, B = 0, HL = 48896 (#R48896)
  38494,1 Copy 240($F0) to the future Vector Table (#R48896).
  38495,1 Increments in 1 HL
  38496,2 Decrements B and compare with 0 (this loop will execute 256 times).
  38498,1 After copying the 256 bytes, we need to copy F0 once more (257 times).
  38499,1 Returns to #R35244
@ 38500 label=int_serv_routine
c 38500 Interrupt Service Routine
D 38500 Triggered by Z80 interrupt mode 2 (IM 2).
N 38500 In execution time, this routine is written by #R49031 to 0xF0F0/61680 (more info in #R61569) so the Vector table can call it.
N 38500 Two responsibilities: frequency divider via #R47474, combat timer decrement via #R46808.
N 38500 OUTPUT: #R47474 incremented or reset; #R46808 decremented.
  38500,2 Preserve AF, BC
  38502,3 #R47474 (ISR frame counter, cycles 0-8).
  38505,1 Advance counter.
  38506,2 Has the counter reached 9 (one timer tick)?
  38508,2 Yes: reset counter and process timer.
  38510,3 No: store updated counter and exit ISR.
  38513,2 Jump to exit.
  38515,4 Counter reached 9 and is reset to 0.
  38519,3 #R46808 (combat timer: 90->0 in 2P mode; 255 = infinite/1P).
  38522,2 Is it infinite-time mode (1P/Demo)?
  38524,2 Yes: skip decrement, exit.
  38526,1 Is timer already 0?
  38527,2 Yes: already expired, skip decrement, exit.
  38529,1 No: preserve timer value in B.
  38530,5 (goblin active flag: 0=inactive, 255=active). Is the goblin currently active?
  38535,1 Restore timer value into A.
  38536,2 Goblin active: freeze timer, exit without decrementing.
  38538,1 Decrement combat timer by 1.
  38539,3 Store updated timer value back to #R46808.
  38542,2 Restore BC and AF.
  38544,1 Re-enable interrupts.
  38545 Return from interrupt.
@ 38547 label=copy_bg_to_frmbuff
c 38547 Copy stage background to framebuffer.
N 38547 Fills the #R24066 with the active stage background graphics each frame, ready for sprite rendering.
N 38547 Copies 94 scanlines of 28 bytes each via 28 unrolled LDI instructions per row. After each row, four INC DE instructions skip the 4-byte border gap, keeping the destination aligned to the next framebuffer row (stride 32, graphics width 28).
N 38547 INPUT: None. OUTPUT: None. DESTROYS AF, BC, DE, HL.
  38547,7 Load active background address from #R46459 into HL, it adds the offset of the upper (not updatable part).
  38554,3 Set DE to #R24066, framebuffer start.
  38557,2 B = 94, total scanline rows to copy.
  38559,2 C = 0, initialises BC so LDI decrements BC correctly each copy.
  38561,56 Copy one 28-byte scanline via 28 unrolled LDI instructions.
  38617,4 Skip the 4-byte border gap to align DE to the next framebuffer row.
  38621,2 Repeat for all 94 scanlines.
  38623,1 Return.
@ 38624 label=clear_attr_row 
c 38624 Clear attributes for a row.
N 38624 Modify colour attributes with customizable width via B and height via C. Used in this case to clear attibutes to a complete row.
N 38624 Writes A to B consecutive attribute bytes starting at HL, then steps down one attribute row (32 bytes) and repeats for C rows total. Produces a solid colour fill across the given area.
N 38624 Called from #R38699 during the fade-out sequence to progressively blacken attribute rows.
N 38624 INPUT: HL = top-left tile attribute address. B = tiles per row (28). C = row count (01). A = attribute value to write (0 for black).
N 38624 OUTPUT: None. DESTROYS: C, DE, HL.
  38624,2 Save address and counters.
  38626,2 Write attribute value to current tile; advance to next.
  38628,2 Repeat for all B tiles in this row.
  38630,2 Restore counters and row start address.
  38632,4 Advance HL one attribute row down (stride 32).
  38636,3 Decrement row counter; loop if rows remain.
  38639,1 Return.
@ 38640 label=fade_ink
c 38640 Fade ink colour to black.
N 38640 For each of C rows, reads the ink bits of each attribute byte via AND 7 and decrements the ink value by 1 unless it is already 0. Processes B tiles per row, then advances HL 32 bytes to the next attribute row.
N 38640 Called from #R36673 to progressively darken the game window during the fade-out transition.
N 38640 INPUT: HL = first attribute address (top-left tile). B = tiles per row (26). C row count (3).
N 38640 OUTPUT: None. DESTROYS A, C, DE, HL.
  38640,2 Save row start address and counters.
  38642,3 Read ink bits from current attribute (AND 7).
  38645,3 Ink already 0 - skip decrement.
  38648,2 Reload attribute and decrement ink by 1.
  38650,1 Write decremented value back to attribute byte.
  38651,1 Advance to next tile in row.
  38652,2 Repeat for all B tiles in this row.
  38654,2 Restore counters and row start address.
  38656,4 Advance HL one row (stride 32).
  38660,3 Decrement row counter; loop if rows remain.
  38663,1 Return.
@ 38664 label=step_ink_up
c 38664 Step each attribute ink colour one level toward a target.
D 38664 Called from #R36706 each frame to drive the menu rainbow colour animation. 
N 38664 For each of B tiles in the row, reads the ink bits via AND 7. If already at the target value A, leaves the tile unchanged. Otherwise increments the ink by 1, sets BRIGHT, and writes the result back. After all B tiles, advances HL by 32 bytes to the next attribute row and decrements C. If C>1, the outer PUSHes accumulate on the stack but are only popped once on exit, corrupting the caller's stack.
N 38664 The caller relies on DE=32 on return to step between rows via ADD HL,DE. 
N 38664 INPUT: HL = first attribute address in the row. A = target ink value (0-7). B = tiles per row. C = row count (always 1 in game).
N 38664 OUTPUT: DE = 32 (row stride; used by caller via ADD HL,DE to advance between rows).
N 38664 DESTROYS: None (HL, BC, AF all restored via PUSH/POP).
  38664,3 Save row-start address, tile count and target ink for final restoration.
  38667,3 Save the same values again to preserve B (tile counter) and C (row count) across the inner tile loop.
  38670,1 Copy target ink value to C for per-tile comparison.
  38671,3 Read the ink bits of the current attribute (AND 7).
  38674,3 Already at target - skip this tile without writing.
  38677,5 Increment ink by 1, set BRIGHT, and write back to the attribute.
  38682,1 Advance to the next tile.
  38683,2 Repeat for all B tiles in this row.
  38685,3 Restore tile count, row count and row-start address.
  38688,4 Set DE to 32 (row stride) and advance HL to the next attribute row.
  38692,3 Decrement row counter; loop back if rows remain.
  38695,3 Restore caller's HL, BC and AF.
  38698,1 Return.
@ 38699 label=sweep_transition
c 38699 Game window row-by-row wipe to black.
N 38699 Clears the game window from top to bottom one tile row per 112 ms step, producing a visible wipe effect. Rows that share columns with the snake HUD are cleared via #R38811, which preserves those columns; all other rows use #R38796, which clears all 28 tiles. The two bottom rows at attribute-map level are cleared separately via #R38624.
N 38699 INPUT: None. OUTPUT: None. DESTROYS A, BC, HL.
  38699,3 Set HL to the first tile of the top game window row.
  38702,2 Set loop counter to 2.
  38704,1 Preserve loop counter before call.
  38705,3 Clear one snake-edge row preserving HUD columns via #R38811.
  38708,1 Restore loop counter.
  38709,2 Repeat for the top 2 snake-edge rows.
  38711,3 Set loop counter to 2.
  38714,4 Clear one full 28-tile row and wait 112 ms via #R38796.
  38718,2 Repeat for the next 2 full rows.
  38720,3 Set loop counter to 3.
  38723,4 Clear one snake-edge row via #R38811.
  38727,2 Repeat for the next 3 snake-edge rows.
  38729,3 Set loop counter to 8.
  38732,4 Clear one full row and wait 112 ms via #R38796.
  38736,2 Repeat for 8 full rows.
  38738,1 A=0, black attribute value.
  38739,3 Set HL to the penultimate attribute row of the game window.
  38742,3 B=28 (full row width), C=1 (single row).
  38745,3 Clear the penultimate attribute row to black via #R38624.
  38748,3 Wait 112 ms via #R39846.
  38751,1 A=0, black attribute value.
  38752,3 Set HL to the last attribute row of the game window.
  38755,3 B=22 (erasable tiles in the last partial row), C=1.
  38758,3 Clear the last row attributes to black via #R38624.
  38761,3 Wait 112 ms and return; tail-calls #R39846.
@ 38764 label=clear_scanline_ink_attr
c 38764 Single scanline clear with attribute wipe.
D 38764 Clears one pixel scanline byte and sets the attribute to black (0) for each of the 28 tiles in a row. Called 8 times per tile row by #R38796 to erase all pixel data of a full row. #R38790 also shares the inner loop from 38767 with B=26 to preserve the leftmost snake column.
N 38764 INPUT: HL = VRAM address of the scanline byte to clear.
N 38764 OUTPUT; HL = restored to the entry value. DESTROYS: A, B, DE.
  38764,1 Preserve the entry VRAM address.
  38765,2 B=28, one iteration per tile column across the full game window row.
  38767,1 A=0, value to clear with.
  38768,4 Clear the current VRAM scanline byte.
  38772,2 Form the full attribute address in DE using A and the column byte from L.
  38774,1 A=0, black attribute value.
  38775,1 Write black attribute (ink=0, paper=0) to this tile.
  38776,1 Advance to the next tile column.
  38777,2 Repeat for all tile columns.
  38779,1 Restores the caller's HL value.
  38780,1 Return.
@ 38781 label=get_attr_address
c 38781 Derive attribute high byte from a VRAM pixel address.
D 38781 Converts the high byte of a VRAM pixel address to the corresponding attribute high byte. Extracts the screen third (0-2) from H and combines it with the attribute area base (0x58) to produce 0x58, 0x59 or 0x5A. L is not touched, so the caller can form the full attribute address directly from A and L.
N 38781 INPUT: HL = VRAM pixel address. OUTPUT: A attribute high byte (0x58, 0x59 or 0x5A). DESTROYS: A.
  38781,6 Shift H right by 3 and mask to bits 1-0 to isolate the screen third (0-2).
  38787,2 OR 0x58 to set the attribute area base, forming the attribute high byte.
  38789,1 Return with the attribute high byte in A.
@ 38790 label=single_scanline_clear
c 38790 Single scanline clear for snake-edge rows (26 central tiles).
N 38790 Setups a counter of 26 loops and deletes the pointed scanline of a complete row. Used by #R38811.
N 38790 INPUT: HL = VRAM address of the first tile of the row.
N 38790 OUTPUT: HL = restored to the entry value. DESTROYS A, B, DE.
  38790,1 Preserve the entry VRAM address.
  38791,2 B=26, skipping the leftmost snake column.
  38793,1 Advance past the leftmost snake column.
  38794,2 Jump into the shared scanline-clear loop at #R38764.
@ 38796 label=clear_row
c 38796 Clear all 28 tiles of one game-window row to black.
N 38796 Calls #R38764 once per scanline (8 times, one per pixel row within the tile) to zero the pixel data and set attributes to black. After the loop, HL naturally points to the first scanline of the tile row below. Tail-calls #R39846 to insert a 112 ms pause, producing the visible row-by-row wipe delay in #R38699.
N 38796 INPUT: HL = VRAM address of the first scanline of the tile row to clear.
N 38796 OUTPUT: HL = VRAM address of the first scanline of the next tile row.
N 38796 DESTROYS: A, B, DE.
  38796,2 B=8, one iteration per scanline within the tile row.
  38798,1 Preserve the loop counter.
  38799,3 Clear pixel data and attributes for this scanline via #R38764.
  38802,3 Advance HL to the next scanline via #R36895.
  38805,1 Restore the loop counter.
  38806,2 Repeat for all 8 scanlines of the tile row.
  38808,3 Tail-call #R39846 to wait 112 ms before returning.
@ 38811 label=clear_snake_row
c 38811 Clear one game-window row preserving snake edge columns.
N 38811 Variant of #R38796 for tile rows that share pixel columns with the snake border. Iterates 8 scanlines via #R38790, which skips the leftmost column. For both snake edge columns only the paper bits in the attribute are cleared to black, keeping the ink colour intact. Tail-calls #R39846 for the 112 ms inter-row pause.
N 38811 INPUT: HL = VRAM address of the first scanline of the tile row to clear. OUTPUT: HL = VRAM address of the first scanline of the next tile row. DESTROYS: A, B, DE.
  38811,2 B=8, one iteration per scanline within the tile row.
  38813,3 Derive the attribute page high byte for the leftmost column via #R38781.
  38816,2 Form the full attribute address for the left snake column in DE.
  38818,4 Read the left snake column attribute, clear its paper bits to black and write it back.
  38822,1 Preserve the loop counter.
  38823,3 Clear the 26 central tile columns for this scanline via #R38790.
  38826,3 Advance HL to the next scanline via #R36895.
  38829,1 Restore the loop counter.
  38830,2 Repeat for all 8 scanlines of the tile row.
  38832,3 Derive the attribute page high byte from the current HL position via #R38781.
  38835,2 Form the attribute address of the first column of the next tile row in DE.
  38837,5 Step DE back 5 bytes to reach the rightmost column (column 27) of the current tile row.
  38842,3 Read the right snake column attribute and clear its paper bits to black.
  38845,1 Write the updated attribute back to the right snake column.
  38846,3 Tail-call #R39846 to wait 112 ms before returning.
@ 38849 label=paints_stage_screen
c 38849 Blit stage background to screen row by row.
N 38849 Copies backfround tile graphics and RLE colour attributes from the active background source to VRAM one row at a time, inserting a 112 ms pause after each of the first 15 rows to produce a visible top-to-bottom reveal. The final 2 rows are blitted without a pause. Resets the attribute stream pointer #R46461 to its initial value on exit so the next call starts from the beginning of the attribute table.
N 38849 INPUT: None. OUTPUT: None. DESTROYS: AF, BC, DE, HL.
  38849,4 Load the initial attribute stream address from #R46614 and preserve it on the stack for the reset at the end.
  38853,4 Load the active stage graphics source address from #R46459 into DE (#R26752 stage 1, #R30112 stage 2).
  38857,3 Set HL to the VRAM address of the first tile of the game window.
  38860,2 B=15, one iteration per row for the top section; the last 2 rows are handled separately without a pause.
  38862,1 Preserve the loop counter.
  38863,3 Copy one full tile row (28 tiles, 8 scanlines) from source to VRAM via #R38936; DE and HL advance to the next row.
  38866,3 Apply RLE colour attributes to the current VRAM row via #R38898; #R46461 advances to the next attribute entry.
  38869,3 Wait 112 ms via #R39846.
  38872,1 Restore the loop counter.
  38873,2 Repeat for all 15 rows.
  38875,3 Advance DE and HL to the penultimate row.
  38878,3 Copy the penultimate row via #R38936.
  38881,3 Apply attributes to the penultimate row via #R38898.
  38884,3 Advance DE and HL to the last row.
  38887,3 Copy the last row via #R38936.
  38890,3 Apply attributes to the last row via #R38898.
  38893,1 Restore initial attribute stream address from the stack.
  38894,3 Write restored address to #R46461, resetting the attribute stream pointer for the next call.
  38897,1 Return.
@ 38898 label=apply_bg_attr_row  
c 38898 Apply RLE colour attributes to a screen row.
N 38898 Reads the RLE attribute stream from #R46461 and writes colour attributes. The stream is a sequence of count+value byte pairs. Each pair applies one attribute byte to the next <count> consecutive tiles. A count of 255 signals the end of the row.
N 38898 After the row is processed, #R46461 is advanced past the end-of-row marker, ready for the next row.
N 38898 INPUT: HL = VRAM address of any scanline within the target screen row. #R46461 active stage attribute stream pointer. OUTPUT: None. DESTROYS: AF, BC, DE, HL, alternate registers.
  38898,1 Pushes the VRAM row address to carry it across the EXX boundary.
  38899,1 Switches to the alternate register set.
  38900,1 Recovers the VRAM row address in the now-active alternate HL.
  38901,3 Steps back to the top scanline of this tile row via #R36879.
  38904,3 Derives the attribute RAM high byte for this row via #R38781.
  38907,2 Forms DE as the attribute RAM address for the first tile of this row.
  38909,4 Loads the stream pointer from #R46461 and reads the next stream byte into A.
N 38913 Stream format: count+value byte pairs. The first byte of each pair is the number of consecutive tiles to colour; the second is the attribute value to apply. A count of 255 ends the row.
  38913,4 End-of-row check; jumps to the pointer update step if the stream byte is 255.
  38917,1 Stores the tile run length in B.
  38918,1 Advances to the attribute value byte of this pair.
  38919,2 Reads the attribute value and writes it to the current tile in attribute RAM.
  38921,1 Advances to the next tile in attribute RAM.
  38922,2 Repeats for all tiles in this run.
  38924,1 Advances to the next count+value pair in the stream.
  38925,3 Saves the updated stream pointer to #R46461.
  38928,2 Loops back to process the next pair.
  38930,1 Advances past the end-of-row marker.
  38931,3 Saves the updated stream pointer to #R46461.
  38934,1 Restores the caller's alternate registers.
  38935,1 Returns.
@ 38936 label=copy_bg_row
c 38936 Copy one tile row from stage background directly to screen.
N 38936 Copies all 8 scanlines of a 28-tile-wide row from the stage background graphics to the ZX Spectrum screen VRAM. Called from #R38849 to paint the stage row by row during screen transitions.
N 38936 INPUT: DE = stage background source address. HL = VRAM destination address, top scanline of the target tile row.
N 38936 OUTPUT: HL = VRAM address of the next tile row below. DE = advanced by 224 bytes (28 bytes x 8 scanlines).
N 38936 DESTROYS AF, B.
  38936,2 Sets the scanline counter to 8, one iteration per scanline of the tile row.
  38938,2 Saves the loop counter and the address for the current scanline.
  38940,3 Copies one 28-byte scanline from the stage background to VRAM via #R38951.
  38943,1 Restores the VRAM address to the start of the current scanline.
  38944,3 Advances the VRAM pointer to the next scanline via #R36895.
  38947,1 Restores the loop counter.
  38948,2 Repeats for all 8 scanlines of the tile row.
  38950,1 Returns once the full tile row has been copied.
@ 38951 label=copy_bg_scanline
c 38951 Copy one 28-byte scanline from stage background to screen.
D 38951 Copies exactly 28 bytes from the stage background source at DE to the screen at HL, advancing both pointers. Called 8 times per tile row by #R38936.
N 38951 INPUT: DE = stage background source address. HL = VRAM destination address.
N 38951 OUTPUT: DE and HL both advanced by 28 bytes. DESTROYS AF, B.
  38951,2 Sets the tile column counter to 28.
  38953,2 Reads one background byte and writes it to VRAM.
  38955,2 Advances both source and destination pointers.
  38957,2 Repeats for all 28 tile columns.
  38959,1 Returns to #R38936.
@ 38960 label=x_pos_controller
c 38960 Loser X tile position controller
N 38960 Advances the active character X tile by the per-frame animation delta.
N 38960 If the character is in an exit animation (mv29, 31, 32 or 33), increments X by 1 per frame until X reaches 30, then tail-calls #R37631 to end the fight.
N 38960 For all other animations, applies the signed delta from the frame displacement table, clamping to the play-area boundary (column 23).
N 38960 INPUT: IY = active character state block.
N 38960 OUTPUT: IY+3 = updated X tile, or tail-call to #R37631 when exit animation clears the screen. DESTROYS: AF, B, HL.
  38960,3 Load active movement ID from IY+6.
  38963,16 Test for exit animations (mv29, 31, 32, 33); if matched, jump to exit path (#R39007).
  38979,9 Read per-frame X displacement for the current animation frame from the table at #R61568.
  38988,8 Check mirror flag in IY+2; if set, negate (mirrors) the displacement for a left-facing character.
  38996,3 Load current X tile from IY+3.
  38999,1 Apply displacement to get new X tile.
  39000,2 Discard if result reaches or exceeds play-area boundary (column 24).
  39002,1 Return without updating IY+3.
  39003,3 Store updated X tile in IY+3.
  39006,1 Return.
N 39007 Exit animation path.
  39007,7 Increment X by 1 toward the right screen edge and store in IY+3.
  39014,2 Check whether X has reached column 30 (character fully off-screen).
  39016,1 Not yet: return and continue exit animation.
  39017,3 Tail-call #R37631 to end the fight.
@ 39020 label=x_update_and_tackle_gate
c 39020 X position update and tackle proximity gate.
N 39020 Advances the active character X position tile via #R38960, then recomputes the fighter distance. If the new distance is negative (bit 7 set), the fighters have overlapped after the step. In that case, if neither fighter is in an exit or death movement, tackle detection is armed (#R47575=1). If one fighter is rolling (mv17) and the other has reached the jump-over frames (8 or 9), the flag stays set and #R39968 handles the cross-side sequence. If no roll/jump-over match is found, the step is reversed.
N 39020 INPUT: IY = active character state block. B = X tile before the step (saved by #R39827).
N 39020 OUTOUT: #R47575 set to 1 if tackle condition is met; 0 if the step was rolled back. DESTROYS: AF, BC.
N 39020 Advances the active character X tile and recomputes fighter distance.
  39020,3 Advance the X tile for the current frame via #R38960.
  39023,1 Save pre-step X tile for possible rollback.
  39024,3 Load pre-step distance from #R46834.
  39027,1 Save pre-step distance for possible rollback.
  39028,1 Save pre-step X tile and distance on the stack.
  39029,3 Recompute fighter distance after the step via #R39856.
  39032,1 Restore pre-step values.
N 39033 Returns immediately if a tackle sequence is already active.
  39033,3 Load tackle state from #R47575.
  39036,1 Test if a tackle sequence is already active.
  39037,1 Return - tackle already in progress.
N 39038 Checks whether the step produced an overlap (negative distance, bit 7 set).
  39038,3 Load updated distance to test for overlap.
  39041,2 Bit 7 set means the step produced a negative distance - fighters have overlapped.
  39043,2 Overlap detected - proceed to exit-movement guards.
  39045,1 No overlap - fighters are still apart, return.
N 39046 Guards: returns if either fighter is in an exit or death movement.
  39046,3 Load P1 movement ID to screen for exit or death animations.
  39049,2 P1 is decapitated (mv8 #R44558).
  39051,1 Return - no tackle during this movement.
  39052,2 P1 is in a death animation (mv27 #R44647).
  39054,1 Return.
  39055,2 P1 is in a body-drag exit (mv31 #R44686).
  39057,1 Return.
  39058,2 P1 is in a body-drag exit (mv29 #R44675).
  39060,1 Return.
  39061,2 P1 is in a body-drag exit (mv33 #R44702).
  39063,1 Return.
  39064,2 P1 is in a body-drag exit (mv32 #R44694).
  39066,1 Return.
  39067,3 Load P2 movement ID to screen for exit or death animations.
  39070,2 P2 is decapitated (mv8 #R44558).
  39072,1 Return.
  39073,2 P2 is in a death animation (mv27 #R44647).
  39075,1 Return.
  39076,2 P2 is in a body-drag exit (mv31 #R44686).
  39078,1 Return.
  39079,2 P2 is in a body-drag exit (mv29 #R44675).
  39081,1 Return.
  39082,2 P2 is in a body-drag exit (mv33 #R44702).
  39084,1 Return.
  39085,2 P2 is in a body-drag exit (mv32 #R44694).
  39087,1 Return.
N 39088 Arms tackle detection and checks whether either fighter is rolling.
  39088,2 Both fighters are eligible for tackle detection.
  39090,3 Arm tackle detection in #R47575.
  39093,3 Load P1 movement ID to check for an active roll.
  39096,2 P1 is rolling (mv17 #R44605) - check whether P2 is in the jump-over phase.
  39098,2 P1 rolling confirmed - jump to jump-over check.
  39100,3 Load P2 movement ID to check for an active roll.
  39103,2 P2 is rolling (mv17 #R44605) - check whether P1 is in the jump-over phase.
  39105,2 P2 rolling confirmed - jump to jump-over check.
N 39107 Rollback: reverses the overlap step and clears the tackle flag.
  39107,1 Neither fighter is rolling - reverse the overlap step.
  39108,3 Clear tackle flag.
  39111,1 Recover pre-step distance.
  39112,3 Restore pre-step distance to #R46834.
  39115,1 Recover pre-step X tile.
  39116,3 Undo the overlap step by restoring the pre-step X tile.
  39119,1 Return.
N 39120 P1 rolling: checks whether P2 has reached the jump-over phase (frame 8 or 9).
  39120,3 P1 rolling - load P2 frame index to check jump-over state.
  39123,2 P2 is at jump-over frame 8. #R43829
  39125,1 Return with tackle flag set - #R39968 drives the cross-side phase.
  39126,2 P2 is at jump-over frame 9. #R43838
  39128,1 Return.
  39129,2 P2 not yet in jump-over phase - reverse the overlap step.
N 39131 P2 rolling: checks whether P1 has reached the jump-over phase (frame 8 or 9).
  39131,3 P2 rolling - load P1 frame index to check jump-over state.
  39134,2 P1 is at jump-over frame 8. #R43829
  39136,1 Return with tackle flag set - #R39968 drives the cross-side phase.
  39137,2 P1 is at jump-over frame 9. #R43838
  39139,1 Return.
  39140,2 P1 not yet in jump-over phase - reverse the overlap step.
@ 39142 label=input_mirror_correcter
c 39142 Mirror-corrected directional input.
N 39142 If the character is mirrored (IY+2 bit 0 set) and a horizontal direction is pressed (bits 0 or 1 of A), swaps Right (bit 0) and Left (bit 1) via XOR 3.
N 39142 This ensures the movement table lookup in #R39211 always treats towards-opponent as Right and away-from-opponent as Left, regardless of which side the character faces.
N 39142 INPUT: A = key state bitmask (bit 0=Right, bit 1=Left, bit 2=Down, bit 3=Up, bit 4=Fire). IY+2 bit 0 mirror flag.
N 39142 OUTPUT: A = adjusted key state with Left/Right possibly swapped. DESTROYS: B.
  39142,3 Save key state; mask to horizontal bits only (AND 3).
  39145,2 No horizontal input pressed; restore A and return unchanged.
  39147,5 Mirror flag clear; return unchanged.
  39152,3 Swap Right and Left bits (XOR 3) to correct for mirrored facing.
  39155,1 Return with adjusted key state in A.
@ 39156 label=input_gated_moves
c 39156 Input-gated movement transition.
D 39156 Called every frame from #R39827. Runs through three gates before attempting a movement change; returns early if any fails:
N 39156 1. Current movement is non-interruptible (bit 6 of its properties byte in #R44755).
N 39156 2. A special event is active (#R47575 != 0, e.g. tackle or collision).
N 39156 3. Current frame is non-controllable (IY+2 bit 7 set).
N 39156 If all gates pass, mirror-corrects the input via #R39142, resolves a candidate movement via #R39211, and returns unchanged if the result is 255 or matches the current movement. On a valid new movement, applies it via #R36838 and rewinds the frame pointer by 1 so the animation starts at its first real frame.
N 39156 INPUT: IY = character state block (#R46425 or #R46434).
N 39156 OUTPUT: None. Updates IY+6 (movement ID), IY+4/IY+5 (frame pointer) and IY+2 (mirror flag) via #R36838. DESTROYS: AF, HL.
  39156,11 Read movement properties byte from #R44755 using the current movement ID; test the non-interruptible flag (bit 6).
  39167,1 Non-interruptible movement active (death, victory); return.
  39168,5 Special event in progress (#R47575 != 0); return.
  39173,6 Read key state and apply mirror correction for direction via #R39142.
  39179,5 Current frame is non-controllable (IY+2 bit 7); return.
  39184,3 Resolve candidate movement ID from current input via #R39211.
  39187,2 No transition defined for this input/movement combination; return.
  39190,4 Candidate matches current movement; return without change.
@ 39194 label=force_apply_moves
c 39194 Force-apply new movement.
D 39194 Used by #R39518 (hit collision resolver) to bypass all input gates and push a new movement directly onto the character block, regardless of controllability state.
N 39194 INPUT: A new movement ID. IY defender character state block.
N 39194 OUTPUT: None. DESTROYS: AF, BC, HL
  39194,3 Apply new movement to the character block via #R36838.
  39197,13 Rewind the frame pointer (IY+4/IY+5) by 1 so the new animation starts at its first real frame.
  39210,1 Return.
@ 39211 label=moves_solver
c 39211 Movement transition resolver.
D 39211 Called from #R39156 with the mirror-adjusted key state in A.
N 39211 Performs a two-level table lookup to find the candidate movement ID:
N 39211 Level 1: maps the lower 4 direction bits of the key state to an input class (0-8) via #R47458, collapsing 16 combos into 9 meaningful classes.
N 39211 Level 2: uses the Fire button (IY+1 bit 4) to select the transition table - #R44795 (no fire: walks, crouches, rolls) or #R44851 (fire: attacks) - then resolves a pointer for the current movement ID and reads the resulting movement ID at the input class offset.
N 39211 Returns 255 if no transition is defined for the current input/movement combination.
N 39211 INPUT: A = adjusted key state. IY = character state block.
N 39211 OUTPUT: A = new movement ID, or 255 if no transition applies. DESTROYS: AF, DE, HL.
  39211,2 Strip the Fire bit; keep only the 4 direction bits.
  39213,6 Look up the input class index (0-8) for this direction combination via #R47458.
  39219,3 Store the input class as a 16-bit offset for the pointer walk.
  39222,6 Fire pressed - jump to attack transition table at #R39233.
  39228,3 Fire not pressed - select the movement transition pointer table #R44795.
  39231,2 Skip to shared table resolution.
  39233,3 Fire pressed - select the attack transition pointer table #R44851.
  39236,6 Resolve the 2-byte transition row pointer for the current movement ID via #R38304.
  39242,1 Advance the pointer by the input class offset to reach the target transition entry.
  39243,2 Read and return the resulting movement ID.
@ 39245 label=get_moves_properties
c 39245 Read movement properties byte.
N 39245 Reads the properties byte for the given movement ID from the table at #R44755.
N 39245 INPUT: A = movement ID. OUTPUT: A = properties byte. DESTROYS: None.
  39245,2 Preserve HL and DE.
  39247,3 Load movement properties table base #R44755.
  39250,3 Form a 16-bit offset from the movement ID.
  39253,1 Advance to the target entry.
  39254,1 Read the properties byte.
  39255,2 Restore HL and DE.
  39257,1 Return.
@ 39258 label=draw_snakes_sprites
c 39258 Snake energy bar renderer.
N 39258 Blits the current snake animation frame to the HUD energy bar for each character whose draw phase is active (high nibble of IY+7 non-zero).
N 39258 P1 bar (VRAM 16416): the sprite is mirrored in-place before blitting and restored afterwards, since P1 faces right and needs the flipped orientation.
N 39258 P2 bar (VRAM 16445): blitted in its natural orientation.
N 39258 INPUT: None. OUTPUT: None. DESTROYS: IY, AF, BC, DE, HL.
  39258,4 Select P1 state block. (#R46425)
  39262,3 Load P1 packed energy/phase byte.
  39265,2 Isolate draw phase index.
  39267,2 Phase idle - skip P1 bar update.
  39269,3 Advance draw phase and fetch snake sprite pointer via #R39317.
  39272,1 Save sprite pointer for the restore pass.
  39273,1 Save sprite pointer for the blit pass.
  39274,2 Set scanline count for the mirror operation.
  39276,3 Mirror snake sprite in-place via #R38342.
  39279,1 Restore pointer to the now-mirrored sprite data.
  39280,3 Set P1 energy bar VRAM destination.
  39283,3 Set blit dimensions - 3 bytes wide, 30 scanlines.
  39286,3 Blit mirrored sprite to P1 energy bar via #R37387.
  39289,1 Restore pointer to the mirrored sprite data.
  39290,2 Set scanline count for the restore pass.
  39292,3 Un-mirror sprite in-place via #R38342, restoring original data for reuse.
  39295,4 Select P2 state block.
  39299,3 Load P2 packed energy/phase byte.
  39302,2 Isolate draw phase index.
  39304,1 Phase idle - return.
  39305,3 Advance draw phase and fetch snake sprite pointer via #R39317.
  39308,3 Set P2 energy bar VRAM destination.
  39311,3 Set blit dimensions - 3 bytes wide, 30 scanlines.
  39314,3 Tail-call to blit sprite to P2 energy bar via #R37387.
@ 39317 label=update_snake_frame_id
c 39317 Snake animation phase stepper.
N 39317 Advances the draw phase index in the high nibble of IY+7 by 1 each call, leaving the current energy value in the low nibble intact.
N 39317 When the index reaches 14 the animation cycle is complete and it resets to 0 (idle). Uses the resulting index to resolve a pointer to the corresponding snake sprite frame via the table at #R47528.
N 39317 IY+7 byte layout: bits 7-4 draw phase (0 idle, 1-13 active, 14->0 wrap); bits 3-0 current energy value (0-13).
N 39317 INPUT: IY = character state block (#R46425 P1 or #R46434 P2).
N 39317 OUTPUT: A = first byte of the snake sprite frame. DE = pointer to the next byte.
N 39317 DESTROYS: AF, BC, DE, HL.
  39317,3 Load packed energy/phase byte from IY+7.
  39320,8 Extract the draw phase index from the high nibble and advance it by 1.
  39328,5 Shift the incremented index back to the high nibble position.
  39333,9 Merge the updated phase index with the preserved energy nibble and write back to IY+7.
  39342,3 Check whether the 14-step animation cycle has completed.
  39345,2 Cycle not complete - jump to table lookup with the current phase index.
  39347,8 Cycle complete - clear the phase index in IY+7, resetting the bar to idle.
  39355,1 Use index 0 to address the idle-state table entry.
  39356,3 Load snake animation pointer table base #R47528.
  39359,3 Resolve the sprite frame pointer for the current phase index via #R38304.
  39362,4 Transfer the frame pointer, load the first sprite byte, and advance past it.
  39366,1 Return.
@ 39367 label=energy_dec
c 39367 Energy decrement, bar display and KO detection.
N 39367 Called by #R39518 after a hit connects with a non-zero knockback type.
N 39367 Decrements the energy value stored in the low nibble of IY+7 (range 0-13).
N 39367 If energy underflows (was 0, DEC wraps to 255), triggers KO sequence: sets movement 27 (death) on the loser and movement 36 (victory pose) on the winner, then forces the energy display to show the empty bar.
N 39367 SELF-MODIFYING TARGET: the instruction at #R39371 is patched from RET Z to NOP by #R36212 and #R36508 on game start. In the unpatched binary it prevents P1 from ever losing energy (demo/attract mode protection).
N 39367 INPUT: IY = defender state block (#R46425 P1 or #R46434 P2).
N 39367 OUTPUT: None. DESTROYS: AF, BC, DE, HL.
  39367,2 Load character type to determine if this is P1.
  39369,2 P1 check - fall through to energy gate if P1.
@ 39371 label=p1_energy_gate
  39371,1 SELF-MODIFYING CODE TARGET. Patched to NOP on game start; as shipped, RET Z skips P1 energy loss entirely.
  39372,3 Load packed energy/phase byte from IY+7.
  39375,2 Isolate the current energy value.
  39377,1 Decrement energy.
  39378,2 Energy underflowed - jump to KO sequence.
  39380,2 Jump to KO sequence if underflow.
  39382,2 Activate energy bar redraw cycle for this character.
  39384,3 Write updated energy byte back to IY+7.
N 39387 Redraws the 3-chars energy bar at column 0 (player 1) or 29 (P2/P2).  
  39387,2 Convert energy to a segment display index.
  39389,2 Halve to get the 3-segment bar index (0-6).
  39391,3 Base of energy bar attribute data #R46827.
  39394,3 Read display byte for this segment via #R38318.
  39397,1 Save display byte across the address calculation.
  39398,2 Set attribute page base.
  39400,2 Reload character type.
  39402,4 Jump to P2 bar address if not P1.
  39406,2 P1 energy bar column - left HUD.
  39408,2 Jump to shared draw.
  39410,2 P2 energy bar column - right HUD.
  39412,2 Draw 3 bar segments.
  39414,1 Restore display byte.
  39415,1 Copy display byte for segment extraction.
  39416,2 Extract first segment type (bits 0-1).
  39418,2 Convert to UDG ASCII code for this segment shape.
  39420,1 Preserve loop state.
  39421,1 Preserve screen address.
  39422,3 Draw segment glyph via #R35996.
  39425,1 Restore screen address.
  39426,1 Restore loop state.
  39427,1 Advance to next column.
  39428,1 Reload display byte.
  39429,1 Shift to next segment field.
  39430,1 Shift again to align to the next 2-bit field.
  39431,2 Repeat for all 3 segments.
  39433,1 Return - energy decremented and bar redrawn.
N 39434 If energy underflows from 0 to 255 (DEC A wraps), triggers the KO sequence.
  39434,2 KO - apply death movement to loser.
  39436,3 Apply movement 27 via #R36838.
  39439,2 Preserve loser state block.
  39441,2 Load loser character type.
  39443,2 Was loser P1?
  39445,2 Yes - winner is P2, select P2 state block.
  39447,4 P1 block - winner when loser was P2.
  39451,2 Jump to apply victory movement.
  39453,4 P2 block - winner when loser was P1.
  39457,2 Apply victory pose movement 36 to winner.
  39459,3 Apply movement 36 via #R36838.
  39462,2 Restore loser state block.
  39464,2 Set display value for empty bar.
  39466,2 Jump back to redraw bar as empty.
@ 39468 label=hit_detection
c 39468 Per-frame hit detection.
N 39468 Called once per frame from the main game loop.
N 39468 Skips entirely if #R47475 is non-zero (throttled by #R40092).
N 39468 Runs the attacker/defender check twice: first with P1 as attacker and P2 as defender, then reversed. For each pass, reads the attacker frame index and searches the hit section table #R45015 via #R38325. On a match, walks
N 39468 the section pairs comparing defender frame index against IY+8. On a match, calls #R39518 to validate range and resolve the hit.
N 39468 Hit section table #R45015 format: each section starts with the attacker frame ID, followed by (defender frameID, hitTypeIndex) pairs, terminated by 0xFF.
N 39468 INPUT: None. OUTPUT: None. DESTROYS: AF, BC, DE, HL, IX, IY.
  39468,5 Read frame skip counter #R47475 - return if non-zero.
  39473,8 Set up P1 as attacker (IX) and P2 as defender (IY).
  39481,3 Call #R39492 to run hit detection for this attacker/defender pair.
  39484,4 Set up P2 as attacker (IX) and P1 as defender (IY).
  39488,4 Fall through to #R39492 for the reversed pass.
@ 39492 label=hit_check
  39492,3 Load attacker frame index from IX+8.
  39495,6 Search hit section table #R45015 for the attacker frame via #R38325.
  39501,1 Return if attacker frame not found - no active hit this frame.
  39502,3 Read candidate defender frame ID from the current table pair.
@ 39504 label=hit_pair_scan
  39505,3 Compare against defender frame index IY+8.
  39508,3 Match - call #R39518 to validate range and apply the hit.
  39511,3 Advance to the next pair.
  39514,4 Loop until 0xFF sentinel - no more pairs for this attacker frame.
@ 39518 label=collision_solver
c 39518 Hit range validation and combat event dispatch.
N 39518 Called by #R39468 when attacker and defender frame states match a hit table entry. Validates the hit by comparing #R46834 fighter distance against the four packed range values in byte 0 of the #R46308  indexed by hit type. If no range matches, the hit is silently ignored.
N 39518 On a valid hit, byte 1 gives the defender reaction movement ID (255 = no change), applied via #R39194. Byte 2 high nibble gives the combat event type stored in #R46803. Byte 2 low nibble gives the knockback type passed
N 39518 to #R39367 to decrement energy.
N 39518 INPUT: HL = pointer into hit section pair (defender frame ID, hit type index). IX = attacker state block, IY defender state block.
N 39518 OUTPUT: None. DESTROYS: AF, BC, DE, HL.
  39518,1 Preserve HL.
  39519,1 Advance to hit type index byte.
  39520,2 Read hit type index.
  39522,2 Zero-extend index to 16 bits.
  39524,3 HL base of hit type parameter table #R46308.
  39527,3 Select the 3-byte entry for this hit type.
N 39530 Range validation - byte 0 contains four packed 2-bit range fields.
  39530,1 Read byte 0 - four packed range values.
  39531,6 Extract range field 0 and compare against fighter distance #R46834.
  39537,3 Match - jump to valid-hit path at #R39580.
  39540,6 Extract range field 1 and compare against fighter distance.
  39546,3 Match - jump to #R39580.
  39549,6 Extract range field 2 and compare against fighter distance.
  39555,3 Match - jump to #R39580.
  39558,8 Extract range field 3 and compare against fighter distance.
  39566,6 Match - jump to #R39580.
  39572,6 No range matched - hit misses silently.
  39578,2 Jump to exit at #R39615.
N 39580 Valid hit - apply defender reaction movement (byte 1).
  39580,1 Advance to reaction movement field.
  39581,3 Movement ID 255 means no reaction - skip.
  39584,2 Jump to #R39591.
  39586,5 Apply defender reaction movement via #R39194.
N 39591 Combat event dispatch - byte 2 high nibble.
  39591,1 Advance to combat event / knockback byte.
  39592,1 Read byte 2.
  39593,2 Isolate event type (high nibble).
  39595,3 Event type 0 - skip storage.
  39598,4 Shift event type to low nibble.
  39602,3 Store event type in #R46803.
  39605,4 Store attacker state block pointer in #R46804.
N 39609 Knockback and energy decrement - byte 2 low nibble.
  39609,3 Isolate knockback type (low nibble).
  39612,3 Non-zero knockback - decrement defender energy via #R39367.
  39615,1 Restore HL.
  39616,1 Return.
@ 39617 label=combat_loop
c 39617 Main combat loop.
N 39617 Executed once per frame during active combat. Handles input, animation, rendering and death exit for both fighters and the goblin.
N 39617 Frame processing order:
N 39617 1. Compute horizontal fighter distance via #R39856, stored in #R46834.
N 39617 2. Dispatch input or AI for P2 then P1 via #R35713.
N 39617 3. Update animation, movement and X position for P2 then P1 via #R39827.
N 39617 4. Draw P1 and P2 sprites via #R37486; Z-order determined by movement properties bit 0.
N 39617 5. Draw the P2 overlay tile via #R38220.
N 39617 6. If the goblin (#R46443) is inactive, return immediately. Otherwise advance and draw it via #R37536 and #R37486, skipping the frame advance if the skip counter (#R47475) is non-zero.
N 39617 7. Death check: if P1 holds movement 8 or 27, set P2 to movement 19 (victory) with IY=P1 as the dying character. Otherwise set P1 to movement 19 with IY=P2 as the dying character.
N 39617 8. Goblin sync and exit: when the goblin's X tile reaches 29, deactivate the goblin and select exit animation 29, 31, 32 or 33 based on mirror flag and movement ID.
N 39617 Movement IDs: 8 = decapitation death, 27 = standard death, 19 = victory pose.
N 39617 INPUT: None. OUTPUT: None. Framebuffer, character state blocks and #R46834 updated in place.
N 39617 DESTROYS: AF, BC, DE, HL, IY, IX.
N 39617 Frame processing: compute fighter distance, dispatch input or AI for both characters, update animation and X position, draw sprites in Z-order, draw P2 overlay tile, and advance and draw the goblin if active.
  39617,3 Compute fighter distance and store in #R46834.
  39620,7 Point IY at P2 state block and dispatch input or AI for P2.
  39627,3 Update P2 frame, movement and X position.
  39630,7 Point IY at P1 state block and dispatch input or AI for P1.
  39637,3 Update P1 frame, movement and X position.
  39640,6 Load P1 movement ID and read its properties byte via #R39245.
  39646,2 Test draw-order flag (bit 0 of the properties byte).
  39648,19 If bit clear, draw P1 then P2 (P2 on top). If bit set, draw P2 only here (P1 draws on top at #R39674).
  39667,1 Save draw-order flag.
  39668,3 Draw P2 overlay tile.
  39671,1 Restore draw-order flag.
  39672,2 Restore P1 state block pointer.
  39674,3 Draw-order bit set: draw P1 sprite on top.
  39677,4 Point IY at the goblin state block.
  39681,3 Load goblin active flag.
  39684,1 Test if zero.
  39685,1 Return if goblin is inactive.
  39686,3 Load frame skip counter.
  39689,1 Test if non-zero.
  39690,3 Skip counter active: draw current goblin frame without advancing animation.
  39693,3 Load goblin X tile counter.
  39696,1 Increment X tile counter.
  39697,2 Wrap to 0-31.
  39699,3 Write updated X tile counter back.
  39702,3 Advance goblin animation frame.
  39705,3 Draw goblin sprite.
N 39708 Death check: if P1 holds movement 8 or 27, assign victory (movement 19) to P2 with P1 as the dying character; otherwise assign victory to P1 with P2 as the dying character.
  39708,4 Point IY at P1 state block for death check.
  39712,3 Load P1 current movement ID.
  39715,2 Is P1 in the decapitation death animation (movement 8)?
  39717,2 Yes: take the P1 dying path.
  39719,2 Is P1 in the standard death animation (movement 27)?
  39721,2 Yes: take the P1 dying path.
  39723,2 P1 not dying: take the P2 dying path.
  39725,6 P1 dying: point IY at P2 and load A=19 for victory.
  39731,3 Apply movement 19 victory to P2 via #R36838.
  39734,4 Point IY back at P1 state block (dying character).
  39738,2 Jump to position check.
  39740,2 P2 dying: load A=19 for victory.
  39742,3 Apply movement 19 victory to P1 via #R36838.
  39745,4 Point IY at P2 state block (dying character) for position check.
N 39749 Goblin sync and exit: synchronise goblin step-over with the dying character body, trigger the flying head final phase, and when the goblin X tile reaches 29 deactivate it and select the exit animation based on mirror flag and movement ID.
  39749,3 Load dying character's X tile position into B.
  39752,2 Load constant 7 for sync offset.
  39754,1 Add X tile to compute goblin sync threshold (X+7).
  39755,1 Save sync threshold in B.
  39756,3 Load goblin X tile position from #R46446.
  39759,1 Compare goblin X tile with sync threshold.
  39760,2 No match: skip body nudge, jump to head sync check.
N 39762 Goblin step-over sync fires when #R46446 matches #R46815 AND 31 - 1 AND 31. Triggers once as the goblin steps over the landed head, launching it rightward.
  39762,3 Sync match: nudge dying character X position by 1 for body alignment.
  39765,1 Preserve goblin X tile position in B.
  39766,3 Load low byte of head framebuffer address from #R46815.
  39769,2 Extract screen column (0-31).
  39771,1 Offset by 1 to align with goblin X tracking.
  39772,2 Wrap to 0-31 column range.
  39774,1 Compare adjusted head column with goblin X tile.
  39775,3 Match: trigger flying head final-phase update via #R37964.
  39778,1 Reload goblin X tile position into A.
  39779,2 Test if goblin X tile has reached 29 (body exits the screen).
  39781,1 Not yet: return, fight sequence continues.
  39782,4 Goblin X reached 29: deactivate goblin by clearing #R46443.
  39786,3 Load the dying character's mirror flag byte.
  39789,2 Test bit 0: is the character mirrored (facing left)?
  39791,2 Not mirrored: jump to #R39810.
N 39793 Exit animation selection when mirrored (facing left): movement 27 (death): exit 32 (drag left, mirrored); movement 8 (decapitation): exit 29 (drag left mirrored with decap).
  39793,3 Mirrored: load dying character's movement ID.
  39796,2 Is it movement 27 (standard death)?
  39798,2 Yes: jump to #R39805.
  39800,5 No (decapitation): apply drag-left (mirrored) with decap exit animation (29) via #R36838.
  39805,5 Standard death mirrored: apply drag-left (mirrored) exit animation (32) via #R36838.
N 39810 Exit animation selection when not mirrored (facing right): movement 27 (death): exit 33 (drag right); movement 8 (decapitation): exit 31 (drag right with decap).
  39810,3 Not mirrored: load dying character's movement ID.
  39813,2 Is it movement 27 (standard death)?
  39815,2 Yes: jump to #R39822.
  39817,5 No (decapitation): apply drag-right with decap exit animation (31) via #R36838.
  39822,5 Standard death not mirrored: apply drag-right exit animation (33) via #R36838.
@ 39827 label=char_frame_update
c 39827 Per-frame character update.
D 39827 Called from #R39617 for each fighter with IY pointing to their state block.
N 39827 Returns immediately if IY+0=0 (inactive) or #R47475 non-zero (3-frame cycle skip, see #R40092).
N 39827 INPUT: IY = character state block. OUTPUT: None. DESTROYS: AF, BC, HL.
  39827,3 Load fighter block state.
  39830,2 Return if zero (inactive).
  39832,3 Load #R47475 (hit-detection skip counter)
  39835,2 Return if non-zero (frame skip).
  39837,3 Process input/movement transition.
  39840,3 Advance frame pointer, trigger frame events.
  39843,3 Tail-call to #R39020 and returns directly to #R39617.
@ 39846 label=waits_112ms
c 39846 112 ms delay loop.
N 39846 Busy-wait timing routine used by menu and animation code. Runs a nested loop over B and C to burn a fixed number of T-states, roughly one frame at 50 Hz.
  39846,3 Load BC with the loop counters (B=96, C96).
  39849,1 Inner loop: decrement B.
  39850,2 If B is not zero, repeat the inner loop.
  39852,1 Outer loop: decrement C.
  39853,2 If C is not zero, restart the inner loop.
  39855,1 Return after both counters have reached zero (after 9216 loops).
@ 39856 label=calc_distance
c 39856 Calculate horizontal distance between fighters.
N 39856 Reads tile X position of both characters and computes the absolute difference. Result stored in #R46834, used by #R39518 to validate hit ranges.
N 39856 Direction is determined by the mirror flag of P1 (#R46427 bit 0).
  39856,7 Load #R46427 (P1 flags); test bit 0 (mirror flag).
  39863,10 Not mirrored: load P1 X (#R46428) into B, load P2 X (#R46437), subtract B.
  39873,8 Mirrored: load P2 X (#R46437) into B, load P1 X (#R46428), subtract B.
  39881,3 Store result (absolute X delta) in #R46834.
  39884,1 Return.
@ 39885 label=beeper_engine
c 39885 Beeper sound engine.
N 39885 Plays a sequence of square-wave tones from a 0-terminated period table pointed by IX. For each non-zero period byte, emits one complete HIGH/LOW cycle via #R39897, then advances to the next byte.
N 39885 Called by all combat sound dispatchers: #R39926 (tackle), #R39932 (kick), #R39938 (slash), #R39944 (head cut), #R39950 (guard 1), #R39956 (guard 2), #R39962 (round end).
N 39885 INPUT: IX = base address of sound data table (period bytes, 0-terminated). OUTPUT: None. DESTROYS: AF, BC, IX.
  39885,5 Load next period byte from IX. Return if zero (end of sequence).
  39890,3 Emit one square-wave cycle with this period via #R39897.
  39893,4 Advance IX to next period byte and repeat.
@ 39897 label=beeper_emit  
c 39897 Emits one square-wave pulse.
N 39897 Plays one complete HIGH-LOW cycle for the given period value. Called by #R39885 once per non-zero period byte in the sound data table.
N 39897 INPUT: A = period value (higher = lower pitch). OUTPUT: None. DESTROYS: AF, BC.
  39897,1 B = period value.
  39898,1 Preserve BC across HIGH phase.
  39899,3 HIGH phase: B-iteration delay loop then speaker HIGH via #R39906.
  39902,1 Restore BC.
  39903,3 LOW phase: B-iteration delay loop then speaker LOW via #R39916.
@ 39906 label=beep_high_phase
c 39906 Beeper HIGH phase.
N 39906 B-iteration delay then OUT (254),16 to drive speaker HIGH.
N 39906 INPUT  B = number of delay iterations. DESTROYS AF, B.
  39906,5 NOP x3 + DJNZ timing loop, B iterations.
  39911,4 A = 16; drive speaker HIGH via OUT 254,A.
  39915,1 Return.
@ 39916 label=beep_low_phase
c 39916 Beeper LOW phase.
N 39916 B-iteration delay then OUT (254),0 to drive speaker LOW.
N 39916 INPUT:  B = number of delay iterations. DESTROYS: AF, B.
  39916,5 NOP x3 + DJNZ timing loop, B iterations.
  39921,4 A = 0; drive speaker LOW via OUT 254,A.
  39925,1 Return.
c 39926 Combat Sound Effects List.
N 39926 Loads IX with the sound data pointer for this event and plays it via #R39885. Then returns to the caller routine.
N 39926 INPUT: A = sound index. OUTPUT: None. DESTROYS: AF, BC, DE, HL, IX.
@ 39926 label=sound_tackle
N 39926 Sound: kick
  39926,6 Points to sound data #R48180 and plays it.
@ 39932 label=sound_kick
N 39932 Sound: tackle
N 39932 Called from #R35531.
  39932,6 Points to sound data #R48200 and plays it.
@ 39938 label=sound_slash
N 39938 Sound: slash
N 39938 Called from #R35531.
  39938,6 Points to sound data #R48210 and plays it.
@ 39944 label=sound_head_cut
N 39944 Sound: Head Cut
N 39944 Called from #R35514, #R35531 and #R35937.
  39944,6 Points to sound data #R48158 and plays it.
@ 39950 label=sound_guard_1
N 39950 Sound: guard 1
N 39950 Called from #R35531.
  39950,6 Points to sound data #R48241 and plays it.
@ 39956 label=sound_guard_2
N 39956 Sound: guard 2
N 39956 Called from #R35531.
  39956,6 Points to sound data #R48251 and plays it.
@ 39962 label=sound_round_end
N 39962 Sound: round end.
N 39962 Plays when the post-fight score sequence runs.
N 39962 Called from #R37852 (post-fight handler, score + time HUD update). NOT part of the in-combat sounds, dispatch chain in #R35531.
  39962,6 Points to sound data #R48261 plays it.
@ 39968 label=tackle_side_swap
c 39968 Tackle cross-side animation controller.
N 39968 Two-phase sequencer for roll/jump-over side-swap. Triggered by #R39020 when one fighter rolls (mv17 frame 38) while the other jumps over (frames 8-9).
N 39968 Gated by #R47475 (3-frame cycle via #R40092) and #R47575 (phase selector).
N 39968 Phase 1 (#R47575=1): apply mv34 (changeside) to both, advance to phase 2.
N 39968 Phase 2 (#R47575=2): wait for mid-swap frame (P1 IY+8=16), apply mv0 + mirror flip + X correction (+-2 tiles).
N 39968 Called pre-HALT at #R35325; reads #R47475 set by previous frame's #R40092 (post-HALT).
N 39968 INPUT: None. OUTPUT: None. DESTROYS: AF, BC, DE, HL, IY.
  39968,10 Guard: return if #R47475 != 0 (skip frames 1-2) or #R47575 == 0 (not active).
  39978,4 Test phase selector #R47575: phase 2 jumps to #R40021.
N 39982 Phase 1: scan for roll-complete frame (mv17 frame 38).
  39982,7 Check P1 frame index #R46433 == 38; jump if match.
  39989,5 Check P2 frame index #R46442 == 38; jump if match.
  39997,24 Apply mv34 (changeside) to P1 then P2 via #R36838; set #R47575=2 (phase 2).
N 40021 Phase 2: wait for mid-swap sync.
  40021,6 Guard: return unless P1 frame index #R46433 == 16 (mid-changeside).
  40027,10 Clear #R47575; IY = P1 block #R46425.
  40037,3 Call #R40077 (mv0 + mirror flip); Z/NZ selects X correction.
  40040,3 Z set (now facing right): IY+3 += 2.
  40043,3 NZ clear (now facing left): IY+3 -= 2.
  40046,4 IY = P2 block #R46434.
  40050,3 Call #R40077 for P2.
  40053,2 Z set (P2 now right): IY+3 += 2.
  40055,11 NZ clear (P2 now left): IY+3 -= 2 (move character 2 tiles left after swap).
  40066,11 Z set (P2 now right): IY+3 += 2 (move character 2 tiles right after swap).
@ 40077 label=stop_mov_and_mirror
c 40077 Apply idle movement and toggle facing direction.
N 40077 Helper called twice by #R39968 phase 2 after the side-swap animation completes, once for each fighter.
N 40077 Applies movement 0 (idle/stop) to reset the animation state, then flips bit 0 of the mirror flag to reverse the character's facing direction.
N 40077 The caller uses the returned Z flag to select the correct X tile correction: Z (now facing right) adds 2; NZ (now facing left) subtracts 2.
N 40077 INPUT: IY = character state block. OUTPUT: Z = set if now facing right, NZ if now facing left. DESTROYS: A.
  40077,1 Select movement 0 (idle).
  40078,3 Apply idle movement to the character via #R36838.
  40081,3 Load the mirror and control flags byte.
  40084,2 Toggle the facing direction bit.
  40086,3 Write the updated flags byte back.
  40089,2 Isolate the new facing bit to set Z or NZ.
  40091,1 Return with Z reflecting the new facing direction.
@ 40092 label=frame_counter_hit_inc
c 40092 3-frame cycle counter advance.
N 40092 Advances #R47475 by 1 each call.
N 40092 Active frame (counter=0) runs #R39968 (pre-HALT) and #R39468 (hit detection).
N 40092 INPUT: None. OUTPUT: None. DESTROYS: AF.
  40092 Load current counter from #R47475.
  40095 Increment the counter.
  40096 Store updated counter back to #R47475.
  40099 Counter reached 2 - reset it to 0.
  40101 Not yet - return with counter at 1.
  40102 Reset counter to 0.
  40103 Store reset value back to #R47475.
  40106 Return.
u 40107 Empty Space.
@ 40192 label=other_sprites
b 40192 Other Sprites tiles (P2, heads, goblin, Drax, Princess).
D 40192 Full tilesheet: 
D 40192 #IMGW(25)(enemy_sheet.png)
D 40192 52 tiles, 64 bytes each. 24(8*3)h x 21vert px
  40192 Tile 00
  40193 #IMG(tiles/enemy_001.png)Drax death 2
  40256 Tile 01
  40257 #IMG(tiles/enemy_002.png)Player head 1
  40320 Tile 02
  40321 #IMG(tiles/enemy_003.png)Player head 2
  40384 Tile 03
  40385 #IMG(tiles/enemy_004.png)Drax Death 1 top
  40448 Tile 04
  40449 #IMG(tiles/enemy_005.png)Player head 3
  40512 Tile 05
  40513 #IMG(tiles/enemy_006.png)Player head 4
  40576 Tile 06
  40577 #IMG(tiles/enemy_007.png)Player head shadow
  40640 Tile 07
  40641 #IMG(tiles/enemy_008.png)P2 Overlay 5
  40704 Tile 08
  40705 #IMG(tiles/enemy_009.png)P2 Overlay 6
  40768 Tile 09
  40769 #IMG(tiles/enemy_010.png)P2 Overlay 7
  40832 Tile 10
  40833 #IMG(tiles/enemy_011.png)P2 Overlay 8
  40896 Tile 11
  40897 #IMG(tiles/enemy_012.png)P2 Overlay 9
  40960 Tile 12
  40961 #IMG(tiles/enemy_013.png)P2 Overlay 10
  41024 Tile 13
  41025 #IMG(tiles/enemy_014.png)P2 Overlay 11
  41088 Tile 14
  41089 #IMG(tiles/enemy_015.png)P2 Overlay 12
  41152 Tile 15
  41153 #IMG(tiles/enemy_016.png)P2 Overlay 13
  41216 Tile 16
  41217 #IMG(tiles/enemy_017.png)P2 head 1
  41280 Tile 17
  41281 #IMG(tiles/enemy_018.png)P2 head 2
  41344 Tile 18
  41345 #IMG(tiles/enemy_019.png)Spell 1
  41408 Tile 19
  41409 #IMG(tiles/enemy_020.png)P2 head 3
  41472 Tile 20
  41473 #IMG(tiles/enemy_021.png)P2 head 4
  41536 Tile 21
  41537 #IMG(tiles/enemy_022.png)P2 Overlay 14
  41600 Tile 22
  41601 #IMG(tiles/enemy_023.png)Spell 2
  41664 Tile 23
  41665 #IMG(tiles/enemy_024.png)P2 Overlay 15
  41728 Tile 24
  41729 #IMG(tiles/enemy_025.png)P2 Overlay 16
  41792 Tile 25
  41793 #IMG(tiles/enemy_026.png)P2 Overlay 17
  41856 Tile 26
  41857 #IMG(tiles/enemy_027.png)P2 Overlay 18
  41920 Tile 27
  41921 #IMG(tiles/enemy_028.png)Drax Death 1 middle/Stand middle
  41984 Tile 28
  41985 #IMG(tiles/enemy_029.png)P2 Overlay 19
  42048 Tile 29
  42049 #IMG(tiles/enemy_030.png)P2 Overlay 20
  42112 Tile 30
  42113 #IMG(tiles/enemy_031.png)P2 Overlay 21
  42176 Tile 31
  42177 #IMG(tiles/enemy_032.png)P2 Overlay 22
  42240 Tile 32
  42241 #IMG(tiles/enemy_033.png)Drax Spell Top
  42304 Tile 33
  42305 #IMG(tiles/enemy_034.png)P2 Overlay 23
  42368 Tile 34
  42369 #IMG(tiles/enemy_035.png)P2 Overlay 24
  42432 Tile 35
  42433 #IMG(tiles/enemy_036.png)P2 Overlay 25
  42496 Tile 36
  42497 #IMG(tiles/enemy_037.png)P2 Overlay 26
  42560 Tile 37
  42561 #IMG(tiles/enemy_038.png)P2 Overlay 27
  42624 Tile 38
  42625 #IMG(tiles/enemy_039.png)Goblin Top
  42688 Tile 39
  42689 #IMG(tiles/enemy_040.png)Goblin Bottom 1
  42752 Tile  40
  42753 #IMG(tiles/enemy_041.png)Goblin Bottom 2
  42816 Tile  41
  42817 #IMG(tiles/enemy_042.png)P2 Overlay 28
  42880 Tile  42
  42881 #IMG(tiles/enemy_043.png)Mariana 1 top
  42944 Tile  43
  42945 #IMG(tiles/enemy_044.png)Mariana 1 middle
  43008 Tile  44
  43009 #IMG(tiles/enemy_045.png)Mariana 1 bottom
  43072 Tile  45
  43073 #IMG(tiles/enemy_046.png)Mariana 2 top
  43136 Tile  46
  43137 #IMG(tiles/enemy_047.png)Mariana 2 bottom left
  43200 Tile  47
  43201 #IMG(tiles/enemy_048.png)Mariana 2 bottom right
  43264 Tile  48
  43265 #IMG(tiles/enemy_049.png)Drax Stand Top
  43328 Tile  49
  43329 #IMG(tiles/enemy_050.png)Drax Spell Middle
  43392 Tile 50
  43393 #IMG(tiles/enemy_051.png)Drax Stand/Death bottom
  43456 Tile 51
  43457 #IMG(tiles/enemy_052.png)Drax Spell Hand
@ 43520 label=sprites_shape_table
b 43520 Barbarian sprite shape control table.
D 43520 21 entries (0-20), 1 byte each. Defines shape/behaviour for each frame's sprite.
N 43520 Accessed as (IX+0) by #R38367 (12-tile mirror checker). Controls tile grid expansion:
N 43520 255 = empty slot: INC IX (skip), no tile consumed from HL frame data. The rest IDs are active shape: consume 1 tile index from HL, render via #R37449.
N 43520 Produces variable-width sprites: 0-3 tiles wide (4 rows tall), column offset follows.
  43520,12,3 #HTML(<span style="font-family:ui-monospace,SFMono-Regular,SF Mono,Menlo,Consolas,Liberation Mono,monospace !important">[ ][ ][ ]</br>[X][X][ ]</br>[X][X][ ]</br>[X][X][ ]</span>)
  43532,12,3 #HTML(<span style="font-family:ui-monospace,SFMono-Regular,SF Mono,Menlo,Consolas,Liberation Mono,monospace !important">[X][X][ ]</br>[X][X][ ]</br>[X][X][ ]</br>[X][X][ ]</span>)
  43544,12,3 #HTML(<span style="font-family:ui-monospace,SFMono-Regular,SF Mono,Menlo,Consolas,Liberation Mono,monospace !important">[ ][ ][ ]</br>[ ][ ][ ]</br>[X][ ][ ]</br>[X][ ][ ]</span>)
  43556,12,3 #HTML(<span style="font-family:ui-monospace,SFMono-Regular,SF Mono,Menlo,Consolas,Liberation Mono,monospace !important">[ ][ ][ ]</br>[ ][ ][ ]</br>[X][X][ ]</br>[X][X][ ]</span>)
  43568,12,3 #HTML(<span style="font-family:ui-monospace,SFMono-Regular,SF Mono,Menlo,Consolas,Liberation Mono,monospace !important">[ ][ ][ ]</br>[ ][ ][ ]</br>[ ][ ][ ]</br>[ ][X][X]</span>)
  43580,12,3 #HTML(<span style="font-family:ui-monospace,SFMono-Regular,SF Mono,Menlo,Consolas,Liberation Mono,monospace !important">[ ][ ][ ]</br>[X][ ][ ]</br>[X][ ][ ]</br>[X][ ][ ]</span>)
  43592,12,3 #HTML(<span style="font-family:ui-monospace,SFMono-Regular,SF Mono,Menlo,Consolas,Liberation Mono,monospace !important">[ ][ ][ ]</br>[ ][ ][ ]</br>[ ][X][ ]</br>[X][X][ ]</span>)
  43604,12,3 #HTML(<span style="font-family:ui-monospace,SFMono-Regular,SF Mono,Menlo,Consolas,Liberation Mono,monospace !important">[ ][ ][ ]</br>[ ][ ][ ]</br>[ ][ ][ ]</br>[X][ ][ ]</span>)
  43616,12,3 #HTML(<span style="font-family:ui-monospace,SFMono-Regular,SF Mono,Menlo,Consolas,Liberation Mono,monospace !important">[ ][ ][ ]</br>[ ][ ][ ]</br>[ ][ ][ ]</br>[X][X][X]</span>)
  43628,12,3 #HTML(<span style="font-family:ui-monospace,SFMono-Regular,SF Mono,Menlo,Consolas,Liberation Mono,monospace !important">[ ][ ][ ]</br>[X][ ][ ]</br>[X][X][X]</br>[X][X][ ]</span>)
  43640,12,3 #HTML(<span style="font-family:ui-monospace,SFMono-Regular,SF Mono,Menlo,Consolas,Liberation Mono,monospace !important">[ ][ ][ ]</br>[ ][ ][ ]</br>[ ][ ][ ]</br>[ ][ ][X]</span>)
  43652,12,3 #HTML(<span style="font-family:ui-monospace,SFMono-Regular,SF Mono,Menlo,Consolas,Liberation Mono,monospace !important">[ ][ ][ ]</br>[X][X][X]</br>[X][X][ ]</br>[X][X][ ]</span>)
  43664,12,3 #HTML(<span style="font-family:ui-monospace,SFMono-Regular,SF Mono,Menlo,Consolas,Liberation Mono,monospace !important">[ ][ ][ ]</br>[ ][ ][ ]</br>[ ][ ][ ]</br>[X][X][ ]</span>)
  43676,12,3 #HTML(<span style="font-family:ui-monospace,SFMono-Regular,SF Mono,Menlo,Consolas,Liberation Mono,monospace !important">[ ][X][ ]</br>[X][X][ ]</br>[X][X][ ]</br>[X][X][ ]</span>)
  43688,12,3 #HTML(<span style="font-family:ui-monospace,SFMono-Regular,SF Mono,Menlo,Consolas,Liberation Mono,monospace !important">[ ][ ][ ]</br>[X][ ][ ]</br>[X][X][ ]</br>[X][X][ ]</span>)
  43700,12,3 #HTML(<span style="font-family:ui-monospace,SFMono-Regular,SF Mono,Menlo,Consolas,Liberation Mono,monospace !important">[ ][ ][ ]</br>[ ][ ][ ]</br>[X][X][ ]</br>[X][X][X]</span>)
  43712,12,3 #HTML(<span style="font-family:ui-monospace,SFMono-Regular,SF Mono,Menlo,Consolas,Liberation Mono,monospace !important">[ ][ ][ ]</br>[X][ ][ ]</br>[X][ ][ ]</br>[X][X][ ]</span>)
  43724,12,3 #HTML(<span style="font-family:ui-monospace,SFMono-Regular,SF Mono,Menlo,Consolas,Liberation Mono,monospace !important">[ ][ ][ ]</br>[X][X][ ]</br>[X][X][X]</br>[X][X][ ]</span>)
  43736,12,3 #HTML(<span style="font-family:ui-monospace,SFMono-Regular,SF Mono,Menlo,Consolas,Liberation Mono,monospace !important">[ ][ ][ ]</br>[ ][ ][ ]</br>[X][X][X]</br>[X][X][ ]</span>)
  43748,12,3 #HTML(<span style="font-family:ui-monospace,SFMono-Regular,SF Mono,Menlo,Consolas,Liberation Mono,monospace !important">[ ][ ][ ]</br>[ ][ ][ ]</br>[ ][X][ ]</br>[X][X][X]</span>)
  43760,12,3 #HTML(<span style="font-family:ui-monospace,SFMono-Regular,SF Mono,Menlo,Consolas,Liberation Mono,monospace !important">[ ][ ][ ]</br>[ ][ ][ ]</br>[ ][X][ ]</br>[ ][X][ ]</span>)
@ 43772 label=barb_spritesheet
b 43772 Barbarian Spritesheet
N 43772 Frame data structure: 1-byte shape ID + 12 tile indices (4 rows x 3 tiles wide).
N 43772 Shape table #R43520 defines sprite shapes; tile indices reference #R49152 (barbarian tileset).
N 43772 Rendered by #R37404 (4x3 grid blitter): loads column offset byte, then 12 tiles via #R37449.
N 43772 P2 uses identical base sprites as P1 with per-frame overlay tiles composited via #R38220.
N 43772 #R47223: tile index per P2 frame (0-52, 255=no overlay). #R47329: position bits 0-5 scanline offset from row 94, bits 6-7 column offset (0-3 right of P2 X tile, inverted if mirrored).
N 43772 Overlay state #R46817 mirrors head block #R46809 layout, using shared renderer #R38103 + #R38158 orientation check.
N 43772 #IMGW(50)(sprites_v3.png)
  43772 Sprite ID0, ID51, ID52, ID93
  43773 #IMG(sprites/000.png)
  43779 Sprite ID1, ID53, ID97
  43780 #IMG(sprites/001.png)
  43786 Sprite ID2, ID54, ID98
  43787 #IMG(sprites/002.png)
  43793 Sprite ID3, ID55, ID80, ID99
  43794 #IMG(sprites/003.png)
  43800 Sprite ID4
  43801 #IMG(sprites/004.png)
  43807 Sprite ID5
  43808 #IMG(sprites/005.png)
  43814 Sprite ID6
  43815 #IMG(sprites/006.png)
  43821 Sprite ID7
  43822 #IMG(sprites/007.png)
  43829 Sprite ID8, ID56
  43830 #IMG(sprites/008.png)
  43838 Sprite ID9
  43839 #IMG(sprites/009.png)
  43847 Sprite ID10
  43848 #IMG(sprites/010.png)
  43852 Sprite ID11, ID57, ID58
  43853 #IMG(sprites/011.png)
  43857 Sprite ID12, ID62, ID96
  43858 #IMG(sprites/012.png)
  43863 Sprite ID13, ID59
  43864 #IMG(sprites/013.png)
  43870 Sprite ID14, ID94
  43871 #IMG(sprites/014.png)
  43879 Sprite ID15
  43880 #IMG(sprites/015.png)
  43888 Sprite ID16
  43889 #IMG(sprites/016.png)
  43897 Sprite ID17
  43898 #IMG(sprites/017.png)
  43901 Sprite ID18
  43902 #IMG(sprites/018.png)
  43905 Sprite ID19
  43906 #IMG(sprites/019.png)
  43910 Sprite ID20, ID100
  43911 #IMG(sprites/020.png)
  43914 Sprite ID21
  43915 #IMG(sprites/021.png)
  43922 Sprite ID22, ID68
  43923 #IMG(sprites/022.png)
  43928 Sprite ID23, ID61
  43929 #IMG(sprites/023.png)
  43935 Sprite ID24
  43936 #IMG(sprites/024.png)
  43942 Sprite ID25, ID60, ID66
  43943 #IMG(sprites/025.png)
  43949 Sprite ID26, ID67, ID69
  43950 #IMG(sprites/026.png)
  43957 Sprite ID27, ID70
  43958 #IMG(sprites/027.png)
  43964 Sprite ID28
  43965 #IMG(sprites/028.png)
  43971 Sprite ID29
  43972 #IMG(sprites/029.png)
  43977 Sprite ID30
  43978 #IMG(sprites/030.png)
  43984 Sprite ID31, ID72
  43985 #IMG(sprites/031.png)
  43992 Sprite ID32, ID73
  43993 #IMG(sprites/032.png)
  44000 Sprite ID33, ID89, ID105
  44001 #IMG(sprites/033.png)
  44004 Sprite ID34
  44005 #IMG(sprites/034.png)
  44011 Sprite ID35, ID46
  44012 #IMG(sprites/035.png)
  44016 Sprite ID36, ID45
  44017 #IMG(sprites/036.png)
  44019 Sprite ID37, ID44
  44020 #IMG(sprites/037.png)
  44022 Sprite ID38, ID43
  44023 #IMG(sprites/038.png)
  44025 Sprite ID39, ID42
  44026 #IMG(sprites/039.png)
  44028 Sprite ID40, ID41
  44029 #IMG(sprites/040.png)
  44033 Sprite ID47
  44034 #IMG(sprites/047.png)
  44040 Sprite ID48
  44041 #IMG(sprites/048.png)
  44047 Sprite ID49
  44048 #IMG(sprites/049.png)
  44056 Sprite ID50, ID74
  44057 #IMG(sprites/050.png)
  44063 Sprite ID63, ID64, ID65, ID71, ID75, ID81
  44064 #IMG(sprites/063.png)
  44070 Sprite ID76
  44071 #IMG(sprites/076.png)
  44076 Sprite ID77, ID78
  44077 #IMG(sprites/077.png)
  44080 Sprite ID79
  44081 #IMG(sprites/079.png)
  44086 Sprite ID82
  44087 #IMG(sprites/082.png)
  44093 Sprite ID83
  44094 #IMG(sprites/083.png)
  44100 Sprite ID84
  44101 #IMG(sprites/084.png)
  44107 Sprite ID85
  44108 #IMG(sprites/085.png)
  44113 Sprite ID86
  44114 #IMG(sprites/086.png)
  44117 Sprite ID87, ID90
  44118 #IMG(sprites/087.png)
  44122 Sprite ID88
  44123 #IMG(sprites/088.png)
  44129 Sprite ID91
  44130 #IMG(sprites/091.png)
  44133 Sprite ID92
  44134 #IMG(sprites/092.png)
  44137 Sprite ID95
  44138 #IMG(sprites/095.png)
  44144 Sprite ID101
  44145 #IMG(sprites/101.png)
  44147 Sprite ID102
  44148 #IMG(sprites/102.png)
  44149 Sprite ID103
  44150 #IMG(sprites/103.png)
  44152 Sprite ID104
  44153 #IMG(sprites/104.png)
  44154 Sprite ID106
  44155 #IMG(sprites/106.png)
  44157 Sprite ID107
  44158 #IMG(sprites/107.png)
  44159 Sprite ID108
  44160 #IMG(sprites/108.png)
  44162 Sprite ID109
  44163 #IMG(sprites/109.png)
  44164 Sprite ID110
  44165 #IMG(sprites/110.png)
  44167 Sprite ID111
  44168 #IMG(sprites/111.png)
  44170 Sprite ID112
  44171 #IMG(sprites/112.png)
  44176 Sprite ID113
  44177 #IMG(sprites/113.png)
  44181 Sprite ID114
  44182 #IMG(sprites/114.png)
  44185 Sprite ID115
  44186 #IMG(sprites/115.png)
@ 44189 label=barb_ptr_table
w 44189 Barbarian frame pointer table.
D 44189 116 entries (0-115), 2 bytes each. Points to frame data sequences in #R43520.
N 44189 Used by #R37486 (sprite dispatcher) and #R37536 (goblin renderer).
@ 44421 label=mov_ptr_table
w 44421 Movement animation pointer table.
D 44421 40 entries (0-39), 2 bytes each. Points to animation chains in #R44189.
N 44421 Array of 2-byte LE pointers indexed by movement ID.
N 44421 Each pointer targets the frame sequence for that movement.
N 44421 Read by #R36838 after updating IY+6 (movement ID).
N 44421 Result stored in IY+4,IY+5 as frame sequence start pointer.
@ 44501 label=frame_seq
b 44501 Frame sequences (animation data)
D 44501 One entry per movement ID. Each sequence is a list of frame indices into #R44189 Barbarian sprite pointer table, terminated by a sentinel byte.
N 44501 Note: Drax sprites and animations are present in the data but are never triggered in the 2 Players version of the game.
N 44501 Terminators: 
N 44501 #N$FD - LOOP: on the last frame, jump back to the first frame of the sequence.
N 44501 #N$FE - HOLD: freeze animation advance; the game logic determines when to proceed to the next frame.
N 44501 #N$FF - CHAIN: end this sequence and chain into another; the following byte specifies the target movement ID.
  44501,21 #HTML(<span>0 Idle</br>)#IMGW(10)(sprites/000.png)#IMGW(10)(sprites/082.png)#IMGW(10)(sprites/083.png)#IMGW(10)(sprites/084.png)
  44522,5 #HTML(<span>1 Walk forward</br>)#IMGW(10)(sprites/001.png)#IMGW(10)(sprites/002.png)#IMGW(10)(sprites/003.png)#IMGW(10)(sprites/051.png)
  44527,5 #HTML(<span>2 Walk backward</br>)#IMGW(10)(sprites/055.png)#IMGW(10)(sprites/054.png)#IMGW(10)(sprites/053.png)#IMGW(10)(sprites/052.png)
  44532,5 #HTML(<span>3 Sword Spin</br>)#IMGW(10)(sprites/004.png)#IMGW(10)(sprites/005.png)#IMGW(10)(sprites/006.png)#IMGW(10)(sprites/007.png)
  44537,5 #HTML(<span>4 Jump</br>)#IMGW(10)(sprites/008.png)#IMGW(10)(sprites/009.png)#IMGW(10)(sprites/056.png)#IMGW(10)(sprites/000.png)
  44542,6 #HTML(<span>5 Crouch Slash</br>)#IMGW(10)(sprites/010.png)#IMGW(10)(sprites/011.png)#IMGW(10)(sprites/012.png)#IMGW(10)(sprites/096.png)#IMGW(10)(sprites/057.png)
  44548,2 #HTML(<span>6 Crouch</br>)#IMGW(10)(sprites/058.png)
  44550,8 #HTML(<span>7 Headcut movement</br>)#IMGW(10)(sprites/014.png)#IMGW(10)(sprites/015.png)#IMGW(10)(sprites/016.png)#IMGW(10)(sprites/025.png)#IMGW(10)(sprites/026.png)#IMGW(10)(sprites/069.png)#IMGW(10)(sprites/025.png)
  44558,9 #HTML(<span>8 Death animation (head cutted)</br>)#IMGW(10)(sprites/017.png)#IMGW(10)(sprites/017.png)#IMGW(10)(sprites/017.png)#IMGW(10)(sprites/018.png)#IMGW(10)(sprites/018.png)#IMGW(10)(sprites/018.png)#IMGW(10)(sprites/019.png)#IMGW(10)(sprites/020.png)
  44567,6 #HTML(<span>9 Forward Slash</br>)#IMGW(10)(sprites/085.png)#IMGW(10)(sprites/022.png)#IMGW(10)(sprites/023.png)#IMGW(10)(sprites/061.png)#IMGW(10)(sprites/068.png)
  44573,3 #HTML(<span>10 Guard 1</br>)#IMGW(10)(sprites/063.png)#IMGW(10)(sprites/024.png)
  44576,6 #HTML(<span>11 Top front Slash</br>)#IMGW(10)(sprites/065.png)#IMGW(10)(sprites/066.png)#IMGW(10)(sprites/067.png)#IMGW(10)(sprites/069.png)#IMGW(10)(sprites/060.png)
  44582,5 #HTML(<span>12 Kick</br>)#IMGW(10)(sprites/027.png)#IMGW(10)(sprites/028.png)#IMGW(10)(sprites/070.png)#IMGW(10)(sprites/000.png)
  44587,4 #HTML(<span>13 Damage received</br>)#IMGW(10)(sprites/029.png)#IMGW(10)(sprites/030.png)#IMGW(10)(sprites/000.png)
  44591,6 #HTML(<span>14 Overhead slash</br>)#IMGW(10)(sprites/088.png)#IMGW(10)(sprites/031.png)#IMGW(10)(sprites/032.png)#IMGW(10)(sprites/073.png)#IMGW(10)(sprites/072.png)
  44597,4 #HTML(<span>15 Headbutt</br>)#IMGW(10)(sprites/050.png)#IMGW(10)(sprites/034.png)#IMGW(10)(sprites/074.png)
  44601,4 #HTML(<span>16 Guard 2</br>)#IMGW(10)(sprites/080.png)#IMGW(10)(sprites/075.png)#IMGW(10)(sprites/081.png)
  44605,5 #HTML(<span>17 Roll Forward</br>)#IMGW(10)(sprites/035.png)#IMGW(10)(sprites/036.png)#IMGW(10)(sprites/037.png)#IMGW(10)(sprites/038.png)
  44610,5 #HTML(<span>18 Roll Backward</br>)#IMGW(10)(sprites/041.png)#IMGW(10)(sprites/043.png)#IMGW(10)(sprites/044.png)#IMGW(10)(sprites/045.png)
  44615,13 #HTML(<span>19 Victory</br>)#IMGW(10)(sprites/000.png)#IMGW(10)(sprites/047.png)#IMGW(10)(sprites/047.png)#IMGW(10)(sprites/048.png)#IMGW(10)(sprites/049.png)#IMGW(10)(sprites/049.png)#IMGW(10)(sprites/049.png)#IMGW(10)(sprites/049.png)#IMGW(10)(sprites/049.png)#IMGW(10)(sprites/048.png)#IMGW(10)(sprites/047.png)#IMGW(10)(sprites/047.png)
  44628,2 #HTML(<span>20 Crouching</br>)#IMGW(10)(sprites/059.png)
  44630,2 #HTML(<span>21 Crouch Strike</br>)#IMGW(10)(sprites/062.png)
  44632,2 #HTML(<span>22 Guard 2</br>)#IMGW(10)(sprites/064.png)
  44634,2 #HTML(<span>23 Crouching</br>)#IMGW(10)(sprites/013.png)
  44636,2 #HTML(<span>24 Roll Backward</br>)#IMGW(10)(sprites/040.png)
  44638,5 #HTML(<span>25 Fall</br>)#IMGW(10)(sprites/076.png)#IMGW(10)(sprites/077.png)#IMGW(10)(sprites/078.png)#IMGW(10)(sprites/079.png)
  44643,4 #HTML(<span>26 Drax (Spells)</br>)#IMGW(10)(sprites/021.png)#IMGW(10)(sprites/021.png)#IMGW(10)(sprites/095.png)
  44647,13 #HTML(<span>27 Death</br>)#IMGW(10)(sprites/080.png)#IMGW(10)(sprites/013.png)#IMGW(10)(sprites/086.png)#IMGW(10)(sprites/086.png)#IMGW(10)(sprites/086.png)#IMGW(10)(sprites/086.png)#IMGW(10)(sprites/086.png)#IMGW(10)(sprites/087.png)#IMGW(10)(sprites/090.png)#IMGW(10)(sprites/090.png)#IMGW(10)(sprites/033.png)#IMGW(10)(sprites/089.png)
  44660,15 #HTML(<span>28 Enter the arena</br>)#IMGW(10)(sprites/091.png)#IMGW(10)(sprites/091.png)#IMGW(10)(sprites/091.png)#IMGW(10)(sprites/091.png)#IMGW(10)(sprites/092.png)#IMGW(10)(sprites/093.png)#IMGW(10)(sprites/001.png)#IMGW(10)(sprites/002.png)#IMGW(10)(sprites/003.png)#IMGW(10)(sprites/051.png)#IMGW(10)(sprites/001.png)#IMGW(10)(sprites/002.png)#IMGW(10)(sprites/003.png)#IMGW(10)(sprites/000.png)
  44675,8 #HTML(<span>29 Body dragged to the left (head off)</br>)#IMGW(10)(sprites/100.png)#IMGW(10)(sprites/100.png)#IMGW(10)(sprites/101.png)#IMGW(10)(sprites/101.png)#IMGW(10)(sprites/102.png)#IMGW(10)(sprites/102.png)#IMGW(10)(sprites/102.png)
  44683,3 #HTML(<span>30 Goblin</br>)#IMGW(10)(sprites/110.png)#IMGW(10)(sprites/111.png)
  44686,8 #HTML(<span>31 Body dragged to the right (head off)</br>)#IMGW(10)(sprites/100.png)#IMGW(10)(sprites/100.png)#IMGW(10)(sprites/103.png)#IMGW(10)(sprites/103.png)#IMGW(10)(sprites/104.png)#IMGW(10)(sprites/104.png)#IMGW(10)(sprites/104.png)
  44694,8 #HTML(<span>32 Body dragged to the left</br>)#IMGW(10)(sprites/105.png)#IMGW(10)(sprites/105.png)#IMGW(10)(sprites/106.png)#IMGW(10)(sprites/106.png)#IMGW(10)(sprites/107.png)#IMGW(10)(sprites/107.png)#IMGW(10)(sprites/107.png)
  44702,8 #HTML(<span>33 Body dragged to the right</br>)#IMGW(10)(sprites/105.png)#IMGW(10)(sprites/105.png)#IMGW(10)(sprites/108.png)#IMGW(10)(sprites/108.png)#IMGW(10)(sprites/109.png)#IMGW(10)(sprites/109.png)#IMGW(10)(sprites/109.png)
  44710,5 #HTML(<span>34 Change side</br>)#IMGW(10)(sprites/000.png)#IMGW(10)(sprites/094.png)#IMGW(10)(sprites/015.png)#IMGW(10)(sprites/016.png)
  44715,12 #HTML(<span>35 Walk Backwards/Exit the arena (Unused)</br>)#IMGW(10)(sprites/052.png)#IMGW(10)(sprites/097.png)#IMGW(10)(sprites/098.png)#IMGW(10)(sprites/099.png)#IMGW(10)(sprites/052.png)#IMGW(10)(sprites/097.png)#IMGW(10)(sprites/098.png)#IMGW(10)(sprites/099.png)#IMGW(10)(sprites/052.png)#IMGW(10)(sprites/097.png)#IMGW(10)(sprites/000.png)
  44727,11 #HTML(<span>36 Win sequence</br>)#IMGW(10)(sprites/014.png)#IMGW(10)(sprites/015.png)#IMGW(10)(sprites/016.png)#IMGW(10)(sprites/000.png)#IMGW(10)(sprites/052.png)#IMGW(10)(sprites/097.png)#IMGW(10)(sprites/027.png)#IMGW(10)(sprites/028.png)#IMGW(10)(sprites/070.png)#IMGW(10)(sprites/000.png)
  44738,2 #HTML(<span>37 Stand</br>)#IMGW(10)(sprites/000.png)
  44740,13 #HTML(<span>38 Drax (Death)</br>)#IMGW(10)(sprites/095.png)#IMGW(10)(sprites/095.png)#IMGW(10)(sprites/112.png)#IMGW(10)(sprites/112.png)#IMGW(10)(sprites/112.png)#IMGW(10)(sprites/112.png)#IMGW(10)(sprites/113.png)#IMGW(10)(sprites/113.png)#IMGW(10)(sprites/113.png)#IMGW(10)(sprites/113.png)#IMGW(10)(sprites/114.png)#IMGW(10)(sprites/115.png)
  44753,2 #HTML(<span>39 End game</br>)#IMGW(10)(sprites/047.png)
@ 44755 mov_flags_table
b 44755 Movement flags table
D 44755 One byte per movement ID (0-39). Bit flags controlling combat activation, interruptibility and draw order.
N 44755 Bit 7: combat-active (1=in-combat movement);
N 44755 Bit 6: non-interruptible (input ignored);
N 44755 Bit 0: draw on top (when overlapping).
N 44755 Bits 1-5 always 0. Read on movement change for state flags (IY+2 bit 7) and render priority.
  44755 mv0 idle:          0x00 pre-combat
  44756 mv1 walk forward:   0x00 pre-combat
  44757 mv2 walk backward:  0x00 pre-combat
  44758 mv3 sword spin:     0x81 combat-active, draw-top
  44759 mv4 jump:           0x80 combat-active
  44760 mv5 crouch slash:   0x81 combat-active, draw-top
  44761 mv6 crouch:         0x80 combat-active
  44762 mv7 headcut move:   0x81 combat-active, draw-top
  44763 mv8 death decap:    0xC1 combat-active, non-interruptible, draw-top
  44764 mv9 fwd slash:      0x81 combat-active, draw-top
  44765 mv10 guard1:        0x80 combat-active
  44766 mv11 top slash:     0x81 combat-active, draw-top
  44767 mv12 kick:          0x80 combat-active
  44768 mv13 damage recv:   0x80 combat-active
  44769 mv14 overhead slash:0x81 combat-active, draw-top
  44770 mv15 headbutt:      0x80 combat-active
  44771 mv16 guard2:        0x80 combat-active
  44772 mv17 roll forward:  0x80 combat-active
  44773 mv18 roll backward: 0x80 combat-active
  44774 mv19 victory:       0xC0 combat-active, non-interruptible
  44775 mv20 crouch stand:  0x80 combat-active
  44776 mv21 crouch strike: 0x80 combat-active
  44777 mv22 guard2b:       0x80 combat-active
  44778 mv23 crouch b:      0x80 combat-active
  44779 mv24 rollback b:    0x80 combat-active
  44780 mv25 fall:          0x80 combat-active
  44781 mv26 goblin a:      0xC0 combat-active, non-interruptible
  44782 mv27 death:         0xC1 combat-active, non-interruptible, draw-top
  44783 mv28 arena enter:   0xC0 combat-active, non-interruptible
  44784 mv29 drag L decap:  0xC1 combat-active, non-interruptible, draw-top
  44785 mv30 goblin b:      0x81 combat-active, draw-top
  44786 mv31 drag R decap:  0xC1 combat-active, non-interruptible, draw-top
  44787 mv32 drag L:        0xC1 combat-active, non-interruptible, draw-top
  44788 mv33 drag R:        0xC1 combat-active, non-interruptible, draw-top
  44789 mv34 change side:   0xC0 combat-active, non-interruptible
  44790 mv35 walk unused:   0xC0 combat-active, non-interruptible
  44791 mv36 win seq:       0xC0 combat-active, non-interruptible
  44792 mv37 stand:         0xC0 combat-active, non-interruptible
  44793 mv38 goblin c:      0xC0 combat-active, non-interruptible
  44794 mv39 endgame:       0xC0 combat-active, non-interruptible
@ 44795 label=no_fire_transition_table
w 44795 Movement transition pointer tables.
D 44795 Two adjacent 28-entry sub-tables, 2 bytes per entry (little-endian), one per movement ID 0-27. Each entry is a pointer to a 9-byte transition row in #R44907.
N 44795 Both tables are indexed by movement ID via #R38304, called from #R39211.
N 44795 Each pointed row holds one movement ID per input class (0-8) from #R47458. 255 means no transition is defined for that input class.
N 44795 Multiple movement IDs may share the same row pointer when their transition profiles are identical.
N 44795 Movement IDs 28-39 are absent: all are either non-interruptible or goblin-only and never reach #R39211 via #R39156.
N 44795 No-fire table: selected by #R39211 when Fire (IY+1 bit 4) is not pressed. Covers movement IDs 0-27.
@ 44851 label=fire_transition_table
N 44851 Fire-pressed table: selected by #R39211 when Fire (IY+1 bit 4) is pressed. Covers movement IDs 0-27.
N 44851 Non-interruptible movements (bit 6 of #R44755 set) are filtered out by #R39156 before #R39211 is called and never index this table.
b 44907 Movement transition rows.
b 44907 Movement transition table.
D 44907 12 rows x 9 bytes each. Each row is indexed by input class 0-8 via #R47458, and holds the movement ID to transition into for that input.
N 44907 A value of 255 means no transition is defined for that input combination.
N 44907 Pointed to by #R44795 no-fire and #R44851 fire pressed.
N 44907 Multiple movements may share the same row identical transition profile.
N 44907 Input class columns 0neutral, 1fwd, 2back, 3crouch, 4jump, 5crouch-fwd, 6jump-fwd, 7crouch-back, 8jump-back.
N 44907 Resolved by #R39211 once per frame per character.
@ 44907 label=st_free
  44907,9,9 STFREE Neutral->Idle, Fwd->Walk Fwd, Bwd->Walk Bwd, Crouch->Crouch B, Jump->Jump, CrFwd->Roll Fwd, JmpFwd->Guard 1, CrBwd->Roll Bwd, JmpBwd->Guard 2
@ 44916 label=st_cr_slash
  44916,9,9 STCRSLASH Neutral->Crouch Stand, Fwd->Walk Fwd, Bwd->Walk Bwd, Crouch->Crouch, Jump->Jump, CrFwd->Roll Fwd, JmpFwd->Guard 1, CrBwd->Roll Bwd, JmpBwd->Guard 2
@ 44925 label=st_crouching
  44925,9,9 STCROUCHING Neutral->Crouch Stand, Fwd->Crouch Stand, Bwd->Crouch Stand, Crouch->Crouch, Jump->Crouch Stand, CrFwd->Roll Fwd, JmpFwd->Crouch Stand, CrBwd->Roll Bwd, JmpBwd->Crouch Stand
@ 44934 label=st_free2
  44934,9,9 STFREE_B Identical data to #R44907. Neutral->Idle, Fwd->Walk Fwd, Bwd->Walk Bwd, Crouch->Crouch B, Jump->Jump, CrFwd->Roll Fwd, JmpFwd->Guard 1, CrBwd->Roll Bwd, JmpBwd->Guard 2
@ 44943 label=st_combat
  44943,9,9 STCOMBAT Neutral->Idle, Fwd->Walk Fwd, Bwd->Walk Bwd, Crouch->Crouch, Jump->Jump, CrFwd->Roll Fwd, JmpFwd->Guard 1, CrBwd->Roll Bwd, JmpBwd->Guard 2
@ 44952 label=st_guard1
  44952,9,9 STGUARD1 Neutral->Guard 2B (sticky guard), Fwd->Walk Fwd, Bwd->Walk Bwd, Crouch->Crouch B, Jump->Jump, CrFwd->Roll Fwd, JmpFwd->Guard 1, CrBwd->Roll Bwd, JmpBwd->Guard 2
@ 44961 label=st_roll_fwd
  44961,9,9 STROLLFWD All inputs->Roll Bwd except Crouch->Crouch
@ 44970 label=st_crouch_lock
  44970,9,9 STCROUCHLOCK All inputs->Crouch
@ 44979 label=st_roll_bk
  44979,9,9 STROLLBK Neutral->Idle, Fwd->Walk Fwd, Bwd->Walk Bwd, Crouch->Idle, Jump->Jump, CrFwd->Idle, JmpFwd->Guard 1, CrBwd->Roll Bwd, JmpBwd->Guard 2
@ 44988 label=st_attack
  44988,9,9 STATTACK Neutral->Idle, Fwd->Fwd Slash, Bwd->Headcut, Crouch->Crouch B, Jump->Top Slash, CrFwd->Kick, JmpFwd->Headbutt, CrBwd->Overhead, JmpBwd->Sword Spin
@ 44997 label=st_cr_attack
  44997,9,9 STCRATTACK All inputs->Crouch Stand except Crouch->Crouch Slash
@ 45006 label=st_locked_atk
  45006,9,9 STLOCKEDATK All inputs->Crouch Slash
@ 45015 label=hit_detection_table
b 45015 Hit section pointer tables. Dispatch indexed by attacker frame.
N 45015 Each sub-table is a list of 2-byte pairs (defender_frame, hit_type_index) terminated by 0xFF. hit_type_index is an index into #R46308.
N 45015 Used by #R39492 to test if IY+8 (defender frame) is vulnerable to the current attacker frame IX+8.
N 45015 Attacker frames with hit sections:
  45015,3 Frame 5 points to #R45052
  45018,3 Frame 7 points to #R45167
  45021,3 Frame 12 points to #R45284
  45024,3 Frame 23 points to #R45407
  45027,3 Frame 26 points to #R45520
  45030,3 Frame 28 points to #R45637
  45033,3 Frame 32 points to #R45740
  45036,3 Frame 34 points to #R45823
  45039,3 Frame 36 points to #R45884
  45042,3 Frame 37 points to #R45991
  45045,3 Frame 38 points to #R46096
  45048,3 Frame 67 points to #R46201
  45051,1 Terminator.
@ 45052 label=hit_frame_5
b 45052 Hit section: attacker frame 5.
D 45052 Hitbox active when attacker animation frame index = 5. Pairs: (defender_frame, hit_type index into #R46308). Terminated by 0xFF.
N 45052 Kick contact frame (initial). Most defender stances react with fall+slash+dmg at adjacent range (type 19).
N 45052 fr5 is blocked (guard2/near, type 14). fr7 is fully blocked (guard2/any, type 6).
N 45052 fr23 has dual entry: type 19 (fall, adjacent) and type 16 (guard1, d1-3 range).
N 45052 Crouching and rolling frames (fr50-fr62) react with fall+slash at near or close range (types 20-21).
N 45052 Used by #R39468.
  45052,8 fr0:fall+slash+dmg/adj  fr1:fall+slash+dmg/adj  fr2:fall+slash+dmg/adj  fr3:fall+slash+dmg/adj
  45060,8 fr4:fall+slash+dmg/adj  fr5:guard2/near  fr6:fall+slash+dmg/adj  fr7:guard2(full block)
  45068,8 fr8:fall+slash+dmg/near  fr10:fall+slash+dmg/adj  fr11:fall+slash+dmg/adj  fr13:fall+slash+dmg/adj
  45076,8 fr14:fall+slash+dmg/adj  fr15:fall+slash+dmg/close  fr16:fall+slash+dmg/adj  fr21:fall+slash+dmg/adj
  45084,8 fr22:fall+slash+dmg/adj  fr23:fall+slash+dmg/adj  fr23:guard1/d1-3  fr24:fall+slash+dmg/adj
  45092,8 fr25:fall+slash+dmg/adj  fr27:fall+slash+dmg/close  fr31:fall+slash+dmg/adj  fr34:fall+slash+dmg/close
  45100,8 fr40:fall+slash+dmg/adj  fr50:fall+slash+dmg/close  fr51:fall+slash+dmg/close  fr52:fall+slash+dmg/near
  45108,8 fr53:fall+slash+dmg/near  fr54:fall+slash+dmg/near  fr55:fall+slash+dmg/near  fr57:fall+slash+dmg/adj
  45116,8 fr58:fall+slash+dmg/adj  fr59:fall+slash+dmg/near  fr60:fall+slash+dmg/near  fr61:fall+slash+dmg/near
  45124,8 fr62:fall+slash+dmg/close  fr63:fall+slash+dmg/adj  fr64:fall+slash+dmg/adj  fr65:fall+slash+dmg/adj
  45132,8 fr66:fall+slash+dmg/adj  fr68:fall+slash+dmg/adj  fr69:fall+slash+dmg/adj  fr70:fall+slash+dmg/close
  45140,8 fr71:fall+slash+dmg/adj  fr72:fall+slash+dmg/adj  fr73:fall+slash+dmg/adj  fr74:fall+slash+dmg/close
  45148,8 fr75:fall+slash+dmg/adj  fr80:fall+slash+dmg/adj  fr81:fall+slash+dmg/adj  fr82:fall+slash+dmg/adj
  45156,8 fr83:fall+slash+dmg/adj  fr84:fall+slash+dmg/adj  fr85:fall+slash+dmg/adj  fr88:fall+slash+dmg/adj
  45164,2 fr96:fall+slash+dmg/adj
  45166,1 End-of-section terminator (0xFF).
@ 45167 label=hit_frame_7
b 45167 Hit section: attacker frame 7.
D 45167 Hitbox active when attacker animation frame index = 7. Pairs: (defender_frame, hit_type index into #R46308). Terminated by 0xFF.
N 45167 Kick contact frame (extended reach). Uses fall+slash types 22-24, functionally identical to types 19-21 from frame 5.
N 45167 fr5 blocked (guard2/near, type 14). fr7 fully blocked (guard2/any, type 6).
N 45167 fr23 dual entry: type 22 (fall/adj) and type 16 (guard1/d1-3).
N 45167 Crouching/rolling frames (fr50-fr55,fr59-fr62) react with fall at near/close range (types 23-24).
N 45167 Used by #R39468.
  45167,8 fr0:fall+slash+dmg/adj  fr1:fall+slash+dmg/adj  fr2:fall+slash+dmg/adj  fr3:fall+slash+dmg/adj
  45175,8 fr4:fall+slash+dmg/adj  fr5:guard2/near  fr6:fall+slash+dmg/adj  fr7:guard2(full block)
  45183,8 fr8:fall+slash+dmg/near  fr10:fall+slash+dmg/adj  fr11:fall+slash+dmg/adj  fr13:fall+slash+dmg/adj
  45191,8 fr14:fall+slash+dmg/adj  fr15:fall+slash+dmg/close  fr16:fall+slash+dmg/adj  fr21:fall+slash+dmg/adj
  45199,8 fr22:fall+slash+dmg/adj  fr23:fall+slash+dmg/adj  fr23:guard1/d1-3  fr24:fall+slash+dmg/adj
  45207,8 fr25:fall+slash+dmg/adj  fr26:fall+slash+dmg/close  fr27:fall+slash+dmg/close  fr31:fall+slash+dmg/adj
  45215,8 fr34:fall+slash+dmg/close  fr40:fall+slash+dmg/adj  fr50:fall+slash+dmg/close  fr51:fall+slash+dmg/close
  45223,8 fr52:fall+slash+dmg/near  fr53:fall+slash+dmg/near  fr54:fall+slash+dmg/near  fr55:fall+slash+dmg/near
  45231,8 fr57:fall+slash+dmg/adj  fr58:fall+slash+dmg/adj  fr59:fall+slash+dmg/near  fr60:fall+slash+dmg/near
  45239,8 fr61:fall+slash+dmg/near  fr62:fall+slash+dmg/close  fr63:fall+slash+dmg/adj  fr64:fall+slash+dmg/adj
  45247,8 fr65:fall+slash+dmg/adj  fr66:fall+slash+dmg/adj  fr68:fall+slash+dmg/adj  fr69:fall+slash+dmg/adj
  45255,8 fr70:fall+slash+dmg/close  fr71:fall+slash+dmg/adj  fr72:fall+slash+dmg/adj  fr73:fall+slash+dmg/adj
  45263,8 fr74:fall+slash+dmg/close  fr75:fall+slash+dmg/adj  fr80:fall+slash+dmg/close  fr81:fall+slash+dmg/adj
  45271,8 fr82:fall+slash+dmg/adj  fr83:fall+slash+dmg/adj  fr84:fall+slash+dmg/adj  fr85:fall+slash+dmg/close
  45279,4 fr88:fall+slash+dmg/close  fr96:fall+slash+dmg/close
  45283,1 End-of-section terminator (0xFF).
@ 45284 label=hit_frame_12
b 45284 Hit section: attacker frame 12.
D 45284 Hitbox active when attacker animation frame index = 12. Pairs: (defender_frame, hit_type index into #R46308). Terminated by 0xFF.
N 45284 Roll/tackle contact frame. Most stances react with stagger+slash+dmg (types 25-28, range variants).
N 45284 fr12 fully blocked (guard2/any, type 6). fr57 also fully blocked (guard2/any, type 6).
N 45284 fr40 special case: fall+kick+dmg/near (type 8) - jumping defender is knocked down harder.
N 45284 Range narrows on crouching frames (fr21-fr23: close, fr24-fr26: any range).
N 45284 Used by #R39468.
  45284,8 fr0:stagger+slash+dmg/near  fr1:stagger+slash+dmg/near  fr2:stagger+slash+dmg/near  fr3:stagger+slash+dmg/near
  45292,8 fr4:stagger+slash+dmg/near  fr5:stagger+slash+dmg/near  fr6:stagger+slash+dmg/near  fr7:stagger+slash+dmg/near
  45300,8 fr8:stagger+slash+dmg/close  fr10:stagger+slash+dmg/close  fr11:stagger+slash+dmg/close  fr12:guard2(full block)
  45308,8 fr13:stagger+slash+dmg/near  fr14:stagger+slash+dmg/near  fr15:stagger+slash+dmg/near  fr16:stagger+slash+dmg/near
  45316,8 fr21:stagger+slash+dmg/close  fr22:stagger+slash+dmg/close  fr23:stagger+slash+dmg/close  fr24:stagger+slash+dmg/any
  45324,8 fr25:stagger+slash+dmg/any  fr26:stagger+slash+dmg/any  fr27:stagger+slash+dmg/adj  fr31:stagger+slash+dmg/near
  45332,8 fr32:stagger+slash+dmg/any  fr34:stagger+slash+dmg/any  fr35:stagger+slash+dmg/close  fr40:fall+kick+dmg/near
  45340,8 fr41:stagger+slash+dmg/close  fr50:stagger+slash+dmg/near  fr51:stagger+slash+dmg/near  fr52:stagger+slash+dmg/near
  45348,8 fr53:stagger+slash+dmg/near  fr54:stagger+slash+dmg/near  fr55:stagger+slash+dmg/near  fr57:guard2(full block)
  45356,8 fr58:stagger+slash+dmg/close  fr59:stagger+slash+dmg/near  fr60:stagger+slash+dmg/close  fr61:stagger+slash+dmg/close
  45364,8 fr62:stagger+slash+dmg/close  fr63:stagger+slash+dmg/close  fr64:stagger+slash+dmg/close  fr65:stagger+slash+dmg/close
  45372,8 fr66:stagger+slash+dmg/near  fr67:stagger+slash+dmg/any  fr68:stagger+slash+dmg/any  fr69:stagger+slash+dmg/any
  45380,8 fr70:stagger+slash+dmg/adj  fr71:stagger+slash+dmg/close  fr72:stagger+slash+dmg/near  fr73:stagger+slash+dmg/near
  45388,8 fr74:stagger+slash+dmg/near  fr75:stagger+slash+dmg/close  fr80:stagger+slash+dmg/near  fr81:stagger+slash+dmg/near
  45396,8 fr82:stagger+slash+dmg/near  fr83:stagger+slash+dmg/near  fr84:stagger+slash+dmg/near  fr85:stagger+slash+dmg/near
  45404,2 fr88:stagger+slash+dmg/near
  45406,1 End-of-section terminator (0xFF).
@ 45407 label=hit_frame_23
b 45407 Hit section: attacker frame 23.
D 45407 Hitbox active when attacker animation frame index = 23. Pairs: (defender_frame, hit_type index into #R46308). Terminated by 0xFF.
N 45407 Low sword slash contact frame. Most stances react with stagger+slash+dmg at close range (types 29-31).
N 45407 fr23 and fr61 fully blocked (guard2/any, type 6). fr24 blocked at near range (guard2/near, type 14).
N 45407 fr28 deflected at mid-far range (stagger+slash/d1-3, type 15): sword slides off raised guard.
N 45407 fr4 and fr21 react at adjacent range only (types 30,30). fr8,fr10,fr27,fr31,fr34,fr35 react at near range (type 31).
N 45407 Used by #R39468.
  45407,8 fr0:stagger+slash+dmg/close  fr1:stagger+slash+dmg/close  fr2:stagger+slash+dmg/close  fr3:stagger+slash+dmg/close
  45415,8 fr4:stagger+slash+dmg/adj  fr6:stagger+slash+dmg/close  fr8:stagger+slash+dmg/near  fr10:stagger+slash+dmg/near
  45423,8 fr11:stagger+slash+dmg/close  fr13:stagger+slash+dmg/close  fr14:stagger+slash+dmg/close  fr15:stagger+slash+dmg/close
  45431,8 fr16:stagger+slash+dmg/close  fr21:stagger+slash+dmg/adj  fr22:stagger+slash+dmg/close  fr23:guard2(full block)
  45439,8 fr24:guard2/near  fr25:stagger+slash+dmg/close  fr27:stagger+slash+dmg/near  fr28:stagger+slash+dmg/d1-3
  45447,8 fr31:stagger+slash+dmg/near  fr34:stagger+slash+dmg/near  fr35:stagger+slash+dmg/near  fr41:stagger+slash+dmg/close
  45455,8 fr50:stagger+slash+dmg/close  fr51:stagger+slash+dmg/close  fr52:stagger+slash+dmg/close  fr53:stagger+slash+dmg/close
  45463,8 fr54:stagger+slash+dmg/close  fr55:stagger+slash+dmg/close  fr57:stagger+slash+dmg/close  fr58:stagger+slash+dmg/close
  45471,8 fr59:stagger+slash+dmg/close  fr60:stagger+slash+dmg/close  fr61:guard2(full block)  fr62:stagger+slash+dmg/close
  45479,8 fr63:stagger+slash+dmg/close  fr64:stagger+slash+dmg/close  fr65:stagger+slash+dmg/close  fr66:stagger+slash+dmg/close
  45487,8 fr68:stagger+slash+dmg/close  fr69:stagger+slash+dmg/close  fr70:stagger+slash+dmg/near  fr71:stagger+slash+dmg/close
  45495,8 fr72:stagger+slash+dmg/close  fr73:stagger+slash+dmg/close  fr74:stagger+slash+dmg/close  fr75:stagger+slash+dmg/close
  45503,8 fr80:stagger+slash+dmg/close  fr81:stagger+slash+dmg/close  fr82:stagger+slash+dmg/close  fr83:stagger+slash+dmg/close
  45511,8 fr84:stagger+slash+dmg/close  fr85:stagger+slash+dmg/close  fr88:stagger+slash+dmg/close  fr96:stagger+slash+dmg/close
  45519,1 End-of-section terminator (0xFF).
@ 45520 label=hit_frame_26
b 45520 Hit section: attacker frame 26.
D 45520 Hitbox active when attacker animation frame index = 26. Pairs: (defender_frame, hit_type index into #R46308). Terminated by 0xFF.
N 45520 Decapitation sword strike frame. Triggers mv8 (decap/death) on most standing and neutral defender stances (types 4-5).
N 45520 fr0-fr3 react with decap at near range (type 4). fr4-fr6 at close range (type 5).
N 45520 fr26 fully blocked (guard2/any, type 6). fr27 and fr28 have dual entries: stagger+slash at close range OR guard1 at far range.
N 45520 Upper-body frames (fr63-fr71,fr75) have dual entries: decap at close range (type 5) AND slash+dmg at far range (type 11).
N 45520 Crouching/idle frames fr0-fr9 and victory/post-combat fr96 react with stagger+slash (types 36-38).
N 45520 Used by #R39468.
  45520,8 fr0:decap/near  fr1:decap/near  fr2:decap/near  fr3:decap/near
  45528,8 fr4:decap/close  fr5:decap/close  fr6:decap/close  fr8:stagger+slash+dmg/any
  45536,8 fr9:stagger+slash+dmg/near  fr13:stagger+slash+dmg/any  fr14:stagger+slash+dmg/near  fr15:stagger+slash+dmg/any
  45544,8 fr16:stagger+slash+dmg/any  fr21:stagger+slash+dmg/any  fr22:stagger+slash+dmg/near  fr23:stagger+slash+dmg/near
  45552,8 fr24:stagger+slash+dmg/any  fr25:stagger+slash+dmg/any  fr26:guard2(full block)  fr27:stagger+slash+dmg/close
  45560,8 fr27:guard1/far  fr28:stagger+slash+dmg/close  fr28:guard1/far  fr31:stagger+slash+dmg/any
  45568,8 fr49:stagger+slash+dmg/near  fr50:decap/near  fr51:decap/near  fr52:decap/near
  45576,8 fr53:decap/near  fr54:decap/near  fr55:decap/near  fr59:stagger+slash+dmg/any
  45584,8 fr60:stagger+slash+dmg/near  fr61:stagger+slash+dmg/near  fr63:decap/close  fr63:slash+dmg/far
  45592,8 fr64:decap/close  fr64:slash+dmg/far  fr65:decap/close  fr65:slash+dmg/far
  45600,8 fr66:decap/close  fr66:slash+dmg/far  fr67:guard2(full block)  fr68:decap/close
  45608,8 fr68:slash+dmg/far  fr70:decap/close  fr71:decap/close  fr71:slash+dmg/far
  45616,8 fr72:decap/near  fr75:decap/close  fr75:slash+dmg/far  fr80:decap/close
  45624,8 fr81:decap/near  fr82:decap/near  fr83:decap/near  fr84:decap/near
  45632,4 fr85:decap/close  fr88:decap/close
  45636,1 End-of-section terminator (0xFF).
@ 45637 label=hit_frame_28
b 45637 Hit section: attacker frame 28.
D 45637 Hitbox active when attacker animation frame index = 28. Pairs: (defender_frame, hit_type index into #R46308). Terminated by 0xFF.
N 45637 Low sweep contact frame. Almost exclusively fall+tackle+dmg at adjacent range (type 10).
N 45637 fr13, fr34, fr35, fr59 react at close range instead (fall+tackle+dmg/close, type 12).
N 45637 No guard entries: this attack cannot be blocked.
N 45637 Used by #R39468.
  45637,8 fr0:fall+tackle+dmg/adj  fr1:fall+tackle+dmg/adj  fr2:fall+tackle+dmg/adj  fr3:fall+tackle+dmg/adj
  45645,8 fr4:fall+tackle+dmg/adj  fr5:fall+tackle+dmg/adj  fr6:fall+tackle+dmg/adj  fr7:fall+tackle+dmg/adj
  45653,8 fr10:fall+tackle+dmg/adj  fr11:fall+tackle+dmg/adj  fr12:fall+tackle+dmg/adj  fr13:fall+tackle+dmg/close
  45661,8 fr14:fall+tackle+dmg/adj  fr15:fall+tackle+dmg/adj  fr16:fall+tackle+dmg/adj  fr21:fall+tackle+dmg/adj
  45669,8 fr23:fall+tackle+dmg/adj  fr25:fall+tackle+dmg/adj  fr26:fall+tackle+dmg/adj  fr31:fall+tackle+dmg/adj
  45677,8 fr34:fall+tackle+dmg/close  fr35:fall+tackle+dmg/close  fr50:fall+tackle+dmg/adj  fr51:fall+tackle+dmg/adj
  45685,8 fr52:fall+tackle+dmg/adj  fr53:fall+tackle+dmg/adj  fr54:fall+tackle+dmg/adj  fr55:fall+tackle+dmg/adj
  45693,8 fr57:fall+tackle+dmg/adj  fr58:fall+tackle+dmg/adj  fr59:fall+tackle+dmg/close  fr60:fall+tackle+dmg/adj
  45701,8 fr61:fall+tackle+dmg/adj  fr62:fall+tackle+dmg/adj  fr63:fall+tackle+dmg/adj  fr64:fall+tackle+dmg/adj
  45709,8 fr65:fall+tackle+dmg/adj  fr66:fall+tackle+dmg/adj  fr68:fall+tackle+dmg/adj  fr71:fall+tackle+dmg/adj
  45717,8 fr72:fall+tackle+dmg/adj  fr74:fall+tackle+dmg/adj  fr75:fall+tackle+dmg/adj  fr80:fall+tackle+dmg/adj
  45725,8 fr81:fall+tackle+dmg/adj  fr82:fall+tackle+dmg/adj  fr83:fall+tackle+dmg/adj  fr84:fall+tackle+dmg/adj
  45733,6 fr85:fall+tackle+dmg/adj  fr88:fall+tackle+dmg/adj  fr96:fall+tackle+dmg/adj
  45739,1 End-of-section terminator (0xFF).
@ 45740 label=hit_frame_32
b 45740 Hit section: attacker frame 32.
D 45740 Hitbox active when attacker animation frame index = 32. Pairs: (defender_frame, hit_type index into #R46308). Terminated by 0xFF.
N 45740 Overhead slash contact frame. Exclusively uses types 32-35, the only hit types in #R46308 specific to this section.
N 45740 Most standing stances react with fall+slash+dmg at near range (type 32). Closer frames at close range (type 33).
N 45740 fr8 and fr15 react at any distance (type 34: fall+slash/any). fr27 and fr28 at adjacent only (type 35).
N 45740 fr32 fully blocked (guard2/any, type 6). fr21 has dual entry: fall+slash (type 33) AND guard1/far (type 13).
N 45740 fr34 deflected at mid-far range (stagger+slash/d1-3, type 15). fr75 and fr81 use guard1/d1-3 (type 16).
N 45740 Used by #R39468.
  45740,8 fr0:fall+slash+dmg/near  fr1:fall+slash+dmg/near  fr2:fall+slash+dmg/near  fr3:fall+slash+dmg/near
  45748,8 fr4:fall+slash+dmg/close  fr5:fall+slash+dmg/close  fr6:fall+slash+dmg/close  fr7:fall+slash+dmg/close
  45756,8 fr8:fall+slash+dmg/any  fr9:fall+slash+dmg/near  fr13:fall+slash+dmg/close  fr14:fall+slash+dmg/near
  45764,8 fr15:fall+slash+dmg/any  fr16:fall+slash+dmg/near  fr21:fall+slash+dmg/close  fr21:guard1/far
  45772,8 fr22:fall+slash+dmg/close  fr23:fall+slash+dmg/close  fr24:fall+slash+dmg/near  fr25:fall+slash+dmg/close
  45780,8 fr27:fall+slash+dmg/adj  fr28:fall+slash+dmg/adj  fr31:fall+slash+dmg/near  fr32:guard2(full block)
  45788,8 fr34:stagger+slash+dmg/d1-3  fr50:fall+slash+dmg/near  fr51:fall+slash+dmg/near  fr52:fall+slash+dmg/near
  45796,8 fr53:fall+slash+dmg/near  fr54:fall+slash+dmg/near  fr55:fall+slash+dmg/near  fr67:fall+slash+dmg/near
  45804,8 fr74:fall+slash+dmg/near  fr75:guard1/d1-3  fr80:fall+slash+dmg/near  fr81:guard1/d1-3
  45812,8 fr82:fall+slash+dmg/near  fr83:fall+slash+dmg/near  fr84:fall+slash+dmg/near  fr85:fall+slash+dmg/close
  45820,2 fr88:fall+slash+dmg/near
  45822,1 End-of-section terminator (0xFF).
@ 45823 label=hit_frame_34
b 45823 Hit section: attacker frame 34.
D 45823 Hitbox active when attacker animation frame index = 34. Pairs: (defender_frame, hit_type index into #R46308). Terminated by 0xFF.
N 45823 Spinning kick contact frame. Exclusively type 3 (fall+kick+dmg/adj) on all matched defender frames.
N 45823 Adjacent range only (dist0): shortest-range attack in the game.
N 45823 No guard entries: cannot be blocked. Only frames present in the table are vulnerable.
N 45823 Used by #R39468.
  45823,8 fr0:fall+kick+dmg/adj  fr1:fall+kick+dmg/adj  fr2:fall+kick+dmg/adj  fr3:fall+kick+dmg/adj
  45831,8 fr14:fall+kick+dmg/adj  fr15:fall+kick+dmg/adj  fr16:fall+kick+dmg/adj  fr21:fall+kick+dmg/adj
  45839,8 fr24:fall+kick+dmg/adj  fr25:fall+kick+dmg/adj  fr26:fall+kick+dmg/adj  fr31:fall+kick+dmg/adj
  45847,8 fr32:fall+kick+dmg/adj  fr50:fall+kick+dmg/adj  fr51:fall+kick+dmg/adj  fr52:fall+kick+dmg/adj
  45855,8 fr53:fall+kick+dmg/adj  fr54:fall+kick+dmg/adj  fr55:fall+kick+dmg/adj  fr66:fall+kick+dmg/adj
  45863,8 fr67:fall+kick+dmg/adj  fr68:fall+kick+dmg/adj  fr72:fall+kick+dmg/adj  fr73:fall+kick+dmg/adj
  45871,8 fr74:fall+kick+dmg/adj  fr80:fall+kick+dmg/adj  fr82:fall+kick+dmg/adj  fr83:fall+kick+dmg/adj
  45879,4 fr84:fall+kick+dmg/adj  fr88:fall+kick+dmg/adj
  45883,1 End-of-section terminator (0xFF).
@ 45884 label=hit_frame_36
b 45884 Hit section: attacker frame 36.
D 45884 Hitbox active when attacker animation frame index = 36. Pairs: (defender_frame, hit_type index into #R46308). Terminated by 0xFF.
N 45884 Post-decap sword continuation frame. Almost entirely type 17 (fall+tackle, NO energy damage, adjacent).
N 45884 fr28 reacts at close range instead (type 18: fall+tackle/close, no damage).
N 45884 No damage because the defender is already in the death/decap state when this frame is active.
N 45884 Used by #R39468.
  45884,8 fr0:fall+tackle/adj(no-dmg)  fr1:fall+tackle/adj(no-dmg)  fr2:fall+tackle/adj(no-dmg)  fr3:fall+tackle/adj(no-dmg)
  45892,8 fr4:fall+tackle/adj(no-dmg)  fr5:fall+tackle/adj(no-dmg)  fr6:fall+tackle/adj(no-dmg)  fr7:fall+tackle/adj(no-dmg)
  45900,8 fr10:fall+tackle/adj(no-dmg)  fr11:fall+tackle/adj(no-dmg)  fr12:fall+tackle/adj(no-dmg)  fr13:fall+tackle/adj(no-dmg)
  45908,8 fr14:fall+tackle/adj(no-dmg)  fr15:fall+tackle/adj(no-dmg)  fr16:fall+tackle/adj(no-dmg)  fr21:fall+tackle/adj(no-dmg)
  45916,8 fr22:fall+tackle/adj(no-dmg)  fr23:fall+tackle/adj(no-dmg)  fr24:fall+tackle/adj(no-dmg)  fr25:fall+tackle/adj(no-dmg)
  45924,8 fr26:fall+tackle/adj(no-dmg)  fr28:fall+tackle/close(no-dmg)  fr31:fall+tackle/adj(no-dmg)  fr32:fall+tackle/adj(no-dmg)
  45932,8 fr34:fall+tackle/adj(no-dmg)  fr50:fall+tackle/adj(no-dmg)  fr51:fall+tackle/adj(no-dmg)  fr52:fall+tackle/adj(no-dmg)
  45940,8 fr53:fall+tackle/adj(no-dmg)  fr54:fall+tackle/adj(no-dmg)  fr55:fall+tackle/adj(no-dmg)  fr57:fall+tackle/adj(no-dmg)
  45948,8 fr58:fall+tackle/adj(no-dmg)  fr59:fall+tackle/adj(no-dmg)  fr60:fall+tackle/adj(no-dmg)  fr61:fall+tackle/adj(no-dmg)
  45956,8 fr65:fall+tackle/adj(no-dmg)  fr66:fall+tackle/adj(no-dmg)  fr67:fall+tackle/adj(no-dmg)  fr68:fall+tackle/adj(no-dmg)
  45964,8 fr69:fall+tackle/adj(no-dmg)  fr72:fall+tackle/adj(no-dmg)  fr73:fall+tackle/adj(no-dmg)  fr74:fall+tackle/adj(no-dmg)
  45972,8 fr75:fall+tackle/adj(no-dmg)  fr80:fall+tackle/adj(no-dmg)  fr81:fall+tackle/adj(no-dmg)  fr82:fall+tackle/adj(no-dmg)
  45980,8 fr83:fall+tackle/adj(no-dmg)  fr84:fall+tackle/adj(no-dmg)  fr85:fall+tackle/adj(no-dmg)  fr88:fall+tackle/adj(no-dmg)
  45988,2 fr96:fall+tackle/adj(no-dmg)
  45990,1 End-of-section terminator (0xFF).
@ 45991 label=hit_frame_37
b 45991 Hit section: attacker frame 37.
D 45991 Hitbox active when attacker animation frame index = 37. Pairs: (defender_frame, hit_type index into #R46308). Terminated by 0xFF.
N 45991 Decapitation fall animation frame. Exclusively type 18 (fall+tackle, NO energy damage, close range).
N 45991 Fires on all matched defender frames with the same reaction: body is pushed to fall state, no energy cost.
N 45991 This frame is active while the decapitated body is falling. The tackle event triggers the associated sound.
N 45991 Used by #R39468.
  45991,8 fr0:fall+tackle/close(no-dmg)  fr1:fall+tackle/close(no-dmg)  fr2:fall+tackle/close(no-dmg)  fr3:fall+tackle/close(no-dmg)
  45999,8 fr4:fall+tackle/close(no-dmg)  fr5:fall+tackle/close(no-dmg)  fr6:fall+tackle/close(no-dmg)  fr7:fall+tackle/close(no-dmg)
  46007,8 fr10:fall+tackle/close(no-dmg)  fr11:fall+tackle/close(no-dmg)  fr12:fall+tackle/close(no-dmg)  fr13:fall+tackle/close(no-dmg)
  46015,8 fr14:fall+tackle/close(no-dmg)  fr15:fall+tackle/close(no-dmg)  fr16:fall+tackle/close(no-dmg)  fr21:fall+tackle/close(no-dmg)
  46023,8 fr22:fall+tackle/close(no-dmg)  fr23:fall+tackle/close(no-dmg)  fr24:fall+tackle/close(no-dmg)  fr25:fall+tackle/close(no-dmg)
  46031,8 fr26:fall+tackle/close(no-dmg)  fr28:fall+tackle/close(no-dmg)  fr31:fall+tackle/close(no-dmg)  fr32:fall+tackle/close(no-dmg)
  46039,8 fr50:fall+tackle/close(no-dmg)  fr51:fall+tackle/close(no-dmg)  fr52:fall+tackle/close(no-dmg)  fr53:fall+tackle/close(no-dmg)
  46047,8 fr54:fall+tackle/close(no-dmg)  fr55:fall+tackle/close(no-dmg)  fr57:fall+tackle/close(no-dmg)  fr58:fall+tackle/close(no-dmg)
  46055,8 fr59:fall+tackle/close(no-dmg)  fr60:fall+tackle/close(no-dmg)  fr61:fall+tackle/close(no-dmg)  fr65:fall+tackle/close(no-dmg)
  46063,8 fr66:fall+tackle/close(no-dmg)  fr67:fall+tackle/close(no-dmg)  fr68:fall+tackle/close(no-dmg)  fr69:fall+tackle/close(no-dmg)
  46071,8 fr72:fall+tackle/close(no-dmg)  fr73:fall+tackle/close(no-dmg)  fr74:fall+tackle/close(no-dmg)  fr75:fall+tackle/close(no-dmg)
  46079,8 fr80:fall+tackle/close(no-dmg)  fr81:fall+tackle/close(no-dmg)  fr82:fall+tackle/close(no-dmg)  fr83:fall+tackle/close(no-dmg)
  46087,8 fr84:fall+tackle/close(no-dmg)  fr85:fall+tackle/close(no-dmg)  fr88:fall+tackle/close(no-dmg)  fr96:fall+tackle/close(no-dmg)
  46095,1 End-of-section terminator (0xFF).
@ 46096 label=hit_frame_38
b 46096 Hit section: attacker frame 38.
D 46096 Hitbox active when attacker animation frame index = 38. Pairs: (defender_frame, hit_type index into #R46308). Terminated by 0xFF.
N 46096 Upward headcut sword frame. Exclusively type 20 (fall+slash+dmg/near) on all matched defender frames.
N 46096 Near range (dist0-2) uniform across all entries. No guard frames and no range exceptions.
N 46096 Used by #R39468.
  46096,8 fr0:fall+slash+dmg/near  fr1:fall+slash+dmg/near  fr2:fall+slash+dmg/near  fr3:fall+slash+dmg/near
  46104,8 fr4:fall+slash+dmg/near  fr5:fall+slash+dmg/near  fr6:fall+slash+dmg/near  fr7:fall+slash+dmg/near
  46112,8 fr8:fall+slash+dmg/near  fr10:fall+slash+dmg/near  fr11:fall+slash+dmg/near  fr13:fall+slash+dmg/near
  46120,8 fr14:fall+slash+dmg/near  fr15:fall+slash+dmg/near  fr16:fall+slash+dmg/near  fr21:fall+slash+dmg/near
  46128,8 fr22:fall+slash+dmg/near  fr23:fall+slash+dmg/near  fr24:fall+slash+dmg/near  fr25:fall+slash+dmg/near
  46136,8 fr26:fall+slash+dmg/near  fr28:fall+slash+dmg/near  fr31:fall+slash+dmg/near  fr32:fall+slash+dmg/near
  46144,8 fr50:fall+slash+dmg/near  fr51:fall+slash+dmg/near  fr52:fall+slash+dmg/near  fr53:fall+slash+dmg/near
  46152,8 fr54:fall+slash+dmg/near  fr55:fall+slash+dmg/near  fr57:fall+slash+dmg/near  fr58:fall+slash+dmg/near
  46160,8 fr59:fall+slash+dmg/near  fr60:fall+slash+dmg/near  fr61:fall+slash+dmg/near  fr65:fall+slash+dmg/near
  46168,8 fr66:fall+slash+dmg/near  fr67:fall+slash+dmg/near  fr68:fall+slash+dmg/near  fr69:fall+slash+dmg/near
  46176,8 fr72:fall+slash+dmg/near  fr73:fall+slash+dmg/near  fr74:fall+slash+dmg/near  fr75:fall+slash+dmg/near
  46184,8 fr80:fall+slash+dmg/near  fr81:fall+slash+dmg/near  fr82:fall+slash+dmg/near  fr83:fall+slash+dmg/near
  46192,8 fr84:fall+slash+dmg/near  fr85:fall+slash+dmg/near  fr88:fall+slash+dmg/near  fr96:fall+slash+dmg/near
  46200,1 End-of-section terminator (0xFF).
@ 46201 label=hit_frame_67
b 46201 Hit section: attacker frame 67.
D 46201 Hitbox active when attacker animation frame index = 67. Pairs: (defender_frame, hit_type index into #R46308). Terminated by 0xFF.
N 46201 Goblin stomp/grab frame. Exclusively type 7 (fall+kick+dmg/any) on all matched defender frames.
N 46201 Any range (dist0-3): widest distance coverage of all hit sections.
N 46201 Used by #R39468.
  46201,8 fr0:fall+kick+dmg/any  fr1:fall+kick+dmg/any  fr2:fall+kick+dmg/any  fr3:fall+kick+dmg/any
  46209,8 fr4:fall+kick+dmg/any  fr5:fall+kick+dmg/any  fr6:fall+kick+dmg/any  fr7:fall+kick+dmg/any
  46217,8 fr10:fall+kick+dmg/any  fr11:fall+kick+dmg/any  fr13:fall+kick+dmg/any  fr14:fall+kick+dmg/any
  46225,8 fr15:fall+kick+dmg/any  fr16:fall+kick+dmg/any  fr21:fall+kick+dmg/any  fr22:fall+kick+dmg/any
  46233,8 fr23:fall+kick+dmg/any  fr24:fall+kick+dmg/any  fr25:fall+kick+dmg/any  fr26:fall+kick+dmg/any
  46241,8 fr27:fall+kick+dmg/any  fr28:fall+kick+dmg/any  fr31:fall+kick+dmg/any  fr32:fall+kick+dmg/any
  46249,8 fr50:fall+kick+dmg/any  fr51:fall+kick+dmg/any  fr52:fall+kick+dmg/any  fr53:fall+kick+dmg/any
  46257,8 fr54:fall+kick+dmg/any  fr55:fall+kick+dmg/any  fr57:fall+kick+dmg/any  fr58:fall+kick+dmg/any
  46265,8 fr59:fall+kick+dmg/any  fr60:fall+kick+dmg/any  fr61:fall+kick+dmg/any  fr65:fall+kick+dmg/any
  46273,8 fr66:fall+kick+dmg/any  fr67:fall+kick+dmg/any  fr68:fall+kick+dmg/any  fr69:fall+kick+dmg/any
  46281,8 fr72:fall+kick+dmg/any  fr73:fall+kick+dmg/any  fr74:fall+kick+dmg/any  fr75:fall+kick+dmg/any
  46289,8 fr80:fall+kick+dmg/any  fr81:fall+kick+dmg/any  fr82:fall+kick+dmg/any  fr83:fall+kick+dmg/any
  46297,8 fr84:fall+kick+dmg/any  fr85:fall+kick+dmg/any  fr88:fall+kick+dmg/any  fr96:fall+kick+dmg/any
  46305,1 End-of-section terminator (0xFF).
@ 46308 label=hit_type_table
b 46308 Hit type parameter table.
D 46308 Indexed by hit type index from #R45015. Each entry is 3 bytes: range byte, reaction movement ID, and event/knockback byte.
D 46308 Byte 0: four 2-bit distance thresholds packed into one byte (bits 1-0 = field 0, bits 3-2 = field 1, bits 5-4 = field 2, bits 7-6 = field 3). #R39518 extracts each field and compares it against the fighter tile distance in #R46834. Any match validates the hit; all four misses discard it silently.
D 46308 Byte 1: movement ID applied to the defender via #R39194 on a valid hit. 255 = no reaction.
D 46308 Byte 2 high nibble: combat event type written to #R46803 (0 = no event). Low nibble: knockback type passed to #R39367 (0 = no energy decrement).
N 46308 Types 0-3: stagger/fall, kick/slash, with energy damage.
N 46308 Types 4-5: mv8 decapitation, headcut event, no energy damage.
N 46308 Type  6: no reaction, guard2 event, no energy damage (full block).
N 46308 Types 7-12: fall, kick/tackle, with or without energy damage.
N 46308 Types 13-16: no reaction or stagger, guard1/guard2/slash, with or without damage.
N 46308 Types 17-18: fall, tackle event, NO energy damage (roll forward hits).
N 46308 Types 19-24: fall, slash event, with energy damage.
N 46308 Types 25-31: stagger, slash event, with energy damage (range variants).
N 46308 Types 32-35: fall, slash event, with energy damage (overhead slash exclusive).
N 46308 Types 36-38: stagger, slash event, with energy damage (range variants, top/headcut area).
N 46308 Types 32-35 are used exclusively by the overhead slash attacker frame (R45740): the only move that produces mv25 fall with slash event instead of kick event.
  46308,3 Type 0: dist 0-3, mv13(stagger), slash energy-dmg
  46311,3 Type 1: dist 0-2, mv13(stagger), slash energy-dmg
  46314,3 Type 2: dist 0-1, mv13(stagger), slash energy-dmg
  46317,3 Type 3: dist 0, mv25(fall), kick energy-dmg
  46320,3 Type 4: dist 0-2, mv8(decap), headcut no-dmg
  46323,3 Type 5: dist 0-1, mv8(decap), headcut no-dmg
  46326,3 Type 6: dist 0-3, none(255), guard2 no-dmg
  46329,3 Type 7: dist 0-3, mv25(fall), kick energy-dmg
  46332,3 Type 8: dist 0-2, mv25(fall), kick energy-dmg
  46335,3 Type 9: dist 0-1, mv25(fall), kick energy-dmg
  46338,3 Type 10: dist 0, mv25(fall), tackle energy-dmg
  46341,3 Type 11: dist 2-3, none(255), slash energy-dmg
  46344,3 Type 12: dist 0-1, mv25(fall), tackle energy-dmg
  46347,3 Type 13: dist 2-3, none(255), guard1 no-dmg
  46350,3 Type 14: dist 0-2, none(255), guard2 no-dmg
  46353,3 Type 15: dist 1-3, mv13(stagger), slash energy-dmg
  46356,3 Type 16: dist 1-3, none(255), guard1 no-dmg
  46359,3 Type 17: dist 0, mv25(fall), tackle no-dmg
  46362,3 Type 18: dist 0-1, mv25(fall), tackle no-dmg
  46365,3 Type 19: dist 0, mv25(fall), slash energy-dmg
  46368,3 Type 20: dist 0-2, mv25(fall), slash energy-dmg
  46371,3 Type 21: dist 0-1, mv25(fall), slash energy-dmg
  46374,3 Type 22: dist 0, mv25(fall), slash energy-dmg
  46377,3 Type 23: dist 0-2, mv25(fall), slash energy-dmg
  46380,3 Type 24: dist 0-1, mv25(fall), slash energy-dmg
  46383,3 Type 25: dist 0-2, mv13(stagger), slash energy-dmg
  46386,3 Type 26: dist 0-1, mv13(stagger), slash energy-dmg
  46389,3 Type 27: dist 0-3, mv13(stagger), slash energy-dmg
  46392,3 Type 28: dist 0, mv13(stagger), slash energy-dmg
  46395,3 Type 29: dist 0-1, mv13(stagger), slash energy-dmg
  46398,3 Type 30: dist 0, mv13(stagger), slash energy-dmg
  46401,3 Type 31: dist 0-2, mv13(stagger), slash energy-dmg
  46404,3 Type 32: dist 0-2, mv25(fall), slash energy-dmg
  46407,3 Type 33: dist 0-1, mv25(fall), slash energy-dmg
  46410,3 Type 34: dist 0-3, mv25(fall), slash energy-dmg
  46413,3 Type 35: dist 0, mv25(fall), slash energy-dmg
  46416,3 Type 36: dist 0-3, mv13(stagger), slash energy-dmg
  46419,3 Type 37: dist 0-2, mv13(stagger), slash energy-dmg
  46422,3 Type 38: dist 0-1, mv13(stagger), slash energy-dmg
g 46425 Player 1 state block.
D 46425 9-byte structure used by all combat routines.
N 46425 Written by #R36822 (init), #R36838 (movement change), #R39367 (energy), #R35713 (input).
N 46425 IY+0 controller type: 1=P1 keyboard #R47433, 2=P2 keyboard #R47440 (Sinclair 2 defaults), 3=Sinclair2 fixed #R47445 (keys 6-0), 4=Sinclair1 fixed #R47450 (keys 1-5), 5=Kempston port 31. Bit 7 set=CPU-controlled.
N 46425 Character type is implicitly IYl (low byte of IY base address: 89=P1, 98=P2, 107=goblin).
@ 46425 label=p1_controller_type
  46425,1 IY+0: Controller type (0=inactive, 1-5=human, bit 7 set=CPU).
@ 46426 label=p1_input_state
  46426,1 IY+1: Input state bitmask (bits 0-4: Right, Left, Down, Up, Fire).
@ 46427 label=p1_mirror_flags
  46427,1 IY+2: Mirror and priority flags (bit 0=facing left, bit 7=draw priority).
@ 46428 label=p1_x_pos
  46428,1 IY+3: X tile position (0-29).
@ 46429 label=p1_frame_ptr
W 46429,2 IY+4+5: Frame data pointer.
@ 46431 label=p1_movement_id
  46431,1 IY+6: Current movement ID (1-37).
@ 46432 label=p1_energy_byte
  46432,1 IY+7: Energy nibbles (bits 0-3=current energy 0-13, bits 4-7=display update flag).
@ 46433 label=p1_frame_index
  46433,1 IY+8: Current frame index byte (read from frame data pointer).
g 46434 Player 2 state block.
D 46434 9-byte structure used by all combat routines.
N 46434 Written by #R36822 (init), #R36838 (movement change), #R39367 (energy), #R35713 (input).
N 46434 IY+0 controller type: 1=P1 keyboard #R47433, 2=P2 keyboard #R47440 (Sinclair 2 defaults), 3=Sinclair2 fixed #R47445 (keys 6-0), 4=Sinclair1 fixed #R47450 (keys 1-5), 5=Kempston port 31. Bit 7 set=CPU-controlled.
N 46434 Character type is implicitly IYl (low byte of IY base address: 89=P1, 98=P2, 107=goblin).
@ 46434 label=p2_controller_type
  46434,1 IY+0: Controller type (0=inactive, 1-5=human, bit 7 set=CPU).
@ 46435 label=p2_input_state
  46435,1 IY+1: Input state bitmask (bits 0-4: Right, Left, Down, Up, Fire).
@ 46436 label=p2_mirror_flags
  46436,1 IY+2: Mirror and priority flags (bit 0=facing left, bit 7=draw priority).
@ 46437 label=p2_x_pos
  46437,1 IY+3: X tile position (0-29).
@ 46438 label=p2_frame_ptr
W 46438,2 IY+4+5: Frame data pointer.
@ 46440 label=p2_movement_id
  46440,1 IY+6: Current movement ID (1-37).
@ 46441 label=p2_energy_byte
  46441,1 IY+7: Energy nibbles (bits 0-3=current energy 0-13, bits 4-7=display update flag).
@ 46442 label=p2_frame_index
  46442,1 IY+8: Current frame index byte (read from frame data pointer).
@ 46443 label=goblin_state_block
g 46443 Goblin state block.
N 46443 IY points here in #R37701. #R36838 writes IY+2, IY+4, IY+5, IY+6, IY+8.
N 46443 IY+0: 0=goblin inactive (cleared by #R39617 when X=29), 255=active (set by #R37701).
  46443,1 IY+0: Active flag (0=inactive, 255=active).
  46444,1 IY+1: Input state byte. Unused for goblin.
@ 46445 label=goblin_mirror_flags
  46445,1 IY+2: Mirror and control flags (bit 0=facing direction, bit 7=non-controllable).
@ 46446 label=goblin_x_pos
  46446,1 IY+3: X tile position. Also used as frame counter by #R39617.
@ 46447 label=goblin_frame_ptr
W 46447,2 IY+4+5: Frame data pointer.
@ 46449 label=goblin_movement_id
  46449,1 IY+6: Current movement ID (30=goblin entrance).
@ 46450 label=goblin_energy_byte
  46450,1 IY+7: Energy byte. Unused for goblin.
@ 46451 label=goblin_frame_index
  46451,1 IY+8: Current frame index byte.
@ 46452 label=saved_sp
g 46452 Saved stack pointer.
D 46452 2-byte LE copy of SP redirecting SP to the VRAM address table #R23552.
N 46452 Restored at the end of #R38412 via LD SP,46452.
  46452,2 Saved SP. Written and restored exclusively by #R38412.
@ 46454 label=active_bg  
g 46454 Active Background index.
D 46454 0=Background 1 (graphics #R26752, attrs #R46614), 1=Background 2 (graphics #R30112, attrs #R46467).
N 46454 Reset to 0 by #R35381 at the start of each new round.
N 46454 Toggled via XOR 1 by #R35458 when the round timer expires.
N 46454 Read exclusively by #R35458 to select the active Background pointers.
  46454,1 Active Background index. 0=Background 1, 1=Background 2.
N 46455 Used by #R35458 to toggle stages and resolve the active graphics pointer #R46459, read indirectly by #R35381 on game reset and by #R38547 when blitting the active stage background.
@ 46455 label=bg_bitmap_ptr
b 46455 Background Bitmap RLE pointers table.
W 46455,2 Background 1 Bitmap pointer to #R26752
W 46457,2 Background 2 Bitmap pointer to #R30112
@ 46459 label=active_bg_bitmap_ptr
W 46459,2 Active background 1 Bitmap pointer to #R26752
@ 46461 label=active_bg_attr_ptr
W 46461,2 Active background 1 Attributes pointer to #R46614
@ 46463 label=bg_attr_ptr
W 46463,2 Background 1 Attributes pointer to #R46614
W 46465,2 Background 2 Attributes pointer to #R46467
b 46467 Background Attributes.
@ 46467 label=bg_2_attr_data
N 46467 RLE compressed attributes using pairs of [count, attribute] values. (28x11 chars).
N 46467 Example: [1,82] means "1 tile with attribute 82".
N 46467 Each row ends with 255 marker.
N 46467 Format per row: [count, attr, count, attr, ..., 255]
N 46467 Graphics bytes are in #R26752 for Stage 1 and #R30112 for Stage 2.
  46467 #HTML(<span>Background 2 Attributes.</span></br>)#IMG(bg/bg1_attrs.png)
@ 46614 label=bg_1_attr_data
  46614 #HTML(<span>Background 1 Attributes.</span></br>)#IMG(bg/bg1_attrs.png)
@ 46747 label=hit_indicator_frame_table
b 46747 Hit indicator frame table.
N 46747 3-byte entries: frame ID, X adjustment, row offset (scanlines/8 *32).
N 46747 Searched by #R38325: if attacker frame IY+8 matches ID, draws ASCII 61 (hit indicator glyph, UDG index 13). via #R35996 near attacker column.
N 46747 Terminator 128 skips indicator. Called before score table #R46775 by #R35531.
  46747,3 Frame 5: X adjust +5, row offset 7
  46750,3 Frame 7: X adjust +6, row offset 7
  46753,3 Frame 12: X adjust +6, row offset 9
  46759,3 Frame 26: X adjust +7, row offset 5
  46762,3 Frame 28: X adjust +5, row offset 7
  46765,3 Frame 32: X adjust +7, row offset 4
  46768,3 Frame 34: X adjust +5, row offset 4
  46771,3 Frame 67: X adjust +7, row offset 5
  46774,1 Terminator skips drawing.
  46756,3 Frame 23: X adjust +6, row offset 7
@ 46775 label=score_award_frame_table
b 46775 Score award frame table.
D 46775 3-byte entries: (attacker_frame_id, score_low, score_high).
D 46775 If IY+8 matches attacker_frame_id, adds DE score delta to #R47429 (P1) or R47431 (P2), depending on IYl: 89=P1 barbarian, 98=P2 barbarian.
D 46775 Searched by #R35531 via #R38325. Terminated by sentinel 0x80.
N 46775 Called after the hit indicator phase in #R35531. Same search pattern as #R46747.
  46775,3 Frame 5 (#R43807), 50 points
  46778,3 Frame 7 (#R43807), 50 points
  46781,3 Frame 12 (#R43857), 50 points
  46784,3 Frame 23 (#R43928), 200 points
  46787,3 Frame 26 (#R43949), 500 points
  46790,3 Frame 28 (#R43964), 100 points
  46793,3 Frame 32 (#R43992), 100 points
  46796,3 Frame 34 (#R44004), 200 points
  46799,3 Frame 67 (#R43949), 200 points
  46802,1 Terminator.
@ 46803 label=pending_sound_index
g 46803 Pending combat sound index.
D 46803 Stores the index of the combat sound triggered this frame.
N 46803 Values: 1=#R39932, 2=#R39926, 3=#R39938, 4=#R39944, 5=#R39950, 6=#R39956.
N 46803 Written by #R39518 (bits 4-7 of hit byte 2, shifted right 4 via RRCA x4).
N 46803 Read and cleared by #R35531 (hit processor and sound dispatcher).
N 46803 When 0, #R35531 returns immediately without any processing. Index 5-6 skip the visual indicator and score logic, going directly to the sound dispatch table.
  46803,1 Combat sound index. 0=none, 1=Kick, 2=Tackle, 3=Slash, 4=Head Cut, 5-6=Guard.
@ 46804 label=attacker_block_ptr
g 46804 Attacker state block pointer.
D 46804 2-byte pointer to the attacker's character state block.
N 46804 Written by #R39518 with IX (attacker block: #R46425=P1, #R46434=P2).
N 46804 Read by #R35531, which loads IY from this address to identify which character delivered the hit, used for score attribution (IYl 89 vs 98). Together with #R46803, forms the combat event descriptor set by #R39518.
W 46804,2 Pointer to attacker state block. #R46425=P1 attacker, #R46434=P2 attacker.
@ 46806 label=hit_indicator_screen_addr
g 46806 Hit indicator screen address.
D 46806 2-byte VRAM address where the hit indicator glyph will be drawn.
N 46806 Computed by #R35531 from the attacker X tile position (IY+3), row offset, and mirror flag (IY+2 bit 0), then stored here before calling #R35996.
N 46806 Written and consumed within the same call to #R35531.
N 46806 Skipped if the computed column falls on boundary tiles (0, 1, 30, 31).
 46806,2 Calculated VRAM address for hit indicator glyph. Written by #R35531.
g 46808 Timer Flag.
@ 46808 label=timer_flag
D 46808 In this address the time is stored (in 2 players mode). If the value is 255 we are in 1 Player or Demo mode (and we got infinite time).
  46808,1 Timer flag.
g 46809 Flying head state block.
D 46809 Initialised by #R37944 on decapitation (#R46809 + #R46810 + #R46811 + #R46813 + #R46815).
N 46809 8-byte block operated via IX by #R37997 each frame.
N 46809 Re-initialised by #R37964 via #R37950 (new tile source + trajectory, direction reset to 0, state=1).
N 46809 A parallel block at #R46817 reuses this same layout for the P2 overlay renderer, allowing #R38103 and #R38158 to serve both without modification.
N 46809 #TABLE(data) { Offset | Address | Field } { IX+0 | #R46809 | Direction: 0=right, 1=left } { IX+1 | #R46810 | State: 0=inactive, 1=bouncing, 255=landed } { IX+2,3 | #R46811 | Tile animation sequence pointer (#R46835 P1/#R46853 P2) } { IX+4,5 | #R46813 | Movement control pointer (#R47017 normal/#R47085 after goblin kick) } { IX+6,7 | #R46815 | Current framebuffer address } TABLE#
@ 46809 label=head_state
  46809,1 IX+0: Direction flag. 0=right, 1=left. Set by #R37944, reset to 0 by #R37964.
@ 46810 label=head_state_flag
  46810,1 IX+1: State. 0=inactive (#R38186), 1=bouncing (#R37944 / #R37950), 255=landed (#R38180).
@ 46811 label=head_frame_seq
W 46811,2 IX+2,3: Tile frame sequence pointer. Advanced +1/frame by #R37997 to read the next tile index byte. #R46835 player head, #R46853 P2 head (normal decap); after goblin kick. Byte 255 triggers landed state via #R38180.
@ 46813 label=head_traj_ptr
W 46813,2 IX+4,5: Trajectory data pointer. 2-byte pairs (control_byte, magnitude); advanced +2/frame by #R37997. #R47017 normal decapitation, #R47085 after goblin kick.
@ 46815 label=head_screen_addr
W 46815 IX+6,7: Current framebuffer address. Updated every frame by #R37997, read by #R38137 for shadow placement.
@ 46817 label=p2_overlay_block_state  
g 46817 Player 2 overlay state block.
D 46817 9-byte block reusing the same layout as the head state block at #R46809, allowing #R38103 and #R38158 to serve both renderers without modification.
N 46817 Written each frame by #R38220 before jumping to #R38103.
  46817,1  IX+0: mirror flag (0=facing right, 1=facing left). Copied from #R46436 bit 0.
  46818,1  IX+1: not written by #R38220; not read.
W 46819,2  IX+2,3: pointer to current tile index entry = #R47223 + P2 frame index.
W 46821,2  IX+4,5: not used by P2 overlay path. Retains head state values.
W 46823,2  IX+6,7: framebuffer destination address. Computed by #R38220.
u 46825 Unused buffer.
@ 46825 label=unused_buffer
N 46825 Unused buffer. 46825 is written to 0 by #R37866 (redundant, already 0). 46826 retains its init value of 6 and is never read or written at runtime. Likely a remnant of a 9-byte P2 overlay state block before the IX8 field was removed.
@ 46827 label=energy_bar_attrs
b 46827 Energy bar UDG indices.
D 46827 7-entry table of packed UDG indices for 3-segment energy bar (0-6 segments).
N 46827 Indexed by current energy / 2 (IY+7 >> 1). Each byte packs 3 x 2-bit segment types (0=empty, 1=low, 2=med, 3=full).
N 46827 Index = energy >> 1 (IY+7). Used by #R39391 to select UDGs for HUD blit at VRAM 16416(P1)/16445(P2).
  46827 0 segs: all empty
  46828 1 seg:  medium circle, empty, empty
  46829 2 segs: full circle, empty, empty
  46830 3 segs: full circle, medium circle, empty
  46831 4 segs: full circle, full circle, empty
  46832 5 segs: full circle, full circle, medium circle
  46833 6 segs: full circle, full circle, full circle
@ 46834 label=fighter_distance
g 46834 Horizontal distance between fighters.
D 46834 Computed by #R39856 as absolute difference of tile X positions.
N 46834 Read by #R39518 to validate hit range conditions.
@ 46835 label=p1_head_tile_seq
b 46835 P1 head tile sequence.
D 46835 17-entry tile index sequence for the severed P1 head animation.
D 46835 Consumed by #R37997 one index per frame via the tile sequence pointer at IX+2,3 (#R46811). Each byte is a tile index resolved against sprite bank base #R40192 by #R38103.
D 46835 Terminated by sentinel 255 at #R46852, which triggers #R38180 to mark the head as landed (#R46810 = 255).
N 46835 Tile base: #R40192. 17 active tile IDs + 1 sentinel = 18 bytes total.
  46835,4 Tile IDs: 1,2,4,5 (cycle 1).
  46839,4 Tile IDs: 1,2,4,5 (cycle 2).
  46843,4 Tile IDs: 1,2,4,5 (cycle 3).
  46847,5 Tile IDs: 1,1,2,2,2 (final phase).
  46852,1 Sentinel 255: end of sequence, triggers #R38180.
@ 46853 label=p2_head_tile_seq
b 46853 P2 head tile sequence.
D 46853 17-entry tile index sequence for the severed P2 head animation.
D 46853 Structure identical to #R46835. Tile ID 18 is absent (sequence jumps directly 17->19). Each byte resolved against sprite bank base 40192 by #R38103.
D 46853 Terminated by sentinel 255 at #R46870, triggering #R38180 (#R46810 = 255).
N 46853 Tile base: #R40192. 17 active tile IDs + 1 sentinel = 18 bytes total.
  46853,4 Tile IDs: 16,17,19,20 (cycle 1, tile ID 18 absent).
  46857,4 Tile IDs: 16,17,19,20 (cycle 2).
  46861,4 Tile IDs: 16,17,19,20 (cycle 3).
  46865,5 Tile IDs: 16,16,17,17,17 (final phase).
  46870,1 Sentinel 255: end of sequence, triggers #R38180.
u 46871 Final boss spell tile sequence (unused).
D 46871 Tile index sequence alternating IDs 18 and 22, resolved against sprite bank base #R40192. Belongs to the final boss projectile spell attack, present in another version of the game. The final boss does not appear in this build and this sequence is not referenced by any runtime code.
N 46871 Dead data retained from another game version. Format identical to #R46835 and #R46853 (tile IDs + sentinel 255).
  46871,15 Tile IDs: 18,22 alternating (spell projectile animation frames).
  46886,1 Sentinel 255: end of sequence.
u 46887
@ 46889 label=ai_level_0
b 46889 AI difficulty entry table / Head trajectory data
D 46889 32-byte tables indexed by R AND 31 (0-31). AI decision weights for levels 0-5 (passive to aggressive). Used by #R35765 to bias movement choices..
B 46889,32,8 fight 0 (most passive, avg sub_index 5.75). Range: 2-7. No sub_index 0 or 1 possible at any random value; the AI always picks at least sub_index 2, guaranteeing a moderate-to-heavy movement block.
@ 46921 label=ai_level_1
N 46921 AI Level 1
B 46921,32,8 fight 1 (avg sub_index 5.38). Range: 1-7.
@ 46953 label=ai_level_2
N 46953 AI Level 2
B 46953,32,8 fight 2 (avg sub_index 4.38). Range: 0-7.
@ 46985 label=ai_level_4
N 46985 AI Level 4
B 46985,32,8 fight 4 (avg sub_index 3.12). Range: 0-7.
@ 47017 label=normal_traj_data
N 47017 Normal trajectory data.
N 47017 Table of 2-byte step pairs (control, magnitude) for the severed head after a normal decapitation. One pair is consumed per frame by #R37997 via the trajectory pointer at IX4,5 (#R46813).
N 47017 Control byte: bit 0 set (value 1) moves the head up by magnitude scanlines; bit 1 set (value 2) moves it down; value 0 holds position. Magnitude is the vertical delta in scanlines applied that frame.
N 47017 The head rises 9 scanlines over 2 frames (6+3), holds one frame at the peak, then falls with increasing speed (2, 4, 6, 8, 10, 12, 14 scanlines per frame), bounces slightly upward (4+2), and settles to the ground.
N 47017 Loaded into IX4,5 (#R46813) by #R37944 at the moment of decapitation. 18 step pairs, 36 bytes total.
  47017,4 Rise: up 6, up 3 scanlines.
  47021,2 Hold: peak position.
  47023,8 Fall: down 2, 4, 6, 8 scanlines (accelerating).
  47031,4 Fall: down 10, 12 scanlines.
  47035,4 Fall: down 14; bounce: up 4 scanlines.
  47039,4 Bounce: up 2; hold.
  47043,4 Settle: down 2, 4 scanlines.
  47047,6 Landed: hold.
@ 47053 label=ai_level_5
N 47053 AI Level 5
B 47053,32,8 fight 5 (avg sub_index 2.62). Range: 0-7.
@ 47085 label=kicked_traj_data
N 47085 Goblin-kick head trajectory.
N 47085 Table of 2-byte step pairs (control, magnitude) for the severed head after the goblin kick (#R37964). Replaces the active trajectory pointer at IX4,5 (#R46813) via #R37950.
N 47085 Same format as #R47017: control byte 1 moves up, 2 moves down, 0 holds. Magnitude is the vertical delta in scanlines applied that frame.
N 47085 The head rises 9 scanlines over 2 frames (6+3), holds one frame, falls 9 scanlines (6+3), holds, bounces up 3 scanlines, holds, settles down 3 scanlines, then rests.
N 47085 Loaded into IX4,5 (#R46813) by #R37964 via #R37950 after the goblin kick. 17 step pairs, 34 bytes total.
  47085,4 Rise: up 6, up 3 scanlines.
  47089,2 Hold.
  47091,4 Fall: down 6, down 3 scanlines.
  47095,2 Hold.
  47097,4 Bounce: up 3; hold.
  47101,4 Settle: down 3; hold.
  47105,14 Landed: hold.
@ 47119 label=ai_level_6
N 47119 AI Level 6
B 47119,32,8 fight 6 (avg sub_index 1.59). Range: 0-6. Only entry where max sub_index never reaches 7; the AI cannot select the most aggressive movement block even at maximum random variance.
N 47017 Spell trajectory data.
N 47151 Trajectory-format data fragment. Four 2-byte pairs (control=2, magnitude): (2,8),(2,8),(2,10),(2,10). Control byte 2 with moderate-to-high constant magnitudes matches a stabilised falling arc phase. No confirmed code reference loads this address as a trajectory pointer. Likely dead data, possibly a remnant of the drax spell movement.
  47151 Trajectory-format data fragment.
@ 47159 label=ai_level_7
N 47159 AI Level 7
B 47159,32,8 fight 7 (most aggressive, avg sub_index ~1.09). Range: 0-5. Even at maximum difficulty the AI cannot lock to sub_index 0; some passive outcomes (sub_index 4-5) remain possible at the high end. Occupies 47159-47190. Bytes 47181-47190 are positions 22-31 of this table, NOT the start of fight 3.
@ 47191 label=ai_level_3
N 47191 AI Level 3
N 47191 Located at 47191, after fights 4, 5, 6, 7 in memory despite being fight 3 in the logical sequence (pointer table at #R47559 resolves order).
N 47191 Fits correctly between F2 (avg 4.38) and F4 (avg 3.12),
N 47191 confirming the monotonically increasing difficulty curve.
  47191,32,8 fight 3 (avg sub_index 3.57). Range: 0-7.
@ 47223 label=p2_overlay_tile_table
b 47223 Per-frame overlay tile index table.
D 47223 One byte per P2 animation frame. Each byte is an index into the P2 sprite bank at #R40192 (tiles 0-52), selecting the overlay tile to draw over the P2 at that frame. Value 255 means no overlay.
D 47223 Indexed by P2 frame index #R46442. Read by #R38220 via ADD HL,DE.

@ 47329 label=p2_overlay_pos_table 
b 47329 Per-frame overlay position table.
D 47329 One byte per P2 animation frame. Encodes the framebuffer offset for the overlay relative to the P2's tile:
D 47329 bits 0-5 = scanline offset downward from framebuffer row 94 (0-63 lines).
D 47329 bits 6-7 = fine column offset rightward from P2 X tile (0-3 tiles).
D 47329 When P2 is mirrored (#R46436 bit 0 set), #R38220 inverts the column offset as 6-L before adding to the X tile.
D 47329 Indexed by P2 frame index #R46442. Read by #R38220 via #R38318.
@ 47429 label=p1_score
g 47429 Player 1 score buffer.
D 47429 In this address the player's 1 score is stored.
N 47429 Written by #R35531.
  47429,2
@ 47431 label=p2_score
g 47431 Player 2 score buffer.
D 47431 In this address the player's 2 score is stored.
N 47431 Written by #R35531.
  47431,2
@ 47433 label=p1_keyboard_table
g 47433 P1 keyboard scancode table.
D 47433 5-byte table: Fire, Up, Down, Left, Right scancodes for P1 (controller type 1).
N 47433 Written by #R36363 key-assignment loop when P1 selects custom keyboard (#R36316 sets IX=#R47433).
N 47433 Read by #R35825 each frame when P1 controller type is 1.
N 47433 The contents of the table are assignments in loading time.
  47433 Right = P  (34)
  47434 Up  = Q  (37)
  47435 Down  = A  (38)
  47436 Left    = I  (18)
  47437 Fire  = O  (26)
g 47438 Pause key Scancode Buffer
@ 47438 label=pause_scancode
D 47438 Pause Scancode Buffer only configurable when choosing keyboard.
N 47438 Cleared to 0 by #R36316 and #R36627/#R36642 before key-assignment.
N 47438 Captured by #R36363 only if 0 (not yet assigned).
N 47438 Read by #R35240 (game loop) and #R35514 (pause handler) via #R35910.
  47438,1 Pause key scancode. 0=unassigned.
g 47439 Quit Scancode Buffer
@ 47439 label=quit_scancode
D 47439 Quit scancode buffer only configurable when choosing keyboard.
N 47439 Cleared to 0 by #R36316 and #R36627/#R36642 before key-assignment.
N 47439 Captured by #R36363 only if 0 (not yet assigned).
N 47439 Read by #R35240 (game loop) via #R35910.
  47439,1 Quit key scancode. 0=unassigned.
@ 47440 label=p2_keyboard_table
g 47440 P2 keyboard scancode table.
D 47440 5-byte table: Fire, Up, Down, Left, Right scancodes for P2 (controller type 2).
N 47440 Pre-loaded with this keys: 35,27,19,3,11.
N 47440 Written by #R36363 key-assignment loop when P2 is assigned a custom keyboard
N 47440 (#R36347 sets IX=#R47440). Used in 2P options 2 and 3.
N 47440 Read by #R35825 each frame when P2 controller type is 2.
  47440,1 Fire  = key 0
  47441,1 Up    = key 9
  47442,1 Down  = key 8
  47443,1 Left  = key 6
  47444,1 Right = key 7
@ 47445 label=sinclair_joystick_2_table
b 47445 Sinclair Interface 2 port 2 fixed scancode table.
D 47445 5-byte read-only table for controller type 3 (Sinclair Interface 2, keys 6-0).
D 47445 Values: 35,27,19,3,11 (keyboard keys 0,9,8,6,7).
D 47445 Never written at runtime. Read by #R35825 when controller type is 3.
  47445,1 Fire  = key 0
  47446,1 Up    = key 9
  47447,1 Down  = key 8
  47448,1 Left  = key 6
  47449,1 Right = key 7
@ 47450 label=sinclair_joystick_1_table
b 47450 Sinclair Interface 2 port 1 fixed scancode table.
D 47450 5-byte read-only table for controller type 4 (Sinclair Interface 1, keys 1-5).
D 47450 Values: 4,12,20,36,28 (keyboard keys 5,4,3,1,2).
D 47450 Never written at runtime. Read by #R35825 when P2 controller type is 4
D 47450 (2P option 1: Sinclair2 + Sinclair1).
  47450 Fixed Sinclair1 scancodes: Right=28(2), Left=36(1), Down=20(3), Up=12(4), Fire=4(5).
  47450,1 Fire  = key 5
  47451,1 Up    = key 4
  47452,1 Down  = key 3
  47453,1 Left  = key 1
  47454,1 Right = key 2
@ 47455 label=mask_scratch_buffer
g 47455 Mask scratch buffer
D 47455 Temporary 3-byte copy of framebuffer bytes before AND-masking for sprite transparency. Written by #R37159. Read by #R37200.
b 47458 Input class lookup table.
@ 47458 label=input_lookup_table
N 47458 16-byte table indexed by the lower 4 bits of the key state bitmask.
N 47458 Converts all 16 possible directional button combinations into one of 9 meaningful input classes (0-8), used as column offsets into the 9-byte movement transition rows at #R44907 via #R44795 and #R44851. Read by #R39211 via #R38318.
N 47458 Key bitmask lower 4 bits: bit 0=Right, bit 1=Left, bit 2=Down, bit 3=Up. Left/Right may already be swapped by #R39142 for mirrored characters.
N 47458 #TABLE(data) { Index | Buttons held | Class | Meaning } { 0x0 | (none) | 0 | Stand / neutral } { 0x1 | Right | 1 | Move towards (forward) } { 0x2 | Left | 2 | Move away (backward) } { 0x3 | Right+Left | 0 | Cancel (treated as neutral) } { 0x4 | Down | 3 | Crouch } { 0x5 | Down+Right | 5 | Crouch-forward } { 0x6 | Down+Left | 7 | Crouch-backward } { 0x7 | Down+Right+Left | 0 | Cancel (treated as neutral) } { 0x8 | Up | 4 | Jump } { 0x9 | Up+Right | 6 | Jump-forward } { 0xA | Up+Left | 8 | Jump-backward } { 0xB | Up+Right+Left | 0 | Cancel (treated as neutral) } { 0xC | Up+Down | 0 | Cancel (treated as neutral) } { 0xD | Up+Down+Right | 0 | Cancel (treated as neutral) }  { 0xE | Up+Down+Left | 0 | Cancel (treated as neutral) } { 0xF | All dirs | 0 | Full cancel (neutral) } TABLE#
  47458,16 16 input class bytes, one per directional bitmask combination (0x00-0x0F).
@ 47474 label=isr_counter
g 47474 ISR frame counter
D 47474 Incremented each interrupt (50 Hz PAL). When it reaches 9 it is reset to 0.
N 47474 Written and read exclusively by #R38500 (ISR).
N 47474 Acts as a frequency divider: the combat timer #R46808 is decremented once every 9 interrupts, giving an effective timer rate of 50/9 ~= 5.56 Hz.
N 47474 Initialised to 0 by #R35291 at the start of each game round.
  47474,1 ISR frame counter. Range 0-8. Resets to 0 on tick 9.
@ 47475 label=frame_counter_hit
g 47475 2-frame animation and hit-detection gate counter.
D 47475 Incremented each frame by #R40092. Cycles 0-1-0-1.
N 47475 Checked at the start of the frame by #R39827 (animation update) and R39968 (tackle): both skip when non-zero.
N 47475 Checked after R40092 by #R39468 (hit detection): runs when zero after the increment, i.e., the opposite frame from animations.
N 47475 Net effect: animations and hit detection alternate each frame and never execute simultaneously.
  47475,1 2-frame gate counter. 0 animations run, hit detection skips. 1 animations skip, hit detection runs.
@ 47476 label=key_glyph_table
b 47476 Keyboard glyph lookup table
D 47476 Maps keyboard scancodes (0-39) to UDG indices for drawing key symbols on the key assignment screen.
N 47476 Used by #R35937: HL=47476; CALL #R38318 to read glyph index for scancode in A.
N 47476 Maps keyboard row/column scancodes to UDG glyphs for key config screen rendering via #R35937/#R38318.
  47476,1 'B' (scancode 0)
  47477,1 'H' (scancode 1)
  47478,1 'Y' (scancode 2)
  47479,1 '6' (scancode 3)
  47480,1 '5' (scancode 4)
  47481,1 'T' (scancode 5)
  47482,1 'G' (scancode 6)
  47483,1 'V' (scancode 7)
  47484,1 'N' (scancode 8)
  47485,1 'J' (scancode 9)
  47486,1 'U' (scancode 10)
  47487,1 '7' (scancode 11)
  47488,1 '4' (scancode 12)
  47489,1 'R' (scancode 13)
  47490,1 'F' (scancode 14)
  47491,1 'C' (scancode 15)
  47492,1 'M' (scancode 16)
  47493,1 'K' (scancode 17)
  47494,1 'I' (scancode 18)
  47495,1 '8' (scancode 19)
  47496,1 '3' (scancode 20)
  47497,1 'E' (scancode 21)
  47498,1 'D' (scancode 22)
  47499,1 'X' (scancode 23)
  47500,1 '>' (scancode 24)'SYMBOL SHIFT'
  47501,1 'L' (scancode 25)
  47502,1 'O' (scancode 26)
  47503,1 '9' (scancode 27)
  47504,1 '2' (scancode 28)
  47505,1 'W' (scancode 29)
  47506,1 'S' (scancode 30)
  47507,1 'Z' (scancode 31)
  47508,1 ':' (scancode 32)'SPACE'
  47509,1 '=' (scancode 33)'ENTER'
  47510,1 'P' (scancode 34)
  47511,1 '0' (scancode 35)
  47512,1 '1' (scancode 36)
  47513,1 'Q' (scancode 37)
  47514,1 'A' (scancode 38)
  47515,1 '?' (scancode 39)'CAPS SHIFT'
  47516,2 Unused padding bytes (';'=59,'<'=60) - scancodes >39 invalid  
@ 47518 label=divder_table
b 47518 5-digit decimal divider table.
D 47518 Five 2-byte little-endian powers of 10 used by #R36063 to decompose a value into individual decimal digits: 10000, 1000, 100, 10, 1.
W 47518,6,2
N 47524 2-digit display entry point. #R35247 calls #R36067 with IX=47524 to print the round timer using only the last two divisors (10 and 1).
  47524,4,2
@ 47528 label=snake_pointer_table
b 47528 Snake animation pointer table.
D 47528 Table of 14 active 16-bit pointers to snake sprite frames in #R33472, indexed by the energy bar draw phase (bits 7-4 of IY+7). Forms a ping-pong cycle through 4 frames: 1-1-1-2-3-3-4-4-3-3-2-2-1-1
D 47528 Used by #R39317 via #R38304 to resolve the frame pointer for each phase.
W 47528,6,2 Phase 0-2  -> #R33472 snake frame 1 (idle)
W 47534,2 Phase 3    -> #R33563 snake frame 2
W 47536,4,2 Phase 4-5  -> #R33654 snake frame 3
W 47540,4,2 Phase 6-7  -> #R33745 snake frame 4 (peak)
W 47544,4,2 Phase 8-9  -> #R33654 snake frame 3
W 47548,4,2 Phase 10-11-> #R33563 snake frame 2
W 47552,4,2 Phase 12-13-> #R33472 snake frame 1 (idle)
W 47556,2 Entry 14 is never accessed by #R39317.
@ 47558 label=fight_counter
g 47558 Fight counter.
D 47558 Tracks how many combats have been played in the current session. Range 0-7.
N 47558 Read by #R35487 and #R36105.
N 47558 RESET to 0 by #R35487 only when a fight ends by timeout #R46808=0. On normal wins the counter is not reset here.
N 47558 initialised to 255 at #R35251. First call to #R36793 wraps it to 0. Incremented at the start of each fight. When counter reaches 7, #R35487 no longer calls R35458, so stage stops alternating from fight 9 onwards. This 8-fight limit is inherited from 1-player mode which has exactly 8 fights.
  47558,1 Fight counter. 0-7, capped at 7 from fight 8 onwards.

@ 47559 label=ai_difficulty_table
b 47559 AI difficulty level pointers.
D 47559 16 bits pointers, one per fight level (fight_counter 0-7 from #R47558.
N 47559 Each pointer targets a 32-byte difficulty entry table. The entry is indexed by the pseudo-random value (R register AND 31, range 0-31) to yield a sub_index (0-7) used to pick within the 8-byte block at #R47974. Higher fight numbers point to
N 47559 entries that return higher sub_indices, selecting more aggressive movement IDs within each block.
N 47559 Difficulty curve (avg sub_index, monotonically increasing): F0(5.75) > F1(5.38) > F2(4.38) > F3(3.57) > F4(3.12) > F5(2.62) > F6(1.59) > F7(~1.09)
W 47559,16,2
@ 47575 label=tackle_overlap_flag
b 47575 Tackle overlap detection flag
D 47575 Blocks multiple overlap triggers until cleared. Set by #R39088 on eligible overlap.
N 47575 0: Eligible for overlap/tackle. 1: Tackle sequence active.
  47575,1
@ 47576 label=tackle_collision_flag
b 47576 Tackle collision flag
D 47576 Prevents multiple tackle triggers per sequence. Reset by #R35381 new-round.
N 47576 0: Able to receive a tackle. 1: Not able to receive a tackle.
  47576,1
u 47577 Unused buffer
@ 47578 label=second_ai_state_table
b 47578 Secondary AI state-to-profile-column table.
D 47578 40-byte table (#R47578-47617) indexed by AI state #R46834 (range 0-39).
N 47578 Each entry is a byte offset (0-7) selecting which column of the 8-byte profile block at R47798 is used to obtain the movement_block_id.
N 47578 This allows the AI combat state (distance, posture, reaction) to bias the profile column independently of the extra_state selection.
N 47578 Used by #R35765: Call #R38318 with HL=#R47578 and A=#R46834.
  47578,40
@ 47618 label=ai_profile_table
b 47618 AI behaviour profile pointer table.
D 47618 Two-section block: a 90-entry 2-byte LE pointer table followed immediately by 22 AI profile blocks of 8 bytes each.
N 47618 SECTION 1 (#R47618): 90 x 2-byte LE pointers indexed by extra_state (#R46442 for P1, #R46433 for P2). Each pointer targets one of the 22 profile blocks below. Multiple extra_state values share the same profile.
N 47618 SECTION 2 (#R47798): 22 profile blocks x 8 bytes. Each byte is a movement_block_id (0-22) selecting an 8-byte row in #R47974. The byte used is chosen by #R47578[#R46834] (range 0-7), so the AI state determines which column of the profile is active.
N 47618 Typical profile structure: first 3 bytes = passive/neutral blocks, middle 3 bytes = aggressive blocks, last 2 bytes = attack-forward blocks (block 4 and 8, both identical: mostly movement-1/attack-5).
N 47618 Used exclusively by #R35765.
W 47618,180,2  pointer table: 90 x 2-byte LE entries
b 47798 AI profile data blocks.
N 47798 22 blocks of 8 bytes each. Each byte is a movement_block_id (0-22) that selects an 8-byte row in #R47974. The column within the profile is chosen by #R47578[#R46834] (secondary AI table, range 0-7).
N 47798 Profiles with low block IDs (0-6) are passive/defensive.
N 47798 Profiles with high block IDs (14-22) are aggressive.
N 47798 Most profiles end with [4,8]: block 4 and block 8 are identical (both = [1,5,1,1,1,1,1,1], biased toward attack-5 and forward-1).
@ 47798 label=ai_profile_0
  47798,8   Profile $BAB6: [0,1,1, 6,6,6, 4,8]  passive->neutral->attack
@ 47806 label=ai_profile_1
  47806,8   Profile $BABE: [22,5,5, 20,20,20, 4,8]  lunge/special
@ 47814 label=ai_profile_2
  47814,8   Profile $BAC6: [0,1,1, 13,13,13, 4,8]  passive->walk
@ 47822 label=ai_profile_3
  47822,8   Profile $BACE: [12,18,18, 18,20,20, 4,8]  mixed aggressive
@ 47830 label=ai_profile_4
  47830,8   Profile $BAD6: [12,18,18, 20,20,20, 4,8]  aggressive
@ 47838 label=ai_profile_5
  47838,8   Profile $BADE: [0,1,1, 20,20,20, 4,8]  passive->aggressive
@ 47846 label=ai_profile_6
  47846,8   Profile $BAE6: [16,17,17, 7,7,7, 4,8]  movement-heavy
@ 47854 label=ai_profile_7
  47854,8   Profile $BAEE: [0,6,6, 13,13,13, 4,8]  passive->walk forward
@ 47862 label=ai_profile_8
  47862,8   Profile $BAF6: [10,11,11, 2,4,3, 4,8]  kick-oriented
@ 47870 label=ai_profile_9
  47870,8   Profile $BAFE: [10,11,11, 13,13,13, 4,8]  kick->walk
@ 47878 label=ai_profile_10
  47878,8   Profile $BB06: [16,17,17, 13,13,13, 4,8]  movement->walk
@ 47886 label=ai_profile_11
  47886,8   Profile $BB0E: [14,15,15, 13,13,13, 4,8]  mixed
@ 47894 label=ai_profile_12
  47894,8   Profile $BB16: [9,9,9, 2,4,3, 4,8]  heavy attack
@ 47902 label=ai_profile_13
  47902,8   Profile $BB1E: [0,1,1, 2,4,3, 4,8]  passive->light attack
@ 47910 label=ai_profile_14
  47910,8   Profile $BB26: [19,1,1, 20,20,20, 4,8]  special->aggressive
@ 47918 label=ai_profile_15
  47918,8   Profile $BB2E: [19,20,20, 20,20,20, 4,8]  very aggressive
@ 47926 label=ai_profile_16
  47926,8   Profile $BB36: [16,17,17, 6,6,6, 4,8]  movement->neutral
@ 47934 label=ai_profile_17
  47934,8   Profile $BB3E: [21,1,1, 13,13,13, 4,8]  walk-heavy->walk
@ 47942 label=ai_profile_18
  47942,8   Profile $BB46: [0,0,0, 0,0,0, 0,0]   all-block-0 (fully passive/random)
@ 47950 label=ai_profile_19
  47950,8   Profile $BB4E: [12,1,1, 20,20,20, 4,8]  passive->aggressive
@ 47958 label=ai_profile_20
  47958,8   Profile $BB56: [17,17,17, 7,7,7, 4,8]  movement-heavy
@ 47966 label=ai_profile_21
  47966,8   Profile $BB5E: [20,1,1, 13,13,13, 4,8]  mixed->walk forward
@ 47974 label=ai_movement_table
b 47974 AI movement selection table.
N 47974 23 blocks of 8 bytes. Block selected by profile[AI_state_col] x 8.
N 47974 Within the block, sub_index (0-7) is chosen by the difficulty entry at #R47559[fight_counter], indexed by a random value (R AND 31).
N 47974 Repeated movement IDs within a block adjust probability weighting.
N 47974 Movement 0 = do-nothing/idle this decision. 
N 47974 Lower block IDs (0-7) = passive/defensive mix.
N 47974 Higher block IDs (9-22) = increasingly aggressive.
  47974,8  Block 0:  [25,21,22,26,20,24, 0,17]  varied mix
  47982,8  Block 1:  [22,20,26,24,17,20,22, 0]  walk/approach mix
  47990,8  Block 2:  [20, 1, 1,26,26, 1, 0, 0]  mostly passive
  47998,8  Block 3:  [18,18,26,26, 1, 1, 0, 0]  passive/retreat
  48006,8  Block 4:  [ 1, 5, 1, 1, 1, 1, 1, 1]  mostly fwd+attack-5
  48014,8  Block 5:  [ 5, 5, 5, 5, 2, 2, 2, 0]  attack-5 dominant
  48022,8  Block 6:  [ 5, 5, 5, 5, 1, 1, 0, 1]  attack-5 dominant
  48030,8  Block 7:  [26,20,26,20, 5, 6, 4, 0]  approach+attack mix
  48038,8  Block 8:  [ 1, 5, 1, 1, 1, 1, 1, 1]  same as block 4
  48046,8  Block 9:  [ 8, 8, 2, 2, 6, 4, 2, 0]  heavy attack
  48054,8  Block 10: [25,25, 9, 9, 9, 9, 9, 0]  attack-9 dominant
  48062,8  Block 11: [ 5, 9, 9, 9, 9, 9, 9, 0]  attack-9 dominant
  48070,8  Block 12: [21,21, 8, 8, 6, 6, 6, 2]  movement+attack
  48078,8  Block 13: [18, 5, 5, 5, 1, 1, 0, 1]  mixed light
  48086,8  Block 14: [25,20, 6,10,10,10, 4, 2]  aggressive
  48094,8  Block 15: [20,20,10,10,10,10, 4, 0]  attack-10 dominant
  48102,8  Block 16: [25,21, 5, 6, 4, 4, 2, 4]  very aggressive
  48110,8  Block 17: [20,20, 5, 6, 4, 4, 2, 4]  aggressive
  48118,8  Block 18: [ 5, 5, 8, 8, 8, 6, 2, 0]  attack mix
  48126,8  Block 19: [21,21,21,26,26,17,17, 0]  movement-heavy
  48134,8  Block 20: [ 5,26,26, 5, 5, 5, 5, 0]  lunge attacks
  48142,8  Block 21: [21,26,21,21, 5,21,21, 0]  movement+lunge
  48150,8  Block 22: [ 5,21, 5,26, 5,26, 5, 0]  alternating


b 48158 Sounds Data
N 48158 Data containing sounds played data. 0 = terminator byte.
N 48158 Called from #R35531 and #R37536 and #R37964.
@ 48158 label=sound_head_cut_data
  48158 Sound Head Cut Data #HTML(<br />)#AUDIO(head_cut.wav)
@ 48180 label=sound_tackle_data
  48180 Sound Tackle Data #HTML(<br />)#AUDIO(tackle.wav)
@ 48200 label=sound_kick_data
  48200 Sound Kick Data #HTML(<br />)#AUDIO(kick.wav)
@ 48210 label=sound_slash_data
  48210 Sound Slash Data #HTML(<br />)#AUDIO(slash.wav)
@ 48241 label=sound_guard_1_data
  48241 Sound Guard 1 Data #HTML(<br />)#AUDIO(guard_1.wav)
@ 48251 label=sound_guard_2_data
  48251 Sound Guard 2 Data #HTML(<br />)#AUDIO(guard_2.wav)
@ 48261 label=round_end_data
  48261 Sound Round End Data #HTML(<br />)#AUDIO(end_round.wav)
b 48269 Composite Tile Definition Data
b 48269 Composite tile definition data
D 48269 Composite tile definitions: edge-mask sequences for sprites.
N 48269 164-byte packed stream (used by #R37218 via #R37317 and #R48433).
N 48269 Byte format:
N 48269   bits 7-6  render mode: 11=AND-mask #R37161, 00=DirectCopy #R37333, 01=EdgeMask-L #R37296 bit6=1, 10=EdgeMask-R #R37296 bit6=0.
N 48269   bit  5    end-of-definition signal when this byte is read as the NEXT byte after rendering a sub-tile. Has NO effect on rendering itself. bit5=1 terminates the current sequence AND serves as the first definition byte of the following entry (packed shared layout).
N 48269   bits 4-0  scanline count (0-31) for this sub-tile.
N 48269 Invariant: scanline counts per entry sum to 21 (one full tile column height).
N 48269 The only pure terminator is the final byte at 48432 which has no next entry.
N 48269 The terminator byte for entry N is ALSO the first definition byte of entry N+1.
N 48269 No wasted bytes except 48432 (final terminator only).
  48269 Entry  0: AND,16sc | EMR,5sc [21sc]
  48271 Entry  1: AND,16sc | EML,5sc [21sc]
  48273 Entry  2: AND,5sc | EMR,16sc [21sc]
  48275 Entry  3: AND,4sc | EML,17sc [21sc]
  48277 Entry  4: AND,16sc | EML,5sc [21sc]
  48279 Entry  5: AND,17sc | EML,4sc [21sc]
  48281 Entry  6: EMR,4sc | AND,2sc | EMR,2sc | AND,7sc | EMR,6sc [21sc]
  48286 Entry  7: EML,8sc | AND,8sc | EML,5sc [21sc]
  48289 Entry  8: EML,7sc | AND,9sc | EML,5sc [21sc]
  48292 Entry  9: AND,18sc | EMR,3sc [21sc]
  48294 Entry 10: EML,3sc | AND,8sc | EML,10sc [21sc]
  48297 Entry 11: AND,4sc | EMR,6sc | AND,6sc | EMR,5sc [21sc]
  48301 Entry 12: EML,11sc | AND,4sc | EML,6sc [21sc]
  48304 Entry 13: AND,2sc | EML,19sc [21sc]
  48306 Entry 14: AND,12sc | EML,9sc [21sc]
  48308 Entry 15: EMR,10sc | AND,2sc | EML,8sc | EMR,1sc [21sc]
  48312 Entry 16: EMR,6sc | EML,15sc [21sc]
  48314 Entry 17: EMR,4sc | AND,12sc | EMR,5sc [21sc]
  48317 Entry 18: EML,8sc | AND,8sc | EML,5sc [21sc]
  48320 Entry 19: EMR,11sc | AND,5sc | EMR,5sc [21sc]
  48323 Entry 20: EMR,9sc | DC,5sc | EMR,7sc [21sc]
  48326 Entry 21: EML,20sc | DC,1sc [21sc]
  48328 Entry 22: AND,18sc | EMR,3sc [21sc]
  48330 Entry 23: AND,6sc | EMR,15sc [21sc]
  48332 Entry 24: AND,18sc | EML,3sc [21sc]
  48334 Entry 25: EML,7sc | DC,6sc | EML,8sc [21sc]
  48337 Entry 26: AND,7sc | EML,14sc [21sc]
  48339 Entry 27: EML,17sc | DC,4sc [21sc]
  48341 Entry 28: AND,15sc | EMR,6sc [21sc]
  48343 Entry 29: EMR,4sc | AND,5sc | EML,4sc | DC,7sc [20sc] ANOMALY sum!=21
  48347 Entry 30: EML,11sc | DC,10sc [21sc]
  48349 Entry 31: AND,12sc | EMR,9sc [21sc]
  48351 Entry 32: EMR,8sc | DC,4sc | EMR,9sc [21sc]
  48354 Entry 33: AND,4sc | EMR,17sc [21sc]
  48356 Entry 34: EML,7sc | DC,3sc | EML,11sc [21sc]
  48359 Entry 35: EML,10sc | AND,5sc | EML,6sc [21sc]
  48362 Entry 36: AND,8sc | EML,13sc [21sc]
  48364 Entry 37: EML,11sc | DC,3sc | EML,7sc [21sc]
  48367 Entry 38: AND,7sc | EMR,14sc [21sc]
  48369 Entry 39: EMR,10sc | AND,11sc [21sc]
  48371 Entry 40: EMR,12sc | AND,9sc [21sc]
  48373 Entry 41: EMR,3sc | DC,8sc | AND,10sc [21sc]
  48376 Entry 42: DC,6sc | EMR,15sc [21sc]
  48378 Entry 43: AND,6sc | EML,15sc [21sc]
  48380 Entry 44: EML,12sc | DC,2sc | AND,7sc [21sc]
  48383 Entry 45: AND,4sc | EML,10sc | AND,3sc | EML,4sc [21sc]
  48387 Entry 46: EML,13sc | DC,8sc [21sc]
  48389 Entry 47: AND,11sc | EML,10sc [21sc]
  48391 Entry 48: EML,6sc | AND,15sc [21sc]
  48393 Entry 49: EML,8sc | AND,9sc | EML,4sc [21sc]
  48396 Entry 50: AND,10sc | EML,11sc [21sc]
  48398 Entry 51: EMR,5sc | AND,12sc | EMR,4sc [21sc]
  48401 Entry 52: EML,4sc | AND,12sc | EML,5sc [21sc]
  48404 Entry 53: AND,5sc | DC,16sc [21sc]
  48406 Entry 54: AND,18sc | DC,3sc [21sc]
  48408 Entry 55: AND,4sc | EMR,17sc [21sc]
  48410 Entry 56: AND,6sc | DC,15sc [21sc]
  48412 Entry 57: AND,17sc | EMR,4sc [21sc]
  48414 Entry 58: DC,7sc | EML,9sc | DC,5sc [21sc]
  48417 Entry 59: DC,10sc | EMR,5sc | DC,6sc [21sc]
  48420 Entry 60: AND,2sc | EMR,7sc | DC,12sc [21sc]
  48423 Entry 61: AND,11sc | EMR,10sc [21sc]
  48425 Entry 62: AND,3sc | EMR,4sc | AND,3sc | EML,11sc [21sc]
  48429 Entry 63: AND,11sc | EML,5sc | AND,5sc [21sc]
  48432 Terminator.
@ 48433 label=composite_tile_pointers
b 48433 Composite tile index pointers table.
N 48433 64 x 2-byte LE pointers (indices 0-63) into #R48269 definition data.
N 48433 Index = control_byte AND 0x3F. All pointers in range #R48269-#R48429.
N 48433 Resolved by #R37317: A=index * 2, HL=#R48433, HL+=A, BC=word at HL.
N 48433 Called from #R37218 after stripping mirror bit and isolating composite index.
W 48433,2 Index  0 -> #R48269
W 48435,2 Index  1 -> #R48271
W 48437,2 Index  2 -> #R48273
W 48439,2 Index  3 -> #R48275
W 48441,2 Index  4 -> #R48277
W 48443,2 Index  5 -> #R48279
W 48445,2 Index  6 -> #R48281
W 48447,2 Index  7 -> #R48286
W 48449,2 Index  8 -> #R48289
W 48451,2 Index  9 -> #R48292
W 48453,2 Index 10 -> #R48294
W 48455,2 Index 11 -> #R48297
W 48457,2 Index 12 -> #R48301
W 48459,2 Index 13 -> #R48304
W 48461,2 Index 14 -> #R48306
W 48463,2 Index 15 -> #R48308
W 48465,2 Index 16 -> #R48312
W 48467,2 Index 17 -> #R48314
W 48469,2 Index 18 -> #R48317
W 48471,2 Index 19 -> #R48320
W 48473,2 Index 20 -> #R48323
W 48475,2 Index 21 -> #R48326
W 48477,2 Index 22 -> #R48328
W 48479,2 Index 23 -> #R48330
W 48481,2 Index 24 -> #R48332
W 48483,2 Index 25 -> #R48334
W 48485,2 Index 26 -> #R48337
W 48487,2 Index 27 -> #R48339
W 48489,2 Index 28 -> #R48341
W 48491,2 Index 29 -> #R48343
W 48493,2 Index 30 -> #R48347
W 48495,2 Index 31 -> #R48349
W 48497,2 Index 32 -> #R48351
W 48499,2 Index 33 -> #R48354
W 48501,2 Index 34 -> #R48356
W 48503,2 Index 35 -> #R48359
W 48505,2 Index 36 -> #R48362
W 48507,2 Index 37 -> #R48364
W 48509,2 Index 38 -> #R48367
W 48511,2 Index 39 -> #R48369
W 48513,2 Index 40 -> #R48371
W 48515,2 Index 41 -> #R48373
W 48517,2 Index 42 -> #R48376
W 48519,2 Index 43 -> #R48378
W 48521,2 Index 44 -> #R48380
W 48523,2 Index 45 -> #R48383
W 48525,2 Index 46 -> #R48387
W 48527,2 Index 47 -> #R48389
W 48529,2 Index 48 -> #R48391
W 48531,2 Index 49 -> #R48393
W 48533,2 Index 50 -> #R48396
W 48535,2 Index 51 -> #R48398
W 48537,2 Index 52 -> #R48401
W 48539,2 Index 53 -> #R48404
W 48541,2 Index 54 -> #R48406
W 48543,2 Index 55 -> #R48408
W 48545,2 Index 56 -> #R48410
W 48547,2 Index 57 -> #R48412
W 48549,2 Index 58 -> #R48414
W 48551,2 Index 59 -> #R48417
W 48553,2 Index 60 -> #R48420
W 48555,2 Index 61 -> #R48423
W 48557,2 Index 62 -> #R48425
W 48559,2 Index 63 -> #R48429
@ 48561 label=messages
t 48561 Messages
D 48561 The if byte = 0 marks the terminator of the string. The scancode ":" renders as an space.
  48561,3,2:1 "#STR(#PC)"
  48564,3,2:1 "#STR(#PC)"
  48567,3,2:1 "#STR(#PC)"
  48570,3,2:1 "#STR(#PC)"
  48573,3,2:1 "#STR(#PC)"

  48576,8,7:1 "#STR(#PC)"
  48584,7,6:1 "#STR(#PC)"
  48591,7,6:1 "#STR(#PC)"
  48598,9,8:1 "#STR(#PC)"
  48607,10,9:1 "#STR(#PC)"
  48617,4,3:1 "#STR(#PC)"
  48621,6,5:1 "#STR(#PC)"
  48627,5,4:1 "#STR(#PC)"
  48632,3,2:1 "#STR(#PC)"
  48635,5,4:1 "#STR(#PC)"
  48640,5,4:1 "#STR(#PC)"
  48645,6,5:1 "#STR(#PC)"
  48651,6,5:1 "#STR(#PC)"
  48657,5,4:1 "#STR(#PC)"
  48662,17,16:1 "#STR(#PC)"
  48679,5,4:1 "#STR(#PC)"
  48684,5,4:1 "#STR(#PC)"
  48689,9,8:1 "#STR(#PC)"
  48698,9,8:1 "#STR(#PC)"
  48707,2,1:1 "#STR(#PC)"
  48709,11,10:1 "#STR(#PC)"
  48720,6,5:1 "#STR(#PC)"
  48726,5,4:1 "#STR(#PC)"
  48731,6,5:1 "#STR(#PC)"
@ 48737 label=string_pointers_table
b 48737 String Pointers Table
D 48737 Table of 29 word-sized pointers to game strings.
D 48737 Used by #R36053 to resolve a string index into the target string address.
W 48737,2 [00] -> "0 "
W 48739,2 [01] -> "1 "
W 48741,2 [02] -> "2 "
W 48743,2 [03] -> "3 "
W 48745,2 [04] -> "4 "
W 48747,2 [05] -> "SELECT"
W 48749,2 [06] -> "OPTION"
W 48751,2 [07] -> "PLAYER"
W 48753,2 [08] -> "KEYBOARD"
W 48755,2 [09] -> " JOYSTICK"
W 48757,2 [10] -> "KEY"
W 48759,2 [11] -> " FOR"
W 48761,2 [12] -> "FIRE"
W 48763,2 [13] -> "UP"
W 48765,2 [14] -> "DOWN"
W 48767,2 [15] -> "LEFT"
W 48769,2 [16] -> "RIGHT"
W 48771,2 [17] -> "PAUSE"
W 48773,2 [18] -> "QUIT"
W 48775,2 [19] -> "FINAL V8:5>11>87"
W 48777,2 [20] -> "ONE"
W 48779,2 [21] -> "TWO"
W 48781,2 [22] -> "SINCLAIR"
W 48783,2 [23] -> "KEMPSTON"
W 48785,2 [24] -> " "
W 48787,2 [25] -> "START GAME"
W 48789,2 [26] -> "GAME"
W 48791,2 [27] -> "KEYS"
W 48793,2 [28] -> "DEMO"
@ 48795 label=menu_string_seq
b 48795 Menu String Sequences
D 48795 Sequences of byte indices into #R48737. Each sequence defines one menu text line built by
N 48795 concatenating the words at those indices. The byte 255 terminates each sequence.
N 48795 Used by #R36037 (Draws a string line) and #R36130 (Main Menu).
@ 48795 label=select_option
B 48795,3 "SELECT OPTION"
@ 48798 label=0_demo
B 48798,3 "0 DEMO" Set to "START GAME" (25) by #R36212 and #R36508 at mode selection.
@ 48801 label=1_one_player
B 48801,4 "1 ONE PLAYER"
@ 48805 label=2_two_player
B 48805,4 "2 TWO PLAYER"
@ 48809 label=1_sinclair_joystick
B 48809,4 "1 SINCLAIR JOYSTICK"
@ 48813 label=2_kempston_joystick
B 48813,4 "2 KEMPSTON JOYSTICK"
@ 48817 label=3_keyboard
B 48817,3 "3 KEYBOARD"
@ 48820 label=select_keys_player
B 48820,4 "SELECT KEYS PLAYER"
@ 48824 label=player_header_1
B 48824,2 "1 " Mutable player-number string index; patched to 1 or 2 by #R36342/#R36358 before the key-assignment screen is drawn.
@ 48826 label=key_for_fire
B 48826,4 "KEY FOR FIRE"
@ 48830 label=key_for_up
B 48830,4 "KEY FOR UP"
@ 48834 label=key_for_down
B 48834,4 "KEY FOR DOWN"
@ 48838 label=key_for_left
B 48838,4 "KEY FOR LEFT"
@ 48842 label=key_for_right
B 48842,4 "KEY FOR RIGHT"
@ 48846 label=key_for_pause
B 48846,4 "KEY FOR PAUSE"
@ 48850 label=key_for_quit
B 48850,4 "KEY FOR QUIT"
@ 48854 label=player_1_player_2_header
B 48854,10 " PLAYER 1 PLAYER 2 "
@ 48864 label=1_sinclair_1_sinclair_2
B 48864,6 "1 SINCLAIR 1 SINCLAIR 2 "
@ 48870 label=2_sinclair_keyboard
B 48870,6 "2 SINCLAIR KEYBOARD"
@ 48876 label=3_kempston_keyboard
B 48876,6 "3 KEMPSTON KEYBOARD"
@ 48882 label=4_keyboard_keyboard
B 48882,6 "4 KEYBOARD KEYBOARD"
S 48888,8  Null terminator / end-of-table padding
c 48896 Game Start Routine
D 48896 Called by #R35244
@ 48896 label=game_start
N 48896 This area will be deleted by #R38494.
  48896,1 A = 0
  48897,2 Border Black
  48899,8 Set 128 (character controlled by CPU) to the address #R46425 and #R46434. (Player 1 and 2 respectively).
@ 48907 label=copy_font_table
N 48907 Copies the UDG table.
  48907,11 Copy the fonts at #R26112 to the UDG address #R23720.
N 48918 Deletes the hud (where the text "Palace Software" in the loading screen is written.
  48918,2 Blanks the 16-tile score and time HUD area.
  48920,3 Points HL to the first HUD tile at 16552.
  48923,2 Saves BC and HL.
  48925,2 Loads ASCII 58 as the blank tile index.
  48927,3 Draws one tile via #R35996.
  48930,2 Restores BC and HL.
  48932,1 Advances HL to the next HUD tile.
  48933,2 Repeats 16 times.
N 48935 Copies the 100 bytes of #R49046 to #R61568. This area will be deleted by #R38494.
N 48935 NOTE: destination #R61568 initially contains Barbarian tile data (unused tiles 194-195 of the sprite tileset at #R49216).
  48935,11 Copies #R49046 to #R61568.
@ 48946 label=reversal_table_generator
N 48946 Builds the bit-reversal lookup table at #R23296 (256 entries). Each entry maps a byte value to its horizontally mirrored equivalent (bits reversed). Used by #R39258 to horizontally mirror sprite tile data before blitting, avoiding per-pixel bit manipulation at render time.
  48946,3 Points HL to the bit-reversal table #R23296.
  48949,3 Initialises A 0 and B 0 as byte counter; C holds the value to reverse.
  48952,2 Shifts the least significant bit of C into the carry flag.
  48954,1 Rotates carry into A, building the reversed byte from MSB to LSB.
  48976,1 Writes the completed reversed byte to the table.
  48977,2 Increments the counter. B and C both hold the new value for the next iteration.
  48979,2 Counter reached 255; 256 entries written, jump to #R48984.
  48981,1 Advances HL to the next table entry.
  48982,2 Loops back for the next byte.
N 48984 Builds the left-column scanline address table at #R23552 (84 entries, 23552-23718). Uses SP as a fast write pointer: sets SP to 23720 and PUSHes each scanline address while walking upward from the bottom-left of the game window. On return, SP is restored from the saved value.
  48984,4 Saves the current stack pointer.
  48988,3 Redirects SP to #R23720 top of the table area.
  48991,3 Points HL to the bottom-left of the game window, first scanline of column 0.
  48994,2 B 84, one iteration per scanline entry.
  48996,1 Pushes the scanline address to the table via SP.
  48997,1 Steps HL up one scanline via #R36879.
  48998,1 Tests if H has crossed a tile boundary lower 3 bits of H equal to 7.
  48999,3 Inverts A and checks the 3 least significant bits for 0.
  49002,2 Tile boundary not crossed, address is ready, jump to loop end.
  49004,1 Tile boundary crossed, calculate the row above.
  49005,3 Decrements L by 32 to step up one tile row.
  49008,2 If carry set, the screen third changed, address is correct.
  49010,4 If no carry, corrects H by adding 8.
  49014,2 Decrements B and loops for the next entry.
  49016,4 Restores the original stack pointer.
N 49020 Sets the interrupt table and mode. The routine will overwrite itself from #R48896 to 49152.
  49020,3 Sets #R48896 to HL. The starting of the Interrtupt Vector Table.
  49023,2 Save 240 (F0) to compound the jump address (F0F0).
  49025,4 Copy 191 (BF) to I. The vector table will go from 0xBF00(48896) to 0xBFFF(49151).
  49029,2 Sets Interrupt mode 2.
  49031,12 Writes "JP/C3(191) #R38500" at the address 61680 (F0F0).
  49043,3 Jumps to #R38494. We move, so the running code won't be affected by the overwritting.
@ 49046 label=x_delta_table  
b 49046 Per-frame horizontal X-delta table
D 49046 Indexed by IY+8 (current frame index) from #R38960. Each byte is a signed 8-bit displacement added to IY+3 (X tile). Positive values move right, negative values move left. The mirror flag (IY+2 bit 0) negates the value so mirrored characters always move in the correct direction.
B 49046,8 frames 0-7: walk forward, delta +1 on frames 1-3
B 49054,8 frames 8-15: enter arena, delta +2 on frame 14, +1 on frame 15
B 49062,8 frames 16-23: enter arena cont., delta +1 on frame 16
B 49070,8 frames 24-31: frame 25 +1, frames 29-30 -2 (knockback/rollback)
B 49078,8 frames 32-39: frame 33 -2 (backward step in mv27 death), frame 35 +1, frames 36-39 roll displacement
B 49086,8 frames 40-47: frame 40 +1, frames 41-46 roll backward (-1,-4,-2,-4,-2,-1)
B 49094,8 frames 48-55: frame 51 +1, frames 52-55 -1 (fall/death drift)
B 49102,8 frames 56-63: no movement
B 49110,8 frames 64-71: no movement
B 49118,8 frames 72-79: frames 75-77 -1/-1/-2 (drag anim)
B 49126,8 frames 80-87: frame 80 -1, frame 87 -1
B 49134,8 frames 88-95: frame 92 +2, frame 93 -2, frame 94 +1
B 49142,8 frames 96-103: frames 97-99 -1
B 49150,2 frames 104-105: no movement
b 49152 Barbarian sprite tileset.
@ 49152 label=barb_sprite_tileset
N 49152 Full tilesheet:
N 49152 #IMGW(50)(barbarian_sheet.png)
N 49152 256 tiles, 64 bytes each. 24(8*3)h x 21vert px
N 49152 RUNTIME OVERLAP: byte at #N49152 is overwritten to #N$F0 by #R38494 as the 257th byte of the IM 2 interrupt vector table (base #N$BF00, I=#N$BF).
N 49152 This makes the ISR handler address = #N$F0F0, written by #R49031.
N 49152 Tiles 195-196 (#N$F0C0-#N$F0FF): overwritten at runtime starting a #N$F0F0 by #R49031, which relocates the ISR code from #R38500 here. The ISR (~46 bytes) spans from tile 195 into tile 196.
N 49152 Tile 253: transparent sentinel (all-zero pixel data), used as blank slot by #R37449.
N 49152 Tile 254: (#N$FF80): unreferenced tile slot. Pixel data never read; no code reference to index 254 identified.
N 49152 Tile 255: (#N$FFC0): skip-draw sentinel. Index 255 is caught by #R37449 before any pixel data is read; bytes #N$FFC0-#N$FFFF are never accessed as tile graphics. Also Stack pointer is set in #N65535.
  49152 Tile 0 (blank transparent tile, all zeros)
  49153 #IMG(tiles/barb_000.png)
  49216 Tile 1
  49217 #IMG(tiles/barb_001.png)
  49280 Tile 2
  49281 #IMG(tiles/barb_002.png)
  49344 Tile 3
  49345 #IMG(tiles/barb_003.png)
  49408 Tile 4
  49409 #IMG(tiles/barb_004.png)
  49472 Tile 5
  49473 #IMG(tiles/barb_005.png)
  49536 Tile 6
  49537 #IMG(tiles/barb_006.png)
  49600 Tile 7
  49601 #IMG(tiles/barb_007.png)
  49664 Tile 8
  49665 #IMG(tiles/barb_008.png)
  49728 Tile 9
  49729 #IMG(tiles/barb_009.png)
  49792 Tile 10
  49793 #IMG(tiles/barb_010.png)
  49856 Tile 11
  49857 #IMG(tiles/barb_011.png)
  49920 Tile 12
  49921 #IMG(tiles/barb_012.png)
  49984 Tile 13
  49985 #IMG(tiles/barb_013.png)
  50048 Tile 14
  50049 #IMG(tiles/barb_014.png)
  50112 Tile 15
  50113 #IMG(tiles/barb_015.png)
  50176 Tile 16
  50177 #IMG(tiles/barb_016.png)
  50240 Tile 17
  50241 #IMG(tiles/barb_017.png)
  50304 Tile 18
  50305 #IMG(tiles/barb_018.png)
  50368 Tile 19
  50369 #IMG(tiles/barb_019.png)
  50432 Tile 20
  50433 #IMG(tiles/barb_020.png)
  50496 Tile 21
  50497 #IMG(tiles/barb_021.png)
  50560 Tile 22
  50561 #IMG(tiles/barb_022.png)
  50624 Tile 23
  50625 #IMG(tiles/barb_023.png)
  50688 Tile 24
  50689 #IMG(tiles/barb_024.png)
  50752 Tile 25
  50753 #IMG(tiles/barb_025.png)
  50816 Tile 26
  50817 #IMG(tiles/barb_026.png)
  50880 Tile 27
  50881 #IMG(tiles/barb_027.png)
  50944 Tile 28
  50945 #IMG(tiles/barb_028.png)
  51008 Tile 29
  51009 #IMG(tiles/barb_029.png)
  51072 Tile 30
  51073 #IMG(tiles/barb_030.png)
  51136 Tile 31
  51137 #IMG(tiles/barb_031.png)
  51200 Tile 32
  51201 #IMG(tiles/barb_032.png)
  51264 Tile 33
  51265 #IMG(tiles/barb_033.png)
  51328 Tile 34
  51329 #IMG(tiles/barb_034.png)
  51392 Tile 35
  51393 #IMG(tiles/barb_035.png)
  51456 Tile 36
  51457 #IMG(tiles/barb_036.png)
  51520 Tile 37
  51521 #IMG(tiles/barb_037.png)
  51584 Tile 38
  51585 #IMG(tiles/barb_038.png)
  51648 Tile 39
  51649 #IMG(tiles/barb_039.png)
  51712 Tile 40
  51713 #IMG(tiles/barb_040.png)
  51776 Tile 41
  51777 #IMG(tiles/barb_041.png)
  51840 Tile 42
  51841 #IMG(tiles/barb_042.png)
  51904 Tile 43
  51905 #IMG(tiles/barb_043.png)
  51968 Tile 44
  51969 #IMG(tiles/barb_044.png)
  52032 Tile 45 
  52033 #IMG(tiles/barb_045.png)
  52096 Tile 46
  52097 #IMG(tiles/barb_046.png)
  52160 Tile 47
  52161 #IMG(tiles/barb_047.png)
  52224 Tile 48
  52225 #IMG(tiles/barb_048.png)
  52288 Tile 49
  52289 #IMG(tiles/barb_049.png)
  52352 Tile 50
  52353 #IMG(tiles/barb_050.png)
  52416 Tile 51
  52417 #IMG(tiles/barb_051.png)
  52480 Tile 52
  52481 #IMG(tiles/barb_052.png)
  52544 Tile 53
  52545 #IMG(tiles/barb_053.png)
  52608 Tile 54
  52609 #IMG(tiles/barb_054.png)
  52672 Tile 55
  52673 #IMG(tiles/barb_055.png)
  52736 Tile 56
  52737 #IMG(tiles/barb_056.png)
  52800 Tile 57
  52801 #IMG(tiles/barb_057.png)
  52864 Tile 58
  52865 #IMG(tiles/barb_058.png)
  52928 Tile 59
  52929 #IMG(tiles/barb_059.png)
  52992 Tile 60
  52993 #IMG(tiles/barb_060.png)
  53056 Tile 61
  53057 #IMG(tiles/barb_061.png)
  53120 Tile 62
  53121 #IMG(tiles/barb_062.png)
  53184 Tile 63
  53185 #IMG(tiles/barb_063.png)
  53248 Tile 64
  53249 #IMG(tiles/barb_064.png)
  53312 Tile 65
  53313 #IMG(tiles/barb_065.png)
  53376 Tile 66
  53377 #IMG(tiles/barb_066.png)
  53440 Tile 67
  53441 #IMG(tiles/barb_067.png)
  53504 Tile 68
  53505 #IMG(tiles/barb_068.png)
  53568 Tile 69
  53569 #IMG(tiles/barb_069.png)
  53632 Tile 70
  53633 #IMG(tiles/barb_070.png)
  53696 Tile 71
  53697 #IMG(tiles/barb_071.png)
  53760 Tile 72
  53761 #IMG(tiles/barb_072.png)
  53824 Tile 73
  53825 #IMG(tiles/barb_073.png)
  53888 Tile 74
  53889 #IMG(tiles/barb_074.png)
  53952 Tile 75
  53953 #IMG(tiles/barb_075.png)
  54016 Tile 76
  54017 #IMG(tiles/barb_076.png)
  54080 Tile 77
  54081 #IMG(tiles/barb_077.png)
  54144 Tile 78
  54145 #IMG(tiles/barb_078.png)
  54208 Tile 79
  54209 #IMG(tiles/barb_079.png)
  54272 Tile 80
  54273 #IMG(tiles/barb_080.png)
  54336 Tile 81
  54337 #IMG(tiles/barb_081.png)
  54400 Tile 82
  54401 #IMG(tiles/barb_082.png)
  54464 Tile 83
  54465 #IMG(tiles/barb_083.png)
  54528 Tile 84
  54529 #IMG(tiles/barb_084.png)
  54592 Tile 85
  54593 #IMG(tiles/barb_085.png)
  54656 Tile 86
  54657 #IMG(tiles/barb_086.png)
  54720 Tile 87
  54721 #IMG(tiles/barb_087.png)
  54784 Tile 88
  54785 #IMG(tiles/barb_088.png)
  54848 Tile 89
  54849 #IMG(tiles/barb_089.png)
  54912 Tile 90
  54913 #IMG(tiles/barb_090.png)
  54976 Tile 91
  54977 #IMG(tiles/barb_091.png)
  55040 Tile 92
  55041 #IMG(tiles/barb_092.png)
  55104 Tile 93
  55105 #IMG(tiles/barb_093.png)
  55168 Tile 94
  55169 #IMG(tiles/barb_094.png)
  55232 Tile 95
  55233 #IMG(tiles/barb_095.png)
  55296 Tile 96
  55297 #IMG(tiles/barb_096.png)
  55360 Tile 97
  55361 #IMG(tiles/barb_097.png)
  55424 Tile 98
  55425 #IMG(tiles/barb_098.png)
  55488 Tile 99
  55489 #IMG(tiles/barb_099.png)
  55552 Tile 100
  55553 #IMG(tiles/barb_100.png)
  55616 Tile 101
  55617 #IMG(tiles/barb_101.png)
  55680 Tile 102
  55681 #IMG(tiles/barb_102.png)
  55744 Tile 103
  55745 #IMG(tiles/barb_103.png)
  55808 Tile 104
  55809 #IMG(tiles/barb_104.png)
  55872 Tile 105
  55873 #IMG(tiles/barb_105.png)
  55936 Tile 106
  55937 #IMG(tiles/barb_106.png)
  56000 Tile 107
  56001 #IMG(tiles/barb_107.png)
  56064 Tile 108
  56065 #IMG(tiles/barb_108.png)
  56128 Tile 109
  56129 #IMG(tiles/barb_109.png)
  56192 Tile 110
  56193 #IMG(tiles/barb_110.png)
  56256 Tile 111
  56257 #IMG(tiles/barb_111.png)
  56320 Tile 112
  56321 #IMG(tiles/barb_112.png)
  56384 Tile 113
  56385 #IMG(tiles/barb_113.png)
  56448 Tile 114
  56449 #IMG(tiles/barb_114.png)
  56512 Tile 115
  56513 #IMG(tiles/barb_115.png)
  56576 Tile 116
  56577 #IMG(tiles/barb_116.png)
  56640 Tile 117
  56641 #IMG(tiles/barb_117.png)
  56704 Tile 118
  56705 #IMG(tiles/barb_118.png)
  56768 Tile 119
  56769 #IMG(tiles/barb_119.png)
  56832 Tile 120
  56833 #IMG(tiles/barb_120.png)
  56896 Tile 121
  56897 #IMG(tiles/barb_121.png)
  56960 Tile 122
  56961 #IMG(tiles/barb_122.png)
  57024 Tile 123
  57025 #IMG(tiles/barb_123.png)
  57088 Tile 124
  57089 #IMG(tiles/barb_124.png)
  57152 Tile 125
  57153 #IMG(tiles/barb_125.png)
  57216 Tile 126
  57217 #IMG(tiles/barb_126.png)
  57280 Tile 127
  57281 #IMG(tiles/barb_127.png)
  57344 Tile 128
  57345 #IMG(tiles/barb_128.png)
  57408 Tile 129
  57409 #IMG(tiles/barb_129.png)
  57472 Tile 130
  57473 #IMG(tiles/barb_130.png)
  57536 Tile 131
  57537 #IMG(tiles/barb_131.png)
  57600 Tile 132
  57601 #IMG(tiles/barb_132.png)
  57664 Tile 133
  57665 #IMG(tiles/barb_133.png)
  57728 Tile 134
  57729 #IMG(tiles/barb_134.png)
  57792 Tile 135
  57793 #IMG(tiles/barb_135.png)
  57856 Tile 136
  57857 #IMG(tiles/barb_136.png)
  57920 Tile 137
  57921 #IMG(tiles/barb_137.png)
  57984 Tile 138
  57985 #IMG(tiles/barb_138.png)
  58048 Tile 139
  58049 #IMG(tiles/barb_139.png)
  58112 Tile 140
  58113 #IMG(tiles/barb_140.png)
  58176 Tile 141
  58177 #IMG(tiles/barb_141.png)
  58240 Tile 142
  58241 #IMG(tiles/barb_142.png)
  58304 Tile 143
  58305 #IMG(tiles/barb_143.png)
  58368 Tile 144
  58369 #IMG(tiles/barb_144.png) 
  58432 Tile 145
  58433 #IMG(tiles/barb_145.png)
  58496 Tile 146
  58497 #IMG(tiles/barb_146.png)
  58560 Tile 147
  58561 #IMG(tiles/barb_147.png)
  58624 Tile 148
  58625 #IMG(tiles/barb_148.png)
  58688 Tile 149
  58689 #IMG(tiles/barb_149.png)
  58752 Tile 150
  58753 #IMG(tiles/barb_150.png)
  58816 Tile 151
  58817 #IMG(tiles/barb_151.png)
  58880 Tile 152
  58881 #IMG(tiles/barb_152.png)
  58944 Tile 153
  58945 #IMG(tiles/barb_153.png)
  59008 Tile 154
  59009 #IMG(tiles/barb_154.png)
  59072 Tile 155
  59073 #IMG(tiles/barb_155.png)
  59136 Tile 156
  59137 #IMG(tiles/barb_156.png)
  59200 Tile 157
  59201 #IMG(tiles/barb_157.png)
  59264 Tile 158
  59265 #IMG(tiles/barb_158.png)
  59328 Tile 159
  59329 #IMG(tiles/barb_159.png)
  59392 Tile 160
  59393 #IMG(tiles/barb_160.png)
  59456 Tile 161
  59457 #IMG(tiles/barb_161.png)
  59520 Tile 162
  59521 #IMG(tiles/barb_162.png)
  59584 Tile 163
  59585 #IMG(tiles/barb_163.png)
  59648 Tile 164
  59649 #IMG(tiles/barb_164.png)
  59712 Tile 165
  59713 #IMG(tiles/barb_165.png)
  59776 Tile 166
  59777 #IMG(tiles/barb_166.png)
  59840 Tile 167
  59841 #IMG(tiles/barb_167.png)
  59904 Tile 168
  59905 #IMG(tiles/barb_168.png)
  59968 Tile 169
  59969 #IMG(tiles/barb_169.png)
  60032 Tile 170
  60033 #IMG(tiles/barb_170.png)
  60096 Tile 171
  60097 #IMG(tiles/barb_171.png)
  60160 Tile 172
  60161 #IMG(tiles/barb_172.png)
  60224 Tile 173
  60225 #IMG(tiles/barb_173.png)
  60288 Tile 174
  60289 #IMG(tiles/barb_174.png)
  60352 Tile 175
  60353 #IMG(tiles/barb_175.png)
  60416 Tile 176
  60417 #IMG(tiles/barb_176.png)
  60480 Tile 177
  60481 #IMG(tiles/barb_177.png)
  60544 Tile 178
  60545 #IMG(tiles/barb_178.png)
  60608 Tile 179
  60609 #IMG(tiles/barb_179.png)
  60672 Tile 180
  60673 #IMG(tiles/barb_180.png)
  60736 Tile 181
  60737 #IMG(tiles/barb_181.png)
  60800 Tile 182
  60801 #IMG(tiles/barb_182.png)
  60864 Tile 183
  60865 #IMG(tiles/barb_183.png)
  60928 Tile 184
  60929 #IMG(tiles/barb_184.png)
  60992 Tile 185
  60993 #IMG(tiles/barb_185.png)
  61056 Tile 186
  61057 #IMG(tiles/barb_186.png)
  61120 Tile 187
  61121 #IMG(tiles/barb_187.png)
  61184 Tile 188
  61185 #IMG(tiles/barb_188.png)
  61248 Tile 189
  61249 #IMG(tiles/barb_189.png)
  61312 Tile 190
  61313 #IMG(tiles/barb_190.png)
  61376 Tile 191
  61377 #IMG(tiles/barb_191.png)
  61440 Tile 192
  61441 #IMG(tiles/barb_192.png)
  61504 Tile 193
  61505 #IMG(tiles/barb_193.png)
  61568 Tile 194
  61569 #IMG(tiles/barb_194.png) Tiles 195-196 (#N$F0C0-#N$F0FF): overwritten at runtime by #R48935 and #R49031, which relocates the delta table (#R49046) and the ISR code from #R38500 here. The ISR (~46 bytes) spans from tile 195 offset +48 into tile 196.
  61632 Tile 195
  61633 #IMG(tiles/barb_195.png)
  61696 Tile 196
  61697 #IMG(tiles/barb_196.png)
  61760 Tile 197
  61761 #IMG(tiles/barb_197.png)
  61824 Tile 198
  61825 #IMG(tiles/barb_198.png)
  61888 Tile 199
  61889 #IMG(tiles/barb_199.png)
  61952 Tile 200
  61953 #IMG(tiles/barb_200.png)
  62016 Tile 201
  62017 #IMG(tiles/barb_201.png)
  62080 Tile 202
  62081 #IMG(tiles/barb_202.png)
  62144 Tile 203
  62145 #IMG(tiles/barb_203.png)
  62208 Tile 204
  62209 #IMG(tiles/barb_204.png)
  62272 Tile 205
  62273 #IMG(tiles/barb_205.png)
  62336 Tile 206
  62337 #IMG(tiles/barb_206.png)
  62400 Tile 207
  62401 #IMG(tiles/barb_207.png)
  62464 Tile 208
  62465 #IMG(tiles/barb_208.png)
  62528 Tile 209
  62529 #IMG(tiles/barb_209.png)
  62592 Tile 210
  62593 #IMG(tiles/barb_210.png)
  62656 Tile 211
  62657 #IMG(tiles/barb_211.png)
  62720 Tile 212
  62721 #IMG(tiles/barb_212.png)
  62784 Tile 213
  62785 #IMG(tiles/barb_213.png)
  62848 Tile 214
  62849 #IMG(tiles/barb_214.png)
  62912 Tile 215
  62913 #IMG(tiles/barb_215.png)
  62976 Tile 216
  62977 #IMG(tiles/barb_216.png)
  63040 Tile 217
  63041 #IMG(tiles/barb_217.png)
  63104 Tile 218
  63105 #IMG(tiles/barb_218.png)
  63168 Tile 219
  63169 #IMG(tiles/barb_219.png)
  63232 Tile 220
  63233 #IMG(tiles/barb_220.png)
  63296 Tile 221
  63297 #IMG(tiles/barb_221.png)
  63360 Tile 222
  63361 #IMG(tiles/barb_222.png)
  63424 Tile 223
  63425 #IMG(tiles/barb_223.png)
  63488 Tile 224
  63489 #IMG(tiles/barb_224.png)
  63552 Tile 225
  63553 #IMG(tiles/barb_225.png)
  63616 Tile 226
  63617 #IMG(tiles/barb_226.png)
  63680 Tile 227
  63681 #IMG(tiles/barb_227.png)
  63744 Tile 228
  63745 #IMG(tiles/barb_228.png)
  63808 Tile 229
  63809 #IMG(tiles/barb_229.png)
  63872 Tile 230
  63873 #IMG(tiles/barb_230.png)
  63936 Tile 231
  63937 #IMG(tiles/barb_231.png)
  64000 Tile 232
  64001 #IMG(tiles/barb_232.png)
  64064 Tile 233
  64065 #IMG(tiles/barb_233.png)
  64128 Tile 234
  64129 #IMG(tiles/barb_234.png)
  64192 Tile 235
  64193 #IMG(tiles/barb_235.png)
  64256 Tile 236
  64257 #IMG(tiles/barb_236.png)
  64320 Tile 237
  64321 #IMG(tiles/barb_237.png)
  64384 Tile 238
  64385 #IMG(tiles/barb_238.png)
  64448 Tile 239
  64449 #IMG(tiles/barb_239.png)
  64512 Tile 240
  64513 #IMG(tiles/barb_240.png)
  64576 Tile 241
  64577 #IMG(tiles/barb_241.png)
  64640 Tile 242
  64641 #IMG(tiles/barb_242.png)
  64704 Tile 243
  64705 #IMG(tiles/barb_243.png)
  64768 Tile 244
  64769 #IMG(tiles/barb_244.png)
  64832 Tile 245
  64833 #IMG(tiles/barb_245.png)
  64896 Tile 246
  64897 #IMG(tiles/barb_246.png)
  64960 Tile 247
  64961 #IMG(tiles/barb_247.png)
  65024 Tile 248
  65025 #IMG(tiles/barb_248.png)
  65088 Tile 249
  65089 #IMG(tiles/barb_249.png)
  65152 Tile 250
  65153 #IMG(tiles/barb_250.png)
  65216 Tile 251
  65217 #IMG(tiles/barb_251.png)
  65280 Tile 252
  65281 #IMG(tiles/barb_252.png)
  65344 Tile 253: transparent sentinel (all-zero pixel data), used as blank slot by #R37449.
  65345 #IMG(tiles/barb_253.png)
  65408 Tile 2544: (#N$FF80): unreferenced tile slot. Pixel data never read; no code reference to index 254 identified.
  65409 #IMG(tiles/barb_254.png)
  65472 Tile 255: (#N$FFC0): skip-draw sentinel. Index 255 is caught by #R37449 before any pixel data is read; bytes #N$FFC0-#N$FFFF are never accessed as tile graphics.
  65473 #IMG(tiles/barb_255.png) Stack pointer set in #N65535.