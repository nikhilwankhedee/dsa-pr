#!/usr/bin/env bash

REPO_URL="git@github.com:nikhilwankhedee/dsa-pr.git"
REPO_HTTPS_URL="https://github.com/nikhilwankhedee/dsa-pr.git"
RAW_BASE="https://raw.githubusercontent.com/nikhilwankhedee/dsa-pr/main"
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

echo "=========================================="
echo "DSA PR Programs Installer"
echo "=========================================="
echo ""

if [ -d "$TARGET_DIR" ]; then
  echo "[INFO] Directory '$TARGET_DIR' already exists."
  read -p "Do you want to overwrite/remove it and re-clone? (y/N): " overwrite
  if [[ "$overwrite" =~ ^[Yy]$ ]]; then
    echo "[INFO] Removing existing $TARGET_DIR..."
    rm -rf "$TARGET_DIR"
  else
    echo "[INFO] Using existing directory."
  fi
fi

if [ ! -d "$TARGET_DIR" ]; then
  if command -v git >/dev/null 2>&1; then
    echo "[INFO] Cloning repo..."
    echo "[INFO] Repo: $REPO_URL"
    if git clone "$REPO_URL" "$TARGET_DIR" 2>&1; then
      echo "[SUCCESS] Repo cloned successfully."
    else
      echo "[WARN] SSH clone failed, trying HTTPS..."
      echo "[INFO] Repo: $REPO_HTTPS_URL"
      git clone "$REPO_HTTPS_URL" "$TARGET_DIR"
      if [ $? -eq 0 ]; then
        echo "[SUCCESS] Repo cloned successfully via HTTPS."
      else
        echo "[ERROR] Failed to clone repo."
        exit 1
      fi
    fi
  else
    echo "[WARN] git not found. Downloading files directly..."
    mkdir -p "$TARGET_DIR"
  fi
fi

echo ""
echo "=========================================="
echo "Download Options"
echo "=========================================="
echo "1) Download ALL programs"
echo "2) Download a SINGLE program"
echo "3) Exit"
echo "=========================================="
read -p "Enter your choice [1-3]: " choice

if [ "$choice" = "3" ]; then
  echo "[INFO] Exiting..."
  exit 0
fi

if [ "$choice" = "1" ]; then
  echo ""
  echo "[INFO] Downloading all programs..."
  mkdir -p "$TARGET_DIR"
  
  for i in "${!FILES[@]}"; do
    file="${FILES[$i]}"
    dest="$TARGET_DIR/$file"
    
    if [ -f "$dest" ] && [ -d "$TARGET_DIR/.git" ]; then
      echo "[SKIP] $file already exists (from git clone)"
      continue
    fi
    
    if [ -d "$TARGET_DIR/.git" ]; then
      echo "[SKIP] $file present from repo"
      continue
    fi
    
    echo "[INFO] Saving file at: $dest"
    if command -v curl >/dev/null 2>&1; then
      curl -fsSL "$RAW_BASE/$file" -o "$dest"
    elif command -v wget >/dev/null 2>&1; then
      wget -q "$RAW_BASE/$file" -O "$dest"
    else
      echo "[ERROR] Neither curl nor wget found."
      exit 1
    fi
    
    if [ -f "$dest" ] && [ -s "$dest" ]; then
      echo "[SUCCESS] Saved files at: $TARGET_DIR/$file"
    else
      echo "[ERROR] Failed to download $file"
    fi
  done
  
  echo ""
  echo "=========================================="
  echo "[DONE] All files saved at: $TARGET_DIR/"
  echo "=========================================="
  ls -1 "$TARGET_DIR"/*.cpp 2>&1 | wc -l | xargs echo "Total .cpp files:"
  echo "=========================================="
  
elif [ "$choice" = "2" ]; then
  echo ""
  echo "=========================================="
  echo "Select a program to download"
  echo "=========================================="
  for name in "${NAMES[@]}"; do
    echo "$name"
  done
  echo "=========================================="
  read -p "Enter number [1-18]: " num
  
  if ! [[ "$num" =~ ^[0-9]+$ ]] || [ "$num" -lt 1 ] || [ "$num" -gt 18 ]; then
    echo "[ERROR] Invalid selection."
    exit 1
  fi
  
  idx=$((num - 1))
  file="${FILES[$idx]}"
  dest="$TARGET_DIR/$file"
  mkdir -p "$TARGET_DIR"
  
  if [ -d "$TARGET_DIR/.git" ] && [ -f "$dest" ]; then
    echo "[INFO] File exists from cloned repo: $dest"
    echo "[DONE] Saved files at: $dest"
    exit 0
  fi
  
  echo "[INFO] Saving file at: $dest"
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$RAW_BASE/$file" -o "$dest"
  elif command -v wget >/dev/null 2>&1; then
    wget -q "$RAW_BASE/$file" -O "$dest"
  else
    echo "[ERROR] Neither curl nor wget found."
    exit 1
  fi
  
  if [ -f "$dest" ] && [ -s "$dest" ]; then
    echo "[SUCCESS] Saved file at: $dest"
    echo "[DONE] Saved files at: $TARGET_DIR/"
  else
    echo "[ERROR] Failed to download $file"
    exit 1
  fi
  
else
  echo "[ERROR] Invalid choice."
  exit 1
fi
