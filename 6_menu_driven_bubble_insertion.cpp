#include <iostream>
using namespace std;

// Bubble sort: repeatedly swap adjacent elements if out of order
void bubbleSort(int a[], int n) {
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (a[j] > a[j + 1]) {             // compare neighbours
                int t = a[j]; a[j] = a[j + 1]; a[j + 1] = t;   // swap
            }
        }
    }
}

// Insertion sort: insert each element into its correct place on the left
void insertionSort(int a[], int n) {
    for (int i = 1; i < n; i++) {
        int key = a[i];                        // element to insert
        int j = i - 1;
        while (j >= 0 && a[j] > key) {         // shift bigger elements right
            a[j + 1] = a[j];
            j--;
        }
        a[j + 1] = key;                        // place key
    }
}

void display(int a[], int n) {
    for (int i = 0; i < n; i++)
        cout << a[i] << " ";
    cout << endl;
}

int main() {
    int marks[100], temp[100], n, choice;

    cout << "Enter number of students: ";
    cin >> n;
    cout << "Enter marks:\n";
    for (int i = 0; i < n; i++)
        cin >> marks[i];

    do {
        cout << "\n--- MENU ---\n1. Bubble Sort\n2. Insertion Sort\n3. Exit\nEnter choice: ";
        cin >> choice;

        for (int i = 0; i < n; i++)
            temp[i] = marks[i];                // copy so original stays unsorted

        if (choice == 1) {
            bubbleSort(temp, n);
            cout << "Sorted (Bubble): ";
            display(temp, n);
        }
        else if (choice == 2) {
            insertionSort(temp, n);
            cout << "Sorted (Insertion): ";
            display(temp, n);
        }
        else if (choice != 3)
            cout << "Invalid choice!\n";

    } while (choice != 3);                     // repeat until Exit

    return 0;
}
