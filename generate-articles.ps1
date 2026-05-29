<#
.SYNOPSIS
    Health Insurance Info - Article Generator Helper
    Provides instructions for creating new blog articles.
.DESCRIPTION
    This script helps you create new blog articles for the Health Insurance Info
    website by copying the BLOG-TEMPLATE.html and providing guidance.
#>

$ErrorActionPreference = "Stop"
$root = $PSScriptRoot

function Show-Guidelines {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host " Health Insurance Info - Article Creator " -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Article Creation Guidelines:" -ForegroundColor Yellow
    Write-Host "------------------------------" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Each article must include:" -ForegroundColor White
    Write-Host "  - Simple, easy-to-understand language" -ForegroundColor White
    Write-Host "  - Realistic, relevant images or visual placeholders" -ForegroundColor White
    Write-Host "  - Infographics for better understanding" -ForegroundColor White
    Write-Host "  - Structured sections (headings + bullet points)" -ForegroundColor White
    Write-Host "  - Only Indian government references" -ForegroundColor White
    Write-Host ""
    Write-Host "Allowed government domains:" -ForegroundColor Green
    Write-Host "  - irdai.gov.in / irdai.gov.in" -ForegroundColor Green
    Write-Host "  - ayushmanbharat.gov.in" -ForegroundColor Green
    Write-Host "  - india.gov.in" -ForegroundColor Green
    Write-Host ""
    Write-Host "Prohibited:" -ForegroundColor Red
    Write-Host "  - U.S. or foreign government links" -ForegroundColor Red
    Write-Host "  - Promotional or selling content" -ForegroundColor Red
    Write-Host "  - Contact details (email, phone)" -ForegroundColor Red
    Write-Host "  - Misleading claims or expert advisory statements" -ForegroundColor Red
    Write-Host ""
}

function New-Article {
    param(
        [string]$Title,
        [string]$Filename
    )

    $templatePath = Join-Path $root "BLOG-TEMPLATE.html"
    $articlesDir = Join-Path $root "blog"

    if (-not (Test-Path -LiteralPath $templatePath)) {
        Write-Host "ERROR: BLOG-TEMPLATE.html not found in project root." -ForegroundColor Red
        return
    }

    if (-not (Test-Path -LiteralPath $articlesDir)) {
        New-Item -ItemType Directory -Path $articlesDir -Force | Out-Null
        Write-Host "Created: blog/" -ForegroundColor Cyan
    }

    $articlePath = Join-Path $articlesDir $Filename

    if (Test-Path -LiteralPath $articlePath) {
        Write-Host "ERROR: $Filename already exists in blog/." -ForegroundColor Red
        return
    }

    # Copy template
    Copy-Item -LiteralPath $templatePath -Destination $articlePath
    Write-Host "Created: blog/$Filename (from template)" -ForegroundColor Cyan

    # Update the title in the new file
    (Get-Content -LiteralPath $articlePath) -replace "Blog Article Title", $Title | Set-Content -LiteralPath $articlePath
    (Get-Content -LiteralPath $articlePath) -replace "Blog Title", $Title | Set-Content -LiteralPath $articlePath

    Write-Host ""
    Write-Host "Article '$Title' created successfully!" -ForegroundColor Green
    Write-Host "File: blog/$Filename" -ForegroundColor White
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Yellow
    Write-Host "  1. Open blog/$Filename in your editor" -ForegroundColor Yellow
    Write-Host "  2. Update the meta description" -ForegroundColor Yellow
    Write-Host "  3. Write your article content" -ForegroundColor Yellow
    Write-Host "  4. Add infographics and visual elements" -ForegroundColor Yellow
    Write-Host "  5. Link the article from blog.html" -ForegroundColor Yellow
}

# --- Main ---

Show-Guidelines

$choice = Read-Host "Do you want to create a new article? (y/n)"

if ($choice -eq "y" -or $choice -eq "Y") {
    $title = Read-Host "Enter article title"
    $filename = Read-Host "Enter filename (e.g., understanding-premium-calculations.html)"

    if ($title -and $filename) {
        New-Article -Title $title -Filename $filename
    } else {
        Write-Host "Both title and filename are required." -ForegroundColor Red
    }
} else {
    Write-Host "Exiting. Goodbye!" -ForegroundColor Cyan
}
