add-type -AssemblyName system.speech
$speaker = new-object System.Speech.Synthesis.SpeechSynthesizer


$fo = Get-AudioDevice -playback
$dog = Get-AudioDevice -List | Where-Object { $_.Type -eq "Playback" }
$cat = $dog | Where-Object {$_.name-match "AIOC*"}
Set-AudioDevice -Index $cat.index #-Playback

#If just so happen to know which COM to use -> 
#I'll make this better but for now... 
$port = New-Object System.IO.Ports.SerialPort COM5,9600,None,8,one
$port.open()

$breaker = 0 
$speaker.volume = 100 
$speaker.rate = 1
$firstLine = "United States of America!"
[string]$dog = "" 
$bust = 0 


 while ($breaker -ne 1 )
 {
 

  if($bust -eq 0 )
  {
     $speaker.Speak($firstLine)
     $bust = 1
  }
  if($bust -eq 1 )
  {
  
      $dog = [System.Console]::ReadLine()
 
      $port.DtrEnable = $true
      #add your own pause
      #Start-Sleep -Milliseconds 200
      $speaker.speak($dog)
 
      $port.DtrEnable = $false
 
  
  }


 }
