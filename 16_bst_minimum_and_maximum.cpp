#include <iostream>
using namespace std;

struct Node {
    int data;
    Node *left, *right;
};

Node* insert(Node* root, int x) {
    if (root == NULL) {                   // empty place: create node
        Node* n = new Node;
        n->data = x;
        n->left = n->right = NULL;
        return n;
    }
    if (x < root->data)
        root->left = insert(root->left, x);    // smaller => left
    else
        root->right = insert(root->right, x);  // larger => right
    return root;
}

int main() {
    Node* root = NULL;
    int n, x;

    cout << "Enter number of nodes: ";
    cin >> n;
    cout << "Enter values:\n";
    for (int i = 0; i < n; i++) {
        cin >> x;
        root = insert(root, x);
    }

    if (root == NULL) {
        cout << "Tree is empty.\n";
        return 0;
    }

    Node* temp = root;
    while (temp->left != NULL)            // minimum is the leftmost node
        temp = temp->left;
    cout << "Minimum value: " << temp->data << endl;

    temp = root;
    while (temp->right != NULL)           // maximum is the rightmost node
        temp = temp->right;
    cout << "Maximum value: " << temp->data << endl;

    return 0;
}
