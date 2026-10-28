#include <iostream>
using namespace std;

int main() {
    int roll[100], n, key;

    cout << "Enter number of students: ";
    cin >> n;

    cout << "Enter roll numbers in ascending order:\n";
    for (int i = 0; i < n; i++)
        cin >> roll[i];

    cout << "Enter roll number to search: ";
    cin >> key;

    int low = 0, high = n - 1, found = 0;

    while (low <= high) {
        int mid = (low + high) / 2;          // find middle

        if (roll[mid] == key) {              // match
            cout << "Roll number found at position " << mid + 1 << endl;
            found = 1;
            break;
        }
        else if (key < roll[mid])
            high = mid - 1;                  // search left half
        else
            low = mid + 1;                   // search right half
    }

    if (found == 0)
        cout << "Student record not found.\n";

    return 0;
}
