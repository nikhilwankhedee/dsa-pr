#include <iostream>
using namespace std;

struct Node {
    int data;
    Node *left, *right;
};

// Create tree recursively: user enters -1 for "no node"
Node* createTree() {
    int x;
    cout << "Enter data (-1 for no node): ";
    cin >> x;

    if (x == -1)                          // no node here
        return NULL;

    Node* n = new Node;
    n->data = x;

    cout << "Enter left child of " << x << endl;
    n->left = createTree();               // build left subtree
    cout << "Enter right child of " << x << endl;
    n->right = createTree();              // build right subtree
    return n;
}

void inorder(Node* root) {                // Left, Root, Right
    if (root != NULL) {
        inorder(root->left);
        cout << root->data << " ";
        inorder(root->right);
    }
}

void preorder(Node* root) {               // Root, Left, Right
    if (root != NULL) {
        cout << root->data << " ";
        preorder(root->left);
        preorder(root->right);
    }
}

void postorder(Node* root) {              // Left, Right, Root
    if (root != NULL) {
        postorder(root->left);
        postorder(root->right);
        cout << root->data << " ";
    }
}

int main() {
    Node* root = createTree();

    cout << "\nInorder:   "; inorder(root);
    cout << "\nPreorder:  "; preorder(root);
    cout << "\nPostorder: "; postorder(root);
    cout << endl;

    return 0;
}
