#!/usr/bin/env bash

REPO="nikhilwankhedee/dsa-pr"
RAW_BASE="https://raw.githubusercontent.com/${REPO}/main"
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
  "1) Linear Search: Training Attendance (random order)"
  "2) Binary Search: Training Attendance (sorted order)"
  "3) Library Book ID: Linear Search"
  "4) Student Roll Number: Binary Search"
  "5) Quick Sort: Player Scores (Ascending / Descending)"
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
  "17) Quick Sort: Book Prices (Ascending / Descending)"
  "18) Queue using Linked List"
)

# Function to read from /dev/tty for curl | bash compatibility
read_tty() {
  local prompt="$1"
  local varname="$2"
  if [ -t 0 ]; then
    read -p "$prompt" "$varname"
  elif [ -r /dev/tty ]; then
    read -p "$prompt" "$varname" </dev/tty
  else
    # Last resort - but should not happen in normal interactive use
    eval "$varname=''"
  fi
}

download_file() {
  local url="$1"
  local dest="$2"
  local name="$(basename "$dest")"
  
  mkdir -p "$(dirname "$dest")"
  echo "[INFO] Saving file at: $dest"
  
  if command -v curl >/dev/null 2>&1; then
    if curl -fsSL "$url" -o "$dest"; then
      if [ -f "$dest" ] && [ -s "$dest" ]; then
        echo "[SUCCESS] Saved files at: $dest"
        return 0
      fi
    fi
  elif command -v wget >/dev/null 2>&1; then
    if wget -q "$url" -O "$dest"; then
      if [ -f "$dest" ] && [ -s "$dest" ]; then
        echo "[SUCCESS] Saved files at: $dest"
        return 0
      fi
    fi
  fi
  
  echo "[ERROR] Failed to download $name from $url"
  return 1
}

echo "=========================================="
echo "DSA PR Programs Installer"
echo "=========================================="
echo ""

# Handle existing directory safely - never silently delete
if [ -d "$TARGET_DIR" ]; then
  echo "[INFO] Directory '$TARGET_DIR' already exists."
  echo "[INFO] Existing files will not be deleted."
  read_tty "Do you want to download into this directory anyway? (y/N): " overwrite
  if [[ ! "$overwrite" =~ ^[Yy]$ ]]; then
    echo "[INFO] Exiting without changes."
    exit 0
  fi
  echo "[INFO] Will download into existing directory (skipping files that already exist)."
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
read_tty "Enter your choice [1-3]: " choice

if [ "$choice" = "3" ]; then
  echo "[INFO] Exiting..."
  exit 0
fi

if [ "$choice" = "1" ]; then
  echo ""
  echo "[INFO] Downloading all programs and README..."
  failed=0
  
  # Download README first
  download_file "$RAW_BASE/README.md" "$TARGET_DIR/README.md" || failed=$((failed+1))
  
  # Download all .cpp files
  for i in "${!FILES[@]}"; do
    file="${FILES[$i]}"
    dest="$TARGET_DIR/$file"
    
    if [ -f "$dest" ]; then
      echo "[SKIP] $file already exists"
      continue
    fi
    
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
  count=$(ls -1 "$TARGET_DIR"/*.cpp 2>&1 | grep -c '\.cpp$' || echo 0)
  echo "Total .cpp files: $count"
  [ -f "$TARGET_DIR/README.md" ] && echo "README.md: present" || echo "README.md: missing"
  echo "=========================================="
  
  if [ $failed -gt 0 ]; then
    exit 1
  fi
  
elif [ "$choice" = "2" ]; then
  echo ""
  echo "=========================================="
  echo "Select a program to download"
  echo "=========================================="
  for name in "${NAMES[@]}"; do
    echo "$name"
  done
  echo "=========================================="
  read_tty "Enter number [1-18]: " num
  
  if ! [[ "$num" =~ ^[0-9]+$ ]] || [ "$num" -lt 1 ] || [ "$num" -gt 18 ]; then
    echo "[ERROR] Invalid selection."
    exit 1
  fi
  
  idx=$((num - 1))
  file="${FILES[$idx]}"
  dest="$TARGET_DIR/$file"
  
  if [ -f "$dest" ]; then
    echo "[INFO] File already exists: $dest"
    echo "[DONE] Saved files at: $dest"
    exit 0
  fi
  
  if download_file "$RAW_BASE/$file" "$dest"; then
    echo "[DONE] Saved files at: $TARGET_DIR/"
  else
    exit 1
  fi
  
else
  echo "[ERROR] Invalid choice."
  exit 1
fi
