# DSA PR Programs Installer (Windows PowerShell)
# Compatible with: curl.exe -fsSL https://s.id/FqYm6 | powershell -NoProfile -

$ErrorActionPreference = "Stop"

$Repo = "nikhilwankhedee/dsa-pr"
$RawBase = "https://raw.githubusercontent.com/$Repo/main"
$TargetDir = ".\dsa-pr"

$Files = @(
  "1_linear_search_training_attendance.cpp",
  "2_binary_search_training_attendance.cpp",
  "3_library_book_id_linear_search.cpp",
  "4_student_roll_number_binary_search.cpp",
  "5_quick_sort_player_scores.cpp",
  "6_menu_driven_bubble_insertion.cpp",
  "7_menu_driven_selection_insertion.cpp",
  "8_stack_using_array.cpp",
  "9_queue_using_array.cpp",
  "10_binary_search_tree_menu_driven.cpp",
  "11_singly_linked_list_student_records.cpp",
  "12_prim_and_kruskal_mst.cpp",
  "13_hash_table_with_linear_probing.cpp",
  "14_circular_queue_using_array.cpp",
  "15_binary_tree_inorder_preorder_postorder.cpp",
  "16_bst_minimum_and_maximum.cpp",
  "17_quick_sort_book_prices.cpp",
  "18_queue_using_linked_list.cpp"
)

$Names = @(
  "1) Linear Search: Training Attendance",
  "2) Binary Search: Training Attendance",
  "3) Library Book ID: Linear Search",
  "4) Student Roll Number: Binary Search",
  "5) Quick Sort: Player Scores",
  "6) Menu-Driven: Bubble Sort & Insertion Sort",
  "7) Menu-Driven: Selection Sort & Insertion Sort",
  "8) Stack using Array",
  "9) Queue using Array",
  "10) Binary Search Tree: Menu Driven",
  "11) Singly Linked List: Student Records",
  "12) Prim's and Kruskal's MST",
  "13) Hash Table with Linear Probing",
  "14) Circular Queue using Array",
  "15) Binary Tree with Inorder, Preorder, Postorder",
  "16) BST: Minimum and Maximum",
  "17) Quick Sort: Book Prices",
  "18) Queue using Linked List"
)

function Download-File {
  param (
    [string]$Url,
    [string]$Dest
  )
  $name = Split-Path $Dest -Leaf
  $dir = Split-Path $Dest -Parent
  if (-not (Test-Path $dir)) {
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
  }
  Write-Host "[INFO] Saving file at: $Dest" -ForegroundColor Cyan
  try {
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest -Uri $Url -OutFile $Dest -UseBasicParsing -TimeoutSec 60
    $ProgressPreference = 'Continue'
    if ((Test-Path $Dest) -and ((Get-Item $Dest).Length -gt 0)) {
      Write-Host "[SUCCESS] Saved files at: $Dest" -ForegroundColor Green
      return $true
    }
  }
  catch {
    $ProgressPreference = 'Continue'
    Write-Host "[ERROR] Failed to download $name : $_" -ForegroundColor Red
    return $false
  }
  Write-Host "[ERROR] Failed to download $name" -ForegroundColor Red
  return $false
}

Write-Host "==========================================" -ForegroundColor Yellow
Write-Host "DSA PR Programs Installer (Windows PowerShell)" -ForegroundColor Yellow
Write-Host "==========================================" -ForegroundColor Yellow
Write-Host ""

if (Test-Path $TargetDir) {
  Write-Host "[INFO] Directory '$TargetDir' already exists." -ForegroundColor Cyan
  Write-Host "[INFO] Existing files will not be deleted." -ForegroundColor Cyan
  $overwrite = Read-Host "Do you want to download into this directory anyway? (y/N)"
  if ($overwrite -ne "y" -and $overwrite -ne "Y") {
    Write-Host "[INFO] Exiting without changes." -ForegroundColor Cyan
    exit 0
  }
  Write-Host "[INFO] Will download into existing directory (skipping existing files)." -ForegroundColor Cyan
}
else {
  New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null
  Write-Host "[INFO] Created directory: $TargetDir" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "==========================================" -ForegroundColor Yellow
Write-Host "Download Options" -ForegroundColor Yellow
Write-Host "==========================================" -ForegroundColor Yellow
Write-Host "1) Download ALL programs + README"
Write-Host "2) Download a SINGLE program"
Write-Host "3) Exit"
Write-Host "==========================================" -ForegroundColor Yellow
$choice = Read-Host "Enter your choice [1-3]"

if ($choice -eq "3") {
  Write-Host "[INFO] Exiting..." -ForegroundColor Cyan
  exit 0
}

if ($choice -eq "1") {
  Write-Host ""
  Write-Host "[INFO] Downloading all programs and README..." -ForegroundColor Cyan
  $failed = 0
  if (-not (Download-File "$RawBase/README.md" "$TargetDir\README.md")) { $failed++ }
  for ($i = 0; $i -lt $Files.Count; $i++) {
    $file = $Files[$i]
    $dest = "$TargetDir\$file"
    if (Test-Path $dest) {
      Write-Host "[SKIP] $file already exists" -ForegroundColor Yellow
      continue
    }
    if (-not (Download-File "$RawBase/$file" $dest)) { $failed++ }
  }
  Write-Host ""
  Write-Host "==========================================" -ForegroundColor Yellow
  if ($failed -eq 0) {
    Write-Host "[DONE] All files saved at: $TargetDir\" -ForegroundColor Green
  }
  else {
    Write-Host "[WARNING] $failed file(s) failed to download." -ForegroundColor Red
    Write-Host "[INFO] Files saved at: $TargetDir\" -ForegroundColor Cyan
  }
  Write-Host "==========================================" -ForegroundColor Yellow
  $count = (Get-ChildItem -Path $TargetDir -Filter "*.cpp" | Measure-Object).Count
  Write-Host "Total .cpp files: $count"
  if (Test-Path "$TargetDir\README.md") { Write-Host "README.md: present" } else { Write-Host "README.md: missing" }
  Write-Host "==========================================" -ForegroundColor Yellow
  if ($failed -gt 0) { exit 1 }
}
elseif ($choice -eq "2") {
  Write-Host ""
  Write-Host "==========================================" -ForegroundColor Yellow
  Write-Host "Select a program to download" -ForegroundColor Yellow
  Write-Host "==========================================" -ForegroundColor Yellow
  for ($i = 0; $i -lt $Names.Count; $i++) {
    Write-Host $Names[$i]
  }
  Write-Host "==========================================" -ForegroundColor Yellow
  $num = Read-Host "Enter number [1-18]"
  $nint = [int]$num
  if ($nint -lt 1 -or $nint -gt 18) {
    Write-Host "[ERROR] Invalid selection." -ForegroundColor Red
    exit 1
  }
  $idx = $nint - 1
  $file = $Files[$idx]
  $dest = "$TargetDir\$file"
  if (Test-Path $dest) {
    Write-Host "[INFO] File already exists: $dest" -ForegroundColor Cyan
    Write-Host "[DONE] Saved files at: $dest" -ForegroundColor Green
    exit 0
  }
  if (Download-File "$RawBase/$file" $dest) {
    Write-Host "[DONE] Saved files at: $TargetDir\" -ForegroundColor Green
  }
  else {
    exit 1
  }
}
else {
  Write-Host "[ERROR] Invalid choice." -ForegroundColor Red
  exit 1
}
