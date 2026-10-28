#include <iostream>
using namespace std;

// Node of the tree
struct Node {
    int data;
    Node *left, *right;
};

// Create a new node
Node* newNode(int x) {
    Node* n = new Node;       // allocate memory
    n->data = x;
    n->left = NULL;           // no children yet
    n->right = NULL;
    return n;
}

// Insert into BST (smaller goes left, larger goes right)
Node* insert(Node* root, int x) {
    if (root == NULL)                     // empty spot found
        return newNode(x);
    if (x < root->data)
        root->left = insert(root->left, x);
    else
        root->right = insert(root->right, x);
    return root;
}

// Search a value in BST
bool search(Node* root, int x) {
    if (root == NULL) return false;       // reached end, not found
    if (root->data == x) return true;     // found
    if (x < root->data)
        return search(root->left, x);     // go left
    return search(root->right, x);        // go right
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

int findMin(Node* root) {
    while (root->left != NULL)            // keep going left
        root = root->left;
    return root->data;
}

int findMax(Node* root) {
    while (root->right != NULL)           // keep going right
        root = root->right;
    return root->data;
}

int main() {
    Node* root = NULL;                    // empty tree
    int choice, x, n;

    do {
        cout << "\n1. Create BST\n2. Insert a node\n3. Search a node\n4. Traverse\n5. Find Min & Max\n6. Exit\nEnter choice: ";
        cin >> choice;

        switch (choice) {
            case 1:
                root = NULL;              // reset tree
                cout << "How many nodes? ";
                cin >> n;
                for (int i = 0; i < n; i++) {
                    cout << "Enter value: ";
                    cin >> x;
                    root = insert(root, x);
                }
                break;
            case 2:
                cout << "Enter value: ";
                cin >> x;
                root = insert(root, x);
                break;
            case 3:
                cout << "Enter value to search: ";
                cin >> x;
                if (search(root, x)) cout << "Found!\n";
                else cout << "Not found!\n";
                break;
            case 4:
                cout << "Inorder: ";   inorder(root);   cout << endl;
                cout << "Preorder: ";  preorder(root);  cout << endl;
                cout << "Postorder: "; postorder(root); cout << endl;
                break;
            case 5:
                if (root == NULL) cout << "Tree is empty.\n";
                else {
                    cout << "Minimum: " << findMin(root) << endl;
                    cout << "Maximum: " << findMax(root) << endl;
                }
                break;
            case 6: cout << "Exiting...\n"; break;
            default: cout << "Invalid choice!\n";
        }
    } while (choice != 6);

    return 0;
}
