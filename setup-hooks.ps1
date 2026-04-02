# setup-hooks.ps1 — One-liner git hooks setup for any project repo (Windows)
# Usage: iwr -useb https://github.com/pgwindy/GitHooker/test_git_hooks/setup-hooks.ps1 | iex
# Prerequisites: Python/pip, Node.js, Go, Java must be pre-installed
$ErrorActionPreference = "Stop"

# --- Configuration -----------------------------------------------------------
$REPO_RAW_URL = "https://github.com/pgwindy/GitHooker/test_git_hooks"
# ------------------------------------------------------------------------------

Write-Host "`n=== Initializing Local Git Hooks ===" -ForegroundColor Cyan

# 1. Verify we are inside a git repository
$gitCheck = git rev-parse --is-inside-work-tree 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Not inside a git repository. Please cd into your project first." -ForegroundColor Red
    exit 1
}

$PROJECT_ROOT = (git rev-parse --show-toplevel).Replace("/", "\")

# 2. Check prerequisites
Write-Host "`n[1/6] Checking prerequisites..." -ForegroundColor Yellow
$missing = @()
if (-not (Get-Command python -ErrorAction SilentlyContinue)) { $missing += "python" }
if (-not (Get-Command node -ErrorAction SilentlyContinue)) { $missing += "node" }
if (-not (Get-Command go -ErrorAction SilentlyContinue)) { $missing += "go" }
if (-not (Get-Command java -ErrorAction SilentlyContinue)) { $missing += "java" }

if ($missing.Count -gt 0) {
    Write-Host "ERROR: Missing required tools: $($missing -join ', ')" -ForegroundColor Red
    Write-Host "Please install them before running this script." -ForegroundColor Yellow
    exit 1
}
Write-Host "  - python, node, go, java: OK" -ForegroundColor Green

# Ensure Go bin is in PATH
$env:GOPATH = if ($env:GOPATH) { $env:GOPATH } else { "$env:USERPROFILE\go" }
if ($env:Path -notlike "*$env:GOPATH\bin*") {
    $env:Path = "$env:Path;$env:GOPATH\bin"
}

# 3. Install pre-commit via pip
Write-Host "`n[2/6] Installing pre-commit via pip..." -ForegroundColor Yellow
if (Get-Command pre-commit -ErrorAction SilentlyContinue) {
    Write-Host "  - pre-commit already installed, skipping." -ForegroundColor Gray
} else {
    pip install pre-commit
}

# 4. Install gitleaks and tflint via go install
Write-Host "`n[3/6] Installing gitleaks via go install..." -ForegroundColor Yellow
if (Get-Command gitleaks -ErrorAction SilentlyContinue) {
    Write-Host "  - gitleaks already installed, skipping." -ForegroundColor Gray
} else {
    go install github.com/zricethezav/gitleaks/v8@latest
}

Write-Host "`n[4/6] Installing tflint via go install..." -ForegroundColor Yellow
if (Get-Command tflint -ErrorAction SilentlyContinue) {
    Write-Host "  - tflint already installed, skipping." -ForegroundColor Gray
} else {
    go install github.com/terraform-linters/tflint@latest
}

# 5. Install checkstyle (standalone jar + wrapper)
Write-Host "`n[5/6] Installing checkstyle..." -ForegroundColor Yellow
$checkstyleDir = "$env:USERPROFILE\.checkstyle"
$checkstyleJar = "$checkstyleDir\checkstyle.jar"
$checkstyleVersion = "10.21.4"
$checkstyleUrl = "https://repo1.maven.org/maven2/com/puppycrawl/tools/checkstyle/$checkstyleVersion/checkstyle-$checkstyleVersion-all.jar"

if (-not (Test-Path $checkstyleDir)) {
    New-Item -ItemType Directory -Path $checkstyleDir -Force | Out-Null
}

if (-not (Test-Path $checkstyleJar)) {
    Write-Host "  - Downloading checkstyle $checkstyleVersion from Maven Central..."
    Invoke-WebRequest -Uri $checkstyleUrl -OutFile $checkstyleJar -UseBasicParsing
} else {
    Write-Host "  - checkstyle jar already exists, skipping." -ForegroundColor Gray
}

# Create checkstyle.cmd wrapper in a PATH-accessible location
$wrapperDir = "$env:USERPROFILE\.local\bin"
if (-not (Test-Path $wrapperDir)) {
    New-Item -ItemType Directory -Path $wrapperDir -Force | Out-Null
}

$wrapperContent = "@echo off`r`njava -jar `"$checkstyleJar`" %*"
Set-Content -Path "$wrapperDir\checkstyle.cmd" -Value $wrapperContent

# Add wrapper dir to user PATH if not already there
$currentUserPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($currentUserPath -notlike "*$wrapperDir*") {
    [Environment]::SetEnvironmentVariable("Path", "$currentUserPath;$wrapperDir", "User")
    $env:Path = "$env:Path;$wrapperDir"
    Write-Host "  - Added $wrapperDir to user PATH."
}

# 6. Download configuration files
Write-Host "`n[6/6] Downloading hook configuration files..." -ForegroundColor Yellow
Invoke-WebRequest -Uri "$REPO_RAW_URL/.pre-commit-config-win.yaml" -OutFile "$PROJECT_ROOT\.pre-commit-config.yaml" -UseBasicParsing
Invoke-WebRequest -Uri "$REPO_RAW_URL/.eslintrc.json" -OutFile "$PROJECT_ROOT\.eslintrc.json" -UseBasicParsing

# 7. Register hooks with Git
Write-Host "`nRegistering hooks with Git..." -ForegroundColor Yellow
Push-Location $PROJECT_ROOT
pre-commit install
Pop-Location

Write-Host "`n=== Success! Pre-commit hooks are now active. ===" -ForegroundColor Green
Write-Host "Added to your project:"
Write-Host "   - .pre-commit-config.yaml"
Write-Host "   - .eslintrc.json"
Write-Host ""
Write-Host "Commands:"
Write-Host "   pre-commit run --all-files   Run all hooks manually"
Write-Host "   pre-commit autoupdate        Update hook versions"
Write-Host ""
