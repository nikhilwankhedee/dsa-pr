#include <iostream>
using namespace std;

#define SIZE 5

int queue[SIZE];        // array to hold queue
int front = 0;          // index of first element
int rear = -1;          // index of last element

void enqueue(int x) {
    if (rear == SIZE - 1)                // queue full
        cout << "Queue Overflow!\n";
    else {
        rear++;                          // move rear forward
        queue[rear] = x;                 // insert at rear
        cout << x << " inserted.\n";
    }
}

void dequeue() {
    if (front > rear)                    // queue empty
        cout << "Queue Underflow!\n";
    else {
        cout << queue[front] << " removed.\n";
        front++;                         // move front forward
    }
}

void showFront() {
    if (front > rear)
        cout << "Queue is empty.\n";
    else
        cout << "Front element: " << queue[front] << endl;
}

void display() {
    if (front > rear)
        cout << "Queue is empty.\n";
    else {
        cout << "Queue elements: ";
        for (int i = front; i <= rear; i++)
            cout << queue[i] << " ";
        cout << endl;
    }
}

int main() {
    int choice, x;
    do {
        cout << "\n1. Enqueue\n2. Dequeue\n3. Display Front\n4. Display All\n5. Exit\nEnter choice: ";
        cin >> choice;

        switch (choice) {
            case 1: cout << "Enter element: "; cin >> x; enqueue(x); break;
            case 2: dequeue(); break;
            case 3: showFront(); break;
            case 4: display(); break;
            case 5: cout << "Exiting...\n"; break;
            default: cout << "Invalid choice!\n";
        }
    } while (choice != 5);

    return 0;
}
