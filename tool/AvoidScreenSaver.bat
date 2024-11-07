@powershell -NoProfile -ExecutionPolicy Unrestricted "&([ScriptBlock]::Create((cat \"%~f0\" | ?{$_.ReadCount -gt 1}) -join \"`n\"))" %* & goto:eof

$Signature = @'
  [DllImport("user32.dll")]
  public static extern void mouse_event(long dwFlags, long dx, long dy, long cButtons, long dwExtraInfo);
'@
$MouseEvent = Add-Type -MemberDefinition $Signature -Name "Win32MouseEvent" -Namespace Win32Functions -PassThru

echo "AvoidScreenSaver.ps1 started."
echo "[Ctrl+C] Press to exit."
while ($true) {
    Start-Sleep -s 50
    $MouseEvent::mouse_event(1, 0, 0, 0, 0)
}
