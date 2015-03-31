#include <iostream>
#include <cstdlib>

__global__ void add(int a, int b, int *c) {
	*c = a + b;
}

int main () {
	int c;
	int *dev_c;

	cudaError_t err;
	err = cudaMalloc( (void**)&dev_c, sizeof(int));
	if (err != cudaSuccess) {
        printf( "%s in %s at line %d\n", cudaGetErrorString( err ),
                __FILE__, __LINE__ );
        exit( EXIT_FAILURE );
    }

    add<<<1,1>>>(2,7, dev_c);

    err = cudaMemcpy(&c, dev_c, sizeof(int), cudaMemcpyDeviceToHost);

    printf("2 + 7 = %d\n", c);
    cudaFree(dev_c);

    return 0;
}