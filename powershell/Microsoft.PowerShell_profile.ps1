# Nvim Prebuilt Manual install
$env:PATH += ":/opt/nvim-linux-x86_64/bin"

# Suggestions are rendered in a drop-down list.
Set-PSReadLineOption -PredictionViewStyle ListView

# Enable predictive Intellisense.
Set-PSReadLineOption -PredictionSource HistoryAndPlugin

Invoke-Expression (& starship init powershell)
