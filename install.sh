#!/usr/bin/env sh
# This is a cross-platform polyglot installer for Bash and PowerShell
# It will route to the appropriate native installer

# Detect PowerShell
if [ -n "$PSVersionTable" ] || [ -n "$POWERSHELL_DISTRIBUTION_CHANNEL" ]; then
    # Running in PowerShell - download and run PS installer
    if command -v powershell >/dev/null 2>&1; then
        powershell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-Expression (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/nikhilwankhedee/dsa-pr/main/install.ps1')" 2>/dev/null || exit $?
    elif command -v pwsh >/dev/null 2>&1; then
        pwsh -NoProfile -ExecutionPolicy Bypass -Command "Invoke-Expression (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/nikhilwankhedee/dsa-pr/main/install.ps1')" 2>/dev/null || exit $?
    fi
    exit 0
fi

# Check if running under Windows cmd/powershell
case "$(uname -s 2>/dev/null)" in
    CYGWIN*|MINGW*|MSYS*)
        if command -v powershell >/dev/null 2>&1; then
            powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/nikhilwankhedee/dsa-pr/main/install.ps1'))"
            exit $?
        fi
        ;;
esac

# Linux/macOS - run bash installer
RAW_BASE="https://raw.githubusercontent.com/nikhilwankhedee/dsa-pr/main"
TARGET_DIR="./dsa-pr"

FILES="1_linear_search_training_attendance.cpp 2_binary_search_training_attendance.cpp 3_library_book_id_linear_search.cpp 4_student_roll_number_binary_search.cpp 5_quick_sort_player_scores.cpp 6_menu_driven_bubble_insertion.cpp 7_menu_driven_selection_insertion.cpp 8_stack_using_array.cpp 9_queue_using_array.cpp 10_binary_search_tree_menu_driven.cpp 11_singly_linked_list_student_records.cpp 12_prim_and_kruskal_mst.cpp 13_hash_table_with_linear_probing.cpp 14_circular_queue_using_array.cpp 15_binary_tree_inorder_preorder_postorder.cpp 16_bst_minimum_and_maximum.cpp 17_quick_sort_book_prices.cpp 18_queue_using_linked_list.cpp"

read_input() {
  local prompt="$1"
  local var="$2"
  if [ -r /dev/tty ] && [ -t 1 ]; then
    printf "%s" "$prompt" > /dev/tty
    read "$var" < /dev/tty
  elif [ -t 0 ]; then
    printf "%s" "$prompt"
    read "$var"
  else
    printf "%s" "$prompt"
    read "$var" </dev/stdin 2>/dev/null || read "$var"
  fi
}

download_file() {
  local url="$1"
  local dest="$2"
  local name=$(basename "$dest")
  mkdir -p "$(dirname "$dest")"
  printf "[INFO] Saving file at: %s\n" "$dest"
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL --connect-timeout 60 "$url" -o "$dest" || return 1
  elif command -v wget >/dev/null 2>&1; then
    wget -T 60 -q "$url" -O "$dest" || return 1
  else
    printf "[ERROR] Neither curl nor wget found.\n"
    return 1
  fi
  if [ -f "$dest" ] && [ -s "$dest" ]; then
    printf "[SUCCESS] Saved files at: %s\n" "$dest"
    return 0
  fi
  printf "[ERROR] Failed to download %s\n" "$name"
  return 1
}

printf "==========================================\n"
printf "DSA PR Programs Installer (Linux/macOS)\n"
printf "==========================================\n\n"

if [ -d "$TARGET_DIR" ]; then
  printf "[INFO] Directory '%s' already exists.\n" "$TARGET_DIR"
  printf "[INFO] Existing files will not be deleted.\n"
  read_input "Do you want to download into this directory anyway? (y/N): " overwrite
  case "$overwrite" in
    y|Y) printf "[INFO] Will download into existing directory (skipping existing files).\n" ;;
    *) printf "[INFO] Exiting without changes.\n"; exit 0 ;;
  esac
else
  mkdir -p "$TARGET_DIR"
  printf "[INFO] Created directory: %s\n" "$TARGET_DIR"
fi

printf "\n==========================================\n"
printf "Download Options\n"
printf "==========================================\n"
printf "1) Download ALL programs + README\n"
printf "2) Download a SINGLE program\n"
printf "3) Exit\n"
printf "==========================================\n"
read_input "Enter your choice [1-3]: " choice

