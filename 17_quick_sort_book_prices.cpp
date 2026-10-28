#include <iostream>
using namespace std;

int order;   // 1 = ascending, 2 = descending

int partition(float arr[], int low, int high) {
    float pivot = arr[high];              // last element as pivot
    int i = low - 1;

    for (int j = low; j < high; j++) {
        if ((order == 1 && arr[j] < pivot) || (order == 2 && arr[j] > pivot)) {
            i++;
            float t = arr[i]; arr[i] = arr[j]; arr[j] = t;   // swap
        }
    }
    float t = arr[i + 1]; arr[i + 1] = arr[high]; arr[high] = t;  // place pivot
    return i + 1;
}

void quickSort(float arr[], int low, int high) {
    if (low < high) {
        int p = partition(arr, low, high);
        quickSort(arr, low, p - 1);       // sort left of pivot
        quickSort(arr, p + 1, high);      // sort right of pivot
    }
}

int main() {
    float price[100];
    int n;

    cout << "Enter number of books: ";
    cin >> n;

    cout << "Enter prices:\n";
    for (int i = 0; i < n; i++)
        cin >> price[i];

    cout << "1. Ascending\n2. Descending\nEnter choice: ";
    cin >> order;

    quickSort(price, 0, n - 1);

    cout << "Sorted prices: ";
    for (int i = 0; i < n; i++)
        cout << price[i] << " ";
    cout << endl;

    return 0;
}
