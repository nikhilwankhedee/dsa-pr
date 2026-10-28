#!/usr/bin/env bash
# Cross-platform bootstrapper - routes to appropriate installer

RAW_BASE="https://raw.githubusercontent.com/nikhilwankhedee/dsa-pr/main"

# Detect PowerShell on Windows/cross-platform
if [ -n "$PSModulePath" ] || [ -n "$POWERSHELL_DISTRIBUTION_CHANNEL" ] || command -v pwsh >/dev/null 2>&1 || command -v powershell >/dev/null 2>&1; then
  if [ "$(uname -s 2>/dev/null)" = "Linux" ] || [ "$(uname -s 2>/dev/null)" = "Darwin" ] || [ -z "$(uname -s 2>/dev/null)" ]; then
    : # might be WSL or unknown, but prefer bash unless explicitly in PS
  fi
fi

# If running under PowerShell (heavier check), switch to PS installer
if [ -n "$PSHOME" ] || [ "$OS" = "Windows_NT" ] 2>/dev/null; then
  if command -v powershell >/dev/null 2>&1; then
    powershell -NoProfile -ExecutionPolicy Bypass -Command "& { iex ((New-Object Net.WebClient).DownloadString('$RAW_BASE/install.ps1')) }"
    exit $?
  elif command -v pwsh >/dev/null 2>&1; then
    pwsh -NoProfile -ExecutionPolicy Bypass -Command "& { iex ((New-Object Net.WebClient).DownloadString('$RAW_BASE/install.ps1')) }"
    exit $?
  fi
fi

# Unix/Linux/macOS installer
TARGET_DIR="./dsa-pr"

FILES=(
  "1_linear_search_training_attendance.cpp"
  "2_binary_search_training_attendance.cpp"
  "3_library_book_id_linear_search.cpp"
  "4_student_roll_number_binary_search.cpp"
  "5_quick_sort_player_scores.cpp"
  "6_menu_driven_bubble_insertion.cpp"
  "7_menu_driven_selection_insertion.cpp"
  "8_stack_using_array.cpp"
  "9_queue_using_array.cpp"
  "10_binary_search_tree_menu_driven.cpp"
  "11_singly_linked_list_student_records.cpp"
  "12_prim_and_kruskal_mst.cpp"
  "13_hash_table_with_linear_probing.cpp"
  "14_circular_queue_using_array.cpp"
  "15_binary_tree_inorder_preorder_postorder.cpp"
  "16_bst_minimum_and_maximum.cpp"
  "17_quick_sort_book_prices.cpp"
  "18_queue_using_linked_list.cpp"
)

NAMES=(
  "1) Linear Search: Training Attendance"
  "2) Binary Search: Training Attendance"
  "3) Library Book ID: Linear Search"
  "4) Student Roll Number: Binary Search"
  "5) Quick Sort: Player Scores"
  "6) Menu-Driven: Bubble Sort & Insertion Sort"
  "7) Menu-Driven: Selection Sort & Insertion Sort"
  "8) Stack using Array"
  "9) Queue using Array"
  "10) Binary Search Tree: Menu Driven"
  "11) Singly Linked List: Student Records"
  "12) Prim's and Kruskal's MST"
  "13) Hash Table with Linear Probing"
  "14) Circular Queue using Array"
  "15) Binary Tree with Inorder, Preorder, Postorder"
  "16) BST: Minimum and Maximum"
  "17) Quick Sort: Book Prices"
  "18) Queue using Linked List"
)

read_input() {
  local prompt="$1"
  local var="$2"
  if [ -r /dev/tty ] && [ -t 1 ]; then
    read -p "$prompt" "$var" </dev/tty
  elif [ -t 0 ]; then
    read -p "$prompt" "$var"
  else
    read -p "$prompt" "$var" </dev/stdin 2>/dev/null || printf "%s" "$prompt" >&2; read "$var"
  fi
}

