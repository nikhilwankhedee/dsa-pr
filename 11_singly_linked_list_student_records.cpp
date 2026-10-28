#include <iostream>
using namespace std;

struct Node {
    int roll;
    Node* next;               // pointer to next node
};

Node* head = NULL;            // start of list (empty)

void insertBegin(int x) {
    Node* n = new Node;
    n->roll = x;
    n->next = head;           // new node points to old first node
    head = n;                 // head now points to new node
}

void insertEnd(int x) {
    Node* n = new Node;
    n->roll = x;
    n->next = NULL;           // last node points to NULL

    if (head == NULL)         // list empty
        head = n;
    else {
        Node* temp = head;
        while (temp->next != NULL)   // go to last node
            temp = temp->next;
        temp->next = n;       // attach new node at end
    }
}

void deleteNode(int x) {
    if (head == NULL) {
        cout << "List is empty.\n";
        return;
    }
    if (head->roll == x) {    // first node is to be deleted
        Node* t = head;
        head = head->next;    // move head forward
        delete t;             // free memory
        cout << "Deleted.\n";
        return;
    }
    Node* temp = head;
    while (temp->next != NULL && temp->next->roll != x)  // find node before target
        temp = temp->next;

    if (temp->next == NULL)
        cout << "Roll number not found.\n";
    else {
        Node* t = temp->next;
        temp->next = t->next; // skip the target node
        delete t;
        cout << "Deleted.\n";
    }
}

void display() {
    if (head == NULL) {
        cout << "List is empty.\n";
        return;
    }
    Node* temp = head;
    while (temp != NULL) {    // visit each node
        cout << temp->roll << " -> ";
        temp = temp->next;
    }
    cout << "NULL\n";
}

int main() {
    int choice, x;
    do {
        cout << "\n1. Insert at beginning\n2. Insert at end\n3. Delete by roll number\n4. Display\n5. Exit\nEnter choice: ";
        cin >> choice;

        switch (choice) {
            case 1: cout << "Enter roll no: "; cin >> x; insertBegin(x); break;
            case 2: cout << "Enter roll no: "; cin >> x; insertEnd(x); break;
            case 3: cout << "Enter roll no to delete: "; cin >> x; deleteNode(x); break;
            case 4: display(); break;
            case 5: cout << "Exiting...\n"; break;
            default: cout << "Invalid choice!\n";
        }
    } while (choice != 5);

    return 0;
}
