<#
.SYNOPSIS
    Health Insurance Info - Site Generator
    Creates the directory structure and placeholder files for the website.
.DESCRIPTION
    This script generates the complete directory structure and placeholder
    content files for the Health Insurance Info website.
    Run this script from the project root directory.
#>

$ErrorActionPreference = "Stop"
$root = $PSScriptRoot

Write-Host "========================================" -ForegroundColor Green
Write-Host " Health Insurance Info - Site Generator " -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

# Create directory structure
$directories = @(
    "css",
    "js",
    "blog",
    "img"
)

foreach ($dir in $directories) {
    $path = Join-Path $root $dir
    if (-not (Test-Path -LiteralPath $path)) {
        New-Item -ItemType Directory -Path $path -Force | Out-Null
        Write-Host "Created: $dir/" -ForegroundColor Cyan
    } else {
        Write-Host "Exists:  $dir/" -ForegroundColor Yellow
    }
}

# Main pages
$mainPages = @(
    "index.html",
    "about.html",
    "blog.html",
    "faq.html",
    "contact.html",
    "privacy-policy.html",
    "terms-of-use.html",
    "disclaimer.html",
    "cookie-policy.html",
    "404.html"
)

# Blog articles
$blogArticles = @(
    "blog/what-is-health-insurance-in-india.html",
    "blog/how-to-file-health-insurance-claim.html",
    "blog/cashless-vs-reimbursement-claims.html"
)

# Templates
$templates = @(
    "PAGE-TEMPLATE.html",
    "BLOG-TEMPLATE.html"
)

# Config files
$configFiles = @(
    "sitemap.xml",
    "robots.txt",
    ".gitignore",
    "README.md",
    "gen.ps1",
    "generate-articles.ps1"
)

Write-Host ""
Write-Host "--- Site Structure Summary ---" -ForegroundColor Green
Write-Host ""

$allPages = $mainPages + $blogArticles + $templates
$existingCount = 0
$missingCount = 0

foreach ($page in $allPages) {
    $path = Join-Path $root $page
    if (Test-Path -LiteralPath $path) {
        $existingCount++
    } else {
        Write-Host "MISSING: $page" -ForegroundColor Red
        $missingCount++
    }
}

Write-Host ""
Write-Host "Pages found: $existingCount" -ForegroundColor Cyan
if ($missingCount -gt 0) {
    Write-Host "Pages missing: $missingCount (create these files)" -ForegroundColor Red
} else {
    Write-Host "All pages present!" -ForegroundColor Green
}

Write-Host ""
Write-Host "To view the site, open index.html in your browser." -ForegroundColor White
Write-Host "========================================" -ForegroundColor Green
