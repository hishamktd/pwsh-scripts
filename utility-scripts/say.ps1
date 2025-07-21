function say {
    param([string]$message = 'Hi')

    Add-Type -AssemblyName System.Speech
    $synth = New-Object System.Speech.Synthesis.SpeechSynthesizer
    Write-Host "$message" -ForegroundColor Cyan
    $synth.SpeakAsync("$message") | Out-Null
}