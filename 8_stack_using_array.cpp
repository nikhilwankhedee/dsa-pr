#include <iostream>
using namespace std;

#define SIZE 5          // maximum stack size

int stack[SIZE];        // array to hold the stack
int top = -1;           // -1 means stack is empty

void push(int x) {
    if (top == SIZE - 1)                 // stack full
        cout << "Stack Overflow!\n";
    else {
        top++;                           // move top up
        stack[top] = x;                  // store element
        cout << x << " pushed.\n";
    }
}

void pop() {
    if (top == -1)                       // stack empty
        cout << "Stack Underflow!\n";
    else {
        cout << stack[top] << " popped.\n";
        top--;                           // move top down
    }
}

void peek() {
    if (top == -1)
        cout << "Stack is empty.\n";
    else
        cout << "Top element: " << stack[top] << endl;
}

void display() {
    if (top == -1)
        cout << "Stack is empty.\n";
    else {
        cout << "Stack elements (top to bottom): ";
        for (int i = top; i >= 0; i--)   // print from top to bottom
            cout << stack[i] << " ";
        cout << endl;
    }
}

int main() {
    int choice, x;
    do {
        cout << "\n1. Push\n2. Pop\n3. Display Top\n4. Display All\n5. Exit\nEnter choice: ";
        cin >> choice;

        switch (choice) {
            case 1: cout << "Enter element: "; cin >> x; push(x); break;
            case 2: pop(); break;
            case 3: peek(); break;
            case 4: display(); break;
            case 5: cout << "Exiting...\n"; break;
            default: cout << "Invalid choice!\n";
        }
    } while (choice != 5);

    return 0;
}
