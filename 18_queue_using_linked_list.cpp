#include <iostream>
using namespace std;

struct Node {
    int data;
    Node* next;
};

Node* front = NULL;       // points to first node (remove from here)
Node* rear = NULL;        // points to last node (insert here)

void enqueue(int x) {
    Node* n = new Node;
    n->data = x;
    n->next = NULL;

    if (rear == NULL)                 // queue empty: node is both front and rear
        front = rear = n;
    else {
        rear->next = n;               // link new node after rear
        rear = n;                     // update rear
    }
    cout << x << " inserted.\n";
}

void dequeue() {
    if (front == NULL) {              // empty
        cout << "Queue Underflow!\n";
        return;
    }
    Node* t = front;
    cout << t->data << " removed.\n";
    front = front->next;              // move front forward
    if (front == NULL)                // queue became empty
        rear = NULL;
    delete t;                         // free memory
}

void showFront() {
    if (front == NULL)
        cout << "Queue is empty.\n";
    else
        cout << "Front element: " << front->data << endl;
}

void display() {
    if (front == NULL) {
        cout << "Queue is empty.\n";
        return;
    }
    Node* temp = front;
    cout << "Queue: ";
    while (temp != NULL) {            // traverse front to rear
        cout << temp->data << " ";
        temp = temp->next;
    }
    cout << endl;
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
