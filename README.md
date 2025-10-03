# AIOC
A short project on how to enable the DTR on the AIOC in windows using simple codes. I have a few Powershell lines and an entire C# project to share. 

Users will be able to talk through the AIOC using a basic HT and Windows. Once I get my project neatly coded for sharing I can show you how to record using NAUDIO and other Windows Core API to enable stratetic recording with no blank spaces(pauses) enabled. 

Also included are a hotkey and hold to PTT button set with indicator. A TTS(Text-To-Speech) writer and a COMM Port selector. In order to fully grasp the basic usages of the AIOC in Windows I added a few sound bars and a digital volume meter which can be paused. The clock rate for recording buffers and the squelch for monitoring and precision volume can also be set.


[I got the ideas and basic code blocks from PTT-DTRmaster... I can't find the link]

Useful is the VB 16 Channel Cable (VBCABLE) https://vb-audio.com/Cable/

<img width="1334" height="838" alt="DEMSpttsamp" src="https://github.com/user-attachments/assets/7184b03b-1ef0-4465-8a5a-e724dbe5bdf5" />

Using the hide function -> Light turns on when receiving and records -> Indicators also display hotkey being used to PTT.

 (CHANNEL MODE!)

<img width="1131" height="448" alt="image" src="https://github.com/user-attachments/assets/e3009149-439c-47ce-89ba-87dbe807c91a" />

<img width="1082" height="435" alt="image" src="https://github.com/user-attachments/assets/0868867c-18d0-40a6-b30a-0d8963454d7d" />

The red light turns on.
*Getting back on it for looks -> KO6HTC 73

*Updates on Progress
-Put some playback, compile audio, and stash buttons on there. Added a repeater mode for if you have 2 AIOCs.
 I had one, it broke, after a while I noticed that TX still works and will do. Now I have 2. It works with some clarity and ease. 

<img width="1324" height="888" alt="image" src="https://github.com/user-attachments/assets/2b2de89e-a72b-492e-99db-643acb7b42b3" />

Ok so I have cleaned up some old code and moved most of the function handlers to the source code file so as to eliminate static variables while maintaining design.
There's still static but there use is properly adjucated for. I am adding SoundFX to make it more fun and also to help with repeaters... such as playing a tone or sound before talking while holding using DTR. I am also constantly fool proofing the form so that there are no crashes or unintended transmissions. You can also play a sound at the end 
of any transmission like a roger beep, and control your TXhold so that sound plays through. I want to be able to make it as safe as possible for a Ham to use. 

Obviously I have no intention of keeping the sound bars and weird number meter there. I have started with FFT graphs and audio spectrum analysis and simplex usage. 

<img width="1402" height="914" alt="image" src="https://github.com/user-attachments/assets/e63bc2d6-d27b-4a2d-824d-aa01e9fae04d" />




