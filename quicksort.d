import std.random;
import std.stdio;
import std.algorithm;
import std.conv;
import std.parallelism;

int partition(ref int[] arr) {
    /**
     * EFFECTS: Picks a random pivot and puts all values <= the
     * pivot before the pivot, and all values >= the pivot after
     * the pivot.
     *
     * PARAM arr: Is either an array or a partition of an array.
     * RETURNS: Index of the pivot.
     *
     * NOTE: In order to partition a subarray, just call
     *          partition(arr[x..y]); where x and y are the
     *          lower and upper bound.
     */
    int pivotIndex = to!int(uniform(0, arr.length));
    int pivotValue = arr[pivotIndex];
    swap(arr[pivotIndex], arr[arr.length-1]);
    int storeIndex = 0;
    for(int i = 0; i < arr.length-1; i++) {
        if(arr[i] <= pivotValue) {
            swap(arr[i], arr[storeIndex]);
            storeIndex++;
        }
    }

    swap(arr[storeIndex], arr[arr.length-1]);
    return storeIndex;
}



unittest {
    void populate(ref int[] arr) {
        for(int i = 0; i < arr.length; i++) {
            arr[i] = to!int(uniform(0, arr.length));
        }
    }

    bool check(ref int[] arr) {
        int pivotIndex = partition(arr);
        for(int i = 0; i < pivotIndex; i++) {
            if(arr[i] > arr[pivotIndex]) {
                return false;
            }
        }

        for(int i = pivotIndex; i < arr.length; i++) {
            if(arr[i] < arr[pivotIndex]) {
                return false;
            }
        }
        return true;
    }
    int a[] = new int[10];
    int b[] = new int[100];
    int c[] = new int[1000];
    populate(a);
    populate(b);
    populate(c);
    assert(check(a));
    assert(check(b));
    assert(check(c));
}

void quicksort(int[] arr) {
    /**
     * EFFECTS: Sorts an array using the quicksort algorithm.
     */
    if(arr.length > 1) {
        int index = partition(arr);
        quicksort(arr[0..index]);
        quicksort(arr[index..$]);
    }
}

unittest {
    void populate(ref int[] arr) {
        for(int i = 0; i < arr.length; i++) {
            arr[i] = to!int(uniform(0, arr.length));
        }
    }

    bool check(ref int[] arr) {
        quicksort(arr);
        for(int i = 0; i < arr.length-1; i++) {
            if(arr[i] > arr[i+1]) {
                return false;
            }
        }
        return true;
    }

    int a[] = new int[10];
    int b[] = new int[100];
    int c[] = new int[1000];
    populate(a);
    populate(b);
    populate(c);
    assert(check(a));
    assert(check(b));
    assert(check(c));
}
