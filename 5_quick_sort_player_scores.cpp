#include <iostream>
using namespace std;

int order;   // 1 = ascending, 2 = descending (global so functions can use it)

// Partition: places pivot at its correct position
int partition(int arr[], int low, int high) {
    int pivot = arr[high];               // last element as pivot
    int i = low - 1;                     // boundary of smaller elements

    for (int j = low; j < high; j++) {
        // ascending: move smaller than pivot; descending: move greater than pivot
        if ((order == 1 && arr[j] < pivot) || (order == 2 && arr[j] > pivot)) {
            i++;
            int t = arr[i]; arr[i] = arr[j]; arr[j] = t;   // swap
        }
    }
    int t = arr[i + 1]; arr[i + 1] = arr[high]; arr[high] = t;  // put pivot in place
    return i + 1;                        // pivot position
}

void quickSort(int arr[], int low, int high) {
    if (low < high) {
        int p = partition(arr, low, high);   // get pivot position
        quickSort(arr, low, p - 1);          // sort left part
        quickSort(arr, p + 1, high);         // sort right part
    }
}

int main() {
    int scores[100], n;

    cout << "Enter number of players: ";
    cin >> n;

    cout << "Enter scores:\n";
    for (int i = 0; i < n; i++)
        cin >> scores[i];

    cout << "1. Ascending\n2. Descending\nEnter choice: ";
    cin >> order;

    quickSort(scores, 0, n - 1);         // sort the array

    cout << "Sorted scores: ";
    for (int i = 0; i < n; i++)
        cout << scores[i] << " ";
    cout << endl;

    return 0;
}
