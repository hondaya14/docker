docker run --gpus all -itd --expose 22 -p 127.0.0.1:30000:22 -p 127.0.0.1:30001:8888 -p 127.0.0.1:30002:8889 -p 127.0.0.1:30003:6006 --hostname hondaya-gamess --name hondaya-gamess -v /net/fs09/work01/hondaya:/net/fs09/work01/hondaya -v /net/fs10/work01/hondaya:/net/fs10/work01/hondaya -v /net/fs09/homes/people:/net/fs09/homes/people hondaya/gamess:1.0