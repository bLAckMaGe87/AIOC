function PTT()
{
$Signature = @'
[DllImport("user32.dll")]
public static extern short GetAsyncKeyState(int vKey);
'@
            $User32 = Add-Type -MemberDefinition $Signature -Name "Win32GetAsyncKeyState" -Namespace Win32Functions -PassThru
            $KeyToWatch = 0x10
            $KeyToWatch2 = 0x45 
            $KeyToWatch3 = 0x57
            $breakloop = 0
            


            $synth = New-Object System.Speech.Synthesis.SpeechSynthesizer
            $dog = Get-AudioDevice -List | Where-Object { $_.Type -eq "Playback" }
             #update with algorithm for COM auto-selector (its in c# right now)
            $cat = $dog | Where-Object {$_.name-match "AIOC*"} #name your AIOC playback device i.e. "...{$_.name-match "KO6HTCsAIOC_playback*"}
            Set-AudioDevice -Index $cat.index #-Playback
            $port = New-Object System.IO.Ports.SerialPort COM5,9600,None,8,one #check your COM number per device...
            $port.open()
            Write-Host "PORT OPENING" -BackgroundColor DarkRed -ForegroundColor Blue
            Write-Host "DEFAULT PRESS <Q> to HOLD TX, <SHIFT> TO PTT" -BackgroundColor DarkRed -ForegroundColor Blue

             
            $alreadySaidOff = 0
            $keyBeingPushed = 0
            $keyAlreadyOn = 0 
            $PTTisOn = 0
             
            while($breakloop -ne 1)
            {
                
                $KeyState = $User32::GetAsyncKeyState($KeyToWatch)
                $isHeld = [bool]($KeyState -band 0x8000)
                $KeyState2 = $User32::GetAsyncKeyState($KeyToWatch2)
                $isHeld2 = [bool]($KeyState2 -band 0x8000)
                $KeyState3 = $User32::GetAsyncKeyState($KeyToWatch3)
                $isHeld3 = [bool]($KeyState3 -band 0x8000)
                if($isHeld2)
                {
                    [System.Console]::Beep(1300, 200) #make your own beeps

                }
                if($isHeld3)
                {
                    [System.Console]::Beep(900, 400)

                }

                if($isHeld) 
                {
                        if($keyBeingPushed -eq 0)
                        {
                        write-host "_____________ON_____*_______" -BackgroundColor Black -ForegroundColor Green  
                        $port.DtrEnable = $true
                        $keyBeingPushed = 1
                        $keyAlreadyOn = 0
                            
                        }
                   
                }
                else 
                {

                    if($keyAlreadyOn -eq 0)
                    {
                    write-host "_____________OFF_____*_______" -BackgroundColor Black -ForegroundColor RED  
                    $port.DtrEnable = $false
                    $keyAlreadyOn = 1
                    }
                    $keyBeingPushed = 0
                   
                }
                if ([Console]::KeyAvailable)
                {

                   $key = [Console]::ReadKey($true) 
                   if($keyBeingPushed -eq 0)
                   {
                       if ($key.Key -eq "Q") 
                       {
                                if($PTTisOn -eq 0)
                                {
                                    write-host "_____________ON_____________" -BackgroundColor Black -ForegroundColor Green
                                    $port.DtrEnable = $true
                                     
                                    $PTTisOn = 1
                                }
                                elseif($PTTisOn -eq 1)
                                {
                                    write-host "_____________OFF_____ _______" -BackgroundColor Black -ForegroundColor RED
                                    $port.DtrEnable = $false
                                    $PTTisOn = 0
                                }
                             
                       } 
                       else 
                       {
                                    write-host "WRONG : KEY" -BackgroundColor Black -ForegroundColor YELLOW
                                    $port.DtrEnable = $false
                                    $PTTisOn = 0
                                    $alreadySaidOff = 1
                       }
                   }
                  
                }
 
            }
            
}
