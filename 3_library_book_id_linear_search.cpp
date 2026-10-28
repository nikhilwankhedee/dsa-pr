#include <iostream>
using namespace std;

int main() {
    int books[100], n, key, found = 0;

    cout << "Enter number of books: ";
    cin >> n;

    cout << "Enter book IDs:\n";
    for (int i = 0; i < n; i++)
        cin >> books[i];

    cout << "Enter book ID to search: ";
    cin >> key;

    for (int i = 0; i < n; i++) {
        if (books[i] == key) {                       // match found
            cout << "Book found at position " << i + 1 << endl;  // +1 for human-friendly position
            found = 1;                               // mark as found
            break;                                   // stop searching
        }
    }

    if (found == 0)
        cout << "Book not available in the library.\n";

    return 0;
}
