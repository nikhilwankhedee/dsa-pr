#include <iostream>
using namespace std;

// Binary search works only on sorted array
int binarySearch(int arr[], int n, int key) {
    int low = 0, high = n - 1;         // start and end of search range

    while (low <= high) {
        int mid = (low + high) / 2;    // middle index

        if (arr[mid] == key)           // found at middle
            return mid;
        else if (key < arr[mid])       // key is in left half
            high = mid - 1;
        else                           // key is in right half
            low = mid + 1;
    }
    return -1;                         // not found
}

int main() {
    int roll[100], n, key;

    cout << "Enter number of students: ";
    cin >> n;

    cout << "Enter roll numbers in SORTED (ascending) order:\n";
    for (int i = 0; i < n; i++)
        cin >> roll[i];

    cout << "Enter roll number to search: ";
    cin >> key;

    int pos = binarySearch(roll, n, key);

    if (pos != -1)
        cout << "Student attended the training program.\n";
    else
        cout << "Student did NOT attend the training program.\n";

    return 0;
}
