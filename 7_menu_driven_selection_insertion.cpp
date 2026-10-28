#include <iostream>
using namespace std;

// Selection sort: find the smallest and place it at the front
void selectionSort(int a[], int n) {
    for (int i = 0; i < n - 1; i++) {
        int min = i;                           // assume current is smallest
        for (int j = i + 1; j < n; j++) {
            if (a[j] < a[min])                 // found a smaller one
                min = j;
        }
        int t = a[i]; a[i] = a[min]; a[min] = t;   // swap into position
    }
}

// Insertion sort
void insertionSort(int a[], int n) {
    for (int i = 1; i < n; i++) {
        int key = a[i];
        int j = i - 1;
        while (j >= 0 && a[j] > key) {         // shift larger elements right
            a[j + 1] = a[j];
            j--;
        }
        a[j + 1] = key;
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
        cout << "\n--- MENU ---\n1. Selection Sort\n2. Insertion Sort\n3. Exit\nEnter choice: ";
        cin >> choice;

        for (int i = 0; i < n; i++)
            temp[i] = marks[i];                // fresh copy each time

        if (choice == 1) {
            selectionSort(temp, n);
            cout << "Sorted (Selection): ";
            display(temp, n);
        }
        else if (choice == 2) {
            insertionSort(temp, n);
            cout << "Sorted (Insertion): ";
            display(temp, n);
        }
        else if (choice != 3)
            cout << "Invalid choice!\n";

    } while (choice != 3);

    return 0;
}