download_file() {
  local url="$1"
  local dest="$2"
  local name="$(basename "$dest")"
  mkdir -p "$(dirname "$dest")"
  echo "[INFO] Saving file at: $dest"
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL --connect-timeout 60 "$url" -o "$dest" || return 1
  elif command -v wget >/dev/null 2>&1; then
    wget -T 60 -q "$url" -O "$dest" || return 1
  else
    echo "[ERROR] Neither curl nor wget found."
    return 1
  fi
  if [ -f "$dest" ] && [ -s "$dest" ]; then
    echo "[SUCCESS] Saved files at: $dest"
    return 0
  fi
  echo "[ERROR] Failed to download $name"
  return 1
}

echo "=========================================="
echo "DSA PR Programs Installer (Linux/macOS)"
echo "=========================================="
echo ""

if [ -d "$TARGET_DIR" ]; then
  echo "[INFO] Directory '$TARGET_DIR' already exists."
  echo "[INFO] Existing files will not be deleted."
  read_input "Do you want to download into this directory anyway? (y/N): " overwrite
  if [[ ! "$overwrite" =~ ^[Yy]$ ]]; then
    echo "[INFO] Exiting without changes."
    exit 0
  fi
  echo "[INFO] Will download into existing directory (skipping existing files)."
else
  mkdir -p "$TARGET_DIR"
  echo "[INFO] Created directory: $TARGET_DIR"
fi

echo ""
echo "=========================================="
echo "Download Options"
echo "=========================================="
echo "1) Download ALL programs + README"
echo "2) Download a SINGLE program"
echo "3) Exit"
echo "=========================================="
read_input "Enter your choice [1-3]: " choice

case "$choice" in
  3)
    echo "[INFO] Exiting..."
    exit 0
    ;;
  1)
    echo ""
    echo "[INFO] Downloading all programs and README..."
    failed=0
    download_file "$RAW_BASE/README.md" "$TARGET_DIR/README.md" || failed=$((failed+1))
    for i in "${!FILES[@]}"; do
      file="${FILES[$i]}"
      dest="$TARGET_DIR/$file"
      [ -f "$dest" ] && echo "[SKIP] $file already exists" && continue
      download_file "$RAW_BASE/$file" "$dest" || failed=$((failed+1))
    done
    echo ""
    echo "=========================================="
    if [ $failed -eq 0 ]; then
      echo "[DONE] All files saved at: $TARGET_DIR/"
    else
      echo "[WARNING] $failed file(s) failed to download."
      echo "[INFO] Files saved at: $TARGET_DIR/"
    fi
    echo "=========================================="
    count=$(find "$TARGET_DIR" -maxdepth 1 -name '*.cpp' | wc -l)
    echo "Total .cpp files: $count"
    [ -f "$TARGET_DIR/README.md" ] && echo "README.md: present" || echo "README.md: missing"
    echo "=========================================="
    [ $failed -gt 0 ] && exit 1
    ;;
  2)
    echo ""
    echo "=========================================="
    echo "Select a program to download"
    echo "=========================================="
    for name in "${NAMES[@]}"; do echo "$name"; done
    echo "=========================================="
    read_input "Enter number [1-18]: " num
    if ! [[ "$num" =~ ^[0-9]+$ ]] || [ "$num" -lt 1 ] || [ "$num" -gt 18 ]; then
      echo "[ERROR] Invalid selection."
      exit 1
    fi
    idx=$((num-1))
    file="${FILES[$idx]}"
    dest="$TARGET_DIR/$file"
    if [ -f "$dest" ]; then
      echo "[INFO] File already exists: $dest"
      echo "[DONE] Saved files at: $dest"
      exit 0
    fi
    download_file "$RAW_BASE/$file" "$dest" && echo "[DONE] Saved files at: $TARGET_DIR/" || exit 1
    ;;
  *)
    echo "[ERROR] Invalid choice."
    exit 1
    ;;
esac
