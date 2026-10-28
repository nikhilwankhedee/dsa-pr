#include <iostream>
using namespace std;

#define MAX 20
#define INF 9999                  // represents "infinity"

int graph[MAX][MAX];              // adjacency matrix (0 = no edge)
int n;                            // number of vertices

// ---------- PRIM'S ALGORITHM ----------
void prim() {
    int visited[MAX] = {0};       // 1 if vertex is already in MST
    int total = 0;
    visited[0] = 1;               // start from vertex 0

    cout << "\nPrim's MST edges:\n";
    for (int count = 0; count < n - 1; count++) {
        int min = INF, a = -1, b = -1;

        for (int i = 0; i < n; i++) {
            if (visited[i]) {                         // i is inside MST
                for (int j = 0; j < n; j++) {
                    if (!visited[j] && graph[i][j] != 0 && graph[i][j] < min) {
                        min = graph[i][j];            // cheapest edge so far
                        a = i;
                        b = j;
                    }
                }
            }
        }
        if (a == -1) break;                           // graph not connected
        cout << a << " - " << b << " : " << min << endl;
        total += min;
        visited[b] = 1;                               // add new vertex to MST
    }
    cout << "Total weight = " << total << endl;
}

// ---------- KRUSKAL'S ALGORITHM ----------
int parent[MAX];

int findParent(int x) {                               // find set leader
    while (parent[x] != x)
        x = parent[x];
    return x;
}

void kruskal() {
    int u[MAX * MAX], v[MAX * MAX], w[MAX * MAX];     // edge list
    int e = 0;

    // collect each edge once (upper triangle of matrix)
    for (int i = 0; i < n; i++)
        for (int j = i + 1; j < n; j++)
            if (graph[i][j] != 0) {
                u[e] = i; v[e] = j; w[e] = graph[i][j];
                e++;
            }

    // sort edges by weight (bubble sort)
    for (int i = 0; i < e - 1; i++)
        for (int j = 0; j < e - i - 1; j++)
            if (w[j] > w[j + 1]) {
                int t;
                t = w[j]; w[j] = w[j + 1]; w[j + 1] = t;
                t = u[j]; u[j] = u[j + 1]; u[j + 1] = t;
                t = v[j]; v[j] = v[j + 1]; v[j + 1] = t;
            }

    for (int i = 0; i < n; i++)
        parent[i] = i;                                // each vertex is its own set

    int total = 0, count = 0;
    cout << "\nKruskal's MST edges:\n";
    for (int i = 0; i < e && count < n - 1; i++) {
        int pu = findParent(u[i]);
        int pv = findParent(v[i]);
        if (pu != pv) {                               // different sets => no cycle
            cout << u[i] << " - " << v[i] << " : " << w[i] << endl;
            total += w[i];
            parent[pu] = pv;                          // join the two sets
            count++;
        }
    }
    cout << "Total weight = " << total << endl;
}

int main() {
    cout << "Enter number of vertices: ";
    cin >> n;

    cout << "Enter adjacency matrix (0 if no edge):\n";
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            cin >> graph[i][j];

    int choice;
    do {
        cout << "\n1. Prim's Algorithm\n2. Kruskal's Algorithm\n3. Exit\nEnter choice: ";
        cin >> choice;
        if (choice == 1) prim();
        else if (choice == 2) kruskal();
    } while (choice != 3);

    return 0;
}
