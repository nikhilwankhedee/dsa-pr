#include <iostream>
using namespace std;

#define SIZE 10                 // table size
#define EMPTY -1                // slot never used
#define DELETED -2              // slot used earlier, now deleted

int table[SIZE];

int hashFunc(int key) {
    return key % SIZE;          // simple hash function
}

void create() {
    for (int i = 0; i < SIZE; i++)
        table[i] = EMPTY;       // mark all slots empty
    cout << "Hash table created.\n";
}

void insertKey(int key) {
    int index = hashFunc(key);
    for (int i = 0; i < SIZE; i++) {
        int pos = (index + i) % SIZE;            // linear probing: try next slot
        if (table[pos] == EMPTY || table[pos] == DELETED) {
            table[pos] = key;                    // free slot found
            cout << "Inserted at index " << pos << endl;
            return;
        }
    }
    cout << "Hash table is full!\n";
}

void searchKey(int key) {
    int index = hashFunc(key);
    for (int i = 0; i < SIZE; i++) {
        int pos = (index + i) % SIZE;
        if (table[pos] == EMPTY) break;          // empty slot => key not present
        if (table[pos] == key) {
            cout << "Found at index " << pos << endl;
            return;
        }
    }
    cout << "Element not found.\n";
}

void deleteKey(int key) {
    int index = hashFunc(key);
    for (int i = 0; i < SIZE; i++) {
        int pos = (index + i) % SIZE;
        if (table[pos] == EMPTY) break;
        if (table[pos] == key) {
            table[pos] = DELETED;                // mark as deleted (keeps probing chain)
            cout << "Deleted from index " << pos << endl;
            return;
        }
    }
    cout << "Element not found.\n";
}

void display() {
    for (int i = 0; i < SIZE; i++) {
        cout << i << " : ";
        if (table[i] == EMPTY) cout << "Empty";
        else if (table[i] == DELETED) cout << "Deleted";
        else cout << table[i];
        cout << endl;
    }
}

int main() {
    int choice, x;
    create();                                    // initialise table at start

    do {
        cout << "\n1. Create (reset)\n2. Insert\n3. Search\n4. Delete\n5. Display\n6. Exit\nEnter choice: ";
        cin >> choice;

        switch (choice) {
            case 1: create(); break;
            case 2: cout << "Enter element: "; cin >> x; insertKey(x); break;
            case 3: cout << "Enter element: "; cin >> x; searchKey(x); break;
            case 4: cout << "Enter element: "; cin >> x; deleteKey(x); break;
            case 5: display(); break;
            case 6: cout << "Exiting...\n"; break;
            default: cout << "Invalid choice!\n";
        }
    } while (choice != 6);

    return 0;
}
