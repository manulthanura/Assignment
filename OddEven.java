// Implement parallel odd-even sort in Java

// the file contains few classes. Some of them are just there to help
// for example, generate random data, check if they are sorted, print etc.
import java.util.Random;
import java.util.concurrent.CyclicBarrier; 

class Data {

    public static int range = 100; // generate numbers less than this 

    /**
     * @param size
     * @return
     */
    public static int [] generateData(int size) {

      int [] data = new int[size];
      Random rand = new Random();
      
      for(int i=0; i<size; i++)
          data[i] = rand.nextInt(range);

      return data;
    }

    public static boolean isSorted(int [] data) {
      for(int i=0; i < data.length - 1; i++)
          if(data[i] > data[i+1]) return false;

      return true;
    }

    public static void showData(int [] data) {
      for(int i=0; i < data.length; i++)
          System.out.printf("%c%d",
                i == 0 ? '[' : ',', data[i]);

      System.out.println("]");
    }

    public static void swap(int [] data, int i, int j) {
      int tmp = data[i];
      data[i] = data[j];
      data[j] = tmp;
    }
}

/**********************************************************************
 * Your implementation should start here. 
 * You can modify the oddEvenParalle function and run function. 
 * Other parameters should not be modified.  
 */


public class OddEven extends Thread {

    // Some fixed values
    // Do not change
    public static int elementsPerThread = 1000;
    public static int arraySize         = 3500;

    /* You will need to put your code here 
     * You will need static/none-static variables 
     * few functions, a constructor etc. 
     */
    public static CyclicBarrier brr = null;
    public int start, end;
    public static int[] data;

    public OddEven(int[] arr,int s,int e) {
      start = s;
      end = e;
      data = arr;
      
      
    }

    public void run() {
      // Implemet me :) 

      oddEvenParallel(data);

    }

    
    public void oddEvenParallel(int [] data) {

	  // you need to implement this code
	  // watch the discussion and sample code in LMS on threads
	  // and barriers before starting
	  // Note the number of threads and array size.
	  // you cannot change the array size or the number of elements per
    // thread
      
      boolean swapped = false;

      while (!swapped) {
        swapped = true;

        for (int i = this.start; i < this.end; i += 2) {
          if (data[i] > data[i + 1]) {
            Data.swap(data, i, i + 1);
            swapped = false;
          }
        }
        
        try{
          brr.await();
        }catch(Exception ignored){}
        
        
        for (int i = this.start + 1; i < this.end; i += 2) {
          if (data[i] > data[i + 1]) {
            Data.swap(data, i, i + 1);
            swapped = false;
          }
        }
        try{
          brr.await();
        }catch(Exception ignored){}
      
      }
        
    }
    

    // Given below is the serial implementation of odd-even sort
    // Your task is to parallel it.
    // Watch the recording of the discussion class and look at the
    // sample code on LMS on threads and barriers
    public static void oddEvenSerial(int [] data) {

      boolean isSorted = false;
      while(!isSorted) {
          // assume the array is sorted now. Compare each element
          // with the adjecent element. If they are out of order swap.
          // If you did a swap them it is not sorted.

          isSorted = true;

          for(int i=0; i < data.length-1; i++)
            if(data[i] > data[i+1]) {
                Data.swap(data, i, i+1);
                isSorted = false;
            }
      }
    }    
    
    public static void main(String [] args) {
      
      int[] data = Data.generateData(arraySize);
      
      OddEven thread01 = new OddEven(data,0, 1000);     // thread 1 
      OddEven thread02 = new OddEven(data,1000, 2000);  // thread 2
      OddEven thread03 = new OddEven(data,2000, 3000);  // thread 3
      OddEven thread04 = new OddEven(data,3000, 3499);  // thread 4
      
      thread01.start();
      thread02.start();
      thread03.start();
      thread04.start();
      // oddEvenSerial(data);

      try{
        thread01.join();
        thread02.join();
        thread03.join();
        thread04.join();
      }catch(Exception ignored){}

      if (Data.isSorted(data)) {
        System.out.println("Looks Good!");
      } 
      else {
          System.out.println("Something bad");
          Data.showData(data);
      }
    }
}

    
