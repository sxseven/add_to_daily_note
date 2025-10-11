param(
    [string]$Content
)

# 强制设置 PowerShell 内部编码为 UTF8
[Console]::InputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# 调试输出
# Write-Host "【接收到的内容】: [$Content]" -ForegroundColor Cyan
# Write-Host "【内容长度】: $($Content.Length) 个字符" -ForegroundColor Magenta

# 检查内容是否为空
if ([string]::IsNullOrWhiteSpace($Content)) {
    Write-Host "内容为空，跳过写入操作。" -ForegroundColor Yellow
    exit 0
}

$VaultPath = "请修改为md文件期望存放位置的绝对地址"
$FileName = "$(Get-Date -Format 'yyyy-M-d').md"
$FilePath = Join-Path -Path $VaultPath -ChildPath $FileName

# 确保目录存在
if (!(Test-Path -Path $VaultPath)) {
    New-Item -ItemType Directory -Path $VaultPath -Force | Out-Null
}

# 生成带时间戳的内容
$Timestamp = Get-Date -Format 'HH:mm:ss'
$Line = "$Timestamp $Content"

# 追加到文件
Add-Content -Path $FilePath -Value $Line -Encoding UTF8

# Write-Host "已写入日记: $Line" -ForegroundColor Green
# Write-Host "文件路径: $FilePath"