function Reload {
    # Disable screen reader
    try {
        if (-not ("ScreenReaderUtil" -as [Type])) {
            (Add-Type -PassThru -Name ScreenReaderUtil -Namespace WinApiHelper -MemberDefinition @'
            const int SPIF_SENDCHANGE = 0x0002;
            const int SPI_SETSCREENREADER = 0x0047;
            [DllImport("user32.dll", SetLastError = true)]
            private static extern bool SystemParametersInfo(uint uiAction, uint uiParam, IntPtr pvParam, uint fWinIni);
            public static void EnableScreenReader(bool enable) {
                var ok = SystemParametersInfo(SPI_SETSCREENREADER, enable ? 1u : 0u, IntPtr.Zero, SPIF_SENDCHANGE);
                if (!ok) { throw new System.ComponentModel.Win32Exception(Marshal.GetLastWin32Error()); }
            }
'@)
        }
        [ScreenReaderUtil]::EnableScreenReader($false)
        Write-Host "Screen reader disabled successfully." -ForegroundColor Green
    } catch {
        Write-Host "Failed to disable screen reader: $_" -ForegroundColor Red
    }

    # Reload PSReadLine module
    try {
        Import-Module PSReadLine -Force
        Write-Host "PSReadLine module reloaded successfully." -ForegroundColor Green
    } catch {
        Write-Host "Failed to reload PSReadLine module: $_" -ForegroundColor Red
    }

    # Remove this function after execution
    Remove-Item -Path Function:\Reload -ErrorAction SilentlyContinue
}