#include <iostream>
using namespace std;

#define SIZE 5

int cq[SIZE];
int front = -1, rear = -1;      // -1 means queue is empty

void insertItem(int x) {
    if ((rear + 1) % SIZE == front)          // next of rear is front => full
        cout << "Queue Overflow!\n";
    else {
        if (front == -1)                     // first element
            front = 0;
        rear = (rear + 1) % SIZE;            // wrap around using modulo
        cq[rear] = x;
        cout << x << " inserted.\n";
    }
}

void deleteItem() {
    if (front == -1)                         // empty
        cout << "Queue Underflow!\n";
    else {
        cout << cq[front] << " deleted.\n";
        if (front == rear)                   // only one element was present
            front = rear = -1;               // queue becomes empty
        else
            front = (front + 1) % SIZE;      // move front with wrap around
    }
}

void display() {
    if (front == -1) {
        cout << "Queue is empty.\n";
        return;
    }
    cout << "Queue elements: ";
    int i = front;
    while (true) {
        cout << cq[i] << " ";
        if (i == rear) break;                // reached last element
        i = (i + 1) % SIZE;                  // move forward circularly
    }
    cout << endl;
}

int main() {
    int choice, x;
    do {
        cout << "\n1. Insert\n2. Delete\n3. Display\n4. Exit\nEnter choice: ";
        cin >> choice;

        switch (choice) {
            case 1: cout << "Enter element: "; cin >> x; insertItem(x); break;
            case 2: deleteItem(); break;
            case 3: display(); break;
            case 4: cout << "Exiting...\n"; break;
            default: cout << "Invalid choice!\n";
        }
    } while (choice != 4);

    return 0;
}
