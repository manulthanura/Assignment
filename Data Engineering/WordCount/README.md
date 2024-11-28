Run Hadoop
start-all.sh
jps

Stop: stop-all.sh

export HADOOP_CLASSPATH=$(hadoop classpath)
echo $HADOOP_CLASSPATH

hadoop fs -mkdir /WordCount
hadoop fs -mkdir /WordCount/Input
hadoop fs -put '/home/hadoop/WordCount/input.txt' /WordCount/Input/

cd /home/hadoop/WordCount

Create .jar file:
javac -classpath ${HADOOP_CLASSPATH} -d '/home/hadoop/WordCount/class' '/home/hadoop/WordCount/WordCount.java'
jar -cvf wc.jar -C class/ .

Run the Hadoop job: hadoop jar '/home/hadoop/WordCount/wc.jar' WordCount /WordCount/Input /WordCount/Output
