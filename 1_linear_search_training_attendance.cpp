#include <iostream>
using namespace std;

// Function to search roll number using linear search
int linearSearch(int arr[], int n, int key) {
    for (int i = 0; i < n; i++) {      // check every element one by one
        if (arr[i] == key)             // if match found
            return i;                  // return its position
    }
    return -1;                         // not found
}

int main() {
    int roll[100], n, key;

    cout << "Enter number of students who attended: ";
    cin >> n;

    cout << "Enter roll numbers (any order):\n";
    for (int i = 0; i < n; i++)
        cin >> roll[i];                // store roll numbers

    cout << "Enter roll number to search: ";
    cin >> key;

    int pos = linearSearch(roll, n, key);   // call search function

    if (pos != -1)
        cout << "Student attended the training program.\n";
    else
        cout << "Student did NOT attend the training program.\n";

    return 0;
}
