Data Engineering assignment by [Manul Thanura](https://manulthanura.com/)

Code repository: [GitHub](https://github.com/manulthanura/Assignment/tree/main/Data%20Engineering/WordCount)


Check the Hadoop version: `hadoop version`
Check the Java version: `javac -version`

Configure Hadoop (3.4.1) on Ubuntu 24.04 using vscode.
1. Edit the .bashrc shell configuration file: `code .bashrc`
2. Edit core-site.xml File: `code $HADOOP_HOME/etc/hadoop/core-site.xml`
3. Edit hdfs-site.xml File: `code $HADOOP_HOME/etc/hadoop/hdfs-site.xml`
4. Edit mapred-site.xml File: `code $HADOOP_HOME/etc/hadoop/mapred-site.xml`
5. Edit yarn-site.xml File: `code $HADOOP_HOME/etc/hadoop/yarn-site.xml`

Run Hadoop `start-all.sh` and `jps` to check if all the services are running.
Stop Hadoop `stop-all.sh` and `jps` to check if all the services are stopped.

Create a directory in HDFS and put the input file:
```bash
hadoop fs -mkdir /WordCount
hadoop fs -mkdir /WordCount/Input
hadoop fs -put '/home/hadoop/WordCount/input.txt' /WordCount/Input/
```

Create `.jar` file and class files:

```bash

export HADOOP_CLASSPATH=$(hadoop classpath)
echo $HADOOP_CLASSPATH

cd /home/hadoop/WordCount

javac -classpath ${HADOOP_CLASSPATH} -d '/home/hadoop/WordCount/class' '/home/hadoop/WordCount/WordCount.java'
jar -cvf wc.jar -C class/ .
```

Run the Hadoop job: `hadoop jar '/home/hadoop/WordCount/wc.jar' WordCount /WordCount/Input /WordCount/Output`

Common localhost links:
- NameNode: http://localhost:9870
- DataNode: http://localhost:9864
- ResourceManager: http://localhost:8088
