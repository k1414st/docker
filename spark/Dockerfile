FROM continuumio/miniconda3:latest

RUN useradd -m spark

RUN apt-get update && \
    apt-get install -y --no-install-recommends sudo vim

RUN apt-get update && \
    apt-get install -y --no-install-recommends openjdk-8-jdk maven

ENV SPARK_VERSION=2.4.3
ENV HADOOP_VERSION=2.6
ENV HADOOP_VERSION_DETAIL=2.6.5

# install spark
RUN wget http://ftp.riken.jp/net/apache/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    tar zxvf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /usr/local/ && \
    ln -s /usr/local/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /usr/local/spark && \
    rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

# # install hadoop
# RUN wget http://ftp.riken.jp/net/apache/hadoop/common/hadoop-${HADOOP_VERSION_DETAIL}/hadoop-${HADOOP_VERSION_DETAIL}.tar.gz && \
#     tar zxvf hadoop-${HADOOP_VERSION_DETAIL}.tar.gz && \
#     chown -R spark:spark hadoop-${HADOOP_VERSION_DETAIL} && \
#     mv hadoop-${HADOOP_VERSION_DETAIL} /usr/local/ && \
#     ln -s /usr/local/hadoop-${HADOOP_VERSION_DETAIL} /usr/local/hadoop && \
#     rm hadoop-${HADOOP_VERSION_DETAIL}.tar.gz

# download test datafile
WORKDIR /home/spark/
RUN apt-get install -y --no-install-recommends unzip && \
    wget https://archive.ics.uci.edu/ml/machine-learning-databases/00210/donation.zip && \
    unzip donation.zip && \
    unzip 'block_*.zip'

# setting env
RUN echo 'export JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")' >> /home/spark/.bashrc
#     echo 'export HADOOP_HOME=/usr/local/hadoop' >> /home/spark/.bashrc && \
#     echo 'export HADOOP_OPTS="$HADOOP_OPTS -Djava.library.path=$HADOOP_HOME/lib/native"' >> /home/spark/.bashrc && \
#     echo 'export HADOOP_COMMON_LIB_NATIVE_DIR="/usr/local/hadoop/lib/native/"' && \
RUN echo 'export SPARK_HOME=/usr/local/spark' >> /home/spark/.bashrc
#     echo 'export PATH=$JAVA_HOME/bin:$HADOOP_HOME/bin:$SPARK_HOME/bin:$PATH' >> /home/spark/.bashrc
RUN echo 'export PATH=$JAVA_HOME/bin:$SPARK_HOME/bin:$PATH' >> /home/spark/.bashrc
USER spark
