function PTT()
{
$Signature = @'
[DllImport("user32.dll")]
public static extern short GetAsyncKeyState(int vKey);
'@
            $User32 = Add-Type -MemberDefinition $Signature -Name "Win32GetAsyncKeyState" -Namespace Win32Functions -PassThru
            $KeyToWatch = 0x10 
            $breakloop = 0 
            


            $synth = New-Object System.Speech.Synthesis.SpeechSynthesizer
            $dog = Get-AudioDevice -List | Where-Object { $_.Type -eq "Playback" }
            $cat = $dog | Where-Object {$_.name-match "KO6HTC*"} #name your AIOC playback device i.e. "...{$_.name-match "AIOC*"}
            Set-AudioDevice -Index $cat.index #-Playback
            $port = New-Object System.IO.Ports.SerialPort COM5,9600,None,8,one #check your com number per device
            $port.open()
            Write-Host "PORT OPENING" -BackgroundColor DarkRed -ForegroundColor Blue
            Write-Host "DEFAULT PRESS <Q> to HOLD TX, <SHIFT> TO PTT" -BackgroundColor DarkRed -ForegroundColor Blue

            #$alreadySaidOn = 0
            $alreadySaidOff = 0
            $keyBeingPushed = 0
            $keyAlreadyOn = 0 
            $PTTisOn = 0
             
            while($breakloop -ne 1)
            {
                
                $KeyState = $User32::GetAsyncKeyState($KeyToWatch)
                $isHeld = [bool]($KeyState -band 0x8000)

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