case "$choice" in
  3)
    printf "[INFO] Exiting...\n"
    exit 0
    ;;
  1)
    printf "\n[INFO] Downloading all programs and README...\n"
    failed=0
    download_file "$RAW_BASE/README.md" "$TARGET_DIR/README.md" || failed=$((failed+1))
    for file in $FILES; do
      dest="$TARGET_DIR/$file"
      if [ -f "$dest" ]; then
        printf "[SKIP] %s already exists\n" "$file"
        continue
      fi
      download_file "$RAW_BASE/$file" "$dest" || failed=$((failed+1))
    done
    printf "\n==========================================\n"
    if [ $failed -eq 0 ]; then
      printf "[DONE] All files saved at: %s/\n" "$TARGET_DIR"
    else
      printf "[WARNING] %d file(s) failed to download.\n" "$failed"
      printf "[INFO] Files saved at: %s/\n" "$TARGET_DIR"
    fi
    printf "==========================================\n"
    count=$(find "$TARGET_DIR" -maxdepth 1 -name '*.cpp' 2>/dev/null | wc -l | tr -d ' ')
    printf "Total .cpp files: %s\n" "$count"
    if [ -f "$TARGET_DIR/README.md" ]; then printf "README.md: present\n"; else printf "README.md: missing\n"; fi
    printf "==========================================\n"
    [ $failed -gt 0 ] && exit 1
    ;;
  2)
    printf "\n==========================================\n"
    printf "Select a program to download\n"
    printf "==========================================\n"
    printf "1) Linear Search: Training Attendance\n"
    printf "2) Binary Search: Training Attendance\n"
    printf "3) Library Book ID: Linear Search\n"
    printf "4) Student Roll Number: Binary Search\n"
    printf "5) Quick Sort: Player Scores\n"
    printf "6) Menu-Driven: Bubble Sort & Insertion Sort\n"
    printf "7) Menu-Driven: Selection Sort & Insertion Sort\n"
    printf "8) Stack using Array\n"
    printf "9) Queue using Array\n"
    printf "10) Binary Search Tree: Menu Driven\n"
    printf "11) Singly Linked List: Student Records\n"
    printf "12) Prim's and Kruskal's MST\n"
    printf "13) Hash Table with Linear Probing\n"
    printf "14) Circular Queue using Array\n"
    printf "15) Binary Tree with Inorder, Preorder, Postorder\n"
    printf "16) BST: Minimum and Maximum\n"
    printf "17) Quick Sort: Book Prices\n"
    printf "18) Queue using Linked List\n"
    printf "==========================================\n"
    read_input "Enter number [1-18]: " num
    case "$num" in
      1) file="1_linear_search_training_attendance.cpp";;
      2) file="2_binary_search_training_attendance.cpp";;
      3) file="3_library_book_id_linear_search.cpp";;
      4) file="4_student_roll_number_binary_search.cpp";;
      5) file="5_quick_sort_player_scores.cpp";;
      6) file="6_menu_driven_bubble_insertion.cpp";;
      7) file="7_menu_driven_selection_insertion.cpp";;
      8) file="8_stack_using_array.cpp";;
      9) file="9_queue_using_array.cpp";;
      10) file="10_binary_search_tree_menu_driven.cpp";;
      11) file="11_singly_linked_list_student_records.cpp";;
      12) file="12_prim_and_kruskal_mst.cpp";;
      13) file="13_hash_table_with_linear_probing.cpp";;
      14) file="14_circular_queue_using_array.cpp";;
      15) file="15_binary_tree_inorder_preorder_postorder.cpp";;
      16) file="16_bst_minimum_and_maximum.cpp";;
      17) file="17_quick_sort_book_prices.cpp";;
      18) file="18_queue_using_linked_list.cpp";;
      *) printf "[ERROR] Invalid selection.\n"; exit 1;;
    esac
    dest="$TARGET_DIR/$file"
    if [ -f "$dest" ]; then
      printf "[INFO] File already exists: %s\n" "$dest"
      printf "[DONE] Saved files at: %s\n" "$dest"
      exit 0
    fi
    if download_file "$RAW_BASE/$file" "$dest"; then
      printf "[DONE] Saved files at: %s/\n" "$TARGET_DIR"
    else
      exit 1
    fi
    ;;
  *)
    printf "[ERROR] Invalid choice.\n"
    exit 1
    ;;
esac
