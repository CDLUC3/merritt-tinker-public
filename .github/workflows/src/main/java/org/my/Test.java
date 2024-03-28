package org.my;

import java.io.IOException;

import org.apache.zookeeper.ZooKeeper;

public class Test {
  public static void main(String[] argv) throws IOException {
    new Test().hello();
  }

  publc Test() {
  }

  public void hello() {
    System.out.println("hello");
  }
}
